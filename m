Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998C125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4oRbXszrC0C5H1s3p+Na3H75Ay7QuNf/snHmM6F73bjK5hYuIPESg4RKUVKo4RHays6nE4ivXUqQoqKrl+PL7qx0May20GbtRNe5CgtHfNwvwfUTKqimkRaz/dJH/0ZOkeG6ASmGCM7KwfrappYdHQokQQJom/v5r28FA8xN9rnCFPIVZokFnj3U2rTnwC1DGks28uuU9EsM/czED25oUxB1zzFDl9Dq8kTkTq/syIxjkk0n7snT6uUqlZIyOJy9AW50gDKw/xkIsygrhadG+AtlhVzx2EJy8UzJADTiHOufX41NOspYV6lSmXsowzJtl9h046S8h3NE9G3NnU4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNw0zsb4wZAmD9AaThDWqiAvjV6ZxsfKpG3uZIV1Nrg=;
 b=M0JYpqC8JxJpuvm6amWy+3tj0bqY+N/3Zmo4myFStOxJTNcf+kH9qILCenPSmafbNHmpDRI6ZakIoOwte2gEuRSYBqbmeH8JXRmjmrPSgzdUcCEnkHRFkcv66f0X2DuGRs1t/KVyk4d996SM2xEIJTwiCfPvrbAkOM3zHr8fSP6jyJYezIofgak4l22z2XKfxoXUUTdxN/W5OB7PCfMRsORDrGGcuBWCddHDB7y3kqcT1/WzwDm0aGXxejmrgKiwyIvvQ57j2bLLyhuI/LX/6eH72Ukhv/anEL8mbOpjZsSZ5PEAEm5HerhlXG5S+aY+zTwFUGugRZMQHL8vJFJMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNw0zsb4wZAmD9AaThDWqiAvjV6ZxsfKpG3uZIV1Nrg=;
 b=DVOFuXlTDjaqAE7Dem7vq80M4daSTtgEwimrEXiQaliWdzpQUf7SFtw3rd5fEm8qnDMLrai17e0rqyANsDBMBe3la0C08FM2Ac6USdahIAfu/05CxqnFL5LugMo8PsYitemRkXjkIclMTA9E32okxGa/ctlHyBChdXd/8QLQpBZluos385A38a9j/GdvWn97lC3WE8v5+zBbb+Lqf0GTRpo3y+rKiCa5EObEPZBK/NqVRilyxfybJ0aIuhMglmMpjMnMABM9MvVx57d2bQtg4TYQ1heL5KNz5hyWK5AkhKheoJiqCdJ/kOztZ2Ka9SmY5GSkZscAUU+K7BDjN36/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:42:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:42:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 07/29] selftests: mptcp: display simult in extra_msg
Date: Mon, 25 Sep 2023 16:41:46 +0800
Message-Id: <8b0cb915b2b9c6c90751f5503df1721157880d1a.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2f934a-0796-4481-ac62-08dbbda34ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uwKs21CLBrRRRiOrwkBfA69XQSQItukwMc6F+hXHHGP5D5lR+wIQLeYhO6IbR/+uPNRlGAfXMWPwf2UelxvA97+6YdKK++XKlWdCVbXNnshrosCmtY8VSErmvFJH0fnOAWs03O2fYxFQeAU7a4gn4uGPJVUvphfBJ/S1LcOpzNZdr1U333q3V3mjX4btV1nhBN5PVZ2TCgtqZQSUztMW0VhV71Ho/sDHwa0rSXsUd9HbwhJiavydNhdaTdPB3j5HlrYVvFfArZnSJmlKQoO5l/Hf9OAG91S9lFZwAVPIPKl6rMOwfB90iXCb/r9+DGlS+wDXt3fRqwhui2WbIk0//cvSWlB2kqvg7Wy6NmDOygL02PACRBkwYCFp8vpD9NnrU0KXFvtoRBeyme6lsCnc2brH5n2GSJJ2WGRwuMjJNPBqkrce+Bn0huQaLO78ziC3zLrSm3BQw+TLb71uHBBUAAQN8J8xKYdECxq1S8721lw2wJuUzwXLrVU1Vd4NrWGJQwCqV6J2sJyJPdBeqyJfVX+13hH+bmKvkEp3KeRzgt9wJs+ORt8bRWNpT15Ou+7Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ko/xSxUXL3WTiJfD8DqzNuXlH8nc3kys94FkIl95UY6OnmfYb2r1rJQRducq?=
 =?us-ascii?Q?oKO4RE6Xlj1Hqp1/2URWAYW0pxWcalCE74FoAzF0KKJt3PKIYhCwo/umA/e4?=
 =?us-ascii?Q?mh6Oa6P6FuWFAcw1nWTrieKJjmx9LAjJAlsPgMqeauss95dJ6FD6H87ATSj8?=
 =?us-ascii?Q?p5ewReiTssCGOTj41EASS8xIT2NtDu0SOvPdpoWShNz/bumb9uaol11nNMwd?=
 =?us-ascii?Q?EeThGY0nFl09DQHi30wTinnJxMuNQwK6hdmh1uVC8PfBiexIU/XyM70BiF6w?=
 =?us-ascii?Q?VeltlMyq2WBkRo93ao5AASd4S4nYMsXrC5gIrjsVLneXKzA1UvqH30H7cNME?=
 =?us-ascii?Q?apI+hpT+shIBwXWg6fWTH2zuMgpypdLJfHIVIn2IJiwueQPlSUf0ANgqLwfx?=
 =?us-ascii?Q?cq8Sp44N2jlVPERg+1zO7Qf9OyGrGtDckubrw/hyPUJEi45SByEAQy6BxgFd?=
 =?us-ascii?Q?tKUHMpF26wBz9/n/wiop8ZF3feRDYzIMHyO4CSkpdv/BRSGISPWT7ahEwkmj?=
 =?us-ascii?Q?n2ud7uaZCL6pbXV2bzq4n1N2erRuchf5SZ1SqDOzV3q00CBnXBdsrgmFNvra?=
 =?us-ascii?Q?jUE2AwdKRZII5ifWrWPCz9nhB3d3Qy5ZEJqpsb8iiHUc85rno8VLUds+V5bD?=
 =?us-ascii?Q?yuP2j/RXFlo/mKNdKLWkoKhS7dBUhASjjE1F3U1xZyWu4EmiVyTv6Ow7VT61?=
 =?us-ascii?Q?PvKdbAvSnNfqzeRlKM5iKcQrVfWjUm8sj9DziQ4z1y6yAD3RtdqSfm+Z4BjY?=
 =?us-ascii?Q?IQMvWg8+vCDyXXh83yVJKpX3ZL5VF3aTnSrXEcnO7iBfJBNWIypxbBWxCMQb?=
 =?us-ascii?Q?BGCZNkdDzsucGajaaFdw6Tkmmf2LRh6doniWEpnTIchNPPiQzKv2YNbPQxpo?=
 =?us-ascii?Q?HLKrOATGYk+JmP9QTZ1pl9I5jBCV7I5cFShJbJpZbXnniZ9It3L7xzOe+R8g?=
 =?us-ascii?Q?XfvZTuG87HICQ3WdKWGoF/gWlYcldIy8H7Om+o5O19ankWw48kn8bhUMzgNh?=
 =?us-ascii?Q?UqItjkKGQE5yL4AZqJQ7J5mV74XimKfVm2r88wC+gjcj+KVk4mbZ/Pp42aIe?=
 =?us-ascii?Q?BLnbxjlaubxubL4b3CZ1G7EK8NuPgD8uVXjYrPd0QasaklI6gJiODmtXcOG9?=
 =?us-ascii?Q?rc1MmU4JVRykgkRQsFbJ7WbPDEfdfu5rcL4wK2uTjqYCcOBQ+kOad229rtZL?=
 =?us-ascii?Q?5QyFD7E+dafDMDuY4aCDM/wn4/zbcaEvn+zAkQ+zLpGkgF/feo0gQ0zKYGhJ?=
 =?us-ascii?Q?yVxyA2EUj8xxp4EU7f7sNvYhtXFpZDwHuERjnXTMv1CqJE5HQD6G6/DE3Tzy?=
 =?us-ascii?Q?RB/nLEE1ty4SoHsgbrbTIjRuhcRrMczligdmmAK6WKjKfSw+9zu5XG85jaak?=
 =?us-ascii?Q?vVO4RKn3qvbJ8/vpdxi68DXv4Bh4a4RPkMgI+U1Yk3/jq7KatqdrlGw8zsR7?=
 =?us-ascii?Q?/dTjeFKyg4piTwg6qKlR9Q/7gkThafEwHEx5qIv6DQi6QPrVgYxyNmEJ9sAR?=
 =?us-ascii?Q?XMlPxoLb1gpyX6gqDfvB1iKBfzViykXryCjbzt0X0TVq7g51+AJo2RtTk5XN?=
 =?us-ascii?Q?KNS0jfP82Q2XM3870OzzSCOF1yeKCR71YrqQGGHC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2f934a-0796-4481-ac62-08dbbda34ea7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:42:10.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPDk0dbPEpTMt8SjRcG5aNcWT5lK7i75x1OMbz0ihdVCuSzXMkze0/ezEPLB6n4xb251nMyc5WkjKyzw4LsvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

Just like displaying "invert" after "Info: ", "simult" should be
displayed too when rm_subflow_nr dosen't match the expect value in
chk_rm_nr():

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ] 3 in [2:4]
      Info: invert simult

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ]
      Info: invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..d02e53be8b31 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1766,7 +1766,9 @@ chk_rm_nr()
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
 		count=$((count + cnt))
-		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+		[ "$count" != "$rm_subflow_nr" ] && \
+			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]" && \
+			extra_msg="$extra_msg simult"
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
 			print_ok "$suffix"
-- 
2.35.3

