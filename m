Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372F7B
	for <mptcp@lists.linux.dev>; Sat, 12 Nov 2022 09:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh/CZH+fnDKHPHIdrgnfZLwy43Dj0hGpmTuUX80RnxrneRLBw0YK7KVSrSufweKSAI/e0XSeXLpMxReIbBlxKjMXoQsuaDdOjUw1jxsd6N9FfTahWoh8zEHioj7rfNAiWIQRPTvzD0uhi0V8uO2timQKnY5eOyK0/UljoP+cehdIcA5193s0zUoa//Of5ODGB9mkquOxWKgqp/3kUVu/irSecTa2XfsZkUjOIBV3ZuQC1ZIjr5joF4zgJGeAAWw31Wr6AUMNhxy3cbzICg/HbF1n1aG6FeXyFj9ATSvfDjahoeXEg3nm84LvPCpiwPdOaqbugRulMZ6IjixFFP167Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l26d2x6MczcNRj51hTathfnsYsYVzE4PCBZqzmXVao=;
 b=YLaJh8+e+lAPE/ekDsuBAht1IIwGBAG5VW/e7yk5ShD9tOFB3yjJkuDIitSPTYSJqDC5UeFQ7++6F926c9q+aZDqA9XNY23dzyqFer3gbw7r1OgZ191oHFKwgwTpfpJRW8cAxabj2Z0JqbBOJ8VkD6GCmdyPoNMGVL5ylxA/9Hs+iOrQ84h4L+tS9cFIc6U7HW8/S01dzlATPP3rA6YCaMiiv0AYbMa1ctEajW5dEtiRSxwev2k2goiSC9IkXAfqniMVOEk/D5BZE6SopuLL40Djd8QZzoMf+xZ+CtqJEfyAVtFbXgJpRUTcp9/teRbYsbJYoxSJypn2glUBkRxt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l26d2x6MczcNRj51hTathfnsYsYVzE4PCBZqzmXVao=;
 b=dh6H7jMm3FVqohtYmpqtwmtTfa5rv321rHlgASGtic5KUFi5g2FHPO6AtA8TmhbNs7p9ScxLfNaJK7Vi3gTIkBZ1Ebg3nxu97BA5y2Cal5l5ZTIwLnnKtQlF+x5nHONhAyo0Raeiah9NXl3sZQwyTlYDvPcFVRbpsla6fWGlvxZ6LDoZIC8P/MBvBzDlDswE6Q3K+tLhO5Lsg5l4i9GwyQCjcgpkUS6ksehNn1Esa5e19rjCrnketyI8DwJmxOSELmQ8LVdRaDT0VUuGAoSg+U8hNEE7JhxOP43+2Z4J9BNvGKHRo+ctZlvCXX9L2zBWcc4RMaHsANzodYynneBd9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 09:28:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Sat, 12 Nov 2022
 09:28:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/3] mptcp: add pm listener events
Date: Sat, 12 Nov 2022 17:28:53 +0800
Message-Id: <bb8e0d8654a232cc51f91c20d5a633d43c16a5c9.1668245254.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668245254.git.geliang.tang@suse.com>
References: <cover.1668245254.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: c704269f-f824-4c0f-ce1e-08dac4904d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	laLncmWdZLMT+Fj5rl41jNHOba5rrYT4PHZl7/pF09nTPPzEMRZNvojzj3UX/GLz7Ucl/rYjBE4BJUrY/hl1LFVKHk6sE/4fvKOOMsf/EmhJgxxFWu5osJ9zUnNIc6mz0LVxX8OJ5FSuEbGm5QvBpnodJWyX/CZARfghw5KX2xKnReD36kN3X/mVHNnW/svUruFx1KikOZpvusDu/JI9EeoDXoaAyGWGwm728xoTsAwEALZWrBwsIUVlb3ULEdYlA/ASkfSWmcaKHbOEjtZTYr1PWl2VpP7tR9R5VRNWLjLvJ1WBEP+SJn8JHg/jGCEAotrKka9zv70kTENiHx9/VMpXxzQxbTd5mg18Ym0tILVVQwjmDAKxXavFT1Xy2rU30vIX3JbzP/tFklDsrjPvP/oFfEh4im91MChyQmZzPVJ8BhfBd9KZgGv0QkF42eiwsIF5vV9kLvRrctZiGJ0x5hNuRt/nyVcr7Tz8eNsY4+H5AvKtsqK8TZjlKUqNHzNLvfM6djljqV26qU+9EFk8BU6N+heVbJ7cSp1RtercL12AiZyx8go20yHsdUl2Pb0sHCy1qrDMqg5+lkx4GOJZJhANaYNISfCOvAIpqF1mnuOm2lpOCc359YzUsR56Nu+zg6RhnZNgQhvCbsEufVdXbL96aei9c1y3fVNPm/opNVVL0cbh+BhjU+z4cv5WMzdhxGrmEJOp8xRKMluj7S5ImA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(36756003)(26005)(6512007)(38100700002)(83380400001)(186003)(44832011)(6506007)(2616005)(2906002)(66946007)(41300700001)(5660300002)(8676002)(86362001)(66556008)(6486002)(4326008)(478600001)(66476007)(8936002)(316002)(107886003)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ldxpYSY3xz0+lF3RUhuRcTE7Bra+ldlndBCbtdoa9y/x0XyY6sZoQQejw+kH?=
 =?us-ascii?Q?oFIkpCkRZ1xcclke7QAB4Vz2xx3pejFujQVXSoF3QHi1AWDShQbIXqfj//TR?=
 =?us-ascii?Q?696qV3dCwK8f65FTH7wsjYJGWYjGzElEplt1cXDe3XBXgIFYIJZj9OXO+qFr?=
 =?us-ascii?Q?yDtDa30+qGZJvREjwM6nH0utI8aruCUCRvaPbjLOB2B3JkhTlNY6ava91T+y?=
 =?us-ascii?Q?G1aXJQsu7lEfwPtvaekGDWzID9kY+lfcYnhlN5K/BWNRoo8uXDPKRfr01dA/?=
 =?us-ascii?Q?cwT00NDmJbRaGoLWvxFJqTt0lMBR04HQZTFsuk3Wyd57WsQxteNe1bmrwjnE?=
 =?us-ascii?Q?lDxMi0BGqOyrPiVG04WVF5ZPvICk43cT30Pi5WmhuLtaae7r8TAm6yN3v0oG?=
 =?us-ascii?Q?QX163xlIkrVDLr3dpXK3RGRp64EDw1QTsZcDq2FUUyR2I0iIKijFah2t2alq?=
 =?us-ascii?Q?GCi4dn0PoFQpkjaznhJrYLcw2dDsZRoV7CFGH+ad9+p8GIqoK8pdD/ElYd6H?=
 =?us-ascii?Q?kCKMr2r3QJ3iuDxETxyzcTiOo7KxV3Df/0/+3LpsxYpS0fhFBZg9Yepg1I1T?=
 =?us-ascii?Q?VuP/EtO/2xKe1w64qab8bInSoBKF7hKwdmIsdohILob4uYgZuMFpeo5ohd2e?=
 =?us-ascii?Q?PMDrYlY09f/REmC8+lzIuFEa0JekPoUbyULGh58jvy28wdKiirlb4v+3Q5rd?=
 =?us-ascii?Q?B7FQ4kYjh70jfuJEuyAlcD/aB8bf2F92PPAdeaM4IJhHPQeUkbnok989FPWV?=
 =?us-ascii?Q?EkH6BqN8UdBdDi8RL2nyi6dwVZlYGIdq6KfA0mGHAP8lKAVOuoBLmylmLIOB?=
 =?us-ascii?Q?Mt2YFGojLtNKJAD9UPywyLVmjLxfvWjXy3es45c3zeMFfC4IYq9ONruNZ5fQ?=
 =?us-ascii?Q?H4ojFvaTQUf0v4NVnaf598U7I7s8rBk3fZ9u7UMEpRIKBTxHDJdA4JZTCtEo?=
 =?us-ascii?Q?lSyiVRB7qxFXMvz0Da/Cjgje62exb4lbjzN6sSCWElsnKahels275bhDE8Sd?=
 =?us-ascii?Q?TkvrOv64jgDOvytx6/ZvRcbI/nT8hqfipQN3861OhvorxAfyv7AUTnn7Vgz6?=
 =?us-ascii?Q?t/BQmcr/YImxE+jFwqWedudm0qajIWfeyLL8UGmue+yp2+CB0EmXonY5l6q8?=
 =?us-ascii?Q?YW0oKqPY2XckQwtFuRu1xPIqDIyl0yUN0teU1y8AJvuKdmY8JBiykQrgiVpH?=
 =?us-ascii?Q?bHk2FEG+OdK2vMKMf+OKqI3DaixEXpH4HWs687zC3ck/t+CfTypXDvohA9d8?=
 =?us-ascii?Q?dpQ4UyCb3tEHq538mvAI5/xlOQgjOStcTkEStBRls15LMOr0Tq7B2HBhsAUP?=
 =?us-ascii?Q?1S4DXNsNZriqZ5A2B7MiK0BAVdOf9gRCqBxHfB+VcDCqwFDInm+ld6ikOQ/p?=
 =?us-ascii?Q?zlSISuP6rDoj6qjcDFLW8AF8JoisCXYii88ypC6w7ND33LDssxX1ulclDyOY?=
 =?us-ascii?Q?QcduzQIV8RE5lMTNT4Na8kGMJy2NCUa8raMCuGV6VINi/vzhYtanYwVCF4Hf?=
 =?us-ascii?Q?3RFXvB/tR/WvafWS0MLYU/AUgfBLoWRX34w2cvE6zlShcQTVlGIwWBiuSjY7?=
 =?us-ascii?Q?r/tTHU/nFKZQjaEE75PWuafByeh2OBVPApg3DwhsAuPmynUOBHus+BI/9TB4?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c704269f-f824-4c0f-ce1e-08dac4904d2c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 09:28:47.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSmzc9BhifmGp3BpprR48MRjO9GqD2Lix/3gxWOCaE/yIOznOcsvHulXoSOtcjEzMSAHzFYBjKHk0yQaAZ3wjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

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
index 9e5b3cf27a45..42dae4c0d8ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2369,6 +2369,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			tcp_set_state(ssk, TCP_CLOSE);
 			mptcp_subflow_queue_clean(ssk);
 			inet_csk_listen_stop(ssk);
+			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
 		}
 		__tcp_close(ssk, 0);
 
@@ -3685,6 +3686,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (!err)
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 
+	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+
 unlock:
 	release_sock(sock->sk);
 	return err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4780fb5a8087..5c9bb0d5f28a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -844,6 +844,8 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+void mptcp_event_pm_listener(const struct sock *ssk,
+			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 // Fast Open Mechanism functions begin
-- 
2.35.3

