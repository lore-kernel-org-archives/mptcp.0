Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F37A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 05:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs9Tw2YQ3VsNEDSjDtpAVDXZ6krN3sRTnZfdplpFhLq3eojoe/nHAPMx0dRrWD/5qrTh+EGEuj50il2G0V7iYrNiV0xQIPR2Dffht2+hOlnnkmQFsvXEJxs8hjeTK+5Uv45jNdSdQ08mRxsMtHGvcWRbhQnnibtAnXlj5F4zWfvUz3Klt94gGr/GRAzKq4VYwt8GM0cd4d1OWLms8Y7ElT7pTt/AflmyJqbcnH/nzHecv1Asma6i+UbVLjZ/nX7cYlmIuabr+WdKYLEcJIRW2ntDiVyAxV9uzSQJNjYhKypU9x1zxdiwBr31iIM1oG47Argp3FAP5itJaCnERDzOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCTX0cU4iJ6q1N/p4iGGoZypY3bAPqJjkStTyQ5qU/w=;
 b=OWZ2Z8e2GTq/z7YqWgnfhOEW144ysf9V19Xn/u1cmve4a7E964R87NLa1gGBk+gIvuUvEHwVhQBtokyA9F2wFvRfwpbLpiYQYPrSJQsukOcTyLXiPrFxURLo+i4O2UDiPyhQqLiMFlHSoKJyyh2fCJVobaFdB8dEDTime8LN0b+gWH0VXanWPs3a5Op5G4NNWtPT5AmerOkmke5MJGxKqPiOfSIS1X029u5jRj2wSb92p8CMUMqeteOszcMlQkh3qqusmqavPtrni0kj5iMoYbVd1FU70iOHenNjlnsXAL0yFvTAGflr17/Rn/Pumn7BDcF0Tvz8xH0dBIy1yiVgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCTX0cU4iJ6q1N/p4iGGoZypY3bAPqJjkStTyQ5qU/w=;
 b=1n2sJslzxaREV0JssfUSgP6t2DulDmFvx2rTQG7myl2oaHHdS6J1Djc4FVTDuSXEm9317kbJ5CZ19WMmuPie9YQQp8NtAdmvv5UrILi9wgvwcTACWgVyCWLhFwUlYjLCtvZ6mcHfJmd7B3cBV0qyuADp4vIjEB8eHWiqBKMjQTr7R7e3RaQJBZt/6VsQAW/VRRRtCgJ9RLomV0E0nQOcKAadGGrMkgf7IW2zqkxQmZDv6rIBDPTvcjh/wLVnkSvWTzT7kvq+N20GHU3qaarY6M+cg2HMNdjOowP0N41+HLmUQrnzrWhUbCgWmG0LEdwJr6QFHgAKQwqUKdENPhM3rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7880.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.21; Thu, 16 Jun
 2022 05:02:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 05:02:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/5] selftests: mptcp: userspace pm address tests
Date: Thu, 16 Jun 2022 13:02:23 +0800
Message-Id: <85bc880f1c3d5aa28d74b09247d6d6f5ebb27c31.1655355422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655355422.git.geliang.tang@suse.com>
References: <cover.1655355422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2ad700f-bd04-4609-82e7-08da4f55746e
X-MS-TrafficTypeDiagnostic: AS8PR04MB7880:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB78800C675F72325B91896B72F8AC9@AS8PR04MB7880.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ASLaSmbVPYRTpX6chmX5R88nOWYQXBNzBlug/otht63S9ZyporVyZ96SK/wBHjfbn8t8GE40REh6FqpAHVt34zj2jQwtUSrUE0FTgsf+toV0ToKENrGJdaqLFu/YO9sJctpJ29cOFSdXtUAw9RrKiM2qlmvT8ClJNtjGLlCwGb9NJjnMgWDnCIoNmMS8iVDpWwtvyosbyjPch4jUfNl2tViY6yg2aKcoC7+vpRmTrrU9T+VQtTp5JH4n4/XIYTbvwPu/m/+FjCPlpIFRrF7P7flGAWIXVMlgrA6dZ5hpKAlJNqdUhraIgZ+TuBvYj+2dTheRogxWlK9g8/SZbkT1ukZdK7ccWdacgUt7Onw1GKXvg+aw4LjkaHxKPnIHd9SBRq8YwLWJARBdLgHO7cpWS66yAZBGsA2CzK8UtjYYEzWyfJ1h0aJrTJq9FpfPhGT1k2r0Mlkx4JUgqJxRkxiYYte0cHeyo52GRqx+KZDT2dFrXfYxOfL5z1vDXCXV3znIxsWkkoWjUyCDtAHuVYBhiqwgB3MJxv3YNW+vPN4lzCI0b2Yl8L7I/xvNdVumdahxPxCq3M69qBZSjKU+eKGdkwRNa9zBdLN2I0SPzpV61Rl6qFl8OSe6247JCWjj7eY889UR4zQiBMmB4cbNPXP63KlWFAMiF8Ckmmp9II+f5MH7bKRuY8GdB3FmlHENP7Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(2906002)(5660300002)(8936002)(38100700002)(508600001)(6486002)(186003)(44832011)(36756003)(66946007)(66556008)(6916009)(4326008)(6666004)(2616005)(6506007)(6512007)(316002)(66476007)(107886003)(8676002)(86362001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nrnAdgIhWTB/JOYU7M2yl1M/1+dUokJI1sm4YpHR+imK/hJfHQDc5wur14dD?=
 =?us-ascii?Q?CoOtQK32Ue2LujrGyTDDvyjFfRVTPclZcbJzgm06Y838USjKZn7MsO/rEMOz?=
 =?us-ascii?Q?BOGdxACG10kM3/tFjUcB546gElt0G847DczzNyH8ffvik2VglqCQ9SAq7c4y?=
 =?us-ascii?Q?ffyuzDlEfdIay9KOxmHQ7A3WjFGoqZ0y6YW7m/dAhe+cTZ37iJqzdVa+96Pm?=
 =?us-ascii?Q?PG6eaa9MUBlSD/uC6l2CRkRla0Qs/WVxb1pq8YDbLK6w4py1YPDHsQH7oaSG?=
 =?us-ascii?Q?EW2QypHfyaUNYpSDGhMupLTRISx1Ak93RTprkSWbf4Q5bRa3FfrOykcxvCYe?=
 =?us-ascii?Q?gn5S3GoyUO/KVWVsY8+e/YAyeAkIGMj6Z/eWNv5uPeiwsLAL1DSd1xHHcwOP?=
 =?us-ascii?Q?6uE0r0sDIQogYTHL3EWpbbI6lYQInu0Pud2OxZawLwmCzATnDzjwYNEzbDwv?=
 =?us-ascii?Q?oykhn+tYAEVNZGKhAMe2yDAOMkC/bL1HjqVbDfOC8ATN4jiKpgCwIDJjZedc?=
 =?us-ascii?Q?PYnaJGUnEC7FBRm/IUJY4Lr+hGzLsC83vxWSvzgmNgPFh2tDBGiPFcx+3qx+?=
 =?us-ascii?Q?pn9bh1QJkXfbC8caIn1OQLNvg19gX30RT1u0FESIF44gAL9gQv3awlB9ig13?=
 =?us-ascii?Q?mwEtn9lnQCjkqc6hckOHMzPaAdegHlbG+XWgxKra1EZ6izOkCuj4puWQl+27?=
 =?us-ascii?Q?gPVNhB1a3961JgGNNNe0oFAhBjRV/bPt1JtV1DJJTSo8WmuFRI1Ja10ZgAUT?=
 =?us-ascii?Q?+plm1Tr+hFg0OOcKrQzuiK8Cp487DMirnTwR9g98JzNagW0W+MkZ7vzP8x4c?=
 =?us-ascii?Q?yWS690o+fX9hQPHQaxmBwYv4V+i4GWT4Hnqz04iENqaBv63f/ay28j9jnxji?=
 =?us-ascii?Q?DxITSsh21nzREHOqTyiUuX5+NZRxIP1AeSaXFGrVKHihXRXxO+AEpCcCRla8?=
 =?us-ascii?Q?dHihx2NhFP/OJceTCb7H2iuMgR+H7dVCHHLMq2YfLrBLp4pVophFOxJHJpNE?=
 =?us-ascii?Q?Op9n/ub2OcuifUsOkPBO9pcfNEePiBE+5ddiA6F+TDiPaPMoWLWHYxFgfJM+?=
 =?us-ascii?Q?lhVhmu/8S43RJviSSEqLsg/naHbOppW+j80w2EzBPJPRFawVT11K7wGQqBcH?=
 =?us-ascii?Q?Aazg87rK/lwCbxFcCn2h1/VVLWxIg/N82WHSc+6B1wUVk2ZiWcGP4Dy7Su70?=
 =?us-ascii?Q?5kc3PsFrhnhQcqcvQXNdmXwcXeTl4U8uCRrKgFI1kyYo8UMD3+0ip8P9OtiR?=
 =?us-ascii?Q?OlRtkff6nuH1oDAuBhBm6Es8eOWJdt6xJf66Jn395J/mvrnfXp17MnlR49jN?=
 =?us-ascii?Q?AXqIt32LOLGmORadIMX4eR/gdZAeNDE1tzHGwBLxMEriTDStIA3x6fiQ3EBJ?=
 =?us-ascii?Q?2F617m9+jS2LiAKPvcASucK6ZuI3yaUZKXDvj0tzxNZkMYruiYtJouJtCVWS?=
 =?us-ascii?Q?6C5dOy8aPi1PsuhDh4UioH4Cd8MWeA1Cv0TJZoz9Rnmh24pvb/I3/Q9qtbvq?=
 =?us-ascii?Q?d6QFnmluhJOFInnhUakpw5buQs/E5pw34Jd8aiTNDykfz3qNV9r9dMy9BOwr?=
 =?us-ascii?Q?gco5Zeq9K49VUuHR+YYB1e+TfnKo5WppvTAvQg9lCLokccEhqhz2W7Qx/JI3?=
 =?us-ascii?Q?jPMrcKR6tgx/lIasuKkqduRK0MQDDoJAIBBOZe4l07+BtAENvqPkoW17PscQ?=
 =?us-ascii?Q?jFaSF5jlHprkLxDc1onsqSWui/8owdXAlTJXkl9l7YCDCzAsADeFixqF2V8I?=
 =?us-ascii?Q?b61Jj6PlsjjJvbq/nzdykyZFCLqkltI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ad700f-bd04-4609-82e7-08da4f55746e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 05:02:47.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yLD/wmXQw7dVIVFin/9gGRyuC0DQ4hVLPbfiOXzM9dlOKkz28S9h/Yt0xnWWU2cSnmRm2cV/bHmQrkiv9odzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7880

This patch adds userspace pm tests support for mptcp_join.sh script. Add
userpace pm add_addr and rm_addr test cases in userspace_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4406b7a8064..977c59c540b2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -654,6 +654,9 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
+	local userspace_pm=0
+	local evts_ns1
+	local evts_ns1_pid
 
 	:> "$cout"
 	:> "$sout"
@@ -690,12 +693,24 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
+	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
+		userspace_pm=1
+		addr_nr_ns1=${addr_nr_ns1:10}
+	fi
+
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
 		# disconnect
 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
 		addr_nr_ns2=0
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		evts_ns1=$(mktemp)
+		:> "$evts_ns1"
+		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+		evts_ns1_pid=$!
+	fi
+
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
@@ -748,6 +763,8 @@ do_transfer()
 	if [ $addr_nr_ns1 -gt 0 ]; then
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
+		local id=10
+		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -755,9 +772,18 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			pm_nl_add_endpoint $ns1 $addr flags signal
+			if [ $userspace_pm -eq 0 ]; then
+				pm_nl_add_endpoint $ns1 $addr flags signal
+			else
+				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+				sleep 1
+				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+			fi
+
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
+			id=$((id + 1))
 		done
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		local rm_nr_ns1=$((-addr_nr_ns1))
@@ -890,6 +916,12 @@ do_transfer()
 	    kill $cappid
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		kill $evts_ns1_pid
+		wait $evts_ns1_pid 2>/dev/null
+		rm -rf $evts_ns1
+	fi
+
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -2810,6 +2842,16 @@ userspace_tests()
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
+
+	# userspace pm add & remove address
+	if reset "userspace pm add & remove address"; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_rm_nr 1 1 invert
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

