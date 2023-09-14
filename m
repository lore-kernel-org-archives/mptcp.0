Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580F28E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6ou+RVXbfgkuuYt8XcrvbF5Ott7q+BMvpEiWo7W9IH7By915xwrtsF977jdrgS6lcYeWRFQI/11u/euhMTVgAofWoBElTVdKVIcwKup3OSNQ5kOqNPMm9p48Vvmlju2eH5vKuSKCbsYJNYL/VQRPz5ww9q6U3yOzZ2H+XuPZqW+fqP6oz4U/06spOGNy+Wp/7kwOoeXMbDaaTW7zwvIq79j9DB78GpXlPm8pKesLr7UHxRf1RNzKsZFQYinnatPx+PhZHgi2XO9mlylpY5cOo1MuiRQNYnH5s6+R3a+X6VchTXhHgKHPlfkvxw0kizdHtmwNpMnefoK2J+/PqSpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=YSP5/utz1jCmxuHht26tMj6ILo4r259dmdyMdXgxi6KdsA2DimEi18pWVJpNOeVYJ51D+B/YTPkj0RBQ0yWjvFZSW1SK3P9zN1OYt5+thwJRbeiq0KJQDRuLau8+67/PhWCva21fJEjhJ2+4/FzT8A72uvNOzkzt3JYg3UHtUi30Ky30cdgQCzYaBAGjCP2sf5JkWWwXwwT5PYDNTtztzlV4em3q3ts5W2vxNID/Ic01GHMV1Q7zjIjFPULwAUbw/TGUYyGObdqnFMtAKxGc6DeVfbeDHximpWv5ivXTtf27apXpiadhTN6X+5YW4vEzx1qIsveBRGyYPdLAJPjGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=s2+2pRAaI3ZZ6JG2kQ9TncFD0ciyELFJl0p6KKLkZDFCMyYCCJ1xZgKdXNIgN/XXNLuUMNADx+KLuOe3mvFeajC8K2/4/Ddaz2e/KbvcWegJfPw9gGKMCo+Kzpe6vUgDw5o2ZAgZPGrgqPntUJZoZytr08EAQJRLPZJxXBWCUz19aK+oZDP6mwqmsxUyRn0n6jydSS4vDEY7H+YOZ0jAhaxOmMsqSPo85RxJiUDKz3MP0CmcYFUYRFSR8O0hHoG5dUaM5H9KCDP7Dn6YUayapreOOo9OqQDb3XoZrrcH+UehijmPGSXDeR95f65CR7Xfb2Oxf5aWCqgl1DQiFPzzBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:50:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:50:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v9 4/9] mptcp: userspace pm allow creating id 0 subflow
Date: Thu, 14 Sep 2023 22:50:19 +0800
Message-Id: <aca07a182fbf6c0a28ddbf2f5a23ca78d056f718.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f92b91-4584-4953-6e86-08dbb531ea89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IFWE7/fuh8RzD7Rt9Q3D3cFwwdOIwCg25bqWJQF6ZhzIrrmc+onsaeZJEnjGJkL7gKhsYmWiQJqe0WBrvTUUIBo6jXfcb00f04tNuXAQX0IwhWDFVfW6uDnVLOa1PC43yp/q9fvQNZsMufMR7rYtLd58JNyU1LTB2dlczggY0MbzMt8ZWPoUAp7vhFS3uVbcE/IaROzI1fkbLAam4wGrxK6zB318bRFuRujVhfIbbtgDAasDLY2egbbb/xbtolmCe6TcHbJZmh+PsJS6PEpqCqtNitAj0LX8DOZN1P8X73vbhm7y2Ogn0/M4NOk7/mfJnH76z0tvjO4QrCs475Of1hBO3qfiFmBDYP0/W7drUDqDXV2tChIM7NbKTV7+d0SjdSk5r5GZP/h7UBFSPk0TBvxOacZI57yUHZ9zMMFO5IoXLFrPHiG6qD6qnVpf9D3iPS125rud1nJIC2CgH0B2aX0R2HAoUsAjZ7wzcqx8W+oqdZ82V2dIPpPPB8EmQfnBN0/ZcwPdjyFqhQqJczKxL7BZz9SiN0I+Hjp/XJ+7fpJvrtNQM33sjLNLHJe5qx4zE7E9MIm0Bwemh1wiDZo0mGpIjhvdrrae5nEjoaF7Gbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(8676002)(4326008)(8936002)(44832011)(316002)(6916009)(5660300002)(66946007)(54906003)(66556008)(66476007)(2906002)(38100700002)(83380400001)(6512007)(2616005)(966005)(26005)(86362001)(36756003)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gC2LLs1ymcD0JB8/CiiRtR0pitkdzCEDV9TdZ49L7/SSnD8rzIYb5G0Mxn0I?=
 =?us-ascii?Q?VqjsDrc6lcuf0MNQkNBc72u5WW8dCbat9Zy3MtT4yPUyNgY2sStZW4VlJpWI?=
 =?us-ascii?Q?4dXo+id7KaGgdnEf+A8eldLfJvl5kYYZ1jPc1YMHakP2iE2K9OKZl8DLO6a1?=
 =?us-ascii?Q?c3Yvj8kZeHMuJxk1fJcZ04GYNzMb6BAt+2yCa0XqEkxRZca/HGNHxu466u2I?=
 =?us-ascii?Q?BKVfHbSbCSUk86ZHq2hgbIaYXnAKKg0VswXP5ZujQrOp0p3YYulwKgqdh23g?=
 =?us-ascii?Q?bE5lslPcccQkVcBFPSz6/gY7h1ISgAp2CdJ0z3yBooLkl6wXNFwliaByMTZt?=
 =?us-ascii?Q?akU0ZXnVCPfN9B6OT6E29ZqE9pgTq3glNh4l20wyC9UyVi6uSO0ks/j3XKzP?=
 =?us-ascii?Q?irAoPRbU0safdvmC8vzIkm81w7iCgXfRIvCXcGod6JBv/0PJZ9V4Uu+Rfm47?=
 =?us-ascii?Q?G0maeGhOmEVvZ/BycPTOSEfApSAg7AC1847TQVoi8KyInWaPuj7OUut9QnGF?=
 =?us-ascii?Q?M/QXAzJY1gnXEmD53NBCgw5vvm8Uxt+7/Mp19hyQdILkaKusVt56lxq28UzT?=
 =?us-ascii?Q?AhYYbzqda9nvFk3Z7i8qabTWnRUAlQX9zkGZDa8YOwUv9YOmF2N7KoIq3r2X?=
 =?us-ascii?Q?coz1WoV1jKN9ET9nU8iUxET4SKtrd+C859tslZgWIpvFP7cW+FiMjtf6X5wo?=
 =?us-ascii?Q?6BcVXMgZ5Z5glJV9WwjJNS2VK2yKUbWTBr9Q2tZw3LrXV1YD6HTYvShypWUA?=
 =?us-ascii?Q?B8iLyX8/di8UPPY46LJKj7pqoeBkJ+zMvaW88exogAvrRdEtGrnbOccztQok?=
 =?us-ascii?Q?sQXdypWGh0WWO23MGhv3HA9Dop6zb3wHEGQtzq6xxxZ7RLTXg0fmpEjFNypC?=
 =?us-ascii?Q?AfyCqUCBnotFVgXRLZobHwbn+TI/3Ah/3jFMDHnN2BiPGx8A6SbKwgGmk+s2?=
 =?us-ascii?Q?cdmp8qeTkjPNPYRPDCVP3U0Vgv41/bRakyWx9SrtUn4PK9cjeKT2nAHluiaA?=
 =?us-ascii?Q?jjkh6YM1T8eIsT0MeEPQPBz7HLxO6E+cV4nIGIjtuk3IveWRyR4pEBh8vsw9?=
 =?us-ascii?Q?jakRFDkn30FFSVt4pqt1pL71gs/naZN7wc28uMpLZLx6XX51V9IA4FgrpDKT?=
 =?us-ascii?Q?78nsQD6MxieJoQF+ZtE9s0ygQEBQCZBcmcN4/Gm2rVisuUuGfFbJUJBcncXX?=
 =?us-ascii?Q?GwTwHaLq7tiUPgwQ3kAc1VhB8HGscK0uDZlMCpaWrCqIDaiahR4lWFN9MtSX?=
 =?us-ascii?Q?EeNf73EqnFj58ZvN3ynzbz0P5y7rBPnNAyQ18pk8iK9IAUh9/QyPw6zkBgrK?=
 =?us-ascii?Q?7jcKBEGxKOXFYMyCLXVgcmUxyMmbNUBE+tjn8d7BU34AOn8mG++QhcpeI2kD?=
 =?us-ascii?Q?/CYdhcQhKxA5JuLgh4PkDBR7PMZQR+44jj62xH4M3p8Jk7tPpD4c6JlGxOE5?=
 =?us-ascii?Q?v9MCsJBrfR2M2QuhNlHDTC/rCgZUunDYvZdlARXGXQEGqVAH7G6pyp+OC8IG?=
 =?us-ascii?Q?+av5QvQrFROzBkfQKWAWpcddOpjJtRD4NeeiocaGO3es7rSO9YlKSJ6QQ1p7?=
 =?us-ascii?Q?au2No1eH9sq2Eqf8zUFLO4witfACUgPfclPdA5EtPblBo14wWHSIP2Ucr2O2?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f92b91-4584-4953-6e86-08dbb531ea89
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:50:19.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yo9sDICRwBDVAKt11bkCrPJ3YNHvlp0eWuIcKvmcxw7SOYHoP4Qfmvb5KIrUDmr1sz1tfsJ8sUYZRzPR5t9Zqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

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

