Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0962F
	for <mptcp@lists.linux.dev>; Wed,  8 Mar 2023 03:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5TYzRLBRDEqLxbbvjfZTrbFpv+ZktDf8ie0SYl3MF3QtaTT2GKuMuDQcwZh/iEbzo7Od8Mr4lFcWvp9Et18AqeDUKgCM5BumhcGzBJguFxxMeLW2myjILikD5xheD2LJM3e1ab2PrnybG0zcMatsTzlRqoLkR1+P5HNLNSSWQvL4XHsaQkw/SBxuh345xXzgqXaeuLJGaQFeQTiYoAp2HjMcJh7GkxxFEUfEtp5gPLz6LZC/qlWJWn+LH4NKSN0Qq/JnM45h8OPTZe7TNnLdL+prrxkySNkDejLFaDB/G21gDdiXum/sQ4/5/YnWTwNOAZWmNqjgW14flNmzfloGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEXtqdu+u1zyPxNM43/ozX63PQCgye+zVMfnrlH0/qU=;
 b=iSZ6rsWS6IqiN/q2wZ8Cnh/0cozurA6sYbPiVO2Klos7s3hCFqRVljMgaJy3GX3VOXxgNO5teF+0EgVR6P6X7U7WylweAlalb2WlYxssF4qY5n+kZ2oDsQ33WFtFrOcrL79k3Xx+DmnvJUkHZOvj2EdaxjgSlCxuFxnSttwWU2/4ZSDTJtK9oVquqKuiMYATkVoudvgS5jk0YQahK8VJ89UMk/f1j+brv1e4aPQUFpbI1SvpzcrRsbBESugfG7GCK05A5vjiXDw8ThZQ8pDe2khsbcDEnZ7/WV0tSkAtmgSujoY2ezxR6XrOjW9GYmS2dii3HEeo9f7i77RQyuko6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEXtqdu+u1zyPxNM43/ozX63PQCgye+zVMfnrlH0/qU=;
 b=FIrowyib+5+oUkgg4eo8x1mWSZ+B467ExQ7r4rsj1dZVOm9CJlO5qW4kKP9Kp+W1kDykUiQ4KwTe91LqK+MTfb1ZhNnYGpzVmrVJ0reBWoJxlSh+HMIvVLWsGE5Zt9Iv8va50JT6mOfa78wpe8UDTnh4WBq7Ejvi5juhgEWUqC4IAFl1WNCa+ZNHlmQumIFX/pZ86GGeG1NwyjMxyn6OUVnxEjr8dP3EK4RhLntJICVyCu7iO8/xsOS7GcZzUzKoIbJRxIFz5lGcfUcVpFv881LEiNvMFXr69x8288MPnZq9P8QEKepgn3x8O7jem16PLVkC1rWBtlO5SyPlFssCUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9712.eurprd04.prod.outlook.com (2603:10a6:102:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Wed, 8 Mar
 2023 03:30:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.016; Wed, 8 Mar 2023
 03:30:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: add mptcp_info tests
Date: Wed,  8 Mar 2023 11:31:32 +0800
Message-Id: <20230308033132.20581-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: 78010a4e-3a84-44ec-b70c-08db1f856f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7b6bxKjcUlZMxVvj2b+uMVN5inYQZT33UMYtR1NR2Gty8TD5a1jb4ogw4teXn7WSC5au+3vOB14OrjvHTTdwCEK8m5rfK5sg0rP0RLETHVbxQigHFllKDzdJLmcTM53ckZeK11wCZJTksZqyz9XCLOMIe2SFsHQI+jVq/samOiOvO0A8MLShFWlramTN4+u8LSAIkzKfHY/yfrR6/UB3XsMvMGCZmOEtt1z2LU8I27KEfsCFBSSOu1TjVxaH6kyib3ZAiMYhQqKNlieZg3hYWTLj7gzOKmJiPXW5yQeBEAsJ/wn9nEQTg9CDN+HHXfzrzY+nzqxiEbrEUwPciQeQMhVBvbF3njVUteWDqpNIC3BY2TGGxjl43wWCFl+vV99QUquD1Qin6ee1SR0CFmLfazfYrgkhiVlrSeszWQmtm0r3aYTBk9RzixOBeo54Thr4karZxu/G7HGQ9jT9RAVm6JUDk71MnsCoWa4cEuCcjTpgBhKf89oFIgkctsjKa3l5Tr10CM94TpWdqNboud0LtHI/wKFJdudfdG345TkFszfnVdUfQABGdiJNzcgJyhhaiAOcan+tM0EvMDafL2f6bYHJYLLEYoRTswH/+RWlqhj0Rv9SmtFgq/Ybm7Ipsrfo5k+GkJloXxQze8qSLsFqD06CbkXSgcQr0pKUV2/MCifwZ/HLkXKl/YdgY7xI6SzU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(6486002)(6512007)(26005)(1076003)(6506007)(107886003)(966005)(6666004)(36756003)(83380400001)(38100700002)(86362001)(186003)(2616005)(41300700001)(66476007)(44832011)(6916009)(4326008)(8676002)(2906002)(66946007)(8936002)(5660300002)(478600001)(66556008)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yXo94jzfrxCnR+AaXYbZxrt3nSfKwJvLqpAZzYf9I95YgsxQqBciKd/yprfu?=
 =?us-ascii?Q?FOGNDtOEN/DT1TrTd26y1xEeHOi4EyJ/5RfjUs2By9Q89jD6sxaf8psjCp72?=
 =?us-ascii?Q?jg3KPCHcozQ16XXYeuhGKGvTKfkQFZ0wuelDIT6pdm0GTFtrA8m3QhjkO/9l?=
 =?us-ascii?Q?PeUsFjGTGqf/TzWCjiRoth50Eeq0uagsspTVzFSDgzTnJToLAjHS+McBtqXE?=
 =?us-ascii?Q?xqMvcecCYF3fp52nREODjsrXNqXxuHbJ9d44W8S0q0f1moNbxQkzYLpe5iQQ?=
 =?us-ascii?Q?OKwLH0gBY6CtkxxSyoxp6r2NrlsNP0DzlPXUfFaSnBoea0K4CCSXmUhAsgP9?=
 =?us-ascii?Q?NOsGRqNwuKfuk3COexbteAwLhvywTT8EKLlYDL9/xoLZX/YUpCoVVnw7OMAq?=
 =?us-ascii?Q?597SjPQE1KMDj4MnDiyzVGeQX6lCNL+wBNN/F2LBGIXRSwFmcvg4Fz1Fs4r7?=
 =?us-ascii?Q?fADzDLU2EoHsEg0tW+wcGeQipWreWNKylhr6X5xT8+4K4dicSsRm46fRC2G5?=
 =?us-ascii?Q?0D03TPkm9xsHb3Wj/bAWx8gtPchVGAGfZMiYiQDwShlqcqvY3iOBMav0P9hX?=
 =?us-ascii?Q?GQTqdHtKu6Ff5pXo7yGxVdbxyFO405gNm4gW8uLWNx3WaEEr3IvgOF29kvko?=
 =?us-ascii?Q?LemOa2Z8cB3xmbQ7GsRAf7hjRrwPIlBHoKpxKM/KOMJ35NGG5o3qKTPv1NSp?=
 =?us-ascii?Q?JFOIGtcH/mzVszFyaGjB5l2fpf4ySGqgAfZnxnfXW3KzqWAC+Rzyk95o4ieq?=
 =?us-ascii?Q?BvG2RfnUFSWTJyFQOBh7uarMCeawP/dFJTQeT3NBe5shC7HUuijYpPbDF2ua?=
 =?us-ascii?Q?90ofoMtHqFjPIT77IZJGbE5Ev346G0fnzMS8LHRc57r4iyiuWUFr6o7OoE23?=
 =?us-ascii?Q?B9U54fufyZ8H9hwMT4Q2Ip2DbrsZvAcpCHuur4v1yBjT5LWS4mbTjoBXaM9B?=
 =?us-ascii?Q?sMwTCarzbhaDDrgh5k2JcIpa5DAnyR4OCid3CbYLLZhWzAv3py/gQogm6oWq?=
 =?us-ascii?Q?rwVOtNUVv08kl/lCySB9Bd4yj7iUiaOS1VUpHheciX4jWzImyZctGyhE4WRt?=
 =?us-ascii?Q?BTBzY5OrMMlH12aBX4RbGFG7/I/XuIDOTfT9ocjYLD9wv+hAV+JJUvWUjJmu?=
 =?us-ascii?Q?Ov3nkRr8IV5GDJZlHX8I9a7w15ZAEwf9pBpaoGpsKBpbydHVsZTh0NZW3ZG5?=
 =?us-ascii?Q?egy8WDpefeFRU6JXl5a0/8+pvoZ8bdOGHwMoF9BdFYxQVE2FyyVSP4FAUFKc?=
 =?us-ascii?Q?LuA3HhDwhuOLmNF2URwFosJIfmfi6lyKlxM6Cheel21rxe4VBNQ8Gvkfd9sD?=
 =?us-ascii?Q?H9HOQRCAnWDjXUWzUjL9nHgaPYkh/XigBt9NZcB23bP8elIqmIkfG/dc52rF?=
 =?us-ascii?Q?CeecLXU/iqVV9g7KG/UQjkwm65ZWopq7yMb63WW08jIk9Q1esEQdqBrUkVUS?=
 =?us-ascii?Q?t7laYc1HS3MXJFGVAsp2+EJCI3N/LexXUQQwjdVPnhsayW3Z2FEwgPeIAMtE?=
 =?us-ascii?Q?hur+h3J+JLeNXtTCrX6auhzsicxr6hJyIXzd8qzqNx4dutwsfTGAAlC1SCl5?=
 =?us-ascii?Q?lfFm8yO0ki7z8+jTwPAJmdOdnCW+SYREKIkKqUvqGoMBkpQgcF/xDOPS50td?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78010a4e-3a84-44ec-b70c-08db1f856f88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 03:30:16.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ORfACOzWISVC7Olao0u3Bbdt7dxnlBcrHsGXZ50XMFXom7FJpB0PMhVPhOIKNH1uh3tLg+XVcXjguowKxVW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9712

This patch adds the mptcp_info fields test cases. Add a new function
chk_mptcp_info() to check the given field number.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 42e3bd1a05f5..a73013463c86 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1719,6 +1719,40 @@ chk_subflow_nr()
 	fi
 }
 
+chk_mptcp_info()
+{
+	local nr_info=$1
+	local info
+	local cnt1
+	local cnt2
+	local dump_stats
+
+	if [[ "${nr_info}" = "subflows_"* ]]; then
+		info="subflows"
+		nr_info=${nr_info:9}
+	fi
+
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ "$cnt1" != "$nr_info" -o "$cnt2" != "$nr_info" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" = 1 ]; then
+		ss -N $ns1 -inmHM
+		ss -N $ns2 -inmHM
+		dump_stats
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3129,6 +3163,21 @@ endpoint_tests()
 	fi
 }
 
+mptcp_info_tests()
+{
+	# mptcp_info subflows
+	if reset "mptcp_info subflows"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 0 1
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_20 2>/dev/null &
+		wait_mpj $ns2
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows_1
+		kill_tests_wait
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -3177,6 +3226,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	i@mptcp_info_tests
 )
 
 all_tests_args=""
-- 
2.35.3

