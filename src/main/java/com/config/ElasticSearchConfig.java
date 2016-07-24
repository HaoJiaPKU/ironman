package com.config;

import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.transport.TransportAddress;

/**
 * Created by lanzheng on 15/10/18.
 */

//@Configuration
public class ElasticSearchConfig {

    //@Bean(destroyMethod = "close")
    @SuppressWarnings("resource")
	public static TransportClient client() {
        TransportAddress transportAddress = new InetSocketTransportAddress("localhost", 9300);
        Settings settings = ImmutableSettings.settingsBuilder()
                .put("client.transport.sniff", true)
                .put("cluster.name", "my_elasticsearch")
                .build();
        return new TransportClient(settings).addTransportAddresses(transportAddress);
    }
}
