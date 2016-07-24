package com.controller;

import org.elasticsearch.action.delete.DeleteResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.transport.TransportAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by lanzheng on 15/10/18.
 */

@Controller
public class DeleteController {

    @RequestMapping(value = "{index}/{type}/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(
    		@PathVariable String index,
    		@PathVariable String type,
    		@PathVariable String id) {
    	
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

        @SuppressWarnings("unused")
		DeleteResponse response = client.prepareDelete(index, type, id)
        		.execute()
        		.actionGet();

        //disconnect es
        client.close();
        
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }
}
