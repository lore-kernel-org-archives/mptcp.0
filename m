Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FB210F9
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 10:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikx1XJaQx7/2+GdddLBx3xupqoZ69sVna8ZYCbbwv/rfbqbVII3v/9nT7EC6w/qJzjm/kuapVe0ThR/uAE/kBPrakB3gea44V7EIEWln/PGuUBrRlDp9v4SIAoeFGTwWhuBrtUniPJL9TWY0d5Nj+v/7l/WYf4+mb5YQ8MHVCbD0OxZq6yWhAk9S+ZeEVM9Dy3IEGDmWnNPgwDKGuNOOenu3sgmhERWvBOZ7hiRNNm7YUCN0WkMIE4G+/6prRndz/DIhizs7LAa4lgCim36XcW/QmetPahTpRtWbepohgD9nvO64vhfw/53hXVSaPuO+WVMJ9fBicRGL1hwXQhIwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEyCVgmAvRfPCx3WcOhOtpO+gWkvym2t5RT8N5035Sw=;
 b=iwzrOMWrm4frRyMNXJRDKcNCrB8T6xYHlDG/Dx/HOzjxihoYY2PT3vRyyFUeeS9duPcN5A3XB5Hf57h68dDlwcffyuuFgKF7KMhRYPFh7yalwLo7HD4UTYUVe+SRqeIRUJWqyOQZv5P1VqhO8xJdshD4wRkvxHxOiOZNe0MSoKJXDJH9WBmS7TiojQPHRXb5Q7/HpPr+goBd+1m1dT5ZMC2+NmX0he3nqqaHI3+bRCxGOgL1iq4wFWxQbYJpMvxUQ9dxQBXHyciszLZxQjTA6K/3bmD65kCuIuV9KFW3iXRFRAjhES02E8JpXbDJM/3oskQg+07JQHEnEesRxjQKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEyCVgmAvRfPCx3WcOhOtpO+gWkvym2t5RT8N5035Sw=;
 b=RIK6/1SvMdcphiBAWDjrOOn/8kWj5VcFpnlL8AWJQrHlTyZBxzIc0kbxZBak4S5i/JlZptjJ/km9/R89mWjK+kSSvzmEqbDJ94n6uYBWCZ9d0RM8td34v+eXYszn8QONL2FW1Nhhc/bpI3KKQPwKIlhu/pGYkK8DRMzicIKGcfexuXvvXjSPlZIFMAOqZbEq0mBImq2+OJjGPAxMCP6gvg6v4Nnj4IHK4ZAMHvWAmgwR/OSocuP580KYBYx7ixlmhnpFuCQDqeG10/NR1r1kGGatIjrjKhXN4K0wH+7gV/wVC7gzzH0CM3mS1PHtYSmaEY4ZjCqd2x+jPfOr0zdZYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 10:45:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 10:45:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/2] mptcp: add pm listener events
Date: Wed, 26 Oct 2022 18:45:04 +0800
Message-Id: <c390b060596c5d0553ad7b388d2dcf76fe034968.1666780919.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666780919.git.geliang.tang@suse.com>
References: <cover.1666780919.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: b1493801-3cd9-4d5d-811c-08dab73f353e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+brFrWIW3P1011Vo3CkvUotZEApa3ibgNN+X/jsLLW6EHGAxYAD99ScIoYc1omv0MpKMg70hM4ZNiNzZfjZuQPqxMF/kP+sdbxYrUFekdp+JpIqT/CrALg3N8ra9Q777liJfm9+jhLyyNXzeTyQizudYMTDcADC/IHhbo1eXHuDdJVFN+3n624r590QlIzavHiWIE8Q3ThTAYOLOXDL2Zu1ohvJs3GYvSRj8hQqErSrU4sqBGzPyYz/WITRlEfks8FMcySxhQlg9B60hko7VMDFBY8Ohp9Kp2zYZwvCFX5HYnf0beZteV1kBvEsmX6plu3dKtheHM5/iLg8vKy2BJbOx9SZ6VEXnxpz4QUq/jFM9EhlNXrZc3/WPr9wOQU0qDORQOHSceNF4Kua0LSuZnb6ZKcBeWIPZnXyG2+Jkl371zoah6G/J7qlvP+iALH6EtHMmJDeV0zehY0ubXTA2dAAVKdIilkcFNYzccZD5eZJ7KbEnrmiWCvv27csWPh6StiTQMlOU/Yhkt/RxL9k96//2vc2osS1m27o96DXRi9pbwQaOWteC9NPwJMl7fzNUhGoYWVvkY8noYQjP6pBddCnLsEvElGu4+eZWZq7J6QagcI6m0vmFcGPI/iyCs1KusqahR57DTCTFzwcy7SjnxO5iSOHVqYIoeUNxe+owRLR4EYGQoIRUWXlkDT3NeXWJngLcFIkjP8rCS84LpHPLrE3DFWRUM6SIlgKs1zbnvNOBidmsWzYIrP/IlZEieGap
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(41300700001)(38100700002)(6512007)(2906002)(186003)(26005)(83380400001)(2616005)(36756003)(8936002)(44832011)(5660300002)(478600001)(6486002)(107886003)(6666004)(86362001)(6506007)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDh/dMFH76zTWB9cxqlmZKwxwtDgge5fZ0TDrMIK3/j+P+kI0HlOh4JXDAjx?=
 =?us-ascii?Q?NT6OQVtImemBf93U2vp6GlzvVxaBXT+xuInnB5BpJ2JHsZb4026c9czkERHY?=
 =?us-ascii?Q?uRnLdIWpONHQkq+og6wv0dT7l7O6Ou1KK6GMEpmsH6q/TjHvKWXE+klQLxi+?=
 =?us-ascii?Q?nxHq8M7i5ti6Qxz5JQ2kbmYgv37WplSrdRHv2i4Hy7N2GDBwqa4CRsJCv+RW?=
 =?us-ascii?Q?Luu2ywBtQoFQzyKXqVelXmRKwqgPFrsYrIidFyq990Z73YdhapDlBjq6rXHl?=
 =?us-ascii?Q?dw1ozrkzQjQe9++9NEE9sG7ljLR3OgcGS4W66NdepxKruahKsuwcskI9PBZ2?=
 =?us-ascii?Q?rxxtD8Dy1v0+F1SavbG+KA+ajEk9hBgGDlY5h5++Xinm4RqOxFWVU8H+wB3u?=
 =?us-ascii?Q?pNFUaO5CZxz1wXlR2zNwrWWhYi+U8AcoZHGNxWjztfI5Xunyswwvn2ahEupS?=
 =?us-ascii?Q?f4dWbfbRjqbaRmCB8boqD2v4lPXFmvUeNE3veYAt3+uenAYab3dSvNbXDRWr?=
 =?us-ascii?Q?9yJ3rO0DCwQ/JSAfc12e6irbH3gSXtd6vgnBQfr12/zV6ohwBkrrWpaPD8Uw?=
 =?us-ascii?Q?FQ+eUQ211MYbMpbRsC2gU9VyJpSnE5GcNDx/pNiLGYLOYlyaebnBDiAByEzn?=
 =?us-ascii?Q?jgFwvqOelySNxQLvfy7PXP1UZNqQv0HyaT9OAQDObvTWwmwzdHBGpo5xJPvj?=
 =?us-ascii?Q?76nysckH6Bs4D+5EJwxuT2nev30A4AGk5yIKYLhCKWI+Y93y+/t+SedGGklT?=
 =?us-ascii?Q?YMjXw2esYF88IbjHh/gspypAgd9TpQ5XeH1DFiQKSFQIKxMGaUZ2FuwYYK6T?=
 =?us-ascii?Q?EHk7v0gvh9mSa63/XOe0eaY0wIHxhH94XQBYNKBRjJAMLVU2ABFEtJJsZwgq?=
 =?us-ascii?Q?oBvv4wLEke22bD1zt5HDv7UGgJeFatshS/ckVZGJ9rM0b6L5c3UU8MmeAnpw?=
 =?us-ascii?Q?z7FYveuMGCMuT++QNbJytSgw3lq4Xm8TvnHxGaNeI61CqPFcy17fUB1MB1kb?=
 =?us-ascii?Q?GHFcGvcq07DwpBpCpl+Y909chae1ydOMmL0oHXISozMKvHXr01eV4FPTRJtL?=
 =?us-ascii?Q?wBair87XcHP6yCy2flHm2gYDJCFi94oSU1JjNpFYvYXiiHHtAOaHy4Dwz22Y?=
 =?us-ascii?Q?kQtSs5HJl26U586osLfvKiUZhuaiCd6VCxQAMZ+IiBrsJhiC/53WqOi1x95a?=
 =?us-ascii?Q?lXNuliXeC1y8uUgh9Nbpf8EebYcoS8lUrpQ8Mns6xMC7kL/KXHlBkqqMSnfo?=
 =?us-ascii?Q?eAEueyxbJPc2Dq/MVdJ4uGlOrPLMfcCJx7NSS3lWNsQf4HyownRRTVl6yOol?=
 =?us-ascii?Q?AAdU0vW799skC/el9RX5Ea7j6cTN2znM3kUj0o0+XTiHFcD80jI3JvmGB8Xw?=
 =?us-ascii?Q?yNsmu+SbpNSq1NEQCnC63EPFKco6lfcbXiTRy7fDHyLQhLGjSpEQLCv7b7Le?=
 =?us-ascii?Q?IAU31NaT1XABedjtWl80H9YzgXLaJ5brePY/mGnago0ldbkuxN3GtkMNQZ3M?=
 =?us-ascii?Q?c3NONqMoJRD62pfZ5u4UlWo3JKoZi3Jd3M+e5nQ+e6TfakeC2Z6AwyX9aOf3?=
 =?us-ascii?Q?fEQdLkjWgq7WQ/ECPsj63HnUDzQREiPD6v5aJB6RtMJv6/RdnajWyFpf11KM?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1493801-3cd9-4d5d-811c-08dab73f353e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:45:33.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BA2cL8tojmjeYqMdXyX1BRImMG5p3CKjq3pyiaOpEUpcbrvRfmcYY4uzUxGFDGUN7m8Rvfatl4jn8yGM0Qqaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338

This patch adds MPTCP netlink events for PM listening socket create and
close.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  9 +++++++
 net/mptcp/pm_netlink.c     | 55 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c       |  3 +++
 net/mptcp/protocol.h       |  2 ++
 4 files changed, 69 insertions(+)

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
index 52a5847b9d74..02469d603261 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2145,6 +2145,58 @@ void mptcp_event_addr_announced(const struct sock *ssk,
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
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
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
+	mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);
+	return;
+
+nla_put_failure:
+	kfree_skb(skb);
+}
+
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp)
 {
@@ -2190,6 +2242,9 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
 			goto nla_put_failure;
 		break;
+	case MPTCP_EVENT_LISTENER_CREATED:
+	case MPTCP_EVENT_LISTENER_CLOSED:
+		break;
 	}
 
 	genlmsg_end(skb, nlh);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dceeaaf3bab4..a1f9dddbdf2c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2358,6 +2358,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			tcp_set_state(ssk, TCP_CLOSE);
 			mptcp_subflow_queue_clean(ssk);
 			inet_csk_listen_stop(ssk);
+			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
 		}
 		__tcp_close(ssk, 0);
 
@@ -3674,6 +3675,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (!err)
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 
+	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+
 unlock:
 	release_sock(sock->sk);
 	return err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f48f881adf8..d2c34360a3e3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -839,6 +839,8 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+void mptcp_event_pm_listener(const struct sock *ssk,
+			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
-- 
2.35.3

