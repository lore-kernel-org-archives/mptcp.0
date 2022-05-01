Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79C28EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651412970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEpGrAjMtxqHrtuTTAyKYAfOCuK7cT/SCV38U4bD0kA=;
	b=k3PbONaFNqpU+I57rsHzAAFwX0ES5lQ027v/1bM7SvUHe1GQTqRwFd+sXASZWdwBhui4En
	x3RYWeUSmj/0iUyBZcVs+YfBr+5znDsZnfO4x/3rb+lbwHhVmViCkRDXAJob0E7X9bbm3Q
	slbYfX0Y/dp8PZgMxFh8cCB/+QYSZQ8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-PhMFno99N96MDY3R9xJPvg-1; Sun, 01 May 2022 15:49:29 +0200
X-MC-Unique: PhMFno99N96MDY3R9xJPvg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJBPCwKS5aS1Ff1AIbkBfAxOGIVnelh4460cbtcNHCEvROkrOLj1Vp1NqwrtgEZh3WoeQPAlzXThRDKdqpJeEVwqr0nF15Fev4GmquIuXtkyd7HwFfC8lL7d6BITsNyQH6elKMckceYAyAs0Q6F1linpZ0PNMH5GfYmrA2hIhW/jMVeZuxyK5yRnXJke4lXMC7TQeKhmQZTXCEWk3YgBLd/w5Tj4+YMpD8nFFMjJL9Ic9x37Vqodqfe3SU3PJPdmweryGs0GgjxmmqagJxqi4oo6s4n3sTPgi18ixVMjtMv06eYEQsnljr759SD7v84pETT94zPHWMy4PMWEiPdv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVDObk04ZRDC97g2yFptpU3LNsYJq6mFr1DqHctTNrw=;
 b=RxVWIq6f6GOq0AzvC9BZWcUvHakkpOY2ELGcJSazDo2xU21Jvrz7L5N2cG4MDMWQo5ey5Tuprx0xxUE6MOuZPKSHdpBnxtdOLJQNrEgXhqvvEmgOIgN8YfBTfR+76NvuOmkmGbvAj3MLnB+Uja0ziDt4/UOuDUV2QGJb/ExvskvmxXvSTYolnhbLpEwH8tCAva/2IFZu3wCa3/ssFS/4WG/Ly+4eHoV86+SvbWBk5kljzqL+J4vKRPz/KvuYt5FX/l7WuBWW1Dhmrra4gtD0ZcvEguOY5vQYSaL8WshdFs8o5+pvmMcu3WcxF/G3/TiLB1PBKgrcpUTbX1A7QVzatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:49:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:49:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 3/7] mptcp: add sched in mptcp_sock
Date: Sun,  1 May 2022 21:48:46 +0800
Message-ID: <a49e26e666c522b41bbb34d67d31d404f217320f.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64232d36-bc45-44a5-bfc1-08da2b796902
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6283FB2E0EFDB691180BBF54F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h1f73lV6nfoWqho1hhuYkYYh4PC2RMmWDucYOBUAG5E+JhAYKqifokhaeADMoYdEKgowSskGWtbQ1KPvQ/ltNsTXULY8Xs//c9PRd73FApLcdUsmf1g2tg/EHErb8gjKNb32udTgvA+VQmPqFwFW+XdnWb4rBiZYGA/FtZqYQatj7hTiyGPdcGYOHQ21XkJy144pQIYBm/SfFZiZDvnj2vE+4+wF1P6RIsXo4z5PUolcC1A3bDqVeELIvcbh4pQ3ct4U0JmwMyawmSfRBBRRKwB2wdmsCT6b6uZPJ7EdYmYAQq2vemJgCVM/rOHbynlri63zjfbef7NIFvF0/rYgMl/c6ZhHCDw+9KRRgQp1UkHbddwUWMwGtT+hSjnfoR05TEQnOq1jYb8H5h2KbxtmDbNAxb4qYkoJG6iTDprDc++MfO+Z09jzxDXlkZh5+xncbuKHTz5BdK1aU9AQbPnHT237z+e9vMlyuoVSg9wjJfvJfFGXThXN+moHYgjtYM7qO9wEcNS9Mpokdf9WDK6G7Bzwrzmlju020H+cnJqIifppWhG725tvhDZJoA5zKFrkT1RJifm0DbsPRAE79Uq9ufxDpMppz/rx0K7qftBli0yyepmA/pSAuUANLxkzxDhieNX3Jl3iWUfu2UiVih7YdPESc4zq14r+rFSx+8xchaxNpXRIzAgzp/CuhySJRLEa3PXs6WbjFr1WraWgII8uPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(36756003)(6486002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nYh9aFSVhM5XI3NM2uC0gve3hAyO6872sdunUy4TE8mbxhgXk9TRe6lbLmL/?=
 =?us-ascii?Q?0UiB27ej3u/1s+FPaAyGOoRsX3slis5/WYarLRYd+GAvGNNWR0GZCb/vvvPa?=
 =?us-ascii?Q?YMB1pN1iRD/y1uLFArxPQxn/JK8unERPAEjFN7eS4rOPBBeyBXPzTEemjpKl?=
 =?us-ascii?Q?3cVgFT32O1b0Cpp2RcIIqg9zfPDYhhVf+qwQtbfV5KukLCJOIaYPyv3TFhvB?=
 =?us-ascii?Q?Q1A4qGc6qGDN3+wWtWI2vU9UBqStvaMc4G0Hw4/HeOXSSchWKtlt8/aCiLZ4?=
 =?us-ascii?Q?nZuOOyTvp2hmxTlX/HLlbfGzQhrYEJKJKCnNU3dCA4eDGnEt3lGamgVWKHEC?=
 =?us-ascii?Q?35+FsZP2HX02svbyGsCETrmpXMUJ/a61jqKVlslZKUkfWqBWY9XI72nhhvFr?=
 =?us-ascii?Q?mqpgjb+EAR3zkU7uPRQHgvC/hvZC0U1g1XYeEl72yrcF4XB66TccT7NZ9DmS?=
 =?us-ascii?Q?oo/fe10+1rInEFb+dcSJL3MUg/QGZGJP0Myk73gpIRKOWcr6uNTA0y5a/ZuY?=
 =?us-ascii?Q?4R+P1Tte4wnPtkIc792UtVPnQoci3JUl6jVu50RKBU2q7PVfSl0eoilRRJlU?=
 =?us-ascii?Q?XOLJOWSQRNWD809hjeLjsyguw0kJ35PgY4i3pmmWNDE/kyMo2w56s0R/cUPk?=
 =?us-ascii?Q?XIaXfAyrcXor1mqaTCuAHiuBE7Y3oAHNfR4fTG0StWPUWA4Gl8ZYcF8BeUZg?=
 =?us-ascii?Q?DP4yzcPv1gR1535RIYParUc6Xq/NIIyDBpaTfFEXp3KbIN0e0Hf354pLQcI5?=
 =?us-ascii?Q?nXamNNp/rRybVFg/NiLrKYW2tBWebRe7Jzm75whgCmaxL74DGCaLuYoslaXC?=
 =?us-ascii?Q?mImzvVztJsMNsSzimy9XQJu5YlzhMgbWn8EHYigJFD/VkjY2sPVa9k+zgFH6?=
 =?us-ascii?Q?ruk/hwBJNzRBra/cPUo1Lb7jEVKKMMZSgdPwsJllCGbR68cLBD8vivEuPpwr?=
 =?us-ascii?Q?uWhMmlL6qiuhyl7T5VhzvwJNSD9sBDfyIv+NHRqj4qHCkAQOEUgTKu5WEbkc?=
 =?us-ascii?Q?w8TrKHoeXaKpE9/BtevW8Yf+Fc0vTKZucG4Gz4ioUzQfB5RLrJhTOG8H0RAG?=
 =?us-ascii?Q?2Bg+Z2P4AByMETIisGuUXvaM32wP/dsSa9ZzmlCuYETm1HD4apTgPoV3yAcS?=
 =?us-ascii?Q?45KOJUXFGKEOTxwej0Sm9e4TUIZ3ATJxo7geEiYdrxPNH/bBuXnWHYHmjpHe?=
 =?us-ascii?Q?YNve6/JyYsD7a2sPqN9CQtJRG1+fIXszIny3AJ/lmlx8puxG1CBnGjPI67qd?=
 =?us-ascii?Q?Sll4nKJ8eZQF9lcLUSsf1CgnZYNzz8LwZ8SPo0rI6Dpt/le6iMZuNqz3xSnF?=
 =?us-ascii?Q?1sw+5PqyDqvM6qAz6RUYxgDp4drcOGFhRz8Ts+OzwUOvRwE3YlbPnndMVQ/d?=
 =?us-ascii?Q?j/ZtcGgPiWCS5fTULwOFjLCLj39mnu5I9GnoAOCy3oHgZBoBgDnkFtYmhh4L?=
 =?us-ascii?Q?/PMgz88LUjVNypCAapwD2PVNMpNZReuHRHZUN+SdxF6Oon56bmb4kUkZ6CNZ?=
 =?us-ascii?Q?j+EmvWWnyLp3TsijIqi9Z8fiYHmXXgt2gT6jQN6e/zRZL4TCtzv+d+VlAYer?=
 =?us-ascii?Q?WM2xpobIhcKKNrUrB2CLRW7XiyVMh7K17blZcM95RYABVRR069wvnopajXjt?=
 =?us-ascii?Q?mCxAy2HnYfdHdKRFzvUSTszmKNIBkSLd7tdT7iYyYOf6L5i1b0F/WAG4aZcZ?=
 =?us-ascii?Q?ssclLBvdiGoji6blHCpHugDNU4/JYi+OnVJRDj/AWMi5KPUIFpppKo85ywNZ?=
 =?us-ascii?Q?oa7IDd33F87H4gKDE3lLAx4gYaqOghI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64232d36-bc45-44a5-bfc1-08da2b796902
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:49:28.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hhngMkXDLwyIB2aRG0O3kaAFMcRS0tjaz0P+CDuufQfKqRiadAqtye9lpbkj5r72gNjx8UtYewuOooBYzMfCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c                          |  7 ++++
 net/mptcp/protocol.h                          |  4 +++
 net/mptcp/sched.c                             | 33 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 4 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 653757ea0aca..f599b702415e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2665,6 +2665,11 @@ static int mptcp_init_sock(struct sock *sk)
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
@@ -2824,6 +2829,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -3001,6 +3007,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2f5ad12601cf..723141a888f4 100644
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
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 5b8eef4f1b4e..e863954de701 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -29,6 +29,7 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

