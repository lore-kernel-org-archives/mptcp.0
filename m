Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089715B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyOeEE6c3onzqLJHdAX3fwC7e/j3gCq69YJHJ44PI5U=;
	b=mprLLgr2/WA6PzFuxDozZad/Piwlu/P7j6cCCM10QLEgKOXluCx1Oto9GMjhCVEY0ulgvD
	J5ppOpQoQUWk9w6QKgLPlbapITSYBCDspBPe3Ri21WuxhkBXVmwJOcMgNaodYEDZS/MJAv
	yCRKL9+GrXETolTOwacP+pY4i6mSRV8=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-72m-NwKgOUKgqDoLQvbj9g-1; Wed, 11 May 2022 09:57:30 +0200
X-MC-Unique: 72m-NwKgOUKgqDoLQvbj9g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNEwYXA+g4gGzbizxBsACTw/GK+Ei2EtwfTjzJzM/cXc5MrRjFZkBwNH+OiL+uc8WP3Sf74L1l8dkti3eRsdWSxNDPJeNHC6SpahjxNz+ey/ugPPYC/aW4oiGuq1zrMNkf1l/DMiKzlkhJ6S88YmWdJGV3UJNlxvKn4kcG2TC8QBPg1y2fFay64OI2g9b8BJ42XXgvxUHfF0LpAx/hzP71Va4N4jjAwKvb/WMCOrW203gpXCDvverlv36xUw15xKXXNGc5LIqzQmMt6X83gxTZqSssx3L+5t2XTqUV+LrOqMWCqFS/Ssf56Rgr0Q/k+YWzHWzMv45gyaDbQwUvmUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMZHbDtevsFKUd4St434GtrEtJKV7jhN++tuwH1OfBA=;
 b=BZ51x6KVsIk/5xKhtw+dG7GgK/oy7HoNh7Zv6Tu60zDwHSSeb4jRoZwPDS4FFmLGUg7HWkp71mwRfUwps+mWo3iFy+wpDXIyyZyHYvU3cMYJJubnWYH36MsPbIzs3qqhNMz111VMj1xFQcoBJOG62Jf/JdVKk3a8AWo3RAIBN4sssS7i0xgOtl3d5sf7/YkTxQpdsfOcOBOKG9rxgd4pHPxaYbE3IhKSm+wdn+TupWZ0zTTOUrh+HmCjPcA8x+yZtKXlxHEoX3GvHga/AQ/msk5gu5JAoPwRgLNa4FGmKC9mEjAUQZCe6jPf2fSp/0VbAdCkFY0mlZe4LRF1qPdAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB6169.eurprd04.prod.outlook.com (2603:10a6:10:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:57:28 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 10/14] mptcp: add sched in mptcp_sock
Date: Wed, 11 May 2022 15:56:16 +0800
Message-ID: <7efe233b56090944ff2aa9e46f349c6d40ed8f8c.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9587474-e38d-48d2-fb19-08da3323e500
X-MS-TrafficTypeDiagnostic: DBBPR04MB6169:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB61697DB426B11D8571A4ECDBF8C89@DBBPR04MB6169.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yWaRzZWeWIs0c5/8822zyVhMKHfu1Oeb+riSUS/6ZTjqm4k1GeWdZhISt62fF/Sjqjop0Zjh+9vMzVQGC87XdframnLPnX1VNz4iOZvDvsKViaKT8PtouUR2XeH7j/02t12FhBLh+RUzGxppL4qQ05P4GkFXcbvlKqpY9xBWSD74TeA/YD7dcoPdUTGGq/B7SAJjFNoyr+UjMKRbvv5jNlx3Nw5CtMG8k2GC1kMylY0rFO9cEq7AmvvUEVkO4LhyswLnyKIWUXuWxVept/iOHQUS9Ef7F9MpLmrkTAuYWCN0DFqMgasvGMC83E/fYOWdXkMnCB7JqtQDDgR26BiJ0HSTVMhZNcEpXgsW4CaI3aMHfQL1o39sMLO334SzbcdBiiRoRx1lWf1uEOGPqmee0FGoa8edw/QhMgsMmWuGGluEkAsXU35i87j9wKEFUPCD5AScvbP1+JU1s5BdKkuM4hBKFoTbg3wctFxBPRAtx/CtJNLvEswl69u/r/SekF0lnU7ouuiP813CoZE38znAfiOPsQe3yb3ZPj6x5tXaG0KQkowhq7Um/Wh9GwY2AJuIqw7g8c0/HDc7X5SaRi0Xw2glsslb1XTcDaZnFQVImkczgA9IrxGUK3w6ydPU9cDN/IpkTJKwm6mVc2YX8FfysTkQW0sPP1o6hy7yzGf9PMWs988mmt8Z6/atHmcf/MKi/3mQWwdbI0R1zwymvaUwEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(186003)(5660300002)(8936002)(6916009)(44832011)(54906003)(26005)(6512007)(66556008)(316002)(86362001)(2616005)(4326008)(8676002)(66476007)(83380400001)(6666004)(6506007)(36756003)(6486002)(2906002)(38100700002)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8B/azaHlP2QbANsXXNTx3LuCv33GuEkybLyiXIsD92Xi3uXSaPsx6ONpKOKW?=
 =?us-ascii?Q?strG1JC8b5t44m/IDDvdqO2gWVudE+nVOBEBv/xkpbzWfB4QCz/4LIPE8oi+?=
 =?us-ascii?Q?cXvR8lLlCihyXB5Iv2029btJWnjLcWr6b13l0oX13d1QpNKPSD+A3iz36Oqr?=
 =?us-ascii?Q?Ov9QwaEhvhFmL+T4NU3s4WhXiivXHiokMEOzRqFVfRImhgtho8SU5zrnhcFL?=
 =?us-ascii?Q?CJTzY1rhAYLQt3d+Mcb4yWPAJ9UAhlKb7a2FafrN9fNVXYS66xnW4pEIENoN?=
 =?us-ascii?Q?mHbhGQ1cXoP1KtbIyXzumO5k4R7OKUNthSlLnR2Tm7A1pVut5kQdY/AqdgJC?=
 =?us-ascii?Q?OZZy7n38CtF3RcuILNccCgsZ/jXfCfJdSSMLzj+PXjE0UjddMCp/4M63Z+mA?=
 =?us-ascii?Q?ev3Bstal8sLDmemKIAfMlCwqyyijN4mYIFGYFzFTDe1Yhy5McFqIntY9MdNS?=
 =?us-ascii?Q?S9mS0ZkTlq6EWDnHpH30AVMlnnvw0cgtChVVh7lZ/IA5BqMFg1KIlmZVuuY3?=
 =?us-ascii?Q?uI4n0cwU3XjnEktkMW4YMQVr6jm9AW4X6MD1dLfrghPbj0xxQFyP1ooDeU2Y?=
 =?us-ascii?Q?DmsGJvGpL5Jm0uDcuXPAQfUdX73eVgI2Sttc4sOL+iNuYKbXoetnZ+WLyztd?=
 =?us-ascii?Q?3RyHC1Z053hIXKIIMv7JKPr9+cRFACqfijjA++NQJBKpqEii69A1NP34X0iw?=
 =?us-ascii?Q?nzjtgG7/1FDDPDfeU4uiNRx7p9jqWt7iuTX1kMHI1ccryEo0JWyGYdH63tmj?=
 =?us-ascii?Q?qsbkzldazM2A+xT9Vih5lGD6j+9qcYIVlRZ56jcUPbXm6syykfV13k7ORHjV?=
 =?us-ascii?Q?ANUiONKdhEg5d1bXuERL3Tpb2L0WDxt+GEYQ4twEZ8x3K4aXZivuiB4mCjo9?=
 =?us-ascii?Q?3yhQKlxSzs5ZNExL2E+eairxi4vAqeQ6hJ14/R4ich5dxl3d0fHtxXSGKoEi?=
 =?us-ascii?Q?k6CvA5zG3TCD0Z5qXz/PQyuFeoqDKV2FKk9jws6rD/MUU4bNd78VeN4RlP4y?=
 =?us-ascii?Q?CFVvxQnQ+uiKQX78A5UsuH6rbbrwqVliVbOM9w7pRttzTRuRM3cCDxm6L6E7?=
 =?us-ascii?Q?9WA5M4sQIK++Sqn5G5Kk+3kiUF+0cyfbyreW8wPjEAv9jj7yC7S9w+Wtes5U?=
 =?us-ascii?Q?SJGd3+fSw28o4xsfV+1VzEVzo/Fpjkp/DsKC7tcB+l1DHI0FXxhZpzvo8lBY?=
 =?us-ascii?Q?Dv9lmn3QBmmgHgynV/yLNvvzaK2VAS2bf0tv+hr7N61dDFNYipYP61Ou3Iwm?=
 =?us-ascii?Q?4dqk6d/CZkY5PO6rxIjluDJxjR5ahSkRJ7j/g6sPssl6Qry5xmneYvbdu7Ia?=
 =?us-ascii?Q?3p7wbcS5+w5BZABFfRs7vnOuLXrFwzk8RNUjEhWWV9FRf89iKB3I9gFk+fw7?=
 =?us-ascii?Q?1OTCy+Anvmcnx74SZc0z0cEeAHQsQM1FzhwstybaL8W7fv+8GogrEASii/Bm?=
 =?us-ascii?Q?ShZnAq9JRMmHn6Bmfb9yUx8xOTO9JhgjjxTHgZJXjUMqt10JprTsn3Yef0aH?=
 =?us-ascii?Q?Is94WBra4W7WNisjnU9LNapfpu5YKmAs8+6kx7sMIuOWbGt+T1CV+mzxb+/f?=
 =?us-ascii?Q?1WLPJcflbVDLdEmBAdKoh3Ksx1sPk/mEkHAYt0OfvZEzbkhsyMnLkFxXCZ4n?=
 =?us-ascii?Q?L3aZI7XiHTAjhFT8OjMlZyLV2qmPOKgbQcmJAlGQxIG+2y8zJdRQPuJiWJoD?=
 =?us-ascii?Q?/5hmR8rdMZSzubVRbHVcHNiJXrI3uetWLvKGJrwlxdErBySN2G+302aqqUg8?=
 =?us-ascii?Q?+tVU7xQSrnfNC5+IEEp/l0NRq4R+vZA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9587474-e38d-48d2-fb19-08da3323e500
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:28.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roz6SrhcRiaHa8D41EAZWF4BCHMQjo9ITnGiCwia2ZWYOnndBTlrogy63Z/m1SY0DUcy3ahzEW0PgHugywP4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6169

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
index bca318d2cc78..e17ce2b856bd 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -253,6 +253,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

