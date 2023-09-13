Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE04A45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CthcDff1pqg/LOFQUT7ft2rtc+/SOy6q2bhpWnFSfY4KQaJFt9YRBVApQ2ER27rYiyH3Bgin2hiQeLow0V5UEEd7ZLIw3ZCANII+ArVZ0fKkSZMRUlVaTyEoD2Sb5SRpzQw3CD54gveUTInT/mhUDFuNcwAxrfKcyZZt8jBADOcJx7XSz2bPt0EEmLIYumuqkz6n9LZ1NE06LklKjbf3YBWMdmXyIMNNE6M4YWR+xNtGrHvIyXOlaYbiWfWJYpwGhU8iBsPo2ZDITfCa2Hdmc6mc0bjrX3wmFJlhiP9KMJb4AALTNToVnSzi1K7Mwto7pqiDLKDZZhA4jFjd98OWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChhLyH4cFst9aBgYAybt0IqQS/9sO1AyfjEKs6D2e7M=;
 b=M+x09e4TURpmm67MDwNfVXYXNs/13rwCHSjP53oBu/cZ/y4dfoyPQKWG0gp5Lcd8MyizhtMubI2Uguo4+Z+PwjD3wziBIzAAUYovd48wFWStYMDW9IRBJO1RPb6QBie6ZaI8o8d28UVHQwTzGX/MfsjyBU1VLH4W9fBxyboD69BmbVINYGAi5gA4UBNv8BwOWR7SqYJ94zpbsN7OOL5zlQOE861JT4Na/18yTgq51X7JHZl7RRcBE9JSchJyYxpQoANNY2dpNBUn/WVADWqx9RMvYhG40cOzA6EEqV1Ie7i7DI1/IK7CvRhd5+Dr5titvejoNFkQMQ+PZGmfgQT/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChhLyH4cFst9aBgYAybt0IqQS/9sO1AyfjEKs6D2e7M=;
 b=BDldkLXNzldCOSo9Re9RCfgc9AfgMlepGcLg/DakLyLunWXJxB12VYeppWWVfPFes6WkyB1F0dUPI2YiCyIJLKy5U+ZzXHwBltNLM/XPRwdF0a0WDVTqLcx405qRnCGP7VLe8hHU9viF7DS7EIQN/tE1jMIXUUMWa7elr+Y651QIt6Y8mKuLlVDQbE7W7xiiJ0NuPMgnDEra0Gyf3w6jqpJiFPCo6AuFu4x54tYvCaXqh2jIeeFmTNYk58RJniqAKPPYvuyb7R7imOPEDLSka/naNaebDaARJ/d3130EXUQ1JBKspTK/MZ/hNDcyKZN8AX86K7K1YnmVEQLMIkiVFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:05:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:05:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 09/13] selftests: mptcp: add mptcp_lib_is_v6
Date: Wed, 13 Sep 2023 14:04:57 +0800
Message-Id: <72a023573798263c0e31bdfe952f38858b5a2e10.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eb5955-9a84-4ecb-3576-08dbb41f6abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D8KWsWc7WDDXlakMOx8ps2Btlmqr7wlJjqJVwYkalT3994Nnyfm++Xd+Oi6t6HkAZscor4dyGm1U+Z6U7fOe6GushNDRCKedei/KzX7YgDLuU7NoxMvzEyUD63ibSsmaRm8Xp1BJ3oVMc/ZZI23ltoDNyhdBzuNxlWwu/32JDhUdOMbyJzGGyyDG8oBtRezj+fLLrVuziO3r0/TLE8LRxY7bNX4PKRu3N7chi5VGZLaz71KdAjWMvdLoRTyci5SKu+/EZ0WM0/yiAYJ2GNi8A3vq3oMR5mQYQQWxDcqOq/zHKuL0NcVB88lgZ4yQ6u/IrlqOnxcjmr1WsHgBQ93Slqprjrh7v/Hkw7BnfeeeZvfQyG8EV8p5GZ7sdiZYpq9y2+K1e8I3B67mfZYAfkb/qjzQSkYUMecSRs/vDuPg23WOXPGi7t9qdhjRdU5RVUJZP7xgPLQXAOOt/Jy9WJRNKCLRLaDbsYLX66gTSfFgInNBX8nFwl44UUFmTuPavAiknUV/M9kNNz1PJ2ccrHNNgkTYGNxjn8U/sBWgcTjIA7PFtcRZWflBOUbdb8VU5JY3xH0uZ9BnkAYfmJzOjviqF/Km/lZVXr728VxyDM65p38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqXFNKUk0g5nFjfUY5ONuzAYXQPH9C95YclxRGuoIRAzS7lNxWl0MfFYuxuJ?=
 =?us-ascii?Q?wx/nkc+c2SO1x6d+UQPj12WUT6WYP/r0i4nVzHtsKp9lZrwX6+Yv6GW63TuS?=
 =?us-ascii?Q?QgpMoW/j08CKBWfn75Ef1ks/CJjvDDCbtqMaMAOZtAkxAZmkVTUJhSvV7wXw?=
 =?us-ascii?Q?n9yeTy2B1SxHGsWgm4s6cgsKSWX1CF8j9hEHk0N8ZQ8SiJlEvG5RaR81xvJ0?=
 =?us-ascii?Q?YCG8FoULfp67aEmWYgBXHDl7WmbYTrASl1C9+EBxcIg5lkkN4VqTgPyrd6NC?=
 =?us-ascii?Q?Vt0MI0aPUU48Cb584hYEGCkM9Gc4TN0HSm/h236voq2mcD0lgPYJ2kJhYdNs?=
 =?us-ascii?Q?ipj1HSmsXz0QivhNFY1l9a7fyuE70mN8dVxEIvq9K6YzlDEQNu9HlOBxeqBH?=
 =?us-ascii?Q?3zIjesbPLUV6K51Lp5TlsCN6ptshwRk5u2QZEjPoHPPpgJhwtXVfc7OMhw4U?=
 =?us-ascii?Q?wpZ2nVQQjYhztGU+WYnp/veyQ5d2RfsuY/8r2FcHPHyjdZHZwYBFiMWJYWku?=
 =?us-ascii?Q?q5kDaHS11alGQscNrANP78lN10SNMfoXaRpi6g4pcuKRkn5kakXqjhPXkZAV?=
 =?us-ascii?Q?WoSNGLJAXG7ZyhVPnoAC222L9FuYfHHFtAbcwpb6L5b1DVSsrrAXWRR0aFo+?=
 =?us-ascii?Q?DmqPN1cmrMo7OgD1O1JuYVnFaeHA5RNLf9U/VrOYasbE+/dmMMff3BXHG6mx?=
 =?us-ascii?Q?QWkSVzvSJ7LnZm/St3/CQrszUdU9+OaoAheHE9IySBUdZChPMxDv+FzOH+N9?=
 =?us-ascii?Q?t/hL0a8sf54vMTIXT6rOCGYo46A0qLN/8ZsHVDlXAtJC/n8zPx/apQiwIRmv?=
 =?us-ascii?Q?9ieeD6koNzrDcA87hBIgFccDUwDpEJEJ5ikpYzbkgHBTYBmTiXF97gm5iNeY?=
 =?us-ascii?Q?NpeCSsHl0re7guowJH33bvWhB3awGBcDeq3KehQ/tUma3sgENLNDyYmQjCnR?=
 =?us-ascii?Q?vq2BSm1H7D/WLSI1Fyv8LSHIFcrWPkUC1PD8EpR/GNVTmfQyde1Zbw7S3l2J?=
 =?us-ascii?Q?DmWrUAJhAT9RKA5+G+0zTTf3n7Wc1LDQtXUX0f8zLeOlONDUQsOV6YOc2pue?=
 =?us-ascii?Q?IeutwTW/UHGmvJHs+z0gDR+kOSf2P+kl4fjo+GVFFkum6f5MJEe7u1EZkctU?=
 =?us-ascii?Q?DzajS0qHQoLuJWBWt5HBDQkvQaDxzQW12kc/Gm3mqOxHyDTr7GUl+Vm7Cidb?=
 =?us-ascii?Q?QchqbosvVpQ4PdQnHXAHSH/ocQpc0z0/hNSkvMKUU6EC2mlWaCRO9xZNG/5j?=
 =?us-ascii?Q?scBnZZCMJ7nwMDzBnNlUKgxYKHmZaZm1/H2IHbqg4o1sxxF34mMjidTytVGe?=
 =?us-ascii?Q?TH1+EvHSPlvxoPrinVVg4JWMSV+o3a/Dj5w1DxY4kWlP/gixeyfU3QDtCvEF?=
 =?us-ascii?Q?ihyCszQU601V4AvN7y4wI+aE9bVR8dDrv87j8QN07hsEhIrj2icvQ25HKTYF?=
 =?us-ascii?Q?cEM69P14u1NfyuQSvYz3Eo7alQZm82UREydMQAEdlFW+0bj5KHmZcKtP19EW?=
 =?us-ascii?Q?j6XNaolMhxyTsY4FEN6Xwy6CltXyH0YBGDn/U38aHmqgUtOjORqTnrh3JqbC?=
 =?us-ascii?Q?K6u8vgEb9crFR2fE9e8oZ+vBU6blf39SEuTJzezW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eb5955-9a84-4ecb-3576-08dbb41f6abd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:05:23.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRw6JEM1FfwVxK1zc+8JMfnpUNlCvaoSOq2ANLI5B6Gsqu5HPM+B7w074/7DmH7HXnhmq9x82TaOySOOOiycrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

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
index fc8a26231595..1dd44b38a553 100755
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
@@ -3255,7 +3249,7 @@ userspace_pm_rm_sf()
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
index 8c8694f21e7d..306d6c4ed5bb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -162,12 +162,6 @@ check_transfer()
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
@@ -184,7 +178,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else
-- 
2.35.3

