Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20048.outbound.protection.outlook.com [40.107.2.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584FF17E0
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 05:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia49YEQOSqMcwhCvXkqbYv4HBkSq3fj9RR+cxMy22gcxmJkETpZ7zwIgNa2zvFxPhgmxGANlLOYhJo7CJVcEYznm+pNzxhTp/tR12xCYunwCTpekjRm1P2I2Q9jXcjsnF50B9DDmCjpkvQP9+NdJuFoJ64BgdIjZecwHC+TAJJbvyzeMfWZrRQXGXNnWbSjigBzSPntLQ7NjaENN33mMb6YmNFTPA8j1hpm5sblK/nVkBEe2g+z9oiB69GNJTJCLvjpnrhRW3cL1hHNyIxfVdrvW5jNop+GdYRl6Wk8eJP7X+ksMWN0QdLXXFsQMlLoMQiaUOalPk+m+VBAcFhdh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGv91Kg87yXgq1t+ZiTpPAWomuvviN/narB1+3l0sJU=;
 b=WdlXb+M30GFlrVRELrlSw/rK6WGlQaQNNWMrZGK/77Ub7bxkLQ6Q41RK2y3pwccbKn68TTE1NIUe4ph31G2qjIjPHvvMucpioSyu7SMcSaXZ5JwWeyh7/PlpWQs3+HB5Uo8/7eapb18jnK2oLd+JGYgKZlG9zUL9jV5HZ+udcW7QzbB3uIKO8/pkKNOph58QyuRPdoUtHqIIKrecL3thruBhL4e1trvHRU8DQofzh8XKDl4gWczo/knFaLKmfW/7mkMJHbWDlGiO1q3J281rF7GT6ljbSrqXQw+aVD9BUKsZv9HvlSsfaZC3BGTrz/vybj+645iNRPEG/5ZCUkcOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGv91Kg87yXgq1t+ZiTpPAWomuvviN/narB1+3l0sJU=;
 b=Icw7wcMCCFhWS0J7MEiQXnp/NSZL2Gu/xWlNL1kJOiF6en+l5qejqJIrZXdWeUkDn89x4uYL7M0N8SJhYrJOSI6+YuBOgfg+vv2kM+lTbQcLcsUMqUR/BWlp6wwgB0CiX38RSycEUUaTslHa6k0iFPFTW28txqgKyVlLlBYiCy32kqG7qTekQ3GT5gSPPa06Dsd0R6FnqgAVrEh/OSZ1c8/7RNmFaCJ6dyl19CZoeDNFgJ5xHzOTWkqOGB3ZYNGrLqM7liOXIww0mc2txPtKUMyJf/QNr3stkASj1cI/XBgvinbpyLw1yIPRayBB1aw21oN8r7nM7akDVCiOI8DtDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 05:31:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 05:31:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/4] mptcp: add pm listener events
Date: Thu, 17 Nov 2022 13:31:31 +0800
Message-Id: <f61d142c6344524d0e16689ad36ba7bfba0aef47.1668662624.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668662624.git.geliang.tang@suse.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b77c1bd-6223-4630-eaba-08dac85cf231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cKUCGEcBEuHCWmeavduEGFZ5dXH70gOcMhSnGcQLk2bbc5GtWBa+8lRehbGC1pkAZRL2+43chXKblloLoBjCg7QmiC+3sxBcPYiUQAHk3nrVzCl8KCwCSf61QeikWZNvkzZG3E9ydxBsx9iW85j/F4x17CaHA5Nf9pWkvHhKk6HKcL/L3P3slYyHlu0pbfIU5iN5m89VBjZiazNE+jMFofvLulEKW9Gx6IR8sGH1otzQ+EfEwdFVOpdS4xpmT2qqoQ4BFGzXwhSG9ZTzsL7gdwTKY/fY0lX55vVtvE0CikviyHM6oGC9l23MKDm3YpJy649EjYTTx67jROhAhfuzvuck43h2rifg0k0Zy18UnGK8YDVNJVDnI/yvaxX4ErZElhEsmJtNklw0Lu0BeViIUEOssY1HCZFdevuKrwZN3uLI5SZ3yD/LOr2n+jWERL6jCsxv/SxD7nRADhObYbVupvD0JgHOJpePD2AvDwGZ3hK8XuCYOBur0bQZv7yNxoj+VvoJy8Dtj6kMPV2ZvSskOBTHylI8jC3xZ6nXul/RzBG7wY6uJ7/KGX09PPFzlpBVZqtnJzXpXSHY/SN/IHpqqoutx1jCACJ6sMhWLUs4/MRACfNRXvIj+GeFEr3iKusmS1TKjZAOXT5KYV95arMdvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(6486002)(478600001)(6666004)(107886003)(6916009)(6506007)(316002)(86362001)(6512007)(26005)(38100700002)(66476007)(66556008)(8936002)(4326008)(8676002)(5660300002)(66946007)(36756003)(2616005)(186003)(83380400001)(44832011)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B4hP8wgc5hO2SGcD5nfO5FXjmZNtlzxb/Ln3yIRthCNXUVXxefuwbmmDpoH+?=
 =?us-ascii?Q?tsezaZUaduiwoVhX6+n/fp2PIdM5VzsVVN+Jo3ur4QiXfc6ncsdhtvSawhXo?=
 =?us-ascii?Q?fZOQYcx5UOCruhDd23FPlDpqHxPSCYBYp0v8UZhT8LLV1XiVqIAC40D32jvG?=
 =?us-ascii?Q?ohrGYEFwXPlUgEYjVO4VbY9672A3I1LgWbicFxIRGVInkFp0EzHQJ4cvlUWk?=
 =?us-ascii?Q?Ky+ujnQLLoz6xIMJiKLzwzw1iJbS9aGYqVKu2271dcwLkEuk6qriiQ4Ilphs?=
 =?us-ascii?Q?TNsqvDddU1iahlrnMPIDxVo35tVnAV/oQjzvArraHYRCqh4e3zCSphw8JH4H?=
 =?us-ascii?Q?G/zl2bPdx3UcejRfxdZ9oR3ca1rx/W4qg96OeDjPP1R3C1Jo06KKXRH4QoJ1?=
 =?us-ascii?Q?AtwKuyv651oK2hbPgxM1rf1rcpNqDc3vts6aVj5eoD0+6Sasm9aMZypGomg6?=
 =?us-ascii?Q?SuPcYTbIbo7EtpTYd6m95BzUzaIJ9M157H05BQwgb8bi7cBeeqqtIVfNckzd?=
 =?us-ascii?Q?h19P+qoIjiL39MzwlOP+dtuCz8nOYfwo/uIxJauLnI3/YiYn0YhS/Ziz0hot?=
 =?us-ascii?Q?njHttLFxJ+hpR4mEkx33D7iOd3FoQUssZnDGxGJbeR6j9UVAkBMwnNuictSD?=
 =?us-ascii?Q?XfnNkdE+fgsopJYVgTH7Od437xhOIvJpUyRW75dB2V41yXT5MJyJkF92mHbr?=
 =?us-ascii?Q?ScxaYmYCEag7Ad0v4AhWtAGvHRYVex+oS5BtarYkFDBUxLBRziG8j5z2wc5b?=
 =?us-ascii?Q?pkK//ffmqg7bHXSyrnXvD9ADy3ERn8vqxz5GuzT1gQVa8DzShVgfP/Lpmob4?=
 =?us-ascii?Q?M3K7mroWu4BnMkPEhp4CAEMfO3EsXaFZlsRTpautA/GiytoEYYDCtD5SIbIy?=
 =?us-ascii?Q?HTeVHIep8BkwTL9N8pkmBvXsAp/kV3DfMIgehgiDxs8ah2X74MzvkGKlUjjA?=
 =?us-ascii?Q?2Qp0fdQ47sAykfn9K8VKVEp0/jsk1R8p0NurEnqDtXzVs+KvQ/3qbrWKSlPP?=
 =?us-ascii?Q?nYoc0lI1OL/v0+EHILxKK4CmRgOf6YNzDScRcwugwfFxHFXANzdWcvjaPywK?=
 =?us-ascii?Q?Mw7bcwS3GaBDIcs7bCqT4RV90GPuYSiwvysDM3eOXFBGuDZMOkh0vJTo9BKr?=
 =?us-ascii?Q?vs4O0TL7WMAlMSQD71eR84TxOR0+oUXiVTHY0UMxtQy+52pfxX/qbRKQACXW?=
 =?us-ascii?Q?j8iCJ/9uFVWvonVLgTie4aG+g/TjiSs9W1sK0EQmhqt/x92vyqd+DuA88PeX?=
 =?us-ascii?Q?vW0R87yKvBi6h1FSu5Y/diPakiZaMSPZ7T5374nB1E+OeLkA5+XpsXaDBUF7?=
 =?us-ascii?Q?/epSAjHiET7AS1DQoVjEiSIYKlJwTZR8w4BWCDKfMFStVD1TO6nlKXDI2Xpg?=
 =?us-ascii?Q?2KeYs/YjjFpyyipk3+GttQ3bFl286tb78XjJ0+JORyziYIG5XaV23q3lDFP8?=
 =?us-ascii?Q?/b5Nk3tDY1BeAI5+RSMai7HpImcGZ1jx4B+PZIjM/HDCsRRZdF4WfG0e8Oy1?=
 =?us-ascii?Q?dPLa4zBz2KFscorVzv/huLNXQ+phYs3wD0cVSTK7eEP03Prhqe9FewaUCShq?=
 =?us-ascii?Q?o39h/LN7Xb/cEVao4wj1j1ZOifS2d+Uej11ib+BC+Gz+LosrzDTfhDww12L+?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77c1bd-6223-4630-eaba-08dac85cf231
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:31:15.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QG3j6gO7OIBwqKt3ZiCfDpP7e0XRBzixr2lYuvD64Fu07kkihCYT6u9T4ABN3XEeU5cKIOGTdLMqa8hCjaR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

This patch adds two new MPTCP netlink event types for PM listening
socket create and close, named MPTCP_EVENT_LISTENER_CREATED and
MPTCP_EVENT_LISTENER_CLOSED.

Add a new function mptcp_event_pm_listener() to push the new events
with family, port and addr to userspace.

Invoke mptcp_event_pm_listener() with MPTCP_EVENT_LISTENER_CREATED in
mptcp_listen() and mptcp_pm_nl_create_listen_socket(), invoke it with
MPTCP_EVENT_LISTENER_CLOSED in __mptcp_close_ssk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  9 ++++++
 net/mptcp/pm_netlink.c     | 57 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c       |  3 ++
 net/mptcp/protocol.h       |  2 ++
 4 files changed, 71 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index dfe19bf13f4c..32af2d278cb4 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -160,6 +160,12 @@ struct mptcp_info {
  *                           daddr4 | daddr6, sport, dport, backup, if_idx
  *                           [, error]
  * The priority of a subflow has changed. 'error' should not be set.
+ *
+ * MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6
+ * A new PM listener is created.
+ *
+ * MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6
+ * A PM listener is closed.
  */
 enum mptcp_event_type {
 	MPTCP_EVENT_UNSPEC = 0,
@@ -174,6 +180,9 @@ enum mptcp_event_type {
 	MPTCP_EVENT_SUB_CLOSED = 11,
 
 	MPTCP_EVENT_SUB_PRIORITY = 13,
+
+	MPTCP_EVENT_LISTENER_CREATED = 15,
+	MPTCP_EVENT_LISTENER_CLOSED = 16,
 };
 
 enum mptcp_event_attr {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 08806f97c8fb..93ae0fc892df 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1026,6 +1026,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+
 	return 0;
 }
 
@@ -2149,6 +2151,58 @@ void mptcp_event_addr_announced(const struct sock *ssk,
 	kfree_skb(skb);
 }
 
+void mptcp_event_pm_listener(const struct sock *ssk,
+			     enum mptcp_event_type event)
+{
+	const struct inet_sock *issk = inet_sk(ssk);
+	struct net *net = sock_net(ssk);
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET))
+		return;
+
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	nlh = genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, event);
+	if (!nlh)
+		goto nla_put_failure;
+
+	if (nla_put_u16(skb, MPTCP_ATTR_FAMILY, ssk->sk_family))
+		goto nla_put_failure;
+
+	if (nla_put_be16(skb, MPTCP_ATTR_SPORT, issk->inet_sport))
+		goto nla_put_failure;
+
+	switch (ssk->sk_family) {
+	case AF_INET:
+		if (nla_put_in_addr(skb, MPTCP_ATTR_SADDR4, issk->inet_saddr))
+			goto nla_put_failure;
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6: {
+		const struct ipv6_pinfo *np = inet6_sk(ssk);
+
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
+			goto nla_put_failure;
+		break;
+	}
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		goto nla_put_failure;
+	}
+
+	genlmsg_end(skb, nlh);
+	mptcp_nl_mcast_send(net, skb, GFP_KERNEL);
+	return;
+
+nla_put_failure:
+	kfree_skb(skb);
+}
+
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp)
 {
@@ -2194,6 +2248,9 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
 			goto nla_put_failure;
 		break;
+	case MPTCP_EVENT_LISTENER_CREATED:
+	case MPTCP_EVENT_LISTENER_CLOSED:
+		break;
 	}
 
 	genlmsg_end(skb, nlh);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f9b72b62998..c2bb4255969e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2366,6 +2366,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			tcp_set_state(ssk, TCP_CLOSE);
 			mptcp_subflow_queue_clean(ssk);
 			inet_csk_listen_stop(ssk);
+			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
 		}
 		__tcp_close(ssk, 0);
 
@@ -3682,6 +3683,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (!err)
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 
+	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+
 unlock:
 	release_sock(sock->sk);
 	return err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ffecd103cc50..bae216bff6e4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -846,6 +846,8 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+void mptcp_event_pm_listener(const struct sock *ssk,
+			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-- 
2.35.3

