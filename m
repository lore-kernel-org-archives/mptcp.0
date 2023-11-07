Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F471FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="0/V0EH/7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+TBIC2VjdxKJQ6t8UKvedyplzA/PSgfgIcQMzAI2opUmX4pPgTls8YuxlQWs+/ZeVcCM41r0sLdUAHaa8EGgeOVoznA+1pK8wQx29CYMAEIPddpukNwi3dEicDleIcbY5Ki9arw+4ifb5HBtKQHH3XrflfZ1R72RC0SQ9vYvQSwb1caXlBbKkaoCyBLYCfUR/4f8Dgw30D7CiVfhcd2SVRjvSMJZl9wrh+wc7/P2S4P6EmxpNwdPK9aLJom6ODIAaroLIvncsU418V+JsNrAWH/p3J33g5qVL4xc7nErUMWZPdxLoChvpZgNeBDTAhPke/X+IRRkIL0By68cRyrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIp5cD0EI7QTXP0DCZ+EvQq9UnqJZrrDxfcKnTTWKtk=;
 b=VJfU7Ps4LLBzcYQDtJ/fovYOrcGwNi9mwiLReTkWu5AStMONJ8glfuP26KTn9V/Sz+lIaCUZkFr1t8oWKlttLibH0l/TTCJAkKl9xOZlQXdWTN/ccNBW7VovKNG6CmwS6ccxr0CGBFau170TxdcskvIRI1+qSzReDJV4h0lJjhkzj7q3dhpP22jtGzgeidoeXbOuiPt9vOBu9f321F1141jRxutmLKRWr2tOC2EE5txApNzWtYPFZGkzSKPYNTo4QvUdwd1tvXTXAJpUre+798aWQKVPR+i+dvt59heJI1WOYfdEuCK2RoY6HAGYk/hx8o5PI0jgi8do+QnCluugNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIp5cD0EI7QTXP0DCZ+EvQq9UnqJZrrDxfcKnTTWKtk=;
 b=0/V0EH/7nz8/40uDKR1BaDVdJ4TVsh6XuBeVxTv8AXL15xWX9X2pDytsCAwmFV1bzrRmn/rT8hQdGm2/J+MH36ALzLSnWWkDeSHkOlKjiwPG9yG5GcTE5n10uE7cuKLK+gU7+DxF2+vAhQBBOjGiiH8UJsD5uZ9wNFSOga34HsBEyNY56yZ+/AGAXLOTobce8MrKbh7EGCnEVYEp/W9tSzj758z05jpOTA/Ol/8Gls57mHEoSLt00FAMlVHcsmkMGVJ4YXhCKTvC8oSGY2kWSs/kkY5dyB++uW9YYRC8xRDlomPWH/tjPEUg6JHlijkwOLcj/8GUMO3DS47n2/VgZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:04:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:04:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 21/21] selftests: mptcp: rm userspace addr with random order
Date: Tue,  7 Nov 2023 14:02:05 +0800
Message-Id: <d50ee79d99f6d35352223aa9d2f212ae3aea4219.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: ad56a33f-c7ed-43ee-bd0d-08dbdf5767b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6icbQ6nq70pptn60/FR++A0RLjxZtN4HKA9l6z5pLgI+ACY33jBEGkHkCTh2B7S9ZS67sDsH1jVLp/PDVB9FLjk3yu0paRO7XxQVFzWYf48gpwBzMsafVKbTJM5E2k6pSi1W+Jp4Ikm1x0uOvprq+khxkHxhLi+mC2kCFasvWujEbC4xaW8eChGTXqkCewx7AJY3qLCMopsMuMz8aYatylZNO1fds4hQ3tHpVmZeyIcrpmelCE3AxCt58qDtW7NVfO9DkR3JvCjO3+xoQ5MBko/ZnTc90W79XYnYq9eQ4iAun60nkjm+RApV9Va8Ob9e/8UBHf/hJDOGaZJAGSnexgPYW6knfT9wreOgHHbNZ5EBQUI90N3SIV0jJqMz7uLyyDnCFTALVSLfRhuPWNkO+jo3v6O9kRZNCf4fVb829kRjkicqLPzKmDoqmUACWaKSpqfyMsJtyi9Hk6pFc0WVD/Sf97zmMpxpZyLOfwCKLQx/na4kRjPF18U3IBZem22dg6Zv5+lRjyznjMkV6ey0bA3YB2utvjjX5CQ4biseOAyaTPTP3Z/HNuRgWxWCt0q8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qI45yr38irdzWy4jJYXq5TNN0lPpgbFt9UexdD6myxWfplwkkCCVrqt1QZgy?=
 =?us-ascii?Q?ZHEIphf3cMuDKnGO+h2Urg0kbET37as5hiVOylomNDlvX+v1aA4JYDZMs/1Z?=
 =?us-ascii?Q?DnwuFQ56c+Tohaa3dZ396hv2PzdzTlfm8/0f2He2uYQDOZhqeiFROlH5u6IV?=
 =?us-ascii?Q?vvM6xWRVmbTg9wzKZR+/q7NUalzQEQUlbAkQF4SVPIClOTOw2Funs0TLkAUp?=
 =?us-ascii?Q?ReaDtpJrMBGf7Jr9xMqttlHOMEswaith7LqzelF2eCouN7MDkNjsSp0kq9nt?=
 =?us-ascii?Q?iNW9sJsQBOvdx1WvYYwlBA3hDe/1fBaOAgO3mdOIANMt9bRKuGObvPeZuRVj?=
 =?us-ascii?Q?wyzopJs85Xn5iZxT6glCkRBaEiOOYCGwh/Gn9nNSXOykqwvWxIl+QS9cL/B1?=
 =?us-ascii?Q?StJEj4IgwLPtIkqDAz7l17d7hijwAW6KZBTe6mLRBJyAxx3OiC+SE0EtanZW?=
 =?us-ascii?Q?9PZb7gwguG6VYFTb1QqE3Cd+R1ZTz/DDlApHMmzf0t8kqjM6rDCIWzg9cMbS?=
 =?us-ascii?Q?t0rUyBi1+k4fJkt1xzedtiy2WMFwaC3F+47xHwRw3k3YaSawxW2nNtYU0Lb9?=
 =?us-ascii?Q?feRh97cYikFRFZCTx1GosrQjr5zSu1q4Kk/M6E2rcqIQNcz6WdjRQBy4Ioy+?=
 =?us-ascii?Q?GUkiqX/QrRMknNuaH+/z6epR8DfVtFx2e1DW1clYX8Yn5Y6IB7Mc/+09wORD?=
 =?us-ascii?Q?gbZMsroqyfocOaE+lTIIuRR4D5w7p2BTBB1r9n/6AQkyOeanvXKza6Bkk+Sq?=
 =?us-ascii?Q?7/KxoOwjdCOSzQrVUpZW/490LvtBXmqUXB8/0RG2P9B3L60uewweVYb1PLua?=
 =?us-ascii?Q?u3VY2Zv0BHAcGx7jSTvaoYrqZWVTGxJ2iYFdzQp3+gwbPtLvujyeDkL+hZoq?=
 =?us-ascii?Q?74n4Tw068SBsWdbYpplBZ2D/0WWUGF8Roz6mTp+F9rgI6HtMKfnqpxKOkrjk?=
 =?us-ascii?Q?qu/ZsNw+Uk0YoJ+eVBK07qqe1mB8QJjyRumG4yp8z8vy/lRLJNzTOth2aQDd?=
 =?us-ascii?Q?rk56WjqmHb7kmFyPrzULoMOfrWSa7NV+U0VGmfxx2MGfdKpv2WGHwBcD9t3J?=
 =?us-ascii?Q?jeeirNFIPOH+HjKsRGJvnAqUG4xymK8MXVCUwcsMlOaTVVZf7nQEEowCl+Jv?=
 =?us-ascii?Q?9FruihqBGUQJz9GhKQEy4Zl2jOon4VMQ+t4WEmh/6I49ignlKdjDmp40XWPP?=
 =?us-ascii?Q?E5Rdlq2jhWaaIRlXlmEgL8Put7AST/IBKwnut6J3WxKEih5mSoN+b7SuI9PV?=
 =?us-ascii?Q?LVSfdwLUpx0wh2WR2eCwwCRlh3orzZ0cf8UqmMSw/3Kuy/e10Z4i+nClhCfZ?=
 =?us-ascii?Q?ycH3ReQaDBPtSit/mn6tf3+H3DvKvks3rOtYNsi4XO3pqo/UF6NqqHUyl1qi?=
 =?us-ascii?Q?n8Hf1neuPf2sKhqcn5KUBdhfQBuqQpqyujftGPQMw5tFEAXykRhsuioLLL6v?=
 =?us-ascii?Q?QnQ7YKLteKJE1fUWvNSStbXks+KdBvla/aAy09hOTblOsX8UUFGfBqINXKDW?=
 =?us-ascii?Q?EMk9Gq8O9zCMS1OqpZmyqadZFmxmDt73HN8gwLGkuBKObqEdcTcEexPzE7Go?=
 =?us-ascii?Q?h4FXO1xzr5BXGd4PrXBSw3XRZKl3blJzN4QWmSdL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad56a33f-c7ed-43ee-bd0d-08dbdf5767b7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:04:30.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYccTdaeg7nl5S5RroxYNN/JHw8JTVcmX/8wPIhmdGLrYtfkN3n8OBQvuMjyCAB3vbXSVvSnGN/tDaLEYwF0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f922d32f4f20..8f7112cb120e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3390,8 +3390,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

