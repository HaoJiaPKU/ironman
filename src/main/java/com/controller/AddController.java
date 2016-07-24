package com.controller;

import org.elasticsearch.ElasticsearchException;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.transport.TransportAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by lanzheng on 15/10/18.
 */

@Controller
public class AddController {

    @RequestMapping(value = "{index}/{type}/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Object add(
    		@PathVariable String index,
    		@PathVariable String type,
    		@PathVariable String id,
    		@RequestBody HashMap <String, Object> map) {
        
    	//decoding
        try {
        	index = URLDecoder.decode(index, "UTF-8");
            type = URLDecoder.decode(type, "UTF-8");
            id = URLDecoder.decode(id, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        //connect es
        TransportAddress transportAddress = new InetSocketTransportAddress("localhost", 9300);
        Settings settings = ImmutableSettings.settingsBuilder()
                .put("client.transport.sniff", true)
                .put("cluster.name", "my_elasticsearch")
                .build();
        @SuppressWarnings("resource")
        Client client = new TransportClient(settings)
                .addTransportAddresses(transportAddress);
        
        Gson gson = new Gson();
        String jsonStr = gson.toJson(map);
        System.out.println(jsonStr);
        
        try {
//        	XContentBuilder builder = XContentFactory.jsonBuilder();
//        	for(String str : map.keySet()) {
//        		builder.startObject().field(str, map.get(str)).endObject();
//        	}
        		    
			@SuppressWarnings("unused")
			IndexResponse response = client.prepareIndex(index, type, id)
					.setSource(jsonStr)
					//.setSource(builder)
					//.setSource(XContentFactory.jsonBuilder().startObject().field(new String("property"), map).endObject().string())
					//.setSource(map)
					.execute()
					.actionGet();
		} catch (ElasticsearchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        //disconnect es
        client.close();
        
        Map<String, Object> m = new HashMap<String, Object>();
        return m;
    }
}
