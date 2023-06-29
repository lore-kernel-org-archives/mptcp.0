Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761FA11192
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY0SGgwpR/H8Qsh8OdRwhwNawS1XFVZHrV9vriwxiiM4GHfFipOftuDBU6P7yfLNKRXM7C+rvALLp5nd6LavftibVa6cu3yQuhmbbE5EKFXY+T108whxYd/yrxDAWScii+iRyrXw0hmdQrFs6830P/llWtKR3Pdaz0coLAeSWWVHtlNtUfI9q1l1wG5u/rd6pjzESQFPEAaN+AUhsbZJ9R4hXnd++jgm7HfZlQ5B4QMWNqpBrtKjBQKaCeKNC039LMTi/+MLegjFPnk7Pd+6ohwXu1hZigITc+PinQL3ZzYrrQaVlBCYWo2HGYCRodUY5WmIzK9fcpEsXFFlj+CdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EByRJp45pKCPFb4MUOC7zzwDQRJeP+cLywVdi5RnU/s=;
 b=ePKk1nPUs22BLC97Mu0HhivANRo7UDZrt2vSKLlXp39bHYlvVv3gGgYCJneTS4YMooHrqPxIvaU1BaP9v9OapknrnnQX0+B+dlKBQ007DRKyLg5SQLQTsQSZ69ExdevrWEu/hhKO0ZVBcUR/689YglPDBq5CRZOgRJyvgc9cfn1oGHUViuBWanwXkwBSzO0cIMHYxII9oSJxjEojHNBoxOAwvpMM5SCNdqEXWFp2Eu+wh2Mdb7H4mcJ6pE1VvdP859MuFM2PSkxomWW3btE8b8HFXSSy6AMCvx6cJmKvS4bqvR+MApTIbm9L4V/0uygyaqcOvgcO3UsxYfk0YulNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EByRJp45pKCPFb4MUOC7zzwDQRJeP+cLywVdi5RnU/s=;
 b=PRVnt+xEFyziWc5py+KhSv4XpvjFj7x3EpRY2kEJQIG8p5JKYKR0Zh+hI3t34ZqLAr8NSOX+4TOEW24A33qF4I3dKDn1GaoJ/552eI0HVo9dcBfvPd+0w6o7M1+eZUu/8aAxwZMgTD4SbSCjD9CiFx/zCbO3b5mcfXzpPkV4WmW/8zONTQC8mZqIC35LLXT5zkiQ/yRSvGNipo8dlz+WGhtuN02zta/NkQoSrh9SVJfa/tH9jdlNPjK5XeoeEO7t6NTMCkMCnrrKD92kRxJViYS4NN+vQdjHGj6YkkdAKEWqIy8bFsp1XOyhws40AXcpo3QWkZNhifOI3Z46jPQUZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.37; Thu, 29 Jun
 2023 13:35:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:35:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: add speed env var
Date: Thu, 29 Jun 2023 21:34:32 +0800
Message-Id: <05fb1934b9654b965f62f54be06579cdc97c864a.1688045383.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688045383.git.geliang.tang@suse.com>
References: <cover.1688045383.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:404:28::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcad70d-e914-4598-bd44-08db78a5ae70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ts2+f3n7WtLFhryoyiF2ALpdbKvtdFhq4fKK1AihAzw9hkJgwn1Cc8S6Fp/RWflb8+J+JGdFumw2fmi+7pnccq+mFXBgPc+B481JTz0P5lCHJrC+EZC721r+UPprexNk0uUldEOJ0PbkUEwtlMLpWQD9IQp5XrjujFH9NBFky5obq49SCceZcMcS8kULvc/uywuVabx8Roz5xHYrj/eYtY7rmyDP2LlBkQtAj7CBlGyVVquESfhV+RKp3dcrwFc/2mY5sDjMK8F7pgjpzIUPx4dRe/iIjRxu40O/3bqhDdai7W0FJOwb4MW3rRJqadcHkmSN2dZEs8aw9XplVwH1ARnmWTQ4kZEXpx5af7jA5ADekx/5SphKJo3tKyk9c6bJpQ4Cjf5/VjFkkEZbscvWRi/a75efbjonMz9J6aAUvpp/Fvn06wgSiqAcagcZoJ6L/6BKp83SsafeFyVF8gAz+gWxwvZqu9MKkSXsrKH2LJ0yesaP8VLn1DzHR+t41S9bPQst/jSO+WBE9DJSwVPf+ccEw1Kf0qXB6iDMzIbf1sG4HQmB4M2Aeb2ElyUfUc7C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(6512007)(107886003)(30864003)(2906002)(66946007)(41300700001)(316002)(4326008)(66476007)(6916009)(66556008)(5660300002)(44832011)(8936002)(8676002)(38100700002)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdcdxZX3vz5A1pJvYaBc4sl4czkA9HeS0hDgQ4b7Ak3siwl8iXRM6PEgMvDU?=
 =?us-ascii?Q?WU5Cc3yc2mA8GZMn8jO8euw9eWTp2IN9cGab/2G77fswEUgPwMrGZ9hj9kic?=
 =?us-ascii?Q?oks7KPGmr+t37h8pjCAc2kgzeyI4TplJgSK0Wu6UA13Vj6dIBb9q9wdhqbcm?=
 =?us-ascii?Q?sYAwfi0cv56jIzXe96s4WS1SzPoS23M/M8T/WEohUdIdXCe2ugBw3amVCebJ?=
 =?us-ascii?Q?TRVBJX1LhBRjclZ5LRmMlb+M2EzcSiM11+QDlvOP1p37g5GyXrN7VXu47Ro1?=
 =?us-ascii?Q?q6huC0tye9fKp0Q4dq0oxTfGfTiqeIEUaEqjPeMUamM0XlJQvbUddAjR50MG?=
 =?us-ascii?Q?TiS06/AGWlDTbIGWfx8OWvxsC3ZMKBkOKHarwfV+t9CHbz+I3n+Sj08tldEN?=
 =?us-ascii?Q?ocrfQmfs5i0xB3xy/B2CiGZZ4RSvpSWre+CQ/MeuXlorMW9ZKmXtVl+VE3RQ?=
 =?us-ascii?Q?H6huuY0tb2co3OjibKXQ3qqWQwP76aHhIMQ5xobSISlyAE10709fYRkRGjE4?=
 =?us-ascii?Q?a+oc2G3DBE3h+euyyQFybatCnzdR/SLz/hGVa6XGBiBA6fTntuTsP2vfyQ9t?=
 =?us-ascii?Q?qhpwEUmeftS/lHC0S6i1MBQD+snFEvpuhW1fZa/Xt2atMWJ3ldjMwuxnRoCC?=
 =?us-ascii?Q?9PtF4wpKk4P97bfvsmYD/ysbrimMzNYGbKwcpnG9GR+g5ioJ1YeTardOk07s?=
 =?us-ascii?Q?gOlFpUbKmDDxl3q2oYQDmswIuTaVoetkaikXxmcrjnUeiCy1U7EtP8FeG3/k?=
 =?us-ascii?Q?VVj2k1Uqi3z+zYOjQn52OHpb+I3gUT9XKa4gxFK0vaN4a5W0pH3GVY3rZql3?=
 =?us-ascii?Q?vApxYR1HAdJRug1HutT53yPe5bCGvlx4cQJ2wMY8mFzp9rRvV+wk6XbmhjPG?=
 =?us-ascii?Q?FlmfhbZ9pyGAAozjG8jC0wdYJzc45DviaxFlzGiHMe9qXlktWnr5shWwfsAZ?=
 =?us-ascii?Q?3zbfqwVAu+2gcLetZ5SahbqYMRlzu6uopBthrNWXUatNCWkAqLlQLVIrCqM5?=
 =?us-ascii?Q?ccWChqbCqB/dXBZcqjAtYanLSTm4v7MD1QB+atF8Hq8QyaOtOL7B3wy7pq2L?=
 =?us-ascii?Q?v+bLRRQtNn8s3MSaaUQ9vnwpNV1/UTftcRt3NZKc2XRIxdvWiXqsn0GHFr+9?=
 =?us-ascii?Q?yWPqVyKYxmoIEBTb3u/FX178oMJRCb7PcNYoTKfg2M4UBrlwj0IqDcebXvI9?=
 =?us-ascii?Q?YTDgOva4avZqYpRfERQtvFGe8A2wJjImrMx4JzRNdH3UurM/mCDq88SR9mRv?=
 =?us-ascii?Q?ysemkI+NO/TLEWe1Q2Z4nUCccRWtzQqQ4jNnq/45W7bAoPyH7vQWno0x3sn8?=
 =?us-ascii?Q?kVWaX2NO/gNbGjaIrcWsH8ZfILUdWe0AqYjL/rqaUY7Yw5mRQauv3G0OIfz0?=
 =?us-ascii?Q?Xi/QWNbgIi3czATO6Qq1wiGvHvW9kv06iTsKuOMiovN3Wr6Fy1ozOUNJiLCM?=
 =?us-ascii?Q?kufYhtd6R0+3ncUOLPsvCIKI+QYVWYLWTL7DbF2wmJEeEPCXE5PpEPFNDtxV?=
 =?us-ascii?Q?NxFVkaJkuVbzaAOeYAmTE3M8Ovxps2iXO18p8pjl3Mo4/0j1hW/R+s9hEo2g?=
 =?us-ascii?Q?crsZZ5YEQle/la4IzsLCOa962b4SSqXD7uJWKoWP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcad70d-e914-4598-bd44-08db78a5ae70
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:35:19.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If5MuoTCqVq9qhcJmtPqIVj222Fb3CFfQ2hrLLTriooi0+5M0gT67vAdKWB7ZdsKAoZpTWI5QlBjVW+qfnkLWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

Use a new env var speed instead of using 'speed' argument of run_tests()
and do_transfer(). It can be set with 'fast', 'slow', or the actual speed
number.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 230 ++++++++++--------
 1 file changed, 125 insertions(+), 105 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f829fb39ff8c..a80b3bd5430c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -56,6 +56,7 @@ export addr_nr_ns2=0
 export sflags=""
 export fastclose=""
 export fullmesh=""
+export speed="fast"
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -109,6 +110,7 @@ init_partial()
 	sflags=""
 	fastclose=""
 	fullmesh=""
+	speed="fast"
 
 	#  ns1         ns2
 	# ns1eth1    ns2eth1
@@ -989,7 +991,6 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local speed="$6"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
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
 
@@ -1208,7 +1208,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
 }
 
 dump_stats()
@@ -1997,7 +1997,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 	fi
 
@@ -2008,7 +2009,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2019,7 +2021,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2031,7 +2034,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow &
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2130,7 +2134,8 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2240,7 +2245,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2251,7 +2257,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2262,7 +2269,8 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 speed_10
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2273,7 +2281,8 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 speed_10
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2286,8 +2295,8 @@ remove_tests()
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
@@ -2299,8 +2308,8 @@ remove_tests()
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
@@ -2310,8 +2319,8 @@ remove_tests()
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
@@ -2323,8 +2332,8 @@ remove_tests()
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
@@ -2337,8 +2346,8 @@ remove_tests()
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
@@ -2351,8 +2360,8 @@ remove_tests()
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
@@ -2365,8 +2374,8 @@ remove_tests()
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
@@ -2379,8 +2388,8 @@ remove_tests()
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
@@ -2393,8 +2402,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-8 addr_nr_ns2=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2412,8 +2421,8 @@ remove_tests()
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
@@ -2426,8 +2435,8 @@ remove_tests()
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
@@ -2438,8 +2447,8 @@ remove_tests()
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
@@ -2449,8 +2458,8 @@ remove_tests()
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
@@ -2463,8 +2472,8 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		addr_nr_ns2=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2472,8 +2481,8 @@ add_tests()
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
@@ -2482,8 +2491,8 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2491,8 +2500,8 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns2=2 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2500,8 +2509,8 @@ add_tests()
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
@@ -2514,14 +2523,16 @@ ipv6_tests()
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
@@ -2531,7 +2542,8 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2541,8 +2553,8 @@ ipv6_tests()
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
@@ -2554,8 +2566,8 @@ ipv6_tests()
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
@@ -2656,7 +2668,8 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 	fi
 
@@ -2666,7 +2679,8 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:2::1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2677,7 +2691,8 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:2::1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2689,8 +2704,8 @@ mixed_tests()
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
@@ -2703,8 +2718,8 @@ backup_tests()
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
@@ -2715,8 +2730,8 @@ backup_tests()
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
@@ -2728,8 +2743,8 @@ backup_tests()
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
@@ -2738,7 +2753,8 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2747,7 +2763,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2755,8 +2772,8 @@ backup_tests()
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
@@ -2765,8 +2782,8 @@ backup_tests()
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
@@ -2855,8 +2872,8 @@ add_addr_ports_tests()
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
@@ -2872,8 +2889,8 @@ add_addr_ports_tests()
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
@@ -2886,8 +2903,8 @@ add_addr_ports_tests()
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
@@ -3089,8 +3106,8 @@ fullmesh_tests()
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
@@ -3102,8 +3119,8 @@ fullmesh_tests()
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
@@ -3115,8 +3132,8 @@ fullmesh_tests()
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
@@ -3129,8 +3146,8 @@ fullmesh_tests()
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
@@ -3141,8 +3158,8 @@ fullmesh_tests()
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
@@ -3153,8 +3170,8 @@ fullmesh_tests()
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
@@ -3165,8 +3182,8 @@ fullmesh_tests()
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
@@ -3178,8 +3195,8 @@ fullmesh_tests()
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
@@ -3354,8 +3371,8 @@ userspace_tests()
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
@@ -3368,8 +3385,8 @@ userspace_tests()
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
@@ -3379,7 +3396,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3399,7 +3417,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3422,7 +3441,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow 2>/dev/null &
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3445,8 +3465,8 @@ endpoint_tests()
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

