Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2075.outbound.protection.outlook.com [40.107.15.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0F11C97
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 08:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQTO4VFljESkWi3uM93xaTIOBtoHT0JBu3jtcoD5p/SpoKujsq1UUV7S4jKVs3bZmPlSuwnBM7lWptEMvNL9V1wHV996ROgKwGNb+7KkEH1+mJIpPiMKmXps30++xZljKcRxVipZBBLvZxW1nRnYvKDY3Xi14o52QCywDpJSTOJwhgVaVArk7FC0k1q+SQsbCavV33/ZVwQ08Z62SJNNDFravJQ2xTDCMCY/1VgwlxdE+5hvLpMszq28VH0Tw07yUTpEZZ7weIcMOpbVV7syh94//rpiLjE/GFmMCoG0o81RZfOmsGEzue1eTM4JGZWYaYgVPS0t/H8nze+by97X1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UME9e34GZlbM/MYJIA8AsjMqmTqhDQKGCpvj+8biYik=;
 b=iIKjQU6X0dm3+dTmHTyEcJB/y4DZvONNhxEjnGXfU8rwLNjwrEfOeFQiCFVdVNDS+dFXlgN1sir5HoUxJddTx9rFXsthmwv822zfLI0gp7O7givFoU4SIMATDrnqA/oK3d+M3K4hot/D/AUQi0Y612JlPlbMa0xJqGFGqqTRoGy3b8V3B8CC3FjQiKeFOPARLPyJKuj9rkfJ2ZV8ovqyEzlbIfYGOBZKz374r5StJXdkCvWGMg7xurkkPOWI3P+wYX1rxLlAlOpCGlLI2dF2iO1PaRh29WQV5QX5Em3nyHSQBwyCIlFYAaslADjn03KjgjfOXOXUDIburCwk9bBGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UME9e34GZlbM/MYJIA8AsjMqmTqhDQKGCpvj+8biYik=;
 b=YInGsIwzu6fJOnwz/CmUSFP9/tDv19Z2rgZEakaBheVEIl2rfNMjuV8NR3awqnEDK//bCAvBDDCnx+m3uFG211umVgji4uGm+/Bvdrq8yz6g9bCFVjTNlh+OT8H/j6rCzHoB7rioMUtp9xIOP+M7uytNPh3vtdaZGszPh/VZFhdfXMimIvz3trUF1kURJIjlj1zx6UG9HdKqvLXupw5W0awTFOLmN/P9cnsY9YxhmnP3ec6sOk9JaTNHQlTlgpnkz9ajI9l4xa/XEDUtdVp14nCCDwiCFSKV76F/caOnprcmV2EKGw7FRogk0bVA0LyGwM0MXkXYFzAuErYHDFhFhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:18:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:18:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 3/5] selftests: mptcp: check subflows infos
Date: Mon,  5 Jun 2023 16:18:06 +0800
Message-Id: <c3b4a6064438063cb4ed3ec6891b84d758639c6e.1685952776.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685952776.git.geliang.tang@suse.com>
References: <cover.1685952776.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 658970ee-df18-4899-c8a6-08db659d71b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a5l8ULRWfHIWUkYtCFqwcmhB8wsE0Hk+0/Xp1nvB38DeMs+WXSsqHoNXtkWq6r1zSSvaR7ND12rh2yO1Rt6D8skz1KWlmf5PiEV/p0JVZ/8hFqELkPdY7bdNzrj2ApiPfJs/pnXrXDXAlGFMal/6+HKVsat8GYY2zved9iVNYyaH/LbUXZcimQ4qXqJxVadcWXtTve1633bbJxsWUSl0KujW1RGPXOeMXgSCRby0lRWZlacfh/C5Z0C+1bSPWaL5OZ+2OV+9t55TCqZ5uXlttkCtOaXLQaFKcyeFZCn/O7yDrH6eu1wGrnVxNh4Gk8ZShbBH5u5xSkvrHG+oYU41YKaS2iu7IiLs1Kar5IXEks5DiBaqD94tuOxseiSXsNth5LfHgCX1LkRc/7Jv3WAXKa3GRVaA27ojSZW3PBCE+WKHWSWxXTJoR04VGb59J0Euto9eV9/vDWPavBMg/gbhqiU09E2cJUZzxGakMdan4e2dM85J6iLxk20QMiYpp8GtLzYlspYV9u07WPBoSkniao5QMmPcwzMcP1EAgb0HVMIEl7AJS/c4I1Vq8weC6jcC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6916009)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(107886003)(6512007)(26005)(6506007)(86362001)(44832011)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWwcUIOgLf7OMbi2JbAgp7fDW4eXUqa3tt3Ok/FGu8IUmyEugMDOtM/JGIYd?=
 =?us-ascii?Q?rCdQdgKknWjTSX7D8w7lm4pFSzeKD4NwnxirvBnp9hBJ+X122dOC4h5+5f5V?=
 =?us-ascii?Q?YVaWD3+E0MsghfsR+MLqeijWHv7YJHRrD9wyQoP/XuQeIuZLV6ImsVt0eX9r?=
 =?us-ascii?Q?UE9ffD3fCF8TitD1wjTu3spXgceUpBMw6HMS44lxj1SG5rCvXk+Rc/1UttE2?=
 =?us-ascii?Q?7TzN1DJ+27pHCdl+/weCo20Dy+CNywFvS87vQtMvO1b8Y2IgKg0J5NP92FEE?=
 =?us-ascii?Q?hyU13diHFkUHO/YqXRX3WMfu0cqpYp9Nzm/ZZ7r1rwcbXH2pImHqDTkBAylH?=
 =?us-ascii?Q?OCS3X2GaoExSROd6Kd9NLp8Po7r13tHrdbLeTAeCGdh2jscbLrsGCVMu29pW?=
 =?us-ascii?Q?zLJjB+cnV148rNIQaeAdTjocf0AH+2V/0eeML0WOM9FQuwUwpijnVzp/sU0i?=
 =?us-ascii?Q?3HrEN5RTgjJs8KXkBkZi2csxUx04OOsZte6KOv82Qrh0EfXW/K88kuvto2Ae?=
 =?us-ascii?Q?hhnwdugIYZOyeGHfZRgX7aiUlJFsiX3O64qlB62A+OMEARfGoxkAkqCuptxt?=
 =?us-ascii?Q?mmn6wIg8jsvWoEl1ChHeMAM5/5vqXtA7M65LToufX20ZuyLOb3t29na0C5qS?=
 =?us-ascii?Q?atS1onDtAnumjsrPRYe6dvnY6BtiQfz8gsk4vd4TjFdYjQvh4bCENxZX1NjA?=
 =?us-ascii?Q?jaKQFWlCTfxvJYB6WkKr+L2YH179zHsq0LeUPvRZbyCCL0QoUU5Xq2Jqmi5v?=
 =?us-ascii?Q?SPxIXfvTaCTCVPaxSkoMtODURvuoromUAadraMbZTopr0RV96l3+hf/a9Cop?=
 =?us-ascii?Q?jmVvTNQTusS5X+BJHxXSbp5sAunKB9Ries7tQiFayY6lrSyChUSgRL92ruOb?=
 =?us-ascii?Q?PZnqS20YWstWtaeJy6Lt4iywScwKnp3+gBM9wwXw07AecXnwzhYJTPHhqEwl?=
 =?us-ascii?Q?fQuH0Q6+7WJsEx7M9UgbtL4v3X4Yss/T+Q2CWOpLcPS7OWkbwdbWFklIZCg0?=
 =?us-ascii?Q?yynrrGBp3q9SttqAsN95Gl1IkmbKCfXPlOYRm7CyWaophpgMxdoZYufG1Ejq?=
 =?us-ascii?Q?2XrygCMfo0cAxHY1uB1qN5jlZAh0LytvGMicptRdcDn5OvHz+41ewgeXqfN8?=
 =?us-ascii?Q?DRhxDuupC04NwtPyiQXvAhwfWgnu/OcvMMCvKdB+xbY26GhgwWGbZ0fOsTCo?=
 =?us-ascii?Q?tTlBea0ZZQBV5AxfXmJIwd+ptGfQDZeEf4uRdiXYXo8ybIPYUIQsHwDA+0/M?=
 =?us-ascii?Q?vk7uuECsG7IwCAQ2raLNRAge6FJvYFTTER7tcVCjyUSv02+zlSydYqZ7eWFC?=
 =?us-ascii?Q?U1TcFlgYi6wVB9MBIJEQU/wMbvSgORzGvDC8xjsV3ufYo3ZC+8BflwMVco9w?=
 =?us-ascii?Q?rzsig0jd5ZlJ4Lt4ZEVRm2lZPPKE9Br1YZnswT2Y8ofwwA3f7svv4I4ijkhs?=
 =?us-ascii?Q?QVYms2jIjHn1asjPA6jM1PXhEEvQrdqXXbNlsyw7Ywyg4gs/toocHznFqQb7?=
 =?us-ascii?Q?uCIXhu6B+pRCHfmaU3N4CG9ONZ05zICACXnO3nIUvBrAHJYxtAZPsBNaLEEd?=
 =?us-ascii?Q?RvvPlSMA0DHIY4i8tWSY3FvQUkPdXkgtgEo+QG+t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658970ee-df18-4899-c8a6-08db659d71b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:18:29.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH8U3ojtCdOFJSERJtMs11CQ6f+tc2/LTVl0ZBrE3i3/4CH7A6zVGKIwMjajXqFpBXycp8nYQOy0rKPpHvfUgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799

This patch adds more arguments for chk_mptcp_info() to check subflows
info of different namespaces. And invokes chk_mptcp_info() to check
subflows infos of userspace PM tests and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5fb67399c00d..1a0239d448f0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1710,31 +1710,31 @@ chk_subflow_nr()
 
 chk_mptcp_info()
 {
-	local nr_info=$1
-	local info
+	local info1=$1
+	local nr1=$2
+	local info2=$3
+	local nr2=$4
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
-		nr_info=${nr_info:9}
-	else
-		echo "[fail] unsupported argument: $nr_info"
+	if [ $info1 != "subflows" ] ||
+	   [ $info2 != "subflows" ]; then
+		echo "[fail] unsupported argument: $info1:$info2"
 		fail_test
 		return 1
 	fi
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
+		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
+		sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
-	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+	if [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr1:$nr2"
 		fail_test
 		dump_stats=1
 	else
@@ -3168,9 +3168,11 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3185,9 +3187,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		sleep 1
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf 10.0.3.2 20
 		wait_rm_addr $ns2 1
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3205,6 +3209,7 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
@@ -3224,17 +3229,17 @@ endpoint_tests()
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
 		chk_subflow_nr "" "after delete" 1
-		chk_mptcp_info subflows_0
+		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 		kill_tests_wait
 	fi
 }
-- 
2.35.3

