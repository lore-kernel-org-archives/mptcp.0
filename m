Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953D2CA5
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhUDPsqXSL1EgaUVt94C94CHc5pGJA7vMFX0fudSGbWOxkGtAafv1ARsgsFaRD8MS9N/vbFrqAdMN0p4Xxkxbz9MWqDALnYV24DEaWklnzWZKbUWWQ/HVb5yxKUwYU3nLx7WgOJoc5sq3V497NhO2OJba4wRv3SozQHNz7koNhRWITSRc3TILjA50RJ5VSeEH2aUKcj0k2Y+GHvsi7eqMHkPak4HYg1korwMP/tpRGldK4QGKhWZix52J4jQ8yDYLU2wqUaZFijOD7djsQ2NjwRMY+NUoiE2Zk+/OVC2PXc6fa8BGTiuisu2qbix+Vr4muC29pO8TEmPVq7/57sl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwYZZi3UaJEDX2AA7lYIdVIAeb4TcTejwNKMOH44UV4=;
 b=jI09QDziW0jAvt8qNQqElm36ZXELcYhlSOjbM/7ljQ5CkgVfz8D0z/B4F+Y1BbVGKjTiXirHnMaDAMNyY5pNUrxa7uIjt6Zi3IEkXC2NWUej5sbVz9pRHwwd0UmrJZEnVt62JXFxkELqDpiKfOStHgEqWf0KSq21TC9STAdkBfe+jn3Q/+gpGgXrgAhXOeNP7jStwN+6jIzKzXJNEb1jfT/xk9ykiwj7K82EGtaktSLG7PCgOCJ4Yh2SrpQZvBKvOXA3fpcG2hHQL2uM4U+kHK4/sF327z4aUcdEmbBMWKBom9ysVelsri/ucZ3r5vO9YWWQIAZwFTFj7RVv5aVPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwYZZi3UaJEDX2AA7lYIdVIAeb4TcTejwNKMOH44UV4=;
 b=Rmf4CRcYmxaS9Q9WV/ktZCOhx3ZMwjaWa/iozL93oO1hOvcJrFR4zeqokrBfUD+P44H0w6qiWUVaCLneyQocis1qterxYaBC5jWQZz15EzSEVMKkWTRdJnTCE2CX43oVgMekPurNaNRj5d66VhM7+FxCTfBwHHP+cTIU/0t7l2tefzCASzBZpXvfMdqZJbhb2+kJytzkO7OhYZZR788G6PNzZXr/V1BOXL/5fruIf2oFQbt3IsmyPzmp0ml5JBuMdWQ5eqXUFAPMW7+BlaM8QjdqGFDA0+H301JGBlrxYLzhs2AExcRHPJLrlV2tXx8tvD2v5BTD2d3Tgh//NpAKhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:13:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:13:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 2/7] mptcp: don't clear userspace pm addr id
Date: Thu, 13 Apr 2023 17:12:37 +0800
Message-Id: <aa8f725b79aef07e0d29ed4ad64a34aa61a51aff.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681376983.git.geliang.tang@suse.com>
References: <cover.1681376983.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d541670-5f82-4c31-30b7-08db3bff486a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fDeOs06pBMK2tN3BgWx/DsxB4mPtjX1i5zVWS78vMaup9oM/mUOpN1heJCoTli/pNHVOMk9d2Ltqxfujdi8IeUiOsJXIu12upu+WZcSKpe1w0VU5sjhg0rIANk9OxWnLj49FqtPMUi8a1E2R0Q81fxPl+FJ0LDDIJy4XiH/awhqXeK1BMYCikoNpkoJivNtT9f0jCd5ZMELqb030vmWB0tXEqMuTbaTa4VoS9L7es2+zyAmhB388zC8ZNLgigdOC13YdSs1c8eIfoS297zxtz5WTYbQXPABRCsdt08O105J/Ye/O5GaTJoAS0uAi2UKfDYA5n4FODnWPXBbRul/2cq/dqeT2GVaxhlxgs4gaFgIW5859y4f/scEDF3BZ7sg74iJkMJhlJ67i4mNR9bWKw4tE6L/VVdWx8Wsojlv43kmwjFtb1b0oJNlE9MYlIZXRug99Q6yqIBqwCuls2Flix9H5ugPL/hdYfHg2YR/cFlKGFSgOf1M8qticIteeje5tQ1HPcSziLubuEjfp5aH5O2kBhKJ6a5plDgUOX+5ssOOW+1F/LEmwmU54L88tbZ+F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(86362001)(478600001)(6486002)(36756003)(2616005)(83380400001)(26005)(107886003)(186003)(6512007)(6506007)(38100700002)(6666004)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(8676002)(8936002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qBOoKEhFeJebTI5Htq+SCRw7HH+O0t/7PZgmkeeHGr1KvqKjnNUwKv2yd4Hk?=
 =?us-ascii?Q?lPALizbQdU9n5IlrnD4BUwPuU0TMi+aDwiEC4hIl6vT1Rp3WxfNk5M3a5byg?=
 =?us-ascii?Q?M2Ri8HO1s/eoltwHkEwnvMVjWYhT1d+VWoMcQ1L9tiT4c/z/KpzodbDd8NHM?=
 =?us-ascii?Q?Vg2RNNSBL17tFhPR1tnWCvx3OTopXrPYzobI1CpEuHPXiydazpREycnj8Eo5?=
 =?us-ascii?Q?TL28jI4lN2ZUwzJtTldCg0dtBffLmCqz7uI6oNM+ZzjK0U4ghp4hNsPU4+YB?=
 =?us-ascii?Q?DLmN2e0v2x2omilMjqjEd1fuTo6bjiKYhcJluJiXkwUXpfkc+0cFT4DVuLvT?=
 =?us-ascii?Q?llxxv7L6duQsyk9/8c/ihVKd2Y60aMrYW7kdqKqQuiDFvzuUj1wF7ewfTIYU?=
 =?us-ascii?Q?GI2Psh4pnYFTXFoKIawUbhrY4T0yyUTJ1juiGdq/TH5j0MW3zHVLadAjbS07?=
 =?us-ascii?Q?1wzyT//vCgd3Y0i98Pz9y4i5pnkzyBEnZyMgucvNGB3m91W1/pBTATfgxHGE?=
 =?us-ascii?Q?Vx8hKiAq2V5fk9Hs5IFnJdt6h8n96xnV5kJDuRuZhHxvIm1ebuKQ520ok8WC?=
 =?us-ascii?Q?0Iu0c6UhJZDFzN7iHIdAW2rvkAlQoDvqj9UG9rloLgaQzzRaCiSSwqDghoyW?=
 =?us-ascii?Q?YDc/DcGXW6Rznl/csBde9ezJPki1uiA8bl1mvrb6oGNk4u1PCxVORn5z6Iv7?=
 =?us-ascii?Q?E5YFAXCx3g0OH1fAPOvgTQMGzZ7hdU3DkrmSEEt+s2+j4orDeqpx2xBtbIb0?=
 =?us-ascii?Q?JZoccc+IUONXJDLWUn42uRgapNeoQY0MW4VVq4le2IBewVhK0nQzvILrLnjl?=
 =?us-ascii?Q?Q3dn4CR50qJlOyFQBe2xwpAv7L4PX3r5hyZ6AoX884YV4KijSL3wnZ0+60CF?=
 =?us-ascii?Q?WM9QJ81PTY7ndgKS91lzQVusNJW0a2JzGhhtc3GBcM7wHkPh3DuL3mA//wLk?=
 =?us-ascii?Q?iKdfpPkqKgwbcaHDxO0C3KTeFdbduLhXoOFXndtl+jv2n/sWtHsql/arqRnL?=
 =?us-ascii?Q?AiqnHxelSvMAGl/aNDQvo8NWziU46K+ZTpetGzmQG/4EirYF8p/G19pyEVf/?=
 =?us-ascii?Q?2Aaq0ZF/FmsdJyISftYbSMWXmFmMyrlhcSUfCxDaQkXbbxjaP3eveHhvjDDy?=
 =?us-ascii?Q?3JXab3oEJSPWl7aOfCW7YNvAVig8Tlv4u1K6CDD8b+zgkMv1PPeckxAehgmo?=
 =?us-ascii?Q?cbJ2WEKth2nnM/5VTUtpatnHEQo15fSjwBgm2nqq/F5NHM12w0OmkPvzrAhi?=
 =?us-ascii?Q?HAWNuXZrZ2oPC+JoQX6x9ywDY/nUsdjKVpUW1yDZ62ABHxIMKJNaCYKQyWqx?=
 =?us-ascii?Q?qDbMLA4edENvHkbUwpOsZEEt/Gx0S2TPUIEEXUrqOYZ9NJF+HLxouZT6poMi?=
 =?us-ascii?Q?ZciynMkbHFxtNo6YGmCp/XCfEJuZRiJPCSoLXKoX6o2YZ8IbgYVPWWFAD6CY?=
 =?us-ascii?Q?f5NbXxSbsU+A/1kHpVE8+mPUgxHO7oVHSe5VLNDeT1HFdtIuEfapuOtkmUD3?=
 =?us-ascii?Q?lUINEgP1KZIMGoViJSHvp02P72F5Lpl9NwWbsvakNXhnJSLYd13MQdUYjMdM?=
 =?us-ascii?Q?haTfmesTHyxV9xzVzeJEi5sS06tTVa/jOF4gcskY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d541670-5f82-4c31-30b7-08db3bff486a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:13:02.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar2b6nsxNL4v+ryjIY5TmlmMZrOIdyb2mYICsc2czKVYkIQPkr1D2So3IAQimqrPAuwT3ZPllcOIxBQEcy0iUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

Don't clear the addr id in mptcp_userspace_pm_get_local_id(), clear it
in mptcp_pm_nl_get_local_id() instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 2 +-
 net/mptcp/pm_userspace.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a02822111218..ff27c9f1f843 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1055,8 +1055,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
+	struct mptcp_addr_info skc_local = { 0 };
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
 	int ret = -1;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4d0e54fab5cf..4a8ebf87ef02 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -113,7 +113,6 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
 	if (new_entry.addr.port == msk_sport)
-- 
2.35.3

