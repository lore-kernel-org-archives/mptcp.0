Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057C7E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chv3pxDVvEu+DVmlY/8G4rZb4fHvz1Nt0ejYdGWgvDgbGCMkOMkRg/j1lRHQtBbF+qK7hrCyiKDhTIjh6SStah8DaUJWXPi1t8zVSiIngP618UhLVSx+3+oco92PMThPsMSaEfLSWa+FCqWzkhIu9Lzrcq7gZJYevz18ilLfc72zHY8b2yeei4s2iefnqBnR04on1jF5b22xEHLf6aneGRaetWce6S2CCVjsFGOGstjflsDsa2MKB3y/FAFdDm+GV+yzebjUgUjAL1s6R53WyOKVUQaQfoGdPYHMaUxUS/OSQ3jyKUpyfkPwToHR94yMm2oRAN5g4mS++tTsbU01Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=S/Ozl+wZSJVpYwA8b/a+PPm40zcgxNu4tCbU+l2nvw7SRDKMS8TkJJk3vssUHzBDfzRRsejcD8YvwIS+3ISFQT6xsft7YHyzGkDzw5vCAeVgoUwROSp9pdTmaUONMbJXS/QBsK/Cgs7g3Tax6Jgr9V/rLWLdvDvTg9OPQQjtCKfxpIcTYKEUAIxYlxnnFOAZDaBWGq06jFyBFYsX2ZUUlpsFq1Zh8nsf8k4AKV2NltPVekzJnMY4W7jpoFnChs/2/DLv//IJTh8SV2pk1tnfOn+aHvNj6DYz28JrrHvXk8SbIEA7OYJjUrrlM9Q3naW8J2U/rCgGKQazn496jWg4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=olYrvrR6979tnWC7osAI1dAfKlCcRBIrteIxXjzFXaX1dhlZjwPJZ04sg+qip3cs0/3e55EYS+sjLY4jLi19qE0ekkXM6aPPyrnUGXlzo+i0E/+BlLU6+sBBofLek8avBnzhzT5FBDzgwgFq/c5M+VWy+qolKE3PrGgiRgIoG2lWUosg1Fsbfn4KK5jmGcCasNomAosrRgFOV3eS3yN2grt9P/UsRFtim394uf9W1mJcnIDupArnuYwDAI6naP5t0KHMgxts7k3Vyv0pIk1y9FnCZwA+nmI0yp3Sl43nETHSlF3IenIig4VJNnkf2HBAlZqeRgO+PKZt7GtJWqekpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:51:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:51:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v6 05/10] mptcp: userspace pm allow creating id 0 subflow
Date: Fri, 25 Aug 2023 11:50:23 +0800
Message-Id: <83fe940091c484338ff9a187d6501c7d0f2a10b6.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0130.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: be826fff-0752-4809-ebe1-08dba51e8338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MZTBQfyTnahjiW+57vs7O7eHlJ2DM0HGIHK4nAYBVd4Z4U0hz2d2sfZKRlSQMWDGRCLNroonD+0jnos0n9is8VD3MZ4QHnGxOOSfJTcVnYUjG0s/hw6QrD/oYwQ1i0jU3ZE8OPZ22ZjW1nGB1QtSg6QDCpVYEu591U4qGeANGQfS20LNtttVYC7wcAiLOcjJMmyYeASmgqCcwQPbKCYDAOcRmmYEKI9feORRr/J07xqO88BAnkfdjLIlYlvA7W3VluNPQwN1rxgu0RFGW3GvOiwNfk+bLiCIcNXldGC6FVOCNtRbPgDkr3tyHxCs2aSTRq+v31Dtp7nZAvxJ9P94WbzpYmu249lIRLFDM3NCJo0Ci1vyGV6nLBO/oGxjXKb0xIi03CnSpQRWxbBG7h8d8KoiipKlf407YW6sR/5284vo/JBXJTEtGLCM1vfLkD47WHlJ/8i91bhbORMqECM8zuRfBbiHqt5q66d2nJwHIzlO4gHVj8ipcNSIfwlvxoTwhdxyFVe40gGJuY0zeER5+nU4xoX2skwYwdgjLIlVP2P6lpG7s6CFrnoF0DYdL6N4OrSJBGX6dIN9BBI35UaIzM68USgex9jE1StH9h0gDLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(54906003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(966005)(2906002)(2616005)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgXGyg2ZkkQspAsZ6F5CkPfhYYzbspqJvNxDk8dQIh7hhizCDGtUgWITfBda?=
 =?us-ascii?Q?LSDfcx3UZk3szS2PLZyo9N3Hac+64nS1+kmtkj3n40yuvDDQGOrd44ipN6hw?=
 =?us-ascii?Q?jYuLarDhQXHKfV1ygua54qQA2Ps7lYw1592td+yVEr2aS2fqUB8c45uBd7ev?=
 =?us-ascii?Q?LaYyYMtzD/Hzevoo1WhYJAHVKpgs+zcIForSFIR1EsXNn0ec/3k/X/JcFKpE?=
 =?us-ascii?Q?UlY6DDSqt7rV5rYwCSTONHLEK1u9TAJea0wtPRWl/IT7bjqpsqnqVDNMw/tb?=
 =?us-ascii?Q?UCZSykSL/Nb3XG6/FEafAiaXOzhxXCOcjqiswNTztfDUKB/ZYCAtrJQ8geq4?=
 =?us-ascii?Q?GVRSAFbeWAWPHMZeN54A3FuhLZLbomDWGsKlgzS9kYN5hDL6TMvJwIg6DZBl?=
 =?us-ascii?Q?wdTctMPujyU5EtzYUEHhPp1AkuhFV9xnnXIlU93epnrwWkl7fRl8awqPiuUH?=
 =?us-ascii?Q?HnQw0v2irPYyiHwVaqSbEaM28/a1q4BcFhTwSPjD3RVFKbEIfDI4MF6rDQor?=
 =?us-ascii?Q?lmcRBbYrk56/ap/I9lhKV/fL6wval7F8vxzNxR6WZkHpcno2dDsVXi6SnY5+?=
 =?us-ascii?Q?Q42nOyyOprAGH1RieTQa6a5L1k4R2oJ5AUsvqY29hpgc0H8iX+8ZpGq1FRX1?=
 =?us-ascii?Q?l+OTuSUDfHvqqGCWuHNvvT0HqUyaFGhlfev8C8ZCX1DijuaTAzLZk7wafttN?=
 =?us-ascii?Q?OTDvg39D7/l0CNVzF6KNGwT6uFdbGwo2Ee8qK/PvZ47C6AE2NX7vE1Nh62/2?=
 =?us-ascii?Q?DgIhRIMo+n6SiR5mNQWYk2oNO4XkE4aIJX7hJvpgk/y+KSddq66PWFg9vIo4?=
 =?us-ascii?Q?b7aQC48faFtnbLANxT1v6j0EfN1K8k9lhy1LhEnAGxLSLydSijDxhhANRB6g?=
 =?us-ascii?Q?YaOtdhLLeWnTPH/yfnp+NYqGXrxrcJXfnreZY8k/Fnou9t0cciE1hGHGA1BT?=
 =?us-ascii?Q?nf3NsU0cebHfIomzN8AL3OC5Eauypug2y1aXwsi74cdiUyYUnTtSvnM79tjR?=
 =?us-ascii?Q?djpiWqjYIB54BW5dmUOIC92oSP1gsKf+NRnnaDmu3a6aQrpNtK/8QTK5GRFJ?=
 =?us-ascii?Q?J8ZH65ZaMPekoseR0+SspdxMj22gAxsdNYM2r69u6UCn/S8gyd+SkX8LC5nm?=
 =?us-ascii?Q?qI9g5xvB0fUnUlMNwFAiMRvAtker++S9lmj/gHjx5DI9wo6Akvd0DLORZhkx?=
 =?us-ascii?Q?2dONaoyqhM5TRTJvDlMAorbPZbjWj8LlLGEeu5+LqYCEd8m1GyzsUTggkf+K?=
 =?us-ascii?Q?0qwvIPScLHVZPiyw6V1VqwDM9nbhMH1T8CZ3CkKvNukLBq5ukukwhkCe8P1l?=
 =?us-ascii?Q?7LWlXilhyXqWgi2ZMq03YJDcPynKDZIeXcQo3xzwjM9gStfC9TMIVGnhL2Fu?=
 =?us-ascii?Q?3GIQht9uNIeot7fWu/IJjPorKTXpXh39i4jKQ16l4MOyh3lTe5FG3HEIo8ri?=
 =?us-ascii?Q?1LByfNd9xWNwKlSnBCgzX9lZXVy2y4Funx9ZPa1y2AdrVdPHnvfhIHhsFX49?=
 =?us-ascii?Q?/NX+5+HPB5kxTjb7isojpEOLml5i4eeB2oGf68u3qIuO8h6LpN54FGJ2V+NW?=
 =?us-ascii?Q?jAVg4pRU5IRdTciO4Z1dDuVuP4THx5mheI2AFwv4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be826fff-0752-4809-ebe1-08dba51e8338
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:51:07.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84es0bfC0DFhoDSICWYm4wJjLzVP8Eh4wyfd/SYclOoZlOR81B8S397OoZvVh2Y8afjY8QEK4GDN2n1MEedvdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

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

