Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A311CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JMZ3Vle3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayaDN2QPRcbDDOtE0A0A9dff1ElqJxRH7RzvCnL592AnJzYNe1F42v8NrDbudQpb4qU+O9OLtJDP6IRovds+0pGs9FIY94vdP0KhVUxH+Z/dV4KdGcyOONUq5l+14Q6vGK+vWIOIQp0aDf2LmSGDNHCr9dDctUW4yhqyBjcD2gOa4TthJhuHdmEoaGUgOAR0/99NAHO7GYr2AsPndkDTigCSqwahKkX0K/fnBeHryO3JRRcziFU5Ork8YpkXkjr4iHiP1xE17P06Dg0Mkn2CEby7Afy2J5vclIb240yZ79l8LEVfrwlnGRxZQArola/IB7w94NCSs7j8zPtjV4IvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAsuYM0SHeE0gMAKE/zDvmsFpvqucoF1N6A3aXgjE3o=;
 b=Q6NjqqnSfbWkjaFncFULXasLX/qNJFiJROkTY28L1jWPICsQ96VMlNvCNzKHgxiav7SicbW8HoNO3ps3tfWEh9xeDW22Lf+XlXXLWdXHwLHKMq7oit2fOWKXhOZkJzFml2FeoYj9bFf7MsF8t8t5Nn9/YjzXvFtLqp2tIq89d5veUnuoQviRQ+AeZZXY8dmX72uo868Ve5uVPbqBfIF9h4DshXU27J6FqzknC2m6799MzQ960E5xMZPKcgr/k5xFqMVWRajjQg9IDGHP8+8221+zxtRsfMsdehNStiJvgT+fTbEl2VOYDE1cahjR8ZbGULTpVjJAWScemP+MAKFc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAsuYM0SHeE0gMAKE/zDvmsFpvqucoF1N6A3aXgjE3o=;
 b=JMZ3Vle3CJNQQVebsLvMA6+8Y1EUQMKDJy2KcsImC06f2+Ce1rO+5JyV5KQ5xDfxa+Yn/eW5z9DAbcexwxLiF81wq9u62i3kh0JQYF2vBkxMEz/zKY5X+VCPgAWM/ciIqaUnGoJRMWIXvzmmNBLAtND0NyL5OYGhasY2xBRNA4aplZhAtuY9tG9UWV3kIJOYqR+46Bm9UFnesqL7HQj/8cciXzSVqkYZ+xJ7lecJVD1umHCPeyg4nAo4iux6jDJZs7SmuTmcyPhPIImPKsvcYmg1opbcE4mtC31t89wLei8jtgeLexjMuaWZJTPIEUBofiEN29Ea5teZApQp+sPuPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:51:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:51:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 08/10] selftests: mptcp: flush and dump userspace addrs list
Date: Thu,  2 Nov 2023 17:50:51 +0800
Message-Id: <2bd462a0b779a740d185628581003f5b0d6feb1f.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3901d5-813f-4213-a06b-08dbdb895814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s3rz0ORhLSqORNX/4cSyAQewmgFcHBcviPqA1fIkhQg+6ZkgjY4AHrdBvzZpnMeji9crlVgR/swgvbiJoYfhejIxl7ketlzZNmnB2xy0dywzP/EJB8ddtzpypGKvQyykihVOeYFZbXbvv20oCmFkvYL3xqXd1avHb3DluAsN8+aX0z10HWAgnoNeN3A0diXGHSxuYvVRcc8LLfnSbN+ak8ju4vcHng48TaEzw9/OdCMsJGFkhESSL4iXNljab7NDLI2MINrzWOUGIub7kYPcnIZkSGSjnOIhWRuKoZIFfGbHQiOqcuWwls+omvTZ7Eyc/OdjfCEgYP4v8RtefnrrZ37tkBgysgQxIUcrmq015jcXLuxG6wt+ZNbFbRFQk54bHIvIb9SslyQEN/06G8VomP0mwUVUPlI6OCxF55H1q/Cg8+BVB1MmMsHA4iFRJ4VPinByp5szB4xeLTNQdH80epKNKyJ+ykVIRCHVM5o/7EeWkhnZHf2o/2Y1GizvKpjsuwLLfxefUP/9eXwk3bM70+phPh91iylnUt3eM0dN/k1fRZcLqPCCMqW7wNljF030jkL8qcjtiAufmA65SvUcxKN6UXG4UJhMwQ0AnPSvH1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(6512007)(107886003)(26005)(36756003)(86362001)(2906002)(4744005)(478600001)(5660300002)(6666004)(8676002)(6506007)(6916009)(8936002)(4326008)(38100700002)(66476007)(66556008)(316002)(44832011)(66946007)(6486002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?168jGSWa71AsOvQ/hUl72lnQ6T+cbfTz0vOg7YHG6FLwCi5avJHhDxIfnU08?=
 =?us-ascii?Q?p1cvoEFbfPn6tpEQ/oBRx93s/BNPr9FOCKzJjQmOQjPqP/gt0lqngHQoWzE7?=
 =?us-ascii?Q?y6/TKhmZ1BYytOQ40Wv/gHFdkYN1frbgpOU78EuxYP9MtS4cXdC1eI71zN/X?=
 =?us-ascii?Q?wstMI5ok3LNFyL3Azzjtv3ehLii+tsyJ6p+sQiPAs2p5pFErGOhNqkuZRa5m?=
 =?us-ascii?Q?IuDi8LHbWONPSiSldVrYrBaXvHWvI6Ww3JAN+kM4VprsPjkPTVf+kDcZxzcc?=
 =?us-ascii?Q?FYE1ZrX4wvbDFuNW6PTkzgN40nDClZLPRIv/2KYCCBVRoXjylD/G0/fv/D8y?=
 =?us-ascii?Q?Qq9jUmFogm6iGsXcchFMzq3msfF0teUAX6vquuPPS8rXGxHso6pdVhftYxcE?=
 =?us-ascii?Q?Fc4PMJl4bzpwD55d8JBMZLv/tAy5/voFpOl4WaZUzpUpvuDZPgXnok9X/9Yo?=
 =?us-ascii?Q?iPf7+cokYbiZbeHLsLsm0gtlNuQk4ZEtBxwGa2MPMs3BavnjTB7ZW6G9eFOT?=
 =?us-ascii?Q?4+gj+ZAanjACG6jzXIsjr0EcPCzPX8ehTRC6+ebpzAr9vMer2MLhKxGfnEDD?=
 =?us-ascii?Q?fDnRZ2mQ/rUgGncS+PleUFAgTR71qeg507RZjf/NaNhBuxkdvni0Z/aROmcg?=
 =?us-ascii?Q?WRH0kRHs5IQgCB3zoNw7EpLwHbqazAvsQGCBJRk+eJ5BWm91TBYJGWQNbqWa?=
 =?us-ascii?Q?BNbSWoTZFI0zvBN+VMosLiqRivcHNn8ef7kT00JZfSG41ZMgv0lDv7IKYwtb?=
 =?us-ascii?Q?YCFVVIfuNAWsub5gkLD6pzN8Ac0LRsbiWR7MXNccbnSOjC24j7180d9VeSe/?=
 =?us-ascii?Q?lEo7ytBunK9/ui0os8viCPFeS48wHIEqtB4P0BvN/ikDh1UZkueQ0icX3Ccn?=
 =?us-ascii?Q?152tfJ/CZ0OrJiMIfqhBu+LYhSVP8vH9ZoyzajVUXjQlA6i+8tLRGugkf7Aq?=
 =?us-ascii?Q?Ybc7uiOu9o+up+RtjTocRp1jngRKQb6Qrc/RVn0Wa5A755iuHEdhNKUsamvH?=
 =?us-ascii?Q?+Hg0gNQrW5UH2NezssVSDVNLSzW+9mugXAHm5/p/8POdI9W8/74jJmQDJGk5?=
 =?us-ascii?Q?mU4uEpmEWEKL9Xe+4bGqf0CIMe2PFZk09tFm5/r2EWdHCaZuyOVqkzPPXdzy?=
 =?us-ascii?Q?o8O4UKJUCnAfo+KcMwg6KrS1oOkd/tiGr4svqkuC8e5z56YSIqOajSqnFBtU?=
 =?us-ascii?Q?rTrBJ5+heXB7LyNhRLtEv/TOt7eggG6fwiXxkR0utlWbCKldfqHYvG/KhXhg?=
 =?us-ascii?Q?ZPjanAZRkiuRqUonzdGAZxb9K3x86DnSxquLXy5aQEzPr7gQdPE8jtEKrdEJ?=
 =?us-ascii?Q?BGHIIz+vgJQ2WpbG+PpLE0h/j0GRHJp6EEmLQ5uKxVPCPSzk/yDqKHdlDAUN?=
 =?us-ascii?Q?XvYhWS1GKq8e3LOaeOfsltBtTG5HK/SOY3yC5y1oL22dMImF/tlbuQrHAYnu?=
 =?us-ascii?Q?XDZzQZ/t3boNeQmOnM5RgcUAMKymHMazOLWYrRTU/rfxDY6rFHG7h4XsfBOq?=
 =?us-ascii?Q?saQuxRdwAt+UMO+EJvvZ3pGwXFFE2mTY4zYRxfcmfnFQWVh4XvE7HphSCH2R?=
 =?us-ascii?Q?N/fNtnz+gsVrDNx6Xku9r7mzg4Kc5a+sCWFl8pqo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3901d5-813f-4213-a06b-08dbdb895814
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:51:54.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyWXSz/e0vCObD5YB1Fch4kQ+JG4uRU9xkWJqGp8TemeIlA7/kBUUQNFCsXC+mc1z0MXyirbY+c8pR4EP3J1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179

This patch tests newly added flush and dump commands for the userspace PM.
Add these commands into "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 995280882428..a14381c94c56 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3453,6 +3453,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

