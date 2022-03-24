Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5081FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648130975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iajKMqQDN3TH6/CeMKw7x0ywnJN1RT/h8Grw4IbBnSg=;
	b=VAN1f/vlH6Lnqt5nkepv7NjjtLhoGfmBPvFPSZgldT+pT7varBdqTuF3sZAaHYzALXxYu7
	w53xwmXba3VvgxIcGFGZC+iWxz1blvnYLTwujeld4pO00lrq2gCFsPYpui/az4k6RqpjuH
	Mv5IN62QGztewJaDLaOLtOFIeeCJH4I=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-qeFCSJBFNzKG0ZDLZlHXRg-1; Thu, 24 Mar 2022 15:09:33 +0100
X-MC-Unique: qeFCSJBFNzKG0ZDLZlHXRg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3IMkab1nMdhy5zsL0kFRmJzH9g/rMCQeD+0+A4fmqTqhiGuHlfnGiUnTGCTjQFLlXHc8gfLyzLSkiPRiNhQarilVMQIzk8Bv0LhZ/uFibigw9uegfqeDaa3iVmAnLwJ+eMFeW68mgAN8o4SuBovdYKqjrvre7DOYB3tewBSI97bOM3xhdK0BUGvF1Rq3yB46yaZA/2f4wApUJjAXhrPDH6t7wZq/FtB/DifH1GynW38qqz72JLi35aVDUIj9WhZ4gxMiLPDWn6UUiWZXfPU6osdCRuj7F45G/ywm70Zx9KjpW6ZgaYF70J18kq7EtDpy/toCQZnWlABGT04JxLHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4ceDldLOsLGRJt2Gd4ZJnHlP/HXBgJBPsO061R+R3o=;
 b=jLLmfxSm7i8z03rVbzOXVZeUCs9F9EktngvFcfzee+KGlbknnxOs4GU3JLTRtnb8T6ATA8TI6A0Gs9NyaKNVlsl+mK7iZnrOjVIohc88+Xn7XonDisamJs2/NQOW2s7sy5N5FwiRt1JRR+cF9rwEmFqsJfPY2U+vvg6YyVEejR5BUMJeVwTWwIePWhhxZXOMKKV8wO1BFjozQm/5W+6UEQI77fkT2n9s5Dv7pYorIFa7NF9RqOJ8CFFanQpyTttaWlcljVf4l3Pof5/1YkqUecIY7zD2rePhq9PP6F8+RBunyjhazWpS2i2JMbvlcJ6DD8ajyKyg2ZKnG76ouKpyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3616.eurprd04.prod.outlook.com (2603:10a6:803:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 14:09:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 4/8] mptcp: add sched in mptcp_sock
Date: Thu, 24 Mar 2022 22:09:06 +0800
Message-ID: <f6c64bceab5e96d42fd5d522302a16d553197121.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5de9fe5-f847-4e3a-01bc-08da0d9feb5b
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3616:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3616020A05DDFE338A3A9ABCF8199@VI1PR0402MB3616.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GCWohJ4hKqQ24IezmwTyW00N0kAilIlXLGmTXpx46ahpfpjoGBobjsEPh+o7K2x9tJa+GU3LPfwq0Twj8Qya30Hdj2fbZgJRJxexdMdyIKwyXvSkipSC1DdGkjIx3UyRLI6yJwepBAX0xwPcVvF7QWOW9MH3OJa1SOvueSOki2zGmHxDXs72vAZlzddGnoge62dg4aGt8YV7nxvKMKLd9dTGSUiqEODdOK3VxWVf8i1CbpxqvAJ49+L3JGwDC7/LYXJznhmcLH+DN0rgljwea+hjiTLtDfhoEwkZtIKMJHZ/tdTFUzCr26p1ByyESAaf6jmrT6whePjfDJwO3xuuSiGKLz1o9rZ/9riBxenuOIiE2hHVDEPuW1ZbVc6zeOSl9FhTLroKXxjE8ajFcBFl5rJx7wzYKCuq7X+Arf03ZcWj5Aq7pIpwPGWOkbCyJYV5OvoTYDMpoi9SPqfWzIEiFZeLdRVfFMeBEgtioBCNCsxVIs3LrUIx1KRRz1fxx1cnc4Jv5Eb/kArokT21ALLfvvQ76Pg4T3PKaZ+f7LyHrl6+OcsMk6qIn68UrrGNuvCAfPlpwlyTPm3RGsfmgkqdPnCyFMXGSnae3wQW3dkjnODrrPybx5Xdb1EPVMQFUUhBySRHoPeZp5HJNsLHaTLIOTSibnrzHalw9jj/Mfnl88HnOZWFpJqOvHiEq5WhEaljcp4Nh/hk3dGstYl0LOcA3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(6512007)(2906002)(8936002)(6666004)(5660300002)(38100700002)(44832011)(186003)(107886003)(2616005)(86362001)(26005)(6916009)(66946007)(83380400001)(66556008)(6486002)(36756003)(8676002)(316002)(4326008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYotIJgpXDyxCcw7Erq1pNjpBGVxZdsB+QkGpX6ytHFcMNgVrJYH053zXznK?=
 =?us-ascii?Q?NHfdE+Gb6l1O+7+xFmvsXihW1NSJyOu9NNWEIPvzmauvK7hGCmD16f94jRXX?=
 =?us-ascii?Q?5lwYOarC0O0TusLmBpn5LTe3ctK4pqEGQXb12r7aTKrLUBWBO6pYWTGcCMjo?=
 =?us-ascii?Q?muhoA9p+6EkjPSp7CfIFXwX0PdW1TOlXrRkgDfA9TNDuoFXCwg+Vi6T9zj6p?=
 =?us-ascii?Q?Hmo4mibrw98GvW0wYYh/gLFcvDBo8bySnUkSiXWcrAr5OtVUAifC0a4A/ygM?=
 =?us-ascii?Q?I68wG3Z/g5HJzLiwgv3I7sf+fry3QPj8OxlCFuYkGD9AGx2bbKLSdNUPg3eZ?=
 =?us-ascii?Q?au9GaXRwPMtcAYYcVVoHtAObpLpQ6o82KQDGc/YMqrN/vGMxR51wG28RKzU/?=
 =?us-ascii?Q?kZnci8TheFoxoPNjB+KFv4t7b/28Nwp3A1oMB5CaQ7qskaSdCttHUQZYhJXG?=
 =?us-ascii?Q?bpKXj2twQuW09iqwAQ4qHF9r8k7ruN1FqduYzmRhhmbrwzpgaJ1Cra1DC1fY?=
 =?us-ascii?Q?IiAt0R9b5Ea8sdr1bmgjWjyGKdDsY72/SxUOz8vwuuVOC8S1K/4JoImvK0r9?=
 =?us-ascii?Q?mu1sjsf8bv8eHdlFO5CRAECoq8LHMbRr/+re2QZ12Y50d8OR6KKRDeyc5VCD?=
 =?us-ascii?Q?oFGO4VtOOgyhRUQz/QhJvnZa8imtEsnpE9kIIr/RoUs61Vx80BUMZ+D2CUmc?=
 =?us-ascii?Q?gVAdqTnQc8DyGsMDOQ7opyvJToW5hp+OVDeB41RdRr+xIq7ueFQWyVx7woLj?=
 =?us-ascii?Q?pTEBH+hHLzWU8RfdpJBRgFSpnWidRnN4leoLADDXlWt7g4QyVnwW7EB3EUgB?=
 =?us-ascii?Q?tjk6dGIhPx2ZjoXHymq/GxqIHt8PAJU0SmS9IIuw9wDSMm7CtXRQTlDsG7Ei?=
 =?us-ascii?Q?gpEDfCSVk1Mg+qMnqGrgsF3Eir/Tv/jyLXt/jl6aFdTC5x7mGL/egVqjBn+W?=
 =?us-ascii?Q?E6LPgm+maUAT8XofbQB4cCpGZ4/TeGkTlFyJItEg+e5woJgc9f8H9Icea9s9?=
 =?us-ascii?Q?e3j7+h38YUucGkixPLSjX/4uFtsLRJBW8Tcaf8S+Jn20BMtHeDZXnnqScNn1?=
 =?us-ascii?Q?6Hozwb1lFusfrQdXWrqbpYZMzpS+O2+n0v8o0dih1UMrISiDuY8L14vr2wgu?=
 =?us-ascii?Q?FPm4YNjBMjaFemRayJ9srsS3uPmksIqgI2EuTXlb5r6UToggtuBm7Oib2FX+?=
 =?us-ascii?Q?2+0cuS4GgvJ2FNe+QucZ166rjmi0eFxqEAAb4/PyZfLK4RsBEG+DJNzlGWWz?=
 =?us-ascii?Q?YWaCWoG19s3CjWq007KRMN9xON9levGF2mcMgR5qhJAP8ZoR1gfaHvczuoz2?=
 =?us-ascii?Q?LIzlrEWSGwRLoMUTxPwDgh4RtZI/UBz1KIcAPw3zPheF+mmwivHW+TeJMU2V?=
 =?us-ascii?Q?9LOoJFOcrjq32ZB3DF6tmpJSiGICE1/B7S0PUcoInSW5fcUGhGRdagb3+xlu?=
 =?us-ascii?Q?XofGQPef5JHT+MW4bOiJWMJtsf6nN0M1nvRJlVFOlVOrUYvFy//74Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5de9fe5-f847-4e3a-01bc-08da0d9feb5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:32.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbCKbaMd97Lw8EFvgKaeshVRTj+RGtPa1poFu43PEWqbgMNp08A8yASgd7yzkqeoi9oZAkwCKGbpaIOXDkDQmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616

This patch added a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 81b77ade9511..c7969b9b567e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2661,6 +2661,8 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_init_sched(mptcp_sk(sk),
+			 mptcp_sched_find(net, mptcp_get_scheduler(net)));
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2816,6 +2818,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2993,6 +2996,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3e69c1e5600a..ad45281e8562 100644
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
@@ -617,6 +618,9 @@ void mptcp_unregister_scheduler(const struct net *net,
 				struct mptcp_sched_ops *sched);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+void mptcp_init_sched(struct mptcp_sock *msk,
+		      struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f6ace8cfe865..e431b1eec5e1 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -122,3 +122,24 @@ void mptcp_sched_init(void)
 		panic("Failed to register MPTCP sched pernet subsystem.\n");
 	mptcp_register_scheduler(&init_net, &mptcp_sched_default);
 }
+
+void mptcp_init_sched(struct mptcp_sock *msk,
+		      struct mptcp_sched_ops *sched)
+{
+	if (!sched)
+		msk->sched =3D &mptcp_sched_default;
+	else
+		msk->sched =3D sched;
+
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	if (msk->sched && msk->sched->release)
+		msk->sched->release(msk);
+	msk->sched =3D NULL;
+}
--=20
2.34.1

