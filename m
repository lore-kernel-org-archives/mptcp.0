Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911D28E2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GILz6YPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiZ0RnHddHaVxoWq2bRbwGgUjUy8ZjAGpup8Y2oxwzopP5gcVUEx0EjdWHay3Xi0eWGNZ5xIxKjSfmuEbJvnI3F45Q9T03VnFUlHtb4zlP/4Ui2rNOlomE1YG4xt6jvlOvJMadY7tXfRgXZFc6qPLw2EED28k5TNZVCzHZh5FHh1tPoJitYmSIwvAy83wpsTrLZzRE9zu2gU75YCRn+WDfbVzZOiPTEzpVvCKjexQik2yB7CqEFdwpo15t9YsNwaWfjA2cx+WROQrblUj8yHvC5tsFvrs6b8l18p5FrpH6Dat2C1//kf2Y3x1ZMqeIwdrTYl4eGBwFs4xLWWgvn+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaOiJpN8/A10of1uj1J4n4Tyw9AEpH9fjhLnvT8bhEM=;
 b=HuyaSViXIlimCaiRr7bs74x+DZ8Ju16trhVeVXM7nl1Cq9/yY4bfnfjtgbLJFDo+ZNxZMfG4TYFdBA6gAWS5XJMCDr28B21Ey8944JLHWuIOubAhzvvya9BoL6vmQIWxDYsWQMp/shU0HJL4lZy3yzi8XxwAYOFnRaGo8hmZwFI/fMwcrYCrlhB3enwwYM5hxVe3pzcF/wG6Y8m9PcbA0nUVVVlXn2Mxl7y1TPpW7NpiQqlY5YLk0JI9cRi8eWmfWqLE8NApQpsX4yqt4+Vo4QA5l/VYc5tiqDF28qPYdmgLsXRbfIiP9DUtv13dTIQnkZ9fRKh8IWeQz0Nirdy59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaOiJpN8/A10of1uj1J4n4Tyw9AEpH9fjhLnvT8bhEM=;
 b=GILz6YPoeSxEfQpM8wFM9LHau2Q0p5CHYbeZtglmshGCBeUS52Kgf82t4SLJGHb4awors8Qao58ysVcNFpYKNW7968r4v1hzYEZ2K+mVNC3sgdscrbmRdy+WWD437Cdh2hcgpZRW8sX8ceAAJ+TWZWOpgYrLVj9Mx+2g+VxjfVRtwGWpahSCOMET96S5VCWuD3y+eD6/qmS449g9zGgmfUKsQ7rtuoHjB7D+/5Jklcu7H9aCeWy2fnowAaIAz5iikP586A9GZUnLTiKIHYzAdTcl0pntnVPG8xE2jOVFeQd8kZF8UfE6/2fc52IV6E21h6/T2IkQalfcrkO3ukmk3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 09/20] mptcp: check userspace pm subflow flag
Date: Tue,  7 Nov 2023 16:14:15 +0800
Message-Id: <ea5e1f6adbbb6d2faedbd07c5527d6e5b573c8a5.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1874b0-23e7-472f-6907-08dbdf69b0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d6ucbWAuvt6XO7LQbDbL4TCkajtYnI4wSBbo/h7YUSOusUY3eUITl4J00URlhC9CqGFrRUwUns9GbSqKq3X4f+mt4SJnPycF2ra6rYdLgI8mDfMOujwlbpexrWun6YeNGeb2KJ65yBU8Chm8Meki9jO6ECJgIslZU6PMRGE0cG7r3K1xpSyhrzWa0vGtD0mI7OcZIWLgzwlUSkAtfc2pgDmuyZFJl8WyOZGBJefQtugxrDXSAS/Rb5Sq+UfqfkU+ow8UYPdOyRSa5wbOo8fP96GgeaAggY8hxgCw7BA5jnsbZPwEZ4/Jj3z55N5wcW5GFdT5r0JqmUjgIlL6zykE8IFH1ASXi13TN7DUUvjYTyUIP/yXRvuOTqenuZxdsrKlPigPXEq/P2UARJoQG0tAvdt8LpWfEi2xaPsYssHu11PpHIb9RBapTQWPSdK7jTrk3P2XueNliYhC7aAmxRzaIsRKzZ3ufmoJEsctaCtFFGl9X9MVdDHwUowdlOrFnYovGHldsAeB/JQBgiE6P1eEyGquULggsEkFQRAYToGTVtcfcW5KxRINFXhjOPwJuW2W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISinpJFIHls62w/k5WQ1Ro0ou/KIp9p+fz7VF6l6M7b6SPrGks5LiKl4Lmb9?=
 =?us-ascii?Q?cMLv0j6qW9brVVe5rfux+7+mRvxiI7kBZ4E8mCYLS9gjLtsX4RtzTO1UR/Aq?=
 =?us-ascii?Q?T++/+vV7KqwqVtvQzM3Em9rSc+rL4hEy3mT6JP6KiSc7BZVCspL8Ez1ee55K?=
 =?us-ascii?Q?or3q5ZTaIlFxjDMZPFwcuX8OuttzCAvhx+JuKuj0gXN7et40rP6MDD0PDM/2?=
 =?us-ascii?Q?pkFoxZxCDNNpAHY3pEA9dw8kiCvqEGbVmm7CrIRtS79Vm7LpROo9vrUeOXav?=
 =?us-ascii?Q?lESvkasvVIR/dIZeCf3l8FwOT8wy649orhjDezUUsu3xigHWv7VqNdgUVpZb?=
 =?us-ascii?Q?WIIf9Ab1CjqDL2+8r6o39bV5yC6H6P2okhamgHzi4gStG1jtdP7GdwMs7SV9?=
 =?us-ascii?Q?hpV+rdZdQVhe7Jy5bEdaV2llqrNLA2FlZBb0zpzsBqPlStuoPRlLWkP9iu6S?=
 =?us-ascii?Q?t18PKujLLvkkMGTXpla6Jk27dz0Wb7MI4dJiRUDA1S0mdEGeusml7oBr7LdM?=
 =?us-ascii?Q?Lrl8OmTAWR9DlTvFOheCQ/MGHmnZoRr8/wJlvcGuFB6SBEfaN9YPXuq1uhPl?=
 =?us-ascii?Q?ISFdmVsdV3hdYWBF3fyTZehuP5Oe+rmQLNmLkXFQttt8bXP4S+KvqE6YKCPL?=
 =?us-ascii?Q?RuJRL/PW3b4fmWPSZxCPEIahs2qDLD5/tZtbOlatOgwFOYQp7iTnHXTqmXHR?=
 =?us-ascii?Q?jJ7Lv2V5xyXp3+btfmNk1kyUrC+YCj/auLGzNI99+yMnOWmINDog8v1fzmyh?=
 =?us-ascii?Q?S/GprGoB0tlGi9yxXTGrqEsvwpjPcYuSLXumlnquOL1GZDLfoTp8dTQOthv3?=
 =?us-ascii?Q?eJy7XrCoWF9GbNNT7SG1k/AtmvX+PODyU5t93lKXdBMU9T9JacBhssO0whT8?=
 =?us-ascii?Q?9CyyXlSbgrP9D8GGHu4AeNgpu4peKkyfh/j/ShRRM3DBw3wKQNMC/75Qytl4?=
 =?us-ascii?Q?bpAllTqDfFnOlidqrwOgNZrGbTuQmtDYQDK2EkkkcZAmb+DiQHUAPvSEbIE5?=
 =?us-ascii?Q?bcMsDNWu/Iw5ycl2gTzmBJ4Rc166oRXS+o1E8quoU/pVI9SJrGGrUuwPHYA8?=
 =?us-ascii?Q?6pheIt4lh5Q/Nn2tXPAYk4NKlXwejksH6vEhHdUGahrl53TBSQRWOSBVNDyf?=
 =?us-ascii?Q?R15lGnSxZw57Jtyb34klWbhBYOuBhSU/9ymLHqvpppWmGZu6HJV2bIDsLvBe?=
 =?us-ascii?Q?p2BZstDlRzLf5/ubiq3Df1Cd3pKcx8hjyvFgjWt4U5609D/Gw2JLV3K7AOH3?=
 =?us-ascii?Q?kImcg8CObRoTus+Vtc9PtuAUfYSuObyNYdogTkFteXhT3zL+WgdiGQCRh3pr?=
 =?us-ascii?Q?Npdmxp0eEEzIeIPiSbcvnWqAcTNJ4ZzNTuQG6Z8kHLgZtXWCSTe8vf9fJTEp?=
 =?us-ascii?Q?u9cujyQAYTQ86+ZZTThvNDDNhFSxYncxC0JsdOtqCAftDsXnWOxjgDlv9cCm?=
 =?us-ascii?Q?vB5di4LCs47T459G2Iu+a/u3HME9SRqtIkSzNgF2bc9v/bGL0y6iH5jQn0tG?=
 =?us-ascii?Q?ww3VFbdS4KlAWL0dht7juc8KwJRDj2aETJyeduNpHkmv3Ms2tjn/vuusT8o6?=
 =?us-ascii?Q?BL1sajlcsSgaqf0EmwqADhquOP2+4EjgwwYMFFhd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1874b0-23e7-472f-6907-08dbdf69b0a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:23.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9upcIIp1g8AewiR4dtRMZqTAUEz1fBqd7QclrWZ1yFr0ZibPWnsITPnAgbMS/AK9c4KcGeszz99pA/gbdhgHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bd491b78171c..75ab4d7b9f3d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -349,12 +349,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	addr_l = local.addr;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -367,7 +374,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3

