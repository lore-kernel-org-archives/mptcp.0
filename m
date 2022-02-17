Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA11FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645097039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZ6yJjsop0VnN+fI/OpWxub0lNOCc/NSc8h2PbhIH50=;
	b=PFxBZ/QiNifu+enIwfU3cFeFi9RwtUSBaiAZWih8s+qK8Tq+IVxoak8Y3UN4PEXdeJtRsC
	v90J+R2GeRDAe5fYlw05XbFcJ8hCYXqPJ/hDtBTHhiH0f/5Gz6F1m1Mi2OAVH0SQwLBuGE
	mJ+7TvlHxcYeLjCUBH5HPe/WVXjdlLU=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-tx2H2mHgOBq5vg778RcjYA-1; Thu, 17 Feb 2022 12:23:58 +0100
X-MC-Unique: tx2H2mHgOBq5vg778RcjYA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFbeyjomWa9qOffv8LmLiVPP1jvgojT1ttsIv5yxZDteDmsgSP/biTzaa6LzafzIcAWNDf2dRlX+SgSvCNkP+ysxhoTRZ8PdT2jc8DHqMeZ48j9EvK8WvPgY9pRnBGqPMbNvczBD4mhne0mAynDkea/QkK8+xjVDVhUsTIcqsPE7/NPfuzStp+A0JbY/SyAu4DXnscAvB/eTJkIWuvyLwZilF8ntStgqfAVm06Ma9F5pRzMRq6mbSPUYgDpV/um57jItJOndbtoOTsukL37CeUM0ihYYXuuxDAIYa+zd5AGuoadLc5bm14BQatTULK4nshEOL8gBSO3ZSQccHGBw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTYglwg7WT9+R1hisLlCpfOlWG1aDSmHUy9qAzxFKms=;
 b=JVlz5Wb3tGfZmkft6ayR2pb8Y1DZEZDxWZlU2YDkIsMh+V59q2M1jvdl4z7A6kgmJ67mH7BZ8ItK3jtPS+lauulwONMqdsbflHfBVUvgWwP9uXWXnXI4eR3d2QzL+gJ9EQIOQvblRZB5o7zfVEYCsU+1ZsDeONF0LmPuy4QUKjitG4YzaKXvQR7rZwYlLvG8KWxP1ABGFLFdJkuUko0jMfEikwIpjSpqdcMY0OpYeo3uZorPH8oDkTiFBChoXpeA7RtcJQ+US8ilNqvbPCHioPFK3OAP48e6dB2yPJKE0T8BKAZBoFG8qOESTkxqLFvMiFt9b325W+idGne0/GrmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7280.eurprd04.prod.outlook.com (2603:10a6:800:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Thu, 17 Feb
 2022 11:23:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:23:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 5/6] mptcp: add MP_FAIL retrans support
Date: Thu, 17 Feb 2022 19:23:43 +0800
Message-ID: <b0f55c56cf296b360582fc54997cbb3f905c106b.1645096378.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645096378.git.geliang.tang@suse.com>
References: <cover.1645096378.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:203:b0::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a404d574-2ebd-4c5a-aa88-08d9f207fbce
X-MS-TrafficTypeDiagnostic: VE1PR04MB7280:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7280786A529813EBBA5A022DF8369@VE1PR04MB7280.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M+AXdVOsAc9Q+i2IuxdNHnxHpQXi/m5RAc4d5afsOv3ToCpvF4psl+bxs0RI3nQ0kOIdYQfwInG5qlFwVqUMjhXXjs5B/gwSkishWxnHvDwkfmRCXHirc9xkodYgQocd/gKnSXwXsRe/ytbbYXNLHO6Ry0w1ENqVeqyIMstfkgt/2PSrRH9wQxJPZyBpKVd+xqJL4Z9foyIBpSZymcT9ULn6O6Q5jaclHYdvFXFopSp6oP/2ZvP0gdtLw6nHFFDFceetdteiqXt4LKgId/3mPErNbXfOIbUTunPefdmND8mHhsp7NembfhZ3apiffSVVmbgPqieJM6Z3QR3QR2ST0Es1+Qet5y5RbGZ/gi/MjUDg1YdW1T4gq6rsNfk9zgzsKeitMSvfXbZFb3F4HQ1gcKwXAd/DwBvTc97CvaNgKaPo5+1s08mE/3BQ/nNEobmYnSGMqnemt71bmdBAyKcH0FL7wVnMUdngp2s7D1F13lk60mA4HX0A1G9/EYwv3M9Oh5MSCB5esV6CvRcJPG5LkhBM+xuFZSG564G7NTTWXO+wWHqhtp62/Usd/Ljkky5FuSmBsZPimwBZc752k08B3Jt/WRudHFfJb/NOWf2du0+yU1jOdLJg9RWcGtdz396tmtpxnn75BS5cL2XylZ0xeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(2906002)(2616005)(107886003)(86362001)(6506007)(8676002)(66556008)(55236004)(4326008)(8936002)(83380400001)(5660300002)(6512007)(6666004)(44832011)(186003)(66946007)(316002)(6486002)(38100700002)(508600001)(26005)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/NGW9uPYijDi6eLiqIn7auQgnnF2D4V/28eYN4UgpSem2hUWRDaqICNOeSfR?=
 =?us-ascii?Q?VbP/LS37qmAx+uRGTMlwDkHW19AIfG+P2VVZMAlAf+5I5U3pGf2isMMpsD0L?=
 =?us-ascii?Q?M0z30mOKpTi5iy0mxYIQq3XyoKSqDaIomDEo0rDj56ZRcXVSTrTK0SzaP6iE?=
 =?us-ascii?Q?yO98vlhLBnF53CEzyuJERsAKtud0JZlaZlwYeIqT0BEH66hlE4xVWjJhegce?=
 =?us-ascii?Q?fcuHCvhqmH/xU4ZV65J0Lh+dM09RiYRJMCnLSW1dJTEZol+3hiKPwR2LAzdK?=
 =?us-ascii?Q?sL18nqr/IoUik7kPr/LgmmDO51PZfB34MCI60NuGT/hb1b04UXQn9LZK3xXD?=
 =?us-ascii?Q?3FZOqO/hDABXb4H6Z12UPR9pFomtjEN2UmSIs2u3r/waOZxYAmlLY6qFaQQI?=
 =?us-ascii?Q?O6Z7jsL+lenvHCYpa60NzENvDtf7CScF26A87x0fw5TKgd8tbflwvMWGpVJj?=
 =?us-ascii?Q?g+i4p02pb2Ii941CDCNT2k9QvOOT2sf5ALHwoQVFhBZK7IIo3RXkYoXJDu4w?=
 =?us-ascii?Q?SOiCojnkskOErazglDjILGnoSbyEzgE9IX1QAwxO2OJqkugXTwHrE5dQt+ao?=
 =?us-ascii?Q?Tqy6uWLGsVkmSd6r2W53CQdZxqrXsTNQMpdRib806bbvcJpt7Qm6CNVoNaUN?=
 =?us-ascii?Q?+b9IlEAWAMnBDn8PEz31N8K4104njhBmYRsQMrqtRwAdEjZ+glwzVlfhElFS?=
 =?us-ascii?Q?d7ctp9gsRCo98P4THUZ8ejC0OD8USDpFfxG55TOVa3DuJFDcJfw/rvsXKbzp?=
 =?us-ascii?Q?D4I2bVmqdY1kQirh40Gg6kJcDmha5vTwl85z2d7jyTDK0twzwvkFnX089uOo?=
 =?us-ascii?Q?+ET/FUrdhA5IrrL9lGEfdjHYttRIf7XpInEtIf16IaMANOno5wVxo5OgL174?=
 =?us-ascii?Q?YXKY1We103oXMoTgF7g2+jRoY5G1JlGuNS5kb33rR9NfyuylFsLWRjYsgza8?=
 =?us-ascii?Q?JEfVHKWyEL2Z8WxY5maHpjHe7sT6uItG6Qz09+KxIK+tvik5IbbH4mZJMCdf?=
 =?us-ascii?Q?S/lPtIjcykNiDZmCuKr1tyrCkex4BUzFD8czJDaDXKoB8wuiPP2IdQV9Dgve?=
 =?us-ascii?Q?xF2KCDM97ojBqpWl8ShDuPTmguIXSE5PfJAnwb219GqRN4A45hQwbCOtRH5o?=
 =?us-ascii?Q?fRKvdrjI/DkLADJDHrzCHyAyILjwMLcJhABbioiIxKPIhl8ShFerj2cUlaqC?=
 =?us-ascii?Q?QgtqsF0k69ZuBFXyacvUrrsDQX2vmUvwEvFKWC18xb+1ooslobWP5w5ugOhP?=
 =?us-ascii?Q?cdtPXJ81bkLhDmjUAI6/Pzp8P7ARgS2hrvfEM3XXtFpS0DGXWRVz4vij6yT7?=
 =?us-ascii?Q?ZyL3sV794PyJHKP45GQSY2sl+MnFvNmGje+MSJjV5TG/ACsn/JexVh5w9kGe?=
 =?us-ascii?Q?736xpV3Jtl1euW/uzc3MaPfap+AhX4c9pkwRQCY8mk4dHqqpwti+ZsaD2aI+?=
 =?us-ascii?Q?GyOu7SHXqM6yh0+NdjtAwt3pUriRVyigSSB73RGvDxsXXybmLDbnOoctBWF0?=
 =?us-ascii?Q?6135GxSCDjA/XFPx9YVIFgVeJbqefyTEomGbL9m+w9l1vtTR0eV1lwI24eAF?=
 =?us-ascii?Q?HXKYmUsBmcWKhFmcTOggYMR/BArqQb/9Qog2JdNrgjN5vJ9OmrZvZdl6uYoA?=
 =?us-ascii?Q?TtK8nB0G6OOvQxXd6mAHJmI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a404d574-2ebd-4c5a-aa88-08d9f207fbce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:23:55.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzzzXXEyzUtgVeqEeSQzknmLvqeGc315CoR7OLvlvEMpsdm0qyLi+oFCsceRUWrRlFfnPqDDYL2dehOfIc5Xqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7280

Add MP_FAIL retrans support.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  1 +
 net/mptcp/protocol.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 314e110588d7..ccb29b2d2075 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -285,6 +285,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fai=
l_seq)
 			subflow->send_infinite_map =3D 1;
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHOTX);
 		} else {
+			sk_stop_timer((struct sock *)msk, &msk->sk.icsk_retransmit_timer);
 			subflow->mp_fail_response_expect =3D 0;
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHORX);
 		}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4599bde215b2..461fd30c6b9d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,6 +50,8 @@ enum {
 	MPTCP_CMSG_INQ =3D BIT(1),
 };
=20
+#define MP_FAIL_RETRANS_MAX	3
+
 static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned=
_in_smp;
=20
 static void __mptcp_destroy_sock(struct sock *sk);
@@ -860,6 +862,46 @@ static void mptcp_reset_timer(struct sock *sk)
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
=20
+static void mptcp_mp_fail_timer(struct timer_list *t)
+{
+	struct inet_connection_sock *icsk =3D from_timer(icsk, t,
+						       icsk_retransmit_timer);
+	struct sock *sk =3D &icsk->icsk_inet.sk;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (!msk)
+		return;
+	if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
+		return;
+
+	bh_lock_sock(sk);
+
+	subflow =3D mptcp_subflow_ctx(msk->first);
+	subflow->send_mp_fail =3D 1;
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
+	pr_debug("retransmit MP_FAIL %u", subflow->retrans_times++);
+
+	if (subflow->retrans_times < MP_FAIL_RETRANS_MAX) {
+		__mptcp_set_timeout(sk, mptcp_get_mp_fail_timeout(sock_net(sk)));
+		mptcp_reset_timer(sk);
+	}
+
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+
+	/* re-use the csk retrans timer for MP_FAIL retrans */
+	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_mp_fail_timer, 0);
+	__mptcp_set_timeout(sk, mptcp_get_mp_fail_timeout(sock_net(sk)));
+	mptcp_reset_timer(sk);
+}
+
 bool mptcp_schedule_work(struct sock *sk)
 {
 	if (inet_sk_state_load(sk) !=3D TCP_CLOSE &&
@@ -1598,7 +1640,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
=20
 out:
 	/* ensure the rtx timer is running */
-	if (!mptcp_timer_pending(sk))
+	if (!mptcp_timer_pending(sk) && !__mptcp_check_fallback(msk))
 		mptcp_reset_timer(sk);
 	if (copied)
 		__mptcp_check_send_data_fin(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c28842ab0dcc..40954f2389e8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -467,6 +467,7 @@ struct mptcp_subflow_context {
 	u8	reset_transient:1;
 	u8	reset_reason:4;
 	u8	stale_count;
+	u8	retrans_times;
=20
 	long	delegated_status;
=20
@@ -669,6 +670,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const=
 struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
+void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk);
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
 		     sockptr_t optval, unsigned int optlen);
 int mptcp_getsockopt(struct sock *sk, int level, int optname,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f06d93fce1bb..a30867f926fd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1174,6 +1174,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 					sk_eat_skb(ssk, skb);
 			} else {
 				subflow->mp_fail_response_expect =3D 1;
+				mptcp_setup_mp_fail_timer(msk);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

