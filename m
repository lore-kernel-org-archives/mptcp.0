Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB915D0
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfdca/bzEm4b/raMgx+ZXqN3ZtxLcFVfxzesH6fhKFqYwapalnsBL8H4hkcOpl0/R8VFOkZCA6VofHtmlEUIORzTPKl5DIWQZvO5cHI5yef+PrH6W1TJMY8BfAj77HWiS4WkAyPPl0/Ms54vVVA0zhzPmXJqC9bkZmoXQu0A05FRX93LYHTUQtX/zQv4oKEqo8AiSDu4VBCDjh8gi+sElmFbykKc6PRH+WpYlVO5GnS+EZAZC+G8szlUMtOagmIz0yL/ztlutl73gzMGe3mA6z0uIVQNgazQAcb2yT4GyU9csDMBf22F+kDjdcWI7qcb1ic7lVefTSYCbAw+eaETzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJs0ashKyKbAlbgVTEKWukn8YXWq3FqI2KW2vap1HA4=;
 b=jtdkCps7JNgoossjuPiFWBFnH0DtGUJioE+2ftzcVNOAFxh0ikO7ahpdEt2nR6Tr4ncELRUrouyWbpJ4gSRz+0C3oDO8l4izsft9bVlxqFabn8J1ntE38+AyYV6YweudE1eTj1qtW+e11QY0J4DIQN2Vq/C+JXs9xqYY1TeKO+1M8nYiBI15gOTckkUu750enwrQirC0PW2l1fcnKkNYJpXnt5KIgKP2zpNfdQNiME1gyCEmqWzFiElV63jrfzMgZbuAs5TVuSZfEbs+KiQ40cSjli3c3XFa7EwNiiDctW+iOoxNfzF/xqTfbLAwYCmhwYF7PnIWlu5sBlMyL1ioYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJs0ashKyKbAlbgVTEKWukn8YXWq3FqI2KW2vap1HA4=;
 b=sFg+17eJbASkMfG3fbQ4e7frBasoOh4/7ri4EHzJopXYQWe/qL10rb+0cxE1T9rzk+f35Us94IniH5lbwt05P9fD+q+MN8nxRRIK2MTTGrC882A6IunXOV1upvaPoOTuhb2ZUr5exxRuXKh3+/VON+9D5t2geQJKjhmG+w89wX/upxhxBbNa4aYULVU6QiPzkyITPXFsThjNv6HI3S1l59hrCDqfbrlqxa7QWujJd7bsWnPmbxVXk7LaZ4biIj+hZWYF76bDPAb6K2LItemW7lLmbGcmZkpUTyQzURRv50YI3/ohKgmXx+NadllOgjEFxH03AV/nEiFHFbwe1aVcGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:10:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:10:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 11/12] selftests: mptcp: pass fastclose to sflags
Date: Sat,  6 May 2023 13:08:59 +0800
Message-Id: <2d9e265f230b4af2731136ef375c46d1c4501c04.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eee206a-be13-4da2-d657-08db4df02ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	byX4CiNXP0LgoxKt3t44sjwAG/d6ytGBAmtK152u2cmDca6AzeZLH6kKbH+FHEA7C5Rm0YvZWvKsze/Lfb7ZAPIBtxi9VcM/IEQXEPy8bN3nmZAS31wk80bWesD0wSIHCzSHmemtoCsS1KPfkn5OvQ7eMQqrFjwFx1hDGXqZ79wuH1yJZRGQbDetHSZQ999sTj5fBtHyo2roPCNI/f6NvobjkMUTxCUrrCjgEZtAkr67SXPctuNCOssYsLNDec9Fez2hHN4Xj7eK4DVgaLOQvJP2vdCVoByJjdgNeF+qmy4SsHNe0n9DHu481mBGDmEIjx9nUibvYWxf289v4t38s40hK7AVhV7OsG4lJXQNXTtBR1N96WqN6SOmo3SbzX9+2o0QY91+J4o4dqu6M58qCfkuiEKrJR7t8EFNjG04sH0Q+7gVFDaFMK8bc2+xAz+QVermLOVZP6j5C9JWnuuCEWjF2+YeHzHGmlJ3ht6tMLMSBK69I3EPaf7N/MLqLJj6O6Rim4BmPRWzrot+IUDkp4wubiisMoyJspALxC5qmZLaap9wRhWV/lJ3cvEL1qLn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XqrJ8bw4B/THv22RPwI3P/CcPW03S/pedaXTafl2x8ug99tSZFJVDTsK3f6d?=
 =?us-ascii?Q?LGAVPogArLHOEHSiTYzze7GKzAe6o3J6RdBqhP/AIC+QaEyv8ROz3e99LIdr?=
 =?us-ascii?Q?uR0dSejX6BoW4X1+AWIXS26XSnYGnfY0FKSOnkF4w0uHoTrrCO1Mn+pLnpD7?=
 =?us-ascii?Q?fCyv4Eh4vFxXuqga+UivBniGuhDct/rWg48TskrOd85Nt+oYPIk8qM+i+lr/?=
 =?us-ascii?Q?UXnePHK+5rytULlS2LhZ6m+bUB3973A90ndQuiuRdq4nmSuNv15Qf2yrupp3?=
 =?us-ascii?Q?zzLJEVSoq55Aziz4HkLrG8ovbxC0biLAuOAjI4ZxK2zaSyGbRzsAc5uzekAn?=
 =?us-ascii?Q?GgR5Fxbunl2lF57eRhX6wkSjQNV+8nidoPL4hl0GZ1dHGIQl9KSZiOv+Zpex?=
 =?us-ascii?Q?Djc5kAkG6yNRDpHjy3OTAJaO+VD9SywBCraI/9zzsbOe0gXwYz9CkxWOO48e?=
 =?us-ascii?Q?j7BiifxEwxXHN/I17tHi73xbmwsWaL6glCEWgCx8eFe0cSIH1InxwE1v23g8?=
 =?us-ascii?Q?thJrcIRiSQ6Yl+vLx2VWbDKjemsUhkYGcsqPZK/Prvy0YYtSY2Nw8uRmGq88?=
 =?us-ascii?Q?jttPTXQLDkCSiP4gnFJYauXnV1ySFwrppbqvRg7vpaNx4WwQ61K7hll5b4RA?=
 =?us-ascii?Q?j4WbV1zofzWJIEpXuE7dqfaS2u10nPQ8AWaMPfQB5e2slQZw11DU4gYWPCBv?=
 =?us-ascii?Q?3NF/EDHtFjXRPKrD0IsgShXaIro8RFyHp+Y1OQHz3OClPSvMJkkHjIMr8icp?=
 =?us-ascii?Q?trU2ybZ4Go8zVKBXZV8McwfJSBVVuTl+bqGIecFI74cjCYXHIGxw/3gwKf5x?=
 =?us-ascii?Q?fSaFGfSQv6/hf5VF9aTnBiISSQoHL0ekjlwMLf+HSkBINnuong75/wvda8xd?=
 =?us-ascii?Q?44EYXBsFS1mzg0pr2qWITMWQdIDMJNIQKs+Nf0EMmK5hqxyfKnZ7bPXApUNf?=
 =?us-ascii?Q?/odAk2sBcL28wVSIp8LiYKJSicDmovt4VCQjlEyvmR71ZiDDeewnLRKbD20s?=
 =?us-ascii?Q?JbdnJb4Z41zKgM/xMIKmIonUoLf0ZAqKb19Hs57Rfy99irOrPTDPsrEk9vbP?=
 =?us-ascii?Q?+agQwiQojny1/qe/FvhiUvOn0Gib5jpF7aBSiv/R4n2/tr8J6suCdj2Sp2Yi?=
 =?us-ascii?Q?2GFqC1pTV8qA7e7Yv206A55nz2chhkelgjQyEdYBwe2BivxYvljOoysWepB5?=
 =?us-ascii?Q?46GGgK7XvnPMItchQScOCDTokWiLQxTMEVXi4loIgHkrU8iN0YLTL+m3tG/J?=
 =?us-ascii?Q?pbrJBMuexujeOyDVRL+1tB05Pj9qjySLKZ5xXY/wGRsEUSivw4WDx83hZZXM?=
 =?us-ascii?Q?RG3+gDDpjMDbGmarM2v2aLlc5MdiO2vtL5r9mB2Zl+l4oRGFHKrNB+wa2t6E?=
 =?us-ascii?Q?DGxdX7nb2aBGtuFR1rIdU8eYRu9BmzCXROxSaC5ndgMmuRhBJJ6MY7PoTgBK?=
 =?us-ascii?Q?3SnSuB5Y6reJIlQty1zSpOYuoZ8fCyJO8Jw94S88EQ4yvvbmaE2hOLP4NQyD?=
 =?us-ascii?Q?BBhFsL0rIs7N7tqXXSBRyTZ0wjbmukiIJ6SxYUkHF2NxBt6SbvNHqBlFzkfX?=
 =?us-ascii?Q?5KMqtbi6Sjwy48IItsXnfA/Hqm5v9VPcGbpquRnz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eee206a-be13-4da2-d657-08db4df02ada
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:10:11.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0pWneu7FHFaycg4JDr8tglO/GEeysiFbohjmyvEL3kPQW9oxl9mUR8jiSdukFfYPepxknr+n08Wx7ycMdWGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Pass fastclose flag to the sflags argument instead of addr_nr_ns2.
Then addr_nr_ns1 and addr_nr_ns2 can be removed in the next commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2973a4ca0833..6c4c1dc817f5 100755
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

