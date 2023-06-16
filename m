Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8023C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKMpsurNAXrUQeev3DxLPm6xFZjFI74r0r60QXhQv1H7kzvh+5fEyz2lVqoVgbqxw9qDRL4/dhVX7YgF9YLwpZ/sIYTlQycz0Lr+Z9GQbb/+JlAqnCoNMNPbIiMAb6UGhV+VDPOpMt9oZk/rCkDiJ+QqAH9K56hBXA5TpqfyrwyFwCQZuA4G5M1Yeld3hoqRRjLk2S7b0c/Qs88lMFvgDxBfWZ1F1BZZCKhukahiDkklMTEkaSsgn35TmIlIa5wpJcAZ8qmpkC8Ixi/yvIha50LRpPG8/xYzTsxvItvYG2HYthtAKbAVW2/YwvHBGpvCLrriePBqYq1klpTSQ8f94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eN6PgFmsp2c7lbVqZNJObwjVmqueVPS8VX77hIyBY0=;
 b=bJ4sxSa05fwXwbHgX4nACzqNrB+T7UOVcytdd0KXgeVbzw2Omq1nEEd5XN8JYx114N0LURvdI5D1OA5J1ZDfRLCII0/RxRX1k0J2N/rX52nNymKapGhNqQXWuk4WxOT+/b/LoozXUR73LwXU8bVNEHw1HIxvHTJJVUCA9GxHFah1Xk7Igu9YdTWtZzn+MvsHd6q9K3x7Fhi8nRTdumbScy/WSkniKdMUQmfmIiDCh/E/tz1FNm07ZMtZWfR80FkSLf581HCA9MuwZpcyNm0LhCqPBCf3A6WPMrZPT4pjxSLtcWMymPnQrPEx0umYU6C2DOJY7mG2OhW2/FAmFz24LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eN6PgFmsp2c7lbVqZNJObwjVmqueVPS8VX77hIyBY0=;
 b=SP/Hk9EEKx2hC66aKD4FKoP/dwONAawxUxbYhouzTJeVr+gR/8yxj40Fi9qfA+c2FcdZ5DwrxVsSCUFFyPMT0VjWUt3g7NP1vs0tPvyWazO6MfYEQoEzd6UGXmTDKutDvHvvxk//Y0dh7uF31ZjuBE1d7iFUGI4PzNsz50+F+PLzGqpTu4VFTO3l9DXzNMOXf6iyo8mOqjsp9dLCaEmlWTVhpRY9GJ84+CQP9qhRqnz7ZRuipFSZ6IlvCFRRnYOA7We+1EkUaawzpqM8LQeIZ8tUn/w+ftbnFgBsjeZWNYrkHP6cDdty69w7cxotJDr07jELvC9sHuuGtf6QlE21zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:31:52 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:31:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 06/10] selftests: mptcp: drop addr_nr_ns1/2 parameters
Date: Fri, 16 Jun 2023 15:30:58 +0800
Message-Id: <6cafd9fc77143d31508b81c17523b5a814b185d9.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 96eaef19-bbc1-4760-fa70-08db6e3bc0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DPlGl/YteYSVmeosexGoSvnkspDLHEqvrehDdNNE2GGNG8x6aJd5EvZK/P25qSTQbaA9dfFL4X4C7HManYYxmqllCnock9LkdLS5HxvA22HFEm9DmdfEjvaoK0u7OJobpu42T7fuCE9nGYLq8BfWCT/OOi9HbvUawAWRNYjqy8sAW0Y3pxnK8qnlcMcMfQ5j61QUUgbCfZGDF1xJU26l/+zbSExU6Hc05wMmyxBcZyLTiV7gu2nefj7TGZ6r9Nqt+q9j2/GsFe0Mb0rWGURCG4mYfvwvi5vIU56KQ+A2p1gFQR/TjMfK7lI2AxvfEbxygK/DtdpKUq85Tzow4hA35LoW43WjRA88AT+vW7edFgmxHQWAEqDLv2s/3/FZRX+yjZhZGg6mqhcnQO+bG0w5H67qhQh41OZ+N6/xWEqK9NzycWU+RS4JXqT/NRoH4YJPjI4EGUxbwC9sK1cPDkUXurih2JtqpHq9DKoF7bF7njo6B6pyl+SnEsjZRd9OHMLlU3Zg8Sqg6uaeBtqBuugBhEa1/Wbuof8NK5R+BHED+CMfi3Uwp8qvnYjYwx+icOAf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(6512007)(6506007)(107886003)(26005)(6916009)(4326008)(66946007)(316002)(66476007)(66556008)(2616005)(186003)(83380400001)(6486002)(478600001)(38100700002)(8676002)(44832011)(8936002)(5660300002)(86362001)(41300700001)(2906002)(36756003)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HyIXcl5sLza34C64/yOZKvslIg9jt7x6kpw/K26Apzg6b0sj9zLBUxZI/e1y?=
 =?us-ascii?Q?DcUTnkcsRdXZ4LVw/hJkDxA1QLfYypPLnHrXIWtq98swhGrHR8Tt37lFsNJJ?=
 =?us-ascii?Q?O0vs3GOWQt51kCauY9Wk3/nboazfNBsIh6hDPvhbpOH0XMgHDLsNcTxwQCGr?=
 =?us-ascii?Q?/F5XNzzOGVSGqAdM2khZC/Fi/f5FZrjJRV3iXiK10c0jTmBRNYFz1nb75sAy?=
 =?us-ascii?Q?3poiQm10Z3kcNmshpbf8Od3DdKZjXxqDPx9PC+wRcjQKFU+G0yMHWA8iQ2JF?=
 =?us-ascii?Q?E2GsHMKDp6d6YRrrI7J9Hvl3x80iC1ssHa6KHkDBehKDYkcNctuBc6N3EANn?=
 =?us-ascii?Q?7AzAWDzY44OzSjr4f4zkxCKm46EnMV4gP9A3GwUPP9g+ki0kiz/ZXFn1StFy?=
 =?us-ascii?Q?GL4m8O34DDLNDO1lMw91zEZFkjGQdO0Ft0XH4toCzrkp7+lKaFnimJNtqKRF?=
 =?us-ascii?Q?91OpKLJmWHeYq6Pxv+4CPxYrusbAo9xnlw5b+/f26f0uJcHqn0MUPrvzpR+c?=
 =?us-ascii?Q?k6lIw9DgT/6qvbR5KJJVb2qynvE7FCfLyB2OgMxDjxBEZr7ZmlxAKJPOwTaF?=
 =?us-ascii?Q?WujCWxmc1sAtzt+J98uunvmSPe64FPjlSHwesLVUpJd2bcZ1pE8PAI8TKKYj?=
 =?us-ascii?Q?Dln7E7H+w/GlzYox3jW81C1k3xnqjPiEhu1cxW1ZlEMy+8WZnJWYikbf2CfJ?=
 =?us-ascii?Q?jYtx9+f9X6rU+6PWJY1zwg3IJeM4hG0Ecn67XdrutHCylGphUlDjNGXc3kog?=
 =?us-ascii?Q?q5PjgOjV8vvs/uoRbnH1Th0PcmvjKcQTVVVzTXZiPd2+ZOuUVNPSYIscOonj?=
 =?us-ascii?Q?4moA5Yz/UAvQ/TB9dPczLludV93km5MsWvf+ck6BTSPv900fCCimd1CGLzQD?=
 =?us-ascii?Q?n9/qbQXAfcWcl7hlCpX0tY3xTmDkbffCqSiiPJLdGuuxIrwDPL7j/oXOPlgC?=
 =?us-ascii?Q?46WaGmKQhI185Jx277NfX2c0/rwzdFH7GnD/DEoQk5q/t7BacQSiPyQGs6rq?=
 =?us-ascii?Q?E9ku8TnHGhSSeMYv5KSIKJOd5JQ8s7lB/eVmip/aEUYbyUy0od6O65ATgnpq?=
 =?us-ascii?Q?b1WCSB+02B25ZysbW+xU44YXbK9DQxOvO83cSciYhyw16WTqLwtuppex+q2n?=
 =?us-ascii?Q?LRxb2nZ5cw/funnBaB17QbD1IIs31QAoXPYr1OOXQfsn6dg47OjkECHnL4LN?=
 =?us-ascii?Q?uUf/csbupacAVy6zITWwdlxcR9f5QMPkNYIarRgzLnWN7oShzP2lSAuY/Fbv?=
 =?us-ascii?Q?0g4h2Rxme8SlsjuGRHlSe3YzeI8SIxVU7OTVxX96cjnwDbqHQrdLNer7qpa5?=
 =?us-ascii?Q?NiDZIK8eo4lNZWlXjUB4GInJR+yE7G8QQL8/QniH15iRy/LZBGckqkBQqpaX?=
 =?us-ascii?Q?lQley/RRqEWGdmLx483dPUDEA0bPs2uixkSdjh4vtFcEbAHKYs343xL7e5cW?=
 =?us-ascii?Q?SjVFGZFGv3evUsUK/BxRNa34RnAZlOM+JqxZFfa3au+DH1UYOYoJD+3rFpDV?=
 =?us-ascii?Q?WNd8b5F9ykhQuJ4BIry59YaSD43/Q6aUCGXuGNI/QczP6HdRU9TjW6meff20?=
 =?us-ascii?Q?lc0oQEQ3nHEGZVwHfQxe7zK4KLO44J3YvICZr/zE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96eaef19-bbc1-4760-fa70-08db6e3bc0c9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:31:52.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cenO/H9ufBbEwayK12h9fQ3RyxjefDhn2ISrw2bwcOrVfcqOGEQD83OQQAQJIDr9FYF4eZVLImCPavOoHci3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157

run_tests() accepts too many optional parameters. Before this modification,
it was required to set all of then when only the last one had to be
changed. That's not clear to see all these 0 and it makes the maintenance
harder:

      run_tests $ns1 $ns2 10.0.1.1 1 2 3 slow

Instead, the parameter can be set as an env var with a limited scope:

      foo=1 bar=2 next=3 \
            run_tests $ns1 $ns2 10.0.1.1 slow

This patch switches to key/value "addr_nr_ns1=*, addr_nr_ns2=*" instead
of positional parameters addr_nr_ns1 and addr_nr_ns2 of do_transfer()
and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 176 ++++++++++--------
 1 file changed, 103 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 90cfd134bf7e..f9bf4733ca41 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -51,6 +51,8 @@ nr_blank=40
 
 export FAILING_LINKS=""
 export test_linkfail=0
+export addr_nr_ns1=0
+export addr_nr_ns2=0
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -826,10 +828,8 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local addr_nr_ns1="$6"
-	local addr_nr_ns2="$7"
-	local speed="$8"
-	local sflags="${9}"
+	local speed="$6"
+	local sflags="${7}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -1146,10 +1146,8 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
-	local addr_nr_ns1="${4:-0}"
-	local addr_nr_ns2="${5:-0}"
-	local speed="${6:-fast}"
-	local sflags="${7:-""}"
+	local speed="${4:-fast}"
+	local sflags="${5:-""}"
 
 	local size
 
@@ -1194,7 +1192,7 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${speed} ${sflags}
 }
 
 dump_stats()
@@ -1989,7 +1987,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2000,7 +1998,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2011,7 +2009,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2023,7 +2021,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2122,7 +2120,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2232,7 +2230,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2243,7 +2241,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2254,7 +2252,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2265,7 +2263,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2278,7 +2276,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
+		addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2290,7 +2289,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -2 slow
+		addr_nr_ns2=-2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2300,7 +2300,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
+		addr_nr_ns1=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2312,7 +2313,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2325,7 +2327,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -2 speed_10
+		addr_nr_ns1=-1 addr_nr_ns2=-2 \
+			run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2338,7 +2341,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
+		addr_nr_ns1=-3 \
+			run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2351,7 +2355,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
+		addr_nr_ns1=-3 \
+			run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2364,7 +2369,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2377,7 +2383,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2395,7 +2402,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2408,7 +2416,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -8 0 slow
+		addr_nr_ns1=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2419,7 +2428,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 slow
+		addr_nr_ns2=-9 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2429,7 +2439,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -9 0 slow
+		addr_nr_ns1=-9 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2442,7 +2453,8 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow
+		addr_nr_ns2=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2450,7 +2462,8 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+		addr_nr_ns1=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2459,7 +2472,8 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 2 slow
+		addr_nr_ns2=2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2467,7 +2481,8 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 slow
+		addr_nr_ns2=2 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2475,7 +2490,8 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 2 0 slow
+		addr_nr_ns1=2 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2488,14 +2504,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2505,7 +2521,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2515,7 +2531,8 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 -1 0 slow
+		addr_nr_ns1=-1 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2527,7 +2544,8 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2628,7 +2646,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2638,7 +2656,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2649,7 +2667,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2661,7 +2679,8 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 fullmesh_1 slow
+		addr_nr_ns2=fullmesh_1 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2674,7 +2693,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 slow nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2685,7 +2704,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2697,7 +2716,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2706,7 +2725,7 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2715,7 +2734,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2723,7 +2742,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2732,7 +2751,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2821,7 +2840,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
+		addr_nr_ns1=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2837,7 +2857,8 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2850,7 +2871,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -2 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3052,7 +3074,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+		addr_nr_ns1=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3064,7 +3087,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow
+		addr_nr_ns2=fullmesh_1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3076,7 +3100,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
+		addr_nr_ns2=fullmesh_2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3089,7 +3114,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
+		addr_nr_ns2=fullmesh_2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3100,7 +3126,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow fullmesh
+		addr_nr_ns2=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3111,7 +3138,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow nofullmesh
+		addr_nr_ns2=fullmesh_1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3122,7 +3150,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow backup,fullmesh
+		addr_nr_ns2=1 run_tests \
+			$ns1 $ns2 10.0.1.1 slow backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3134,7 +3163,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 slow nobackup,nofullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3144,16 +3173,16 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		test_linkfail=1024 \
-			run_tests $ns1 $ns2 10.0.1.1 0 fastclose_client
+		test_linkfail=1024 addr_nr_ns2=fastclose_client \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		test_linkfail=1024 \
-			run_tests $ns1 $ns2 10.0.1.1 0 fastclose_server
+		test_linkfail=1024 addr_nr_ns2=fastclose_server \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3309,7 +3338,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3322,7 +3351,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
+		addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3332,7 +3362,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3352,7 +3382,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3375,7 +3405,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3399,7 +3429,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 \
-			run_tests $ns1 $ns2 10.0.1.1 0 0 speed_20 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

