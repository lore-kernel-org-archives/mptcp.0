Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12097F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G6lcIc+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+oBHT/ti8U/nbyWF/6UIELiYiH1Wf7Vgrni9JuJIBeQhTu0vqhXWYXiADbw1R3fO/hWRAgLSO8sQ6pTLMws7XfJZ+BkvDmQHx0Puc2moDVcarjF8g7YsSmQPTgnpIV9aPgdlNB25NeoblW46XG63IQLND/+S+1xXyBgu3gdCdrO3pfxs+DLsxJnnoYGmpreqjJQpT1jo3NoSm8GKJwT59jalMFdyHjENIXSWHiW4kBjowEX/B/eVqJN9drzD2bHj3w3Pt2+TP2kK576E/XsWcSP3iiiPaK2kkvF7ZhjqXVFzZWFk/xgWmZaYl8pnsELifZNSGUefH2da39HAxcV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coctbeWPn0P7meuEzyozO9hESLQ4HhXlUqCF3KVkxLY=;
 b=EkS+9kXc+YOajMtHXad2Wc8fIg8qixEGkN4lU4j1JCYJccwzLtoyVeiVFeJaJ9ZUw8X9gtDfaG32EbwZp99AEVw3ierssCwl3RTUvkMLJSPbIasvUkfvBZSy7yHaiKC+EPZSWG9WDwQq0b3ObReinasYFGBM76EOaTYjwJWuEPa4EOM/BTvzoXs0EBBKXrZ/GwGMVXmHSWkIeZqBHtIfszNmtFfGnANRQhsXmvbr1EKZPiPu6o5c4BL0egbm+c85RV35TDagXhjXY+/XZ5xUKY+8SiDvvRlPoaRTPQss0pxa+Oq++JsJh8YWxfeUgb4YvQuX8ymtK0MP3s33Um0Rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coctbeWPn0P7meuEzyozO9hESLQ4HhXlUqCF3KVkxLY=;
 b=G6lcIc+vVIMaBc9ZGSLlZhMm8e64hIQojSngQUyD842hkCr7e/zM8SJoPuI1DC9FXap/3US04ylW7Gi2HgrKQxtt9ZAcS2yQB6M0jr8MhzwwLatbg45+N78dqfUM5Sua/WZIxU+pR/IN+xlpcd6LKgjnXLdavoqGebeaMNKlNiB/26S2LwEoZMr7F2MWH7yNFp9xhwZeZKeGhiXGS1RNigy7JDeq8WO1j6qsR0E+P1M05Zekg14c0MPNXHzCAfUObd+jMbKECr6DPcN6Vsb/eY7y8ju9c7SjaOkeUKX+0p6RJVtZrTwg7ervFoyp1wTMuUZ7Yr5R79VABX2kP7D8FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 7/9] selftests: mptcp: flush userspace addrs list
Date: Wed,  1 Nov 2023 12:38:22 +0800
Message-Id: <9c0862fe938e836f6d28e8ada391232bf6c70a0b.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 78198c3e-e8bd-4f63-d5be-08dbda94770c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CTaidXdD3W2tFAhmGBdxEDP2jkp7/H9kStjt9hzuHb82SeQjecBOOBDMyZ1EE7n7U8JlQfrRf2SwK1NrF8NQNqZ+cEc+bdmDmGbGzRw5htUmCXi0WSQT7O/O8TD41qbyBsqVd76IOtypl7QIQ1zaRlEKRc+mjN1xg9UHa2XVTcpwYgrvcc/UUujHUMJ+xXwYks8olNbY3Sv6aK3wbLwazPDn+g+SCi56j0mr8QDk7H7ycmTmpF8F+JQ7FbC0j5KZHSYhX7CrJ0F1CUBXND1XJArEXLOxVeitrtNrLdZrYkrKeHyhknas6TDHnE5Jk8kv31jZA27MSUIdR8Oo/vpbwdgNmrNWSjXbB1ucTLQ0C+lI1jGAVRr/D8DcfFwaJ0A4nQlaqS8Cp4jOQtcDc0SGCRRpS5tXHG1fvlU9zNkRKz+PgeI+VGvLhYpjxIa1uDlQ9rj/rGKr9Avk6FqMzyI98NCLPJmSxOO1bH2tUwUTIO+vSI0BIq8RjQLCYKrgEbL2+QAINXtIg4gq6Le/ZSX+YGy2ZwZK2e8EBMK+/Cn0gGXJlLGPOtGgTYZ0rUQcCsfk6wZqKnzUm6vwVGFJSYkxdkTFR6pZy0JX/jegZV7tJps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGQecuotyeJMjmZ9sjNMmEjDL9WgfII7NAVGuuE7is67t6WiHgEvnwJQAzLZ?=
 =?us-ascii?Q?ZF3Bwz7Qghj7UdHcp7GoFbi0XJeJGiI1YW3m0ABtVy5oI0Io2blOWAGkBlvk?=
 =?us-ascii?Q?dBMnPEIgP3SlRE1DGb4PuY85ulZVMT+BdHpSoVgkXEFTbbJsWr+E5/rM3d9o?=
 =?us-ascii?Q?ADcBWG2xKjgcAM0E4fGxl2qXsUeKaprRcFJ6NodXTq0y/nMpSzkmwstIvK0h?=
 =?us-ascii?Q?TIvEK/XOVQ+iaMIr1lWm7C3uxxQSFREFCXuFxH/4eJPt0V+7BU7k18Pw7GrC?=
 =?us-ascii?Q?aYl0rz96efW0gzAWFlMmLShYQCQIbN5LJ29icx2tTWPkWWKAQlW5AdQDz/gO?=
 =?us-ascii?Q?l0A214MjyI5xifeHkOyyu7KDS3D9b9D1qNozp5HFFR1BIOw0N4Q205L9LgQM?=
 =?us-ascii?Q?dt5dQIlBSo1UKcXhy3bpnQtvmwM4wEfx67R38WSatfHYfpaBewvoS64HtnQB?=
 =?us-ascii?Q?/zRNUY+zezM861UrPTLZ44/e5aRyPUgL3wPBIMxrhNMFfUxlMj6oH14Wlzq8?=
 =?us-ascii?Q?WaNvtsA6SscL3mpW0zGaDLspmIXRQGhiXPdNJbNigsn/VYa6U/YRAfJYkH2c?=
 =?us-ascii?Q?4ryCKqdbVbAkOOz5NYtYEer5PIykIDZdQ/vN6B72mdtNmrtKxLS583q6KFcb?=
 =?us-ascii?Q?sbhIWMYvd8tauOhDuDhZmvdRPoqHKKKqNVLsBl7KppYg074WaV5xfLfgGqY5?=
 =?us-ascii?Q?SNEIKSN0J9V11nWX37GGSmLEd2bDr6FitcPMgFR1m0tshxseeI2XUzvI/kZI?=
 =?us-ascii?Q?1PzCrxpLPzXlzP2m6wdcogUzp4+6mTAmCmNKB8SkPHmNkH08dZ/2gyTZHXg+?=
 =?us-ascii?Q?THS0vE1vSpECxyMjY5RsBMAkVJVz6kOwp93vGGsxt7q+ZXo6pzrAgSvh5CfS?=
 =?us-ascii?Q?uIg/cAgfLAJBx2Mm7SeJH7nOQrMu9nUuc5FeOEKWUCIGvkgVpdoIz5IxJJz/?=
 =?us-ascii?Q?u4IIB4GYalmI0jMgHKN8xgimyC3D4v8lcmN13DJDjf3mdhj9XOFjHpxm4uWq?=
 =?us-ascii?Q?SoqFyPF0r6FjrAmrG9jXHxhVeqxzbfb1iz9RZIrQq0f2f3rZnZ8kuMWM4AfB?=
 =?us-ascii?Q?pMP8hSHhMX5gFczQcmwLDhfe4gbX0HhV+HTeMCUy1DJYLFIw9l6yXgXooLGf?=
 =?us-ascii?Q?tU4RCh0cMCbQsC+tJsfqxizEa58MVNtAIFUK0pF4Hgkszybu5w9wMmboAOgK?=
 =?us-ascii?Q?wfiuR4+sXbe93ZNyivvHyrTbapJNHF/4o1kCVLmGC4/uubHiFq6VfV+XUXEM?=
 =?us-ascii?Q?yy1nGbtYEJMmi184LczrQ573uBf+wNtGJJ7JaL6VWfp20bSIEyKsEXXXDfw3?=
 =?us-ascii?Q?QPWDNZSC4hoGZ1SAhKk0JUVlFRLCKI7wpg6SSH9JPeS3N5hJO46youFYwB7l?=
 =?us-ascii?Q?1kDKbQWBRf0IpC9ToNRxjlfY0Knusq5q6O0GBn2zH4SCBbcvSfsVsLV9l54k?=
 =?us-ascii?Q?ZfxP0EYA0PLoDLp+M73GuYTIpaTjC5SnmhHPiWB8Is3OZGCz5YasltNbjORP?=
 =?us-ascii?Q?BZVTzZBkIJQHTpe8xfiQgoqShz9s+kBW5KmvsmR2pv4LI5MweD2AzEErYn1G?=
 =?us-ascii?Q?Tejc4irQ7tKXfvZUMLWMrzaLG9ori5Y6LpbSEsKU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78198c3e-e8bd-4f63-d5be-08dbda94770c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:59.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtU3p+MPTBR/6YqvLR73rYS2NPh4g0VZ1vvoUj0FNSmhS8k41kA/0ZspvT1yqLOxZYPLVTciM6gUSh9xucEkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

This patch adds some userspace addrs list flush commands in the
userspace tests. Without these changes, some tests will break.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 27ddbd8cf03f..17e182345bf4 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -560,6 +560,7 @@ test_subflows()
 	print_title "Subflows v4 or v6 only tests"
 
 	# Capture events on the network namespace running the server
+	ip netns exec "$ns1" ./pm_nl_ctl flush
 	:>"$server_evts"
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
@@ -638,6 +639,8 @@ test_subflows()
 	   "$client6_token"
 	sleep 0.5
 
+	ip netns exec "$ns2" ./pm_nl_ctl flush
+
 	# Attempt to add a listener at 10.0.2.2:<new-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
 	   $new4_port &
@@ -676,6 +679,7 @@ test_subflows()
 	   "$client4_token"
 
 	# Capture events on the network namespace running the client
+	ip netns exec "$ns1" ./pm_nl_ctl flush
 	:>"$client_evts"
 
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
@@ -753,6 +757,8 @@ test_subflows()
 	   "$server6_token"
 	sleep 0.5
 
+	ip netns exec "$ns1" ./pm_nl_ctl flush
+
 	# Attempt to add a listener at 10.0.2.1:<new-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
 	   $new4_port &
@@ -794,6 +800,8 @@ test_subflows_v4_v6_mix()
 {
 	print_title "Subflows v4 and v6 mix tests"
 
+	ip netns exec "$ns2" ./pm_nl_ctl flush
+
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
 	   $app6_port &
-- 
2.35.3

