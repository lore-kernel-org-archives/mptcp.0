Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4FA31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pC5H6cNVigXdgbdg7bnyfrHWOvSZlSNO3I9U0DSR3mw=;
	b=CHJ7kvmcHfaIfZgcfmnjYaE3RtofPeEslL+SCETk/uFrRzAp52TrshR8yomkSVGl5wVV7x
	AHyc8Hm2YYxuqn1PIRUvPh8iPBRGpOLDMFv4M8RhE1JGOlnVFlmE6wMRovp1of+yP1BPf3
	xo3NZPv4X7rByuF5tyt+rIx4T/yEM8I=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-5_dVz0jzMmW9ubwlJtERPw-1; Tue, 22 Mar 2022 10:53:23 +0100
X-MC-Unique: 5_dVz0jzMmW9ubwlJtERPw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z19fje0cpQ3Xmt+Fafvuara2Be8mqzwFZPLpcE4Vi+/RfW2P1jkrfJl9vhnnYhIbeN92UkxvDPtmGC6/gc/Es57BjlKXAoyfUhNrkZBLsjjwREvetWsb/vcZ1m4+b5znvMY43GE/fUV2dV+8l0UjTK8edpKw19d00nJqU3RFbfeorgW3xx2R2StM+UMNLmX1q82x8GEyjlkzIKMuaGltYhwK259jlWc2naBzZcVyBu7qU4UDkPeZOxsuq7Hd5Tw4aXGoAVJhBR37zPXEaABeHr9swztLtehb4Gdc1949l1kdcTiyF+zrJsoxZrZClkPus96vqbtVsMTX27lY/Vhl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA1vClu2yS/xFkl848JXv7w9G0Bodq6jzxOk2r1sl+o=;
 b=NQve21V8rRJ8PCDQcxUGzSzdckcV4BDbO549skJ0V24XmhWEBL85cPhbQ4VvcDFWZYY2BDdc7G2cDpAW3n5rCrCQ9lPoZ701U1rmS35vrLucqvSTTpJS87R9nQEnQxaIP9N6HEu6abLRDtzHR4DbuN3iv0owrXoGUyvgjPuWe2toUBgNcV6OwHTEj6tc5oGBDniOcECpon+I/L0Q9Xb901w6zryH0hG21n16Tl8fATfC0akQ13yDQJ0zDmgL3ov6SSQjwrTtMsawSWKGyDgKhEjluQAeUHaL5b9/hM4LuBeiZuCRZ3Ou+8x+EltaokFRjZbUfbivh0uFs0ofY9xHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/8] mptcp: add sched in mptcp_sock
Date: Tue, 22 Mar 2022 17:52:39 +0800
Message-ID: <05808789d3cfaf6df311cb5a30427f2b51a9f2bd.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 910d59e6-f5c6-4ff8-f8cd-08da0be9cd11
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2282310A831C20FAC2998435F8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pc3pU5ROq39gqbVuQLeGb+5jkXqzvJQmso9WLClytmk6IfWUdmMXBIsOEknyiiF4aRshLS3gP6zqatYf7j46UsXuDw/LSfSPmA2VyZjepnCTHZb4uZQbV9eV3WqOdB+yf7Iahr0+lc4zIKjbfWRaSiGrZhw9+oTKl0LsECPx28koIE+6ni7yfwMilXkYlZSFtK0XdH4rXzN5SdljqUe+D+XO/SCwUK/yYgYppeUDccMlJoW0e029tp1ycGSdd/j23fHrxwu7Y48Z8/9Snr/q8o176J4K3Th0sHJuPLmy1qGdVGZBwrPJS5F12yz1N/C1Q84g3GwV8b6Gas3uCG+T50n7F2aK5FHtF3BRvrV4oWanlhWvp/YNfAGBU6UwYrysw+Sfg/yC9fQgSnXl+V2aXnNd4AVb9hneH7k7jWU7dhDr4yuBx1gzdtp6tIKv/EON/1TpDbbMHvbd58vMZH5c/yeRlLNVBnKaswHH1PtqQOhF7+znzl9tO3tngOHeoTCvNIintkRSwSFNoYm58SDmsoHMVgbzNAj/xi5r4TErrqMm+L7E/MN1OGZhMEKwREwJGSc83AygPNVxRbxN1H+RkC6HVrTHr2NLyqaJWAoLADA/L09rMQJQCXp38NsmnK3vF8S3AGzdq2DJ8J3v/YPHSSL2FtQk8i4yDpU/BjYXV0g1sh45r50bTec4q7kAFaYfavKA27+iacuGqA5WTakOXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?InpCrcRYRC4vp7tZPTvWK67PR+118kpG+OdhSHock+w0gisan6qVTl9yprYn?=
 =?us-ascii?Q?/7TjFVLRTehrqDN6l86n0+N64eZ6QSkcqziKpTgnJbWAL4pqo2GCShyP9dCq?=
 =?us-ascii?Q?Wbr0yXI4Jhq6NTicQ4zabdb90/EmlWdS/OX1JF+SWxeqexo4JI4wVdDNi41m?=
 =?us-ascii?Q?LgiRxSE8lPEr8f8be6NcfpArK7GowlEDxTojOdjwK7U6Hcuxo9uAqtwDDgZE?=
 =?us-ascii?Q?HVKIQUCJiMHk7jyMVXzGPxe4JmJBZzlsPPS/23MEtjIysFFggNQ8kexwB2MO?=
 =?us-ascii?Q?SpW+/t4fd2X68tdDXeGqo/9q7APSvF2fMmumsQrJKMODkdRjwm+CmV9B6Cix?=
 =?us-ascii?Q?zzrommHaycLzQ5KUfcZF8iWrWQQ1MsDhyEJsuI4QsLyIpoQo37Wu6920yWwr?=
 =?us-ascii?Q?cJxYIdwz6qN693m8bUIzgrx012EuErCXGgmYT4cxXYMPMVeZGbbvTUal2icQ?=
 =?us-ascii?Q?UFrRLYJjwNyZv6e8ieZvbBLYSxm3tto0iCKQdcseSm7LNnhBE9v6FyJMMb33?=
 =?us-ascii?Q?1SzpJnWbj+/Lv/wF9y/MWWPjYM9VSL0V4uddwMxvoF1jEO3zBjo+5SWYhcqw?=
 =?us-ascii?Q?OPurTTsUAo2IfywfnCxL87W1BgvNUaxXk4KS75x8QcqABcPTMEpIRC8J5KI/?=
 =?us-ascii?Q?2hQhjsb/HGt23pvHPdzEoUu3bLxjmGxsMfciBStDqvu0PPI2B8vp87dzTWtj?=
 =?us-ascii?Q?wucDhqOjKiXc49OtusOOsvW8nTC4lI8NUvU13VE014x5TbVTc9t3zH+YK8pW?=
 =?us-ascii?Q?4G34+LCU84nv6Lrwe4xJVzfyM7CR77v+pq9Ife1JJUE12vuCAVsWd1JWzqNp?=
 =?us-ascii?Q?j3CZHvGmHxz3JlBsilPQp/s3xedm9rG0F3vHrxe4qJk0O+kr9ixqCrhX5TI6?=
 =?us-ascii?Q?Os3GiFGHlyLKym6eakrxGCil/4XTzPhKxOAhCiLN9fJS6fz/LZruWDqAab9H?=
 =?us-ascii?Q?uptunGg854pgTwlhi7K49xZRu/U8cB+r6kkJUx+568FqqLPIVxGR06TplqrE?=
 =?us-ascii?Q?pm7qvxE4cDFsQuAwn0bPhfOMl/dWnPpeprg9kV0wH2iZp7MmqZE5ssq3f0aD?=
 =?us-ascii?Q?VMVipJHeS/ZedKNaNXhEHhtyzCC6a1005okJh5WVPCLNtrnmB7Jh131eooJR?=
 =?us-ascii?Q?FaBEaJCYAUXNvWnWBvcU3L4sPF5EAsqxSc3DeAWWJv6nRszDae+ItRdsKWAC?=
 =?us-ascii?Q?boli7+pyErhyCbqRj+7xf2Fs69bBF4HA2mt6bXIAF9+W3yHFdMY7BkZnbFNF?=
 =?us-ascii?Q?0tO3aZzj1Or6bx+yVEnHtLcpX7uMMCKRn2xrjAXClMAb/8l7pwkb/ZInAUCn?=
 =?us-ascii?Q?WzOQcj6h+D8+WEGoPe2DbPom+6e2rOsIS+hrkoZd5EM+UZMm+Pbu+iI8H+CQ?=
 =?us-ascii?Q?WH0LY7PvyjJGZ0u0ZdIam8OEimomaHJLwUFeSZstnjbJ33tOycCpQBO1uZiZ?=
 =?us-ascii?Q?7YTw+1eRzRJ2+5O+h76LrpwGuwO0GU2192Ch5aH09JeyjB8/cNwiBg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910d59e6-f5c6-4ff8-f8cd-08da0be9cd11
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:22.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzGOSBqQV6rPe442rosDOKANJcYe776Ym4yK5EqDWTblO9MbNBoYxN4gCJJP7TGPsLCGRXKD7xTK0+OX9siG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

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
index 11e19ac9d5af..c892e3b6b65c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2609,6 +2609,8 @@ static int mptcp_init_sock(struct sock *sk)
 	 * propagate the correct value
 	 */
 	mptcp_ca_reset(sk);
+	mptcp_init_sched(mptcp_sk(sk),
+			 mptcp_sched_find(mptcp_get_scheduler(net)));
=20
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2760,6 +2762,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2933,6 +2936,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f0bd2e17f2d6..f7acec409607 100644
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
@@ -611,6 +612,9 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sc=
hed);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
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
index 331e6517622a..ca8d204e476f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -64,3 +64,24 @@ void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
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

