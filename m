Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B517CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqPWJ0+4r0DCMyyCYqR8CXbjcjtWldPG7/w79/72ZjIyNS0KLtLV7WrXSaGotcXZc/8vaMK/BhIZ5xxjLf91DLvfo9132f7h4NlmIrbwtjcKMzOr2L1qHf3rdjaOSp++8nTKGBfi3fZKrqa0ajl3zVXw/zVu92ldyH8wW6Z+/V3fxIqiNw40d018obJTAtSXNCoCvtncX8SQ17BrlnNiWd1a4GNSSfoGpeI0+snR6n1X2vgXDXzruHIQLcgGtsZu7LmBp7rFL6su4D31aGUCo/Y7zLiyDj+1omf18VJ/Edh6SWPrEfLRx7PB3yIXO1UlYTfWDV1qiEgeqk1iOp5DHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVlyGCMX9kAyr+Bh12N3oRWw7xIyi5YXYjWpaGwOQEU=;
 b=DWFnyK4Ns2744cGuY5WtdLAkN1R1SQ6qDusDG4r3mdaFbpy0hTo7OGRHoss7rakEci2ioXINzAaCnqiRxaq3kXaYqTGJ81hUTqU+ce6NFASI1G0CYoJl1lRi7vNgIa07EfczNobzDbxx7W7VInnhe6/Ff4U+zy3EutuErYrPulVcHtd4OE9zLicguk//To4qNuspMG8vbF2OfB9YQp+97TsKz8rkiFQnd6WZGGmOBnKTKXRwJEZeCAm1N1Lc0JWAFADraq6egeH9Fw2zgBuZbw1rbKbvACHgNdOxOitk4D5FinBSNVdHl3sUf/I1HGQ2TRoSGWP+N29T2MUFPX3QzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVlyGCMX9kAyr+Bh12N3oRWw7xIyi5YXYjWpaGwOQEU=;
 b=CO1UNE4+sjiqRLkyL3BLxx5ce7RrwUwFDQMCkHu14J8G+3FT8p8g3ma/xrFKSDteKC1gWTWPKEy5zZ3g/8tVALaQf/iwGn0mb5iiWjLFDRz1e/1TXiaXCEAt0UwM1xkYTvELMogZckgT/A98eowsUB2LHEsdC1jcL70UhXTVuUGUToH2qYkPWhSFO057Z/AMF3YckdI+Dm4NNX/2ECshTSkk85VJg/0J/ceZ+x4AXUcnOG+k1CClYFvYVSvmyGABlwOpgbQlQLzFspXzsDF/GPCXE7oJaTfWTTGMB6GXsib9lyA337yhKg5M28ZZ3+0fHL3eG5LzZjYmzmkaELoDmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 11/16] mptcp: add mptcp_sched_data_set_contexts helper
Date: Wed, 12 Oct 2022 12:50:32 +0800
Message-Id: <8d50be20eeb939a3461d648fffaddf6856d37111.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db18404-c0e7-47c1-fe0b-08daac0d7cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ygI4qbrl/sNQ57EGd88vejq2GJ0WmF0HMDIrkhkQfOesC6fHKv0DYQ24i4c30WCYTX+VsSD0+rA+nwC4Y4x3Vqt90eRVYTYR80LEZ0MbFfGqR9hEHqWvhIZfqAU/0dmBv6TGvppiLvaU4Wmd16wVeNMyvGVoMiWiWfnbTYPiu3rmScDcHA7cp/qsVPmgCyjNs0en8pKIRaGsxVcvfgGMzyBcTOX3dI4Gf+GTohKiOrIq10JHeJchR+uMfDVe+kzYpZDasN0sqYIHwDi3Zdkf13AvobwC5ioGrsPycWJlWcdjynnL0jVvaOkR+IDyJvu0mFUy7YWuNFCzXQjGsxm7wVoorjJOSxxuGkRDbZgP22GxFz7dBbNMShMKUg/Gv8/SAji0CxOp1yEHTr/PnRDXC7SMcKA8wo1PGRP5trJIUi601lW/lq/x1Dh/Nng365wLd/PvcYUJ2eIV4oIZLweGkmY//34E+iuk/AnthJUSln6r2HIHIDuDapb4RzZUtnxzZIpBgG+w0atcBpX5cGwztahvRYkTOUjhNGV1zTPJ5oGz3VeaffZZ3iDOyjaf3pd39ORYvy+ffURaaVWnFdFLizUnxgidj5uZN8rpl/vRkvvAEq5x0BSBPF0Q7uYKxh+2wdGacKz671E0miJuk+o9mWW1jgGoAf3wg3Et3ayCGUElChCKHh9ekwnvs845To9CqwgulAH75v3JeZyTWvqcpC7HYwn9GMz0bk4fKDJJLGMk8mEAs7W0zeEm7VMooIWz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjxQr8MTr2vxy8Oju/KPNCz2PkML6EYpAuOVHNH9QfT7CaOZdbCGqAHAfTbZ?=
 =?us-ascii?Q?Kwz3Vx0KA2U9hwnX8QrEzLLnc5CDBbgLUiFDOub5Keb+H/dUsj41fVeA1GiF?=
 =?us-ascii?Q?29cSDC2yPb+1UlJpa1MIWZFZXNZqPZFj9n4smMKFo4uM3ubkLZFruoc5aSP7?=
 =?us-ascii?Q?6ZHscHO2bhzD+kEjpQam+Pd4LaVLRes42M5FXEu/kqUxWZCoDmt1/ABcDPdB?=
 =?us-ascii?Q?M5HwMkmpUaBM6cRnunfN5XgILGUP/B8mLZj8c8YGlyHc/Zmy5DGKz3cK+47R?=
 =?us-ascii?Q?Kjy2zEFq9FLVpEAOlfZAZrBGDHCWFQAr+9IBp/ELqi2hZGEnxDtDV63sGAcn?=
 =?us-ascii?Q?uRmemn1rUGovpZYHYNBRYEjARF9+4CfkcwYkvECDosMJmL13ygsxe4QFHefs?=
 =?us-ascii?Q?vUVQrM4LjmyR64cGGOOTpK3KDJLtpl5OXMu/HXTMJfu/LbzxKSQ4uxPHILdb?=
 =?us-ascii?Q?311wIKFnpwLSAyWmOtZRhK85R0Uzi3EHapm6tEHBjoE41g6G6XzARJaOjuq9?=
 =?us-ascii?Q?29n8Y5XwUPIpZUsIEJahWendIoWtmZBFtHdTS3OakXoKrn3mt6PuLmm0WRvE?=
 =?us-ascii?Q?s5NhZeS+/cq2wmix8j3VVePm610+Xyji6OziB8OqwNYxIHaUnsI/LyKtqOEn?=
 =?us-ascii?Q?Icub5e30yX3dz7iS+8Q7sFd3NTdnLTdb0KHKrRlNYVyxJ5DchlAMiKAmK4+9?=
 =?us-ascii?Q?jr4TEBWgZOxrYcFhSXyRAu1ENmVTFYGtw+YNXpLuRakzSX3Z5xVMCERlAeth?=
 =?us-ascii?Q?4hToaZXPN9fH/EJEq6RaBK2u+2gF3mVQEhC/WkfKDB0c97XQcyQvJsgfTEED?=
 =?us-ascii?Q?VdXxcBig5L99ztC9qKq428hwdNqYbnetqsoqVXaBTBxWAfhW417AiPusdFGu?=
 =?us-ascii?Q?iLY4D48AsFfoUSw19W1kkkoqFLfq+QmfokKgNc7sDBfAs3ohjnY+H1Lby2RT?=
 =?us-ascii?Q?at0khXXz4fuCcKGbludfk6SiXyhEDwxf3UlWqZtMZnj2FjpA1ne6dtKRrTU1?=
 =?us-ascii?Q?kauWVWYCbhgtcqHWClvDaBxHdypnGXFDzpjZqalbOsQFpq4MSwXo3rhTVj1N?=
 =?us-ascii?Q?RPgBkENetQ98CyRQYouTgBWY4YP1MRNpNHUgBkojNB1BUXqr+YLeqWSHgSa3?=
 =?us-ascii?Q?aAgdWDQV3Tj2v9G2XkrLpULyyiD9UB2bFStFktV7fynSu2bkzeAXn+iTi2UO?=
 =?us-ascii?Q?7eUAlAq5yTLfoLxAl5xMgkWLb7cM9ZbS/2hpDhli+1zMYAcT8gxD5Wxq0PZz?=
 =?us-ascii?Q?PtDwXnc1HEbudbe7D9f/5BObolTpWJIG48R0DmwMhwFcg2rHXPwR7cbFMbrI?=
 =?us-ascii?Q?jV4eBYhtGg+TkLqJCcHwT35Llw9VJNO3r1XtyqxGAfX0RaYarz9hucntOcEo?=
 =?us-ascii?Q?tV5jbkmfJTz+pHZhD51G+6jt3ZcCZ6dqxy/PgTqVhnhqr9YXhwxYWs5KoMYa?=
 =?us-ascii?Q?fARVmofDAsC0IuILjjzAwDysf/mtIrCjQlUHwlkcXtcyVr7G4JR3gW6MIOqa?=
 =?us-ascii?Q?DP6PQqkCT4nicbue0+0+6skzwZIUOLnFZriGpuJ4irt13bXslT7QwzBf8WaF?=
 =?us-ascii?Q?myCCiPev/jKaU72FHj1k3EUKzswQHcEOC3+t7opAe9DptMRqpIZzyeMUWIwO?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db18404-c0e7-47c1-fe0b-08daac0d7cd1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:55.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Upf/Ji7v8wWo2nvFQ+Cu10Pj7ski2Dm6J4s7s1Z0dx6JxEH6l0mlOUwkW1luYPVIi9vJT4+jsrxzadgrRc3jpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Add a new helper mptcp_sched_data_set_contexts(), it will be used in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index cc9865a79ffe..99d7df8d9b58 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -128,6 +128,25 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+				   struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i == MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+		data->contexts[i++] = subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] = NULL;
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk,
 			 struct mptcp_sched_data *data)
 {
-- 
2.35.3

