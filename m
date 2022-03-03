Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C6621
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 06:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646287501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIxhUX+SxeqkfhyTmhEGfPJB6blEEPw3f1+C5SvO/nk=;
	b=VuZNfeDXorow8VCQZX6Przi4//OT/akGmHPtqWOI970Hg73iDrsAkEmaE8I2yNU+0bWv4E
	ZMF5NRGus13nDh8v+0lSQ3jAG1vOgfS/KZopTOk/VSh7MFGPgcy2MB+gObMzBSiB8R2M5Z
	9i1Wcu+BPUVwJ/4AdrJ0Pf8N+1Mv2aQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-rub_qN3xMGePnJLRdVW0QQ-1; Thu, 03 Mar 2022 07:05:00 +0100
X-MC-Unique: rub_qN3xMGePnJLRdVW0QQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORaCgB8Jb19BdhUNZkVm3rx9cRc4UTr2YXlD2cQqHLFIvNlOWQemi9W0RYOoEooxoHO8hvDargxjiaL2u/xZIMJSrXtvqeH9TWdbx2QM0lMHNWBCjokb0vCEatCFKeKU7/yoyvaerEYoFe4hDgPcBhz5+P0x4C9zwPRRLtVofrss1jaf7GT80nZ0G7060m7IaWgwTXh15LvUzdJOUBS9nWVozUpImpMFWef5zvxZ6/D9DyWPUI9URQX3uvjTq2kdbLDSMHqFhHQGXF96m4nRGoR7ROl4fJ52alrhRbuJpbbVqPMRGbJ9gZFH//JmMmyZHobfoFk8TJF5g0ptWtTWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR+U+0eYwjE+baYzrUBdT1+grp974MDqqOtjVAflAfY=;
 b=gmdeDGJhiQG368lJNWN+L20EV6ySYbrZOc69/ArqH5D4TjXf+Y7NIhC/FrEVMdDv+Xxr/uKKbq0sK0BXlMnfCijz0GYMNuMRh/83ZGV1wccWd+hYoJbnSf0T+IrWKM/OXn9rNDYt6mPdCBhM0zGWqfOS8vbQVemTJuH60hXFshbIK/pVtylNnyjSNwW9q93sC8PZgOtnf3wIQrFRihP7ywRomaYTola6Px7ftq8UymZF2VdztKrdWm4onqm/Np47jXU3HojbVeP920ItL07nhLVyw0efLJR0Fz9OyNhpz8uN9Odw+I2fd1Eocd0J9t7hEadDmndLnUwLjok91BRN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5041.eurprd04.prod.outlook.com (2603:10a6:208:bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 06:04:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 06:04:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] mptcp: reset the subflow when MP_FAIL is lost
Date: Thu,  3 Mar 2022 14:04:29 +0800
Message-ID: <d4b8877793e878092bd17cfd45018b0feafbace0.1646287286.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646287286.git.geliang.tang@suse.com>
References: <cover.1646287286.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08cbcc24-d624-4fdf-ce56-08d9fcdbbf99
X-MS-TrafficTypeDiagnostic: AM0PR04MB5041:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB50418AEF3357B3DC0A819A11F8049@AM0PR04MB5041.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lEmTUO12Nw6OQvc7n4l2AOprPcJgYGWMKBs4skCJliWkoClLJQ5cIFksSW20dO+03fOEevzoHr7BBmBCvmGWKfyUvO6Y8zARS+IstPo3E7AZ6aF3seWt+avDpTxLo0ybdECXp0lOJql54eOUOx2PRm59dHYq2wDPyde1nndmfHev8SaK+vXj0N5tx5R1LJXnlgT2h/tQRf6+JJUdURxetohtAShdN5lj5ag9RZWx/oqQ7/Y89tjkQfT6deYMTi95YNZT3QUzdIDam3tqFhNhM7TYEv3BJv9C1zo8+CNysnSZa3AJCP8zooMj6orpdsobCXl6PcWp7WeBOGVozV/BdIajHrKN9JhQw7HLrmU1MfdK37WhSgV0zl3vlS58Jy4cUylMZmCy3lmkNWBqi4+70MWQ3G5z9byBSJaY7lr5H8vETnFoit8xxAp/FIBJvZEuklJ24Tbv5Enm/SrfMeW+hfYgUM1Rt6iBuR6WWQIPdQvb27PUSbRtk4yDbkczflWx1Y8h2fa32FSwtxGRktJJ6aYaLv5e51izMLFZ4ruAGObF69SZlmOSQgwoLfeu8IyEaQaNjSV6BvzZ2CUugqta2H+otLEOCZnhikK6wV7XlhRE5t5uPoRxW3M6plNKopm99eWvy4k6IBf0i7uUDVA3cBq6tX4Na7Q3OnQlel3uKRiK/9RUZ9krNtC+bt+nSelf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(44832011)(36756003)(186003)(38100700002)(8676002)(4326008)(2906002)(66946007)(66476007)(66556008)(26005)(6666004)(6506007)(83380400001)(6486002)(316002)(86362001)(6916009)(107886003)(6512007)(2616005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?82+NCnDSzpv4lHFq3EE5zqz8AAt6jLK5gSxQtSG+y02Zpggg0JWtO0DNA05X?=
 =?us-ascii?Q?l2WJof3/9baJR0G+Nq5oEEY7+VR8fcp8icy8k3Jenc2gAbRLt6V7paTw7eHn?=
 =?us-ascii?Q?bVwP4Bp7UZRwijah/dqWtZZzutqmwIY+YvvRBRkJEcgoH6+DishOqCQa8vJn?=
 =?us-ascii?Q?gP6lcNE2ic7yKwbKGuxLWRP2AuRXA9vp5b/Up6/q/HgMkXLz6yRaVx/nxA0X?=
 =?us-ascii?Q?P2i6kPhe4OWNvpU4xB1V/Q5UJe8Z4XK5/nWNO/i6LT+kcT6PQzdZhnatDERy?=
 =?us-ascii?Q?pjoM3niT3+H6DAFAIsSSWKifWM7Qha9T07+JYQch10/C78LfuRHe00DjRUsS?=
 =?us-ascii?Q?KiT9BrPgu5ZNuinuRNJPpNcRQp1ojChx36r/t8QJjtJ8l54uEtF83DXnJF5+?=
 =?us-ascii?Q?zmS8ca4qXlDe7b1yeWG49Ov49sye3p22VnBYZ5wcZijuRr4Q25VbDyIMpG62?=
 =?us-ascii?Q?cvekK5WEkSXh8z6/Pr6OQq/bAyeSi8GrqrqMa+IforSjFgJ1I11XXBaleGX1?=
 =?us-ascii?Q?Xz0qpd25Pn+g1mjYjb7fOGMJQXPWn2ynCevf2LdQmgcQlgZfPRh/J0HlCW68?=
 =?us-ascii?Q?3tqDZPjxSJpoQx2J9WzuoY00oExRRhjewrb0BSio9RpRzIBVaOBvrxJe9juj?=
 =?us-ascii?Q?exOfl3ldtNf/uQNtYm6ZAXiReJDccK21VNFBmSRJBOjjKkB/sNm4tqT2Drk8?=
 =?us-ascii?Q?TZMxo54Cs58t5KvRmLH41wSGENdmWayAt7vktxaonoUokhLE+hjZJ0Z5vX2H?=
 =?us-ascii?Q?65RiKxDFQRDvJfv3QK2W6nM7xyDh3h4jd8GeUWJJi+lWSh1gVYFMU7YNZ+Nx?=
 =?us-ascii?Q?sZ6fa4ymzVMdqdghEzcIk5cPxPvJUKLzdi/TUEqsqv/t1wYTDNTxD6F7gLkL?=
 =?us-ascii?Q?ttnQmnz5aAVFDVBTmKar5bXp3ngtv4NZ/bzj6RocUNzq+kneILsDFg5xXEJd?=
 =?us-ascii?Q?u8J8go+XY1O+vcA5YJOKV4VPERScs5SPZfsrZLW7kiy5CT69zWlogthYEFzO?=
 =?us-ascii?Q?GP8aqcyd+nIvKNDgdsvIWIK3jcnh3nQlTbsSZN9PVKDzzEo6NCkWd4P3dhgM?=
 =?us-ascii?Q?hD8fdxirQCSti9IbICerX6rYa92ba7hlEk5YtwR8KA9e78eSzQ02/UjgrI2U?=
 =?us-ascii?Q?7sfjEESx7jZOID4z8ASq1N+JfchEEzYiK7KbctU7ZjmrDDQ2mQDsIt8B1dTx?=
 =?us-ascii?Q?uLnFPe9eO6Q9F9BTkfpJsG7WpCgI2oZtyDfst/OGuXEXJU096jgHi4YxRTje?=
 =?us-ascii?Q?6aTtFJikbD5aIoIpd0P/zzfYZR9y/k8G+rppv6PoMWocjwOFXOERWTju7j5S?=
 =?us-ascii?Q?FvpqGUPiXhhKU0n/+/RhJ17ELVu2o8rbi9+drxsneDioxgjDgkGJxVdKsV90?=
 =?us-ascii?Q?p5O9bkFe1Kqi23Bb4PVY445FH/SXVqZVa2poR/KfM956u9u0Cq8FeuiwsWwn?=
 =?us-ascii?Q?5miagoVMnimuvdGI32DkG8gWeyt4aPbeg0mYXPDu6ql978p7PXeU7rkZxRC+?=
 =?us-ascii?Q?Y/DGrg3R5DiG8T0qdzoUo2LoLvW1PjpAft4rAsWpenzXFBwfdMNSOoMTepSs?=
 =?us-ascii?Q?ppTgvlh88oeOdXuOoomTIehQN9ETXpAaHs5+ekQlv/fO7E9mj+rQcOjLFrK/?=
 =?us-ascii?Q?XvkEej+CeqK++Ml25q28Ivg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cbcc24-d624-4fdf-ce56-08d9fcdbbf99
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 06:04:59.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXKaBx2SDyK8VBbeh1o074NRI8rwoDrk/dicQo5s6spL4phq1HBSaKDjEKZYdmwg/FB9Ru1p9l4XKTzf58QcRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5041

This patch reuses icsk_retransmit_timer to trigger a check if we have
not received a response from the peer after sending MP_FAIL. If the
peer doesn't respond properly, reset the subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  1 +
 net/mptcp/protocol.c | 32 +++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c9080230b800..441f5c79b601 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -285,6 +285,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fai=
l_seq)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 			subflow->send_infinite_map =3D 1;
 		} else {
+			sk_stop_timer((struct sock *)msk, &msk->sk.icsk_retransmit_timer);
 			subflow->mp_fail_response_expect =3D 0;
 		}
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb975227d12..59d2deec1ae8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -866,6 +866,36 @@ static void mptcp_reset_timer(struct sock *sk)
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
=20
+static void mptcp_mp_fail_timer(struct timer_list *t)
+{
+	struct inet_connection_sock *icsk =3D from_timer(icsk, t,
+						       icsk_retransmit_timer);
+	struct sock *sk =3D &icsk->icsk_inet.sk, *ssk;
+	struct mptcp_subflow_context *subflow;
+
+	if (!sk || inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
+		return;
+
+	bh_lock_sock(sk);
+	subflow =3D mptcp_subflow_ctx(mptcp_sk(sk)->first);
+	ssk =3D mptcp_subflow_tcp_sock(subflow);
+	pr_debug("MP_FAIL is lost, reset the subflow");
+	mptcp_subflow_reset(ssk);
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
+	__mptcp_set_timeout(sk, TCP_RTO_MAX);
+	mptcp_reset_timer(sk);
+}
+
 bool mptcp_schedule_work(struct sock *sk)
 {
 	if (inet_sk_state_load(sk) !=3D TCP_CLOSE &&
@@ -1604,7 +1634,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
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
index 39aa22595add..313c1a6c616f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -669,6 +669,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const=
 struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
+void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk);
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
 		     sockptr_t optval, unsigned int optlen);
 int mptcp_getsockopt(struct sock *sk, int level, int optname,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63a256a94b65..960b161b1cb2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1219,6 +1219,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
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

