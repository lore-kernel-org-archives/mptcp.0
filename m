Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712607B
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654732876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMM/iB6esnrGGp0/IGyocozOLOaGEtfRIYi85Y3YZlA=;
	b=kgVoHI7QWGcLUjcR0QSDdssU/6yHPOyBn9ATgBdQrwOp+S4bOpZQ/1zb/RhhBB9LgoUWui
	tyYbUS8JMj8F2+gtJYhEzamZpWxRRH5sJJKSpA136/uADNp7MVpbCxvJ4P6T5Pm/cTgMFQ
	yMHq+z0ijMMoUQZmmIZB7BXv+WAlNjI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-82K39Bf2PreFDB_LEbwSVg-1; Thu, 09 Jun 2022 02:01:15 +0200
X-MC-Unique: 82K39Bf2PreFDB_LEbwSVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+jtWNLWmg18lD2McM0823ELWtOFdpmnJcsY3bvEuruuxRHxrXjblrLahy41TIWQNfIN4IcVqcKwxxZ7fzMw0n5HiTnPhZSps7s/RYzTa2468aUPI/gNIHdYLyN67GteiZvdGWOjXDsj4qzfgsZpbtSFihWWU1Fsp7mLsiM3pIjxGpXcn8PmHePkiRxmgrXD70f1/PmViZrN4pigEkXRQpQ/eALiP9JHew4BDQkZFDl/5R6fI0iR8VODnM1sB7K2SvZEjBpZ1r3HOJ3NlsKmlkw0y//V+/MiGX3zuGwbodAU1vnt/P1SiTzwnRYIkv2DHgCMe+l/tQ6PxYkMobeSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugGxdQH/TBh6zHgxZ4nSUsB4TVEmdBAeEirjrCAxfGg=;
 b=e1HIxyiYhICAw7fmypy9abA8/91dTqzrykYWvRpw9V0/tyRkk0e6RVunqA4RfERbx0nQycR0oeGWwldWDyhLlqp6P1VubpP6H41WbwUEKwNUOyhD3vTFm77N1zoHjlSOAPXnEJQD6/5iGj3186CWoCGBeH7XbY7CXmOMUfl1/3+9Pbeh3Y72Lo+BbXOG0gBMgj6q7yG3x+eDz/wFmtXJbon0DTCm8Qo6wHayRo8D64Dj8oYkBTmvoxCAcEXXR6zaWnaqwsTJ/+DfrLtYmqWsU6ygIIdb7GoreETfPZG5OX5dAzBDBPUFDcs/MAOcJnDJ76EAjFzYzxsbsNl8BFk5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugGxdQH/TBh6zHgxZ4nSUsB4TVEmdBAeEirjrCAxfGg=;
 b=SDlZFgjrEt+ptZ9sYdlrUzmqMjT1BtlZCsF7dGb5dSjL80uANsUugGiMpjAVmNsHdF/PdcoZKSv/HekiVUwPjmydQZLuAgeCPC287d9JPIG5IMqldpKEsYo8h4kgE14ktyogl4OBVuSKe0Z160opgNOg2hoYXCBbvmTFCCQOFAytac1vqrXOkO4yDHEOqJ9jAVPVKro3TsJb2lEtufKmzqoBeMiAtRLjEbeES17EfySpvckFGe/tTd7s3pBAeCB41xCslzNmtCxXUJR8eEYlt+Kjat75JJSUmb8diDrrcsvVWDmHmGxX/ULG/DmysKTiluavmIX0n2KLExNJO6t6ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4263.eurprd04.prod.outlook.com (2603:10a6:209:4f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 00:01:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 00:01:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v4 1/2] mptcp: refactor MP_FAIL response timeout
Date: Thu,  9 Jun 2022 08:00:52 +0800
Message-ID: <ee1ab6a8d4525e7af542f84ad11fcca7a1e938e6.1654732564.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654732564.git.geliang.tang@suse.com>
References: <cover.1654732564.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b837a99d-95ea-40b4-e35f-08da49ab2b1f
X-MS-TrafficTypeDiagnostic: AM6PR04MB4263:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4263138048000AC59BD2BB2BF8A79@AM6PR04MB4263.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H3ixPuiRpzuaXe9BQXx2uTy3+gqoVkrnw8x3FxLlQLbfCAdOF2dLaernppb2trpjpb+4OmDaSPh+lpYj95GwBH+/IWQMSlrNbLUYXYKdHmLeL9XypxmC+KD8dQb5+IkGwGFlN0eIfTxN1b7YOS6K2/VOfsCgJMjqVdLdHVkp4iShhojPcciEdBSSVHjxRIho6Aa719Me4wjFVmPOZOO8jdYXGkrpY69knUk0VECrq1zYqmZY0ayMtOBHFfozXM65fKKhe0EWGuZeYYHNRHdsHrM+xEhraB06a/TwXRBAtdttUl8gaCvTzEQdydZobdWCgbGTnBMbj7JrHB50LuasUO77KgV8DTDyt+J4ag72d+V5BHXnhhhKUagJ8MCF76xQvZWOnT71ulc7ytUuDd3ff3R93DA/04/Gq9TdkWEA8PCVnu1E1SVevb4+W+kUr9mIqz8G+Ev0T2+1cnl5P0r/7bYezxxt2fdHCkFMNhDkN1i6VXvDs2o5E/3nyyH300PnEbUHdUexokza+C0tdbGXgtb54nf22zASgHa2sKWb9gIuAptmEm62NJqEClOWn6wCbCen9+IcNKb75K1kKkHQGkKZgkCGvaLSLzqUwZlDMqrypr3qeImsmuUiv1uwlbh5WALoLGp/gaxecsUJ2StXPDWBD/3mSpW4KlYZLQ7NsNzb31RJAAzXIp9qx6u9GN53fp/AJmmQoLDBljitOAtMpCLGqVnj0f9tZNrjSRgZosRQwUNHN4IAJCfyt/Gn5HsirLs0ZDbS/0UeYxRoHl8QNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(316002)(186003)(8676002)(6512007)(4326008)(6506007)(8936002)(54906003)(86362001)(66946007)(6486002)(6916009)(66476007)(66556008)(83380400001)(508600001)(6666004)(38100700002)(966005)(2616005)(5660300002)(2906002)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lapkuZb/RBAJjUIudQGFrroe838ULcZgkD2CYkBO77zxyX9h6pK29lKZ777C?=
 =?us-ascii?Q?aUCKk0m6DKYukAL4X/qE4jAUAY7ocX/2LhMIwXX8tzq3wVRWBIYOtuXf5cuF?=
 =?us-ascii?Q?SojJ0e2Vw5KK363qi+4dl8vGwenMRbFPClW4ZtD+YdPqy9PxlZZY0GnEIALo?=
 =?us-ascii?Q?ApTxde76fdNeGokp8V5OLKo2ZQ+R8WQzbeScD4saQOyNGyvCyXQ4GiiwYIIC?=
 =?us-ascii?Q?hjmjiEIrUCFWd68z+8HlUWJuDgImsimEiTZCgbK+BogXQqzhoJckZDX7JSoT?=
 =?us-ascii?Q?39VK7fS2J93410WBOaNOwAVdFeE/P5nxTUvjd4lOYLjFBu+rwyTecfptODY6?=
 =?us-ascii?Q?s8hh2DVRFDsnWgn9BIawDBtjsTANSh9S5JuZ9/vz3Ige0v498V84qxUFnAou?=
 =?us-ascii?Q?o2oTr/kkrdg5Z9yVtOwTL4Ao+lPckmyMbvyU9vCmEPitEFItWq9BkrP1XPbS?=
 =?us-ascii?Q?/+P6uiI/5UOoHyjRzcKyNibSRJN+nrmVJtR1YUP7fMoJeohycQV+jMyoSRS0?=
 =?us-ascii?Q?wFLqw6Qoih/6QZogy8/b82S6slOUfzcB61+dmdF6IzUcdg96VsYGABWFO2Vk?=
 =?us-ascii?Q?W1DStkBvEQQX3vSc+x6AfM8kK9tBpgg/2BvDarP7viKnhF9OYA5phef7FJWf?=
 =?us-ascii?Q?+Rad27gmavNC/fNBK+qtode2i4o2Qbr9GWpP+/X3oCMuAVk5rti50qx/pXUr?=
 =?us-ascii?Q?1gRiYkVKUXLCzFCkm3iPyYi7wkR31JePDIJe1svGySlIZZMWDn6WzpQI/y+W?=
 =?us-ascii?Q?Gpl3eFaINqLaVHvXP3InZDyE28u/+1NMkwn6nhe+Hao6K3GdXVVeDKDrbQCq?=
 =?us-ascii?Q?w3MZbb5nq3O1B9F5IQGNMHonQD3XIDPc17HllNt5GF3hXwLsq0n+lTwcEudl?=
 =?us-ascii?Q?EYM7pG9LgYqybghFBaobn9//Ndhxft9q/rvZ0xu203N53wldPQYFmGBaC6VQ?=
 =?us-ascii?Q?iz5vtk/SbTZbe8hwwAeYNdsPBF4/ObK5UcCSlEiliWGScyNzghHcc0YhAGct?=
 =?us-ascii?Q?EgzSXfuJw+4WDIpxjwbPqPtd59DjmbtlmTK3tP+kblntozsH0S4UTdLGN3CW?=
 =?us-ascii?Q?/xD5z7Vux311CmlC0hFCn+udEgcwKlTop6tPAxkIPl5QjAzMvQHteB7cqfvM?=
 =?us-ascii?Q?H8KykCnVuHkS10QmxV21br8l8MjMMpLpSfgu5HEY1ju2jINn4K4eu6JE0Hyt?=
 =?us-ascii?Q?77uzGLEURsrhwXOyD6RBGb7O3Z1G1xBFP7HzRlwM+f7KdJzbyEJc4Jv5BzS+?=
 =?us-ascii?Q?KAAonLo6cBBrbTCAH9w91Jme6fNIjGMNly9pecawWeIRqvH77M8Fs/IZy3LV?=
 =?us-ascii?Q?U6aSfLka3gJaFK6AJalvw8FXzbJ/4lacKh3Ti/IqbZOJlzLFzNbExB2ttllB?=
 =?us-ascii?Q?JarVSJvXYERq5+s9OXczEfEnPnI+TFMBgrxMylC2QaoQ9Gd2I1p2SnRpe2LN?=
 =?us-ascii?Q?Mz8ft9XVBp1GOey15wTyjxmh3eAscQYkvNYO/mcgOkZJbvpypRb96lRZSuk+?=
 =?us-ascii?Q?G1NW+A/05MTpmuT7TRs5rmbHSrOToTMAVYjxMglFMBKM4Rp4THcZKlTdKs4q?=
 =?us-ascii?Q?X+kr913qWFjROdJOtKggFCYCvWSOjkXd5zGvMima2bAXLrqzNusm1jM8SeyQ?=
 =?us-ascii?Q?YZQmSIT2eltHXtw85VeW5uQmNvNUlWdRWARSr3I7w1yIDm+FPVPsUDzr2w4i?=
 =?us-ascii?Q?m5tzBUic49Z0+d9bB6JRWDko25MaC4nxypLjD+BY2LETp5ne9R3p27yvm4gG?=
 =?us-ascii?Q?Gfs7lWJzc8C8ZlzSItnhy2eQSH/26IQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b837a99d-95ea-40b4-e35f-08da49ab2b1f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 00:01:14.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eNDL5hyZbUbeYzN5pvdH+PvdRXeHSEbEtyLbXAop4fQ1/Ffi1nftKTRAyz0+vA6KG+9KiNju0yyI0TZ1kOpNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4263

mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
should be invoked only when MP_FAIL response timeout occurs.

This patch refactors the MP_FAIL response timeout logic. Add fail_tout
in mptcp_sock to record the MP_FAIL timestamp. Check it in mptcp_worker()
before invoking mptcp_mp_fail_no_response(). Drop the code to reuse
sk_timer for MP_FAIL response.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/281
Fixes: d9fb797046c5 ("mptcp: Do not traverse the subflow connection list wi=
thout lock")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       |  5 +----
 net/mptcp/protocol.c |  4 +++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 10 ++--------
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 59a85220edc9..45a9e02abf24 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -299,7 +299,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fai=
l_seq)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	struct sock *s =3D (struct sock *)msk;
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
@@ -312,10 +311,8 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
 		subflow->send_mp_fail =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map =3D 1;
-	} else if (!sock_flag(sk, SOCK_DEAD)) {
+	} else {
 		pr_debug("MP_FAIL response received");
-
-		sk_stop_timer(s, &s->sk_timer);
 	}
 }
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..917df5fb9708 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2562,7 +2562,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
=20
-	mptcp_mp_fail_no_response(msk);
+	if (time_after(jiffies, msk->fail_tout))
+		mptcp_mp_fail_no_response(msk);
=20
 unlock:
 	release_sock(sk);
@@ -2589,6 +2590,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery =3D false;
+	msk->fail_tout =3D 0;
=20
 	mptcp_pm_data_init(msk);
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d406b5afbee4..f7b01275af94 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -306,6 +306,7 @@ struct mptcp_sock {
=20
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+	unsigned long	fail_tout;
 };
=20
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..866d54a0e83c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -974,7 +974,6 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	bool csum_reqd =3D READ_ONCE(msk->csum_enabled);
-	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_ext *mpext;
 	struct sk_buff *skb;
 	u16 data_len;
@@ -1016,9 +1015,6 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
 		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
-		if (!sock_flag(ssk, SOCK_DEAD))
-			sk_stop_timer(sk, &sk->sk_timer);
-
 		return MAPPING_INVALID;
 	}
=20
@@ -1238,11 +1234,9 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
-			} else if (!sock_flag(ssk, SOCK_DEAD)) {
+			} else {
 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
-				sk_reset_timer((struct sock *)msk,
-					       &((struct sock *)msk)->sk_timer,
-					       jiffies + TCP_RTO_MAX);
+				msk->fail_tout =3D jiffies + TCP_RTO_MAX;
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.35.3

