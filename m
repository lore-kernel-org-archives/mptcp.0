Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CC18C0A
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YYL8mnMs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF4LwCPUtbupP1CXvujo5b4+2WONO1EMQMpKFhUu13ZDIeoByjllG6fJsM8FUnByOn0lN5lHaKbYJkraSM93EKSzryoZS4tbY9JlkwoxssN2Kse2rWs3ilefQZ5RA1NDH7MnooTo8UDdLt48AhEdNG8I2E18movVB8YEbJ90l8izjwIlhG9H8LxQ3eGekmfcgnwKVyYYy8wiNBTUUfxHQTdp5zi/N6HG0FreTORygAx3FMflroCG1uWwSWG++iXM0TLOYgBv5ciBsse5+9Iv9RcGqvMQB9WwCrC2FsaYcYxF2m6xDtNncEdhAxpyAK22PAr8UqnwNnca/3/vW7z/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV8hAcIp2hPILLEe+OnpQWRH80r74XwvgKxVdqXO/00=;
 b=caFfVD9MjOYhdCDR5HxO4y7d0Fm6CCGlqGxPI2OwxwSh2qH2SshAVC7uF4qBOpKsIuerBvc2dTDvEsx8TG3tHFoTeRQTkRrIq7ifKhmqmeXB03pBLJ2PZEXNWGFtcYqRRCOITLS/MAD4Z+Yp0IUtqs3nT/cCRwL/+gVoiUlrBsdXpXs7WcNcETbOtzRRP6aHwQimz1tiJ6oO85rInkOW3sk9a2ga4NZlpqLPol0wyHztYAQyNiM9QoALL6+VWqsVw8IJJ6s5vbn4tZ8KOfwkutI6AlTz3fIu+gR3DbZk8WPZyoUWS407ED4eypfTUe75JN627P73Gibmgzm5JQqUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV8hAcIp2hPILLEe+OnpQWRH80r74XwvgKxVdqXO/00=;
 b=YYL8mnMsocoB99IxrgNpwwqhwuCUpI0ZEqttv6d6uM2XspmCgLt3a0mav1FzeN4nTWsGcgOJSbZK/AUlf5qoOUTie+a67yjuRTz/YIjylch+XFw+Q9N5jj6Nj6MvcY5//oFZlaUD/lQkDh8gUscNNST673d/zDChA7uUPTOj9+bkFQ0ckxJIL3cQVt9yPWLQMK3OPPIMKDEyCVKU8sfkEOGFMnaQiDJU8LH83WHEXHqar6YmKRjtR7RLwZZH7Cxf1lvx0qNjbNbd39J5SjWmWVD+GjkCiGgg3p/5H4AtTjjaOjEnfg74SermBrx/KitItu8CU75zbEZY2aUCK79Ztg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:32:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:32:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 26/27] mptcp: add userspace pm addr entry refcount
Date: Sat, 18 Nov 2023 22:28:41 +0800
Message-Id: <6101c6615b2d7225352d17158ed1e3c4a3dd46bc.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 723525b1-6e2d-421a-41e9-08dbe84324be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gYKmPuAEnNHRLhcLmoZrogke5kKi0zA+tif59R4gwUkF2+9+ba24jGnxQTWf8TRJLwvmrb7kmOyfC+uX+he+eY16iIPRkLsJr6oQfu+J4nAdn7R+ncvQcz/y4V576W1QhQESC+9Myyj5LiSjIpTZsTk2m3gipDXObcMRnD0Adz1c/U9BMAhMr53s6JgYmTS+7qYayrDNMb5LqP3JStWnFAWNYUTWh6A7P4n5TeUl0fTQZmfibNsoEKMF0CT1iqluddFIaOuy9PoROaQr4YQ6pL4EH9SG5PC72/ONJyzKl3HKZvJk6bBcofYYDB+nUqHbwHrO+y2L2wr0+vUoq4btogIhRt3/vQ8lG3BK7sFsJu5glgZqrQrgSGfpws7fRIWj5LK+LQvq0whK1iLZYk7eNjPGoEpstYH1DwQTQc5G5zU78M3gk9xhSLdZZaT15oglJpJ/kp2sOycAU+IsIWIcPy29LyUJBkXKwivlK1JV/dxoeDu9Y1tQcQt/elNenVk8LH3qcS1Cfcs9csiIS5ArJB+cRmtB6s181Wvmy3BgD10QPuMlZ8Y7n15PnS0uTrP6PkGocfEyEtTwFtzkjID+GYlREoi5e7OhoZ+MHP959Ak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(6916009)(316002)(4326008)(66476007)(8936002)(8676002)(6666004)(478600001)(6486002)(966005)(41300700001)(36756003)(5660300002)(86362001)(44832011)(2906002)(38100700002)(2616005)(107886003)(26005)(6506007)(6512007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ubrX9Wqum4Yr5dAijlOFi+IFiDEc+4/aT0ZfpiPLIR+G3LcSzLuq3xQlAGfo?=
 =?us-ascii?Q?i6kHPHGPocxANK6yxAGKrveBvCPIh9xFFKj6b+pfpqiJUQWSPVISSkZlfTJz?=
 =?us-ascii?Q?WafsOfu+CdpVBFrqlvo8MOy7vKQUNvHPjdRXstV93Bha/7GO4TivCcC6Lbij?=
 =?us-ascii?Q?9S69I28QMEqXz7ASIdVzkMQbiOQx0rs4fFQxoLCdwJZKiIMfaVReFYMxlI0V?=
 =?us-ascii?Q?5YNS6xMcFK9jjBniX3cp0aoPxGujXrpLbegOJJsNff/jR5TVWem4/5ck8tY8?=
 =?us-ascii?Q?qRIaiUOhd3eJtgyw9blSFC6bq847SG9AgvDTTTcdacKFdyqb15IGd7F+t8IL?=
 =?us-ascii?Q?GehHPobYCPkQOqQ/TCArV1Y8L8D1fTlxgmpA0TuTmnnDURlPAHyC86gT9XQC?=
 =?us-ascii?Q?sTUWLi90RhXsWidU91r1gUn8y5RtxmwA9GSMeFHF/fzqtsGnZ0z77tiWrBOA?=
 =?us-ascii?Q?BTuRCnSUHr3/5aFmbzk6liSHc5C0Si+0v+PFUnb4enwzlMW2ZOM/BFO1obfs?=
 =?us-ascii?Q?g04882XFX4Ae92fplfc0Yz72vL67DQDo1Hu64tGcA2DvtQpnqR8eq0htXguh?=
 =?us-ascii?Q?XoJMFolU55IZnGPvEnxtIk2qdu8rdC4G72UTtVrNEiQmcY5FztD9SUyaNhs9?=
 =?us-ascii?Q?hCZ5pr3KFkW6oSyhYRNdERWhwYncgzw3PXsd+1Ru24g0LQO1BLTeezzGfFYv?=
 =?us-ascii?Q?t/zirh/R4wZQWcs8n3ey8eQo++vymYCpnlG4k4TrBUMBWxdLY8Jra04XtZcz?=
 =?us-ascii?Q?tDVv58h1rtJ4NmcjHdovHE7hp4a/aPJEU6RGd8D+mpB2/Kij1WmP9EoXJj3p?=
 =?us-ascii?Q?GgpVXa9R1flga+alz9ikD+FqGFHMYDf7Zpide8tPtFWaL4djjRP9+t/ZqlkO?=
 =?us-ascii?Q?t9T7O1gotcvPhbPH6bOd0ZXdt8eN6n2Nji8QIsnV2jVzh1Etc17VJFL47BdC?=
 =?us-ascii?Q?Fi/LHzv+AoZ/IHjlNqX327J6d8Hn1wvOH3gih7ranxnbUlCiQrV1br9ndyTM?=
 =?us-ascii?Q?D7GFrvS2cRK+JpZPypi6l6OtJCbwx7daGsHXBPgvjJVcj1H97jl9rfvn2YZ8?=
 =?us-ascii?Q?acdKi/Ush6MF2NGE8xAjPkTQaX3uDCOsg28EDpPFhFeGsTUdnAIrBkyij6P+?=
 =?us-ascii?Q?r68HYdPaK8cpa83a0bKuQ4Ruv5MasYIOrlJpSYlUZA1aOEVfZVil5but8JcI?=
 =?us-ascii?Q?OI7+PUSxWk8TDn7JMB+C6DHy14j/l08KAeZxstqZ3tkMK/5PJ8SvIGU/LK1g?=
 =?us-ascii?Q?OKmrFMEY3zZr3F/11hEljKW2oVmzvQUZVTapHKWaXKVEZWZ4ltvGzMC4hLBt?=
 =?us-ascii?Q?9N0gtI3UPF5KH7zvinV1IAbspmSUcfs1LSPt2OwMxU1MkDRGkwzOgWD9EEHq?=
 =?us-ascii?Q?wJNJ4LMG6EzygKrrK9cd7sx+a4HMpyLlBVPlMYalrGvKeBWHynsB/uHHL6Ps?=
 =?us-ascii?Q?N6mMcDmw7D5ue4/uNHEi/HBtTmePtAUyinFodUo87kAQp9rEACrylP6ywu82?=
 =?us-ascii?Q?5I8NRFw1Om0SlyQMQJO2+QKowQoOPa9GtXTs4ccXDmEemsV8gzBROpoTZlCR?=
 =?us-ascii?Q?97dyX7ZTdxrKdyJiOzsaQ04OAcNZ67BJag+OA3RAs2OAe4yX6mj0w2rtOIgf?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723525b1-6e2d-421a-41e9-08dbe84324be
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:32:08.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHwWY7vLUXjak5tYwgV6nA25CbzcptqGpdU7bgwe4/WxOKmCDj0ixaieNK8PKhEquGH1leeFTbr7jolWzcTRrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

This patch adds the refcount of addree entry in userspace PM. Add a new
counter 'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter when an address is announced or a subflow is created
in mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(). And
decrease it when an address is removed or a subflow is closed in
mptcp_pm_nl_remove_doit() and mptcp_userspace_pm_delete_local_addr(). If
the counter reaches to 1, free this entry.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8879792ffa7a..ef1babcdf651 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -84,6 +84,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -109,12 +110,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -215,6 +215,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -320,8 +325,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -407,10 +414,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 02ae42135072..e2b71fc62603 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

