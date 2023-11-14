Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AF18C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NFHXEJrI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d76+EuLwRlrVQtlZlYcN7VKeNYHorMtiD9PZ9EHA/RyvBoQ/u3/1HQYv59rF2ejHIK8jRQffXbuJBHHIWhf53zJugFN7pF1AxrnJBALgzn5ahrkrOc1jW4sDnb0rqyfLtwa51S0kfw8Y6s4RLVHPBjesECPi1Ago75PbveYAodl4PsglGooMakW2pnXv2hCHjHnAulPpYZn8OoFVeLQi0SFYpgl2RWD0lbdQ9rAnbcwMJFRdqYWYknt2VFKTiDXZbOkkG+3j0iRZb1dk/jKgnjOWH7REFAaoWkRVSH7kmoCh+qHPHTAdh+LUPchLkmIYmCDiQWb0d6pHhrs9aTIuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moBAUjw9K4TFJZP0DrfY1hMBYNM6GAtpA93ldHiEbuk=;
 b=GTCo20JYjkjVbqgiFz+pjGjiBtgkDSdVx04Zh5Y7qh8Vi0KZX/Tp7VoHUMRH5c8ZBdX+HUfPpJkdOF/A1mecB1dy/NtM52V2AKoW5jMA3iRwtQeMkwn1l5pRHjyD8dt+H7FKYm367jCZ7HGVi7j9YvRwKTw135Y2B5hW9fm96yIVvWGnTOfVhuSvoCgOlGZGOI2mlC5gD72qEmICFkA+3DOjeUNds2bKhN+2vH5e5Qa7y4ikTiZcr/iXwd2V+aOi/nEE4JJURlTjCoa8ChFjWSqCxqWlS0/sta01pi/c0lsq6O4AmDAcr2WjGsCQV/QHVTF5mzw5cNvremex4b/7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moBAUjw9K4TFJZP0DrfY1hMBYNM6GAtpA93ldHiEbuk=;
 b=NFHXEJrIWvMBXOTpRT6NqQGATt9exJb/7gAbr3paFEovmS+TrrMCOF42DoVvTuJAS3y+dAG/uVn+T7YSWAXjV9f0SlSPdNraxlt1HbANR0QW9xSxPdAF2pS/H/pONaMNjzYaZwdThHw0F9AEW3zCOKYFManr1sbXH3EOhBxfZqBVobsk28YzspZzMo5PEU3zjUD8qsCu4liKLSHvH+sf4WPmlleGt1xrJpZIDDYhFovcwMlIkgZpiTczDUJ+sgJ5eRwH09hIEAOD0p1KmxIm+yp57Bvw+Nxi4bYpzFNntRqdswKuk3yD5jFSaLCrqQZofxC6aXakYPm14eDkqzusqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 13/33] selftests: mptcp: connect: print colored output
Date: Tue, 14 Nov 2023 18:21:43 +0800
Message-Id: <38c745bb6198479f5bd4b3cbffdaf5681e9d488b.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c0ec65-cc09-4cc4-d6d2-08dbe4fbb493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T2leWKS1RZumj1g0CLNdb3voGJKrcbh/GvkbIx0aKVtf1CS7T7fXlxE03NHRnPqyQ32H+Jusyqzqa//cxq4pgyDhZhnChnfhXTjlxk6Tx2Y0HzfjtPlVodw8w5anC2no4Ny/3fS4wGc+PACySWDVevn2OhePXlPPQuPLE1p6+SGo2vPrEPlnPgiHM8tcbCt7zxWl5Z4mfYC5BP4XKeJg4MNAL6YY4kUIKjb920RUZyS29lz6QiHGMHOoRTpriBazpRGM6zczaUlDFbItAsfuflL1ASkxl3TDNEmL11s9hOfdBimqJhtvqPlv0KKi89meCugJTCZsBddoQQ1+MySH0tt9ZBTRuOuDjRno6isJc9LvCkxBYAE5dnyWrOWFFQfyT4Ip4FE/phq5TgaQUWnCYxpxr/P6wl67QyXzBVv+AgGhz2J1keWSL1YEd0HdmYhfKJ3xv1UhM5mwhF9rJsUa7w+tO1yw+MCP0YTyJDAT7mkouvC1rO2Y+mMGtNlEQS79yEiMwerBFh6U+/bfTlQUT8d3od2ZCqwcJGU5QWvmASO3ytqC/YtOt1Wo+R8UeaR3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1QoAU66MNDU2PSkRtM72Wz1VDC49cyLY+xTeEpARoy3Ch+kAm6FWqCaeOQ+?=
 =?us-ascii?Q?Oh+uZxwnjnFeosp3OLtmRy76B18S0Mezq9Sv0jB0pjAG6SR8DPn83bqO19B/?=
 =?us-ascii?Q?XAQ5UlTvP9IXP1zhfSp9SFHc+78aCczt/+DhtXV4Ifrj04LSVQUIDF4MmAJF?=
 =?us-ascii?Q?lGJovY+HoV1O+YCnIns7hIKd24ZhruyB/STSS5YEK9yrWzmR8CvQeQ8DIBDf?=
 =?us-ascii?Q?uYAts6UdP1CyehmdtknDLIDL3o5UBTYMvqCY9Xw0JKGv18AjJUiwjzcxyhgM?=
 =?us-ascii?Q?FFnI1VP105pJMr4UZw6p6d8hmGeoL9keHc5QJUfnD18QHE3VyHF1Co7xp/Ka?=
 =?us-ascii?Q?gSsHdaWlaHupm+EMX7wxcRtZgXx75EMFX6eKot3pEjPcsWSSnM628YmKbjxN?=
 =?us-ascii?Q?tPtCJeoQC7qUxfDHXeog+8x59JFoKC0vqyjMWIe5e0vAkeSWVxs+/pSq7+Ab?=
 =?us-ascii?Q?b0J4NOz7TYmZTt1nzUTwLAOpH0pvoWZUujRG+SFuGRXpjyKyIk8SCfY754fH?=
 =?us-ascii?Q?lu2bcO66ctyqKumLfV3kwYttY8Nvu73zVYKGmyW+YOtuqGa5LEKYCDRjQmPu?=
 =?us-ascii?Q?wQNzfH3TBx/lyv8zmZyclnoAgwlog8m4Uq/lA9BMjv6AgaZWXHbnUfnC43CJ?=
 =?us-ascii?Q?GN6nitPGAeKmnIvSSj0T8dBW94BaKn7zgn/hOBpnw8s3XXWVHXAYWCfhjjAv?=
 =?us-ascii?Q?aIqEJeSqrEFwvcSC4KgfNpm9Qj5D+/au3jlc3fqLbaTG+qgKVSTl8++beLPK?=
 =?us-ascii?Q?0Y9NPrwo0RnLMcocwqTnc0hExxVCKnGLJsbeOpKvYVAl/962P++fGUAHykkt?=
 =?us-ascii?Q?CqB1QBA/w2ra0j3nZgHafTsTeisyupFlWtY0refZzFjQc4ChKqDmjUMqBqAc?=
 =?us-ascii?Q?NJbKXLM3vEzBheTkYs83Pd0jdGShoskERJxD4ZvukddQuEJ0mRc4fKV5PFbB?=
 =?us-ascii?Q?AOLtL7quKC2C0Hxcgf/Tmwv/RBKbWZBXaivt0KiPu8Fq9SITALqladZrcUEb?=
 =?us-ascii?Q?HUs9NK7me/hc2HXfpud4AekBQt2vZwWksX0X6ufRxAaPQi0BC+x5ULmzqEYh?=
 =?us-ascii?Q?tdtJ25LgXr75QZF2UCzDPVcMt0a6CinJ6T8XVVaUQ2k1PAIE4vGUvCSFxfV4?=
 =?us-ascii?Q?jfm9DByHqbJurm2wr8BX8hWrMuiJW3B6FO9ENtQhjkFhNi4V7/slfzqItMuU?=
 =?us-ascii?Q?0eIDvicMGhcqAmnUHU7jZhjl9lFQBynxBkk7bBb2wp4OrGNUvkhR1LFbUDip?=
 =?us-ascii?Q?/9MpLyheQmz6MYQTZGlTOz1VatyjNwTS9q+V3HzbSaCNsFDWhL0+7qMVyNqw?=
 =?us-ascii?Q?pYhuppwTZFoSdyPSQxeiDCxc0YSequqiAcwVXCNtgveWIEwJJ0pXdhGlw3gx?=
 =?us-ascii?Q?Yi24DG3RAEXBiKhC2nYuIO10xWNCeIf/V/VYkEhRi2I62wJ707ph4GP2wggG?=
 =?us-ascii?Q?kLfHcdOqLNPP58zU6beiwiBrLgn3jC0ONGyrMtKNcsqjZrkyqH7HL37PWudw?=
 =?us-ascii?Q?QUfUlPS+dim9oKfW7+Y6Jia8PP27ymyBLY7OcaTLrsevJ8ggmL64+8RDkPV/?=
 =?us-ascii?Q?UUSpGlVZsvsS0vJ6EJsUo8nG0ecjaaVkEhX70oNUpLbi9Yd5LMFnNWLPjGsl?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c0ec65-cc09-4cc4-d6d2-08dbe4fbb493
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:12.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vYAXwm7QQtsbcS8IpRotIoNEMteu6H1/1BQnAKhtT2OITQ0b6FeB/IHwSWyPuHjUBRoyvmqtURapkYaL6bk/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

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

