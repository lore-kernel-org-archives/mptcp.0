Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B451035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HzHhB67n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSav+UxI7jt7BF+ogD7Ng9sR/lxC29rxjpoRjCyaEdIYwGozjVUd2oS/5S3P6x7jhLPcf7RcZPlbJoIoHx8WbPfuvsvWSDq3qr6143XsHlunQUXfKdKnd0BMFSfzNz+wEWjiyMv+U+SGDF7jHLA3MdRPio5StsPwMEYBv3kB1zaH5YE33uhZWWzdH8WRwVH30Cq4YXpFiJ5vQaDwP1bLkSx/eCUIxqMScmnOycKJfcpj1VsRmfuBYnvkX1J0MHYtQONGPim2eelc/DYtRk35w50j2TBAEDSWc25tQxDctNd5qZOK38jgIJGp/7ZkDN6iUAe4M2zcJCN0fzPiEhJ4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQRS5uEfzetn0fPm8Jcjcj+ipA7eCIm5/BJTKHB1sok=;
 b=GnUR8VJPBg8W1vbVQwI2ulFaq2sKMO5KNHvwxGYxW1zfh4S75Cw4Gzm2fGGGvhIUnKtRsgtAh0YdjWD29GCfhvY8bTmtY3BVfc8bhYAizfkaqtVCCxbGlqUu653rTa9nK9r/sfHRh4KCp1Qi5peLiR+gy8mXVxRO1nUrAW5UrdrmWGsbsR4fLS9xU/kVBuCFI11bES0TyYoj7/Z3IJXApZwpluIFL7W4O+JxMlGS+jrovgMrloHSGp1bfud7iN2fCb0H7L7a1bxUYbN+QTeiIagjxfXEnnaPaVgfCB3kEHvo8wlVX3ZikocgGgFAjqywjpvK3ttwQlm5hnVi04yeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQRS5uEfzetn0fPm8Jcjcj+ipA7eCIm5/BJTKHB1sok=;
 b=HzHhB67nPYMfQ+UkMGu48eDQinWQQx7ARXyZSzB9/q3tEPPxPYPGmKX2eDBsUKNXbg8ZN2ZbTpUlvjk/oC3tV4ax/9k5XiE2/qzOLf0/kC3FNmXoTJREtyDm+TMXCIzdn8GPwyszsXqWB2i1ti7n3oiBiYooSgQHpxaSHz2MvE5HiPoW/Z+m06cCzQHolz08JPUkkJhoZPGW51dhul2ICivjOtUE7OlFdZnIhx9ZQm/r9VViOHOwQwNG23+N93As7eZCahZ+FDy8U+TIgL/SltqPaglRFRRRT27UtwlYDJfxztIe7MCV/MqV7cFq2kpUeCDX4s8FUTRs82VqfHm0QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:32:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:32:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 14/33] selftests: mptcp: sockopt: print every test result
Date: Wed, 22 Nov 2023 19:31:02 +0800
Message-Id: <969ecf72809657fea20fc896975856920e7dc333.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: e56d05e0-818e-480c-9429-08dbeb4ec629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GxBVFT5DWsNX43/H0oYL3xghzQ/o9qzJn1MgRQlyIQ51dLpoqMz6iADptsku4c2gJXIIcoRSI2VnrdZQFZKtz4A5+TPY0zHFL/aT8Ik3pXzd+zHYzLUkTTj2c/Zy+DOV4mOEOgNnjCp3ZpWlDNSiQwXoDzPMFumJxRcUO4zMD67C7qAxVPydeKwv0uZCPtvqIpROM/7KkeWssL08NFCcDB0Db2ca08nvvBaHIMViYTIEA9NMthCmuPorrR3W9z4qIQDBocL6QhFVMPTBrv1v4FjIltdhTUqY1t1fEMCr5TiE8qT3/Mx8JkUzEwISdwJ6BLWXELp+ud6L9xaxu3QD1n+XWUAHSzjJqYR2ze09AFVjKF18PJtGDeEL5UXGlEFIcrmE78BjgKK6lRBMzF9iVXN52QCS1oFtiu1fS/Vp3Ir4oCXscJrdbTp8JNaL/BkwPwcqbl6F9NGs5clmnx0zEJGfD1NTyvTSkJPfDYBlXehmKtuRKE+U/qZce9stmw9YupUDSwjqHUiawvJBAHwzW/ZtZ/04vjsgmfFSTtG1lU6dIHpP32du5C3yc4JgXE2HhBAzUEqoqetTpGJTLFuU4rBkMJGRchhHYsmixSbp6/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKO0IZUZo3+90CsaDzkSLZEGczIq7dkvMqg6Oc18UWGUW4NMiRCak5j0c+Bm?=
 =?us-ascii?Q?cBggMkDaGJiZ1NIEDUCP1K2lTgjba1k7ADAaBvxkebwAEIs6n5bY/zc9JOMR?=
 =?us-ascii?Q?bFUv70ZV578jJckd26I7fRtmWQb3wXHjGs6m4kHphyLdjrzocBrU5yHWJpph?=
 =?us-ascii?Q?saEaz0K1/mVKQDEvgmkquPZYNFN1CpHT+HJ2gMmaIZYH4r2j3wLOinquP6ki?=
 =?us-ascii?Q?ZrvnwKtHx4Wg/SqYzccu348hqCOUZv/5h8HO8ZFXLYTJccrQMLUsU4gGb9TH?=
 =?us-ascii?Q?tcRVJi0n8BaWpuF3VZVPkitBxhrkBLYzPY+y0OGP9HtNBJRlc7wZaj4uz4VB?=
 =?us-ascii?Q?TbQLs6uQs4YuagJ3RF+aDRMoT22MFnvs6n0LgSKchHsAUXPK6fOA80VxUWPs?=
 =?us-ascii?Q?5IR5d/ODZM4KsQJtPoL7WHdprBJMQ2sF2SVRsWl2Z86hHxGvN+sYhSY7ST5r?=
 =?us-ascii?Q?ULdpRbZI1YvQVU0xJxmP+am8wYdsHFx/YnsN2+lsevqtFclDqGWcxVSCj3wX?=
 =?us-ascii?Q?eK7QUi8LE/46PXUag6Ix77e6ggYm10bjXTWI/5prHXdtk9DowymbtQiGX9Gy?=
 =?us-ascii?Q?tDY6FqyVBo+f0/lKfuBwuC8iDC2I/bVeZ5f7I1goGcPEZ79o+/hf0gPG4dcc?=
 =?us-ascii?Q?L4ga7ThvRWcL/z8NTbUmQxINhfQuk6sZ59GpFXNj42I+hV9vLbLGsJN7P0RW?=
 =?us-ascii?Q?GuQHmdLFGSFeZrQM9Kk0v8rJu0pdUbC7aZzrLjA9u/wiNCoei62nP1HJYZ2H?=
 =?us-ascii?Q?3wZNRmH/bF7Xo7XhWaejX3KZZc72nhhUw3CsMYuEIlco7YNcTCIWhA3Es9Np?=
 =?us-ascii?Q?SMpaxFalplEJIxvb7ZqTe0v2EGTwvapPr4LmXeBLqJBh0WVuaU5294rvkh9F?=
 =?us-ascii?Q?sAr4MKaMIFSbELMdmJ0nnx2JevkkxzFgsJHjE60UARSi6x/2xqybiq9xF+Io?=
 =?us-ascii?Q?j0oNurO+7mBcYMOCKIuCJoelQ74FtdjgCycfhrx09+wcbsUrh2JZNazhIdGQ?=
 =?us-ascii?Q?9X6uE84cTyfBWhuXF8Hv3q0bVBdfcCTerzzG+Vo39W+NyaWVNdUYKIgRUTAk?=
 =?us-ascii?Q?j33cMFiTXP0ETGGLECHPDl6qy2ZtUcLDTIFk9tLwF+zvwLmmb1r8JJDjkPew?=
 =?us-ascii?Q?izqfgwklQ1Mqnn/umC6UJN39wT0s4hZ8lR2BeZP47ZC+Z9crTNkWPOxTqALc?=
 =?us-ascii?Q?5MUybMcDGZf0Ip9+KHKnhptxF0SiPrD4/ZOd/Zyc0I7gJtRrVfoMmCeRHAPe?=
 =?us-ascii?Q?qT1lR6DgZWKLy1Ie87Xy0KooNe92mWvNAs/qMpPQEkKnfQu9EuesM/WzopXK?=
 =?us-ascii?Q?cO4S8lSbmkzqrquKJizBqGUt7bbyMXqYwZpdZvuJ0Ney4coh8n4rDaH3M1bl?=
 =?us-ascii?Q?LrSh9cApT4RpA5r1BAl9h0VQGjWHe/jMwmirxbJBPV0KRvUP1oiBzdXPB3ez?=
 =?us-ascii?Q?uclsqGWaoJ87pxkp5flxHTKHu/ruM0w5lIGoTHaoi2XGVAsWmSRTO77s1ETF?=
 =?us-ascii?Q?wgTsQrGfGPWtj7SSqcyHbw0iEdOpjz14rlEO3XWVzg5BJFMjfkbIQt6An72/?=
 =?us-ascii?Q?cehzeeM8+gwIjSH9t+WJ+VEd5DEZ7Sf7KGWASTsUxcHWUmASW1fXZg8rNksp?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56d05e0-818e-480c-9429-08dbeb4ec629
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:32:57.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AXYLqc0iTgVoXEDEjIHNCIPqkYmDekH18AlX4+KMXYp+RnAhkIXfLHCgnJIicuy7HAfOsEOBiOnIG6BXcLvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

Only total test results are printed out in mptcp_sockopt.sh:

 PASS: all packets had packet mark set
 PASS: SOL_MPTCP getsockopt has expected information
 PASS: TCP_INQ cmsg/ioctl -t tcp
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 PASS: TCP_INQ cmsg/ioctl -r tcp
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp

This patch prints more info for every test result in each test
group:

 transfer ipv4                                                [ OK ]
 mark ipv4                                                    [ OK ]
 transfer ipv6                                                [ OK ]
 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 sockopt v4                                                   [ OK ]
 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 TCP_INQ: -6 -r tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp
 TCP_INQ: -r tcp -t tcp                                       [ OK ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff49ee9b9cc2..f6b9660122ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -173,6 +173,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	printf "%-25s %35s" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -181,12 +182,15 @@ do_transfer()
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 
+		mptcp_lib_print_err "[ FAIL ]"
 		mptcp_lib_result_fail "transfer ${ip}"
 
 		ret=1
 		return 1
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
+	printf "%-25s %35s" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -202,8 +206,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		mptcp_lib_print_ok "[ OK ]"
 		return 0
 	fi
+	mptcp_lib_print_err "[ FAIL ]"
 
 	return 1
 }
@@ -232,23 +238,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -271,6 +281,7 @@ run_tests()
 
 do_tcpinq_test()
 {
+	printf "%-25s %35s" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -279,6 +290,7 @@ do_tcpinq_test()
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
 	echo "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
-- 
2.35.3

