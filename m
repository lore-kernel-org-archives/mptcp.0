Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20075.outbound.protection.outlook.com [40.107.2.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5797C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1jhUla0VftVDSnbQSJkWaxEDcsjUNLMk1FFgHwYE0/nu3fHPfQtP+pItc8OUKzhUz3ejIWAUsoEUoWaCxPPPsAliJhP9imQN5zTI5k3nOezDfH3AYWBcll3kFPybZoi6X02UHvyBO338CD80PTJeDAIzd7gnPn6Gldw6heTmlGedWay4upZHdq7bhc0c1fA0XpU3zohqtRlA06PnsjRdmpLlFdZ6S6dhRW2XBKVvXJHMkogz/z8u/iXWt/vKDh79rHjrKm+kw/0/rPkmS1leJQWGQWq1jIrtncIqVqixOe7Zh766Yb4HAYi8GmHOD1soBu+PxDUxgETap9DwgHHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V56A/O+/cDbnvxU9ZLzBJRTYFaYPfUhVHADzxVOXEck=;
 b=Y5KxdrPt1hw6f1kKvVmH3OzdBTFh0uefxE9ioXxf0eIzeqsz5c1GoWvTU+RYQvnx1mYyxf3MXLSb8f5S6+HAJHdTrxXS/dUw4NKeNIguqyVEWUwxoJsvvvC4K2hX+sdwiqPh1i8pwANDQGG318GUgqzq1Vd8/YsIioKLWIkeptn90m+FvIXiCn2eDroqJ+aNi/glU4u4Lhqz789XubjmEaQY78wuAkvHPEr8X2gUzPm0xe1/25I5Qi7XDaxrUXrM/Xm7tlWIxqN7mynWgLfldJPysIDWQGGVHoI3Cnfo1lkUzw+T4pY3DxAJcsbCUmWjZQI7H5cWrecg7oEuJdg7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V56A/O+/cDbnvxU9ZLzBJRTYFaYPfUhVHADzxVOXEck=;
 b=YAsiXVDkZ4cLzQQZFyJhCzR8XShKLerItdNqUXmLCJ62m1go9b60yWVCdHl+Z/c/alHX18CJRuevoqlvWH7WmPWcVdZ5u9xQuPAPdeaqfTt+L/D0/8P2aMdVauHv2zivL7ixo9VFy6znkZgbS1UtiMJ0vZUNOiWMWN5QsERmtBirQ9sne94ARC+r0bBna2lKoxjKevAWtSDVKK5ujoq3Q0kkuVZLIAcrFMt5kT6OkpJdjqIJEQMEhmvK92733fJVPrIZXOVjK3ilHiNX5ZfSFUT4ro2v0pSOqNhLpP7uIgZQbUtCRt4ADYDbkivW+2NwNtSMcyLuaeN+MhzvC21V1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:46:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:46:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/4] mptcp: add pm listener events
Date: Wed, 16 Nov 2022 19:46:17 +0800
Message-Id: <a97e3700eb1034493411759a554ce0ffdb858ddf.1668599064.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668599064.git.geliang.tang@suse.com>
References: <cover.1668599064.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 73437d08-1493-44f6-448d-08dac7c82707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TB/67hQXWCLYak92FjEE3+/C860DMBN58s0VYQG/ZET27nOBe3jqRL16q9ltKTHb2wOMrH9gTg2YbO7z/1rwaq2dbBj3Da6qN/uVFUPvqbTsX7JgROIKMkiNemlCKlOIF/WVb80Ld0ztoRWMEOIHy/DnIqZuZV7gDb50bJkk7r5Cy0+KvUIRcaZMyRSJNKjkQLAS3GUW2WahBU4guXVSLGGfh69zHBtOsZIYIXIi7/sLlyqnByPdhRDQNmcUfNVqxmcH/BYaWHa2u3dI7V5nEsHQut+n/JmZ5drkXPO+zr8wNUyCSmnqLiBl3PEVKUoXRqfdX9Bj2q52wVEqJQOJTi/ENhvnFyZQjq3PDVmeeGn8psYdRUh2YDV6mU3DPWcGa1ipsc86hY0weAItkzJ79i4bDrLWjKWmRNhrcnZk64ayWKtYVD78p/Lr9xRl/iGSxJkshCJlZv7cxsLVz49XiAsbYFAF5dhVjREtZq2qGAFtnGMY+cLpGz5RaRut4on0MJcJyIoCgWMtfT4S2A5324n00mE5c/seVNJJv2YGh5F5Us66lC8upioWpGaeOd5DLjkAG6SJBMfUiI9zoYzKi4R2UcfTaGJwCWs9r+mPdFnnLy31uwdj8BctzTNdc5KkdkXKk0jn5K9DwvhYNBfIPnj+lkjiN3K0VnXBIzrhM8tdqlV+oW18UNx916Cr1cuUCTwExXQeVdOKW12kcvDItg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(107886003)(478600001)(6486002)(6916009)(6666004)(83380400001)(8676002)(4326008)(66946007)(26005)(66476007)(66556008)(41300700001)(36756003)(86362001)(6506007)(316002)(38100700002)(186003)(8936002)(5660300002)(44832011)(2616005)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4BJ7WnBratAnU8VSQqEwdf+fJ8gXJn6A4srGORUNtaB4N+KCjatIttHbP4fW?=
 =?us-ascii?Q?HYnh5dzRE+sqE1r4BsIJG7SOqVvn3rfpv5ZyIHG3wMEUBq4nwC+z9FnVTGjY?=
 =?us-ascii?Q?6MxMKhfsvY9aVFFbAzQONPY1yLCa1CZaogigeyTmPYb27XRjY5o84Vlzz6Rn?=
 =?us-ascii?Q?KiRx+GfeiqaGWe6tDLBwN/z+Pwzov4mKDfLYf+CSd+w4BA0/WXvvH3lnFOue?=
 =?us-ascii?Q?tGBo8OT29t5x0pa853ARoMqDdd6tc9YUwde13VLKrhY81tsGTFNRkwCJGHlT?=
 =?us-ascii?Q?g67kXg2RyakqPhfMBakyYBekgeolBwoG0MVGaBbqk9h6CHMqyBbQQw6gOr9x?=
 =?us-ascii?Q?CYz4LRCVCu96yR4JxWALw1B6JlRC8GnNth7x0TJe0gJIA6Pzo/Lri/x+Hphz?=
 =?us-ascii?Q?ZsZs5rSwDdq6uDwU8kfia9dB3kXQBHtZBBDKjdr/lCH0S6GULF8fsOuuzt/M?=
 =?us-ascii?Q?4aEJgfwCVkL9YRdQeZAs/QyksSOvKX+nobDUlTPXJ2Zb8snS+XdL8CVlodsx?=
 =?us-ascii?Q?gft8cSeCEie4EdRWebksuZxsGvlrDCQr3D1tUrIBaCL4Jp8sVgFOWp3uSw29?=
 =?us-ascii?Q?F17O4DcMdg7xoOktbgVJjPTLShv6v9SomnwMIbzzO+K5IWoZgQjwZCMwsuzz?=
 =?us-ascii?Q?7pQNcnFqg2IFWruHTPMevG1f6mh8H9eJbDAj7kV2vAgEahfy7MvPrX0Tf6EI?=
 =?us-ascii?Q?g7ZT5kKzMXc1oR67LVO2xMyOgQ0ZdGnQ8FM6vliFdJWrDZ2IJfMSaKZGJwI0?=
 =?us-ascii?Q?DxTROgyWfg+AoW6kEgZKsApY5eYmPiPyBaY352f0caASJTTmZkda8RK0J6Uh?=
 =?us-ascii?Q?HY+SdbbFDqyfuJxwPTQRotVNRMnuOKMFjdAZZ4Li92dX9MMNhDnO2XFPj6yU?=
 =?us-ascii?Q?H2+aDA2iiEnyLgUv6/agMdg+FjKVPx2qOC8u+s+HAtCBjWJ4j+AGLAXkzzmn?=
 =?us-ascii?Q?GnSOb4mREfQRXJe+VmeBfNpgtBVGogairsl6G9zSPPV7XOLY7uMQIZ2OAQV3?=
 =?us-ascii?Q?MV4ZSV7DXpj0uL6VBV2TjpE6ekM1M8kgfa/JuBEy6JFgAfauijj85OyM6QZi?=
 =?us-ascii?Q?lFPHkA+rw+cmGUBT5tkU5g7LwNot67JTfiwJseKnAbxogDqn0G6RbDJpGERb?=
 =?us-ascii?Q?TAcfadUDcFByGl+fl4o362JN/PxWKO50wNMFZp3BtCAFNRqWl7ZKgxpcjVQc?=
 =?us-ascii?Q?+wJsHOJICvpILDMMAHsUTF25R3Ox1H0CFlg4WhM0N6skbMZYWv8uSTtKUE1r?=
 =?us-ascii?Q?L4zTzAFWUWc/z3DG8bRa2W6gxHH1Yb7T36yTVkqTPfGG+x7D/KkhjtPHzLLk?=
 =?us-ascii?Q?vgz8biPBaGWsGTCcdUJjiFql0xEE3AXlLvDoVNUw1wGvQVD5szGFs5h93MPi?=
 =?us-ascii?Q?p1Qm22KJW7jzJRp7C8vBcr4b0bDD35PVKQufe1YCOy+L7aRT7jTHxvdICFCn?=
 =?us-ascii?Q?VE/vQCR7261k7WrZ8Ohe/k2Ih0pMiCDSDHyV3JW59K9MoI1THQkyv6yauNzS?=
 =?us-ascii?Q?45q0VID6++bBLQgetbo3/fLgt6zacNHch0OnPa5DS462PdcKaucROObfveJR?=
 =?us-ascii?Q?aKAhGpCi/AJKga9bjNWKdY3+C+KMMN8zegncHhprgJLWRyIxk7/CSXFDqOyl?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73437d08-1493-44f6-448d-08dac7c82707
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:46:09.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 641X0nnhGNwemga+CPTB1KnJMCnodNSEaunexQBA9nhOnUev1ztDVGU/xG5+Kzu+nre8ZHnyqX85rgSRzIT2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430

This patch adds MPTCP netlink events for PM listening socket create and
close.

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
index 08806f97c8fb..685240f6bc80 100644
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

