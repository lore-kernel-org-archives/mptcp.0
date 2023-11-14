Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD618E30
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H3a3xIYo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehLUZHqnvfXwJZhJC5iISk0rGWpeRkQmQwW9HfRt5mUA72QNEqTadrfb1ppcfj/IhZOE6Z8qHUe4ffTDE48Is25MYcYzni3LugV3vSDRwgL3NkclZcbOFNIwiotJ7OdchH11pnG1jyP489oq1GWZPTA3IaEAdscpYLp4KKZYWKo2/t7rEtWMv+dyQ3Nh2CI3E2focNIY0zBIEqmXHvjG+AItv2BjJmd8yUR+batAO7aMdULYJ2HJ8A6EKYlhvpwG1yUKYPsGpaIye7VZdbfK9hHfZL+Vy10AM1Cfih8jjRuvBuNwtU0zL1Zq9D54eMdVq/Y0lIyhzImtJ+bT9HSssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxHgT9FxW4/HB371HaovJX80lhRmP6QF4+bwpKBgNBU=;
 b=JPleGh73Ix4n3HT6ZB+r5Hv0DUcmesZMU2zCsNni1Vevzp9QMMTr6GzJmIuv4CwN/Gy9VVH5tUAYJXRU+WLjoTa73Lnf+69SuG5AB7ElXAbY4g5MB/paZ4vxOHug6oqykTzqghNQkDLOYPqBqVqh4vjMNWm+nijjql1OFNdcDVPqhjNOGwUxsWS6V8OdT5Cl7q5eG2O1M+/HOrMGpBynDe63DHzkwqClmsvDI4h9/QdGwGO94vUj3QPG+Fum4f1X85WqemE10jdlIOfjZ4FahtSJuIXc0yGJBGSvHKwTuRDkJ+yvV7v8PDrdzNazuqvXLicX27x1m7Vday2Hw0E1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxHgT9FxW4/HB371HaovJX80lhRmP6QF4+bwpKBgNBU=;
 b=H3a3xIYo7fRewQCfYlEMqRwJvEaGOEkabgLPraIE6OZXGp6BKzLB9OSQlJkkxYrnpAjMYlmGrFrHbtGfiUj7l+nN1+iMwAfwCql/Y/AAaZBQZA6q/zwjkXKe9SygGDhk5PyI1bjqGCdTnmUPyLuw1KJZvxYoY7MxUD28KwWDS3VNzBB5fLlxdWQxcM/MfftmaSEFc5HeW5nRoILjffPaKUTP2iBkWRpyFK9OnkGJhH0E8cFxr3v53uJ+J5Ylu6+//sXM18CioDk3w5HB5/OyNB/xmXV2U6SzlqOVeubEJbz5BYQh3V4tAIrEOqbV7Lh8W87RR+zo0CArQ8GpMZwTmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 14/33] selftests: mptcp: sockopt: print every test result
Date: Tue, 14 Nov 2023 18:21:44 +0800
Message-Id: <5f578cac58f25eaf58b4258be0a095ce67e54bd8.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: edd67728-7ac0-4c17-9dd1-08dbe4fbb787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GTNU5Ra/jPNH/vid6cARknja23u/PY8MvcACrlo2p3qQ9MrK6biHajQfo6ko44dCVO7vk7vzXfFITqd/jI//syrI2Hijbdp7+DDU/Iw9aUW60hIu/8Rb8gwfv61Z6OGeZf1gL7Xv+FpEGYgaqBfPKC/XQyaEc+sGCthGFexUnC6MdL9uVj+OH1rb6RPpmOZdxNbNl4nCInjNdD4nYPHL8NnOIzkS5hCWnHeacYx3GVyJVTs06agRQPaw9ueX1M1nzYfuZs1afd6Fm8kW7KW9gnnlhdCmT2qna5Ic/UM6akqOqWOxvJO9GZMSP7J6fduqGdzjgCRwzJa1rnIPJYVlbaFE0+tT22h5iX3s7rjvZ3YmyJBX8xBmdodJ7pnf9JoQ75vKk0GtnF4huLEWyQ5jU8bv5OE1KRtbeVdDii26pzY8swjRGuAOOeCq8+EvDlzT2QXVNR9ay5kXvWTjnsh/rcV8pF5Qus0B6/OIhOclpIzSM0Xco3DtEuUZD0w7wp5n1ln3/A46phppu1hWUl17++/dlwDTNaoOSp4/YhHwYRgm+jbjS3hOUiSdrFkHwtOc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zns6TmKqP1+8sgbLDBXUzIBFFs56H/8gBCsWrPu9PEQY2vcEMrx3q9k4BRQE?=
 =?us-ascii?Q?GxxPWAZP+IIE1yaSZyf2k93Rf1/6QiZN8exftn0S3/8b6ka0I0YVVg18sYIV?=
 =?us-ascii?Q?8EXKt68e8mLa8mq0m0VSfmIXnU24MPwuooZtW+d+b5LcPELKLAIUdHMi6GBs?=
 =?us-ascii?Q?9My9EgrIhz4u8pQctrwTOj+no+5M3TPoyX3zn4IwTHPZ7reMTztqaDO6sI2n?=
 =?us-ascii?Q?j55SLAL0BhnB8f7LRC1IcUWiWCrwdpbzf2mC0YD8eh4etMLmUiuhcY+qjM12?=
 =?us-ascii?Q?so2XMFQ3CPasRCaEFO3J/zDEoD4I9bUAYOZj/+ByBHYzBnkjuvUW+4QQkbtA?=
 =?us-ascii?Q?uYGVySZYvkTp+32DQnFfln4RExsUKZCsZMtprU4NqC7G1LXFaniA59A8S7gI?=
 =?us-ascii?Q?OeJHRBeZdWyKjk4HkX61jBl0YHykN/2/Tn1mWgosSyWtuMGEUmzIM3kdkCWM?=
 =?us-ascii?Q?JFWjudzqsVC/UmbsMGBUHH9UAdpcOjL2fpJ7sy/u4Y41wBnlreUOZoZex9mJ?=
 =?us-ascii?Q?+YKiphqyWn4Z01SjP1ZRVroG4eJTK7pjfohIX+El0iAIfPyIGwxuMLz4j4O3?=
 =?us-ascii?Q?pN/Zof4k+CDXIWMumLdB0mgUUwxZ6AR/J+lAGBOD3jU1IvNv/20jcv3NrsYw?=
 =?us-ascii?Q?tI6g5piKTAQfPrA0agMX9gnIlSrYk5Moux0bwKZSLrVuX4iGmUbUHl4pRoQF?=
 =?us-ascii?Q?d1oC5ycWRMNiRffkmB2Zkzx7eKp1kt+z2r4fBlqUjnbvfejWMUR+tsfKKDFG?=
 =?us-ascii?Q?O8fIhMdei7M9PtwOOm9T84ycter1oBbZZvzt0VmWzBQZSFiVpS5FNS2VKyO/?=
 =?us-ascii?Q?GRfeDwAbXNfV7HfXBD4it6jQqvPUo9D8hx3SGY8oar74S/X6OFK+1GyUnb16?=
 =?us-ascii?Q?MDuPj7EK+G/iVcS8BbXmlgQSPNhFiL1WHZT9BaVfg86lkQOouVJKT1fPs9qp?=
 =?us-ascii?Q?XGWPFWGbOj8WY1fEK/JE4NOPWDCDKwdcZN2TBFNR/KzcocYHT+q/5yMEPNb2?=
 =?us-ascii?Q?GiMBVY5o3ephPyLnGQNSMFzthatvPI6n4HCtG1UL7Rvu83nzwGz1ShygcWty?=
 =?us-ascii?Q?cXb40hgHj2W/8yONV1upkPVJ2404NWQJ+H61E1E13WoG6dAoXWw/HOrZCS35?=
 =?us-ascii?Q?nDedGXaY0wU0TdckPXPDwlmsE6LzHh0onNjHv+Mq1oxXP/V0N98YMEco7AiU?=
 =?us-ascii?Q?h/jGKWHRdkm0UWU3Aj5HWH3Q7bV6kxx8sfSLkD30OsQhI+F5uHvbWatu3C+5?=
 =?us-ascii?Q?ULvvpSLxb5QJPo3qLogVuVsXB2irN/+hBW3/Wz/6JlMfkZ8s7VVkQ06K8Ts9?=
 =?us-ascii?Q?Z9x+RFozq/Fvb8G9+DsYn7Df+2Z2ZT1rllir2ziVQ2XdHutHpRuWUCP20Ar6?=
 =?us-ascii?Q?5PmxyS2MzvD1CwVKY0uZlolGHIgnkG9eu9Xor2pYXutonrqxgIe3VfgVNQl+?=
 =?us-ascii?Q?reXWgs/bDCxhgSLBHe3F9qrs9NjY0oIFDEZuGBgR2UekSmKWlD3I6CeI1Aem?=
 =?us-ascii?Q?ilDbW3nMBAtJlbMP4iAlGzi7nIwvNcB9PaDzTfW3fwBr1lPfAk+dtT+lmVWY?=
 =?us-ascii?Q?n1L9XH/o/Y3SjF4gUoZD5h5CuyKCMmCYxxk/i1YAIp3O/4wGfvWyYvfdrDjP?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd67728-7ac0-4c17-9dd1-08dbe4fbb787
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:17.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcR8020rfC2pVhSN+reye2YElIOsHwritxZU/mvvqIGneL/sBj9pe85SXpXu21tkG/KIEALlG5H/PYPim+5TuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

Only total test results are printed out in mptcp_sockopt.sh:

 PASS: all packets had packet mark set
 PASS: SOL_MPTCP getsockopt has expected information
 PASS: TCP_INQ cmsg/ioctl -t tcp
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 PASS: TCP_INQ cmsg/ioctl -r tcp
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp

This patch prints more info for every test result in each test
group:

 transfer ipv4                                                [ OK ]
 mark ipv4                                                    [ OK ]
 transfer ipv6                                                [ OK ]
 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 sockopt v4                                                   [ OK ]
 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 TCP_INQ: -6 -r tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp
 TCP_INQ: -r tcp -t tcp                                       [ OK ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff49ee9b9cc2..f445fc685b86 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -173,6 +173,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	printf "%-25s %35s" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -186,7 +187,9 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
+	printf "%-25s %35s" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -202,6 +205,7 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		mptcp_lib_print_ok "[ OK ]"
 		return 0
 	fi
 
@@ -232,23 +236,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -271,6 +279,7 @@ run_tests()
 
 do_tcpinq_test()
 {
+	printf "%-25s %35s" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -279,6 +288,7 @@ do_tcpinq_test()
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
 	echo "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
-- 
2.35.3

