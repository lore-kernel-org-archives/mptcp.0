Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E72AB4A
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCFqhvMrFT/75SLE7nW2cbDBKYbL6s9jYQmO8HpNuv5PmgPn+nctD7YPkzlNJx74vnzHn5smIhsS52zNERwxwr/vvpHRhpGC8iqjry2aTZzS4ZAw1JugXm0EbNE1NJjXHNI1mwjeKgEKHQ8V9Xo5VXiefiVgwLTLkDnctzxbEvFnWBQzVHJoFGhEP6UsTYqdGLHUaJG23iFijY8TB3765ccl+bAK/8foNXMHqEeBH3z3ZmR/SZgHvDS0IEPU5zyJ0+41eOqgfOJfDz13PHFZ0IRUEbwDG1+ys1rZ3xO1FHLLK86U3UsrsHG3ZxWBRVF/R6CWPTuzXru2tTX+u9ZaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=Hur1F/C5DT9+J6Z7SRYTPVthnqt7538hN/ylCUVqoHSW6jvFaAl9h+Af1dAAFlOpbWDaTSImjTbzgDT0ahctC33iFiaU2Y0gs9wDVzM5AzkZrbZORYwA+bQaKHupy8fBJxu5jlrHpNVjkbKW28ibK4Mtn5Z0nAxhk8d+OONQ2WRg1Xai3yfAumOmqSZq8wYZmXhqATXq6i8skI9m5DrArmKR1I6a8hLRY4CcXVbteLqsExiiTDrBZgHRVXLfSZuPTPKu01DwZQObBA8GNai6xzU7aXgA0NFm9Nc4MWiaSN7n2zE6/oyrxH9FRaub9Sef47Icx9kw5CaqJ9tjJEJ1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=DOrsr1zZYnF39CGMVFBM3VqtWUHrurxUeOwLxT8WxDG2t0nfKumM/bp3RgvHlXhQ2aYlpLogsJrHmmEj/mtc8n1IPFHdmWHmUXEv+A2mpn+hsSkTzRnQ18T4nPiLuunGwtK4Fw+UWsVcTtiB+/1Bpt/AjIJ8nF1hobGZ3e4GUGMU4BCH7L6x4wJNmo8G3frgASa8G8V2YRHxEaF1LkedkDi1K6tniVUCb/0fFfhfh/qZv5uY6IAOxfxDpUEoAWSAGweuKa5AzNOTX6awi+aA/3PgLBHUV7wzvEqeo5aS5csFgYEPolm7p8tsZiLlgCRtcWld7edanYJefNrz0aHScA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:03:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:03:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 5/8] mptcp: userspace pm allow creating id 0 subflow
Date: Thu, 14 Sep 2023 18:03:22 +0800
Message-Id: <9ee5c6d8290fdb54e93cb1e93f292eadd04a1a0b.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5b2d9a-3a94-4c12-4893-08dbb509dda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R1MdunoAoqEt0LY+AeVUTWQCg2Hxd2yYJ3ArLN6FJ0WsN2EDRpFTpJk2PJUHXb9ztYwSLKtxqUH6w75JJeNEKAYeKYEmFggRmdY3LpfA6/QTloQ7ytUxrmWWlgBtFtl+SD9N3uCu8TEK0/tcZlvUztPjHAt+2fXNbzi3ltEacp5z1f/ttOVp12XSBbRJeOsZcJMTpyyK1VgwednDhOcSMAlwWXV4+h49SPRXUY55jaScLsQGqEb5chsLFPXvNcadnKPi4qF1gzcTqKKb60tEuie8vl2vG+OMyLx8jXSlt3C90iB7Nx4pxPYfBr6tmsW3hRrpHO9ukNQi4AKHAQRDfhKQKVdGDDCXpg6lpcraFDIfAU8EkJp3J65Lzpq5HMuNoqL/Tgh1iyG6hLmhDumyxm3VM9T2cFpnKHjAN4PO+d5c/6j+KMWkG7iunaqGkYg7arRxxk5t0pdW8ZAB7RfIOkhvySpBjQATWJo3LCN5uh3naVclSNsDtFI1/118xTIw/GjNlkyKmpi1w19tMMuWcvh8mVYae5awFJe7p3uHS3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(36756003)(2616005)(966005)(478600001)(6486002)(6666004)(6506007)(83380400001)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(54906003)(6916009)(316002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWtY9ONJta7ifJrpxRXhw/xgYei2aeDb/Hb4aDcRnwkxF6AdP+uEVsHCZqSF?=
 =?us-ascii?Q?uIrfMHn146Om2h5bsfFHuhk2g/RxfzvSvlRfVYMuKnfXbX6Mk/fjosF0WtEK?=
 =?us-ascii?Q?1bg2UCjCY/LRke6Xo3Eo83ir3RM+8ljjaB0u6ilFV7J6up4R/T0y9RNCuQ+b?=
 =?us-ascii?Q?pP+dFI5X/hlpEZnmuj32pCf4xDhmg7dtZu4kIEWtMlqULXK9V5zI+X4GlD78?=
 =?us-ascii?Q?naJedjRMZOYu42zr2ai1dAodPjJQU68W60DtEeSYr2xCcsXpAcrhl9nIUv0E?=
 =?us-ascii?Q?4/NJGITz954x17UZB0kdBEYFPKCaTcH2mfYginbvG5vgDPDkPe1s8NGqJ/H8?=
 =?us-ascii?Q?6kkKUO+4qBR1qOFCbjlVLXapGfVO+BtKwr+4JYRlFdH0vZdzVy5/o1YLAiy2?=
 =?us-ascii?Q?wHwYQyFwnA19zrbP9j7FH8yq/qpNkiPCIFDA9aQTyvXWG0GCcMnqoIsSACNv?=
 =?us-ascii?Q?W1RQKyEvUkOPYTVYKrXpXbt9kfSvVYOipggSoppJ9BhnCPs6vlaGXViP8/RT?=
 =?us-ascii?Q?UaQaqt/YEI+4v0zmwLof+V5Ui4bJLR9oXyKykRJUYDw4osNWbxUsIe9LQBOP?=
 =?us-ascii?Q?njTz05x3GER9yahbvTtmIyr7RSWbrn5HmGjN9yhyf6/BzsUG0iKi92y82xzK?=
 =?us-ascii?Q?lPH/bIIGkpKit/MigvwfttKMEDWbPpyQ6RZcqelGScaXC8BfvRYItTpiJAHQ?=
 =?us-ascii?Q?DTMEa6F9eJmCRJtRN5h2JC0cYECilzvc3BCZI2ZogE1VjY0fbFcXYgykGpey?=
 =?us-ascii?Q?niX7UC5XCILt1g03xN58PbBwZlZZ3c1BwLmNA42PW7bmF89CFFCAJwTXGgOl?=
 =?us-ascii?Q?fXrDh83A4UAe2n15uLyHr3hDETn9Wu+fTeZsnBXJbfYKl9ptDeg+bwGdnpp+?=
 =?us-ascii?Q?owdhb6BW3dTUTyTnTzsK7S3N1SGpkVYBCMVK5TUfn27KJHlul/S2tcnPDPap?=
 =?us-ascii?Q?+ipTLly46AAc6xi6egw0PlxrPma7bkYVFp4d6UTxbMEdUdwADfbLAcWb5d0B?=
 =?us-ascii?Q?nRH0NlYC8kncFIYJ6z5IU4HPEPMHmdSmbVSDqotSqBF8LccELBXzBv3HPf+Z?=
 =?us-ascii?Q?zyVvXOLzKYebiRmEiTcOGq0caOKqM1RQ4n2LyG1TGsYjyZkKN/OKw/Y4uLbT?=
 =?us-ascii?Q?tanKMnl+9wAfv7eQwY6n5A22YsP/FnrMhdDCFaDOPcyBH4UN6JxqR05muL92?=
 =?us-ascii?Q?6RjBwohBC3SpGrzPeHW8F0MtsruS9xpeMjPErP3Lyue55nvI4H/IdRGt/ery?=
 =?us-ascii?Q?rLMu3j4A/r/qvWHA396bsleUjOkwUKrV1swmBIpLqIqzj7PxOBsMuWJx+AwQ?=
 =?us-ascii?Q?Gfwl4/8SBkSPu5IRpAAfJYkn3IH8lXysvFzOouMOr23iH2cv0GAHilQ81uSd?=
 =?us-ascii?Q?D/n0wFybHOfkxDimNycrnV1DQ66P7tsIeiXmuRCeO8/+xFLiax23D3BRv4jf?=
 =?us-ascii?Q?SPyoRP7Nuw5cndX7xzARP6JfmLscPV+fPU99BSPQbOXoxQtByaiLAKGd5Xbh?=
 =?us-ascii?Q?FVJ+P5+2HuMNBXtx5js8fCJ8NhX57FHT9edWMWWJPMbdtnRJ4HJvw1y7JjAz?=
 =?us-ascii?Q?N1mx8xoSb3e0+z4dQomptCsoSarsX4nv0E5SSMBl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5b2d9a-3a94-4c12-4893-08dbb509dda6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:03:38.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV5t6LiinQY18kPzP637+BbqQzlRTmsbr7mIYitTBsDOkyefUnysSJufZpKkdF3idDRLE5tbMLH6D9RU9fdeow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

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

