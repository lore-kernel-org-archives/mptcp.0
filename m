Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E408D125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN1Y2E4KJQOEUxVpGlqgoMhtqPpdw2u0pc8flJh54UzTvZLBnmZ1DnOckux2+W3hOTj5jUB6ULXAec/+N0KzRCHcBSDEZtG40Xwa8+Ob/TWwfx8c14pMzempSzy6kXIDhNDUDYoQhvN6nTL0N4EELdoWzhdJbpnntt91gwwkUSS1/3C+Jhm1PEOj78YMl/C3jPmsSSr1WGNWw+sZOSPLvBiVejp+6GHcUjesIs070+f8c3ddn9CQLkhV5V/Fhqu8gN4aOW4Wnx0gIjndzVC+WOC0+WJ2qnx+4NYb0J+KYv0mY873gVw6hoqHkzX5KHuqr4MLTDYQzLiX2uwwrc3HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XngaGM/DJAO/9MecDEFPd8DsmB8TdxfJQknaiTs8mLo=;
 b=mnWl6occ2nbR70LxunCjwctC7LmgkMr/DkR6fSrdIlSiAYR/X7trkSCFwpq8Em/xpS+V37cHV3yOwB54NeVHM8SF4hALREuvbu+wDLCu8dNtiiVW84K0kr/PLbzDFFf8DLYbJXSRb7xy9bZ1fjUu2Lvh6eQkl+YqbaOVq9RkLlsTD5KSl7Uz/VCPr5FPLFfU3BPCYCmbFaWmzC704iLiBGy7adNmzAb660gC0ifJZXJY/lsnP7P8nkk44EX6NOycWNbkvPKkWkAlduqeW3jrS8pvZLKsDL1t23QeyQmqd1FPmdt7QVsZtihsGmcHARr0LWYbmGbjiKApm/n5zt3ceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XngaGM/DJAO/9MecDEFPd8DsmB8TdxfJQknaiTs8mLo=;
 b=2XF9emDyhqdTB/J8YMYEB7qD/ZVbrbwWjuaFGzq6h3NkGsUFEj90tbMcoSMul+EFvRrnEpy27+RFS7PW7ZSxTHt6+h2ZuCcSUlTRHOGdpYuMAe5wz7SiUoC4muuv7Wz+WKLAXbMjGXfOL/fQwFH/kQvf2Fg/Dp0wOdL6dttPvPrHesqVhBqNYnU052h8XnMDhj8lBzfHuU7neh6NIwrcMZNKn3imGAs4JrytI1rveqgbfvquy7qufPbEefp9IZbHs6pdsKcX8Ht9QeO0xoMLqSpgHUwFN7O49gJgvCt/GRBpNVAouL+mtxP4Y8ayHY7r3L/6ARhQNKcqucwq4jheLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 19/29] mptcp: add netlink pm addr entry refcount
Date: Mon, 25 Sep 2023 16:41:58 +0800
Message-Id: <02f4426edd24a150ab523715135a602069244443.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 198890c7-b572-46ab-a4d8-08dbbda38a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yc5rPVrEK35sNZnz9/usejv3djZpVquf1MGUskzcIsJ2cSZhBQ3grVJNrtboDY8Nz6efkEiIC5EucZviBZE6v7jmcFStPJR1bTGioRzoFqnFSnfi6bssgG+PxYFPhG+nV8HqMFH/XBH9ORUJEdprIapXRMMh+Po7vXomkbx8hCQnxWKfZbGYt3Mc07mG2xDsE4aCwDK/R6Bn3PNrqzjU8ggx8g8x1Uc1DZ+bT0lOxq69PszPjVgp50CCIcaW3WVKQrqXPos+EjEK3WiyfNDbRCiz0JY+EsEoN/XDbnMQQ3m53m5IunuG9bRpYLakG6RzifskK/13XLq2lWa6BXULC1swf3xqUZqZTONxRfd0hVxt6Jej+q/nSP5YqIynIZ3a8FoJmk/NS8m6xOeBMWulqNcsj9AnAfJln2Fk3gmgglhEnX58AmtbzF+8F0YFmewWz/jFeDGXWZuAJ0Dd+G2f5MMvOLXtpdpjHfCsRM8G8kC5UI8lHoKTKJzAPLd0eveGCAIobaQOG8oLXs0ERyIIO1rqjoV0lvsOWdd2YK+OkcVRGv9p+ZGVmwZsHvIXYG9+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBE7OTKTP0Vm4dMWhWOMtZ9aUpxxEm0GJI3116BLQor9KkztnuJENyR0vGWw?=
 =?us-ascii?Q?jQPR4iyPVW9J1lueLJpD5fILNfQu6D46I5RFzDvYjdSqzOBfp0YoCNXVJ0R5?=
 =?us-ascii?Q?o98k2q5QmICDSwaVJeXCYyWpleV287rP2ey2l1eTA8YAAmB1k56QTk+byOhX?=
 =?us-ascii?Q?XzBoXZ0sfeT0QyjnYUF+3m+dP1TksI6+jcbco0QcL4RYNyZroS05NPHVrQ+H?=
 =?us-ascii?Q?C5hKSHvv6N1vzf3kQvHIeyehyYPUN+516L9CB7B6RltqSAnTTId7hqoQHQoh?=
 =?us-ascii?Q?YbkfT38sevzVUgCzvGlTpmsTVySSyLFxZ/FgtlHJfFM2K06y5/CF4I2wMird?=
 =?us-ascii?Q?11Tr1ZhJriPvRKqDbpProL9duJrPqKLEcTwEJrNhTR12jNks4hdmyThYgs+y?=
 =?us-ascii?Q?1B8U9ycwXKHKVhNqHJUvipdZIZ1iX46AQRj0mAnV9Lc/TZqIh0nE+4adQ8a2?=
 =?us-ascii?Q?nKSPLAme1OgYEemXD54dbdYI4VfOvcy5lkz7lwbj1aI/Wwo7Nmo0nO08MKxs?=
 =?us-ascii?Q?+4OaHw4O1eKJH64ze18w3W/7TTKOpgO+mX6YZJtKde3PUoffR6YxvKTo6Xek?=
 =?us-ascii?Q?8c9OuHqTmKe+DQR7G3fV7Sn7aLknjBxw/W39uaqKe4PG1admnr7ZX+FDQVEY?=
 =?us-ascii?Q?cbQAuEoURS4OzftbBhfBMkhAZrsIoQST1XyQplC4crb0J/yY+vOWUPA/yamL?=
 =?us-ascii?Q?ACpAPcu6rdUerUbX3diHqD1RYXo5kLfnpcvCfrmYOPLwPEs1n6cwQ9W6usKS?=
 =?us-ascii?Q?A6hsAjYA4Sg8m8UzDFwbuhieLN3eIK73lVKDubdQoPpYtQKcPGcwWyskuMEy?=
 =?us-ascii?Q?DcIf3CIOiHSkHdNiLmGNfjsAtC0lLCvEo068kBxlhbsGozXue+8C4LKo2L9+?=
 =?us-ascii?Q?FOyCx8nA5LQ8b3eFKi4oJnyaNBoXCPWmv3HKM5jJuFnqzp4OOXEdpFFQKYOu?=
 =?us-ascii?Q?Slcy5EhCPS5hMwWLeGG3dusLnO9uXMpuD4lCAvms5elwd2F7UKdBRODYl01N?=
 =?us-ascii?Q?/EVc97H5SfV0EqEbfR1z69dO0yZUgMtNFY4Tajc3YQDLAQAmOS7iXc0t6a5P?=
 =?us-ascii?Q?m+pIa5t9qe+e1pn7ULAhzkemiQbfl2xs/Y5BTQOwL2NLtaJoIOhquTc8RIcy?=
 =?us-ascii?Q?++PPcT69hEf6A2yVwQdPjfihHKXIrC5WJQcshR0RHDKDvh2ZHs4+leJUxdFr?=
 =?us-ascii?Q?0T83ylH7dLHGayRlUmLfmC16jn9hkC7SPyUZ17wmmfhMs1yvAg6zS/V2fKLT?=
 =?us-ascii?Q?E0dadjf/yeFsMiNQ/935CZ5O+f66rO8B8+AYGteTY6R7MCV1fanDa85Gi4sr?=
 =?us-ascii?Q?0k9f8C62wh8mywa6llMRkGintfYBndFn8jFsYJeY50uJ5tc6cVdJKDLnZKK9?=
 =?us-ascii?Q?7w1FR9XmgASI0+ZWrRc3uECXOEAlBDubSALe/0SxJx9bG/KkxPG3MRKfirTw?=
 =?us-ascii?Q?T6xvITMYIetQ4u8JxconZVeqAOX1vUnemssNS9xk9lJtAVYxEAq+6fEUtcq/?=
 =?us-ascii?Q?oCS1BD889gCwIAXQ8sth4bDxiO0J/U0X0ffTq/sz9IAQp2H6EUVpnOHLddzq?=
 =?us-ascii?Q?N8gKFXW9WrwkOHxMvNMZssjqnrlaMDNkqYzoAmUH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198890c7-b572-46ab-a4d8-08dbbda38a24
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:50.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUMRM5b0gyNXvqjxtHyD6WtxLIkBAi0MfTCUzKbB3P8hoOlQKKxOQIqvG5rC9G3nkPiym4nL2hnR5f0Kbtbxng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds netlink PM address entry refcount. Init 'refcont' of
every address entry to 1. And add a new filed 'subflows' in struct
mptcp_pm_addr_entry, inited to 0, to store how many subflows have
been established on this address entry.

Increase both values in mptcp_pm_create_subflow_or_signal_addr() and
fill_local_addresses_vec(), and decrease the counter 'refcont' in
__mptcp_pm_release_addr_entry() according its 'subflows' value.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
 net/mptcp/protocol.h   |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1529ec358815..7d1a4922e931 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -603,8 +603,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			if (refcount_inc_not_zero(&local->refcnt)) {
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+				local->subflows++;
+			}
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -644,9 +648,11 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
+			entry->subflows++;
 		}
 	}
 	rcu_read_unlock();
@@ -895,6 +901,16 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
+	int i;
+
+	for (i = 0; i < entry->subflows; i++) {
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			pr_debug("netlink refcount error: refcnt=%d, subflows=%d",
+				 refcount_read(&entry->refcnt), entry->subflows);
+			return;
+		}
+	}
+
 	if (entry->lsk)
 		sock_release(entry->lsk);
 	kfree(entry);
@@ -1087,6 +1103,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	entry->subflows = 0;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1314,6 +1332,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a71b64565e04..2194e53070d8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -245,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	u8			subflows;
 	refcount_t		refcnt;
 };
 
-- 
2.35.3

