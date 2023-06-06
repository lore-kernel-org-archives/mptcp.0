Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F1813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDOsSAeW5V5pJvtcqvfLbuiprTej91HPVJS/ap8I8s+xST/woij1XyIFWFsYaExpNpSUTpnqZQeTQSBsSD/N7cS2b81dg2pKDZA6dAB6Ohn4p9PG/Lpn4939I0uHMVI4fVLDt4aYivqeRIHhhr32DPGNYGPPnRoxnP0yvi3IjNKqCa+T4Ai1rhPa8GHztezE8WrMXi1KvJgsF25+D5/bCnA63coko/YI6hGJa38WUlVftFsguCzgPL26kFU71+p/LokXSuLbEtzL/TvdWZofXTlKiWSBqFVCpr9QO8pmlGdNUwkWrSkk7e2P8gK4fyu1tX9akvsOy+3Vl2CC4d6DPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9PI2sV7MlipZTri3SLbscvZ4LbuFBwFaRdlDVp8dUE=;
 b=JGKQ52k2HRDOY1sUSSDLPqfpZxDIZ8NH+vcf8xE1EOVitZMj4rBrmhHjMSlfaqS5fuiJ6+26M31pZJUPMYBgPWQQ5L77MGrz2r6ArU5UUlrTqgYXJbfpTJTCAHK2wm3Z9rGC2T0URxAeVyowwrsUM7iaAVK3pGVESTeJsaHumZMB+p0VNhVJqBVuDMR1NwYBIbyWlhaOloRX0hcoN33d/Qt/KKJvMWO+8Aa1nlYylGngqKd+j30s+SXucxqWecXlilvMuarMcr/Fjwqxis+L2aTKoLkzNFLDmyDtoOxYr2FxTZ2R+7MQoG1POQecTM8faqQTmMxhne+QWuyHcu+Qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9PI2sV7MlipZTri3SLbscvZ4LbuFBwFaRdlDVp8dUE=;
 b=tzIf4b/LJfuwASyrf+J43JJsZvMFg9JOecrSfuNbHOMBHrEi1W9VeLY6MljR6U27JyPiFlNAg8JCQsIigBuQkTz3Ydys/Mer4GuFd1VM0TrTkLaaXtRJbhqNSV1klXvdXXal0xNRraYk5DWD9LMiS2hhkBwFQmySOO30CD8SCcxlu+C24k8ZwyYcgG0AV4+Zx+wFad8F06/XClFPkOOqxg4SxZqzUPwnKngiOrLar5cK2d095+H4KWaDKnUC68y27F9l7Wf9gUnROyVKnYwAyYHoxItcnKo7K21d4Thx8PqH554+w9PKjMSx+PuxIoh7KqtisjW4qQ0CfgPAhbcqww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 07/18] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue,  6 Jun 2023 14:45:06 +0800
Message-Id: <2cddd5e32bd51d68d30f7196acb29f608de45cad.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a49eba9-11ef-481e-6688-08db6659af7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LT4nRa8KaNyFfXFCZ/j9MB/wkDT4ktkrRPD5VqSMvJAHoO0C19y68Sq9DsGrM30+QNySd+8MGut2x+e5AxaOY39VHVmr8pB5B9cbn2u4rWWWdqqKXpnFN4jC4rldJjEqytMpfnEXf2c9WWZo4qZ86JqTrkIkPdyiT6ujzpu1E50syGS1IJredM/lt4eNKR779qNEWz109P/nvf6E1dccoMdcEL1YvayKGgPzfNWajxdTfZetYM8LiE16NnJps2uQxp7dENf7xyoWIN3Rhat8+sdFzq32YbC2GAyCFh2GZIXQxesmcaaBzlDKA7qiG8bmpWBR17P6ukO0ITyp2njkJtOvX8SbvF3zbsZYlNTF5Wh+lU8vMsD/jKjlIWdtlbdvlWVpWh4Rf/fyC47rh0AxBWAValPEGrEql9Tldalkxg6DqUX4cpx09g1cH3rAFXAwM5vpgTDJiZrm6Zr6Qm/h4qkZz7ex6Nms8SPSwiWomdMM/zh1fFahxmQMhZlJtWhIldTtmLyL/oPwL80mwOOtPsFruHPYN4QmklPP3SDg4RRZ88BX/YoufpujomLQT6Wc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MY4ZLhRV0AYd/BMpA0HaYJ2bZQhETKB/VW45e7OfknZLSHnRBbXvlZI9OtxI?=
 =?us-ascii?Q?e354xmT6T+BHz7ki4Pu32PEl7q2d/G5dqSRpmOlZQ1iuPUJHiXjFWZeNcsQv?=
 =?us-ascii?Q?/AgD5skraIk8czB4n/EjBhT1I437daMKuRONd+xMQZa1R9SroN5Vkz/jy8li?=
 =?us-ascii?Q?bdlpvVAcKmDaSYwAdYNB7Y1lxFAScPr0li+sI50z0vV4R0Bxt3BfWYncZd8q?=
 =?us-ascii?Q?4MgKkrv8WO29Onwze3FPInuR8OzLPqxS/siDJ4L0Oan39NfpXzW0JRkPTUN/?=
 =?us-ascii?Q?8hsHUGhBnVYA8+/qbmHVQDEcqcMnDOyJmgvVA8B63OoOEL3Nz8+CUJzqNBqS?=
 =?us-ascii?Q?JxnPz23TWsUgRyijcMjPhzGHZ7ZRwzKjCdElGWECLch3KkV0SWaCmjHvBkli?=
 =?us-ascii?Q?12p6TNZ7bhNZxRKQozQiEUWo5PGD3O2P3S7OQpgBd7+J5eVg0wqWPFk+ip8p?=
 =?us-ascii?Q?uOMfTwj6wcotzE8ze3pHjiHuAKAToodd0BbfYDPfGADMX7KeO6teBe5/j1Al?=
 =?us-ascii?Q?IziPLfER7cF2f1zrRvaFvMLi+OSnkecKG+PZKOje3k79Q5SmqCjFIRPmszdT?=
 =?us-ascii?Q?NIR4P2vMGnS9IrC5HJaopK/MVf+fHrWisX8uOhG3Je1Jbta4eADO2zvuNbvZ?=
 =?us-ascii?Q?LmkIKLdKjmLj56hIY/O9WQ8PX9CEuFA8adjnMP5KrnkcYLkd4hKdIzjv23XT?=
 =?us-ascii?Q?T51PqLxSdp5NMnZl1+koxbAQF9tfSmMYeBwPhumZfERtFTcZAGZLkdagLLM8?=
 =?us-ascii?Q?mKMP0qCLRKBQUcu2EKFXPH9XB+nwxAibkP26TMycxYqknqMNHTx2BvbDLWma?=
 =?us-ascii?Q?ni1uuXFaHun5edkDW6End1MpbBrR+o/9dOkS2vUekehHlaIRh6DtV9Dj1Ci/?=
 =?us-ascii?Q?CRK2PIICtv5B5xmbTYFDZ2TFjIxfqDO05LFOzpZO8ypjRNoHPNjsPL1ShnzE?=
 =?us-ascii?Q?MjnP4Iu8naYrzXNK6vvTOedbFsRE/Qh6+q0di85kdaX47M3zqO8PrqpicTm4?=
 =?us-ascii?Q?0IBSQRfq2JWWvVti2SHDgvPkjDd7Ata/ywPDsnQNTy9EJ4CqyDP80aeL3xx1?=
 =?us-ascii?Q?frFgnFtaah0vMtppy+4qUCEa9JuwNNSZ7/JVauGwpJFKJGJKtTaFmXiuG1YO?=
 =?us-ascii?Q?hbLxImi8ppt8cYYs2S4ESdLGMDfoe3k9pNBjga6rUWEig0OEdakNxA5w7js6?=
 =?us-ascii?Q?qfJfJPRoKL0L79Pf9n7QIANA1/QHUqbim2x1NgVU+xqvdy3HXvYahfsVVrhw?=
 =?us-ascii?Q?WntvipAvGupBJi99z9HsMAOes59MAEFo0TUZAShurC3hArAu7/v3351eiTfB?=
 =?us-ascii?Q?vmNIncOOySzKKK6jsFObx5WT1hTfxD65+wJ10NWkT1q+5QXNAPmmMTVcymJG?=
 =?us-ascii?Q?frW9vwzOuFjmEEcnmM40kYWFXM+8ud246ChC/ow1Su8pLRZf56ZbJh2gC97h?=
 =?us-ascii?Q?BtFsRxB7ZanYQ7KhYP96v17Gt4nKhjOGiSQgAkrZwKBt+zIelxeFGASwGVoZ?=
 =?us-ascii?Q?hRa9iwnhc7+LI3shaGiHoxbe1eJR2MmGs9TZuf5HEGzmDa9FoNwBVpJbOWt2?=
 =?us-ascii?Q?ndK6OwobxqpSWbq0J+T973bY86B2gh0AeP/I9ybY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a49eba9-11ef-481e-6688-08db6659af7c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:58.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHcJv9hSq+a/4Vt4/A2DRh2olhELp7fCW6gjpEgcoa7ZInf5gjeumRri4WSSWY3pslMdPBh3kgXa69sb5nRaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

Add more struct accesses.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..a2bf8bf691d1 100644
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
 
@@ -51,13 +52,14 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
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
 
@@ -141,8 +143,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
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

