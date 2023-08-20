Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39B566C
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtY8/J/IyrmD4cW/FAXqe3Kq3Dk7VgaDXMUA93Y9h58+rjjSPtyWemzANlc55lVnAuqyCWduRzJG1xKtWAyyETzksI1U4pAZYOpALgEPoGTpWO+Ey1/t1am/S1EYF/SA3V0EEi+ohjLIJQoKgxFQM8GQ/xBpHlzkjoaaNZTYXl0LwPq6OWBhBPQZnXlVGNe95DzhNNo9yMntU8kWRZSzpRFKNOBOcNf/OiAdzmg6+hE4S8gW8BG8MW7GFBmWC1Kgt+7TSZ8bgm0BSLH7hMOZUyOVmAQajbaz7xKIPApNCIUAgzwBcHamfZlzRnvdsCDyJyeTeq+lBWoIjjNVlOAg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=CJKbChsnblIm/a3RqN18QVw76Qjtc7hl2/u5s9ZhMpimavIsjqPmNufPCqXYDoZl3JamqXe4BcoV9nRlRTmcyuExsv9O9nrjVM7uYeNxpUarMXBx2SBoje4TpoHG8+thLUYNPojjua42hqutXd/I8XIFMKxdT2RHhXlMe0Vzwy54VWq3Z2pmVxQxE63Rk5V/lZBKWBRIz4UZEqG5hm1QY4L7EkOyQ22K7zxkFgxF6wOirdF60O44/27t3gAzUgPrzxrZnwM3kXnUnXVThLWUC+F2vggpW5szuWX47WjvCIEc+E9yCzsnyqZNk1L6F9QHYJF+oEi8AGR8owLwUtZaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSAF9pVPQMGFCRRIZ2CWkJOpmYr2QAARJNPwTMUnHq4=;
 b=VWJnv6UBKVZmg8YemwZ+UiHylOzcprbcpoQRpUpmLsI9K3o/dFUBohLzTEO7D++/4HRX03k35+pAOxf6KwrCwBbcY8KsX7jEE6/pYRkINxebAXYWwgJRtrNJ8Ax25CVtXw60F1TBHtpxHw1m9GvZvx+1dIiYYaF4c2d1dVaFRpjX+atK2SEzQlUwKKEEm3gCTt0JGBwCyU9jponILe4Jn5PIWNPDKXwl2ulKs3QnSQLD6O9ZQnElFif7/m7g2vMj76aR0VCN/OYOKZjseok8DFQ21enp7rPsLJzoEqsMXEb9l7aUM3EvVoSbMbeRrxplKdhH/Xd/ne7aTF0Fg0wdKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:06:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:06:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 4/9] mptcp: userspace pm allow creating id 0 subflow
Date: Sun, 20 Aug 2023 20:06:35 +0800
Message-Id: <b791d41183164eeec4d9e4fbd592ec25172ed670.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8bede7-adba-46f8-cf75-08dba175f246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	basSCHXep2iUgtcnmBWtl8NekEKBvBTJJJaC3e0AskKAXH9eAdCBwaAjZnrzkfoO2cWdftPDq74/QjdzgNEtweL/r9GHN/0h0tgyrGPpV3YF8oSvEU+mDgl12EUckNfOzokZ1JHCCRl7/5m6f1s32rlaliLdN3+v1J+wmC7ffapCUEBm5AytzGmZ3riZkak0NX3C0XY7LfKduV5TQmSDspbSUPcSpzBMacdPOy6+jpzOUVza+A8yTDvcZ3QDRe/oEUt6QBcnIYPkH38wW/wlRU8g/rRB4nkXKYU97cJW7OsJ2ZM0Am5LoXr14E6S5ETT4nR8yNZZaDkWaLZavKXGFoEctRDymq0z5a4X+sG0TXTr6y9U9Q57k2qjvRFaUH0EllI4CL+HM7nrb6TRwfSm3/v4yQEwFa27cXlKnTdHnOvTwvfzkvTkYsvyWiI4TpIJOU/E5aPt4t0ymhf/mFz6GIpYQvZf/sRj5dtYwJSRhP3sEUi56znZI6M/4xi9GBOl4l/E42ghH9DBy4uJYE5ZCTnAhqP2ljactYnp6gYS7P7t0nxotZmikIpnsE4KqGydMAOP1N+cBQO1qH4b+Xu5lhqgSmwPQ+f5VkIJ5aDzZ3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(54906003)(966005)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?343U/NgquVUlQ0pa/Sit/Sdjcw7fiXVpFacAoPbJ72W95LTnWzqfwvEQIxVn?=
 =?us-ascii?Q?ZMVWZpu7QEGnbuX0NSVFgq3llFjmh8BY3JwceCsrETvr29j7poEnJWp458Jc?=
 =?us-ascii?Q?fg8Aqr4PU75O5B2+r5YX3KQGk8mn25oNQ6Tx9hW2852fAtDj86SV7q1xVYGW?=
 =?us-ascii?Q?0M8Nrz+3DqazCpvOar7VE9xksSRPiHAw1xfq1Pfcc+sIakHbVMZQceYd/64U?=
 =?us-ascii?Q?ffNELYtag7VYI/F/QkICMyaWxQSEtePew6q9tS8Wdnk1RVG+hIc/q0bvcVzb?=
 =?us-ascii?Q?z77y3l8TjJRFtPfvJkfX6b7RF3mh0QIL0BmEp4J5uP0VFt46aII0yKetPAcU?=
 =?us-ascii?Q?8R78O7ZzFK+N4wjN1NqplfxI6RFAaPFgu3SrqGZIIB9+fZpITL6xpQG7Nj2J?=
 =?us-ascii?Q?T7AI6VV6sZZzFdO9oi8H+jHvOgqQdYpTcuyBDAf4y9mREBSKV01gQNTyh9OC?=
 =?us-ascii?Q?pWF1sshid7x1MRACLJpCwW/lOCh2qsMK/szXfJhUjYLUJ17t0zpzMCLHhrwz?=
 =?us-ascii?Q?cl6axR9ugnTyxV8sqPzG9ZaOd3q9Y1rY3FZFRd7gihVGp/2xdgUq7WO6gJ2+?=
 =?us-ascii?Q?3i5gAUao9tJUlIHqMrEOqJ0CdRIIyfu5VCtZZAlRPVLBZMobV5FDvxnIplwZ?=
 =?us-ascii?Q?btr7qr3NCTwV2Af15qScz8xl9nWTA9b0zyLAmMPYbuGxszFsUOiYkNxWBga7?=
 =?us-ascii?Q?pjwKv9sCS5jf7KGn6leJShCyrfzygqYxQItZiGCItW+quENdoNqKj+3zJ3w2?=
 =?us-ascii?Q?nq92eo8TBhUQWLKFPs3ZKlK19hDDfX69navPThCnKc7atpU//NTjufnyM8O5?=
 =?us-ascii?Q?FkDhfRZ5y3/CTKFOHfM4a2ws6myMg2W+dRarmp1k4a1YbDpZ0uktarJoLKJ7?=
 =?us-ascii?Q?QWDOnEyGyzx6f+S0WHDz2uCaKo/2sqXg22srZnc499A4PFjlGEQKB5mswz5H?=
 =?us-ascii?Q?7qVH3vtuEl/Gae7sk10mwcCZiDbcN8HIsEArvzzJ3wBD5bGTr7/I1ew+z936?=
 =?us-ascii?Q?i4p1dj46bTt/o7/dRInstfILwL6C+tqtuv1p9n0evAPP5I8qS5IHcGmABeSD?=
 =?us-ascii?Q?zCsZBAdCRElosTWd4v6BIJAVer7cvmOn4yZpADkIAa3jiiknN5jO/Agf6vDq?=
 =?us-ascii?Q?gSLaLjgGoroh81hJJJAQNMWK1WXbdQg8rDHcis3V4V12q7NoeGuLTCNoOTVr?=
 =?us-ascii?Q?MJhPED7wuwa83STNNPzXlVIfA64HyPwMjrAlQI45jG2fIiCG/RXAcWZzTe7L?=
 =?us-ascii?Q?sa9wEGSJXJB+bZoFV6995sMwLwJb/Byg2Y4/9GuuvCV1s+ZcEuX8xQyTNdGv?=
 =?us-ascii?Q?jH3X2Cw66tUA40FPcyhJI2mwrKs2rxtHTiVCGLr5fgDgyZ0kOyDFPY7J17BV?=
 =?us-ascii?Q?aUYT+eSfcpiRLWZg02fOCsG+SdwWy8LLEjM7GIhYWqCah95mEqM/dA5YsJAQ?=
 =?us-ascii?Q?Zyt/9KMW+tR8pUiblUon5M3Ey22K8vucIC6jhD08BCFvra8p6ucWjthODWXB?=
 =?us-ascii?Q?2nu6876nshJNXh22HN/B1LsjO0UBXXQSI0HfRjzoDjiCffjqdUo0F7zUA4X2?=
 =?us-ascii?Q?Uyj7gSAyJFxLD/kFIGObLcb+iqQWN9PBHkn8AD17?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8bede7-adba-46f8-cf75-08dba175f246
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:06:55.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCwUxs56ga+txMdbcrlGvJmHpdhpFgXs+03nloSnZXbWkBu2fDs7OOZ/rmycFFPGG1wGY5OTT0DNw67teEIbkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

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

