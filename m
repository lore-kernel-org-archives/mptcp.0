Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F315AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b81zmStCh1pHGMbgipJC3nha8ac7ZI04GXTqw7revtQ=;
	b=nG2dwUuFBJMDKgJcpBtQPW9TyeZiluYOgGfig2Q3L8W7FsTnKVngR9mab+r3AK6oL9eK4R
	qHxevbmp3OEYqv3K4jkHxWowH8DvX1RvpXzlbfmJaTzt7422CHm8XokadHmm1a2Vs3g+Ho
	rLdUrl5UAXH4WRKjXyhIrRafOx8NBcE=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-YF8btjfDOT-ihxYZJX1PqA-1; Fri, 18 Mar 2022 03:58:46 +0100
X-MC-Unique: YF8btjfDOT-ihxYZJX1PqA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuZBshbaFWaaXCaDGP4S0U2QnwpLjJdkb9JNqgOceu063waujtT2h3tCS8hN8G3JWQpmWWGddwRGuyGNWDd+FgzUOhxsBD8C+Ojv3CcnIMCTYdYy0qs2exSwNhzVkhtPYJaENgQzpz515mGOjf8eZ1D7AM4PKyk7PIAdiJre06Co5NLTJjxG+BljMDJ1QeoLSmXHDEyAM+IIp4TKkIGBCZGWg09Rel3S3Zjz351Ii+uE6RGEmQH2IOASbPS6XeCAJ+wFek2vI+AKXV7jHRiWvmYCZArCxKggZ1pflG9qw8supXcqFeY/xeI5PHtxirmTQz/6vBtZ8aiRN+iNyWeG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTMduRfphey0P7Qj+nrIa+rQ9fiEIkWolDDaZ8fxYKI=;
 b=hJ5Dbzy7/00EXnXCZ5ONjgi9LUp1iRLbWE6bUT6qqLPy6jpZ6T9MovKNrc7JBDgKqIwQIwwte3WJiur+obXGniu2IW9rQjMr0JBmy7lDUMNFTVUXPJ9wv2TPs6EiLDiUUfhdCVIhQCgqqVsM32bYPBElcAhEmW05byyLuJlCLIphQdl1Qu93+aFQLhUqTalm/PgVI4TFA87fit5gUrIubrYKb2imRj14TSFreFaJ7xggEkMReI4u3KZ4M7PGqy0ny7A6BRjGMFIQBhfsuMuh4376soCpdxT5mx3q7Etga5GQEABJjOeHodcTav1szuGD45b+24hGZQQWPOkIhU8VDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:58:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:58:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/8] mptcp: add sched for struct mptcp_sock
Date: Fri, 18 Mar 2022 10:58:06 +0800
Message-ID: <a626e160359a747d1d5eba3a4912ff24086b3493.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:4:91::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29c36a8-7db9-46be-fb7c-08da088b3797
X-MS-TrafficTypeDiagnostic: AM9PR04MB8321:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB83212748739E3857BDFE26E2F8139@AM9PR04MB8321.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+a7aVwL9blQMk+reatdPh0kq5i+L+eswxDd15Anal5IAIxWH/+A9jQk1ez83lk4ke0tp/ygzbCcvYe7G1K+O5JEVvPK40nmqrijKHsjdXUfV6QjNOOm5qQf/i4mq0MSIzkWYXkUJLq0MMxtFxjwLhtz4W9mpNTwiqE1hEZFzf7h70K7NgxEn52RhzRx54RvKCI3TXHV36jQpIT+q7Mw6yr3IMs6uvJT8J7PwGI0HiGGnxxanuD47FuAaq6gLmBCpHex7vv9IXexH0bJ4rzEHGRn6+hqwuDy7XcUqfdj5kPiARm6857shHLvJafWhJHvmiNYEfqv0S0d8CmOOkXj3mwxJkjNzoR0ooSudeuH8XJQZ44vqWalA4BFdZyUtimnuns1hlcNFavMhVBSxLXKTwpDHnsZH3axxuFOjSwRFZGBzh1zi6INAXpfG7QjoWmRYHL8f0rPx17o8Kz0ZlbqZbSpJ0YoiJ4qtDoqSeBfuzEx8RxVEq06LOC64GMxiOD90q/eY9RZhdQDZRu8ByGCylWI8yxGhkppiq1d4AvIDuFSHStV5BOmT8hoQqckQ407S0cDJxdxqWevB32ZuXQqK16CqtDoqyuCd08l/zHGRrHAInqSRuStQGdsNV3iVJ6JG9zo9CfUVVP+BAeAVdHNb3ZWX8Q7FCmxJytw84DGY9rMXg72bu6qrExE/kMkpvTb2xcsvP7PshLJxuA6CTP3OIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(86362001)(44832011)(6666004)(5660300002)(6512007)(6916009)(36756003)(316002)(2906002)(6506007)(66946007)(6486002)(4326008)(508600001)(8676002)(8936002)(66556008)(66476007)(186003)(26005)(2616005)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XNMEJqXa4rzD8UdxXqSItaz9tEYQyjGaobeW+FfBhKBkEm6Vr4peNk4X+aVN?=
 =?us-ascii?Q?E/SpmkV34OCGck4p2tHQSdC1YvJ/lej7Yy75QhU+Mi7rHyeYwMNjT0KNfQQG?=
 =?us-ascii?Q?bboDtwLU96tNOsPEuklXYx8ILVS1T8PiGse6zML7boX8wUqbvub77SRjtFy5?=
 =?us-ascii?Q?dtcmwa6QFxD6s7xar6TmOWKSzJK+gNaDUUX15VKq4CtT1CXj6RAA5v9wBgzv?=
 =?us-ascii?Q?AMWUzgsiemgtblHkpSU+zOJIYas7IZeXccIiEj6xXovY5kWl+RROh+NeWRZ2?=
 =?us-ascii?Q?CEUBTHo8baq0PZHikBFa/SoTUjP63TB2uXNkIDLaIV3zzxahQOC+SJ5jTkpU?=
 =?us-ascii?Q?qesIyvdjUr5RLKYsznyPrvzp/OvXS7CQsj9OGYCpF+gkcaUBPVwbdm5A/Onm?=
 =?us-ascii?Q?k4AnvWLsIxweYBlf/TUmizUoxjHhtpbHSKNodi7CPsdANlFLtke47kAf3nzJ?=
 =?us-ascii?Q?cXWVTsCJ7PrryzTKZZWQUdOj54QJ/p9JBn0v0ktzzmvDqwV4I94sIBoPMIRO?=
 =?us-ascii?Q?9qPrUSkWxyKkyUf6abPbGNT/pHdWH+ppsxjckyApHhulF3H5I9StGGF7dUTn?=
 =?us-ascii?Q?ghDDZEEvzwdBjU55Blh7EThbRe9jhsYrh7bNgDa8DysaOXjX2+QBapddrqz6?=
 =?us-ascii?Q?w+VlgLe2jNZ7FwFgdnWptl7anYhWxk3r8Af53YVjf8bwy07ZiymEdn3CaYg2?=
 =?us-ascii?Q?57bhw1RguvDNs0D1mVDbWhg5rAZ65sm+eG1LvcE0G6lcVJZRffxC1vALopYI?=
 =?us-ascii?Q?sYnhyfWcXLsGZD4QUDYq/Z9lZNu5VwL628CQcCHnxA5LchZ7snb+gWq0G/WL?=
 =?us-ascii?Q?yb1fZqtQ9kx1rXoTESxtoTEEn3Sj6PgJ9KSUkfnAJv8YdvZZoN0WeUjeBIJm?=
 =?us-ascii?Q?8BThnYCYl83vTYvrlrHGyioCCDZvuiAaCjeaKRvDcyJ0vKSf8JGeDjo6U3E3?=
 =?us-ascii?Q?0D06fdUHCSgdQyf2/ehNk8lQ2O9mDNduKYMSTiS/bQYhofTbuQCIWUgKPfKe?=
 =?us-ascii?Q?Q1Mz9Tqfmb8fi/4ppC1vvVp/LWkZOvWHAPlPd/b1GZGSObSwS+LnYL+wesXY?=
 =?us-ascii?Q?1DogLufApZMiczShfrlrmzEf6b6eTnu5xMLnPiGQAFkcJ1KJTU98ARXUM0wY?=
 =?us-ascii?Q?SJnBv/1pdiDr8eDtUympDbrMNzmulMOZ0cwsQTun9uOxlxuy6CSmGMKhDRvX?=
 =?us-ascii?Q?36rQt6wcz0WY3EMaFtvf73nMuLdBoRUrSX2dD18Qd63lWI7Iamuy/2Ufcwk8?=
 =?us-ascii?Q?Z/wI3oRNCXo6+3XoY6YhBQFIEGBhJRiGVm3Y3hDYrws9ZeLUfVGqO17AkHtt?=
 =?us-ascii?Q?g6iWMOWsgMG+nrF742nicJPsv0lXGTccr8D920KiWcfERzsQj1NTXdfsmPVk?=
 =?us-ascii?Q?6UDXU3orzk0sRd9HMVyAJ/V2EGw56Yqjra3zm2cP7dmA6jK7tcZU+Zh/PU7d?=
 =?us-ascii?Q?qGULWJSUrO+oO8GeCqwaiqyPrGk1MeOOYc2pjnpaDdTr2tfTiNTxrA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29c36a8-7db9-46be-fb7c-08da088b3797
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:58:45.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwEFPICR1c5dm2dBdeamP2s/nJVAVg3XcuS58857hP2bnXP4UtXZUct6lCp4IIpLA5LedxApiPAdqtOtUMRd+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

This patch added a new struct member sched in struct mptcp_sock. Set it
in mptcp_set_sched() with the scheduler sysctl.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 +++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 11e19ac9d5af..b6b8f41a3ccb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2609,6 +2609,7 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_set_sched(sk);
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2760,6 +2761,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
+	msk->sched =3D NULL;
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2933,6 +2935,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	msk->sched =3D mptcp_sk(sk)->sched;
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f0bd2e17f2d6..d18c54e2f28c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -286,6 +286,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -609,6 +610,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_set_sched(struct sock *sk);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
=20
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9612e182b7b7..727d185af86e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -55,6 +55,22 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *=
sched)
 	synchronize_rcu();
 }
=20
+void mptcp_set_sched(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct net *net =3D sock_net(sk);
+
+	msk->sched =3D mptcp_sched_find(mptcp_get_scheduler(net));
+	if (!msk->sched) {
+		pr_debug("sched %s not found", mptcp_get_scheduler(net));
+		return;
+	}
+
+	pr_debug("sched=3D%s", msk->sched->name);
+	if (msk->sched->init)
+		msk->sched->init(msk);
+}
+
 static struct mptcp_sched_ops mptcp_sched_default =3D {
 	.get_subflow    =3D mptcp_subflow_get_send,
 	.name           =3D "default",
--=20
2.34.1

