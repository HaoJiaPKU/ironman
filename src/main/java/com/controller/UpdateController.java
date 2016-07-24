package com.controller;

import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.transport.TransportAddress;
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
public class UpdateController {

    @RequestMapping(value = {"/update"}, method = RequestMethod.GET)
    @ResponseBody
    public Object update(@RequestParam(value = "question", required = false, defaultValue = "false") String question) {
    	//question decoding
        try {
            question = URLDecoder.decode(question, "UTF-8");
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

        //disconnect es
        client.close();
        
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }
}
