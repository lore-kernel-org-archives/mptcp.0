Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2073.outbound.protection.outlook.com [40.107.14.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA928E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9njz6Y1FSiGsDdwhccBoskeqqWD26dgrKgQ/KmR9LpJ3xrH2mUr5KzOhgYVLSY5Ls5BuByaFHbQHWAiPeBFHczd4eEY8V9Mc0jjcffZBhxnVw02DixNAJd0gbqpZ6y5iewURK5VvIlojQRew9YfTnc5/V49Vte3+pyBkZn45hbS34F1b9NHld9K3Bwg4BjXYeYeGYtaGq8M+7Cp2hLewsvWhu1tg9wSUjmMLOpbPjHM3FPQXjO6qMrUvXQDhaYcnoujx970Dy+WQbwiQcEyckioqhxnOh3wwb+fszHlcqA8CNxzCiU5EMZuo2hDNuikS2105bB2370EKXCGu6GE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnhT8++e4G62qHflATsbElmQVBoAy/bov3RQQiiRQdc=;
 b=GZY4h/tyoWmlURr3uN5ZeYO2WWAPip6h/4ygAIVD2F5Y7kvTsuLk8XawRx2b6SMH+G+LHE0hH1DhnJkcvRQrnAjDZv9Gpdj3/e8VqccOWnvHFPH+UHIXcP0jwBYtxeEJb4c1LjI6jW30SmNHM+maxZY2RXwt9Uc/pUMfLai6kpSf6vQQhRPC8yVSNF1UGRtgXh2HXFlHfqMfbOIKLraufXpDHHveO1nlXFw6rCFpkQFpM3NEmz13PgGxPLjO3kO5/zDT6o2/eP/InyLIEQ2Bci7Tlwdink0qKvzhveQ2UKWk7ycYQIRmRGZKf2YskTZBcgVi0vZ+Vr34li9AbNIvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnhT8++e4G62qHflATsbElmQVBoAy/bov3RQQiiRQdc=;
 b=TTvNk7MqQ4On9FPKYHKqthhtEl4d4UinPnPPx1DTPtn/dT8r3uTsid4KkpJ94Lp/fIjIvdjOMYykUmpKlt4j85jRpqzVwTWf/RcS0IknEyNc18HWQs3RAnlw5vanxogne4oVh9JUuWxjmg3dVT5pAHdk8IMvR+GsllJK/nEmreSMi3XmAOAm1pE+Q9KqgoVXTHVzYzmGdKcyJEodcf6fcX15dx/7jl0mdzhnaS2i9AAJFJxxx6VYiLT/rCpiQ8SqC+PmU15hmOtmwmU9mvnhv8xsagrm+Uz6sM80RnxEKNQiJaRi71alZcXI7IsltWgbIr6AyevzJ+f7PYY70pNiqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:50:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:50:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 3/9] selftests: mptcp: userspace pm remove id 0 subflow
Date: Thu, 14 Sep 2023 22:50:18 +0800
Message-Id: <004fe2ec6a8487878a9a1c21b6d784cc538d0a07.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: fed0bab4-1559-4ef8-db81-08dbb531e548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYe+i4grYFWQNnH8Y7jabPQAUKCatVVa8pvcu8BzvK6oj7fn0HWJvu9zhmfFLXxhc0LmwnL7MLskLZQQrXVP+s2n6UpStEWA3T0nANL0g33YJ2V8VMk6Ky5o17vcpC5Ia5j1hIhl0bNsXRGMOfh+lAHhlvq+4WxIKkmJ5ZbQ0p1ilAFipcnnqqSwwUD4KIgR65R+tBvKAvUk7h0FsDmyJnPsGtp+hz8OnvQdsMgAPbzzrY4Bb9yIG/g+4/17sIVP3iwMwwL4yEnZZz5asC1T6Mz5ITb6itipc0TYlIO7KhlG/cgCjAjb1Y6VzKGVdplQmn5lumgJElfyO4VZ7f8nSE39i4jmECwG0rNoPu/d+7Sztnnx4IOnozYRBaX9YbFNUACcV9pa1BGA+CTs/JnbBKJ45kY/qXgXgcm5bw69j3wUe/I6wBaYgWUiuxRxI9p9WOCZkQsM2Ru6Zz7HijnemCvrUCZUhCqqMjohg8ulAKaguu5XzmnmhgApjHbzgoCrfMF8u0u3G8u39ut0lr7Mf2Ae5KidxWy48ZgdQ0sXDoIOVjvG0BXgMjRmeh2uj1VLP5sRJ6RIbHB04SfVcd3ai6WZHYS35j7nyhtwkpkFvXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(8676002)(4326008)(8936002)(44832011)(316002)(6916009)(5660300002)(66946007)(66556008)(66476007)(2906002)(38100700002)(83380400001)(6512007)(2616005)(26005)(107886003)(86362001)(36756003)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1e1HtxBUch/R5ec9oL1jNa+0l96XM2yEbgvLTiMYjwtOtykbPmF4BlG0ZJSD?=
 =?us-ascii?Q?LHbuzBK8LWwTVEZaFs/WQrI/846Htw+2A/2f6RJLiPfknx+eImU8pBqXg+3F?=
 =?us-ascii?Q?i6qz17SWTEeUmIHMW7p77BCOfCMfcvXFYBlmtd4oFeg0P+18xEYcwArb30fI?=
 =?us-ascii?Q?QAlEb6Y1K6wrv3j7ieDA4BczYB9u/IqMclgHlGN9v9D4h6yaP3fxbnHR9Uhr?=
 =?us-ascii?Q?CWn21EnVM4HoJj96czCe/V3pfVR0J5dBv5lHT7xvUDleaUmVctoXXo2I2DXe?=
 =?us-ascii?Q?JyUHlLwNiV+AQYN0zgU6q7RZ9P66x2GZwbMJltw/JHUd1xynmzZYPlR0KA6Y?=
 =?us-ascii?Q?Bs5Uk9ZtmrJ42yp0TrqFjrTOkgzS31piCKM4X1iWo0weYJcf3Vf89Ew0UI/W?=
 =?us-ascii?Q?CUV2P4whKYafBqmAkqYENVRIflTYbdxb318nT+tq8/NIYxmPDuq4mp4R6DX8?=
 =?us-ascii?Q?52Ig1QgyQKLQUEyomWYhwP34tDpsmtI/dPHCooQRpeF4e0+xHxo3kGIKMkTh?=
 =?us-ascii?Q?v1IeRa+z8/dpMOl0DygEvFDb26unQgiliCm/2v5lm+0FBVtXRfP88LeTBvje?=
 =?us-ascii?Q?YwDZ8wq+H1kfPbFTpgY3WdmgoCNfy/s/TbEv5YQOUJGgE+TaC3hXkiEidwXq?=
 =?us-ascii?Q?DUHSDMGAP43ax0A6e8C+BDm8PTYR70yZx/twT9jDE7H8y3eF9pacOrJ/3+97?=
 =?us-ascii?Q?qWkSum1it4XvSJC4BpJzFMykYnPjOyTOmOXF+USWJjhkFIjqvqvSgcSRVoI0?=
 =?us-ascii?Q?pSjXN2xpaSxyyD/eYUWhp2WdmDraPAK1+l4Sk5h6FYhmdHMUg0qi5k63OPvM?=
 =?us-ascii?Q?ZEpFoCf6r1ARg3H2S4V+alPevYt/2YOlr3wNqnsQdigXd5HiZqW3G3jOFsf1?=
 =?us-ascii?Q?6I+p+YraZKOlcBFgZwVWwqQhyvsdTOsxSlqyspfR7pq1fIuTUQrPu0TIHh3O?=
 =?us-ascii?Q?2QdskFgJftIyXRwXGLWMxVUpNFO9Sa4FX0FN/W1IyIC+Q0HT3M4mta+UspRn?=
 =?us-ascii?Q?IX8ukmr63UadwTDOLep5OOorB1LEHQLDCdNnAH715C528Fvnl48yoFwzGnm1?=
 =?us-ascii?Q?YaXgZJCle0+VXHiNBD3GKrG+YzovPXMunarKB5dsLWILBjzgBGX0lKuICHhB?=
 =?us-ascii?Q?UMy2LaSy4u6k8w1XwQV1pchMdlqZRQhWUZBZE8qM3WndB9iEgyswk+sBCAjo?=
 =?us-ascii?Q?NOzUPsJ13jVTQM0vSpDQ9w3j1+gh3GGf3L/yZ9o+swZuQxKSXhH2fKLNYMEb?=
 =?us-ascii?Q?AF81Cw2mza5ScIWol31hSClAmFJsEPaD5w52B4W1cg7AwwXfwcsc3i2Kg11B?=
 =?us-ascii?Q?kEDU6V1jgvI6zJYZKZO/AZjfOEXNJ2woXQYxHKUo8IREsoSFalk7attyARXi?=
 =?us-ascii?Q?9plNIcDDuUjmuM58YWNjn9I7S7ju8zJimr8x9p/f93v/LBIe6UWFd0cZ5wiO?=
 =?us-ascii?Q?mUxqnWC+sMPnWaE9fN4u1nYEJks55DHPMl3vQ6jLh/NgB6+yLtVzmCgQ4yh/?=
 =?us-ascii?Q?7gLVZFMwVAOV6iEk4mj31H5ux4n37n+J2NGvlJsy7Qm3UVi2qBrmfI/SyQif?=
 =?us-ascii?Q?fuYYt3X7BKtcj4oeIlL1Kx+4MnAfPAQ7/pMcZw6mfFb9SQJNWt9RT8E8EzTZ?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed0bab4-1559-4ef8-db81-08dbb531e548
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:50:11.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7AKllOBjLBpj/G+3iyKwbI3oCg2ngVgDnv2Jd+d5VN3vPfQitWjNqHLJ0xp2Kw7qpGs5JFBNwg91+VGHHnOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

Add a new helper chk_all_subflows(), in it use 'ss' command

        ss -ti | grep -c tcp-ulp-mptcp

to get the "correct" amount of subflows, including the initial one.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2ebe1692edeb..966977980d5c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1881,6 +1881,31 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_all_subflows()
+{
+	local cnt1
+	local cnt2
+
+	print_check "all subflows $1:$2"
+
+	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3430,6 +3455,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow
+	if reset_with_events "userspace pm remove id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

