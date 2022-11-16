Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EC7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxYCAJd6a/TjncTKn0NHZhoWmHFzAMLY8IkE54f2+f3AcjDh+kufuxvMglLQweT/g+BebvA0nE0QM239+8DQDAQ0JQJ1iU9UYgYiRsqsffe4BaXufIVrCOAd1UBYbAh+Ozx+OpEq/Rmv5VCRKUobmIXBA9XGZGT2T6/PAg8f9+dl2lq0J4vggZdDVQooHYScox+iIUFMtJXQudYg6Wa1g+uWEouAWr1ovXF1ZRsEh2bO0HftcOJnWkS0IK0i5U0SgZupquQTf+WMco5NcZQUvDQckCZjXRJLJMLF9hcPu9C45yZKMFnJdtxxDa6ISjM5vdsT/EH4ePV0/Kv1QWcstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wus+zWOQc4wN2qe7W5VZKJm3CMNW7FXPHXeR87UP7S8=;
 b=FHoRchynyIma/EnWyPrVc3ay/J4mnJSNVMQAbKSSTnvZYTi4/uPVtk9oz7v53rBm0IzulEQu9+MKNq+2R12F4rHp9Y+Lny+9wHzuUm5nZwL8rufFLnFcPYT+QSOK0qdKSiBLL4iXUiTv7giFO8YLe8nVFHDlVQCiUBx5065v6+x6hgUsOWtPYggt9JWt6svhMlresHNE8KoWXVxMggCdO77iDmq3Yb1NhGODAIiX8otWQd2NeczSzr9WobGs7ZolT4ZijFXDtuaESRjN5qUkxHosXYBztWa/nJDLiH6cuCDM7lcgmDiQHbSKaTb5vFxxoI1iQEcTGgRlqXgbO5Sfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wus+zWOQc4wN2qe7W5VZKJm3CMNW7FXPHXeR87UP7S8=;
 b=WkV9+9G8/YjclyOZnrONkUQsQm9WiutJgKFrRyZDs2GrpXnAjjtSHaMdUTMxOQqmDEyKM1htwqg5+tmbJ9eqsf71anWJhDzW++V7rsLUXRygHzadyyizisioGk/Z5Y3H3ZHW+DG5ePeH154zsbiNlWo+qO4VIAjox9A4qH4JN8Q/wf7h2IdTeb9seEOZ+Qir4VGh+rnuVEDZgbViFbppJHGfdtOO+selcqUCb/U5UDg/c5rwe6B0/Z2BCHvZhvZftD01T1oXoFwJWzWGLRdyQIeZoJf8xugCcKvag6NZsZqo/Q8Br6/pYzziWOHCLgC/ArPcxCWdDKl0eAIekkNNow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:46:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:46:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/4] selftests: mptcp: pm_listener tests for userspace_pm
Date: Wed, 16 Nov 2022 19:46:19 +0800
Message-Id: <2c71346c03507837d10b7a047004348b8c39ece2.1668599064.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668599064.git.geliang.tang@suse.com>
References: <cover.1668599064.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: e92704fd-5ed9-41e7-b5e8-08dac7c832df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4O13tBAxqdVH+O2QWGVVnfo/a6ocE40WCT4CsRqvIP1G3mwaPN+pXOyurLtIjzMZQyyKGXEofJEmbLvogyOWFS/P3MbamCioqp+aGZ0ZtV49Czo7efI2/9ju6u3oXmVkMZPzG0OCcTpGVoVd+A0E8wrKprxFBpnqMIystLWjPRju1kpGvewkaaA31f4kFeGEyklZ6rRu2LvIXbpFIAktfgtvn1zb3HvW5YgwwDz9+VXv2GT/qkhZcJ9OJvf/VhjQKlwHvNwH7V9S0h9dbqLt8rx7DdBnw57U2+k8e+ik8kToPvDCKEkoU8LeS/52IDpWjbw7PhqHrl/DfOL4KJ0ON2iBenRbnzHX0ObXxP/jSTpIAx9j8SNOwEPJ5HLJmaUV2PiX7HLOkPqpyCXLNrjU1TbZ0SWiK9nuFLmsDln/paqeH85pJIyuYadb6s+4AgVBpkk6Cg3FXRppPlflmf8Gv0iau3Z0F3qNpTmitfvYZDfkv1UiJ2wF0irBA+CDqlKhdjUA0vDL4I2zZmtX34ewv9UPvgPYJBbJFIUvJ3Gn1hd6aHCSGkACIiIZMRrH5d0Cvymc7cm9amstBjdZ7bWXKF+eI7+d+0CVpuNPOrMsjSfbIRO4htiITski6tkLVt+YCOXo3rKgsru5in0bGXUFPM5appSf04Do3opT2LExVds295hDQ534M2y4/3bHEbcwrgfAlDsAPDzy2s5S/fkB3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(107886003)(478600001)(6486002)(6916009)(6666004)(83380400001)(8676002)(4326008)(66946007)(26005)(66476007)(66556008)(41300700001)(36756003)(86362001)(6506007)(316002)(38100700002)(186003)(8936002)(5660300002)(44832011)(2616005)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q0M0NAn/fNWNEjS6Oxt4lvvhmi6e+LS3j02ia79JRQaYS9JVgJRMFNpU2jc0?=
 =?us-ascii?Q?+RuGi1M2tqLC07AuPBwfrl173k49gtXf+mJlqWS+U+GuZcwdt7ehghVxPnGM?=
 =?us-ascii?Q?HvZUJtlptdJF2t7eG+D0ouebcdJ/o8Koa54Jz3ObFU0BNOLhQ/gRKmvhV6Lj?=
 =?us-ascii?Q?3g+MC+4as8QPDGZzvYxLQr7YWc0//XZDkwNH/yP2vtOo2WGObmyPiGs1y4fp?=
 =?us-ascii?Q?NxF/eoFVKfE2Dhh3ZADHT9tzPaUH3sJmhVu1eqdqP21knrFc3UcoqnqEp5xp?=
 =?us-ascii?Q?O3yr4miCfwf5dYK7ziHCoocCIlngdJ1MyD4cf95TLCGEq0Kj868RchhM1obv?=
 =?us-ascii?Q?UGX5LUvbpeGoMSKJ//M5cAZ3xZBvJaIy3BUCbHvyO6DusjYcynyv0jDNkg/9?=
 =?us-ascii?Q?TzY5hd3Phdcbde+G3/OzyaDm101wSHQ45FauwJ9gUbypWBx6nV0wYRSmyu3H?=
 =?us-ascii?Q?R1dVLAgEOmj1Ai5a33h2Lvu3x8cGyf8sTs2LYBo/U6KCFX5bYYOMQJyC3y4X?=
 =?us-ascii?Q?41kSz4qI2Nhi/s8f6O55nzCDoO4ZS/+KuQO3j1KPe8E9PeKfnhMYXKg8aExH?=
 =?us-ascii?Q?8Cx3ZsNZ1LlMXGzs3SvCssvCgVz/3Sd3GtYE0SyMWBBDDVpwOBnBfr6rS8ap?=
 =?us-ascii?Q?ZZiQfu549g86W6+NwWND55KTSpyi/oGzxDLzdnXpib7YXoQ55yjGOZqb1CQi?=
 =?us-ascii?Q?XHnBQVv3LhXi0BWXkLeJf6EYYs+AElMTfvMsjYEAsCq9MTRoHjuvMaoOgeLn?=
 =?us-ascii?Q?3le7pOCHKCafMCYkdBToBhlZq8ZbcSWkifEFn+RK203pr97iAkl4Mobm8dRY?=
 =?us-ascii?Q?3n6a17MXukjt7MpqxaT9oQ62/HppjAqdx1vRL7VgD6N9qFuFumiXggM1pKE2?=
 =?us-ascii?Q?YU+6wG20qGCB+QbhJy4j9GbCT4CFIu2PUBD3KPYcxugfc2Hr6xQ52Nf2BrXv?=
 =?us-ascii?Q?ZQgR6lqZUhO6/2P3hzV3pS606HstSNVq//DXWXhB/N+1q0nsokM2ttgFHmmx?=
 =?us-ascii?Q?j//xk+yJbRcjT8BNm/j/EYtCPAWJBCe2UDAYuldqzbVV0Nwjp6pm57W/PaH/?=
 =?us-ascii?Q?fq73yoMK0bhzJbx1mQAjchM3nH2wfChy0gWdQgbRcZYGJdHvERUffElgKC3O?=
 =?us-ascii?Q?ZsB518+1VgFRxmt8iz2r0d1Qlq9+zBpcUOT5MekNk0z+WgAQdboc6syokB0F?=
 =?us-ascii?Q?IAR66DvANtZBBi456ONWmz9LwQYUrRIzRVwzk3ew+USfjcMcSv9AcpEFLYCY?=
 =?us-ascii?Q?EJZJ4zfqas3QGMCfjqel5hz10CY4vOb6tiPl9Owlh/GxlC+V09/kiSy+PGsp?=
 =?us-ascii?Q?hj7TczFZw4QGy2KuJ5UuC8Mix84Zpmek3S/jqFwL9B2wIWH9glW1sAUCCYKM?=
 =?us-ascii?Q?NXnJnZcDCrtAlGsw3a6aC8KJxXx47oN9WvO6bErqYdtOBRpO8vbHqKdtefn/?=
 =?us-ascii?Q?sDZ8a7hIAc2zhsjOk/8scGenqBxQvBMeHdrJclpbFUGncobZ0ulAtU0hCsO8?=
 =?us-ascii?Q?OUC+S4cIuWj7QByBQlYDmJgCaUQo0e4c9iDQ0RrRma3kR0DMOU5mqn9mGT3T?=
 =?us-ascii?Q?tpdRHsUk4s5FrAZZTwmioMRFDSaGW9dBD++WxzrbgPcR7Goss7OHgIyB7Ld+?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92704fd-5ed9-41e7-b5e8-08dac7c832df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:46:29.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XOomLu+9iPGCNymoU1tQPjb+EQZ9opN01g+vW0NxfnzpBxoT9yHAyQ5OoszAHO9qAcZsXlmD1B27EQPdwrCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430

Add pm_listener selftests for userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 08a88ea47a29..40801279ebdf 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -11,6 +11,8 @@ ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
 SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 
 AF_INET=2
 AF_INET6=10
@@ -808,11 +810,91 @@ test_prio()
 	fi
 }
 
+verify_listener_events()
+{
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	if [ $e_type = $LISTENER_CREATED ]; then
+		stdbuf -o0 -e0 printf "CREATE_LISTENER %s:%s\t\t\t\t\t"\
+			$e_saddr $e_sport
+	elif [ $e_type = $LISTENER_CLOSED ]; then
+		stdbuf -o0 -e0 printf "CLOSE_LISTENER %s:%s\t\t\t\t\t"\
+			$e_saddr $e_sport
+	fi
+
+	type=$(grep "type:$e_type," $evt |
+	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," $evt |
+		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," $evt |
+		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ $family = $AF_INET6 ]; then
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	else
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+	fi
+
+	if [ $type = $e_type ] && [ $family = $e_family ] &&
+	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+		stdbuf -o0 -e0 printf "[OK]\n"
+		return 0
+	fi
+	stdbuf -o0 -e0 printf "[FAIL]\n"
+	exit 1
+}
+
+test_listener()
+{
+	local evts
+	evts=$(mktemp)
+	# Capture events on the network namespace running the server
+	:>$evts
+	ip netns exec $ns2 ./pm_nl_ctl events >> $evts 2>&1 &
+	evts_pid=$!
+	sleep 0.5
+
+	# Attempt to add a listener at 10.0.2.2:<subflow-port>
+	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
+		$client4_port > /dev/null 2>&1 &
+	local listener_pid=$!
+
+	verify_listener_events $evts 15 $AF_INET 10.0.2.2 $client4_port
+
+	# ADD_ADDR from client to server machine reusing the subflow port
+	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
+		$client_addr_id > /dev/null 2>&1
+	sleep 0.5
+
+	# CREATE_SUBFLOW from server to client machine
+	ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
+		rport $client4_port token $server4_token > /dev/null 2>&1
+	sleep 0.5
+
+	# Delete the listener from the client ns, if one was created
+	kill_wait $listener_pid
+
+	verify_listener_events $evts 16 $AF_INET 10.0.2.2 $client4_port
+
+	kill_wait $evts_pid
+	rm -f $evts
+}
+
 make_connection
 make_connection "v6"
 test_announce
 test_remove
 test_subflows
 test_prio
+test_listener
 
 exit 0
-- 
2.35.3

