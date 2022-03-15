Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01EF1B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 06:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647327525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrMGp2MJPMAwyUwQeHigliZRsSWJrcDrR+i3zqyAV4E=;
	b=QsoKUMQs0ZnM4LLDiUW+w41OkFrbTRzhPjSktQRIZNWJDdx4PO6mMG4+xhhR/HHP4P/K0T
	Fbbm/Yp4fe5r4VB+jnLAbgGNcOWykf+iPNgmr9HJ57EJYltP9ls6sP2qEKRJ5SPdBN6Xpc
	FPbfLiBcR7A+FoW0AoNK3xE5bAR2ET0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-Gqo-jntlPNW8ebwt-41D4Q-1; Tue, 15 Mar 2022 07:58:45 +0100
X-MC-Unique: Gqo-jntlPNW8ebwt-41D4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny8tXmXmyghgfKsz3bqB9qJuv/w7q8qFzqXZbkbl473celmjzA8X98zTk4gXJiaJiglqnmOjwimDf4+RPyFBxKhIA+ctYcS7PuAgRBZdUFIvnEFBCgXKHHu2dZrtlQUWdl6PrOINDnSmePS5Cx99p09Gff19adtcGzfM42KEi4PFS/OPKgxa8c+14IEyIptVLD+CbxM342jj/gfBYMR2/uzESWE+85ca6RLzIVG1yBct1mbKKB8Yx+d3A3sFINLl5IR1lN6i44D6sWMnr/wWvUmeLBYD9INL0szSypuQ9Fv8Q/wsN36ky/hu0VDmjNYu8W0tC7KYS6SFWd7G+xcmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pUrkahfiqiNJHYTQPPktlfv2h/p8AJ0jgPh7most2A=;
 b=juvkrTfkfVUd64nnkGbUAro5HLLzZ13I6r09JsRk8GzE3B1YeGzuyYlbIiMslVnv6cB56f5AFOhMajyd4YPTpYoMKqRA2+/vlcTTSobX6B9Be10m7zYdzyMkTWgKrEszRTP/l4RmXiq5VnoVzLGe378P4S40Tk3EcE220mvrdD54KgtXoYFfJa2O1SUI3S6B8zeoZRt+sewOt5QXA5njxRB4mhOgrbgahjqUbM0U7f4eBkyzLJUvlbO9oZ/YGYOYoKc9xvW/NsdST6I+f4bkFv9AGzhXoLa1N3FW6gU7oBRPpps/HD2oaOUZIU6DI9aY3/tSz+WGptYqA5d1wkDJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3138.eurprd04.prod.outlook.com (2603:10a6:206:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 06:58:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:58:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/6] mptcp: add data lock for sk timers
Date: Tue, 15 Mar 2022 14:58:22 +0800
Message-ID: <78821d7062ea739af85dd920b5d47342775e796a.1647327162.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647327162.git.geliang.tang@suse.com>
References: <cover.1647327162.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab482013-a535-4ffd-525c-08da06513e93
X-MS-TrafficTypeDiagnostic: AM5PR04MB3138:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB313888EB3BFBA3C3A3EA710EF8109@AM5PR04MB3138.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rx0ucFUbmJm30YIpPkwCY4JLfQjoO0BnCHaOfGKuegWs58lT0dwSUSaIcRN3Sx2kY9BZTf25JitG+fPhYinh0uu+/Nsgiqzwf+fsjUe3QtaIjknN3FZAv2T15ipvKFhfusJPc1/wSDOdE8nvxNcO0j/zzjoifGyI00rv1SGMNhqrU5Y4YMVcM7bxWlJKLgFzWv5H9Gb3f0ic7jafDrw6L2UnNNTU0tiUQ4aNZVFwWr5JFfr8ZIzqJ9A4V2y20pm05SBfsW+1oSbr/ScbE9dDJlElqHra4X2RxqcuJwRE8Wo68Zv577oJPssEiY9KRcI6W8mjilLtX2PVSURym6DcZ8wm6UvaT9j+UEkN1Fmy/UrE9KBJZyD8CIqtXxa52wPWNAwD+fy+XndxXXrciGNCf2vnvHcNjLqlZ8mZttHoFX7PkvP1+K5LsK4CTQRYwaKRBssDlOsSBXncd4GrPpC6MXK0JQr+vW0CZAxm2LKknIUEeTjXXoZuBai2fdRuPFyKQ/ZNwp4F/oEDieLPW3bJZSBf9gHAsb5ndnT9Ys5102etLX083GBvBojFPzzH1CAwjOirRQKsVr9IYv9ME1MOPEYmGW7DSY2aR54i2qExB/atbUj9ktfuyjOK/ZKTmu7Jsfg5cuorlPfWSaj8ayBAMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(6666004)(38100700002)(36756003)(6486002)(5660300002)(508600001)(66476007)(107886003)(83380400001)(6916009)(8936002)(2906002)(86362001)(44832011)(2616005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZ8klZMNlZ/o6ah4FDtgCzExN2ug29WaK3vrqhc0vgnPzCcNagZR7xBDrkxH?=
 =?us-ascii?Q?U5D6G0zp5DwASGW8MfHiCVOLtJhaB4qICkr5xOqwvSk8WVbqXOGOEpyXoQGS?=
 =?us-ascii?Q?dAk3J3okTFxOK4N7m8bx+bUeua7gpSXkVFm34P1xOTx07O5AXWrBwXaZgN8/?=
 =?us-ascii?Q?B6Hz+VZ6M1v2TFIEWqbgsHyZGszoHAXRdb0IEiAel8G4CMlSqsL5ZVzUnMyE?=
 =?us-ascii?Q?jOkTIyKH5eh2p3WzS899w4yk38KM7j/t/93JNKDS3saZgmN0pFIe4qMyVjGQ?=
 =?us-ascii?Q?61i97BfhfFMDWn89VoQLO0p21mHdjGwJFf1VwbMegud7fytiTwboEEx5q69v?=
 =?us-ascii?Q?PGksZyhliCBqHq0uId/eENGZ/MaVfYYeuWDqxj2O5nNgLvkwzNUh4crhDdrd?=
 =?us-ascii?Q?b1/LfKzwdEQ+kX2CCiNptJ4e8J1ijxJPPTCxI/tqzToWrErjvN8hWFp+if6A?=
 =?us-ascii?Q?i/lNfQUAfvF/esLjv56F6vmUC6cy6V0PoGVcoRCj8W00Xrv5bQwWCPQC1Ovi?=
 =?us-ascii?Q?q+Tm19mz6ub7KQYvclRPEN0lwqLRLrbgFp64k8yj5hsTorZJNwXGexdBwmJE?=
 =?us-ascii?Q?z4G+mlZHKN/bpV71NUfBmtvx0UNP/LmPPw3SKbkaAVkVyrM9cFEJywMnRVv7?=
 =?us-ascii?Q?uL+UAi7aFPoImVxdob6+aLOjqp5u8mc+zLXgKMq6SDTyf7G/J+69ETnFjRgN?=
 =?us-ascii?Q?SAds/yhhmwrsGYOPThTY7MnqiNqczc2hvxjoXEUqPRQt//1lvu4PJryXJfGk?=
 =?us-ascii?Q?SQqzLvZJZ4oWePqrW6HKxQy62g2/exLbX2KfB2OKVhjIV9oFt2wj2Wd/brjF?=
 =?us-ascii?Q?RL0pjL682J82t62yAYivNmt/UnpJrbx8xM7nh0EX8hvmjgnL/TLWUy8mC9Wl?=
 =?us-ascii?Q?U1dQo6C5RaIZoHica48A6RnrgyGhXYfzCcVOBxg4e9DpJ5IzMASVxyTcfYui?=
 =?us-ascii?Q?Zva077/3ZFHMufqJz53z9aYR5h1nvdT+5tvZeDWgrXGV3JNmHjpSgepuFt5S?=
 =?us-ascii?Q?W1CPmvhHyBeuvopdQn1yiW6ebGmnADXv5AxtlFxYxZQry8sYYwP9X2abDJdg?=
 =?us-ascii?Q?8+11WgZDujxTnY38T1kV5PJpfaID0aoC32L7EF1VygqB/mr6DEXp8wioYpI1?=
 =?us-ascii?Q?uUKjf/Dp7TFiORRYXX5VEBJt1ZfSfpw63duPlDbMsRf8uhNYMjOKHEAOg07L?=
 =?us-ascii?Q?54TwUHxZJHSi9pb20OyRw/6rrQvHoU6njtEL9roc3aijJ+EEEI0gSdAucXg1?=
 =?us-ascii?Q?D9D3Sr6bLZNOySDY6/L06r4LwVvk4K/S43cYLwLac3r/IQIfmBus9gdYFzL+?=
 =?us-ascii?Q?ALYyiZ5zKPAIq1ss5LYTeXh1b88X3ZbqygPJaNCD8exyGUMauPkCfQqGqs+Z?=
 =?us-ascii?Q?eR1V+WhBaOuciT6mRO2kRpESpzDtkt5CSvKd8QQmprdGCtEvHgCJ9HCwrZMG?=
 =?us-ascii?Q?sND3vxcg24/3ZH9JtAPa2dTJRFGO085bG+H3XbztlvmycgEH3u9XmOHBDY6i?=
 =?us-ascii?Q?AV072HSAkBYepEcSDijxdIZ6zsZuRWMEYI9oN+G6Tb682+IgROFpGjAVnQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab482013-a535-4ffd-525c-08da06513e93
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:58:44.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xnMEpUzlhwv54EprBdr9NEwhfNE/Whm41JBTdVAOdK5z6gV6kVQWmcQyPzrzZOgR/XDLFGkeNHOLfPK/ov13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138

mptcp_data_lock() needs to be held when manipulating the msk
retransmit_timer or the sk sk_timer. This patch adds the data
lock for the both timers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 90c2febe72cb..483f4d4e8e87 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1604,8 +1604,10 @@ void __mptcp_push_pending(struct sock *sk, unsigned =
int flags)
=20
 out:
 	/* ensure the rtx timer is running */
+	mptcp_data_lock(sk);
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
+	mptcp_data_unlock(sk);
 	if (copied)
 		__mptcp_check_send_data_fin(sk);
 }
@@ -2490,8 +2492,10 @@ static void __mptcp_retrans(struct sock *sk)
 reset_timer:
 	mptcp_check_and_set_pending(sk);
=20
+	mptcp_data_lock(sk);
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
+	mptcp_data_unlock(sk);
 }
=20
 static void mptcp_worker(struct work_struct *work)
@@ -2654,8 +2658,10 @@ void mptcp_subflow_shutdown(struct sock *sk, struct =
sock *ssk, int how)
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
+			mptcp_data_lock(sk);
 			if (!mptcp_timer_pending(sk))
 				mptcp_reset_timer(sk);
+			mptcp_data_unlock(sk);
 		}
 		break;
 	}
@@ -2756,8 +2762,10 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	/* join list will be eventually flushed (with rst) at sock lock release t=
ime*/
 	list_splice_init(&msk->conn_list, &conn_list);
=20
+	mptcp_data_lock(sk);
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
=20
 	/* clears msk->subflow, allowing the following loop to close
@@ -2819,7 +2827,9 @@ static void mptcp_close(struct sock *sk, long timeout=
)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work =3D true;
 	} else {
+		mptcp_data_lock(sk);
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
+		mptcp_data_unlock(sk);
 	}
 	release_sock(sk);
 	if (do_cancel_work)
@@ -2864,8 +2874,10 @@ static int mptcp_disconnect(struct sock *sk, int fla=
gs)
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
 	}
=20
+	mptcp_data_lock(sk);
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_data_unlock(sk);
=20
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
--=20
2.34.1

