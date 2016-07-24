package com.controller;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHits;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by lanzheng on 15/10/18.
 */

@Controller
public class QueryController {

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    @ResponseBody
    public Object query(
    		@RequestParam(value = "question", required = true, defaultValue = "") String question,
    		@RequestParam(value = "type", required = true, defaultValue = "") String type) {
    	
    	//decoding
        try {
            question = URLDecoder.decode(question, "UTF-8");
            type = URLDecoder.decode(type, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println(question);
        System.out.println(type);

        //connect es
        TransportAddress transportAddress = new InetSocketTransportAddress("localhost", 9300);
        Settings settings = ImmutableSettings.settingsBuilder()
                .put("client.transport.sniff", true)
                .put("cluster.name", "my_elasticsearch")
                .build();
        @SuppressWarnings("resource")
        Client client = new TransportClient(settings)
                .addTransportAddresses(transportAddress);

        //excute query
        SearchResponse response = client.prepareSearch("ironman")
                .setTypes(type)
                .setQuery(QueryBuilders.matchQuery("_all", question))
                .execute()
                .actionGet();
        SearchHits hits = response.getHits();
        
        //System.out.println(response);
        //System.out.println(hits.getTotalHits());
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("totalHits", hits.getHits().length);
        for (int i = 0; i < hits.getHits().length; i ++) {
        	//System.out.println(hits.getHits()[i].getScore());
        	double score = (double)hits.getHits()[i].getScore();
        	score = Math.sqrt(score);
        	score = Math.sqrt(score);
        	score = Math.sqrt(score);
        	map.put("score" + String.valueOf(i), score);
        	map.put("source" + String.valueOf(i), hits.getHits()[i].getSourceAsString());
        }

        //disconnect es
        client.close();

        //return the result to frontstage
        return map;
    }
}
