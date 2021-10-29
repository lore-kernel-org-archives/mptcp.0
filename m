Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C972
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d73u7/AX7ZBC3GgoaIozdJhetsVRz5+0iU0BTngX6cc=;
	b=XlSS+UdkLs0Dyx47kHO7KM0xtQYJJVXco9ph6jLETLFgROno/YgyNSZeY+7OlUTiyXx/7G
	ib0kXygyLdYUtlFQm6L4uCPRx4nrEO3bUn43+ml9Q0qwLSlkdUS0hqY8vGfpbbJuRj+C0a
	LEscYHNj12xi6ElX3xy+BP4z1iE7DMQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-wSZbC23hO7eYrLS5T4hxBg-1; Fri, 29 Oct 2021 06:40:55 +0200
X-MC-Unique: wSZbC23hO7eYrLS5T4hxBg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb5etLCj8BtAVR3K0eDjqoZzo4KB9ZXfb1E/xa5Jn1UP5+IJNirQK0TGBgaGl9GEYgondjIKQArmpVcK2aoT0O0GAN62wUib/iRYWNTYHWq4bmHDFKpqDxMGLWTnNkDDl2tWsG8LwJfg49xeYdzFa/8AOoBV4E5Oo8A+tk/ycXZpnavmnuNKQwO7ANEy+FVjqSsvBG889m/humeB4VqHTcc1+Ejr66qagYaTPkyx+rY/i9KZvlUvF5l+4+Fz/hze9XJl8rl5J0CFpvdG/C1Hn++t2GDRESjhOfIdZZH1lFpRwWGfBqxmaj+OfhpMWEUfqjlZuMqg/rRlfpN7wPtmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oInyVpOnh5prwgPSH655qLEDTXn0DWisTkjgSpzSg6k=;
 b=EwNMHdRtiWjOKb7Bv7bqAYxMYgmZgD4Tde/RNyjTdP62Ik7rHIE64pYXx6ktv+q59es5Fvt/1vi2KWOU8GV6tLwWJEo8QNlVVUkBoxi6QZTqnNXpTnKgNOSisg3irsDg/0qoM6yEjZxbFgliEboVaAY2p6BRTlb8TTX5qIGAsfiTfVdlVPy52CjZjDNhUIqyGqCTIGBfnEN/li3zV1Dh4hZDtjqgsC6d0HKpcW839Tw7wM45Icy/jH8VV+ZrjCeJSjdyvwEtETTKvjKZSmDQ8c1HAAp54XtQIOyQoDtuewVpMJPHCcv3b8Fa/YqyGpVWqwaZN2BrRKh2CwfQmWzsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:40:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:40:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v8 3/8] mptcp: track and update contiguous data status
Date: Fri, 29 Oct 2021 12:40:13 +0800
Message-ID: <8ab5be63461a9f9554ab38bb479ae829d6be2ce7.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0191.apcprd02.prod.outlook.com (2603:1096:201:21::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 04:40:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e28f9b50-a11f-4b8f-ec34-08d99a964ad8
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2652DC9898AAE7DC0B2742EAF8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z0V5QUCZibLlmh8cIOWcSwXGbtHLsoClrwwbxlb1jnj0K9mes5VkkBGSkpB8+3D6LOzcMqLr4P84ABcCzfpKn/tLdLTggK9PSOllWsQVEcWzYYLRQyIpHhfg7W07WwiywhkstKvNikddMX+vFHUTtho+3vuqy27yw6xTcNNgHP0gRkxiepe0D+mRGY0oqB75/ILdJpeIjKifUgvHo7iiUFyxqP4Mpm9BsDzxtmmQnhFXwk0sN3P8SbZ3pItsmTQKtbEKAmCldbk0gOaivKV74S7xisLnL1RBHY/N9bwJzctnB503ggPD0N+GMkyszF5/19X/GMr993aSMYXF8E6VQRmVSiookvKO3CiMhcRq4hwsm6tu/jUQes2em7k0W041bBdabd9PnqJYbWazecOy2gSNW5eQ5L+Jjh/tzUV5RBAHJpXsk33k4BAm8TdV9itgRtbVLffyGlHhR13qKR4DFWOVg1cQtu5WRzWzUx2oA63ITNScsMr9qeYCrTGEOo+svNmXtHGXxHOGpDnZvqqbru2FPFJyCmRBIX7DWhoyJ9e2AG2iS2Fbpb+dYMY4l58x9QCx3S/jhUquS4Fy6HiZr8Um+BNaWmWPsYM9Oljquse11mp30teglcZwPXPnFAhg2U4JHqqI0ckYcZMm003C1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(508600001)(4326008)(66946007)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIK5IwMtMJCNcmhYlUJ9sZazFdqHpQrHO3mEKJyAD3dDPZieys3dFz5bQfH2?=
 =?us-ascii?Q?JA9SKi5mCSZFtNfDMuoUdK9ox3GIVuUvmcsrFU0Ircs9K6jJ/LIinzJ6o0kl?=
 =?us-ascii?Q?fttNEECQfXGVke+HM8tOcYF69dFcHPThpfjgNa+3rkjG/1mPM8CGGI3S6Qnc?=
 =?us-ascii?Q?xzOk8IZC6OPvKmdeCFXxrTWDAEiasj7B+myx7iCyomOI5e/C3D9N0LF/4iSn?=
 =?us-ascii?Q?i6Rp38v57ZSzWOj9E4dVH4/+thGl7EHBVqqHZCW+f5VfGX3gMe3z1yNKlYXc?=
 =?us-ascii?Q?FZ6ReoFbOW4rETOojc3letEgZnirG3d8KXR7bp1vvn6mDY1WumHdxrKCDCyI?=
 =?us-ascii?Q?Kw/SLFqdo+rzzNPRk6CMSw+ZciPQzVbn6zkQUz+CrASSxSeQ+8G6uWkW9tLG?=
 =?us-ascii?Q?keGDY/hwJE7jpVnXNE+t92vOWqBwGMxHpgRPrnXquYNnmdLoV1V+cNCE7oii?=
 =?us-ascii?Q?sLiScODwQn+ECxfYDaJlMZTduKi1JhDXjVP7ld3pMZqC+AQMo5uuLp/rkL+m?=
 =?us-ascii?Q?aN60gpvShDbj9JP76HUx6+s1bMcGKt0wIAudK9CBtE3utllks8XeNpDX1tme?=
 =?us-ascii?Q?U2kt8HN3wyAF2YfC6Llc9MQtk4/jxU3xg0w56CTQjBQqdP89ZqEAiyWk3V1t?=
 =?us-ascii?Q?aQ40AOnINGEQJnQbz0SoVLSsmjFHsuh2ZhRmlLy50PfXR3cfREA8Y8/5ekD5?=
 =?us-ascii?Q?TbuQbw75Vw3IWQTXr+HRqA+Vkmoenp5cZg8qUP8sWj6SFWfo0UayaQnpU1q2?=
 =?us-ascii?Q?EtrqeZFUf1vTAIx0ZR/jx4FksBAJrKNn3IgKSpVqqlP6+cGgMzCp2ODCnn+q?=
 =?us-ascii?Q?oefN7JAbdpny8qtImVjKTepV8xAv401ODaTkmDebjIx4HhEL9owr2cttmq1V?=
 =?us-ascii?Q?MuyU6q6TqfAf0eWu6PgUdNotjvtrPyUxvarabpaBVlcU4psvduEoKkH+W+p0?=
 =?us-ascii?Q?ml6cH/CRrT+x0d+6TreBvI0SV57aqKEZ/z/Oifwr2GHoY0EJKq6nXMl260oM?=
 =?us-ascii?Q?z3CetfVPdhBt32rQ1CVYRIOMYOxOM0Otm+oWhHUira9niLMc8QYvSLrFHOS7?=
 =?us-ascii?Q?MXkwZ2hioXDMSxV63JxomicTXOyivRdYSuAMVTELwAlBByCzdOpZ7Tk8Aw0i?=
 =?us-ascii?Q?kXAkGbLzfHyCtMXH0TN6aObI+8rZ7ia8mYcWvoAGeqVkX8HjYgDpDWH8ZnpU?=
 =?us-ascii?Q?el8r/IK97RpsPZa5CZp70IJheFt0gIE1Ff6lM/s6t7TcFh183VGkDlg6eQVB?=
 =?us-ascii?Q?EA2GRRyRR8wxfRRJu4eJDHuXxFt4oT1K8oiisAlzuVhoJRm6LedbsqpREd6v?=
 =?us-ascii?Q?aBk56E1PxzxKxx5oVb584vh4UPy81UqWpkw0Ep5Zda5X+ZaKa0rQKXUsl2Ej?=
 =?us-ascii?Q?wKUjQGVadynR6qKwB/kZPeHMmy9QmD9CPwuVvqbiV0GHGWPELC/mwe7A1Fo9?=
 =?us-ascii?Q?9SZueWpbDv5H7JbCT0n21+2C5Fjl2YqCRGfLdKSzLMsg29uYLmzMgR6Y74K5?=
 =?us-ascii?Q?VNTx6yd83dJKM6oNZWHOFZQAjBV+6eBV/siwTnsGVsSI1nmfaMLkdZUzp2W/?=
 =?us-ascii?Q?R3ql0528Of5gioEmsJBQaGlw+fWJvQbIMmtoGde5rHNJ4XYRQBJZqAclBAHS?=
 =?us-ascii?Q?7PGgnN0vRBOXCdQ0TwmSTt8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28f9b50-a11f-4b8f-ec34-08d99a964ad8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:40:54.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8K5GAYhVt5SPl5xbH3DPUc8EQVPLhNoMF2q+xjOcD5QxWc9GukoavlZ98cuzl845yMBlKYH4O8EqpV2bGz4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

This patch added a new member allow_infinite_fallback in mptcp_sock,
which gets initialized to 'true' when the connection begins and is set
to 'false' on any retransmit or successful MP_JOIN. Only do infinite
mapping fallback if there is a single subflow AND there have been no
retransmissions AND there have never been any MP_JOINs.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7803b0dbb1be..f3163647c501 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2387,6 +2387,7 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent =3D max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
=20
 	release_sock(ssk);
@@ -2465,6 +2466,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first =3D NULL;
 	inet_csk(sk)->icsk_sync_mss =3D mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery =3D false;
=20
 	mptcp_pm_data_init(msk);
@@ -3133,6 +3135,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (parent_sock && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq =3D READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 67a61ac48b20..4b9fe56bd572 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,6 +249,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		allow_infinite_fallback;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 87a9ffebcc42..93bc298bd41d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1167,7 +1167,8 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 	if (!__mptcp_check_fallback(msk)) {
 		/* RFC 8684 section 3.7. */
 		if (subflow->send_mp_fail) {
-			if (mptcp_has_another_subflow(ssk)) {
+			if (mptcp_has_another_subflow(ssk) ||
+			    !READ_ONCE(msk->allow_infinite_fallback)) {
 				ssk->sk_err =3D EBADMSG;
 				tcp_set_state(ssk, TCP_CLOSE);
 				subflow->reset_transient =3D 0;
@@ -1452,6 +1453,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return err;
=20
 failed_unlink:
--=20
2.26.2

