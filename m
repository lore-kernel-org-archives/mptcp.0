Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1B182CF
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RXAOGz/e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLUBM0fPsc1JHowXF1lPVB+psbyrow8OKmY6ZAvrznsCUfhe7YEG7SgYRkUQEFjJ5adPs05OkWLGtphC74Hss7cdtNB22OzgYQoL1jawIlx7veqqmDcLO//WII336KBQU2h2rIiVvVdeiQtHOyJwhDvcIy2wmYMdOZXismZ66hV4x/rcS1uEVHvHcTf4Ubnqzkt6CgNPJr3M1vih71hageW0719vtytT5c1IdBHmJfZXissK2qKUVBJ93TdJgHsOvQH+7Rb36mjjuAAaIrF3SHHoaZAyFFwd5ifE1B3O1U8tHknqrLPYMTJsJD8hFNLOkBfsH6FTAyb4q0PJqJTGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3MVgFLclNEChcUURPIioByvIJrDCSQ/lDchMxB3/G4=;
 b=byngAOPTaAtev6aI9pD2XH2ERYFpubMkbpVDNBfgFMK02SOLA/KIlqI7XDqW08y03CZYEHgoTiaHeDEaMsrpCSEYNdc+ndFzaiBQj2Ma7/9tZc+q436Ft+I3kl8KsZlylXcNbQNs3yxBIhi0pgifgIUg2nGo9RJASONoX6xXOkQ03RXDrhXrm/b2mJkOqpt77UBQ9pg6RVpZUXUNI2cL5Mssy/AecMq9g0MtUbabIgxGoB0dFAqwcEuCRk9LeyuGzTugata5GwodLrqJ71NNbETjnx4gIA75UWzHTlzrk/8RWgwNAtp0gWd0ov+iE361qjiWH5lVGMWZv4MLh5XqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3MVgFLclNEChcUURPIioByvIJrDCSQ/lDchMxB3/G4=;
 b=RXAOGz/efe/mie5+jsBnuQT9JfaMd1xZJfePsmacNPpdgoIU7izaUpiduHnmAix0dNNuQ9Nrn8be0i2dTi95ZXSxv+xbVwKw5LHQnSBxNDTVt1NYBqgJ6nixDaoK42sRL/wV/8gH8calN63SB5nGQiZLsIOVUZxK/C0qTrXb5zzPCq44ymCY9kW3BYFKLPTWnfPHyJ315wS+vvCPyWlmQFWG5yUp5liRGaKU5odw/xVPB2zvPSbRIqUOqgQWreByrsRKSYkV2JHc9Rc5Xs1jzVh1L898TrztIdOzPi8E2EvQJ5DZJgL8j3IFjfPzxQk8J/sSIBqxIUwZ1o8gQAX47g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:30:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:30:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 11/27] selftests: mptcp: dump userspace addrs list
Date: Sat, 18 Nov 2023 22:28:26 +0800
Message-Id: <8c4de416d9fa6753b5eeca5509e979ddc134d443.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0187.jpnprd01.prod.outlook.com (2603:1096:403::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 90bc483e-cff2-4a16-b80f-08dbe842e444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5cw7IumM1DtsdWK7QU0qjN1bsXDTqgieRTN33oC2KpLhXDNXf4uj+/hxiGW4VCkDMzdq7moGl4fqq+M2iRnSafQQJTFrZYXulqSrv0ij9kCG0uWWacTInPfoCsa+TMcGAtTVaVnkJSpLnjoQtb6lPM6Ziy43mU3soi+yTkyIF5UiEfXSrcJjkXAVC1VgcU/NU1e6QQif7UVvhjz/1K+2vTrZg9ixoHfD8/1D14kZykReZfNLkmuuXXrasLQjXMkDTSsZSrQJBEWpkesX3YEL5D6Ls9Fh4AToJfcID2J22IEvAkN0sNxTdOSCq6x6QFjDUce7vxFdjcxa6HNhiK8Zy+drEXY0WxxeVRxp/5Cp6NiXIwGTTp/8cHWfVmoBVPGS6VW16cf6eYoHCjuju/0lFfR/CshoPtQR9MwJHr98XmRpsEY1f6vChfOVWxc/b1+2a8crZeDU6GdMxEjoovs2EszA6Aof1awM4JfyS8AJDEyZwSo4R6oNLHL/mEhDmbcyetVHYzTLgidgAFWnX3EU8BeMVYm+PTQTYYBOu47xm/mUiyKbI6oIargW0IkSZAGxKJsWG4ztm68tD67ji/qIA4QkpStmA8ZZ4uAvsxgsnxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnJCPjLkll726iODnK20g26vHuBHNiCnXwB8X6nwAoWue2p9LVbjcs7oy5nD?=
 =?us-ascii?Q?bvQM6UCqdvKeSjq9rd5uogXTr/NnPkfo/PVdo1+HHbyo07zq3EzxdYLZDxK1?=
 =?us-ascii?Q?sXdqAN3QoOynR5+mugXGqXi3dfRHncASBJPC07MciK5g1B67nTa7eVq2f6xx?=
 =?us-ascii?Q?R1Y9lp1BNdn86EHs/cU9mjMFol56u7WAJxcslCoMuevNOGqUkEzh/WfpLQ02?=
 =?us-ascii?Q?h5cKZ07XLhceX+KtVw8Fs25lT0cY9cC5eio1xRpoYWZ/BRb8VJTnu6nrHLzE?=
 =?us-ascii?Q?5xNyE16Uskq0CbcFBkkuUC3p+O3hqqeU1xHMKUzHvIvoe5WPFFJsJ9bSL2LY?=
 =?us-ascii?Q?xUriEuJ49U4A9jj82+LQUwLO2FHrIGqdtjEHo7l9bB1ekuC0O4jxltUxNgBw?=
 =?us-ascii?Q?DcgX8NxjirVtpYw/R10rA5twP6idp3euyMHNCEWB5QvBEdDLpFYPcgstVvKm?=
 =?us-ascii?Q?TNt6XnFeMHSrAlHSqsby9tIyw7W/HjIyCKwfG6gCnQytCHl5wrxwh9mFRy3D?=
 =?us-ascii?Q?K0MUpYyU5zvh1WsxzwvGiGWloE09btv/iRAnSBgbmj7Ssts8jTbf0TE90XtY?=
 =?us-ascii?Q?u1u3FbH5FV8ood9KQ1yCelHjJyI/2kRGb7CUTe+v3IIPFYlB7Bm+bZw59VYP?=
 =?us-ascii?Q?m+HtrWJPwXZ0IASJkMSm0T+GRMniW8c1Ry/YDmDzA6Z1vHisg2rcDNpbd4O9?=
 =?us-ascii?Q?wHa8XuRaPtm8/2kCMCcFIWZQ1NKyMHCm6Uoo01O/zZFFBxnZuBkTWrzOR1sM?=
 =?us-ascii?Q?33PGnuT+hCfNBASqzs1FhLE1fHuFBExUAkQwORgD8bAJdfc6vCWj3r20zGfU?=
 =?us-ascii?Q?0c22/NG7ZlFkL8EMrV+knGzolgh50OyKu5iOFNuogVfcwEzd2p2UQjj3irdN?=
 =?us-ascii?Q?u5z41j8zjTpBk8p7srrI+bZQaYSWGxzwUuTvBBBcok9Oi4oZJAqT86ZjQnaC?=
 =?us-ascii?Q?aHwjmbUDnJT0+UlkvISPfEsKZ5DPIG3UeF+T2cOWSShqKE0tYK0JboIbot0R?=
 =?us-ascii?Q?rS8B2XL10QBdk24oUnplvqHSefJUd8CVeQ6nGjx/kDFgVjnV98nhebv5wjbC?=
 =?us-ascii?Q?W+lAARVAyHBcK2zqYNieNEq1iSZvgRpCNSBU/fhzXFa/eTgDX0WDRVUTyIue?=
 =?us-ascii?Q?noOxFHVHpbC8Ea/Hcf/tyf3m05YfxytyAWgHoGNJ39lGhmn6ppx5kdIcXIph?=
 =?us-ascii?Q?qp/IZszN/FUmQ5QRud5OvK8PdNze6/ABs5SVHDzBoEHJHLP1/gzTMi8QxsWR?=
 =?us-ascii?Q?NrefunyzS6hqW8wbgcsCHAMR3GWtAmUAUkLm5qrjH58KF8GoTf7eoSEzACXq?=
 =?us-ascii?Q?kxReg6y5qYntQTTnpc0nw+TPwJhVTWq4cr6bzCzO4qX6uynUGl2VYEQ2DeTh?=
 =?us-ascii?Q?rZBKbigBORQHC9jpg820PCFeVXnNq26D5if72vlzvNlljcl+XuDzJ3PzCCU2?=
 =?us-ascii?Q?h7Y/O5YsgGBeUoDhvNGrY1Jka55gzeM9vGnvhZa3Y+H7gbBpww/EpmntPkiU?=
 =?us-ascii?Q?bsZ43WX39aCuSXcjX8upomMCSsrhQnqxGdMwCPRgsL2V28rAZthAr24acB1A?=
 =?us-ascii?Q?IQfj/nPtlGR0LQDJ1qByK6Kj9any6maiTI6XvjJTmJXvXeM4bZIeQt3JDm5V?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bc483e-cff2-4a16-b80f-08dbe842e444
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:30:19.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHTYof+/80Qh9B2FN2Pq6eMfAV5hLWVlUBIy8OcYmVKwl89amazyjw6dCtmIqWB9jZYIHu1p/b4LaUCNGN41sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch tests newly added dump command for the userspace PM. Add two
new tests for userspace pm dump address and subflow. Use the helpers
userspace_pm_add_addr() and userspace_pm_add_sf() to add an address and
a suflow, and use mptcp_lib_check() helper to check the outputs of dump
commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 98b6814af0e5..56a795a7f538 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3511,6 +3511,49 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm dump address
+	if reset_with_events "userspace pm dump address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"id 10 flags signal 10.0.2.1" "      dump addrs"
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm dump subflow
+	if reset_with_events "userspace pm dump subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"id 20 flags subflow 10.0.3.2" \
+				"      dump addrs"
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

