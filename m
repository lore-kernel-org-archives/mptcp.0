Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888111E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9C1ExX4+bsO3VK6q9JTr6oC6Zix5njFNezuoud8b92h2s2ZcSVNfM3vxiJk6ArnzzZ/CIAmBcme5gjkU46D7Gd7YQ4tMXEtBsfW9HIjFjDXFMB6/neMyXCZsuJlmhhNxqQIP7sI3UW7MXiP0ImCBgrufCE3RU0K1sWT54h3yaJXU9VG8xGaNQmjXpReD4qwbZwEb0T48GcO6LTV3hv/HZDid2mROa1FiF+p/XTcxkAIkXFtN0JRe+0ZEedR30dZ+YAKjMTkKqyd3gUYBu3na9TRxQdo45H/xHWyWGDjb37J+1OvEl3fiG7DpKeriYIGKPBrvyalaLbOm0k/HenQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gqB2+TMZxH37Us2AAssP3wgEKnwPbuxyhn19wpD/hk=;
 b=GwMLQ/2HtHIR7p1k++ODm+UMmAkAMxSQ6uy1XSZp/Gqn4QuRY+wAMuivG3xnV5yIsPH5hyLSIen+3uvkdI11RIsSmvie2W0P/nPTkJAnuIvXtKUxpB5ENtl0801AfzkmkFOsDUyT3sjlKqtHuoI9WF3O28j8V3JfQ83xDYZU5EZfH4xy7Mgi309evvdpdq3xZ35glmWsHdkVPpVEh/I8HggK+lCA3zccRjH8pyING1sSS+rHbjyFyUPhusNzt4zSYVDTPE9npa9CqEvQ9pO+YOglOvsOOG3j17SUSuaQ90Ksy9gETri+8wS/5zP6toPyu2PppjFSk3d7+cxv7EbBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gqB2+TMZxH37Us2AAssP3wgEKnwPbuxyhn19wpD/hk=;
 b=ch3R9Qeb4Ci95N8WWSNznjXPeJPXq+FXWt28RRiO0eHT0SwldUxoXOZxpUSxu/Fr41+FNHaby+gjwIaK9EK07eJPWMAe3/9M386YahRU0nT5yqB4126yS75FbLxaP2RkhfnA4UeKzsSlzSuBZYAgsZY5e132Dj0wXOYyk72StG0w8lSjWp4PdUhk+9hdKMnXTOGuImKmwOZpTEg7VR7nCQwuQtzWpDJppwKHJTZvHrYW33UEdUhPOIw0XKxptoWsu0L3z17R6H/IytECdBZPHN/CJo1JTbovJw6RuS8uTVg+4UDBamAshRLl0IdYbstzRraY+g0k9Uy3KTxWSttQcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Thu, 10 Aug
 2023 14:10:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 02/11] Squash to "mptcp: add scheduler wrappers"
Date: Thu, 10 Aug 2023 22:09:54 +0800
Message-Id: <6a3c391f8d6193b37a013947d708123b7e4cc987.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: cda6ef6a-8b0c-4445-5015-08db99ab810f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DByvE743FN32SBTgqYOkHz53PGuODC4MgZIY7mPimQlybKlfc7kHQ1XmptacCZ5K3jcLDVRNvPvnD1ZQ4TpwUvPqQTqN1cwyQ+g5fECfebJ21y29FAa06kwF+NmpY1+SmQs88ne3RZXCpVsPrIWhaMwTKtMAh9GHesBJf/Xxt/O11Z7rXLV6M5pmNoaSqO+n3wXK/AdtGkAoDBdbwdBVU72jNEXtCb1uQsHUdVVqDnYP5kMYRXdAVU2o+oJaVJLj9d2HphHbJdtXnjgdnj4MUC3mA50LY42OxU00UC1iB5fDKtfcRlq6fj/hTeNj26R0ifHCUA4kRBEK6mLLLqJtXLQfOz9R+nJGu3kXs8ZJa1BdgiHdRXTcl/KeqMfR6CfwS8bviHXFK+54F3bffOF5EidljPyrKWpaQKkM7bhYogjWwekhWfS0NIqnFWoTZBH3w2PEoYwRwkh0NGPxR/kV8WOFhtftl9alOownG0RH7EqzBEp24gAGHeAK96/SS9XYd0K3HdysJsZY82g2wvQzwTdDX9XexsPszXf9b0BZ33DlyD9RW6I7WJZEx6JwViQ//z61meofNJokyaSt6Uls8IdSMZpEGKJXueiSO+bHptM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(186006)(1800799006)(2616005)(6506007)(6916009)(36756003)(4326008)(6512007)(316002)(86362001)(38100700002)(478600001)(66946007)(6666004)(66476007)(6486002)(66556008)(26005)(107886003)(8936002)(41300700001)(8676002)(2906002)(44832011)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXBlLmZ+iWGby1KGsUyooIioy5mpC+vkK/o5liYWTcdGZETLtTzticfNQpRZ?=
 =?us-ascii?Q?IOxwN9kK5jhaE11PwYBkypC4FGfUySdBthO7fvxagwgXzd0dPI7Ug79OJNt6?=
 =?us-ascii?Q?sXvCJcTbKekvLj+JZxfsGF8GEu9G+iQ0AYsWz6bCvZ6cxDFkMlQ6zp9UDviI?=
 =?us-ascii?Q?rzYMeDmEc3414PEBJpad/CtXcRVOP5slkJhM9ShXULAp2AKABe5Sen1kRiLn?=
 =?us-ascii?Q?LqzOZf5sKRMluueFytuF9zEMYcdD/6nUYFN7RzG/JoeUgSKMamLmKompWFyn?=
 =?us-ascii?Q?bhYXGoxdennA5ZukxI+fetQf8TyfQ9YmhHXtgacTbyOKOJZLeDTYIk7AZBt+?=
 =?us-ascii?Q?K8aagXzwfzHk6IosxqTqVJxNxDg3Er3At3pQ0TFYsd/3Zq8kaoHWGhCYADj4?=
 =?us-ascii?Q?2HhB4To0OTziuAuGiWGnyCzKemcS2DI3DlQCyz4zGqHmFWianUFpgnO6/4B5?=
 =?us-ascii?Q?STWh0lxJc0afq6dNGO+c7YsuSWy+E0PUIkOzvw4FOMWtgFxJ6g0WV5/qH0Lo?=
 =?us-ascii?Q?VwhLoqcyIwITExZIi2vKgatnP2OmRyAFlqwO5++QbOQKluR8qEBl1xR2YU10?=
 =?us-ascii?Q?1xtuqNfF13kzi5MbKjlrjOdLgdmzszHc0EXP9CwcflDYypEVLeMOGDuc5NVY?=
 =?us-ascii?Q?nY2Ydhdn5dfl0StEN02gGdq2XctbYSE+BJeHIgcuaKInuzLkZ4t7MQqNFSrH?=
 =?us-ascii?Q?zD5QWgkZjJpmzW7ktjqp6zKyaabAg3BGvV36Xb6eQFZo1FJU0oVEK+S63wjX?=
 =?us-ascii?Q?44DbtIZMWsSb8Cw0g4TGXziKUXCQDWv6Tkb5aI5N0lfiLAwwuiI7uIs1+VGK?=
 =?us-ascii?Q?nOtvNyN1Dw5XsgjvYevdicZZtfexxs+t4KjeNbn2mmo0BlWB5SGTuOzYS72n?=
 =?us-ascii?Q?mdvDwR7ISMJXNT3j2Tc0SVxoc2+MVHAn2raVeBqcCUtHVohYzV/0MDqcWkRV?=
 =?us-ascii?Q?IpD9qt85j0Qp55io+lEnK0ens54jbYVx4BNH5swBPnsQbbINRVcYyqTU0MhC?=
 =?us-ascii?Q?cyEv0xlQB5BcGFHoHf3IVT0uur9b2Fk2b73KNZPwGTWh92PvZBzL0tfpz61f?=
 =?us-ascii?Q?Pgg3M9Dlm6s1JkVYM9vIsaq+Uk8+hJg2jYgKDBtsVq4sWdj+7UdtQnozDESr?=
 =?us-ascii?Q?szhtwinWkMAc9Im0lvMUSpySXkN0izzxeLFHE2mLBnjRO/LviXFv0rv0nmXH?=
 =?us-ascii?Q?+BLcw6NxS91jjlwAxEpnDOHiUeHtgtJpY+47lZLjq/dDl4/K47ZOcLnqw1a7?=
 =?us-ascii?Q?SV2h+Pb3NCMuJGvaDAz/aI4CHfqNzX/ELSr+yKGbQ1aaXH4bl53yIPJTbIJJ?=
 =?us-ascii?Q?p5HASgpyBUKhpTbmTfQraX46MER214cMt9LRbXJHHcVRigtvLljKrfP74CVT?=
 =?us-ascii?Q?RP1Y3RBxl2ETgi90r1GzOLIvZHTm2nyFkNubwcdpOkWXDxRWtbQ4EhMc0oz1?=
 =?us-ascii?Q?JbG6gyO9ZycBtF/dxja+G3m70l23D1Ko9kFvDU4i2eZStvTblsW4iiICTNH+?=
 =?us-ascii?Q?IC6dHgxKxMTfghWrxCMD1tQ2AjyGbnsDDwpeEWqyU91FX4v8dx+8+8NFsZn2?=
 =?us-ascii?Q?fsEXHpXgWj4VKDUIZ1aS0Ry7UHWeeajlnMM1c9i8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda6ef6a-8b0c-4445-5015-08db99ab810f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:08.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/YPupjLOTYJhbsts/j0lQPm7j/FLZiT2IOcLBs8sP6KDlxbjJjqFcTUXyyqKDVwJNcc0NHgsEzqfW/Gc1Hi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993

Add mptcp_get_snd_burst and mptcp_set_snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4572f01b978d..8c382384090b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -673,6 +673,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_get_snd_burst(struct mptcp_sock *msk);
+int mptcp_set_snd_burst(struct mptcp_sock *msk, int burst);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5d78efc9c96c..e96f69762071 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -229,3 +229,35 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
+
+int mptcp_get_snd_burst(struct mptcp_sock *msk)
+{
+	if (!msk->sched)
+		return msk->snd_burst;
+
+	if (msk->sched->get_params) {
+		struct mptcp_sched_params params;
+
+		msk->sched->get_params(msk, &params);
+		return params.snd_burst;
+	}
+	return 0;
+}
+
+
+int mptcp_set_snd_burst(struct mptcp_sock *msk, int burst)
+{
+	if (!msk->sched) {
+		msk->snd_burst = burst;
+		return 0;
+	}
+
+	if (msk->sched->set_params) {
+		struct mptcp_sched_params params;
+
+		params.snd_burst = burst;
+		return msk->sched->set_params(msk, &params);
+	}
+	return 0;
+
+}
-- 
2.35.3

