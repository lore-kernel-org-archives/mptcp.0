Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F407FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY8cPpDjeqQPUqEEsLE3/Y2lZxq2rCP96Wo9y2pUbyo3ATGNtoD6CvlA98fM97nw7hA502bNvy54zIYBgFYR/hTqHVk6bUPBkkfy/EPIpmXqGp1wgun34ZygVal+SbfIwp13UL5BVb37JeulYKyqM17yFYz5qXOcZfsiq2RimdxSZqgxQqNHrOLh4I9tbeGcSOvjYFp0ZnhO6SVHW+9VMaFUFDz40GhavsZPQ7A95942FUVmTCx4tF/0L4XvLRUWPDJ/wUuBvOUnjm6wIq3ayWoTcp0/SZfJzrK0Dncc1HgYUi7tH9P2JQyCC5QFVhG3boINtVP+/uHzKP7SfhjFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8FnK1/Rzr4qBqJ3xVZkk758EzadRcoY4AIkfH7C2cc=;
 b=i7GO5B3PsoIhjNynr/I1I84tRomq0rZqOLTgGtE6i8L7voMCzEHIzib/XDfEryey94Qei1VTuB3uup+mK+mDi9KByGV72mzH9zh2Ufg9u1JP2IWFUAEX89bbwFWOZEpx0+p2Vwil+Zh5s1wTNj+2gBXsBujhJXPfY7rDl6QwdZFaArIFvmpnuGlteEW0FpJO5zdb9Oue43J7BNSd/ma4xKiBHdCHwjgbKtVwUdeABjsF0Mh3oY5ud6nbEPpR3EeSzNEhbBacVvDK7ejRiakglpzTOEwz+ISCA38UzodVbCr53GtTFUowPpVCuO3pESmpT2Wnngxsx/fU9+Zvg7tNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8FnK1/Rzr4qBqJ3xVZkk758EzadRcoY4AIkfH7C2cc=;
 b=EFXNJwi5sZCql+d9z4Z9X9rEe4Zc8mbzBwSZsTUOGiZmC+s/g7yqoNFXVOZZ56O8XzW5/FGi5cVuSbImFsNSb9LeRdj08rHijc2JHFs9aBBqEgLy4iE2y/xOf3hXUe/fm3ltNwttQeOoHmLHQXL3uPKX1ADfoQylIKqsF1XEsl6XAz9T0c3CUROZQNAml+9gyblx33ldz5ttgibINcCHHYrAvJyjlvb4YJzindf+GZQOq4+/qNQ1bFLSfwsnkqunqAfKp/JoDxwtJEMXK7FPb3d6Xr8sJY/micOWsFT0H9sl+g7THcnUz6eis59jklDGqo3mfSpFgBey+Rw1cUaCoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:24:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:24:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 12/13] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Mon, 26 Jun 2023 10:23:13 +0800
Message-Id: <984826f7c18f5dbe96ac89657b51a817d10a7dfe.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2eb07f-0a8a-4758-2a8e-08db75ec79e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MgsoNTw4NlJwbmIrTM/1DNmSn1kUnUFYRT5dtA5d4Q5QxgqPwzcQ2eiEsmoQ2DxR8/tMQOPrETKnNygzQ70u9knBj3YEn7fXi37Uked3V8sHs/DWvcfC4q5hTyDc1gystNM6GsUnRDX7HllH98EkHDcdlyHc1VYg3nLf1JjVavaHIn5WItApOUmV4e742BzJ3fC6K6qohahjXA+6bZqyGKNYDXech4SHlSGvFFfYJLRNdHXamvBgpuc4OWvaBVcAgU5MgfGGFaKXmWDKC9s2TsVaSDexbsyLbqMFJpDOHH4QQnVs1vOdoMPWxQNUSpOVUwomwa3Z4aoO2gmuRGdQstU17ohDOr9rR5rvTzr1Sp1Cgp/qqXA8Cg4yPFifdAi4A7GveXmr+CTtpXp09qf8h+aFD93PF2DAaGvTy+H9ymH5UqBL89GJJjnsr30PcfgK9EZpi8Nm5woKMRDzQKOUhVVUKGOC51LM0dJzT5gglkhNwVMCHELwLSkY9JSY28sjrygQqDBLYlCJ6CKmB1ZEyxhv8m82b6LuZzphSrGLZ4mKRfkgZ8CxGq8QC5tn92Nq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLwR18k7Oj4HUCvf19sn2C0cH/GOSSlG/fhEjaQA+y9WJqJNT3rmwoeUZO5j?=
 =?us-ascii?Q?2JcUSnmqazV7Q03CGio7X95LS4HDeXez28M/b894FwlvilmYKKRAm3l19knd?=
 =?us-ascii?Q?CFFpc08hl6Z5J2ATgF4xrb4QEKgtCm+ChJpimgszqcOFBsRxPJjzchBW7gc6?=
 =?us-ascii?Q?kQyGjvYI3M91gNgXonCye/h28oGzTRlS2+LxStr8zHAVVWZz/moR0ftxMott?=
 =?us-ascii?Q?C9beQec/B5XMSjIYebw+eKdeCjnWwX/Sorphgum4LUS3DHyd7sGhPCeeIv2E?=
 =?us-ascii?Q?rrJjuDBCin5oapQqi6iBMZYBCeQ4L0EHR5fbzEpmGeP3ruVfr/CHV2oZaq9Q?=
 =?us-ascii?Q?v0fbhF+O/hm1kRlSItGqa6WoRJGh/PR7of5jeBDzOTH8G50B3eKM6ka7b/RN?=
 =?us-ascii?Q?UVGcBSrucus+8OQlEzIdy/vmHWOUFXfOOc/1PTcAIUGnj3eVGyvnIl4hFUnP?=
 =?us-ascii?Q?cug3pwNWrsgQ6tjoyJw+DGOXE2WqXfzpQr7ScmMoZIaRYTOk3sHWgeuE4T+N?=
 =?us-ascii?Q?CjHZIwYp2Yn7pMssc4wYl469xmR5Ht+DMUk6cTjlyAlBy1gK4ZZ8AexowU8S?=
 =?us-ascii?Q?X6Mr7rU/SUc9iEhyTHXqiDGxR1Rd9URWpwbxZbfARANV2atp0WObDKy26TGU?=
 =?us-ascii?Q?k0hs687hefdFQDdlk7TbCaFUciCGCW/+oEq+yGIA4dxvH7ReDn861nCQhZG4?=
 =?us-ascii?Q?kfCBI8mb8qoaLXIIA9ptCw4klxWSrsSVmoR8H5amLmVcubSbLU8i9mHa2XQz?=
 =?us-ascii?Q?j+8aPu2KcXP7coiWT5R/1zKJFuJCxUtTwNR9u/KMaozgNJXPSrUMLPN3JNr8?=
 =?us-ascii?Q?YSnF2NPCuexiigmMH5phUytmDDQB3iJ5x8yOnoP4eaJQTpLiUXAfPVgsU1Sy?=
 =?us-ascii?Q?UlIuUXdDlxXXiZ8lhFjI7P7FU58N7nYfycBsu68c++m3XHpZPX/d2Am5O15/?=
 =?us-ascii?Q?CDFs/vNLbszuUw2pHUVvgMlD8qm4yiO5h/L9lJlAu7qi/i4s82YgUwoNG4nm?=
 =?us-ascii?Q?2UGYpsFuYW81n7LPOXuSXIKDRn4bP9tfgh+8V89WwL7IFtAobkRxoF6nnCfQ?=
 =?us-ascii?Q?iheKK/HvHsi+8zXTvf2wpjWYuWZZQ1WSOgHovyRzUNX8rQTiUe82EbGebiTE?=
 =?us-ascii?Q?FJHfSkuS7i6HKQpCllsgtgcLf1eKPDFZzkfC+9KIttZGQzzR4HuauBdyi2jM?=
 =?us-ascii?Q?f4LWeUel6RGamUqeGTLBESZb2DT59q2xWeZyk1PLPB9NXmcBGR/80H65bDzJ?=
 =?us-ascii?Q?Gb5wMmw5DULImX6dGzqGqlcEuEQEQZki9qaI0J/6ICt+yC0T2ObO2VocCDpk?=
 =?us-ascii?Q?G+TZdqVFlRfjZi3eBW8BwLNRYe8jrzaHrqN4u8tcv960a5zJF4gybyzb+kIC?=
 =?us-ascii?Q?gmn7XkQyCGXiWQGhE+KIqHTy354VEh2p13cVXMt/JAYMDlucheCzP+r3Ph6m?=
 =?us-ascii?Q?QHGG07MZ9VfZ9KAKTMS58mrftHLRegxd0nq1lL/m4TnKeofdPJ47OkFxuMVt?=
 =?us-ascii?Q?yVJPcyZ7S/QXJOTceiih2qg01srG19oYlX+G2famkfc2did3dVmlk7AmyAtg?=
 =?us-ascii?Q?m/MdqDI9kXz1E7ZfSZRcGhace92VV97yoi5i6rka?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2eb07f-0a8a-4758-2a8e-08db75ec79e2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:24:32.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbQBIV3sO2442fEM4tV+W5pzvBf3KTBMe5yc+1Ar2/cq959WgekFX0Keta7DjLJRhWNrm03DetWT3vQuOzA1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Use mptcp_storage instead of msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 43 ++++++++++++++-----
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index b4b766c7a68f..945dd46c98c0 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -259,7 +259,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
@@ -271,5 +270,10 @@ extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
 extern struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
+static inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index e101428e5906..a6f1aa55a16b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -6,33 +6,49 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct mptcp_rr_storage {
+	struct sock *last_snd;
+};
+struct sock *last_snd;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_MPTCP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mptcp_rr_storage);
+} mptcp_rr_map SEC(".maps");
+
 SEC("struct_ops/mptcp_sched_rr_init")
-void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
 {
 }
 
 SEC("struct_ops/mptcp_sched_rr_release")
-void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 {
+	bpf_mptcp_storage_delete(&mptcp_rr_map, msk);
 }
 
-void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
-int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
-		   struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_rr_storage *ptr;
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!last_snd || !subflow)
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
+			if (i + 1 == MPTCP_SUBFLOWS_MAX || !mptcp_subflow_ctx_by_pos(data, i + 1))
 				break;
 
 			nr = i + 1;
@@ -40,7 +56,14 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	subflow = mptcp_subflow_ctx_by_pos(data, nr);
+	if (!subflow)
+		return -1;
+	mptcp_subflow_set_scheduled(subflow, true);
+	last_snd = mptcp_subflow_tcp_sock(subflow);
+	ptr = bpf_mptcp_storage_get(&mptcp_rr_map, msk, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		ptr->last_snd = last_snd;
 	return 0;
 }
 
-- 
2.35.3

