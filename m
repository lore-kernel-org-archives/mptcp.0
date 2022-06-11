Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8EA21
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 14:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBMHhCxM4u3vUxPf2ncL7/wPbKXgezFt+/kWyWh5BOLOiAVlI78ZYICjX72A/2PYL7u5lJwctC5kr7czdBc5wXdsCq/qbk95UHOuz+LyOUTecN9fj3qrk/3pSBcF54YQYbjEBIXujxQLXdgGIkojfBvyF2DTychJ4FMpT2CZxbpiPiBPrgqvY3108tPCO0P/vz+/p451cG6DtWYUoy+FYKrIGpgBQjjf3DIhzkwvgWUEJ1UvwLA2a45Aoe27LcgkCL+sYqMIAZDxjYbGth2tTRnqClpfT8xPf3upgmC6gcZ6KQerXT86hz7shtdOARnmaLF6rzF3FLftOwymYZLvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1I6QnDt8s11zkZnJSGk8llIMgOtQcZXVvtTA2qWy0M=;
 b=b/kLZuxtk9NY9YlSF1nB3tjHdmhDk5KSVBHDeUvU9aqcE2WC592Aj9DtKRolKv6T/paSZ4wbZ10lTyK+3GqP1a/7GkBAIeFCWKeRvONUuSzaM9VTkMaU4xVbEoIi5Qy2Le1Nsx8nhkFYvM0voqx6yfv23oMbOFXRqyWGjSif9NaIZ7vY6fW2O+xKIs7C4/6NHBNAoaOIrvi55KSjEsd23g+BpMbasi61iDGsQ42b95yp5I+msWrd1/mHpwvbyEkU9Qw2F5QMJy20akXIBH0HTgVCd/xcuke5hVcrHE5ZGJcXCJ/ocYAgYTLOhZEmu3SSbaN7b/ii9cNlK05sh5SUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1I6QnDt8s11zkZnJSGk8llIMgOtQcZXVvtTA2qWy0M=;
 b=32FVBhA6e9s+Flk5crUUY/J97dbFsZ5GyB57tk5MIkxpN6FpFYBXH4W5WHGUCadmUYxq7wsjHy/psTkmzSJ860kUQ8ougH9n4EED9opfXUVd4U8g/V2aQbgdXXHmgMYkbZ8ta1i3Tf1+u40EWJf+TgjP1JAGO0CTOnB4e5MCtWe5lrYlVB+RYzHO6DPJmfzIDuNvZTrMas+EWz5WAm16gvxt6YW4IS/czmK8xlMTY5hHBdjR+/18QdTkGbxLCHgEerrVeFsC1rVduHs3u72VqtQz3RiSGOmNLAA5uw6mSklVaFJMnWNWac1CX5dlzeIq8w2NG2w5iq5C8AjLnVpAuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4944.eurprd04.prod.outlook.com (2603:10a6:803:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Sat, 11 Jun
 2022 14:55:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 14:55:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/5] selftests: mptcp: avoid Terminated messages in userspace_pm
Date: Sat, 11 Jun 2022 22:54:38 +0800
Message-Id: <ccc55a405227c67fbe8a5b70f3aa20157f0bca26.1654958401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654958401.git.geliang.tang@suse.com>
References: <cover.1654958401.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b517195-71f4-46f9-f1f8-08da4bba67bb
X-MS-TrafficTypeDiagnostic: VI1PR04MB4944:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4944D84968B5F20C129B7798F8A99@VI1PR04MB4944.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rs4prdTQqP+BBfNz263R0OA1zmQjgnz6NCxujX8kbarVMEo0CgpvE7lFcKhqHLh5SBvvIkCd2CbTQgMxGsZEhRn9VQ/AN5EGxYCXMmHLqqljxY++JaWjg6XZ6S9svUvl23kUjZy6s7ZsC0pqCNWnxlnxTIsmhMu8hE9bV0WLj/MdQN3I5rhwo6YhtSX4RRcV7TQMRI1LmLE+hxW48dj14EyPxcbvbeIuUX8G4znneC+nfF7i4gv1ktxQPFlMHsQ1U2wb+7AMhdoDGzj20Y+/Mpr1agLbMrCcF8zycvAN81z55BsY/WBmu6uCE+1VqLMCGFz3w+mHmWjH+aaPanM+RZLTXJ5x0W+ELHujcfLU9ounuGyLAZoSgc726pkfWJ7IR7AwV8ER2M5mj6ErM9847HhNMEqMvvk+Xm0dvzfkXZUqvMJWKAtBFABhg3b7GdHmFuoRMU40TAdufx+8QJOHHJbWUL+N8zcn9CAJz8qSy698XTW3GE1VzHs8XkA9V1jlHzFsYW11z4ktPwM4KrQSffoE/59W5ZrpTUWfk0+oNrIdXrnSMGaO+/yyPeu/F66OP5wTNzt3KW0N0IGI2bqE9ZxSVRsN/we92MwhpjMeOlX80/bNFAEBtnFIZat7ZTjUbNJN2DVXG6HtSlvGVCLNBFAN5sA33lKJxFZa2hAOdg3meQziP21fL65np/dyJI0MA8T3czGuwmLq2LUFyOK62A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6916009)(107886003)(15650500001)(38100700002)(316002)(36756003)(2616005)(508600001)(6506007)(66476007)(66556008)(66946007)(8676002)(83380400001)(86362001)(186003)(6666004)(44832011)(5660300002)(2906002)(26005)(6512007)(6486002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88KYggm5VAIMS6Uhmj8Zcvo8AWI5gBzBGyMXXNPtokqpykeUKzHxYWI8gsLX?=
 =?us-ascii?Q?0X4aSq98SXhr4E22i2pwhP6Oo27zx5Z7VtZjzKFiMzZ6WTFgcackGWfP/Gxl?=
 =?us-ascii?Q?omX01+yYiZOi3GHVW/rILq0IheutIx27wxYPRH5aSPqySQXonCosSq/JoKpO?=
 =?us-ascii?Q?vEIh5i9N1xPC7f9eCGaTLcKy49JSRS7uCra/m9h+RXYXfysV5iwxM6X4eWuR?=
 =?us-ascii?Q?w9bINhwc0nRZRWcbarL/OP1RxS4+sTekHx70c9MJvve6v/gynL9v+Akcvfu0?=
 =?us-ascii?Q?YYz5JUZPlwauVwANx/pPVIVDS2kTHA5aHY8uFQnNAQq4Cjd4igSfKjm6XJV5?=
 =?us-ascii?Q?SFMcam2FIxcYq83avgCXkAWwnTbkK4QxWBFto6X9RZf7BKcZ7MUMgphSGRnw?=
 =?us-ascii?Q?gDXPVqjREsoFfn+g1xJW5B06YYqPUBREp18GNRH+wQiZp6+Mcos6uA6pBYV7?=
 =?us-ascii?Q?D5rEEXnAwwtX1UQMb1ZJvvhXRq3gmOum0QBVL3zlfhFUMkjytEqMdztw+qLf?=
 =?us-ascii?Q?E8eGNbaJJQJOMX2DUgS6HkUoXB+REVlRxq7tnfuOkh4Rd0vTJTYosFpxhX4y?=
 =?us-ascii?Q?o/ePngbqNG02R5sy94P84mddLgcRAeU4Wzo7V/yfgxWfYe95MWTJ5gvP7SsA?=
 =?us-ascii?Q?C/wneMO1LpEv349NZ7ha7yy4S1/d+YXeH/chACUdLv01X39sd8aspoVr5u2n?=
 =?us-ascii?Q?c3IjZnLjmFdpphlpYFqVw3BW8ShKl/EDJnPoMNHCdbKeERgmURfpzI5MAZ60?=
 =?us-ascii?Q?h6Bh7aMwg9JCHHLZYByykIScBTdUc1Edv4ebW1TJgQo3954nAgQIxRyFD/Ti?=
 =?us-ascii?Q?XRSDiUNuTZPjEo+hxhmX+297OO6F38m2IZ8w/hCEWWCwJREn69EK4Rotrk7J?=
 =?us-ascii?Q?jlHdS578Zb97ktzdkD9Jj4HOqDWKnzbONS79CsSCuH2STZ+C/ZmQi79irOuC?=
 =?us-ascii?Q?ZUvf+J1Zd12v6t5Aqz/G55delN+2AynlHPEzt4AJXlne4O4fIEcj9EX3oDa3?=
 =?us-ascii?Q?3hQk/8ByIIT984E1UlGBYz+3MdEGov8VTyJo7WxWfaZX0QJO8hFHKAdG9p4b?=
 =?us-ascii?Q?6GWKEhPhQZoywiaNWcijTq77hTMNCOiewYOcLrIQy2QZbGGVVky3dUpwYm6y?=
 =?us-ascii?Q?ESumTl/3Z03UDeG4FazN8hBXERiihJisSLTqKSLB7PaIq6YrzAUfNAWo7fWd?=
 =?us-ascii?Q?5GO5Ab89FnL4jrrEGD4Fnjytrf3x5yDScz70CHUh7ifx7OusjepFPSK9hBDl?=
 =?us-ascii?Q?mCNZjdS1V7e4VYJyAoR8ssdkc6tgmRMi7Vo6BNSr3UEhBxjZVYywrbyEG5Q/?=
 =?us-ascii?Q?5U20uJBE51EhHCaId9a5pRJiNvl302Y1SxagHijUs1F8JpS7774HShru3IC6?=
 =?us-ascii?Q?9N+kaSHgx5sd/n2Gjer4gnnx9VvknJJ02Tocm+8zfjNGKSlG7Wwh7s9/MW6t?=
 =?us-ascii?Q?91L+MPvPp7RCfB/n4tDOtyckNL7XKxDaS/g7RIsvR6dmS7S4o5/7vPBcETz+?=
 =?us-ascii?Q?XllcnMwRxhF6iluU1fpbIWtkyZtOQRPTQUZxLXokV2Hu2G1REe+1zgtelZFH?=
 =?us-ascii?Q?GT50kbPY3T2gtCrWiO6eC1+i5jahYAEqLg8HLzUIgyw9ZSXJFD/8LRuneQE3?=
 =?us-ascii?Q?lGCwYqT1RvnUq+sO8CfilpK7ZoVkjpBdRfUDKUMN3HprAyFBp/psCyLQl1Cw?=
 =?us-ascii?Q?yJn4J1xNjNas/YiN3Ti33pFoeK/BzC4jaEX48/SdNbqeLPM0oUoNLwNAaOXv?=
 =?us-ascii?Q?dpjocRELK9izGU48MbQFUGdVSWp4w5s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b517195-71f4-46f9-f1f8-08da4bba67bb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 14:55:20.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CtYfPJS/goUSiBwPEp/2RuwmHr63DgkphM7dBE+M8saMZ/hXNEwV8FgDBespcqEI8ZyIfQdQFDcBhiZcnUt7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4944

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

