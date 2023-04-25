Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE397B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1HNjfNhyLjg0Yprjc1jPDRdd1nq82U27T5kvaOlk8Og2xC/CTiMz2NWt68PC2wvwABZZoOiMa2jsDFwgnhjQ28JCDamXcRGje/rXf04QXHtNqOLLzvcsjHAvKvmuu9p9yB9CtmYirlwnzZXKUHFUL9U/P3vho3JzTrYMBHjMKF2t2BM/nT3rqoy/ZAp6h8jl7InV5jMmIhpufy9H+8mBS12UmyZ8uOXij6B1MzCpDUYExeJ47hKwhwlKh3oIbc9BijDTYU+INpImuJ3vVpFUzU450OWa+zxAB/VwVt3Z/qu3eboGxpN+P75RUaeXZSN1lEU4M1QCGURS7FuAY0Lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnXvE+3+GZKc9VwgNzabo/RtGn7ViFGOSq9gIpeOp7k=;
 b=Fmx2jCOZIIB0kea2bTp2jNLrKkz2kLuOfj0D6DOoHusVDi3UcbS8FkWh1BpCZXNk/L3lQ+Vh44iEqcAHWeNq9rB3wI25dKvBS0cAnAp4iiL1lcyHKaDb9PaAqfTofAbXxM7JNodq2j1lvQjfPKvXyV/1jm7bj2PlmWvNoBLNszsnecxlWuLLA1Itu3ThCrpFVSHvQYOan6lkaZZHktSjO02UR6c8CxiRfDss/5hmaeth7itD1IZPLr93+30Vp7ZG0mvmGRomuf828s/RTflKAL2BZX2XJtBJiEUIdSHQezIe52vjHiy51TpMNfUXOfK9miI/hTfJ/PQXZaxcS/HkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnXvE+3+GZKc9VwgNzabo/RtGn7ViFGOSq9gIpeOp7k=;
 b=aqZdaL+S2mbCXQ96RnN/u1dydAfoUjN9dtL35j6DVni+eOEs3HlK11cSRyWwTztuEpjCpdBhFnjq03hRgyOGImxlGXr9Hc2clNELlw6d9ZVNkNttPlmoU0zENqwBzdZYcRUCmaTQV/fDWqEGpCD44EjIIbRNxmF1z0M6n1qZ1HGqcXejW3YZXrJJ0jmi6+9hzPzOS7iGRc7+jMPs2NS9kO+zyAz2b4ED0f9/okOly2dqLnv+OTiZCkprDS7UFKBCs0SoFKOxvQWSfb5yYlHWFXroHFwLQO2T2qshvJaJH5tLdSmaiYLqUULZ61/5U2B5PjNrJsHZ6FBOzNHuMc/8oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 07:55:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:55:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/6] mptcp: only send RM_ADDR in nl_cmd_remove
Date: Tue, 25 Apr 2023 15:55:06 +0800
Message-Id: <51353fdd885e07dd2335320d605ea7c70195ba7b.1682409247.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682409247.git.geliang.tang@suse.com>
References: <cover.1682409247.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 320628ac-4c67-4b23-2187-08db45627337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cXew6WaFS4RFWEyreksYxdtlvWVVveszi66xa0sYV9X/puT+B4W0CZA2+rdSFuLr98E9O3Zi+ikdqsMwTXpoJz73SJJFTq/NontbhGspQbG0jBfvguNLpRrY9Lz/PEKc9JjmvFChrPMzCNQJXAA0gIXFL1iS8ivHQzw7S7SHQh9BZ6199mzJlWr6NyC06FF4GsdWE3HgsNwf52SVhbo2bjU8OYHjnjaYb8tzIjlD+BYt2Wf1pZz/yrjvl5HOPGQ4GpbtLb8JuCKCAFC7p6teGYZI62D9Pun10iXwe4a4pxFdYMzls5d57BQtREFmAGXlmh4154nEFcvl7FjaI3JxMK5Bg21D8+Q5ld/hGE2bzFClp2LRA29yqRrPjg0P1mG1eU3WDbHOnCj9XmXq8OTOdF0Oa3GgxUEtNyLqZSA0OtgpbbQN6QDCbQWDbFXBy7dzMdd9Rgcl0yJr0JuU9dcp44FX1aEmSZ/6GzigPvSN+oV+S7ECg2+E8jYR2nTIi5IVm9efDttwZAyrvTXdMShLpSFJhrHcqY5PZSIQoL9SvXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(38100700002)(966005)(6486002)(107886003)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(316002)(44832011)(4326008)(66556008)(66946007)(66476007)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ip2nrVlTuwZXFlf5Eckmjq1iA2eD9WkhVLD3J10KbUPi6iBZ7g1igCOHAPwE?=
 =?us-ascii?Q?tBMLgO4cNjJSaHGaCO665l36wVVmG/3yOlhl9MSqu78bR+pL8WbxEWJRtkNL?=
 =?us-ascii?Q?Tqwmpja3hHtohNOo3DFa6LIbDioH3oYUm8Ro0DNs5vSCtFgoXEiw47/L+5DG?=
 =?us-ascii?Q?1R7g5Ha5N5zYznEBBLn2ctpon7ADitb5Fwtqipurtu+nfX5gFKipPLJ+CPNP?=
 =?us-ascii?Q?NC/FbPQrLMX8yJMIgBprfBMqbI673ryKz/k/62jjt8NQjWBJECC85vwWalK8?=
 =?us-ascii?Q?xp/BFqfs3u4G8BHEU1cKWA/qwOMEZQk1xrQxD6JkP2zoiv3aTQ+qJ0R1lTlC?=
 =?us-ascii?Q?hlzspjnZtYm2HzaIWxJmrw6V66HAdNOi7an1RukX0R3wRyde99BwpxXH9ZZ1?=
 =?us-ascii?Q?v4ysgPrdRiWQo8qLZX9MGXqGwxrFLE4EJ5GUS3SttsKwmbNQIuvwuN/CCKyx?=
 =?us-ascii?Q?YT54lCEbsWrQtMDT88bh6NyojYKpLQeTW7nuBnF8XfMn6tCbXOgryR0+PX9k?=
 =?us-ascii?Q?YO07KwzTHzHwB5ZthfV3sOqkqJ9TMB9MeawHsb9kYXLznyBPkBXU32ocQXYn?=
 =?us-ascii?Q?5qcVtqam6m7JcOMbDTaYHsyawCeSpMeB2kqLBvKDonAzvFqrXfftGlnJjrhe?=
 =?us-ascii?Q?zim/fjUEhIC1qopSBMQI45guK5mKMpRYjRFk1f705G4npHjjTCVJHCvsEbWT?=
 =?us-ascii?Q?j2ONMdg2i1HuGEN5JzKKGqVAbsYLw0StXj0S1v2Yq9Yce/pTemJimloqdECP?=
 =?us-ascii?Q?wWtAm/3HJFV1xssSp0AwcEGy1vSFYQCADLSi3u6vubw3gJ/p1LuepFqBqG+I?=
 =?us-ascii?Q?GljMtTkYkRsFdwcetF9MLi8n8ktI6rT2t9RehsXFpDFfIxRAtc3scsj8AnFZ?=
 =?us-ascii?Q?973DVF/8Nz6wUk/xSRFn3QWjCUl1/278CcM2hyPY0GG1bI4MGCCZWf8birEC?=
 =?us-ascii?Q?iQZV+iBaKQc9OtIO8tJooakWnNTzELK5wksu7tx47zDh+Ft3C17upkOnvofJ?=
 =?us-ascii?Q?rLXPmXykLSmr79DOf7BEjTXRkOqsurXb82oOlf0QBWhEt9ILWeTKr21ObnLS?=
 =?us-ascii?Q?qIm00JBb50HHp+At1e7JJQGYxe1k329LAAwpdqan6jnM65XQy1qQ27zkzLE2?=
 =?us-ascii?Q?lqYE3zwC81c/79wBBmQbSx+V8rUAh63Bb/L5fsoqPa8+xdsW9Q7CJs7sAy5f?=
 =?us-ascii?Q?pLMsNvykvJbnQzjDCqsqisGPTV+Tf3LhRPLCHS8n66k4Tv/S8wbQq7Q1Iwb9?=
 =?us-ascii?Q?t73U2xyHW8DUrelZFCpgOixUZpC2mAYqAxQCnzAJUo2j0Okdmcz14CvKdEuX?=
 =?us-ascii?Q?FQXdegrFrPa4NZM87qwLeqawODdsaQa9F1+egPoBRNR8jod1UJUDHzUixH9h?=
 =?us-ascii?Q?gqafK3jU3EZR8HPMxWYf2hJU1UJmMchwZnQpR8tpG8uPVDlPZ67zyk+GYgqD?=
 =?us-ascii?Q?FyMkNoUy9AUm2/f57tSDQI+Wkf+NATSqzJcgrsT6oOWXyMEsdgA/ZdDXb0fQ?=
 =?us-ascii?Q?6Jky3O7PpPaoNoeoYphYxhBkhFErjjcBrTOhhEeYmSHTLQiDKbdtSQY+o0xO?=
 =?us-ascii?Q?hl+zT4qR1gDZGihFpdxTT5um9xsqDrCAdfhpExQH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320628ac-4c67-4b23-2187-08db45627337
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:55:34.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glO0i8J7xXOLYNrE9xBXgszr3E50boDtzWhVRr8qXX3xDDJ/G1nC6awsR1wliGwopcuYOtBmFB59lndrGDF/5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

The specifications from [1] about the "REMOVE" command say:

    Announce that an address has been lost to the peer

It was then only supposed to send a RM_ADDR and not trying to delete
associated subflows.

A new helper mptcp_pm_remove_addrs() is then introduced to do just
that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
subflows.

To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
command, see mptcp_nl_cmd_sf_destroy().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h
[1]
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 16 ++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..d85649bc27e2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,22 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX) {
+			alist.ids[alist.nr++] = entry->addr.id;
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_remove_addr(msk, &alist);
+			spin_unlock_bh(&msk->pm.lock);
+		}
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..6beadea8c67d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c39e172c95db..1a2772902e9d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-- 
2.35.3

