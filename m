Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564331A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSlftuMl7SiN15erE+yAzBbTUrmReq2KyuJ7z1c7BnCZPLydoC6+B3A8sdFjTEHZocarZpIGj8pkOUc683nTWx+3OUinbl1eDxICrhj5t6P19t81iZM7KsFQvJ3irzK1yqcmbVAFUoyzhywBQXt3u+Ad7ub6LfwwU+LnaloF9YLhxZM2WJF5w3iwWwFOplKVD/uFxRBsNui4BUaTYNrEMKKGXjl9mm2iUvpXhW9qXLTVtRXhxAVfzV9N50ZY0Ke13VWe9pEy8ODndbt+Ivv1ltipkO3jeoFtm+MwV4rzWOvV08PTppS59sTgUUfvzFtPWdNlpw7iXGTZACtzC7p4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR0jOb0tBkJ/YkD0fh3SD5h400nX2dUp+Egk8E1WuwU=;
 b=BBOxH37VE70z7HfJftDnVNh/9ILkLQt6tfOzuTiI04GK91+S2sbt2QxjkoLsr9HDlr9SMJaXZmXkRkc5kVVZsjaK5t4QeErODy7NcvNP1ulk8mfGWwTmC52+E6MpQALXaZoVTfAhHY9+AetSDL7UXBodHf2dtQzFX6b5knMiR0VcKlOEbr2Pq5UfrFpSxkrrBmrwnQj9e95FaeXELH/UmyENwcjB6Wx5Mqw0azvD63bfnd/EHRbhdtgEeeYkFO5GWPYwYk5IlrCW3zPduEL5hZ3KXaC5fqnDympvNSdHKwA1cHAeZF/iw03Ljb/YQlgmY6X6QGr3KqLxPZb/++luZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR0jOb0tBkJ/YkD0fh3SD5h400nX2dUp+Egk8E1WuwU=;
 b=TNnmLbqEfVY0y5Q2KvwiCmRL0q3DjYj373owz2O7HopnwEFL4kYoGHbu6sSkjN2RDJKfMw4613/MSRfPR09L4vR3qhKOux4kisSCPPBE3Fhknrg/7XhvcwGHiDxqz7o5mVBM0SZxi/fAvhwl5ww8tT/sBUd6wrZrHOSBeBlavZaqHOLIKG8KKKza6ZtncA1qtLM1TrAM3PMh6DGPKN/owgYuyz8BsZfa/5b1ZPxScVCjcG8gXqP4kI9RlqtRtPG9pKwYIW1UgzaAThNSHqclWzMfrdhQJ+s/8q3Sfb1au/SCYjrNdpeEvuPkwwym5dpDN4dTl7L8mSgJgzIqCoaicw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:05:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:05:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 26/30] selftests: mptcp: add mptcp_lib_is_v6
Date: Tue, 19 Sep 2023 12:02:27 +0800
Message-Id: <59d96934e3303beb08d7392da8c27419b5e2a2ce.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 91139076-6673-4c8a-f6e8-08dbb8c5b5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DFuLFEwpodY52iuuMhv3jPGDHsR85xzIGPnNOdlpCrFvzS0y2ymFwTXt+6eQzMQ2y4kIWPCmuBFjFb6wIJiiCk+aSRMkDFvNjTbpuXimRpA8NGH1wSkbIIXHLH/zogiEQ0Naqn7UcCPcmEBw2v06W4eVeYCl8s0yvMqetfTYEC/gl/j/kIL3e2vQLy7H/jANUI/ztSQQqDk5uePcnZ8UCTRW/LbH4P59J8SZB8vA4ENLmpe/Ny/TtfRJcjrK+wwRLumgZXXm6ChiDfL26/1dNcEEmwul7W7Yxg1tPhp7opvqklhurccNNO0T2ECQu7vqZ18VzYUFCoUIV0f1hnzZU5nr1ZMCeORQV8w6iuJxa+Ze1tex7AMPCxuQAkQir0XxYtUeTmRd3UwlYxAf89LfJWjc5cN+bwS92iuD1/YL6rr7LPKfloz/u3ZYWqSjlAvfUK3tOrGFu0b71PhLi7pc9IrlLxAAnuw5wz+LvuosyXMidhTzKTIY6lm8z52x4fuF/zT89JMdCO8ohr4Q6HqgCxLa7I9GTXaEge0TaD+CJFveO3I6TlmspW7vIFntZ0kuB4CRCVwatDioFz3SByaNXMJ7GXZxGmFtSYVIls4e+iQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t3sXTcoigXaeEWJRC2CyhL2xW34dj5R5h4iOj/XQJ41HC4EL8iPZJeVTppmw?=
 =?us-ascii?Q?eZCWs9dCGlvDqrkgKeQ/nhcgPCVj4H+Aj08CLcCVDwWgV35EiH/FPH3VEzBQ?=
 =?us-ascii?Q?yb0vyVyQ9FFzF2BuWp4387C4sY0xkj45Ga+Qa4nySCviHmi69zPv0bNftKnZ?=
 =?us-ascii?Q?nKVZx0C2AtA2rnFc4KVHNdSUlvUe4joWeHgaqENFqh823UgKaveThwumqRud?=
 =?us-ascii?Q?HgLPAx6l1Rk6cERvPjZ66EemmJfRB6lhiS+vjUV1tdVBugYTGeaXsCR3wpcm?=
 =?us-ascii?Q?SHejfu/DUcEN7FNs9RyrjfK+UUvj6oob+3rqgjj56FxLdN3YvG7tgxwFm3qd?=
 =?us-ascii?Q?iwPhUNMPV7IfBdtS3p6Te5YyH08R2vqhhOo2Bb/avECPqCA4crY+HyzdBx1d?=
 =?us-ascii?Q?4BI3/IncWbGV9TlulCL602+rbGdNbUmseHJfxxVf0HIbWf1NScjZo19JAZ8s?=
 =?us-ascii?Q?0WJ4xjbhcUMmiurjjg1pX5LinvHTdOF4/dZeBkut3a6veLZT2UKndfE1FL1V?=
 =?us-ascii?Q?0J7RrtS8iLWXURX+gi1V+BxBPcDPW2LiWeGpOOQhImidpF+UDnOLKZ6g55LR?=
 =?us-ascii?Q?KotR+rXEmLxnbvYMGFbD2HlX+P6lPnpOSgQK58BogqOltQmeweyp23vvsq6A?=
 =?us-ascii?Q?yfDz1VfD7XMj+G4mQs67ToVbRGcPKgjwO53Bfh59qWRUtwVSyktgwH2hmGbT?=
 =?us-ascii?Q?uJTJW4UkdiieB/D5k3Dy2t422EQEUnqrJtF7GzdcKJJSJBd4M7UyZn7/qugl?=
 =?us-ascii?Q?zW1wFLkcemsbfrJ8w6wA2qq7+m+/Lb/9lSm68QUFDZBmiDMmMgjn7Z37B+38?=
 =?us-ascii?Q?LDEoCaj8eJabmMJ8r4qlympyiaFTq92vXY0fG+FsOgX3p1DK1f/vQrWbenqe?=
 =?us-ascii?Q?MHfFu51EPPX+xjP0DOOS3z5noH4E4W2gxpT6Vy1t8wEFifzpnnUHFUVPDHRI?=
 =?us-ascii?Q?E365LcbclPCG1Qs39yjgT/OrZcLu0obELLVmKD9m+zH/bxtiMtJxwR6JHPRt?=
 =?us-ascii?Q?hZnbXfUuk5klfBMNJNEMwLuX+AcuXCL/SmT6wvIGzSEfEEsOkRhXW1Ef1Gsn?=
 =?us-ascii?Q?/Og7xOCp1jHRI+QBHevEzJ6AJWgR6qH+n1SLRvsDKtUh79NMHe+DIvX84u3m?=
 =?us-ascii?Q?Kl6AovBzv5bmjyYn2D9vJKDZQDdO5ZIY44IRRrbdfyjec/icXwBvbtxEQpHh?=
 =?us-ascii?Q?MnmUGoeD7bK3OL2Ob5KZssz0ijJoKLmLOw7r+v9eUXEKqXHZxDqKtREhyTwS?=
 =?us-ascii?Q?+Ofd0IGuJ02tM+MPKCX4aSiiZ+NyCbUEAJBnCbTiM83W1BIpvMJFLUrYUZ7F?=
 =?us-ascii?Q?SXW9F9sxkYrGhRgCm+3vI26NSzhQF1l+VbikScUp98yReS5ZxtkMLOX11AV5?=
 =?us-ascii?Q?CZpZy0ghW9TqK7ga+TVhoaj/rA3eQZgnr8sUKKTv0l4TOWFVLnsOM/49jCmg?=
 =?us-ascii?Q?ZNna2NFXkzadclmAl5vvsJjppx31TpybiSx36NV3A31RZMlrQ4J1bsS1TTTT?=
 =?us-ascii?Q?bqhnEZ9xH0myQiP6NdRUjk6ohmpWKNqYVXVPPWVt4LvEhykj90kihIKs36sC?=
 =?us-ascii?Q?12poSqByKItZKJlT3mzOpViua+BtIcO7P6JvnoUQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91139076-6673-4c8a-f6e8-08dbb8c5b5df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:05:50.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz8XVh1WGpLdTlB9ZWDRjO4TQ1U6rXX57yNDBvJL2t3yBTcKWbdyrWkYFd8+N9FXd5U8RikyUvrrvAN+fgdY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

is_v6() helper is defined in mptcp_connect.sh, mptcp_join.sh and
mptcp_sockopt.sh, so export it into mptcp_lib.sh and rename it as
mptcp_lib_is_v6(). Use this new helper in all scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_connect.sh | 16 +++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh  | 14 ++++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh   |  5 +++++
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh |  8 +-------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b1fc8afd072d..4cf62b2b0480 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,12 +310,6 @@ check_mptcp_disabled()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_ping()
 {
 	local listener_ns="$1"
@@ -324,7 +318,7 @@ do_ping()
 	local ping_args="-q -c 1"
 	local rc=0
 
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
 		ping_args="${ping_args} -6"
 	fi
@@ -635,12 +629,12 @@ run_tests_lo()
 	fi
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 	else
 		local_addr="0.0.0.0"
@@ -708,7 +702,7 @@ run_test_transparent()
 	TEST_GROUP="${msg}"
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
@@ -741,7 +735,7 @@ EOF
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		r6flag="-6"
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e59867eed5c2..8ef91a939c1b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -577,12 +577,6 @@ link_failure()
 	done
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -879,7 +873,7 @@ pm_nl_set_endpoint()
 		local id=10
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::1"
 			else
 				addr="10.0.$counter.1"
@@ -931,7 +925,7 @@ pm_nl_set_endpoint()
 		local id=20
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::2"
 			else
 				addr="10.0.$counter.2"
@@ -973,7 +967,7 @@ pm_nl_set_endpoint()
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:1::2"
 			else
 				addr="10.0.1.2"
@@ -3263,7 +3257,7 @@ userspace_pm_rm_sf()
 	local tk da dp sp
 
 	[ "$1" == "$ns2" ] && evts=$client_evts
-	if is_v6 $2; then ip=6; fi
+	if mptcp_lib_is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1301af71ad2c..91a17ae81cb8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -323,3 +323,8 @@ mptcp_lib_verify_listener_events() {
 	mptcp_lib_print_err "[fail] $e_type:$type $e_family:$family \
 		$e_saddr:$saddr $e_sport:$sport"
 }
+
+# $1: IP address
+mptcp_lib_is_v6() {
+	[ -z "${1##*:*}" ]
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index a817af6616ec..bfa744e350ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,12 +161,6 @@ check_transfer()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -183,7 +177,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else
-- 
2.35.3

