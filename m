Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4A812
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE2SQxA7i1ZB1qGYMbAIERoQYTx20b1HmLeR7xMBxu2SXP6OZp6paFwPCc7diimwJRWnqnP3lnj416Au/d028bvZPNHi7sEMtP2LNKQAbAryoeazQRRocaBV/msa9xkYOk6LVV3TSZYI7KXyc4FttaP1YIHMqxcqYrJ/QqAUnBRzUM8AJFwuE6xoVXMVpDqM0RkifG2OzeAB0/sl0tznrLWuw1u9vWhGJETDhN9d4BeQFOr7kML5WhR9Q+9PiUqx7wRf0hb+rJX80ryjFnLi1ipNPleBWV6TPOx2rIQKRAwjw2l/oel6oQCu2O5Ndxaz4xB2AOrStViJwo4drp5tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdNycxW+pwVBmux5uxIP+qwySMSm8SkQ/Sd7XaYaBXA=;
 b=jx6mzerTjQUpEiUwMNVnN1I2uLFUDdwLg7Pg1GbABD4xex69J9RGsMji7ztPtXNPYamIe1MyBmFMoDNAX7wXE9crIC9qPbGClWRhUpVgCnaA4YybSJLepWlF3rSn1E/O47li8Tb0g+KhBpHWeirTzNmPSogfbf/G9F/5rHDtuOZvOQJGBg+xfiJ5XttJfWHkRVX497weOZWXu+qyyX1U8vnsJ205LLBE5Up5mnMck7FYMrMXO0wF8AJcF6j6fzbmEbGZXFWtwGDhd7qSugfsmpK1Lfb6mD2zG4gaJCThSbeVHe5kfRAGLykV2knwZKYrjaIFfx/dyxHDfI1C7ns/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdNycxW+pwVBmux5uxIP+qwySMSm8SkQ/Sd7XaYaBXA=;
 b=zZCjXqFjrcRepYxnB09dGrFVrkt1vOzwxGa8UPFZ/KeMg19uCQIrWlGDZccif7+Epx9HFy2kb6jLcok1dG3ulmlFSJRUzEn/Vi4Ft2idI91qr1LoEfhVtQxvbx65EZLNo8Y5XxKrEZoCCQKYR90FVb72e0ag1rTUXR6U/Z5ikV2IRweGTA+29W9L3jTUq4xaho+fTHeRj/cgOjAYoSpGKMZXiMAuxfGZO8RtHcFgsTKooTx4HJ78uCYpxMDZvH5ulstSRw+AeK6jbbeHdRW0vZiqtRc1X/7omBAbwUGCWHr9T4IQmPEpEVOpTkrARsfbk5vv+5wk49vhExY63TBKjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:14:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:14:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/6] mptcp: userspace pm remove id 0 address
Date: Fri, 18 Aug 2023 15:12:04 +0800
Message-Id: <3c3c0bdd3e0d8fe5be8701e38f39ce1fd3e20d3c.1692342519.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692342519.git.geliang.tang@suse.com>
References: <cover.1692342519.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 916ab50a-2bb4-4739-2fb3-08db9fbab806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k/McjOKs/8i3PMI/ZfD4qDIK89hkn9KOOGRv1QhEV3V9FFaoUjhR53r3NaRN2Oa8vNaV0ZqMKClwP1IayPSLJNlRo9FGKSDS3osk3Px2ZR2LZNTuLq/bIZRjyH90/uipUEQWW12UkzOLNQEmphgfY+UZ+XOHY5uzm77GvgoAqHh2f1JMpzbDi6AuFDrGe6n9o7QHwviYjeZ3T1z5T9iPzmFUihRQDjOgP/E+ELO/DQsgxx1hshNx8Sa+sAV1JrP3QkOSZYC79KGREtYm1kHmB6X8gqE2QKv7RdeGD5e7NyLZyWE0W1+gfBsSmbwgePB16kI/plqH9z+Iq8RQhVL2yHFOgvtBI2vguaDR5uDaKxzJ8FZxpBZFaMlpH2Obns6Sct12re+xiD3X7tjSrWFIWvlsTlKOmccbX7tJlyhpuQ+WV4Cq28eqyHADUQoD1WE2NQOf5u1SRvXmkzz2GlqtTx66nvtoNQvnwjea3p1jO/+QUaj0ZWaCGeIr3jnP3yzXAIPU8M4kod/0ON9+wBHpBkQWhhGNSHjCgnDMloaSMNrHejo48OhGJlPP6KzYrvv5UBSVQ8MrnW+zs9rCiLFdnmUmPTt/UTUuG7Z2uJxt4O8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(966005)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?48a7zipi4wIEuJALuG2Xm5DvfS7mii7YNARx0Rx35bdnsnqR1Kr3L9526VRQ?=
 =?us-ascii?Q?osVTovcyJ4Bd5j6B89JPA3PlmzYcPwfyaRadQXwEu3Wl2bY3lxbgj1Eqgvzp?=
 =?us-ascii?Q?ubpLb1yF7ayblZxgz60isTWVzQxsCSBKp/VCJTHMWZga2EkeP0VhTEUbSDxv?=
 =?us-ascii?Q?od6/qe5GfhfxpGuE4rs5Ej+BSYEWnALABODLgIgesyjgIhIYxquXI8K9i1GE?=
 =?us-ascii?Q?+8eCFmQQDw7bJ5+EPwHNHx7Wm0TA+IRAL/Vnw+UbhK6z6x1gchwwfbYwxBZR?=
 =?us-ascii?Q?xoSUSkBCEfceDNqkzIJ7+mbljHVJ9KJrC9haYUjTpxncq9x5GqXKVzWWgv2G?=
 =?us-ascii?Q?016e1E5poyh/yIuJH6w0Ny5hzSv1rD72a5x1slSXHmoInoDV64MRF958T2dI?=
 =?us-ascii?Q?b//i+7uH+5ju4xV21WLbOLgdH/zfU9mtTHn0tI3W8Cn2dnDSP1xOjQclBTdo?=
 =?us-ascii?Q?ZuJMcqvSnlozUpyO+aWQiFqGCI+jRcFUi/B04Bm7hDvldH7AZC0vKXlkU8mL?=
 =?us-ascii?Q?9TZZ3jRQC/WOhoaqRsxyFKwVP/3j4W9BaUSL74wvpLsswY3FzFx9DDqZ7yrx?=
 =?us-ascii?Q?fJrKVMEIljbEHcXMz8VHCVKl+E7j0sjOts+zAUgB58Io04FTnURlBqPpuTHA?=
 =?us-ascii?Q?6630E3tqeNp1GZjOHiQEOjnOZZuOXkvKdxDhKTWysLgoqxBebFjOTB+6EsJQ?=
 =?us-ascii?Q?K4zULP8JvSraxWIFjzNMhNDvjWqgJSCq8tApOoSkoBF8pGdl3dHc5ep4kwHZ?=
 =?us-ascii?Q?E+KAe95+QfDCAg4/iR54JF4+TwyYVAMHnsqvAdOc5LJ9kHlnNCdhAOnZJhvy?=
 =?us-ascii?Q?RMFbEVx42Z58UvLdRBwKJbY+IZMstdGdkU/Da6ON4lNFcMRQhs8McvZN5Dm8?=
 =?us-ascii?Q?Wk4owKkMIHh4zXRUwBp+fYn3+KKc95Ar1I633lFTUqFqVr7Xy2IhBZZZqJMB?=
 =?us-ascii?Q?q8NbJXOIH+uTc5LjdTLGoXcai/VQGj02h42i10YqnyKitmnbXGmcSPmgEMfE?=
 =?us-ascii?Q?9azcu6wLHNGmNlyJnD5sisFibzTv4YwWP3oF8BnodENF8KU105gR0RadG3rr?=
 =?us-ascii?Q?CuYIHZtLYt9QDpAhmJbf0dqPDPH//FiGchlmXzEnPanShCXW5U+kr1cCqePF?=
 =?us-ascii?Q?3LXSf1OPTGxa0MKXg5saLRIa9C4B+OJnxi7Eyj54FDEojj/NjAOvv4cUBN8X?=
 =?us-ascii?Q?IvDnioE2YAdSAxZMvlpDQLD578LuFDiW6bvp3Bd2H0LI5vvPZ83PYHCltc+a?=
 =?us-ascii?Q?ul8TKA03ZvXDB2gfx5kXsZxBddvEoeOOcRSuyHrByRs1ZcEiMXjMDDW/OBNp?=
 =?us-ascii?Q?4Rn++JaRVuvdOI3fSO+vpmR51byciTGcTaZVS7As+Gqnd8UFbPr6vXRTQfAd?=
 =?us-ascii?Q?+whU+ZOrO3Riw7+fMTiAx2WT96zh1PSVO+Z+krIiql13tzpHLfYZ3kz/4SDc?=
 =?us-ascii?Q?9aE9W181D90FavEAJXBvsgAjNB7R/rIBoQJJKntMXa+jKiW6CxIjetY+CIHL?=
 =?us-ascii?Q?6fW3dqjvlFHSeDCnM57hGoM8tZNc1bIvDvtT9qhXcGU4oNC2aS58F6QYdp9q?=
 =?us-ascii?Q?8FJYINThSIaw6eXoxmhCKuk8ZgKZrEybmThf0SL3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ab50a-2bb4-4739-2fb3-08db9fbab806
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:14:10.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLwhdNYBPz7RWuz1FTVx1QpE8uT3/4R3Fk9FOPq314KKtdf2UQcT3jvkmcCpsffbTCb7xx+9aBlP3cZcWuubAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

This patch adds the ability to send RM_ADDR for local ID 0. Put id 0
into a removing list, pass it to mptcp_pm_remove_addr() to remove id
0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..059b672b55f7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -236,7 +236,43 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
+	}
+
+	if (id_val == 0) {
+		struct mptcp_rm_list list = { .nr = 0 };
+		struct mptcp_subflow_context *subflow;
+		bool has_id_0 = false;
+
+		if (!READ_ONCE(msk->first)) {
+			GENL_SET_ERR_MSG(info, "no subflow in conn_list");
+			goto out;
+		}
+
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_for_each_subflow(msk, subflow) {
+			if (subflow->remote_id == 0) {
+				has_id_0 = true;
+				break;
+			}
+		}
+		spin_unlock_bh(&msk->pm.lock);
+
+		if (!has_id_0) {
+			GENL_SET_ERR_MSG(info, "address with id 0 not found");
+			goto out;
+		}
+
+		list.ids[list.nr++] = 0;
+
+		lock_sock((struct sock *)msk);
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &list);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock((struct sock *)msk);
+
+		err = 0;
+		goto out;
 	}
 
 	lock_sock((struct sock *)msk);
@@ -251,7 +287,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock((struct sock *)msk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -265,7 +301,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put((struct sock *)msk);
 	return err;
 }
-- 
2.35.3

