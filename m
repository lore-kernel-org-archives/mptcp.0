Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D82847E
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ch6Xwqa8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDnnIcVanl4kiUuc1fE61dw9i/XbeQqqnbiLadmeRA0YXZu5bh47FIEI0TfTb/YPSy8toey5Xgot75J7w+k5hNuQzLDA2s/rQ0YA2grGzcsu1uYxvOrniEx8RZBqWRayrximDH7Xq9QGJYdHi4z9Z7Z5ZoPp7YXMz/+uBslPvb8v9RBi+EYQFIZwddOoPTYwvlni72v91n7J5pA/qE7bfxO9Tu3DjtgM0IzH2N5x5p0+h2OG6vaVQo5ijjJiCnUYM3x0qhgAEY73CAySZSN5xKPTSL86UYcwwzz+y3K3s29lbiFVyKY0+Z4eEVh11rP4iaQNm9EEgrDN/uqL8vF+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvniUgWGT98EC6BjxOjf2Js96ZH4EXTEx413NmW7VDs=;
 b=NZ1lX4671qPtweEElF09J1vgmh3imT6u3eRce0rTHCmZku2AQ64bcI2IWxuEfWhyxpbKh4n7M1Hr8y61034Szs7SeYFXVlfyWmJvoB50QGPSq4/bd/yfaoVkotRoz34zgYOd4yKtrsFMP2Kv2VmF9ppfm8fb9wtl/TdHBs5vTtFSLkfzn25PjgvT9w3ynIYeqO+gaK0f5IW1+xPWtnL6CIZTTtRey+DM6mrhdSvwPZbmTnVvzPcjcNrLJaIM8n61FkSIl2BG5U4d4Dc23UxilnmSOQ/zzSIvGJBCD8UK5MF5iwJeRQg0SKIbWV6eUHOS7Sc8TGVQb+PZ7fKvESqtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvniUgWGT98EC6BjxOjf2Js96ZH4EXTEx413NmW7VDs=;
 b=Ch6Xwqa82BXuAPHYRLNH0LFS/uVCXYdQdj2mrx1XNdcr65IrHnQklOgUhFTlBFa4DP/QVGtyyTgF9bR3kzz4mNOJf3uXDyC0EEpyg1s793HBcKsllH0EJwf8v5QZdm/5SDWMez07MqRqpROQaAqq3hEBCIERx7GTQxj3hV9PeFsmfkIOgmcPs5s5iAAFL/XBmpNtYxKu6KRP7OJ+kOjloKyMZGxa6IudKOmoNx7tM4v7rOuKii4qGgSAnkTJX2zmsO0TWm+0RPuQ1UwCnW3azPUNBrUe55MtOZeII6NDOERzA96ZnumeglTu1nkkWG+MniJfiQtO8K3+3e08YQs07A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:50:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 15/22] selftests: mptcp: flush userspace addrs list
Date: Mon, 13 Nov 2023 10:48:59 +0800
Message-Id: <f240170818360247f2c6f2632d3d7623dacbff2c.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: ac695b2b-00c1-4089-41d9-08dbe3f348c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	slvmn2R2aMy1QJDTgeAz445oW7FK9YUdH3O56KpET643go9MHNBhnmJ0K9kz9yYQv6Mu2E75R4imDjVNR5Dsw2i7SAZxT88JdAhFIWcALhOKTNhC6ISfbZGMlFmhDsFL5tMwj9TDrX7h4ypev8LAGTbQTwRYbvpOArnWTt00iTdaCkL3FiYurYVjW0z+uFYtiSpNwnH1T/ixdlR4roZ1YAnt3fJhh5NyncM+rvRyt7kvLiYI+jvTaop1vGWyv7cuR45/u1f/vGC/5/Jrw8EXjI+0o9AsMq3c4WuioRrpYGcmNJe3LU5QzH86CDGkfeUdLHG5d+m6/4n0V+/fgbR+wqswEh4hAZfd/Puo7oC6IH5aoZw/Sv3I/gmZkvydOtXHPr1mgHg9Hwj1VFh1IjzIabk4C9xYmyPvO8yRTl9I8FVzRpl+vOoYww6ljI3h0tyT+VJsnDJb8A5zsFjP3E+KXPHAUKFobRs5G5vGHLt0BZ/TRM2565amrKAAB54CcxSP0qm9h0Jb3ZAzU1j3MuZ6vdjQ4ZJV9931ucg/LfOdceN3/292eI9JfTAoiwYVawoV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4744005)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8IPjqvFEvXzfIqg1IujXchrLkOJ4EM6NEx/wcGZn5BIDrPZCNueVIk3oqSdS?=
 =?us-ascii?Q?gFEfAf64IZ1w2kwBtkjHGOeGr7bRdpkRfrte+fDPHDV2f1sRromMqF+bV586?=
 =?us-ascii?Q?2T3CgeXsu4vgkHnOGD6DihsMVVjXBXrFz1lzJ3ccX1/f09KerajAArCkXDZF?=
 =?us-ascii?Q?5SOuKs+KWt9s5FdxrMjcFPkShJFGoAZNFEKjxic3T8Jg4+vcG4ywMcc6LUlQ?=
 =?us-ascii?Q?hv7621UuTDpyDTgTpUNwD/c201jxMDbCAWWznuXSML0cyCyBpZbOg0C/mgSt?=
 =?us-ascii?Q?TLRFkHVxqI09h92XBSTMJTCP2vUPflkz0g5/+21m2NxY3KB9YB5/BdNrB57K?=
 =?us-ascii?Q?fOh/By2ab3rHTc79Z+J4vQcYMqEF//Xo7ZqD8s4Pc8kDhmcFr3g9TGVi5mSG?=
 =?us-ascii?Q?ZRyKoiOz4aG9NgVRdRtHuXIp3PemonlpozrQK5Jf5HuIaR9c4MkyFHaGJJMz?=
 =?us-ascii?Q?dssp+1TO43y1eZhByIiPgGJrDFIIHOjRID1U2jmtGaqQdaIBJ80WkJVIXsh9?=
 =?us-ascii?Q?HANmhUACIckSzKu8NBBaNEmxYRJ132HiuBEZKW0+pE8LeJlAi+q+r1j+mavm?=
 =?us-ascii?Q?6K2JIeF0xG97UhaR3hS9gaI7xz2eb+yVZQ/2nGyK4DiavCHYlL2sroJVnXcq?=
 =?us-ascii?Q?bd9HPZp6pv0KVMQs8DubWVrSqZhxEI/xJiaku/6zB2jkaBK+tv6pjgch+WPo?=
 =?us-ascii?Q?5Z/IomSfdWVqfRuuSwvKPhg5qXd+0FLt9Z8EidBwmvggiJDyl/wTmrkIbvmi?=
 =?us-ascii?Q?rFHNxJX+YbIF/VBMnYilgwKQ/NAxgNnGRG6B5Tusi6z9r6XAtHM1nceVN4/J?=
 =?us-ascii?Q?ttZPPcF6a6OUYLhymKCh3Vu+crApRLIqKp0+wz/fVW3/MUn6CmJt3Qcpu3qi?=
 =?us-ascii?Q?wlb8BbnKufE8zmqjbbW5ffegy8CQCsWmR7DUiNpuSiHjaUs/CscodUtQGAI0?=
 =?us-ascii?Q?jWFSgtv7eLl0W3m3xjYvvaW0NY9uiIA1DnYnkjFnBgLe36QD2sVb/LNLtLzf?=
 =?us-ascii?Q?n7EzQVrAX+plHGLOCPheamUpwHArrzAD7EMSuHD9XBq7cVRYz55E0TJDQKQw?=
 =?us-ascii?Q?eiqxUie5UZaJyxIgrjm2fvaeWJsGYtBbQ2WQQCOkgEQtAgHjLO6xJtptzBJJ?=
 =?us-ascii?Q?pWI10Iznt/HZqP7wbFZrdP0yd5wazGh9MelG26woyzY8H4T1TbtBJZTvH7/m?=
 =?us-ascii?Q?/x6G+GdWibEiqkks+12YZScqqUMkG+Neo+wg3BcZRga11o6Qt4KmJyWK3D3R?=
 =?us-ascii?Q?gxhRQ0LPDWDllBA4GKWlteyFSTjCamk39K7Hx+0a8EsOJOjCldfpvzeMOiXH?=
 =?us-ascii?Q?XTSNHzIbAOVkDIMzGC0nX8dtMkdfMA5QH4zOiHun4cpfeM5kB9aGxjoLOG0C?=
 =?us-ascii?Q?ehMWefk6k1MvMQH20K+B9s8pbYI8ENPY/ljUpaS1/1j8X5RRhTtf4TUxuWKg?=
 =?us-ascii?Q?xWA2DR2aLizUxwEs7Q0GdiuF+4l0xRaOXwu8LvgjC98e3pygtK2+yfBSaZAJ?=
 =?us-ascii?Q?OLS7I+4jH4TlMM8ThqtrbsXq6ij6z6LZhPQFeaRA7xRe/r/i4u47a/5v2lYr?=
 =?us-ascii?Q?pf9J3bR0lR+lm7BoDU3V1bbVMHGMYkyvrUWFRzS3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac695b2b-00c1-4089-41d9-08dbe3f348c8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:24.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHiafs5wdnGXowkulNvfxQRUPZYRNCvaw5XJktz0YqBP0Nqd6zBfBRww1drjPKOpClc4TmWXvWP2nHvk4UWqng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch tests newly added flush command for the userspace PM. Add this
command into userspace pm test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9e29251eee15..ada523c160ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3461,6 +3461,10 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
+		chk_rm_nr 0 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

