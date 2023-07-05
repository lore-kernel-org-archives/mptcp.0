Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7610FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+5TKMVmaMa4WwfXewLeu1iRXsOnsyQQs8HBKN2evbkoON6i/kb18haTny/eaT0P+ajTZJrRePjl2sbs2Qu/obSxFzMZz3vYsrzogDWlt2iwEYY44AW0LRwY2AA5Rp6cqbne+NhQAvQIOPpfx01vB4u2sNN8o2kyaOM9ZwrCqriIHYrTj8ve+/KPocXAwNDjgC6iU77xsrCkGIw3g+eaXa9UTTLgMttT3n70470ZGU9y0sbZgQWAOiKA8ppPvYVvwEalLL5JkbZVHBaXWF1GCEUT/t+lquGXVVtDXrItwR6Ve7HGCXaOrMszwDG7OpiBx7OzwlS1Kh9AVBgEsNfOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=XyNarcElgnIwMGZARnY+t2YnX2cipmPNNqfuZXJ8waZyGgcIW153qdO6il2QyUWL4+n4W6lkO6pXSUi1HFEBJEvatPzUizZNxaYgitgzb4gyBYUcBiO/Wg1K2qglhvWtGpBm2pZIPcl/Caq+5Ic8eQwV8Sr1/FtuEaPEGmBupAL2UzBNzx2Q4s6x0Z4SENv/V87dgb6rLwS+2z06xlIwp/G64wpxdK7yux7qnkIR2z0wSjI8OerFM6Kd4gPTP9QA54oKoP5KvqKQHmSBzb66Ilvh3UCLwpyywkGAVWdA/m1YsNQccRhxofxSsQrEjyZ6jDoc2XyWvx527OZziteEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=dcmdiI1YfpoZVKaIsPuDSjajvoP9ATNHTMGTKEC1IGrw9Uiyzis20PhOA2Z0QRvcIh/Jq0EaMoPPtNUcYpKQVziSarIG0z5B1+l6EonU5ruUAsoD6ST3qvT5T/xWOaZ7WcQnLfEBNhs91OhtThSTXiOqO5f6r30r/hucclVyZvGpHpJlxt0+g89aFWvUyg68mGJewtvgmUz3QFyWEB7RW+5rfaXH1gOR0oKDC7Y8XfAV9aEAfh7EEb4RWZdb2Ed6PDlIJvMj4O5epySLo7qgkaH7LVNWbJ6ipYXq9MgSaruS4+80bSJFeSiwCasCuCxwWs1tf49Wi7scBlfd8fELRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:57:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:57:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/7] libbpf: Support sockinit hook
Date: Wed,  5 Jul 2023 14:56:38 +0800
Message-Id: <f9e4ea9606206c0131dd38ab2410e1d3ada238d7.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
References: <cover.1688540074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ac6318-5ecd-43c9-2b1e-08db7d251752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OpSyaYilUIDI7Jyi2fdAO0gquGJSPuZQ1mU0KY3u1rHp6D1OoprVWIPixmgythSaMcVkJ7Xrt/A0h+jRsjVCjFnRH1jrYe5LYZeSRhX9FvTbH7NNAu1bLG9R6J6+tvo55jSyvGJ1jkeMfERN/pHaaQIYgdxBmMxBLfOlzOG+vKKy0BiKGBZXl07XP5jFeRJbdghlTvjQRHrhs/Dwo6H91GoxFH62yKz+C6LDr23xT0oAPeTl8dysjl12a0TTXmVTl1awr2lh84iTqu13fmFVOLAoEebbL3WqTlh/MZZhnAywzbXRYK90vEcwJZFx/Y8D6ci0Wi6VVSOP00AT2xmwpILygnHMx2ESRE79VdGMiatOA6i89cgxrHuZ+rCMZJER9aG1zVwaiFiUuB7EpqbhCVM/1X8lsR4k/VoPvZHSz38g8VBrByxaJt5xAY5AfglifWThE7TmH6a8pvfeKTLkc/YRrCJHXEBLyMIeoT2t+PhJH7YDWsTZ1q6X2m50MpVbgS5UqvebQegXIogPo5GlGOHoz8XQ5u6zMfuC8fdRsllHIX2NGvNPEH/vED31iq1xWn/upu63ioTeoNcon6nBWTwKxScgdgCn0vvlJEiutyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(6512007)(44832011)(26005)(186003)(86362001)(8676002)(6666004)(36756003)(2906002)(6486002)(8936002)(5660300002)(41300700001)(38100700002)(478600001)(107886003)(6506007)(66556008)(6916009)(66946007)(4326008)(66476007)(2616005)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XsPARGl7fay9mNLPFbxuo4LDTTGIsIQ5CGfMGN3e5jp0NjLy3OjpoN6tY/zY?=
 =?us-ascii?Q?kuClPhYIR+6tXQDPkS3pp0wWzOo/4o25pXqqijj408XfmxFVlDm8qjNya/MJ?=
 =?us-ascii?Q?SFNsvPVQ8p3JR6c5ESBQk7pkAz9LOSORD+bW6hj555aumq6GXq5zSSX9h+HG?=
 =?us-ascii?Q?7vk+9yFCPqIjNLQMKEuM/E6Rr97UcFFSNHhYFpO8RtR7LV8kEbvIEq+rbBgM?=
 =?us-ascii?Q?DFa1Nc6xGcWyzfZneWIJSqbyFFjLhwtJZXyIZaUK4T0F3XtKIX+prVAohkjU?=
 =?us-ascii?Q?Q6FEMnuLyJRaWV5GzbMQb+lMTz3EG57ecRvKOUsnaMpedY89ChDXj0NbTF8v?=
 =?us-ascii?Q?tQawHazk5VdU6bpFz9UFq60220QUIKBwIz3hRRp0xgzB/JdaWpraNSyueJF7?=
 =?us-ascii?Q?jQjTcLQGqW4G9uNCO4XbnSuOAtFRnRsXui6FBcBYbSKL9QwXd0CzbWKB5TqQ?=
 =?us-ascii?Q?CJO1F7DRiFl0gfZKBdgNlkOlWKf7qcJPR51TNaEjtjv3k/jRMMreuSotxWZw?=
 =?us-ascii?Q?ETCZ09tP0G2yQ/PEcK+d6Rgmxk4Qh3o4BFZRRq1uFoqJysisBQqvzz41FhvJ?=
 =?us-ascii?Q?yCI7oVscPsATOKr/UIewMeAkeV1Mk4ICwGF5wCKhhKelQYB2q9QLvOhrd//R?=
 =?us-ascii?Q?5NLvwdZlnPBN+wN4chWycqqkvjo7roKrDo68Rmg125w0tvJOjE5W739gqm3j?=
 =?us-ascii?Q?bmTCqzv0KqBEzVWsvxwqrl/rkT0tbZRMroGrEUbbPMoFTv4STgxE//Bw66/R?=
 =?us-ascii?Q?FrHE2X0blwPql8ovj4xqDCXxzc5GVlblBLfP/f5ll279pEtz8szpwsFLPQfW?=
 =?us-ascii?Q?P89CYspISRq2LAaCx2qFljxYhpszRVyG0sKp1obn2marFlz1/NR/wyiX6wSv?=
 =?us-ascii?Q?deTinyf5YvwDxnH/RqeY6QBIXDWLeo1FlaAq0LBNULK+C66QAw1M3Tz4+/RT?=
 =?us-ascii?Q?zQqueTLoriHc26mZPfnKRkjaeUf/YwV7cPDv61QyMOUrWMO7LUSR6bioaFIw?=
 =?us-ascii?Q?tnFaNa9OH5gfzRIfkFTcFgUPoQ3xdFQPX27R0jzmpVkVEfQFelcF5EHoqIFM?=
 =?us-ascii?Q?K/z4xuQ6p63v8ol0UBqBFt1ktLPirMK3ZWHc0eNqMM1uur/ZgTvWOumIJxUa?=
 =?us-ascii?Q?4KP2X9d5rbAUGfHZ1S7HZb34Y3xi0r15mHHhVSeA4WZ+Siqr/tOnQbrhEhAq?=
 =?us-ascii?Q?WxV4fBOKfxZ5go2SUFhnU+Wf8q+0L0JYbhw+5cMSyL1ESGp+28gbL/nOUHgh?=
 =?us-ascii?Q?2SAZ8fMkFQp2Y6feShSpsTa1vBOMUc+3n4N4sYNeeFgFCQKo2Lbj92QPkKKs?=
 =?us-ascii?Q?sRILYJU6Zxa4qiYPw5q2CCZ6jvzirBEf3dR8+MSH1NZRo2Ml7TjbWp5C0QaG?=
 =?us-ascii?Q?CxlrrqkXjeuGm1ecY5bvMXocFPYLlNb5RRjS3/DuJYHj27Yn5YcY6glA3kjf?=
 =?us-ascii?Q?km2UsNfNsyuG52nmtVo8VDnLM/XcEGVp6/HcOAilHRMBbUXc6p5INRIcy6gg?=
 =?us-ascii?Q?UDCYARL0JXlcUXVF0wAJ5d9puJLz5SL8SxlajvCdKbVFeNiYXTlVNNIVMy1C?=
 =?us-ascii?Q?t9txwJu6MwDuTVOfQVO33xdQFJnWhB1mjdCUM9k9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ac6318-5ecd-43c9-2b1e-08db7d251752
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:57:26.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1quEU00pDDHI3ssHXM1JR+gSghC2MYQxBVEzDQ3D3KV78QypGKbShR19BvYNja7dicXRGdc5gIg95VPmSrAhdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

Sync BPF_PROG_TYPE_CGROUP_SOCKINIT related bpf UAPI changes to tools/.
Support BPF_PROG_TYPE_CGROUP_SOCKINIT program in libbpf: identifying
program and attach types by section name, probe.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/include/uapi/linux/bpf.h | 8 ++++++++
 tools/lib/bpf/libbpf.c         | 3 +++
 tools/lib/bpf/libbpf_probes.c  | 1 +
 3 files changed, 12 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..cb882ab8065d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -980,6 +980,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	BPF_PROG_TYPE_CGROUP_SOCKINIT,
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
@@ -1013,6 +1014,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
+	BPF_CGROUP_SOCKINIT,
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
@@ -6829,6 +6831,12 @@ struct bpf_raw_tracepoint_args {
 	__u64 args[0];
 };
 
+struct bpf_sockinit_ctx {
+	__u32 family;
+	__u32 type;
+	__u32 protocol;
+};
+
 /* DIRECT:  Skip the FIB rules and go to FIB table associated with device
  * OUTPUT:  Do lookup from egress perspective; default is ingress
  */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..03f62d163030 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -95,6 +95,7 @@ static const char * const attach_type_name[] = {
 	[BPF_CGROUP_UDP6_RECVMSG]	= "cgroup_udp6_recvmsg",
 	[BPF_CGROUP_GETSOCKOPT]		= "cgroup_getsockopt",
 	[BPF_CGROUP_SETSOCKOPT]		= "cgroup_setsockopt",
+	[BPF_CGROUP_SOCKINIT]		= "cgroup_sockinit",
 	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
 	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
 	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
@@ -197,6 +198,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
 	[BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE]	= "raw_tracepoint_writable",
 	[BPF_PROG_TYPE_CGROUP_SOCKOPT]		= "cgroup_sockopt",
+	[BPF_PROG_TYPE_CGROUP_SOCKINIT]		= "cgroup_sockinit",
 	[BPF_PROG_TYPE_TRACING]			= "tracing",
 	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_PROG_TYPE_EXT]			= "ext",
@@ -8734,6 +8736,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup/sockinit",	CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT, SEC_ATTACHABLE),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..3734fee60d2f 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -180,6 +180,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		opts.expected_attach_type = BPF_NETFILTER;
-- 
2.35.3

