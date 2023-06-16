Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163023C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrx5fPhpwMop5zVvHvQ+YMQeaWNZJJM3o7HH1/d5NyGiz2jUi/Zjc2JXyw/KLr+CmGBEr8rkoHeI5ido4q5ugWtznPgg0FSvYjjvtpLrVf0C4vDngbOXBox/Mdy+gL/gUct72wUaffUxzC5GuTjr1vV7qX1xAmD8d6a1BxEmlWDCLZ+sOHuJjWWEC5sznracvKzZNAtwCqzgh/P79i7uEyNKvzbqPsKZjGjD5hhUrt4y4aBiiQp4Men2+1xwWtF1f0s99pJqleu9RisKIJY+xPWAy/WkYXGlaX+8kTc2ARXPYRKjdw0wDGiLBwq+3EneuJfcHBagrB3uaKCWkVBU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xfYBOULAAaND3fEHyQYYm3zNDbHpcTFCPlre/tlbhc=;
 b=WX20alguUiVNo+GT/aVG9Qxdc/LKPpO3UhiEXwVGfbsXKqCems33tz5M0c/ACWPhwglqV8ALfk5zrgZUZTeH4YreH6eOTorZNi0YfgvyTzfZw1XXYO5lvjN2z+c+7xNhj5/iurw78ZVYH0/tGWIbS2CZLsteRTmek0lhKZIsFXwiKPn9QK4V2NgWY86S/xDw5bvK4BlTy6d1Od+DwkomPIEYNdpNH+vvOOvKSejL4ob0rKn6wamixRzi6F5DU/ItdfScwYEU7Pe8Un2mjnchnMjVkcmao//rt4pJivapGzdM53zw+NIS5HYassW/4vqMSsDHcmaQEx/dsbUfrgYlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xfYBOULAAaND3fEHyQYYm3zNDbHpcTFCPlre/tlbhc=;
 b=Abc9SlPbOAQ736eR2JG8kMoFaOIagcideXduQ5xrGaFKu5uP3sxfHkXarECYWyH0H92U8mychcysZ+SGMaDG2M2Nwqav8FSVC3FDUlTd3gNAhWrMjS0Vu0Yl5oEvEJw5fmUoHi2vGpCsBlQUztb/7vJhEF7QPUw2F5cjeH+1e14dRerlw5WqucUAJfxmMiiMe5ikIiiwjRQ5oTLoQbudYDwLwpov33RWe9jyzzIpwzJE0IBawYCzn90Z1q9UPxz0AWhodLSfzEP9E2hT4lPTwXRO9AlP7qu/ncUbvDb0S8cK138NQ37+hR9RgaxloFr0awZYkYoSGxXYpkW7mV7G5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:31:30 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:31:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 03/10] selftests: mptcp: check subflow and addr infos
Date: Fri, 16 Jun 2023 15:30:55 +0800
Message-Id: <91c10944663b947b6ccb8b3be5b2f8581295ba73.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: fda36468-6471-4d24-b7e3-08db6e3bb3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2L+4H+vtB0kOkfTUoODgoas19soVMdPUhtj9Wanvh/z01OmVvzvx1reP38/ZGi2DgvoCd03d0rYWk014YciXi9FNclNpd5PctyUqpn3Eh+cK2hIPp0g9DyR4r0UE4r77J1JdvARFUv4+cW36W+AGat23UCG1OqvsTSYA3ziC+WLgA5xeHNucL6w+J8CXKVKD2dwJ6onrbknLth3UPJyB4UMRKjLw4b7bo8W3RX8zcCcblXMKLOfX3w7nuqdmMjq9JRM3rx6Y3N6Yd84ezNZqZYfPiWqolSe6iSQJS43X/93uuz2Z0KzJtqE7HLkngTR9FdwKXsg2h0tEjy6D/wO0lL0ApQ6eFs2aILM5EXgwBa6/qs56yHzeizDQLOANPGAuBIEZXBLC5UeUFuUgGjkMCd/Z9L+SZCtMUVUFRg+G4Jp/vJevSiWs11Cf/E+oLZkMnTTIdjCmCkaBIejOnugxnb9df9d0ikt/V2YTe+2ZDPfd/yAbqRphqmlzwwJhK/GgvNGWGioMxFV0lofAhRsUxviiTaRkAbP4izlcduVQybQL5Q+zC12ppWZeoUxnXj/0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(6666004)(4326008)(8936002)(5660300002)(8676002)(6486002)(41300700001)(6512007)(6506007)(26005)(44832011)(107886003)(86362001)(66476007)(66946007)(6916009)(66556008)(316002)(186003)(83380400001)(2616005)(2906002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ON2YxDaB0ZZj37n0F8xjjO4sHEn59MDzYZppD8hT7YUpdEWgqka5aj61jFEx?=
 =?us-ascii?Q?sVrLC9QQsbLgKJs7dXWq9s/bXZ6EgBXd8eV07jm0VLKpSmyFA6Wq51UMJnhJ?=
 =?us-ascii?Q?OT0HzAxQGZhf+dip9QOCSbFuqgUltYx/183CSHK0lqKvfSyY1rP05vStIlP+?=
 =?us-ascii?Q?UOdXT0v/x1+m++ReOtYnV//fuYNVrNmZGA83Z5YSm6YVEfoctZg6ACC7d1hH?=
 =?us-ascii?Q?3JPXYkb0vkMu+aqVIfMEtKHr2fIsUpfajRNE1m0Koj4vJs7ZJbB9ODyKRSeC?=
 =?us-ascii?Q?+oB/NppGvEbouFjWHL4rEEUPR56pwrriayg+iTFe6h4BOv7JBs5jKIxRJKAU?=
 =?us-ascii?Q?U80BUBW/fg2O6DJ9Py46t3H8J8FdUU3TRTYT+isJxSdAwPpkSdaGyNdjT6iK?=
 =?us-ascii?Q?/AfXEsLJycak4w4/mr32kmppsLaMaAOmlNDSroJfBayqV2IvqC8XAq+OVfdP?=
 =?us-ascii?Q?e3+5v75dPdpz5W9xtS7A9izKnU68SjtUYOfpG4nE+sdgHtwYVuLt74Bc09RG?=
 =?us-ascii?Q?iB38reiEkYQ/oK7VGBCkMhobobAgVOVXGKX/2c7dNzN9TK5BtlGWUZBN1wKt?=
 =?us-ascii?Q?mtPka2pkq71+p+1H+aVa5qGl4P6yYhZIVY9xHGll/99VaaLDFqV2IOnAUYeF?=
 =?us-ascii?Q?KxpR4XMjq1qRx0CwXR7tGeNm98bL8gTkHBya2MZcl+8tnh6hUdLbuYHYsKdF?=
 =?us-ascii?Q?jQMVRGXNltCCaJ+lrovmsdGdzJGk+yh0F9MveC47cVMpPlGCcDgyfVgufzit?=
 =?us-ascii?Q?pEGgRCjgX6832dEomxIh27OqMZhAOiFVtTBffy/LicTjNwJIqpeh5YnxjrnB?=
 =?us-ascii?Q?8NMmyJiyldsJGxj2GIXmuHpJ7y/n7W3q6VctMKLOtHxD1R+AU1/BLNrJtz4X?=
 =?us-ascii?Q?2Kn36AsB7RJd1rxSsbLfDtkfESsTn1Hq6BKAPWlgcg7Zjy0bnYbkj4/jr5pt?=
 =?us-ascii?Q?W0yly1+yBsPWzMe/xoSXF0VjzX2q2l+VqKV3Gl5jTLshOghK930c1BUIfp1Z?=
 =?us-ascii?Q?fShkrz0bu3EEvM5CW2RuuB2Bx90kzaD54g6WpP3vf7TCko8zqykKz6RfKhaM?=
 =?us-ascii?Q?un+TqH6gVMGmyXWXizJDRbwG8L6EdiGcth3C5OkJw6fMZcHZ78OO+e1IFGfU?=
 =?us-ascii?Q?5owEl7ogKOvl7vmc+dnEhI8GUDjMzIFWFV+qdpUTdCaQHifspqLahR6Xy8QA?=
 =?us-ascii?Q?mtge0TkAn5FVTSC4yRStkkDHblhz1aQRZP+E4Pr4lPHRPuB7AvGKbTx0FSwQ?=
 =?us-ascii?Q?PueGF4BCzVyJJhEGET1IXONfceP22QhnU7SvmYh+qhfvqYMZvE2ec/N3BPc/?=
 =?us-ascii?Q?o937An8FcSwQfVzgTegB82heT4Awai27N8cCGeXJvyrqIRmG9isNmadYNhFb?=
 =?us-ascii?Q?sdsp6YqQ5REGEh5Slyp0H/yuooq7KY5meSLXwwBu+Lqaw2FzZ20JoZoOlNIX?=
 =?us-ascii?Q?sQOdAsobPob1iRajo5Jo9tUte0OliwvgZ5kvydy1Scrw9IuHtrB87Ps2Rq+v?=
 =?us-ascii?Q?phlWDui7OjEtTx+1BEOgcpBLDYqrZ3GZSXNB9Z4kfhUYVrQ+zN5ZccvAby+2?=
 =?us-ascii?Q?FngzjWRx0M4h+DWIWDp3hkBo2n4BE2//pOG7ofRO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda36468-6471-4d24-b7e3-08db6e3bb3c2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:31:30.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVpACfGZrDAONHZrURyvxdL5odxrCVVpUZXLt3h9mR8WtnYC2d8gPBjsbbX/d35uM13YWAKmGGZceN0iLugOCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226

This patch adds more arguments for chk_mptcp_info() to check subflows,
add_addr_signal and add_addr_accepted infos of different namespaces. And
invokes chk_mptcp_info() to check subflows infos of userspace PM tests
and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 48 +++++++++++--------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3baa6ac3b03e..3811a6c3dc5d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1832,31 +1832,32 @@ chk_subflow_nr()
 
 chk_mptcp_info()
 {
-	local nr_info=$1
-	local info
+	local info1=$1
+	local nr1=$2
+	local info2=$3
+	local nr2=$4
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
-		nr_info=${nr_info:9}
-	else
-		echo "[fail] unsupported argument: $nr_info"
-		fail_test
-		return 1
-	fi
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	cnt1="$(ss -N $ns1 -inmHM)"
+	cnt2="$(ss -N $ns2 -inmHM)"
+	if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
+		mptcp_lib_fail_if_expected_feature "$info1:$info2 SS counter"
+		echo "[skip]"
+		return
+	fi
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(echo "$cnt1" | grep "$info1:" |
+	     sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(echo "$cnt2" | grep "$info2:" |
+	     sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
-	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+	if [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr1:$nr2"
 		fail_test
 		dump_stats=1
 	else
@@ -3332,8 +3333,11 @@ userspace_tests()
 		userspace_pm_add_addr 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3348,8 +3352,10 @@ userspace_tests()
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3369,6 +3375,8 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
@@ -3389,17 +3397,17 @@ endpoint_tests()
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
 		chk_subflow_nr "" "after delete" 1
-		chk_mptcp_info subflows_0
+		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 		kill_tests_wait
 	fi
 }
-- 
2.35.3

