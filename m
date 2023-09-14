Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29EB28E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvEU+bBBFDakHbrrAyakSRRrMEiLmZiHrwIdiJ7Fn/AdP90e+Wnmak/p4jN7BLvryA5Nqq1VxjubKlJz5bcdeN7rQ8iOn3reR3tvRDXyATckDGMA5ZisuRSV4VvNd4/6z1Z0cKq61kyANrrNoSalQLWA7KKE8DZSAxsdFginCjV/IVpUH0Ln1XbvGAQ1ht92hBJ9LfVS6vPX1TgihhTr9EXtpVUAbpf8lBvUkj0zLtfhS9Z/avfm4k396dmp+bSICPzkDlmfricNR9VSVBJe/w2etwLP01vHZ7eR9KRG0MTezid1c7u4HrrZ/dWyLP0sZ1tvRxg6b0m/txns9hQDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dsnODTdx/yklo7aQJ3vRB1lLa296B164qRziR3tmkM=;
 b=QkXVjyDlA7dPcnnFpcS6jUVZR0wIjCtThAaCKt+uH/cztB8He9miAlXCQgEG+kcYwim8gW7v4eYrhcHB6zLUvHtuE95pIQi9oaskvhLKTx5s66jZLryNyqEGfV3apx6u+1mGJ+8TANKYEE53T6vQbn7QwYG6LHqQYWAnjbC87+EVpDZgKjtcL4OXSba3uIw2J0lvuTWoPJjfOXZV4LaKpjNcy89rQrAo4JsAmTD5pEssZ+YH/8urvfDk4mRSFZhdfa1YudnztcJTYquTNDmxZ9jGSqDI36a07Vcb3xbl3UJM8Q/P923q8Zi7Um5yqnE8rBz8vq00myWv5EYO/Bkyvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dsnODTdx/yklo7aQJ3vRB1lLa296B164qRziR3tmkM=;
 b=Mupp42/J2arOejQYI8pi2EfxTWAqxhp8LkmP6aH/e2WvOTMZTVUHUb3HOffH9sJe/UifI0AfYlXn7QLdSbMhqywJyIU0wl/rp8Pk0cE9OrGxBXx7DH0WAoO4YmYwESz730BMlxYdniOq5xBLddFEqykP1WlA+zN9CYVRtFxP+et4j27C4s3IiUksW6X8pHwuNlnuUJJ08jdlJD17/kT0wXYwUeLvhqIkZRa3yzCQwsZQjsZoR9sSLZV99rk3v5qVmqLveMivFCiMz3qEK9utg4Us7JJ3SQbTKIwrqhVgKQNcA+Lpm9pgUvi079AlfkBGWcWR9yKPygW8YnSQFISoRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:50:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:50:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 5/9] selftests: mptcp: userspace pm create id 0 subflow
Date: Thu, 14 Sep 2023 22:50:20 +0800
Message-Id: <5cf8c16baf7e7aa4c82adce81d2f251ddd8b9b43.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b6eefe-9ab6-4256-a577-08dbb531ef6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SligfQSe6AVQqx8KRirtyj7iK2KCBlG11EyDYsu/jRg1mz64dm3M+jV6afLVrNTnwKbeQJHuM82pBp3hfBGl6E/M1CvWOPj+/eQKC8nIf/qjpZ/JPJVNi10hIEtyQscI+OoE4Bdj59WxFf5o/GsBR6KD2pJ6u5lw5ACRbszO0GZc/zKffUt+WupxzTEPzMigpe1CbQRB+GmxH+dki/b/Lj1+07mtkD3o9ljI1+z3m1rKqn+EopkGkiWTT/yRBN54oHn29bUOXblHSaN83JiFUWI2/6y0RG0/MP6Xf0our1+6KvoXZyuoW6iXU8oFADgP0ZBiN1msMSm2p9xk60KuTrY3M4flRjyHlzTWszgLad8H0Ny3j72VSgEGohjctItFBp2XILKsjq5d/7XYsdYCah6YJPh9oU7OJZj0isLEz1Nyxc9dk8bS2HmWAi6rtQsOc36QNh0I3GmF7CGPM5pkygZh9uqUcedvJeTN1DLfCZHIH0cItt6ewLVL4ZplM6X+Tp1fpORVXiT6Dr8QXEiZt1lRo5t5cPco8rHdyO0EV8KRljGyJia/73m2WAB3IrgEHtyNrtZwZ+/0qIBYFjGnL74A7WT+FN3K9IBDQj7tjig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(8676002)(4326008)(8936002)(44832011)(316002)(6916009)(5660300002)(66946007)(66556008)(66476007)(2906002)(38100700002)(83380400001)(6512007)(2616005)(26005)(107886003)(86362001)(36756003)(478600001)(6506007)(6486002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EldVu02R5PL5R3la9T1cFVAXHmjz4+xOtMBcy81s9bGfHYZ/mRDz2mX8rUMG?=
 =?us-ascii?Q?1GbYJg6SXTtwtzgW/KQq1Ry1E9kW8L1RYzFFubSkZF2iTWndAUIe0BZwCFKV?=
 =?us-ascii?Q?jL8gWgg0sGEyBW5K8Z38895g2PrUtJ9lbl8Jo3KMox6wtZ40wF0L2x1EaoFw?=
 =?us-ascii?Q?crHBmNliCn3VGvWpvwtwiTB43+LYRo5Xe3WlxiAkQ8v9aCoiVZ8VubRg+rCF?=
 =?us-ascii?Q?0RIhuPkl0rUqoXKBV4mfXnuhuMNntlh781ItHd0u//pS8lHFD7eW76PBaggI?=
 =?us-ascii?Q?Co9+G+LNKQKqgDuoc5oNS4Libh/Q9K0IYHjFQnli4RmTqfwmdOxBkMIPYQDd?=
 =?us-ascii?Q?DQneCHL3Qobz77rycdoBShOYar5OfTgs7zso0LY0RweTPtXI86RMpJ+c2S07?=
 =?us-ascii?Q?4d3p/q3nRfl45XznRnKMJIKrTQwC/AOpNkVxf0gf3yDsFSEK+lxTkGlZKZTp?=
 =?us-ascii?Q?3RzIpEet0HEojOHUhDNnpyiC50NOWEYQn3fjBPzVDiew/xrCGX6QGJo5yO5Q?=
 =?us-ascii?Q?odr57yrI+/+AArNesdEbZHurxI4fXWgEdA2ckUOPLSsqVpOruiAoh4mJSKKp?=
 =?us-ascii?Q?9/uF57RR3bWkbgsXEiSGfoYnSlnSQySYR/swWKpMjQc00jD2S+OlTirNMjFO?=
 =?us-ascii?Q?SE+vqQxxZuWbzB3IRvx7twzjCVvSKYQvpspF9JHi2r53dQo+Kyq+wbYY9Jnj?=
 =?us-ascii?Q?aICNHgLyJyR5zCGr8Lgf7AvwzW9FAo16Me0sKBa7SnaPTrdrveS+Svzv6xz/?=
 =?us-ascii?Q?LUNJctK+NX8W9QvXRYjkbKiEJdKJTIT317+nvUM68lqvv0+QeuzfqULupo3w?=
 =?us-ascii?Q?6hQhn22jcqReXpjw0hoDbYUpRjeQFCErf/OexQ1JzP8Vpt+bz1yzC+huipM0?=
 =?us-ascii?Q?WmcgFkf7ZWGGE4jgcZH650m/CsVra8rN/+rA5lIgu4fl/Wp+EgBz1K9CN4zL?=
 =?us-ascii?Q?oia7xjM0OAQpYurfmTNgeFtB9ou/mwVUDJNGRRI/u/A5RXKCspn8UXBJJYOx?=
 =?us-ascii?Q?QvqDaAhKFTQmrq1xTTTO+EuRFzB7PT6kK240QGsXE5hNpqtqRkJ8VzHbS/mo?=
 =?us-ascii?Q?/xvHiZSAGq/UvS3WExofl421e29nGRpA6klDy8+PiB5/u2GlPVVI4lpwRVOl?=
 =?us-ascii?Q?cGT8c3DT27kZZibxhhornqweH4cuUaSnqXLffm8N5RW/2jgBBcKW2dfl5spK?=
 =?us-ascii?Q?LqTIzv+p0K58HQWV/258uNYg3xnnFqTd5uit+USnIYedhghoue/+j+SuapNd?=
 =?us-ascii?Q?F8rIBHsQH8U6V0NU9SQA14AdhxxPRgqOjBKxwA0HfUkVenRxWkuvNW6DI4d9?=
 =?us-ascii?Q?NAWYW36AKHh295k42zIBu3ynY2iv1jYk+mKrwDcakabMNexxm9hfltoq+JOg?=
 =?us-ascii?Q?L3XdHWwF2Ji0VHj8fBlcDfJr4Lb79qECmOf+GBLyIeTuSkEvxuiQJClr1HKK?=
 =?us-ascii?Q?VJIJZr9fUPnlNmuOZLfraMONELkhkLtP4RSJBl8BuqJFqYde6Eob8gWRhgmj?=
 =?us-ascii?Q?JHKPAbUPP661wLeTiAyotZy45u5FyKyezWHgNq7gUjpKDKLwl+of/ZOF1ex9?=
 =?us-ascii?Q?RDzXuMLd8ppB/7eNQsSLqw2kCwQvWRkG0YfTwbCNFpaX8GzSbGGhhHdmdPX7?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b6eefe-9ab6-4256-a577-08dbb531ef6a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:50:27.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xaNLJeRkylt2/OCE1yRuCNQlaNib3fB/AJm4l9Xzr/FBTRJXJrOXOX7ZUS/2wAT9Q1DjFC61EDEeOcfzcvfnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_all_subflows shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 966977980d5c..f1a7e04815b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3456,6 +3456,25 @@ userspace_tests()
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

