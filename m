Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CD18E37
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="3kIkLMnQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMic6L0E5DVsFMrfSLvit/A6P0HgkZCmpi+LunqMhKr0dQOE5wOCA+y0fTnSLAAMd1qbtMTPW2vy+unToecVFzeypjiq11LBXm/qLUYi/ABYxSazU5eAngd/pIspUaVGIFKeF2f7EgtF45uKZJ0juAidTYvDdqn4LTp+ZjuffwzQ8sHKdVKlPklrU/ouRFKhef1MG+0CLq0yZaDpH20g5Yk8J4VcWZ+TYmmwwayfYIun1PxqTpcMOGTmetJgn33LIdww6YX0sjNmPPz2hUN+gcPONcoRMpr09TcJkbbrSDQX03IoAmo1DqCDWF1Z/5wXaqoFJY1Z01RioxRPbxiRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOedQMCJLoY0vY50UsLWLwEw9Hhz9n2QNv2Fy1tl0WM=;
 b=Vj7qlvsdbPNiecPLdtJO75jmAo4sAQKaS3hBsmAgtA6H3B1cxZHjp4bQTFqyCLeDeqZk5CjAW+C0Lse7pQejVDFrRiVTRH5tSgqYkOKAcyIorQ5B4jvDILT1Vrgi4zCh9tL9Jutc/kWi/I/Re0t4+NpJwrOx0B/phgqsmNf/mu9xz2fS0VvQSuN/o261uDQhJ5S9OuCUVbzO9Wn32zMKObVUtru+SKW3OEmucO3lCfFR51wUyxuNybGnplw2Gkyl43FlhTuS+E4gXOLON30xkv/D5hk7e5Z1J80CYP5Q6kq4ZdgBZVrKi58lU0BX30jSICHN7eiLpJNWaOfHvWIRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOedQMCJLoY0vY50UsLWLwEw9Hhz9n2QNv2Fy1tl0WM=;
 b=3kIkLMnQicyAuAT7ifQAIgWAZwlmOsyzx/OGVRePxgVcY+ASAosN/IaaEcI2w/f14360WWTacTkligQPuLhmRXAWxRafBHpPl/k15CDiWD8NJlTW1id5nEcDp+HjoBgHPWyIF3hqsKCUaciURxQN93reNE/ZVz3KtZfeEjeQXzm6GVSVx5XY9s6D2eFc0vagwNxWhbVJwz/TzHbWEpzmro1lb1znqwsnK0QOrEoVKb+GlUZJBUFj0X3+QqH35wD4eaMZEKf2Iu/B5j+i1mughHFy41elSB2A1y/l7P0PEZMnenuw+qMvpERD4v1ZpZCpR7HYIbDyyYVk2j6KbcKMRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:30:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:30:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 10/27] selftests: mptcp: add mptcp_lib_check helper
Date: Sat, 18 Nov 2023 22:28:25 +0800
Message-Id: <2e65977c5450bd57226810b79817349564b340ef.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: e669d9b0-94d7-41a9-bdfd-08dbe842df14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yWEZiaKDYCXW6veP6SAmvz0oBKPhbUi0L6r2hRwazVGGdYXuhOgffxWk5NYTHCocHz4y4I0FlPiZg4bc55kh6YTOg1zhYyRL0jed6IqYF/cw6Z+OIsKi0mSJlTbS5427AowE6M4oe1vga7Ok3HtRVRT4/rQGWl+LNxKSF37d02MmfDkhLq1NOd/70jUBA6QqTZxAQhawFJfwW0XP2xRQ5XfFj2sPL6pko40oCsaSPcdVJ+6fbHKfMrcavS85m2m/+coxxLoxxIhz6Y8ZORKbIEVJ7Jn6mXZsIzIOsgWtZdN4yXQcQzU+FdP9e/TSDaS2sfAAZkYSZAMFRxSfmjUALrSvGdOPIZr//RTXgrd6lgs8pi5KiGYWjRpuzPi8/zWgDrUp/KJvBuoLF6FgMAgFiJEABIhX3gF4VRZMJK8RQpIBlXqi2fzChJCB1rR4j71zEc9dNw/Tv7ydaDD7GRWoWIU+r5nEJWJasXvGW3beibQ/NuW3d9yxGPNQwbOId2M8o9ol0Y4UsTyIrhB+ZykenVVlxgcyMEdx5Ckbn4cPmPKrXDvcs1gaoalLUO9VLCtJyXxBqgvRgCW5AIJRlbmlX71R46S7yKMr5LPmgU8FRzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jk7i+fCPynVW1GSYQMLs/Mdmp8m5mHFDPhF6VzZJMM7OCRPK4eHbv8HpgGlL?=
 =?us-ascii?Q?REbAUza9Uraa/rgwNHV0sLAHdOtOHb/BS2kj3w3SzWNq2ma4qgAgcMW/b8sf?=
 =?us-ascii?Q?ILSR+YHqedwTcrZCgy0VpnWitYtc7MOuv1D1GEOgXiWhOKI5hNYJeCz0RoF4?=
 =?us-ascii?Q?/9dzW9mSkvDtjrCoZsp7NUU77yEUuRhLLg2FwrqcOJVVHf9aVQDTeOLajCO+?=
 =?us-ascii?Q?I0/qb31WzSkd6qXY4m+6j20yKLr0SSOylTynHyRtRu/14J8qWLz0pmZ0Te/2?=
 =?us-ascii?Q?CR6iy7CcyXtbxgOPF4Q10ugkLq56WFxC014VgtdKrqDE1Ep+nGW9g2LET19p?=
 =?us-ascii?Q?Em461PdL61dalx+mSrzabZuwExdmwabbMEZLKEFkJh1UsQ4ghUjTw6afHn+U?=
 =?us-ascii?Q?/Q6DaQoyMIlugwAPynaqtfCTsuOJpk14KsJHMcmMF4IpMbIT4rgIlCaepLTe?=
 =?us-ascii?Q?pfE6H2xn8M1wEJgX5S7lc7SBoM0QVNBXfLRY0nOjEZySVeu1ockjZlyTs/Ce?=
 =?us-ascii?Q?AivZsVAWCqGqXUEAglKdCCiHR3FTdBcy6XAZ6ODdLz6yGl36C9m2UUZ8zcC0?=
 =?us-ascii?Q?+u6kPZXLZ+SxgbX9QmUa+OgIjYG1yh9ZGAmf2Iq63QzIEezvoYnOlovMV/rJ?=
 =?us-ascii?Q?6Z+ohw9GcZjz7OHyKvoDvSHm6JeogASlHmkEfszyy19/qBsdaa2kpPypJx6U?=
 =?us-ascii?Q?mDOmkIA7fhc4SdRZcOXrmOjIgg/NCa7RZhKZFfpVRnUGKigYvYAEty6LI2Jw?=
 =?us-ascii?Q?drU1KIVCYhhsVRD1z/X8fDLC4zPZMmb3iRiE7vTmbVjIiWRA5tymSE69No2A?=
 =?us-ascii?Q?QklUX6UFbacoIcGxOUOVzZMYTycxmsPkuzeODjUGg3RtLwlL4V0KpQbKk9Jf?=
 =?us-ascii?Q?/MPjZOvkOy9lal0rUEOAz56j+RQ+HluNpIp0elKX77ouEPchW6/u9h/UMs8N?=
 =?us-ascii?Q?sA8KMRUklslf+Ha1ZNIdmLlh8/YQru86ly2IKSBkoELwuUjyq/a2jN0ZsAiJ?=
 =?us-ascii?Q?KTc5pQLjPgMvwAKs8tbzI+p7Dlwdae78vf1HNXAHnNJrPBlYfZIFv5AbvK8g?=
 =?us-ascii?Q?Wje7YCoMQSzOoZ0o1LHm63cDiN/FlrNkjC5yLmYFF74OUuZB9xfSM+l40opX?=
 =?us-ascii?Q?HPTEv8JNq+lknNCCYcLLaGdb0PED8xBULdTm33aefvOZ0opebGqXXqHx7Cp2?=
 =?us-ascii?Q?Ga9D2ZtQl5DuKjDhXRK+V47DwUZxtULEr1JLDtHoIUqC76eIOo7KhBfrUqI8?=
 =?us-ascii?Q?IycUBPDyRItVFY+6HJogZv35qWGxDzcezEwFN5omhZvncCQMt8toCtEP0SCI?=
 =?us-ascii?Q?UfU7z9o4//MABshJ/GcqadPCwZP6x5xSObQYP10U9WRy/9x/7+mw7KL96JpA?=
 =?us-ascii?Q?4fzi031Q0z0WoI7n+tmJu89oHi8/arAXU7WKoKr+2pfxSYl5S+3vrt5FlpRo?=
 =?us-ascii?Q?/Tiyoo3lKYmG9ir0m79tszDhebn3F1zZJ6FY8vFulBN+nd94dghjTq4q3dvn?=
 =?us-ascii?Q?IN7EJGfbcxIuPn+nBl9dfsYLpMQEC4K13VN5xpN5DRXD23xIXzy+tloJ5tTE?=
 =?us-ascii?Q?0lgJjVUK7HVWJfxmNfXEmLMgEl81H1ljHg8SBbI0dJz6v+80dMpMjWXacmU+?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e669d9b0-94d7-41a9-bdfd-08dbe842df14
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:30:11.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhNkySFBcLe3q7qwFzRrzezwTlJNhN+frpAJpGWbsdR9NCKGso4CMC02Yrxu7gr4pHa7IA47nEHfPELV8vPIkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

Extract the main part of check() in pm_netlink.sh to a new function
mptcp_lib_check() in mptcp_lib.sh. And use mptcp_lib_print_ok() and
_err() in it to print test results with colors.

This helper will be used in mptcp_john.sh later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 27 +++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 29 +++++--------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index cbaa55ab89b1..466fde97d3f4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -300,7 +300,34 @@ mptcp_lib_wait_local_port_listen() {
 	done
 }
 
+mptcp_lib_err=$(mktemp)
+
+mptcp_lib_check()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$mptcp_lib_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
+		cat $mptcp_lib_err
+		ret=1
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
+		ret=1
+		return 1
+	fi
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
+	rm -f $mptcp_lib_err
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index fd413b4c8123..8d30d4a1db57 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -27,12 +27,10 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-err=$(mktemp)
 ret=0
 
 cleanup()
 {
-	rm -f $err
 	ip netns del $ns1
 	mptcp_lib_cleanup
 }
@@ -53,26 +51,15 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
-	local cmd="$1"
-	local expected="$2"
-	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
-
-	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
-		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
-		mptcp_lib_result_pass "${msg}"
+	# ${*} doesn't work here since there're spaces in some arguments.
+	mptcp_lib_check "${1}" "${2}" "${3}"
+	local rc=$?
+	if [ ${rc} -eq 0 ]; then
+		mptcp_lib_result_pass "${3}"
+	elif [ ${rc} -eq 1 ]; then
+		mptcp_lib_result_fail "${3} # different output"
 	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
-		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		mptcp_lib_result_fail "${3} # error ${rc}"
 	fi
 }
 
-- 
2.35.3

