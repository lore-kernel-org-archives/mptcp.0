Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144853BB49
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GW9UaB68"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcRISQYlSpTpuDlp9vFukWUWTNAkl7iCh2LIPuf4kS0MHxMdDjSWrtSUH6bfWwtg4bOoRkxjTuHaQus6jUYcT0Bd/DiZsjaUJl7Q8AThyagXlwg9RT2vaHpWf0+7EDZjiSlDLvRAsyJrNSl4TILIEfGVsIws2LHPkBsrqk7dB1y9jskUrp9FVgaEcipSYN7FLBwiaHJvPyB3/K7RRg45yoopmpU22mNr/ddNW64Enxbdg8KGgIGymFZQ8jD7F2qqLiedj6Fu93IKZds6jXTVKotOSbSDoQKMY6nMcr55cAPFHDKthPBmNy3qYEgfMOqb4wqE3NgNzq9+vyHGq+ZRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnjZaB7bRb43ZitZcS0sAU7VHwQ51rokw2Rj2Ke/7Vk=;
 b=i9lzhqZpSq3UaDsgR0YFv5t4XzdLt6GAC2gI9qVHy9ZvIpWR1KMdIcqGjGiM3vMbg2/0J4+9HPKZ1YkTkjfUHhQUzanz6iWrR3KkSVQ79rZVZKNao1NwaOaaiPFDRvYczMh+nSl7RTtRPPw+0Kzvb9hPUxgCzaPjCbMFAaF7RlTJJBcXDe/N7imsHD4nZTjT3D3yUjB+2Tk2mstzbCiCMhuCGFQkchIdShAA3iZUzJ4WsW7ha91/7kLtbLWKP6cqxpRmhvOruKiSoWlU1KbMLaX4SRdQ43H2JHaH2pcB8ZukjhnYaHsf1rtFLbFelSLedn9tgYvx6U0RUKmIBKWYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnjZaB7bRb43ZitZcS0sAU7VHwQ51rokw2Rj2Ke/7Vk=;
 b=GW9UaB68PDqjzELyd1nA1vZL58ou/oZN6mtk6sRudpvD5uSI4iG7p7ongkqSe3ZWT3vVLnS4jFsEoJG/4w06vpPVAGMFwIyLseTWvnIr4DaRRHn+mriutSvjj9iBKNZMRNQVSQrm8gPljdDQFzCgvn/9yoTUTS5zuIfS4X6q2PIBugT/HuMZWnBuqtvHoIoySDuCqE1AL3TRUxniV6mScaUnEQP4UGrGfW6JL0Z8WR5PiCSed29RQv442bhpMw9fn4oWsOFY+6vyexKpZw0q4qJjRjKb0jGWbOKdNJ7IxYbMWA24p1eyzYKeyRjnaUKlQoIpwldudiQ30qkEtC6SrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 11/28] selftests: mptcp: dump userspace addrs list
Date: Tue, 21 Nov 2023 17:52:34 +0800
Message-Id: <6ffc562b0456bc522f88c8a567a55873eaf0e2b4.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: d74ddb15-f7b1-4c12-b696-08dbea77e063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EBfznEVyxfODpbSgvOYq3Aw1ch7kuKn3/uQkXm3U1ZbWVX6Ht2Z/GTpdjmqFKLHOh+t7brDk/JlsGkItWmRUUWWGFMJ4s8dMKpB+mYQ/N/2hSOI7d3kO5u+4MzFOyhMRBc2ihuc7mi8tyW6tn8MVu+5HnVjZn2WV4DdVF9Rf3Iq1SyBM9173yUPELMenDNHLcDO8xUwGTW8jioVNP/937l4y15LW06Ysh4nCOu1GLmGsqxPdh5GXdIdVtJDComXV2jjgIyXXEnQ/2fXL+FqwokLMiMq+Vej5IWo8babuaO7Cin7VD2CYl5Wct9dA6QVGxmhoH/Q3kCIqDreZafE1yY63x58OyG5Yud0Wvmue+pVlLJBUcObgrHTqzY4AQgzBw4YV3H7+jH6XJ3K1/m6kKDVuxIhm/yWbLPF0Wacg7EGTR3XwEAK048D26KgOt53CFHeAws+aValaf2RQ37H9SIqumUm0SDleTTPe/gdeldrqUxPuzxdtVGmHfmAGPtaoeuNPS30ge/y24Wp6rQULy4Cy1wjST2S+qAkLWcnFJQ3uB2zxpbyUOBxFWtHZYxez
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mHGwWfFHsVYrHmZIv+UX/kHrqLehl8uZMRN21JmTd98L30DXqAmoPhE9TJ7k?=
 =?us-ascii?Q?Ad9Ml11z5h8bBdkdVNeqIFrBI7rbg6r9QqDZkl3vfS2rlid/eaZO/jPJBcox?=
 =?us-ascii?Q?F5oLWbBQKdwyVGh2cl1uaHvyzGePF9YwYd+KwRKayirIx8blVYhDCf1CqGQG?=
 =?us-ascii?Q?KkA+JWgt6als+TCjsP3dmsMx1C7RhO0BSp1o9/EZFH+YlwNqU7mfJiy7qW5+?=
 =?us-ascii?Q?1BqUrVypVpl0DKm5/+7e0OOTHoFd1KkUv6lUiJfKUuaqsp2tjiAJ1N1vPp3C?=
 =?us-ascii?Q?ZeNCINCGs4L8NR7CQ6ghu2Yvhe5MFUfz9NsF9dMZ5TZap/zTCh1OXWhmKYSY?=
 =?us-ascii?Q?jUhlb9kR6HzCLXSG/OVi9BVthRKUJsJw9VUvtuwS6v5GNRM3W3WChlrCOMm4?=
 =?us-ascii?Q?q5driVCFK2s/yFpoBxFk8cI0lUctyYl7c/fMwH79fsyXQTVvGPB3Uo7qFO8Z?=
 =?us-ascii?Q?KaKbUtsFCBXzwGFINjScLAGPRH7wSZbhdxGjpRuFUFLI+msYunqU6eMd/d23?=
 =?us-ascii?Q?qjfivV+5clHz7+sOpd6Xhc//0Cl96koipvvC+RPtCzRz54HbMgwBJFWgAFhx?=
 =?us-ascii?Q?OLu6flQu+NxjOVGqRQpTPmg8ec1oqcU5b9qb4d0gZK/h+vi9jG8qDRIr8ynZ?=
 =?us-ascii?Q?gPMOLHo6AqYWXmIOo79kutHwO+mj9YSb2X+nMJha4+sbU41AoQB5sVmSl9Qd?=
 =?us-ascii?Q?+MHbwNNlgSFyM1odbe7z9+RTUGKDxVffq0a0hwbXdK5MSt7uzoDwuFjj9TsF?=
 =?us-ascii?Q?xjy+W7A8LBfySQVIC+6LI3n/TweYbSm7iHeopEZTYFi9GHX4aZeuaQkZ9K86?=
 =?us-ascii?Q?dMeFItyvph1tpI+AyHIjA6XASujtx4mKBiLIHb7w6C6yXlmBPVzsiLuwPNBi?=
 =?us-ascii?Q?oWJHOJ/AXRBTKO13dk2scfDltraZiFulW0CbFHQfv/gxeo2O13o4Kn6cMEwZ?=
 =?us-ascii?Q?Cbo254ZgND3Xt33ILb7VAHf4IiAzrMnuUk1+4BD+JpqMYpw+7x5y5OttV6zf?=
 =?us-ascii?Q?5j13sGV7JUvrxWH6Z3wM/UDAR39gCnqs97i4SQskB12Zaf/gKvxdaLXRrpGL?=
 =?us-ascii?Q?zqbedIFTCs3ge5qiw4VPgnXjJeJ2jtrUTd5yno7ytIf/p0R9ivh9RntknDxt?=
 =?us-ascii?Q?j5SHXgCOTer2i7ph7QREdupjS4Pgzcn6u5j3hPPgeziiWzGbwz445nN//1zG?=
 =?us-ascii?Q?d6lSARuUVbTiPvJT/4XEXVjAw9gvc+8nPIm5eVD3oXLQdaXorqmUDMMJNJf0?=
 =?us-ascii?Q?8k/Hnguw2+4E6YvXljQFQ2+lWlw792gX2/S6kSQn+sLqxc2VWqXqXSl90/a5?=
 =?us-ascii?Q?yxCrV4xeH3CgITJzoGZm4caxz2JqAxmVxhuXtHdA4UMJEwltq/trnjQu99qv?=
 =?us-ascii?Q?d8ru0JuU1UG/GBNpHvAzSFVKNx6QzdxlD75VaRK+MaZ9gBXlARhKAOxFz3AU?=
 =?us-ascii?Q?CT8X9A3cKt6WprGy3bBVrBtAnyG2QnYK7QnJupHGr5geHth+OzgjyIi3ZEc7?=
 =?us-ascii?Q?6vru8U8IM8ufcZnWM6whRYaI4NuYulE3E3zY8DHi9CQ8QHTcp+0FIS7gA7VF?=
 =?us-ascii?Q?AbvQDSxk22kdtz7+u2OmpA5cXSvNXZKf84PDWajNDgdOa9xBKlrlOgJMX0zm?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74ddb15-f7b1-4c12-b696-08dbea77e063
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:39.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UH+OYLRBUa/WENcjS72tln8VnMdQ9ScjtUUUfE3GnXi4erk626HJrlnnux4M2GGhDj9UyVGWWk0ditm8Tpw9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

This patch tests newly added dump command for the userspace PM. Add two
new tests for userspace pm dump address and subflow. Use the helpers
userspace_pm_add_addr() and userspace_pm_add_sf() to add an address and
a suflow, and use mptcp_lib_check() helper to check the outputs of dump
commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 98b6814af0e5..eae9f84423ee 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3511,6 +3511,50 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm dump address
+	if reset_with_events "userspace pm dump address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"id 10 flags signal 10.0.2.1" \
+				"      dump addrs signal"
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm dump subflow
+	if reset_with_events "userspace pm dump subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"id 20 flags subflow 10.0.3.2" \
+				"      dump addrs subflow"
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

