Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C971AA45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB1BcwHKNWjyhz6Dk/LGcEHsJeQeAtMR/qjxUSc4D/oqosaBoJoNdEP2eBgn9/evNVRKMFJt9ALGsZPtDpNw343EfQoO+VVmJUQ+uD8Y3ng3SK4Yl8er1tVSxahj1fNZNoYaXV+HZsIRE4tZtkpkENKI23yTh4vdelhYoBXLQp78xQdn05gbs78w847aDR/1rsZkmyJI6XYKdYahuBlnCYuLuFENHMcSSLaxWwGvG3+S5ySjKceYwOTHzPGl78rr9LynMLsz+ZwHDwIx72BbfRhild8mYJyy78c+fD6QV5C7gD6CDN+fjw55av/nz+ExVzjKIbDLLayI6eZrLCH9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDPOi8knlOXPCaTurKmQRqBTVv21i3mPZkkgIOkzhTs=;
 b=N+dECapUllI0dXyq2Gxwt2uZdAP04iSFoDXFOTlT1Io+PQj9HSIJdYUeE7Fk79Yol6EKc672+RZo/qBq/JdL09GOD+HiY+kU49j0ZtQeP+a246FHL+T4LteiRO3jauHBsAAPY2PuQYAUsK6ezOJzlaRYcQXuBeBkG4BnFqPKUesfb/43QTD/ECiteDQdiLlTWHnTz8pxgt+3CQko5PlcRj6NE6hyXKfrBQAYPm2OqmWP+v7jMSaqa3rzs16Eg/gWjiYrOAP/G1OxS47M7lCqCpPFFwU+hJIz5zU2rTyPmhVWLVkZuNK1bp4B85/o9WbZlJRS/9ztAQJ4Ruw9qteBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDPOi8knlOXPCaTurKmQRqBTVv21i3mPZkkgIOkzhTs=;
 b=uS1ivH8qCYAMvdL2XaKyv8ADvunCrOTcfob6nV98Jz9pfnzLH2YQd2WxWtgiA6ryNRh53fqx6WIdUHw38uL/qRBMAusuwrUizDXfiWQfVUiFlXZ6/MiW1wJFXD0DrptFrAmOjQ6jzZjZTD8ghIhJSY+cEFuSI+dIMEP7S5RmHL85La0Z35v0DvWW85yKJWh+LiTNzt9oZPZGACfnT+HN+f/7Xxal7Rwycpu1TFgyssHh8jlftj5te/1PDfx5YKrtXhf29YMDLg21CViirgoENh2LiNiHpE8PDnMVr7LLR3kNe7TEuHlmxkjh0ss3aPSMv/w+/75WJL85lzpV5Bro+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:04:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:04:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 02/13] mptcp: add userspace pm addr entry refcont
Date: Wed, 13 Sep 2023 14:04:50 +0800
Message-Id: <a8e2e45f50f45e9a32262723469a6f937dbfe770.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d22b3e-afda-4aad-ac6c-08dbb41f4ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vbdos1S6gHCqRVXybKc7+5JFASTCrUsVt9il6KqoFaCFl3seSrKGPx3u/Vz7aBtvP3p0gYGGURjIlzFbWU2/43hsslJKzF1eqx+aqWqRmiJpm/pe7hb8nTSVnduKdOB3Iv7hmjYnQ+XygqnfD65nNbOUSS5X/4ctsS79oCSSLDim+QeDdqXxCuLjD5JWiDz8r1wXFyeei2U/ZMJ3ogz+VtMPd+u1fulC7s0H60+i1sCPyDmwB876x52Mw3nJ9XDOOq5RVIXvJjtpPyhrmd0dg7tJZTHRf+1sszu0cRzhDC/b3fjpazds63Wf7jAm1VuZMdgoT1C/neeG4INxoJYoRO5njiOmoLC3zwyzwTPA8xXwtotH+l+OrHdvgSbLycEimNT6qD5hOrVDFQv+7DmiShZAQzfQedn3XTc1IX1L/zTpf39N01uyJivaPrf6usEgsPSn6+1CooxDgPe1CD4+ksevnSxTuh42fyHo72IIv4ZFw49eWR46p+C5iNab90EKMg0z3FMiAqEpctZc551mWSa5lko5bC4Qk1V46tfHCR9qbK+AywT6zvZtlLYZDv8WzCRzgjdGsgCJKjC3vZxQAxhqVupi79IHWg7CRG2gsuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D7Q7QPlvbpJ6N3AfdE5D3+Ljy1atpQtp5SZcxS5vuyQke6DzOECwYnJZck0Z?=
 =?us-ascii?Q?zKqkFJJZzzlsIJKThxFv49ULuzVWG5pRPYzNcGDaXdWJuZvnKXL/jm2yxUgI?=
 =?us-ascii?Q?H8eg0MWfYUUQ3cibNR6xvlfa0fe5heRT4+pJM91TCMZtpHFN8Yy6ug4gSe05?=
 =?us-ascii?Q?uaFVrnBf+qZe1gqCDyRKkhlMMlVYFPl+l9wEKhQLN6rVRxA0o9/Ob3d3q5lZ?=
 =?us-ascii?Q?wJuHKULnEJXOrccdwQI+RxL03/UfYhu3IpUewkuB5P2JWocpQlVl9ihPncoW?=
 =?us-ascii?Q?p/5j/1mSPexqdlC0Q2/vqqhWvn7FTpCul0R3mCQBZAROBxI6KZHdalemUi/L?=
 =?us-ascii?Q?DR7jdCi3LehLhYxrRUX/9vdaqbrZH6LipbZy8cdLQkj1GRnG8YuKPrxtKEjz?=
 =?us-ascii?Q?20rCuZcFGKbP36tf2ohMiLy4/SRPXIaHvKnbDh5lpLONZmcpAPr30DeNIe1g?=
 =?us-ascii?Q?NZAAWoI6IHoOpW+gwOCPjI+W/dvMgth6LU5ERzLaRY40EDkNElPxp3IqUNTt?=
 =?us-ascii?Q?SEHUNQHP60iGt6EJkoeUScXBbsTB/xD5Sria/cpoMw2BbxWDE8UGBMubgjXC?=
 =?us-ascii?Q?DWObAGYfrsb32F401T60CsKNk48OKD1K6+hhy8HiwtpEXgTbnA8bAyPpsHgZ?=
 =?us-ascii?Q?ORiILl4rXmc9rIH8fnK2fhOzCcpSgf4Sb0UVSNqdtUioYKZikvNgJNEk9EVQ?=
 =?us-ascii?Q?PGZcj1ENnEdEOXiedBara1w2yVlJRjK4q9cCysWvSSHUapO21ZGEXPnf/Mjy?=
 =?us-ascii?Q?beFEsdFQiHRTgAtxFOMmwjoQfaAqjpgisutpZbdSV4FBfzIXS0mAZiTzASvm?=
 =?us-ascii?Q?0DukSrolpdoJ08iJeNKXTf2cuiBY5/19WD6ayrTsmvkrbsEaXAoDn9ePgHRv?=
 =?us-ascii?Q?e8CxMlkI8hbE9nwKYYMlhP+PVHGgCNiR/noB0NYnn0a265h/6E2/ULZxZ9PO?=
 =?us-ascii?Q?vu1Vl0V3BJPd1oeHyFm0mlcQzsDU67MMJtA0+WbC2898tlvqI9jrK4vL9hH1?=
 =?us-ascii?Q?UCmUzgTzIyQt7csBbtXgCpO0Ca0tFOYcy0VsjdbMhkEB7coK3uSq4Nw0NyyZ?=
 =?us-ascii?Q?Q1FbPaVyNduwY6YUxpCh9ieRJELlECN4B7Q3FleGuXLsurfiEvEmqDSEDtYd?=
 =?us-ascii?Q?l6zOTpVQh2PZsm5Pg0v109uXweH0HXbQTHkKV/ecW7Yu8/leWqph3HwdPytl?=
 =?us-ascii?Q?G2LE0WQlmWAv+Tz9HSpdQ1EmVV3pnLfWRip10RTh7/oavwMa1I7fuJjZmZTm?=
 =?us-ascii?Q?vQebGVju2TxyLaloQpwENwT0SPsaVaqTTigtyMz/IyxuGNbQYhQzFbXi6wMP?=
 =?us-ascii?Q?Kb4HjK5jTdfBaD/54/wdpfbKdXR3HNn/9EwKvQVk0eHprbxxjsyo3+H+d4+1?=
 =?us-ascii?Q?DdZwoJ4CIontQhrZ/ByNqmsfayf9mnO7odu5uJBvD/ny+wIBY8AmQOIPU0Qw?=
 =?us-ascii?Q?C5piEeZU7nVGECKW2XapUJ3W/X4GRul63EZkGNHQF6mcMcfFFfkuYeGW9CEP?=
 =?us-ascii?Q?XARtJr8qYwoDZUxtutB69g3eVaphC8FnSpp3Bh+sSp4ZMcqbH/b8sscpeJvr?=
 =?us-ascii?Q?POY/U5mZBwJ2moj/VPsd8XSNSfi7UZyczcHGv7yw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d22b3e-afda-4aad-ac6c-08dbb41f4ec3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:04:36.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3Sak5PLHaOAQnBC2O9OoLijtqHO7Wa67F56d4YviQ8OFfpqQfIyDxGokFMhgsJfxAr97lHf9h3pjePAPvzF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

This patch adds userspace PM address entry refcont. Add a new refcont
filed in struct mptcp_pm_addr_entry, inited to 1, and another filed
subflows, inited to 0, to store how many subflows have been established
on this address entry.

Increase both values in mptcp_nl_cmd_sf_create(), and decrease refcont
in mptcp_userspace_pm_delete_local_addr() according the subflows value.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 27 +++++++++++++++++++++------
 net/mptcp/protocol.h     |  3 +++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 359ecc65fc73..091f299db010 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -70,6 +70,8 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		e->subflows = 0;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -102,14 +104,20 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
 	struct mptcp_pm_addr_entry *entry;
+	int i;
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr);
 	if (!entry)
 		return -EINVAL;
 
-	/* TODO: a refcount is needed because the entry can
-	 * be used multiple times (e.g. fullmesh mode).
-	 */
+	for (i = 0; i < entry->subflows; i++) {
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			pr_debug("userspace refcount error: refcnt=%d, subflows=%d",
+				 refcount_read(&entry->refcnt), entry->subflows);
+			return -EINVAL;
+		}
+	}
+
 	list_del_rcu(&entry->list);
 	kfree(entry);
 	msk->pm.local_addr_used--;
@@ -380,10 +388,17 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
-		msk->pm.subflows++;
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);
+		if (entry && refcount_inc_not_zero(&entry->refcnt)) {
+			msk->pm.subflows++;
+			entry->subflows++;
+		}
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 15c85be21fd9..06465c8c21e4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -241,6 +242,8 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	u8			subflows;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

