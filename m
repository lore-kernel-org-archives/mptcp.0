Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCC8BE7
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rpokZQPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUueC1EO6+5YSY4HdqQEV/+0OG9wIZicOSEBbQ/MYGhvRafMrxlfwpiiAViVeSQPrfEkc7DW5XCEsahlDUazHD8MzATZDd2Coz77lxJ/b9E1OnlCz46yAHne/25HSCIRbukyBAv1xXYm78w0CkUfHUu28/Zu0VsOiI6J1GlJKoYAojZSDCrPM21RZsjy/HXq6XvouG9sKGsbHLZueW3i19NQzuFUsCLevom4tpUDiUnQ8QG2M6nG+vNoj7cdbSvt8v+a1akN+Y3aBwSPt0+aBhYvgZDHpEICooQLjqntPBwMejTPxDjtywdhqUQsHx3I7JoL5NqgCsqG9Jfy7Uy1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN63uIWtDhQJ3budsnSs5mI4RcH0IS5fQQ9d7gfQalQ=;
 b=EwzdMoyGxJEhZG83ZMdA+8jj3p0uSfC3Noa/0OxDmsn6vU0PmrT1WyY+VHrAHJ0IXen6SPy9JXrBK92CWxUDqJJOwYltiTvdJC8pbX1pISJAnrdM6dzg8/uYvlKAdYHPKwM1asz1hjGsDSrNFf/7J52TviDJZGiCy2RDWyI5uP3tvwj8r07SeFFxSl+wdTY5OuquvEdNneHF6rPHermUhSfkb8qrAeHRB05TMlbNJMEeUMqvQ3bHJ6l3AKAk9vczCbgtYcrAYaZYC6PO04jcI5Kff5Dda93c0GBJcdzAQ92tc2zIffju7ELDVqDxV/XM3JKIaIhkxSTf/tuNdL6qfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN63uIWtDhQJ3budsnSs5mI4RcH0IS5fQQ9d7gfQalQ=;
 b=rpokZQPwqL8r35QIUmCX6SFn3qaBMXH34tLCK+4Wa1gCaeCvdqSg9W6rHEyodxbSk3eRk44wKsjXrGfygHe3TZCiGKUvJksZ/uXSasQwJ9hPRO2SpBRokI3/vkBFvxl0bDE4sX9DLb36SMtOX31NJuhmCGA0jbsggfG/nkLLX7MgkiIH0KyTFAt8EWSaI7iaIUqP3qRgYC/t6fUO71qi7kg8c1mOluueBvu8tEcJWSkXDkhlVR5QZqWN/tNVqhdDYgshtmHGLTkyfBL5ixjKuCmQbBJI38b64UK2gIPTt4J/JUa+6PTPBhH8c+xxTfaUbrvgAhRO6gSBr+SQcJ7NvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sun, 8 Oct
 2023 10:26:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Sun, 8 Oct 2023
 10:26:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 4/4] selftests: mptcp: userspace pm remove id 0 address
Date: Sun,  8 Oct 2023 18:27:10 +0800
Message-Id: <3738a4c89c049ae3b2832206390a39471331865d.1696760702.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696760702.git.geliang.tang@suse.com>
References: <cover.1696760702.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a78dcc-2e49-4ce7-6d33-08dbc7e904e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qUJ6nJbbc86bxGcLdrthnhBYPKGTqh8JjmaXMHtpM9L6/ca4DpcQ8LdTCsPBFCNNHf4hp7VFvSkcC+LaAa5FvdJqaN6DWQvLtWRsdw/Wf2acIL36a2DzUrDzkNWE4ZbKBV81vpCQWfvRLrffVX3cgWR/h7SmPShdjmF0FuJq09Q/DgUMbO4Lr8jwLvhQs+Yua2ynM0LxfzkV+bXwyy9vib7IaQKAHr4ScOp15eLQQ0cgAmVumZYZ5k0sfU32Ywhw2mOxMXG9CLhb4H8yKlpaXzYSH4skakuclcw4X6Auhmd/h3R/moBXGI0u9RbzGGL9vO10x1FPzzLyY+RYGqADm+ajs8gWk6JewqyqOK9MX6R2H03KyZrcdlihhliB54fvQgnBVAPZNGCMudnxAfNpMKQ9lG6rJyoKheKydcDTvlMmmzdFbJ8Ir4xOOciOxBDh9IZN8yQmppU65i5jaVN+Y5DvJAMFIgmEQDUExKBVhOOItsacSDRfgEKr3evzM8DY9hjZAtY7kmWluSUVuvIDLV1AGn0V9YH3LqJ0CA3815w9jRHIoPZ2eJp4WApXaba8R2G5JgiBo1C7R3+MiDU7zWDxW8zbBalo9LKfDM4d/io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(36756003)(38100700002)(2616005)(26005)(6666004)(5660300002)(8676002)(8936002)(4326008)(6512007)(6486002)(6506007)(44832011)(83380400001)(107886003)(2906002)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfGAZR3jtvkGifZTNCEQqZ64GD9uNMBLH4naIPjRri3HugElya0gauWFd0mP?=
 =?us-ascii?Q?kQ2yC2HisAT0VdXoNpoBVj0/1/XU88Wc+tm/Q8N+++BpPPbSrzzIBZKu+D5f?=
 =?us-ascii?Q?bgLB31nXkrlUN/653GhO5zmeOfHBFqYjfUBsCPuZ/uq5je7i1d1LTuu4lB7S?=
 =?us-ascii?Q?DLEGLxpm8o6+8WkiJ/e7i3Ry5XV4mFG0u84Ri5ggGj8iUaV214Fh5/MK6Gca?=
 =?us-ascii?Q?RERRn8U1zIgVAj3SFDaNFppll/0SKktLTcAr37HLc34TVl22Hb2TELuIfmla?=
 =?us-ascii?Q?P/Vh9DyqfwX9SfAq8luUNYwwZyI1Y3zsKWPAvA67g0MPCNepxKhRZCz33LPw?=
 =?us-ascii?Q?T8lUvC5PCw4sKoKsmc/Vgb/V7Yipi9FqQ7FBJabsj3yal0OUgFgSgVqrRNdX?=
 =?us-ascii?Q?UwPSF6uVclXb1dj8HKbagHL9aCuhO5bclyq5e1Hro7C7y+NPJ+uHbIioIvc4?=
 =?us-ascii?Q?hBQhvzfqYQRXEsdgJfQgyVevvXSpJeEWqjNFbIOilBFbuHx5TazoBMC58j2f?=
 =?us-ascii?Q?OMLfmVLc9pDVp5oeaSyx4xGz+9rUSfC9ns92PuyGXKV7lb2KuuVC1M1dUX0o?=
 =?us-ascii?Q?OiGhp+iJH6JBA10r47NZDOJwlejFjU3jeg2dmpWfKQWzEE53v/+TRiJjWMv+?=
 =?us-ascii?Q?veoztz26ONOWmHEVab3T3J1Czij5pXyP29QkcEvsSI0Cy1iY5oDUYfreq6aV?=
 =?us-ascii?Q?OYqSrmDHECrYpiw9xSyxaiWw+H4WxW0/8PfOoi8V+nQMDnrNhAWY+B6FiEtZ?=
 =?us-ascii?Q?/BzZMxyji5kV4WgHzN8hrLgH9xVDH5UObR3I6iq9COxepzQOpUBJKNxZzW1D?=
 =?us-ascii?Q?aBEFG6WQ5G5dFjuan7tsIek/5IWmaPmMdJf6Abv5I3e8adGDQVQjD6tO+EtU?=
 =?us-ascii?Q?9VfXBTQ2G/EgDsO2maIg4ANQMfClTXZRofdeLq7XYV5TY8FbU8cJOxhE1Dmj?=
 =?us-ascii?Q?j3IRtyMlVkYDIHNMyPR2OFV87i0CaqTUlj508Fx42qQ4vaLYk7Ejj69NaTcc?=
 =?us-ascii?Q?V4UYgCdQ9/vlvYjtvvlOVb9mP/8yxhX7DbWt8t9mWbYOXs1eE8xZgLy7jjwM?=
 =?us-ascii?Q?NmE59jLSE1Yb94at8uIY9i9eYrhFW8V07hrv60BxLo/W97nqB1uSGats/Ptk?=
 =?us-ascii?Q?sv2cBYxcJ9sgatxGVB6r7MolbC2B2uiOgwNie69WHiu6jIHz3egdvBpKncaN?=
 =?us-ascii?Q?UIq9BukbAa9t3rlwWrxWmjnjIYuIXMLEYFZyN7rauxsrgHeXlvr6kDJUHj7h?=
 =?us-ascii?Q?9niGw7qbv4JNLBMbAnyxtaxunIM0bcJ9y2bNZ+Zt+THDelXx0rgjh9JG8Eem?=
 =?us-ascii?Q?RL2ajHqR2rYPXwMWd6g0TC+gcV2SxkVxTg/SFCYNl9ifGFVJLCnnc5V8VkDx?=
 =?us-ascii?Q?u+8GUV1Ym5PMyuCseVacvyOKi10TEVkVVmNHWsupN2OfFy0UtopNqsTbSGTL?=
 =?us-ascii?Q?PLYHR0HzHDVyyLzN+Ko3h7ZgIHhvrbYkC1pU3Wdr8wiuDQD1Jbyj2hFiCH5r?=
 =?us-ascii?Q?JentgGOk0ikrITFqi3YF6r504h3ksfwsIjRK2OSeNlF5bYQqQAMDYhQ0r/j1?=
 =?us-ascii?Q?b56IcvO79VLs9uRDi8mknulZs91E+xbv5ecP7DpJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a78dcc-2e49-4ce7-6d33-08dbc7e904e5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:26:22.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoiFvW+umT6K9g444VqVwg/fH9jDqXLrAUUhg61ist7I8DLKdDYJsBnye0oyTmCjYIdnTLA03b6oC5WRYUUbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ce691aeca99e..30b9e367cefa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3511,6 +3511,29 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

