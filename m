Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82723C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxjZ7pdD83y1hS4EYdAGlaPJc1LSgR709t2FR5yS/zU=;
	b=JtGweRQmEUNjITl7T60ucdJODdbmVeznUdF5mYdwpkqsfTjA7JCwKHjhXaHd74DS7m4LES
	wMpCSzocz1zFGN600CzGUhojHWiO4Z8Japt9xoGv+UN+/Tkn9kXyDmtutyflYgxbox4RN2
	xpGIpYTjAVms/fOdkbcPSE3+d1onGNg=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-7YRNGSU5NZKgbx-C9Em4Ig-1; Mon, 04 Apr 2022 04:10:45 +0200
X-MC-Unique: 7YRNGSU5NZKgbx-C9Em4Ig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KidmdRVgiRX/2gRMT5R4rzItkjgCrLaHcPzTgQXS5q5e6OM+GX7mfPnUTs8wSP8U/JOX9hDUWCSsWyhkw99FJqDnoXtFFNpYL6bjyzriu07+Sv3sPMzdu0vQ3GmYARHJAsXAUoCQ3BNmnQd1TvWDS6fL8R3lzPTCOPjGROO43YhVWtcbI4TOItqq+21c5l8W4QWZMPeWDVLqasBhoGweKQ/8jNDlNQUVR8utdCLRNmilpYhgqc78phtfenRCUI8hs+G0G0kmiAmwrjuSSI1ONguR9sc0yEvFdh7giHsFAgfHhr5vlQVIzg6Dv/N/sP4Ru2QadA2uXyMH11+RbEfLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIFj6RPpzflxj77/1/bXfH0GhShReIWDWHFRc2L5qRw=;
 b=AgBDMuzaCi5odJ56vaATdFd0yszaF756UTDWoCiLoByctJRr2aJsDyWCECfDCokydyXwpyoCHb7rNJsyS//XXBLBdoV2L2FCr1SF5HVPxnLDv7KnIXfWnnRssDhGCtOrBzNUSLuaL64D6U+4eILP1cJGrFGQCVbY3z4F/9bDMiE3XOwQilQe/3MjX2jy5NXgrmkJm7kuRnnE8mAR3pXp+HMcuwncQLYL13yvpGiopX366TGyL413r23uQMYfcKN9qrNYtAZd9lTSTmyD/CFi7EK/VcPgik3jwPr1qdnlmIHP24K9IGh5QQ/G0il55H9lo7xV/5gCsovl/q13rjiQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:10:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:10:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 4/8] mptcp: add sched in mptcp_sock
Date: Mon,  4 Apr 2022 10:09:56 +0800
Message-ID: <64d8a25cc23fe8720f29f303a136e5cd6001bb73.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0012.jpnprd01.prod.outlook.com (2603:1096:405::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db9ad226-c5ea-4ea8-35a6-08da15e05336
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB71896A48B617D1825D4BF683F8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	80A/Fq/iNoYVhWsnBHqxCvCwJk36nzL+hx3F6rqdCxeZ6LBHy19aQ4jrN2/nIQBiSVsVCgeHaa23eS27damkrIXneEhsS7JKyuu+kzBU++zpQFTTiUbMZKIaoA0bWnTPrbhhFwCttrSb1sXnPGmtC0ibWuyF1YfnKT6K+hP1zQOpMbLiPxLEWCKvBw2GjmvsKg/q9mt1C1s7ebaekrpemw1Nz1oLQKZTMZ61QuWcW7y7qGJXccXSGVzv3OPW7SQAyVAq9fb2DXjJ3bStODOM/mUnIArz/trAOm4QOo1dgrFJ0f0NKTWAMu5xEP+oVY4Ndvn5lzEZ8jYK3xq13O/jjoSq0BDeQJ+rL41wvlOtK6u2yfAaFw3UfVYY8I+T45VoAZvnK2SFov7da6xst4D9EGNBSQL7jNK+28u9cVDOSoZ7H63ZoP5BpWrCZ1PRSrdFqa0USCYRxsOoBPCpo5NbVw6b5qo/BFpgCukqqeN1prFjmO+S+Lr1fIKKP94bmCKkXyZjtrmSHBQPtwqDB2k/QTUx3/tZazSNkXCiXGz6qdbDJOtxM6gzaVqiSnWsM5kQKUMR0hkuTU+Dtt4uJi7HvcwokzAHp4eE0O7HLfsI+pzhmpaRQyJ0O+HEGih9YlVVto4CxlA3qoFAy0ks+hCep/es2ZKQB3vOVCemWIIK2YukRecqZyouT6iMS83M15Ji
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yu/V4pDYmRDMkf47GPkiKlpRpvXlGFnNQLdrQ+DeDUFqB9fxKhqNBXEK0jd5?=
 =?us-ascii?Q?8dbQtfjr6lKni/c8vDu6XdkmxYjZISoiGocWzKbCvP8pKJQssYAat9o5frbC?=
 =?us-ascii?Q?Dx0a5MP9t3Nc5w6ok7i1GbxExZEegoc/4xqjPkzCh2W5vcmA+6xAz5GtvVn5?=
 =?us-ascii?Q?a6eFPvAmyGcUztc23tkrvlcm3jIA0grQzi59AW0TpeOOHK4bdY0zT9V714tt?=
 =?us-ascii?Q?OBhW/bI3j8+JAkZTZcKz+HYXhEZr/RP5QDtXmPto1+rlrkgx/tfZd6q0QwTc?=
 =?us-ascii?Q?yUNDSi5Ahm+kPyN8rhJrg2FCHg3Fx7+bWK12SwsCAmOIKsHtO//tkNzRm/fZ?=
 =?us-ascii?Q?g7t5C6fdqkCMTkm3mKHRN/clQPcFhGxlN2WbB0SdMxHCwaLFXTQmY6BtYw8E?=
 =?us-ascii?Q?h9c3d9erxiawPvroBha+BEjl9qDPkp1rKNg7HatLrKKJDIkSeL4PH11biObQ?=
 =?us-ascii?Q?ZGIPZH/wmzFctZcUWZUzHwZUY9q34AMd+PnO4TezidUWHPC66Cf78Ozzpo9G?=
 =?us-ascii?Q?/XxX8/OFyxWdHbb3KK25eISQNPDNgXAyY4knXsVvYfJ3CtbCIKWel6Ef1DbV?=
 =?us-ascii?Q?6kNfOpXhXQNYwLTEYhqIVzvz9y633hVF2HmFuFg6oj/pSCp9HdJWHmaW5s1x?=
 =?us-ascii?Q?WngGXF3C4G2GMaByU1Vcz2HkY1ydr5pGrcktlDed07bcMcLayPRna4Gkx08C?=
 =?us-ascii?Q?AFfEJQ38WY4ud98T1HdIG1A5cMjlJ4vk60/qh9cgAhphD6jFmCC+RhWVGwIB?=
 =?us-ascii?Q?tlqtDEhz2QUlb00Xrpvzx9A2YF1QrT8HSsyRTikyzZCZXIjqp4D0lJ/zXlzP?=
 =?us-ascii?Q?dt2muGibz0I4EYVRqvydglGVesdtPuQsxro9WmfqTDQvKVtpUtXgDQOzFe9U?=
 =?us-ascii?Q?P5M9aSifehK3R85nsDV8m5Rfwi+J5nnL/2BAEr8IKJJK7MXl9kC7L1hTcQ2c?=
 =?us-ascii?Q?WduOgiXoYrZnw47Bkp9cC78tBT+IrGVQpuoPaMJ2yAILwj8Yjq9mRFlgymHZ?=
 =?us-ascii?Q?C8nN6o2ycY4wub7TAkdIQvVklHVRYY0GxuTwhCgn9fQQ68y56xCMqPrPKM9u?=
 =?us-ascii?Q?ecg1IGhraw3rutf64b8Purewykb6IrhXTA9EAKnPqMSUAwDXuwYxEfG4Lq/7?=
 =?us-ascii?Q?+23jqi8JUbZYTGHTVt7iJcMi86UI271TZFB08FE/EpO3P1rZs3bHqCSSEbVf?=
 =?us-ascii?Q?sTfAz5RbYjDcZEqKZA0BMsFTn9x5uZ80dYB6dpUfaEQwnOYVZgmEaHjyE37S?=
 =?us-ascii?Q?nlPVib3eX2nG6ftzhPkaJ2jUCLTNj8NMmH71zShHx9RqaASDsLNegy4DINKS?=
 =?us-ascii?Q?khONqrHgxQh9/mOyi+dUEq9HcGQvNDL58gAuonKnuA2jvpo+YsxLSkTShvyq?=
 =?us-ascii?Q?pH5B4mg7lXg982bQNO2opdxC5ey9JZheYDEIoV4OSCkHuQtE9ePKm3CQohRw?=
 =?us-ascii?Q?y56NHNOOW85NxyJaIiZnWg8+cdsBVn8nPrPFrt7w9NZNzVJZ6I38gQ362kT0?=
 =?us-ascii?Q?sHUltiT3UE1FgrrOXcaoPkjMk4YYkvkCXq9McYVcHQeP6mY1WZGU6HeX+Hj8?=
 =?us-ascii?Q?Uz2qZc5xQwc/5VZ3UY4m/D5cz3DToSPqR9H/FS2wR6qdNvpGCbb+0tkgppt1?=
 =?us-ascii?Q?+sHAn8EidHkEbx0qM1kzXfyNy8I/NHhUq+6y5JQdI0wSW/vOI5lVMneyb3ba?=
 =?us-ascii?Q?rPGbd2ZNfzyr2CXdbdBlcWP6nxwcRGTTReRHw/DKPnwnePcpX05guZtZ5FcA?=
 =?us-ascii?Q?P2oSn3D30C5VXkv7Obe0l/Z8j3wubpw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9ad226-c5ea-4ea8-35a6-08da15e05336
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:10:44.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC3p47Vj4p4UCrKrdZS/ERKKJu3TZGnX4ZZoWDND/7gqK9jWW5n5rjp9zyE5LmvDJy0MknL8CuL8aBAergPEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  7 +++++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8f0e71c38336..37f4f6f3661d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2657,6 +2657,11 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
=20
+	ret =3D mptcp_init_sched(mptcp_sk(sk),
+			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	if (ret)
+		return ret;
+
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone wi=
ll
 	 * propagate the correct value
 	 */
@@ -2816,6 +2821,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2993,6 +2999,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 65a08110268d..1016dac065c8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,6 +288,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -614,6 +615,9 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sc=
hed);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 52828eb741c0..5d20d252088f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -68,3 +68,37 @@ void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	struct mptcp_sched_ops *sched_init =3D &mptcp_sched_default;
+
+	if (sched)
+		sched_init =3D sched;
+
+	if (!bpf_try_module_get(sched_init, sched_init->owner))
+		return -EBUSY;
+
+	msk->sched =3D sched_init;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+
+	return 0;
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_ops *sched =3D msk->sched;
+
+	if (!sched)
+		return;
+
+	msk->sched =3D NULL;
+	if (sched->release)
+		sched->release(msk);
+
+	bpf_module_put(sched, sched->owner);
+}
--=20
2.34.1

