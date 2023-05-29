Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1B7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFD30UpQernBEomV4AQIetf0CQ1z5Ygq66lMNttMXkQyyv7LoJxklJmeKGwPG5R1DAfnbV3o7cmTVbtbimWZjkpQNoh2AKTN0QKtkpQ3/8T/HG4zoyTL1fqIIGXShYTORQKJ2H+x9uhbGRpGr25G6cA+byp4sY+FsXHlwdktcbp40C04w3d7qVlE9H7BgseC6496EccbASuGyRzg+2s8vYHLZmUbEu+KDBeOr4S8KeeC10xedgD1ee6BY0Y8Vs1LDgviEJLD6IedSLStZfF+/ZLIdxLZg363wjnqmNHgBchS6ncTGpnfDl0bQpcrsyjYm8+ulY5uTwoUG5qTzJMfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsyIBUfohl6UmExIXwILMxZE/VQci31GxF7/sOspquA=;
 b=nUGBmGHBVY9j+48lxfAdi9jqUKAe2+YsGPkiZW0j7o3uu5HJdeQ73GZ4VtaEPYuE+qsOtrUu58T+8NC/1dfOPsxV+eGvicc7HbW1pmXDOSxb/BPgUFsKnhNW7C8krc/WJjtycjbcJ/Z0+ene4JVFaorKvnAjpmAG82luNIP1ATdMt2SUlIUOvTujqea+NPLgk2t5QoBX6EjHc8fFNqEVmu2axeYE5y4qC+u00cHooMIVpo2RZGrC1LZZW2djeOhsNDUi7DhPNWlXcmaujFKSgsrNmEmjatNkiq6b0kpov9WKzb+8mGP9Uki4d5v+9TJQToyGeoNr5iyeQBhEZkpMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsyIBUfohl6UmExIXwILMxZE/VQci31GxF7/sOspquA=;
 b=DLpG57JDm99brCYEzALsnwKwvjNXyaoSKnkpprW8NpUlFWC9+K6k0wJHZK+Zh2bYg9j/mp/lJ9+R6a7QONmwlQOGbr3OzLtI4UyJF4MKBu6t6GcnT/WlsynPLfi/MPC8SFLclEf3ckpCPrZBZC2IRegnUe6xU1aCnX51wUa4t3yTbmbZjS8DFd58kdBDODkry/tqFSlJqsLSHcc68FcVUgrWzWoo9BPyk6ouYXsvVQ16/2SV/uxseUiCC4ZLUbtGxnKzihOKiCxMdcQ4nRc6jDFGnyJ0jyewCDzwxat439tXEcbgWsn3h7DyL0V0Gk/nu38DOBco5UAXOnOVRQ5t1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:18:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:18:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 07/12] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Mon, 29 May 2023 17:17:21 +0800
Message-Id: <c696c9fa6e162c68a50805a78e41a949990c8f4a.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 835c6d47-5642-47ef-fa8e-08db6025a992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0FIgBcBWnLrO3DJ0TxI6206g9ZjxAWz63dvwYZhgfi+zXA46noWjL5h4wzGkc4zRyWUcmtM9btdOi5IEDvK1/JzSfDkGzAvw17sJRwECoZ2WO0a2v+q/nBp8IMA/sRmpvb8S/rDsKVl5rOQZRsEjhW65XSwPRlv+gAdJ1T3wxi1fRXyUv7pSv/4RcYPP35BRKsI6ISS8VdLIgdRHxJD/cPfXCMbXc6qM4kgmCcegdpjTqaaQGWeZUV1YfXp2izqLaKKO6uIVUJs6bse4FWumOsXhiB0cn9USmqT/Qi9OJmSgGUeVD0MmpDUXApTPIZG+Mqw+H5J+HLZH8JX+vn7SS62Kj34fKkJl61DLkhyJlyd0OZfyzRyoWeUhDYGVk0vjYRt7MLo1mTH6wL6ua/p3Y7USbljvodBDT+0RYjrSo4jzXC4BPGWtjzaPIz7sMZuTXMxYWm0S8YTbUsMKbX5HeqdFKt81Tx4ca0LNnODi5+DVqU/265WjTX8ieR7rC5NPbUTy/ozQtZgTW4/WTUwCCA6QbO0HUMcvsoVK+tOaE3pnD1/9gq3SnKv0U4jP+6aV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?30o0BN8gefc85LK3itz5yflc9gamW8/WKLy5PvYT+N+x3jV45C0WymKP3m8h?=
 =?us-ascii?Q?tQGD466hKMH57gdWXqoCvxw4p8owMuYqV2uSRB7kaDsuQ1f+QzECjqIxZpMt?=
 =?us-ascii?Q?xvz4ABM3vABZfvS/729v9RK0UOZO2WwlBD+3xFz85ur7lcJyJnJUI8qmd2XU?=
 =?us-ascii?Q?Hy0SATe1z43EO0Xe7zzCbVE/xAvWQWEv104L+vRLiu3zY/9bh8NFoPLyfXnY?=
 =?us-ascii?Q?XuvrpPM6PYHHn+nQlukEH64cwt9f1fjbvpbft9wbkJp2HIVh9it6ObH4Cwlv?=
 =?us-ascii?Q?Z+Scj4QDHA8mREhAYd0fsFvsN+a39ZAhraOuh27WziHNrpbSA1IxPBbBRHgy?=
 =?us-ascii?Q?giTN3CrMpqQM9mHHEUYLYzoFJmzTZdiTZSGw0Du2e2oSheVCFZQ0CIKv9qwe?=
 =?us-ascii?Q?d8mN/AXrsuKTlipZtz+OzLnb+R0yFWhHeA6H9eOtAk7aWtAUZ5Mb0mMzUuIk?=
 =?us-ascii?Q?o6KwFCbhHyGLzBcf2xynDqadA2WQjr/Oc+2SeXhRDx34V4FzX7aT+Hyb8vN0?=
 =?us-ascii?Q?auE6NQ9ZTjvhdDPvIrVUakuqVg4o+/lsthmgaEglD26ssy/sPL6YEMX8Jm0n?=
 =?us-ascii?Q?0QZPAM3zFQANPMk/EMo7xeMpesRVSgIaOaRjWaGlWGbiZQlT2OR7dwE5nnBz?=
 =?us-ascii?Q?m8Oy1FuDujodqyaW5S5dTFzIypFn6JDw/NdoAbIW3kmR5PsocBO4fLQfcUkq?=
 =?us-ascii?Q?QsTxddJhYSy6WGSA4uLgEraT5kTLYxOGIMc+MxpRpf/F3yjWhbSd0WgKbEtC?=
 =?us-ascii?Q?sEokQaGuBw4RUo1B8oNgXZGsYgg3obsLTpfiIeS0vGhCyrf+h0eYplLpFcZY?=
 =?us-ascii?Q?SlyOWlwNOCGfYnU9h4dyjnL4o8bVe873vsW9t6ibEe9yB1RSs3fC8+3JMTqX?=
 =?us-ascii?Q?IJthdk4kZPrj4Z+0p5iTLObVY8XYYuznby/tNw9BJjWFYrUBe5gbfZjRms4Z?=
 =?us-ascii?Q?vA2VXf8wUH6eRBrKKGdfSwxAHaFuyDAmAM01N6IJ4NMxHbQdJpS3XhSEXRj8?=
 =?us-ascii?Q?ksc1cV3x7yumNiEe28YXPmKzJtmMNsiUA7Xj/PGtSJd43z0FU9Wxqboev78O?=
 =?us-ascii?Q?rlX97voMIocxGh8QLeOjLyMrbpyqfH46kS1GwyAs9K5CJoQFrszk3DoynaqS?=
 =?us-ascii?Q?8JP6iFxQDWE0hSDL21by+4rnPP8OrYGYvBj/lN9qw//m/+wBUGqeS2NDEMVz?=
 =?us-ascii?Q?OMNeHYC2jIwwBV847+cjS5J7Is4nYTl5LRf0+0Yxi6mFhMu5VkGRq42gogoB?=
 =?us-ascii?Q?kVRTR9oZkBZ1ejBugDwRpRYSddC+uNbiyxTzgAqGzsrrLyFtkHxXJlNMVc0R?=
 =?us-ascii?Q?43AXAiTr+nvD53fAPrj1nbLZXnjwrjyz/Qie4Aerz+ZmdUJONspy20RZLnX+?=
 =?us-ascii?Q?o10nRDAFvgOW++uuuHz3lHwLBVUOzbUMK/M+cwS09FQB6mS6EvUKO2q7u7aq?=
 =?us-ascii?Q?8MHAp97+fKEdG41eVosiQ1tamcKEcd3Lgugr+kacfND0OxtVIoLH3F3ZmlxP?=
 =?us-ascii?Q?QzjnAeucTO0HQMkLHYRJ2hD23963aXJUj6MZATSInOVEWW7EiBrV0DiIAU7t?=
 =?us-ascii?Q?CpyQ6nPelONsBmg/lb8b7RCAgomhdfztKtRFBfIs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c6d47-5642-47ef-fa8e-08db6025a992
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:18:28.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knpKTWnc6ROWYhCMQI5kOFSXhsZUSt1AzG/7qlulCDDIGBhlpKBtuNRN8Pfatu4DCXFkATivP2DGfnc9OSAUZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

Add more struct accesses.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..f2ce9acc2628 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,9 @@
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
 extern struct btf *btf_vmlinux;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
+static const struct btf_type *mptcp_context_type __read_mostly;
+static const struct btf_type *mptcp_data_type __read_mostly;
+static u32 mptcp_context_id, mptcp_data_id;
 
 static u32 optional_sched_ops[] = {
 	offsetof(struct mptcp_sched_ops, init),
@@ -41,8 +42,8 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
+	if (t != mptcp_context_type && t != mptcp_data_type) {
+		bpf_log(log, "only access to subflow_context or sched_data is supported\n");
 		return -EACCES;
 	}
 
@@ -50,14 +51,21 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
-		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
+		bpf_log(log, "no write support to %s at off %d\n",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
 		return -EACCES;
 	}
 
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ended at %zu",
-			off, size, end);
+		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off, size, end);
 		return -EACCES;
 	}
 
@@ -141,8 +149,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
-	mptcp_sched_id = type_id;
-	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
+	mptcp_context_id = type_id;
+	mptcp_context_type = btf_type_by_id(btf, mptcp_context_id);
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_data_id = type_id;
+	mptcp_data_type = btf_type_by_id(btf, mptcp_data_id);
 
 	return 0;
 }
-- 
2.35.3

