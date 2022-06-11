Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A358A21
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 14:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3LKoQv+n3ohEa1xp5+YIlsVo63RcZb0NrQ1VqUa6sCuZHMefQaI1DYdJjECcbv3WLDo/MHdCbl+yfvziLd7uWGp7Y+yCgl2JADs1ORPTOwXYivyppYlAvEiDMEYDiber5nKx0kBx8kpMtqLBHhAq6nvZNIi7Dm9rFs6Z9+5T+EciVBgD11uuLSyODcYtClYDf+6AvLtw/nTYAGJhxO6zOojLY+sDskMkr4oXtQF1wrhAsfhvnX9/zqPeyMDvYbqIevXmjWdLGwA1UcYltJtweFu1hM2ROtSBgv9vTfE4AyZF1hi9KjUil+Da5AByjR2TJ2tczftPD4h3kRnIa699w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PR97hGReSYttj0BBCshqRSBCSyacnElylEjPrrWhCT8=;
 b=Meb1YhAV61kkZnrt91K2mYADp8IZWa89X9Zn4dDrjeAebTJ6j6wOtwjSmvWbLmgZ4UYJY3hVrzmOhkGRPPKppcFqOCxBuCQpw9gnAZKpRY+bC7eI2o8mWkxYviVrk5c0Bd3WqGcu070aUJuWchBt7Ur5x7BddM3PBtw5fGT770nF8cBWnbnRnMkM+9p0K7fke5CByFxv4/ViRqFcRHKc+UK/N2lsEZGMf1iw0RB8AUMAk8uHpm3d76FK6J8SBf0uAaZ/rgYmiva1C96gFJMaQVkyHxfxGGefMEKXZKnBBCsx1eNjhgwTfOBLluua7YrMd6aAbimUbolqQVQlHuvWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR97hGReSYttj0BBCshqRSBCSyacnElylEjPrrWhCT8=;
 b=SGUI2ZEU25RVIWjBgFA5Moa97MedIQGzVkvTxZDi44OgQIsonOI663H+HsPen0++X7p2dizioHZxdClIP2z+1Q9sEmcz0CDsjvIT/6YKvf3ocCw0xYhNEiWgOC+iOSLn1a+yAJ1yHuTPIlrhzYoiuilizBO/Z4v9A/p+oCG8UJ5zy+uHm7atFlxOudqerlrtXl5r4bSbBqGg+we7RwqaTgv9+5j276pJO7jCVKv/Tx1FrQuv5NcNQTs8F9nVcHjw7ob2+w6A8CIjFjUyK697rh1TmIrj/r0081XJFl+IH27AOKMoGQgZrwAXg0sEJvRGsMQ5lJ71mAQpErb2arHO6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4944.eurprd04.prod.outlook.com (2603:10a6:803:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Sat, 11 Jun
 2022 14:55:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 14:55:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/5] selftests: mptcp: userspace pm address tests
Date: Sat, 11 Jun 2022 22:54:36 +0800
Message-Id: <11ccaad770f4e51f211665639d4fa2daac975ee1.1654958401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654958401.git.geliang.tang@suse.com>
References: <cover.1654958401.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f85d5aef-770f-44fa-9ab5-08da4bba5ef8
X-MS-TrafficTypeDiagnostic: VI1PR04MB4944:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4944722840BB01ED4C0DC8A8F8A99@VI1PR04MB4944.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6q/r9ZRfgUklCi7Bzd74bM0P23jDcCyajOVBcyExBnsauwpalRDzPCur+vqSWcNTImqX0UZ7xBJ6C3E4zO8xAv8/+voSTi9YOlV7ZwvfPB5KByvzEKXdVEigIhesLj7r3+KRxewzU9nqqidbemLgMHCOPq++7uNfqrGEpJ5lWdeJEb61ub3ovDqOy19UWTC6sj39LEvyDn2M7A/iDeT7lN0WanAT9xOmGp+dRpp0X+CxcJnFVU006jjPlEje529cAsrf0SyGyQEr98DEZeUFkjQYCuOrz6vPkC22OjqZb6p3+OB9ePG9/51UE49/S3UIZ2NsAWuzqpoukDEedTzVvSvYaMGa3XiKp7ATR9piWh8gfeZ//NC1FgyxYCbJ+7XvI4RQPYiBnTb/1fk88TMsbcyG6+4kTS56of7TgQrcwB4R4hgoXo3FwzY/A8ITWk+wDOYsGk4mMrlQm/2x/bka2qvUFD6ZP/o2B29wH0hxn6VtF0nq0Zp7Ivuy/OocehaDif0JyAdyZToq4/TmbKz8APXN79JtdcP4GPmdfLRKiQyHYod4ubHAal3A6xtdvXTSe7359CE50RmnM/zAGbeHeQSlrGPk6BpZW3ZFzJOjf7MWWQJmJVRpb1LoRlYUqx4klictSKapNUa62teGWlxyOK9W6tKWKsaHLSkLi1VuSqyWtm06mj1HFqxgLdKw34Rj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6916009)(107886003)(38100700002)(316002)(36756003)(2616005)(508600001)(6506007)(66476007)(66556008)(66946007)(8676002)(83380400001)(86362001)(186003)(6666004)(44832011)(5660300002)(2906002)(26005)(6512007)(6486002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Y4BgqVmQbr9N6G2udAhWk68+sHkyicbQ3BDtT06EcZSSvOknLUeRkQjMYmK?=
 =?us-ascii?Q?HR502A1R3Z1kkIukizVDkrkaMpV5CJr0IG+K7nKiBa+ViXf9/8j2mCfbQe50?=
 =?us-ascii?Q?xwbf28Ym7l6PK1a6Y/b68WMdGFO89h+aCV6nQVotESKM31Sv6Qsu/rh5cuN8?=
 =?us-ascii?Q?R4o40KtHHgxSyknYhlCTsyeREytSM9u0U5t+cDGpJ/PC5qIaeZFPTVEJ8awg?=
 =?us-ascii?Q?jKTtHjbknCu9nnr978b5JT3tC2AACKzZL1LTSPyRcHZ2iExgByp8W92e0vlf?=
 =?us-ascii?Q?AKpmU2NxUW5ZSx57yQ9QsbjyNDX3ENtRAzSWigxCN9mBUdLOv7G76pGLCrrL?=
 =?us-ascii?Q?qf3Glug+DOzhCqcKMJ5qo5MVAPdQxw9VoquQtpBo9/fzCPLHksSlPRGfIpz5?=
 =?us-ascii?Q?N1nR9gKtCQlrOepY9sGa8wIb6ZWiPJwuWLRUkP3vvwANEuT6smCM1NOSLWrv?=
 =?us-ascii?Q?sUJIQpXgiCeSA1fIZvw81q+NyaiKiVihLk9vH33V82U6+TtsbE06zNcMTqAK?=
 =?us-ascii?Q?vqX7Fa3IFjlPxkNirQLW6pBKMhe8KZN6ddq7XF3R98Lj9muTPar0AyjxW1D0?=
 =?us-ascii?Q?2xvDR42xoiGqJvDRVCzBhvuWVzHsMFFiD4Ttrd4y2VRkM144ZiohJr6VuQhi?=
 =?us-ascii?Q?wTyCFxMA78DkLUWd5VBQNobsAYu+MWTAHR6ktQfkpRfB5/tACRpwJN+x23fE?=
 =?us-ascii?Q?TT7wu+75QII//kUYVgM8uruTzRd4YA8+hfV1KDqSy2o6ERf1t+s1/Wad85nm?=
 =?us-ascii?Q?JlgU2bDkG9I6kMMzRdYWcL+vFh+IFq/O6pZ/l5Dr3Lc6R8lw7fNK0dncQyZr?=
 =?us-ascii?Q?ogrukE2lZw4O04v1TbzeXjgFHFleYC5B5dclaZ9q94/1EN0KuxMZXHKW6KeZ?=
 =?us-ascii?Q?IgcvtS/FdEzrjZPTMwbPxPpcx4yGBzlVR7fHSC1dq5KI/wvd7fRC/u1r5ikN?=
 =?us-ascii?Q?GTxaNiFd0m5Jmmguu7H6a75KkYrvbFcWaZw3txUdJ7x39WiSY2LOHVFeWZ67?=
 =?us-ascii?Q?gf+t33bK49DFKBvp52a6vreGH5JFLYMSG3EWjTtJV8tM1PL3eZoSyr3Uyazx?=
 =?us-ascii?Q?Ljc9NmHTtYgcAnKDtBwhhYmopbwjKdJLzuSmZrXX9+6yjDoVqi6Fz55VPcqQ?=
 =?us-ascii?Q?0DeY2l3GcwNZLwMpILEVqNy0TSfMoZqrdbjyDg9VgYONkEbyDzspZIyVGSKb?=
 =?us-ascii?Q?XRNTgIMzRUJgp8fFkNiIkp9FwNnRquDEqddG5Ukojpn/75Qz/0I+742hj0xc?=
 =?us-ascii?Q?YiI3a6ZC7UtHOEDtNN5JOWb7B3WNHqdlnOHJWfVl4OXU/TWbDcgcqh7PAI1s?=
 =?us-ascii?Q?On/dN1ROm2Ipd7rA7BO2oB3tbkjpdVYSKMkHt+iM/zf0BDfoIM/z4TGb2HPy?=
 =?us-ascii?Q?Vmk2rUtFneYNXPlGu5BuBpQuZY7ctgT4x6O+LwrafBAwFikCFxyRknaEQXLF?=
 =?us-ascii?Q?GTlb+3dfPpFUpq/5BT0mcDvZ+xPv7uSfEaSM/EszPbwe6FBoWRhSe9D8PWN3?=
 =?us-ascii?Q?jB3HPi2cf/CllNXCcnYDjGYEsyPiD2az3b1JKkaaZuMtmaMDOUdQ6y3xF1md?=
 =?us-ascii?Q?aO55dedxfmSEDAIGS/FcviwzLFP9ufASJ6J4t76MUDsYnEkHvXv1NwyIQb8m?=
 =?us-ascii?Q?WAd/gc0NE3q8Q8dfmabNUwy6lNGK2RbDHEzeaDc1V8ziMvGvl67VHV8vE8dV?=
 =?us-ascii?Q?ZlwJcNw8eTqsOa7HtV/rK9q6YFnyWzYYHUWJ5/N54Cz6hV61u9Fg6Dxy2dp7?=
 =?us-ascii?Q?9ojtVBcbOOE+XH9wbnFDycTO524qK8Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85d5aef-770f-44fa-9ab5-08da4bba5ef8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 14:55:05.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUuZfuHQ/Z/JmCRWwdV4pkbCCIbJvlJCqwSChc2c7Q7MV4u8TEHuTtejZOUrMOno6lfDoFoz74sZwGCVYuwqLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4944

This patch adds userspace pm tests support for mptcp_join.sh script. Add
userpace pm add_addr and rm_addr test cases in userspace_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4406b7a8064..c3cea1d0d245 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -654,6 +654,9 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
+	local userspace_pm=0
+	local evts_ns1
+	local evts_ns1_pid
 
 	:> "$cout"
 	:> "$sout"
@@ -690,12 +693,24 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
+	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
+		userspace_pm=1
+		addr_nr_ns1=${addr_nr_ns1:10}
+	fi
+
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
 		# disconnect
 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
 		addr_nr_ns2=0
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		evts_ns1=$(mktemp)
+		:> "$evts_ns1"
+		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+		evts_ns1_pid=$!
+	fi
+
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
@@ -748,6 +763,8 @@ do_transfer()
 	if [ $addr_nr_ns1 -gt 0 ]; then
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
+		local id=10
+		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -755,9 +772,18 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			pm_nl_add_endpoint $ns1 $addr flags signal
+			if [ $userspace_pm -eq 0 ]; then
+				pm_nl_add_endpoint $ns1 $addr flags signal
+			else
+				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+				sleep 1
+				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+			fi
+
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
+			id=$((id + 1))
 		done
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		local rm_nr_ns1=$((-addr_nr_ns1))
@@ -890,6 +916,12 @@ do_transfer()
 	    kill $cappid
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		kill $evts_ns1_pid
+		wait $evts_ns1_pid 2>/dev/null
+		rm -rf $evts_ns1
+	fi
+
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -2810,6 +2842,17 @@ userspace_tests()
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
+
+	# userspace pm add & remove address
+	if reset "userspace pm add & remove address"; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns1 2 2
+		pm_nl_set_limits $ns2 2 2
+		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_rm_nr 1 1 invert
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

