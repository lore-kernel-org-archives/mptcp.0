Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A82C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0mEc5GVs34TUzZgPFjuKVt8i+LB/310wSHE4XqJM/U=;
	b=d7QCKvWd9pYltoqHF6+38aJRneCxWGDcHrmzTrJAI+uCFmSfXhV7JG0rCN3Uf9wUCSbe4r
	qz9kIR+lEAwM98oz1eByJiNf5UQ/1y7KejDMquiDVgWI5+1IWUvi4mCr6wkGEg53N62H0+
	sUXuuwnrEOBMqcldEeVfpcW7sD2w888=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-Ol-c_9_8OWWBFl1QDymJPA-1; Fri, 07 Jan 2022 07:17:32 +0100
X-MC-Unique: Ol-c_9_8OWWBFl1QDymJPA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPXSNtVOvPinDf5RuC4FsBjB00M4P/AD6Stg1lyrDaDSZJ5kQAM2bpAjZE/5sDsiLRAu6cWquaYQezbwXDgBONeLZR0VwxHq8MJEhgQmYUIPMw0+y+VaFR0CFbg0mj60d8EdAua0CMmzMiRB0Pb6fL68oRbY7Sq0MpTScmFop6+sJsJVI+1ndXzUJ54TCXa/2ohdBlMyt/v1fHWcr2Yyv/E7j9oiLgeXGP9Pek30SVvFjpa38GZLlYJfqf7ZNe+X5Hzo7uIZlT/o2B5vSPTTJNbuc5pdR3Fr0gxLPhWvvSa+JQIEdInft0jfhYHJLaH1eLkWlDYgHTggHbz80Nc+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPCFqO0LKGJFd98z5194yHoDS2C9hEGxGLps4Wt0MsE=;
 b=lf0YtBchNYN5uvnLuDEHzNEKsaY3TjDZ/ZI6URhl3yuv/tR26tkEgyZzOyZ6HSl+7mzvQygm9XusE8BwlPCns1WT7p1fM6Bi55AvMnq2wtXJ3Jv/0qVXsxZOMqq5xbz4PYUC3F320p9kWskCKQrpagoYyct9x/gQeJqGisfVmF1qvF7APsKnFsMpGgv8h62BiMxRaCEZ5PyR/VTw8y1N7YWoUl2HYsKQlDaHOsuoOy0RrwcvyAp+Z6HejbAECGymt5QRnFlKKKBizcdBjpuCwF0tXoKKZTXmSSrS1NwBzrB7iG/Zw4yj+2KQyCkkDfqWJsT6MQ30GNVH3/wlgEnHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 3/9] selftests: mptcp: implement pm_nl_set_limits
Date: Fri,  7 Jan 2022 14:16:55 +0800
Message-ID: <519b852a686e5d347d5ef8c4f386b2152b8b0113.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30f621c7-876f-4a40-7ee2-08d9d1a561f1
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33691A83EEDFE68939172426F84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fJ4rLd0RVoW5QN+d55NcJ2uNGJ2wcHkQtZDi9ym8julEcLhvgCbbA7cNZcOY0hsfnFoRBUUmbkf5Ho8/2DTz4+c1ukqE2ACmKQbz8dhYyeMUipfTazErJD63bYeVg01miDdQrSDG12Bs6SpTtoyD0raLO/I/AHZ1qpoRteUpfu6rhBXrlSktTcRJiZqpIxSlYza0mM6WCWUPfPCSbZakUVc5xHHpURL+J2NBTGWMwJ0muU1QtvnSbEHlMffb3HH5JrAIQ8p5PdM1ZSB5AD4/YyLHCt0W+5gdrx30LEWRTey98ogy0DD7SVIC+46rWFmGdcfLf8yVukDs6QRn+X6u7CBXEx74zNIeFP3lduqoUqzV/OpjtWQcs1aPf5lbNiwhfTjnPYj5ifTj5PyvUsF/lBEQOurIbnpA7+GwQTPovYigKGV/ZKYyHZH+UXASTeq+OaEz2d2O0pvyyTj0WsCj8DACmRJS5T822DuBpHqWziuuNvVyXgHXnc92WMbLsyjLTLLGuYHKt8+WPVxaGdDFZx9J4azumDwDQTqmt89veARCHaLo+yb2aM3Ip1OmgjulDtdQX55KkvX+HZAiy5WmeGvj2rOGXAarDjXZT0FvMyiJDyLeenZvF/TFNObHMG6W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6666004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(30864003)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DjIuo5j8NOwJnxDD2MyMh4SHA2cHQo4j4U2erphrHbKQ4JxbD9eEjoJqr5p?=
 =?us-ascii?Q?BayZIy6M77URR27g1TFBTWS4+LmIrZRZFLRW//SycnRDLcjwvaaAHlz9G3zh?=
 =?us-ascii?Q?0BXGfyVE/Si6d6WWcymj3zRmSsQnB8Y2M3dmY1xfcsuCPUGJZpqQvYJjnbXj?=
 =?us-ascii?Q?UN1mfv32PptVryck9/h9w5ODVdW0ZUS+dDFw8aukRn51d9J9fJL/hldeqJQe?=
 =?us-ascii?Q?Ve7P8VrtIOpWElbbzSvWJm8XRTVJZg3H2jAwbQxKoijkA+xkqWcvmN6Y/pdF?=
 =?us-ascii?Q?5BkxhgFaiksXRSnzrcwZBwSC7iP1RReN6cJbFoA8/P+W0CN3teNDlG2wTVTP?=
 =?us-ascii?Q?X0VAzGAHJlm0lQ6hGWz/rOEN/9zsDjfm9a8d8KwSqR7h5exu0R//5ZE8VtzL?=
 =?us-ascii?Q?6cNY7TZzgkNi++sAA2O1CgzaBQa9bdBuiMRxf6grw7NwvnIFaHo4LDxS8SW2?=
 =?us-ascii?Q?p98IaAHK8NV+1V7ST27azQ3uq+HqKst/ZejfWp15mv06Ui6CSei1LZsd/QRC?=
 =?us-ascii?Q?THp3O954A3tWdKyeY8oFdFn8qp/aHyHIf/09V1bsiLBxwtWZ4l6s33o0XmjC?=
 =?us-ascii?Q?C13/Wg2jGTlLwRFeXrNmze4J61yMKc5lKordJXzTm0C8yadd62B1qUp7IlVc?=
 =?us-ascii?Q?YIIhS/LulkoaCI1GJhWkfpsR0C2can2AQH94dOF/GHUcDP3RNfDN77ivIkib?=
 =?us-ascii?Q?iVU6ZeunL26Nb7PY8xgr7vHCrWQzAZkXUm4bOSVAgyIUGx7QZDEVVsULWx7u?=
 =?us-ascii?Q?VK8uxnCO4HvX1obTFtI+3ivMVZwTG7y7EwZGGpReoEvJmXIUnxuTZexAGIPR?=
 =?us-ascii?Q?HvYp3vyeigB9F1r9FbdP9tR7Oyob5/snRzJ57olsqRj09ATiJuFFhWmWYOwA?=
 =?us-ascii?Q?HwVpEcOKiJNmZVrMbWJma3zzOoiEpN7uUo8KdUWmEFXCWum0NTZ4Us4bUdFY?=
 =?us-ascii?Q?aMsPUttMJvHmj6CWAgK0Jji00DSCwd7Azvzz+v+FMiYw4VQgFkI7YWG48zKI?=
 =?us-ascii?Q?6rQ72SZab0mRJQGeLvhYHb78NuQ8RgVGc7uroGiO3vm2csgfhStbazmKpVv6?=
 =?us-ascii?Q?3NUqXwmSCeIArkhHteXlz5DUfttl586S/RK10FGJgRd/f5Dbuf+FboBry6h3?=
 =?us-ascii?Q?RZEI38KCdVge7h4/ZCQu4caBWIAMgxhts5Rr86y9RBUPuxQNX2TUlhxcgZwz?=
 =?us-ascii?Q?hJZnmzMLsWwrMYFFLNwdHGu79gLLt2AvODs2B2tmyQs4AseTK1AQHnTe7B3a?=
 =?us-ascii?Q?JhheBHb3TCM5OnlP5HgL4fV7YihQH71aUgb7u4pdh1hAJBQO5MPVIWxRQKd3?=
 =?us-ascii?Q?dE8JNfDOH8lYbeDqnJPF+qAGwP8zknCDh0/Al8y++FeEBMwrgSDxrxoA5FNd?=
 =?us-ascii?Q?U4bYVNX5IegCbCrkt8+TlS3Ag8V1JfWAUKovSCYxoEC5Xdp98Z+dDFM5ixEi?=
 =?us-ascii?Q?PFF7wGMIuass/Jpy1zPdHfhtJEXghXoXTflUAIIdCtmCg4bbQtWvzyu56nYr?=
 =?us-ascii?Q?zgYAyffTbcnwg42uBukw47wXeXYKjWgbju9SoOQnwdJa4UWQZbpeSZ2j8P2Y?=
 =?us-ascii?Q?oy49suwB5EojEwNdTUhssDhBoQbZ8yBhV57ma1FC1BarTiY3pvfhOaLZylvv?=
 =?us-ascii?Q?J8GaPYp875RNo2liv1xsQHo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f621c7-876f-4a40-7ee2-08d9d1a561f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:29.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urGY6wh9/nLRc2oGKV/MhjC06e5ItjBhaZLjVrKiYOXIUfJnr/x0wRoW8AW+KQCkeu64+CIrPiGwyLIa6FzYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

This patch implemented a new function named pm_nl_set_limits(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use for the PM limits
setting.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 378 +++++++++---------
 1 file changed, 196 insertions(+), 182 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b8c21d0b8919..d9142ad820e4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ timeout_test=3D$((timeout_poll * 2 + 1))
 mptcp_connect=3D""
 capture=3D0
 checksum=3D0
+ip_mptcp=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -278,6 +279,19 @@ wait_rm_addr()
 	done
 }
=20
+pm_nl_set_limits()
+{
+	local ns=3D$1
+	local nr_addrs=3D$2
+	local nr_subflows=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp limits set add_addr_accepted $nr_addrs subflows $nr_subf=
lows
+	else
+		ip netns exec $ns ./pm_nl_ctl limits $nr_addrs $nr_subflows
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -1024,32 +1038,32 @@ subflows_tests()
=20
 	# subflow limited by client
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 0
+	pm_nl_set_limits $ns1 0 0
+	pm_nl_set_limits $ns2 0 0
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by client" 0 0 0
=20
 	# subflow limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 0
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by server" 1 1 0
=20
 	# subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow" 1 1 1
=20
 	# multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1057,8 +1071,8 @@ subflows_tests()
=20
 	# multiple subflows limited by server
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1066,8 +1080,8 @@ subflows_tests()
=20
 	# single subflow, dev
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, dev" 1 1 1
@@ -1078,16 +1092,16 @@ subflows_error_tests()
 	# If a single subflow is configured, and matches the MPC src
 	# address, no additional subflow should be created
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
=20
 	# multiple subflows, with subflow creation error
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
@@ -1096,8 +1110,8 @@ subflows_error_tests()
=20
 	# multiple subflows, with subflow timeout on MPJ
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
@@ -1108,8 +1122,8 @@ subflows_error_tests()
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
@@ -1139,8 +1153,8 @@ signal_address_tests()
=20
 	# accept and use add_addr
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address" 1 1 1
@@ -1152,8 +1166,8 @@ signal_address_tests()
 	# used for 'add_addr' subflow
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal" 2 2 2
@@ -1161,9 +1175,9 @@ signal_address_tests()
=20
 	# accept and use add_addr with additional subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1172,30 +1186,30 @@ signal_address_tests()
=20
 	# signal addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal addresses" 3 3 3
 	chk_add_nr 3 3
=20
 	# signal invalid addresses
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
 	chk_add_nr 3 3
=20
 	# signal addresses race test
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	pm_nl_set_limits $ns1 4 4
+	pm_nl_set_limits $ns2 4 4
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
@@ -1223,9 +1237,9 @@ link_failure_tests()
 	# active backup and link switch-over.
 	# Let's set some arbitrary (low) virtual link limits.
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1237,9 +1251,9 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
@@ -1251,9 +1265,9 @@ link_failure_tests()
 	# will never be used
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	export FAILING_LINKS=3D"1"
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1265,9 +1279,9 @@ link_failure_tests()
 	# the traffic
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
 	export FAILING_LINKS=3D"1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1280,9 +1294,9 @@ link_failure_tests()
 	# for bidirectional transfer
 	reset
 	init_shapers
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
@@ -1295,8 +1309,8 @@ add_addr_timeout_tests()
 {
 	# add_addr timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
@@ -1304,8 +1318,8 @@ add_addr_timeout_tests()
=20
 	# add_addr timeout IPv6
 	reset_with_add_addr_timeout 6
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
@@ -1313,20 +1327,20 @@ add_addr_timeout_tests()
=20
 	# signal addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
=20
 	# signal invalid addresses timeout
 	reset_with_add_addr_timeout
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
@@ -1336,8 +1350,8 @@ remove_tests()
 {
 	# single subflow, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
@@ -1345,8 +1359,8 @@ remove_tests()
=20
 	# multiple subflows, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
@@ -1355,9 +1369,9 @@ remove_tests()
=20
 	# single address, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
 	chk_add_nr 1 1
@@ -1365,9 +1379,9 @@ remove_tests()
=20
 	# subflow and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
@@ -1376,9 +1390,9 @@ remove_tests()
=20
 	# subflows and signal, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
@@ -1388,11 +1402,11 @@ remove_tests()
=20
 	# addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1400,11 +1414,11 @@ remove_tests()
=20
 	# invalid addresses remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1412,9 +1426,9 @@ remove_tests()
=20
 	# subflows and signal, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
@@ -1424,8 +1438,8 @@ remove_tests()
=20
 	# subflows flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
+	pm_nl_set_limits $ns2 3 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
@@ -1435,11 +1449,11 @@ remove_tests()
=20
 	# addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1447,11 +1461,11 @@ remove_tests()
=20
 	# invalid addresses flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns1 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1459,8 +1473,8 @@ remove_tests()
=20
 	# remove id 0 subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
 	chk_join_nr "remove id 0 subflow" 1 1 1
@@ -1468,9 +1482,9 @@ remove_tests()
=20
 	# remove id 0 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
 	chk_join_nr "remove id 0 address" 1 1 1
 	chk_add_nr 1 1
@@ -1481,37 +1495,37 @@ add_tests()
 {
 	# add single subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
 	chk_join_nr "add single subflow" 1 1 1
=20
 	# add signal address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "add signal address" 1 1 1
 	chk_add_nr 1 1
=20
 	# add multiple subflows
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
 	chk_join_nr "add multiple subflows" 2 2 2
=20
 	# add multiple subflows IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
 	chk_join_nr "add multiple subflows IPv6" 2 2 2
=20
 	# add multiple addresses IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
 	chk_join_nr "add multiple addresses IPv6" 2 2 2
 	chk_add_nr 2 2
@@ -1521,8 +1535,8 @@ ipv6_tests()
 {
 	# subflow IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single subflow IPv6" 1 1 1
@@ -1536,18 +1550,18 @@ ipv6_tests()
=20
 	# signal address IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single address IPv6" 1 1 1
 	chk_add_nr 1 1
=20
 	# single address IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
 	chk_add_nr 1 1
@@ -1555,9 +1569,9 @@ ipv6_tests()
=20
 	# subflow and signal IPv6, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
@@ -1569,16 +1583,16 @@ v4mapped_tests()
 {
 	# subflow IPv4-mapped to IPv4-mapped
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow IPv4-mapped" 1 1 1
=20
 	# signal address IPv4-mapped with IPv4-mapped sk
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address IPv4-mapped" 1 1 1
@@ -1586,16 +1600,16 @@ v4mapped_tests()
=20
 	# subflow v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow v4-map-v6" 1 1 1
=20
 	# signal address v4-map-v6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address v4-map-v6" 1 1 1
@@ -1603,16 +1617,16 @@ v4mapped_tests()
=20
 	# subflow v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow v6-map-v4" 1 1 1
=20
 	# signal address v6-map-v4
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address v6-map-v4" 1 1 1
@@ -1620,24 +1634,24 @@ v4mapped_tests()
=20
 	# no subflow IPv6 to v4 address
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
=20
 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
=20
 	# no subflow IPv4 to v6 address, no need to slow down too then
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1
 	chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
@@ -1647,8 +1661,8 @@ backup_tests()
 {
 	# single subflow, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
@@ -1656,9 +1670,9 @@ backup_tests()
=20
 	# single address, backup
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
@@ -1669,8 +1683,8 @@ add_addr_ports_tests()
 {
 	# signal address with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with port" 1 1 1
@@ -1679,8 +1693,8 @@ add_addr_ports_tests()
 	# subflow and signal with port
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal with port" 2 2 2
@@ -1688,9 +1702,9 @@ add_addr_ports_tests()
=20
 	# single address with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
 	chk_add_nr 1 1 1
@@ -1698,9 +1712,9 @@ add_addr_ports_tests()
=20
 	# subflow and signal with port, remove
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal with port" 2 2 2
@@ -1709,9 +1723,9 @@ add_addr_ports_tests()
=20
 	# subflows and signal with port, flush
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
@@ -1721,20 +1735,20 @@ add_addr_ports_tests()
=20
 	# multiple addresses with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with port" 2 2 2
 	chk_add_nr 2 2 2
=20
 	# multiple addresses with ports
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with ports" 2 2 2
 	chk_add_nr 2 2 2
@@ -1744,16 +1758,16 @@ syncookies_tests()
 {
 	# single subflow, syncookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow with syn cookies" 1 1 1
=20
 	# multiple subflows with syn cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1761,8 +1775,8 @@ syncookies_tests()
=20
 	# multiple subflows limited by server
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1770,8 +1784,8 @@ syncookies_tests()
=20
 	# test signal address with cookies
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with syn cookies" 1 1 1
@@ -1780,8 +1794,8 @@ syncookies_tests()
 	# test cookie with subflow and signal
 	reset_with_cookies
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal w cookies" 2 2 2
@@ -1789,9 +1803,9 @@ syncookies_tests()
=20
 	# accept and use add_addr with additional subflows
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	pm_nl_set_limits $ns1 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1803,29 +1817,29 @@ checksum_tests()
 {
 	# checksum test 0 0
 	reset_with_checksum 0 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 0"
=20
 	# checksum test 1 1
 	reset_with_checksum 1 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 1"
=20
 	# checksum test 0 1
 	reset_with_checksum 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 0 1"
=20
 	# checksum test 1 0
 	reset_with_checksum 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_csum_nr "checksum test 1 0"
 }
@@ -1834,16 +1848,16 @@ deny_join_id0_tests()
 {
 	# subflow allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
=20
 	# subflow allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
@@ -1851,8 +1865,8 @@ deny_join_id0_tests()
 	# signal address allow join id0 ns1
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns1" 1 1 1
@@ -1861,8 +1875,8 @@ deny_join_id0_tests()
 	# signal address allow join id0 ns2
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns2" 1 1 1
@@ -1870,8 +1884,8 @@ deny_join_id0_tests()
=20
 	# subflow and address allow join id0 ns1
 	reset_with_allow_join_id0 1 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_set_limits $ns2 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1879,8 +1893,8 @@ deny_join_id0_tests()
=20
 	# subflow and address allow join id0 ns2
 	reset_with_allow_join_id0 0 1
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	pm_nl_set_limits $ns1 2 2
+	pm_nl_set_limits $ns2 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1893,8 +1907,8 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added before the connection,
 	# 1 non-fullmesh addr in ns1, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	pm_nl_set_limits $ns1 0 4
+	pm_nl_set_limits $ns2 1 4
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
@@ -1905,8 +1919,8 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 1 fullmesh addr in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	pm_nl_set_limits $ns1 1 3
+	pm_nl_set_limits $ns2 1 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
@@ -1916,8 +1930,8 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 2 fullmesh addrs in ns2, added during the connection.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
+	pm_nl_set_limits $ns1 2 5
+	pm_nl_set_limits $ns2 1 5
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
@@ -1928,8 +1942,8 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added during the connection,
 	# limit max_subflows to 4.
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	pm_nl_set_limits $ns1 2 4
+	pm_nl_set_limits $ns2 1 4
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
@@ -1941,8 +1955,8 @@ userspace_tests()
 	# userspace pm type prevents add_addr
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
@@ -1951,8 +1965,8 @@ userspace_tests()
 	# userspace pm type echoes add_addr
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
@@ -1961,8 +1975,8 @@ userspace_tests()
 	# userspace pm type rejects join
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type rejects join" 1 1 0
@@ -1970,8 +1984,8 @@ userspace_tests()
 	# userspace pm type does not send join
 	reset
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type does not send join" 0 0 0
@@ -1979,8 +1993,8 @@ userspace_tests()
 	# userspace pm type prevents mp_prio
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
@@ -1990,8 +2004,8 @@ userspace_tests()
 	reset
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
--=20
2.31.1

