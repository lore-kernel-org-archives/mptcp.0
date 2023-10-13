Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FE5698
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IhpQwl9t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKq3VdWIOr0C2phcY1+P7sFLKNF4O1AG4FseVnZ0MH4O7qRuYE6BFJ2g6PM1mABvAP4rj/dh5tnMXAd5Tzb2YZo4EZh/KsbSlFeSAZK0/Xxz+Y7ulY9S2MPjyOZFryvP5xxEkANDsF3pleDnuAbgZSUuj6e4t5F2jVJYVARJKqQPwbrgJHAGg6fQ8IgJZktTrg7lg+eosmFyA08zrFNy5ZdHW8tIm7xWkoLmIsVrq3lITXWZq56OzmQX2kAiArsmhFseb989Yx/OILXRy6y/9eFKyuIp4yXnYyzM+JMWA7zjpnvgsNiSTFEWgAueQn9WPEz30GhNNgDJ/8c3BtYHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=gThB1F4jO8bbKiK5IYK/eWMn00q+WeNOipEaHMykgV1U9zNPs53wQcYQcZmD6024RusDF7291BqxrAH9rQvJjXOh4Dz0l1/pQ+vmEODhCLzUGJZecpcXQmJjgNBYR7NUkqIfY3/Cnph8M10blZQ6WtLjmkVwyGJcg9Qipqx7H9pPZmNZY1FkLgsjZzLhRlgNHeEa7BM2Z7d8rBr3z3p72zAIcVBmKvxQPYhQ1519qOnHEqLxMc+fvZQsbG97/oGgqL1lTWTR+Uy8hIyNDFUStMKgMNiLGEku/GWtv3P3CDLGdNCmSUAlFrL/vRqKyDwBB1cyZ9MV2JWMcKgFvQhaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=IhpQwl9tndNhRVs5NhOl3uCQw3i/IMkspi0GRF7xBsatYBiyCN1YUBO4zuy/I4AnxfhSfPGegkjF0X0jy1NK1/pitOGkzU7zmhy/cet7KQ1BKPGF7PjGFW+0LtyZmD9UZES3OO3QuVvL30XtTRAyzGt+UlIXD5Jp+W8sYqrTbUNYRQ7HrsjlNg55Pq8ewse9ReBOSnQ5h9K0XODrtEUZfuI25wHW+vIcZvps2EyvpDsywzhRwlWdwt4VqtD+H1naYf5sajbqSN5U+v0T79ujmgaBJGXdF9T1fFc4V97rcva8t/XTLFk3TrXQkUrOSn0XmSNi6DED4r9r9Vz/qm5ueg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:46:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:46:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 6/8] mptcp: userspace pm send RM_ADDR for ID 0
Date: Fri, 13 Oct 2023 13:46:41 +0800
Message-Id: <6a4513bb54923a767664b3b63abcac26152dbcbc.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc7a67e-ed73-4fca-df8a-08dbcbafbab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c9+PzD7Yah0388qWqefkJkaCuWLkwzJiP3QSWhYbnEY578szWEx8cZzUtpTX4EU52t/HAJkarqj5qCeKClCvhEQwJGP1r821w/3f1iKP53WA1daZs3cEHqB8DbhwJQoXBYi4ayoeIJizwR0J8WJolSY19i7ZEyZ8lZVxiTxtG18YDi+IR6/HTveIPFp0LzmOrFxgIVRiRxm4ffCoMVJveXCT4BDUgtyWajOkBMFbtbBEkSRCRwcIEQIgFYEf8Xj1VKrNUIWogitItcpakBofPmdvE2pB+PjRJ4VUW/dx7W3DW6/ZGlX8VBoyz2eaS0ywURxdhjdYo5y5cnpb8UPLE0ASenSK0PYV5LQPyzKVlsuh7sTgtazYqnHL+ctRG7njINN5ZNHBifokElUKRHbi/++qBvhtNNVrLU5I4tA6pk3QQ55gl2LYLkXAS5vpTM5vBiB4HqbngI3jsKDEFjj/hr4BAFw/vaenHMoliG/5dMWlVjVFNA1qCFqxvrR+L1hGlGiaJUwXFgeEbMrjK+gKxXTm9XvZc66eWJccaO6wWozFYEETGl0U67swkicu+BtrbLaZZ61CqaJnXOlEP2NirhwFiJDDbZqVoXAIVYR9drg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(966005)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(107886003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2FV+EF4DWBbdcTFoxoLkuPXl0Gi6mJVo3UL+/YMMpX9YiElNg2nPXW953D27?=
 =?us-ascii?Q?emxd0GOiWNbzqQOmL6caQQwhtxBl4hcDYqpMPorjokqWOQ3PEX00SZVaMA3k?=
 =?us-ascii?Q?IN04hz5xpAyybrBmjGqsDoXBsdhkwAZ+XnymwF76ZCOHgPEcVb/F4YwvpTBZ?=
 =?us-ascii?Q?XPrNty24PdE6cToA+hVxx8ICDCQ6uqtZqubyg91SnUnbj+iHd35c/fmLyLKC?=
 =?us-ascii?Q?ESxXZBxjgP1ffWpqvKo0bDuNuCe2rysOomXxQ6Y2jMnt85iR3jPaqgTwzQ2A?=
 =?us-ascii?Q?UOu4+7Ph1T00TZhjwZO8HGxbJW3Mc4+WjuLlceDPEuBuninRP7FzbGHkDe75?=
 =?us-ascii?Q?2UUWm+7cicf/CQkDQCTxYrvyqvCWgAqo0xyAWkf6gZKgDzUVOVAw2hkt1vVM?=
 =?us-ascii?Q?GLWmiBy9Z6DLOdCeFLp0Em4Cfrzby3MkiHSWw5bz+HXRbFsJV6t3R2phURh7?=
 =?us-ascii?Q?y2gFxAkdzNexsR113vg0ooNR4TEsTCiShWBWkTBA9aiwkvp5oHhA+HjFYXPH?=
 =?us-ascii?Q?pYP/fHvq7PiTnvLrPLjwE+ii95R39FSLeRLdz185otiLKQ+Cz3lQFeSoiH5P?=
 =?us-ascii?Q?OQtrW91GRS836CYkFWtdXsAZcOd7IU2lCOH89oaZ8MTedgZBJa2KqyylvW8B?=
 =?us-ascii?Q?cinJVzT+GUdroLy46CgFWAax6g1IOkwz40fw3VPfskzkqMIgO30wFC00NAtx?=
 =?us-ascii?Q?vf/S5Lf5qBk4wXUZIt1/dMAfEGGEyrL7FiW5pMF+zNhFGKjCfp+7oW/hPR1+?=
 =?us-ascii?Q?VCwEq2AUrrzsevYMS2p/QERCz2NMUHP8Jzr4kZ/QkF7gvrpV3F+E4ayVPg4+?=
 =?us-ascii?Q?7xVdEniKFkqiopHuPScLQlkvcv3M32pN3vBCVJ5QHP9aeVRgsRQXluqRX3OA?=
 =?us-ascii?Q?ePRJOVYLfgXSBdK24gEHObdoZG2LLV2hCdb3VgtSKRgnKY9nLyG5L1iO4QmD?=
 =?us-ascii?Q?QQf5qCmo2d6M+RtDdV0PzPDfTQz8jCb9lnmZCA/q/RoV2VHSI4yOeFdJrm8t?=
 =?us-ascii?Q?IcvSum51BjAZ6sNm7bmNRufSbMYbsdjj0/UVx8Rft+/fTmRffb0Rfxsj23r7?=
 =?us-ascii?Q?2VcaoYqpSrv4KAOrDmxcMcz3OFAzgwUevoyovoVWPB1sk7kwUjVlz67qSGep?=
 =?us-ascii?Q?G3LRkTix0R2UMvHf4A7/M3awqRBMmZ9Go7P+Bz+dRI+j80Sf4Nh590tmxyVF?=
 =?us-ascii?Q?/FBfuqpkpd7Is/S6BwkTv9MhCxAyjlvJRRyFFzFRN4gFlabhvYDw1dynfITn?=
 =?us-ascii?Q?Sc0JMgLivG9++pZiz/SQQmccQnSvbyndPK3JkGR/mupOPoiwlQEVwEDGjWa8?=
 =?us-ascii?Q?Z4z88quVWwNWIHDM5wVQPfC7PmU5t/pEbkJ5oQh4FY/sE9+KpUehFvkITtAA?=
 =?us-ascii?Q?lI/Opc5oUdskhiEQl85OqbB1Dz42pBIomec+dtaywN4ye8sP/ixqTTDALFuu?=
 =?us-ascii?Q?VkEAkad/nJEOykpfGBkpbd4kKV6aQhlbSoJ6gEjqsuLYb2JpZ7q051lInDW0?=
 =?us-ascii?Q?qe+XSsTN5m1WLYJO6+RefxLA8qHavRk+Pz4ptRfC4XE01LqqhWFUekFdVsoI?=
 =?us-ascii?Q?fUowF0fEK/RHNWv1rOkNEVia8DzOkp6+To7pvU0Ls2iGu4eslKGTHTsda/VY?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc7a67e-ed73-4fca-df8a-08dbcbafbab6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:46:21.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wtm1yb47+B2TM7/h6ojgmMkMH+7PMSLuw5StO5Xx75vfoz6ENFtKImW75T/3ghvE0sIIOVnIYskykxAL7vPVfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6b8083650bc1..ea50e694125d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,40 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->local_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto remove_err;
+	}
+
+	list.ids[list.nr++] = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	err = 0;
+
+remove_err:
+	release_sock(sk);
+	return err;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +279,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0) {
+		err = mptcp_userspace_remove_id_zero_address(msk, info);
+		goto remove_err;
+	}
+
 	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

