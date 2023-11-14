Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EC15AF6
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nT4Szux1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDNuBELVgqpUIV5ScMK37jBgi9pY9eByQLUypLTLObFpzFZIKTwLJYbL8SPAB/uZ1bBTeMr3xsLARPYuiGDPE4ehVbcPgzGYdI1f5WA729sWG1NH4fSCVP33mA9UmInUOOHlNTMvC1yymcbT79QjsmZxY5su3OQCMTtBXTLbadXXxOKomDKhlaS9oND0vDF3dTbp1LydLB1KOFKGHAGISaqC9EakXP+BrUwS5EU2Y5W8+CkgrQ7rsp4DiylaPldeMcULwqZoOgTds5ig+vKGWyElRiai4eF5aKuceJ9bdDQoG9iVmJlhOPafBoRIbMOP6ipa8XKN35A0++AMn3VeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89vwzIBrP70ufSNlyGK1yDJy94W5tqbL5wRnkFA8pEM=;
 b=dWSrAuu5yB1hRIgjr32uRwkKgqYkRgUu/k9c9LL60z92BNY2h/Iqh3WqEdYQtsubLpKVIZ/UD7Hb5zQkZr3HHKDq/+uSH1PqR54waxe4sjakCcUdcOdgQSuzqOTDWN9Bpsn4f9hBZpFrQR3cOvWaE+y+70iGI4Th3qPROZ9ARpGtG7r6gN5twIdlZhdQjhSBy8oUPxhZ1QVgapYbQoVP+1tn+wLe4/a/ObMBbiPiHC7fwnl9hJtBpYI3D1H0OhGVg+/Zc5i9NANfsLt7bmMfM8RxpffdDjz2bMOZGW47Sms1qM57ViJkRqa8rZOq2T3ajLaPdnFEF7+75T4qri2uSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89vwzIBrP70ufSNlyGK1yDJy94W5tqbL5wRnkFA8pEM=;
 b=nT4Szux192atFTTWqyJmZ7CgtstVzWLUFktZA3DlIWanhSpN1+jYtoenSpzWpuYx/selG8E1Bl+2Y3KSO/3UgMJeDdvpvt3eHzt89V9NPHfIZn7VpmGKAT0enhMYjsIVi3Qv1t+U0XiBJL95lYI9JQFR0OHFb39WhbhgSQ7oOrb/awpG85aKQkkc8xVTNrNgm+KeoWfgVjFgLgdP1xWpFJ0StRY8drO1fHXYN69vyY3Nq6GhdW16uzh6JqFHcpkWp+xsNJa0JnWcD+fpuLzIhLwRkO+2B0kV/hb/WuSa8e2AFjk4YquB8wvXOEyqAJvU2f02sCsWvGRKva/JC9BgLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:25:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:25:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 29/33] selftests: mptcp: export capture/checksum vars
Date: Tue, 14 Nov 2023 18:21:59 +0800
Message-Id: <1468526f0661fa6917e3771ca274bdac7240612e.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0032.apcprd06.prod.outlook.com
 (2603:1096:404:2e::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 022a60e2-c4c2-40ce-eeca-08dbe4fbf5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	63e72IbJ1ucWagCCU8SgAWBdd1O448vbjEV7xKhu6aUzJaimNxERW86PeelaPCg46jcUuRgGfxRi7QW+wGoutDl98uABJq33EwRIST50LMsic1NsX0WSi0dvraXOn+8TaXmOr68NCaEKLb1QxewRc0LcV4OZRSdNdbfn3ZwN/vaqoRdCBYAzDEQRZMzMa5AP0cBohgojajj92Ih+FNufssU0Ne5TnKhiRtFdRQ10Mwc/BBaX4iHMTKwkHqJaZ5+QtKjMKuF0seo66FSkdUGu9Uyf60+TSmEVUNN1yn5ejLUm5S5N7vertHjgYg6fwNtiUiYW132N5VPIG9p4wtE6+H4n2WDpdcPMrChSbyJ/zMgtK1+Ud5Ha4uuwyUULcxYRE+bDTfobdHEDV/WcAeKqROgBhxTXTeAgCjhptRTxN/e+IxYy04YZqg092nG/1rDdt8clVPFYoHA0Plf0rjsJj5teaIyb4Wv9dkg6GcRqcFcYg+1y3SBlOLvoN9Ofg5OTy/VSubcd8MxjN45KtFK9uvm8qbORShZJS0TFheCS2H9C/dchgJ/KrVGMxgyhaELm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cqh3yOYBB/jjVs6BrtYi9rO+M9l+lkbHVDkigpQnUeRivjDAvcqP9xSSztwa?=
 =?us-ascii?Q?JJhikNcONr9b1JoSHwcAB01d6TxshHd1fudOAkxapgSPaTUh2w3fcmwgwsRT?=
 =?us-ascii?Q?jH2O6IFISG2Sx1S5GWMwCuWTBqyGCKhGUN43nj2NiH7TCEbXIO1b4/inXmQ1?=
 =?us-ascii?Q?5zWLtJgRuUkQvYNZ7KnI28Ulg1RhniGHqvwcOasJWbkz4WLXeiy6IrouioH0?=
 =?us-ascii?Q?gOWaVQjWa91CQVI7LIIH9n52HJGdTaGipWh7dLQpXwonU3yE4zIJjFsNTC/7?=
 =?us-ascii?Q?5Z1P88liN+FvWkPFZZ9EOpvU0Ou/SPbw3m2D97a7tPODduubNN5mcUAujX9l?=
 =?us-ascii?Q?sWdqsNMFGIOc1uUXIgw0NDW3zUiUYUqsmdCz4rQ6Byp8ky7ePmEBpt5M2mTl?=
 =?us-ascii?Q?m//NjLu4jBDs6zJcrsSrgrRnf4EM2NSRLBDoO3halzwTocRhFdJYtyDYz1wQ?=
 =?us-ascii?Q?7Cl2+T/rqQc6GVtPH/8SDz04A0IisifO9zQ0hy2MaR2xxrHZS+WdKXcxGH73?=
 =?us-ascii?Q?t5T+p3lyVNwNP9JGS30ei8O4lVJ9ehs4w64mIa0TYCwqBcOKA8vyiS30fAAk?=
 =?us-ascii?Q?zhUg8eMpfH3yv5OvnHBCCOnnXG0YCQnC5vFipKUFbOiltlg2sjLnlNOwh94m?=
 =?us-ascii?Q?gK8Z8Ahkr96+sA9KVObs4Df7UJNakkSW9SudYXCnON2W2orGgTtVqLcw3WXN?=
 =?us-ascii?Q?I41rpzkX2je1wk0reoxXEFPX3Uc01jbhd8HBfb1mkZ/+frYadIvBtWstrDSa?=
 =?us-ascii?Q?v8g6cwbZizNOVGsD2u+pyQauWpENoSs+aKomXheJKeGsORIadR4tuglibjD1?=
 =?us-ascii?Q?DYoyFwGP7ELGIwf3LzpZCc/fXmadEDR3U1i1lqHL3pypTzqRKa3+l7jqI5ME?=
 =?us-ascii?Q?tUDRuCwoWiDnGuPBL5y9S6+GLrzqRsel12nH78nWT+8/G8rNwwwW2M2dPZSF?=
 =?us-ascii?Q?VjbA2iwyDpHmAFlxcajBx29uV2veR4JPn3Xd/0NzhnubrWgNpXCwqB6XbVMO?=
 =?us-ascii?Q?EZebys7SlCdwBxAlh/HAmPmlhc83g/WTCMhRDSXCWV9bJN07E/xHGcMvsx5+?=
 =?us-ascii?Q?NHKi8Ajm6rrMpm6k4a1TiK4iZIIG4NAf8GySas3oEJQUiMSa4rbrDbp7Vrd8?=
 =?us-ascii?Q?4FNrhA9ytcu9Tzo+ingZlHdf1Qq++jzbmbBw7DJ63+3J8a7KJebKZkIeGTeU?=
 =?us-ascii?Q?dzbaGzXU68gnruIsV4VynwNHPz0P1ypSjRJP5wyfSUPzfsDsRnzDQjN+Pe5W?=
 =?us-ascii?Q?bFnGFNP/7O1aepgG9UpUnNHUbL+KtJdwId6W60k2DVLl3JbBjhQ6qsf/kExf?=
 =?us-ascii?Q?jPaQkDoJPREsxZEZfaj1/s33NqEQR3ZQi8P89Fqbxi1PHYjSqg6hkIwPaz2q?=
 =?us-ascii?Q?cXOfNXD4T0NXNRij7Y9RINEa09zJi8R6XeAGzAvDWacjzuOIOyylcBEclkuc?=
 =?us-ascii?Q?fQWAgE4gT4mJIHzIxNIPAYmocPemleZbsG886j/7BNYWRF+KUV3iFLSST1Yz?=
 =?us-ascii?Q?CpveTE/hk5kysUKjhFJ3YQBnHWHaGJO46YCXU1twgrVR3sL6g00FNOy5pIch?=
 =?us-ascii?Q?ufePRrOCW6BK1FTwflFYhlioBcOrSt34fBvOmz/W?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022a60e2-c4c2-40ce-eeca-08dbe4fbf5e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:25:01.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0JM1gsTiWuzS7Rnhyo91TAOusuRNgnFYaOUnjiSXZQndmgW6SWesBFHiEQMHjmvnCDnxv7yzW+K6IMBjuF7RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

The variables 'capture' and 'checksum' are defined in multiple scripts.
So this patch moves them into mptcp_lib.sh as public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a2511a37d9ce..59482d5476c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,7 +9,6 @@ optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
 ksft_skip=4
-capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ipv6=true
@@ -21,7 +20,6 @@ sndbuf=0
 rcvbuf=0
 options_log=true
 do_tcp=0
-checksum=false
 filesize=0
 connect_per_transfer=1
 PORT=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 63f89bc9b7aa..d36639e48027 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,8 +22,6 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=false
-checksum=false
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1d7f69d36b4e..b5f3d5e0f118 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -23,6 +23,9 @@ readonly AF_INET6=10
 TEST_NAME=""
 TEST_COUNT=0
 
+capture=false
+checksum=false
+
 MPTCP_LIB_SUBTESTS=()
 
 sin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index de897b226d40..67643ffc5c08 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-- 
2.35.3

