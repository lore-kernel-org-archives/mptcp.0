Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25F612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nnZhWEmj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIX1AG3Ep8LD7dE3H3fTCL9UN4yk+ccnV2bwJlOt84wu+vBYMxlQdz5Czh9D/1+jjFFOxOFGKwpoKHi6pz6KJdcYCwkXhKhgOfBO9RKWkMsV7IyXok8dNlEweO1UeS6g98AMGhOML9RZ5IS7+lu0633SwL+HeXpWrjHa8pSOsP2uaVzyckXzrlMAGE1a4wZbMbJbOeZGCdbugqRb5i0yJywmqc0G9l5VVrH8LOZwsDiAdwp9wuZpmM4Q5Vt/ajogTVkCwrXJvQAoXauBZxGEokkelXgyNfyjW4YvUP63MO0/oAQeta++jZO3ounTuASBRhGbjq3ExfqveFEMCy66PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moBAUjw9K4TFJZP0DrfY1hMBYNM6GAtpA93ldHiEbuk=;
 b=m6N3uXNdjy8W2wCIAVFeaYJA43kqmRlL0GJ3J+tyRjaS7NOFBSFHLgI7iHqrpApBpn9Q88/k2Z9qNbSgVDu+OhE5juTwx4BV+nl5g+3yTE9LltS5l+3NbhvnXUY8i6hjaL1fwIiBjYP4Js8HTzgsYelbxS391cf4b49rsf02KbIxyr6e/rfYcFCTLScAFSmmMHeUxyoK3HBD1SWYs+QbSStMDs3WjDjYuC7BWcX2PKmQSXta0PT+BSCYhyNCoWL+US8iNbPowR7PiR0pwZbubiD4NJBWDxyN91tpAXW5GYwGAPQ94ApFj8CDI+2HSlHTbw8JXTFHj2mRgSqc1pgHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moBAUjw9K4TFJZP0DrfY1hMBYNM6GAtpA93ldHiEbuk=;
 b=nnZhWEmjv6Es64Lnu6ZS/pY2UahGLIbRvzaVStNEuGFQokcwZg3ZeA8HpJaqSJlOFXxV0aITBbcNFzxE1AljJg8xml6wsmITtGjzFW+cF5mSdsJ1j5AOoDkFGDEWlJ79k4TJSUoxwwohLQuGUAveAMlXiy0NrOp1KPF0j/+hGzrZbLVNUHE2VWKizvIEUXWDSV3SjDQ/PImA9/HWzJ14iPj56JowetBTqRHGijc1HC5fpIEgZhSRG+rhzkfQ0dryRBxPrIeGgTNN0akioLoaK4k7E7+ur28VEgHMyAZ+ULCjO6o9FiFvqY78vu9YpPl7xvLMjJFj78Xyq7NJnAhZgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:39:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:39:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 13/32] selftests: mptcp: connect: print colored output
Date: Tue, 14 Nov 2023 14:35:32 +0800
Message-Id: <0f93b016089cdde8f374389b3fc52a327d29a7a9.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0221.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5a25fc-5129-4a44-622c-08dbe4dc79fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0QpVqLVHgVJqODTiJXRaina0CN4rV/ayzcE0uFHbZeeNApHpnNekJ4CHXtHN7m8mOgLUK50u8kgdjzeJTcW5vAiLIgbPNe8UuH+KQyDMiCYMGyW91hw/19jtnops28Ect2QrrLU9cxy8G4bfJ07ZbN3quUm3AGAO3twd+mdNxKoY+BvJHKof9+CWd/0M7PPrCXIX8Vd9ug7xU1OjxhqeA/k5WRfNI7YHrYnQLCFE59jou73IwCQHm40RRpBYMsps/pCqqwyYtBlVAn0Yw1Kq23UOdKNWlzLBPap4mCumqka6ofgwgI+4dLTR1sgOH5tB22x9BvGNjrPofKqtRzV9iw4/h/z3UNtgigOVM83h6tw7nvW6EycmfxQMhbUMagVTM+nSPT+CMXw0NxJgjAJyjyNS1IK75RTN8PiTeoKFO1P9qPqDjAJrsuBjKJIlZC5u9laGXYNVKqvOFBAGXA2hMuH+RhnWTLLVjtwiQ/3I1tnztyzrQnJNx9ZQGxVv24QuL1uuvDIOCLRVu/fJoFhAUbbeSP8AvWVWxAE8NfRKIb+B6RYRiJ90LBTGVlUVf6nK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fViac5xwxw+GhKkyfw2N1Jzwc4qHWxNFr97InT6ZwinkMugTHYRNkT/F8YDm?=
 =?us-ascii?Q?bvR50yxx7XwWmLYcaIVcHSAqfrFwcpYgeQG9qfnvN7yyoxdzRXLdlGamwYjV?=
 =?us-ascii?Q?wKj5OQtL2lSbhnojUzuqBywcuzKJwS6SQJtu+vwq/lcqd4/mS4J7C1tFoWDH?=
 =?us-ascii?Q?iT8hCpovKRN44SGPHmm0rPavOCnNLQlklfYTlwPNehuHedp7ldsp/aWVdE1g?=
 =?us-ascii?Q?TVHjf+Kjsdz1fsPrw0aI1ZX47+AgE1gTPTAw00EIQam0ioJcBtY3GPSDCV9a?=
 =?us-ascii?Q?TWBYhSiBZf9EyiOT8fGaogqGcHk1xwQKWLavkWOBOdosS4iyeNZBHfDr5lAF?=
 =?us-ascii?Q?PXCff8z/jYp/6Z9C0GrAXd8sQw3P4D1szIkW+M2p2Ow3xSqRlG79+rEGFV60?=
 =?us-ascii?Q?qjSrj6Bl7rz/1jVskqGjir/ARfw+JPCkag3Dl1CldM2dZxNu1JF/KHwVXZFx?=
 =?us-ascii?Q?gDrMsWVMv0BTdySkpS4KmAbtk7nQI7mT3nkCYIvVl00SEuQ9Po8vCK6KVRxi?=
 =?us-ascii?Q?aqzIpTofX6KT+RWz4076nRjBak9KyHgNIOOwK5Rqy1KIRUrN9IjeTYhMcc96?=
 =?us-ascii?Q?HYGC9EnO1NS3hhV9fzp02RYOKdepTNaB+LBtsR6Kob3PrIhwJivArIqD0YxB?=
 =?us-ascii?Q?s/9WMY4EKu3FQ0PsC6M2cWd2Dn01Xb/NMDjJaLzO9XJH0Ij772twp1kxUDxl?=
 =?us-ascii?Q?10gpZ5WyP+e6Jkon56ylUQzR0OmrpwhX3xhCABHCVpfQQ0V2c1EMKn6vi2o5?=
 =?us-ascii?Q?Fg39G0GKBLPMpOFY4Uz/6HxGPZE3WRghVGI7eld+T7L1tyl73GIWE+PNCKvk?=
 =?us-ascii?Q?2Vgbf7h/SvXBzX5Ef3zJUZGW0aK5hEHd9Hr/1B7V0gDm5q225rfTCnsQG3sS?=
 =?us-ascii?Q?ANOMawvDq+KGMMVQQhGokVlcB60JZSf1CYl6dgkyh4asCU0G08F5JIbOcQXK?=
 =?us-ascii?Q?W8gtx470cXMybp1uSq/GsKBUJBP1vkoqPsXYFTwgWVT7mig7JXm9RemB2rDu?=
 =?us-ascii?Q?aKmkxbh02vvhN+dju2Ir8MEFK9Y54CMNvGASJGPWf7bnIGA3bN7o5jvCWY79?=
 =?us-ascii?Q?AxLiHWZmjZ1Qzrwvp52iWy4u6ctuPECpIyGo+2RWWHfdb8/wMrb/ElvqQ77R?=
 =?us-ascii?Q?dB8f6ue3JZ8V60bJvyXz/UzUfTlK/kj19iin3QHcqZ1214cz9anjG7En7lLb?=
 =?us-ascii?Q?emeovm/asAol85/mbtvFu+tuc7H2MJ3JwL3BV76UQ7CGlyG8enln0+UPQZoj?=
 =?us-ascii?Q?hHTtBdyXuatBlzTfupJ1KiPI+cbAOdfYvRerCZE20QE9atmRAmOEYiR2XSuW?=
 =?us-ascii?Q?cOtYgDLMIlh0jUNIMRNADu7K5blAXryZmvmZlCivxY+GKb0vQ9Y+uE9MLCIy?=
 =?us-ascii?Q?Nks2OH0eMB6FcLwkjbAEonpctW/XQG6aZp2wrzkAK0SjC1g6QngyDh85+VZB?=
 =?us-ascii?Q?gF/6YKcMrvIj2DCQvknoV/5gDnpYBruJNa5veGCZni0mL86a0MfGjVAWfi4O?=
 =?us-ascii?Q?YCkzESvW5Y1xmAM3r7sMXedJxE2hopLe3zRbbn1PLUJisX8YK6KgFsLBQ501?=
 =?us-ascii?Q?v35pH/ZtLUEq4s05bde8EfcD+OE2a0KOb6LekGHK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5a25fc-5129-4a44-622c-08dbe4dc79fc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:39:39.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG65tn2Z2j5pzZiMrdBhjszGjLfJSXF0UL+Okg7fmAxvSaiGTsVdM7JDtYHzGMhQM/T3kKr9EVsrMmCzU1Czvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Use mptcp_lib_print_info() and _ok() helpers in script mptcp_connect.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh       | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e0263e691a8..4041414c8804 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -266,7 +266,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	mptcp_lib_print_ok "\t           [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -482,7 +483,7 @@ do_transfer()
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -513,7 +514,6 @@ do_transfer()
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -689,7 +689,7 @@ EOF
 		return
 	fi
 
-	echo "INFO: test $msg"
+	mptcp_lib_print_info "INFO: test $msg"
 
 	TEST_COUNT=10000
 	local extra_args="-o TRANSPARENT"
@@ -716,7 +716,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_print_info "INFO: with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -731,7 +731,7 @@ run_tests_mptfo()
 		return
 	fi
 
-	echo "INFO: with MPTFO start"
+	mptcp_lib_print_info "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
 
@@ -743,7 +743,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_print_info "INFO: with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -767,7 +767,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_print_info "INFO: disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -816,7 +816,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+mptcp_lib_print_info "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
-- 
2.35.3

