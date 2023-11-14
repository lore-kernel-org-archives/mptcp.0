Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31318C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="p6NarlL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkRobkd/CDKrSP3hflQZ9krhGiUKggpcO83yBfT9jxK6vi7mbmtIo2D9CuT/aWV4N4pPHJNezprz1mUmopheQyCnMgCg80/eloHiQSwKH9oPaI10O8QtzEaT1dIqFxPTIEdFyFtGaErphfXOq1LgIZBcDrKUjU/Odbp3hPYhpRG2GnYtyxZijq35QfBO5LP1r7QXVRvgZo7iwGtTjh2MHZuaR82N+nb5oeOOdXU9yUgEONgWI+2Ovuq8clY8AU/dGRwq6gIt57GI66ZIIy3pvsJvaYxVu/0KH/waypSBrI5Hxn3+Wqrt9EoyPpWsD45zAqkMam/e9adDg/G+WSjVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/gQyUaHUhRxW9N3xngLMLuBruOs0x9K+AgcCwzAmQk=;
 b=jVhid/kDKrXDiwQbNYjkJMLegTv4+DH+/MNWAVUXgB4d4K5kPWAV90NwL32SA1ldPA8lCibiCTDhoLz4ntdf/6q4/tVlHMUgpYBE6nIO+kH+Ma8gyIhCvOzUt5sjlD9HMpHA+zLROo7HqVgZkXsKafhaG4bSyURhDfO6/ApxUUwUc0zyMxNbUlJa3soo8vlSU1iK87DpNMlp6DEBtmtHdLDHCMelJzlNC+5XRqcbY7TwpR7nm2xuc7eUSWyDzfp5DIaElp5YcXgx1c7eHHVolICcGZlK4CGEK8y783z+/xfWn3IumBd7LEFLEIjlelmbBl39d9lYXmILmgwrB4r0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/gQyUaHUhRxW9N3xngLMLuBruOs0x9K+AgcCwzAmQk=;
 b=p6NarlL+EeLeXjyB1ibPoThJrL5aPffAEsNbU10B0HknHNAFtksgOroBP+V13PP2eyld2jWOXcPiScUvWYZSFbZUmIVjQKstoEuSOAfeyihFfKx3UmwwO6cZYKYjiOkhmyi/plATcu0fWx/ZIfQ5HxxTCIPR22GGlP02B1DmVvgLl485RcOgM1BdDBAtJ7hwZtU1AsbE5wNEeURvqWHcE3FwtEFOgzY9nVCu2eyHemE1WKyt0f8LewB0VuGMeLTwyvqxXa7kLX4VRA9aakuz+PwQMaHEk1Vckv8ze0svpdXQRvAA4kJlJpS2Y9dkvXo9m8bl8SDoLXc4/kmhG8H81Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 21/33] selftests: mptcp: simult flows: print out test counter
Date: Tue, 14 Nov 2023 18:21:51 +0800
Message-Id: <720c63a7f1b3c38a61188e3c9e07f193b29730dc.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a696761-621d-436c-e1af-08dbe4fbd487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G7XYFB+UhDPxPVhGTvHouq+/HgnPUZVi2Nf6yTEcEN8PzTFvwaxbEUtcvgxSJ4oEjF7Mm2ZvxHYFASsAit9siCRLeeEJl11HmoOTW/o71Su4+wMf8JJ2rlLP+gHHbr4h5CXYYW0GvWjI63NX1cDefGo7q3px+7ineemwn6XedaiQkHuR2qYn+bGPKl3wDsrSG9H7dz+KRu2yoKvd2/nmLiYlt08PWssoAl/K59l1t8OhV0H9MT9IPTY5LqJ6+jIZg2f1VpSIWMgEMi2N3YI1+sfGYKNfAnLkMLWT9MWuz/1myAoqGv/p7ncFQHIOK6OOa6mrMZmlGmC9N87z9hC3sEyvT7Z7bo1r3E4TnMxUiq9PF8wxZgkC1F01YxIH9erHAZZ7VIEfkbnDAmmGMdNdnxIChcFyJPd/HEGbOnyoaP2491qQzzB2FYSRPkcSrXIlom6g6b8vInosDqrOt1LuDKa9HVNrxGwYr5LZ6YRkLQyTVfr5l5h76bvNpOG32CKEIAaOTkAIcUG+SiJ5eQ83KAUj+Zu5wqkvyBWo3mw2Re4D6IJ0pdkmPKcbax1yn30S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wXhJqr7matQiHGI/UfiOcKJsI8JyWFftx6g31TlttN348HY4Ec5Ip7A1wipK?=
 =?us-ascii?Q?ZPHwV+DGOwOMPTFid6n7fSDTpNFsRFHQuHjUilHudEGc/8UAsRmBWvUklgD8?=
 =?us-ascii?Q?dFSKfem4BpWIlr0eOqR1hm9lYeYgA6uQU+vIzisEFpkowmNOL85vu+cmyvIX?=
 =?us-ascii?Q?ipjmH7xy+VlcX/YSu0HRu5ROuNkszn1SO12tmTvk85f4kWKwDBV77QGWYAE4?=
 =?us-ascii?Q?gcJNaJqlAb5rT+fjwMc19P10H0T32zyBxVarJ6rGAAknIvHGaJB4qOUGyK+1?=
 =?us-ascii?Q?KK/MJk9PFHiKYhLmJyYQVxW+YOmuI6MYX1LqyLhYX3Gx/xD+Jy1sxXp1QW5G?=
 =?us-ascii?Q?55MaKYkMftP+wrEMeFCByPAlqeMD5q0OPEKUiG68Hs4yygHQGA/CZymZj82L?=
 =?us-ascii?Q?5I1KUNlBm/LTK9uEFSQ0dQ1GAM2e3V8DlPNChcmpqxzwTefsTjtQn9umDEDK?=
 =?us-ascii?Q?wcKcNeEL2so8lNfMVfzV7YTyBFp791l9JuZRFlbqUST5d1vOlSaDt0MM3XnK?=
 =?us-ascii?Q?GfraZYD/RwdNOpc7zQEhMR5Av5EnW5UlGm6Bkx8ViM2eggWuOFkNIzmUWmsw?=
 =?us-ascii?Q?dzqTM8vpQGnJh3QrkrrP9lsgTxIo+y290WxuBEseJNz2oJpfgfXx0U0JDOih?=
 =?us-ascii?Q?xx6igW30/yxZ0hmb15Hf3Unmmm6ZncUcfuIX5/NMY8lR0okP/CEGDu7bp7YE?=
 =?us-ascii?Q?IJOcIpWPUluBFMMSHUAH15wOmYQDIBe6lnA05LGtogFjLMwXv52LUC7KdwqJ?=
 =?us-ascii?Q?BwpqKEXW5vppfIx74tQsxhun8NcNwnLD7FbNT4RXGNH/uugfasLSPxvoMQh2?=
 =?us-ascii?Q?YXKj3w524sTDYCVZb0zM7Ku+dPFl/jHASf+XAXX2ojkfkWH2s1eT4eJmP4PQ?=
 =?us-ascii?Q?Uf8fSkoc3oTqTKKhazu5TtwAhXqm6n/t9jC2WlmQXJgfmWx6gjM4xM9F2E2T?=
 =?us-ascii?Q?xssR9SUgPezvpQQkDI5coVkeXqkksXhJeAd0Dtb807EFabcc6lvap8Or0PH1?=
 =?us-ascii?Q?wJ+NCglc+VW86kCfcQBoKOS1O4tGSr4H1sKoE8cV68gWX2L65aThqwgwQ7gO?=
 =?us-ascii?Q?0ceowdCyWTp3kl77r0zEdI2LMRveehnXGMtUjDy+zpya9gCBAhdRybLhbJs8?=
 =?us-ascii?Q?2ueT99V7c/nzPeX0MDNf3t47qELl5VGyiTkbwhGU+srxwbi5zNWrxpbgZ86i?=
 =?us-ascii?Q?vloWNfUgf8YYYnEULp5t4N3G0+P0LWcAU1dTd1YAEX4m/eC2KID0OLP8A5CD?=
 =?us-ascii?Q?jcUzM00NGeZuvFb7mE8jjSSCHcsUFDDPNDNS1jdM7mpGhmOct6yfZGDosKwM?=
 =?us-ascii?Q?haqYwfJVJpYf5hCWU2m+RBm1Yz2xzxK40rtoBPYHRJAufcBQrmURaOalEfyy?=
 =?us-ascii?Q?GS81Wcf1FsQa4ObvpJa2q6gvKWZrnwSXm4lMBtHMW2BE6pap6MyiHpPld9OD?=
 =?us-ascii?Q?AemJfpbsZ21OYB9V03KrjgDSqiv3w7gWvl2PMhh4p+KYJtyJDMB+aTVQg6Yl?=
 =?us-ascii?Q?NBRY/9sAA8ogPpdeeZ7FpI1LZmNovoy/RnYn40+iak5rZ3z+nuXvAsL7Bvkl?=
 =?us-ascii?Q?pMFosLec4SgUTkv5Gijr50JbXdA37N8Erv7fOY33h2CDJmNe0ET6JBjBEvCf?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a696761-621d-436c-e1af-08dbe4fbd487
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:06.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJq2skkXxZyW5wzKQcvSDlD4tuPvuAp5+H74/XfrploYpq5QhXA7lSFdq2EyKq1NNLqJ9cYOrgrvgvZAGWtGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

This patch prints out TEST_COUNT for every tests in script simult_flows.sh.

The output looks like:

 01 balanced bwidth                          7411 max 8456       [ OK ]
 02 balanced bwidth - reverse direction      7380 max 8456       [ OK ]
 03 balanced bwidth with unbalanced delay    7434 max 8456       [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 6a4568d8f596..a9e14698c179 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=1
+TEST_COUNT=0
 bail=0
 slack=50
 
@@ -227,7 +227,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -236,7 +236,7 @@ run_test()
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	printf "%-60s" "$msg - reverse direction"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg - reverse direction"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-- 
2.35.3

