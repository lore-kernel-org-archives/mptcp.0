Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC25693
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mach0+Od"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbmBlpB0IikYGq8QYpJwxh0DxMt1+25sZj2c7qyWlr56iOLSVIc7b8P28bAb6D15UNaYtTvNNovq0fNR+J5KzxvhvdvdgehdDXLGo5G+HfG+88+MuR6OsgCmRY46wFjqRTHjzw9hT3crXeiWNHFuw2q1j+NltYEn6jgRV7KSEzMQXlGz6qmItZqklbznxsOJpxSJsZrkEtF8c8J6o/ceH371NmL4pVDosDOmuj2AlM1L+xhz6jq4Spt/MhGrKKnoei9+EnrVqEQsPDOSxYe4lTz+HTvyEXBlBjmZBTeVGe84Rc+D/KrMlpBoizVVl5RXKWxjEst0kZbhMWTlmjmN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDfKp6Vy75CFTnGdjVfQqABzkDYyW71oMUXyQ15sijs=;
 b=aL33HDtz5VEMwaus2tU8K+jHjYCWN5XnUyZlhNoxKtORgEWVRIUEGGzPFClOa/nl4zy0PRYlmwc4ydXfqO8Yle/RlrHFxHZ1rP4+VNPwCwk7O3rwr1Qvfb+5nCYgYVR5I3lUK3Cu6NAa2orYistZL48G6fWM/KlXM14ztJhYfBACINmHOzWIRWdqrvvzirvYZLhLg4/m5YNb9IRE/Se7wDTFCiOITouBGc5qXkNWHq0lvsdC7NSnb4vx2XuVRB8iuOO4me898Q/oD83f3jeZZOQ4sPcIR7O7arNQ6Yf0TcwkSUPPAsgWA3oHra6BpmPTso2sGRA9feomr1JMkgmdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDfKp6Vy75CFTnGdjVfQqABzkDYyW71oMUXyQ15sijs=;
 b=mach0+Odx7PSunEjG5H/Dpfpb8WSg7MssFgMLX1vskvvPmtfN9IqGMayGcFSDAo1pii6hrpZ5RqStD1hQHjq7icR/faGuHCFg+2hZ+06ZNY41ithgxUyndOsOT7WxpWtzk5MCwaYIBaYfO/+vQ9opMOMjrj6fVHAAkbs4S+3+hOGLYgD+/3uOOYG6Q7AqS90BFCnF2fz7U4llvK69FgcQp4cU9jxQCHFY/j2RPuwNe6qjpmJHIkr9mPw9y4NJpYsOJbXdcAPxyb4XfJG3N0DQlZVBjWAwvkxVZwOZta3bzsak8fOV32cv5Kic2xroI8xfmlrSuZMVlrFhyCBIDF99g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:46:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:46:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 5/8] selftests: mptcp: userspace pm remove initial subflow
Date: Fri, 13 Oct 2023 13:46:40 +0800
Message-Id: <0b1a1a0c1a7e6348bc09dfde7a18631570eeccdc.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ef6378-71bd-453f-a28a-08dbcbafb632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9p9vTvHOgyR9nrSQIDFoPrek4zyr6CIlblM3XVVNrMF9mn0gWPs+Ww3xbBeQWDxNSYOIUSjgEqfIpmLjr2z3bmEltbJ6d9StKDQ6QK6q/E3uHdfceZh9eNpE3CU7+jxqByIoJHRr51r9qGRArPPkjY0X0HcI4RCVpZ7quImoXcOwkjFNXFruAzvZx6EaQTXJhjulJE3U7Xk8VLunR5eJpLcA8234oswTXgqhqvP+IwC9hQ/WtyEvJo8hdRrDKv1kLQvqRuEIpbjM5q8ud8Zj87z8wvgo9W4gAi+yFUiCOD5Ry81bIFbvMssgr6rm12xUZeawsuyXSv4XYfxo/b3lLeZBJFgpLY5KkKALGSREu6GynhDnsWD04n14kAE327Qe93KzP5aTQnbXYhfcQokZzGvxCycT3y+v1oeF3HdA7qkI9Sdn5tcX8Wgtxf0UFSV0hNch6LmM//6maGrqYjhy4EN4OsYe/5vd2AzoNl+bP+TWrKY0slY/2Jo5htZzBZ5AckxNtEtvLPfZGr5qvCE/ClcJuDFluPD0xW5ksULirYg2vOI3cwJDxy6Y2U1bP2+gJa7anmZ4Rmz6G1gBP45DGjMdf7IMLOF4oRWBr4Vlwas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(107886003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+mxHxWyq4EyvRLQyRJ1zBygW82mKFj0M+vBEw3oX3xUAMq+xtr+UwSiYCTGN?=
 =?us-ascii?Q?ei8Gvb9Pe9hnBXzNNcROOawyr2lxSFuw07DxFYM/DqNALr7ZVwf6um6bUfl9?=
 =?us-ascii?Q?d98lnDR2BvBlUOLN2HTQwpt5g0e0wo1ZuveQXyteQ0qepNTjsqdbKIgd9rjM?=
 =?us-ascii?Q?9qvoS9qNd2AGL5bzwEbs/Mb0bYkHONJC3qhh36XQ9zLDvt+ZNeHCw+JAvhl1?=
 =?us-ascii?Q?wb6HAYPc6+YIry3/ezExS61Z70g+jD3qmHwQpEi1EIKVsCI5ShjofSvvKqmL?=
 =?us-ascii?Q?dVQXhAt63u1OQvntgErJHLzsdNbgWimDQmdaRlZ9QkHbS9dfBikdiQ08Wi0O?=
 =?us-ascii?Q?WphH+qN3UlnsijILekJkAWsmgFZPjQl/LzbSGhcqfRbxALAGRHgSjrGlqwa0?=
 =?us-ascii?Q?J3kPyk8KiZNCvadCjC/rk8zmhEPQ+5Pc1DCuCHcM3LFq1qH/StiJ1AZ/iueJ?=
 =?us-ascii?Q?4bupKoB7SVoT2nWrD+a804r3B2YGueU6nVcSk2yZ2EW76qm8KPPdBFAE1rgK?=
 =?us-ascii?Q?59LMjJ43eUc1N1aU2XmM6RqxV1oD/TuZLViOm5+5rwrYLkr5tR5j8PbYCBWK?=
 =?us-ascii?Q?gs8m55u4fRB1nlkXj5n7g5DXbYeGg2TJpeg8szwjQt6l/1mtZnFkEm3tdbpj?=
 =?us-ascii?Q?IkSvQ0274/cFuzCXZU+GmMpGpSY0yAGYIG8CR0AWFPpg0pMgGdVa0S7lWE/+?=
 =?us-ascii?Q?GAnQyFwnhm0c8A3MMboPJ0OZ010fF6B/D+Dx1b/kCiTiUsKInKtBF04vPMTD?=
 =?us-ascii?Q?hMIyIiXMjEYOPPQnBT7zZok8cZg2VxjKyraUmmkzWIP8H+V0NbpyWZj0HMLs?=
 =?us-ascii?Q?fKxCoM9O7CkQhcw67twm3kKE9nVkwGxLd+Fm9LpJAOL7sKCKw1wQmGgaJ8j4?=
 =?us-ascii?Q?EwtLoMbjCtSdZ+6ciO7UkpV25ApdsUU7LAiFLLTYOIRJlGm5xm9gnuc6Jw6M?=
 =?us-ascii?Q?zvh6V6VPDitay4dUjMSX369PPC5eZLVF1x+oRF6T5VEb68YecsdI72+Mdhwq?=
 =?us-ascii?Q?ySxFc144WvO0NefD6c1FfMfy7k504ALdhnI3EH7FYTfbRqJJSvQJsoSN5Knn?=
 =?us-ascii?Q?yMNnzChEgKFc97YfBTcV7//AoT9fs58aGyKEk0ZMtRwg0kas2lH0moBVQtcR?=
 =?us-ascii?Q?DCFcxCorRPoIfj3i+se1wxQAxn9t9+SFtePZdgkflsu2WdhhVKo1JTRMCTuh?=
 =?us-ascii?Q?wXlaTJfSVKoBEYd3lttTletSHrsqZ/A4sl9+c8YCi+bJ3hs4dij8FUAE4f/u?=
 =?us-ascii?Q?rGO2rn8AyUi40oMcWd2925WOfawT7wo7EYx/Qc5tjVQZcpPIoNIfoWjR9lab?=
 =?us-ascii?Q?dt39tp754OzFlQMX0fbvCTO0dDZ4l3SONzB8LTIdDg5kGe2g0at5Qt17YFBs?=
 =?us-ascii?Q?zRCnX2GTkCJsHFPZGflqTtoI53d//BjKzRBoeGja9fdzsQxXDps8+u2G3MXK?=
 =?us-ascii?Q?yDSeynSCLN576ENG6iKP/M7V7eTY/zmWB66lZYDVogOOOVNRipUupPBWmD3F?=
 =?us-ascii?Q?9sWsfDxG7Z2QKOxRsXj17+5epZEgHyF4acIOad3/xBU1Wo9lyQaJFPymmqDl?=
 =?us-ascii?Q?YkG7XXU8LaInlSqCRHR6cl+u+dRsZCMIV8ZCXjcPqkVVx6KbkWA1Uzm5TAyu?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ef6378-71bd-453f-a28a-08dbcbafb632
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:46:14.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISBADZM1NKH3LRn8UofreVq2JlRpBMZSc7IaS94cqN1+1eIh7TAqKw0yfAfdXoNzxOW1CXYgyOKtDGR88zEoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

This patch adds a selftest for userpsace PM to remove the initial
subflow. Use userspace_pm_add_sf() to add a subflow, and pass initial
ip address to userspace_pm_rm_sf() to remove the initial subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 74f40cdf97c3..dcb8464a5f65 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3507,6 +3507,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove initial subflow
+	if reset_with_events "userspace pm remove initial subflow" &&
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
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		# we don't look at the counter linked to the RM_ADDR but
+		# to the one linked to the subflows that have been removed
+		chk_rm_nr 0 1
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

