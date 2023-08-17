Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3301097B
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 14:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvl3zeAQSq4OZDbsvHZ7dH4L39mDFmIZHoim5C632m4jbqcabINrpW2/yYATMGdj+zecKNRah/IaeUEx93kzUAmH0N2OkhO5AmgFML+kycujBGIITlXrWV15330L7oMzklpyrLhrfmkbo1jBPzGCmI2x3W5Zbv/vNNrEGpgNabSZnhCAke0PbYUj9i9/5oth4f89yug65Buf66fwODC0R/LVMs9bVl1h0qqdl2WyeRMiLB7vsm9VAGruA9OFkBvyCriY2Iw3jwC+0YfKnFoISFwAMd1UFCV3MXEGtnKj8KSfvB45OVv1dZ7yAsSRzP0Dsj1GQF0cFbwQq1myzoFCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=QUviuZpKOONpgSALuQNAo76Vk8c+emkLr7zLqoewo26ivF7AXbD6hZ7eUXLKzs2+MkjZoYjE3R4xAFpP9+b77fm0mVITm/u3VPALlj8eUfjR5IDz/ZsSz1ENz8MxIYO7Za/fj2Gfb7eHp0CHJbbFiHsTPo+LuRS/329bF4p4vBMxGC6mcb1INxVkSdv6b97RhYhVeQyBtwLrDMTenvz3i9WUTLRmGXJXeCM5AykNXIsi/1WwREV9dCzDnG9c/D31VfeB5QFb2yuWA7rtvdohrpM5pL3AXIuO8HEuFe3P2XX5sQ2qeUd72C7jdVOVvSmtYAwkrXG+x4195oNu16njPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=bLSoabtCh3L9tqjIgFphYn31mNlfQcq75ZqzPg0XaDGbAYkK2qmn/ZtAH3HM+Mr4TZ8jcdO69WgvFODq7Gk9TmBe5qNEfNflyzeg3AuP32XCMbY/7twiSnZ9CY6DPULTcmxOPBaZft+Jj9a52i421j29EiwPdlZhtypygmSUPbZZzriTyz+SCYX4ZBpus0FCzwCo/L5OQmi48i/Uer04sgM8W2nciHrX8WtiYOy2IZZtCguBqgahwTzk71BpZ2VZ/P0B5Z+Uh9ufA1GR0JvgMwYGHiUfMVtqjiqYSPMvaula/HGMMefGNwnx5tfffo7EzJfmm25mb/uXRffySJW6qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9057.eurprd04.prod.outlook.com (2603:10a6:102:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 14:10:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:10:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 1/3] mptcp: allow creating id 0 subflow
Date: Thu, 17 Aug 2023 22:10:47 +0800
Message-Id: <2fd9705f3100956009881666fc0deb65bcf2cc6c.1692281317.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692281317.git.geliang.tang@suse.com>
References: <cover.1692281317.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0240.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0d0bc9-5849-4047-cd06-08db9f2bbd52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CK2UwE4JMYET3HKIBpgufuctCgPsZ8mH4XI/P3Vnyh1FKXDb5I9M7RzPj3rJoYreYIsuwhVJg0mIuaTfaWw1KBX6K3YsCHwcBIKgZOSIdAYhd5zhO+aJ0UOd294f/6VsslHvL0qttwozM/OdlB+iOSXFK7axduhw8LdUZnFVPoQ+kwRAX7qWDVz30wgJuxx5Ggr7CT6I1ek6rcTaiYmoKAO882X0egfAdXjJwMbs7vX5IXEMG7208rVJdq2O+Mh4hyW0/f0wrDFq7wIUXsAilKJA7m/GhFA3c3TVEEuhFtTLDxbt216/3HduHXQMtXJFZhneqhosnUmDpgxzPbY0EGE0DoV1lBMsZ5b0kb+MBa2wvH1CyplVjfaSVFlUejl0GFyzouy5sIIw7psCznfcynKGWY6fAl1nopW1Rvb5eNZwDEyK0mWKMrtwqOHaKM1WOw3o2yXZw0tTjOM8p4lo+rvvwp76jvV3g8cBv3dEP/V9etJ3FUJw3ZTtEAM+ysTiC4ce3QAcRMDgU5Rm+B7PCZg3e3rw+9b1LrVMttaKOcFkdqwZZ81UUrv3aBraqXGJ4sWLob8k4vyhRacxVHjIMtdb+qKaD6bHqAqctqvCDFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(36756003)(2616005)(6486002)(6512007)(966005)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?piRh1uwEX2rdJ4PXJLlzycXeXbEbMc1cIMAYyD7VF4ztJe0XTnh5WDMQkoIr?=
 =?us-ascii?Q?ZmJkd5uSPMShXVJq+44NKgjn+GqDncUg3bFdFLM/ubtQJMqfps45i99G0ell?=
 =?us-ascii?Q?U0YUdssCy1zi1vwb1d+Ucw+XSMS/1fE+xGynVLDA9LlpYj9hC4twO4Az0Wen?=
 =?us-ascii?Q?uDIr2jcR54nygrn1QXg5N7ldcD93oPHTZC0AsMCiaAmhQ7orCdNYr7B2Zn20?=
 =?us-ascii?Q?rUCNSI4zcDV8pDAn9xxnj6E6LVCov8dxRTRpmUvTLNeqNbIh71MlpLqT+Sco?=
 =?us-ascii?Q?IMpr2YEa6XZ/t2Ht6yf6lxnYAeOd9ajEj8NcUMhrYEb8JHn5ZKWW2+rZlwvr?=
 =?us-ascii?Q?H+sq2vwr94aQC46AG5Q5/lXnIeM/NL389IEdQbeKokk9bieeqdJRA7UWrAfA?=
 =?us-ascii?Q?Gw8r4EIVKDkIQNDYroIlW7EHVkKcQp/nddn3Bnpl5Sz+puXE5uksSDFHjXji?=
 =?us-ascii?Q?aY5TSEwFefK3vRnvtzVENGafl5NoPv4gHXXgtoheRe5eKXQa0ISye8au4vN2?=
 =?us-ascii?Q?CWwoJSeLdyRjQ///Sz5H6+VUvvFFQu6tEpfwCjH5/HD0kwCcDyHcUVrDgvxU?=
 =?us-ascii?Q?FZh6wZoeYi/ECebsqjSGFj1QtIl+0EvAXaNnKy/7MPv9fbDeBpumvnqyw5Hj?=
 =?us-ascii?Q?m5pGhvN45rPdkVoIGLVLzImCOds1nUqOI3q3p4E0S7OzyMihCleti3ZbzVn0?=
 =?us-ascii?Q?nX/g2FPIpJLxtKmmdBlp5RA/5iAIKMMiKdWaK0PlHMcP3qTL40YrKrakeohY?=
 =?us-ascii?Q?MrLPiOjPvA/e9Knoo2ZiAd+s6k4vLbUQtS86fa1Tx9zX7JvbNbY7Z7e6XyZQ?=
 =?us-ascii?Q?2qVP9s8/DWSyF5Q+mylT/xnCBcWmCeQMqjuDn/qk3dB6/YCv+76lNbac34hI?=
 =?us-ascii?Q?MemYWZZTqMRi/GK+03tSWW5J+IabGfTzxka+6+4+42RiUIafwZReKangHwKM?=
 =?us-ascii?Q?jzT55/ClmBDBtpCOTgSey6Q31j2MIo5XE0XM5SdvKhc+Zyv3tzQz8/ArJf74?=
 =?us-ascii?Q?BHhf1d5jtg5EGBtwRO1eMQ0v1q/n3wwTa/getAXwEWLLX9NczLQiU2mRSegx?=
 =?us-ascii?Q?dAY9nbHH2vb18FneZKjtCDOf1rA5nBS7g4B8ZVvMrdDMRck6Pl71GU+78GEL?=
 =?us-ascii?Q?IARUj7tG89XtSrsLN3imke4iNK7LmBb6WbS+lXRqGbOGe6XWMlyZzC627o6W?=
 =?us-ascii?Q?jGKxYecK7zokgf/JUzjNw/kNxhduIJfITt5KmwBAX3j5f91CVTxCliRRcbsk?=
 =?us-ascii?Q?ToXdJ3/pvP7K7XAM6fjjzEoFRX2wZ41GBvJlmJqGGsEP2WrwWnTikB5BHnHw?=
 =?us-ascii?Q?WxdISMx9v0VIm2iuFtDj97LevC0FPIxSQa5VaDy94QhISo+NIcvZW9t1ZHbU?=
 =?us-ascii?Q?03nm/ntnKutbMrg1pXxFUiOOaO8k7MjRodqJII8YgyLuS7mZJidQmWT3RGSo?=
 =?us-ascii?Q?QRkp8VL7AYHBOloB7lpaMYVRGY9E4WeX7KrGEBi/naFSGSorUAucT5B5jyji?=
 =?us-ascii?Q?ye8c2k94dsAfzGfjvq+XbnqZSBeOdAgkcZUGEcqUwColY9t1/IU7OAx4aExe?=
 =?us-ascii?Q?4UewJw5Ritpj7Ym6ScMPMY/IwAQIwkgPMza1xJxB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0d0bc9-5849-4047-cd06-08db9f2bbd52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:10:41.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd80LCPK2Wvf5NG/dhMFvUq60pgvcQnoKOC6L55F4edaW5cnBPbPA0e2U7BPv6tdhO5+kMazZI5XLAqyr3VWJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9057

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

There is no reason not to allow additional subflows from this local
address: we should be able to create new subflows from the initial
endpoint. This limitation was breaking fullmesh support from userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..d042d32beb4d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -307,12 +307,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (addr_l.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		err = -EINVAL;
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.35.3

