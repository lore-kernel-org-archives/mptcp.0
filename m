Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC71852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRxAvXrhiOxg1zCCJJMEhl/dtKkfzMQBen1bjE/32Ys=;
	b=dYFZ9gkWT2hyQPRPQgyqY7f15EMQxOgb3QeFwb7ytTD/mwLyCJjo4X+wC3y6l/+2kaFsxV
	mXfs24hwxHmlAIit5Fe5gJBQGXoceswChQz4kVEukBtekVBs3tMiy01DYPbRb53RuowsV9
	hil5RU5ZnZMyQkH4qEUHGcXllKnRz08=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-TgM7x-XLPfmGnTlJQNETIA-1; Wed, 18 May 2022 08:12:43 +0200
X-MC-Unique: TgM7x-XLPfmGnTlJQNETIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq13Ry3epJtCLaGqjeBBPGaophr1RtjBKam+Eyg2zxHp7IP40ZQJHvZxEXmWQxNSlpfrfxOjw+y6INHYCo6iVQo4qmPR/65rUWlGkbCxajlBWP0J9Am2N5IndrFKPxCq/DfrzTcdJdna+4ghU83UyjoTMoK33uWmDERjejJ4/eWkoZuD4Elde+lydkr3LddGE0G1KbAQCBeMAlHBoYkxH8qkOUTAbtX7GzlUhW4WbWbexF5egCy8dbwCUsQ6zsndo3ZQgqG8cpqF8qe+dY+t14smpKLJisVgGNsgR4gAMdNNCaZecGT567ggiTW72j+1vheN3hc877pHtWAr5EdooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dkf14X/b1u8DaWysq5zD3Goopu4QvsIvbUrOsJePChE=;
 b=KK8SoqVspd7N8baAJWaDO6DeXq2XPpM2FEwivfzmY0fxRWcZhshppXTnrBQfdnszhnNMDxGsvIDJu0BLZesv5UAAdP1BpfhQbQvMTLDB+wPUvRWl6Ak9lzE48krMpI3pbpC2eP7Ln8lje6qd49VfjBUK+Mr1D9iES8LEnblGKnqSArZRImRl6cjE3XDy71suZEeZkQ52wNVfKAi9qQX3amOLB1aYhQpjvFh7//D486uhrOGopbnQPexo6vjrEbTfA9GgflVZOr9LQymvVNS2TLauSKLpTesZLy7MsnREnzCpgrO68VX/AvpJU78QL6rvYnH5YVJRDjDj3zIrXTK0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 14/17] mptcp: add get_subflow wrappers
Date: Wed, 18 May 2022 14:10:52 +0800
Message-ID: <d808e217948c28d1a8ef6aa86d176dc40bd70e13.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f8dbb65-e97d-4b59-32c3-08da38956ad3
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB258431CCA927621B6E2E2340F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A/9fMUhjV7lrGa/2ngd9e3EjvWdtYMPyEzp4+izd0WnjfCcbdTwzbprbVLegBJy6UWenNMaUkMTy2fC58Ow966NYkfmxoCuXOJeykSlciYavP+nA/R2JrQ//NX2UqU/pBfGY4yaXVZiYGywrZ+Lw15afM3XdCn6/4Tb15oCZqNamZ+DRY5Ix8fMYz0WMtdXN0cQIW4DLdYZqBt054lGoGK2zlFYSifhikEX/+j2hnuI3TUwd3QRnyjXlFCD1YQrumHA1kaRWwTFFqD3uUYKuB6ho16gYhAYs039IY7Kgy3MGX4ebEQ2q1h9mqrbxYR12tB5HD3n6RnyMOhx1JWeDkMeXfgn5TwJXeKvSo0k39dehRuZNDgFlV0N8G7lcilNvm0WgoetFaLho3aHUoeGL0GdE64jtGO2gXNPRwIzZrF6rHUx0i72kp+9i1O+YNU3T2V5EJQ6H34LX9ElqsiP9F8w5IfZZBytDhPNHitZz0OphzrdazF4Vb22ggrBun9gPjygZt1ngxMyvOC+ShBO8KGhEQ6fe/WGFHloldC1OvT987AwNsZvhL7aF4lAfYrSoKyEQOAkwHZY8i4ATr3/ubeUqAXME257KxAt98BlGaRL6WdqPwAglW2ElDuEtqMOruT5YiqjgtR4ybB/BhmjIUQBzOM1TR+JEhfxxTbM7tLWPTLNszm04N9uBNm/Yj8c9w/3cZQY5B4o4ByHd8WRsRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(83380400001)(186003)(6506007)(6916009)(54906003)(6512007)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WesQeGC97jk2ZH5X0mg1GX/+EEAuK/HI9uNX9gC3+n/7Dewsz92o5MoEcQuF?=
 =?us-ascii?Q?M+xUrTujQkBbNx1Wi97sxPPIeApQ+quWyc1Le+6mVx7iQUvJf0i3GL2tyZJv?=
 =?us-ascii?Q?vR0dpws2zad6CVJLrzfNCB0pmVQr7wWlfJEnUh3oYb3vC7SAWY8Ap0zMTWUx?=
 =?us-ascii?Q?l4jx303vI7AG+nW4Rt/PRPFNFA1RysmQFaPzG1rC3S0d7gee0T+FcgaC8huU?=
 =?us-ascii?Q?lJtqgY7gjnrh90UG50B5XxmHzFwIAWY91vZ/UrXaLz0L6Psvw2WcPl+uookE?=
 =?us-ascii?Q?sU9oKLvtS5BjQ4EqZXMve7XGPCcAV1gMzIzbTYWQtMb5w0Et2pWeGVcz9ZI+?=
 =?us-ascii?Q?b4aDPXMGQ4Qf1NTbjShXMLqSCdozCasMmiw3nJORetPX8NzHxl5VSqG2ca9B?=
 =?us-ascii?Q?XbYr9Mn7WB4FHHDXXIAEMriNbRdfcYmjPHY+g4LDQSc8k3EfLocDE8MePtBQ?=
 =?us-ascii?Q?ZIsb2HXBMJBENwezsuMFsiLkfreNQBgqSxrQrMeXO4/qp9t+0z38qBzS93I2?=
 =?us-ascii?Q?CYmv3VGjt+wIB6UOv/cGFy21LXEBv1FzR6pFWPHIbqJ8SWhEh6pBJ1fgQyYe?=
 =?us-ascii?Q?NF0CZdT/gzJS2etWSs6tFmFy0eziWIvoPgJNZVz/clANAUZBF5pLGkEN5NMp?=
 =?us-ascii?Q?k8NGn+mh7rZip16GEGuV3Z6LFMfKD19xfbY4pBbjnidGucpn1XVrpjQ58KlV?=
 =?us-ascii?Q?wmuXiV4gcZZ9yvKZGQQModcN7if3HDGpuVODVgqMDseypdrKFqszChqDk73p?=
 =?us-ascii?Q?XWMzh1wVNG3bBGESxZxql2QBrMroJ4GnQo0keHjmNgvTvX+Vd9biD2BSPjjy?=
 =?us-ascii?Q?+W0v1do/H71j5LJCLXugziPivA8wKZ4GRel0CuBPVsGdtctbQYwNg7M8Kw3y?=
 =?us-ascii?Q?nGQkWHTehsnPA014UYfB7JopUlnoNBE4oY++GSnPQ/JGx/A/Y+ifqi/Lifmd?=
 =?us-ascii?Q?0adc+OlmIWeCPzGQN6xCe7ySq1XOwc2KN7pCyDKMOhCGuf18EjeZ5MZtXPrg?=
 =?us-ascii?Q?YElQysK8fu4C3MBjt4ZWEOSa7TxiHjLorOt4xcM2P1ROBC0++z0JpVAjcF1a?=
 =?us-ascii?Q?SrJyY5C0fi6D0VIrWt/VUua6dh3asJL+bXgae9iNHlexHLu4v2Vbi/N/TZws?=
 =?us-ascii?Q?fqiyS5j+uAycmCRtaKwYv2Laf5ykvJV2yP3sb3PThnR7V69pXmGW4mGINGY3?=
 =?us-ascii?Q?n0K767yAhS7LRC/NgykRj+1wpXBtBpJt0OImKm1dTu+akNdPRkH2VTQa6+B9?=
 =?us-ascii?Q?Mr1IUU/5nrO0ZbDZCIj35AJH6Fd84oe1huK8KqFQR47H9jFzI7UE5rRrTiY5?=
 =?us-ascii?Q?BPtN4Nmyo6vBT+WY2O/9wAEeL1hgeqWIkacQbu7kZeZRYQvSjgOl/hlrmD4V?=
 =?us-ascii?Q?kTY5ateQQ1+n1XnGjaL4R3G8vcH/1fxYG21QEnUi8pbzXe+RkFkEndvBZhTu?=
 =?us-ascii?Q?KP0Atq8tKCWMU04k7G8BIUHIhjO+7oSDbkHdn6rYY6FW39/Xu5P4tglLR2jJ?=
 =?us-ascii?Q?2vVBiMcduaNUx2aQ0NxD/bPgg55j/x/p7+Ro2hwQOaVhs1zOhSdFiVXRYKY2?=
 =?us-ascii?Q?I4uwGb/1R/OHJsThIioiBtRV9cH/vS9wN9cfUJ3Ya+E/ZqLMvWg6o/Zj+8bo?=
 =?us-ascii?Q?6s7PIbGiyA8orPFqXcqNQL0MFUNDBzg0gMaL+aQWQ/brtxfB1tKSgxxTR/JV?=
 =?us-ascii?Q?YCk/09Nrl/PQ4ZzZrOmi4DKyo9YGJRUdlfrvcRy0Qg2nAtkMpZ2AzjtoIjPK?=
 =?us-ascii?Q?EtzarObFvAAu/b3mSA+wfCw4a2oXmAA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8dbb65-e97d-4b59-32c3-08da38956ad3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:42.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YoEf3o2vqWqI1Ol4Jvv+DsVX4HoNR4roXWojdwMEM0EwZ60lU07jw6GOCIcF6FhHMzrtyEFUibAryIa3DsW/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched
in them. Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 25 +++++----------------
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b7b7fbd2cab7..4c10c88d170d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1427,7 +1427,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1438,14 +1438,6 @@ static struct sock *mptcp_subflow_get_send(struct mp=
tcp_sock *msk)
 	u64 linger_time;
 	long tout =3D 0;
=20
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
@@ -1575,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_send(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1642,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2203,17 +2195,12 @@ static void mptcp_timeout_timer(struct timer_list *=
t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup =3D NULL, *pick =3D NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count =3D INT_MAX;
=20
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
=20
@@ -2466,7 +2453,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3114,7 +3101,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 57a92db1e85b..9649d367d363 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -535,6 +535,10 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops=
 *sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 53773668b5ee..3ceb721e6489 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -87,3 +87,55 @@ void mptcp_release_sched(struct mptcp_sock *msk)
=20
 	bpf_module_put(sched, sched->owner);
 }
+
+static int mptcp_sched_data_init(struct mptcp_sock *msk,
+				 struct mptcp_sched_data *data)
+{
+	data->sock =3D NULL;
+	data->call_again =3D 0;
+
+	return 0;
+}
+
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (!msk->first)
+			return NULL;
+		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+	}
+
+	if (!msk->sched)
+		return mptcp_subflow_get_send(msk);
+
+	mptcp_sched_data_init(msk, &data);
+	msk->sched->get_subflow(msk, false, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
+
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
+	if (!msk->sched)
+		return mptcp_subflow_get_retrans(msk);
+
+	mptcp_sched_data_init(msk, &data);
+	msk->sched->get_subflow(msk, true, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
--=20
2.34.1

