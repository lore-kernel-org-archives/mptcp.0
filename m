Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC7A2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/sQoHBeVaNLnjtYxSRwspbff96mvWzF0uHICygE+gUhAt1c9kMTeso8EqF5HJo2Hw929/SUMYHJ6kOzcXHlgJiqa1wwicHDmkaD/Mu4svQjsug3DYtIvB3CTI2dsxqEW56OG7VMYxg2ro0TD22tSbZDrXeSskWhvSc9Uiq57FVdiZDJcw09KR6JzIrub8qxfac1wY/j8M+1oJi55uvwnKoHyPlwb9yurmI6RoWn/ZA+/fn1o/AxsTCVMuLnZuCTEpaq43Dkdtei1EYpG01ECag0uV/ZUJkcG6Q4qLigTv95jj4odJIcV0vPHz7pDpeDPaOnTlRCDijrHIpy7tRJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RgUjrHCgiy2GuIoO8Wu03fhuha/n/5rKG+C+7numdw=;
 b=LPls1oJumfUj3hwI8RAVrkZ8CfQybUFBIhajHq7dwa/vOtGKKZ7KzX2NrUW0jvUoxWY4mo204msKEI+0M34SMykl8ssC/cvmQhNyzdsOUuCfqct5uUIhl1q/oGAs5u1XEMFfg7FPVWSngIaTpj0ktt3/2A0CaQ1iwL2zkzYq04Wz1E+MzTDBeWW+hZoWtswlVN9ttKyj7+XZQVx/gQH3ToajtDpAVORDTPg2LEYcxQqkk9bFoItMm2sUxvENfSEJ2Sx5h1YzcSiLCD4W89EOJN2nL9sDBpvlHtXRTcYvQu1eQcs8uvJJCfmoiEaTC/Wib09morrXWx4GcQj7ASpIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RgUjrHCgiy2GuIoO8Wu03fhuha/n/5rKG+C+7numdw=;
 b=SxcUR+ODcHCwtE/h6dGnxUbo34x//rri0Da4HZf0Btxbchl8GF2OxswxKzFk3P7gJWovT7yRwEX4PXDQ/WQ5oj/GokAA8u0egwaC9gLMDSlsw3PPhA76mxMhbbjNJgpzedCyynxA9C1uLkw0eAvRTZAF/eS89BmM0xRP09C21Fd8TAMDgfrxGqe85gFE+QN4M51Sm8vRxu7ZNHtDLIJguvRlZDcODVQwJLhbB64j020rqOlTsYAA4pngCSyQffSNCs5kLSQJLh2QH4ZOhCE9laI5rYd8ScQ5fZgl6bI66wWTBVeuHLFS/MZNdNsYgw55psPuHzaaCXXXvbsfQpamAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:21:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:21:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 11/12] selftests: mptcp: pass fastclose to sflags
Date: Thu,  4 May 2023 18:20:16 +0800
Message-Id: <85064a76bfc49db393a574178f20e9503a8500d4.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 886d0484-f440-41f1-e42a-08db4c8955c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xKGDoOUru2eAKtBCp3VIYJJB9VjaOwZTVTibXMgylwR1Wj8rQoSrjofuNrEF5OizOWrvTQGvV9U2VLbCiRbly8bKyZ7qr027ewFqZgobAGwSjcITw4hSb5v219uF75+qyJuTeUfW6aodY+AcDxPr0eGtZSx0/vg4bwhsUa4zX74Rz4qxTvbRPsdpdar6dGnQuG0aQkKwDw4qIeY9gFQ8XXnRxL3K/6Hg0z4NttbWnPLKO6kMBYJZ9B2vvazhRP4l1Yqt+e/mL53H/mc0xANCRzlZfzfnM/48lcofkmJvmabb/Tq5SOWiqUxi0HMM9LAFrBDYES4qx8PvGBjkiTznteFqBezfTPUsOKfEwrG3SESW2IA5NmN5MaAJInzjQlU1wopkYgiHcnaLHiL2cwEHeGN9qklQ9PRKXloZUudGrmfB/wuyDqPV27Q3EEp1Z8M7Itkk5mbYVRWVizB/g+8NFwvoapuw6wN3y++HEFtHrWeChQx1pI8lkZAWSj9jY38O3K+XYMZUEGmsFt0QcpDUp33/xIRA7uw90NB5XgHy1nmq0Vz4nMJVxu4tyAf7YrWm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(6666004)(38100700002)(478600001)(86362001)(107886003)(83380400001)(26005)(186003)(6506007)(6512007)(2616005)(36756003)(6486002)(5660300002)(41300700001)(8936002)(8676002)(44832011)(2906002)(66556008)(316002)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4omCk0OCmCkq5vR342TQCEszwH2HHswCtgekyfDLOdumJevGc6oJbIaAH7/N?=
 =?us-ascii?Q?WvQ6f/G8zlFSlaI8gn3kIiV4M1KUMVEWEGYAqYAUqwuk3UDDH2EH/HQevn4H?=
 =?us-ascii?Q?WYui4YJ9E8phHWGn+TWkarbkWdZWqLSSQSMoswjGdzykat+2BW4Hub7PYB0O?=
 =?us-ascii?Q?J4EgbucvEkxSW0D1QgUs0PmfYTreBKQP4xRXht6q0d2S8ah1H/sGK0+I9etj?=
 =?us-ascii?Q?KwWsjaXsyvKeulSxr3+GSd4j8QZbNYfM98nbvQqvaDP1vnYaudpwAMNmfJNu?=
 =?us-ascii?Q?KIyZuYYfSSc9icpD6H68XPg7OO/8ig1xLIBdb2UTg+ByZAZR8HysnaEVNXyV?=
 =?us-ascii?Q?27mVDV3Jy+TbQa/myBB43KpYhlDvXQrmhHz8ZpGs024YXanWj6s8kROYkViE?=
 =?us-ascii?Q?R1Y096OEgUFg3R0NXgzQ82BLCWAMe5/uHol34Zj9/pILfIbGS9Txe+SkWbNv?=
 =?us-ascii?Q?UT1DjbvEYrZfLqmHMtvVuJbF1QG31XinsIp4VuVmekAwohhRxWK5FtmzsEY+?=
 =?us-ascii?Q?duiNZFMcFc+iJP4JfejahfQAW6fnc3MPT54RuN0+7RWltmgfhnGyjx9RsjED?=
 =?us-ascii?Q?8579iGo6Rndm+uwF20OaMWxR/whjO9MBECJwRustoy+fcKX2nMeTUPOONf8A?=
 =?us-ascii?Q?kZjtMKpqt924kq+IcQOHV2ElYihfXPwri5sCNlrk46h9fF7L+INdRSsiptW8?=
 =?us-ascii?Q?dqhMB/MOiqkuG+fyiJL9g1IjuGbzSxUKGGHOJzfjuN8kZiW8RkRY7GoYjTkM?=
 =?us-ascii?Q?q71X5J2+OvCaVDfbAtJd0KzBGRKqxSG4Ivjm9DffPlRLHAyNsQfTQsMkwdb9?=
 =?us-ascii?Q?IOs0QgfhHRadLsdf98d5UrlVLeAvUwN09CrXU1z6ieNNvurDLdibzWZYpTmh?=
 =?us-ascii?Q?sw8SfIXM9+grIEZwaJwhkm8hlzoH1i7WAsE8Bt2cvfIr5SpPZPEONFfX8Psr?=
 =?us-ascii?Q?7E0dRMJXWvmU/lr/X6jV/INCqi09LYp7cfIMJAlRJgBZ5aZOt638WU08Ww3/?=
 =?us-ascii?Q?GKotsTCkQK6F/16f+K0NZ7gg5ndINix4BCunUmJDLI1ja89pyHxKtEP+OeYF?=
 =?us-ascii?Q?3o+sRVDWQrRhS+O02q1PaxPCU5TjGS6vdLEfYfcrT6UFcFUJ2m2IxNfbnCgm?=
 =?us-ascii?Q?V46Jgw9GZeOwtIHdmoE5Cufl7nUwa16wo0pdDsrE7kkYy8CkE48uuY7k2BZ2?=
 =?us-ascii?Q?7aj95w8QNTdYqomW+/OaqYeFQAHyFp1caQROHqra7GBcK7aZujCw199eOLMO?=
 =?us-ascii?Q?nVvpYR6tAmr4W7/VTswrHT57Obz09vRxjkCcD5AdcTRu2hNKMGzbU++6lbYS?=
 =?us-ascii?Q?8BlvodgfxKJ5O0EdNEiUG6DBTnexW//MIoJjhmmL7hJ+L7qTinDyX8GHt7Lh?=
 =?us-ascii?Q?wFg/KEBYw2IOXZnx72EkDrNpjLgPn9dDhnJU2z2k1aXMXvz6/AEGo49+4E1G?=
 =?us-ascii?Q?JIOr14/JiNULRibn8zBabz1QLmhOMIUr8A91aq7ZNkKf3NCRBATXjL/F7YW2?=
 =?us-ascii?Q?5rDqjM37Anh4vw9ToQatedZ0JzI1Y4uPSlhTpuiWCQPJS4XcEaFaFl3+vQtV?=
 =?us-ascii?Q?jceKoKo0kzBkDhEsVfoui27BfePYghWx8w2U10K4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886d0484-f440-41f1-e42a-08db4c8955c2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:21:33.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFG+QZovvXp1zvdR4AqfolJEExJjSkGzSLHevT+gzG85b6M1gj8e7p+mIE3WPzcxGya60tdKzR848LXXcJkFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345

Pass fastclose flag to the sflags argument instead of addr_nr_ns2.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52d569651485..0dcb0470b076 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -763,7 +763,7 @@ do_transfer()
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [[ "${sflags}" = "fastclose_"* ]]; then
 		if [ ${test_link_fail} -le 1 ]; then
 			echo "fastclose tests need test_link_fail argument"
 			fail_test
@@ -772,7 +772,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_link_fail}
-		local side=${addr_nr_ns2:10}
+		local side=${sflags:10}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_link_fail}"
@@ -785,8 +785,9 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		sflags=0
+	fi
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
@@ -2990,14 +2991,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset "fastclose test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset "fastclose server test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
-- 
2.35.3

