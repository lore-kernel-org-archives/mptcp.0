Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803617CB
	for <mptcp@lists.linux.dev>; Sat, 26 Nov 2022 13:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkOKbYAm3GG12x9+HyBlzhco1sePuw3lmE3R6NYIBFEw2wsDRu8A50U9qPhvzyO+hkLF8fUvzw54bp6RVBxu2cFgSv9JLMUkAVSK5CqSV7XTN8oJ0EJHSv3prxR8pCpHQHwt8/oOAhEYkQQcvczXVhcjyDR0IuMWgoM3VBzsJue3nzzcQuZKDVi3hrh0vPR/58PpjJ1NhYsZRehn5GD0x1H+jH1FUaCPAHQdI+0hkUBeQD0VAAaGlnZ/uGCYoa8bK7lqtdgI7EISzAGSxQUTEqLs+BgvY9lYTSWxhXZMMQPPv4JashjbVE3T2ODh68m/k0W2BTiYze/pkCyyoPz2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwommJP47Vy5ESvtyWQgOu9hHUbP/n99yf9dtt/5onM=;
 b=bnB+qVPFSuyZyT7bDJIzv0ueWgmkT/hj33Qre2bCK3Xwww6NbvhlcC8Zmjr9vY5a2N/kP1vu9GlQPsDMHV/Xbm8JzU0shFeCQb4OPHXUK7b0ba7QTfY+CgFLPYL4TcfBoOfBLM94HOrl4CdQvH1T/j0Fm2uy4UgbO1YqP5sF4btacgj14hFnYZ9Jr8AIreQEZ0xVBnB0cJw35uB/sjDpFgZt91Vf7E7fIONGnWaAExzx1nGeylcumOaS/U8lzVR8AuEO0EyqyDtvwPRxDDfpxqWFJJonloxI2WqW6R20D7HY/gfI1FD3Z9eIVJgKAAxfm2lZBG2SRPtja1CX/YCaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwommJP47Vy5ESvtyWQgOu9hHUbP/n99yf9dtt/5onM=;
 b=S9lw3dlOWnF9lbNIKXJM+wyGoR/XBPfghAs3+GFeSJnOb1ggARY09HKuVB8BqT5+ooiJXnO11B8wBEWj+cNHm3hUu8fYNkbRRdM/AoaxdBNrVl9KSY4x5Bm8McmairyKeFMgbv9cbpIj4pJFG1ApXOx/+8UowISGV6+M9T3urdHJUZdEYp/5ZuJo9DNud14Ntk5pYY/OIOAc3yoXkkDKo6cfzLZpMrdsI5mJDDXcP0JN4M4xtxu0uLcLKP0o3f92YcXizR9opJqoNVBfygVjy800SP0IePXO5uk0NcHGC4tatH3G6nCDvcRoXl3M27QusY1a9OVT6thfgj7gt9DP7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 13:15:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 13:15:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v3 1/4] selftests: mptcp: make evts global in userspace_pm
Date: Sat, 26 Nov 2022 21:15:19 +0800
Message-Id: <72a2fe4ba1bc121d019e6f1e4342ee46e7e7e7fe.1669468340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669468340.git.geliang.tang@suse.com>
References: <cover.1669468340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 4345c3e9-b3b7-4c5a-02bd-08dacfb03937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/RaTwyAcf8Vuplw6v4TJ/GwrwhMfL65PkldkbyOah+nTWdi6sWeHN8PWI5NuBvkkkskHFaLAdytEy019tYBcphL/I/313Vd9aTyE+ra36krFlh8ALA8tCPnd2fOJxTuFJF6/Qf4MdyJuU6Cr1/i2B6VyG67xO1ZCEBSapWEDpB636if1jCVXuUA/IYBD/sttvbbbE9k7SQGtyY3VuYt/igD1AlYztwTASM8FcYiozz8W14qkZ9te5/0I2ZKHiMgrFxCjRfivnqfnFhfi6c9G4p70+Zv6iDneRmWtDnc9mI/0kQSN9aKXC0BJ91ZAlgbA3q8/5gkMdx/EmKJZAmc5tfztHLw2+A/hrBGJOvTlf4WUN5XDK9AaWV6V7fXT5yOc8EbBwMb5Ks5w1UPDZfk8Xhu6c8OgvMcT6nsuA5suBj4xZOvWMX9VnW0B5TPdTvLTfWKSpN1L+u71LRH7qUltf6vSFwUhKdfEsNixMDQhyV4r/PEOU0TBFXb3MlSa5pcPw66vf2d0Pqte1dFrgv9HJfwCldDOtuXP1zRHG0ig/RdqKWP1HGq1VcHO15VDoDivFMWlsRAk0dMhYKq2AQp8l0vsitL6RYeBVcueuX+FLBgWDLQKRqrusKNBOCtPqVzkCykOrCbee9KNAVnAtzdP3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(6512007)(26005)(36756003)(41300700001)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(6506007)(2616005)(478600001)(6666004)(6486002)(316002)(30864003)(6916009)(8936002)(2906002)(44832011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ZpVmEPnTzBRRoNzVJQSu6+9MZ5g8d1+Hz6xpViw5rUK5jiPv361VpSc7uvZ?=
 =?us-ascii?Q?kO38Cq8tbGM02kD928pXca0vdsIAKdKY2mzSJ8irOMzCz3fgrwjaNkkDf8k9?=
 =?us-ascii?Q?jxlDDhShBy72NvC+fiKDq/G8MZCKVxGVOMDFeUqyqPAqzhkl//ARvUVSKs8k?=
 =?us-ascii?Q?nrAgjELa1wuOuJAJlbIDmIJh0WgHFPiU200liTemMdRxhQSYA0hUs1aA/XnV?=
 =?us-ascii?Q?AJ0KxW/8PGW34zkWDkDYR6FaSejA7qfPjsOsGOcVcWLe2Y8npLOycA8KcE/V?=
 =?us-ascii?Q?D4Hb/iw/5B9til77VMoV4jw+8NriLhreLVxwOJgddjMX5IE/5hNUcIdV5TTO?=
 =?us-ascii?Q?m8eXxRnEFOaxrLYc1du6mbuE4Vd79BsWuZAv9L4cxnkgrbTBxNSY0cQnrvx9?=
 =?us-ascii?Q?b4VROrtkY7bzJeBstrpivbqIF4v4Ni4BYCbaPqRyRouffaWk62U0X2iY57tW?=
 =?us-ascii?Q?+sRVBMVA6h4VMITSnPq1iDqRkDpgqsOvHkoqwqeOl1dchdNjR8JtiE2fjO6L?=
 =?us-ascii?Q?xk7eJzSc4y6rkFSK6d2fDlJ/V8mGlGz+NdNBv61fPGwf4cY51rjqYhsVIj/M?=
 =?us-ascii?Q?bRt04V5NfjCSj1kdGVfLjo3B16MmCR7AcVi8FqxzH01yaxXwpVUc3szFHHb5?=
 =?us-ascii?Q?ed/NEqmjLhzdvPuoxV85JpXH2QJmpJEcHfZ4u33CaSGIPoaIMGPBcflJCKgW?=
 =?us-ascii?Q?i0FVR1Rs9tdDBzZ9NZ+3u/dfeCFh6QntGbuDrdO57qm2tRjp5KxbYRx+75F2?=
 =?us-ascii?Q?yAZjGQSd8SB5ZMvkQ4H/nveoOZjtZMLd+t1lMwrFhgvip1mfPyQtpMglQ6bX?=
 =?us-ascii?Q?0tmkrR7e3F3FSJEWpsFvCRhknvKpuWUOsXHyhYMcUJ/H1dkIubdSoJKRZaKE?=
 =?us-ascii?Q?chm+HVnsCMROsnYzUNUJ3/XLhBV8GEAzDdtFgeBV7n12eJ5r3JhPw84+qx40?=
 =?us-ascii?Q?YjajjmnO5ZpNN6hVuUtL8KhWQP49Y36OGnLnu9GMxrWjVxxoMTUK6lhMXnCs?=
 =?us-ascii?Q?uSzwiK09jmj/fBJL8fEpwuEn+KpPYv3oXQ7Ktw6NVHkm5jz/f1A2iV1ji3/d?=
 =?us-ascii?Q?/R1Wt7WdovRe/d1b/CmUS9VmMmcpDTVsAdCjOs47BbyrG2/f1IkWFAkm1C8P?=
 =?us-ascii?Q?t0dvQmt7OkrHkSp0hkqcbQUVsMddSS3HdNaROSngckX9ukqkqRxnBn9s7Lio?=
 =?us-ascii?Q?Gts4r0hEzJ0Ss/InlagiIAZLHcUCw4iNSGEpXTrtop+3ABdEKRdgd5aRgPJm?=
 =?us-ascii?Q?6Nc/uGnIYh25gEhw6Nz8hE6FqDoNlaZfs/s6yV+GJMjRDZDf2LDXtwkARaxH?=
 =?us-ascii?Q?ECvz4NlqfolZRq2fytPF2N8BIsbzn2dYnFybwpblxOi9+1Q1G04zPxfjmlw0?=
 =?us-ascii?Q?kd9ZZZ/sstTQTel6SUpUt10H9Xpr+bA5UrDWHiofWSepgEDwJnqYgJZTtHPV?=
 =?us-ascii?Q?0wwRqzHUn0liml2wm+y3L5hAzsDRtVmfTafIm1nBwF4R1WSemuCXSK5x0bPL?=
 =?us-ascii?Q?EWq2M3/YY7BXq+7l9HcjVIxWn4GSwzX75eQG749PR+S9/Hw+VC4VXO8pruF2?=
 =?us-ascii?Q?0tN37+yD1TNF3VB/NpVRuyvuxv7k5gBeB8OPqI9RgnQ/s+t4vDt17SMgXEgy?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4345c3e9-b3b7-4c5a-02bd-08dacfb03937
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 13:15:01.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a92W6PbdutdN6HzNn9fOdO0cPhCjt0aG254gP+3GiYfOcu7odVZ2WTYKRmTgPo08MmDYNzM1yU5gbw6MRVGFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083

This patch makes server_evts and client_evts global in userspace_pm.sh,
then these two variables could be used in test_announce(), test_remove()
and test_subflows(). The local variable 'evts' in these three functions
then could be dropped.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 208 ++++++++----------
 1 file changed, 90 insertions(+), 118 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 40801279ebdf..f21da6119ad8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -17,7 +17,10 @@ LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 AF_INET=2
 AF_INET6=10
 
-evts_pid=0
+server_evts=""
+client_evts=""
+server_evts_pid=0
+client_evts_pid=0
 client4_pid=0
 server4_pid=0
 client6_pid=0
@@ -49,7 +52,7 @@ cleanup()
 {
 	echo "cleanup"
 
-	rm -rf $file
+	rm -f "$client_evts" "$server_evts" "$file"
 
 	# Terminate the MPTCP connection and related processes
 	if [ $client4_pid -ne 0 ]; then
@@ -64,8 +67,11 @@ cleanup()
 	if [ $server6_pid -ne 0 ]; then
 		kill_wait $server6_pid
 	fi
-	if [ $evts_pid -ne 0 ]; then
-		kill_wait $evts_pid
+	if [ $server_evts_pid -ne 0 ]; then
+		kill_wait $server_evts_pid
+	fi
+	if [ $client_evts_pid -ne 0 ]; then
+		kill_wait $client_evts_pid
 	fi
 	local netns
 	for netns in "$ns1" "$ns2" ;do
@@ -134,16 +140,24 @@ make_connection()
 
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
-	local client_evts
-	client_evts=$(mktemp)
+	if [ -z "$client_evts" ]; then
+		client_evts=$(mktemp)
+	fi
 	:>"$client_evts"
+	if [ $client_evts_pid -ne 0 ]; then
+		kill_wait $client_evts_pid
+	fi
 	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	local client_evts_pid=$!
-	local server_evts
-	server_evts=$(mktemp)
+	client_evts_pid=$!
+	if [ -z "$server_evts" ]; then
+		server_evts=$(mktemp)
+	fi
 	:>"$server_evts"
+	if [ $server_evts_pid -ne 0 ]; then
+		kill_wait $server_evts_pid
+	fi
 	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	local server_evts_pid=$!
+	server_evts_pid=$!
 	sleep 0.5
 
 	# Run the server
@@ -161,7 +175,6 @@ make_connection()
 	sleep 1
 
 	# Capture client/server attributes from MPTCP connection netlink events
-	kill_wait $client_evts_pid
 
 	local client_token
 	local client_port
@@ -173,12 +186,11 @@ make_connection()
 	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
-	kill_wait $server_evts_pid
 	server_token=$(grep "type:1," "$server_evts" |
 		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 	server_serverside=$(grep "type:1," "$server_evts" |
 			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
-	rm -f "$client_evts" "$server_evts" "$file"
+	rm -f "$file"
 
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
 		   [ "$server_serverside" = 1 ]
@@ -242,13 +254,8 @@ verify_announce_event()
 
 test_announce()
 {
-	local evts
-	evts=$(mktemp)
 	# Capture events on the network namespace running the server
-	:>"$evts"
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$evts" 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	:>"$server_evts"
 
 	# ADD_ADDR using an invalid token should result in no action
 	local invalid_token=$(( client4_token - 1))
@@ -256,7 +263,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 > /dev/null 2>&1
 
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	stdbuf -o0 -e0 printf "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    \t\t"
 	if [ "$type" = "" ]
 	then
@@ -267,71 +274,63 @@ test_announce()
 	fi
 
 	# ADD_ADDR from the client to server machine reusing the subflow port
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
 	   ns2eth1 > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, reuse port \t\t" $client_addr_id
 	sleep 0.5
-	verify_announce_event "$evts" "$ANNOUNCED" "$server4_token" "10.0.2.2" "$client_addr_id"\
+	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
 			      "$client4_port"
 
 	# ADD_ADDR6 from the client to server machine reusing the subflow port
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1 > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "ADD_ADDR6 id:%d dead:beef:2::2 (ns2) => ns1, reuse port\t\t" $client_addr_id
 	sleep 0.5
-	verify_announce_event "$evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
+	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
 			      "$client_addr_id" "$client6_port" "v6"
 
 	# ADD_ADDR from the client to server machine using a new port
-	:>"$evts"
+	:>"$server_evts"
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id dev ns2eth1 port $new4_port > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, new port \t\t\t" $client_addr_id
 	sleep 0.5
-	verify_announce_event "$evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
+	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
 
-	kill_wait $evts_pid
-
 	# Capture events on the network namespace running the client
-	:>"$evts"
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$evts" 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	:>"$client_evts"
 
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, reuse port \t\t" $server_addr_id
 	sleep 0.5
-	verify_announce_event "$evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
 
 	# ADD_ADDR6 from the server to client machine reusing the subflow port
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "ADD_ADDR6 id:%d dead:beef:2::1 (ns1) => ns2, reuse port\t\t" $server_addr_id
 	sleep 0.5
-	verify_announce_event "$evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
+	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
 			      "$server_addr_id" "$app6_port" "v6"
 
 	# ADD_ADDR from the server to client machine using a new port
-	:>"$evts"
+	:>"$client_evts"
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 port $new4_port > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, new port \t\t\t" $server_addr_id
 	sleep 0.5
-	verify_announce_event "$evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
-
-	kill_wait $evts_pid
-	rm -f "$evts"
 }
 
 verify_remove_event()
@@ -359,14 +358,8 @@ verify_remove_event()
 
 test_remove()
 {
-	local evts
-	evts=$(mktemp)
-
 	# Capture events on the network namespace running the server
-	:>"$evts"
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$evts" 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	:>"$server_evts"
 
 	# RM_ADDR using an invalid token should result in no action
 	local invalid_token=$(( client4_token - 1 ))
@@ -375,7 +368,7 @@ test_remove()
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid token                    \t"\
 	       $client_addr_id
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
@@ -389,7 +382,7 @@ test_remove()
 	   $invalid_id > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid id                    \t"\
 	       $invalid_id
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
@@ -398,40 +391,35 @@ test_remove()
 	fi
 
 	# RM_ADDR from the client to server machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1                                \t"\
 	       $client_addr_id
 	sleep 0.5
-	verify_remove_event "$evts" "$REMOVED" "$server4_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
 	# RM_ADDR from the client to server machine
-	:>"$evts"
+	:>"$server_evts"
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1                                \t"\
 	       $client_addr_id
 	sleep 0.5
-	verify_remove_event "$evts" "$REMOVED" "$server4_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
 	# RM_ADDR6 from the client to server machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
 	   $client_addr_id > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "RM_ADDR6 id:%d ns2 => ns1                               \t"\
 	       $client_addr_id
 	sleep 0.5
-	verify_remove_event "$evts" "$REMOVED" "$server6_token" "$client_addr_id"
-
-	kill_wait $evts_pid
+	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
 	# Capture events on the network namespace running the client
-	:>"$evts"
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$evts" 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	:>"$client_evts"
 
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
@@ -439,27 +427,24 @@ test_remove()
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns1 => ns2                                \t"\
 	       $server_addr_id
 	sleep 0.5
-	verify_remove_event "$evts" "$REMOVED" "$client4_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
 	# RM_ADDR from the server to client machine
-	:>"$evts"
+	:>"$client_evts"
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns1 => ns2                                \t" $server_addr_id
 	sleep 0.5
-	verify_remove_event "$evts" "$REMOVED" "$client4_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
 	# RM_ADDR6 from the server to client machine
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
 	   $server_addr_id > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "RM_ADDR6 id:%d ns1 => ns2                               \t" $server_addr_id
 	sleep 0.5
-	verify_remove_event "$evts" "$REMOVED" "$client6_token" "$server_addr_id"
-
-	kill_wait $evts_pid
-	rm -f "$evts"
+	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
 }
 
 verify_subflow_events()
@@ -535,13 +520,8 @@ verify_subflow_events()
 
 test_subflows()
 {
-	local evts
-	evts=$(mktemp)
 	# Capture events on the network namespace running the server
-	:>"$evts"
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$evts" 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	:>"$server_evts"
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
@@ -554,25 +534,25 @@ test_subflows()
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
 	   rport "$client4_port" token "$server4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET" "10.0.2.1"\
+	verify_subflow_events $server_evts $SUB_ESTABLISHED $server4_token $AF_INET "10.0.2.1" \
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
 	local sport
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 
 	# DESTROY_SUBFLOW from server to client machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   "$client4_port" token "$server4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
+	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
@@ -586,31 +566,31 @@ test_subflows()
 	listener_pid=$!
 
 	# ADD_ADDR6 from client to server machine reusing the subflow port
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann dead:beef:2::2 token "$client6_token" id\
 	   $client_addr_id > /dev/null 2>&1
 	sleep 0.5
 
 	# CREATE_SUBFLOW6 from server to client machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
+	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 
 	# DESTROY_SUBFLOW6 from server to client machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
+	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
@@ -625,44 +605,39 @@ test_subflows()
 	listener_pid=$!
 
 	# ADD_ADDR from client to server machine using a new port
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id port $new4_port > /dev/null 2>&1
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET"\
+	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET"\
 			      "10.0.2.1" "10.0.2.2" "$new4_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 
 	# DESTROY_SUBFLOW from server to client machine
-	:>"$evts"
+	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
+	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
 	   "$client4_token" > /dev/null 2>&1
 
-	kill_wait $evts_pid
-
 	# Capture events on the network namespace running the client
-	:>"$evts"
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$evts" 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	:>"$client_evts"
 
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
@@ -675,24 +650,24 @@ test_subflows()
 	sleep 0.5
 
 	# CREATE_SUBFLOW from client to server machine
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET" "10.0.2.2"\
+	verify_subflow_events $client_evts $SUB_ESTABLISHED $client4_token $AF_INET "10.0.2.2"\
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 
 	# DESTROY_SUBFLOW from client to server machine
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
+	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
@@ -706,17 +681,17 @@ test_subflows()
 	listener_pid=$!
 
 	# ADD_ADDR6 from server to client machine reusing the subflow port
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id > /dev/null 2>&1
 	sleep 0.5
 
 	# CREATE_SUBFLOW6 from client to server machine
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
@@ -724,14 +699,14 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 
 	# DESTROY_SUBFLOW6 from client to server machine
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_CLOSED" "$client6_token" "$AF_INET6" "dead:beef:2::2"\
+	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR6 from server to client machine
@@ -745,38 +720,35 @@ test_subflows()
 	listener_pid=$!
 
 	# ADD_ADDR from server to client machine using a new port
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id port $new4_port > /dev/null 2>&1
 	sleep 0.5
 
 	# CREATE_SUBFLOW from client to server machine
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET"\
+	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET"\
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 
 	# DESTROY_SUBFLOW from client to server machine
-	:>"$evts"
+	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token" > /dev/null 2>&1
 	sleep 0.5
-	verify_subflow_events "$evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
+	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
 	   "$server4_token" > /dev/null 2>&1
-
-	kill_wait $evts_pid
-	rm -f "$evts"
 }
 
 test_prio()
-- 
2.35.3

