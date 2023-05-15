Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4910EA
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeyOfjerwWl8rqOae81HEELinAP9SHQnRAYUSArmWifmIWb8zhBJEE7SUjeOxe3ETVatIA60FUHY4VzGG7XAyNs2Sm1+2xEuwIQV4Cq971L41WMIpcfvDCj/+qtoX/LZUh416GFh87tb8E8g514+9q9a1tXASwKQBEJ6ZizHlGOULnwcV30KFx5mXwVWDAaxqeo3DDfqHV7h/L8dPDftOdTShLukdOvP0hID0E/BQZV5mmYW0n04yzyZAkphNUUKRc3CnNvlkJdR2DZtO0Kzw4RaOvzXIB8NV+fF9LFXNSdPXAOtTa0nI76DAaxwHqRgPzyDX+LFkWJcA75IoN4pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II9BZTr+iuXxN+ScTzUhxj2emNYy0u4QW5Wx7Al/rt4=;
 b=bd+2DIW/B/dj/2/0Pf9frt096jKKuCm3UyHlamohZEYAVNa3L+8iMgf1+daVDHferHFumwM3qS2RafRO+CySqrs4ijnPO7H+3fM2jaQJVz3Xk7tiWXs76QiXdTReCqDDSINYZy0zsNMZR86hHKhwQbGHDCFGxxrgYQ0PTKHCTSOupVDh+Vu+1O6NzxV8YyAynji7dXoCEhEsOB6buG3YSqDkeK2xMJSMe1XCI75YE187qux+KizAHnEXyy6NQBsxg7tlfEmyy0qeFCP8TOjAohgPXnUcanz1mACFmRgzeR7pKsinxVjXKLVThQf0R6JZ+Z+Bn3eN5xVxMET4oa/vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II9BZTr+iuXxN+ScTzUhxj2emNYy0u4QW5Wx7Al/rt4=;
 b=z99mvDWEyNvkONCTSQJWlSbOiQ0jv6ulFAwPIg8TnyZbb5DJQHQP5VKiTdjWbGz5NbgSb6UtG/XfDwZl7ZlU+TBoyu140fES5eah19nMKeYWzR8FfltboBkVUYIfPH6Tt0dnDULhXMZkzaqZwOu05mNEtzNEhZ4vOS05OMF6y2fAhgKjnaGMroL45vOrlO/biInpV6JuY2xIrYBKEIBlnhU9/AofW8PvTBaVkJdzVebpustnn0R9UoWPLYduNYfL9sY+c+Bspji0VrrZ5MRDsaF6jrOpiEcbT0W+MvrH8M8012j/XQ56BWuctVJDCxEAPYNqJlQrzEZPLVykkifayg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:12:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:12:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 6/7] selftests: mptcp: pass fastclose to sflags
Date: Mon, 15 May 2023 10:10:57 +0800
Message-Id: <7b6c64dcbaa07ff9cd067495e16205c81185cdbc.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684116357.git.geliang.tang@suse.com>
References: <cover.1684116357.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:404:15::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba89425-6a22-4b85-ea4f-08db54e9d082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vi8+VdqWHkr+Yjv+Upxoitpzm7opSUY9pqjhhptRkeBkxm8eR/DDtV6en8Pyf2M0AkXYv5soOwYF8CPB52Wl8skAoRRIG4jRoxfWgJ1+Qn7rlN8Nc7tCW0FLkVW8cEPOL73ldnorh/+ToEEnvt7Wcs+so+MbCmev9qLggUzggaT4mQAIUASFnBG8ayNt6tbnd9epjQc4+S8WhecUqjVJ9naCs08Y8NZeziLaHCq4frDWcWzJJj2KpzVOFwnE2ETp500MePgXW0P83FkbvXsJSvt9ulauofp7FjnMsD1YUaWy6QcXqbm3Aqg/x9OfZNCxg8PIf0ZxEjzUzc7UpEtljifQPhACngkASbyZ2d5g8CslDC81AKe/rmKUZHPw7FFnngczqz07YZYdRlRBcBaUzuOAuk66VnxHZ2ulbe8JYSL1aogqzWA/E36/RobS8D5mVliTsq7o/ccmCBbFB50UB44TvxjJ1AYeoo8PEWHrlXBg1sGGmbYiuHjFMPGb0OUPhUeADV3dL0F6Igshs5c/LtNHtZWu/OWZKX2xZBpVvfSuK2HVLM9pBLwGFqqhhiA8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(6666004)(186003)(5660300002)(44832011)(86362001)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mL6ffffbt5H4/HqUO7LExYElYRMBsbbrwuRxMQT5Q1FyCi8Wibu97sJwmYFn?=
 =?us-ascii?Q?4ZcNWiQSWIioCCJTGWEf7EliMWCXYONoMnDT7j2AyMhKZoAUdCEr8jyYBfLm?=
 =?us-ascii?Q?Qx8KVt6NK3O9yBkLZSKWjiMcSj6YIVHZPN3yy27Iu7QY7kyl4aLtTlc/PlWo?=
 =?us-ascii?Q?CxhX/5wG3KP2FANWFB1lyMYE3R73cgIwSPLYx+1TQ2oAu3WfvmXuWu/h2Chg?=
 =?us-ascii?Q?Vb06xf6c8YNwSSehjc/qgdbB/TOdhlFxWqs9GF+K6pu/r/hYBaldqEuFZyQj?=
 =?us-ascii?Q?JeGlRCBxbE+7hk2N9pLEdQBuuTyTheLIzMLZ55wTIRHUDseg+Vd69nNNrrwo?=
 =?us-ascii?Q?WWEyFJfDC88BCXRceLvXSCWOHiy2VUQs0JiEeKAeEKpyn7aj1c037Bb0cCcg?=
 =?us-ascii?Q?Av0U4W0XPkwSOI31IlQtYibYDGTAp4Iqbe8WpW6Lxvg7CmbTFBQAXpih7m88?=
 =?us-ascii?Q?1j1KqM9JtrQI9lXfs/2MEQrWjXbCKmlCHobWcYSIBg75kLL0lKfC8BHEAjfS?=
 =?us-ascii?Q?3pvFo5andEJkM370JePNM5NL259VPU6D5De2HuSCLDV8FWzKr48NyPbj2/6V?=
 =?us-ascii?Q?7DKhES8vdcIkG0MHsX2/9wvIwwxSlz4SEd7fYP6Xr6noo2r+0KpMudQ8iY3X?=
 =?us-ascii?Q?jYXDuBEuNzVbkrblx4N3b8lx+yl5i1r3AKMM73nlI7fA/RkZ5CXN6/ZOKm5b?=
 =?us-ascii?Q?v2vvIJWhUk0Eo/HmEL8fIgzRgVS2NKZpIeRtoMNXSECUmNLO/53bf5234SiC?=
 =?us-ascii?Q?vgidO8M3d25qzMpa6NUM+VrtHhuR+3T1EiBOnAghT2bael1bebN3Qz8g0Saw?=
 =?us-ascii?Q?QexiNjqqCOo2/NQcM4ULOoLj0z8q5znyQDgBWD/caWLTlgXplIHUbkaDA0AP?=
 =?us-ascii?Q?w4j6mNdiCUaruyS8H+u35gjLzQcAz+ZDz9HCv4Pb8hC/emcYs4WNJADUxMFD?=
 =?us-ascii?Q?nuibROppJ7k6H5zkROBQ0pEht5/w1MOq4MPWHW3LsW5sdjuXta1ygcmHMvJt?=
 =?us-ascii?Q?+HblhdG+VMRP5AhEhDwsT71t3DYp2VlZ/SAljnRFT2CDVGvESVnkeTWk/Hsd?=
 =?us-ascii?Q?DCd25CqvEgPkcDqUY0ixxvqyvT4g3nCU4sIp2JWN4jGxTaLW9iqKaQoclBZW?=
 =?us-ascii?Q?llvt0DsHkFsfF45kU+vxJIywp1H5iv4OG2nhjR+GiaAgTgfoLUS9bBwUrY1A?=
 =?us-ascii?Q?3ZJwX+r7FKchZekqsdLSyMl43Q2qwsL3z8G4jekiBWnn9hcL9iaeTcqx2YSB?=
 =?us-ascii?Q?BmmTSWtH6k7gu+ux8c96V+7PekueM9WU8z6hejQO8/oZfeQwYsAWi4ef+Sf9?=
 =?us-ascii?Q?1RUztWAANv8gcHOUgrTkOglyybcNPUL587ieNU5Z/9JHogDLQ6kvLOgF3ciO?=
 =?us-ascii?Q?fDe1AfXGOsj4w+lDC4BDSXNOJBnjeUV8EqURh2bobesN4RS1P3HVcd5oMttj?=
 =?us-ascii?Q?ZBEuSxIoKtHtkM0OQjzuZQj0lqr26bsoT0KUVvBxqvmcHSn2R0DYq5vk/0Zn?=
 =?us-ascii?Q?UUU/XW8/knj57NGYTQLCgwLb3ahWzrjNF6b8SiVmhvcgjqnNBcQXaLAso09Q?=
 =?us-ascii?Q?OLMxBuVKw9nzLuiFtQkZ+9SS9umo6IVyc/zDGmiC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba89425-6a22-4b85-ea4f-08db54e9d082
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:12:20.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8DUbADMkyM2XL1HfdiZFTH8L6sUDQ+pYZVmNc6EuS2gkHkdRQmIYpyWho400mIjxqxjtDB923t3JIPRE1lr0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

Pass fastclose flag to the sflags argument instead of addr_nr_ns2.
Then addr_nr_ns1 and addr_nr_ns2 can be removed in the next commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d8404d1354b7..d749ab8627ca 100755
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

