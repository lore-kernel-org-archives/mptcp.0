Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880415B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Lf39A5tikAIwxSqLTq4iWlT55z/CAiZnlAUzwxr7nE=;
	b=XTbR69Ip2jBnno4FXI0GNDwKerGAjbxc01vP3n+ywotSzhyNkc1CDGkGYvFyg/Q/WJR2n9
	/Br1df4e/WSxnldXD7lUl8y2bvEdlvTGlGJG4QV97NHSwaKlQtfYq8WeoA0Wusndbeicpm
	0GaWpTxpG+jDgQUeMVEt1omskfERYus=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-e4QCW2-gPD2Y7SVg5XHOGQ-1; Wed, 11 May 2022 05:41:02 +0200
X-MC-Unique: e4QCW2-gPD2Y7SVg5XHOGQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScezW6L+dIkuTVrMs2/iMPe2sxCkUcfFtjZJLFpOFXJWZ8JZQ2kQk00mr6oqg90sqbSiLgY+D9Y8IkWcBFYA5h+aUDPBTnsrGOvS/Xk3/eq9VsgtZPZLunG/Pn25vXj2gM+SRgpXLj55EZRq8OY0a+zp/2Tpqs3CYUb1gCjQw9c1qCROzrcOvu+a258gAtQeJST2yNBzmv5rAYaDrssfk7JrhOcUz68iVa7aA4oIqzY8tTX32hBR72q13IWfYcLbjsJv8595hdqNrTtsVwVtDH06dRSCKh0eLFPW+p03tRdzB8UnPWKnP9ABjKMjqF7k3ZH9uBXae0nmjzr7gUEaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D2H55MAVqP+2N9JUuSrSf1CprXJ+JM3ahdFHrWnd50=;
 b=RqOEzfPiZp8E1nIek+PnFaHdkpO/PjSyLTXZQaQzgb9MVgttFjQ4Xk55xkG1He/ZvqEXI6Cb/bao1maqeDvm8DfcLcDMCiE6l0gO6zKhxSb73xo0hcTXRsICkcpX4BKjLHaq8mbXxpknYVtS1e3bS5dau8o/SmloZApA4KlgmUksUa/RAXSPCdtx5DjMTO89bOiwF/fbxcgtaVS3t2HdQ7RSw+JfN473i7AFJQB/ywMg0jkxRNkFR8bpk2SXVCW0JwG4B44rDZZzvj6q7DmiQdLm50rPC9OmRZ1gswGZKRndvgyg1F+M6AXkhNDO7VJtFL2A75I3I6A4L3T1OLWUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:53 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 11/15] mptcp: add sched in mptcp_sock
Date: Wed, 11 May 2022 11:39:12 +0800
Message-ID: <8bae46e5aedaafb5f68c87fab1e8357dc144b7e8.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3db8dbdf-0853-481e-3e87-08da33000c88
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156A03B28E835DE9EE4AF3FF8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O4irHDkEU1gfaXrFS4nZ432V4FW2qQH8sIGJa7YMyHhavg2uAu/flKo8OXYusBjebUzqlYdQ1M6zoJXUwoKfFSJhRqNZtVFizNXnoDqe76P9m/Duxfm34DI8ezZoN+gunEuxADjACj0BhPVJblVDbQSI5C8Wdk8IhZF9TwI6OeayOmCy76ABeFQsvzcTeT3dH33NUYWoFchBBdx2V1Lb1VmWhtF4dp7w+dHSHga56vV0IBXotbViQL6TUud0WO+9A1GjcL7ezDk7l0dlPVPiXiAy9ebPurgR9P5A5LKzB+OkBdioaPygmhRayGBuntPbs37YIGKqmVe5KrMw0u6CAFPrF79Cs5EH7VYdkmE8TfZBCVgpPshhArv7k2Hj2IVqfLi74SPrp4yorGpMICxH6oYlO9gaoEc1uFheez+da3YypoiP5BM3jkV8zNhvrBR5JwJnoqivxxGqplSA4Z5Na2pKmnTcKwVv/ik79MuxTSO57trjU0C/KSJn6BsC5kyvEkhBpeiIcuZusf20HhZfaySW7ZB7ATLehT9lmnlDS6kacTKRgGWrPX3jUguKC4Y8m3Ltm5+9cyJjtQMyOgOJRuAEJAyWuvsdNUBM/1YQ4pRJGzHSeANS5lPIJxN9iW1q06VqNKnkLnRMhukZTtztEuuDBfY9lCXQta2Hj0P0gRMY9NUoboojPgOaFb7pdvs0PjtYI3hB6N87925cNgYAKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lp0Uvk1tIlffSqGeO+4u6AGHwD+cfn0Qhb3ubQtSEGnnGk+3ucwJ4nIE62DG?=
 =?us-ascii?Q?FOUq/bF/RUIodNK7rGj6raB82EP2AmwVNwmATMt6RvtKiRN4tnOSfElGeOpU?=
 =?us-ascii?Q?dHHflf1Ej7YQkTMVwDLkHdqM03ZmQC/Sg7kTQbUytW4MLtsq47kksH1rvqqj?=
 =?us-ascii?Q?oPZERkf9Dyk6mKwjeon8csgN9lvW/4L4YGnxAufXwJOYXv677Dcvijz188A/?=
 =?us-ascii?Q?s1z8U3twc1XwXjL/B+1hlyLve3QLJy0AiTrmPrlwLe2SPYMXsRKfnOkdvsYt?=
 =?us-ascii?Q?fFAImKW0/1DwY7HJ3l6cgMWConIhbqsVEDSBzsXbbHh9PZrAFncgnyq1QkB8?=
 =?us-ascii?Q?T2bPFqPcNpb4g3o06mvl0oqYi/pPLZtrbDRl1S0PrDYRk0IEum39gfkbUFv/?=
 =?us-ascii?Q?0CglXlpqVmDmKYFNPQz1vQ+h7eVV5l6g5Jdy00dgasV1sIF9mBGFEy63imcF?=
 =?us-ascii?Q?H9x9Xk6AidZD5vjd+elXnXENOPlhKJAdet9IgVPW/zQJIgMCM7ejOAxrOJww?=
 =?us-ascii?Q?mJuHETWgOW5o6zqFHoM54LXX3B3UtUFQxUTlO0/5UGpT7TP9cPQK01SuuDoq?=
 =?us-ascii?Q?Y7SXrvKworfC55xC84DngXZ7bxeLpE8okaoM1LyfUMUqhjCcTiFgRoIyslJH?=
 =?us-ascii?Q?gDX55XS4O4EKQor21tsHFAnw7R38IsrH1UD8VrSjoNKXzjxTinQPrFZgYwe9?=
 =?us-ascii?Q?Sb7gj5azVa1yvAcCuV7AppfpcLyOaQlTGEk7QcpirHZLGquSInOHLmEysexR?=
 =?us-ascii?Q?Fttnaa+fKhtJVQXxKWLpiR1RYKcoJUc67RJ9GGOtCnp+8R1X8TglmvopvWe6?=
 =?us-ascii?Q?3ijV6GaSGaYhNhh0W99v/oGBThhIq1/tuzCp6+ojgiPEQHtxWYQOFO7zi046?=
 =?us-ascii?Q?4W5xl6LfIPIaUfIbXGjAwcnjcDB/EP+FZ4ZAXnpjurWfRDMXFtk087V4Bo8c?=
 =?us-ascii?Q?1WT0ZPjLhaStVDxXAp2YH3iLAz/cArjYphC+onsIZY7Nii9++273PSdkvhlt?=
 =?us-ascii?Q?hLNyJ+VyDBSbzngy+xjDx5zEgF92q9/pYPzua4UeOewoO1jowMoWvnN7/nPc?=
 =?us-ascii?Q?IvAKyfodS3wuhKpPCCb1dekv0RYW87dE6ggYX251Z/pMg4WeQYwsSx1K9C9E?=
 =?us-ascii?Q?8Xy0G+aU7jckc4IsjT/vuPFeU9z+Dwlt+pPTn+ttA22CvQoDpmqs1YzgC0KT?=
 =?us-ascii?Q?ph3Csno4lMpmZn9QDDtcILfUogn7hvNpjn7mAQzu4c3fvfU58YHjQywsrm9g?=
 =?us-ascii?Q?cCmp/GeMQEJvkPTuNpcOsHjqCcVTFWxbE/gV9D/u9sGWX/SKuFKm29/QoBGH?=
 =?us-ascii?Q?bGyu+jiov57O6k4kfC9kqnY40tFeLPWSaeoMOH2xiZm1hnZmfitcjpoi0FCd?=
 =?us-ascii?Q?hpomVodCqqk5aFR7VsDfbhbBUHA4BRV0rM1UlRi0BtmSqMoIe0wq8DVCZKjV?=
 =?us-ascii?Q?pdQ+KypYVaRvvxIOX8ppWD+K1YRWsHPeQLLFnWt1MPA6p63bkD8pqbd2nYhm?=
 =?us-ascii?Q?0H8S/YONF9cEUPQaYBbtrOE7vIjeE1Q4CGIsy/AVM2MYL3Je2HgIqQtpIuxI?=
 =?us-ascii?Q?3hjP9w8Uyee4ne4kzYNlfihIsyWL4rTNQqCaNbNs96L1A43qA69wj83yPgG8?=
 =?us-ascii?Q?cK9qf2Txrg37yd3GtX7ZH5z8VTXHv38VeY9Q0Rn5aA7LABDHnIqrinyfu4qf?=
 =?us-ascii?Q?ZSN62IZ6Jx55UDp7lX+QaH/rRHcS7u1QDRl3zf3LfCSYu76Jg8ejnYRUQLD4?=
 =?us-ascii?Q?qQsB0zI3kYRekCumh+MQhg2bJTpe+k8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db8dbdf-0853-481e-3e87-08da33000c88
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:53.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59VPjIuvP7S7/5F/+dAbMQM68bKzn1h87aO2SQ/Ks2n/mhwCyJ9LZideDMl+NvpMdNtPaBpZqNAFUntcBM+RPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c                          |  7 ++++
 net/mptcp/protocol.h                          |  4 +++
 net/mptcp/sched.c                             | 33 +++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 4 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 921d67174e49..3e9246822412 100644
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
@@ -2812,6 +2817,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2985,6 +2991,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b52cef5fdd9c..85dd69b8d9d5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -298,6 +298,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -625,6 +626,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..53773668b5ee 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -54,3 +54,36 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *=
sched)
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	if (!sched)
+		goto out;
+
+	if (!bpf_try_module_get(sched, sched->owner))
+		return -EBUSY;
+
+	msk->sched =3D sched;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+
+out:
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
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index ff4d57993e10..1ef66a16771c 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -252,6 +252,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

