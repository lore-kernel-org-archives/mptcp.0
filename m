Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A97F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndu2y0e8YQXE1Rr0WpVg/LkYzdpzgQTZVkZL3bjaWflXfwygrVSlqs0R+SUGp+f14vGG0VVorqxQbTDwBJXZDuhG95kSkQFKrCNXxxznYJ27cHnGN6DpHBRMgRCxOD7djR00je8mziI7MM2Z7kfGS9zOLo6P2Ivcl8L6u2oCqKXObwlmPFcjjhSHkMnTqqzCNtwuDeh3dMX3K5UFFU6vjpy5Y4UG7KJ1ye3/CeobqENFYcHHrpuV/Wo0QxgV1abMEb6TghpNP9CIWzUhmr1shCLrjrrVVqB7C6Cq0mS5xBxczfzQsWDH0RK2D2eQoDYaurRaUDwv26JPMo1I0smxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/XVeh4dmUHZSP5Dn4A6KKzfEWj0XgYtipjls5x/Nbk=;
 b=TJTYqpr+54ymFrbCUHxIGHBCFCX7Wm7Dctz5uRK9JhGIwaVpGh4RNa28vYis/rfIz06UXx0bRY18u/9I2wZdb4DW+rSqjB3XGS7BBu12gAW3SPPi12aU4FgHM6pxmaEYLh/otOe7tc2xryyiAYN7MuJx1zDfwdMU3jN+1zRG2FTNnl+r770648+LQTNmGaqrYpQGQ4UpEdKjGAcbvvuXpy3UIwvYP59I278eZ/l+39RbW9N/mrVszqPOFnbqlr9nOmtN6lEEuEyuL4b/OzymBRdZaCYDsJlb66XWljEZ2MmIjF3CfBmgnX1ArhbtA6yhjlLkOpx/1nqcvPPgvIVEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/XVeh4dmUHZSP5Dn4A6KKzfEWj0XgYtipjls5x/Nbk=;
 b=mbh7lST7bjNh6lDQRBPH0wtortq6VhPeDwyjF8W+QdEHNQHOIMuKVwmOrZUSSC0GlM2zs94EG5Gwl6YYp/lGslsfEwsDDYiUywWX24B4iI2RWHfu/YNUbROgGyqQ/sP37VUUJtpLM2aJXlHCCqGg6Hq1+Lb+Pq8iqm/WocNqpTwfiOEXbUzMTdFWUqlHrt3jSUIOtYuzuCN9JZEXYXLKQl+LOgeDF4hEu7oIxRJRv1gwvhXX4LyiSRx8jf5eBTB28JjJwZRLteHo6yYRlIpi4izXQsswwLUjk8Re7+QWk6dlS/eSNI3kM7DO6A837eeJGIXs1iXL/Cmq2nP1KqpsQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 06/23] mptcp: add last_snd in sched_data
Date: Wed, 14 Jun 2023 10:20:53 +0800
Message-Id: <905dc582f8b1203c0c454c496883da970511e8bc.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa4f7b1-9999-46ce-a1f1-08db6c7e34ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1yHT/cOU2or02U0ATWGtH2QcPsAprybSUAUyWVjb2X0OnI1lTLDpsFHNDVnGp48+CwAibJrdscxDhUpVPzQQGr9wzCDh3XjfXXZyOu8cVO1Y9tfV/JQKyuIfJF+oDaXsV7+eXzsRC/yGIcUs4VjKxBFW7i49Loor2ybyP08rVL/B3ZtWm2eL4qEGoVW5VhFmDKCcKdpm+6O31YGNHChNnSLXYVSy809wegXaUmaqGrAtJi2AhJ2O43ca9iVIS6UfvHTle1IFbImX1VEN9Yfa05UXK5Io9uK60j7AOErbxKZh9mFudKTuAb6gN7VEZIe1ZHke56IRLeTlJbxUTmV6SbeEqoCEWViBlxS7VmlBf/o0aS/ubgPF3J1ZAmAX8Bp965/7unwboyl8nmncgqLNnTqYdvxSK+WazCn0B77SuT4pNM+7KGNKYp5OibA3eB38Nk9bFew5nAT08CvhgfTX7t5UNLu5juq3A/Cv77rTOMDoUeqFMlcseFHhJs5iiQ3nC0YhjZiGf8kVybp3DkoPbjO05h2ZS808w9gpmJ3qpBV2AXYCHBxXpEC43VgpVP1u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(4744005)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chdqDuOErQXOV1HlTUM9Yks3ixAd/5FmRYmu8Lzlv3F61mEsFFBiKF9t/O6U?=
 =?us-ascii?Q?987NtuFR64Hf0RF6RQyC2DmgUfjpZKenLGf5LeBqfAIQNNdmtNExdzwKAXyB?=
 =?us-ascii?Q?6r736jZIz1ZqF5UozMB0vaa5d9PvbSUPa06ywe8w3OWiTKw1ILXwC9zAC+TI?=
 =?us-ascii?Q?IwKv/FnKO85ELWmnbsiIiwedz9OPCKXLdRVUzQxZQx9csp4TjQiYZVt68TLc?=
 =?us-ascii?Q?UNx9GgNYMUQ88pRGa4yjloBkRfh0UWO06aFCRc2toul139E3SVLGxhQKDAhd?=
 =?us-ascii?Q?RG2XmrZctcm5ag5SfZx9+swhAK+Q8Dr2xDqN2ZBLJrba+gMa/WIPEN2udtl0?=
 =?us-ascii?Q?6QpcxFNyojpnRJBlJDZPBuw4gCfZ61WVrwIMU+9AbBNt6T1+LmONxw6NAkvc?=
 =?us-ascii?Q?1g9n2mVpWLlBRe9e3R/kStXMwNEBZ9SMv+HS15rLwKIK5c33zwFkkb9HTty3?=
 =?us-ascii?Q?bXwK8+7KR6ypCYMqJ3IuH1YcRvqwOx7XDrcPDfwlB29gCiHwqlM44U/+tyvy?=
 =?us-ascii?Q?uKeEr16ISa0QZU2IsvJvRtNfw0zh+bZ0my8joawq17Cr+bcBJbLsiGCYFhDi?=
 =?us-ascii?Q?bV1hi5tl9D4g2XL/chE/zO2wA8/JetIH4s4YF61oaq21kUNGjdl8yE0p/tL9?=
 =?us-ascii?Q?32DAd66EvH0wxuHEX/DsK0E2xqQZC4kxBoXMFGeELg6QhqUrZmxJPOgseSX+?=
 =?us-ascii?Q?/TRjli/FLhgpRA5az6PBRW+cut4t/VJXcF81jvx+gcC5yuhRspTIMj6MdrUy?=
 =?us-ascii?Q?bNonZwCRl3kmQa3IZX2Zn6/VEi5rvWtvr5fmdzjLQtoRkvnBfXGvmzOcP7f7?=
 =?us-ascii?Q?WQ9qw/iP9YwotA6E6Mopnml8yi/J7coSQ2kiLO6Cyg+IZtpsTAi7dGYx42pH?=
 =?us-ascii?Q?WTbKc2Onqk5jEuPfq+Z1VLt9LmZ4UOjrYpqGAMMxhIBgbJCkRg9pHZj0BdkB?=
 =?us-ascii?Q?11ZqUtBZEJwNoWEhfg7E+Mz8M/Ds1Kb6ZOrJPJac2XJSbZzOcdw0BL2B03U5?=
 =?us-ascii?Q?FrX8G6peHNH8z0WJPxzXNm+McYR3iXSND2hajPbvc3xcr30CsDEWQcNY4Diy?=
 =?us-ascii?Q?ICEhWoz0s1HGwSLQ0p0+NrVHmhiuUJRpnAfPvlItdM8Zpf0qjeJMSRwMUOKK?=
 =?us-ascii?Q?UCk3Q7dNERlGeC3R2gcTtSUDn++lIHK3zMa6SrRHogutWtgA6WIvTtkc16hT?=
 =?us-ascii?Q?gXecU5gVba5hNPz0cdBGwEd2TncoeaD/A+kRwSIK7A3BlppdP5cdOf+m0ITt?=
 =?us-ascii?Q?TGcscxRnryFJvDg5FGL3CcwU0wcaWE0SrkqgkGo/o1Dn/y53xNdtuC1pNG6+?=
 =?us-ascii?Q?ImQe3ssRig8dROA1CE+ZkVSLgBjqI0Sa6oeOPwoxlsUwvWzQwJppXtis0Yr0?=
 =?us-ascii?Q?PPf2JAHOVJJ75U4blBazLmVcbcY/GgnkGGVFGDZMDOLph7WgxfsURiMnC5u/?=
 =?us-ascii?Q?QbYmhnY6xc66pjm3c787uDR0GL1o4sSVAtr/d1fCVhAtwwtWJED/26YXqn4e?=
 =?us-ascii?Q?SFM5BHlwEw6dPFEjjvSoV/ztUAMoH7BPuTsEdPlLh8ANhuAotxPm8UeFAnqK?=
 =?us-ascii?Q?afzLZqlKs/V9lvDn5ncaLAdBbb2B5dR9B7TB4y9o?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa4f7b1-9999-46ce-a1f1-08db6c7e34ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:30.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D70TPnKF1+L/ZF1mbPFrOPd922GK5wvLS11fVFKpefLcMBMZyDgcj9AXqn+GUq6Rol3w3DSmRg4fIalvgvD1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

This patch adds a member last_snd for struct mptcp_sched_data to make it
accessible to bpf schedulers like bpf_rr.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 1 +
 net/mptcp/sched.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f5cd43cff66b..a9bd7d6cd177 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,6 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	u8		subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index ca4bd53cf5d9..b59046e31457 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -81,6 +81,8 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	if (msk->sched_data.last_snd)
+		msk->sched_data.last_snd = NULL;
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

