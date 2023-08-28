Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CA634
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 04:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJW0CcDyiNEM/775szFYOvNysI6tbtWcIBdyCgyX0w2Jy/aH7hYxF8PyIw/5kat0mmJeLTEzFmaUKabblDXqtk1A1t4RahBauQhE3KSZnVJNOJXALIOz4UTld16N4sJxr9gCwvAW5Ts/Z2m9y23nRgvxE55je9G9xU46bAGbhRl6x89mVv7WQ0rw5WmjZDTr/EO8NNQjJibRPNH3E4Auux18im4gwdPVHzFUBhYhMqWYj8woAWiAQeX/fk++MkqER/qeVff9ngPWVFZwLUz4KUmhRWhzpWsEAZKk3IOo+mX3kgP19I8N5iiwJkiMAl7XUlTIUGUTsT2uacaVNPWC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xux4nFgYCh/qOIMGMdOrHF1f3cDNm+P5c7yOsmDcPVo=;
 b=jmKgpQXDk8J81d/3QDnjUH3IqfbshNbb7A1um/m56p63WSmz1yM2k83wP9Z7swjh+dI0eH8DtT/YdECZ25Qxpkhb1YeD6CAmlPlW+HzPGZqfBa3oEe0Og56eu1+ud2duMceGcZ01JS80PB9uhiQFTsOhTRI/NkvLYCCdK8Cg/Duf8znG1+pdLVBI3kNUXw03ThEKMzsVaqFZYuTeX7npVW32C7vM9N1I1E+7UvAMAI+3q31O42+aaQ21FtFTLjsqRxvgTEZ2UplV9pyZoMNFERdqyl0Ve0A2gMQxM4WAA3neX1l8eRfzlorNjioSyFdE+aT/3I0ixZqlcyWCet5XSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xux4nFgYCh/qOIMGMdOrHF1f3cDNm+P5c7yOsmDcPVo=;
 b=yc6w9+u7Nb0j9z3m4QtsuB5vDPTh2p+TOhBW1HPwmtcVjKOPyYp4IvlkfMbyQlt1bi6tjNEn55A7cEcNev/aXpO5KP72b4mD3jM+Fquj8npdpf6bxBALLKYREXzt9bxHB+ddxaN2NAh2t958+seAIcHgLpUB7O1D2vEr+/7yxOg9V6z5QmlaoN3YZwhvjhF/WZ/6S4UCc7qIGN6bkcM7hsWMrGMN3GOEv2f6rfeAnfhz9rHkVsfi4SEhpw2W2IA6NbBTiZeqxOhTcph1UCcJcwF/l/MyEQkTbRtRQTYWJak5+FFjNPpRCWLC61U48vCtTZ4bfEVV3v1Jbl7wKKSLSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:35:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:35:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 3/7] selftests: mptcp: userspace pm remove id 0 subflow
Date: Mon, 28 Aug 2023 12:35:25 +0800
Message-Id: <d3f9fc3646d0ae0e09bdf3b5642066a13cc0a436.1693197152.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693197152.git.geliang.tang@suse.com>
References: <cover.1693197152.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: df7f0992-6632-441a-ade9-08dba7803bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LLE+BeYoq+NKl887ik5yApH+MqpXf6psZwiupqKMjcybHT6m/djHZmqp8+IMXThgAHtDDIekJRuQFSI8hHQseEwERArNth1DbJJnJV8KgI0caKq+Cmb/nXzlpVNPKTcgpaABFIw0yQLIyyVcQXxdFRPG+jvO9EeIBe3mGedMPgnYYKjmGGjjuLfOq07JBgjjB+mU5qI6i4YWFVKZqVPmDLWECsO8Rt9iR0fiEHGVQrkVB2KKdw29D9Ptil9FVFPXdo5nrNFxydhRFUuGyppunLMIr8aLzDfJw8aaLkHHsKi9q98Mfedl4QP1HbnFM7AVxq2vCyRsRCYEoK7uirUAXJNbxbgJTGoDfk65uv5I8tRHjNlJOAXUX2yDHvr30zGc4NYrOCQ9w+pHzoYPCDQxgk9NEgNqbSBxgOS7lvv5kKyoGxs3PFldJ6Aki5oqD2XJOn4jlBYDdC2kDptIMwqjvbW0s5DVN2xhtwUgjw53YvMawIlzgBjOKKKbBb4Kk+uKpcb6On4Yt6REbr/WIeKBFeh16S/laYhPiuAEieloX/Y0DcsZmMzKTKNT9y3/cjoM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(86362001)(83380400001)(478600001)(2616005)(26005)(107886003)(6512007)(6506007)(6486002)(36756003)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hecnHeQKtVEyV3bQIQiIsLocRYMX6n31Akv9MlY/xxmt3JHrkLszg31OUiVq?=
 =?us-ascii?Q?PJY7b6yEDgKAUteplYPw1Cl2OuECam7ZLg3ApNOmT95CDy+537T3XAL2sCYT?=
 =?us-ascii?Q?Suyr3z0UK9L2PXL4ku0R5FJCgYbQPSCEKj0FGY+haEGMzf+HcMukf+dVskbM?=
 =?us-ascii?Q?3F8HbcJfHYGdKv50IiuEW4nKHYgNDqMv0IEcw2N3mtcFcYRSlfZf5Rjj7xBS?=
 =?us-ascii?Q?j31I7P5OFLPkJQG/ruTrlY7uYIdSCnjXuIZ3tPkNAavNyPdeMN3/k1Um2IeU?=
 =?us-ascii?Q?oz9H2uD4uXu3KercFLtSZdCoJbXVY/DGqsUuGugnSgFJppAh6S8rvjs4PKG/?=
 =?us-ascii?Q?KMD4KmUfs7JMtnI+PX3oyz7GpJ5yf8Y+33/svmQltO9KbKPG3naRetmBfUKX?=
 =?us-ascii?Q?iO2RYSP/wra4/hMgDHtqT6XXCalhCpwB+cOEqgNK9F/r6m553hP6+OYt5D1d?=
 =?us-ascii?Q?rqSsl1CkY1je1gFBTHrGOvGNjWpChOL+7pn2tF7leRcBPAADIZacMYjsMjmn?=
 =?us-ascii?Q?Iu00/1VzIRMDyv53GugOHmtC2tfIH2I7KCPy870r6yWRB7iKHYEnH14Wqo/2?=
 =?us-ascii?Q?ezckzxqti+EF4Qn3/LDNFDkQAWLbtwEwaWlxCInHev4Zn8j3RG3LsHKFfL53?=
 =?us-ascii?Q?/zyAQ6thCQe43QgCpcfcQwKg76sHuI53fJGThHtZY31iezLsH0aaAZ7oVooG?=
 =?us-ascii?Q?7swT1MBmWyKY7Y9rpJf6TZFl7usQMO4CJuVPXWXKOWJB7svpAm6uBajv23Ey?=
 =?us-ascii?Q?cSHpRWcouBDU5+XHpZaCsdUe4ji+DLso/W5Ci2rXAGQd6XpvLGffZ0GGpA9S?=
 =?us-ascii?Q?Km1d83OW2lML2hq7VKwmLknGY5t1Zmxj/JIP60/b+8Ghp1pAFRFA2g/EXVEF?=
 =?us-ascii?Q?mzRwysaTAv5P63lfx5qnq9hIJLZK/6jTVeCBud5xZkYO3Pr2pnj/2hrUwbkP?=
 =?us-ascii?Q?9K+jGHfbZg6Pqi+848KSgiL1lZBzsDQd8Z7yQmy75bzDNoKbOkQOlTOHnUPM?=
 =?us-ascii?Q?uPXlSootBmYBK0+VWW5m4/xWktnEX04EDw5sI+YXp7fVtJDW6mtoSRSFnRMZ?=
 =?us-ascii?Q?C5K/YXTVghvPj9l/wnEvJcB8841dNHHxw9dieDFiwLm7A6lgPmjOW+Z4u3Ce?=
 =?us-ascii?Q?sU9gmKkZt5S+gh48jXMDUFItNh3o9cG/+bhgo/SAeGskqeDw7ORCPa4lzuQE?=
 =?us-ascii?Q?M3aiqi31Y1W2iax3qqNnT2kcguTidVWCX7nm4eXHgpczaJT/S/c19Rec1lO2?=
 =?us-ascii?Q?AKb4COuhs6szSdAKLTfw3N/X2HjmY71a7gddsCUbD4nPUKulorI9ORkNhhor?=
 =?us-ascii?Q?QPu8NQa/EXA+wn6fEU+0BHRMTECJeMWf6q/SYNlBbZNrwdaZvBplVbQb5ar/?=
 =?us-ascii?Q?wB03qstV1h+li8xf5YEqpDIglrSBHixRhdssiohzOztMgJaB+A7449OKL6te?=
 =?us-ascii?Q?JAncx1mqu5WUDsxuMM5yaT25/YdQmg4BluR9WQQiH+JzFObPg05Dl/8Pw0c1?=
 =?us-ascii?Q?SPSxxnt6vvEaYovSqk3+mJoqu0MUUg97pMjDT+pLjwLhtc40YWYSMO7aI/rQ?=
 =?us-ascii?Q?Kwu9hV4sNfRsHOCwOjLII4CzmozJbZPK4BShT45k?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7f0992-6632-441a-ade9-08dba7803bf6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:35:40.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Zw56RcBMlUndEXRZhlMd6uuaj32cuRBfIbyZSuqRAykIIlz97gSiSe6MQqByOJjvm1tMPWsgIGNUQX2JS1ChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

Add a new helper chk_all_subflows(), in it use 'ss' command

        ss -ti | grep -c tcp-ulp-mptcp

to get the "correct" amount of subflows, including the initial
subflow.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 983fe4446523..a0a87b4c8d36 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1850,6 +1850,31 @@ chk_subflow_nr()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_all_subflows()
+{
+	local cnt1
+	local cnt2
+
+	print_check "all subflows $1:$2"
+
+	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_mptcp_info()
 {
 	local info1=$1
@@ -3424,6 +3449,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow
+	if reset_with_events "userspace pm remove id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

