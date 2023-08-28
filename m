Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72F634
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 04:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAjg3xtC8sHTHC7UU6Oke6Lw0Vrgm5t/2YB8krmO1XsYCxGe/S9J/DKnQWlPo+G5D3VzzOVyJpBZQAkVqvxUGoJPMc7/bwj9YNiKx0AWKmNXqyMKaMU+w2Q80io6DSqcT3AnLzbNikgbDzmI6f6rFCCf6n3fGxqjev5yI2g5FsnzBIMbwuHVqBBl1fhl61SznZfW6ucHxT3GJNs7CuO5Kueg1ApzkC9iPvw7lgHRd9Yu5rxczU5iuhcg1pxwiMtONRroKlY8ZaDUb9NYBt84tpGuoLKs/ZxVHs+qu5CP+ld/0OfRrdrvLXsO0AGJ+ACagE55zdlmmCSYyMSHBMBO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JFBY5lMR2WTzOD5Kz94rfRjaXM0SlsKsUv7WDzxWTc=;
 b=U9eHfMGZcy3rudIMjfzF5rXoNGsQbGeEQ1TskSBIz6G3OqxGsgmOFy3YzwIa02b8xydLlswY+uKsK8xLF1PYYano3HHtX+uu7gcP1BjaJyrypa6GTjdHM6V0I9uNeysgqv4Hn5cQ6BhNgBE+ekFbdCRENurckCfZf9RBV1gVwFDQ7oA+QBhO375dMZHNDzjuYarLuuYjMPxDR1C1NEoXY+AFDVZRwm89+ajxwGqJ39ztlCEdUWHMSBNib6mJi4unaJhAl2zSAEhlJAJrRjrFGPYGbPNTkjxNN/4HxxH8LiA3X3rPP0CjJWH2eg+yL54wC0NOTvo6tx3yRRMcTovZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JFBY5lMR2WTzOD5Kz94rfRjaXM0SlsKsUv7WDzxWTc=;
 b=w+HwgVKKafks6qCK11ZBUeUqI6pJMmTFZ89ZeGZB6jDkwcIV49bL/uKGo9ACDF8dXRzLrAqLY8oP5aKWuXer1JWuApYQEL2wE8Jy9hVeCnDN3YrYkIL9DgbrXyyhAJZhjLYQ+hkw9bYtka3SjMvQwTR+mG04W8xSWQvN7QNnVaVPupQPhG2Z4x2hVFw8DU9/1wlZUTB8D3TbBbgC2rO1BBdXEzJoqmQnMTh1BGRUafGGKDkjRYJcQgxa6FAQxy7+V1Yerdbh5sAtGM+gWVkUwpOcKkgNSjmaz0lXCBWy07z+A0UwqhPvTr74aIdVbLMnlGom3JUmpHdv7DhRXqO6fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:35:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:35:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 5/7] selftests: mptcp: userspace pm create id 0 subflow
Date: Mon, 28 Aug 2023 12:35:27 +0800
Message-Id: <09304926f8b57182e6b0a4268cec16d4af827cf2.1693197152.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693197152.git.geliang.tang@suse.com>
References: <cover.1693197152.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: e5324f85-9634-40a3-c40f-08dba7804645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9dXw789wLGcDfUQrIdQdM3w9Y52Ev48glxm0paoMw8rkzZr7xxqGF/j4fWVa9uQ+aJtxDC3vSyAMFAGu/GybqxCTse7UZKGqCTHCCg3MlXXMO/U9D2jjn0VqQYc+aX9C4DyNI0qvy/L0VE7rtDrPAOvpxQmWVZMAT0lT4tucOyhadRsK3XcFLb9epsBBGaJ85l/9vakWCjxwQPKUw6F35/i3vjYiF1JFcXWo1Q4yCbu+BW02trELVJs7CIUhw7VA31lhohEILJOpvY/vLlMcbDzoHxEMWoO01NxZN4E0KSlPkKLwjdGZ7dARoQCr9jCOno0WjDx9XGVkUjFtSo4i74XF5QUnQCFyf03WFmQO9GvPn6CO4Gjgs8Ai1VPCxAkmymqpdbaEgrzo087Mh7oFRzEZIexkog8aBowaRXx8OQVQyBZk0+Lzta0SQWwjHY6Dle+sY2CocjP4puMX4Q+Id6eXTJV4hRPVRz/E9NGoFiPoEch2Hg4OIQswkKel7aNmdTntZxqrpJE73ge4p6Pm1AyEM+78s+S/lH6qQ/I4IcOETqfeHlFVWTPETVtI//rO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(86362001)(83380400001)(478600001)(2616005)(26005)(107886003)(6512007)(6506007)(6486002)(36756003)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQpQQckXIQZh2WAnHqZSs+3MrwYkOpM1Z69SJiVerkRw/DsnSh71cAf+kouO?=
 =?us-ascii?Q?TheqMXvygF5aWnRtPF+ELhU8ZaLXESt7Wuj89zCgYJF3oS/5efEEbpVaq0JK?=
 =?us-ascii?Q?+FyO0qXO2Q+/4RAD6eY0/j7VexMz0r6m44I+Ao+nysPgjuqsecrXUGg0crnK?=
 =?us-ascii?Q?yfnx63o81Ldhp+ogiLuPPJaC7YTkt/vq7MP2B3ICxfZ4ryDZqkA8WKflpSX9?=
 =?us-ascii?Q?6iJiuyyaGTtUlf7XBLLgb9DMIanrS8997yz4ic3UuPiLxaLMUzgc9coNMaVT?=
 =?us-ascii?Q?UaWlktYv8gmSOVj2qP3712giwWkLUd2C0pqAbvKD+yE1KW7zEU+UyEkdQh7F?=
 =?us-ascii?Q?JwKu/mXPJIs1xAsz46RrMlcGBeO+uSMuX9O/NjRTJHaQnBjyFe8WfKpZp2gx?=
 =?us-ascii?Q?DRsgmTzQrLsOKx5G4mpb3d8ir5DaJqkipzypymApsOQDHqvbQipsH+5NuChC?=
 =?us-ascii?Q?h3cA2KSm7uC2vsDPO3g+zMZZVkixUqfTQzAUfISwA8d9+1ueg3nrgd9C7qZP?=
 =?us-ascii?Q?y3W+itFQTG+GV2zubIy75zySGJdU2cCrll8XygNycqEDNRbaLrv4MUC44bjt?=
 =?us-ascii?Q?w8xM/wtd8Jeu2C4HdEVEX5oRAyPPxq5WwDjkRNsdYihe3rX2Utx+mW14qF+j?=
 =?us-ascii?Q?5xbtmYjSsKmx56j+OzNN9NJfoqedSuT+utnIeyWbyJFdlmg3fcWoqatLuWwF?=
 =?us-ascii?Q?QlXwJ79PxE/yh9xJduKAoCbDepJvASZ1Kds3KpJQvgqBP3FGJ7Loft/O9ROu?=
 =?us-ascii?Q?b9a/2hOflhU63GLvGFd7GbPWuiHI9y20ynLRIRXis7wY0k1xuBs7NHlaH9rC?=
 =?us-ascii?Q?djvrwrbCuKAFB1LeSVLqaBcU0M07FUHiYQfSjBwYBQB85Au4FPv8JE3Tm85T?=
 =?us-ascii?Q?IhXEzNHcf2/GXKHC+5HxHTlN78zLSR0pJVTF8qFZsmlNweOhAt8i4hut3Gga?=
 =?us-ascii?Q?gAJg+NcG7b+YJ6X5Sw8abXaySkgu1OmSik+PLL3niOHRooydS++M359ZA1LR?=
 =?us-ascii?Q?esGs6oZk9rJ90LMKj82dGMDXePbR+Ka0WwFyX+7RJ6aKbAgWZcE93gIrLsMy?=
 =?us-ascii?Q?vLsEoKvXC+BezhJD855CQQ0su4bYr4F+eF59e1mJr1okjTHU7vZ8xMt7qZo1?=
 =?us-ascii?Q?AGMHzjtEM6lFipfmuEzbSf8Iu/Ju1I1ZVLiTRfeT2DIfnF9T+7JozjScEXTk?=
 =?us-ascii?Q?Ro2kFCUPk+pYk1UALlSCw85AtMH3gcKFKUkHygT5PXMyNeCeUI9Jj92U1gqG?=
 =?us-ascii?Q?E+ZL+2pykM4s/H36oAIuQgMzjoZwMpwkWNQXLLaUIXSuaxhq0g4rcFKdhv0j?=
 =?us-ascii?Q?8qEfxnkFIIIhCw57U0DN4bgHrdmGuF1H8WiNbHrKHGvWdsKI/CMRZbxDnFr+?=
 =?us-ascii?Q?chxRGs9fwhFgI8H3EY1O7kq+96kK3s4GY01iDfRAffERmg3cfsHKkjNFCKfn?=
 =?us-ascii?Q?GHZjjbtZf0JRCo747+kXVd2dWOKDWJj85EFNU3bz2f+8yMllXBKlCGbs4Vau?=
 =?us-ascii?Q?OkXnOJDNRj5MVTKBhRurlUWtgrvSOnCrThumXm5qImrm1jIau8PG7pvECQG/?=
 =?us-ascii?Q?sFzMGqcSiKR/49SJlNbhS/a/XgCenrWl5lD1siDB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5324f85-9634-40a3-c40f-08dba7804645
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:35:58.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRrdzN7ANaNsWHrStIPg//3Yx4v+EBiDT5udriYpKAyAJYPSmxnSaafUtEtcn5kfNAOO/icZOOOzikLpU5+nBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_all_subflows shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a0a87b4c8d36..6a5019d1f95c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3450,6 +3450,25 @@ userspace_tests()
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
+		chk_all_subflows 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
 	# userspace pm remove id 0 subflow
 	if reset_with_events "userspace pm remove id 0 subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-- 
2.35.3

