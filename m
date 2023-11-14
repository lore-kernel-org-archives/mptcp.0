Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B3618C39
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qgrr4klE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PySY6awW5qak31h1GAUo/4vlc5mzoZHGKHWae7jpXQYR1MD0D0RrGfg2cpP6XlBUZwGEUdHKDwH3qmHqoHn9B2V1ImWxxN0JDJJskVBG9oeb++66kbtyfMY+jIJMhoFlZCjiQbgP8zhnwSZVG3Fmc11YBJw0ytYmece27WXEhcP4QnmXcgAaphGPrdv6EJkbpbzCSBLoc8XVDWxhRj50JXxYyP/qlq5VCOi7tmUbAMNmTlYNggxZrJOy7vkxP60ZCFruTToKJi5lYoXBQePHi9EM9mQVmwGFZZ+O/WxIdT/N07flsxGeJS/Vcqa6RzFfzXWFj/NDtK+AbFwoqL5zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvNMoWxeIJtaEInpK0iT0VR1O0bULxCyHqMobB0bfF8=;
 b=fqEVr+FvRMroC3QdfvXaZuSN9fQtabj/hKJbldrPSSZDgOkgS5NW8Q/X0tJR678U8g4jYT/CJx2AWuIUYVdC6OnkvlLIj+lqwhuwQgnPoJlNBLYFWJFjnhMN0Rn9I9mRvyYk0Fls/Vyx8Pt5yFF6Hqn/ZO1CXozM0K5cgd+/lx1BYKO/pJJgv01dF7L9QpWPyvGMnZVf+Jeheyhh7WM7KJxW4Bw36Rrjm9h6nH+qVwHlXbVJ03QbdSDJ0twRtTWHfVycSK81K6vEqJhYwhitqk+s/ehu/tyJ5h/5NhT0hfkRM9FpTybAkGLCkD+vjEiGpAfAb6U/LFxgJUQ35ZIZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvNMoWxeIJtaEInpK0iT0VR1O0bULxCyHqMobB0bfF8=;
 b=Qgrr4klEWaZxfMOGnlnnHVzEE+USB/1lPn3nRE5MSk8hMk/SU1YSiHzg/xp1ej2RXmlc4DfXSNMW/p7wyyhW2a4lvcqtZD5gpszLGLzEsHRE+2AP//LB1P0d4KUokwCFiSuw5nsgTxCWqaDrd8Isil4yHrIYVHTcPMJu6mTdj+wVTOgsqmC4o+e47s6QxzJ7SQKYtGMpnvTx6Rqq99Gx7/gcGRZoHNbJfkXxRYZlKxHOtRHODvK4N2sC3qiLCB07RoN1dsFrhBpuuHCd65cnv54XEkEF5rrOJUsijjQrdBOOoaw5Pfsq+IRtSpDcH+KCeB7AzPMwYTe6HtURjSamqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 07/33] selftests: mptcp: extract mptcp_lib_check_expected
Date: Tue, 14 Nov 2023 18:21:37 +0800
Message-Id: <b40b3f4a2ce9588f59b571f0f19f2469c9242290.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3edded-68c7-4a99-eb77-08dbe4fba011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lZDd7Nch9gxgl2599Dk9ILU5MCwdP3Y9QkAYait+BCZPFWakrVT//6V9JgFcv256mR4lwlMjviIwYGHOtATcudcMi7lsKK3nJYL/IqEDPmHhZvr3VplXWVEt/IDgTIDrHik2I/vZND5ibNggRb++hBZKXtDd9X2NrIaGzYfY9xMyNpjvGzRmZp9uO4zjuVpHjtbp5M194DdUDUbmBkg09P+RYFxIAtSWBZvSmY7uXWAza0z82cLB8UUQvfJW40q5/Q19T+AXK+c7K3TuC426J9DLT86gC/A6AFrrp5uSXuU5ljNwVkogfUu51UoQD9ZFWGlC9cmT4gwJTL1NypL1dJPtSy7abVtLJw7FJ62/o1foufFGq99WqgRwU64D8YXGL/FxmVBpQvpYuqm8GkTeGlW0n/u0ttXaIkvMMeJYg9swkH6SY2bebx0N45dRMogq9JJ0mZEr2feuiFhF74XDKie9tqGmnJiTbaDygwwM5BgZYZNmR4pNaBljvU7YLQdoLyTWbWCV5FEa8xiRldEvc5YaTBXc4OmUMt6GTh8hcNhhFcljq+GrKhznv0MhOulT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xzsdczkUKiRjUOyuwKSRc2nvG7JogeBs93lQT5QRxiDanGtGgFQopVcwB2G1?=
 =?us-ascii?Q?ufTE7mfpJMJYXotmXnBIy0LEs5uG2kWcn6+O1jYF7vsOHtqP7isLbHYWfRGf?=
 =?us-ascii?Q?4HU4DRCpTiK2jjTbzIizXYTDHeuBATUFklzZQbx/pfDMVlqIOnB9uJEP4L+U?=
 =?us-ascii?Q?8n1s+w8XrwhAQJ1zaHKwwBKe5m/z8AtKT5IHLqNj5n3J1mkCUB2w/wJoVvBV?=
 =?us-ascii?Q?8mrd5CoiQvCNjBpXxJAaO9fuF/q1ge79PI4JQQZJsxdQcLH/GsXHvlE/Ow/O?=
 =?us-ascii?Q?0yanjXb3ELC+UJXQm6keMdk9+ahOkSfO2/W42tE6YOakUvt4PWfG7OROS6IE?=
 =?us-ascii?Q?QTeqxlgv8mA8+ryMKAl8m3YnrktyfyldRP1PZHnji9r7TizCZ0NHfm0T0uVe?=
 =?us-ascii?Q?EDVS62sRHjcMLQQpJWI9hMp+bc/pKg7g50jvqvoxZKnr09+J0E18FxA38qVZ?=
 =?us-ascii?Q?S/KD+Kji0mAgJqoM5pIJ+pvzojCOVbX6Bed8Z1cAtQl6yZLSpZpUSge0Hlia?=
 =?us-ascii?Q?LfDaCAbdJ0nZCtR+1DqFL7tx/2JOwYW7gAc2rhe9qhYtHJ5g+wUxIC09CSzb?=
 =?us-ascii?Q?JXBMcRjessLSStHvQypW7rFaIYSwEopx1isUw3YCclK115rhrUvGrj9vnnXE?=
 =?us-ascii?Q?O8F/s8qiouL0Qtg/t+EX3izrBQLFA73L4vOmuFsjpS06stndLm/b8gRhplrN?=
 =?us-ascii?Q?6lvhvQbMARpQ8ZpLred5enQjnF2+hB9isKiIueH1mA9kk8o8ASQ5/Fgv3Cdt?=
 =?us-ascii?Q?Pl+ed0b47ZKW8yvWBENGANBCt0JRVriuALOWUf85p0H4D6kYT629y2o+tiED?=
 =?us-ascii?Q?tqJLOLwMsuxEuTHjwGjNj8pmNjb1mCnz/cLuOtzdTtIQwsGkqW8gGvZRdOyW?=
 =?us-ascii?Q?rMOlNk/rM1i/tfzRo2czIGYuKqitayqDmJA7qsrVo+BW9Yds7OPGPqxcBAcu?=
 =?us-ascii?Q?2447Y8FSMupgpx3ohQs8Wkkr/H6JJfE3KNHGZUC5Wl/SdBLWEFdE7Nspm0gJ?=
 =?us-ascii?Q?OCD9gRilcFS4e2O5KbfX3k1kEjU1B3nqJBFCEwljltMc0dnt9up/UHoE6Yf6?=
 =?us-ascii?Q?phJ75/LPtfWF/2iXdX40bi3tbSlHNg9wQO05sF543Q1t1Ujv0J3P9L7Hw3tb?=
 =?us-ascii?Q?SfwqU/knw5RIxQBJ/3L4CmFmWgWz0G51C7Ah+oKPO6l4u1E/qHsP/CY33aO3?=
 =?us-ascii?Q?Y4lAaXaj/UOVPX+jw1Jd7VdqpwrK0JiOG89vGxG/OL3xiOe8rIIxS/q5pwd2?=
 =?us-ascii?Q?gLpPVQA5h8uWkuJF8CKDTKi5Pc5sEzXX1M7QvAVizK/Cn3LtdbDIeHGwTTcz?=
 =?us-ascii?Q?Qord75SKPFJ3um4b2Zp1v7L3T2H2MKdj9p9JF1ZJuzkhVRwovRWbAYYJ4FwP?=
 =?us-ascii?Q?N20GXRNkwerPhr1Z6TG4MAe+T9ZWpgV+IUwP8TVAmo6Gv2kunZtuNO/C+H1D?=
 =?us-ascii?Q?nVJ6VZ4mOh//4b/4Srz76Az9qgS3w9MijMbQ0w94oJlLOPBt1fGuYxRrCS8N?=
 =?us-ascii?Q?oy7EcI0Z+/aj4fuXdigWvrdkWj3KvXmJOdZVaXILClU/TTOmWYjtfq0Hx0JU?=
 =?us-ascii?Q?Gneo7O84BjHgfbU6NoA95TOrOMycJO7j2FlQkAOHbmP5Ktc9wfcuof3j4dPk?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3edded-68c7-4a99-eb77-08dbe4fba011
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:37.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkAPYqUXE7OGXzK3sTi2XnwMOJPjkxZcRYliBBw7bajNbgDjauetIUwTVlGgrqd78AHep2hmZ69c9vR6au5pKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 42 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 41 +++---------------
 2 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 88ea621e7df5..3d23783dc307 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -391,6 +391,48 @@ mptcp_lib_evts_remove() {
 	rm -rf "${server_evts}" "${client_evts}"
 }
 
+# $1: var name ; $2: prev ret
+mptcp_lib_check_expected_one()
+{
+	local var="${1}"
+	local exp="e_${var}"
+	local prev_ret="${2}"
+
+	if [ "${!var}" = "${!exp}" ]
+	then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]
+	then
+		ret=1
+	fi
+
+	printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+		"${var}" "${!exp}" "${!var}"
+	return 1
+}
+
+# $@: all var names to check
+mptcp_lib_check_expected()
+{
+	local rc=0
+	local var
+
+	for var in "${@}"
+	do
+		mptcp_lib_check_expected_one "${var}" "${rc}" || rc=1
+	done
+
+	if [ ${rc} -eq 0 ]
+	then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	fi
+
+	return 1
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 7de2ca99edbd..a85eb83a61f8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -237,46 +237,15 @@ make_connection()
 	fi
 }
 
-# $1: var name ; $2: prev ret
-check_expected_one()
-{
-	local var="${1}"
-	local exp="e_${var}"
-	local prev_ret="${2}"
-
-	if [ "${!var}" = "${!exp}" ]
-	then
-		return 0
-	fi
-
-	if [ "${prev_ret}" = "0" ]
-	then
-		test_fail
-	fi
-
-	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!exp}" "${!var}"
-	return 1
-}
-
 # $@: all var names to check
 check_expected()
 {
-	local rc=0
-	local var
-
-	for var in "${@}"
-	do
-		check_expected_one "${var}" "${rc}" || rc=1
-	done
-
-	if [ ${rc} -eq 0 ]
-	then
-		test_pass
-		return 0
+	mptcp_lib_check_expected ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
+	else
+		test_fail
 	fi
-
-	return 1
 }
 
 verify_announce_event()
-- 
2.35.3

