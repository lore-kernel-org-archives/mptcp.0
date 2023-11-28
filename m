Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6E5674E
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="spgLPWtm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXVjLqjxcJRLu86jCl2q1TopAoiJIeDAQBr+B+QOrxdGrChwP39o+V01/xLzBznwrny7eBhRHWSQoOa/rs62xjANybPm3JoUtK0SSIDJIERIQdtddJUOv9fCQvEuGM5oLcpjtdcO8NuavyJ9XUH8Pf5lfQ+vRF0WkEluEMyV6YXn5Qw/aYtKxFPyyjDCky9+TFxuykLomRA3Qi/4Rioh/O5vaqUXMD74GQK689TCf5UK3NbM2yHOZo95LU6TlFrHFAQMm9ZbmiH5c5lM5zVMMjl3tFOrCZn3RWWtO4evCcWHiKOlYFHjsO4T6/uy+VwikV5YVnqj3KSllj7t9PPfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VveZjxe3vGPdKEro5YHMRAiW3CWK3pSQKoMd3qOIkUQ=;
 b=TxlW9VMVYryxZ+tQOFzhjpYkOz5E1Xiv/gA6FsCTtzdnsEIHGhW8KkkvAw3eYbPnaigoCg2O0ekNs33/mEVci3sAhLxeUPJaV0cP8fNOJeAV1ucr7xrHWppHfAoVHP00rq8COAvtzaWoB0emqYK5bhmcgxysddJRqc0gV6j9610M0ZnwfmJO6593zC2m0G7ZANW3vH/+OlulFwZLA9R2zXB0lJZAuqHeGzMBg4I/GZaDGMULZ0eBu1zfg8k/9OXigm90kMQ/KQjI8d7WlZ33XT97ekEYhIBqhc4wwQ1SM/trO2gD6lsDTj85rqNsuvVje/j2xUepPhPeS9CcQOMFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VveZjxe3vGPdKEro5YHMRAiW3CWK3pSQKoMd3qOIkUQ=;
 b=spgLPWtmHGf5LVCmUVAABrksnpMuET1K+ConYIet09R4qZfoiSbDD2Ky4xiyI9VeZgfC9+5FgFOo/i4ZaTde3H3TtMGw9pVThKCuQFmN5laryEcaKKSyAHHszAqYSNlwKfJrNcqeXQM9isHk9Lb2pS5+GUMob0H9yWrdcb+JEWzKrTUyyhK+5ERxVN2C3ZvI0Csi8Xox21tV7mCnxYXU39aLzfTn6V+EID79MZtUCvT+eUjtog7hNJT4px4HHMcisVcKwlmpbdMGImOJOQCXGhrai8ok2QdQYn/ZTzVQ19WcZsRARK5cFfLasu44CB7AEyjFxp3ZcHViZ/kSTja+aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:25:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:25:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 30/32] selftests: mptcp: rm userspace addr with random order
Date: Tue, 28 Nov 2023 22:22:23 +0800
Message-Id: <3d66030ea94674d652210cf82fbd707015498d99.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d746129-622a-4f92-094c-08dbf01ddb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fAp8XQ1yA+jVh60hFkT0/jvLxNJIJV0aLslxQ9yW1vKkWdOKj8FLcxiDK3FTvt5W3xA+w6OGwdCUTSXYaq8RD1Ut0TDifp2YcnhAZGxhSFi+WMDhKmr7w+2mOYOU+2+WbLy4x8eRUdrkhojcNKJSQnBm3ytDtwlZTfD66QwyjEBlGgIP0+7iReaG/pS+ni7dX/p+9zCS2urxt1j9/4AF9OKxU2YFuRdwtTmlBd9ZLaIbArFSIHWIa/fSmIsaMm1qUPp7ntGhMWDoHKvNPK3r2InPxaO4Ibv3NGQ69zvtxSEGY5k1Ni6df5JZ+cPhKVmm20P9JHYRZ/R8WQTMlngbQs23Rg763m4dV+Qfoz5X6JlQKI4bHfOnYcR78NPPc1RV7VxmZoCY+8YRLscgSde/GdEFLuCp1Ot988dRv/FcRQS0NqAfcmswNzZcNbLS14SsZQLapfWkH33FKdTEtCTTxqdwVoLbsxWITNVpJVhTG5zwVr1hwYjBAuMzETW4XFh0HRqCOpgeCo5Q8nXcKlNAkpDBJTMEsE5tDk++fLLT8bBQWw30yxubPoN7oDccR5NN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?69b6tztmzoPAGLiAG7Lxfm3TI4h1y9W13xPPf94oFpECCx/0XQPT7RUoWit+?=
 =?us-ascii?Q?W0ZEiRq7Fj6vEKOnJEvZ/hZDzHs3Sk4wW51guq93P/TzDdLa5VzhR444Fls2?=
 =?us-ascii?Q?1N1WNKYq6XCvbosa4EJ+C4a9i4V/r2rJyw71pQNq4Hi5gOSgaRb6GWGHuzqS?=
 =?us-ascii?Q?qRDmWcvLMxWP6AKO3wmQCTKtQBSkhW8QFmvMYJqMTLOzd7k6RT3kX1Ty1b/+?=
 =?us-ascii?Q?iCTRyvTIKEnK7lXZe28+CdgbpEgb9u6o0cEgS9ySBgeHsyC57txhV0yc2TGc?=
 =?us-ascii?Q?SqeJWpiUSmYHawxo4RiQ0h1LZJuaGEhtRHPLjOvbq4bSoHZ4FWi/phF71jHm?=
 =?us-ascii?Q?zl1cOViX/b/r+aHmt3I4QolardnZDWI+Xx/97qdWH0qjtObcg0LPuOwDZT0C?=
 =?us-ascii?Q?tj6tna2W0MuIcpI+wgJOTYGE0dallv+Gv4himD0OR9KAJ4rSbsDsBp4dDwVS?=
 =?us-ascii?Q?DHm5desfUkIINj3w0xxBYTlP3xmmGQgMpjKZyzN4F2Ywo449u763AQ3aw9q9?=
 =?us-ascii?Q?0XWdcQCFWrSd35Sn2zAs/oD5t/AmuDM8Pxldqy843YePWa9LcTwWoHEY9yza?=
 =?us-ascii?Q?1oIJAjtnt0AtU+93GUPZHsY3ca9nidNzopHCLSL/iFVTj4X3PTfuovxqNDf1?=
 =?us-ascii?Q?bsrgrEmbxkRq11OGA0enLuigVhiZf/fSr5V58hkjaszzG8eU40CdLGoEPFIM?=
 =?us-ascii?Q?Qb5SyTLlLVx/9jHGcQ04gF5p5HaQfKNGg7HM2vd8VJkpLKpfZLkFMmUJWC1a?=
 =?us-ascii?Q?fsWPttlt8GDALi1/63jJQ6+EIur3UAPi8O73dJXz7Hog16eQNf11+/mdp/yQ?=
 =?us-ascii?Q?Kqp2qHHSog/AcaJ2GuguY9Sw62K03DoaRydBKGyU+S9XVk7I/BykF8rQ+rOR?=
 =?us-ascii?Q?BkAlwGOp5pHfnA3vHOpzDkHsvLJlfz9F/zi8YjvvdcM/YxgRp9G9ldY66f1f?=
 =?us-ascii?Q?tnzSW5VEWH0wMNwp9dhU4ivb9RgKgIJTsrv87Oj77x3dmkeDI3pJpLXAxO6K?=
 =?us-ascii?Q?A5XDeqXD9Gp1dlaArK2zgd4UsffMNKEuO5xUVEGsl01hn4j+51ac6VueAvAf?=
 =?us-ascii?Q?HsAzV2H2MuWnxa8XUComrubP+2pPNYr6Ii833uG/xOVkz1P7qZoSVT9fUI1x?=
 =?us-ascii?Q?BV7CiiZsULlCeZKWfUYgZ+tb1eB/7dqSMGKwUxN9RAVY0yeUbV0VCHdB6eF4?=
 =?us-ascii?Q?Lon0Lc3BPNYuEypXeG4zFXnp49xBCnPy/bn0Sicwz75s77CqLksXIrBOMEtC?=
 =?us-ascii?Q?y/tAyXpYKusb9zUBYek5JROyNgOee9MdZ1W3UUJCgDutACvfNqB2eT6tdEer?=
 =?us-ascii?Q?FaVtMnvLFTynjpSTteNXRFENZMsXCdM/a/oY64wJWU0P78vHKa7/LgcvuYDZ?=
 =?us-ascii?Q?fmUj2NUqFfHm8wz7RSojCs0SzKWslXre/5AbGBk1PQMklkGNoXdPMwtyLFnA?=
 =?us-ascii?Q?oPVWL3fkkOrcQZue2aKwvSzm9zsPMJZ7VotGyG2ka2ino1k056W2ehRAGSV4?=
 =?us-ascii?Q?o802oT/IZYNLgEB+VZFy0OzUs4wFLwU+oZGiSqC6KpRqK8OQzw4Fbj0Z42oA?=
 =?us-ascii?Q?AwaGm/QPds3Epdc8u1h6Znwjf02ubMmkM4LFpSfc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d746129-622a-4f92-094c-08dbf01ddb13
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:25:22.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFcY4e6mEPCnjAQh8KOeVfDRK1L8u9nUNhyNYT07mvAZbENmJ7MxFsQ9zN202Ck2IvZyHWtUMs86r6k3jkEw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a2baae49a451..ff8c852a9b45 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3411,8 +3411,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

