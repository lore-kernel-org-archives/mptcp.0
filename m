Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8A196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CpMKyU98"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfAPyOI911bO+GHt3b4VkuYcmRjfFoWvDBYyDf/3hM4Qd/DoCLJe/Zqq139uiv7jaHcOo41dljohfiOVsNv/Rczy2AhHtxVO2SV3yyb6ZPU6Eptx9zaLSmWayP/AMgSmZFsGyoi77sLll+juHZh0gzh431ceF/uxOnNl1gUHsGHt8Q8ueDKhK0SOfsjniGpgnT/J4Z/8Pmcnhw82jUJe4sKQmDr/NPftoMtWnKjt477e2Fa5vglj/usvKdEv/+qUIUrkmhp/MjhATcKaZ9Gzo7pfpRtV5KZvkyK+TWaTf3LFqIf+AjLC/KvdxS76Qo6XomofEll3asS/pHh/JB99xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxLCnnePJd5c2Mf3PYEBR/TkDVQQytjznxYO6+wVpF8=;
 b=O+5MXsaxoyEMZhNlWHSlhJVJu70oWJsc81lvWX2NaoW4zJXmF+C7W+JlUz4h/9PiwiS1QnQVI/ycu3OU1+AnzEmSJwDerMW6VgWon4M3HHRjbwU5PQZR8By5fZzZXRnrvU8tNJbdKSc3MFgyhiuUpH8VxmM4WcsqDjY1XGthw6QgVar+xcw6to+5O5LbSIqZreeDxp4hnMBGnSGthr5dyM0D+K+ynp5pZjiHQHOUcSrhNRzyHCRYPO7mEtYQUXnv+XKWdBD7RhajNbCRelHEbzF+sgRGTc+BygZDwrPDWdbFeRHAaLKdvLiW3UT1dKWNRmn0oN5Btm7Hhu8R8EDKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxLCnnePJd5c2Mf3PYEBR/TkDVQQytjznxYO6+wVpF8=;
 b=CpMKyU98X8mOHhiCN8YdCaCj47jc8fL0EvuB3n8kDNYG7nrf4SjG7VfewZM47SnLr0xPjM7FLsMW9Y85CfpRf5+37yZCdpJxtooMBuO9o3jD9C1lLV3FiAHUcKrLOsViiUtKIugfhjtfSMqy/1RbGewcl4DDLx7L4keOl76hzziApmVmu8p8aMqXMivuZelwGB0YLVZ0EO67MAwTeHKW6AF8eSQLFsnOigqNuTWyjGwzHR/OYBYDHJb8vE+3FzrqEXBWcD05C3TmAw/rSrvF6+n1NAtk8dz4r59JG/KDjO8fLDQtdmsWSVPUxAP3NWFslorFscF1HJl1AjBVK5tojA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9174.eurprd04.prod.outlook.com (2603:10a6:20b:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 08/10] mptcp: add userspace pm addr entry refcount
Date: Sat,  4 Nov 2023 08:26:32 +0800
Message-Id: <fdf4fbce13728bd2bec64f156770d929f1080b64.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 901ccca1-19ab-4aea-3612-08dbdccd0696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2Q/nEYEGoHZdix0NgTTC/3T1mNgHOWg+rsAQvyDykfjT5itRids8+sdiEESwalAv8Sqz0s26tPQPWlTK7BsV7fVqlsrYf9Q60a4lzdahrOS8CM3ahZJ9nYDzGE3QkYjnJpy3WMVS6PEaAzpcyigBWDolALkUzPD+1IpnQdfAs1GkhXWOqcUpeFu5TUSOzSeKBsLIhrK1i3MKt9JeiZanD44A6+hBx4LLjuwhS23DKyj5o1D0ffk5oV6/V/qVNkWRqg++yFi8dpZNl86NIS6pamhAlUWCg11Edyqov7DJbbWSJVVlWaCtG2aUdHztOe6Qkx7ThVb02M2uzhsPWMRNEgMmtCQ1174jZOuP9ShK6V0liIDem4wgEtq7jt12e5eG3t2Z1bpYnMF8gK/EVdTxwfteO+rmclXnAMFRhAnKGaim2f7Zk82Mdm4KT1mFB9kXmiDOoId44u7WVmS/xfx2kniWEl5xvM5iNpE9/7s2gbjLygldD7Z5lConDCz3F/Oa701dsvax1Qj9lk049JhTvGRoE0cTpvn57RM3fgyCwZIJEwYMAVv4RXo3M55qMx0R9z7zU5MozK3fQ7KltLGh7uDeFj2UL1MrZWcrNazsmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(107886003)(6506007)(26005)(2616005)(6512007)(86362001)(36756003)(38100700002)(83380400001)(8676002)(316002)(8936002)(6916009)(478600001)(966005)(4326008)(5660300002)(2906002)(66476007)(6486002)(66556008)(66946007)(6666004)(44832011)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcjwZ/H4yaRQaS9qlCZS2VLDAC12vx3N6CewcHwqt5E1AXf8Kxzy+ihhmyjL?=
 =?us-ascii?Q?2rtzxJtrIIZ9KBBRLNCma115MPGyj0UUGzYON5ROyfUO1cZtxrxhoLpxTQcM?=
 =?us-ascii?Q?K985Jgs/EPQVRR/GGYXi4d53cVQsR+CBb5Var4TE1u/lZLdPL964bubQV48A?=
 =?us-ascii?Q?f8fbRVjIkR4sGhTgml3Mn4BPZVUilyplFKVtiqwns3TTav3YP077qWptgouK?=
 =?us-ascii?Q?BQ6nBO/6+EQZOwKKA+rSJAxd0PCdq21yb4CRC2sxgLOULTmG15P4CXM2c83n?=
 =?us-ascii?Q?REizKraafWq5VpfuiCGCR+C2rUK5Qeen23sV812XDFywoWIPXGuUNxo6N/+f?=
 =?us-ascii?Q?hzVtfgY+o1O+hR2WJke6sNG/hnVNnWGD2QKmhn3La3n5EOLo4616q0QdhCix?=
 =?us-ascii?Q?DvoeQq3/4Ap0519vGFoUobNJ8XGfVS2pb0kn/+/DPQ45yc+mPy+ya4OICkzz?=
 =?us-ascii?Q?2UgGTLJjii4bEYeLqmv65q9LSTVoCOdblG9T6BhTe0p3Cut00WMGbjsl3OTR?=
 =?us-ascii?Q?pyl/+kBQjkIfviF/xFQW9Sl2scFs/UoO1u9NCmXkujl20Tr2Ysy2WWg0ITl0?=
 =?us-ascii?Q?xMYTYKspXr6TAdoIinSJ6wpc/44xzzg/zIuCSQC2NYSrkieUy3hS5o9nyQiJ?=
 =?us-ascii?Q?k40XtAK+PxUFtRxE6SWx/SMfikpt1p1zMgRtInS5yG8ITNsvCae0ieaowP5x?=
 =?us-ascii?Q?dsfWUvo5Jjswv5Af05rG4ELksXiaT6HREwzQ2pUJfZDqI5Znut+PUHvw/ZDU?=
 =?us-ascii?Q?M7b2CXl2umzUrBr1nKgpUJ3fLBjcdl/sLBDmDPKlhQ+CdPlRySaiuwstdhyK?=
 =?us-ascii?Q?RnkeISc90+o2Uityf0yo5r/dnfOsJb2TIhyPIV9k/xBUDnHIL+ut0+cjvwwb?=
 =?us-ascii?Q?TOFRJWRsxt8xrzNtEpkt1/bHjHEoQFaieCZUjb+1tvYmtJZxt9+msisGEbPH?=
 =?us-ascii?Q?g/c1RSYX/03i1vyi0Lfu6r30AXtQ6DsAMisIFDdjmF2SZZ/SaWI1krwGGaix?=
 =?us-ascii?Q?feAiabhHGUJUCY4Q/XDl/5qOxHR799AuOPWiW1aw57wCdRK2PeWIhoUSoQ1X?=
 =?us-ascii?Q?KwjeDoBJeiNH4uenk3hzuYQKG8Y0HdVklumDUTUZuszYwhfKdjLCISIOhs85?=
 =?us-ascii?Q?Nn1WolC0lR7fELY/Ob8nu5uGW67CHr0EHfubglPuAIy+gFEGCBFOb97JUn0B?=
 =?us-ascii?Q?thakGbfgJ+Tn6TBURDhyiAL7ppIeD2311RFd1JgpZ9sC54+Vwwu+eMSdeuGB?=
 =?us-ascii?Q?FhHv3QfC9KFPdOTsjQr0r+o9Y87SbC8jmP/fqwhK6HT3CaDrKL036z6JRwJn?=
 =?us-ascii?Q?/Ws5gwkE1xw1NHqUfSCds+aPoO8B2hMicinCjI5p9kbueFaupPIKuuZqDb9I?=
 =?us-ascii?Q?i81EAZBA7JX9Yb6BrBBHLJbSdYBMDHnyxwwN+1tAFfIU2f/HkmRXsABnPXtI?=
 =?us-ascii?Q?qja6gNvvtcCYqWgfQ2P5QS0g+7t6RZH31xNo3+TI+wadMZj7MoRV6veSuZrZ?=
 =?us-ascii?Q?17ic7Va+C8hKzc2M7fAPeD1pAsu7dXdfSfmOP+N8gMPWjEy9ugybYJPkIP6D?=
 =?us-ascii?Q?S5sIKOlUzE5dw1t9As69PMeeyGmZJB1ebbUB3VKWM1NoP++R3dwDurSE3yQV?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901ccca1-19ab-4aea-3612-08dbdccd0696
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:54.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6B7evl4QPleNP8v6GA+1LzawDKEE3tiXKY7Gtv9nzuFB+oPwOZKqZh4NPv0Zme9YkuZn8i/4R6oYDCLFeESmiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9174

This patch adds userspace PM address entry refcount. Add a new filed
'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3ad4e6044a97..5ca6ed172fc5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -91,6 +91,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -114,12 +115,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false);
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
 
@@ -213,6 +213,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -318,8 +323,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -404,10 +411,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6e8ca3d453b3..112cbefd0521 100644
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

