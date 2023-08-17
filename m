Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DB1097B
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 14:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0QtzTqIQr0lsnPn7fp/kb08qm4fJ9O0FYIDVhOnf1G2LlIzY1XuXWpjRFNpupiDed9HjfSjpc8COlmh2dMB32LS36zalRfhTxIQctYl8Nf5kzCLLwA6CoMnSLSZrIVIX/W3b67YkSA9d3Y8BIaE8NnAQ3OiJPIx0WDGXzq6plESEbPz+/dIiq2WZm9GmTzgnCOJdHgdfBlQKlVJ/NYYFbJXrGwaI6h+E98SZqeztK/vVcU3SOiXEOiKYVfdZYS9WVSURJStdTPm63tc7FL9XVhvuUeYVrVLRQRMUogGYfKeRjvSgaeXs0DcewoTKrutBm8uNqXJyJFOd9lgHp1l4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5LHeiwnwU2nGaUg4INwQiGzgHITtq3HVxdyqzG9DlU=;
 b=JUys2n6w8mypGDdRWXbxgB4xw+ZehEk3Er63zDorIQ7p2YCya7iE1AFPUAUqilMoLd8/x8ymNtCu2jO328HxDSOTLAlanZCvd70/8AHrtHv5zREJsrfvsH73QbGXk4MnKI13gQZ8Oscmus6Z0ZVyzJtSpbTMpHnzJjqne/JIczNvUrD5kAYZF7b5R2QvwdxecQ1bCRlFj3vXK7/Nx9er5h/vtdN9ks731p8Kq9qdkqqRzxcMGktT4kTtWubmNAnokraNJH73C5zwDAO8GXRwAMaSD43UqVCP+Jqd8DVjgmVmPA+FDscZ8kZJtjAK4meW71DOvRZfCkCmyjb1ZBJFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5LHeiwnwU2nGaUg4INwQiGzgHITtq3HVxdyqzG9DlU=;
 b=3x+NNOX7yumZoFWVL2JkxbIcjpVSyT/4YrbbrhvsvkfysJj+QcuMd3/qfqqN/JEW3ki/9+hvreXKTkEXyFqtsXjJaWOto6KR9Bmk0RFRxiyHzQBRmmRQDZ2p7B3pChiHnguDWhwuze1Fm8+bs5kfvu9d9sJrDOe+z/KwylnAXd3K6aESBwIk4BdDyENN47D0qqzlP3e1n0TAMpRmIlvnPjbslZXM+5Q0TQsnGPJjx/bsNrCOnWYPDHQM9cIjiKpJJOjLGYWipxd+Tvxg2ROIl0oGEYA1p3qBJ4NavmZ0Q463orfP0VuYVw4iRvj/0+YzDG3PAC0hVUYLVCC4JhfTHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9057.eurprd04.prod.outlook.com (2603:10a6:102:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 14:10:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:10:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/3] mptcp: remove id 0 address
Date: Thu, 17 Aug 2023 22:10:48 +0800
Message-Id: <2a2600dd6642da6d29be1df8062f7bc8637155b2.1692281317.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692281317.git.geliang.tang@suse.com>
References: <cover.1692281317.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ae6926-ec3f-4326-f7f4-08db9f2bc417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PTfGJwrRQcPJZiozLnsI0DK9SvVOtDG/DDRfrcMFEFxfwUUwGormZ892VdZpaUbDYvLSi7c/+h0R/HihiCg0Mv8IKJl3yrrefth3Tc8RSdEclH5sBfpeqRzRfHd7baSfRKX2iWJaYVgQBhMKe6f48gEqlNiupP0NlWG4cRgW1qkiqmSYnK7lcwtoL5YTTIND4Tp4EyDvi25TuHi/R0z9Gq+Zz8F/BwTFUCVlARU6w333PAOdcqCwgPN89equrBcmBoZ8siyx5ANm0Rdcjj9mprNjYBaMNXBzYjm0p8GnfZo6QqhuTGytnFAkSMrzFmTr/lPoXsWSPw2sIoMixKISJz5BLPpptoN8hrzECAf9OpY6TVTTLdePHLBrBY9lg+XpmxQPgiDSsMTRG/K6Gjja1HPxKBOCEW7lbptiIKRKEXhzKNmTs8j3V4KKJboqqfD9dTAKuqZuT1xOdJHlFSnx5iUX9qfuBe44FENTBzN1Y7JAmjOCP0op+UfkrbO5aE4WQ3huuKRL9NB2tN2S0taXs3q/Dwi52i4UgLu3q1h/llWPhgQ5Gz7cq/OXJowsbkz+63k5VNT54g3YIYO0cRQV9cB24x3NePc4dpVB9OHaQ+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(36756003)(107886003)(6666004)(2616005)(6486002)(6512007)(966005)(44832011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CctSRJ5Reye/ZRt0MwW7aQflOWoZt88VU94nqraEovPfTLQDq9P5zYpbP0+v?=
 =?us-ascii?Q?QE5TAMOtfzDXepGSp5XCpijW50AGIxSowNgJTZLRH/qVSIURalAEHFcDSZIO?=
 =?us-ascii?Q?U+Vg2eRLQTGpv9v8V+hW6hLyr124srCA2dX1QIWnwa0bhbv9Ie82sr/Bi4zj?=
 =?us-ascii?Q?3AukYR79o2Pr/ZiFkoLBEwPa8/yMiQBliTwopQiDXhRzYNRyokRy8AS9XWoA?=
 =?us-ascii?Q?FRgM5kVaeuv6i0WzqZHh+iAOtT5BpE5lFeUWi5lPyviN/q75O8Atfyi5jEsD?=
 =?us-ascii?Q?GLlOwPV7IwWjWTPwdo9C25KFklVaY7VadJyJxfqWvnLa63cSlB4Z1yXa8vQ2?=
 =?us-ascii?Q?u9d94Z0SR8tzL9WjKbsDV17JVAgvSyQ7QACaxWj8F4yJDsHE4hCSY0tz65hx?=
 =?us-ascii?Q?4JvLJ+JUKNwW8eDQh49mqAo2ZR/gEnHJfpANAB+pbBmtQJC7RNAz1DtzFthM?=
 =?us-ascii?Q?P/x8rzZCVxBoQQ2bRLw5CI1zH9dbvgjkdLV05uf3oNndNUWQ+UdjPPo+MTug?=
 =?us-ascii?Q?yJ0Mb7ycPGzLxVQGo8bXSrpAic3l0ZBwtLGVEByWXeK9ChCKibReCssX+xqP?=
 =?us-ascii?Q?ttC58MtQGGShdvxlk8WdDoDbUt3ipvkXUJ94Tn/B5QocmrFC16076c8SDZQe?=
 =?us-ascii?Q?4l8YH8/rIyOSwefVwXn7r0eYNQf42U/VGYGON/tm0Q/ZnsxnxEryKcaLllC5?=
 =?us-ascii?Q?GtWVXRcp7XtXk1ieJItB6XdZjxJ1hciYcbZKOv7nGSc0zmvX8bRaNfQRTkuf?=
 =?us-ascii?Q?Jy/20R7bD6h2XgOfPiPMhrmrF9iBqCRWlYI1L1SY4xnwg62yi00eWpq7Dst9?=
 =?us-ascii?Q?ETrk7+GbFox6Tww1k8cpeubT6pH/mRtwkZGVFiGZ9wS/Ha3iFHiUSzFm942f?=
 =?us-ascii?Q?6+OZ2QmvFaWiGgiMMp/uybEOVTS+UUc7L1AjeW4ekTIJNyyMAJxPggU6doEz?=
 =?us-ascii?Q?rvVsdqy1+yga6W5YY1pvmIrKlNeTv9ea7SwqtxdpiJ1fNx/Ak4VKN7lPjAyX?=
 =?us-ascii?Q?hLu6bkJaJHK1N0qpb9irGt6Ty9RRBgfiQLkinA5X56OUbikNxTsj2/LYjb8P?=
 =?us-ascii?Q?rZ12XzcpNOrOUPoaObKRdc2FyHbFGDjtDLS1TzixeW6i3UTndBGB1rCrNCg1?=
 =?us-ascii?Q?+q1DBXt+JziWPFFB3/p0bmyj9C62wcFpFrkJV7iZhMz3TlxUeWgx9ep4512W?=
 =?us-ascii?Q?asJ3cPJG4qgeSZzl8BkDuvTnfLA3nTfz1/0B//AWZYhw5eGxbSzatuM+FSR2?=
 =?us-ascii?Q?WT8RcbjWL/zVzCzwegZfNpkRSINrwRMDK+LQDPe0F+mM1JAd7WzVA/Pkk5qT?=
 =?us-ascii?Q?vFnI1z/2N9iD77Ixb4mI2Jz0w/9OHjFyfeuiv5SD1hrmAqjRrGts7shB/uj3?=
 =?us-ascii?Q?soSs1uqFo5Rgl67G+CUU90KC/FN1nwJXWRekESR3LiPzB1dPYWyIlCkTJwMc?=
 =?us-ascii?Q?xeWCoPy91S+aOBVS8vZTOwoyQrk4Ry029NZU+2eGThizcCn7osNTHbkIgmzs?=
 =?us-ascii?Q?PKFzmX1q1no/aXOICM5X4893HJ0GEJfkiNvzszEIet84SloSI+Ta+q/Xw8rF?=
 =?us-ascii?Q?FOQV6nWVLWIgs5i0Fb1RAm9MMxr//KlTaSftTf0Y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ae6926-ec3f-4326-f7f4-08db9f2bc417
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:10:52.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4doHe+md/JWFA3Rir6MMvxzMlEOmLnfz4Z9bfYC3mf5parFCt/c0nq1czKk0Sx2YG0RFPDwZpH67totTc48vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9057

This patch adds the ability to send RM_ADDR for local ID 0. Put id 0
into a removing list, pass it to mptcp_pm_remove_addr() to remve id
0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses/subflows as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_userspace.c | 30 +++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d8da5374d9e1..6c610fb494ab 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -192,7 +192,7 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 
 	update_subflows = subflow->request_join || subflow->mp_join;
 	if (mptcp_pm_is_userspace(msk)) {
-		if (update_subflows) {
+		if (update_subflows || subflow->request_mptcp || subflow->mp_capable) {
 			spin_lock_bh(&pm->lock);
 			pm->subflows--;
 			spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..3e5ac4015c8e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -236,7 +236,31 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
+	}
+
+	if (id_val == 0) {
+		struct mptcp_rm_list list = { .nr = 0 };
+		struct mptcp_subflow_context *subflow;
+		int id_0 = 0;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (subflow->remote_id == 0)
+				id_0 = 1;
+		}
+		if (!id_0)
+			goto out;
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
@@ -251,7 +275,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock((struct sock *)msk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -265,7 +289,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put((struct sock *)msk);
 	return err;
 }
-- 
2.35.3

