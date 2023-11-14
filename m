Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E618C34
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hutnpX4A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtBEhnAeM0P0mPUo9ri2vlKGQwBQWohHlfeRw9kgVv7sH4iFdDCEOXlMuTO5ua4I2KwdZ42ex9KhsvoN9vivNzcFJNYCmTYMbXY5asCYwRrukjApo9gDjin5VVDO17/QGLh+F1WKKQQS2dEhIwvuYR880NBSk3KJ3Invq6PoAQXfnz00Z2wbOV0otPecojMbGJibEP67CY4BHao0GcjgG7Cn30LMESt6DgIVkiT2cXbpuhT/DIpz0wos2sLmt+7yGnUuF4djy1Ef5xT53lO7ht5ZJHl7VnI55ZCpt1QEVdk5URFS6WF3ZaJC2d92+huAoHsUUjOracVC7Aakd30iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiPIx91PM4eFoIGvm9qwP2zqSLV31oIvgLoyNyBYWug=;
 b=B9FdYkJBK2LZe1cG1/ZWX7DZgjoL5FGTVogpFbby9RViFQ+a2oD5N4+0nMWh8DTQo8OfzBTPQo2bTDPZ+qjwBIUy9s0L4e2EJGwZf0N2gUT7J9ADeoAiMMyoelkhjJgheDZANmka+0yRye6S8idMa2+E5LfHsPgck2OKIbU87nHfTVFgcZfnyqhw7kG+nXpECSv2Mi4jq2KK+kRLP+09xr5h3SmhvRQlZACMSFWv8pqBT6Ossij8L6rKCjSDm3FYAD2vlhw5n1Vqb/XN/IhRlBh0NfrMzi4zX6pLubscJ8cTqT3+HCPIPg6J454jKpa+wR56LRMq7eXmqJEOCitO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiPIx91PM4eFoIGvm9qwP2zqSLV31oIvgLoyNyBYWug=;
 b=hutnpX4Alt9vwAwpn5xNSv5jXyWLKEU69TFV8tX3c06WtX/qc/9xQR9l7YQ//ioKDOMAQKF9XIjW26wH5aycWuJNoFXCaJSH+4pXh+wL8kjCVZxO5Vq/Ayxx9IoW3+MpzIzqQQz3qcc7fYzvpHIUVbFcy7kzFIOSLsQ/EuHWbMh7/QN5Dhoo2q0Tq7J+m8Sv1tgcVa4HI4gt80VgPd8v2fFGJ7Q/qINzt2zKSz1/KaDnWlNV4beVa1U3FLPBEkhvpQMLs1j6ktQrk50XnGilGFkk04y6ufAPJ8YBm4hnom1f1AKAh82ixx9L/GmlSYcob5MA2a5C0tDO1KvkLQl9GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 22/33] selftests: mptcp: sockopt: print out test counter
Date: Tue, 14 Nov 2023 18:21:52 +0800
Message-Id: <9d1fa8c8b87a8f7103815463a218bccaa9aaf366.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: e62f81d3-2168-44c4-1337-08dbe4fbd86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	112LQTXfiTfamKx0Psgi8nrsp9NofXvc7Qatb3Ce5JEvTnsE19tQJvwbbol90UdzML4Y/quyF4+k3S2xtgBLJZCi/X1UL+xkYQav/AjYoz6sodVS5YUtJR8GPXRQOmdlo7Lp4V8jKK5V8vdgc/iEClNFadaraR5s7gsK8gBM3Y9CLpN+kgvTn5ZSsqrGv6WFiglL72ryAghCFQ4F2JJ3p6O8lr8h3M1B6/YGPbR0tlqFgH4wFFnMMR3j+YfJ1Qn8bRdMVRJEHPfr5Wvx59mRduk9a+0PMD08QkbTlf7XtFs6CzuGpOpkJt1cqRzehODJDuP767XZtV8n7fBoiXNc2+x+ktWvpo0BL2KlSuZtTETvLXyKEzDGkiWM46UK/MosUVT9ETXN9goUGGPqaVYSbaq0in81FtfgBncrU0iKGQJ25vm/3TkL8jj8ELMhEUfoMniBeLtpXk5fBEo/ZO/QrJQo19hMXISzftLQS3Z5QJCaLo3Udm9HI6fUYywupeche4CnNzTtzHJIaURJteiKPyQXZQfxRoHeutFuisTXQo9XQLiQZrrxWg1V2I2v/FZn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjMztTcKSsSKPgr8zpreeDdJVxJo7hVx+NE46Ioq6G4hC94yWtyGfTz6iyUq?=
 =?us-ascii?Q?gBk+ZQDs1YOi7I404B9W1i0KyulfH+ila8zPHiJHOLIKcaphsOoDgjuogRZr?=
 =?us-ascii?Q?tA+K/dS5U5wMwgk9sgvavmKbtZMqjlKG5pXUnp3bHlaXq4393G6duGhmDXW7?=
 =?us-ascii?Q?dKrbydCOPDGGTe6ir28vOlmTDtvZ3t9wdhFjSnfZlWX/dQ5zWEN5NG3ZyKKw?=
 =?us-ascii?Q?9oJCqBIbdcAABFyPGqTtlaSII8zqh3GIF4vylAHQ2Oja7bSyeZatj2nwrXNB?=
 =?us-ascii?Q?mA7tv1HWg73WtYQREpizMP9/RNdAYk2GtXHmgq4sLRJ/Sh1asSJd6Ash0tnF?=
 =?us-ascii?Q?4AWdavCyE2ECaQNcDtVtgzp5Yf4cYo4ZJpOJOZ3iMpwl9PuVypGic0KlRuYg?=
 =?us-ascii?Q?U/pOmfmhH+nBZixmgEEA7WnP1ru/6nNqNq6iMw7JtSPkdp3n6soOy3emJ60P?=
 =?us-ascii?Q?Qq/hIB45gAZaUZ3oChgpU2euoyS2LEdaw94AoBFuMrYPmcKugMdCGRGSII4t?=
 =?us-ascii?Q?oL2dL/jE2uBQ7Oi3QJduNeVDO1HbofsuvHXNeF2d8H+zqjJUm8nJ+MEe+OQR?=
 =?us-ascii?Q?etVOm6FoAMmNT9hnEYwHU0fPoDiKe9c/17TzsiJ41TmtHKuWRKPDLixnXD4u?=
 =?us-ascii?Q?cWesCIk8TsBiTzNkar/OaVj+QElKgUp1Rd7FnFjyI/is1Ih+uhJEbnlCEO8Y?=
 =?us-ascii?Q?EVMk/rAfaZKJrN8qciDNNIifHQKtYilJAeI0mrukx1Ga3ZZojuWg7MF6Ut7L?=
 =?us-ascii?Q?nrs0LLA1TR8qSPfDtMopcgReWHQ7TsfB7AFk2T0KS+Ih4xmEzPLvt22RUECM?=
 =?us-ascii?Q?BntL6X3x7l1hCuFzIux3htmpPinx+Vx6cRdCbvsbfxEGmruD0qdPE8BYmmXi?=
 =?us-ascii?Q?982v46M/J49hT4rGFi5hQbkc6n8Ilfw9mAMqBwoFlCReONSMPeoy7EhCsHgz?=
 =?us-ascii?Q?im6+kT2Ho/V7EJxpLTpfRAeyIOfS5+t4/Qj41QcyT9m1WnNM9Vu8XtaHzO/Z?=
 =?us-ascii?Q?KeyiLAvYpiOz0W5d9fWU/rCWA+vMEREWZmlHwv5zpwZMAGES1rpcyisLY6lQ?=
 =?us-ascii?Q?XbHJog+TVvy0SCO3gB8p52UiuLbK+BHp4aHTTQ+gjQ7pOnNial7BRXfhZaRl?=
 =?us-ascii?Q?+pF/6gWLGFkhWLsizGlnl/efXcr2NhX+jcBIQ/qIwnZ+gLoKdWtxWUS8p0kx?=
 =?us-ascii?Q?Ne7bD1I/o1mxSwLo8+OAHCpdzgqTRQP4flzTSf1HfFL1u1uZK0SBuiRBR6uK?=
 =?us-ascii?Q?MQwz4IIbAIHgr/pt1+q2YmFmvtI9vePRA8P+63+M9XVmsTebc1bxW29I55yY?=
 =?us-ascii?Q?Up6tD7g5sPsRfJsZhrAJz5i5UAlj28GGjkEWCZmlA808GKjPr3HkF2NtU2LA?=
 =?us-ascii?Q?N7Vj8xtlWrQdOfmW2SkWwu7nYDltd1ELoEVJCzLwYoBmTXWr5cSc8s1y+TB+?=
 =?us-ascii?Q?wSYF4HnR/xUmZs9j+SU/wfOkNq05Ir047NLoh5dXexIWDF+s6iM/uH6rKAKi?=
 =?us-ascii?Q?1bZbyQcdOhpVQkSXRG/jz/48wunv7UAP74+mhID21nKxtQWFdssfBicN/mtZ?=
 =?us-ascii?Q?d4uxg+YV+HOpplsmut8E9CoCHrZZhLnaC0LNfC7XQndHx2aCndQosnfwYPDN?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62f81d3-2168-44c4-1337-08dbe4fbd86a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:12.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YxUoQr6UWb4Y3lBU2mQuvYbnTu0HF3Yj1VwZeqFIdwQxkp9kBflE2X5aF+25nztRbSO9b5BbDUGjPV4c4+6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

This patch prints out TEST_COUNT for every tests in script
mptcp_sockopt.sh.

The output looks like:

 01 transfer ipv4                                                [ OK ]
 02 mark ipv4                                                    [ OK ]
 03 transfer ipv6                                                [ OK ]
 04 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 05 sockopt v4                                                   [ OK ]
 06 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 07 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 08 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 09 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 10 TCP_INQ: -6 -r tcp                                           [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index d03f9f9daa39..2aff01813058 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -173,7 +173,8 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	printf "%-25s %35s" "transfer ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -189,7 +190,8 @@ do_transfer()
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	printf "%-25s %35s" "mark ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -236,7 +238,8 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v4" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
@@ -249,7 +252,8 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v6" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
@@ -279,7 +283,8 @@ run_tests()
 
 do_tcpinq_test()
 {
-	printf "%-25s %35s" "TCP_INQ: $*" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
-- 
2.35.3

