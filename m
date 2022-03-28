Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6487C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2w01P4Zk1W9NsyM37E8rvHAw8MwKMsuJF3zjIdqssM=;
	b=mjWL/kzIYFl+h4Uzk0R4EPtBfFz5PJWFWiz3b7Cq/saQ7jlkproZgbVJDnV6olj7/0kky7
	PVzwHIzJ+mN5oS28d1skW9MoVNfCSXXoJ5SUD2wIzoLHcYW88RlkcDBjdyI9U/ZUxZSaPR
	VkXiWd6s76OrzKnHR8h9+ahrmjiEGu4=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-wDBX-yOkMSaoUpsfUrc5Kw-1; Mon, 28 Mar 2022 11:38:29 +0200
X-MC-Unique: wDBX-yOkMSaoUpsfUrc5Kw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O99fuQBNgVlCfzbXZl7Pfk5FIDQb/ZbSHggsEPT/UYkV70uN4MHU9gLRC1tzbsdGxUCAbiiRTHO9+T9eEU7GX2xeq7HbBV82RnZsehqK2Zv9aHOY3vWPb3fDJyx5aCXuAT1gm7YXHW7vGtSob+QgRvwWax+45xgVOYNoWtFfCFR/yfURbhg7kQgmgnLN1bHnd+KwLk9eBJ65rGKZrUUHo9VZkvUB8G5Ojb/uvetdaCP8OUg+85FKVgyAJ53gZqvkCVGaBxhYuWY32ZE8cB98wrGyprBFzAoM1HXO41aTDBv5kvaryvXNyO1SG2HaA8V/lerf1G7i5nSMnkCiAMvffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLoodUEu3QQnqSIAdFgmDyTem0wHMvlACazYP90bCNs=;
 b=AyeNpQV8fdxXoedf2zmo5LNcWFJK0Tq2jB0ZXdJKGUOfZi6g/gLPozx3A+4TgZOAcYUOr2gbpqTkPSRxqYVAkSz8RuFPl6sRc6j4nRxTApTu1hbTbb8zx8WAAMfnq17uxnpKZcwFS2nmvWkJ53/N3mJJS3ElN/iaUjeNFH0Ctz23xffPTp2IsTc+cQqgUyh/ursae3izs5wpD6Fyl4VgcFXPR7eKKdEQ4zXdIjrMue4LusgKmhF/c6fKFMYKuMZos42NxVLJvkIyaAXgB4/462CZ2XLy/sbJDYYiU6CmvhIZDjexf+GMcTN7VL0V96XAZ9qcyoLTYVlXPiJjCNB/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 4/8] mptcp: add sched in mptcp_sock
Date: Mon, 28 Mar 2022 17:37:58 +0800
Message-ID: <2812381119c23048dadbf5372293c724ff4b7970.1648459865.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a181e5-6efc-4ff2-7cf5-08da109eb6c4
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5067B389A4D31EA741941DA2F81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WP/S+GxNO2SbzFung1ZJzqNmWdDyMxXJIvgDpJdqJYZOzXY6suldXPHn4estdzQSgMFBENp6sshgsZmt0l2bZwju5i0sL3D84qd8vd21DYhWgU2d+cpb/EeHHevP7vkrJ/MmwiLp5l7y83ZpB/eO3KWH7BEjYx7QP6sK8b/qtKR2e5OG54vrmOCcKwiPZ/pyFq+6GCEzrh/uMgW5vROwUfBAx/1W66SOSUf4o6hRPS/nizx1nkTc2PM45Tewm/pWoairgCaMuBfpSJeq4tW76kvbqN+jTAl0sIu36um2t/ZSg6yn48evrhPi6V214ZhI6AFsZDD6XzQdWDeGVZS+yvcVy726qlVebN4yCcO5fOWRIxMc95FQxBk1ujPQDi1ytPwncwLunDpCN5Wmz4mIq56Za+J5QLFPd4KAuqnsU/YRV4/C2Z1te7Wmf+mRVoLNob1nLJLiYRZQJv1AHVwQJOrP14keAu+vUFrudGcbaRCJkz5G2Pzp3r534Fz+0m754WYzQbytIVTszi5wQdDWXHJeP20TdFcwEwLfeYfpOnVQRBbtPpF+pFUzeO/pmpksJ8lyTX7EGVG9W3N1JdmWgjaXwoqKJJ9MkGGfqhu8YeDLcwlLd54DH2JnMGB70HgqFJLkxh8l6n7yAHTt77n94mTV/hsnTVufX9zvxbX5ecgQOLYogN3CyCLuIS2p8M3g8lZT4V6xbGtMjNjVmzHqaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(83380400001)(8676002)(4326008)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXxQTsHWG/rR/vwrJdN0Q1UWlpqjnL7pwUyhlZACCcL89gD4KHJQYscpQNl8?=
 =?us-ascii?Q?f5Cgk31Z5Ky97AaXvpJ7dSK86NyqODms7tauqO0NERw/Y/qcDMN5xxqTJ3R4?=
 =?us-ascii?Q?p2v57Ini6WYhYJwBjnP4rOazTKKHRJ+TmpBIYZGmquPdAHVAzCNYjSctr9YC?=
 =?us-ascii?Q?dZLVLkyMosK3WxQ6dIBLAMjurslajox6qE8+npai0hOS1BSpmYBmLayMbE9l?=
 =?us-ascii?Q?fxw+WhM/bBjvRVCfhP++Zz3IdY1wmvmyG5+27rPjXs2wgd71V7Q1KSLPeAji?=
 =?us-ascii?Q?EYZimC9uSAIwaa5VDwP3vAH3o+/kHu6pe7zSwhAz1bLPJ6r+RAwoSWCksILM?=
 =?us-ascii?Q?FsDdieY1Y3qK+Qp2D2ixB+3opMUNTcFQxImSqP600C8QmYW5+Fr0DP7tj15S?=
 =?us-ascii?Q?RcNMIwWmsx78FULlYu/LvWBgI+rkdlTuYeZAbHTmj22Vn3E7EslaCW7N0a8t?=
 =?us-ascii?Q?mKeah24D56RwwMb0NVxHzgHOXGx5/3vt+yPi4vXKBPU9IxI+qMEBNxZBZ0bj?=
 =?us-ascii?Q?bN+DnKljCz28s2Nf2De5IyqLsHZrQRnZi/jhFbjkfcCYonBHUiktzoxlCX57?=
 =?us-ascii?Q?rWLE+nopi2WIh82aMtRqhdj1WslFPFP31fWnxtLl+eid7P9rzz8TCbP7puYC?=
 =?us-ascii?Q?jRkZ4IQNNKEAZcv7Nojgu+9eR5I9ppYEgIPILaRmg8QBAEyyg1rrVtWwL7Kt?=
 =?us-ascii?Q?JYSuh11ohR8Cq6pDP5SFIUkkerkRxwCtGof9GsZzhQKZYYly0ZjvUnO6TJln?=
 =?us-ascii?Q?ZGD4AqJ0dxW3IUj1aLIHSSaVxGSeJvTVgnbed35oszY1jcMmQGVDFW6ttPXL?=
 =?us-ascii?Q?qwXaqvsX0C5V1LqujfNKFkDJMo/rdVOX6ZqcklwziYM+XFkwCAnw0Se6Ngqz?=
 =?us-ascii?Q?AZALabAh67tsbM3XayOb7KnkN+rEJWhZimLuxEtcMJj+jqC2a++kE7NHSu/o?=
 =?us-ascii?Q?IwtZPdqwKQVgvPns0eyap3bk0eBTOsoDwLnIkpmxgi9yrGMbCM/m6cIo4SEi?=
 =?us-ascii?Q?kMXiMZYqN8Ak049TwP6URweQ34w5WT9kdLQXR8lHfVGiz3905n8955VYvLp8?=
 =?us-ascii?Q?Wq+PTDklHjfcIAYoQMTxt+qimVaYKDO2i2KDdssS9bQnnebrcyQZOCCnUySG?=
 =?us-ascii?Q?QE8MpLQkLE7CZXB6VN72VW8+VWuFvpC7pwqaeMHNBC3DcG9Ik5IKN76QEE18?=
 =?us-ascii?Q?/kSqfYv+vMs9NZUWP7TuC71tY41wcLiNi7mlYjH8fDOEEoUuvEUJ/tPrrU81?=
 =?us-ascii?Q?x8fkbUqA0m8+ZMqOD3K2e2NNJwo/sshnXtxrpJrXjMzNmbjQYWhFjyVRmQ3L?=
 =?us-ascii?Q?U2R1rE+YNim1TZvM1yPzBDSRzRfnAAqXSaDcRmnxV8vZaRjyyD7+xh9rtMSo?=
 =?us-ascii?Q?IuF9wqJruSLluThUZPKm3Lykl9zA1XgDqJLbqeJ0aKz/2dd5qYLBL7nngx6Q?=
 =?us-ascii?Q?1AWnlTNmt6hc3SV5SAh5NVp4q51QauGSLX2sK2UC4sOEQhrotu76B87ElS7F?=
 =?us-ascii?Q?3uVWgbCbnQ/umvgasCtmQwSy1J2zzDwI+q4ga+t9y3+iu0ywBBVanC/WUvQd?=
 =?us-ascii?Q?twk4utPHkz7d3qDPA4LLnD1q3ivMb0xd/yGTtnGPiMeKbK2FOGffwDI7gywO?=
 =?us-ascii?Q?xwcerdE20x4VpjmikR8saScfxb7o8qxbYwgks1MFlmin+ZIlICqVZRPVkji4?=
 =?us-ascii?Q?IKx8CB18H5D7/+iN1uv2tAqd1xa1b/qzd3j5sFHIemIbwG3PK5exmg9B53Mi?=
 =?us-ascii?Q?H0ITuzLV4lS7kjpwApJ18U8lUtFQjsU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a181e5-6efc-4ff2-7cf5-08da109eb6c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:28.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMNoXMr/nRW84D+n77aFvx3+na6EE8alfuZn1n0ENGpmgD5BZC9jUp5G1i7wGnmoEq7GjBmHGxBSPwnjndYEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2c684034fe7a..82b3846147a6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2662,6 +2662,8 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_init_sched(mptcp_sk(sk),
+			 mptcp_sched_find(net, mptcp_get_scheduler(net)));
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2817,6 +2819,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2994,6 +2997,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd4a2afdb38b..81c35af7ade5 100644
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
@@ -618,6 +619,9 @@ void mptcp_unregister_scheduler(const struct net *net,
 void mptcp_sched_init(void);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_data_init(struct sock *sk);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1fb3dd24d6ff..9b3a3157111d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -125,3 +125,30 @@ void mptcp_sched_data_init(struct sock *sk)
 {
 	mptcp_register_scheduler(sock_net(sk), &mptcp_sched_default);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	if (!sched)
+		msk->sched =3D &mptcp_sched_default;
+	else
+		msk->sched =3D sched;
+
+	if (!bpf_try_module_get(msk->sched, msk->sched->owner))
+		return -EBUSY;
+
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
+	if (msk->sched && msk->sched->release)
+		msk->sched->release(msk);
+	bpf_module_put(msk->sched, msk->sched->owner);
+	msk->sched =3D NULL;
+}
--=20
2.34.1

