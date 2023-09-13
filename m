Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469BA45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flBINidMFg6MY2YYAWv423fO55Zb1bwP9WkuPhBg66q+GNrrlTRVMdzIhWIjDp4c/ZzLyN0EcrI1mUQyblXXojPBeDVmDMJGRi5ptc6tsuC6pZ8WI7Bk/PcMQpjsxx//oVJPiyl5s4XCp82ZQRbWh7AameTAdu81vjRG9VGa+r4m9yZsl1n5tG6/tKs546Zhgq2M+mm1qbdbX/XA0veTR7TogfwKle4kOFjARKrPvkHxqTKy5NLYlBXcaIyAAxo/jYOZ6qQxsxqaBUJcj54HyZYav/jF/8FvLKvZxUobIuFWX4V590xFMljEhbcCiOM4lXQPIqNwIEdRlIjNNMittA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT7prdXPYkZef7aX8iuxG6btLfhKkbwvu63iaAdl1eo=;
 b=l/l3gftp8xqg1SEANJtDFNIVIm8aBlpQDauKeeyTQEHxZMaxQ1NRSz8SwRx1B4n20dTp5LSNqRzvoMCi1ggvV+4t6H/3sVw3UnOGAwIeuE3Rvobc4Nc2jHXVEsm2B1aA9FvMJsCf4NYI7Fj5gySBXoik+P/u5PNDgbC84PUG8k5nK5KtYesNGNaNLXq0JpGHtdnuHRKLLW0nUgQ7CMGEenVidSghnGhWoHpV3Uwa0DMKtUxfbp6c4o6U0kIkdhNiVugFBiZbWDKW/vPAJ+yzGcnzZd/+hPkv3Gd+h8HBs1i0xjnW2W3xuhsG3P480Vy5anH5IYFIT1Hut9/QvJGtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT7prdXPYkZef7aX8iuxG6btLfhKkbwvu63iaAdl1eo=;
 b=1QblOxBrXNLsHcnZBxgD9n8cnAahjQTAe8URDDz1pKna2C326jnfsqxOSPRq6b1tpn/m2GqwFElteVbb+Wjkndmf/GHzZraf7ZrTYC6zNKmECBkIabhjiVyT82iFPJ3djLA4M+6enVX1TcbSjTSKc7uOScP2Kv38a5l6lGmxXsCc0gTqlcHJh5ii5Nu9Qa0VVEwt0TqH1eVR2R5JgSrE30WSBcY/FGQ9cFlGHGNXgkhWqhtHzhUc2wn7qB87ktx6kmI32gq+8qD+DAQRdR2fhfO/+90IIFyO5ilf7/VwiSmWhiVvk/dOYAI9J0+7FlCU7yV/2mQo+6XPMvZ8X9z8zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:04:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:04:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 05/13] selftests: mptcp: add mptcp_lib_kill_wait
Date: Wed, 13 Sep 2023 14:04:53 +0800
Message-Id: <3e2f3e132ba6d3eda36851256a58dfcda0c2a578.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: a2473729-9b11-4a05-c0d0-08dbb41f5931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a70wCp9GkPyDI9j7YDbZhiNiSNpZ9sVkMPdlErgYYIxcXqAiuocgJwpOSax/7wHTtMP8ZrIJ6Si7hdI39SvJ/y0VQMJstdghzBwk31az11HmNo5r1AF3+FXDvVtHDCX7n0LCG00o7msL7qnR1xtEGiwg93g918jKUWNeO+C/+Q/AjmlFlnmGaRUV743iordr/XjH9r5OY3OF+LTO0NXj8s61ORNpzsVTXopwusPCE6dmkTSwUK4KZm3g+KaIoAOjjByJhfTnasv16XWUeJfLXBRKvmjRiFmOrlocgfh+JPSmIXuN/P7S4RpA/dabPWe6wnmAg8SFfMZabOPkKPxHmq4IZFMaO4j5q4gqgCCekfHCd0nsHOu8vLQ5k8/llhxeFzIIdwUGsdYcJTxSzFXVmUm53un/QO0/mVm9ZkJ67zam7Lp4wLo/j4NRpqyaDL2A0lfbS1M+SyyU9ricL5LQ00X7U2tHrv3tV9DFFibJhf0SMEgVfdZWEIxS7QdVk+ecENwMPKmc4iVuA2QotU1cRxpmGlG5ViC4CBM02JjjtVR2rc4KN7BnAUUOMkJhMFOLzp88L1YVtuimkC6GhklrcISd/jQHKnIjBQZqOHPIH8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXMvWZf7oQRk+nTRr+B9cdJXUW7xkK9HdGqP9SYqIsCllJAh7af8y+kDeGqK?=
 =?us-ascii?Q?SyDy3mvmXXm0XXOVBhD1sVV4ouI4SVo7vZZw7ayRyJn6/sy+jrPEZkhqHjVk?=
 =?us-ascii?Q?MXgpmIdrvZIXK+enG5O/MPcBKPIHe+XpMpBTFZYOXgyi9vYADbubqWWln3Lz?=
 =?us-ascii?Q?P7LPp3bfMm36EnLtQXQ0qQMWvz+b+IXybcDROUzKcoxxpqvR3EvKes0juc6b?=
 =?us-ascii?Q?1OBvGmxXdQXGf8ceOoWnhtX/kV5QJiSpcVuBAIQR326RYych5g2i+6ieHG7k?=
 =?us-ascii?Q?pORVQCYJpSLvVyp3cxwmjgHFGA1sH2m+Ock9p1zSgOp3LpMVFmFmFldxzZCb?=
 =?us-ascii?Q?POovKe2urmaCGRfiATqsfdFI1rugQ9BPGYQPb2e4lE83ppmlPD4czhojqYJq?=
 =?us-ascii?Q?0DqJXixfnqLALREXXbasiY/xReMJNzpKdjUF3m7T2OAkljnXbMXf5beytiYE?=
 =?us-ascii?Q?GAaomPUru1uOqP65pI3z4aC2r3Piy1J3nBpUPh1UcaO4BoYOw5WcohhmpY7H?=
 =?us-ascii?Q?+NTJr6YeLeAfGwXn1cAdG79NoL+jSoOBvfMoGGysfy/cytGG5RHnoezQ/Lqa?=
 =?us-ascii?Q?okxrfj6wwtCkZAJMoDkY895kFyR4fujcoSWBgU5czo3KXWnaonmtNbduk3wo?=
 =?us-ascii?Q?GmAaPQ66bRqZTAQdwVBoS5IQo0yd0i3lzo1Cr1Kk9TfNfiQh/i+7rFq/gojI?=
 =?us-ascii?Q?aIcYPsumBh7v3um6RpwNF8vtcEZWFApVJL4JP7Q/Jrmh5pcOxzoDljVluNOL?=
 =?us-ascii?Q?U5OvUOSujg9xrn7/Dz2CmPl2bBePTQIp7hZkcNaQVQS1XO0hn7KbxRn/9jU4?=
 =?us-ascii?Q?ZXIaMa6XHxlyZMoeGxjo8eomSZDNSNa176oAU9zHGQHKzlQXmwpi50182e7G?=
 =?us-ascii?Q?Yp4xzAdrZ7d+dvWr/7NSeYv6TxGDtR57U1sT6yMv6pREsZr6lDM56rwoKr/a?=
 =?us-ascii?Q?6u9ltivLEg4sk+rupG2m5ReCb3dVLc0OIMa7Jky/g3gXc6eeYbTYz4b3fk11?=
 =?us-ascii?Q?kOd97NLjlsYfbVm2sLvrYADxARWFmC4wOd1ndWybqvGhUcZNJ33No53EEChA?=
 =?us-ascii?Q?/IEm96v2v4KkhQieePg0AjmbdDQA6SN2ErUafFqn4qOc+n7xhfQ32KS02A9G?=
 =?us-ascii?Q?w+mo3ZdKIhxH9uLtAGPli5e0kA0Zs3u5tu6MGuwqpr1wVbuVA0Z5Gve7D3+j?=
 =?us-ascii?Q?mE1kNOa50S2XDuNocMydkOJRMAiUAwEIv6fZAibNv4pPewbMx1IYNKZHcIll?=
 =?us-ascii?Q?ow/krev5JrjvoFdlAocYsH3y2gEs+nn15Plp2Y/PIQSLrkaF/il7ujwNLxzt?=
 =?us-ascii?Q?8d4DPrdeivdPAehDB+gCYrIu4Jokl9DnCdesjxDp9os+Xos1E4BtHId5KN9U?=
 =?us-ascii?Q?SCpfvdNY20vk7L+/H6kdWEBqy2lusSaBdqDDCLNMEBaXZPKHBhkuUHf0i8ar?=
 =?us-ascii?Q?8nj8S3qgp2Gsib1d60hL21REYNjwHNC8Cly5wra2NXpK3XUCy5pN+okdCovx?=
 =?us-ascii?Q?5GrDKKV2fUMjdsVfXhxITAGZxnorH0QUbGbm38eLfS483S18Y64eiFdgTCxj?=
 =?us-ascii?Q?kTJXxB3s0oHinRap8Sy6d2sejVf+PakPVJG5H68H?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2473729-9b11-4a05-c0d0-08dbb41f5931
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:04:54.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbEc/QLvYhtGE9mpqMR3OWRcaGjXZgtuhTjy+n9sq2Yvk8gKR71BPMVE7Q7aFSMPRJPoeVnNdzndvGq7BXSYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

Export kill_wait() helper in userspace_pm.sh into mptcp_lib.sh and
rename it as mptcp_lib_kill_wait(). It can be used to instead of
kill_wait() in mptcp_join.sh. Use the new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 ++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  8 +++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++------------
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2fb07f87e6bb..96e3fd219968 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -682,16 +682,10 @@ wait_mpj()
 	done
 }
 
-kill_wait()
-{
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 kill_events_pids()
 {
-	kill_wait $evts_ns1_pid
-	kill_wait $evts_ns2_pid
+	mptcp_lib_kill_wait $evts_ns1_pid
+	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
 kill_tests_wait()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index bb95dd967eb3..8051ac5507dc 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -219,3 +219,11 @@ mptcp_lib_get_info_value() {
 mptcp_lib_evts_get_info() {
 	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
+
+mptcp_lib_kill_wait() {
+	[ $1 -eq 0 ] && return 0
+
+	kill -SIGUSR1 $1 > /dev/null 2>&1
+	kill $1 > /dev/null 2>&1
+	wait $1 2>/dev/null
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 283c62deb628..7cddf793950a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -107,15 +107,6 @@ test_fail()
 	mptcp_lib_result_fail "${test_name}"
 }
 
-kill_wait()
-{
-	[ $1 -eq 0 ] && return 0
-
-	kill -SIGUSR1 $1 > /dev/null 2>&1
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 # This function is used in the cleanup trap
 #shellcheck disable=SC2317
 cleanup()
@@ -127,7 +118,7 @@ cleanup()
 	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
 		   $server_evts_pid $client_evts_pid
 	do
-		kill_wait $pid
+		mptcp_lib_kill_wait $pid
 	done
 
 	local netns
@@ -209,7 +200,7 @@ make_connection()
 	fi
 	:>"$client_evts"
 	if [ $client_evts_pid -ne 0 ]; then
-		kill_wait $client_evts_pid
+		mptcp_lib_kill_wait $client_evts_pid
 	fi
 	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
 	client_evts_pid=$!
@@ -218,7 +209,7 @@ make_connection()
 	fi
 	:>"$server_evts"
 	if [ $server_evts_pid -ne 0 ]; then
-		kill_wait $server_evts_pid
+		mptcp_lib_kill_wait $server_evts_pid
 	fi
 	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
 	server_evts_pid=$!
@@ -623,7 +614,7 @@ test_subflows()
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	local sport
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
@@ -662,7 +653,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -701,7 +692,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -739,7 +730,7 @@ test_subflows()
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -778,7 +769,7 @@ test_subflows()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -815,7 +806,7 @@ test_subflows()
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -861,7 +852,7 @@ test_subflows_v4_v6_mix()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -973,7 +964,7 @@ test_listener()
 	sleep 0.5
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
-- 
2.35.3

