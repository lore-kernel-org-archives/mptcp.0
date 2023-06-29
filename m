Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147511192
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwRqh6L6ILqW+It+j5upQAlL2G7MJRdwk022b42h27T1KML5w3HMC7Dku5Ip/VQwmWkADjLGDx78a+pJ9YC0pXJh0WdAFfK5nldyJwcHqxqcEgzdO0n6tUT1Aisqk2pjqN0MBU7NHz0rhNTmq5j/gAsuZqQCGz8/BQPtjBkE5q5ooTz6wxIFjdjy/JQPFnQpnDFKbzIQVg9j3posnrBDOCAAULNWXEMp9c2Zq4Bv44goj3yroca/0nxW+ojMMhEVFGtp39dRf5QO5E3PjWueXn91RVEMFj8DyVuw19HKbaNgbcj8N+CUUMt3vjY/WODurDx4iQT/gKZdIOQVN8CtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkcZZ5KA+8CLOCI4NkUJ4+GkRN0DYaS8WJd6KbJaAfE=;
 b=OsGqbwE9O8WHpUtqLp+/ezbzacjwud/Fr4/19WbCo08MciyH2I8+Cbx+Uo1OmshmcCzHz8CTyxf+uD4UYwqj086+y1YaeA1GK/K7E3TQjccq75jZJAu/PtFtwYVWG0/OMJRK9/OzgsKaN+FvNuZpxrHZlG0mLFPuvwbekbuP6AwSfjLckYetR6DSOoXBHj+DFha3aIhoRbwmnuDy7B6SlrFUuwvyvQYfv8++Vv1mWfcuT+p1sxaVdq8sRrNCIs7YIisZl3gPFN6hYY4yHzVf7tttLOlWQBIbVi80BrXoWCNf0FyYlKC1Pv96rMehaYvKM/0pIqi6W/O9HKuxf8mqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkcZZ5KA+8CLOCI4NkUJ4+GkRN0DYaS8WJd6KbJaAfE=;
 b=11I4Ifoc5oEzh8qYv6eC8fi4GXCaiXVtGbHtO1wjWof4DdPkrzo0czutoY8grRrhrJZI1hEFeyHwulfFhPdaCegnZXw9UB3ux0pCxpgC5NNm7XSrfgS45w8w4lToAAxknhPxTRg3Qlmx7etg8WAvTZPkak6PVu7U5hd59Usz0gGWB1cZR1WW6p5Tru7B9ky19C82Xdd4YugfCVcn8dF4+z0wT3Acdi1FkisAFV3C1LZD9ldcS3jlVIW3Ut+f02CIgcjswVNv4NYo8FhBq6jMYmUrkB0F7ihXG3W/9cfDtnr5S87+lQTY2bNsy91xAQR9j9CdzbguG68ocg60nwCZ5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.37; Thu, 29 Jun
 2023 13:34:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:34:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] selftests: mptcp: add fastclose env var
Date: Thu, 29 Jun 2023 21:34:30 +0800
Message-Id: <e222375ceb37583f3cd4960db0a69e29c44c9101.1688045383.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688045383.git.geliang.tang@suse.com>
References: <cover.1688045383.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3efcdd-b827-412b-12e9-08db78a5a02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HvtO4k5YZasAwGLwfAWLkLqD0i9KEpWU5EvAAXXGIs6pZHj6DwgrFlvIRL5yge4Wb4nsmlVCF3Bzt+HwLHB0HGLwwW5ieLPs9NC5CtfzhzRsyUusqH9S2y76ZPsrd6TZ2pBfvvon+pV8fRQLVwKIiYqO6SGvYayingO77E326uZ1BPCvGg//WiVQXmTWkn1khAlEZd1ZHEBFRnG2u8Vut7HB6fOoPPTC7vsjpaEiew7O5IziJL/Dj2IKsTznALzMR9n3E7m7VyjMW0niKWd9Ki+GjHaby0yF8NIJOxg8LFr7sHWGFejs0rNAYOWyX1ZW9WJwWBaFFxe29BfnEeuqHTnvcyOgHx9dP1pZP+U9raAzfUuYEwrvlXZZwn8gjw0BPlcxkVvj780cHal91NlFCU83K6pzszuhg16wlCNjGHHfq8gSBiGE7yqbWfl2ZBa6Ck5/5P2wYGScW68gX3j/sflWKXPONW4vKGYnSVrMPW3OcC3+3gJOkfVEq61bZNShroyYHxwqX14jtU7RBXta3E13MJXmXiDCEsMVzgUSdeuzeoxVQja3ZDfy50pvGRxE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(6512007)(107886003)(2906002)(66946007)(41300700001)(316002)(4326008)(66476007)(6916009)(66556008)(5660300002)(44832011)(8936002)(8676002)(38100700002)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axcb+UKJol3Y+WqdhoWpz23QUYhclT4Hhs/X9Il5CopRpMkQSatFIJsIij6W?=
 =?us-ascii?Q?vMmxJBKKSWbwRpKAG2XiPVb1tAm8rY3DLorIsWUV4OsrUJ2TF3hDjSr8+NHm?=
 =?us-ascii?Q?ga+yhXgpqWdFf44Ht/RWolod9OxEmsIUaph0XtqFUQk71rbt6NcTQimQ3GPZ?=
 =?us-ascii?Q?8S0pm7xSE+GtoMQuTH0w59R20LCRmEt1TH75WcUAtd+Xn00ChSyi3BOP+gDB?=
 =?us-ascii?Q?vcM+B+CQQ/8irbpCUW7E32XhGiD0kDa934Qvral2OWMnRLPiG8qWXAkC5uoa?=
 =?us-ascii?Q?fqtWGccX1Aqrw6JrjCAGWo2M1zXX8moMJZzb6UmlTs5dNVvv/Pa2xfP3d7zn?=
 =?us-ascii?Q?s2wCtiIuqPI/26DgsneGUo1tPaveXxl6rhP4zsItvB8d0uL36urfFfbGkANd?=
 =?us-ascii?Q?dpzAu1yLxYJrHhTcyr8DEaJu7ruuL3820asaqv2V5uAVn/ZryfOyNzvo4tzm?=
 =?us-ascii?Q?oZQShUbda6Wd4fOMfwvKbvMD3Vmc2ruUbtQCI8H4k31YSuZUwEqvdICB+mj+?=
 =?us-ascii?Q?bh3vS3/1sTBCSwZt4Iz/1Syf9NDE7hrPVs3IAAwKgpHHW0iwlTCZGVxwDHML?=
 =?us-ascii?Q?rGECWKgSSfVCSkuoLHY8VFYuFmKHLlzRvknXm6AWz063Ve69sfkoVv3uuVwi?=
 =?us-ascii?Q?y/M4cPdXxd9dG+lRzwndqascGX3qK8ziLB8n0EgthpjTKjy+0YPilBcvZNmi?=
 =?us-ascii?Q?Y7YiIWiTzOLLjxSbtiZUJI2fKyi6TSjo7J2ThFPmFWDp4KxpMUoP4xmny6XB?=
 =?us-ascii?Q?ri2qhjdk9UVnAxnrlYjWUp3hlpIb40Mx4QhbfoBSTlroCCeNfKSbE0vptqCM?=
 =?us-ascii?Q?K6w/JKjtkXQgBvYtOH92pVeU5NlE83izadEwfPXErcngZt3DnIz80k8kjsMX?=
 =?us-ascii?Q?zfFc5PXAwIAocZ9sFc06fjZetEMJWZgTrt9Soq9koBBgXMIAoLfbRWWXWvYc?=
 =?us-ascii?Q?4pC+oA4CxmdnDPrUTOpuoouvMLMmKKM87SvgD5JH9Ty9dwnMFgq6LD1U/UIf?=
 =?us-ascii?Q?k5BvRqNBMvAFG6ckKqAU2tz1fo+pnF3F9CyRPRziEIOpqlH3tUbnQImZqdyQ?=
 =?us-ascii?Q?C9G14DjW22D2PmkwHYKfHve0kaa0XlxR3dPX4FST8xLePJq4seHt2iRJqJNq?=
 =?us-ascii?Q?hJJu3WtSromoXtvh7S2fLRGdMeRSr8T2RF1ow56WgpWO4dZihRPzvKXG2rQz?=
 =?us-ascii?Q?XBBopWBXV+W/mRo2UIioDp6D1z85Yv746HIBQfTXl3csvGBXnY7JebUdRnvh?=
 =?us-ascii?Q?PXJ9q0I+yf7yFTqEBFjjyPwEH1HJKXOXrNa9HnTzkI5Lph+jt4VRjLlFl+C4?=
 =?us-ascii?Q?9Z9p+qyren8wI1Evi+0DJB4Tim2ogGES/6/vnIgS8WpTaIZCFEO0BtZ3AU2u?=
 =?us-ascii?Q?jD0v3YRjuiuSbXXearmQwzGG4BbadNIqiGLHrb9pIsc694gBq56AN6RxBXVB?=
 =?us-ascii?Q?zqlQvfBEN1KiU+XIs1PWzmvO253IR2SeQ4f1T+WnaUiy+qbar9bqOjkJrrGG?=
 =?us-ascii?Q?4zqjt/8CL/yj2cppQcSZXsDl7pI3kPfJCLIOFajy1Isfu68gEgvDRqgr14hB?=
 =?us-ascii?Q?UfDl/FBohzpGgmt0sK0CaVvy2UOmD8T0vlQtAJGU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3efcdd-b827-412b-12e9-08db78a5a02a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:34:55.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J03riQ4aMGo32tgEP5xtjME2DbF9bajipNck8naFx809k+C4llnYFZbf4f/1Ru3nD08NIbKzW7IUw8bO9aMk0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

Use a new env var fastclose instead of passing fastclose to addr_nr_ns2.
It can be set with 'server' or 'client'. Then the fullmesh flag setting
code can be moved into pm_nl_set_endpoint() from do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b80c5e7b5a7b..e1e7ee46e980 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -54,6 +54,7 @@ export test_linkfail=0
 export addr_nr_ns1=0
 export addr_nr_ns2=0
 export sflags=""
+export fastclose=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -105,6 +106,7 @@ init_partial()
 	addr_nr_ns1=0
 	addr_nr_ns2=0
 	sflags=""
+	fastclose=""
 
 	#  ns1         ns2
 	# ns1eth1    ns2eth1
@@ -832,6 +834,12 @@ pm_nl_set_endpoint()
 	local connector_ns="$2"
 	local connect_addr="$3"
 
+	local flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -1019,11 +1027,10 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [ -n "${fastclose}" ]; then
 		if [ ${test_linkfail} -le 1 ]; then
 			echo "fastclose tests need test_linkfail argument"
 			fail_test
@@ -1032,7 +1039,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_linkfail}
-		local side=${addr_nr_ns2:10}
+		local side=${fastclose}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_linkfail}"
@@ -1045,10 +1052,6 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
@@ -3184,7 +3187,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_client \
+		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
@@ -3192,7 +3195,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_server \
+		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
-- 
2.35.3

