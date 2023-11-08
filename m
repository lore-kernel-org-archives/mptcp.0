Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4D53A6
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="j7m4zBTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCURzcvqYepI18ykb2ttROyGAZ6aaog1VTpprwb+TqJzsyn7g9NxOhTfB1nd+0npEKr1xyu1tkE918W+SZHC3FM6yFdQREqOeDOKU8qtBM4zOZS8ltwIH++kP2aUjYeevpMLmLAVEs2F3R3r3D5e95FP9V5NprNhKoPRuIhI9mezmReexAGuJ6OQSYRkBPrcrDl0mbMvLJwgjxSsCWHMvUH6asEVk25FYI5ZEKJPQmtIxjWKWaOexCvGcLj6wofpOq9Nns/u54sooT/zZE+rq4KxLI9kE1lj1KXT9Mg1sI/lOX6KO0EVKi2KOhXfuDm+tjkT/KaVbm8iyw5T2fe4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=n0HugLsMTKLqCo+4UsDKqd+BnJxNUK9JsuAtluqRlKUhpp/XqKJ4oI2eWwGUsxT3pV7hoXXGtXP7YGb+mmMK8i0ubVVSEdqpS0GrMPpJyi41GCk7IvfB8g1jbTKubhIUp9sRrLTS0f0rhfbSMB2LRqSIP1HUyIhp8k16VV+e9YUNMyWjr38z/DydfnemrGAy/vFCAsrtLXsMhJPuGVLozPp8rFGLypuq6wsQWfGxDBBy30NudUBqoijbq1hWj9fEw0AXYIGPUkF6FUd8nwX5uHFtZ/cXeydkb0FWPRSGA095aRWWYyTtAuLXbupxIwTWZkCs1Y+lfTqDhaL1oIzpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dph7slE2gv8EAzbuXoW1AIj1s2dm2ND+F4+zezBtKwE=;
 b=j7m4zBTBf85JrNITZkul4OF42RfQmbtuDkiXttMycBMVB5U/eTlVXWb1SBAPURBROHbLI3MDHFDLlKL/kMaJg/HshixUf2uZ4FPbFcbIlu1+0ZaajUSsDMtDtPZyY3gBsLtUttIEptt2xGGaKx6zY2YTpL7u7l+TKE7RRXSmKIO6dvDbT5oHV4dynV/cx3fSzNmvXL6boTTXOgJvqPxWJgrLa76U/k3nVePR5k01nG33L0DL+XZ/e1efNgB+NHtWnuCLnG7GV7BNIYkr5RKyc3w92MixyIiRIN3pPQZ5NJMe3KLyIQOkO12YoBwaTCfwtTMRbE9IHaIXDQYRFsGLFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 07/22] mptcp: check userspace pm subflow flag
Date: Wed,  8 Nov 2023 14:49:37 +0800
Message-Id: <617ac73e3f5a57f8917c1e9905b79171792513b6.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 81795c1d-e496-4079-6662-08dbe027043b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5RWCW+/eA0zURqy30EVrGuhkZ8oDwbceM+Xfw1uybh6slahPMVgvpKfoNvAlFmK646Q1eKlk3t+9fhl93xUi6bb5bHlpANvrI/QDDL28cGZ9VNXHiLw1nxfz5ms5gcmXB/z1iKdON2ODG5tkf3QMHOkCancAhDknjoSBJSgBY4fq7lMNtrfckovYcKD4GyALoliyA0fNX1o2dytXhVdRKGrMFasPuuDLCPYP/pe/R//RTxYQeowOvc+qBtmN1PLzLmf1tpYq53Sx6n9/9Ya4bD7UH3ivpMZiAujnKM8Bh5uGyhXI2855CPB/sgLZq8JOSskiXRfUsKy1hnT+lhewgm0uJEvttWPXoHVM0gNLZ9DqaZolrtpOdVeFRkGV1ZruMpZ6DEM1F/q8RGjCXbjYrtAa+6X2/DuxPGoGp504zuBGJ02tZJx0XJM295dcyvLEVzkHzNspC195ri9dmCy3a4X/nsUJoboHdD7wvl3r4DIaG5zYvq0/g1DeBRkiiucz9Onls60CcLUnF5wary0XqRNSlLYJs+twjFYlYU6gxhMiDM//FyMAiDdtfpaZCgA0l6UDh1MfK89R0klArUtr7c5uKoNpSPd5gQ1iIPQlilA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9AIyfaaGu7kIiso0xo+lD+FpSbRlAWiFtRA0/kUI7BuAaqfiQT0Ct8j3bN0C?=
 =?us-ascii?Q?bkQDrSEc4vmiHuLlCPMyQGKB73sKvgxmljg+awkMCTYYaIa6hcu3IejkoaxL?=
 =?us-ascii?Q?B6GfgaQWhoymZ99PH+9tlWf53nylAYu62Hzb4MoMEFzyVtf67wXhwD/rP2mn?=
 =?us-ascii?Q?cr9IfUB5ZChivb69cWNfnSjYgJNNdCUbNGp4+PTXGbv0VrXEBhNli6weUIP9?=
 =?us-ascii?Q?iExphrILVSIgKDdE8zM3uOTPtLZTvYS63N+rwhDqMM96OeA6ZXqVCuQJAn42?=
 =?us-ascii?Q?qgustnSCjvEvuBY4k2zDBC3fVsAga5ZI89Ll0d9WDSgIpbV3uRFFwODvWkxW?=
 =?us-ascii?Q?UPYIPFpJZ+csi2IhRPaTkpBv8JQAvXY/VOpkOH94JtBTjeqETHEMU7btYcrS?=
 =?us-ascii?Q?bhGuEoG+yILUwBGp8yMeySD2cPJz1gtasE9lPeXMrECIsUgsGuH4qqR+MTor?=
 =?us-ascii?Q?0gcJ456fA0HDiiHSWmJnhNtctBrEC8r1zLtcUBaLvHbKZW3Sx0oecnY6+Bb+?=
 =?us-ascii?Q?WOrRFeSS3hv2P0INiG7H3WhhflFJzYbmZeZvDeNJY2asNhZwspIWo/uUGZ9o?=
 =?us-ascii?Q?FlmutYu3dDawhnEMRGyxc3TY2/mQaEua32Ppj2VqYhqciBusEz8/Xz3GZr9g?=
 =?us-ascii?Q?E3YWBwTCORdi5fYTWzTFT+gfBZ1DpGmkvtBUxLUtlglIEI3bQpWUrOxO6cqG?=
 =?us-ascii?Q?3hGD2YkbBY0NiySgKsVHOXvDKc+D4Q2VbjacIK/rWrdy364J1dSqGKUuaRn/?=
 =?us-ascii?Q?nIkZSrau34ePFPxmeehEuCRGZOj4ueawRc7yue9uSfno90qKxcX5IihQqugv?=
 =?us-ascii?Q?7ASYtjNzFrTK9j/tMtSj73PCVEk/onQXO+pJ0GbkJcvTsgjGbTmPu6haPoke?=
 =?us-ascii?Q?MmHMx89K/957UrqP53h5KH7FcGYik60jHwE+V3Ha3XpmxX6hJWJxupVfS/qJ?=
 =?us-ascii?Q?EZwhhlFGadG5+P1iaEBOAOwYJzxszSWY9C3g8O1rbtaSkK5Irna6Gh+5H1Dl?=
 =?us-ascii?Q?WN/uA5ZOfcsWKI6pWXQnqYL1P6IpykAfvBHMEBVv/wSvmM+vVhzm0unV9Y5M?=
 =?us-ascii?Q?79pwQuR+qNjYPccz9zAP/Fkhbr46Y86KWtTFS3JcFdZsBgvIqsBqsPuSmkRw?=
 =?us-ascii?Q?VS1HoVOToYDMrqOQBIMwkQmFsex8qbkippvhCx9et2dIHGuMlXc2CkUfldFZ?=
 =?us-ascii?Q?kJUBPcv2NiGuZbfcXfqRFCuDUvZcvKwc559VFldRXceY9OoSTf0mZ0Al2EVg?=
 =?us-ascii?Q?YDzv3pm2dp1L5vm1KkZmoys3zSG0cTSeAQvj13sVKePIZYRjnYMtGuzeaG9X?=
 =?us-ascii?Q?EC0v7axcujwuos9URvBunTxcuRtTHLsMp1Blw0+pY8vMuiKDs5RoZOU+c1Y0?=
 =?us-ascii?Q?PcB4lsJV3ZF540pmKDDa/u1sq92PILAbKDWhkDfOKl30Oau7ikqKaImKnlxY?=
 =?us-ascii?Q?QxYC5pO+hCLCTUtaJ/lhxTzhq1H4hepAq/seWNK306pKPA2bfhhO7LGo0ffU?=
 =?us-ascii?Q?mdreJ40a/UPn8lLgXNFrr8VYLGF6EXRX1+kelFUBuE2m6bUg0qoVLIHaekqK?=
 =?us-ascii?Q?KBoLdnUT4bHVkNRU3DGrURxUdHEr0BiYxx6KaED4Oz9A88TfIxp30k1m6iJx?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81795c1d-e496-4079-6662-08dbe027043b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:38.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHxjNvJoqsqbv7pYyHGruNFYa3dIOIo6e55Z9JWGXoLMbq6et94GJwRxD2Zvu7X0kYuvEIWAg8aro76f1DvTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5e45e36ce1d3..de10be21bf26 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -347,12 +347,19 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -365,7 +372,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.35.3

