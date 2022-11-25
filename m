Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21C33DC
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 13:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfBev3d1QX4NwedU04r7MGdJnq9HBueE6AWd/xOVN2goWM+Cr70848K8lHpTlNrSvYGyWoZ+A53Geh/PM2A/0uL/17WqlhlZTSH333qxkNZzldsCR6VU44DqH/jmhz0Fp4iGFIYcC4hK0FHmPwnxjYc80pvfZZIpWGA+tcMV5MZXCruL8co6h6dzlhQmIOmeLnMtGmrKbAKNeqaZ2ZU7hVIuU3F5zhXlhbPtRGxnhtCdfP2bKsogl9JBUZTEsCmaDART8/ZPbqRYI42vEj0n5U7xUkUdPTDF3LdIlIFbjNXmSkXc+xN/v/Ts5tISYfIss00tOIvjdaueK3GiJpTA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl3s/c9Q+3ks3zOx5aAeyuGVmYBBGO4jHe/B2EDhsJE=;
 b=DjQlbSdoW+zxh34wUJCHUpHWfds2BMf+WCGXwVMIOdmtAaipIOfvF9ewMkAVRrQioK30bFK7jnmZzQENdq9QBTglgTFOpixOcUNpSd7Ddd2i1s8c01oWKMOJV2/zZ03qCEpF97NoyQhdEe2goUQpS8PpEe7zvkse8Klhhz1k9blfE0MQQF7th8BTL9PAc0Y7ls4ayXjeQU5ZTWNjTGh9I9srvjApyerSjwspl4aUOA8CAvd1KWsM9wu6Nct0zR2YHPiVpkuTwamc8f8gC9t06wjpg9AhC1d/YrAfIVv1FV4Td4+dqDtgEeoxJLC0FaVlz3uF3qnRqtxkMWl1PvvewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl3s/c9Q+3ks3zOx5aAeyuGVmYBBGO4jHe/B2EDhsJE=;
 b=0712WYvCnFwCpaZu8x1oXKInqXs172uQ8D1OjqsUy3rkatsVFqlCRhkQgt5VxujuWqam4WyoIv+4A8mwyuLEjo4NyEOCXxfUvTbJOlvgYw1mA+gPIoaLFe9BLZOmkEn96DzJiNUeCA7WK98dqBLwTT2MVo/f/OiizJsSPPGiQUzEMsswLJrP171w4Bstk02Dvgl1rI+t3khLx8hhHGR+DNeSxRAh21OJaruhIcbEl4jaQb9MHCBPiKlD3oUmeEI1HMupA7amRWpVhbPvV9OW5kbkeCCbzyZ7+GTjTaeJJhr6dUwxui9sQQ8mOKv+rn1yYR1q3NgFwkgvs/lXNj5Zsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Fri, 25 Nov
 2022 13:40:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 13:40:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v2 3/4] selftests: mptcp: make evts global in mptcp_join
Date: Fri, 25 Nov 2022 21:40:48 +0800
Message-Id: <c25cc64499f37737c35a2d66db3dee1d261b6509.1669383374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669383374.git.geliang.tang@suse.com>
References: <cover.1669383374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: de3cfba7-854b-4113-eb08-08daceeaa49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gava+9QngYe5HVNZNR8tk3vK0eiPKCPsHVHo1ygXm87jwK9P/TTV0mr9nLBjPsvMO8zeKnT+jC1TLT3u9TobF+6Y5GoruKdt82a7HR4DLfHIx3zXtuYDbEiPVHgHGIAzJh+N9D9pO2CgyR4krWTcwuZMtCx9JOVgtHkhXQk8IRy7NtVn2W9xrG3QJVwzn+Hx64i0i6BcmVqOrsh+e2+v65QaNXY+pAFbdxDKI/NbqYYudgQnTUpeMMW4dh1WC2/xoBm3K3cvi81KH5jeEaAmV74lDz0xV8f7FfvIkhgrwkGyKk7udVfNadTDFzWojrTAHpgmcS7cgfXAD3X2+TyQBUXnt8GJEunXdmmHtufpb7GxuMgyVdCdOp3xBzjS2npD3CGxyI3bkeBVyOXtZywEoInkVoT43jeEk7CPeRn0l0gxC0kcOCWjgXLHkeIBn20IypSb1Pxhj3oJNwa7YN00E12t/fCNNI1MjA9cVfjyqtJDLB0RJE7npn3zLGx6Kw60CGNR2iS6VaSA0+VwNDbTwk2te6ijMSdQDPI9PLFKr8LSqix8982Dbcfnhjv//8I83l3ZUyFYAN4wsF/R30DXfO8NJWf/2FTueP8URxCg1jJaIbjEg1pWd5PVRTXG0bW9EG7ucwR1rvgva32/vcKPnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(66946007)(66556008)(186003)(38100700002)(41300700001)(2616005)(66476007)(86362001)(44832011)(5660300002)(4326008)(8676002)(6486002)(6512007)(316002)(26005)(478600001)(6916009)(6506007)(36756003)(54906003)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znpOQtAkwP8EHqBTA75j12rqsbr6o+3cjnrcoFWHt+whbfeD1kYLe//eg19s?=
 =?us-ascii?Q?yDvpcMv+hA6YF/Oi0HFvLukUFtGYukKMVuVTHQQ9vjeYIkwyqv7kOLsQdS5u?=
 =?us-ascii?Q?9DuMArXgsJ+nIsbZVO4GqIoBx5PfR3Hp+3rV8A3haoTLUY7sTmZx8JwYeC60?=
 =?us-ascii?Q?X6mGX5PnBMijtwnXvIYcxftNDcDfyIoYgPqFaH+iK4sV1eCgYo06KsbBvy7a?=
 =?us-ascii?Q?ZFJsAdBrMx4yVuO1XxxgrDWqFvII9mC76TqnyA40qWLqVGG/jwpnOfzgADBi?=
 =?us-ascii?Q?EG9szb3DpFPYFQxlgcH3Zrqz69kwp0d7L1N61Ya54WgQRj9aootX7W0oMZ8S?=
 =?us-ascii?Q?we3rSQCqPtoVL2X2H/2MqHH93jEorQqpO1T/6KCwN9V+4eUgUgZH9zVqvvnL?=
 =?us-ascii?Q?/Nlyw72W5ptFyDFZT7BRsU2p4cGkXeGXlHf3RrRksbOukNVAIM/fbloLX6Nv?=
 =?us-ascii?Q?xeNNEtadun1bKPyLLfy+Ra3T9MNZ/rH7LilovQuNprUHP8qw5wPaZFGXtTCw?=
 =?us-ascii?Q?FBW+6/yL0q/imm9O5OTbcon6moBnyIB9OZvML3dY+NiK2/4k2WKgKQhzzFNS?=
 =?us-ascii?Q?Jh4vMPw7wLqqEGJQQaJvIA42nGsoGCcOw0SBDzRauFXGA7vEmCef/jcS1glN?=
 =?us-ascii?Q?naRhurz7saKURTDpPwxXh8T4B1mR7kIXxVrG72SlfHdlJeaejQUVp96aus4w?=
 =?us-ascii?Q?nfKDWe/pFr8tQdPrfKeEbv9xhhVXF3xX5cDzoLmojWSsd4Sh4pluuhs28PdZ?=
 =?us-ascii?Q?pOs/a9Lsvnye/SzXimGHTeAtMbYQqbKj64jRaCeG/5gWr2oaXXapluJeeo23?=
 =?us-ascii?Q?nuGlFzgPAeXmKy9uvbgfVNyaPywOKjBxoB6wQ2gq+wIm524ravbcexu1z+6M?=
 =?us-ascii?Q?JoOF9jm2wKljs1gOA+malrA3pB+/adY56m+XEfwBNsHHPvjd8E2DteJ4Rtpb?=
 =?us-ascii?Q?PjWKrUdz3tIEDM+jIfS6awLqrNRJoi5/m4BbZQ7U05cIgxxaIgDLHW59qJTn?=
 =?us-ascii?Q?zCavBPDeWhypwGHHmCjEGI981kJcHBbr6gRGVJZeW8uDwfZczOVKyVcHjzYV?=
 =?us-ascii?Q?LmOdddgQOanmX8ZUOLb/Go8FM7VkgbhWEVFYq96Hv2kNBLrhbC/aVO7g4SiP?=
 =?us-ascii?Q?XtXjxvBnauIPtIHG7km8toW2UwJEvClbI8kqC1Rg9YeEMAQLNHou70cRl59h?=
 =?us-ascii?Q?McXzqCzmIf9148jk4SCOCfE0R74G9/H3tccNQ84DtxWE+xWWJs0OJGJ7c4yk?=
 =?us-ascii?Q?ETXjZhv3pRxg0E/0zah8DoUe7G/3dgFhsHAA+kFBmyt8SG4YwjtwzLQIMlDI?=
 =?us-ascii?Q?Ogjgj1UtzQQ6xs9LQC7eRad1p743wTmqu76ONdlnIsKxcV1mtTrPKyddfapH?=
 =?us-ascii?Q?8maexWqdz3aqLR0CcH8oFVtKBCpHFyEJUM50ykwa5iHtOhiJIkjfadMqSSCr?=
 =?us-ascii?Q?lrMN0EkaqzktztDzLYSeTCWAQYUpjdZhaNcnXlk29ZyTCoZIdsCOScZ1ZcB8?=
 =?us-ascii?Q?gAM7Pnutx2j1qWFPUHuFdA2XY1OOYE/SaLo3GlMYK/CCQtg7qYLAIuJ8HKZg?=
 =?us-ascii?Q?Zxv+dopuFqhKELgBjbPjSZj+3+sQ/T7L5avlgbf2/toLycx3Aw92KQFU06X/?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3cfba7-854b-4113-eb08-08daceeaa49b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 13:40:40.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDHN9hAvNhl/TQQ3l4VwtVOwk81kyjk/Wqza8UEFZ4Hl6zopGB7lAfkpS9mMOWjCa7yXVc0HKUaOgmRVn8DBQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

This patch moves evts_ns1 and evts_ns2 out of do_transfer() as two global
variables in mptcp_join.sh. Init them in init() and remove them in
cleanup(). Add a new helper reset_with_events() to save the outputs of
'pm_nl_ctl events' in them.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 +++++++++++--------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 89a30225bbd7..f568c71884c7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -26,6 +26,10 @@ ip_mptcp=0
 check_invert=0
 validate_checksum=0
 init=0
+evts_ns1=""
+evts_ns2=""
+evts_ns1_pid=0
+evts_ns2_pid=0
 
 declare -A all_tests
 declare -a only_tests_ids
@@ -154,6 +158,8 @@ init() {
 	cin=$(mktemp)
 	cinsent=$(mktemp)
 	cout=$(mktemp)
+	evts_ns1=$(mktemp)
+	evts_ns2=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -161,10 +167,23 @@ init() {
 	make_file "$sin" "server" 1
 }
 
+kill_wait()
+{
+	kill $1 > /dev/null 2>&1
+	wait $1 2>/dev/null
+}
+
 cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	if [ $evts_ns1_pid -gt 0 ]; then
+		kill_wait $evts_ns1_pid
+	fi
+	if [ $evts_ns2_pid -gt 0 ]; then
+		kill_wait $evts_ns2_pid
+	fi
+	rm -rf $evts_ns1 $evts_ns2
 	cleanup_partial
 }
 
@@ -320,6 +339,26 @@ reset_with_fail()
 		index 100 || exit 1
 }
 
+reset_with_events()
+{
+	reset "${1}" || return 1
+
+	:> "$evts_ns1"
+	:> "$evts_ns2"
+
+	if [ $evts_ns1_pid -gt 0 ]; then
+		kill_wait $evts_ns1_pid
+	fi
+	if [ $evts_ns2_pid -gt 0 ]; then
+		kill_wait $evts_ns2_pid
+	fi
+
+	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+	evts_ns1_pid=$!
+	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
+	evts_ns2_pid=$!
+}
+
 fail_test()
 {
 	ret=1
@@ -467,12 +506,6 @@ wait_mpj()
 	done
 }
 
-kill_wait()
-{
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -673,10 +706,6 @@ do_transfer()
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
 	local userspace_pm=0
-	local evts_ns1
-	local evts_ns1_pid
-	local evts_ns2
-	local evts_ns2_pid
 
 	:> "$cout"
 	:> "$sout"
@@ -753,17 +782,6 @@ do_transfer()
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
-	if [ $userspace_pm -eq 1 ]; then
-		evts_ns1=$(mktemp)
-		evts_ns2=$(mktemp)
-		:> "$evts_ns1"
-		:> "$evts_ns2"
-		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-		evts_ns1_pid=$!
-		ip netns exec ${connector_ns} ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-		evts_ns2_pid=$!
-	fi
-
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
@@ -982,12 +1000,6 @@ do_transfer()
 	    kill $cappid
 	fi
 
-	if [ $userspace_pm -eq 1 ]; then
-		kill_wait $evts_ns1_pid
-		kill_wait $evts_ns2_pid
-		rm -rf $evts_ns1 $evts_ns2
-	fi
-
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -3023,7 +3035,7 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset "userspace pm add & remove address"; then
+	if reset_with_events "userspace pm add & remove address"; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
@@ -3033,7 +3045,7 @@ userspace_tests()
 	fi
 
 	# userspace pm create destroy subflow
-	if reset "userspace pm create destroy subflow"; then
+	if reset_with_events "userspace pm create destroy subflow"; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
-- 
2.35.3

