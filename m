Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1561D523
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB240ysPmtuNL03YttkEMXqCt+4JvEQn+Ae1F4yHo7VkEVHi8FYwagVphnb9dFIcaVjK0TiPyU+1zwD55xTRs1uQZeWLq1JRv87cHAMdQ04BegItysNh2h8MP36822yk2YkfolhYau6BwuSHtFGhPhD3+R4BzA3wlEaLEE6efrHVppqrNEr6UCnOzTgwcPuDyztq6VY62TwIpdBVTwsCpreRcXE9BrfZPdPI/fDhJPtcbeVl2X2KbwKaXw4T2+/WDkx91AVFXfG7t7AE90densd3mt9G9OCtWqY7DsnTjGr4XgHhcJDCIhZZqh/nm0pSTG5FEVkyIvg8ItY3NZS+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdzTA+Wi1TMa8eRaCBMlqRu9j65TKVoz/MNlLSxQvso=;
 b=E1XSFSDQsfYmDfcBrDhi1qeEBbxmLwgl8J7qV1z5Ut+8cmblBedKidPxVKhL16ZRSpcYW0bG7F7PGzGgCofese4BqbX43Y18JZF8qOwPUj+E3yNNaK/Y1fkTHUNG1/utRlUZHODDHYHvcTwWLGrg05OWjuoMDqXa+XZyipHE412SgdA9Iv2NcQLrN1ohFNp3kPzGA2GFJbRjFIHdRXrM/n5jLqtc23+Ldoa9BfqWAX1uVVfNfHmoSnC+JXAAWlqjKbHRVc3/LdlPaaJaY0DsPJ+o+bc0LsUqeYzdWTkSOtPJnGljU3WcieyPoDvt7Azrbj2EADlC8/MDB7J/bJrzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdzTA+Wi1TMa8eRaCBMlqRu9j65TKVoz/MNlLSxQvso=;
 b=SMhEZeshtmo4Q76YtKcBQRghVJkXm9MvUcDa5Rkjz8upgTUScCzuZDzFopw2zgZOp2mlRfqT0bWxinXz0kC5dEFsqXFtry7hPbidkZ23Hnxg+HrmkMB2hHgV3cFtRbV0KyELW1uXtNS8xG0vBa0iUtb05MbcQWv6qwNqOC/wITQWIkgP1fzjPKPR3Jo4ptOqPA+WX/gTUfIAzc8Fwe6xHfKK6V3/YV/nVmNbtnmK/OYDgubN4935PWbiO6+sOqvvHuvyszGvPI3s/Cc5LaZpZxUs6YmgUx/t2SvUnkeUHtT5Vca4yRkr52vNQ/ieUZ4sSrZRTgz8pl1t7da6u4h45g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:04:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:04:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] ss: mptcp: print no_initial_subflow flag
Date: Thu, 14 Sep 2023 18:03:26 +0800
Message-Id: <20230914100503.8886-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: deab2e5b-35cb-4e1f-d321-08dbb509f284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qqZ3azc4Ol+swtsF5pws7D0CXdiRw0DeN/veVGJGrxSlFXbUufBMA0zQ7yGqJPSTpS9wWXO7b0MbOSYIfy4u4iLkS/ODyx/zGe2278GkTHzrKQ5holhNO0fsiObpBnqDCCNolXu7wL+jutMJMYcy7dWoPyfzAFF8b/iJifjJhBiQK+hVA7uLkmk3tZNcsFYGQS8dHuap7rmfmQ99N0dfE+pyYWFyNEVisRcWarrgp8lROwpJm90d9YjHf2w2Vssx/39fV0auXHNFUlV/NPWeg4WOwZhWs78QQfbqegHoXkd4hPI11tmBY0r1vodh898JLSlr1mZSAtEOJl7jMcyk2FXt47XVjXQcWeH3n/TJvWiK6grtZ56mTJf0rBEZQ3zHO3MKIb1xgssMNUSbGCiCml3iEwpqIlzBEFtpp5blp5Ii2O35PyqkxwuF3nSiFO07VzwLWqPZmFoRL+4Mm+3XWutl8hpbIdpf2kKEVmvsKS1tU8QAwcQlRWNFyjzzABzkE+ej7asmBw4ta8KxuJLI4aS7aLtMOLr+3vRgc8mSjOVi/m9Cnn+ZMCTRXgLYKJGz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(36756003)(2616005)(107886003)(1076003)(478600001)(6486002)(6666004)(6506007)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(6916009)(316002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPfhmmZNeL84wbQTrqzfzXomnTmv2L12mmLOz+Yt2BVsJWhrC4Cl4Wr4hBKR?=
 =?us-ascii?Q?FbcyzuYzZF6Yt6vXARRtI3pfguNpSgs1HAFE332dEz/q88LxbH+Q+WMnD5yv?=
 =?us-ascii?Q?3hjgDkoDnVNAt69BnUE4+iUBNVsgxoJ42xuqbPaa7OpIukAeBAvyJ1aDeYlw?=
 =?us-ascii?Q?FwmKJT/+0XBsXaYxEeQCWCr7CRcYCF83UwFhPo099x/ZekdLFBzDx3/FIVkH?=
 =?us-ascii?Q?4BloEz+ElXcR8SyAfO1c47MXvnhJlUJuoTUaC0sK3EY48vE4/2Udc3jf0MIM?=
 =?us-ascii?Q?VdsND4tNWkTKIzBZhBnx4psjWj1z6DyAja/fhIGUwdHBGlY5/efHayHI+jyR?=
 =?us-ascii?Q?bG3CJBUwGQ/VunIFA18v/qCgKv/qca0cq3i2W/xesD2aOKiM5ymx0/JP9APH?=
 =?us-ascii?Q?MLkck+mlz5PWkBGhYdJkrcFt4GfnWTJdsK+vZnL8rBSqqK24ggDtclLuihAo?=
 =?us-ascii?Q?S1qw4NPSESMkYH6V4zFXA1t5EovYtZ2qPcFil/L2wO8hnDaramrGpoYJZNBW?=
 =?us-ascii?Q?CjmFNHIQY1x6lgoOa7RK8N/83l7QMuHQ/fslRhgS5uozg2aOxd2KXQVoLNTw?=
 =?us-ascii?Q?3CEaq2Bl6Y6cF2aqIP8AwQbpEqPKauceIf72yIUoidhVmXwqhmxsrGFR0rL9?=
 =?us-ascii?Q?Q9jMuPJANUViEYiSvFkF8z8lt1giMPjQ3+4UakCMI0Gm01O1iLa4bl6F3pSD?=
 =?us-ascii?Q?nv+zryHEx78pBMmO27kC6PumqckW53WPsL0BneX4KD5wdPFdJvoPaKZTdddH?=
 =?us-ascii?Q?DSANflIqQQExYaJBvddPlb3LyFsm36cctsBTYiFT0JCM6u5fuymtEBjCgYye?=
 =?us-ascii?Q?A/vusSwrkdRlSC+PJaWjXHACWiiA7Fuy1axjGdE99ToYnVojJoNMvkxCljYj?=
 =?us-ascii?Q?Ccz0/PJcHkL7vpiXHbNQPcxwU5OpJ1hD2YsGyM42luVmPfGNWJMiJyEGMFCX?=
 =?us-ascii?Q?4OWhVCmXPEMG2LEea6SNYlW92yH7sxVIVa2uoQEB4JwIlrxszvEJ9utlFv65?=
 =?us-ascii?Q?ew7x/wRVSDAK8KLrryEii1C8GoSG4F2dkXyT4RogX3QH0OO93nV5SmgNVsZJ?=
 =?us-ascii?Q?Ff/BI98XHvMHH3O5Kp77WKCI8hipURL4q/0+OT/iTkNgQCF7SpQpg+L5W3jV?=
 =?us-ascii?Q?JWV0eRdDUxhSSKA2V2tfiy6mc32ojTwpDjwpuC6cQFwI2vtdJxeBroIcm7ym?=
 =?us-ascii?Q?s2RcwVSVeq2B5ba1ZzOWJHeV3atFe/Rzfvh++8owW0Lme4AvNSowLYyMLsVq?=
 =?us-ascii?Q?HVfoj9wIdmtCJmdhz0Qhuq96b66aYfTCDSohy/RiwaH+y8mE5htlxu4bHyh6?=
 =?us-ascii?Q?RiDp46MXsaudKlNK1KWm9AQ1xCL/Ev7jgdmZJ9qzIHpZzJp/nHFv6/UoLmET?=
 =?us-ascii?Q?kXY4ZiPwGaW3t3x+6jp9LFmGN3SzxnjGD6DcR67FdP3f6+Wa4QdztK6FjdKz?=
 =?us-ascii?Q?DQJgCCzv5fiDCBXK5MeRR7R8RnhCnLWyfp2qFUNw0QwVVjfT5VTbVPcg1NFg?=
 =?us-ascii?Q?rcAqlmt5W9Vq9ikDop/ibDsNIF3P0Vhx7Bu/FnMdwQKwjGdXO/tyjRrTs0ny?=
 =?us-ascii?Q?STuZ1hWwtx/UNJr7V9tIx8+Jr0gWtmaRhLbd6Y8f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deab2e5b-35cb-4e1f-d321-08dbb509f284
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:04:13.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV2cOPei0aPFOvLk/Zq7cr6jOpzc+st94LeeUXXxzPsDY221/i5U5hfMcdPmm+F6/RqhSjgM4cmiLFKyLuw9Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

A new flag MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW has been added in
mptcpi_flags to know if the initial subflow has been removed. With
this bit, we can then compute the total amount of subflows from
mptcp_info including the initial one.

This patch prints a "no_initial_subflow" info into mptcp_stats output
to show the MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW has been set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h | 1 +
 misc/ss.c                  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 159d32f0..bae24690 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -105,6 +105,7 @@ enum {
 
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
+#define MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW	_BITUL(2)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
diff --git a/misc/ss.c b/misc/ss.c
index 2a584015..e58f6087 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3247,6 +3247,8 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" fallback");
 	if (s->mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
 		out(" remote_key");
+	if (s->mptcpi_flags & MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW)
+		out(" no_initial_subflow");
 	if (s->mptcpi_token)
 		out(" token:%x", s->mptcpi_token);
 	if (s->mptcpi_write_seq)
-- 
2.35.3

