Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAF846A
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB+bmLv4bRPBXYn3NOr57wUsjI9Vq/Rp0ILDpd4KeX3CPZTbV+dPqpNen+5JXPonjHqgH8pG4XFhZen2ZtKEx5UdZBS+c28Cmxt0WNmhA2d6v0IDl0EpeLjVgvqqJZWOaY21mz+t4kayjlpBlrB1gNrRtVAZao1Ij6d110qp34HjJM2iZwec1XSL8WkLFu2Kk2ir2SUkL47V0DDzlcmddp99O42Ls1v6oo4qUTsgxzsGV4UQJKZ8zZd6SzzRPQygcbrXFKPpi9KL2XG7XVvEXTh7Up+ujH1r1pIFYbIWLyP4YfNuICOKJQb/jOwxsPEMZTf+ALblR/G3ItI6D9YTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTaadbgsDurl1aPLU8yi7InP8nKoZ3Vx0VrIG2rVC3Y=;
 b=VTLGc41rw13eqX4yMhavhVm/7mlX0N3oYerDdOdm11AKcZVPuvO6xyvyKw49ym/UGpE/dkr5V8J+QUeGXRmpnKlybFfbdzDXMmUcmXjc/8NOKXmqm9ZlIrUe3EvMNF5yJ3vs5RyiFHuohdtuB0n4aYnxH4St5D9TcWKWWv34s8Fbr3Ml7XuTlo51Zk3qAqzg4SUphI7MGBP3/XnyNQxbJDjRAtwJKD7hAFljZmVWXNs4zaqJTEwlVWa3SuQSA/WrEXdEv+XQfQby1cBHR6F/8KW0cokOhge1CQyUAkU8PggCxCMi+1+GnpSgfzoJ3IRgtIIAV2xSdlcDfM2k6La9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTaadbgsDurl1aPLU8yi7InP8nKoZ3Vx0VrIG2rVC3Y=;
 b=pgFLzj2ZCa4r2u75ieHyA5sK/ARltvmY6MP/F0aSb+5tvYurMeyaTLhKgIhkpbRGxoweWdYXLulpszN/SHKq86q5s6I6KGF2GpwI7lIbIUypeX9dZxh4DHZXy/spDshmkENcKiF/ZnkjuJIpZH2YcMl96wLsc2JPTCRDEWqAq8cup3dx9Cbd30sqmVE9OIqSW7TYtC0byYFOVuxLF+m1f2Qhno4F3MbWGZzzdLP/JTLgk9Aqogn3jU+Sq6Dtd74d7dbADqpvTFKpK0zSo4qLKoUO9uPcN8JfXyQsUT8yl/c6y0Qfy9fMn4dQQ/LK0Ay+4a3i1/EfOkW7gEFsBdwsZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 3 Aug
 2023 04:28:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 04:28:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 6/6] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Thu,  3 Aug 2023 12:27:22 +0800
Message-Id: <4f65c2b44b82e8682abcf5c5b91dceced0f07480.1691036765.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
References: <cover.1691036765.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbf787c-5def-416e-4546-08db93da0714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z5oYJk38MHv1j8zzxb5dg/m/Dl2uDDV7cfsyTCn+QaArOPz4Bjhm8r24D77LaHDTgAS7pv69aYVK9MsM2psRQOZ/Hdu6/S3Q4qXP9keGTx/sAKakw0x2frPZgXXIjHxdldbzfR3ulBu9rWwv0z68GEk5SGe7RANNtf1UHKBoRXfn1vQ4D9dQdJBJJrSGQOwoGimHBivk3MKLUumLLha9f4xQObGnF52zLPdqQhy8WWFArO2LJ3/B2WJUQM9Z2Px8ztuHNDx7tugwp37hZn8E5Rqc0zZhT1iYwJEfj9Bc/XKv6Cjt5xpVoWCBCwWPVROkGZ+RhBkO1+98cX1uX12JbFg1q2bfqMjrvTjepJA7MGxj0/8vOBo5AwSF5CUsYumfZmDktIDSeN5KYsL9oxQxogEdwl3zM0x4P+AwuUeoj9WcjQPvH4A5Ssvy/VW7/dvv20LB6CjsasB20kUAO4VcslxJbJgiMGogUC16tBq0yqhEDOcLC6UHddGf/gbvSm/4ZidYV8Tii+Qm89hSry68Q/vlNXoQ4FjyoNpqxse5MWIr0jbbymkCRrd4w/dyS/yQpvIMv+kzJnSM14ATR0F8wuc/nAVS3LvU/yeO/03dKnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(2906002)(478600001)(6666004)(6486002)(6512007)(36756003)(83380400001)(2616005)(86362001)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(107886003)(5660300002)(44832011)(41300700001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Gt5I8bBydAPOSi8MMsio+xrYXU4vNPT+zYZl0dGxrhT17/QZfyZHKslQN9k?=
 =?us-ascii?Q?NUrp4JKBEp2/xLuGB+am/WwVGNKXkkHrcK8UnFzhz3QPc2I1CUe8NScWavSk?=
 =?us-ascii?Q?JyHX8jLoAQfhKFsrN6MvWZ2kbWVsOHWA3yytTWk/CoEvk3wMN7ZGZWby/QjR?=
 =?us-ascii?Q?XQ4OogGbL2c+rPi9W7Z/Qq+ml5cvhe1V4RDy6HfVixLbYOJn6f797l1WF/yS?=
 =?us-ascii?Q?xpquZkWsUdd7jVgAyDURvipOChT8zPq0F/QcW9d8KwigVMa5MWWO3KJFXS93?=
 =?us-ascii?Q?o2/n8gy/gGwte2xi+cX3AWD9thn2PO58NHZfNEBtegMcmvLQfAciQFCgVClR?=
 =?us-ascii?Q?1hY9A2L9d0QHEEJWjtLSyRZSvfWCu0+IyOLfLmWMjKrzcJNbZmjDGKR8H3LT?=
 =?us-ascii?Q?ag1VgDBe3qvUQzAl6TU+TCLt26xP9Ye0X6C73v/0rqQFMtXyXI2WbiYq5PrQ?=
 =?us-ascii?Q?sdTkILzs2HYaRsFSDkOT2G8arBLH2mQW8seeMNzwRf1TgYBMflm+XaDy8kyf?=
 =?us-ascii?Q?zazhfqxE9DnNEE0E7+4twmd6OSzhG0iqE6FywpzU9zpraMfpjKFgY1GXLHiP?=
 =?us-ascii?Q?2Z21cc+DDwqPmubSpIHcM/njsinCZeX9swoGF9i6Cf3chlmHP58rkFidZvxz?=
 =?us-ascii?Q?jf+7oLNoVP+8BC91mvWo/e868R/FWaKftFPJxVNS/UbcAJPfMcqELm6ZHyRc?=
 =?us-ascii?Q?sA6IHgoWXNNE3MWXHKkfdNZGb0fzEKm9oef3BRP8PxBX7zBSkXru8jOvOGVN?=
 =?us-ascii?Q?v0j0qpH3W09idapQwiRHVM64qN91B+zWfeAR52PXzFKQ1B3n5VpGkudi7vu3?=
 =?us-ascii?Q?8IC1reMkawkEl63B3tju40epuyVxHreONmzLm7wN2hd7ADEHU07LajKrnpk6?=
 =?us-ascii?Q?PTCZLHR1FYK4Sr8FxVep7odmHzH0+GZpolQDIC9KHl6b9zRL42HU0uVmsSoX?=
 =?us-ascii?Q?79pGZRJwpKf4qxL/G1puHZsJe9BkExqaGlyPhcf913V6ePr7opzXtatFfGPs?=
 =?us-ascii?Q?Qvf4zn091CJ18rdRLs7ID3yLp2jFTGIOlm9543j/FW5hzz6HIsYk/fmWv+gg?=
 =?us-ascii?Q?kCtij6eFz8kcFhWYakQUfalbD0THvUy0CfhMzHplCX3W69QmDZU+ftA7QJSq?=
 =?us-ascii?Q?2zvl7P5i0EqQJne2bavvV2qW9n2BxlmklNc47uSSAhFz53Ylg/r3ctpcjZzM?=
 =?us-ascii?Q?b2r2cf4bNpnYE3pyUIt380q2ytaJ7OhqycXp7ttfST9wubyitzLjeRHTbFMM?=
 =?us-ascii?Q?MVzswlgcwuqQbMbuTdLUPUIxWy7ChedSXzdIkN5ed+GX+y4WCUt/ORtpV7/6?=
 =?us-ascii?Q?4C12OVQaV49m6pvoAnDkAo39NqvVSPXszRfCkHs8y9uDYfpD7Mahhh/E6PbJ?=
 =?us-ascii?Q?XWtF9jxH8ZHxtMSXKABTGax+lEBdY8rJ85fUxnVFYpITpCDOUKRadbvs1eyW?=
 =?us-ascii?Q?0NvpxOtUQILibq33sY15PxgZ+E4wUbJfZdRRPCeiNOM92iZpeMBsOlPr4/hb?=
 =?us-ascii?Q?ON61wNGP2y6grSyrkbdQV/JtQceKg4sNz27+j8DDMXC5v36vkwa7eiqnSBLk?=
 =?us-ascii?Q?4nX1Hkb5Zsr8zDPtlvaCXPYZpSWADWLgzg/q4ExMGEwR5pRqqmYgePb15r6r?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbf787c-5def-416e-4546-08db93da0714
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 04:28:03.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db2gVMvIlVDYj908EnQpfc8TGjM4Klt5ZQhsBTaxo9ju1QHapnGCmTSl7nxwCRvEZNETSK5pBeA4Dit6RUGKrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Use __always_inline instead of inline.

Define tcp_rtx_and_write_queues_empty() and sk_stream_memory_free() in
BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 43 +++++++++++++++----
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index ff4dd13fd8c6..776c54948a4a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -36,6 +36,7 @@ enum sk_pacing {
 struct sock {
 	struct sock_common	__sk_common;
 #define sk_state		__sk_common.skc_state
+	int			sk_sndbuf;
 	int			sk_wmem_queued;
 	unsigned long		sk_pacing_rate;
 	__u32			sk_pacing_status; /* see enum sk_pacing */
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 7af21d03277d..8cf2ab32c159 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -25,22 +25,47 @@ struct subflow_send_info {
 	__u64 linger_time;
 };
 
-static inline __u64 div_u64(__u64 dividend, __u32 divisor)
-{
-	return dividend / divisor;
-}
-
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
-extern bool bpf_mptcp_subflow_memory_free(const struct sock *sk) __ksym;
-extern bool bpf_mptcp_subflow_queues_empty(const struct sock *sk) __ksym;
+extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
+extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
 #define SSK_MODE_ACTIVE	0
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
 
+static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
+{
+	return dividend / divisor;
+}
+
+static __always_inline bool tcp_write_queue_empty(struct sock *sk)
+{
+	const struct tcp_sock *tp = bpf_skc_to_tcp_sock(sk);
+
+	return tp ? tp->write_seq == tp->snd_nxt : true;
+}
+
+static __always_inline bool tcp_rtx_and_write_queues_empty(struct sock *sk)
+{
+	return bpf_mptcp_subflow_queues_empty(sk) && tcp_write_queue_empty(sk);
+}
+
+static __always_inline bool __sk_stream_memory_free(const struct sock *sk, int wake)
+{
+	if (sk->sk_wmem_queued >= sk->sk_sndbuf)
+		return false;
+
+	return tcp_stream_memory_free(sk, wake);
+}
+
+static __always_inline bool sk_stream_memory_free(const struct sock *sk)
+{
+	return __sk_stream_memory_free(sk, 0);
+}
+
 SEC("struct_ops/mptcp_sched_burst_init")
 void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
 {
@@ -110,7 +135,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	if (!subflow)
 		return -1;
 	ssk = mptcp_subflow_tcp_sock(subflow);
-	if (!ssk || !bpf_mptcp_subflow_memory_free(ssk))
+	if (!ssk || !sk_stream_memory_free(ssk))
 		return -1;
 
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
@@ -149,7 +174,7 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		/* still data outstanding at TCP level? skip this */
-		if (!bpf_mptcp_subflow_queues_empty(ssk)) {
+		if (!tcp_rtx_and_write_queues_empty(ssk)) {
 			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min(min_stale_count, subflow->stale_count);
 			continue;
-- 
2.35.3

