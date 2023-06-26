Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7807FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6tIJh2R5EpyOP8sPnYFnqBC+yosp2TPEJ2Zzq+Oe2dQBmw4+X6TGtmofypyu3YEPYFpSORFjEqQX1GOj5uSjqDdscIX8cex5n0utuhn1Wiqz/oC+y95smqKciPLnY0ENuIFPGxUG1kfEGtpv6YCk+gHUwqQrCHQsqUodDjLg6dDbUeEhsMtvWB4b4+SFg1OFXdUNTd504m8mnm6SP62x9chre9IHNBnJO7evr0TjEGRmIwUiS23PLzEJi0BGvlnbPkWqf0WJWM93X1kquuKtY3RHhlLzVb4kvxZQxctAMnQBkjQ9CnTQqiryJUsuiyGkaW6h4PWST0tabc1YaElBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8w6Fy11ZLX5izmI9cYU+HhaQ515N2DxkYc7IdRsYXo=;
 b=mlsUzFAnY5y5+AApV2Qq1JRQ3LYV6rB7E3DXc2j3Ee3RhyFtYDg3qVpcyN1NWJgdHB8rhk9zIHJPy2RWaZ4cvF1sW3lNSk0IWAn1kK9FOuR6ovw/8aT6G2iy1L+VcoIWBJ2LmXpAUktb8pLkiE9w8aVrIwKTc4xQeHO7Tu4wC9qcNd2EP4Z+nIE1xwJoW7BpdFH+n0OnEHIcAH1rY+v7RauxhBjOHfVUC4J2gPC6tw39GLTQtS4RjUQUMDWGnlxH7c5hndiSq7j/e3ObJUP6i4W7hUXzOV8kEIKHNxGMaT979ci21pPV1BBi7NDnqGvRtNImO6bKKMPxoCwUKzfV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8w6Fy11ZLX5izmI9cYU+HhaQ515N2DxkYc7IdRsYXo=;
 b=rz6CDFT+OsKrW4RCJnFc6TxfzxftJBq1P3qibrO1a5EI+7yQ1ycf2GYYtqXenvIQ6JNczMQ8itpoT+TwL0WxIR73irBPtUdBhyyRktfxSCmK2mSYEB8khzI7jJxZTgFPUOaVZDkr5Pv2nEJdhNLoRCLW+RD1BWxWLQOAckFiuyrICl1zBtG7D8gtYA8mXSEsWLkebyKIhO7YnRrcDx8JZGiY0wa21fPcGle1DaKuGBxo961zIEAvy60NaoP2FZLEs2i9p88U2++jPHdUKwKIZv6QtSfbfKtgiTR316db8LRZQPUntmYurssNcet4wQc5wp5twL5++zTJC1bcKVRPRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:24:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:24:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 09/13] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Mon, 26 Jun 2023 10:23:10 +0800
Message-Id: <25e059ba8d89058617a6f111652db5eb15f9a377.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4a6375-951b-4671-80bd-08db75ec6efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	odkOTSBHmUHAOGl1Bg6+BFoikUAaDVL6Ltg/+ohq1yFh0rPavUU2tkJRN2kmgYQNVmlmRuuqlJXPdVIaChpOgv4EJ90KICdUlvPpbhsh1RDc9VWdAzdGeB45a3NzWwawe5vXANAqHjArgEV3Ocgf8TPyUjiSt3tOJhxFhrB+XpSUl115ZpW/POuoOshPRJUUP+wBGbBHdw4To1QYolCC8zIl0LPBSmWiah2QpyLRimLB9exAgpSKk0to3fUzL/ngMEAyI9u+9Jg8qKVsjPWXhNMTEGiUW6CTL73mQcPcCdBkAE6/TvcaUauzkxTm+Z4ZVZCHcAe3yRPgBkyh5swmmD2xHgEsY+/oduwocw1E7mg9Z7UNmDWSoAB+U3zYY1V1twNcbdt7+62l5vRMM3H0dbsv7r2Xnf8jngcJAyf8EIlROB+lMK3bLPTGWHifbeK/JWE7LUDI6KXoP/Izt6UO2cY6TNKybJgPHjNvPBSjrqjcBM96IMwqXEunrf03k0gK+ax/w5b5ZbKV6cMkAxV3HwFLhj30wkTcf6kGFzWpF2kxtuuxIU2z86id90WPVhUY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqGFJsuCehV9OgxZw2GF2YjpMdI081VElcXRuLjkIfjmvUkc2HL/7F34kaKH?=
 =?us-ascii?Q?2uDSdoD944LWreYB8aZvPIE+5TRH1rNQQ80dNKzyT3HQPe2SlEuSV6XJnNQq?=
 =?us-ascii?Q?r+kNhmwuQ1s8j+bqj9s9vsMzJbghH/3WLshpFpFsNbq7IlK9DGmvmuq/WyKW?=
 =?us-ascii?Q?TiS133psTGIALHj3kwapOyAgzvHlarTkszZejwpSGFV5tGSHRw31ojgsKyGC?=
 =?us-ascii?Q?tp9/Tx1E+nltfAIq7bTbsW0zA6+o+b2VszWMWp1ouhFdPD36OQwBvrOYWj78?=
 =?us-ascii?Q?IjTvGsQH2NabMhUVMhXuue6E2yhYDu333v54fOjv8S7BG3A+15uUUldDdCgV?=
 =?us-ascii?Q?qEBz+1a3gufdCtQJ/blIz09lWJWJ7w6WKA7bLM5jyr4/rc1IoJjkgoVVOd3U?=
 =?us-ascii?Q?HQ6P5im6Uul+nbHN7o0B0NvROaVnTGaN6Z8PYHzba7xFfSHIQsU+yT3djthq?=
 =?us-ascii?Q?uFKVe+4KEQJZnLkyQ3r20gzq4h+lCTLDDOtFHTUXm2J5nbtbsnSDSej2JLcg?=
 =?us-ascii?Q?Pby1XWsHGbdwHQlZJT0DhYLsHmdb9NY8fZL91Bo73ScAN97W+dyZolnixj2t?=
 =?us-ascii?Q?57PP9KB6THS8eSpHXR0xsCilkXX+7drGCBIDXqFoGHVdH0DLBDhlLk1RxayF?=
 =?us-ascii?Q?QQVkSfki7taqnQBbxFKqPEAiq9fr2CQPWaJW1/whWISa5XUqzwdCcNZOOBGM?=
 =?us-ascii?Q?Jg40xCVlTVInXLux7KD2Y60h9k39w12z8RDIvCePPOMd842bOsd4qOCsxU9D?=
 =?us-ascii?Q?yrXn31yiSoMu6liOA6qn/b4YA0N3e1hxOtXm8WVy2aVMqJQHnVLxIPkdWssI?=
 =?us-ascii?Q?ekVe6NZPMwRoE1m05iAsXYsV385/eDPKXsMVas1d4l7y0+eUaf6+bKDwaSey?=
 =?us-ascii?Q?yDVrcng8enwFKBxtqCqiSzOyymANjWI+OYu6czaJ1Hc7u9dCLm1Xn0u8YoG5?=
 =?us-ascii?Q?TSxkA4oR0wP8ItbnttqUErK6lpARZVMoDs2fIepL55DPRaSJS/nVGLKy/2Cy?=
 =?us-ascii?Q?JQSxY6LwofaDo4XcLZkZlF1zkqy9cqtYE8mKIUvNMcxLyRDyIaoxLqbzgtxc?=
 =?us-ascii?Q?GwV6iTwTWF6newjDpkHnjkHYrLwmGBy6DV/gqCoCrV3doMSd2z1JdKXcwwpz?=
 =?us-ascii?Q?Sdfzhim5l19b8gM7ZD6iXDepKUcJIzHm+R0u+nYTNqsoUwpx5QM+Sz4JNwMq?=
 =?us-ascii?Q?gX1cAd+0YnMiICh0/P8YdDEPjBzb6SFOPNSXXQlh1kSW8JmphBW/G39xHGLr?=
 =?us-ascii?Q?QBfmb9GiQTtFPpYIISnJ2K3KomcIeeDsQf4sq6S+29eEMPS0STQT0ypyNe2k?=
 =?us-ascii?Q?PkMbyLqfZVgsjbLjNB8qFids6zzfXKKgEw4WRqFRB5fWtZiCwVlMf6e1SSg0?=
 =?us-ascii?Q?2xxffULntHK7C5c5YokoaJGIBvyooEzy+DLQiBGoZ6XqmS47C0mx0p5pm8mg?=
 =?us-ascii?Q?eiCBlTAhMMSMoEA+AQ+hEr6h8bQYwsBeavREHG4BU/md+NgPljswRsTzEruF?=
 =?us-ascii?Q?ElvwPQBo2lmLJa8K1PAs3ZyKRGTcwS4D92drvD8H8EEXJNLxTU3UGAliLQIR?=
 =?us-ascii?Q?f4CPp4x08cg8ZdKJIG7QjJKQRgi7f9DuXD72mOIS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4a6375-951b-4671-80bd-08db75ec6efa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:24:13.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovL5Zr8luvocwSVgHk91t6jO8sRBxgHQj2mRsMpwH22ifmGy65ka0lwqW/QP6cwvswpyS+s7lVtZTGd5csad0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Update scheduler API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..b4b766c7a68f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -240,19 +240,19 @@ struct mptcp_subflow_context {
 
 struct mptcp_sched_data {
 	bool	reinject;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+	__u8	subflows;
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_ops {
 	char name[MPTCP_SCHED_NAME_MAX];
 
-	void (*init)(const struct mptcp_sock *msk);
-	void (*release)(const struct mptcp_sock *msk);
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
 
-	void (*data_init)(const struct mptcp_sock *msk,
+	void (*data_init)(struct mptcp_sock *msk,
 			  struct mptcp_sched_data *data);
-	int (*get_subflow)(const struct mptcp_sock *msk,
-			   struct mptcp_sched_data *data);
+	int (*get_subflow)(struct mptcp_sock *msk,
+			   const struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -269,5 +269,7 @@ extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
+extern struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
 #endif
-- 
2.35.3

