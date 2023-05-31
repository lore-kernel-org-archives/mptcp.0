Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1CEA4
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 00:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDGrqJWRabdVptj72oNsc3PuQ58mb7WhTxCwfbi9uuTB6eGc2p0SqTCJTNvDw5Kuj2xCsrBIwbxDPeNj6fkxym+jSIp16zW1m06bTKfHgIg/p5Vgzj0TZ01pEZWpTZsTZKLz1H2FUIuMepWXFc339wrE3zWcRV+mX7zHZSme/n4LmFkkmbGlWNK02DdrF+JsZv2RHpRAGnTZr/dszcv/aYsAcmvMUfV7fHdvHIiJ2cnJaF8+SKBipnY8ibMU9AgRBYj9LVYntbhfQ0hinwv6mSRl259znufRhtWeBbjYRKJBbjJo44SfrtVwUdFbfrBZi5vwMPwBDzUReCFioTIDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW6mQXMkEzoGj05tR03PazZFsgzMfd9DIKZnW1Lg9VM=;
 b=ktr7bTxH9oU5StTK5Vzo6+7RMcakTGGBhCGNPJ7oFXiQA4IK6wSina/JrR8lNhiZthG7Ndc/dba7eOO6jHLEzY8Dze2nvdsF7BOwiH7V6UjKWwr6E5vk0sTldkvESXB+4EMlrwShpYIV/3g1R64u0Qi9ob0kO378xCoS5mJxTBjpboR0SwcGxw+gh7eCskEJIXTR+T5Yx8wzCK7gViYI6KAAgl+q7Tr9ppHBXjmqO0I3f3VIyqyjeYfLNZ5hE2Jkbmc2eqDmbbbZfGV1bzAwebPfsMwz515ykZZ1m7SBO94kR41519Ax+M6IpmLtmZ7BuVRga8UiRCFQbtXxZjcW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW6mQXMkEzoGj05tR03PazZFsgzMfd9DIKZnW1Lg9VM=;
 b=XwYmsOJcebov+TpulZMB3Vw9UvGYcUdBMYS4BhVn+9wz+tgChzvZaig2hiVzuavb3YruFr2bHrTlus8CGesMrdU1aIJiqRcDCTPYQY3jJ5SANu5xJ9EGestHxjH2zxYPBlQeAY1BVE9VywTvrluXd+30tB0ElYpXNr5DXbPOgAveBr0M0Dhkql0TdOBkNwKAbMJnYxI44mUh9nby+5u8/pELqk0pEhXZBMxHAHalg3mqD9rUeHZMSbw3iAdxXU9CQW3soYjvr4KeprkViI+L8xWe1yEvjrCrCw9vQsduoxd5Ro5pA4BfZ9hbqCoGhXOJ/aJ7MXtFOFKLbgK4w7ZMhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:53:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:53:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 5/7] selftests: mptcp: check add_addr infos
Date: Wed, 31 May 2023 08:53:02 +0800
Message-Id: <9b35d5befb941c2d13c8f75cd2ac3bf4b6257fe4.1685494054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685494054.git.geliang.tang@suse.com>
References: <cover.1685494054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: d1601062-1387-4656-3f8d-08db61718412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LqnsIsH4IrKdbI5F0JHT4M4hBXiz3k2UW4kMsn6UW7YEVu3Dz7Ovu8/yXnSdzY8JuWngrj+BKKB9OFaMSxLyODRFL++uGk2N+g8+hNhFsjEJsIv2IwyHZT/K+Gkh37qK27n128GDc0z4+lQwiWAVYqpuFWcNoXeQ7gpU2Q4H3jn4IIGRmBQaO8jGDZY+AAgshAHZaZkGCqVCM8qs/I/uPGao6db+PRzq/8/YqarOxIYb8hg2OawVGQDIGeMegRYDgiYE0R/Q/xctexraorQSRCTZftA7OW6VwgbFAcgomi+Dylt4Qk8+dwiwERBsqSwrJaUTZjTaROS/lzQZM1d77zqFVH5QjZJVkhWSP5rYhFzwFqhlM7y0ixuvsInrRA1s+ab9oydDQpAyLy7Pl6Rt1grK9Zl9UnRTpJGs+gDiUUu2LRVb4seln4XQnBhp9+twSZPp5lVy2YTC8DZ4MhMnJ833LudEq4vhUJOGSmcE5Hzl+d3XlZ3jjpfe0PHR8JIfGUsrNQTMymK11jVZ14EGbpSKNqQxr0mX5C76dZwwcKsLkZhBG02rr/6qxoIPP184
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8676002)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(66476007)(4326008)(6916009)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(107886003)(186003)(6506007)(26005)(6486002)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CjOWUhv7nPCp/eO7Po9IfQ+Cid3hTwdI1Pnw393pOI8Ts0MbR4ULE2KuRzry?=
 =?us-ascii?Q?P2VZq8HiCnXjfH1nnIS3vWk47BGE/gtY0mG2UkezakYfLiwT016FkoFTKHTU?=
 =?us-ascii?Q?Cqask0c0w+rr6JE9ZJXb6UCv1FnaE3xvm2wmgCrY80ASvB0sD5hD2mdYHJnI?=
 =?us-ascii?Q?VaN1fKeUWOedklZotKwvMKllYtAWimvYFz0/j/Oyj+q7WU4nK/Yz8S7hP1qv?=
 =?us-ascii?Q?yT5iI79KY4f02RE+SNWQee5CH7Hj/t0pdJcXqrniim3wJUVXOkjztM2i021o?=
 =?us-ascii?Q?04CaKJKsOtcgW2xgKuagXKFmRZSW/GKiK0aBvYM9PpGaO3Ihrxat+ipY6YSB?=
 =?us-ascii?Q?C8LsPSwLCfCTNZFEnPUa6vhqEQ9mhQdjMt36v8A+GjJQ9EvSVqXjBL6ic6LU?=
 =?us-ascii?Q?UGFQCTvcdRNnKIDBtjVDfsO2wmQyhFKrvltbOLtTd3RobIhxJCzRG41UPrFF?=
 =?us-ascii?Q?K5RIG/7/fSIbiGUbIIhuMlFyoNMOd/pYox8ea+qyvaWih8dEZt6VdUNsAJRH?=
 =?us-ascii?Q?aU3TO4sIGP8OtDvIr4GSQTjNc6amUZ82S1PV9t/frFbYXjXVG/DvavhcMyLQ?=
 =?us-ascii?Q?Wek2ZedGp2zCylCgubKACQdF3CPHkqxuTV5Yc3DeDdj4g1gTUlYXkbfCyVW6?=
 =?us-ascii?Q?1WwonhEgy7NThqhpql4V17ny0SzJapxRFE++/s4zLJAjbxKTsOs3zgbDC0+Z?=
 =?us-ascii?Q?RHouOzwPrevTU3sWX9yaXoajtvwu2eVa/OaYCQ6309fJbtNzCzgJH5cVux7v?=
 =?us-ascii?Q?gGBtK1ogYFURmxJG0cbGYQDJ4E+IsrLYpzcFMqK9uWQjDYlbMWERUxwpZAfI?=
 =?us-ascii?Q?N+E8d2wm0qmucEqq6+xynJg4LTfw6PekwD/sDeopSp0FpQDGFP0Lfr6knApr?=
 =?us-ascii?Q?mIlkAnvcF/dHP8vMuSQnJ279tnVnJ7GrtTdQhFCKQbRfyaRALHz70IZPMVzs?=
 =?us-ascii?Q?pthGeAPT0+wI5auZiD8AfV8JvDJ/o/brn4FhOlvF/sRObpNh/xENkJ3hhTae?=
 =?us-ascii?Q?sTZi3lykrTPQQyDmoo9FCbMMzPC3W9H3yZW56hlfn9BA28s5i8+2ERGDYGHw?=
 =?us-ascii?Q?k1E+55ZjHrDhbdwqSBTN4ASv5/Er53pzB7D1K50t2TuX3aRFUWXBJzycPoGJ?=
 =?us-ascii?Q?PD7bA3d4OvJB6s+knk9B/LZu2KyRNrIMJEHZLq/Jc6n1qF6v+CsRzUMEgwhA?=
 =?us-ascii?Q?l9w/5NE2wTZRLUdqK13Pm6VRwYPpN3lgrtb/ga/P/a2toMJ1J5ua/D+7Upr1?=
 =?us-ascii?Q?pZVBTL3QM6uyt3351vL8L8l2gF66xj9iik/LtOH3x9Lo2u/I7IE5vaJoISlt?=
 =?us-ascii?Q?zk2MOsDHLDDEEPe0cO4JBiee5n7cGnfyRlyhtoF6IeB4FNkRAGHgtNf8YBXu?=
 =?us-ascii?Q?9jbIU9VQ8+f9N6MNLVvekp2X7LLDtWRfejKbEEcVqSyzSGancepqtcX5mySj?=
 =?us-ascii?Q?BjNlYIC+h+P9CyL7RngHomynP5dXbqWhLjebxhYCVhxMdeW02/l2a8FIXiHT?=
 =?us-ascii?Q?h6RhSX/zMlx2CvjhxRMBYskecRacJj15RsdjqmRV3UUQHbdbeaj7dyBJol+4?=
 =?us-ascii?Q?YEARpFEs5hAM1O2oP7kIp0LRStrxPrWWbvuBU4EF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1601062-1387-4656-3f8d-08db61718412
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:53:58.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS6eyT0hFs/YA7l3Re+HoG4yJJz+XdHGBqIMaLyDdWJxzsOhxvXN83i/zNCzHqwmYVjjNqTK79v7u/FyCsobBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

This patch checks add_addr_signal and add_addr_accepted in
chk_mptcp_info(), and do this checks in userspace_tests()
and endpoint_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 846d028f0b16..7270f8cab157 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1816,13 +1816,17 @@ chk_subflow_nr()
 chk_mptcp_info()
 {
 	local nr_info=$1
-	local info
-	local cnt1
-	local cnt2
+	local info1 info2
+	local cnt1 cnt2
 	local dump_stats
 
 	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
+		info1="subflows"
+		info2="subflows"
+		nr_info=${nr_info:9}
+	elif [[ $nr_info = "add_addr_"* ]]; then
+		info1="add_addr_signal"
+		info2="add_addr_accepted"
 		nr_info=${nr_info:9}
 	else
 		echo "[fail] unsupported argument: $nr_info"
@@ -1830,16 +1834,16 @@ chk_mptcp_info()
 		return 1
 	fi
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr_info"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
+		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
+		sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
 	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr_info"
 		fail_test
 		dump_stats=1
 	else
@@ -3313,6 +3317,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
@@ -3356,6 +3361,7 @@ endpoint_tests()
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows_1
+		chk_mptcp_info add_addr_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

