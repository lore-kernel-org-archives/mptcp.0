Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368123C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhIkUkWY3vrhPDHVCXBYwVNQfFiQXRaj3rlW/Dv9km1o1Sqdp5q4bYojY7lm3im/Jo39gfoSyPuJgUltuan5xt6tSwddNq8Hu4xHvzvfHi81lfehEGrTiBobJIfZr7qo4+dNJGXxpQXfPw7I4ueYcwW0e+L+HKek9I9lCb7/kh50fb0XRUI3kxRMk/w63a22GSmluTt+ZRnjn8Zk+L/9eQc2xQC3c5g5Q8528vT1de1pzyEaEQEiK5Pjli6RWCazhiYiZSZQeR21d5j3AZBLaebLt+Eq+Mt94gf9cmytMhBnv14OAn2YFHDCjUkehqLnTge3t0j46PZAHcMK2S8hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVK9MSUaowTOYVMwXfv+9FmAL1n1AueRe46zxJZCN0M=;
 b=V77OM5D4E9gC9S7TlhyU5hc3xbqCQheq2EU+HQxBL+Jz9VjRwkPOicXBcS5IamaiB/Mrzu+IzlXHvUegZPKi030M3D+BtZ++2nn0kUMNmwN+mE6LUQmj8N7pY5EbezJJhAEomSAnbKW6uq5iy70SDiBu1EIPBKDUS1ylpezJY4SIbKlwPAGn1CTZKoklCi+hfH4oo5VF0By8gBx1t8tyfOle6YYi0RpizzpXaYcq58SAJmM8tPMQ/tizNFIYavEOXybYjj9QLIL3xYuOKGU1/1vPYmmvaOVR8twHKOxmYUvoeWs6EKoQakAGSEyJIeedkCjfYFSxUgxMnCcvltkKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVK9MSUaowTOYVMwXfv+9FmAL1n1AueRe46zxJZCN0M=;
 b=as571SgiXoOTpB88SIxv4jrg6AxkBFEBWgtm0lpm/lLJjYd5j6GWDUCzt6fJiByQGOqBP4lHUOGP5fA76ufvQcSzcnkPsauQanXafDHUXb8KjLH25wjikJ/dPlzjrdYUzCIR5CV+PPFjz3w7N8sV9KA8z0A0aJjAjyeDAZZ1dpleuqrY80ln61SFsL929SVaHESezQCwUJqzl1yZ5i+yGRYv97AuZxQ1ByS1HxvnbJZL+Y0OC8pXQzEo2nfugKr/7eh7jtDOEieabaL4ceQJfzj8Jl6JGi7TA1Z7XCIst77JeTqB0iJGfVfnl6oylA7Y3K0otTqL/98hy2FNwvSGAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:32:00 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:32:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 07/10] selftests: mptcp: drop sflags parameter
Date: Fri, 16 Jun 2023 15:30:59 +0800
Message-Id: <adde1e1326a44b97fe857bdf44683445bdbc4102.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 38213ace-076e-4221-aac5-08db6e3bc5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	foSA7wx1HwQJEyyOJLsLQ3r1M/4pqemY5ijegHHQVGkxtgUnczjeHWkErRDQHJWP3JcHi4ooIaPVcx4q5z+UCFpp395V5QohQ7anyKFBg0QUBlbjRrTiPaCR1nLZr3pP5rpHUT7n7XmhcukvvT1sTXuyY0dkPLyHQDES/i+pdi69+VNVIHJwyV3Ai9PLp9pyUvvkZ+FPNCI/wWXDMEl/sRsLwf32N/fan/aJrvTmKSmM19rglFmluCu2n7eA0VaKQ9Ex5eYhlasUc6bZ88TRrYLsqMVztVoXOPW77M4YNjHNE8959PdBC2DWH4u2n68qhAfIfqIh+npoy6ITnkv/Xq6U7EoYpd9iNAS8cvifkBXzOZNeFrrVcT+VtAg+Yi7B4I1UwUsRaajjZY8mpCYe9O82ZmR0V7jA1EmpV5jvI3VkNNxP4X1RG6yADgqLloxuRUYq9ncm7pJAvGhVQkeeoBkIoJif6Kw6THDJZy6nUrKdI/OzTz+6zdGxgu/Z4McmZA5Ah0+UYXnhQ14AifHvUSZ2ZEt+gFP7ORr1H0hv0SZb/L3BRfrQHFMlh1koMmR1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(6512007)(6506007)(107886003)(26005)(6916009)(4326008)(66946007)(316002)(66476007)(66556008)(2616005)(186003)(83380400001)(6486002)(478600001)(38100700002)(8676002)(44832011)(8936002)(5660300002)(86362001)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LyWu1T9IH/Fj7HnBKHGcdo4j7x5GhPI6DppHTw0EGeEEsko30P43XKCDplOb?=
 =?us-ascii?Q?2LFRsEgOIxBN8JrX4QVhzDX1eKuBWFQNmWedOWf+qvcFnYiB82ZAMRp+Al1u?=
 =?us-ascii?Q?dAhD3Mi02R3liljI8aFJJBkE2ZTMbg7hXLB1LP/vdzVU6cA/5t2X2tvsKsto?=
 =?us-ascii?Q?0JlzmeUhuInRMxBrErCODZ0Zveajp9xb+P5vF2f3hdkplblOjBQl7ng9GTiG?=
 =?us-ascii?Q?yonRghY3wb/gd/S15SpmxSxErRfJmH+zOvXMwFhMyWyp9QjAHun0+hK8S/bw?=
 =?us-ascii?Q?iS0zTI7VI2AKGV5AlqgjVUww0T/YtTh5xPliyff80hYoquf1Pynq2SmxejXR?=
 =?us-ascii?Q?FNzYQA0AAr3dB8O3yla0FxLgAEOJ561CRGoCqkH65ZmNaT0Mb60RZXwik24j?=
 =?us-ascii?Q?79ylMQp8CuV6uPvveH2pjGFQH2tMyTn/N2Y3vlV/9Y3BfT4lWks1duO/MhYT?=
 =?us-ascii?Q?zHyfdfnprQFzQ3GDaE/PjxZ9/jV2h9mSpqwNYUhE72SKlusvpRG6CG6fIHC3?=
 =?us-ascii?Q?yAOiEb9ozezJ43wCvlC+C4jhrgnRaQpnqqJZa4DFTV4A6q1Mty9+wShM2JiO?=
 =?us-ascii?Q?0pmpBGBCXze06W5X4iAUlnFUpj5RERaCUhj8UzDVZ97+LEkfSBI8Qsh+xOm8?=
 =?us-ascii?Q?v2fnyU1M9Qn6RbsFcKyRsAeYviTl9FNlWsFEswL95qcgYg6s9mNYj5wQYajW?=
 =?us-ascii?Q?L/YP8N0eicoESj6cY4lCCiTML8L+DuYBNwj3kWoR2g2F2zj5her8nIDe7nTP?=
 =?us-ascii?Q?SfVD2Vl1/eTI7R4J0l39na++t+ek6fe6HmvAOY2emCoQjgV91XhkjOXqkBHa?=
 =?us-ascii?Q?tmJuP8bM2HwIQkeyulrfogq884HxR1wOIJ/Rgdnx6bUZpIIzcqwElJ0vTi9r?=
 =?us-ascii?Q?oeWbk2R6MqiSi/X96U25VmW/6YolllzWFK4wRbD/jye/fPjA2Y65ehhjC6rx?=
 =?us-ascii?Q?yh1mtmcDOwGl3QQMSVoi+4XcQHvG2SM33c0Ty4rbZjfFdP/ZLvq5GRm5e26I?=
 =?us-ascii?Q?l0HQRenLr07BGyWYsrzh2K+KJeFr3TQfudZBXYTHkyW2cZGEZbk8MHs4GKT2?=
 =?us-ascii?Q?6m9JMY1WkxyWCsgSgQED0dTOqAS5w5Mo2cD17PQmEGyor86J+64Ir1k/wwiP?=
 =?us-ascii?Q?LL7cwoFfCLXP90KAzD7/sycS7MDJXeNiKRAaafxe92dC2eN3LRVUFbmLix66?=
 =?us-ascii?Q?eyVPzypiFmqOnUuZMxzPFv+WwY5Btf3EkMKTDGcc4/tdBtkuNy2E3BCsBdAY?=
 =?us-ascii?Q?RCoYunlhlXeiZs0AmhcJIETnSkov91DK2cmhgsHLqiHT5ZABd+wSx13yJKIi?=
 =?us-ascii?Q?7iaz4blyMAtg8JIrpkvN82SNNvlo42biSn2meMBsk76GeonbhhcvGw/ic0EW?=
 =?us-ascii?Q?FSoI7p/9jm7CiVztUgzPzrRi4PswzVj3PJFAYtDWSaV1hHhjwmF8U9alHgO2?=
 =?us-ascii?Q?XnQ4psKe7B37iaDGU7NWVGnQRva/hiI0MyFTHaDf1Y3g+kcV4xinipykEFDK?=
 =?us-ascii?Q?XbcNcuv42LOsBhccOl9Q1BG+c1YUM8VrBIz5Gknz2eut5pI6l/N2Yco+mn00?=
 =?us-ascii?Q?W+yOvnidMOc8kGE0uS2QHxlRmqbm21eOO1U+dYor?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38213ace-076e-4221-aac5-08db6e3bc5c0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:32:00.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOdqrA414wpKklh5G6GZkxAuoG7awDCibgkJX7DvwcTjhh0G7U2EmZSUAW/iwTZgVDdEXund7wFVYRQsJ8BDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157

run_tests() accepts too many optional parameters. Before this modification,
it was required to set all of then when only the last one had to be
changed. That's not clear to see all these 0 and it makes the maintenance
harder:

      run_tests $ns1 $ns2 10.0.1.1 1 2 3 slow

Instead, the parameter can be set as an env var with a limited scope:

      foo=1 bar=2 next=3 \
            run_tests $ns1 $ns2 10.0.1.1 slow

This patch switches to key/value "sflags=*" instead of positional parameter
sflags of do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f9bf4733ca41..49d0fa5496a2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -53,6 +53,7 @@ export FAILING_LINKS=""
 export test_linkfail=0
 export addr_nr_ns1=0
 export addr_nr_ns2=0
+export sflags=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -829,7 +830,6 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 	local speed="$6"
-	local sflags="${7}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -1147,7 +1147,6 @@ run_tests()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local speed="${4:-fast}"
-	local sflags="${5:-""}"
 
 	local size
 
@@ -1191,8 +1190,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${speed} ${sflags}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
 }
 
 dump_stats()
@@ -2693,7 +2691,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup
+		sflags=nobackup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2704,7 +2703,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2716,7 +2716,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2742,7 +2743,8 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2751,7 +2753,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -3126,8 +3129,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow fullmesh
+		addr_nr_ns2=1 sflags=fullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3138,8 +3141,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=fullmesh_1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow nofullmesh
+		addr_nr_ns2=fullmesh_1 sflags=nofullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3150,8 +3153,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 run_tests \
-			$ns1 $ns2 10.0.1.1 slow backup,fullmesh
+		addr_nr_ns2=1 sflags=backup,fullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3163,7 +3166,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup,nofullmesh
+		sflags=nobackup,nofullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3338,7 +3342,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
-- 
2.35.3

