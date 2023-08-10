Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE41E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmOTv9lEll39HMAJJ+UWhAVT26hikRrBBHy0C6RPedwU6KM5V/gHDB5SnV2Omhw/GNtP4i9dl/PeSzPntZS5DPFw30laIj5WX8apPSUrH/yNFLOioOfv7MmInD/YlfeEewepYDwfXlI0mLBN9XHzyeAvI/UN0w1mf7tLoAWFoTl+OAVoe+S6QLHtBbrtco3eHwlKbA8jqNEe9RNKqQFeoi5O2+ORVIGne+i64lbPnFsMNnhKR9EWCpCeK2bbXwNOx9ys3ZeTPhJnxZ/nGEumFp1kUXl9A3p2O9Nc2pYrk8Kjc/iHNVK+/DLEee+zsH1pDehTDDwXe4FrFjlsyA6Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1edvtfLOYKK8DmceLHdbQTVvxj/Bje2gGNiSIUWigo=;
 b=iVo0kwf/yTEq6fHkDYTkIHUzDrqYRwr+4GngoZ3CMfhEG7wjZxwpVbOc0GNZ86Z4cGx36lW54KdKMY/D39REcAuDGdQLJvuLpvTmHbweeWRFfn/BtdV7uW0y5Sul1IMUk93atygY1u7wSvChJ9qC1De5k2/gOKzhdv3pDEhTUgYLKH0mjHaMLqwpKNzv1Nw52YGk4D/3a/RUuRIkg6uFiPCxa7IhjM+opD8vklVYVrb/O09U2CSjaKRJB6NnXSCN9rBACTqeElZYYfrFT8uvLNd5ZEjLTNEDt3mdKtV9Us/oUuu1oHhMB+cbSvFYPF+H5TdIYUVe1oRTVv31oBdmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1edvtfLOYKK8DmceLHdbQTVvxj/Bje2gGNiSIUWigo=;
 b=AdIoS0XmW67lPl3El4p1Ro1y4VSNPWCmU7Qc3wEsmT3CVo4YATBtFFNHtM2zXiq/HoUdvSrxExI1LN7xauSi7L1t/Si9XGG2c6gLaHjFHQjyzc9uB+5pR5atVvt48kq0AAOleziNuft1aQKkOJkwF9VC42FJX0ATLTKZ+NpExJvr+Jz3FMqKqUaQXnjcbbPWXGriT7zC3WE1ybGPq3NSniN600WhMjvYHTV+X6l5eFzeZFM3gFZItlQ2D0kmIUMQiDIp0E0l7o1I1SbqesGijH5UjOIIh9Oj+3qiCdargSR7byIWRYRZfzhnnKyrc6f9XnJYymX4+cr5Tf7YQu+vXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Thu, 10 Aug
 2023 14:10:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 05/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Thu, 10 Aug 2023 22:09:57 +0800
Message-Id: <0c3cbd27850ba5fbb3d10947da2dc4b89065195d.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1d874f-d9ae-4594-7656-08db99ab8f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tT6RjAm8u1PLBrF0uaqGdI2JSiZY7/kWKcd8IKhD/vaYEF0urW5TBPkz7kKNLXJpTNPlXxXUg7zQOTiTpZtMvXpfe80FE1xPeDTxEymXH8RP7qGeDy1vuclZLiOmMYpHFOcPeov8XmcocfYUY5TiDXTQuEK+GNb5H3OM7bvRjqjp3Fo+mzQvdF8A/fsT9zlUXGfR4y0yTVQ9tF8H2b2CjuFTOi5lxY4kafPc3NpnLYgJodW2VOOXmh6Gf/pbqoGVw/NYHuGiCKZBr9h83gAKetSfIdd8yw4S1IZrAEMoxvclaFqkxA6tbYD4g04Fc83O9umlU00Jn/AK5K6+eUjhJ2na2b9ZDh4luh718USAKuga/oUIDEZWMPWb11qe2PDeBP6uALU79bHVrNvK0uNyDcPkPlaewvl/eTz25p/YmTpK/fEPzryqTQhEprczRkiSjcZG5nfSvkxw0pS9QA+2mmOd2OBeX6KZK89lvQ6ax4nH3Cl0vLZ22x/vc2M/mtTLGPrREOR03NcgU46tiYgOfT71J2Lky3tDPQOEG4Whfu6Hq8tlB+bBjrZJN9yLkMkNrjAukYNmNB4PiDvXrrfLaJ1KtWG5OjoifCFBOq5lmN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(186006)(1800799006)(2616005)(6506007)(6916009)(36756003)(4326008)(6512007)(316002)(86362001)(38100700002)(478600001)(66946007)(6666004)(66476007)(6486002)(66556008)(26005)(107886003)(8936002)(41300700001)(8676002)(2906002)(83380400001)(44832011)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SZBvvnStho0C1Vlu2eJbG7nHnRugMKvPlSAdB88IPS37k+61xuJVxI+VpuMZ?=
 =?us-ascii?Q?WmCMEd91ARiX1HC873j41q5ueowRzcvyWyvt604bfRyQuvCeKS/u8r3//54Z?=
 =?us-ascii?Q?eNEZGEaH4RQTYsMK2GGZYGSTkwq7wTtXwqUxpvZK1jpMTT33SKkLtvGbkMNT?=
 =?us-ascii?Q?kfKBVuCJ6xcA2wfjdMmRsz+DMFmSXzIXS2MuhZVlUgCMqo1bx53Dik8OxoUw?=
 =?us-ascii?Q?EXcFN4bEsi6u2xUJYQuBClg/yZJI8foU2b7wGm8IWHUWU5Lurj3QMLKH2y7c?=
 =?us-ascii?Q?34alFV0kZEyNV3fGa4OUCO38IeK2Hfemsv9KxQO41iNFjc5f/BJTcQwdyU8w?=
 =?us-ascii?Q?LPW4DsJtDEVlBLlk/bW0O+DQSZzB4QZ0udpodwtCKJTBpIUweagss3InxS8R?=
 =?us-ascii?Q?qKNQ5/ujctfJ1gLVUMpiiill93Ic7B9TXxgMoGSvGbsziijO+96hiOXsNCvQ?=
 =?us-ascii?Q?FJ9Oj2Q+vHSk/CTFN92h3eeAhWcCWEOP8LZrvp+dbIkRMeoYchLiLfbmq9Pi?=
 =?us-ascii?Q?qITLeiBP4q/kB/Z0wKXkZZwBHYDjQWgN/J4U/rG+9vYEdS5NkAEXZbBcZYoa?=
 =?us-ascii?Q?MeY6QT4ZwJTeMia9lP7k60ZGP27sodR2/AxBC/zskHanSawdVLh9B5EY//nc?=
 =?us-ascii?Q?TmY73OWELxwHmY+PD9azfuAbYF5c31j8DOOlJbVuFk64mRhR7uTecfqe0o/j?=
 =?us-ascii?Q?6gGcVZDZfYzCP6LaH5csQuqFQlKbFx1m5ct463p3zcBdO2qBv5QCjiyYlZaL?=
 =?us-ascii?Q?bibVT/FhU+ADvD9RKYpei259monfXxXf2K10yHmYU0URkyHlmji4MfjMwSfb?=
 =?us-ascii?Q?SGLtdICi3GOGpCtDA5iMo1bI9WjV49vyiXizrW+uMq7m4/fUU6JjaxkDkLT7?=
 =?us-ascii?Q?XOtlUtShqKwjMCICcAdSzHzl8WlH48A6U6EwZQANN61F+QOi3Y747t9SaTcf?=
 =?us-ascii?Q?RAUfvJ8MQCjASgZp1LLXFCaI2LDhNnNgn/ELjWawpOtRo9Eh0MCnDzEMLC2H?=
 =?us-ascii?Q?AyQYW8t+GNswXsr5B+h1VdbYfV2sp5QfnvWyOIIYx8zAVQtkJrDAOLAonJJc?=
 =?us-ascii?Q?S5Wkyp6q6v7Oo2VK1T3q3uIJAhOKPo3ISB7G5zVL5hUBrG4WPU/pw/D0fN/c?=
 =?us-ascii?Q?NsiEiSEBG5T+3DQ3Wq/s5KRurcWlYzB4CLuKNZzKnU5gk2PEVrcnVmptCF4y?=
 =?us-ascii?Q?Y2ojT2ykiahGVZwvoOrbHDpx5OcSJmReGJ0ZIsT8q5hPHVEpZlZAbcfEiu7R?=
 =?us-ascii?Q?SEvgsIGNE+475ZwX5TyDJnkfWPGWCQBYcyfCsdpiMn/2acjA38GcZB0qnq2Z?=
 =?us-ascii?Q?DFBz2YlGU4aHWm1un9XEupfmCogvHZcKfUdORwb9VAEZBs3mKz4DIe9DzThs?=
 =?us-ascii?Q?o7oFvMyioTNMHEMu72qUKzukwiE5QKEe2IRjqFEccp5QDvBpal5nqtit6j9x?=
 =?us-ascii?Q?aQEf85ZgsY5P6VhgHvdSu/IrQ/HtaWim1/tFghNs48fDovWFWyVHP1uhpsvs?=
 =?us-ascii?Q?yL/h86NYHUvB6qGUiy4rrVxuOoImgtdjutK8/QPdyJdsayztTboUHJsFUScu?=
 =?us-ascii?Q?34r970rQDn5zbleDvbv8Q8VAvED183ow+/e8UsAB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1d874f-d9ae-4594-7656-08db99ab8f0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:32.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP7omRjBJkHe4l0WGnNNutqJrefkPMhXNXExf7iJQ0e5cxhWK5bwl916fYlLr5ckihBX02J9LLQsX63BJIv7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993

Add write access to params->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a48ca9ea55cd..1c8cfb305529 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,9 @@
 
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
+static const struct btf_type *mptcp_subflow_type __read_mostly;
+static const struct btf_type *mptcp_params_type __read_mostly;
+static u32 mptcp_subflow_id, mptcp_params_id;
 
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
@@ -47,8 +48,8 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
+	if (t != mptcp_subflow_type && t != mptcp_params_type) {
+		bpf_log(log, "only access to mptcp_sched is supported\n");
 		return -EACCES;
 	}
 
@@ -59,13 +60,16 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 		break;
+	case offsetof(struct mptcp_sched_params, snd_burst):
+		end = offsetofend(struct mptcp_sched_params, snd_burst);
+		break;
 	default:
-		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
+		bpf_log(log, "no write support to mptcp_sched at off %d\n", off);
 		return -EACCES;
 	}
 
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ended at %zu",
+		bpf_log(log, "access beyond mptcp_sched at off %u size %u ended at %zu",
 			off, size, end);
 		return -EACCES;
 	}
@@ -129,8 +133,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
-	mptcp_sched_id = type_id;
-	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
+	mptcp_subflow_id = type_id;
+	mptcp_subflow_type = btf_type_by_id(btf, mptcp_subflow_id);
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_sched_params",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_params_id = type_id;
+	mptcp_params_type = btf_type_by_id(btf, mptcp_params_id);
 
 	return 0;
 }
-- 
2.35.3

