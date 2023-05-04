Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A997A2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqEJIctTRDHkMm3haZKy+0M+JGF+QCQnCqi0y2q6Ra43IRHz/DYl/WesmGvnHUOWpU9fFan4XQ3qeGza5JjMDmFychcdbmlwOZrKMdclgM+aMWt9i1Py4KsKA63vjIl+iGMl3rMOW+1y9gzBRpHAN3Y+HQzflpylKXf7YIC4WDJLAiUIVnoInbCi09KfcOypXto+/ZTqB+3Rht9KxTSgfeiXG3GnMCO8yWphgNDCKGbHb+6xJFc9jsAfV3LbO54XSTTBt4M5KunSffTBYRJUzWqRAOInU+GYgdw4z8SuqRlioS2wBO4TdVox4VpLZOgEnAfMB07UViy1NPf5ogFdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+6948g/ZaOjwuw/KLl+oT9PoPEqrqfwBBDy6co42XI=;
 b=Byz+x1yOpVz+R3LdFhr2K5+1Di31JL11Xf7NO+bDX8MeEijROXoPlD7NtGyMwN4QbWJDJZgniHwGQrICSp2Q52OJOqze0+FbSiECFOMLyBPDM20LbTXogortbtCNpgaKUjtsYthk9rZmDkXMpYJQwl0ujPDzqmtJJthG1UC/cym2zgI666JKbxd0RvgEVkoOj0SxWCHjnsi5qoobSh7uKI386yJY9U5K2SwEv/rXyxyUZzivr9EWhohvhOOZYVFJN/r0AFaynJd8sUOtUQO/+IVUQXhZPAYdkn2PVbqrMnWjqmj+/JGhnkuVq2zyyzcug8SPgkBAMkE2HoWYscldQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+6948g/ZaOjwuw/KLl+oT9PoPEqrqfwBBDy6co42XI=;
 b=zjeWiZY1/8kvUa7Vne4mXHEQBf7TcBbglBRiXN+BDlvB7j1NiENHS1BpCJvUuzZxFf0ilHFU0BplrWm8wVxGnLpICLEeouUIFQKcFFs8tBbFjFLj4fVbfln7pqqvdRVpk4EB6vChGVAduUKMEBBckHZdOgXeQiBSoMziVWVe1EsYP7lwHZ9B8GJEe7xEdEqdVzAcfKH92mvgoSH3dFouazQO/4dvKvDoglEjaFG1VyKjwYai2r1rF3Me+iRwhXGcuagVXHbckqD8lwnt/7PQyMX2fAcH7nQjru5T8Ig6WGBaCzii90w9zGg8rHG91kAuZDaPT/oD5HOZ/6ACE9JLTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:21:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:21:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 12/12] selftests: mptcp: do endpoint manipulation out of transfer
Date: Thu,  4 May 2023 18:20:17 +0800
Message-Id: <2be8d0226ca5ac72b1801eb128fa9028d4886b46.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea7fd97-9b30-40ba-0880-08db4c895967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7iUQxrZu6DN2ki7MGjYQaVp3RsbZ0Iu8J1wDzLsO1YEy6zdsyOAE7LdczdN1T1lfb7MACnYNaz4nk86fidAkzaAObBYpXsm561zMbJ8rcrvV8rHvpAyGp0rzbXXJJQDBLsmb3eXNvdhUGoYS1CBLJbect7q833TJpQ3GYox1A7YZ1Cym7F3x0YnlzzjbBgOOxP8ZTYep6XC6fgX8H0P+5bSlLzXC5AUQhrTS19pa9lqvelTCXWw3pvtl7lUAxXElLZ5iOPCx707Q9EoX4K2Hy6WZD/XpHwSwMXJ9AYbey3lRjM+BxEdHdF16kLipGZMfEDTjpEmFK34gs6Yv6q7gyXpSMK66YYIgTXFqTB1fczKRuW29NZuh9mCphTA1T9u/hjGVlCkGh5Q7xCRgYhVzrhOqzjmmrA0k0jk10s5Te3VEvM1RgzAt55YczBKID0XA4nTUrFAXppuBxRlx6aOHcME8EKU3m8t9lQ2Eh5GKFnTlxbNSPFsSmuT8w+swtu4gvhcVY6rRf/loPH+H0PnhXl1j8XiIKUWxHjSOceS15TKO8OVgs6Po7RR7+y5+SzDQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(6666004)(38100700002)(478600001)(86362001)(107886003)(83380400001)(26005)(186003)(6506007)(6512007)(2616005)(36756003)(6486002)(5660300002)(41300700001)(8936002)(8676002)(44832011)(30864003)(2906002)(66556008)(316002)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MxUvuawvyDVSGeWMAvsm3T/LMkIHKTUM3xHfzApnr5HVbjTIUxyb9TrqnnQQ?=
 =?us-ascii?Q?peu6Dz71tgY1MtyBbpI4AVSa7km8DTWjX9XJLI9JW6dC/yB6Nb7LFrOGx6sB?=
 =?us-ascii?Q?VwGpgNyrJctDbu7Ot5erizPXgx7bjF5WN8G+pD1lSfw3+BPmI7aRWv69jLia?=
 =?us-ascii?Q?1GIBY0bjo/4v2VXKoeB0ZqX/4ivLMnUSkqAVnFVKt7rMo7JppL+AzzbebICy?=
 =?us-ascii?Q?0V6dH1L5LPHAuKN3x+E3aCwZrN7HOoY5cP70x7R1XoVnP4P5lbL2ZGFtX+MG?=
 =?us-ascii?Q?y/w2G3Yd4A0ylIKpDD6ogQ50oSwLlmN58qFJ3eDzSKqMxdvB46W0fLatd5it?=
 =?us-ascii?Q?WeYDCMh2KMkgLjLOGjW56nSBeOqJhN+pco6Gl1EJDpcWGj8iHsq19xZUKNbU?=
 =?us-ascii?Q?M2embVf99DPk08DghEhIsLK3pnE9iFFkEMQ6ju4vC/1m8yuePvOLICsm1ANE?=
 =?us-ascii?Q?w9YzC3TME07HJBU28B3p08pGzNRjmpbjPt1cdeAtUqd9BNZ0qW4DfrZl3C0N?=
 =?us-ascii?Q?I9TUrPO41k/DhpQ7mipdTSDf4hiHXa06syVUNSXBJEJGpbUdoC4A8OzpWNvd?=
 =?us-ascii?Q?tlufU8trEF29NVoF+s++8ujo0NYOHuDR2Eo3gFhsXP20mS0+aJVCRUcdCPCm?=
 =?us-ascii?Q?9fArs3ddcyGCz4QU9itcjewpH6NGiL2hBT41uBXGOnbTUmccJ7Relp1XkmHu?=
 =?us-ascii?Q?8hgBmbN7BZjLZQcg1WEOxwlSrUP7Rp3NIeEnPohExWDDayB6wNmQRweHSptR?=
 =?us-ascii?Q?KPaD+YCs5Eo0azfnvUt4x/LMpZpZW58L3QWWTar6ZqUYo/tN57P3uzst6seb?=
 =?us-ascii?Q?jk2be2gaNyHeZ17CZqqvaKdSMPXypiDVpYninmhQ6bIhpYIdtwwsuFS8KZEl?=
 =?us-ascii?Q?8HdO7ClBIrlw2sKvPELhYVBo+zLi0D7412vNiWqe8gp3xXeYXrVw28fePXr7?=
 =?us-ascii?Q?/YA6vsHqBKZ0R3tEp80fgWu7++oxGymUFC82GJyVUPK8ko56904ArfpglIom?=
 =?us-ascii?Q?fmsqOi49CYVxLZc4624Ob6qT0CLUgAaEpFMwE+3/Jd5m7kqXBYgIs9CJUeUN?=
 =?us-ascii?Q?w0EdxL99xiGK8sbotaFOFn31tquOWL9ldSl3ZYt0i2V8eEDyhpphS8pkhL/p?=
 =?us-ascii?Q?IvAvZIICIelO/OrlAPed61s26kzWRD+oNiJT+AQWxT/4MJCZX8+T8/0w1Nqz?=
 =?us-ascii?Q?SSv8ks04x3Wjo9Itps19eYlsDrvOh+RnWT3+MG8TG6gEV2L/4JnURBLizp/g?=
 =?us-ascii?Q?5HTW3hKXkCm4oTBfXVpoOCzchyCWSBhobSM64aidYbLT/4u2J6wg+VfGbgBf?=
 =?us-ascii?Q?+tqYF8m68G8V7ic10PxeBtT5qZoBKOrqE+XCdmnumgjrGD+RaW0aiGzgOy8l?=
 =?us-ascii?Q?q+irRgZkbxJfuu/Jsb4JtxX5STRiWKtpoz4yGEMgNId//73xC6u11iPKs5ka?=
 =?us-ascii?Q?nPRCBoOwpxuQdBSOJ3yoPB+3Fi9U+szTSxJgIWaTnVacgQiHLlDfX+zc2WCF?=
 =?us-ascii?Q?BzeE6pWFmpCId/PBwGfquoUFRFBCoMnPdg3rbM4Fgoj7MqOTjXpZlwf5wjgx?=
 =?us-ascii?Q?iOy28nDWMzdYadckW/wLi3nZGAkz6l2dV3VtXb4y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea7fd97-9b30-40ba-0880-08db4c895967
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:21:40.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdFdbXInoPCYJl1GYmtujT2Y65Gchw9Y4nriCxlJKY1sEVfX0PjdZXbin68vekkPxvLxXHFssYM3CcTP1pN5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345

This patch moves endpoint manipulation out of do_transfer() into a new
function endpoint_manipulation(), then addr_nr_ns1 and addr_nr_ns2
arguments can be removed.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 518 ++++++++++--------
 1 file changed, 302 insertions(+), 216 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0dcb0470b076..8fbc9071688b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -716,10 +716,8 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 	local test_link_fail="$6"
-	local addr_nr_ns1="$7"
-	local addr_nr_ns2="$8"
-	local speed="$9"
-	local sflags="${10}"
+	local speed="$7"
+	local sflags="${8}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -759,7 +757,6 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
@@ -785,11 +782,6 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		sflags=0
-	fi
-	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
@@ -830,145 +822,6 @@ do_transfer()
 	fi
 	local cpid=$!
 
-	# let the mptcp subflow be established in background before
-	# do endpoint manipulation
-	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
-		sleep 1
-	fi
-
-	if [ $addr_nr_ns1 -gt 0 ]; then
-		local counter=2
-		local add_nr_ns1=${addr_nr_ns1}
-		local id=10
-		while [ $add_nr_ns1 -gt 0 ]; do
-			local addr
-			if is_v6 "${connect_addr}"; then
-				addr="dead:beef:$counter::1"
-			else
-				addr="10.0.$counter.1"
-			fi
-			pm_nl_add_endpoint $ns1 $addr flags signal
-			counter=$((counter + 1))
-			add_nr_ns1=$((add_nr_ns1 - 1))
-			id=$((id + 1))
-		done
-	elif [ $addr_nr_ns1 -lt 0 ]; then
-		local rm_nr_ns1=$((-addr_nr_ns1))
-		if [ $rm_nr_ns1 -lt 8 ]; then
-			local counter=0
-			local line
-			pm_nl_show_endpoints ${listener_ns} | while read -r line; do
-				# shellcheck disable=SC2206 # we do want to split per word
-				local arr=($line)
-				local nr=0
-
-				local i
-				for i in "${arr[@]}"; do
-					if [ $i = "id" ]; then
-						if [ $counter -eq $rm_nr_ns1 ]; then
-							break
-						fi
-						id=${arr[$nr+1]}
-						rm_addr=$(rm_addr_count ${connector_ns})
-						pm_nl_del_endpoint ${listener_ns} $id
-						wait_rm_addr ${connector_ns} ${rm_addr}
-						counter=$((counter + 1))
-					fi
-					nr=$((nr + 1))
-				done
-			done
-		elif [ $rm_nr_ns1 -eq 8 ]; then
-			pm_nl_flush_endpoint ${listener_ns}
-		elif [ $rm_nr_ns1 -eq 9 ]; then
-			pm_nl_del_endpoint ${listener_ns} 0 ${connect_addr}
-		fi
-	fi
-
-	# if newly added endpoints must be deleted, give the background msk
-	# some time to created them
-	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
-
-	if [ $addr_nr_ns2 -gt 0 ]; then
-		local add_nr_ns2=${addr_nr_ns2}
-		local counter=3
-		local id=20
-		while [ $add_nr_ns2 -gt 0 ]; do
-			local addr
-			if is_v6 "${connect_addr}"; then
-				addr="dead:beef:$counter::2"
-			else
-				addr="10.0.$counter.2"
-			fi
-			pm_nl_add_endpoint $ns2 $addr flags $flags
-			counter=$((counter + 1))
-			add_nr_ns2=$((add_nr_ns2 - 1))
-			id=$((id + 1))
-		done
-	elif [ $addr_nr_ns2 -lt 0 ]; then
-		local rm_nr_ns2=$((-addr_nr_ns2))
-		if [ $rm_nr_ns2 -lt 8 ]; then
-			local counter=0
-			local line
-			pm_nl_show_endpoints ${connector_ns} | while read -r line; do
-				# shellcheck disable=SC2206 # we do want to split per word
-				local arr=($line)
-				local nr=0
-
-				local i
-				for i in "${arr[@]}"; do
-					if [ $i = "id" ]; then
-						if [ $counter -eq $rm_nr_ns2 ]; then
-							break
-						fi
-						local id rm_addr
-						# rm_addr are serialized, allow the previous one to
-						# complete
-						id=${arr[$nr+1]}
-						rm_addr=$(rm_addr_count ${listener_ns})
-						pm_nl_del_endpoint ${connector_ns} $id
-						wait_rm_addr ${listener_ns} ${rm_addr}
-						counter=$((counter + 1))
-					fi
-					nr=$((nr + 1))
-				done
-			done
-		elif [ $rm_nr_ns2 -eq 8 ]; then
-			pm_nl_flush_endpoint ${connector_ns}
-		elif [ $rm_nr_ns2 -eq 9 ]; then
-			local addr
-			if is_v6 "${connect_addr}"; then
-				addr="dead:beef:1::2"
-			else
-				addr="10.0.1.2"
-			fi
-			pm_nl_del_endpoint ${connector_ns} 0 $addr
-		fi
-	fi
-
-	if [ -n "${sflags}" ]; then
-		sleep 1
-
-		local netns
-		for netns in "$ns1" "$ns2"; do
-			local line
-			pm_nl_show_endpoints $netns | while read -r line; do
-				# shellcheck disable=SC2206 # we do want to split per word
-				local arr=($line)
-				local nr=0
-				local id
-
-				local i
-				for i in "${arr[@]}"; do
-					if [ $i = "id" ]; then
-						id=${arr[$nr+1]}
-					fi
-					nr=$((nr + 1))
-				done
-				pm_nl_change_endpoint $netns $id $sflags
-			done
-		done
-	fi
-
 	wait $cpid
 	local retc=$?
 	wait $spid
@@ -1038,10 +891,8 @@ run_tests()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local test_linkfail="${4:-0}"
-	local addr_nr_ns1="${5:-0}"
-	local addr_nr_ns2="${6:-0}"
-	local speed="${7:-fast}"
-	local sflags="${8:-""}"
+	local speed="${5:-fast}"
+	local sflags="${6:-""}"
 
 	local size
 
@@ -1086,7 +937,7 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${test_linkfail} ${speed} ${sflags}
 }
 
 dump_stats()
@@ -1796,6 +1647,159 @@ set_userspace_pm()
 	ip netns exec $ns sysctl -q net.mptcp.pm_type=1
 }
 
+endpoint_manipulation()
+{
+	local connect_addr="$1"
+	local addr_nr_ns1="$2"
+	local addr_nr_ns2="${3:-0}"
+	local sflags="${4:-""}"
+
+	local flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
+	# let the mptcp subflow be established in background before
+	# do endpoint manipulation
+	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
+		sleep 1
+	fi
+
+	if [ $addr_nr_ns1 -gt 0 ]; then
+		local counter=2
+		local add_nr_ns1=${addr_nr_ns1}
+		local id=10
+		while [ $add_nr_ns1 -gt 0 ]; do
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:$counter::1"
+			else
+				addr="10.0.$counter.1"
+			fi
+			pm_nl_add_endpoint $ns1 $addr flags signal
+			counter=$((counter + 1))
+			add_nr_ns1=$((add_nr_ns1 - 1))
+			id=$((id + 1))
+		done
+	elif [ $addr_nr_ns1 -lt 0 ]; then
+		local rm_nr_ns1=$((-addr_nr_ns1))
+		if [ $rm_nr_ns1 -lt 8 ]; then
+			local counter=0
+			local line
+			pm_nl_show_endpoints $ns1 | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
+				local arr=($line)
+				local nr=0
+
+				local i
+				for i in "${arr[@]}"; do
+					if [ $i = "id" ]; then
+						if [ $counter -eq $rm_nr_ns1 ]; then
+							break
+						fi
+						id=${arr[$nr+1]}
+						rm_addr=$(rm_addr_count $ns2)
+						pm_nl_del_endpoint $ns1 $id
+						wait_rm_addr $ns2 ${rm_addr}
+						counter=$((counter + 1))
+					fi
+					nr=$((nr + 1))
+				done
+			done
+		elif [ $rm_nr_ns1 -eq 8 ]; then
+			pm_nl_flush_endpoint $ns1
+		elif [ $rm_nr_ns1 -eq 9 ]; then
+			pm_nl_del_endpoint $ns1 0 ${connect_addr}
+		fi
+	fi
+
+	# if newly added endpoints must be deleted, give the background msk
+	# some time to created them
+	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
+
+	if [ $addr_nr_ns2 -gt 0 ]; then
+		local add_nr_ns2=${addr_nr_ns2}
+		local counter=3
+		local id=20
+		while [ $add_nr_ns2 -gt 0 ]; do
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:$counter::2"
+			else
+				addr="10.0.$counter.2"
+			fi
+			pm_nl_add_endpoint $ns2 $addr flags $flags
+			counter=$((counter + 1))
+			add_nr_ns2=$((add_nr_ns2 - 1))
+			id=$((id + 1))
+		done
+	elif [ $addr_nr_ns2 -lt 0 ]; then
+		local rm_nr_ns2=$((-addr_nr_ns2))
+		if [ $rm_nr_ns2 -lt 8 ]; then
+			local counter=0
+			local line
+			pm_nl_show_endpoints $ns2 | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
+				local arr=($line)
+				local nr=0
+
+				local i
+				for i in "${arr[@]}"; do
+					if [ $i = "id" ]; then
+						if [ $counter -eq $rm_nr_ns2 ]; then
+							break
+						fi
+						local id rm_addr
+						# rm_addr are serialized, allow the previous one to
+						# complete
+						id=${arr[$nr+1]}
+						rm_addr=$(rm_addr_count $ns1)
+						pm_nl_del_endpoint $ns2 $id
+						wait_rm_addr $ns1 ${rm_addr}
+						counter=$((counter + 1))
+					fi
+					nr=$((nr + 1))
+				done
+			done
+		elif [ $rm_nr_ns2 -eq 8 ]; then
+			pm_nl_flush_endpoint $ns2
+		elif [ $rm_nr_ns2 -eq 9 ]; then
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:1::2"
+			else
+				addr="10.0.1.2"
+			fi
+			pm_nl_del_endpoint $ns2 0 $addr
+		fi
+	fi
+
+	if [ -n "${sflags}" ]; then
+		sleep 1
+
+		local netns
+		for netns in "$ns1" "$ns2"; do
+			local line
+			pm_nl_show_endpoints $netns | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
+				local arr=($line)
+				local nr=0
+				local id
+
+				local i
+				for i in "${arr[@]}"; do
+					if [ $i = "id" ]; then
+						id=${arr[$nr+1]}
+					fi
+					nr=$((nr + 1))
+				done
+				pm_nl_change_endpoint $netns $id $sflags
+			done
+		done
+	fi
+}
+
 subflows_tests()
 {
 	if reset "no JOIN"; then
@@ -1868,7 +1872,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -1879,7 +1883,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -1890,7 +1894,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 DROP
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -1902,7 +1906,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2001,7 +2005,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 3 3 3
 
 		# the server will not signal the address terminating
@@ -2102,7 +2106,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2113,7 +2117,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2124,7 +2128,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2135,7 +2139,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2148,10 +2152,12 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -1
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# multiple subflows, remove
@@ -2160,9 +2166,11 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -2
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		kill_tests_wait
 	fi
 
 	# single address, remove
@@ -2170,10 +2178,12 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		kill_tests_wait
 	fi
 
 	# subflow and signal, remove
@@ -2182,10 +2192,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# subflows and signal, remove
@@ -2195,10 +2207,12 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1 -2
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		kill_tests_wait
 	fi
 
 	# addresses remove
@@ -2208,10 +2222,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -3
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		kill_tests_wait
 	fi
 
 	# invalid addresses remove
@@ -2221,10 +2237,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -3
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		kill_tests_wait
 	fi
 
 	# subflows and signal, flush
@@ -2234,10 +2252,12 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		kill_tests_wait
 	fi
 
 	# subflows flush
@@ -2247,10 +2267,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_rm_tx_nr 0
 		chk_rm_nr 0 3 simult
+		kill_tests_wait
 	fi
 
 	# addresses flush
@@ -2260,10 +2282,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		kill_tests_wait
 	fi
 
 	# invalid addresses flush
@@ -2273,10 +2297,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -8
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		kill_tests_wait
 	fi
 
 	# remove id 0 subflow
@@ -2284,9 +2310,11 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -9
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# remove id 0 address
@@ -2294,10 +2322,12 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -9
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		kill_tests_wait
 	fi
 }
 
@@ -2307,42 +2337,53 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 1
 		chk_join_nr 1 1 1
+		kill_tests_wait
 	fi
 
 	# add signal address
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# add multiple subflows
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 2
 		chk_join_nr 2 2 2
+		kill_tests_wait
 	fi
 
 	# add multiple subflows IPv6
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		wait_mpj $ns2
+		endpoint_manipulation dead:beef:1::1 0 2
 		chk_join_nr 2 2 2
+		kill_tests_wait
 	fi
 
 	# add multiple addresses IPv6
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 2
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
+		kill_tests_wait
 	fi
 }
 
@@ -2353,14 +2394,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2370,7 +2411,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2380,10 +2421,12 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		kill_tests_wait
 	fi
 
 	# subflow and signal IPv6, remove
@@ -2392,10 +2435,12 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 }
 
@@ -2492,7 +2537,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2501,7 +2546,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2511,7 +2556,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2522,8 +2567,11 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 0 fullmesh_1
+		wait_mpj $ns1
 		chk_join_nr 4 4 4
+		kill_tests_wait
 	fi
 }
 
@@ -2534,9 +2582,11 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
+		kill_tests_wait
 	fi
 
 	# single address, backup
@@ -2544,10 +2594,12 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
+		kill_tests_wait
 	fi
 
 	# single address with port, backup
@@ -2555,15 +2607,17 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
+		kill_tests_wait
 	fi
 
 	if reset "mpc backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2571,24 +2625,28 @@ backup_tests()
 	if reset "mpc backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
 
 	if reset "mpc switch to backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
+		kill_tests_wait
 	fi
 
 	if reset "mpc switch to backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
+		kill_tests_wait
 	fi
 }
 
@@ -2672,7 +2730,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2680,6 +2739,7 @@ add_addr_ports_tests()
 		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
 		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
 		kill_events_pids
+		kill_tests_wait
 	fi
 
 	# subflow and signal with port, remove
@@ -2688,10 +2748,12 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# subflows and signal with port, flush
@@ -2701,10 +2763,12 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -8 -2
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		kill_tests_wait
 	fi
 
 	# multiple addresses with port
@@ -2903,9 +2967,11 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# fullmesh 2
@@ -2915,9 +2981,11 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 fullmesh_1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# fullmesh 3
@@ -2927,9 +2995,11 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 fullmesh_2
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# fullmesh 4
@@ -2940,9 +3010,11 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 fullmesh_2
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# set fullmesh flag
@@ -2950,9 +3022,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 1 fullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 
 	# set nofullmesh flag
@@ -2960,9 +3035,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 fullmesh_1 nofullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 
 	# set backup,fullmesh flags
@@ -2970,10 +3048,13 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 1 backup,fullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 
 	# set nobackup,nofullmesh flags
@@ -2981,24 +3062,27 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 nobackup,nofullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 }
 
 fastclose_tests()
 {
 	if reset "fastclose test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset "fastclose server test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3082,7 +3166,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3094,9 +3178,11 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -1
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
+		kill_tests_wait
 	fi
 
 	# userspace pm add & remove address
@@ -3106,7 +3192,7 @@ userspace_tests()
 		local tk sp da dp
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 		wait_mpj $ns1
 		tk=$(grep "type:1," "$evts_ns1" |
 		     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
@@ -3139,7 +3225,7 @@ userspace_tests()
 		local tk da dp sp
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 		wait_mpj $ns2
 		tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 		da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
@@ -3169,7 +3255,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3197,7 +3283,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

