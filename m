Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80719125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bls1LeYQ9Sxlmm4WQmZCQpE+aW5TIbA/EEFUSi0F544AR2Ty8RYweQ5Vi6jsXwPcfTjLFlHithqz0LCs8ZJMAOmEoqN4IzRmrSxGr5vLg3qEi30zgceGA/lKG4qB2F+IJ4YbSlOgwVL9rP1uXDJ90oKMaOvp7hkBb68gSeSKQCfUl9tZ6tSrRlIzuPBaXYBpFIiN1XrzxbUngXO4bCO9LqZiJ5g37svbeSAQWQDAEe0stizkvJGtTn1wLxDqB+nDNIXfIzBpi00l4Q+6uUuguD0SWIHm36+EDE+N6b+iqvodx9a99uELrgygL2Vj80L8tAKVTCN4gil1FTqRjpL6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX1IbyvnaoToSna0tKxEnh4OZ96zVEp0E0+0OajmvqA=;
 b=EausGWhFmUTRgYKWN3I/N1uKUsS7KoDjIZBC+dShT92GUSwiMLoKXHL3+WRv/lAs/JHNoYaLRvZ3kQsrAumkIoIXOoXxOcHlzwISnIrhUJ8v11l4aXcT0gS4CHgOIgkfUxEWPye9mM+a+DTIK3R/Nu2FjpXyVC0fCcw00oz962+uLAhE/sfXhCBXDuWcEWk9ZXeolIRgAAEM1oyGWHauG34gyA+ox7o0YogekXOqrvcWmtIT3jBUFw6ZcamF0kZSNOgLT/e/F10x6TvujmWX8HEpevJ5WCmuxLtoDgaebcOIWWWjqK9ZGJ0AxLNAiQv2J+DpBB4WbAYIOpDR3qLUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX1IbyvnaoToSna0tKxEnh4OZ96zVEp0E0+0OajmvqA=;
 b=f0b66kJQtPreVRbr5FQMJW7qdpN4E8gS/2N6merLQCo+t5i5IBbSh2kbxSJd4abt8wmYvar5bMcU9VeKHyXzqeCTIq15lTCdeirtoLVOROKN+0TSiRL56MONA/eLdkJSNjNQlWeHY5shOy4j6btj+9q+p+MENAtU9cdQr+YciL9NcuYS7mQs91jOaQYlmRqY0CLK4LUgR6dko+rEMfNwU/y6HaxAfZotCamevtcQK3rm1Hvdhw6+RCS5qX3qmFgtek7dBJsku+zWA+uIQEPQABg4SQFE5LvLht1Ym7M/21FMthITKEnCdo8tAw7Db7hWyMyqQKljo1yJRyMi3gapKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:41:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:41:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 03/29] mptcp: use mptcp_get_ext helper
Date: Mon, 25 Sep 2023 16:41:42 +0800
Message-Id: <034b311eb7207115cb79781735d9d5f548157a19.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bea442b-2d8f-4d12-49da-08dbbda33d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7d4GZZqepJYfXfeDJNDQmGFtltCNCZUh8VhJhpDF3kDeZdlAXEXQhPc7xBRRIFOaLZ0awImpjNpBJX4rb7RIbmH0qIssAaYPJQOzHW3jCHkD1bQLBArEoaJ2rpqZR07cv8dag2BF3TMot2r/xGMs9A3XlyotksCypyPxgYHZw09H8JtusQdzzHiZ/S3UniNLjq61iWQf4V0XMwJt6UHgMydURCZwPikLzu5eOJFd4lE7HGHj+qEduA+RteGZt7PHnGx+CAb4jgBQrzQaZAIXTB5I+pJmeHAbTjrQXcTqmikld9aixFbX7Y57VEwnNjX+gZ2QxHvPM6ezA0hz9+c9V2sGJ7+L5Ny5W/sN4AnKwHm7Afe6q5T0lOz0T1B1LLi8kue6T/agjvLuSqFttjri0OsLJWzxvSEevDpJ96KG9DPxH0Gqe8Z7qinDN+l3KGmll96kyml7e2mATzMVWDxcNtJRK8Z3MVQfITucyonAbRXCoIsWPJlAPk2raQwZwfoj9yW2NwrmA59bIbAmr5FpjTFB39lkSoXljwTbmfaB7g/dpELpMOCeYj7vPPylZ3CZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(4744005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8CMfmnrZ8szKUOt5cMMEsG6xpyOBDFqb0iA5Jqcmz4pRuR4v6n/Z5M0Gr9V?=
 =?us-ascii?Q?isoYGcn/iYSPulxa0ADIC5t1GlyLe4+1+Zh+zi2ZFtn8vBmVSKQ8UC17TeUE?=
 =?us-ascii?Q?gxDh9xRPfAglJchLRihauEEndoutgDLJZEwxlNnjVd3IQIqICBJGFyxh4F2M?=
 =?us-ascii?Q?hs+ET65WFc/T1sxCbfg3KoKMFBEBJIKsh6NuWN8iaVIbkyTgvYC5qd1eBMvw?=
 =?us-ascii?Q?Q//bM3pP4R+nTnxaATGExrjcuCSpG4k1LhBWnVnGNN1OhLYQAaq8JiNL9DO0?=
 =?us-ascii?Q?kOobi2iZvMolQ1afmKfspFFNFbE9iheVc4EYBVNsBPtci17MnBaoVJO86Cin?=
 =?us-ascii?Q?aHfX4nGAfaiEHEIEf7fXcjmY3sVvGDHNkphFlVcbjlF5bIRD9t6+Qz/rszh+?=
 =?us-ascii?Q?hBxTwujSQAneh/YsrAc0a51qgh3Ohq6rDiaUmsMiUZUtOM4rpKBZ0wxmNCEo?=
 =?us-ascii?Q?bWFYldA39LkO0o5DdW7/BCE68KXOmLKof79drWm5jyt5nNFSnnlosBWmbZYH?=
 =?us-ascii?Q?BJo0cmumwWiwETuN7jNM7wLMX3h0lfGYZHtopyvCjwppINmgOzTeOYofMUGz?=
 =?us-ascii?Q?T3okDCil/JpWq6iPM33WfdPLO4RvMSRVO05bH00cYQxeqJU7iyGPgvoodoRy?=
 =?us-ascii?Q?aJJujBWhvyQyOMFmtyu1+gwzdkDebhUyW6h+TaJjzIz/zZUPfvFWVolvJTYz?=
 =?us-ascii?Q?leVRqv0CKWLDZ5EDn93fvYMysFWuTQTtvCMu2arFu65BX7VQ7Rwf7ohUG7Ii?=
 =?us-ascii?Q?JSN5piuz3ZWehr2pIxrdoxwSANalVo1WwnpLthc+u3wOObRSdRhbnO7tq/nW?=
 =?us-ascii?Q?BMzMLP3HPgABZMty6iZezbFhEX8pdvq+TDxT1dENWHQECqiz6uH2BWCfdz+X?=
 =?us-ascii?Q?kAIpxBwOkiOdT50yAL9Pn/n9ud/p0XY73NGQhk0Xa8F8dwn19OKZLAe/iiZX?=
 =?us-ascii?Q?4lhECJC90p8mgwdF1nsLY+JcCt1ROxF4bIDaYE5arJdI+9D1LLAuUGX87bXu?=
 =?us-ascii?Q?UkTG6kyt4vJLtileQm4In86WON3M/1e36ltPw54Vivm0/+KZ5bpXqyDmetNA?=
 =?us-ascii?Q?RALGxgqPBkuQyLuHnT9u2R6k8f0++E/9PIk01NMwi38Mky1uPUJKYcF331+2?=
 =?us-ascii?Q?Y8iybl8CviW7YYhp/X4TkxomLksHbXGmdJYNvw+tKeh0WcrFhHl0wSHXZOPu?=
 =?us-ascii?Q?PgTlQCZ/e78Ea6Uhhjtb8irnG9VNpUWnUNnp8BIx+PLtEqDAHUIACk/GsKjJ?=
 =?us-ascii?Q?e+4nJr1rYBVPkMNn7hsnxEO0DqRuSTcGocbkO86UXuTdTCw+EFdF5nEXIE8a?=
 =?us-ascii?Q?VZLiW7Tdxn3QgdAknN3Avjq+IyVlFA3S8bbSdBWRJRJGXQHETjcjC9nBv7T2?=
 =?us-ascii?Q?TTqEdCjYzgoRhptEmM9J9tDkPMU+vqFfZpFbtwbZp/5df5PeUNdgTn78FuKo?=
 =?us-ascii?Q?Az1G1965Iz8gHScb1+u37hG3+ZVAxbw/wNuOgup6EFkk2kKkvDmlJCtWL5iK?=
 =?us-ascii?Q?rQwvVsU0RkhThVLM/4PG8D5ATcga3139QmNZMVKMdKaO13Okp6w8GJi2ZQm4?=
 =?us-ascii?Q?w56aeXe+GW5DVyBvEA1JSWFXb2mlJSrW205+t5OU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea442b-2d8f-4d12-49da-08dbbda33d4e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:41:41.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea1FShu05zh6qXiqLDfizxDiCw7UvPHCW2E3enF9zg6WHSsv/uqyh5mYSGZQj8EFoM+Ww49D1NYlMV7jo8/gQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

Use mptcp_get_ext() helper defined in protocol.h instead of open-coding
it in mptcp_sendmsg_frag().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6dd1ceaee257..f11834d924ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1267,7 +1267,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 * queue management operation, to avoid breaking the ext <->
 		 * SSN association set here
 		 */
-		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
+		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
 			goto alloc_skb;
@@ -1289,7 +1289,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 		i = skb_shinfo(skb)->nr_frags;
 		reuse_skb = false;
-		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
+		mpext = mptcp_get_ext(skb);
 	}
 
 	/* Zero window and all data acked? Probe. */
-- 
2.35.3

