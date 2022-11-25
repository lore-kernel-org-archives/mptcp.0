Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090E33DC
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 13:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJG6JI8CUE80wjd2wm3SDVShEWGGW7Yd929f9jtQhldRyO81Kc+uGe3CMOTpOVpEVL7TD/nsCUnEvr3MmCHxMkmAY2nFbAW6/ODN7uJIYqB2NeALb+ynx3t54VCqDUm6I023mAXGWi9s7qKqPhxUu4ZkQ4Ip+RQv54mNnzHk/SBy8aGHWt0mzxWRjvp7OZPIoOejJKR9RjdXVrgQfHJhOqoQJJXxqpwZrVKFXZRzTk5wdn/FeAYN8Q6EFdT423yMd779lg8DqcPcgbJfuGJRidbcP21KSZF/YzNTQfz66cRsYD0GPjXrXcsOka49OecbLXfFaLhVnq/jKJmD3O1TGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IoAc9J0XeonFkR+rMnvYcpmdVacci0GsTEO4BLPmr0=;
 b=k3TNb4JCXb/PdxkEL3pcSCKOgjs6dTUPAVYp34jBRO9IJY3YvFcGBEbZHuQnumEn60Zob1cHSMLDiJG41Mkfhht7kBTYRleaKTfxxMlkhEtDirYvi4n+nGYB3WF52GFweYUPwZH0hPf8K+ARdNlOtEeSd31G5jnkiGv5UREplXVbx8L4Xhqil3IW5hRVu+ZUBmL2PVQ58xzjCTFZR+CoRhWlzQFvzdIHYEdsX1/Nx3Rwz6OIitQhcSVx40gxVFrLfbHM14lEzn6nkJk0o5Puj3wNw86kT0c0ySLWCZaOqdjqCUjcJAbw0uenDxAKeTml9itoqHrzrItVXz2bqagzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IoAc9J0XeonFkR+rMnvYcpmdVacci0GsTEO4BLPmr0=;
 b=gFpmecDzBQR1IMjxx+G+mA33htryaNCsvyLQEx40SYe+WA2PwQp4yCvGqbraLpUQmh8bKkDAZIJNlUgFhuuZT6EnmZqVXHldE09WUusTzbs+jKllxK+EtGEYiBQqCaNOQpP916RIQMX+svmeQ8jaTSCXbWuKJKQzUpar+QpJ+qoqhBy+ENElRD+SMIc4SmYeK4OjonSGd8wG/TYP9OC8ZsjboBo27c/4wcxtTf60uJjO8ivMeALfUpRlfCADGMAy5Yr+yq///Uw+utiYyBdDj3YA3Y5G7ENxDvfR7ouqSy8V0f9cCbyFiER9zO3N4EL/i+MEQX/H4aDxGe4oakPk0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Fri, 25 Nov
 2022 13:40:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 13:40:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v2 1/4] selftests: mptcp: make evts global in userspace_pm
Date: Fri, 25 Nov 2022 21:40:46 +0800
Message-Id: <7b755941b11aeb74e443e3178c07c143986a5227.1669383374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669383374.git.geliang.tang@suse.com>
References: <cover.1669383374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e52b58-49f3-470f-71e5-08daceea9b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G4CFgL/+uC76AJag3V6AfEcmQXoa72/7fUpPCXrumw7opI/z4ToeuJveXLmgVXZxYr9Hn1dcKhb8PLqFMJ6iKHBfy2WQPNsFqLwJYLlo2i6OZIaKGK37UTnz3FEKCUc7+ZlZcbX8vSvtCfaG4dZ/loQMrdCfU8TekNUQFw7zOwxeBxl7kPZykOLDbZ3gSVzUxo6WpdCDeirdQPdXNPER0B73XK4EFGHf4O0v5Vou6yprz2cBJAZlOuxe9swDTomS6H771yPqaEP7SvvNbDxAvjizeIcsDIrCJnFYescSPeqJDhgsf82v8Y5c2gNCMIj7JMFPiSYxTpzZjEmkyko5wVe63BH2yCm+Zwr3uGfd3/eQdYlnl15yKx7Ywtaueuy3N0ve1IBdPUu3KJnbhrm0zEelEVmovcPIjXaW/BppjTTwNkAPkk0xjkAr2BvMHBAfcHDp9ryJLVWUTOrTfLS4ltuwwZ7HiAYPTGf84yCJfgJwKS0wQe/KV/Rrmq4qJ/jyZnw2Y6NSlAcSXeIgGoT6PG1/qxnwc/9w/VwJCRuXZvFcp5iv7LKpnHx9kb5WPi2XOWo17LqSYkhvQbp2kOh8W1CTtUwRqVEUNNdR+4vPtlUd62Sz4qix0yS7Vtl6bu1fACn8ONC0kox4E+6Qy6zy6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(66946007)(66556008)(186003)(38100700002)(41300700001)(2616005)(66476007)(86362001)(44832011)(30864003)(5660300002)(4326008)(6666004)(8676002)(6486002)(6512007)(316002)(26005)(478600001)(6916009)(6506007)(36756003)(54906003)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eq3AuhrKoFgVP3u2bVaK1nM3THgZVnfo74moic3YjJ2zjkVrtDbROxnJXhpw?=
 =?us-ascii?Q?5WKkdzbEJe3cutBb7z2RZJ0qXGttcaNQxXF0AuABXL6dJcDNq0F5e1zY5xQp?=
 =?us-ascii?Q?1a7FTwN9COzvpVmc0r4Hi+eMnpAsZ6n6PRjN3FXIwTS9Ry9kJT6t9IPDXm4d?=
 =?us-ascii?Q?RRUE8R+oZGIWd5BXZqtlMpgKOwv3/wSyHW0734+P2O1Dd3mLs1B7HSPIyfUM?=
 =?us-ascii?Q?FVU/B26/UFqbu8AtKPVvbsvUHHQM+J4AU8MhbmjABvN35ugUcjsyKmq7Qq1z?=
 =?us-ascii?Q?gFFADseBfJQN1ESqhJwFWC6hgiyRZYDLbDuryQeIc2f7kf/wy6emd/p5KiYK?=
 =?us-ascii?Q?p+cC8/Y3vwoQN7OseB91hnEIX0sIgmyfqQNCbYTnhHOKRu0le5q4TUOKHJNk?=
 =?us-ascii?Q?D6IN6AQCLRt5YjZ4cn1lj9Bv4MAsOxSJwqI+h1niriUSn+C3L+2kaoFsJJwG?=
 =?us-ascii?Q?jPvUn2VAICY2EC86hv18dbT+3k0vJGJ8Ji3Q6AW62l9PEAfpqhTxx4Meu3+B?=
 =?us-ascii?Q?G1OxwYru0XR1NC7PgXKKquxQRicJJzzvBJGLvYdh+iO4gm+1niFQzkXy4eaq?=
 =?us-ascii?Q?E1sqd5VVQzbwZ3MInyDfuoz2trmgcGGv9q7cQ6tUkE1DUsheU4LQEY9XO6aa?=
 =?us-ascii?Q?WohCjUnupW6idCLNmlv8G1tb+4FqeoH7LZQIhDwFKXB+4dmwEm5a3NdAktRd?=
 =?us-ascii?Q?Tjq+bAq4BUnO0mdsUsBSGYZGWleO5oTG/9N754rvZdsqg9vAEKjUFEQrleAy?=
 =?us-ascii?Q?nAzADLfCcn9TYxkeBBvwmMKs8C8LZS6aAwUXVz3XL/KoUUhQbiGzJitPhhSe?=
 =?us-ascii?Q?dJT4j3eoT1EZbm8XvYRv7QYOwF1k9GA7BqriAs3KBupPo0d/MFzzVnsJS0/J?=
 =?us-ascii?Q?rkdI3ff7+wBVVwPUV0N9Eg3EBPZlLCCInng1OkWvcMZ8iKOVxWPMPVGgN2xg?=
 =?us-ascii?Q?B8Smlw5Skkn+peZucfRXujpWc2RELvQkEEZ0jq8QAlR2kYAGRrp3KKn6FLT2?=
 =?us-ascii?Q?dn6Fc4zrmcuzfVUG5ikQSWR2TWwSkGqylUjAAdzWzAUUuXMtOaRCeNHhHJfA?=
 =?us-ascii?Q?tnvCHFpoRE2z4bP9OdSnJ7L6/h+hVYOlgypBgUcTrmg8pXM28BcTMlbWwFDG?=
 =?us-ascii?Q?64QjlnMcs1Dje2Qa7W/DMnwJPiTOBWBe6mUEURxTd42k4a0y9PQHAJHM3hHo?=
 =?us-ascii?Q?CCzr1ucfbXAb0OFjThUGKnwZ++ZNxQveodpNcG5gk6oiM1GK3tWFdlWPpUzX?=
 =?us-ascii?Q?TJs9MHheth6hdhP77Ujuo+ApUnG11EAwgvQghLWK1qnD+onrZsKfBxLXUqFC?=
 =?us-ascii?Q?dNXUywx/2yeIL0UmeVxOJIVo/CV9ZbxreoTVzC7hOz8f4jXYxrHwgKKRvVjr?=
 =?us-ascii?Q?XzYSfC70jsosFGCZDsPMagQH3P1IJE49+N569j4S/BNvTmUnFg/t3ovfrDu+?=
 =?us-ascii?Q?xFAGn6lCtYovSHJZ6IWH/7wdbp0s3j0dixaXW6T6VneA+3xtTqbpP+Kk8c1U?=
 =?us-ascii?Q?w6XwQ0tesQfi1v6k0kHxv8vAO655neJzduS6f68sFMW97Rjbe6H+UQsWi7sb?=
 =?us-ascii?Q?3chqJGSdOWuxqNst0NKB5TmfUa+TstYjJ+d5gHQmy6ir8VKguOZwDLmzrSvI?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e52b58-49f3-470f-71e5-08daceea9b74
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 13:40:25.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRYTYXg+r9eTrvTNyBpkDD0Jr5ZyuStB+TNkfOvF5gA4Eew8hOpETNov8yScqs0l0q2kuU5OymLB6AZjt7AkWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

This patch makes server_evts and client_evts global in userspace_pm.sh,
then these two variables could be used in test_announce(), test_remove()
and test_subflows(). The local variable 'evts' in these three functions
then could be dropped.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 209 ++++++++----------
 1 file changed, 90 insertions(+), 119 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 40801279ebdf..a1b7592621b7 100755
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
@@ -134,18 +140,25 @@ make_connection()
 
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
-
 	# Run the server
 	ip netns exec "$ns1" \
 	   ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr > /dev/null 2>&1 &
@@ -161,7 +174,6 @@ make_connection()
 	sleep 1
 
 	# Capture client/server attributes from MPTCP connection netlink events
-	kill_wait $client_evts_pid
 
 	local client_token
 	local client_port
@@ -173,12 +185,11 @@ make_connection()
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
@@ -242,13 +253,8 @@ verify_announce_event()
 
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
@@ -256,7 +262,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 > /dev/null 2>&1
 
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	stdbuf -o0 -e0 printf "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    \t\t"
 	if [ "$type" = "" ]
 	then
@@ -267,71 +273,63 @@ test_announce()
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
@@ -359,14 +357,8 @@ verify_remove_event()
 
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
@@ -375,7 +367,7 @@ test_remove()
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid token                    \t"\
 	       $client_addr_id
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
@@ -389,7 +381,7 @@ test_remove()
 	   $invalid_id > /dev/null 2>&1
 	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid id                    \t"\
 	       $invalid_id
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
+	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
@@ -398,40 +390,35 @@ test_remove()
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
@@ -439,27 +426,24 @@ test_remove()
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
@@ -535,13 +519,8 @@ verify_subflow_events()
 
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
@@ -554,25 +533,25 @@ test_subflows()
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
@@ -586,31 +565,31 @@ test_subflows()
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
 
@@ -625,44 +604,39 @@ test_subflows()
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
@@ -675,24 +649,24 @@ test_subflows()
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
@@ -706,17 +680,17 @@ test_subflows()
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
@@ -724,14 +698,14 @@ test_subflows()
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
@@ -745,38 +719,35 @@ test_subflows()
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

