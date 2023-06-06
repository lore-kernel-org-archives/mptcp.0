Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A128C07
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMSy6uO0U4wN76PCNtu8qlTS2Oo4EaufvyzU0Xg04F6EmfF+InWLRXBvsofGfLeogBBP1GBprWA9MFyJdu2wklKAXD1QsJ4SU5ZneJ9K1buxHy/DtRiMadWUD2+53z4SB0yFJC3C6W5QdOFmosM5mNQvGK4HsUc/AlJzs6BQS2suau9KtQU7sKxdykDAWIeM15VVdE2EsclO9WI1CWze1JuU5u9syv47XQmUMiS6igTkkjpdwp6I2PrstnKLr82ggnnIxZLmSlANfQGpIEZxDlAkxbLpNaF2qCh3HgRexHBDBsc+4JDKGwHVN+nd3ZO4CbYbkIFbkGcS8yyVHIfUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9PI2sV7MlipZTri3SLbscvZ4LbuFBwFaRdlDVp8dUE=;
 b=TzA61beOOyKW8JxVB5uSoOOZMS2TengklGWdLigf/WgDKOQHGHStihaE2bxkkImqTUJypJpaIoQPXS0KBAPNX8mkS8Jm3XoiHDTiYE2i/xS3JjiYbNOOCv6SKtlufHjHKQnP4PTdO9czN550VfDPfjXDU4REM8+ATwsP6XSTs8zqlublgkK5E1SIJQhZDdCmz+CVpNFlW/TIYHAAG/mCOSbztIzTgRH3dUz7ORsLLQG4uF4Arrm3x7fTIRXDIvwBSS6we9sdtro2376poSN5v5EozNJ/CgVvoEIpU0Nz2997OBYhoZeS3ZdpkMbgvF49ZPFl+NA8aMO4wIYmxtKASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9PI2sV7MlipZTri3SLbscvZ4LbuFBwFaRdlDVp8dUE=;
 b=uS5K07WQcHrNJ3mc8ddF6upEvz87/EoUhyiP7sgrHUYnWX3yfHUbVTB9w31TIrLIzqCnhM2LCc/2RJjJRR8LRkHNsA86jRnUD9MkxiEXH3rkAWCwZEZ7KwO4wOjl1Ugao+33M5gduLAICSXvonclC1oPbls2jAVxrC4V04wiMzALaWu6hslwxE1MgfFQ6Fnko4S2ReMqiUuUJna6Z2gi7azDXum4j0fO+LyNDIvpK0ghUJDitvg8gPe5axIwQJKTkFgw8FJe3DqoPOb3byR/0isMkA/8XE+1EHjLVtDtHfsmgV9RZ5XKTFx3FkfDsEX+FgofhuMbW1paarW/PcPY1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:01:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:01:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 07/18] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue,  6 Jun 2023 16:59:21 +0800
Message-Id: <2cddd5e32bd51d68d30f7196acb29f608de45cad.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 50103cf7-8ce8-4ad8-05a3-08db666c95bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8FIn3XbpcKbd0pr2u5weYEgOicZuzqSy4CMbvKtxRKKa9so/pGp/IeZx5qaIG4vUf0ztZ5qNFUH7UHiAEGbbWgCOxEhiEu1958ebqtHk0OJJQtK2CfczLq9Nyn2XrL4mISf8ZblHR6m4Eto8u9wIAvTXa1tyv2Jf02Po3V1Ol5GyRyi2EdBwosanj0E1NfySTKykMHzNqU/x/D7vcOxoLbhV/qI6FWinV4Mzh1Lbb6o5ujVr/qhloSIxAyknt9czsp1Cm4LL+yQcvXEKpxuTw/E3aZPYllMnnJmMm2qeNAMxw3n/iwHs5fF4NwagT5jZkf1NgdmvXI+X3bjYJGrT/k1GjpRimswo8hhVCoPR1izV3meKoKg33btoDGM3LJrli3u6OoQod6vnf9/5m11hls3cn9nI6U4t/F4xOEDn93fkUkAZJ4VUleYWzv1dvcGN86INAOSAE2gSBIuNHEnwzGyKd6JhJilmTZshuqs2zy/l2U0ud98ukQ+r9XTbTctT5uShHB2nMBYBf3+EEZNcQNZo03PoXr3C9zRF+nsVZe7QwAfcGTWEDslrqvGWACJt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yys0n2WnF5czCHUCzDLYWoEbfn8Lt158594iFJSxF+v9OuOuQx3R57Y/GUG3?=
 =?us-ascii?Q?HaI86IQJBODFRE/B1fZb8nXSftHMEolfm4EgYBI7TiCPz9HXnlQ9z8Vnaand?=
 =?us-ascii?Q?TOQzy02F+vAajJx5wQksq2+G6kw8WYYaIdfUceSglqYMQ5rqgMEcmrBfK8w5?=
 =?us-ascii?Q?plfsvoqIGUaHqvLTPV2hV0d6ZZ8B0gHFY6b3HPQjIL3IObLd4NiaGzN22j3A?=
 =?us-ascii?Q?DzYllQTvDg1tlJU5qUtkBfnZxKVMkgY+EAWzLzC+8sK8cA9Eaayl/MVIn3jS?=
 =?us-ascii?Q?ONQivhykGFWU+DpJaJMxNA5kXYi7CBtgi1ZGCvJOaTeMQAGMVnsEmV56jTtA?=
 =?us-ascii?Q?c/oovCuPt8JCv17mC1/qV/tORqIFEo6z4fGyJUQJb+nW+FiijsidjGcpL3Lp?=
 =?us-ascii?Q?hFh905eYVV5qRlqtf94T6VnusdFySywssrDvM3W41LOF66Bu+h32yrAM43gu?=
 =?us-ascii?Q?g7CbcjoMWSgiwKkTM6CpD4RHDgbveMpNlVCTkcXuV7rWhx1GtwhP5FN2GCit?=
 =?us-ascii?Q?rKLcueaoVTbts/WlvnW0r8Vz9bJZ3m1rClxFQiBJmv3IyZOl3dEijDZin+Z9?=
 =?us-ascii?Q?JxwAmBZMCw+dXCtueLzlvCmFQkLxjEAFC1S/QTbFOhKv2mUeNpDTvsnlOvTf?=
 =?us-ascii?Q?uyGZts4cr2wNEMayF2+Is0x+KtPp5AB67XKtnACiNlaCqK6EiMiJF6Kttf4r?=
 =?us-ascii?Q?NWF2y1CnxSS4v8PfvMo6mG44ZU2LGad9taH/zFk8dy0/dMycUrTzD0vNTVTJ?=
 =?us-ascii?Q?LD8yaF8LUbGvr7TwjJUgDWPsytO3HrUYPMkhd2wyqw9VQDDbFURn+4Vu/Two?=
 =?us-ascii?Q?FA4oxnVj3WTx8WkvD6/yqpONdamlURwXCFvn13ykrj6jaVKjmcT/PZhrstdB?=
 =?us-ascii?Q?2BBQrG6YAlOL7nzSHS/RbMMdKgPm+Djs/3xwl0JJtc6l61wGAOUlP7VTc18D?=
 =?us-ascii?Q?upH3/CK33VMxcSn85pOu68/RetDaFy+X/HR8u3kAe2ruNj5BXiFaEZ9qvLtK?=
 =?us-ascii?Q?0vwYyBaaQCjcMFg/1iNBE6mQ5UNCzs3fYccXuuPKwwcKU0yBlhBvEVIj6M1B?=
 =?us-ascii?Q?7UF+0wQIfHnRHiru2dDyDhzUj9j+D4DrX64EJbS4iIkwnEZz8NV36VypvKyv?=
 =?us-ascii?Q?t7IkQf7YRQ0wfi1aNNqLNT9r19dKTJ3QDhJBJyxiA0BnAkXYg/h9F91hXsEc?=
 =?us-ascii?Q?PwlbpfSTV+m81QLDlOS38rXlDO4I4Ju675VjggRC/7BFS35ik42yNVG7itIV?=
 =?us-ascii?Q?LO/8VjJbh92Nb3oEEfrxXgc+rjJqlDZIgHeZahz8dYxBUKtOhmZUr1LS7KQ2?=
 =?us-ascii?Q?7qNQJw31L0a16+VKbsqsY5r0hWZDjIA9Xopzg38AR2YvTz8FYi/KXNwonN6E?=
 =?us-ascii?Q?3kyt4CowkNlL4lS5eCAYuE4XcUaJzfNyrfW4rVYhkh1Js1I+yD8xaChvq+jd?=
 =?us-ascii?Q?DSNs4BEs5F7sglc4DzmA+aGtNIoDPsKLM2B+xawsi26GgvQZy5+QITRVtjmI?=
 =?us-ascii?Q?DaJlkaDBrnenvZu8+YjOBAdF2qDXav+X1f+JOz1AqKlHaqM/3r+yqwxT81W1?=
 =?us-ascii?Q?M4fIXi26TSoejL/umt0hPEnav8QQP9oQRKhUMu2b?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50103cf7-8ce8-4ad8-05a3-08db666c95bb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:01:16.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzt+yktjh6NDR4gER8gnpS0HvL9S9bmU/7Og11OrBqtV97j7jRnjMWV1CEnzzLGdxEZWITD/B12gcpGhJ2LxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

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

