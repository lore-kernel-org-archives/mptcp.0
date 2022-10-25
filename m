Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7C1A5A
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 09:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fkxb7T2SXyoSP+jDq532AYopZQrJwlyJfCs51EJzAnmCLnzxaEvyju6T/he5aBj11DRd09wDUaf/2H+Tn4E/svE1Bt1Sik5JBXX5bUFTfCFZYiNHvHDpjS6umfFfuQqMCpei6SECmGcpQgnKc7FX2WHhk8XQ+HmzD3kVHN2JFqWi5fsDJSAA+RwXEeaqZu4lyy2SGeHwto6r1zPzsAKaLbu1cuUElrtB0bqRLYh9b2MS5dKUlzZeGlqpaL6ls67f0Fy1Nr+frSpsSPzWV1oYTQHZxBQrPk+ZZycZJqtvhhf96K6PleDm7FBjYQa1aRtJytOw8aep+RRRb6FiZ9H7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VzvaZb6sAdSfdCOhCEDBkjmAJ3CtZ7lToatOplkH38=;
 b=JE/YaQOqkTU81iCnOv5qhtwGkXBoA4qwXTF2pInTe5NdUQm+zXEv23YeRfJANRmldYMIAFaFQMajr0Z3py0Na9cHdOmuYp5nFiL62tKT2FiWsGs4V5ABrvgeVP7d8121FJGk6xaqesIaMouAXdfpiCyLAJzfofSHmv/kxo3y244H2JwLHscvLqHo+eHxCKnrhtlehr3llWEm743zmFZ0wPZZg+UKRrgq7CsqIIRGRA2miyhau/5s86eId7tn0urO25yU0s6CCRfXj7tYVNwGBqDAtn0vcAwnoYZgghmfjXp/Iff/sgGobfH6hSIaiDE1VfnQDgwm2DzTr3etUK466Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VzvaZb6sAdSfdCOhCEDBkjmAJ3CtZ7lToatOplkH38=;
 b=17SwJqm9GJtmi8dtPEE21NdDKObdmP6AOJx/kEytiVHXPX72EzHiVBSZx+Fp9umyLv1S968p8F6mXStH01sVfsqVVZHAIeDxLwUEG8qaXAVs7Datdb+Ce7iOtxIzXdvlzmJFLrZPwp7Cs1PgZbGl14fkVTutZVpSaYsOJj872btTU3U/1f6mEdP6Hu6KmcNrbqaMXvrzLkKR07l3d9Yg7lNXZfORB8HD5qbioXEDY8UVpZ7y/GDdiCWSgA4ZrFitUJCLkLN4fUZzDIlBVfgBI78s5OKGnWUKQptARrKj1yMypkpy7Rts7iHpHkhZ3+Fgfr1xhXNfZkf3LzP+I+7XIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7212.eurprd04.prod.outlook.com (2603:10a6:102:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 09:24:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 09:24:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next] mptcp: add pm listener events
Date: Tue, 25 Oct 2022 17:24:44 +0800
Message-Id: <20221025092444.6646-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: b5edb376-4b72-4def-4341-08dab66ac39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wSJAv4cFaNJeGpqfHgnTtkRt6Ny7Lh3tr4xJu2PYcKc+mx4AhfbaRwCGw+QHmRCo/a0oQ85cxzwtJ0o35+MNdT8MDlsNJlUANat16PWZgu+jb5zhY66IK0/+XQdvatFVE+CAXRZV5tmKydCsiQVnoeQHyywbXG9gAmHUKFFnpxIVBbftk+Qv21UQgnu5w1dEQtHSTKZJ4KbDy61JKwB76TPUh5tPHjJ8vmjmtTnykfzprh/T5dz+iMb0CokQWDwzmVy3iSdvUbyReg9UQSm66un82fhFpzBnQvUfbhsGdjBtOW9mqVG8DMjQuza5wKylrcm75zcyZ54yNzEGxns0V8qARoOBEZqYP8FtBdcbB0Kqt6lKugkD+0x/ozdRR07UayrNTAQ0TIo0nO77QpBT/gDyYICpxC7Ash6g3KFSsQGSOw/ftAd06nsthDq6yGYVOcihtAAb+zcjXKvElqzyN4kBEFKZWhD6T797Ufxzjqt6ysxadbtLUDdWAl9wg9BK5ZDKBcNC0hj3NbNKtl8ZInS9cqBLZ+3lKXG6nhcCnOYsAOWKPWRfgRaNBuObN6xDB3MLfMzdTd/f9aUHa90L6JFZitrt8OLc0hgXtfe/UDcLFn1W+QF1/yufmq8UCxE8hAzNkzwLBBdvqmnOtok86U57uGKb1Tgpa85y9Wvvjm3LRA4kFOlfFPRCI/5lENMS6G1w4g8FWCcZFBPIooVxIgzuPLeiGeBJmX9DVvmpVoFopb75j0zjNa4iCAko3/Ag5pX76DzIGMR4GkNW9B4W+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(478600001)(86362001)(83380400001)(6486002)(966005)(6512007)(8936002)(41300700001)(6916009)(26005)(6506007)(66476007)(66556008)(107886003)(6666004)(4326008)(8676002)(36756003)(66946007)(44832011)(2616005)(2906002)(1076003)(186003)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqdU9LFG+boKus2EsTligYe9WCQKt6EkxTBhJ7fhwK6N1iShSMtI8w3mq7tW?=
 =?us-ascii?Q?Vax3eu/ZuQ7fdJgAE9hdFIJ57guhEyqCNgeAaPRplyTRK/fhfhlQPyd+SWoJ?=
 =?us-ascii?Q?irv1F7mXHIE31+AL73o4dmrqapUIYWen47sASC1x1K2/YCTldpbeLd/kCLNn?=
 =?us-ascii?Q?jj2nF9OPrZZahtfghTIr66bbSDqscy+GLZlojQRM1n37yexIib8RTWTBJC7g?=
 =?us-ascii?Q?zSY7jOuYh0CtemDZ60HWPQc0TZ0BFU2vid4T2VcU9RPHXJDaJKuKOT56D1Gu?=
 =?us-ascii?Q?y1wm3bcGoRYYfokuoy+3bzWWTH6cx0ZgMkUs0junrtGY9f3n2ffH2NOp6tTX?=
 =?us-ascii?Q?bZ63ZUhvRXTbT0DivkxKWYRWqPCfRRSiiAESjfCOkFiimGHmL6zi61WJOrtO?=
 =?us-ascii?Q?GhO6OU2+S9OIE8YlBSTb9euxVL2n7KOFEkdhIsGK6faUUMRNKOyXpGIrHhYr?=
 =?us-ascii?Q?+J0li9tnfV9avPupAFEsj/AoTsfCF5bOKxY4/tdTFFvnHi8Tb8y/nALdfqqW?=
 =?us-ascii?Q?SsbVxkk7l8iR+bmMkLn+c+czWv1EH9tYqRwB6i8vq+634VaNn2z1UYlzGIjj?=
 =?us-ascii?Q?Ed5I1tliZx6ePgovTiaBwSYZ4D5+wUdcx/myRqk+2oTU+dsCnIIhMY3Q4VWH?=
 =?us-ascii?Q?vSftp5pAzxOv7XcNALWlA4WgwCvj3ENplg7gZUNJnNrhtL4xe9mBIiInzeD+?=
 =?us-ascii?Q?XRfX1stWRJqaPofh4+itmsLDTRV9jh9/x8jgLL1dsQQvzXI8ixQMbtK/LNE6?=
 =?us-ascii?Q?xJ6ttn1qGwJsJSf2oHtNqOOaxar2v0R9cdtxQE7F+86bVk4H6eylRHHTLkNH?=
 =?us-ascii?Q?a+PMMfsAd+LVXPyugDgR17OXb5ulzmbReKfNcaXvs7i4Aq4HicooH1cp4Hn3?=
 =?us-ascii?Q?uC04kzDq3V49C/JMPtd5WcW4ibHp100yJXMruj1OMvr+6D7Cu5KLRw+bQbFB?=
 =?us-ascii?Q?j1Ilj5VASz2YYryDyHzdmhkh2aQevtNiKdeTyU+z1PUiXkZlq6PuRGir+bWv?=
 =?us-ascii?Q?8GaErzTUowzbmnSFRBqXhhPMUtmCnLfRpWwrhQoCwxvmVktkWbcr1m9wD89I?=
 =?us-ascii?Q?s3wm/lWycTKLqIuKofvj68WzE5LZfIK68YpkzlpG9y1Cz5ZgJlJXJjX5nLR+?=
 =?us-ascii?Q?eNzW+8bF0AltPaxIPTjMF191nRsqOg8sS+MR0YcJOLjgjnihyFMqfMpBxPK1?=
 =?us-ascii?Q?BxV0X4NNRKFDsYKxCIqzYk+0kiVNvW3Av3MX6axJFkw8y6DszaasdDq7ceyc?=
 =?us-ascii?Q?zUKl/Qp8tsdCRMPbZx+TXjRTnWA7NNjg45nbE27I8kYwUca8L8x0wWqN8HkW?=
 =?us-ascii?Q?uXW7fhXzeJoj3WG28VNdSIm5JEkw+xJFms40jIqxBWhJC7lFeQNnTecGso/6?=
 =?us-ascii?Q?pJrSGzEahF58j8TbzkPB+vEQbQxxhcHeYoUJ4Paw9VogEoz9ruuE2OgOvRjC?=
 =?us-ascii?Q?2SMHCMMjbpXw6voTpJ1jSATWgdIf/CAD2oSzfb0oJp2Rf5d0uvoKtyWi+FNv?=
 =?us-ascii?Q?9hnqASpHbcwscOsGKMAq7btQn2/bXEjXnZGYs0ngrPe8NxcKnEXYqmPgy1PG?=
 =?us-ascii?Q?Ej+YDK3SqqFB0ERWAYXardc1AXob7TZGxUKMvql1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5edb376-4b72-4def-4341-08dab66ac39b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 09:24:49.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+9ysEWSO1Gfa9pwo1XpvgZA+FU3j4ZZfrZfTlOqmKbU7DAlDsMsqIJdK+Q6M7gL+03OzATBNelTq5QY9SPUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7212

This patch adds MPTCP netlink events for PM listening socket create and
close.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  9 ++++++
 net/mptcp/pm_netlink.c     | 66 +++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h       |  3 ++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index dfe19bf13f4c..4307807ba8d4 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -160,6 +160,12 @@ struct mptcp_info {
  *                           daddr4 | daddr6, sport, dport, backup, if_idx
  *                           [, error]
  * The priority of a subflow has changed. 'error' should not be set.
+ *
+ * MPTCP_EVENT_LISTENER_CREATED: loc_id, family, sport, saddr4 | saddr6
+ * A new PM listener is created.
+ *
+ * MPTCP_EVENT_LISTENER_CLOSED: loc_id, family, sport, saddr4 | saddr6
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
index 9813ed0fde9b..85cdd957bb11 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -894,8 +894,13 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
-	if (entry->lsk)
+	if (entry->lsk) {
+		struct mptcp_sock *msk = mptcp_sk(entry->lsk->sk);
+
 		sock_release(entry->lsk);
+		mptcp_event_pm_listener(msk, &entry->addr,
+					MPTCP_EVENT_LISTENER_CLOSED);
+	}
 	kfree(entry);
 }
 
@@ -1008,6 +1013,9 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		goto out;
 	}
 
+	mptcp_event_pm_listener(msk, &entry->addr,
+				MPTCP_EVENT_LISTENER_CREATED);
+
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock) {
 		err = -EINVAL;
@@ -2159,6 +2167,58 @@ void mptcp_event_addr_announced(const struct sock *ssk,
 	kfree_skb(skb);
 }
 
+void mptcp_event_pm_listener(const struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *info,
+			     enum mptcp_event_type event)
+{
+	struct net *net = sock_net((struct sock *)msk);
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
+	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, info->id))
+		goto nla_put_failure;
+
+	if (nla_put_u16(skb, MPTCP_ATTR_FAMILY, info->family))
+		goto nla_put_failure;
+
+	if (nla_put_be16(skb, MPTCP_ATTR_SPORT, info->port))
+		goto nla_put_failure;
+
+	switch (info->family) {
+	case AF_INET:
+		if (nla_put_in_addr(skb, MPTCP_ATTR_SADDR4, info->addr.s_addr))
+			goto nla_put_failure;
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6:
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &info->addr6))
+			goto nla_put_failure;
+		break;
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
@@ -2204,6 +2264,10 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
 			goto nla_put_failure;
 		break;
+	case MPTCP_EVENT_LISTENER_CREATED:
+		break;
+	case MPTCP_EVENT_LISTENER_CLOSED:
+		break;
 	}
 
 	genlmsg_end(skb, nlh);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f48f881adf8..be1e8f434b1c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -839,6 +839,9 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+void mptcp_event_pm_listener(const struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *info,
+			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
-- 
2.35.3

