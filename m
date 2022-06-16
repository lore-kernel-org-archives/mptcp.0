Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6F7A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 05:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfx+DSaLYZdPVZUKWpay7GKguY5oPnUqcotyBshoNF6F8u9EjbAHruZphmPMrqxuR1K6PszZJamJ7Yzbi8+ZRBHdMCzpfDbguXo6yN3rFvwYcCAaGV6pazNX+G762mJyhWILujVA8xd3C76RVrY6YotTWOOcQKV89U30Id9ulbL3/LSHi68dh+d91rXJTX9LSlup2JxnFUpbhtc/cvZZM7Fy4o0y8TOtc5dXVQZ6w03NuLdg4I4HOJGzHpVF0UG4NpUSpwYwbZ+O3osno7RFiZjPSaH4A3GSn2tgdH66q3kbcBl5mQQjwBJjvrOP+o+gXrCjVxtaDXYK06uXoFuKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1I6QnDt8s11zkZnJSGk8llIMgOtQcZXVvtTA2qWy0M=;
 b=hzXDEQ6Zp4ek4/bvZMAHkn2zL7VQiNMjK/VUvld8GjhFqktIa2bZcaVGzDYAMzGQngmHERmcffGnQ3ywGcRJcy+7tWS/wGw7q/+DBGfKSE/4ukAyqys/PdVpA6O16j2s3ylUNL5tFdraDX86nfcfSk6fj/woNqYJgkUnlTJdIUP8eXoDweccx9TDv10ImyeKEAOrJxx9BQsYnmoUMnH6cFZwindjpxN0KjN5xVgv5GLCMlGQQq3j6uqd85yDaGX08AatLaKhjatwQekdYZ3Tjuzxds3cYQTgwGz02EFhK0susV/wMv1DuYe0B/nf/gglWQERt/Y6OJO30zl/cFfqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1I6QnDt8s11zkZnJSGk8llIMgOtQcZXVvtTA2qWy0M=;
 b=peCgRIZw3vwcJv5quJrIFf8gi3pWeYH+FLd8VhkW91RLeHE0KtAlpHdQSO0pE6HRd9VXCq/dinLwSbkoQqaMaUCVatRKlKLraVVQJeUXeGQhVtnRIdmhGcLqrD107NMd4+8uJZNKjNIk32peKg02EKayW8ikE0ThzCYtZjGqtlUmnjWdebvwQ+ZJJqPnx4NsJUTGRpznvbxVX73Oio+2U/GAdUN5rRSJs5cIbn/qQANYlI3ZxtrNw7AVF2sEC3AYRLE+GA4F0RNs7LIvHvFSbpg8VpBGZwBaA1dIdLIUEOHYtgS/m47Vb24WCBixEAtB8rV6DThhIJvt2c6ZHuo5Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4720.eurprd04.prod.outlook.com (2603:10a6:803:52::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 05:03:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 05:03:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/5] selftests: mptcp: avoid Terminated messages in userspace_pm
Date: Thu, 16 Jun 2022 13:02:25 +0800
Message-Id: <0bf0ae4baaa7bd9be22ccfc12330dfa7a1919f49.1655355422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655355422.git.geliang.tang@suse.com>
References: <cover.1655355422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8a2b0db-2720-4b8d-fad1-08da4f557c6b
X-MS-TrafficTypeDiagnostic: VI1PR04MB4720:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4720E25FE5C6BED7BB38FB06F8AC9@VI1PR04MB4720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ujPRpgZiJgHTM0FuUs1kK1eG+tAKjBUFMdg7cDeGHdacJ49iQIi15XAXHEm9e1dfvTRAdmDDgMiVkWQJelvDnmZ739sE8lgP4rgsRDCLrKZ+8tfx3MJTvZR5MRmqhQ5vUHxEqEGBV4FAhaBj7IGVuuZykzMrttAcDaDdmj0Zyfkfq2vJ0MLHPRUCwPz5/MZVE692/awcWPZj395B7nuunTjF56gMSZIn0+Qz91ctc+quIGlO3RIISuGCLKD3QuMEJWbXDnmAg2xdSEaknzYAtepPvb7JwpQwbZZMS8LJ61uFJqkdzKCZxUB+1mS78Rh2NfaVPcQ8+I2G7fBU5u/33ldX2jJRAWPCpkruPp1BD7PKjPhMGboxGr//fcTvr9xs2Ka9MFfREl1tW4T52SiMf84QZq/qE7PuxIRy6vXSePV1eKpMAs8KbVL1suXK2o0Yanu1CuvdUM4FMrfW0ls97oAOMRkUZqqCGazUB1bVM19wYUF0GHRnSYrLGRNxOARxDjM+mBFALMZ1eKYQm969VvYa3H8jddfjwe2Ob+1/H6XGwvG3NQcwZjO3A10hhFiSwJghrAc9CJKCQFuIfZbJ6LijqNttMH9o7h3hwig4g/Vr/nKLvwoBHrckxaYiMy9y480ckzYLGuBR9pot8BS7Q7RbeY/ULX2JHK/FiMhGbn5NPkBMiziGZ/cBzIf6ftGizTSRKQkt74eouD5GQ94n1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(6506007)(4326008)(66946007)(66556008)(66476007)(2616005)(6512007)(86362001)(15650500001)(2906002)(6666004)(38100700002)(316002)(8676002)(36756003)(6916009)(8936002)(44832011)(83380400001)(508600001)(186003)(107886003)(5660300002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hT//BNsEgsOV88fUevZ5edgzv2ys37PAzIclc5SWAIAy1nsw0cHZp+H3h05k?=
 =?us-ascii?Q?9K4kE5MPof7LFjW7hcZwticVUnlSqMDalfsA6agH3jpzdVozaxBPBjEv+Hld?=
 =?us-ascii?Q?S57WpSLO/gBuXuwapN5bTYhkGsjfwLmAA4avudQcihIhRrGgqretYnEDZc2N?=
 =?us-ascii?Q?Alc/MZNvb99PijFiYg/xVytmkCnkPysYmTsTLg08w66K7Cq/AUFFXIlPoEc8?=
 =?us-ascii?Q?V0ZtyIyg+SKMJQWCOsVsg+4obtmb1deOw5BXdYodT2dxbTDGI83CEhjZzx4U?=
 =?us-ascii?Q?Wm0mWP+Vn4i0NszwXpUgBShltSJyARRMCoSCa93EbPSyRESIhTDHo5iwafRJ?=
 =?us-ascii?Q?ie5dfHYU0lbaUPEmf56xNl8ZRb4QArTA1UFdJVUuFP4wDZ6Mb4YdXWCzsRPz?=
 =?us-ascii?Q?VDTejDI7yDYqDTyhy3T8CLEq0c/+IlvZFgBwi2bMpezMVLC61tko3HXUzRFB?=
 =?us-ascii?Q?FcxYP/Mh6Flk7UeIeNpVRNag4idL8FpD1k6foNq/pPjNOdbwGsEleIb1Eg7X?=
 =?us-ascii?Q?0QoMc06XjpNKUgVy/8rftACwrxWwgTWnk5kzNJE1987ZgRwN7DHi0WrEWQVY?=
 =?us-ascii?Q?r2t+Y67Hgobiltcg7E+Tj3hyQaWTREa3YxFJTMKOJLMT+rAVjiKm2+SINh89?=
 =?us-ascii?Q?X1DJnVsYKToyrGJiCAlb3EpGROURgaUCkWsJ5otG2/KF4QNSO0LMGK/oDXf5?=
 =?us-ascii?Q?TykuHcXFfJqXgdljDWjFznlH1P6AcSJdL0Bg7VTLrt160HwLDDHOpTUhqIXI?=
 =?us-ascii?Q?gPiiFciNg6Yn6LoiIXtrB2H/NfcWgbM7A17zNATzlTFEcYsXgqnGO2fWixAH?=
 =?us-ascii?Q?44ccWOkintNOE0aXES1D398NDhUytefI8dh8fyYg6xPA2XYwmBlLJhb7sQek?=
 =?us-ascii?Q?705IxKo0Rd7b1KVMdaQnojgZ73r1AFc06Ayk252epWqhYOzvI/sJs+uOu0pf?=
 =?us-ascii?Q?4yUpABNIlpq5ldvZKI6zh0BsmKHkBOIBCjvQY7FuTa+QtK+DG3WyKFrGfaB4?=
 =?us-ascii?Q?lrxze4wLzH9Gu0BqiBFOrZ/EE663d2HaKWINmVMwLuvaoFQFxitwbzVY0RCD?=
 =?us-ascii?Q?zdC2aJup3GiAsJxIsjHbWrXYmra6FtLoNBFF9vHDs5yyjZPEQUAep8daSF02?=
 =?us-ascii?Q?dLd+R3Lpo/ywAY9zX7496QIGqqTfEUQrafSwwGOf7KK5ZLNvlmYqwBQgUMWu?=
 =?us-ascii?Q?Qb/ZexEgiLOqGu0OU1UHUzoConFvjeVwarZSozElyccMAgl7IiWKigXC0Jmz?=
 =?us-ascii?Q?vbjWWMLSrT7uIM7fr/bPUxQQHUmicrqDN7By6Bqtn8UG9WUOJEAE6GupJ7R4?=
 =?us-ascii?Q?6Q+C3zVSz+YkWcMrBJ03e5qgQvZxkCyt6aBNFBWf3wrtApR2RnAW658gxz48?=
 =?us-ascii?Q?fXEQXQAV8rdaMxVXW5RMk/23YcE8feOsW1GX/veTwLoMRleMCSQqOphbsQVe?=
 =?us-ascii?Q?JdRS2Ff8v5Kp08xy8gwiqX4loNrhvBzolFSm1vxjEyJAW2qTaBlF3EGhmcGq?=
 =?us-ascii?Q?ch5p+GIX6BYm2arZRJ48y79IX1UxkouoVk1QlcBP76g86wW09Og0OIDcqXiJ?=
 =?us-ascii?Q?o+Yp+tIta9mIZSg+blrjRMLrUt7GYWPVyR2yudmSfmQ+BALoXFs6DEl3INpY?=
 =?us-ascii?Q?sLszZy1mzmGkBdj/ajNIwAsZObkFjqmIgtZdpzeqaYuKypnMeJnSMoSLotCt?=
 =?us-ascii?Q?F8CgWCj1kVh20xtM+NHVO4KWWnfQOyjPD0hZglz02GpPItkJSZIRAi4tZwdb?=
 =?us-ascii?Q?UkyvcW3pyQdwBV+wYcTT5KPiVfHaFTs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a2b0db-2720-4b8d-fad1-08da4f557c6b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 05:03:00.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOKndXZqKRHUXxoW6zVln1HU0VLPK+lKRHO184GAu33JYMr+6jVQWwJLQ65S6mDIl0cIO6bZw7eTzjJUf+7oow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4720

There're some 'Terminated' messages in the output of userspace pm tests
script after killing './pm_nl_ctl events' processes:

Created network namespaces ns1, ns2         			[OK]
./userspace_pm.sh: line 166: 13735 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
./userspace_pm.sh: line 172: 13737 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
Established IPv4 MPTCP Connection ns2 => ns1    		[OK]
./userspace_pm.sh: line 166: 13753 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
./userspace_pm.sh: line 172: 13755 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
Established IPv6 MPTCP Connection ns2 => ns1    		[OK]
ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    		[OK]

This patch adds a helper kill_wait(), in it using 'wait $pid 2>/dev/null'
commands after 'kill $pid' to avoid printing out these Terminated messages.
Use this helper instead of using 'kill $pid'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 40 +++++++++++--------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 78d0bb640b11..d586bc5ffe01 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -37,6 +37,12 @@ rndh=$(stdbuf -o0 -e0 printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 
+kill_wait()
+{
+	kill $1 > /dev/null 2>&1
+	wait $1 2>/dev/null
+}
+
 cleanup()
 {
 	echo "cleanup"
@@ -48,16 +54,16 @@ cleanup()
 		kill -SIGUSR1 $client4_pid > /dev/null 2>&1
 	fi
 	if [ $server4_pid -ne 0 ]; then
-		kill $server4_pid > /dev/null 2>&1
+		kill_wait $server4_pid
 	fi
 	if [ $client6_pid -ne 0 ]; then
 		kill -SIGUSR1 $client6_pid > /dev/null 2>&1
 	fi
 	if [ $server6_pid -ne 0 ]; then
-		kill $server6_pid > /dev/null 2>&1
+		kill_wait $server6_pid
 	fi
 	if [ $evts_pid -ne 0 ]; then
-		kill $evts_pid > /dev/null 2>&1
+		kill_wait $evts_pid
 	fi
 	local netns
 	for netns in "$ns1" "$ns2" ;do
@@ -153,7 +159,7 @@ make_connection()
 	sleep 1
 
 	# Capture client/server attributes from MPTCP connection netlink events
-	kill $client_evts_pid
+	kill_wait $client_evts_pid
 
 	local client_token
 	local client_port
@@ -165,7 +171,7 @@ make_connection()
 	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
-	kill $server_evts_pid
+	kill_wait $server_evts_pid
 	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$server_evts")
@@ -286,7 +292,7 @@ test_announce()
 	verify_announce_event "$evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
 
-	kill $evts_pid
+	kill_wait $evts_pid
 
 	# Capture events on the network namespace running the client
 	:>"$evts"
@@ -321,7 +327,7 @@ test_announce()
 	verify_announce_event "$evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
 
-	kill $evts_pid
+	kill_wait $evts_pid
 	rm -f "$evts"
 }
 
@@ -416,7 +422,7 @@ test_remove()
 	sleep 0.5
 	verify_remove_event "$evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
-	kill $evts_pid
+	kill_wait $evts_pid
 
 	# Capture events on the network namespace running the client
 	:>"$evts"
@@ -449,7 +455,7 @@ test_remove()
 	sleep 0.5
 	verify_remove_event "$evts" "$REMOVED" "$client6_token" "$server_addr_id"
 
-	kill $evts_pid
+	kill_wait $evts_pid
 	rm -f "$evts"
 }
 
@@ -553,7 +559,7 @@ test_subflows()
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill $listener_pid > /dev/null 2>&1
+	kill_wait $listener_pid
 
 	local sport
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
@@ -592,7 +598,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill $listener_pid > /dev/null 2>&1
+	kill_wait $listener_pid
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -631,7 +637,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill $listener_pid > /dev/null 2>&1
+	kill_wait $listener_pid
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -647,7 +653,7 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client4_token" > /dev/null 2>&1
 
-	kill $evts_pid
+	kill_wait $evts_pid
 
 	# Capture events on the network namespace running the client
 	:>"$evts"
@@ -674,7 +680,7 @@ test_subflows()
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill $listener_pid> /dev/null 2>&1
+	kill_wait $listener_pid
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -713,7 +719,7 @@ test_subflows()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill $listener_pid > /dev/null 2>&1
+	kill_wait $listener_pid
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -750,7 +756,7 @@ test_subflows()
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill $listener_pid > /dev/null 2>&1
+	kill_wait $listener_pid
 
 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
 
@@ -766,7 +772,7 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token" > /dev/null 2>&1
 
-	kill $evts_pid
+	kill_wait $evts_pid
 	rm -f "$evts"
 }
 
-- 
2.35.3

