Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449E362
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 05:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3NAOpCkRuxHys3NxnPIi/bWrddsbiUfEl4A7rKcA3KCN+ZeBNxCk2XoxOhp/HveIQlOGwFK/9YMLKTAa3PNsao4pHRaSzjf/zPH6dUnlqtfTZw47rnnfHf6Pj5QF4sYS6S+CyYaiRSlQCM3kKSWzevvkedJOZ5eQSu5PjUyqv5sUPDWjf4WLJlUQoiVPffG3KFg+g/tGOIOIs3zyoxuYJ2C8eLVMHD6wsHC3z4KB5Ufb0X34DywGgWKd6aD//59vHYDp0WMwAoV3wu77KcSQ7xolSyUq3dBEZrcryxnTWOIu/d6O8EK+k7lUHfhjDj6SnbMNvXM864EMM6occRsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sysHpjntALLxxGhBj+b7Q1/rqPksNd4AJ2LjdMVwrEs=;
 b=Jp7WX/3KFbzh2ydTi33ImFHrvYhSScnw0X/fo14W4bsaaYhmKQzK5X7Be40ip7IUttzGkTuFVQvDZoP2Ooqy+0THpFh+vWCggDQ0yRUKbZcxcl5dyK/GNtVHUwi3ntUmVlKSjJjWkim34artSMQepuJVnynVkZ6Fva2b2rsCc6t/HOH9Wn+w8ylztMeyqfEydAG5/w2+wckCKgzYmp6g4vk30O2pq1iGgB3AaHWyZrtcMorkTUQb4CunVgZ80fKSyIHnvuDueahVn73kmZGxWx9JM+rx4G6Sc55l/fsupV4qiaDMWLxfNCRBO/koROakFcx+2eG4ho+ib5KMos6FNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sysHpjntALLxxGhBj+b7Q1/rqPksNd4AJ2LjdMVwrEs=;
 b=0FnQw5o1v4tsxAsEw2mp51ZjA4r1uopoBcGVOvsIkj/ZdGPQW0Ws3UBHdns4JJjJq9kTjKqPjNKPB3oP5zKkihVx4ZX+UvxegICY9fX9wRwVQ1eFFNqabKsmEhfCWsgNlKTD8FsFczbmXALAkCr+jP5YSDoMffBSjpdB/dltLoRSr8o1nuBUDuBFmX69FSzNDnLooxfnr1ZjnV11g9YVLu8V4zUV3zHi7E4PuCH9QTFTuGqekUsDylqi/q2WUOqYuT9tfkMIzXUkKJCKTPXbfKAWMKa0bdLruxWv9iMp8n8iE0Iy0nQNHESajYHFvLV+JHLilGHQPvV3E4uRbGxslA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 05:45:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 05:45:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: update pm_nl_ctl usage header
Date: Fri, 10 Jun 2022 13:45:10 +0800
Message-Id: <4894e178ac9a9ee233246a73e5c968858b7a3a87.1654839889.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd15ee12-942e-4396-6275-08da4aa4674b
X-MS-TrafficTypeDiagnostic: PA4PR04MB7952:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7952B940270DF851AB75B14CF8A69@PA4PR04MB7952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SM9WGBzFhwBU7rZLEnuGHlrw+nuxbd6oUn6guea9Lm0mVLVEaji77XawPwc6VKtOM2prvtsOTTDllCGrQ3VLXS86K8i2RzTZFCgvf/NDDS2aW7dzCcBrGCplLqsGXlPA1+MANfFcJe+dD7QQgbyVJSUl9WTzhBw4046N3kZQZZ16xUa9T3X1YOp3T/Xf1VycaBpVYaPH1NVtVM/O6ACBqbiV2V5+3UtH6RPp6AIWIaPJDkmczXnVpPryhPJLlO8XxMIEDzb/SabH/C/nUNekTD2wwwYlDFXG9BbY9kn/Nqp+JnK4EIE7rewrXvUmOdX7UIUAtX4MgtldcD411kvH5p3UPkicpx8mJr0AYVb0rjhic33xuEuvtWyk5nBbUJA3mzFAfRjq9W0q0nM7qonGaEfphQaXE9jXTZKnrd6KudnDv1nLpFOU+SaAmH5bcWs2LKf4YMHs9VUaXYWQSKRzBtr+A6u9hVxPW2OeEQ56vIpGB3bLS3TtUrHDNof0E6Mwz9dWW/qmjoBSfp1hLewAOSGUEqs3GFElew5H+sBeUanRL7RBcZjMBsDhzcThiQB5DW6l89YdreN9KU7uzfhgcixqtrGHe6bd0BI+Tnhh8bJKt8oWF0q9Sl+xGCV9JYdIk011UdPeEhoSqR0b3WE3TjN4E681vv9vjHlahiwP2+1igl6wP3fRWPvWect/p/5c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(186003)(2616005)(107886003)(508600001)(8936002)(38100700002)(8676002)(66556008)(66476007)(6486002)(66946007)(4326008)(5660300002)(2906002)(316002)(83380400001)(6666004)(26005)(6512007)(6506007)(86362001)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qLHrLit8WEv0KXXt5Xu4ee80YmSO/KzuUEsdZjeiKnXMr68ucXY/qKFA0azu?=
 =?us-ascii?Q?/Wml7W7Ns24zwB8KMmB9PcsNwXE6hApCuw7rBKKOVWUy0UZ/g4T/MoeyzC99?=
 =?us-ascii?Q?cjxHNAjIII2A+Y/RZ51dk+RGwnF4/Iolq7j8CHqygH6DjOUdQbbre8RPKhxM?=
 =?us-ascii?Q?qLNd9w6LFSp72lv1tOoX9Ex778TaX0TNDnH2B5vHkc6bbiNbyR5mC3Vv/icx?=
 =?us-ascii?Q?k5d/nVdrK3r/bojkm/fhNYxLHhBzFXTmsRp9FE+yrIA2qjoUNnHH4GBxq5RT?=
 =?us-ascii?Q?InWPANwY6SP/4iAGvrOV9ahGJhl/vxOeIpRWH0FF5AalRaiNWMXVSsHOrsZH?=
 =?us-ascii?Q?mPqGOUQARlb0kRhnDt+TDfilppOP8r3ASZzCx+i7sVz/KLvcMqvkIj5ncMlv?=
 =?us-ascii?Q?03p1/bJiLJVolnQJ/beuoEv68KmGkUbqJtoRxsEUp/LZTzCMAIRZh7QxhHj5?=
 =?us-ascii?Q?QY/X1egk0Zi9Os0CMXaMN7DoQ5AUnbLgW97DGzxn7h4kY7xeJjZmUg1Qyx4x?=
 =?us-ascii?Q?dCiiC7dLAJP6+MviR7mEFWdYeuixefHXT+3CdbKuH5I1cgOR5RssUlOTdNGk?=
 =?us-ascii?Q?vamolFMEuyck8QHFhzQ5H33nsKyhrHlfQsom/eH0vEL4riQY2w3RVbRY1A9u?=
 =?us-ascii?Q?5xljDtolLz0klmaZUNRy5rUqTCTXv/XOwiZAl+BqU/EZe1XbS+sxYUirqQbS?=
 =?us-ascii?Q?vtHp6fie90AgemHoWfdQMvkzoW0SgFovBerufeZ7HSPnZ80bhdy6WBk0Cbcn?=
 =?us-ascii?Q?zLHTIWCIci93OhFX19XYKOlrCULEKJO2SFpjUsUcTrO4h2IafSpPptSTbF/Y?=
 =?us-ascii?Q?g8Be0ll9U1Vi6pz99kBIAVVF/Cyb4kbWhb5MqHEBhriKTvlC6JqLeUEXV16k?=
 =?us-ascii?Q?paOthQx1OUDUkBcyqrlh0Y0C/fY6xk6mY20TeCttynjrC16Ox8UAgUv9RTGX?=
 =?us-ascii?Q?M/B+SHGXJbEZGFq0wrRbx54FM/RNNtCf7qlkr9y/X3w2CvWb3l9Z1qF+LS7M?=
 =?us-ascii?Q?Nzew4eOlBGvsHBXtZeF2gK7Cub+ITAh8EABZjxuJ2snOA0fvgJt5iF1hQwis?=
 =?us-ascii?Q?NGJxV6HUZPPE9SI6H9MyPc1HlGuiRPG2jVi2TXl2sym0moRHQUQtJ/OENW8y?=
 =?us-ascii?Q?ELWr4BPjKgc/vZVhle5+QaVK6TIBs+jkF2GNaFsIgfwhDK8Y72E3bLYbr7VJ?=
 =?us-ascii?Q?s6mBSCEHyQypdyeRVPGTA3YIJ332O+WZqGy5DEpcMVRQMJ4LCsRDYhoAoGre?=
 =?us-ascii?Q?Umod3h2xf5ivkA/NX+NzZp5BUmZ7PhygsVpIDgh3zyLPAfPSoVMilplyGhtN?=
 =?us-ascii?Q?wxmjvjnVndqNwXjL3mDmQH6gUdWFyIji0PBDuMApRcpQzcytdzAI5eVOtZ5V?=
 =?us-ascii?Q?uX4smf0KXMI61HXcATcfelkE7YkM3EFYYa9aYzQZvFgK30XddRrMA3g9yydo?=
 =?us-ascii?Q?HJcBHnvKBqayLLY1/3Y8kID9FKWkbEtX203YHzSCSnn86ATp7z2wxXN0NzzY?=
 =?us-ascii?Q?RQXNhF9sK5BJK2sSUy1M7C9EA6Giz3cwxskXZY1paIcAi2a6fFEhzEEOCe5q?=
 =?us-ascii?Q?t+TywuI49SiPMKBkS/T2VgdLe6r65yc8jQ1UeS7UzdMYHdeALUD3RBox8rAi?=
 =?us-ascii?Q?Mkj2hYAES7wKv6A/V+z/nf802e97tWvSdXUltDSTZb3AHiij/M+gk0jbON6u?=
 =?us-ascii?Q?MMHjyk4ybWy3OOFM2eLfmPuO71H2DX3oPj2hrqdfgtI9yfwC+5vjve5W6V7N?=
 =?us-ascii?Q?LNtanNih6Aog5Y/WcXhLqAORJ7NLW4k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd15ee12-942e-4396-6275-08da4aa4674b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 05:45:19.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2sZqoNa007UlYw7/Hkhg48nHJxCEcfJ40MuV0/Ld3AMiEIg13OVT6OU/1a8YlXPchnnngjb7CM1R8EiiNh3GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952

The usage header of pm_nl_ctl command doesn't match with the context. So
this patch adds the missing userspace PM keywords 'ann', 'rem', 'csf',
'dsf', 'events' and 'listen' in it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 6a2f4b981e1d..4dd87bb9ee91 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -31,7 +31,7 @@
 
 static void syntax(char *argv[])
 {
-	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
+	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
-- 
2.35.3

