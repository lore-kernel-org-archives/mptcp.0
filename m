Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2410FB
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 02:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtZqhb8lvzYcHWMMu5sFD3271FxJurSJDFgJjdCyP/JxklYDgt8ucZXzkNG0kHxmSXtqUf6LR3MT3N8gdncIjeF8PIaHAAO6oLMvVNc5TvyykmV+42dnqvxVhf3dWU/WVAY2W6BaHn3i6SRv9NG+/v5IUFY+BLH5Eo/OI8WIukKLb0NU6Wm3LKnYxX7n7y+QUtb0/gd5Rnp0JZpeqJMF4Vkpe+N0/leURcWjRjZSpNqD3kV9dR91svXj/LZuyJwpnZt9tnK+EtvNCA24gUZUB+pMCy8DUw9v3hKVmoOYQ/R4AVhwtTX68XvFZ2M+jasFFx67k1wB7F3h3C9RSNs+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs+rvOg1oiFObN8UxTkK52rLvAPMm80Uv9/HnhSxKBw=;
 b=CcPwSSDrw3gNG2vkPQkcxmFmaT3G1TCU+l1lTzYSqoG5KDI7zyARCBS0R/OlPkFKKfN8bfPsSvp8JKGuudqtgjXs1AA+LyxTViAvGkBDl7ZvID6jf64XyDQ9VysBN13KsIQur5Omky3BZSPifvLC38vs35vPOsfvxyZGf/KOgbyZjpWuihrSWVkFKVpPT4C6HU1PJXxJrMdaWBVPqtfhcpJ+6amOCH9OK8Zs4nEE7DpRBONrwwufhgA+FvdJnE710kZtPA/Jo2wi5bYBSfvm734Sx6hVeIVuScQX+w7C/hoE8S/MXgfSroCU2YC335Mg3rRI8EJt8rCUH7LsHiUcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs+rvOg1oiFObN8UxTkK52rLvAPMm80Uv9/HnhSxKBw=;
 b=peLOnTNMJ+QZpcSrsao8I++L1OZW1KORnrdvJGvBFHY1CXYKYKUoG/Mb0vxjDdayVkzMd/SSBa4vjxzf4PltMano0w7gGKgCaLQidZZHiYn4HHBdKKIc1K6sHS4lfbn6X6qjJKj2TKzxKGbD83Pxs+DXzSxm8fHp52MvNDfFobPrTUBDhWxhQYQXoAPKxY47Ng0k8kz1uadtB6jaaa6GgCMFae1Ba8mbEhOMF2WF2M92eS27w7+4F+tAggaLbpjE1aWfIx0YchsNsFOHqZ6V1OcP9cP/EIcJ/qzKmjD07hh/TrpdEtr9KcrRKuTC5YNkTzeV5yFzob4vcd7rn4U8HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 02:43:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 02:43:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/4] selftests: mptcp: add speed env var
Date: Fri, 30 Jun 2023 10:42:34 +0800
Message-Id: <d0352b2b949544ce4b87ceeec55109fe22f1fc26.1688092826.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688092826.git.geliang.tang@suse.com>
References: <cover.1688092826.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ec1b84-f3dc-482b-a7fd-08db7913bb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h/kQYr+gu+ANMahwrGReoHPfjpiwc90fX62C7hgc7KSa9JQDeSjcIcx9VvvgOdPFFgZz8dZJDsb2510eTRfcqhS/phKzBp4ZXam+INLax+7h0xS5KuPe34PXlsaURZdK42FWiMDStx3YsDcNnsxsaohNLRAVILyIVGThe6aZqqIn5zIgNje5faiHg3DcNVDK+2XCpf9bWrheJJ4fRLJUjJe8ei/3CpM7x9IaFPBZpT4Ibf9fgeZiBPRHAB/v8aHxvXxO8fGgZa2EvbQ31LFXGpYpSlqukI3D3boxz/0aTVbvCKFZneiCNJHHeZYhdWj0n4x7XRR775aWYEnebbn8ij61zN4cD3iPpqoF8Ft96iu9gIsiUZ6K4le142XX8qKiPHQQUFchflv/8PTzfGq88sXTULP/mlflgZtUuF0568byLtGZSPFHEMFIyrns7/rdt0vdEsn3WgF509epG7UmQ18yCWk7xGY6daVmi5150n9njhE/MpffPl2OQEIDpuc+CNtxRqmweNCQGMB9T8DAJ/7hJCEalRWpecPbiHtYTYFJPoXJPUZgCfZUMJWT4YXR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(107886003)(8936002)(8676002)(5660300002)(26005)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(30864003)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UsuDcicWI0fB11cxIrczp/oKIPoBjr/EaNVUrmLtv5FTe5gmJgZooYGEu01U?=
 =?us-ascii?Q?9nqIwKi8zcia4mHnC9yZkjoPVkP7t+fPIwYBCHFxMHlksCCzGKchVEEvIrfi?=
 =?us-ascii?Q?BiIAUxuQMzm7nMfB1uM5zt7YJdkZTNBjdrwYHgySnJF3uyC5LHYj+GOi/UCx?=
 =?us-ascii?Q?hMaBZE1ff42qUrk3Drs/2b8n1Xe19Nb3Z11u1rTpyy/rqJLscxs5U7/lM14w?=
 =?us-ascii?Q?FRX+GWL6jb6ZMyIgevnFypTVyqmE8eNUyE47EM0mNiKlrDkYnYeheQrpAVNs?=
 =?us-ascii?Q?9Nz3X69l5UpI/WlRx2GP+Rk89+HxsPPVySgWgGTjqPN5DyTI71s77X8XTFVs?=
 =?us-ascii?Q?pnwPOK8sIPaPGabhWs0kdWCdK3FIb9+H5j24fyrxYChDVCwt4jRep5XD/8iK?=
 =?us-ascii?Q?TdpHd4BQzrkOvGel33FeyaYLSVSCENVqXXte5vzbVnIRHMv4mOHBb7xlj0sM?=
 =?us-ascii?Q?M6ytVjiQl69e0OIp1J5pgEQoBnzdLfgJQncRMltM1C9a/Cyiq3Oemt3nQ51V?=
 =?us-ascii?Q?QxgCkFNcRUbiL9WNywUqquEc6dNG3fA8FNRZnzUDtSBZTrxVF2AtBql5ttIm?=
 =?us-ascii?Q?ABhnmjHbbTBG4vtJ+vrBo47QjSu3LjkrMF6weTljE+q6u0QuLa6+z/6mbk2j?=
 =?us-ascii?Q?tR+w7cH9Q16k+5Q8nhSaZeuYq0DJyakqPC5Bfdh+TRO5nuyMU84sElobZhkY?=
 =?us-ascii?Q?e9zIeCRZKCD+TDlYQdEK4res9gSdcTC94r6eImBq2YVFbKFPMUYg1urE83Sb?=
 =?us-ascii?Q?Osx/PLU1MZi2YiY2Q2Cus8KX3LNe0yU07EyZFhlUG1LmT8xgPxovx8xvqD5H?=
 =?us-ascii?Q?PSxG2vI7wCIblvsqBWYqcLXWHvma7EBf3DHUUL0bcUfPS6ONqE1eTzCsfxzt?=
 =?us-ascii?Q?l4mZDugpr9F9WSuLOgLdAVBTGYHt+GJwfCf2QpMpYyX7cHezAvrL2gUxf6q6?=
 =?us-ascii?Q?5mXjj0PVV8dL+3DCkjmFESsTHY0eNl4wvoPACmZOg/jwHshzXRxeShgXnIe2?=
 =?us-ascii?Q?kRphdGsUuZzJJgeT1CoPSW/nd4nKJb57CBgJMt7fZaNGT2VBm62nP6jsyLSB?=
 =?us-ascii?Q?uAfqgg0r5vPcQj3dor6fbq6JCh7cYPa526J6b+JHzpZb4oaHio6yosW9zK+S?=
 =?us-ascii?Q?OSRMfUDKdgExzdIzm/M8T+awF37mgVdTE/pKvDH8O60yqj0fO3oiPu/MNeYr?=
 =?us-ascii?Q?g7v9gFecAhQu+BSu3pfZ9596VcSlPSqKraASGr/DHIFYcciJue2ITss6zeoH?=
 =?us-ascii?Q?efJbP6xdYvsSalc6D9IkLDK7sPzJxUcaGinZVltQQWAy7TrkkCc4iFSlZhlA?=
 =?us-ascii?Q?rNG3m5b3VH2bXpumbx5DtW8Nq5XV4wos9PN4s9xDnjaeswFepNv1tB++vww4?=
 =?us-ascii?Q?+vSXX6gkbOlKPbIacIfxgB12NJxIQCHU38X9N4d3eQF3ILuHFpKe2XZazmyx?=
 =?us-ascii?Q?uD1PchLak8ZvDhqOLfTtUsJt3HvudlUUzuZUBR8f9PozcshbSKN29vRlet0G?=
 =?us-ascii?Q?g+qRsdcJlV1WoHYOsyAbKDXgwpdFVHCnkn3tktelDkXZOBdNhSTP/ns6HDB7?=
 =?us-ascii?Q?NtLJF4sHYfGNMu/GAGMT0RudCgbUr9o0xjB60oYi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ec1b84-f3dc-482b-a7fd-08db7913bb69
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 02:43:06.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcrkzNuwN9zu/li507O9mGlg70w8Y9zMgzIOu7cieD071wc9+RI6suSO45JsqwDQLTvldNzbQWWEHNZLTFjjAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Use a new env var speed instead of using 'speed' argument of run_tests()
and do_transfer(). It can be set with 'fast', 'slow', or the actual speed
number:

  run_tests $ns1 $ns2 10.0.1.1 slow

  ->

  speed=slow \
          run_tests $ns1 $ns2 10.0.1.1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 230 ++++++++++--------
 1 file changed, 125 insertions(+), 105 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bda250f703ba..b89077510080 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -56,6 +56,7 @@ addr_nr_ns2=0
 sflags=""
 fastclose=""
 fullmesh=""
+speed="fast"
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -987,12 +988,12 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local speed="$6"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
+	local speed=${speed:-"fast"}
 
 	:> "$cout"
 	:> "$sout"
@@ -1025,8 +1026,8 @@ do_transfer()
 		extra_args="-j"
 	elif [ $speed = "slow" ]; then
 		extra_args="-r 50"
-	elif [[ $speed = "speed_"* ]]; then
-		extra_args="-r ${speed:6}"
+	elif [ $speed -gt 0 ]; then
+		extra_args="-r ${speed}"
 	fi
 
 	local extra_cl_args=""
@@ -1164,7 +1165,6 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
-	local speed="${4:-fast}"
 
 	local size
 	local test_linkfail=${test_linkfail:-0}
@@ -1209,7 +1209,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
 }
 
 dump_stats()
@@ -1998,7 +1998,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 	fi
 
@@ -2009,7 +2010,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2020,7 +2022,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2032,7 +2035,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow &
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2131,7 +2135,8 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2241,7 +2246,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2252,7 +2258,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2263,7 +2270,8 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 speed_10
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2274,7 +2282,8 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 speed_10
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2287,8 +2296,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2300,8 +2309,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2311,8 +2320,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2324,8 +2333,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2338,8 +2347,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-2 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+		addr_nr_ns1=-1 addr_nr_ns2=-2 speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2352,8 +2361,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-3 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+		addr_nr_ns1=-3 speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2366,8 +2375,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-3 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+		addr_nr_ns1=-3 speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2380,8 +2389,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-8 addr_nr_ns2=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2394,8 +2403,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-8 addr_nr_ns2=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2413,8 +2422,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-8 addr_nr_ns2=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2427,8 +2436,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2439,8 +2448,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-9 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-9 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2450,8 +2459,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-9 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-9 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2464,8 +2473,8 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		addr_nr_ns2=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2473,8 +2482,8 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2483,8 +2492,8 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2492,8 +2501,8 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns2=2 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2501,8 +2510,8 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		addr_nr_ns1=2 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns1=2 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2515,14 +2524,16 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2532,7 +2543,8 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2542,8 +2554,8 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2555,8 +2567,8 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2657,7 +2669,8 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 	fi
 
@@ -2667,7 +2680,8 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:2::1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2678,7 +2692,8 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:2::1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2690,8 +2705,8 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		fullmesh=1 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		fullmesh=1 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2704,8 +2719,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		sflags=nobackup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=nobackup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2716,8 +2731,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2729,8 +2744,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2739,7 +2754,8 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2748,7 +2764,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2756,8 +2773,8 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2766,8 +2783,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2856,8 +2873,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2873,8 +2890,8 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2887,8 +2904,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-8 addr_nr_ns2=-2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3090,8 +3107,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		addr_nr_ns1=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3103,8 +3120,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		fullmesh=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3116,8 +3133,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		fullmesh=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3130,8 +3147,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		fullmesh=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3142,8 +3159,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 sflags=fullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=1 sflags=fullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3154,8 +3171,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		fullmesh=1 sflags=nofullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=1 sflags=nofullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3166,8 +3183,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 sflags=backup,fullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=1 sflags=backup,fullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3179,8 +3196,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		sflags=nobackup,nofullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=nobackup,nofullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3355,8 +3372,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3369,8 +3386,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3380,7 +3397,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3400,7 +3418,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3423,7 +3442,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow 2>/dev/null &
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3446,8 +3466,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_20 2>/dev/null &
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

