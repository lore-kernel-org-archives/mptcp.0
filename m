Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F5362
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 05:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DloghzbgPxOelv9vQVYyCD2iDvTuxCsBsBkW+m9Ebae9+4y2TU6pbODQ3hvCVODIUaHwNME2Vqb75qJpLMGdUj+gfwXkgyzq2C9V3mdSnfuAxwfEq6kgK8W4GaWqo0fjU/3U1xn9w9xQVsRGmU+0jCkmWWhyJeJ64qEk4EPTFd+O5MrPqDUkDAct0cpN6dB+L3l2Z2c5Cx8N0ywUvvGLqUo7ZlyDZYS8Ek8jqwMc3VrIOZHsBrP/WzKDTIM0UVJR+DcTGdHc5IthMh2/UD6sDyXvTlV9DNYot8l8oDDlFZTJP/yAemqscUHseieQ+AzkQE9eRljo4V+MsgFc5hQZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yoCYbzmHX+ahF71N3doDg9slnz7Xv1qLzHvPOUoF6s=;
 b=fRH9Ty+twyWSNUR3hkAG/847HL7rFPMcIeqbAMCy6ykhYHbrVQiNVWwJJVB+30VF+m3772lUiCibSZwml8B6zyehtLwdJn6Tt5o5TM2KPEpDaPNOaVzTHGFNe/n2DEtMN6Sn2BveCacXDZd3qkqSOYVIhHHkvF/3G9Dl/dYan5qX/kCeNcSk5wn5qelz6CHo1md0rLjyfPV/S+hEw5HC9f2wDpgC5d3hteDXSjg0Ny5oGwGkDuReAIm5C9A6E+aAz4Bl5PgfZCwqxUbYhuSAN4Uwz2NOq/eQ4RqNAxzROPAceDLAjDBKPQE4yP7631F59GwsOBd4HFG6uldvLVhs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yoCYbzmHX+ahF71N3doDg9slnz7Xv1qLzHvPOUoF6s=;
 b=I4H4LNfW5RA4bPF9x9PjpI0c5lZZssEdjH0X0qOiAw6AdoA3wSw1dlhHudDFM/CXE9HeJ2OWZ1XIHn6qXeptpfy4T8aVDycBc4aUj7AI1xICwvHR0uoLd2tEBK1PnAkVH9eK2vkPMI063gaGPyq/vFtI16kK1iS0cWE5MXWUWN4onRTNffD9XAPiSs50MBIAZL2UckzlEcNpZTY6GSyCXP5TzNsPdy+STedFOGrakGnLGaQn/I62+BK595pjswm9XwMBkqzRIJSWRicrOnmNy7iM6kPnAwUVQSkMcVyoT10dME8skxMm+i1xwlCKaskOTy7CnTeeZHtxwROoQBpFxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3833.eurprd04.prod.outlook.com (2603:10a6:8:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 05:34:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 05:34:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: userspace pm add_addr test
Date: Fri, 10 Jun 2022 13:34:10 +0800
Message-Id: <ba3d782f8fd64867c37a64202dce2565067c9740.1654839195.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168eea09-f10a-40e2-71f1-08da4aa2dcd8
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3833:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB3833BBF163B3E77E205E55B5F8A69@DB3PR0402MB3833.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DDV3mU0EQmXjOf6f3dyp9ZcUMG5gVGwZnsYQDHvx/l2zOiqxnbT0n0YLMQ7wo5E5dApomUSA+3CmpH+BQiHglv10bZcStex4ncbWwPA9Nfpq69vVT6HnbxDbdvwJiHfWK1mhNOSgE01t3z9/pmK8hHJQ5eRuheGDUJiGL9dDICdswy6LPf9MpjI0Op/QBJLxoGPuFG7L5hEzEU9ewuy2Bs3MRw3iLDDNHrkriqwk/EJKbP7m6anqnK8sSkNByRyUeINAPHfrjJ2F4xdbmkF2R2NLNcw7Vxcl6E0DNN/FsxPa6ofnbBVtybi07DGQtp8Rqnq6lBO8zlbTaU1WtFlpV2Qn7/JVyqxaXmTcsu3B8MmFZUNniovpkd18etIZIGksKRYiTnus6JYcktTmp9mqC4yHyKOeVd4hiMi3sTOUx2h6PNjK6ZRDNOT97Cixv12eut45ZfXnDt7OhAlx4h+TIx70JzI6gv6KF9Wq6mBjerB2tKU14xLDmLaoLc7onBv9Q7gWF34t7SrDEKNnOM1HuJpdC9m1pyQrqMY6erdymq3p7flPNiIXQR7r2uDroNeohVtwi4A9eThwb8o2xDcLXaM+SfyVyI9TcTKknRFZ3XM79ub2sZzLK0ymHb3NCZI4tQ/or64/8bjibgDrGiFbcGb4TL7ci7SLuwFyJjnDt5xVoiM5qte/WrU2OvrOJz1t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(8676002)(38100700002)(66946007)(8936002)(6916009)(4326008)(26005)(6512007)(6506007)(66476007)(66556008)(316002)(6666004)(6486002)(186003)(86362001)(44832011)(107886003)(2616005)(83380400001)(2906002)(508600001)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?us1ZGuDQs4bqkBej8yezvo2RpZ5fjaAxF5O+C/eTgocDb0TIbl6YPNQrIno7?=
 =?us-ascii?Q?aD0LaSWlrR9AO1+rq5nQStYG8iqwJmMSTGfPYUzHWPrrAk8rek65tzH3Xt5N?=
 =?us-ascii?Q?Z+HMBiQIJ02Tj+It1bXq14R0iYRUZNXWbqy7bV3nchGggC6kjwVA0OFHyo92?=
 =?us-ascii?Q?fbaAxzbBvZMmxFIDI/riYOCTxpG3fSOyaOk2zpgIZyjzzbHzSfdk5qWHABjg?=
 =?us-ascii?Q?de5q1z8lApFtYO7AkRqheWQRTv61DDXFk95S5TSx6VK0MFEJfAWvrIWw0LRp?=
 =?us-ascii?Q?yBVIRq13i/WhSfm8BtFYRF/9aQNTz0S8lIhzZL82VJjf3MhSQFzaKzBmv5K3?=
 =?us-ascii?Q?sKRM5xxVFikq9t0TFQsN82lm2mVowyoUkRH1jevM0GlkSJ75ziu6RKBGEjYX?=
 =?us-ascii?Q?bv+F9vdvsjnCJWHgSU89uxeAqwaVgV2cor4eXgukHSqKvFZ1e4slo2y7r0Gw?=
 =?us-ascii?Q?lP2RkpuaeQvFSdUGkykAG/HPUTXJlAnr93zikriRMy2Vs5DP1+kw/V1nkLJd?=
 =?us-ascii?Q?iqrgS5p7HfIoJIU4JWfGRfYDQ6PFlTgwquuzRiszrDsZKvCgDBI+dToY3pLH?=
 =?us-ascii?Q?gLsTNfvCDoK9fF/IBerbfw8haWEsdA0lhx7dink7VfieXs215jbmAfvZSALy?=
 =?us-ascii?Q?xzeIO7weXwBBcCu2I9OLv4BLo/3iewpsrQMq4Yfs8zKbNlCvXjMY9G7v7ouY?=
 =?us-ascii?Q?2Ynp3whbCdFnBPCXKHyDfRB5TgcoUmqIaK5ANSlz/feyeUpZXFqbAZtE8wJD?=
 =?us-ascii?Q?nNG75wqK/cC/oTqUVRlAHGxpRWrjM6mPDw6gIZAZr9owm0EBl3ixAGjFA3im?=
 =?us-ascii?Q?BGX27hXIPvhV1IolwUrdEPExCqOKsz/6dh09hdxaSpf70zrVzq+4/NZAw0KD?=
 =?us-ascii?Q?u0uPUi8tdr0wlODqsBMVWZpVcUbvcHnI8QlYb5bKRAqsTZa8FLzNHKFkEsbE?=
 =?us-ascii?Q?P4LhImU8WQgl4/3kmP4wNyqAqnl2cI2BA8gLeP1vRDo02ecsQRq3w+sHtLdf?=
 =?us-ascii?Q?ev+Nzemy0d7dunwGt4AQPF5/US777+i/OMEX901i2BbAKWU9aj3SDiEhoNkA?=
 =?us-ascii?Q?UKFWbnA43hJ9GIngxi7hJBbM0rUXaVAqbj6o/yuGxLY+DaVuykpVcFU44Dmu?=
 =?us-ascii?Q?yskUC7rNlm1M2N+oQD4C2G9+ItHwuTbp9ltvKnQHm4aK/WlCwDK7w029Cdqn?=
 =?us-ascii?Q?MxhTCtFhIPw/KwWcIG5bbE0MilRH8REsBCmdVuBva4yru/FPeMwdIALfX9u6?=
 =?us-ascii?Q?gD4ysLNRBn5/OWDnd5T5RjB8X60N64U323O7xU7J+v2KAsfhG6SDLjjxYY/C?=
 =?us-ascii?Q?/G08Z0YK2JUpzxBzVcbMPWWcXNVtpYrp5H8McvP2PnQKA65OTOG4RgKva9uA?=
 =?us-ascii?Q?TNy9Z2dgq7+i9DBCl6LwxbKjnWbNVMo/SMiVtYvmAXg5Zq8IbQH+QPqsqLhV?=
 =?us-ascii?Q?0HlMqUM6B39KEygZ/8FJpuHIj4YPVS61G0HxVnYF6kN52CY+VCmFVHVHOIWA?=
 =?us-ascii?Q?f00Esz7qY3NYBP4QRVLSF+QZxixnE+Wh+tV8N41ei+SP9iCM0RcH/A4Dguq7?=
 =?us-ascii?Q?jc7x/DG03BmLuHzFBsXUDRSrark1jJ5/1LiANnJ9q+YI6n6/PMrLAXpVsyFm?=
 =?us-ascii?Q?mhtIlcwoKdCq1fUR3cLUMJzE307NDXlWh1kpoENIsPjN9lyvl48jcCSN2GKX?=
 =?us-ascii?Q?sGJShRoEXuuoilTXKLT9C/c1XhYl17jBXp0q62P2D0Sb7QsYmPjItz21P9f3?=
 =?us-ascii?Q?DpsmWLJsllKKjkRkht8gvU4FOR+KADw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168eea09-f10a-40e2-71f1-08da4aa2dcd8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 05:34:18.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/XnU3mNlb37W9wT5uXuXxYYssBqCA1ShoBTVgdVvR4PHtOszh1y55j0C7VkZvHkoa7+cllX5nI2S3AwZc3+4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833

This patch adds userspace pm tests support for mptcp_join.sh script. Add a
userpace pm add_addr test case in userspace_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4406b7a8064..21fa79384c9c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -654,6 +654,9 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
+	local userspace_pm=0
+	local evts_ns1
+	local evts_ns1_pid
 
 	:> "$cout"
 	:> "$sout"
@@ -690,12 +693,24 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
+	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
+		userspace_pm=1
+		addr_nr_ns1=${addr_nr_ns1:10}
+	fi
+
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
 		# disconnect
 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
 		addr_nr_ns2=0
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		evts_ns1=$(mktemp)
+		:> "$evts_ns1"
+		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+		evts_ns1_pid=$!
+	fi
+
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
@@ -748,6 +763,8 @@ do_transfer()
 	if [ $addr_nr_ns1 -gt 0 ]; then
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
+		local id=10
+		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -755,9 +772,16 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			pm_nl_add_endpoint $ns1 $addr flags signal
+			if [ $userspace_pm -eq 0 ]; then
+				pm_nl_add_endpoint $ns1 $addr flags signal
+			else
+				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+			fi
+
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
+			id=$((id + 1))
 		done
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		local rm_nr_ns1=$((-addr_nr_ns1))
@@ -890,6 +914,12 @@ do_transfer()
 	    kill $cappid
 	fi
 
+	if [ $userspace_pm -eq 1 ]; then
+		kill $evts_ns1_pid
+		wait $evts_ns1_pid 2>/dev/null
+		rm -rf $evts_ns1
+	fi
+
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -2810,6 +2840,16 @@ userspace_tests()
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
+
+	# userspace pm add_addr
+	if reset "userspace pm add_addr"; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns1 2 2
+		pm_nl_set_limits $ns2 2 2
+		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

