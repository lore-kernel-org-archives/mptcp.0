Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7F2C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644319001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3asp1jeUjrDPeIEbN/1CCDI7h+O0weVURBxO7Aue4xk=;
	b=IQYsxxEgL9777aGwKwHTI6LgKTr1BIoNkZd3BdLGFTpk46CIA+8CXWjBaw+SUAb0p/ghj3
	ykHV3QAZQLwEd9d2VlSnnsyVq3C0v0hQyNYCVd3cKj5q+UqJoi4nUGE4JMN/BGqAdjD+Q7
	YV7cBu0gYT7bdHY6XyBPXVPv9QEsDkw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-9CqYKqpSO4Sc2oLeChL2vg-1; Tue, 08 Feb 2022 12:16:40 +0100
X-MC-Unique: 9CqYKqpSO4Sc2oLeChL2vg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuJMxRZhuhebkI/wKsaI3xqQQxg1yoqFalTfqs187ZqJ+bMIUAUIELqazTc+MIabn3PPur/jsc0HHvi34bYowMtnfakygFzC1DkJvpfKFF4u8Lp3eXMv7WOfM0WmM1gRiWrAauotzFMivaimkem2T+7U/Hk8oOfRtcsXYzF4/W7BwU5m95QFKnB0Xsm5Axz2uUSyf18ePmL+3LVEjwCbnaZ+0ZqPEVk6f1wX09pBDEiLQOR2ERG8PfVBO3Qll+cSuHiBwTulFWkZ77L8WdnZdNxSAO41d1ITCrGCR4sTe2vguuqXbGLy2Seq1EHxrOjLnP/exVGR3PC4AU1A8KcSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5bENp63WciYUz0sZtk+b01FxrFd6nMY/RZ1msOtMaM=;
 b=dt+rfgeABwxfdqhOIPtohFIoE9v05Fdmjx841MKaAZ/FJQRfBuTC8J2DwTCnc1nnj0bjEc0s7wGW773cCLTP4AD8LeXBx1gvAiK/5OWQNkgzzO36F4Jm1xHB28us+TEGSe2z+DTi8wk2k2CaQrkqoEbfvvfD42K/3pyYOFVcUolKPhS0cxtzYdebQQXgVpYctyKDKQwEc4Bnah4o7BFQBYi5WbDzzL3ROsARE7KlWL3VEIQi3hiHd0ETJYuMazXSpmr5/L4xNovNp2CkvNLdAiG2CSKVY8CCEyd7UCeatMpd8nV2DLx83ZRYbsXj1TXw1eXt6lEJCKx5NABZRFiueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 11:16:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:16:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] mptcp: drop echo parameter of mptcp_pm_announce_addr
Date: Tue,  8 Feb 2022 19:16:08 +0800
Message-ID: <3f4443708de96d22560a552c83538b5fa84a357f.1644318561.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644318561.git.geliang.tang@suse.com>
References: <cover.1644318561.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16198c5-2549-4177-8b9e-08d9eaf479ec
X-MS-TrafficTypeDiagnostic: GV1PR04MB9103:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB91039A58F48E55628832EE25F82D9@GV1PR04MB9103.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aqCX33Kcqqb/wCFG0549voG+WYJBlqkzcgd0NpkZWREmpF/iTiFffG31iV6I8j1Wd4Ugc29nZv4ff/w6jqybyo+piIAclQPMX1OeXfPdB7J3dtgR3HdOaEx2lhpEKcS4FTen58hnz/rXnHBXCdPH9bSMTg24jAHpWoegXWuKg4DAwu93+KTo9rnua+7ZBiOP25EP9yDUIlwhtNOnzKKOxV+Hr1lWQ2XVkCWWWUwJjGYpvszwN5XGI/+G91wFL8IrMQWVKIQRknj7Kb6k7Rz7rBMp8HbUKV+ZCgFe3H5BtnrIEd2Qg9g37oJ+LtWiqhUODEOTcFjcXt43qZpcSQjoGcnz0I/P9qqRrF6Og1H4q1EwuNUYwK1+W2YK71+VxrTF/0nK+1IYukV0XJZSXYc4VLGLl0JH/Y3hlkTKqo8XR7B6d9X7io2dYIX68FMi4lPcnQbXKH9uY6j8x0vRB0RPp64KeA3FylcPmnVt83EFADCWtxZHMaP6leJZk16VEGILKv2QimLsthgp6gG259cmoEYD14kQvAWRQCsuWjboOoGBIctql5BNFP920W1MUsw3KC37mtHGir6W8OrUHYNX1XX3jn+nxnUENx2ULg9Fch4taGUbkiEw2kSkzN4edoCL9Wi64Upzi2Mkxye4lmbawg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66946007)(316002)(186003)(4326008)(86362001)(8936002)(66476007)(2906002)(508600001)(5660300002)(83380400001)(8676002)(38100700002)(6486002)(6916009)(36756003)(26005)(6666004)(6512007)(2616005)(6506007)(55236004)(107886003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7KoFFkkQXa1NwRasl7TU3VuSvqZNArz43MyMRMJpH1V9MenbxLbaxPbYpdaP?=
 =?us-ascii?Q?6CANq2+Zx3CcSGCksjWhRBYVAu0VyGgrqITakE1o6mA4D+z4jXkGhTj9tBD2?=
 =?us-ascii?Q?amGcCysx5e9WcZVeXbgfAZkmQHI0FAYDUh9MAvWTIVGyw/sqoNepykm6nzzj?=
 =?us-ascii?Q?LzMy/3CqlQDBAuDxaQQnb24SRWcLPZQdRuWY16OKO7qNV905NfRiwta9GKVi?=
 =?us-ascii?Q?RRFZktGyyccaFciMqPWL7012jAOSr7afyE3Oafh72BkoCkU+rRnEslMHiA7Z?=
 =?us-ascii?Q?WGbI6BlVigqjo9U7+VT6IeMUlF14Hy/rg1y6zr5nKXO78x3FQYd8Lp55XRM1?=
 =?us-ascii?Q?kSJjgzW4UGAVlK10rwW5YeYmvhBGxewPObLh+savPrlocgYLKOxzBAFyoTFp?=
 =?us-ascii?Q?O7wZ8BEV98NhfEyyJGAaTaX/dYD7BisUUF9GSg9RcifScMXDgLakjN3tbixD?=
 =?us-ascii?Q?o2t6/Ex3UkGLhkgFVuEww5MVbzaMfXq1FwX1VL7vdGbq+3a/8wNaeb4xfZLJ?=
 =?us-ascii?Q?bPyUdoX4i01GIvHgYYlofJNWSsEyEaQ5ENCatH20xTlk7WU0mFgstVFRA5Yc?=
 =?us-ascii?Q?xLgoBw6vgbFCxGMghIRdEroq3f01R+7zn6sFFUhl4SV4fiPDSTLk9ggKIIn/?=
 =?us-ascii?Q?hlrubGjJzwV04uYezHEnXOZnCOj7cLvldcOlznlBsaOvxUbeQonpDcv5r96c?=
 =?us-ascii?Q?mHEFOExFDDkQ5bnfvsC9aXelhaQcobaFxekM15d7Qh1CXlxmy9qh3sNDm7I1?=
 =?us-ascii?Q?C9+NUCPV62ogxQuGih9j54y2kG4XTJfAlftF6ojykh/RBOhvZHT6bRfvIIGI?=
 =?us-ascii?Q?S7bMRUinZlTOq+sg+DnRtqOgdiYIWSFYID0bS0OsMPodM/gWR40qA5vnFXvg?=
 =?us-ascii?Q?rizkkTfUyh0SmCxY/fFjg54Y8wmGdnQRitJaK8iARq3/uCZpst780AekZvvZ?=
 =?us-ascii?Q?L6tYzIwXDq9Taq/8n8gLN0SXU2AsOJeNot+LW55VvEn2s3RRhdRIbI1ejKVS?=
 =?us-ascii?Q?HlEVjIcWf6NrPW7HxJe1k5g71/nx81DKISyn3B0txzqYxerLKQGYNj7QWw/K?=
 =?us-ascii?Q?Nbp/g/pkgATk6aghatY3DZKeM5VmxWXCP5VDBA3kG4oogDDYhoGEJnv5Rn8u?=
 =?us-ascii?Q?q2MHnxsHH647j4cJK23tf4P/0Lp24/Nqr6oKbaXYUglw+WXZraF4H/mUpBFU?=
 =?us-ascii?Q?0c879KH4hBh9UsvZpINqsNfgXa6JUv4APUGyRG49YFhxG8El84TkjOA4guHt?=
 =?us-ascii?Q?kd7Ta9JcROwuyK4n16E1k94MhC0QHSBLBriHiF6UeA3275pys6ZueBG8lAgw?=
 =?us-ascii?Q?Q3hELNpaAdij71y/YfTFiAWuY5a1snRzJwWt3qqTwTypVBWrczirSAQGDMJY?=
 =?us-ascii?Q?a3HZivb8hE78dqnOAXvcCQhdV/P+iA+cVs5aRm7QMrhFs3IdxgzOw0AscB4t?=
 =?us-ascii?Q?beMdeml5KHgyGLnbVvVm0+d6pMOQJEQoy0sL91EZleIEr7cfvELLMvwfkCtr?=
 =?us-ascii?Q?b9Q7etbpbdJp1cTWcmS+4qLcQGJbNwZzil/Qw2QCKb57twr8QPDTaNZt6wkW?=
 =?us-ascii?Q?1QN7cGJh6FAqheE82Swv1EyW9SHeyQ1LPAQvnfdUFGeCqCMWtAtCxi6yHo1+?=
 =?us-ascii?Q?WkHMDK6SJT9gs/GAnEAVnHE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16198c5-2549-4177-8b9e-08d9eaf479ec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:16:39.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OeKw7xIpy1je/sWNFT0d1YIqFMBIy6wKQpHIFK08MXlQiTPdnIfinjD/s0ktaC3yPlbMl0ixtKqfTweDfJdMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Since the echo bit is added in struct mptcp_addr_info, use it in
mptcp_pm_announce_addr() instead of passing the echo parameter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         | 13 ++++++-------
 net/mptcp/pm_netlink.c |  6 +++---
 net/mptcp/protocol.h   |  3 +--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8dd78424f86e..0bd8af167d65 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -15,22 +15,21 @@
 /* path manager command handlers */
=20
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
-			   const struct mptcp_addr_info *addr,
-			   bool echo)
+			   const struct mptcp_addr_info *addr)
 {
 	u8 add_addr =3D READ_ONCE(msk->pm.addr_signal);
=20
-	pr_debug("msk=3D%p, local_id=3D%d, echo=3D%d", msk, addr->id, echo);
+	pr_debug("msk=3D%p, local_id=3D%d, echo=3D%d", msk, addr->id, addr->echo)=
;
=20
 	lockdep_assert_held(&msk->pm.lock);
=20
 	if (add_addr &
-	    (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL))) {
-		pr_warn("addr_signal error, add_addr=3D%d, echo=3D%d", add_addr, echo);
+	    (addr->echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL)))=
 {
+		pr_warn("addr_signal error, add_addr=3D%d, echo=3D%d", add_addr, addr->e=
cho);
 		return -EINVAL;
 	}
=20
-	if (echo) {
+	if (addr->echo) {
 		msk->pm.remote =3D *addr;
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
 	} else {
@@ -209,7 +208,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_lock_bh(&pm->lock);
=20
 	if (!READ_ONCE(pm->accept_addr) || mptcp_pm_is_userspace(msk)) {
-		mptcp_pm_announce_addr(msk, addr, true);
+		mptcp_pm_announce_addr(msk, addr);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote =3D *addr;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 93800f32fcb6..8fcba8e92b5b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -326,7 +326,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer=
)
=20
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
-		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		mptcp_pm_announce_addr(msk, &entry->addr);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
 	}
@@ -550,7 +550,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
+				mptcp_pm_announce_addr(msk, &local->addr);
 				mptcp_pm_nl_addr_send_ack(msk);
 			}
 		}
@@ -681,7 +681,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 	spin_lock_bh(&msk->pm.lock);
=20
 add_addr_echo:
-	mptcp_pm_announce_addr(msk, &msk->pm.remote, true);
+	mptcp_pm_announce_addr(msk, &msk->pm.remote);
 	mptcp_pm_nl_addr_send_ack(msk);
 }
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7ee6a39a7ff9..29a8a0b2512b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -772,8 +772,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *ne=
t, unsigned int id,
 					 u8 *flags, int *ifindex);
=20
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
-			   const struct mptcp_addr_info *addr,
-			   bool echo);
+			   const struct mptcp_addr_info *addr);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_=
list *rm_list);
=20
--=20
2.34.1

