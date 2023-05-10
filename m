Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02F808
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 04:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VACJLosx5NEO6B0AA5or1MCU1CmQofOcInuvGOPgWSoexNBVBB1HJwHxbGYX2kx0J4cu+NjNmqfBYnm83LX7bnAa0kT811RL6OgibQJM9AFJkza06j32h9DeUYHQ0hRCGb+RySIttFS448WlZEpZf5p72MdzvgpFXxT35yvACUKvceYiDdDzzZrhb1xRJNozWWaxFutABaa1xPcMcF3iAAc34UAjvpo/Vq3NppyvIwYnoRozCXI299CczaFJxEj7wojtvCOYEsz4ogd1wRR5eo3KGtHf++NlJshW/+HM2v0TBv/3Vf7nUszPyC0I39JSUke7Sc7x+lS+Z0w7UpdyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=UzdofFM8bsi1LLKXEKZbs3JjGofQ/XQ9PVRYdvrEK+EwYDr0ys6+nCelS1EYb5NOPyb7FzlsIk06XpRliNOwoars10vb86jOdnNbiLJYek61DkieouD1JR79k/uI4V+s5rv10EF590iPyjkUx0cTRG34yH6LA3UbmlebX0RnfpwE5zvdZF0mXB54BeGGfhhBEiFPmBDctHPmOxmsYIdsB7dt5j3AoygDsMl/hh2JHbGLD3GN4RW1nXBskDJ1fXlvtinELWAjxpjVuCXckFu4F5X0sxY6eTJ4HJk/iOWF1zuX6gnpSTt4ozfoNOyRrMhaHFOAGxzpBOInBPlLinzm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=UjezVn3hr12nTiJ26H+PNhBrmpaRnm0z1KC3IEb0nyHuXF5rSk289h7J4y8HBE9CuQz8uPraTtUm4Tk6yI4tzBxfrTzVrRjSnD+WjWMSiLRm3QBiUT7snu3IK7TEf2f7Fq7eWXGf+KLMdjH+pcQVrSCbJPrs2VtkR2+hMgUdvWSiQxuvyGhDYaNp5iBdpFUN74eqIBK1WSrtW5P+0+TGltxG1H1kQjLDMnChMkgG8UubSdFlJaq4vsQ32PzHaEtp2WPeNt/bmDmUbqV4kDepWgoQYtvVowwZda2D3PpdDqT2TLHxdW22DgB7X+MNX6i0uEAIHCSmr10Ue2XxbQohHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7146.eurprd04.prod.outlook.com (2603:10a6:10:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 04:20:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Wed, 10 May 2023
 04:20:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 1/5] mptcp: only send RM_ADDR in nl_cmd_remove
Date: Wed, 10 May 2023 12:20:08 +0800
Message-Id: <3b081bdc3ca6f35780d39f5a92b42f17a65b1b33.1683692137.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683692137.git.geliang.tang@suse.com>
References: <cover.1683692137.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:404:e2::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 42596847-b73c-40b9-c10d-08db510dd99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MyMGcR3YeH9S3xDlv7qPjivCCXe2+eBbcjN/Tpk8H1UkXqzl28nfG73y6MPTM4sBNNiMaY3fP+LDb2RPRqRWQpvcveIVSq/qbr8Fn5TYHSNb7HMYFO/1WZPUppNCzHpPyi9mev13O8HYkt0PAQ22bM5mWBR0nyIoBWbOWYzHt8Ut/N4Ma1IaJmifYnYNaxPl0taQQSnjFnmvMVN2E4o1O/eXg8nayYHvRxZOMp263WXAhYC28e0cvmFdbdvcfz1045C8csG6q2VhcyABR+/rfirRULKIdfX+ZBeWQ/e5Y/jukuSGYERiBR59H+EdJzsBVn6DUqbl5xjkABpT42zsvOfoqKHBtfqElZGku4mDq1ePHap/wbTrC/lico/DdqH51G+F5/eNMeozunpm1kMpCOo6Qc2HeW5xaqCxecXUg4imi2+dv3irCgXw41YPLfhvgQfuQ1U2e8+MfaQPDtTkJclwNZgo3qbcGOwNRvPxTgZwtaxeTN4GhVkbackHnXwdWyTxZN7io2nrvZ0SZZbMgZBF9AS+GySxmT4hGdseMJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(66946007)(4326008)(6486002)(6666004)(66476007)(66556008)(6916009)(316002)(966005)(86362001)(36756003)(83380400001)(2616005)(6506007)(107886003)(6512007)(26005)(5660300002)(2906002)(8676002)(44832011)(41300700001)(8936002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3bvFrOS0Rt12HpU5HLEnHNngVdKc8/mOPH+rrKC11572ZSyYmySQ6wCPDzGk?=
 =?us-ascii?Q?tTpXIZz6UM3S39FgCXXzlzjJU0wi2Rkl2aO2qkVVz7aYshkve4CPAIRlAF89?=
 =?us-ascii?Q?nF106WqTa7eMSbh5w+4B6QNc1wqch9Hh/bMxgcz4mLKhvRfnPqqmj+dd/Hcv?=
 =?us-ascii?Q?SmchiTiwtZoUL5zn0oVEJWe32LUjF+OjGnAJ+1GEBPq8gvGx4VInqYSzNDfX?=
 =?us-ascii?Q?H5kqJ13MnFNpbZRd0VNasjt9Y2tzbi5lM8lzcSEFa0KKTzn+ZhE2q8ezQslW?=
 =?us-ascii?Q?EVzqJjUq5ni8WJXC+913DP+HGiqiR2yhsz9nIzLcb8FXSOTLCK+9JAnmQpKh?=
 =?us-ascii?Q?5WDclqVjMK+lrLvf/c0yGHQgOp1CBMek0RZeHFlB7CMB5T/BEAkfENBfxPu0?=
 =?us-ascii?Q?SJ2/bDlMj4aYmBIGveNEGXlov1EjBj802AyHL7DQLZtbXiLACcq11vsBU4HK?=
 =?us-ascii?Q?DpXMOJnuOtKWpBYXqqKstrtLEpZUeg1vWJjONreJXhBdnQgFnnYko9kKS9O8?=
 =?us-ascii?Q?GiFPPy7f5jyefE6CkZszCTvWfSBHfyJq4yet8VH/x3bC4NFIyTgiXTInP+s8?=
 =?us-ascii?Q?xOahusxmWrh09FAliTahQ3L0FnnWjl0TCA6X1f4DlePplg+9Dq3r1lctIFOY?=
 =?us-ascii?Q?pP5RwL+VI9Sg9pGt6RonRmT+PplujNxSO1eZVwJHRUzU4hEY6Mv+1ZKo+vBO?=
 =?us-ascii?Q?ZFGSGtSrANvzNLqQExvJ08uOwk4prZhWyqABj+7E/MudG098wh/VaRHdgfba?=
 =?us-ascii?Q?BOUl+qr5LEM/r5QUoWQmfkvx5hMdgdVfP99ma3OHb5ox3P4yrFmd97qLAepg?=
 =?us-ascii?Q?adHysHzaVaa3Hd2gnqu3fjK1M2/rlZVwtHlwnlZSN65RijeJjuIUIzWdo7qs?=
 =?us-ascii?Q?haMJavURyWPZ5oeihvhUOqAWKtpbgd82jlluue9X5Mkv//c9NPQ4iqC7PFOv?=
 =?us-ascii?Q?Yifh6FrlcLYk75aYvyMOFUrHf/va+hKjnkiegoRoM6YPFBx0Ea/bhlVbdbr1?=
 =?us-ascii?Q?USgCpfEwQLGSyEhLU4oX1in5ZkfJGl6SnjpHAZ1WFq1zDukFFGfrNb39iCXJ?=
 =?us-ascii?Q?POpysLFGySCdImsddF0rbKl4shjhOThWl/Q7m+ME1zU57fvwr5E6JPh3Glz2?=
 =?us-ascii?Q?9hV2YqKcrCFuHsfs8LZIb+InLnAvoChn1kFGaEfdR69OLjEJkfqEsqHnsa5x?=
 =?us-ascii?Q?Tg2T4go7YR1cXSf55R3esMYrkj/wLaBJxbHeVNTKWkgp5SlSVRBIHbMG2pyn?=
 =?us-ascii?Q?Ga6k6UTfqt6eq12972m165ez+5xyRzQiXowUmPc34y/M+346d2yoJEKvD2WP?=
 =?us-ascii?Q?Ias1fKoR7M0RtwQyqkgmlbIVRxT6/p6vb1cjZQhDx1qJQnNK7I7gOuu9poKh?=
 =?us-ascii?Q?ik2zhyhuM6xmwdfDJDjc+iflm75ceWopPkO3PUn7pfmcuaboq4SszN8VZ6aE?=
 =?us-ascii?Q?680XRAp6vqalE7RZD6htjdSMITGzY3/8TsGq8yU4tkxM+V/t2FlKPh2Yzj/k?=
 =?us-ascii?Q?3C+Uy94alMB4c27JxfxmP9vxpEK6KSbMaBsYGcEmuj+oYdghN0jwvJ4sBgBv?=
 =?us-ascii?Q?S5PbKDnSyJCA79H4KeGhMWYGcyr0g2HxhRiWvzsX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42596847-b73c-40b9-c10d-08db510dd99d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:20:13.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuGAKfYdMrpG/2npb4lhNCDW11z4KOXJt8MbnTWsLhHI4xpMWwJbj3um3NZH5S+uiWDEBhvl7Rs5qtbdwwo7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7146

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
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..784145e6a314 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,24 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
+			alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
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

