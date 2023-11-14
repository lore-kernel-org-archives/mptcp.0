Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE7612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="13+I5hro"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0DovCqqVtRPtp09xY2bNzcbPfajsUPNNbW4RY3ko+PKv//XuZGU3SJPQg742r/ncJfwc4q1nmZ0zHtgrfbEffBFY6RbmqkeMOmZsF+R4XbIh9FWliN0muUxhstyT2vMSKhcdkL6p35jpf08KhXid08t55jysZZjAsxdru3ABLVtG8rL6af+IMQJGQ2X+Z2VyvBMhzLCET2lCV8j7WtIpKeOvxW+vfL3yoMTbB7Z7xSBUkS7alQeK6AyuVeVwT2FSrX9joT0+09xFy1yNt7EFlLMQpR+/UWE0GG440wF5+twEFoHTg9OHM8poR6Ut94BWD+3aV+IFN6m0Z60Srq9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R07kNJawyzlHpf3LIoGYdhQd0fUV9zMxON6SSgrlLk=;
 b=QwMnRP41kGXBQFdeJAfnOCYNF+u7DxtRReBGYbFQbQG4BB3XimE4AqHi4wWOYMaJHZD8kxPk176hd4CNo4BnYFeo7Edm0hrL6y7H3BaZeeKgvfdNOlpbl3pdPhDoNJg7t0jRzw9YVFOfuSmMoRlXHmIoS+7mqkxzrRRRMp6kWyuOrfg6+wolHH2DQo3m616SI7Qsh/hE8OrJSDAa5l86BqXb+lSD502rP1LkjLCCTxcNingpb+dkHJHycfC1XpEH56E7S2064pddIDNW1cLJoInm9NYFcVqTm3yvQmDsffhhTWnFbXrNrWP8V7a4OC5LJjGr17Valp9uSX+AGiHCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R07kNJawyzlHpf3LIoGYdhQd0fUV9zMxON6SSgrlLk=;
 b=13+I5hroIiCVGczlkHKy0EtFgyf0iJzaf6DVXiHL4WYCIztLZLBpSAvR/v1c+W3Wz9Ld3gJfV4Kj4v6aVEJqfFwzyCCwbu44fxHyZdbFvr4eDZYQvLBj+qNqj4IOTqdMGxMTmDZW80BO7V9ThUeb0GICv1k2rGewW3mZYC+bTLfq84CrlVh2Ny1zF765GV6BeZxv+lGGjyxC7gWoaxMm9IbwIi2WyofRJ6dyw05Ej64axKckHRhQ6M2rSHojisrFoFdX0kX4gFbmYlTjQg6+ufiF3jM1RCXr6i1nz2QbUUh4WM0aR1b7GAOJG9jGNamosA/mEMr14fhrT2+c9xhBVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 03/32] selftests: mptcp: userspace: print colored output
Date: Tue, 14 Nov 2023 14:35:22 +0800
Message-Id: <76a2aa1487406e12a01e9c3d26d3b9bf87e9f165.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2644177f-1838-488f-618f-08dbe4dc4b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s1XMPJRgrFGzINOT4H6408H6fkrk6WFZxrTPdAfbYDXETkaHiHidwGO5NoOqJ/b1hebkn1A4i1Mm5KT22vV9xLsabLYWDxWo+Ne/QHTFgbPTUfY1DkvGdEgT0O3V2lHy3m8T1gm9AcIKGd11QU9+GsJ4l0Q1+bjmYaxLKi1MzYbyP+6TUzIBjOv1NR5lUmHX/4E5O4sArhwOTikKLOSoC/CUt+tQg/dwl4RR9VW7/RJAGLxGcYnpEl/rbwdHHfhXDcJT+ftjkB23JO3EPk4xqvDwJPd590m8DAKcAuMgQuYc0DAHlshjzgecTKjWxk0N7Ot0zCbKXxZoZsXK/N+8oT67u5GDuHXLKYsDhbzITbNnXhsvkE5G+9wRHvo08BUDP5mtOlkq1IUtwxsdHBU+sxaPF6AR1LpX2pLwvWLpmvm6t0sUP6QshqdE6RR8yQPm/wH/QI8kokY++5PF42DZck8DA4q3t03jqtuFso6jr7dTfUSEBG+GESHZxdaoLZqrjEODGYj72WuAbuzYp4SfMLCP5cnVTLKXZDacIfoMgDUAhqocowx1+ucpPQMvGKCY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(54906003)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zg+qPScfRnbab5eq5pqB4K8GEYC6lBJTMY7vReHUE6auRLftsDZWW0+V5bA?=
 =?us-ascii?Q?dqw86isBouoiBo76UfZwosMUBnh6evTZbaV3RMiFb4wlLe9PiSVixkqbjD5a?=
 =?us-ascii?Q?MtmQNFCmKjF0FJm8KV3k4gURsiGBWRQf/o0minU8JN1LHQ4+Cqi8jUokIa8L?=
 =?us-ascii?Q?fAzi7r8Z/hzq4/VJFRQgT8Z6HnIpiSddPB+7vW7/cXgSSVUJBOcQQbYZ2eo3?=
 =?us-ascii?Q?60pe39Gk/E754zePjOdz+4jRhg4yW7JLMWfg1xOb5JOT8dimj6+ZRBFS1EFM?=
 =?us-ascii?Q?4i3bQ32d+56bHifvD1PWCxVtGX3C8vzvRtgh38dfYQawjHCdYgZJoI4Lwt3d?=
 =?us-ascii?Q?77YszcH5HNPUdPl12cHeqVH3fN6mronPDwX8SfM5P9KQ1CWzEkx5jvtkyY56?=
 =?us-ascii?Q?7pfdMk7vKk1a7qEyByWb8rNSDtcinFT5CyfD7xt7Wbjauj/WJhMaeZvQ0AL6?=
 =?us-ascii?Q?NDOe12BO83s237OGsWgQZ8l/Y4ULoWnKUUIQPrx1s+Q/itFZwMyU2saEUwz+?=
 =?us-ascii?Q?BbLJbyjQ2SbFRcxNmDIrw6FC6mMl8rOb34piQ+yc4HBRoqTrqC6hCmBbdBCe?=
 =?us-ascii?Q?GLpBxofW7I/aFLs6IMIMdluKvCKNF5KMp7OBsDtvQE8EQpWrMMXG6mGrSuF2?=
 =?us-ascii?Q?/T4pbTf2rYx3p4L7M1Rn9fiEbu4AvkcTl4gP6XyysK74biDFo8osFkSZmFkT?=
 =?us-ascii?Q?HDwtpAR6/ia6FXV2yE1y1f+KuOpaCw+poxtC1BT2LNAaeuVr9IJdZP0OW1K0?=
 =?us-ascii?Q?rdN/0zr3UGVb4MQ/hD2e9TSu18K0pMLEi6qX3per25otukl1DG1kd4pOFGrU?=
 =?us-ascii?Q?iedF1nYm4oIhnW3K8Akfoalh78SVCtP5F1lqfXsze04SLwbC0XTgKqyqtzR1?=
 =?us-ascii?Q?eHP/X34yhFYv++xCauFsTt/hrv5nO9kgNNflVs600iN/8Qe9RLNRmUWz1sGk?=
 =?us-ascii?Q?3U7i5XFeaWQ2Fb5skuECk1VC2YDhzWmSrDc+4dqf9Z2hDnR8mc46tFOum8Pg?=
 =?us-ascii?Q?aScYDCDIFADg61/TrLWOWM47cvYZCDtITESPGIIBdMNe2QzsF4fIDqm43/0m?=
 =?us-ascii?Q?q1nOeo+Eq7WAWz1n2Ru6/RHeqAROUD+xwImr1PwXWdY8DNz0G8hiMuXraGBR?=
 =?us-ascii?Q?qxkgDIDbs7GeAPZyKQWLcipGivc+ni9Z/8KHIafdmEqsDwL5Tx+eQZBoq6Q6?=
 =?us-ascii?Q?TqFLArIrL39v9Mol7cCmjScnTgqvu22GdA9th6lvTMQoZNPZPEkTTya7uL0r?=
 =?us-ascii?Q?So8Ex6bNkoVt7cRNsRq0qpbjS3oKP+QVtsYrPA16C6gmXadbzLGZnX4mUa9N?=
 =?us-ascii?Q?Ggm/ltEHh7wSSXm0eVlyD3SOP9oK9IJRKK9JEuyQLeR+VyUfbwJTLaOc/UFb?=
 =?us-ascii?Q?PJ1vu8Pi9wLLjJqyPZr41/Q8XTYozuYF2ACdmgAfX/HOOAaLsczuGmoVRkVc?=
 =?us-ascii?Q?f/QAUcieIj4CZq2YBjxR1nhHZ7UsMDBsX0plCOBx7qGkPF89Ufn6HX3tIwZQ?=
 =?us-ascii?Q?BBaS4I4BHG5+qyQokJ//t2IBZk2cYaNRZ1hQsAG6HdDxOSSyH+Erln0RkCwR?=
 =?us-ascii?Q?DR6Rj4pt8iKdT0CrOf14VzT1AYWRXpRyYG/qQ6Up?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2644177f-1838-488f-618f-08dbe4dc4b13
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:20.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meAcZmZtTIx5yYZr2sJ5a4QAU4yZc/hwDD7//Eo3+tJiR9skX0LtbxwdSgX98RPB2lwqYcwbiPUHTaWkuJEjdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

The helper mptcp_lib_verify_listener_events() will be added latter in
mptcp_lib.sh, and be used by mptcp_join.sh and userspace_pm.sh. The
former prints colored output while the latter is not. It makes sense
to unify them.

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results()
in test_pass(), _skip() and _fail(), and use mptcp_lib_print_info() to
instead _printf() in print_title() to print test results with colors
in userspace_pm.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f1d5cd4ab95a..0614611b7821 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -63,7 +63,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -74,27 +74,22 @@ print_test()
 	_printf "%-63s" "${TEST_NAME}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
 	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

