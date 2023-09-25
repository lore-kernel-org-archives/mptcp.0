Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0520125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsq0xO+wTUkj2SVyDRWaBfB2H4ZDl4dOODzks6fU3+f84BJxnSwdFSvfrm0qaiwR7i892epQx7XtVW6UsPMw7DTayb7IIwSx8rOnLNhWCq3MK6iXQyxOj0EGJ9+uNkd3bf5OQyXp+A5qV+xvIl/wi6wE9V4j0+D92Dfihv9NSLVYWhlUmBU4fx3E+/o7VuObJ+1OnYoZRGFh0AqO4FQtupk5CLJspjyhVkfKqt1B6SUfwFw3sd9JdY5UOk/EvaToVFaPrwzeeA/Q8zgWkYBuFFUCbtInkWPcNrjxnt1xpzNSIH3cTJ5CYR5bPfPbqGZArZ/XBE/qN0lCRbo9Cl1TDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh0AThWy/1iY4ohouWlu1EMSH+myMG0i4Rl4xquRNfo=;
 b=e7r0T9igme8YI50mU01N6lih4ZkazwqPCNlKqVyR35qO8n0h56Gf9nKn6LpaKJSYy2QLGpJ6B6aHEwZ2YxMqOox8SWiHTOfMEEkkMuGjqGagum6mtZTZAqOuZWhbbezGz2AH9B+WYGD4+BQhcWcEImLjD5EN1S+pRJGSFI640wMfXXb96aTMibSpjiyfb2Ltm9pCwjjY+/Wz27F1cZovi+XagivkLrtoFuQi4efHlC2i/+BsPqigznzL7Y5eVMrkoTyxqdQycxWW25kwT1TDy+rkEe++F5P5ZpwSk8PCgFHfFFHrWPr/2dnbyX1aFI8AOBjGDpIm2JuyJXmcQuCO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh0AThWy/1iY4ohouWlu1EMSH+myMG0i4Rl4xquRNfo=;
 b=Gs3eABpL6F/CEFHuP4T7RwPRIqspgaUebgrMMuNGsLFhAJTgLYawfp/jtxyIY7cYuEQ5OEhf8pUa7rpXkHIEGX6IX+Ps3PUn7NhHa8pf51cnUJbYQwgtyVYQNvxkhpVQMDdTDXqkWk6sfwvVB4ONgIjKmH0QbuxF5P70x9s83ec2ClARZ7Rb9bXGpKkNfHLA1s005tS04W45lD+QFcJ3n2/GT8R5Ul+66aQWlaKLTcc2TvtPVCs+IWxs+Pf0iKrvYrz+ThJeeeIjTbU7U6QtVg6TyinxPsOHqk0XVky4EnTycbRI9ZasRjNBh26r2mZtEru6MG8uSAI07cFUxvWoGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 14/29] selftests: mptcp: userspace pm create id 0 subflow
Date: Mon, 25 Sep 2023 16:41:53 +0800
Message-Id: <3c2da4a3892d87214612539e587a131ebd5167e7.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 49290453-64b7-4807-868b-08dbbda36dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NpzNWCMj9h3LuleSdTPmauZ+cU69T82x/lAJAYbIFFNRJqHDCKX4jpQ9Qp+zBHobdi1C9TdqFVxWi1KlJZ6gjVQDiv9nMJkGQrghsJE4pdA2z6IuEjewDsqC9l6Md/ONOj+31EvDp9eaDUzWj6WDjYBgBgusQj7B1E0Z6QCHGjinQbLxMuMAQUl3GZtJG6TmvFHv/vHpCI4HdTSlKJMAWk5Q4R0aBTcAfai9s8nVZtgKnlLGzOHOyYPLhjiIILlOBO60+7dH3qG726rj42/MM40MmDdfkliAfb2o0mTMQXrCtYRFZwD8FNZ8Ttm6rnOUchfqWVFmtM6MpBndP1iGHLAwwesVUHHHW8XEUXU5TaVFTFNKKDQHebYH+tfrL03oCO2kAv8cARazXwvsYMBfWd2LrAFKIIQDsMzxcbo0qsgjpFu8QqO0JF1qJKTkXlO5S0/bOFDdmA7fDxqHy+LmUo1hB7y9+gYwU3LOMuokgkga5AZc7J4fJu/UETuRehz1jaLBvxdaLBp8mY1TE2mfLBH0fxUwR+MqTvCbOxvrtjZ3QVMaPGryhrY3LRdododY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zRxywZGFOfyU4SNejQPKdhXRmKARQpTSC+WU0bPrLXemPW6fo/oGfSbR5Jtm?=
 =?us-ascii?Q?3pWoRcQh/tQYMDFb7C3W2oOJLaEt8vMQ3QrJVT2v+UqSHTKV2ZJ/39KlZFBq?=
 =?us-ascii?Q?hIYUs8SdFuz5oCkJCRG6IHMwUwBlsckXwnexlGVp4mYs9lVgaxC2Cbhsn88B?=
 =?us-ascii?Q?8AWZ+HAsqRGKjNDZRls/cwUbUWB3GeDlodBpBC4dMCQbIdWMmPhhxAPWw0wi?=
 =?us-ascii?Q?whrlNxH4C6RevHDStiXhSX7uPCzprS+l4ReCJZ+uUgmhiIe4iOZv+iJrhTdJ?=
 =?us-ascii?Q?JUUxQBpdkHqKAZ8HZpR5zwx6NwLZARVNjudvxJoqbbKkWkXLfo4j7uiBqoVB?=
 =?us-ascii?Q?jSUvmI7qb0IdB29QL/Sr0FYdV4UytY0I4s/ndBAoGwmKXPa131rhDji/RToK?=
 =?us-ascii?Q?eeNXjx0nThC31RF73kMfzwtRbh0kekfCldelp4sqpbbLxjreOipUXJPBUzmi?=
 =?us-ascii?Q?5WeV6RsO8lo0IPIrv4Trnk9aor0pOf3X13BJJEIAX7R/ox/H+Fn6FIdh1Pdy?=
 =?us-ascii?Q?S9JBx98tJCm+8nIbigZiJd5zexPllfvGkNRmEtzVgv9jz3QgzqcbnvzoLb2Y?=
 =?us-ascii?Q?IeWYmIFyYqCxVkU/yQ0su85nskYXZ5xXZlN0qL+EwjLqqFr9PMocCpRIn3q8?=
 =?us-ascii?Q?+xat/isoMi7kJBQiQTAkDOyWBuzemgvw0kP2ta+del51twYOdLtiVjG4WkBc?=
 =?us-ascii?Q?SIcvLDQ6/RQwddxwshPxg295spK0Dwej5DJKxN5QxuZMYzqfTj288CW6UzrL?=
 =?us-ascii?Q?vTaJkzcJh18ki4KIsMJxRSIzBQeeIu+CyBhR4bJlO1uSjlAlh/EgLNs5Rxr9?=
 =?us-ascii?Q?uvRGsFl4ezkf0V1X8QCIZ7qmnDw9nSf4NCbabfbGfI66lLUolrZBIbSCeVXA?=
 =?us-ascii?Q?Gm4rmDynNRlNurr+8sw+YjjQoPaFWaddWyu/i6AupV1RId/xhyZAy0hYlGmR?=
 =?us-ascii?Q?H76oclePg969f7vz0n7PRSTWgXCHbnpF9DSatC93SNTAwBoDsXVt8vuO+izV?=
 =?us-ascii?Q?zsyvDyMi8/w9mGoMJQKoey7ar9UdfiNTpHKpBjeVhZrJpWCiHaf1OEH9IBZD?=
 =?us-ascii?Q?VN1Ly4hS+o0L253+/HnW6b7XQD19sP6abrTTa+wLFoiLSh2xBhp/gEKSEx0p?=
 =?us-ascii?Q?6nZ/QJjfL90r/GWaw6mPQho0yNNnKDC+3I/w+HgDvZttAeiOzAoLFcFE7i0s?=
 =?us-ascii?Q?19w28lhXHTanjYy0uCCK/VuuG6dxUoXzueyDO4w4B8IQG0NHiIZ6cqa0+xHa?=
 =?us-ascii?Q?7IaZD2Rt9YgPi+b2CK7FJaFUYu92MlZBVYfHoybURA9U0DYIeMJz9ILjFgid?=
 =?us-ascii?Q?77W5+8G0HEWgdCBeSyth2N2iMsgjY+GHc/mMvlaQTb6gHGquMjsG29AMc7W4?=
 =?us-ascii?Q?f+dc0nOlDgm+sPspyE7NdP6VmVIGVu6PELXYYoEjtMehZKn/R7x586rhZ+yv?=
 =?us-ascii?Q?sOnlLNUEX2t9vVA2efgzD/BZcPInqdqM3rP6k1VTKMdSCL5JNzGsl1tLrwrR?=
 =?us-ascii?Q?MLtbzVk8Lun9HDspKAIDPvFdHbOmaAWBwDV0/EeWGl3OLgkSTuVwriCfaKK1?=
 =?us-ascii?Q?llZSDr9YJE5VqlGMGXeqmjtndQS9qZx2yIOmSj8T?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49290453-64b7-4807-868b-08dbbda36dd0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:02.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGZcRzpIYRemPCT/qoAAiyk8x9D9cJwYfzvvykDRqglrr2DdoK+afyeZpKcEDgF94Za4qQ6jwxg/3QgksRQ+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_subflows_total shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ca75d2c6d415..22aa69db87ab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3468,6 +3468,25 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
+	# userspace pm create id 0 subflow
+	if reset_with_events "userspace pm create id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
 	# userspace pm remove id 0 subflow
 	if reset_with_events "userspace pm remove id 0 subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-- 
2.35.3

