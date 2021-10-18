Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29772
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=im8w8W+SH7qLj+Ph2mfvZy1ttAD0d0/zR4v9/RAXsfg=;
	b=ILKK8Jxj51F6vAirvQOki9qoYz6ZscEcPe8Ry6gH0P2kNeAwt18AjCT/qqkZvtFUtmBSBq
	TmaKmZGzn9a4yxtEDgb/p5IkVh4PkzVW1BrmJymf1LX3B8vhhUmUjEkqBoDZfuNJlHLfsK
	blRsI9cgM4lqJnz8aCne0EaVOAsgGmw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-1ImoqHgiN1qC3NRPDL6Dag-1; Mon, 18 Oct 2021 14:34:03 +0200
X-MC-Unique: 1ImoqHgiN1qC3NRPDL6Dag-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOEnsFwC7L0E3IWVwzi8l5Cm04vuPTEZIuYHyCacUebr+fPyBRhot4RRG5i+/nuxEarTkbDcqQuizYDQxOhKknz9LHesM80zODuy5YJ2qEkuVsAuLgqDysw6A5Od/5/iwZNL/jNz8blyEtfArKJk5++mL/Sa6ZVKpewnmP2KGgNegOEtVSXymJ8oMDOHupMgh/gBSdyrHY8xh9/G9o7kfSicYBKFJv/tDORmwk0+ptaHA8xvmwrYLaxYuoGXdIK3VLCeqjNmc+qx5lNepRtORi+6svSEuxj2OznSMZ5xkU6hFSnV03GbXSAnBRzWs/P7Z/r2k4BXUrwKDlu/c0rGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poo/EYfKS1DbgYOf8ms9An6X7wCs4aUgFThfNenKSxg=;
 b=WBkueXdVZoy1+5l2a8ctqJJDYNFnRbP3QASZ2Um9mluZX7H81ZVuoBMGNSMEQplbLcmlS4rBj8Lc5L2yuBX6oNktyeLZJajx2agGr99pdw7d7StaKbvQUVxiPLwlw0Bn7m8F96+aigtYl+kBjxvkbKt6Sp9tfBPK3sFMvzvOQczeb2dyvXeJDIMyJNcY68NeQ3yV6ra9qhbLIahTpSUTYZy+GtgKScZIXB+F72K6KOKeBIhJ1vKQ0218LJ5OdbXa7IjaCDzAisYP5bNNevzzQu7NmazAvDJ9AoRpdT8/Isi2LwET7oM20B4N8xNSljiD10XaCyuA9ANnh13B7v9A7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2825.eurprd04.prod.outlook.com (2603:10a6:3:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 12:34:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:34:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v7 3/8] mptcp: track and update contiguous data status
Date: Mon, 18 Oct 2021 12:33:10 +0800
Message-ID: <da78a5188ed09cb8ffe33ee88803424995fe3485.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HK0PR01CA0069.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Mon, 18 Oct 2021 12:33:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6503f0d-f0a9-4b04-46ee-08d992338f8c
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2825:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2825F258A583E4ADD1D7A406F8BC9@HE1PR0402MB2825.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MoOXQfWPxWH8sJhYUor6Ae6fmfKf879RKd0HH6pZYIMtWC5Rhv7Ikmq55NedYs179cvJIvlJubdR2jHqg/GGQBCKuZuFL/NhzqPAA+TJo0zpNhz7Cb9qjiTTQ+EKVDSL5heixeGA0tKiN5YCehfn7S2YDeviuHN6tvQXHHbPBIA84N1nP3acN199mexM4YQvDM8D/xrz85sQ7wTlof4EsGWYv+39UA/6MvUs0UbK+t+zMDUXvFwD8cT5HtLQlxmnoBuYTCRT/QPDqRRt+PL5eydiZHo85ck0GOvuT0wG4v9txAcoc7OpaJCNCIIvCni6fVvlFEU5QIjSdV5RYLk3/sxTOo8YETPJtzHjecDuaqYIwhBefr31LVDo8HdsZ6j0fQQf5VvY85lWEu3wh9wXpnHTwImlB2W2/hMgKCxBllYLN+Mfb6tdDP+eLkjJV6RKHCIBhKMOZyTZl1wNoEP1KlHVzMTzrBYxgt9s6u4o6xoNfsCneVueFR2B9+mu3YvlnOl4l+6OisXEis6iRYLKe7lzeRqHPW4OXtp9b34UIxv79TWCAncs6+GGqDNZNR3uB76M2QGDnSTeAoVo31IbyfrPq12LtQgkm1nia/VOWrPMqoKomN3JjkqIGox3aWzPvb0nq6sfFQqLHDjY3o7P5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(36756003)(2906002)(6496006)(66556008)(38100700002)(8676002)(83380400001)(66476007)(2616005)(54906003)(44832011)(316002)(5660300002)(186003)(6666004)(86362001)(8936002)(6916009)(508600001)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5dffakb/S+sDHw/dwenEqXIZP9Zrebk64xu2lsybGOynw7oB2Go71S8aXDP?=
 =?us-ascii?Q?z3Z+zfU+h3ic84MQcISDr0qfyYr5/x4mZo1GgZVt87GocPWWOhSzPQS6gSDu?=
 =?us-ascii?Q?/0szEnCwhPVHhw5KUetqmj8wYfMiJnL9HLnFFubQEzowc21uOjX3cEdiFF2r?=
 =?us-ascii?Q?eFZNmsiu/FR11+lBlHfEx7KBoPwbvlEPkNgv6P+CoFJWPq8zi3OMaGmaRLiL?=
 =?us-ascii?Q?L6lEHes669KdmhYr+j1RgeqBMB5JDei89wk2uBBtVVNe3CdaGAOUd0bnVf4m?=
 =?us-ascii?Q?+qUPRU6wUuJKtTekP2WdlBLusmBP6eJ6Wcu3hcKp31WBcreAn2f0nmp8Wggu?=
 =?us-ascii?Q?7wF/nYIoIoSyUZEqu//IbY06Q5MAEGiArlik1pVGDEFnq8YckSdISpfY2EBf?=
 =?us-ascii?Q?2mijyf4uizCagGFhvoOMnvRaGexV0hQvqfTRiWioqBjoSUFRoVIbVBIEAZMX?=
 =?us-ascii?Q?RKZFgTqpO5PIXejgfvjkS0U3S8WqPZnZNfqWC8Yv5yIT1bWj+1JdrwJPeCW0?=
 =?us-ascii?Q?boFLsEykMBfHMj79BJVmUqca1HZKTqlxyGWXUJLJun5q+I8w8h1Kqrnku49F?=
 =?us-ascii?Q?5agqRRz0PAhsp8BC+564ptqQdGDKSAWzyz3Y3JZ6KbTAeFZXFdHSwpaSoVwZ?=
 =?us-ascii?Q?nAkudzxmlmP86MdVIrYIh3qE5rAuBdRs2oPxJ74SrxJhjSDFgGGAHg/gWiU2?=
 =?us-ascii?Q?EvmeqXB3OzG4x4YCiKK9zIQnEPD+N2A8Fi0dm54aKJ+uJLDUOHnh9kOmJ1SV?=
 =?us-ascii?Q?meNYJia8LjPxeQhquEQDKXoxU8Gx6PbeT4N6Yzso82EsiESy/hL1k6QnoDHX?=
 =?us-ascii?Q?jcN/jR+8qQecSK2rkfvDIouynCaxMlxmdhDJzmtSQHTbqbv+kj4lSKBRzaod?=
 =?us-ascii?Q?ob1/gjRuZwCoWwRMt0tzkLSAUrfTyI9eUwwMrzI+ZilTFM/ZCqF77ep6c0ph?=
 =?us-ascii?Q?5iVeTq+gDzz+/eSOYosFoGmAMWnnbPtug+FhxZDs6OHjH/KYRWBCELFhkCII?=
 =?us-ascii?Q?nyXCx8DatCq2sxpfTtOm6HAqJM0XsGIH+IWEBopsrxsX3BlzRIkiGw0XOLO+?=
 =?us-ascii?Q?mnjLP5xHSyhlxreeG5oGpTxXO6LHjxYD+Xzt3Q7upRZpqoi8l9/4F4R27COd?=
 =?us-ascii?Q?oJ3JKC+Pc5mkLVeDMebmc+uenl6SduDR7w9Qaz1hBVbS/K/NkEc+8djfmHEU?=
 =?us-ascii?Q?l2OHbAEdF74Db4T9lZPdt3W9N5FoM7mD1Ex0R4mTxFD5neDbAV7UMSqiD94Q?=
 =?us-ascii?Q?sE2cPseF53pe/oo2BKs7T9wWbx+VGJtbIKx8jDoA3crYH56/Wa2Ort7Zju3F?=
 =?us-ascii?Q?gpPIqRJSU1lQQqMMiCLHZm5lhSeg7zQKrO5r24k86y8tHNAS/XSXXGoxpUsV?=
 =?us-ascii?Q?+cSuEI0LTW+nu35VIYwr1MFPZpBg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6503f0d-f0a9-4b04-46ee-08d992338f8c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:34:00.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25ew0MFgGRoABUXmX7AFzYi2O5ZMzv2cHxr2QKePTod/Bo/Nn1ganXwswm9SXiFhmfWiA48tgXgt/1ZquGDZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2825

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
2.31.1

