Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A97C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645009504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ggPhFKeeCMA0z4NEopjpe1Zf+264JMZUGetM/rdXpI=;
	b=ezWAQ+zMbKcaic64wH+yjAwaMIp+CZtmuZtkCqfgV2ojttflmrjegQLl6FmK0n7zw+Fndj
	dL0Z9Wjh3W0NiF8uPEMw/9/B9aRL1IeOsa5KijY1TS/aZkrKRBQTQzZL1hmmhmM9YW9Cmt
	kvZcozxw6KtSd2ljHiSzaLLOlXSyCDY=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-p_S-8PLYNnGgpN5uwKDj_g-1; Wed, 16 Feb 2022 12:05:03 +0100
X-MC-Unique: p_S-8PLYNnGgpN5uwKDj_g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si3u5wycOqBbzbg/G8fGUcn7KWYMSzq7lQINIgGOO3yoPUujp5tRVE/uQ02dyatHciXoNevliePB7cqSPhHZc0dLV6uDfYwdZJr12jv2awVYbRoK90e0qo85u4bzJxYmW7UtIntffwUl29kV7w2p8Eo6sz6c2w36h8cN7MizdWqrbWkizKrmtRWgnZhYcYFLkprAIBTYHSCJOWsjzKSz7AcCWQJbwmybL9NOKpQCdovWTzl20g+icYtNnQYbfoEYqc53xeXLVgkM2eXg18oIgKPtjyclVOCFDfzbFr9XuQuLDbwXjC5WLRGY9sskyvFv62XfH2v0H3RaQcpe06VkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2Yn2HF0D6gYYTGBd6R2cDQC/aV9+JlA5MvPXJhraz0=;
 b=FqSPNRSUiZGQKf6g9fwGoQ6ujRm9LHr9fe7sXcKXxNKSVRwJRrznFvLCIfPSwJSAUxPV89uyYZKT+xzYNrtiir977TFKQWdv0dyEZgKhFSE1dCJBCBYZF440hjd838h3gnMyjOFrG89/zum1FL+SVEEAu9+SqURVFzVUeDiAQnvqenk11lkeSmrSBP4SeQg+HPvrLwjODL+9am5uwzO3xg8PaQMBAMhLc5poK9sdvT0Jd/LdlijXeyevLgTcf1mkDXcbdgNp8zGTJ5TmsErsQzVUo3ocdMrNF8NDWrkduE8VnNKLC/BgvZiO5RkkDAaFvr4iw/P3OnpyZz6SNv/DyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7422.eurprd04.prod.outlook.com (2603:10a6:800:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:05:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 11:05:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 1/6] mptcp: add MP_FAIL echo support
Date: Wed, 16 Feb 2022 19:05:08 +0800
Message-ID: <8a936e54bb0147cbdeaf4e5430390185edcb549e.1645009373.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645009373.git.geliang.tang@suse.com>
References: <cover.1645009373.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf50fb07-102a-4d12-f59b-08d9f13c2e48
X-MS-TrafficTypeDiagnostic: VE1PR04MB7422:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7422681BDA81F2ECADF14214F8359@VE1PR04MB7422.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CARRi+pNAxG3F5ku2p0On1nZN6kN9y/FLFYezVD3CyJgD9ztSIJJ6pbqSOro33pZSQGz4cIzg7sPOL5fMC9TM09ujnFCaBC2ZQw8o7rZcyHJuYOBLkHr5qBdKBNbhC+8XTdBDpI3xAjC0XgYtL2+fM6CY2GAcGSO8U75ITupHhn5bij3u+3TOEvRphPOIRyKtVpze68VLBj3bM8d4KCM2L2ILogCweMVXAb02NX/XtdsHuOHZ4Se0fALLsXtJk7gwx8Wp03Isr+WEPxmejVebE2Iva+M+13QItMXV0JieRGZaaoKV6cXOQFc8AxpJZBQ8kvrTzp2XoP0rP7pkcAMzY+eW6adFPR5o2Q6YJarJwvJnd4uybTef3BeEzab49xnb8ZCox64w29Q29VaXbgrWrNjZVEussxn+PZtPiBFPJsif/kLPJiSWIoPycLADtpHDtWzfbWQHEKRknrJ8wD6GQ+ZJzlVxNLESnSpXvVj108Oc+N4+gbBWbawNdoninq89YFo/1CkGo9TREPZhhP4tSmf3fkBhdlh9Ymly3tjBi5IGnj5mc4+l88i9/HziudEwBd9J78dJckogvK9swl7hGeeen1nW3Ftz9j6dBdX9VVWci5h9STjXNOsPkqJgR4cjB6bQ2bQfWF5lyMhjdR7yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6916009)(26005)(86362001)(2616005)(44832011)(8936002)(66946007)(66476007)(83380400001)(66556008)(4326008)(8676002)(316002)(508600001)(38100700002)(6486002)(107886003)(55236004)(2906002)(6506007)(36756003)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZIQI49v6RncldMw3v/Kmlgbwr1EajNUf3vItG43l6op4MeZjaKPkiYQa5VB?=
 =?us-ascii?Q?ocWMazuqu5fjE2EmUzBLLtTxwOBSTSDwt0x+GG8o3QCp4RruoVRPruYrOFg5?=
 =?us-ascii?Q?han8vVEUKN97WWSndIhtUL+moS9vfa6QQ24ZXhSdC5ra4ys4EhFRXVuAg1Ap?=
 =?us-ascii?Q?mybaXkNs3XqXI2tZRSpnx+QfO+BXMWBruy5A0QSnx5JV7MLzWPnPqQ3xrbvX?=
 =?us-ascii?Q?wTvGad1ALUIsai7PmUFK+k4r27INDq9/4QYHczR/QEorwwRpamAwyg+1Gb4U?=
 =?us-ascii?Q?aFzeKUHTfxx22D7oOQjk66gk8lAeDhZOW3JTHhYWE3+ZNibRf9Hp0XqsM9jQ?=
 =?us-ascii?Q?byQaiFnqB/HfAXjv2wbpgcuKpcvXLTgtln13+qV7o6LZojmYjBPM8z/mX808?=
 =?us-ascii?Q?Mqw4k/RAsrG+EAzpQOXSoc3si08D6mLpcb+CZb8aurL68Eg+fScv9E8BOO+r?=
 =?us-ascii?Q?ygF6rmKa3CyqsicjM33FU/2dg2kkICyZ9jsIDh0gRlZ3PtX/XxKOKd1w47J5?=
 =?us-ascii?Q?ucHBWnzcD+usTH76oaslf3JTsD0IBC7RRJBosDbvWZf3ktWWHXr63heIR3Bh?=
 =?us-ascii?Q?q/uxEijuFoFzRXfHU1vuG8iBvTwbiIU1dbLBzwNuy10Spun7PuMaACfo5HLE?=
 =?us-ascii?Q?qIb0+EBksV9QYTntEbPGGrWUJjGVP++xZzKad3brKmGIakLP0WLV/jQQsHG8?=
 =?us-ascii?Q?4lmmZV0KbmfXC8d9lgfESu/ysCkax4NFqIKZzPHldthTcgd0oDn6bTIxuiix?=
 =?us-ascii?Q?c4IV2yat11EXFC64B9DGTQve6EmKT//KEsBO8TbiPOTx9tb9hzYMO4n1syL+?=
 =?us-ascii?Q?2zpcNPcZy8Od5ZgS5Vgqyx/gPsGYCM/TVYRUL9wgq04aC2YFcDc9llY1aR9y?=
 =?us-ascii?Q?U6NwJqlxEFzV5crwx6N9SDf1aDsjvYJ8/bZ4OZtXj5YCjVLfQX1g1txZK4Qt?=
 =?us-ascii?Q?O+1cMu2Ys3AyyURSPyfPk2u7PwsaNa7/2UPwWAaNYw9u/UnfQ1aeqn3mRnMb?=
 =?us-ascii?Q?LUOVXjMyZScsEOUwFkCQ0RHfvD8+qwXr5YJQExfc/wTeaPUiqq7gs87q/Y0t?=
 =?us-ascii?Q?dywjLdKsYze+YRlsKG7RkqtEQ9+GWPXnWUrL7gj7sQD+BdiW/vP1DK0SqJJH?=
 =?us-ascii?Q?01hrYSI2re6ztgDBd5oVrjVc+FUtJN2joEl3JGR/6iEEQHD7G0pKLJ7GxTB6?=
 =?us-ascii?Q?3woqPtPbJxWtlrxBkEikn8W05erNaQwNuShIB5h+UmIXC+VW4f0urUcYecW6?=
 =?us-ascii?Q?aMVEwQv81+t3+oSaxLoXi+0EKPwzS2S/uLzsDB8vqsHA2Yt1xg3mcep1wD6a?=
 =?us-ascii?Q?pBYbGQ7GKr+eYKqH7YrPJMPdQ4vpOM8VSQtDtk9G/5QhH5gSkrTg5XdPsOIr?=
 =?us-ascii?Q?kpdxMPdAySP32ZgXu3rpdOwzDyia7Nyj0vYzBUZUwwau0PWvGArGZlD/UOSI?=
 =?us-ascii?Q?jbpX6VvmmlYV/fsuQ+YI3gdRSMpSOxc+0PK9QcbbBD50T2ZM+zflnll7txLh?=
 =?us-ascii?Q?9Klxn4Miq4hAlv456uC7zDB8p4ZZglyByMSk9UR2DruaUGyTszuv3avWUK09?=
 =?us-ascii?Q?312YntQINOm1jUlY8yH5dqsxisMGHUb7B6h2p3zjDMQQV20pAgGdf540J4T6?=
 =?us-ascii?Q?LwEGyxKrszyAUe4C/j6SjpE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf50fb07-102a-4d12-f59b-08d9f13c2e48
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:05:02.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdRmJceCmegq9tx7x3sYDY/s8mOlqacyTG+ptw/sSnTCtnXtfvh3YdPZ/owRTNAzdi4ZLRmnTub4M1svjAw8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7422

Add MP_FAIL echo support.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c  | 22 +++++++++++++++++++---
 net/mptcp/pm.c       | 36 +++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  5 ++---
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 88f4ebbd6515..c4d66fca9c5d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -806,7 +806,7 @@ static bool mptcp_established_options_mp_fail(struct so=
ck *sk,
=20
 	*size =3D TCPOLEN_MPTCP_FAIL;
 	opts->suboptions |=3D OPTION_MPTCP_FAIL;
-	opts->fail_seq =3D subflow->map_seq;
+	opts->fail_seq =3D subflow->fail_seq;
=20
 	pr_debug("MP_FAIL fail_seq=3D%llu", opts->fail_seq);
=20
@@ -1092,6 +1092,18 @@ static bool add_addr_hmac_valid(struct mptcp_sock *m=
sk,
 	return hmac =3D=3D mp_opt->ahmac;
 }
=20
+static bool mptcp_is_mp_fail_echo(struct mptcp_sock *msk, u64 fail_seq)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->fail_seq =3D=3D fail_seq)
+			return true;
+	}
+
+	return false;
+}
+
 /* Return false if a subflow has been reset, else return true */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1154,8 +1166,12 @@ bool mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
 		}
=20
 		if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
-			mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
+			if (!mptcp_is_mp_fail_echo(msk, mp_opt.fail_seq)) {
+				mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
+			} else {
+				mptcp_pm_mp_fail_echoed(sk, mp_opt.fail_seq);
+			}
 		}
=20
 		if (mp_opt.suboptions & OPTION_MPTCP_RST) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..d58fddf4d5a2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -279,8 +279,42 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
+	if (mptcp_has_another_subflow(sk)) {
+		struct mptcp_subflow_context *tmp;
+
+		mptcp_for_each_subflow(msk, tmp) {
+			if (tmp !=3D subflow) {
+				tmp->fail_seq =3D fail_seq;
+				tmp->send_mp_fail =3D 1;
+			}
+		}
+	} else if (READ_ONCE(msk->allow_infinite_fallback)) {
+		subflow->fail_seq =3D fail_seq;
+		subflow->send_mp_fail =3D 1;
 		subflow->send_infinite_map =3D 1;
+	}
+}
+
+void mptcp_pm_mp_fail_echoed(struct sock *sk, u64 fail_seq)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	pr_debug("echoed fail_seq=3D%llu", fail_seq);
+
+	if (mptcp_has_another_subflow(sk)) {
+		struct mptcp_subflow_context *tmp;
+
+		mptcp_for_each_subflow(msk, tmp) {
+			if (tmp !=3D subflow && tmp->fail_seq =3D=3D fail_seq) {
+				struct sock *ssk =3D mptcp_subflow_tcp_sock(tmp);
+
+				ssk->sk_err =3D EBADMSG;
+				tcp_set_state(ssk, TCP_CLOSE);
+				subflow_sched_work_if_closed(msk, ssk);
+			}
+		}
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18ca0248c084..febf32c9a139 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -433,6 +433,7 @@ struct mptcp_subflow_context {
 	u32	map_data_len;
 	__wsum	map_data_csum;
 	u32	map_csum_len;
+	u64	fail_seq;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
@@ -604,6 +605,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
 socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
+void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk=
);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
@@ -759,6 +761,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
+void mptcp_pm_mp_fail_echoed(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk);
 struct mptcp_pm_add_entry *
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8d086641bdc5..a8b5b8bf45e5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -910,6 +910,7 @@ static enum mapping_status validate_data_csum(struct so=
ck *ssk, struct sk_buff *
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
+		subflow->fail_seq =3D subflow->map_seq;
 		subflow->send_mp_fail =3D 1;
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
@@ -1083,7 +1084,7 @@ static void mptcp_subflow_discard_data(struct sock *s=
sk, struct sk_buff *skb,
 }
=20
 /* sched mptcp worker to remove the subflow if no more data is pending */
-static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct so=
ck *ssk)
+void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk=
)
 {
 	struct sock *sk =3D (struct sock *)msk;
=20
@@ -1165,8 +1166,6 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 		if (subflow->send_mp_fail) {
 			if (mptcp_has_another_subflow(ssk) ||
 			    !READ_ONCE(msk->allow_infinite_fallback)) {
-				ssk->sk_err =3D EBADMSG;
-				tcp_set_state(ssk, TCP_CLOSE);
 				subflow->reset_transient =3D 0;
 				subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
--=20
2.34.1

