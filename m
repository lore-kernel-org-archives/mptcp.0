Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380163FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcVyfa9/vluihmy5rwr/xWMkBeeYFaRT3A5FpAGcAD03irlKPRa90I+UEAeBSi/1lYqDYYCbGuzG3tI2qIwVVF9U3yNnYENdbDlLd8+R15nNDisFD3nGQtFAvhEsS/dSVbrFM8nm7/LltPuHZqIanUQe0JnHGaLQiblR2aMA3WcxelwrBc7D7Cukf+G0h/9hGd7tlq3QgEOYZ5tfm73IFJiSNF9HC+4Un+WA6kbMe2FC4z4omE/c6JbD+/X1wkM6M+HTRQOXKRyqne6/ynAvM7z/m7Wp0E1KNRlnwyzBwixPG8O4us8q/MLYnzBXnFBo093oDHCTFv2JzcBiRvr1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=IA8U2rKirMjAeLqjjC5xKh0sSDDKJAk9yZTlsTd+F+9efOS5nOlcW+mJu7T06w/3GZ5rDGsSy2PXLahFeO1e2woMErwplexFeoFIUEdLqJFVJfyig473kDdzqOgChAk1cWuclKUmgVuMowQazLLBi6fY3FolaR2B0KkcL6YqlaKHXdUQzmWWCqzAvJxVIT5MZI8nDdcz/rvvTGd2TKGopq/rk1k2fl/08nG2G6nTkCZ2KztG4b3cXq/zCUBYWRO1X3nnQ0MtGG7RBWrYgRDLr7WhD0OOJAk2JRa2wPGMDAjkEN6ihM5oIdSd0S2Q1TVXDIlUkxfKrbjZ1X46BoeNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=jLvZrj7/nYgYF6nvZu2a/XxrUpGXYACm7WKSsIPiapd+0T019bf4FxbaXkexmKeGZmIVlDKAKkqvFicZGfDDkxLyX+GV9KPE1MZ+ABz4DGZ7ECRCL4yNV/dTzOqPTR/Jf5cf8X2c/IR8NEZGRw06Mm8wvTCXK95OeG3MKoah7UftwgfaImRSVwkKRFsJ5I1J4w1ND6MbrxXLXw+9G+L8iV/8K/AISOjRy6aqaC47LGflu1jVOLzCzsm0VaogeFfmpp3kjP+HIR54WjLRxqZ0JDQB5C7nAuUWG//NJbocjQoV2JykF55MnxOytKNvgpk2iUfz2TcCwSOuHt7Lft5mSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:45:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:45:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v10 5/8] mptcp: userspace pm allow creating id 0 subflow
Date: Fri, 15 Sep 2023 15:45:15 +0800
Message-Id: <662455ce1e286ba38ae29dde19f43ed51629cd91.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee91075-ce29-4148-4161-08dbb5bfb363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P4RL4m4argMJxhkXjTBeOtte93l2gq9kD4j3DrZNKt0IMbTWcrCMb0bNt0GK1Ip/gRMSWa3RP0BLXbqj64iA/cl+uqkEZI7h/9+I61M0YxVNlKXyU+G4GqZC3sKGpFryS9K6T1w7MNNhVdBJudGPHlHwGAnQQeVGA1SjtPWxxae6In41vxHbrSz0xIcKQLnoR5NekZOCF8+iFXsxtvd2X4CGrjpsb2lDnNXhV+DsAf7reF1gdDFxbQ3FO7BIXVuaKH9S4em6p4qtq7uXcqkeX9u05rf7BnSz9Wc8xW/IkjGO18hzY3xJNp7+edHjj3yoZicS3hpnezES94CYbw9VN4t2wrvA/9XSFM5PO3w2VakLo0dEk14BuLAnsK/aVsS+OKJ38P+liaAZHACNFVxr5J9zAPlVFcRPbPy+XmoEF5k3yiOX0d72yWOVbYMmre/oj3BuDjuqWCvwLpuY6unyA103N+AUZpncz1K+N3GW3oTNdIvLc6pguwqE51mz2jTANEalrCBTOal3rwpyTd0Fd6uUVHcRNDp61yxj2+zvH+isDjPVg3Sn6ZeYxpwbHhYTZEGIm+sx5+uMEzyLPa8xGh8i77mYZZbzFgdo+j5ptsM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(2616005)(26005)(6506007)(38100700002)(86362001)(966005)(478600001)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(54906003)(2906002)(6916009)(36756003)(41300700001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rw2Wawl/dBtGwT4Jky5lekt1GFZG/odMfH/eJoShjeJjgEDTlHXGms+VJOFx?=
 =?us-ascii?Q?z7UITzWeEmHTuKHMXPSuJw/h3JloJtkYWE6oQPhDdO+A6Zb4SuJ5Hq3200CH?=
 =?us-ascii?Q?rp1pmIroQrLfdlwsl47xnu30jpPZiQidt8RFYqfwZP2zgB0WpZE6bc68LkVw?=
 =?us-ascii?Q?LhJdnxHtPLsXfusTLsE83yUG2HFdi2AQpsSLaqOVIh+E9pgCA7xNbja7V6iz?=
 =?us-ascii?Q?BnDswLwspL2wPd8w4icJuOktvg5YI5ALihaRHiIFQzKjCkHiRv2italgPl0Z?=
 =?us-ascii?Q?AC8TBsJfGhf0ZaaJU0N16X8cQp2lR/es775G7v6lzRCDV6yx+xI44llJnBpf?=
 =?us-ascii?Q?wJvunzR7O0eI3nb+Ls6zaA63UtnNRiMG0JqTPZph9zhm8mdwOShdet0/aKvZ?=
 =?us-ascii?Q?a7hHd5S0wGp+QxQSklLfb+/zNoFOXlNSF36ijjMegPfzItRRMpMsrkgrGFWd?=
 =?us-ascii?Q?cH/VqwnRbAi4sTPksEbdew4SJcf83FuZJoQ8Ep6JnZ2Ldr8CHnEm5kHHZAWB?=
 =?us-ascii?Q?yXCdUhJwOwotq+zEAL9BkD6A+OzeE6LNoIweLXFLJ804IdpcMo5P0syHNVuQ?=
 =?us-ascii?Q?p5dOaHMuURKSm+oqn8yHmyLkBfnxlanmm7Kj9qRQprOKtAreOdGbZPVJV6eU?=
 =?us-ascii?Q?if/JzZERHpqU/nEsKi5k/KFbTDKzA4XHt97bYTvf34qXxzahOgiMk8oelHYf?=
 =?us-ascii?Q?0fmXUCENYy7SA/wxf5SMjGCG+AuQFtb4etGuJZvuPYucYwC9mC+AKzxj3ydD?=
 =?us-ascii?Q?gj7duc+5vyO8RV892spsydyg/wj7UEJtTvQDWH5rgKAZLtpCVbDcnrFdoKX6?=
 =?us-ascii?Q?HvtMk7WqZwEEP6C7osSxJSrR1dYX4YTtJ3eDLaeHdk9FYaOegbHQGbI9UT2J?=
 =?us-ascii?Q?ALWgIcbo0CFFfytqMCmQlGcBpBMr6B/gEa7d6nXhYPHfG7G5NEv14nl7UsIh?=
 =?us-ascii?Q?XBtCkXFRy2ScZjj3nKZNSY9OKyM/OHVVGEj+dJROgpyPRip/xOLq2kQKcQnC?=
 =?us-ascii?Q?ULgTyWLTinHVEK1phL/vOxmsOvCGabke5SzJRxAZ4dEVP+93XwIbelz4dBHh?=
 =?us-ascii?Q?zvKvn1R3VfrVpnv/I/C8DbIiYmOsR55xtp+wWxNNngwSHVmGZ+R/b6vvu5Iv?=
 =?us-ascii?Q?kWNHPti7N8NRhOP50lAH4y47NP1b6S37/2IjQ+52OxTVmisoRX9KfHC08DQl?=
 =?us-ascii?Q?P3FosH+NF02Fta3cVIXSPHlK3PpfWYP3oeGI1lR/CbEnP14zwzju/uPC9Mdv?=
 =?us-ascii?Q?WQqOszWUcxJKLhX7dy+nWpOX0h2LaUK+Ng1LRx0X9EiQjagbj6r4BCWEwdzD?=
 =?us-ascii?Q?wuabSgEeKbfTKINvdY75EXa3B09YuVoAe3lU2isBVqYe7wZIOFNMMhMY9xCC?=
 =?us-ascii?Q?6dQfI/N9fr4fm5m1x5mi5/Cxt34EooAZ3b9xVhHPIgFZb/ljfj6phBaJDOu6?=
 =?us-ascii?Q?hTsDwdWaiabh3T0vIOpsSt+MJQQk2HIDQwJ7niNPmFSBiyZxARQT3I2zgkra?=
 =?us-ascii?Q?cJ32SelrSZbcljUuO6DBcbGDi9oPQnHfL6sobONVu9G8WOLT9yGG45wp/WDw?=
 =?us-ascii?Q?4Hq1C/ye3JAQ7Rd+9bzVTFko0KkqKYPyH1GrCOdnjCmTO5+Nf+t2vKrYub3N?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee91075-ce29-4148-4161-08dbb5bfb363
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:45:15.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouUxoeGLBcnUeSn+w7gpDDAKC6mAkX8fvNqn7SGPh1gjkeG/GE463h5v2yOePYxOHGCht3cRxikVwGdRrZK0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

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

