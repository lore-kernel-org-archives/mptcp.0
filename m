Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30600803
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 06:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYJA8jbwON5Gq2QfAdE5RmsPEb+by4soDpcRfLdsYuqrwNnhH048nMru9rOiQP8dc8lwK6z4Kq3LkDYI5AecaBkBmJBUwbdWH/QGCHxF0J1U2/NR+RIrp1J6FvNVH3l/kyDtaf41XaQOAbSbIOdVpApX28RqL+Tf+3ZgqHrMfxWmHx0dG9HowJ7YiV3Uzgu47WO3cwTpNu7GzqaYjU+z/jn6IS89jrRaWV7Qnsrsq52sGb7IOd/LuM3v3LIGE2cKlq9WaVQ5/HDyYT71iDi3aQrXftYque3VC+pFBJHBKIBWON4HBeQTsjf/gGedNkAROjAOZ+CohN/DueoZjy5X1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4MHqDuw1vv1wd6IMHOf8J1XIGOnnaTq+2cQv+aqfpA=;
 b=NSPMacd6P/heyx8ILeR9/Gx/bJp7VCDl1bbMddQe3IW4ZWjd8EjNl/tbEGRttH8ZhkfFLJronZeOQ7p299MLvGEAkOFOy0oDQvKcY2qx2Fmaknmls27up0bCdfUzKbIoAmXLZ71sZrI1c6T1TJ6vP9xvwahCR0qK4FcVEGTVZRGgZRMiShoKY8YkPJiRULfCJr2KWEKB0ZDqPkbJn6BKRxY8d4EBMhwbISejzsHEUsUDE0d6aI1ZtzkDKZrslswHg8n5l9+HDX1FbGjn9IEXoObPLn7nInq4ml4U8Pteytrk7H8bOPDqOHSpuPa7Cd+Y5oiUPXRSQq7qspZGk3orEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4MHqDuw1vv1wd6IMHOf8J1XIGOnnaTq+2cQv+aqfpA=;
 b=Wsrk3YlQ1nOuadxlmJ9o8emF5+jJxaeKomjCDqlKR0voyRWnD3yxaX+MxRZ5yVr1gaSBHwFBPDpH+52niPAMalFY38bsuWdJkF2jSLh6kUtwoD5QeoKYP51AYPhMjfFCxQnL+7WOWON+aCeaUX+ObhMRRj/LRMA17pzjeOLkbS75PpxB+n7vbBhal2PlEog+2a414RyynSqRxpnFXz4i+bOWtoPGLAKH4IYu0mlDo0LqlEQYHcuPVRLm1oxneujim5OH06nWei09IURIOu1PYqYIrDXsypy4OVyJRAtqAmhzqWFVfeG8IQcHpu+Yhvlwn/4fWn+yb1fpOS/AD+NykQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:40:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:40:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/5] bpf: Add bpf_mptcpify helper
Date: Mon,  3 Jul 2023 14:39:58 +0800
Message-Id: <d746717840dfdcab3e4d8fa710dfaa3958a0ead1.1688366249.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688366249.git.geliang.tang@suse.com>
References: <cover.1688366249.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b2e022-1cb1-4b12-ad43-08db7b90601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	myUmaL+emR43HQovAXKato37cxobpVqM3wgE2Q1SwnZKAHpnGPcJeBxQiUzi7uAHS2k/jVcPMKorUNbUFLwKPEvVXnfWp+OYnQ8XfRvPw3ag6n1TO6qm920BWYMDgsmdYA9BrP1bIqkLGQdrV0xxqNVkVntaBxeH7XwuPmkC6fbOA2GCk3ms4qZUJ5uhhI/lNu+e0HJBlg1JT7IVAcEtt3jxKmUGb/0X5g5N4EpOlsUtsMDUrN9QI9BVzvEeUKmBiCA5be8iLQ4ybcEEjtGCYXInVXGoAugbKkSjZBiE/ig93SDM0kFP5W3NByaOxGtLczX/VzdPtXQBHimXPEpaMb+OshmQnmMcLJQpjymM6QYuHklCTtoI5QYLbvzy+CAYDh5tQa65rGdUl8ii45zSD5pJy2DoBiEScZ/mdA+z/RWR+eLH1fphmrQRxiFs+qkIg2Fjphz9xBwRE/jUg658KEkbzKIbOlgAOS5WHT6frg4GVzkphEtssypglc+Vq5cAUsp7LVvyk2sMGrjEcyCVcyE39MMZdu39R8twpR6h3R2xITuXws/wStOmbknsQzQL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(6512007)(316002)(66556008)(66476007)(38100700002)(66946007)(6916009)(4326008)(107886003)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(8676002)(8936002)(36756003)(44832011)(5660300002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlWhhoUQVGpKNp31Vi+pAjzYxhqupVkLPcxHuY2u1CdD0w/3mRNBS5LRUlcB?=
 =?us-ascii?Q?Q/3bNpwcjTuFjoYsP8q38yvuWIjIUfZ8+JiZPBvO1X2LQufcY2s1ZOjoNTBB?=
 =?us-ascii?Q?LQ5O3FG0pNk4/9l9fESG4wMZgMKkFMIKrjHthYXMb1xqqFTfu8TWCWE+kCJs?=
 =?us-ascii?Q?k9AAvwXDc62G5lnLzuPhdCL6vP9dvOTtj8XGfuiQAN9wcKlt9ciPWhouIRsj?=
 =?us-ascii?Q?6P1tHjuYEs6JgE4xSPocChPnwWvLIo3wsY1lXZQAmFt81V1Qyw09U4SkYSPL?=
 =?us-ascii?Q?XmxOaapm7D6kDkwV5feBVL9i7QVeZiblApig611NxTghiRtWH+JIkX8JOD/h?=
 =?us-ascii?Q?VVSZ7c+NKW9WnlbLklLGgLgfF7Ul3iMmBNvDx2lyVxtnJvVQajXKoZCHUL0P?=
 =?us-ascii?Q?LHd9SutEJWPW6+yXBnNMVjRVbmJZrufZBngYECsOz7V5jfU6zGLiCdsLIP90?=
 =?us-ascii?Q?HEwJJ24kpOuh6urhOpwvw/jpYMhXBgftaUphq5XUZuBenG+jwK/kTzmzoxxr?=
 =?us-ascii?Q?nwjFg/KVJZvzgDXq9kmHuJVMQXjkF2q4+n40aaOcE9KkgtTTqrft5uNQqy3p?=
 =?us-ascii?Q?2cq4UhF6UGMW4xVrg9yeepIbGC1XOrHWlN6fuaA857gqpUzqwc/50nxssuZJ?=
 =?us-ascii?Q?pmPqM41JecmeWBJ75o3tdNC6Twdzvne4hdGwsIJ7Yq4R6Cxr84DoIGmygTAt?=
 =?us-ascii?Q?9zdv/hjRlJHBKLeeZ3LMTb8BBCnbs5w8WFlu80sXcH7CAu0O9zqFoAlXTIiS?=
 =?us-ascii?Q?DCdqcvWXa/84Ss/x/RlBqD7Er6SuMoK+vg8qjdCbwV7doWHmvIDbesDGSbdt?=
 =?us-ascii?Q?8eOQ1ta50+8B0CLcsOAhyLwa4Ste28mHfHg9mDENlzXXTDGciq3AVor0S+Kn?=
 =?us-ascii?Q?uplZ4mqdSeFzsW/nEym24Xb4GWMKsdyoA6cjf1zHQl+5mCx0VNDUEXNFenx7?=
 =?us-ascii?Q?lVUbOOB9DA+s+HwbV77sBh0A7sos0bPR1EcChiF3CtwNdUzsPp/Sq4TV1l3E?=
 =?us-ascii?Q?K5qBs2I2FJxyia6x7+uFREI2/F0BFL02fKahiAJMpBLYyAEpsCgEw94qdbGC?=
 =?us-ascii?Q?n3IrqWbXlgovCWlKCb4CaNxI6CdnBZPIf55L7mmly15AmHYObc45u4ugfVtj?=
 =?us-ascii?Q?aA1LLBQapWWSMl1JxrkNyIXrcCs0HrxIJUt7WQekntG+DWLxJPMfryONebZy?=
 =?us-ascii?Q?Y3DQZ7n9qiqPzCcko66CKdYSFdpRG+wpwBe+ix5HmKnpIGOOHlMUWE4S3mU9?=
 =?us-ascii?Q?TvxhaHUGqggt/Tqg+w9lNbpQgKaSJfOTgJbwYNeEOwiBBGqVao2xYr9vuXzC?=
 =?us-ascii?Q?ciJYHIY1q97PKDNrp1TSFLzV90TZ3kH32weNDU8wxjwQ7hlavI0VD6OYEVVQ?=
 =?us-ascii?Q?wryLTxrbX6Qm15w6CxoHR/NZwJx8oJ/fgpX16sp4kJSDhbERa1e+E41X9KLj?=
 =?us-ascii?Q?ImgljikvpaaMWqoBaeb/BCW/Vr4K4DT+cT8rSbrB3p+J5nlhS5hPozuqK2/e?=
 =?us-ascii?Q?C2WIoMwMVHj1Iwt3becW/M2RWNdnDXnSH+TPBYWjia8ZkqJSSE1BlbfQIgBu?=
 =?us-ascii?Q?cwbh5hIZ8ruZPJ5ka2QWdV2PBUJm88wFYkI/ICx0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b2e022-1cb1-4b12-ad43-08db7b90601d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:40:22.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbMTLcNKdZuTcTFoe2coNTkOpERCqkt+/OYWVaK2+Z+p/3WRJl6UEp6V6LVrRXDtIw4GoXMhV49MwGB1jnTsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

This patch implements a new struct bpf_func_proto bpf_mptcpify_proto. And
define a new helper bpf_mptcpify() to mptcpify a TCP socket dynamically as
an MPTCP one when it is created.

In bpf_mptcpify(), if the protocol ID of sk is IPPROTO_TCP, set it to
IPPROTO_MPTCP.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/trace/bpf_trace.c       | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 3 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..0fb8222964d6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5573,6 +5573,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_mptcpify(void *args)
+ *	Description
+ *		Dynamically mptcpify a TCP socket as an MPTCP one when it is created.
+ *	Return
+ *		0 on success.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5787,6 +5793,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 03b7f6b8e4f0..272166e9689a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1886,6 +1886,27 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_1(bpf_mptcpify, struct socket_args *, args)
+{
+	if (args->family == AF_INET &&
+	    args->type == SOCK_STREAM &&
+	    (!args->protocol || args->protocol == IPPROTO_TCP))
+		args->protocol = IPPROTO_MPTCP;
+
+	return 0;
+}
+
+BTF_ID_LIST(bpf_mptcpify_btf_ids)
+BTF_ID(struct, socket_args)
+
+static const struct bpf_func_proto bpf_mptcpify_proto = {
+	.func		= bpf_mptcpify,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_mptcpify_btf_ids[0],
+};
+
 static const struct bpf_func_proto *
 raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1936,6 +1957,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_ptr_cookie_proto;
 	case BPF_FUNC_xdp_get_buff_len:
 		return &bpf_xdp_get_buff_len_trace_proto;
+	case BPF_FUNC_mptcpify:
+		return &bpf_mptcpify_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..0fb8222964d6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5573,6 +5573,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_mptcpify(void *args)
+ *	Description
+ *		Dynamically mptcpify a TCP socket as an MPTCP one when it is created.
+ *	Return
+ *		0 on success.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5787,6 +5793,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.35.3

