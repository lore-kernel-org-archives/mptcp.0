Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554FC11192
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koufAdm2/OfR0lVs1a9I1AePZGNEcGNRZKZIQBz6zzxBY5PBxf33hhXcTmGnULSRLggGZ+hP+ki/Xz48Uv90o3nQTa0tpSST48XR5SfZVcvlKn3WHTyZp3luiAwAel9+S6l/Ce364KXTJPF78aNmdCeEtPE5OyNmwzuVnitFlCC1ZHKJDbMjusYefsDhqUSRF4I+zGsSEGHFFCMVeNU3/KmGhSMfFEiE5DrFwo0DlqMJbBG0xwaFixHaO9dL8yvovZ6l9aXkQNx4UR0QjZUTP208HPXazp0VDG6VSDsw06OYZfSFynmrXszx8DVejNhgj4Doo0mu8d7k/QNMmk5F5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3YUl256b+5CtRAQxgSoySGn2pvEoM7H6HHgVvvs63s=;
 b=UX6d1yyf9an8k/W9HNsiMi2ybo5p0PRf3xUnDRHseEIw2ZlpOmx55lh6jBP+MLxXuu29aOHoa4nkYFLXcY2m75m3yuAA7sh0b//c2YAHBVwpbwELcR7nWnKwDaVLhxVlwRh/9VUCQ+wuWlBLIG5iVQqKAYhtBPKnfAJ6aYbY3Yh2csvwR456CjUedVLbUIXIn+hofdn2D+kf//t5Hbwmv2ALxxp6Pu9QvxGGeFUSzwmkr4N3/Dze2HbWyVrg8idjcjK1YVYLKxkevzuizVKXEXbK81JHlf/ZtNI8o2/c7+M51iWODvSWv4sqHaXFNFHQlvbE72nvfcR4gMepYZT5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3YUl256b+5CtRAQxgSoySGn2pvEoM7H6HHgVvvs63s=;
 b=QUT49q3ZgFeJmqnH93zbVZck29QzQwAYvDTsQDRf9oG9cVTgrSCGgrKbJ38t6k0WMsWiY3na/7EubAa9S9pzHnoB0RpqF8aTAnVdlB4JPYHNJ9Vyzva+CQCMGwtzr2wQ5BU9Rx25xB/3yokDopHEPNvzuX911mIsNFO9dg22VEqiWueRKdLSBbfftMghMyLbKLhxJumMpFCPtq5kdRycW2PINKHc2NN6xlxoEmH/Rf2FAb1z/wgJITWp13YoLyE6v7sm96na5l1N/TW6Ssfr03GZLrBqwxyTYE5KGYisG6svq2GlyfreQhPLdQXEniIcMEzJIJuiquY5RwT+hLW/Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.37; Thu, 29 Jun
 2023 13:35:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:35:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: add fullmesh env var
Date: Thu, 29 Jun 2023 21:34:31 +0800
Message-Id: <1279f658dd6aa12561713bc985d548a1a7fac0fd.1688045383.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688045383.git.geliang.tang@suse.com>
References: <cover.1688045383.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 016454f2-b616-40f2-473d-08db78a5a77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KAllUWEnXj9dhgFp5i8rmsJWiFSXRPYocps9py0A+mHl4PQPXd9Gh2VCNefY8nDG7bY3a6cwd8Ba5Me24WNPNrhStFsTSvG9DFHEarzWq4TImYQHeiA68e6pWgcj5+MN2SibZ9d2N9Nzj/WtWg8AjLZG+fQ9TPsoSrABlM/v4LDn3WogoAiaC2D9D5Z3f8k+8OzLJDthQ4VD0GuLFstQ5bvHuNPYt5qPED9fcuYeaaOMDDlcWQ1Er8YJxbWSo8dh7QMs4MurqEmHnbFL4wCAB2TixHBqxnkMC0fKmt+ZlG/30jo2DlDKfQkMvqnNVqIiW/GECmFckipIQep1dM/ISUw6Ptv1jSwtrBV63u3k59HWdNkcR3voTIr2Amf/mgXpY3276N20M12yX6RKP0aoPh7hBhWp+zf3F6i7r1vhdiJbymhP0sjs+ayeEYh0zfCuYb41MF8yj6t9oXOFulzTgDL26SepaBRm1Y8jbzK/RK/HY/aaYFAzzorksMQiuZyZL0uryl6ktsfwU457fbjXMr7+ufUOVmbYX7+WMYzgXAzkPNuEFHyGmmK83PmnTNil
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(6512007)(107886003)(2906002)(66946007)(41300700001)(316002)(4326008)(66476007)(6916009)(66556008)(5660300002)(44832011)(8936002)(8676002)(38100700002)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36EXJgRxtQRtgLkBs48NCktSwRHQGcYUicTqk0M/F1aH2pI01nRg6Ad9/uNj?=
 =?us-ascii?Q?+JXqvolRoqvHZPsuU4s5FCn/OdwM/5Q5uJf45sZBFYr1rbqgwz/QVYz5+0NK?=
 =?us-ascii?Q?Y7QOvSE1hA1oRrKI3oGLz8AyMOjReKxUlW5JVpstwzQYB7rxRehCiaZ3SrgV?=
 =?us-ascii?Q?NKCCh7sbAEfidfh4DnLyAILDVUxkjfGIWPn0uE2bUx6NUp8lzEZHSt0IeF7t?=
 =?us-ascii?Q?Eb3j0t+JNy1kr6UXj3mZaKNBpzlohu7V+Wshe0Ccydqaj4f3KGaOF5pvjblz?=
 =?us-ascii?Q?Uak0SGE8jmg4o9tupSCKr4EMJe0N8qSlF5N5OfvgtQug7y0HzvkUIPjJO4nQ?=
 =?us-ascii?Q?ZcD1zsdzDukucPmrVYt4ocbBQLy4yWXuhSo90T7VFla0G0/Rgvt+NWN4+FdW?=
 =?us-ascii?Q?BrlH+mIQxr3oeEn5O5VVpqcO4XVoGzpUA1KwUb93F0Bk6xaNTlC0xdHSbuT9?=
 =?us-ascii?Q?9OXtbLLApWPI6RweHmccaibuqnODEozeU5OdssrIp6ZuJlKsYc8G9l+uak9Q?=
 =?us-ascii?Q?T5Eu9+Kjp2YArD+UQx3GKI+9q3uaxSmViCwCKCt76ZzqETfRo3lO/0VDl7q/?=
 =?us-ascii?Q?981Favfil2xbK0rOA3Wj5zd/HKOw9BmQC9W5HLYDHnlvjTr178iqntGNkavo?=
 =?us-ascii?Q?Fy4loFUr/QWHAQR4HtNIvI9d+wLmqJ0Rd2S2rxe969rN6AJg28ER4rOsdznY?=
 =?us-ascii?Q?yZxyAGvjI/hwgJNmaPCyEL17hdeeNHOMIHpCk2N4CBtRR5Ue4f4EldYj33tT?=
 =?us-ascii?Q?EcejxcIRKSwIeVsTubglFIj+0Me5mL3OwIFoDLfmQYcVyhcdXZLr7YJOv1IO?=
 =?us-ascii?Q?iGeDOyl6y7Vp9+CiKN/XNtKFU+jkggL+QkE2g84v21lbcikYZIY2SeNCxt9s?=
 =?us-ascii?Q?5wu8UlLdcMS0UiYmAz9MO7x+iWuuDeG8mMle/C/66arEoTs95YjnCGhC2cWx?=
 =?us-ascii?Q?e88SmIT8WFZFGuGS63GGYF3LV7hXG7ouieYDcPJ1l40ykVaK0WBHWKby+IBL?=
 =?us-ascii?Q?YugWRxWlVwzktrwatk0WeSfvX/+1VPWtzD7OadjWleiZvrSd8lXETNI+0BSD?=
 =?us-ascii?Q?Y9WzB3kGOVtA/I97ovArhR3mlNEzUkzDKQ4Ig5ZMDWzvjqYD++jr3mkL9Fzk?=
 =?us-ascii?Q?RILjUORx+4rMUtVxhi+Ri+UdpTKjZNQTPgnNsGXTdiPLAJnMU8kVi1s5DZh7?=
 =?us-ascii?Q?luV7iAc9MuaHQ8LkcdeV2KW2CMkKsPmQWq2BdC9mrF/M8k1QcDa+dlW3qoB6?=
 =?us-ascii?Q?kskdbTuFTUb5b9Ieqp8Smj2ygQ+96titNwTmq2wIrehQi3tDHftkrE0zYtr+?=
 =?us-ascii?Q?Q5EK0QwYGl4T58MUFJvqjtaOixnSniYC2cMJJbf6kWdrLsiZsbVi9mUJ4yAL?=
 =?us-ascii?Q?O3StTIJe3/jSfj9eiFkUpEQOtYZzwGvxDMcYRKn4ToHH6OuYPNkx8rcsMmCe?=
 =?us-ascii?Q?TUmntTIwx/0PRJLMxEQU46Lp8P1QxbQONKRg4BYIHvA1n3lVyzDAALPJobDc?=
 =?us-ascii?Q?Iz5ybJJdNigdm/gHyJwasr6DCMhUz/JAF9/UGKurpYS7/uzjFQrRM3RR+fX4?=
 =?us-ascii?Q?AMjsAzMeBNDWcx1ahC/yxv3mXll07rIQ9zUTOgbv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016454f2-b616-40f2-473d-08db78a5a77e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:35:07.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRJdwMc+pFRQTvOUDzCLvWH50egqYYPnPAoyG/dEmvVf2ZGYr6o5ulV9DH+9FsCxHmzQzix5QHaQALmMzRgP7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

Use a new env var fullmesh instead of passing 'fullmesh_*' to addr_nr_ns2.
It can be set with the actual value of addr_nr_ns2 now.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e1e7ee46e980..f829fb39ff8c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -55,6 +55,7 @@ export addr_nr_ns1=0
 export addr_nr_ns2=0
 export sflags=""
 export fastclose=""
+export fullmesh=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -107,6 +108,7 @@ init_partial()
 	addr_nr_ns2=0
 	sflags=""
 	fastclose=""
+	fullmesh=""
 
 	#  ns1         ns2
 	# ns1eth1    ns2eth1
@@ -835,9 +837,9 @@ pm_nl_set_endpoint()
 	local connect_addr="$3"
 
 	local flags="subflow"
-	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+	if [ -n "${fullmesh}" ]; then
 		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
+		addr_nr_ns2=${fullmesh}
 	fi
 
 	# let the mptcp subflow be established in background before
@@ -2687,7 +2689,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		addr_nr_ns2=fullmesh_1 \
+		fullmesh=1 \
 			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 4 4 4
 	fi
@@ -3100,7 +3102,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_1 \
+		fullmesh=1 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
@@ -3113,7 +3115,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_2 \
+		fullmesh=2 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
@@ -3127,7 +3129,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_2 \
+		fullmesh=2 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
@@ -3151,7 +3153,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=fullmesh_1 sflags=nofullmesh \
+		fullmesh=1 sflags=nofullmesh \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
-- 
2.35.3

