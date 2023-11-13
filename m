Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B08475
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JQFsDKGl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKz4sCAgSHZ4LFjN8hAN5nT3Y2cpC2O+l9ChusQ2PttNP3jMETKH87c4CQpos3vfFw9AkZipt2xY1tsiQxmC8CZHf+wS5qIoQoQEisUr/6IyzX+zfavTPX26ciaS4xsQCORMEGSPOf8ksDIPK0lkm3peiUiSZVsY+G5xV+jF4pZ9DwgBw6TyWViw+7+oDFsjVqshZXsYiyZOdXwTFded9Wy4NHqamPBW2iSc5Aq6C8UEnlG5xU+Xdt2G6bB5JlsOp/5edMlixNV2i3Hy0aDjgVRZ6EC9MGk2MT+srR26/+QMT1i9AFMBZHFw87OLlcffI5zLd5+cldI10Tx42DSQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2Y7zwlH2h5JVPDMz6IN8NLbKTVfyt6ODCuKBCrxgrg=;
 b=di1S5/JROOfhMuCCTdBuni/xapv9irCNNhonJDZoWpRPJxG6bzxv0S7Hv5cCdELqLjMh0ry0tBrwBlXPEU8UGxnQ8QPKuS/UPqNNdk2As7Atow3Z1v+Dq9lcY+vM8AYVsW+96Rgv27AhdJBczspjB/BMydbTpCHQa3dIxzQlZw0ZvBPH2YFDWxt4jv/J78eg70Lqnobu5PEB2lkjI0ttmOUBsQQJxMjozo18k1uBxcwjCvmYuka5XLfHqA2yjoeArrmKETjZcI582aqx30E/iw7YrwM/z6mjWHLCYHqD8bQIQnz1L5FHk6TPyMOGNJqxBS5SOQGX37W9dXhDxH2Blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2Y7zwlH2h5JVPDMz6IN8NLbKTVfyt6ODCuKBCrxgrg=;
 b=JQFsDKGlQ4B+Vq88E5R5ZEfKLK8jMezxd8IWPtSGHWt5BmoC/jdrsYDBfpxWlG50o/WAYp2Kw+n+re0fp5LKhxHqy8wX9Sx46duWFB18e3N2Iys1Z8wbIYj3/5Yzi5/hyl/3OnmJ/mpuE80CzfppXp8zOVtWqDjQfp0DZe0avBcVcY6Hte+UckSrkgXuqmdltKvjZmcjLdjk8P4vLMeLHQ9hwsd8foWY1D3KmB1dzQKTnKuIcQ0NK7lE/B/j1LCM9o89C1IjvaPGm8NVn9d/QzGddv0+CYC9l66ORiIj4Sw2dQcMkmak6vZ8NW4hwQG39ERdVGygb8PtMALJJ6GLug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 09/22] selftests: mptcp: pm_netlink: print colored output
Date: Mon, 13 Nov 2023 10:48:53 +0800
Message-Id: <570e1ea39fd5a253bfb221561b3f57957321155b.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: b6964ed5-6eab-429f-d589-08dbe3f33528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jx5iV/EoUgdEztRsJwwQftaeUI/vqfYgD0RGzgBnyr9dcr0hXBEjhCQNaigHOlNhK00lxVbog5gDBcLG++wm32hTizMAhnmTtxNJ/7dNazDYbAOPkz2Vj7UKw0gdoiyR8//9oJh8lUikwpLCd1HBNUHVreZt4cLNn5zWBEt1RFtCTDZusIkVBVVQB5SOurQgF9dLIyqTHAVp6lGOc2MdhFbard8CEctmop1p/UHuJ1r5eTXZ91cq69g5LNdhAf5dN8T5Io+A/wXjDaCG0aa9BLUlLTWaZBWTAK8sOgrWobvGBk1gjgmE491ynI25VUB3yTOneVoT2bx9T/oOBeCCqefHMXxjTUBgEh39ncv2oAWthPfh9DlNx7CHjLQ/hx/k/f+TLDNMulBY0VIEYDSClbkT22uO5C5nnqRvrdSQDaHG48l4sWZAeXbHwk6gt4wUXvqw9Hy6fB9b6A6zdLcyU39QN+xTCZUbBSMOwm3cUHtnzW0NxIpNEJESWtzZ8TaCqcgRj0P7DWUQWRPkaVqMsU+mrKtLV7ntxCbRUWQeIFPZ2/maJSKR6vFBM7CxFmyJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66dsZtuuigDm5RH0vZ+5ypZWLxqbSMA0z+cxYPvBX5LDKXiEuLwsF/wbhjlh?=
 =?us-ascii?Q?vxz2Ml/VUYvkMhZu5gk5PjRpJz2TvsTixGKS1TwBFYM370Q0+WqmWLsMyZ2f?=
 =?us-ascii?Q?BQG4VwNzJ9U7X6yKO6+CmV7rdzLLeaxP/URFpLUFjexDR9EtE6KRRd2sFN75?=
 =?us-ascii?Q?C+1EHGi8zQQ+oUa8J7P12F+2H8qUTi1unOxd1UVcUbYdwN2J0VMZX8DRPId1?=
 =?us-ascii?Q?zAqopzm2SSay5H7XSiMjdtCz4N8uewyssJ14L170seXxX1R66Z/tfjcmwg/L?=
 =?us-ascii?Q?vbp1fHDPHKr3IREfeFMijR2KGizK5QAe1oAVYdH3kLfZpqW0Sr5B/rbDyUKp?=
 =?us-ascii?Q?KK0hr084j0vpANS5dx9Qv9NNvNZazOS+YFe6Cat2uVvJYryYA2p9jZX6oK+2?=
 =?us-ascii?Q?71ChAY+iff3ME18JJ4wfIfXommyrc0QsivzzC1Bko/R5zaU+lGbRwRjLnx91?=
 =?us-ascii?Q?KTqoKgxZO3oNSKEB4zj4Q/Or6ayoOamndFtsa8t5hs9WXlFmOWiLTO8QLar8?=
 =?us-ascii?Q?7qmxJiRwYcj6EN7lHZsjA89/Lr0SNvh4RZJDK4GlnCZs/w6xCPAU/Cp12ZOd?=
 =?us-ascii?Q?jqHbQgz+FTtpMTPOyvgil9Emp/kW+saMdZIQ6ruCDnFJN13np2AxPEiqZ1F4?=
 =?us-ascii?Q?MArbj5BOXtmSbykNFomnNpy7//wIW+zm6wG8oNP4tLP7+3K8HDXMjo3F9Osa?=
 =?us-ascii?Q?a4muZuxgjpgJAv94WjB4CQ79/EzoPd27EtQ6H476OGwWV4EMTUCCsdJ92/qu?=
 =?us-ascii?Q?qgL36+MhoeSf3Wskw9M+oAhfNgvEFUMsxbNhNgRW9gPjiDI1yvJx8UGa13za?=
 =?us-ascii?Q?pZbQj5ZZkdJZasy7NdhEQZ6S7MWEdGRI8tP39haYR1l1Xmg6oFKwra/QdjKb?=
 =?us-ascii?Q?hbwmxBdlooZMlQIoukF0AzSvoiV9nZxmJpyluMTCx/2atfloXuPiuY9z0EMD?=
 =?us-ascii?Q?x6o0uNuQ6QHEkbRfJ/c1M+UbCDzajLmrIayxMBcFhXEXJKhJDjUBj9C8d3oN?=
 =?us-ascii?Q?KNKujUYWVmCUxonKs63QG+31IShyPwjY9A8XETTVj2DxWTMu9/xv8E4hKrAX?=
 =?us-ascii?Q?Yexrd1KSitbGd5fRg7aVSCPd4ZW7YEZdTz3BWJ9eZY5/1R9CadnZysAB7kJo?=
 =?us-ascii?Q?Y8wgiO87SLHwhB+IhHwoe5OVMlhUm75P94V6/MulxEiGo3s6ZAAXV3RJSIOZ?=
 =?us-ascii?Q?6usi1uB8urYrfcpo3iTuEbiPBIOdre/rRlQILDLVCdowcJih9ryMVe6RZBCb?=
 =?us-ascii?Q?RVU5oYHZudAnKI4LEecTxZ0V5Z4drzBVcgmW4H+d6lmA7fIey5faG3nVUhYa?=
 =?us-ascii?Q?LKFB1vJBV3lNJi1s/jIxE4heDo031iqqMwwFJZdsh1U40dAAG7r4S7kC6wOq?=
 =?us-ascii?Q?SuofDuLhzBYXTjpFQE6XzgF9Gs2Rgz+vzeXZt+CKzzqz1adBZdXGVONEvctt?=
 =?us-ascii?Q?rXNl6GXt2Jz/w97uS9olX/G4sO3j2d1A//mcQ58BhxKjeb1SLFh9q0mqVmgh?=
 =?us-ascii?Q?ADhLJEJAIo37bFow83wG8UA2GHnuuaU77evHxZc9CKyeazcOAf3n8KKT81UB?=
 =?us-ascii?Q?YJQLfbY+LnlTSGQLit3ck7C7NE4v7avoTPnhWJPF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6964ed5-6eab-429f-d589-08dbe3f33528
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:51.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAwgbfZmoOh8nK0uk/ueLThXwpgLehYBzhnW9YfMrbhkSXIb3csR8JaEZ6Qfu1elaAlWNiVusp3GTH3YxE/bMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

The helper check() will be moved into mptcp_lib.sh, and be used by two
scripts mptcp_join.sh and pm_netlink.sh. The former prints colored
output while the latter is not. It makes sense to unify them.

Use mptcp_lib_print_ok(), mptcp_lib_print_err, and mptcp_lib_echo_err
helpers in script pm_netlink.sh to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..b1155f4a8504 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -60,16 +60,15 @@ check()
 
 	printf "%-50s" "$msg"
 	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
 		cat $err
 		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
 		ret=1
 	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
 		mptcp_lib_result_fail "${msg} # different output"
 		ret=1
 	fi
-- 
2.35.3

