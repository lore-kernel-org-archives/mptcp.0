Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9028E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAS/nxTFHmcQQYO6aqQXh2hejItJPR3JTvQUD96qles=;
	b=hA5/f4Vp3zpoL4+fmjRc1BGtlNfIAp2sfHvUU6CaUbakepVLhV5FP42QbV41+5q2XpwzQ4
	9hrlYnhhzugPCGAVZVJ/dgw5I5+uo0xfz7JFsMpWPT2tzJK4P/GM4OUo9UcdCZ4SqMzGvE
	ZZk7Bk1C8oltrclwBPHgKzsLkEQJXtU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-30_tSvwTMI6Jqp9OzC1xUw-1; Mon, 06 Jun 2022 16:41:51 +0200
X-MC-Unique: 30_tSvwTMI6Jqp9OzC1xUw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4gKEylBCptu0sbAMa52Qv4Mmf8cfV1pSICz79AK9ySK68KYgsAbjvMyzRo9psXcFEEY+rcYHjKcs3xHFq3NhW8BB+s6ykGTOTld+PPz7B3Euq3wqtyUARmP81+b//Q8p4pQmuNczxoM6ejojsRPSLh48inlUKi0s7kDMHb0diAKK+zndMnaYX8LUI9pHuG1CaqhX1lAhN5NQaQalzWnq8QRCKVMjCoLn8uMTQU4WEUXIWcW+4UCNVTwpvsJh+RDCDLhvIP2ImT9PF1XaAY7UsPn+Lw8zsFGZ/vvgWEthsQ0amBLRHQtA9gqW2Q968uhRjx8rl9y3Z0KD9wxbmEpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4IjezjvT81PTWumNUj6jkR/8XNh6dzZCSnosWWuLMU=;
 b=nlTvk99iEZ8ePe3utcu9rISo9fblXAKbnjjNGo1QmJP6snXQhcqNDOUrWEqhpyejSVRZg4Qx1g5KoeBgiOlltvA6r8wCknUlhEfrb30/yq07DQ0SG3r0GkzWMZ1B6Gi+aCccricN/7VVla9gi4SZ0zKnlyH9E5ukQF25a73+JFTuV80SFxbYeKpeKZ5Vt63KRiEJGhQnb16FBaQ0NJ4uJ1owu1gy7zdfHBPAEoTGG9cCE0eYeYOzD7iIXs4K0eMHZ1sQWkYNPG20kC2dsyS4MawolvbVL/KMBcdxkFUGXoa9ZWbwXKPp06nyp5YPRy9WuuOZPuZODlwzP4SZUDOwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3536.eurprd04.prod.outlook.com (2603:10a6:803:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:41:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:41:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/7] mptcp: redundant subflows push pending
Date: Mon,  6 Jun 2022 22:41:17 +0800
Message-ID: <c456d88a1c0e71ecf5849f1dbd93524422c818a0.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654526068.git.geliang.tang@suse.com>
References: <cover.1654526068.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9c2144-3cb8-4824-8212-08da47cab11e
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3536:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB353666FC01FE5EB2F5D5E9BAF8A29@VI1PR0402MB3536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2RboeZN1O3VyaisppjgYLcJttlOYVWjN5E+SieIeuag9Hnc8mOZQ51q4BfigaGrH32glWQZjTILyTOdFdNRJp0VR0tF9/Vpui5XKmPra+cVMt50gFsnA++DSGM7gQOLtVAI5qo5arcT9MKkH/1VDGg6Vk8gu/bXflbo50XJXM7DLSDJ/eFMrw/S4wsvYi8xqWlk7XMe0sw0xMELjTowT9RwcKrRIjMx/pB8zoOebyXIPxIp/BlSv5qAWvpKHYKProrD1v1WKJQlwNqGqEMAdlZ0rOkCb5LyZT0/pl6+i1W02um92pAllIEqthR868qqStPzFOo7S8PdpRCjXyK7qrcqQGjm94UZiPJb5Lbz+7GHD6pQPEkT0xXNFZ19j9ECIuZyE6SXJUWROu/YVZy35PJolEZBuyLxZZOuoW2LEXFVhgK6zdQiz3gIdSeV2TniuLxKJyAHB9lItGKR0swzJUqRcEwD84xesLB1weF/dqEEs/0NNjv/+LrOKlM3JZh2g1W7K21FKuwTVWq4C3HFKhN4fLVPjl1WT2CpFHqU+f4azvzZJCRImNSwkB2Gag8QeOIPsFnLO+70hqMrIyvsrDz1mXadgsIoutwrHJNopYWy5fNfZIIrn1zehpQq4pnlb943pNLI8oixE2z8WDWMoRcL+F1FNqbUhFGhReB+71qmPBkQGQ6qU2E0Hv9B17uZvei+ZdRarqUx/AZRn406uRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(36756003)(66946007)(186003)(2616005)(6486002)(6512007)(26005)(6666004)(6506007)(38100700002)(66556008)(66476007)(8936002)(44832011)(316002)(86362001)(4326008)(508600001)(8676002)(5660300002)(6916009)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6m68HdV1lDpA+Z7dpUXjpJtmMJu5/+bh331UKtbbWe38Vo7P5Hl//FBUiQK0?=
 =?us-ascii?Q?DQBzrRWDwR8dV4X+LqXqpUoIhGLXKD/aTHv0HEr5T0CfrMIt5vYWpIZMId+P?=
 =?us-ascii?Q?ELWYlAPijRLH1g2UCqOSAuA6x4GwCinJ3ZbhUwJ89IR2EZ7EAcXNqXy6caJT?=
 =?us-ascii?Q?igtj3TmejIvhcKsFM4gG7ufHYfGyHGu8VlWFN0wxIYnnuPVzLq2KORj2MPl4?=
 =?us-ascii?Q?UGdchRloxqT/0FjgEmOJzTXiyp/YOL2rxM0Tq8DCpsgVjmrcXXUVI5EDp51B?=
 =?us-ascii?Q?SMaI9A65U1lkIMb2v5P8nweRIwXAc1CYKysbOIk9gckpABR1MNZpYSZF563i?=
 =?us-ascii?Q?PUYYomUwxSzkEnn3HpqSjp7SittC5wEEevbIVTTkVovjpAZVMJ8PXKbum7+i?=
 =?us-ascii?Q?KEz+k6FGdWEqXxRfgRBW8NXgQ2zpJhChPC6rrm7Q+hA5346sm0KVNTRaDd7L?=
 =?us-ascii?Q?b4WAOOWSEJpZor6yoEsTJTz5+Sh2+sU3dTo53DI7kz08rJc3nX/EnlRD3P95?=
 =?us-ascii?Q?C3zzWK5UcfOK3MHkGwGokSmrZoK/xA59vgzYBITrlcevHMHTiWaHd3bNfXOg?=
 =?us-ascii?Q?TYZQd3JWATRgbGHhTHb9zf2KbN2nLdgUhY6zEVduFIdTgLd/2k+bwVw3zTmf?=
 =?us-ascii?Q?/G0XEQp5S5m+7S20io0O2dyzh56uI45wxUQH8eVmg8H3c1rOQEKidOUaEk+k?=
 =?us-ascii?Q?AbjBOdxUk0V5l0BnuVI5H2PWqcRR4YVDg07nvj67K+kMCpQb6G2n2JSl7u/l?=
 =?us-ascii?Q?38Dn55Hb4EojRaga3qy/O+D+/w77mWBTTViygsR3lyqt8IpA5T7TAJPf8oZH?=
 =?us-ascii?Q?g5GeuvVHFg1mRNVk5tuNt2xuTdCWnqbzMWjdGRZAPA61jNF7yq4pFA2MPYAi?=
 =?us-ascii?Q?l4Z24GjKftdIysAinm3ts7xIdrj0Remv4DGdqAKimW21U3gT0pQo8jsWUyux?=
 =?us-ascii?Q?lsfV6IWfIlseKbEjCrpuML+mOYqX2eOksu7dyDXwLUXGQkx5wx5PUtEyjjQf?=
 =?us-ascii?Q?Lp6Zsxkf6r5BbH1uTL7knhvz6wE2f06n99hA3mTD1FF6AAt2ez4bbARAfJmw?=
 =?us-ascii?Q?D5OVBrOLFsW64kkeGcQxllqB5d+yEc1XLRjFksmix/bnayULU4WtwypiAPyb?=
 =?us-ascii?Q?Tz7lWAE+l2UtRz3PbEMW1FCzNo+PKaS0/mw2dl5gwcLor4qtZXmGtftRbHwh?=
 =?us-ascii?Q?WRGiQLLgUF5KWtj2J75lgo319C4OR6k7ZB4qi/XZ6zXXNKRd5b1/gTTK9pZV?=
 =?us-ascii?Q?y/0fg+WUoEkm74tT8oB7ule8Gw35cp8fQwNMF7tC5vy1BSW/HOdwKEa1ecw0?=
 =?us-ascii?Q?vak4ckFaLQTR1cggQvQ2n4xeRNLaPiexxXz2mBW5BKbdSOuBv2N1uEZEPH3x?=
 =?us-ascii?Q?qE9QZ9pxgQpcs7V0OWGMdiAJEJNRRp8rmQ4TTbM87YBNBuQ7Ekrqmwla/uZ3?=
 =?us-ascii?Q?iW9TiQxGPoKXKnk/mz2hBT+XD9j3L7/otNmqjlBYLwqFyo3cvvNrnoZCKIUC?=
 =?us-ascii?Q?6pESOna3FHpmJTpXkNm6zploZTXCsVT3kXP+nhqsfuVATS/qU8HXH5cz6TTk?=
 =?us-ascii?Q?BSAdIB9iqMQWudAL4WgDYW+XHK/BZXNcFRVe8fcymG9Fn4SL1w7ghEfxzWoy?=
 =?us-ascii?Q?9P9wPlo8UdrRqzHhcTB6fcbSOMsWZQ3N4anMrabO/hc8o5v1QokF2KnbFETw?=
 =?us-ascii?Q?P4bcml7t70GFJ8+/HRxyxL/mVELGUm5oizUF/ucwzVLgfizRBOGFq8NmMfB3?=
 =?us-ascii?Q?kHxI6fEOt8uPjRgRjoQYyno05SRhA00=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9c2144-3cb8-4824-8212-08da47cab11e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:41:50.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11SC4me9XqUKqpV8Xm1OTDqWc84pd9/AkgBWLpl5NTssjc+vTeM8bykQqXJ/9plifW8dh3UUZN74S6wts1vngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3536

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++----------------------
 net/mptcp/subflow.c  |  1 -
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d93df73a9e3..8bf48387f9d8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1551,58 +1551,59 @@ void mptcp_check_and_set_pending(struct sock *sk)
=20
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk =3D NULL, *ssk =3D NULL;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info =3D {
-				.flags =3D flags,
+		.flags =3D flags,
 	};
 	struct mptcp_data_frag *dfrag;
-	int len, copied =3D 0;
+	int len, copied =3D 0, err =3D 0;
+	struct sock *ssk =3D NULL;
=20
 	while ((dfrag =3D mptcp_send_head(sk))) {
 		info.sent =3D dfrag->already_sent;
 		info.limit =3D dfrag->data_len;
 		len =3D dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
-			int ret =3D 0;
+			int ret =3D 0, max =3D 0;
=20
-			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk !=3D prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
+			mptcp_sched_get_send(msk, &err);
+			if (err)
 				goto out;
=20
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk !=3D prev_ssk)
-				lock_sock(ssk);
+			mptcp_for_each_subflow(msk, subflow) {
+				if (READ_ONCE(subflow->scheduled)) {
+					ssk =3D mptcp_subflow_tcp_sock(subflow);
+					if (!ssk)
+						goto out;
=20
-			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0) {
-				mptcp_push_release(ssk, &info);
-				goto out;
+					lock_sock(ssk);
+
+					ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+					if (ret <=3D 0) {
+						mptcp_push_release(ssk, &info);
+						goto out;
+					}
+
+					if (ret > max)
+						max =3D ret;
+
+					mptcp_push_release(ssk, &info);
+
+					msk->last_snd =3D ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+				}
 			}
=20
-			info.sent +=3D ret;
-			copied +=3D ret;
-			len -=3D ret;
+			info.sent +=3D max;
+			copied +=3D max;
+			len -=3D max;
=20
-			mptcp_update_post_push(msk, dfrag, ret);
+			mptcp_update_post_push(msk, dfrag, max);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
=20
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
-
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..e7864a413192 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -881,7 +881,6 @@ static bool validate_mapping(struct sock *ssk, struct s=
k_buff *skb)
 				  subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
 		dbg_bad_map(subflow, ssn);
-		return false;
 	}
 	return true;
 }
--=20
2.34.1

