Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942765A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 03:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644807805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=68h6m83hYK6GM8ScClBYSHUorqg3r32HlZgBZyPEI6k=;
	b=M/gesBDMbJFOj911kYw+p685JgNU49iOs7DkCBUb4fkhsYyhMfc8RRi3jyANka0LDoFfys
	K02FNGMq0QD/7tfwH823uTBn0JtKd/wAbOPhJl+MfiM7Y+ieVPXF2jSuqR/CGQt5Tvgoq+
	hx2rPmpTN90Ay+5mWzWy3UOkHXcnXSk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-SSyKSqTNONewD_PU-GeOIA-1; Mon, 14 Feb 2022 04:03:24 +0100
X-MC-Unique: SSyKSqTNONewD_PU-GeOIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI3Cj86l5MhFJ1+e5nA34ZPIvybZ81rdMkp+AQBZCbC9Rp7wvcHppkqtcu5PeOx23KlpJ8yJNsm3bKJWRZLn4pKzBXpL4RHMDd97oh08DET00tGIf5MYGGAiLPpXMmVqAmhIT3JyBsB4/zSGRg1GnxaFrKw3REKhBxpfrqcKYxWtgV5JY+oMLIK3ujr71/sPj7EA+qR3lO1o1QOQ0kbAOFzDH/oFNTOKB/fVItlxw/3TQDe5cr1wcE+w1BePdWbcjakp+GnOhXaXNRNYlbFJCpEbRriG8waNg5rVYjBrGiX4q05gtN9X5Xm0ISJlyKWHR1uaYNCWlcsz7c2mnx1IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxB/2+yJcheeCaL+SyzCelKv1FAsBJu8fp8kOWXDuIE=;
 b=WOAV8keBDzI1zY0ZCUc2e0FaWiusLLf/RBYvty7HRA0sm1SS2YEKiYfHcAJyNEogP64J020c8OtKSu+yt6qNNTv/kgqDUuNdAv9zph/askIxoAlLKRpFUNKmKFhTJJyXCK5P3OtWJCXfRy4OB2hrjV9F6vfKNjUmLmEej7FQKvaLlPv/Jy6+WJp+I4CF6DgrnV+uUwjIJqXkuYWcFupMrPymVN+UUtEBoqwQpNz2WaB7+CcCNl4BrbjuKUxDeG/9KBvN/IjD+aLLl2VXa6FvUBdDrxjBqRHbth9eAXoPA7cE9298Sn0C+/AGQCGOgrf75uKc0gyghSZ6mARuvG/hWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2494.eurprd04.prod.outlook.com (2603:10a6:800:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 03:03:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 14 Feb 2022
 03:03:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add fastclose testcases v2"
Date: Mon, 14 Feb 2022 11:03:41 +0800
Message-ID: <8806b4752bbee59d6c66847c89b70a08abd6a8df.1644807798.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d25a897-ce69-4731-00fe-08d9ef668edf
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2494:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB2494017BC3755559A88584BFF8339@VI1PR0401MB2494.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d85d8pE3tMEQ1C+rr8JKfS0iBSHnpwA6g/YJAVxVw+mMSleiC8S7kUKuo37s0d17DUCYpnyhetBwEvtSzka9iAdWk3h3sjqqnPLsAYT57G7REIldXvw/tRiPDelgpl5S55VeQQKwizKYHpH7Zb3gb9/o5XhgScpHu3mjAlKeeglO9mZan8LIw53RAi0KRLPWHtfkPBlTA14be97KjEHKlm4fDntcKEX4M+7pY7/vWkP/0Mgk3Q9HMnKTj75LcXCT/Tfw9Re1jf7bYBiAlv2G0ir8giAzRFyo9Mpbi23oDxljKoCv95is2CdPsdOu7uuavS2GNQN8l1cktpm9im9pIrizjhS528fNA9tc2HvogiXb8QXz3T9ngVxOG5m0O5sOe51MQRmOHgok9txFDO+4hur1cuDcyekfBQsBcUoigFZhhUHneXRw1vRCwBX6JcQWdCfVxNpD0Xlzz6qVrh17qQWTs8dAmjneXHLSSvdWqjO03FgrUWflCe9K+xG0v2eRj/dg7s+0n5vSDNU2DrjwCLz/US37y/7lRbVymju1cDCSmngw7YunESLP2f/FwAHA3Gj5aV0HyEFxXcHDQGMkS03aCoWifk4W4GQK29BycSvzXgQ2Gmcl1MYNQVLCLnvE+3J4XHyW50tZxdQ6Omi5AA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6506007)(55236004)(83380400001)(6666004)(8936002)(86362001)(36756003)(5660300002)(6486002)(2616005)(508600001)(66476007)(4326008)(8676002)(107886003)(66946007)(26005)(186003)(6916009)(316002)(66556008)(6512007)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztXmJ0av49o+b0hA2kSMEbkQaWOVqeC3XF+L0LmyIomX32IlCxVcRftMBfM5?=
 =?us-ascii?Q?ALQkpujXsbpqOcZuXeGVWd3DYuFjxzZCHJokg9XdXOSm7u2IorKrfMD8RIGU?=
 =?us-ascii?Q?OFtbCpdWsOTHLgKAQpek+mP4BqN6ht+XxYkz7QpCqIASu29Vr4p1FaaJ43fy?=
 =?us-ascii?Q?W1tQXxxncizSUUzlMsrIddOAvcrgQ0muyKZZSEOrPsK5Hgf1iOVXuzg2NkCw?=
 =?us-ascii?Q?YQm9O+Zp3FwVqSArPSzr23PdGIZCRJob+iXQiNoGrxJ/P/sXoBamYa37epQD?=
 =?us-ascii?Q?W+S+SJFxloeB1BcDV+oV/u861arR6tCR9WWVwKqnaKlMtK1HKZWJ4f/A3zDs?=
 =?us-ascii?Q?UICWiux6L1cDooVvweKxyWPgx4/4CNDczs+3xN2axjpeIPy2J+aCqpJVo9Ik?=
 =?us-ascii?Q?sG/uOPMjAYs4VfiNJilPO9+M5skjEyPPMVA//t4nCCRCuHimGCzd40IGwQ6V?=
 =?us-ascii?Q?iqOAwxj4OijNWrFtAFtb7vif4gWR4bGQsaBWsGRwW8VsklGQnktuqWQ8f44m?=
 =?us-ascii?Q?kSwILoZsGFc7REE+BzTWTaqlz6QL5lvoYqc//idHwqy9jWy6mpPI09M4mpyL?=
 =?us-ascii?Q?LvlkQBJIrtobgd1hDinAsoxIp3UXb92S/UG76VgcfL88zppOM18ooQMOK9T4?=
 =?us-ascii?Q?2/WcMuGVxjLOVu1yBE96pgb8WnFTV+2saKQFa+80jZ9YLRzetiSf/7v1s9ny?=
 =?us-ascii?Q?d/Ks4BHbbeLjFeV9FMtZ5C4ISBcnWvoGMgUO+vlrj0YZlS97aFfhVCBD7QXO?=
 =?us-ascii?Q?+6X+ysd3inxVWpTj5bxzaBW0dApgjEySfzrdvEAJZjGEhJpJ8bfMIhZLrqdt?=
 =?us-ascii?Q?8lE67QzvDHKILinb5ClxFrrj9ibIEk+cfgaXn3WGP9wuzsnBc+u3Jaev0ArN?=
 =?us-ascii?Q?UXgE8QL/71sIfAsRFoD0uQg1H22yLx6Ox5Uw5WkiaHRvKIu0o1TLXMC+8EG1?=
 =?us-ascii?Q?xNU9zUtlcZFxZ5mTlRXMbyViRlwvFGIMKQj8882XAwiyVe3TB6kcHEpbzaQU?=
 =?us-ascii?Q?SNb40JSqiOrPkm5jiCZk42k5WHB9FSlrMWUUQohC8LhUfXxveV5eLn9EVOem?=
 =?us-ascii?Q?xnFaSu74IGnomgHyH+u+/0XEw10/lZNPUbu1VlaV4pGiaYJAmB7rKqUBKBGO?=
 =?us-ascii?Q?ZzlcVRz1JfMLb7MfqbKLzRCoJArrmVifIHkg1qdfYx+9dWzDEDZYeW1fdcwf?=
 =?us-ascii?Q?LEHa9eN4nApNCVMjJ7eVIpWgHF6n3ktqJUcY2+4GZvTjAUIPqapVe9kZeSyD?=
 =?us-ascii?Q?604t2cqYbhY40UNH4ywk4F43119AKgOY8M+pKcrbpDkJOgu6eoLGz0gL5BYs?=
 =?us-ascii?Q?EQ9mR33TZz54T9Mxdt+9/uFfHHpSpRiihk356V4vJqA8Os3PxtLRvEpcvcRQ?=
 =?us-ascii?Q?aRHmv9YzWLMCQMUp2csTkmvFkDDNlu0RVoGThLkJfJRg3Aj9cMQMW6mnApKZ?=
 =?us-ascii?Q?DxHJ71AEvsl2+McNLvwkKtllGSiAeWCeG9fC8ekLHerlWMXSEFcfZ6wf52Ez?=
 =?us-ascii?Q?+QlBr61GBa1x93LTzzT6caR29rEISyhtI+AQoEgfs5yN3tXDqOYky7EhT0fM?=
 =?us-ascii?Q?6JsDFlA5vc8hkf3/C1swRPNsuGD9g6jn4Kmir1IWi6KDsl9UB8Cr5yrBb3gN?=
 =?us-ascii?Q?SkPnPSloqNNk5qTLhy3UgJE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d25a897-ce69-4731-00fe-08d9ef668edf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 03:03:21.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h3OAdio4S55aCVhowphQV6NrEB2MCWajRyY+YvXWtY+WZEfHrQ+H6hQN3rIh1ThLOZs8nBaVPqDrlWhfdIblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2494

Reuse the argment addr_nr_ns2 for fastclose, instead of adding a new
one.

Please update the commit log:

'''
This patch added the self tests for MP_FASTCLOSE. Reused the argment
addr_nr_ns2 of do_transfer() to pass the extra argments '-I 2' or
'-I 3' to mptcp_connect commands. Then mptcp_connect disconnected the
connections to trigger the MP_FASTCLOSE sending and receiving. Used
chk_fclose_nr to check the MP_FASTCLOSE mibs and used chk_rst_nr to
check the MP_RST mibs.

The output looks like this:

001 fastclose test 1              syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  sum[ ok ] - csum  [ ok ]
                                  ftx[ ok ] - frx   [ ok ]
                                  rtx[ ok ] - rstrx [ ok ]
                                  itx[ ok ] - irx   [ ok ]
                                  ctx[ ok ] - fclzrx[ ok ]
                                  rtx[ ok ] - rstrx [ ok ] - invert
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2fc26fe68a9d..00a35601f319 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -424,7 +424,6 @@ do_transfer()
 	addr_nr_ns2=3D"$8"
 	speed=3D"$9"
 	sflags=3D"${10}"
-	fastclose=3D"${11}"
=20
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -463,11 +462,10 @@ do_transfer()
 		extra_args=3D"-r 10"
 	fi
=20
-	if [ $fastclose -eq 2 ]; then
+	if [[ "${addr_nr_ns2}" =3D "fastclose_"* ]]; then
 		# disconnect
-		extra_args=3D"$extra_args -I 2"
-	elif [ $fastclose -eq 3 ]; then
-		extra_args=3D"$extra_args -I 3"
+		extra_args=3D"$extra_args -I ${addr_nr_ns2:10}"
+		addr_nr_ns2=3D0
 	fi
=20
 	local local_addr
@@ -615,7 +613,7 @@ do_transfer()
 		fi
 	fi
=20
-	if [ $sflags !=3D "null" ]; then
+	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
 			pm_nl_show_endpoints $netns | while read line; do
@@ -706,8 +704,7 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	sflags=3D"${8:-null}"
-	fastclose=3D"${9:-0}"
+	sflags=3D"${8:-""}"
=20
 	# create the input file for the failure test when
 	# the first failure test run
@@ -734,7 +731,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags} ${fast=
close}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 }
=20
 dump_stats()
@@ -2297,13 +2294,13 @@ userspace_tests()
 fastclose_tests()
 {
 	reset
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast null 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_2
 	chk_join_nr "fastclose test 1" 0 0 0
 	chk_fclose_nr 1 1
 	chk_rst_nr 1 1 invert
=20
 	reset
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow null 3
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_3 slow
 	chk_join_nr "fastclose test 2" 0 0 0
 	chk_fclose_nr 2 2
 	chk_rst_nr 2 2 invert
--=20
2.34.1

