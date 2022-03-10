Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FD7A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646899785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfAC9capa+dG+XD2hsj1t26KCF27EscWhUfjnUAQ0G0=;
	b=FrtDpa7MMyPUuwIxrrCbWf6O7pxym9N1yPRQ8ucm/5k8Ncm84PDGdWQrfa6ogc6jQQAlaK
	NB4iccRZUWa52eWgp5TZzZlucM7SjD4YcRm38+TeFXhkeTnZy+I/8GAVgLHi/OwZD1g7Sp
	R8rbv/VNmnv2nhmZizp6p37VQF79QK4=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-ngR7tC1OOHixeWkvBb2sZw-1; Thu, 10 Mar 2022 09:09:44 +0100
X-MC-Unique: ngR7tC1OOHixeWkvBb2sZw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al16YiJulnzWpL3m0IoXBDWM3/+7pYnN/oZnL8CnXc08uF1Sni1bv3EVER9qLuRWLay5NSQoNqwEVa/Oy/isAQerrXxEneCrgpUGLorpqT/1bv88Z0675hFDoYsrComUYTzdzQRJipFlUaj9vV97+9F9hy00zjSVgKlFW2LcQ5mP275SlzAUD1sMzQxIoRsec/Ut+enIjGoigEPik6L/g9Yhy8CtjcYntkZjOMxpx1Syk6l7UktjNw3Tz3WcHNJYCOGwIb0ZwaDUXIJqpwKVsPmvpsfgitURGNfKUCsJeYjBygF5hVOfp/7Mq89d6IES64e6obmXWOf1JQhYWHcjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg4NsWCDGlx9EShkaxfNB/t/1lgKY+sl/WyEBTWM3y4=;
 b=N6D1qwuZ+9rCEI4OGgVkpbTLaLqr+KLcQrpUHxd9fpN3V17bihCfxbWJxe3Zcg/zTVHZvkVsvBF87VSu4NFLzyZndBzrZjCogEyhJd26Ri1LksuJHGTE319IWqdY2p3GfYYU7xjVqQnMKqxjILADOzUuKzOdfDgkTj9cegztEZIEkk5AqYkoHnvuZypRBo9VjZqjHu4E09QoMZVqWVJAZT01b6cWs9LJ8Q78wPUJ2IZGBBtbjE/YI1eVMos603ZtRg6fJs6epL4pnMKM/OFBRWjnADL2CWglyF9grZRb4Gl2IyxzLXPc5zCZsMhT+EdqnM4haouZe9XXPzWDKLRB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM4PR0401MB2259.eurprd04.prod.outlook.com (2603:10a6:200:50::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 08:09:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:09:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/4] mptcp: add MP_FAIL response support
Date: Thu, 10 Mar 2022 16:09:24 +0800
Message-ID: <07c2999bfa92fd1ee9514fd28a96e18d4d4bc3d0.1646898548.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646898548.git.geliang.tang@suse.com>
References: <cover.1646898548.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5142cfe-83d6-434f-87a8-08da026d5532
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2259:EE_
X-Microsoft-Antispam-PRVS:
	<AM4PR0401MB22591D6468028D5A8F767C28F80B9@AM4PR0401MB2259.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gbJrWqAmRsrRa5i4KHeqhqMxhBjfudW+SkKyslrXklf78YjCdmK9Kf61kgrefqUJZjT8qK1buhADXRBb+HUEqgU2giHjVhwUeeTArDt6fCLu+5RZwJQqGZgMHRmyH+u7PvrO5OQovHKADSpo2ncPy3Mc1YjzetbcURpsJGE7Rz4G/QSlAzoL0Ic/MYsx013wVb1Xs7T69L+OIFtEM80zgKfTQ3f6lzL55N8wECTR6BUAFyQSFMxVUmZYoNIfGno+LJpT3y8WoU4bDJn1M8YZIT/oUvbwUWlehG6shLHu/T0MXvAJ1Mzmjw42QvqP0qgGsTVSSAFcykKWpg26+s0yi33ms/jVUURjLB+zmtjyKEyZzIP6d8WKSScarYoYh2NYwbIA1adHQ4NXWZgLefhq4ObwE5RvHssPfnJO7bWhNuWke1RSoyJBEyilTlPqizsQwixzElsV9GqBZ/ouhFxPaUbOLkkYzKaraKHTaKGS6rlb8k1TTL+tf87X6ZYIhDBhsX+p1nxSCr8bFziIkNEOWoKg/VeJ4wySo2uVsQSWBc9sPpkdrR3J0Ik+ufBruFknQWDxUbtw7ePEjybyXfTLTIXnb/Dm2m0Bmjr2FPGa87demIzL36zvUXQLmOMSk2UXNkjWiFicthSfZMbiCZ+icOl8F43DZPBn/x3u22B0kcFhK6FXptM5ouFplsmcHz0o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(107886003)(186003)(6916009)(316002)(26005)(6666004)(6512007)(6506007)(38100700002)(508600001)(86362001)(44832011)(83380400001)(5660300002)(36756003)(4326008)(8676002)(8936002)(66946007)(6486002)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gb9GxLc5ppf2rHe+Ks8GQdfD2QSdg7R438n+GQZah0mq4XyEBIPf/UPtNvn4?=
 =?us-ascii?Q?LjwGMCPiGD14mECgJ2SU6Atfaa4dc1uSpfnNEqOAc6XopZmW1UVA8ZrL4Ifh?=
 =?us-ascii?Q?62mek3qK9YXIDScStoPcSQWKs7UHlaJlhI4ltetynwvw/UQdg2OGQ+meAp/Z?=
 =?us-ascii?Q?VatTUy2n5aU9gUa2qXfPrGMbQizaxCK64CJM10g3qGguNVSX217LHby9/80F?=
 =?us-ascii?Q?79pYHgNgwF421H2hN7qkert2WJNgZ22gf/4cF+WbFPU7qtrDuh/fIfM+wr2R?=
 =?us-ascii?Q?S6GvFHrmPkrZ0pLhipVbaB47TWCGkAXPLh0tRn6oqJc5wzLUPOFhIDDAkjVt?=
 =?us-ascii?Q?1bBItOAlLtc8jWW0su4tfSAndzEnAn3/BnBvnpxlxT3oldX2gKYeFhuOaI3k?=
 =?us-ascii?Q?cQyWwe8GkbnUXc86cHMvprTsV49b+/1PypvSPartPIwbsNWVEyXz/qWhwbmK?=
 =?us-ascii?Q?3U4dpvgD2PIjbIkt0NBSLkw4CNB+S2qrijoWesbpczLYwMQLAyJym8d3CYPL?=
 =?us-ascii?Q?Jd53zJMHWPYabEC2rmMciie5a28/rExVg6ZGmVIwnmpY25/B2ep3GfVQduYx?=
 =?us-ascii?Q?EYt/MlX0T+PXykw8zIvzYlzPVOc+poYEksVMfF6qSVP1YXFfhUyNFU76CIoV?=
 =?us-ascii?Q?sbgr1nnMZef5NO/mOEbGryn32RkFirplOMvf1EUw7fL+spZJgsubXzH8YGhI?=
 =?us-ascii?Q?hBkzbuH3muT7fdB6e3It0E9s8tWfF2WbjXyImUI3EogUPIwfUHTps7yAYuJw?=
 =?us-ascii?Q?PPoS8DGWiA5btIz5ZCRmO3Zg4HbPc43DAb047LX0XfRMfxkIZwsDtvhQt3F9?=
 =?us-ascii?Q?b4EQNKEaWW1tT24AhqU/04IEFbAfVmSHsqBuHGrNWvbxwTMg+mVItV6IV8b0?=
 =?us-ascii?Q?S7j4g4oQh4LS1sx5cFEaS37T6OjhAf/sCvI08JWCdWUtmPOTuCDyNHtdFYSF?=
 =?us-ascii?Q?U3MCwyJWsW/TqqH+adr0F3k9R9DptOe5uqTEiW8/P+zh+skMD+Xrn7+wuDDz?=
 =?us-ascii?Q?VnaZKkOV1EEesRrKlSGt6y6JA6XbfeUopzuB2xsgnR6PJmGUzT7V7oF7ynvy?=
 =?us-ascii?Q?4aupkMJ0VQ80an1sCEjXCJbZVDHv0+yQhRjuGqTTrd08S1ERgaDyb8I+rEHS?=
 =?us-ascii?Q?xLZIvmbEjildWoNP4X3CbhhVu8RdmUagFtSh8xNiTqbO/i6eMOBiWVFtbHes?=
 =?us-ascii?Q?CHtFCu8RHDipbWHQiiNP7ookcvQ3BZiiDKqed5cud3tr59QNAswdm86IDusZ?=
 =?us-ascii?Q?Ph5EWXS0Fz8abU/hh7khCSehR2j4mP5HYu5En3mYsww2fDIGTtLAMQ7b8Tjd?=
 =?us-ascii?Q?P+IoBkHbxMO+BHst25OAgEuW4BpZjeJiu+064a8dRPcgywxsxXittg/yZjHF?=
 =?us-ascii?Q?GGLmKI7bSo+uwE0fipXwDxmm2BzppA26JGvVrqTERiyWz0Yevk4MQ9Bnyo/F?=
 =?us-ascii?Q?FjmztF5N2WkKGvBh9clm7wP3GerkYYbzaJKXPiZPiK/8Ol4xiopv4e30pSov?=
 =?us-ascii?Q?KtylfaX4KDG3/S9haIsrf11PcD6RMs1vbSOySHslIsWfl5jbO5yzA+uVNPo5?=
 =?us-ascii?Q?BcyMnQk0OwoHB1jVmAcj1kFmVFBD7yh2b6oOaXx85kc4gISC4fsEk1GU9qMc?=
 =?us-ascii?Q?AHrTxv1MXcUx8VgKoSNXd2I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5142cfe-83d6-434f-87a8-08da026d5532
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:09:43.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvg30ltrmiEMwBMdXDD92r9AxhZvsKmerFbc5HSOjwplqTlU/bDfUhHko8otH0/wSgBt87A4TQ8n8MjJuR/Tjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2259

This patch added a new struct member mp_fail_response_expect in struct
mptcp_subflow_context to support MP_FAIL response. In the single subflow
with checksum error and contiguous data special case, a MP_FAIL sent in
response to another MP_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 10 +++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..f5f4561f332a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -279,8 +279,16 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
+	if (mptcp_has_another_subflow(sk) || !READ_ONCE(msk->allow_infinite_fallb=
ack))
+		return;
+
+	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
+		pr_debug("send MP_FAIL response and infinite map");
+
+		subflow->send_mp_fail =3D 1;
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map =3D 1;
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..83f0205f0d95 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -456,6 +456,7 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1; /* local_id is correctly initialized */
 	enum mptcp_data_avail data_avail;
+	bool	mp_fail_response_expect;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30ffb00661bb..ca2352ad20d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1217,6 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				WRITE_ONCE(subflow->mp_fail_response_expect, true);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

