Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150070.outbound.protection.outlook.com [40.107.15.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920433DF
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 13:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fykOaJw5mX3Mj3VU7s2b/nIQt5uKkVpd4EOefuiaCT4SoSMx9N2xgpGL3pANgldvXdiCB3GfSaGlTuBK1uYqncF4LGFgQMqXeN9lsQ+hDrvzGJ0L8Swesaxk0jPgnKwhjv+YsDH/TOa81vGdEVMQZUVHQ2PicVKauOaWQQi0IvrTscHizmzjbge3KEakI1ksuZiALFsbQFubxgMSJBYS8atVkwPCdEytC82Xym3e2PTeTOJLJD80YCFldsEiSWVf6ZywTtlhch85ooJe5fPtUwbzewRuq2tnJanBUGAtpgnCqMvkGxkUkb7hUu3AIDGIarhJ+nb0MhniDc+Eo3Uk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vFoZxLSjdYrpXOIQJq0LTBE2Fdp9ENB9oaAyxZ9quM=;
 b=BvBu7WGIFfpyA7E7df3eJcohrXbOG0NDbejtn3s1H1WrQ2MZXyZt3cM0EpAqiTHhEKfD27BvkThHgCg3vAzHs41HO70UHl5+MvnrYCi/Z6aT60oIRDj0o/9lYTOk4HXMYTNyFAmtxXqo2/K4oFFbU9VbJL27UkrgCKB6+5PGnz4ZQlQ3dpGqlFCpcT39swSlr1vqC9JflqvvsLGx2qTCLZHLWzyr/TnQ1ZH8i9gezu0v0YFK6VtID5ekHqewbap5vHjgPaUjJWbJBwVO3jtfrHi5b2AkZdh6fvX4mZ0Ydf2nl3OhlyrbndBQVw8R5Z5gwLvnxM6yVRSenhaX9s+l5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vFoZxLSjdYrpXOIQJq0LTBE2Fdp9ENB9oaAyxZ9quM=;
 b=gJBZennZh8BXHXdTS2mEOtNEQ1wqDnkQ7CQoll5cxisjO0a9pVgAd3sc4EywZjSr2u1GYG+mnlESRO3JLwRoH0MScuQwhrr190Rx0C6MkX2sUknFxBMDmtrQKgH4uQeo/j3NLXVyq4fn1AORr/h5uiSQqtwoIKbrSe+nHk3Y1iqvi9nP2BH/XYgE0CfSFSI2z0DS6nnz0ST1GTqcyBMqgH23vJojLJ4BwGKLfcqItOi25dpqAXJXv1hKMq5CSCe3NpE4WOv2mxzjuQ8YxOJWoLs2VHZDnZxsQ/x/yYFCG7ZmpAyU4Pgk0aaamYZPjZd0A+6js/xIsawVn9MAYp6nyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8882.eurprd04.prod.outlook.com (2603:10a6:20b:42d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 13:35:37 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Sat, 22 Oct 2022
 13:35:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: use max_time instead of time
Date: Sat, 22 Oct 2022 21:35:28 +0800
Message-Id: <20221022133528.31996-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: f714e7ef-ea08-4b53-e981-08dab4324d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wX5rKIWtRrqJCnECvQJddGw0KF1zyd71clNLJsj24z0dH9SOP/RfLsniZePLnfAUMEDWgWhtBf7WgFcODsv4DZqojWlFmkeYahxflwK/Wy2321/6cJYelo/Z2iLT1lgIfNUcSvgNIMU8Xskqm2rsmtoOffKELWn78KjxxE5pCHdqHkS/21Nd6gxpFqCLURAQdRkycwuiPSqxZR2x211a/A/NsscqpB/FltsLKn7FWXRca2+d58W7C6P3HhBmERKwcIYV/kxBwQusnF2RCNtCiy+tIURYouHC+Hb2N0xmM2QW8peHlhFd84FqFk1u61dMZAiAwjMCagYrpAjlC3ib+j66cO2tHKjGAiblB9S9OAfON1h6cQAddZfJDK8NF/WS/iPEQHuVwiE7Wx22wv89wDDz7jUES/hF6jar5QBSaXgHZngTvxsTCRsnPGnsllZTrR3d/Y5t0bLqUXgJkBtU+Ef3ppJ/ssAInxxfYSTdpVH9x0X7qCpevk1JfKkp21gmAhy8scqU8rEzMjrsg8IiadiqrXA70RPmmAaQshuE7JkKd2ycCHLf2oAxmHOpq2hCbP2TlqG2VI6HywyZSTr4VGhQf0Age+e8BEbPsyHypMxk/G4J3cUiJSA2mN3hIEiCrSnaPk32S3j6YzPg0hVdi0EcOPaePQTi3ji6jzITqLP6WdHfKjArCIUMtlfJRbvG66PTkD95NtBLCcc7dLL77GMEFWWx/E0Tg1Pc3xPZwRpB0/TbRovjODWQuPH6GWHe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(316002)(478600001)(6916009)(4326008)(66946007)(107886003)(66556008)(8676002)(66476007)(6506007)(6486002)(6666004)(6512007)(8936002)(186003)(86362001)(2906002)(5660300002)(1076003)(2616005)(44832011)(26005)(41300700001)(36756003)(83380400001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dAav4cP5YR8Ew9NX3UcmDJw8RC5UAYUcUEMoR6en70KSN3Q2CBoUX1lOjxLv?=
 =?us-ascii?Q?0OrdCtqOXWgFsmfjrswdjiA33OwFQH39dL3Bu26hH1U5FTpMgIpfDxRQYvuv?=
 =?us-ascii?Q?UGrzy4w4Vcw61aZ6XoKDxDlF3rwCRLiCBrOqoMHW8sH1YLvH68PgRaED3ool?=
 =?us-ascii?Q?Tm88zxo+BsZYprZ+D31dwrIKGvnkMpvhhxb+yBaEcT/wKnAdmWtT5d6wWEbI?=
 =?us-ascii?Q?BKhF2HA1gc1uWM7YoKYhebOYuPXarMx/XuLKG5vSmkhoR7kgZ0VH5zuFVRAS?=
 =?us-ascii?Q?xbnTimYx0SkctmvU9cwk1F67u3EEQz57sbmLA480hO45QekKoI8R/FK/G/Vc?=
 =?us-ascii?Q?FRczmPSN3QJtXOWAOPdbeMWuYuoza7i7luq9x51FfBFNMzPmOp2vKOQxShxI?=
 =?us-ascii?Q?I1HEFkbl2COBkHlzKxIJyT9Or1wJxnVK8hdEZkawvoYPhM3oDFdT7OpzGtlh?=
 =?us-ascii?Q?zGy7+UHhz5ayCpDt/IDD0NyXmgvsGjBMyDW4YomNH/iBi2m7V5FSkuBRQT7K?=
 =?us-ascii?Q?yjBBXp6kzDbARHh8TV6J7wd86GFyC5ZIslYrF6Yba9GyBVAespwJl16jIKMe?=
 =?us-ascii?Q?JTLWV77i95RXzVH0+3u1WJUb1PjTtBD74q0F1GWLf6ZJlT4ZfvhEDbUCCPCy?=
 =?us-ascii?Q?zbmKAjS8L7ZNIoJRA87foMJ9xLxTft4qHkuDP9U9uKTYSk/s7jWG2iI7fkzU?=
 =?us-ascii?Q?IXkKXSSelyxnHSh52VfxdwiDyZbyvFO2ZOP83lZGvkUI/sG+YSak6aHUjjBM?=
 =?us-ascii?Q?izgBYp3Gmm0XkHCXbaPyhwVrNyo/pYt1dZC2iTsEcVo8D7CcnpDyS6MF3sMo?=
 =?us-ascii?Q?PBNooWyGNlo6OcPwvgwD+SRnmO8dHZrzntvKEDrMDaLrdcVEp9foHceurI9e?=
 =?us-ascii?Q?caGYp/9+40uQWFjqHl8b6rMiGU+ExNdkP7czG5kZtMEDcelIRgJhgazokGW9?=
 =?us-ascii?Q?ZxuZdgJjxcADEnrkPxZhY08QOxiD84KhivAGFyQ7mvfWnIXLTuCN0AXf4mz8?=
 =?us-ascii?Q?ARwog/6W9AvQdBsbHg77hbGiBf15ExTXCcgiDuo6I6wM8YVNRZ/WWOvn5tpf?=
 =?us-ascii?Q?yVvps/miHgEjhYA1rsHHiFqNCJ6YvyamdfcXYQfIQLu9MPHdTVokSzdDpdu/?=
 =?us-ascii?Q?vxEauDYmUW1/2b6yypgdDLviaQX5g8pq+kyGWrHEqJGRUfSIoGghwu4RSZFm?=
 =?us-ascii?Q?yUkgzz3hktw8Ax6PbDbmzt3XGpW1pwTq/MsFI9fBsaiZJ2isLhE0YvK7qATI?=
 =?us-ascii?Q?yB/gzcD1VXPcK0GTfn3kSOlDNqPD9lDOYxwJaM67SDphNBLklo/gXhvYY/UH?=
 =?us-ascii?Q?Rbd5n99vSpTsXengiFPl67O7Glgpjpjdso6AV41iz6OgJBSqHouRg0n7NQ9T?=
 =?us-ascii?Q?R3ZD6lVRBR9fP0gwuB9TMbApV6/S50pYje26eqmfC5TVnkxixXzjyf3Evc9N?=
 =?us-ascii?Q?4CG4Lb4BMgrONHuC+nGEeHx6IgjHg9S0ODH9ma/9awksByoL2s/s48MgOS+y?=
 =?us-ascii?Q?lqiemId6/iNwIy2dMJRvCv9gHyE+Nb/F3nZSO9Tw2oPLopLl/3v/Kh9jk/H6?=
 =?us-ascii?Q?pVrAszh4bCwe4ltHmsSYMT7ZVdFqGKqN3k9w68XvKDvQ3d02Ny8CmQGD3S5Y?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f714e7ef-ea08-4b53-e981-08dab4324d82
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 13:35:36.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nII7oJQP6Z9NqsGVzTdDgIYfByxskVxc56sVb9drQdwpi9drLcNUB6jtnM2mWP6Ucuf+XaoE8lZEZhfTmJudpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8882

'time' is the local variable of run_test() function, while 'max_time' is
the local variable of do_transfer() function. So in do_transfer(),
$max_time should be used, not $time.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ffa13a957a36..af70c14e0bf9 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -173,7 +173,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
-			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $time \
+			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
 				0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
@@ -181,7 +181,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns1} \
-			./mptcp_connect -jt ${timeout_poll} -p $port -T $time \
+			./mptcp_connect -jt ${timeout_poll} -p $port -T $max_time \
 				10.0.3.3 < "$cin" > "$cout" &
 	local cpid=$!
 
-- 
2.35.3

