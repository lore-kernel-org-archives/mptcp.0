Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DDF10EA
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI2p4Opo3DzGDyzr+/jBdwl8Z2sTWnse0IrgtsxFNOYFOukgpT4W6HUuWCECM5IbmA+SbB5IUQSTX+P5sCwz94ajSteOuGfKXOEBH8hRsANEiekyOaaTKBgqXvXI57K/uLHs/LFMFnYUkoCZAcynQAeiytfV67fkM+XBrlQI9B71MLVi9++rHX7IsQKJQ+ipF4FSWP6wOaoFrhy3T7bCjmTT0vG6OnQzchmh9dCSCVnKOzrmIPDjr+UZi8bD4JngEhnq2PLQ3EfvcI3YL8lVPieNF+vYmuofaaisj40JBV/TPNd8SKJPpeZLqzwGnZ24uRGVwyS5j3pQqO1mLNJpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uw/u9MYYb0qmKlxuV/13zxwyYqTKS4pyY7+vF/jkGc=;
 b=dvu9aSt0tokC9Yp/7VFjzIcmwzEJzr+qNZQndcHDyeaOf9B0E1wcJumtXpy5NDrioaoy7w2tctdAkLtoWtxReKqD8kB9exWKLH+A8bew5QG61V5FbBfgKbj9QMxjJLaxnCirwz57z60WTwjdlOS0vgPEaNf6nf0nwQA2VTrrBgmAW0+NhyI1cJmysjsYMYcnQqSVHHy6SOSoaFuK3JJpBTJL0uT/zDiydfd67GlfHQGOgQJ+7q5e4jQCkrWR2O0bqOJP4OCARZuSD5YEEeV1Y4+8bXwG2ounlIlsEX+Zz8LDShDSOXPUTQUJ5jIMjz0I6E2jO/QNZDIJbynwD0AjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uw/u9MYYb0qmKlxuV/13zxwyYqTKS4pyY7+vF/jkGc=;
 b=DK4Ks65tX4MLPb2JBDYZlkP3Dv44MK6tsKPqzYJPW9BFw59fePEb53+/FAstqli168RpV+l+bUoJUQ8B8v1lBXhX6Lo21muJ6O/G0M6HQsTf1EyrWdxUh1phpbjs44q+hmFoQnNALaoeWWG1Qh7qRsv/4ViwfckcNeJ5V/oPm5uOpB+jYz6DMgGizd8jIqSYT0JG4w5cKRKszZ0rqUPqaUTjVdvBy3rQcq1s7+PXaTrzO53HQxwC9rC/feNJLaLspiuDsLaZhkLsDsF94dBrxLRehWIwFMx7meCyLWr7zITG9xX5vN6f6uIeYGAsfGVKy3/trqTtsDS3NQaZ/xzqBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:11:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:11:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 2/7] selftests: mptcp: test userspace pm out of transfer
Date: Mon, 15 May 2023 10:10:53 +0800
Message-Id: <8c0b3b33eb79be864cc5b106a5eb21ec1ea84b96.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684116357.git.geliang.tang@suse.com>
References: <cover.1684116357.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:404:15::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aaec3a2-eb68-49ea-f541-08db54e9b794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mmhftJGlN0SMJaFWrgPJgW9Fm0Svsxu5wfybgVSHwx20faH005fipU6mWOSVIt2b8r5FJEhCCQsP+ZuRtPQHFPGMQwCLmUAkWVF0QSrlMW7Zh6cDyv6SPikDSL3BAnJU4L6VjWQ19YkBm3btZR1rbfP5zUQlDQ1IkwHlLbGlwsYgxBEiHokNmW5tTxkM+zK3k6x//zCNYcWgbSt6Yp1mgPBB9F5/hbMFpBWQbIOsTk5M8+sdrYIduZE3LiFZTvHVR8IxYCmJocljZy9CMbJYQ1RgwLmJTX8MJmGkoZ0KGTkGc4vJ1c29ypWP9BroROKcBeG/TKaO+l6a57c4yOuPvOxH5ts5o7f2k9IPi2bnvbgzcYUxW1PtmDiGXuDcPyE/VwU3/NO/ZAj7fK8szg56H+zP8Sg6f2nBw4qqO7+OL8k8iEpw/ypP1kTO3E8KJoOS5iYkMgRK5DYSwl5YXCK01CjRXQ3Y0QI8b8Z+9wFguWmSH/bgaolpM5jSI4BLJz/k3FgQHoSUi+sKZAJZpOg8nMOnH74VOMm9We9Mfbq1B52EAV2Jz+XUy5pUgphE11cE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(6666004)(186003)(5660300002)(44832011)(86362001)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8RSn4DTPkvQsSU+h5GQ9suDQIHyjTa/Gul1I/uMUmT2G+4zGoRnuTTq7K1H?=
 =?us-ascii?Q?10qnAiLMxYmM7HSJZ+M+u4jN/wHzo92La9qbEeoV5Z3Lp2e2GdinPshtVUq+?=
 =?us-ascii?Q?u10nP/MW3gtep7FeJvztMSLemJ1Ew8OdpV2oCmTV8bk2VxeGuhOFZvZ9QXja?=
 =?us-ascii?Q?e9Av/aH5Lrf1s/yJr2CtSVDqiW8hXbrodAVP1bUAXaJusOYW6TRWcx7QvfJy?=
 =?us-ascii?Q?MLOPsUur3B0kaJ4/AQqupM6dP8AmpkFLnkRDGDyx0XvWvaCbNastIrUmGLDG?=
 =?us-ascii?Q?LzJPvsftppoXfOvRV7phSEd9UxkQikAJafa1knTnsSnKWot6feuWxba7v49C?=
 =?us-ascii?Q?DOPNqMz41wvoNZ1oDsxl9rvdMt648ZPGRDKQ+VOUWBQTp8+zdGhLvazwM8YL?=
 =?us-ascii?Q?E4FLAfKoP9dNnNu91O/BuriDTrONNQYVGucSG0jt+kF2vgKxY/WnN2a0Ujpq?=
 =?us-ascii?Q?jQ5MPk7I9BFxeCGBfbLLw02DQhJy2mpJSC61Y33iMHBh/2MwYGhoVTgyomM1?=
 =?us-ascii?Q?cM0ypemvVCrYCGoR2gwMzG/G2QQHUhhnFmyMNXZR2bvbU3iGgRkuRwT641Nw?=
 =?us-ascii?Q?DiOErqyZC9dRHz4H1jPmq2b4Oxe5sDZuLWIxlX6PGGpzoJjcjmN0wdwbqJG8?=
 =?us-ascii?Q?HXsHL4zSAHGZXD+nHPLBKhVbSbQv/MJ2HqADM5B/W6NIegoMLH2c3BHKZ/dx?=
 =?us-ascii?Q?IiFNPRTPsHPQ+vNjST6JvH91QJhB10kiB2OMWrefyqBLO3CVusbs3EX7aYLY?=
 =?us-ascii?Q?Bv47PttSSfyXGHJM38ejbGhhM7C9ZgiWL5OIpPcN7ridTJYNqCUDBmumO9F2?=
 =?us-ascii?Q?/zHs0cpOyKMdfI2doxyvNR1t5rBMEbEFTcuNSrX0fWpz5okAZZdSdt8d4y29?=
 =?us-ascii?Q?aNrFfdZ+Mr49YAujn7FD59p21mmlnY/OulvMdHT6jcmdiBnB5Ik/77Fj3H4V?=
 =?us-ascii?Q?gmVCIgIkGb4A7m7XFDQ3vgWl9sYYK21D6fN0UKcydNyMcNmNSTtKtNO+w+hX?=
 =?us-ascii?Q?neQVzBjUllE4yy7M30vioY92yTfQW7oPvgwJNw/NE2x21fud+KVnMFxInEbY?=
 =?us-ascii?Q?c5A/NPQSh0mQMHL81aPECUCuU/XZWtu1OskO0g5dz30W9W0ktuxOtFkqYLqx?=
 =?us-ascii?Q?ZtnzAR0LfSUcWEMMbn59VKwgqOk0nPRNDcazvaIYPkL5KO8Caye9jNLC0AQa?=
 =?us-ascii?Q?nQ3/kZvTnIk/yz7r4YQJDu8jMrMChsUM9ypSJksO+pdB/oZFuLu5hMyQxFsu?=
 =?us-ascii?Q?bT3hr59qrxS88sn/1d1t6jvBDFYLLlGnqafr21p7aGY3TmVGqRyW4ZewYKVD?=
 =?us-ascii?Q?qqfFdr0mbGN3TIzjWhqlvQ8s2LaoDomGTibAx4eUcJUV1ODkYHhAvFLNQZDw?=
 =?us-ascii?Q?GbvFSkAIXxq0Gl697oge7+RYZZ5Hyf1QugLqCbfrTlwEPiNeAU3bN6VHjew0?=
 =?us-ascii?Q?ru/G7orRXRXdkEq0HCIUcjmT6HBJNj/O/BsBRrCkT9zUQd4StMNpLtxH1p1i?=
 =?us-ascii?Q?UsVnfThFEVPd9vhAhxyTYOtGwBTADsUNsJrwIajcgwP6OUfyeQabtNRvCFBf?=
 =?us-ascii?Q?r8q1bYot2ilmaGjitsgA6nYaUfEizDPMfUit/nm/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaec3a2-eb68-49ea-f541-08db54e9b794
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:11:39.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHqtoX3kwsv7mvG59nWwVzMXXNaUS8UpcnZjCKjsn8Z5U82awqqsQoOe1YDREPTbDeouSROKj9G10gxamvN/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

This patch moves userspace pm tests out of do_transfer(). Move add
addrese test into a new function userspace_pm_add_addr(), and remove
address test into userspace_pm_rm_addr(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 122 +++++++++++-------
 1 file changed, 76 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6aacffa32bb6..ac3fa8f0df0f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -723,7 +723,6 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
-	local userspace_pm=0
 
 	:> "$cout"
 	:> "$sout"
@@ -760,11 +759,6 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns1=${addr_nr_ns1:10}
-	fi
-
 	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
@@ -792,9 +786,6 @@ do_transfer()
 			return 1
 		fi
 		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -848,7 +839,6 @@ do_transfer()
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
 		local id=10
-		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -856,24 +846,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns1 $addr flags signal
-			else
-				tk=$(grep "type:1," "$evts_ns1" |
-				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-				dp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
-							lport $sp rip $da rport $dp token $tk
-				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-			fi
-
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
 			id=$((id + 1))
@@ -918,7 +891,6 @@ do_transfer()
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		local id=20
-		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -926,21 +898,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns2 $addr flags $flags
-			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
-									rip $da rport $dp token $tk
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns2" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
-									rip $da rport $dp token $tk
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
-			fi
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
 			id=$((id + 1))
@@ -3069,6 +3027,65 @@ fail_tests()
 	fi
 }
 
+userspace_pm_add_addr()
+{
+	local addr=$1
+	local id=$2
+	local tk
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+}
+
+userspace_pm_rm_addr()
+{
+	local addr=$1
+	local id=$2
+	local tk sp da dp
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	sp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	da=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	dp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
+				lport $sp rip $da rport $dp token $tk
+	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
+}
+
+userspace_pm_add_sf()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+				rip $da rport $dp token $tk
+}
+
+userspace_pm_rm_sf()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp sp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	sp=$(grep "type:10" "$evts_ns2" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+				rip $da rport $dp token $tk
+	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3140,21 +3157,34 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address"; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr 10.0.2.1 10
+		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		userspace_pm_rm_addr 10.0.2.1 10
+		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
 		kill_events_pids
+		wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
 	if reset_with_events "userspace pm create destroy subflow"; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 2>/dev/null &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.3.2 20
+		sleep 1
 		chk_join_nr 1 1 1
+		userspace_pm_rm_sf 10.0.3.2 20
 		chk_rm_nr 1 1
 		kill_events_pids
+		wait $tests_pid
 	fi
 }
 
-- 
2.35.3

