Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBC7B
	for <mptcp@lists.linux.dev>; Sat, 12 Nov 2022 09:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIB7ypw6CrV41MRSz08oZab2HiQeG/2h1+8PtWATGsVS8rfz95RHfOLtLrDEUp/lmEqI8S0YrcbXVEHLf80MmIwHUavNdtGxbSIdLoYvYwDehUaGclZYaOZuF7ikIRzVsQ3z07pYSeeJJR2MRGAuIvBmxVkMLpH2L16JI4p1Ci1E/ki0bTZMOU77HwA6mx/s/JjvQwL9Pj1Idsy7EfzXH7OOC5+PEQdfT0mR77//DUSxtJ5yTS8VQaEjzM01Q2zlWKW+1JFKuckdPrLj0uujVXWXrJKoSY61xIZSCR+bmAY3PONDufAyqdK0vKc3Bk/WdWr2HDeCVjsAbzWjGeik3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHDC8D9qVLSxBc6uxb7Cisk1acma8iswRm5Zcnet76A=;
 b=HqjtodkzPwCDcj9Qv0LZ9BzS30QvdkZs2uk/nyGSArQnzHXwoJqhAHQTmmaGRqnO+bX7eolbAZjid8v4D8TL0aqpREBla7LPsjcWtc0RGodxO/wlnZzf7AgfAVlkv3gwmXyH5VU8Alomc1i6IF0VZnepd/JVVz5Y0Bxpnt6O//YU+7iam7Tx+jZcqxGLbX2vcRfHeYrekoekhA/+xWXXxKKHuy/9peOpZLtVyo6WAxMn9kdx5pn9XivIVPLr20i+QfR1WtWN1CuHbGP5AriRWLqJ4oa1g2v5Ro8nZiTgpyG7o9kzPcMaPnh2eLJdJoeE8lkK9Ig0/u+6vQBhdHZdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHDC8D9qVLSxBc6uxb7Cisk1acma8iswRm5Zcnet76A=;
 b=LuoI9nDW5LfEoMhwDk6dbSj3cJ+VpfTrZ1fgFqMjunEDd9YllMM3IKi2B2m63pe1YHAxoxn73/i+BpNaawSFwf7KfqzH+dVbqdGIQjyeXrVsVIgbqGayIl9Od6bPcEqwdxZ0BlEHrcHKuDrpw+PPB7GLLM052R5ycp34vUKlCmshdYAuewdbX47zmxV9ddMaIIRyw+zA7he+bkYedCC8NQ7eJvhN/Rdsd2BpeAHI/9g4MP8DEgY92RqORrWNACkwptvDoNB1o6lSuZxQ8ecnywqwgBCPuC7L8fSzf2l5TAqqPdOdxzC51FmIxerpfpokScGALyRO2YC3rO3tiJttyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 09:29:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Sat, 12 Nov 2022
 09:29:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: add pm_listener tests
Date: Sat, 12 Nov 2022 17:28:55 +0800
Message-Id: <29d4d7aae141c18b3c77873771e0812b6fd73471.1668245254.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668245254.git.geliang.tang@suse.com>
References: <cover.1668245254.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: c981a096-db69-481f-ddcd-08dac49056ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	75G/xb9QC8LzZ28Sw2DXZ/wALBimOy02HKLV2yil3HrC9alf8mLiQ0NAZpktINCCmhvtn1MH7+Ba4HnElRJLP5MN93CkPDFe66Xj557zZqW5V5GVbWWMFamCixVWscA4Y2UgstD4HUFqIV68sWVJu+UO0GfXyiLZhf5UgV6KcfbpV2NFJoNJkUn5DjkIbLo8mrPzFq1bwEp1OMBn8WFOkPw8e79jxNuBmciRNX7f8yAQRQWXtf6C2RHpDLmG6dh19pEg1a4LKLetwH1YN1SUDLwDvJPqmmAPN8McO67P2xyLXXIaGZfD87oj/mGbimEIbY8+Qg8NeCx5+VuHkBDVpbS0kKOxriLHSbuJwK7mKRL+6bEQI0nHVISeshyUt/AyQQfNpjU+T6/12XdcJawcP8bkQSQriBcXFJ9Jh73GVUHL3JI3l6PMZ4aYvWima2KnNUrOQd8gK5ibQ+cQHdYDQXhlTDhtekrP4g2lQHeaWUlSqHptOda+QjYZoo4pY/ExZoYKJonDQ1xxV2jvNhdxbvoK6m3oPw+cY6UWDiLjM43LlzlYp+H7oHeAe/5L535ZkHqoI+8CG8YVbyIIqF48rRsrEgTN/clvD6edHbUJIShzG+K9ELo3oq2fi7LzujoGBYSOYMUqYcjmaxR6d6y7TEg9tHrdkCxsHvyMlc3lbFs7QyoljuSMmLagRTlOdCbvpDf6a+SHDa3xkiqt4t8ywQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(36756003)(26005)(6512007)(38100700002)(83380400001)(186003)(44832011)(6506007)(2616005)(2906002)(66946007)(41300700001)(5660300002)(8676002)(86362001)(66556008)(6486002)(4326008)(478600001)(66476007)(8936002)(316002)(107886003)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ehiiqct/w9c3+X19uGR8AsA4zF8cm3Ta9gMf1uEPJoF5Fce6pgWfft4UvKxu?=
 =?us-ascii?Q?ThPlwZHPFL23TjyoAKLwM91CvfzIUNkV6yV+JKhutTeoILPTTxcrUfXBUWDf?=
 =?us-ascii?Q?oDjX1X7MHstHyUymHpamFjxHNl+yw9l5A0NEfHdzJHoiqm6F/+P62uXwr5m2?=
 =?us-ascii?Q?7CjWf0XDsjnQdq7XWLyTn+U43TeWhTEwtp4e8ydPdSltbL5BNTLucfvndCFs?=
 =?us-ascii?Q?dzT10jfa6pxw6pU4cjIqPq8ppCjZWp5Px1qMhA4+ioHEJFAuno/bUZ2Yi10o?=
 =?us-ascii?Q?Hr9to7hhIPqog+p5z45ywHXaEh5CLgtJKPHELYhwxbLXJEkdTX0yAcPk4gtX?=
 =?us-ascii?Q?SRh7rAQT8o1OKLgeuqm6myuuO8PyzMZhkwuvUz0vqywbWtkNn5DLXbqj8B/w?=
 =?us-ascii?Q?gKihLVR/5wqDtRwASCvYJucMHAkuhbvKP7h68T2Eb0RWn2XQRUUWejCnoVbB?=
 =?us-ascii?Q?TkY7izb+DG6eu8w/fvwdCSo7DXaaFSAQ9ZNZK99yemMZ/+ms9kKdwNzEWZqF?=
 =?us-ascii?Q?bz50Kxrl1dM5gWnYCgIR6hCJeVbeU1QeKPD4vJOhmnJi/vfPlBkQYvWsHza8?=
 =?us-ascii?Q?rXyg+PxKm3d72hV6gm52QjbJ/JaRZw24HhpF8gX2WzIK9SUgsj3MCUfEt0DO?=
 =?us-ascii?Q?2zfuKiDnVF11RcEvs/Dr2ugacYMtwcoYvx6IjvVrwy0UOqVqStFP902FQRnM?=
 =?us-ascii?Q?FKy5MxsaWxYsAJ4hLHjiGDOU5JWygQyThG1ZO8NDYlALMuxZE0qeQFe/PCSd?=
 =?us-ascii?Q?B9C9MtkXl8OK3p3qBqNIKIxaIkg5F6xzNBYO/EC4Dridt6x4vSt+jeFS2vfF?=
 =?us-ascii?Q?FiPXxFeVEmPrFr/mgs/xgV49WMFfAo3hCdXh+rC3inwHSeUhuynrGAZ+S6mn?=
 =?us-ascii?Q?sLwCk6sDJ2gmsUCYzro5xm5+X2IXuvK+dFmA+RdCJIZwWW1hr1VCZleM/6I2?=
 =?us-ascii?Q?OowWvU43olM89E5zKk0CaS1WDJahX0rXbGwz5/j5GC0SMED/xh/j1INui16u?=
 =?us-ascii?Q?XkZgwrITX5m5yaaPQOhHajjebvsIIAKAqW33PRrLTiLGmoYi3KhAhHhwWVMr?=
 =?us-ascii?Q?bMeUuabcnXpw0bu1sO3870jLDSe4XbbEOHp1tD7db9sJKms7We6ZkE/VVta7?=
 =?us-ascii?Q?oN4qOu41Qd6Se0WK1rKdrAvQF9ambjQZCjnCauOK4lcYBBuBe9lxW3IZmk9U?=
 =?us-ascii?Q?xrIVjvGT3AS0ZNlMbz755hsXu+vdbfqMiJYsYGHuErLx4azlmfC9ssAw8ChZ?=
 =?us-ascii?Q?BijD/RaBHlTbsASoryUY4AzYe3bzfdaQBwx8W6MkuGU6RYkXjn9fYhrRMc/m?=
 =?us-ascii?Q?I3FzvLQqfi/ilC8tf55swoTCSOzHxjRFBdIm4rc3Zpc2YSRrXZOPlvTbxjti?=
 =?us-ascii?Q?Nx3BtIyyQCsm9OYshg8V71ToYnGRIBY3mBrHMCbFc7jyT5hqW4bTH/DhPxtj?=
 =?us-ascii?Q?otALFbZkC0fiZkLrNx7VHb/jFcYZwEhSBfNGNkq+E8Yrywdcmf2FdjXZU0H7?=
 =?us-ascii?Q?tOXwp+8ankRci7D8/tjk4lS67/hjdV1SBYUu5ReTZBxQ80ePW6kCEDC3te2c?=
 =?us-ascii?Q?E2cMMvR8Z8jCky4SvSi4rxdfR0zGWSoap2y8DZ9J2payaEF8yPmSwn8h85ac?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c981a096-db69-481f-ddcd-08dac49056ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 09:29:03.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +neTzqv1fQT4ge9B4IptBMH1cXmlPWVw7ut/Z0Ti/nQptHgQP2VJOMcO0QVBUBrLmjle4i80Kr/Bbxys3Fj1uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

Add pm_listener selftests for mptcp_join.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 69 ++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 82 +++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f10ef65a7009..0d085396405d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2509,6 +2509,51 @@ backup_tests()
 	fi
 }
 
+AF_INET=2
+AF_INET6=10
+
+verify_listener_events()
+{
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	if [ "$e_type" = 15 ]; then
+		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
+			"$e_saddr" "$e_sport"
+	elif [ "$e_type" = 16 ]; then
+		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
+			"$e_saddr" "$e_sport"
+	fi
+
+	type=$(grep "type:$e_type," "$evt" |
+	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," "$evt" |
+		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," "$evt" |
+		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ "$family" = "$AF_INET6" ]; then
+		saddr=$(grep "type:$e_type," "$evt" |
+			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	else
+		saddr=$(grep "type:$e_type," "$evt" |
+			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+	fi
+
+	if [ "$type" = "$e_type" ] && [ "$family" = "$e_family" ] &&
+	   [ "$saddr" = "$e_saddr" ] && [ "$sport" = "$e_sport" ]; then
+		stdbuf -o0 -e0 printf "[ ok ]\n"
+		return 0
+	fi
+	stdbuf -o0 -e0 printf "[fail]\n"
+}
+
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -2589,6 +2634,30 @@ add_addr_ports_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2 2
 	fi
+
+	# pm listener events
+	if reset "pm listener events"; then
+		local evts
+		local pid
+
+		evts=$(mktemp)
+		:> "$evts"
+		ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
+		pid=$!
+
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+		pm_nl_set_limits $ns2 1 1
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 1
+		chk_rm_nr 1 1 invert
+
+		verify_listener_events "$evts" 15 "$AF_INET" "10.0.2.1" "10100"
+		verify_listener_events "$evts" 16 "$AF_INET" "10.0.2.1" "10100"
+		kill_wait $pid
+		rm -rf $evts
+	fi
 }
 
 syncookies_tests()
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 08a88ea47a29..73d2297b5824 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -11,6 +11,8 @@ ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
 SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
+LISTENER_CREATED=15
+LISTENER_CLOSED=16
 
 AF_INET=2
 AF_INET6=10
@@ -808,11 +810,91 @@ test_prio()
 	fi
 }
 
+verify_listener_events()
+{
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	if [ "$e_type" = "$LISTENER_CREATED" ]; then
+		stdbuf -o0 -e0 printf "CREATE_LISTENER %s:%s\t\t\t\t\t"\
+			"$e_saddr" "$e_sport"
+	elif [ "$e_type" = "$LISTENER_CLOSED" ]; then
+		stdbuf -o0 -e0 printf "CLOSE_LISTENER %s:%s\t\t\t\t\t"\
+			"$e_saddr" "$e_sport"
+	fi
+
+	type=$(grep "type:$e_type," "$evt" |
+	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," "$evt" |
+		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," "$evt" |
+		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ "$family" = "$AF_INET6" ]; then
+		saddr=$(grep "type:$e_type," "$evt" |
+			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	else
+		saddr=$(grep "type:$e_type," "$evt" |
+			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+	fi
+
+	if [ "$type" = "$e_type" ] && [ "$family" = "$e_family" ] &&
+	   [ "$saddr" = "$e_saddr" ] && [ "$sport" = "$e_sport" ]; then
+		stdbuf -o0 -e0 printf "[OK]\n"
+		return 0
+	fi
+	stdbuf -o0 -e0 printf "[FAIL]\n"
+	exit 1
+}
+
+test_listener()
+{
+	local evts
+	evts=$(mktemp)
+	# Capture events on the network namespace running the server
+	:>"$evts"
+	ip netns exec "$ns2" ./pm_nl_ctl events >> "$evts" 2>&1 &
+	evts_pid=$!
+	sleep 0.5
+
+	# Attempt to add a listener at 10.0.2.2:<subflow-port>
+	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
+		"$client4_port" > /dev/null 2>&1 &
+	local listener_pid=$!
+
+	verify_listener_events "$evts" 15 "$AF_INET" "10.0.2.2" "$client4_port"
+
+	# ADD_ADDR from client to server machine reusing the subflow port
+	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
+		$client_addr_id > /dev/null 2>&1
+	sleep 0.5
+
+	# CREATE_SUBFLOW from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
+		rport "$client4_port" token "$server4_token" > /dev/null 2>&1
+	sleep 0.5
+
+	# Delete the listener from the client ns, if one was created
+	kill_wait $listener_pid
+
+	verify_listener_events "$evts" 16 "$AF_INET" "10.0.2.2" "$client4_port"
+
+	kill_wait $evts_pid
+	rm -f "$evts"
+}
+
 make_connection
 make_connection "v6"
 test_announce
 test_remove
 test_subflows
 test_prio
+test_listener
 
 exit 0
-- 
2.35.3

