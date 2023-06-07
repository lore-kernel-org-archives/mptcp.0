Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F84653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1gTD+8i6MDMqZXk4y/5RmsdML8CXLmiDqXbCjdxJhp4Ddb8BGhqFplDFB+yj46uy9G9PcOpeFtRDQrSE2Ly4ZLL3u5FRRV3nbuOxnLcyqfloppxmrCoXeGK6YJjl+RIK9moTv91f6EH3r3s/iI6vnMigx2q4WgMsjtDZ84Vc9V/JBa1Op1zjn6wa+77rybuwGeVshmYcRDctIJrAboIWIygp0mRW5ZWwB8jJnuKiW0FLatEPWzUV70S7dqDmiK7KWlC6sUBMM4SZjJxmN37gmYlGAml4kwCVg8LAU+jyBkeeXdwVNNDAoa1IKcAK27ZWyDVSpTEsstX0s9ZvtEiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ColUWx+jPDzcN0Yy+5AQqn4KnR0IgWRnIS+IXJMrq6M=;
 b=HgezxbEtsarViakq0ViecxR8OsOtTv+So5teoFVpAl3iBg9NeNWGR9m8IEZZANBUDbKPWCOglLmrpHkF8pSUnenooND4H3VKtX5st1skLEWGRMTWlQIfksX9Y5AiVB56peYCmGWoAn1LJlk0DROAHjZZ0ar31KkdDycWYYz1JEwq4VCvemmKwi6fgvQ1wo5bcQhkEWMh1X8O3SD+ofDAl5vClQB1BK1+U01Hxa0OcOklXZWm/MjVKRoTOjyJ+rIvPj6vng/FU1p+2emIHNWIol9qTGc5MsMQgT/xynTr0c5zPrnYuHXSxp3CRcku7XZFEpaymlgF/HRLA3P/tUj3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ColUWx+jPDzcN0Yy+5AQqn4KnR0IgWRnIS+IXJMrq6M=;
 b=zSlE9LHbVEtMDODRD4JjgtUIDS/37A8fG5kFbc5w0hVA4oCEt4ZSgFvxcJtyhqRG8Fvaqo1wcgNrMWkVsXiXeU0iZ2QSYM5lu2ueQYby4ViQe51cmhBHSNXisGbvrOxQZ6RRzsDEJW6HKYMkzmRE2JN6u8Bd760SGEQW/ZCvXxiiV4vZX90ISBJvlBw2Tzt/fyfG9SM6c3v7ApqJjx/xAEUN0HrzXXEVLqfEHPUWKOi6AisqNnaZCkeuIsVbwLgJ+E6G6B91nhlkaAXPmrRXkA4sNLF6LWy3tLwjxNJGRCjl1vGzfnapIfiqfFGa2LFlfSQ/cP2uciosK9IJzww36g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:40:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:40:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 08/19] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Wed,  7 Jun 2023 16:38:23 +0800
Message-Id: <b38d45733c9e8cd62097638a533b6268da501790.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0268.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fc19c4-9b9f-4bb0-cdeb-08db6732d1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XvkPvoOxwB065Gw+jqZPFXXq6ZhhNuvr3eOps/zRJcw2JmkiPb2kD9M74X7iqBGXBpMX140yy8W+fikBE36hrQLYXr8p5uL4nRndDT2l8gDyu2bSmPlKpFXVbuyCmQpPRJE/JyhiCLQ2lk5Iw6rO3fLGulS5tzge8Ka3W2jCSWKr2v3QKNpXsU44P5Ga9J8hhGS2ZKMBkkWxXYFk4Xz5rmQLYQfIaojMKT+2uXAIeM//+E7XNojKUSsqG43nklsjDhuG4T0vL8TepfYnjExLO18AJHYSWWWoQBaFGw2H7uap8i7gHACt0yQ6T1v/j3rTe1WamKB/sF+kVAqXm0REcITodPjUywncqvereAoEJ5rXK/RVLWJgG3glA+qJXYH2ILLNaf45sojVrHOnqMeQMtf2JnzJnQKN1a0sOOA6sm+GLyNmZ959UY9N874XwbaM9hMFHo5LYdmk1e3jgMyJHkJfcHXlb5oboZa0wR+vt5GUt94kE2mUYY30Zadrpt8SdWaAc9/4Cz2Xm+gxsUsS6ZLvTCiGZIvP9hdLrGBiY/SJbNPieTGAJ9YDZd7HQQmG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(44832011)(86362001)(6916009)(4326008)(2906002)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(38100700002)(8676002)(8936002)(478600001)(6486002)(6666004)(186003)(6512007)(26005)(6506007)(2616005)(36756003)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?infHvPl4KOF319Y+KKcE587HWAwyWeU1sB9Dqom1xs55DxFS9lPdszLA53wg?=
 =?us-ascii?Q?Z1kXodVRKTA6FS6v5BZ4xEXhzLHPfxr7bjP3KXMrgsdOwK3nlyMVe/beqkbq?=
 =?us-ascii?Q?8u54+OL+tkQUBj6cXh/Sh1WJwVBaUqeCgZgqeThOhZW9h2/rjxW8fNyUrZGk?=
 =?us-ascii?Q?fHvfB5RKbUphLhVl6Z1q4TGxkIESjbQiNc8pHbx6x8/GgmymBExeiJ/d2Tqw?=
 =?us-ascii?Q?VLOL5EYYRtL3rJB77YwsqjgxJ2A/IZBTEunOIavlOxWzBNG1zTZNPL3BbrlX?=
 =?us-ascii?Q?UyYGH5OihVVIJ2885wxYy4AFFAjqKedMfRa+ljZxpjj+wI6oRN4Yv+gjUoLG?=
 =?us-ascii?Q?4lpfKbCxdoyQ/HhJxZWlJCp6Nt2rPuIaanCAtFE/utQhVka/k9U43UxBRsc+?=
 =?us-ascii?Q?heeub0QysY81U5kM7bin5LUGqF9U284hEGiXGmFbS6lGjhqKSuwQJChdrEt5?=
 =?us-ascii?Q?FvwNpcRIklOJdAtBwvcwfWclwXSRxalRaXsBycHmyeZ/Zxk9d01AqJ8DsjoN?=
 =?us-ascii?Q?mIoHJ4OU8n4YyDHK/dGOUqsyocaUxNqaSonSXIvGZuTQSNDVBq6/RlcIMgR+?=
 =?us-ascii?Q?1RKx+b/MYi3pa/CYy6BCK7USPniQHi5dvqUp2f+GIAQPaKBGCNQhPWdxOgyd?=
 =?us-ascii?Q?3rpENF/g7Rk5QdxhrASJtUyupS3Dg+xDmgp6Tq32kvJ+xiInpz/l4JA39JHG?=
 =?us-ascii?Q?n6TGTXrbmEJeAPpesyGp6l4iXda4bCDI6fRNYlPaEeu2EBz4YNumZsQSw+S8?=
 =?us-ascii?Q?NyRxRMYMeKD6/RnwR7h+ixalN4zgap3j4EgKGvucHe88A/okScv/GX81n+ev?=
 =?us-ascii?Q?5uyfQCvqt1UOgEZz+JaYzPLIu8mmUv+2Xu1Eq6twoJGEQWtfQRqRPu78DGDq?=
 =?us-ascii?Q?Cd1EHqQH6oMBVJKpOx+cKo0R6TmuHcS5N+oykjHy/r4F2Zl3sF127bS609it?=
 =?us-ascii?Q?P0uqQjOYnR4vfkzvbb+R4IXECUCxElo3k8FhSbM6Drful38v7sPVvZHGMOjK?=
 =?us-ascii?Q?ZioSxdoGE8qSP4LC0hf+V2mtaApwPFnQrApEVbBdLFa5o9NRjcQyi1iuhfvO?=
 =?us-ascii?Q?qHPuXhV5FJWudAeQb8bkESH5D+k37aeo0PmmgSlazEEX/Gr9hjrpkjZZOd8F?=
 =?us-ascii?Q?xxNH/SLEaWR4FyxzGkKVmd3SOrtMHuR0DzBWXc0Eh3THmuAlTCIv9Z8V2cS1?=
 =?us-ascii?Q?9IYy0JRYoql0lYBVDO/otJFdQqBIjx4YrFNSqqgP9RYU0sgBmwGJv8LLhgyR?=
 =?us-ascii?Q?tij24UEQizFfoks2YWqT7u4cyj1RJGAKFMDKrTGi82nXe/tk+O5RQ3NfUjf0?=
 =?us-ascii?Q?2Ap0D6zOmGrG//2KQBJtr239B2tJd605BWWvKp5DiCpuppdmbB7Yl/xJeAG1?=
 =?us-ascii?Q?m1axGXtpuLi1jxvnoqw0u2VTAuMU3t03EvXQ3tgRhggFmDHw1rpVTvEVOdvL?=
 =?us-ascii?Q?+AtmaGZDS6WdxsNRB/n1jvQ099lJUIdXLcSN9WvKncVJOIfE2J3CZIQ2biJi?=
 =?us-ascii?Q?8HZBQ1v1/Mct9EoLXOmXwD4BDS+eObbaleZsM9auWKrbbhIcjXDzsogm3FVl?=
 =?us-ascii?Q?kPzI1kCI6S7S/e9KTLWAT/s3b4v+wEswf7Wxpqq7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fc19c4-9b9f-4bb0-cdeb-08db6732d1ba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:40:16.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FkpP1Z50FMM7RWzXw4QM4yK+/FxgDYv2RvBdtb7RaDCQ2tGGDbMCPjik87/8/g21colY5Bg5RSu7kSufx/LNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777

Add struct mptcp_sched_data write access.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..e2ed4223617a 100644
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
 
@@ -50,14 +51,18 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_sched_data, last_snd):
+		end = offsetofend(struct mptcp_sched_data, last_snd);
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
 
@@ -141,8 +146,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
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

