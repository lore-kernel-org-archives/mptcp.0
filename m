Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AE7E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwD+q7s5SOpP5D3Mtx6qqCSzrZ5b9n2ZjmKcmprAAwhRdEK6od9KTCUDDf/DzhQ0B9eV+u1YlU8pH37g9EHPltsfIerrQhLDK025NHaDTqGY2p2SbUpreV4lXbeJZ7gtRs7aDeHx8DBPH2N7Uyhq+gPwKsigTuL13FnuXJZmJ+siM7YXI+3lvLgbCQVJC3gCvA8+KV6G6qTFqFVaLqfIMGnW0ARxLKpwPayHj090kdEuz3g01UbLeh9KT0UB6skCI36QOol0SESaeXe7A+WgYHHuCqZb5Qxoj3urPaScFBWHcGQ7suMVUsFRgxF9do6C5aGf3eHTRXgCx1u14+L2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7mE3R7wQYU1WhyAi6jLml384hfFAxEHCXSXnZdMIvI=;
 b=GUZhG7YTOxnY/5GTpJEi6Y89mjuhn189/nb0Pay9jqdOqa3V6z1awlZpORSJx09/AZgVOALvtIxSv9yo4ygTIYBfB5sagxdR90YS/kqGUwtT2Imee9bYrLC4EqwPCc2uvM+QD6mGCsHsJJwZI8XU283QUx+hzJqpbJ7V4ETU4CecEO5+KP2dUbS9JozI+25DSPpDyxT8SDMl37vw4CNygHS7ucp0ND3gTEaTqCw6c2X3FquLoSwyMGCPDI3Xxjjkdbf6nw4vFQTgKCcDWbRWLrWR+VfuOHXtK+DCfFYeDReUexjXCUBJpAcI6ZG4f+63UiAyBn1yMtOnZ7ZdQju4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7mE3R7wQYU1WhyAi6jLml384hfFAxEHCXSXnZdMIvI=;
 b=hqtYyucamj9ubCIclrpWkABUIyqT8rEEzcm1p+ehq/YvK+eUINM17Sg8GUeEOd4+HYfrL+pIDQfI/ceeml3FSYQsJrlA4Y4HJ35q1nhmZ1hHBDLTN/PPT7yev2ATI75i06tosheL1IbhWrRqx3gJt/GQ6+Jy+2hVdIZSxeeu2AkprxQ8PqJ0vP/q8NYXVU2Xq67PvLu+tYckaDwdAOAQB07v/nXPISix8ZSJ8Jn0qIeabnRgg+iEIgjeS6ButJZSY2hMw0TIOC2v2xYndN7DHc32rwwcLibpZORerCSXWipmXSp+jEHnJLhkZlSNhJ3IqE+K1w3/m3ZF9MNt5Ic2/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:51:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:51:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 09/10] selftests: mptcp: simplify checksum_tests
Date: Fri, 25 Aug 2023 11:50:27 +0800
Message-Id: <0d1d2f3dd01d728963b6b813dc7230b02be10338.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0197.jpnprd01.prod.outlook.com
 (2603:1096:404:29::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: ea48810a-920d-4164-057d-08dba51e9d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CR0OHcUlpxPveTD3p6wJXEqD5bTu3c4LsrM6nYHvjpyZUHE+Qk2bbgiUMnf1+9zRPKhB0EzXpK9eK31EUBaPkD2Kskk6tFUTdAXluqXZ9AhJagQIBV98Wgw79szz3H9BdMa2LhgKnu73Drn6EWdAI1kLHpz47oxxh6i8+iTQOBT2u23SW3WCGG3KfZWFicVM8eF3Vw83UVCMeeso1rij7K08Jxc85i+4o6UbE6HzIIAilwN5Eg3WyDoPR7KU2pjd9WrTaXM4CJRDSq8yMVpXv5wRWEh+dhCnoD7/i36lDYSSZ8vyZSpFHoXIwCUKx+ktb7F0WF9x0gNVddjr86sZRD7a28o04l/uME46DrErRbL809onjNDR9+MOCS5qvVQHz2ndjHQF7aHgBChnOzghmtu/uqUF00JtvfYNAbj+mVZS7xcnlYRosqfpRL2tR6jRJHk0q1YtKKF6GZTqZa8usLYYjhJO7Axgm/G5GX+d2DqGVLacOuxrH1ZGRLRuBZAFVH/e4TWmdDiqBcZEi1Ov/oGyJoDbGhD0BaLsi+T/vCcVmG+xsbFgOTSfd7m8j18ck4JtQdDvrWZoQ/IdsVM3c0gtmJW7CurbeKKYAHa68oo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KnhXEZs1JPnqXb4kjjiqLp1VOWDve+QqRXT8f9+dW/Ip68iQJJk4KVJjKP49?=
 =?us-ascii?Q?Ytn0W1jxkUwWRqC4e+Cqq0Ac5TXgd80aiW2Zz/J9I4TfbaUW10UHicY1AT1P?=
 =?us-ascii?Q?q/NtTDNSFLYJlDMAgk/+UAIG8KmklDr2Q7lErlZlHWPZP2hKp5KaOe4ZIw2Z?=
 =?us-ascii?Q?9GLyUL1b0LoDzRAkpLu5OdGewIkOHvzQkSykQ/hA3SmDppMjKgBA5C7junge?=
 =?us-ascii?Q?QttVZ2HfQiHn+Y6Zr13U60IydsiwAE52TVC9lYq2KXM2TEl6SorZcBc1RjU4?=
 =?us-ascii?Q?1C80+9qnqKdwcB92+FR3Q2xsfBUMsMDrwvvFZ6M9y/yL7sBApzIjigpi6OVT?=
 =?us-ascii?Q?ZvEeR6cseT/1Zi18DEBmpJ48W7fL8UUIYmPywyUZ6jLSK7NMp5vrc+L9E5lq?=
 =?us-ascii?Q?JR3Z09E1KXUwbWwziES+AIVlsoSkya+mRGHz/8IaDtA0wAYkoBGaefW5vRvX?=
 =?us-ascii?Q?Y1DRATv8twqU6qxuyPdjJ0WDSzfX0i1q0+rCyC60bREQU+Gr71LxOYci4u9X?=
 =?us-ascii?Q?9v7hqaJocY55bS8BCwgjobZ1ChmPz2Jhm6zBQcU0W/XmMBI9ctFcdN2dSCIW?=
 =?us-ascii?Q?wjTkQUsd/HD/ureqdSphxoa2wczTjjH1hVAXWqhciKA9gNEP65Z6K+bPsoD7?=
 =?us-ascii?Q?O9UDCVjerK6bLYfFOZ7XA9c3amCuQFDjQGXqN4NI9nHjrpSWOBGcgfcrofrL?=
 =?us-ascii?Q?qYa6ai5S6SV1fj5pA2PNG4gNkaBxfaaSqtnjIN4ZuWBIMQ7Cm6M+XlKMAn06?=
 =?us-ascii?Q?R+QIZzBQ+BDJIbrJqAVU2hHj+Mqc2lkuJpitdCq3ofzKIt78JpHlLFNtoPJ4?=
 =?us-ascii?Q?mVWg5dykom+0cjb2fGfuW9eAAmnWYJVwYipKZ5lwr1fbS6+anvgWF2H5fTti?=
 =?us-ascii?Q?N8Px/jhQoOzbKwn52chXv2SYUk3gtW88aTu1uzV53dAgOFtlTLfwrkjQuC40?=
 =?us-ascii?Q?xBDXHyQa/RbrFyH50LTvhuvyG/Um6esKJCpDfvPGjcle9HnTjjFR5ZVpxsbE?=
 =?us-ascii?Q?WE2nAwo3BjY7UiKh1HWBpPyxAEpUoH2wlqUAB/qBN3iz84XDJ8Z9xhzyhu4L?=
 =?us-ascii?Q?fKczIDg2KLv/D6tfALswoEBNkDTuzqrOYTsGZyx3CvlNRTvatNpPoSDGcHZd?=
 =?us-ascii?Q?1unvLruypNXTuknacb5pfHA1kClv8cxjrHfdtAD8PAUrCb4h+nQ78GIo5DQI?=
 =?us-ascii?Q?w86cpYWDG8s2mwGDs2ACKmCozmm43S4y5Tl5pU9KSEyzhbETuQZGPo1CAOk9?=
 =?us-ascii?Q?GzMJN8JRK99EqJVPfD0C+3k9fdRZvbdymjb/E7/1LBf5gejxbOmbjZ6mzV4Z?=
 =?us-ascii?Q?Tw3Zd5qTnTtgtnq0FPdQ7/Hjxh+zH4DsV1hoyhMJBPWjx5iDnSCuAV4jzCLH?=
 =?us-ascii?Q?3S//e1j60LMVzKVGI3JPpqT6rB6JroMBbe/eWjFlb3x8beTt4f12gvhl9SD9?=
 =?us-ascii?Q?8x0AlyTGnE+K2xXY6w8Xuf919ao/RchOCQnKcK3fFOCDLCgiJpU3YrjzX+Ws?=
 =?us-ascii?Q?WxXowCEN/R+kwFNxr2c02aWTddegoilEtKDzXRJe2FHS3KWXcKcXXt8Maewt?=
 =?us-ascii?Q?BCi2beQB7eVfPqOjZ146OOZV3mFxqqAISCbDlJ7S8H4uB2GacDhizDU9ouy0?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea48810a-920d-4164-057d-08dba51e9d96
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:51:51.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPlP8cYHvC3t+2xz+YomwogSt/CxJ6ooyIsYj5vhQC6coJdiI2lVyiqG4l76Jzegjvl1f6nWeAyIXTygGV3SHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

The four checksum tests are similar, only one line is different. So
a for-loop can be used to simplify these tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 +++++--------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 83a625c36044..59f613c6d387 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3039,37 +3039,17 @@ syncookies_tests()
 
 checksum_tests()
 {
-	# checksum test 0 0
-	if reset_with_checksum 0 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
+	local enable
 
-	# checksum test 1 1
-	if reset_with_checksum 1 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 0 1
-	if reset_with_checksum 0 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 1 0
-	if reset_with_checksum 1 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
+	for enable in "0 0" "1 1" "0 1" "1 0"; do
+		# checksum test 0 0, 1 1, 0 1, 1 0
+		if reset_with_checksum $enable; then
+			pm_nl_set_limits $ns1 0 1
+			pm_nl_set_limits $ns2 0 1
+			run_tests $ns1 $ns2 10.0.1.1
+			chk_join_nr 0 0 0
+		fi
+	done
 }
 
 deny_join_id0_tests()
-- 
2.35.3

