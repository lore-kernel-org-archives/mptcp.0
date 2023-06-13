Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759417C7
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 01:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSMSzS4V39Q/IWbcPF82TyH8mCDZozWo5+AaWLi8bxRLb3w4sFzJQljDNlaWjMn3NEx7YKWf9hv85ndt6rvLC4PmyBJ+QOqbqwoADL7lPRdVCZ+g8szFBsnL8ptNrMqJkR4JwOtx/93eeM6Ea+iKK3/REqCDv86oUItopeKdm4I5VRTQcnDTx8mL8m+ZBIPyl3ymzDV68pbvXGkyaA1PXj58gy5Wmrpqbde2ijbYYMayg5S96dz1bsu7Vjvv0GByoIb1s4boDrVmPspYzlc5fBr2ufxE2PRmG0NBr8FsqUdhOZBEbMZE4SAaUR/JfMZRu8qT164hO9zYSTr4IjicXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9T6nv55OcPvb5BVUNH5iMfEt//Q0OMxIRAA2/iQ8aU=;
 b=I7FhP/GsUUJPisDwd/cL/DisdkOjs6wACWeYFidSVaKkCmau9WYC1FVG6Op+XwCOakbJUiqgLT8xYqxQ60tO6Yw7oDFBaSgUkmB9JSbA46w/jlu9JGORv35QDn4g/034bVFDDT8qFsLdFNEfbJpOHOZy8120SsaMG+SJ4QsUzP94KVfcEXq3RBt2lyx6lK7FUk+elOa8SopZBDW9be7QVmSsrWocOsNAUFTuY7GcaTED+E04t6Cj/180IOd9esy+7qQtPVD89OpWlooASk9Kk7fWlBMr1KpXZ+214EGqZUM3+hSl0WaNuIvQKnbjfKpDeVVIxQfAoUw5mVLw+3p3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9T6nv55OcPvb5BVUNH5iMfEt//Q0OMxIRAA2/iQ8aU=;
 b=wlpB1dkzNXrp93/8VnM7mqVrTdAkMsyd4jDQt2YQygxHTlzIbFz7drMpTLE3QLas0KRPvnJeHhWwKR91Msr3znDPGxoXDwF8UOwuINtAi+nvN/9JAboMKkdWLgtAC9FqVdadj5ysZ5Z1ni48PU8JFuSWrcSaOENfjJQF8ebhUi3cU6u2NK6AYDTbfvFADK/xhUC2e9ilgKGFewD1iMSGeUCVBhheJqflTfGDmMzmXhuU66OgpyikkTexN4djLYgNJOeYQJlEhpNrNhCHTtptTM1ywyGme3InwGgbmZSx8ISqJ5MZD1oif0UYwCplRG+lAiSdylAjkSauo5fUwPcB3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7926.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 01:39:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 01:39:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "BPF packet scheduler updates v8"
Date: Tue, 13 Jun 2023 09:39:37 +0800
Message-Id: <8193bd590a4d811054a36f50a2aad79a02e8c137.1686620367.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 91013e61-3462-49b8-757e-08db6baf12d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zpmU7VLaicvxV4MLlfpLl4N/43ZmGFah4f5I5VpRK8GhcUK/DZiVCDan44jIOYvXYQAYwDu33RslxngHEUwE5n5Zq8UuMrNxdI6U/AXuZj6HtsyiRsh0vgSQkvU4jM4luII5MjoupJ8/fiMI87Dnr7RA8BvI3HIZa4k/R+us6dEJgmIQU8Yo5AlSPJoKhdaBSOZhERw9PULbmWpemV9k3l82ikczAM+7QFQif6EOBcoXifLoFA7PUByywFHpbHe2m8RgB/oyiOv8QXDd3qTmHYf/tSwxokxVt6bSbc4dWvWeH25rNI1i2FBTahnVZz6PRhy3sso4iN8yBQ3RrAB5lTNfVia2br+BWvy8WuMXxT2eJSG6T8/vWnUigHXSUomw7eP3tVBJtayJWbvZ55OuGVp3T/lRVR+7KsN3FGElinbYhHhBZ5IXPJkBNOxwgtUi7zmW9ErzRvhJzZJ2fufoff1Pp7daweYCf63xhrtPeExFMV9yCIXLrPw20Nfo0Jfe3b0cSLkb8yHdhbpvErORNmqF9b/AGJJ0VfCb8uv70lWC/b0/1mZSEMXy5pOw5Vs9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(6512007)(107886003)(6506007)(83380400001)(186003)(36756003)(38100700002)(86362001)(26005)(2616005)(4326008)(66476007)(66556008)(66946007)(6916009)(316002)(8936002)(44832011)(8676002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duE7mqIJ7ZL/nbI46sxhpITsXKlrEtQBTZevqLDGlbN4BqlNeANMDtJxN9IJ?=
 =?us-ascii?Q?zfylAKCOiBy1r8/gsdsz77CxqAQ+Md2U9I+lS11FjX2OcgNvin8dC/KkmcK5?=
 =?us-ascii?Q?M2EwmFvr20MGZ1QxquExI4Jaz+e2IZh6Wmy6z0R2wGrro4QyHN0XR+iL/nCt?=
 =?us-ascii?Q?ldoqWxCcaDjWyEHEnFMnlV68VktY7Hl8WseV1oYBV6pvkj6SAeAXw4wazZ4G?=
 =?us-ascii?Q?xPI1jjNd7a9cUylx3KYT9Of1XCJ370Lf/fKxiqva6acJoIJqq0mvgLq525Fa?=
 =?us-ascii?Q?eKCOFNWCfDVqNAv/9eCTXhi/tHbHtM5USe8JHexHF6I/rZiyOvh9PPkWD3oZ?=
 =?us-ascii?Q?EetjPXy60/HHl3EyIYh/EaRJLWszjpAbE6hqdOgeGDlYO3/FsRSo4LYHtpZ7?=
 =?us-ascii?Q?GGWUQ8oAdIhcM/Vqf2YZKcoYl40zkn7lHF0NCder34BR6GT2pKlhhLb4FxyU?=
 =?us-ascii?Q?cQcWR3D/FgIqv7w3LP8BBfkCtyqhTDjRmZTegp4qYHJxtYQKjFBXj+pUHhi2?=
 =?us-ascii?Q?+q+O7659ACP6RyGB33wEPhcduXJH8aiTkoDSa96fyipDuglTcxFVeM+M4OVE?=
 =?us-ascii?Q?tQRjZ0WA7YV5Moz1fv1ZPgA+HVbaq7cCIUKq9oyM6XmKEY5HGLZYKp/upfor?=
 =?us-ascii?Q?Qv/PYRdtrdbPsOnLeFqJmgufKX50omU3Dyh05RJlF7mfwJdyQw7Rw2IJOYWi?=
 =?us-ascii?Q?+hZeXpoy3AJ08XtzJp7HoiwbJhxbat/oaens8K87ptIB+WGzr2lmqs3nZWzm?=
 =?us-ascii?Q?qltvlc5om5YpqDAAVbv3ZKxwjAGryku1pNesGdTb8SoRLuLcQOgPewRkzKZp?=
 =?us-ascii?Q?pWiGfH61y6/Tf3UUZn7wAx/cwJ3DVpPyFC+JD1dJWEomt7PI3lRyXyxt9whl?=
 =?us-ascii?Q?KZBppRqKrjMT2TPQGz23924sNXo45myegXWhVgoMF41/l9zo3Ec744y4Y3yE?=
 =?us-ascii?Q?AsXkKaITqa+Y+9ZEjS/8IAz76B5aBK6AJjc3O9ti8AZHUJAVZ1nPhDHcbX8F?=
 =?us-ascii?Q?kMrWR/+Lzt6siprsS276aDfsd54GydZt37nJlIsQJr6ndp6rseNyVaJkdJtV?=
 =?us-ascii?Q?YE+UcAkPAoEcX+c6jfFmbpWsirvjgeGs7TCwwkGfs2G7a/IV/OBlHegXG75G?=
 =?us-ascii?Q?Vs78zaVy9EhMCPsVT1mO02vR834X5cZyjLxen9ZpM2Q2vWcPy9NiMvxNZQoE?=
 =?us-ascii?Q?maL+nXXFQkNwOT6PtYPt1E1ai5/uL9RqWRB5R8yLco+vkv3Z2OYO09ijoXHU?=
 =?us-ascii?Q?NdI6f1d4DvP4D/DC31nidK9sNUOcty11ACyZYhCTwM72EZpk0o7Sc4OWRMy4?=
 =?us-ascii?Q?PmDs/E+6a8SFS7KO5Att30TqVBvufdjS5LTMnidiP8kCHDKNk59P0ix06cIh?=
 =?us-ascii?Q?e1oEyEdOOj1hq850ymdvK85MXCmxw7uzf2vMkIFxPlRZ6wemeYZySpoHy/gu?=
 =?us-ascii?Q?skIkJK0x8o+EfaR+wxlzNOwe5rwyW6VEpWvqN5zY/QrjSnypEE+wheLUNfOA?=
 =?us-ascii?Q?vvT1PacZLex4qdIgNxEOQ/lk+eEOIcN8BPxGOaSqSxmHJffzTjdU1U9SFgwJ?=
 =?us-ascii?Q?SdHmjSu2xC8BQMRByw1ABxYuO2zhA54MWOEPZa93?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91013e61-3462-49b8-757e-08db6baf12d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:39:48.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG79q+0vIrKdvjRpGxPBA0dscPG52TH/2MkRQ0HmCTWOOEKma/ow2YzlBp+UC/K8qu4wiDzHsejQgam5ih96Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7926

Fix the build errors:

Unable to compile mptcp source code with make W=1 net/mptcp/protocol.o
Unable to compile mptcp source code with make C=1 net/mptcp/protocol.o: net/mptcp/protocol.c:53:5: warning: symbol 'mptcp_wnd_end' was not declared. Should it be static?
Unable to compile mptcp source code with make C=1 net/mptcp/protocol.o: net/mptcp/protocol.c:501:6: warning: symbol 'mptcp_set_timeout' was not declared. Should it be static?

Drop bpf_mptcp_subflow_ctx, add mptcp_subflow_ctx_by_pos instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                               |  9 +++
 net/mptcp/protocol.h                          |  4 ++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 69 +++++++------------
 4 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index d46d53fe193b..6e333b214d42 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -188,9 +188,18 @@ bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
 	return tcp_rtx_and_write_queues_empty(sk);
 }
 
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos)
+{
+	if (pos >= MPTCP_SUBFLOWS_MAX)
+		return NULL;
+	return msk->sched_data.contexts[pos];
+}
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a38b712a6d2f..dfdd22221b6d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -638,6 +638,8 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
+u64 mptcp_wnd_end(const struct mptcp_sock *msk);
+void mptcp_set_timeout(struct sock *sk);
 struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
@@ -669,6 +671,8 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 bool bpf_sk_stream_memory_free(const struct sock *sk);
 bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
+struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 3e8df90951e9..4ac51f74e872 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -268,6 +268,7 @@ struct mptcp_sock {
 	__u64		snd_nxt;
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_data sched_data;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
@@ -275,6 +276,8 @@ extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
+extern struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos) __ksym;
 static inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index b860fd517787..4ff4728faef8 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -10,28 +10,10 @@ char _license[] SEC("license") = "GPL";
 #define MPTCP_SEND_BURST_SIZE	65428
 
 struct subflow_send_info {
-	struct sock *ssk;
+	__u8 subflow_id;
 	__u64 linger_time;
 };
 
-static struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx(struct sock *ssk, struct mptcp_sched_data *data)
-{
-	int i, nr = 0;
-
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!ssk || !data->contexts[i])
-			break;
-
-		if (mptcp_subflow_tcp_sock(data->contexts[i]) == ssk) {
-			nr = i;
-			break;
-		}
-	}
-
-	return data->contexts[nr];
-}
-
 static inline __u64 div_u64_rem(__u64 dividend, __u32 divisor, __u32 *remainder)
 {
 	*remainder = dividend % divisor;
@@ -79,13 +61,13 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
-	int i, nr_active = 0;
 	__u64 linger_time;
 	struct sock *ssk;
+	int i;
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].ssk = NULL;
+		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
 		send_info[i].linger_time = -1;
 	}
 
@@ -98,7 +80,6 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		nr_active += !subflow->backup;
 		pace = subflow->avg_pacing_rate;
 		if (!pace) {
 			/* init pacing rate from socket */
@@ -110,23 +91,19 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
+			send_info[subflow->backup].subflow_id = i;
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
 	mptcp_set_timeout(sk);
 
 	/* pick the best backup if no other subflow is active */
-	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
-
-	/* Get the ssk directly like this "ssk = send_info[SSK_MODE_ACTIVE].ssk;"
-	 * will get an error:
-	 *   arg#0 pointer type STRUCT sock must point to scalar, or struct with scalar
-	 * So here use bpf_mptcp_subflow_ctx() to get the subflow,
-	 * then use mptcp_subflow_tcp_sock() to get the ssk.
-	 */
-	subflow = bpf_mptcp_subflow_ctx(send_info[SSK_MODE_ACTIVE].ssk, data);
+	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
+		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
+
+	subflow = mptcp_subflow_ctx_by_pos(msk, send_info[SSK_MODE_ACTIVE].subflow_id);
+	if (!subflow)
+		return -1;
 	ssk = mptcp_subflow_tcp_sock(subflow);
 	if (!ssk || !bpf_sk_stream_memory_free(ssk))
 		return -1;
@@ -149,21 +126,20 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 static int bpf_burst_get_retrans(const struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
-	struct sock *backup = NULL, *pick = NULL;
+	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 	struct sock *ssk;
-	int i;
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
 		if (!data->contexts[i])
 			break;
 
 		subflow = data->contexts[i];
-		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
+		ssk = mptcp_subflow_tcp_sock(subflow);
 		/* still data outstanding at TCP level? skip this */
 		if (!bpf_tcp_rtx_and_write_queues_empty(ssk)) {
 			mptcp_pm_subflow_chk_stale(msk, ssk);
@@ -172,21 +148,26 @@ static int bpf_burst_get_retrans(const struct mptcp_sock *msk,
 		}
 
 		if (subflow->backup) {
-			if (!backup)
-				backup = ssk;
+			if (backup == MPTCP_SUBFLOWS_MAX)
+				backup = i;
 			continue;
 		}
 
-		if (!pick)
-			pick = ssk;
+		if (pick == MPTCP_SUBFLOWS_MAX)
+			pick = i;
 	}
 
-	if (pick)
+	if (pick < MPTCP_SUBFLOWS_MAX) {
+		subflow_id = pick;
 		goto out;
-	pick = min_stale_count > 1 ? backup : NULL;
+	}
+	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
 
 out:
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx(pick, data), true);
+	subflow = mptcp_subflow_ctx_by_pos(msk, subflow_id);
+	if (!subflow)
+		return -1;
+	mptcp_subflow_set_scheduled(subflow, true);
 	return 0;
 }
 
-- 
2.35.3

