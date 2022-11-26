Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2B17CB
	for <mptcp@lists.linux.dev>; Sat, 26 Nov 2022 13:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkNYFsa5OAxpZoZM6PvNtzmrDbjAPaFUn+04ffytETVrqmLv338CtVdpolgoklOtE+ll9E1FdJdpwhBr3TNoZrg+bEh0MZGDrDG5VQ1Pah5+hU1bAk2DgMK8z6VwQBWPJQygoQDGQ7hxEv1X5MHlPjH3J5mUZn7qsR/YyUcWYIsZI8CgAy+yA73/PPQl6kuZ7u6DkIc50BISMGI2iF1CvHzIQT738MqAIg7tgixVC2tYnAV2D7eyr7dI2/MpFgY0CIUsawSt4fsfuzemA81AENhRo3ZWniMS5+yXyaZAhXgkyEIZq5RhcobLMCqRrRBXalsY4TtjYxexodRLvALM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FnrOnAd+MuPiONfHMAZVtYzQlpreuCv8AVDywY9dKA=;
 b=bfBjV5WIsYARMT+RSQeQE4/OuUSSNv0P/7J3hvvXY8C2v+ZRZr+4YswfSUp6/+sW9vuS8QLJHLjxtb/rDBdZQU7U2GMc3GKvNKw6D3lyuhrwSdK2XihQRLWCmAAflwr0d8tEYMo4LyS5W3mCgQ4hLuUwpEYWn0Zz9yBhJ9UTJAmnOKTB7HXlUhNix4PUHinYV5pUVMY/iLu9Vtk7rUCmX9l/l0GCOGZUPrXEMJlS2rfRLHoNSuu0wzHfKxTKNHXwk/W1Wv//0AZFfOCaR0iicH3gWnKphfgwi6bBfCO2MjHId3Ryq76hFsxLQ0r+Dsu1ObL8KGbMDhemCq0ccuwMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FnrOnAd+MuPiONfHMAZVtYzQlpreuCv8AVDywY9dKA=;
 b=rRuS9lWNx1b14L4EfXrFoELDiwLNLSVRNsS3s7fP18/52vA3W7no96qkNKgj2ETmscLW4dtrAZncWoVRxNAOcyPnsmwVGo9fZRTsxkMdtMxzxJXuF//1UbbylXq6Lg+vAd1E31+ANAfvAPEYF5scWOElYZCoorKit79r+7zNSY+x2vcuaibrl8CZ+RkW7e4j0exugAomt6UT+sd3m3sWbr+xPDgTj1pXBUtwfPJaTILDpwO+ZL3a70i35eujfvpZ1BZ6CyiHNWqQtSrtNos2+btogHYpPeOvSSlvuLHrD/A4j3CshbjubAm2RtXvch397dl/dwXZOgus5WeChDpXTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 13:15:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 13:15:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v3 3/4] selftests: mptcp: make evts global in mptcp_join
Date: Sat, 26 Nov 2022 21:15:21 +0800
Message-Id: <35c9ae9a6e487e0e1a6147d0f273a73c62784483.1669468340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669468340.git.geliang.tang@suse.com>
References: <cover.1669468340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac50fb6-f7df-446f-7ac9-08dacfb04134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+W1ZEHFg0nirLQ1ylFWrH0ch6k+vDeMvsyq2kDRGQGB9Jpt/MwwkeN3mOuTinMUewBLbCy4rS/1TPv+ravgNEKzakk8pfmglURCGa7AV4uHN4+KfmW0dJECzw78z37qtyO5rn2ApI99uJ8yTSGjiRk8LvfphmI4mRqw8QQ607ZfvyMo1h9w5uYL/lmkoYEBCf5cq9xegCfqvHHdBQcPcAxFiaNi5qo/UktiJWD+fLz8xq/0xPuAPm9AiukUmuzyO3e9bDn1FBrLN8UhS3hQ7zzje/gtvEwEkI7IsdtHOI8+tqUNdfCpzpc16nZV6zGC0KHrR669sxbwuPNsSclJbask/Xyd/MbhF4/CdbgdC58SdGPmoMpSmKP9nMYEsuygRzmq5EDPmeu/mKqAlyrkkQpEBlpbXI0YQacWkjOVjV4gQmvOJnHrWBTD5L6TzWwFMrvkaVeYB4fjT/1GWgCKM7IeVX5spNjnWFpU5AQQ9kF5D5E+Wb7lZX5NSS3LnFDUMUzDPuW6iOEttwWHSVTaBHZVIVKC4mJsf8fCugsr3Y32aVEwDxnNQ2U4SByIqHqa9hwZqh+agt2VkLdLUKhrLHMpMZilu8RjS2Dpx63Exvb9wE0xV9ogHU8CvFx2zAlY2BiLrvvilUgbhqROw8GSDjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(6512007)(26005)(36756003)(41300700001)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(6506007)(2616005)(478600001)(6666004)(6486002)(316002)(6916009)(8936002)(2906002)(44832011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPTAQEH34tmoT057CPs1h+pjFDU4TmyRxjGHQvvMcg/SNKLh2B3WG851Yr3p?=
 =?us-ascii?Q?j8KfqI5cEZYsJOFErTapUyVCNHaMjWXryuAtC7kubKQqGZZa5VR7i+9sQUYq?=
 =?us-ascii?Q?Z9WtgMxP9b8zI2uNdHodTStQmCuHrhIJrtSK2LWoPYD4KoXqtIQJEhf4rWFv?=
 =?us-ascii?Q?XySV0lYlCHKCVXcmgGXVHaMvSELs+ZAMS+Z0Us3VxCl00rBVXegzXS78AAeE?=
 =?us-ascii?Q?qLe5Cs8qrxOQ2FyU7GoWuDgO5/VnWlfNoR0gcHLpuL6up7hGgMKBTWBNdJB0?=
 =?us-ascii?Q?c2etJzQBt/cktVdu9iGKaG0TxbeRCfwqpzhoSNJPjyaaSgvXS+SDV6U1rdiZ?=
 =?us-ascii?Q?bQocjIihwwtr9S/aPwl/MH8zP4qm1gd+ykanRqqG2d2QyDCIaHPj5XdJ/n/r?=
 =?us-ascii?Q?Prpan5HRPqE//Bz+pIcaM7bCi7SkYhcQdU6Jz5p3LxTHB39TLVodKcL15ZiC?=
 =?us-ascii?Q?PQZd5awJ1RzYmY/sqjw/SqjUXZRsr7RZ9yDYzxpYudyfDz/JQaXxdLXrHg4S?=
 =?us-ascii?Q?anWANI0MHHbJCbX8lRaONQ5Gcn9vwiDUN17IDEykvgt3fqopjvlUSf5A+Co4?=
 =?us-ascii?Q?5oejuJBHagtOgErvh4CZd7FzEMMl1yJjbQMEzoPbx0fc/tWDGy9aiaMdQXZl?=
 =?us-ascii?Q?gsBsoSgeP+8fRDJZGMQe+H4whUDcQ4Uk6m/8guz6CU7wOvmuacGyf2OnwUcM?=
 =?us-ascii?Q?V86zs1cnKfvL72a8z8C/7GaBOuebOssheqDwiY97KG+yICtfz3IC0yCxKIYV?=
 =?us-ascii?Q?ImVJTtW46xbyfDkPPK0ALxL3figeBrKLoWJ8fvWUqAOXiNYlBd309S6HiebZ?=
 =?us-ascii?Q?woxaKQd2hmwsuPr6k8Pcy4cxAURIp2SO6BFru0NGF1njp4tNZxDGIFx/qJkG?=
 =?us-ascii?Q?bSp6gqjiuA3OhlmZYkP+UpjweK8MM+wZbI8vndX+/RDb6/80KqSRhS4LUG65?=
 =?us-ascii?Q?sSFdqEHxnvy+Hin2bUgfYQvmlGOM2K9OjXEcLabRvQsCEeFGGA8+GrM9TCpN?=
 =?us-ascii?Q?+r+F5V8oeL6dXHI/bDrK0udGIH/ZBEnMR4Ua6LSEo5kTue24anvaYo6kRNHF?=
 =?us-ascii?Q?mBdokSbk3U/yDF2T/++ImGqazG8AxdVguf2z2VW1jQYqVYsCPTUyh6+bnhBU?=
 =?us-ascii?Q?2wYIKJQtg6mAw6Hvn5TF7mkzzl0BdkRSUECOKA4fy3IXQoTr9I67lQ/MjBXZ?=
 =?us-ascii?Q?1bG+bIWSV9Sq0DzP9KZQPmhis/zIVCrTsdXdReVPq9+gUVIyXQ1TvKaCC/Ho?=
 =?us-ascii?Q?0zryqPYify8AnpcEugmKYb37cZC4NNMpBpXzC/qeaTjJHRN0bHOEHYlbLpge?=
 =?us-ascii?Q?1pYONlNb54lLDl1kLzs9KFYzOYok5aFQjxwYPHC2H+tQfJ0BVCaaoQyXfgGM?=
 =?us-ascii?Q?SMiSEgN8umA114TnDWTVsNr0h0czDAavnMa6YXcD7vDx5MHHOfwEA+LNnzkV?=
 =?us-ascii?Q?LhdMdDnaicOGsiCatrdldQqMWQEAY9Q5zFp1KHXYfBo/AJU8fIwadFGUCa9A?=
 =?us-ascii?Q?ki1LVScgJxwcCxexx2gs4+n9ZsjSXpIsHP265CH2Rq6AabBOdpgiICNoiQMB?=
 =?us-ascii?Q?SIlLvYnuePS3/XrGzS3N5wujuVqHv6Nfz3gUB9THasO6ajmr16nhquZacorq?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac50fb6-f7df-446f-7ac9-08dacfb04134
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 13:15:14.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtTFV+ouR0G5l1xp2hYRhvimPJSw2UtonvEugI08SKgRfYRpwRwgFurJSC4GS1XIC4H+mO+huy9MSRhNOwS+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083

This patch moves evts_ns1 and evts_ns2 out of do_transfer() as two global
variables in mptcp_join.sh. Init them in init() and remove them in
cleanup().

Add a new helper reset_with_events() to save the outputs of 'pm_nl_ctl
events' command in them. And a new helper kill_events_pids() to kill
pids of 'pm_nl_ctl events' command. Use these helpers in userspace pm
tests.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 52 +++++++++++--------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 89a30225bbd7..6c4dc890b71e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -26,6 +26,10 @@ ip_mptcp=0
 check_invert=0
 validate_checksum=0
 init=0
+evts_ns1=""
+evts_ns2=""
+evts_ns1_pid=0
+evts_ns2_pid=0
 
 declare -A all_tests
 declare -a only_tests_ids
@@ -154,6 +158,8 @@ init() {
 	cin=$(mktemp)
 	cinsent=$(mktemp)
 	cout=$(mktemp)
+	evts_ns1=$(mktemp)
+	evts_ns2=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -165,6 +171,7 @@ cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -rf $evts_ns1 $evts_ns2
 	cleanup_partial
 }
 
@@ -320,6 +327,18 @@ reset_with_fail()
 		index 100 || exit 1
 }
 
+reset_with_events()
+{
+	reset "${1}" || return 1
+
+	:> "$evts_ns1"
+	:> "$evts_ns2"
+	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+	evts_ns1_pid=$!
+	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
+	evts_ns2_pid=$!
+}
+
 fail_test()
 {
 	ret=1
@@ -473,6 +492,12 @@ kill_wait()
 	wait $1 2>/dev/null
 }
 
+kill_events_pids()
+{
+	kill_wait $evts_ns1_pid
+	kill_wait $evts_ns2_pid
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -673,10 +698,6 @@ do_transfer()
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
 	local userspace_pm=0
-	local evts_ns1
-	local evts_ns1_pid
-	local evts_ns2
-	local evts_ns2_pid
 
 	:> "$cout"
 	:> "$sout"
@@ -753,17 +774,6 @@ do_transfer()
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
-	if [ $userspace_pm -eq 1 ]; then
-		evts_ns1=$(mktemp)
-		evts_ns2=$(mktemp)
-		:> "$evts_ns1"
-		:> "$evts_ns2"
-		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-		evts_ns1_pid=$!
-		ip netns exec ${connector_ns} ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-		evts_ns2_pid=$!
-	fi
-
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
@@ -982,12 +992,6 @@ do_transfer()
 	    kill $cappid
 	fi
 
-	if [ $userspace_pm -eq 1 ]; then
-		kill_wait $evts_ns1_pid
-		kill_wait $evts_ns2_pid
-		rm -rf $evts_ns1 $evts_ns2
-	fi
-
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -3023,22 +3027,24 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset "userspace pm add & remove address"; then
+	if reset_with_events "userspace pm add & remove address"; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		kill_events_pids
 	fi
 
 	# userspace pm create destroy subflow
-	if reset "userspace pm create destroy subflow"; then
+	if reset_with_events "userspace pm create destroy subflow"; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 0 1
+		kill_events_pids
 	fi
 }
 
-- 
2.35.3

