Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7D1107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYpqQgQ1Z2IIXNBT+3CBmxExgn78df33MfJbN44cEhXRWuK1V3npnELRgG2P7bsoMHmjzwkWjpJs0g41NrOenEezUnxdJU9QjH/EICIxC2JyR/humRohgVQX7irKH6WbKhBrBIsO1VjUKHY6CEp9J0xilCQE0r3n5PygGEeAvwgb71sZPnFZW1WejIkO9w83YMazyV7zpu8/jmcYoV23ErzQdd9B+ukmxiRaFkyMADoYOxSH9nw97uApDv/SAwSVIDPeW/M2rI7xNIVYEs28HcABt+FvCU0pkPX6d1u0j1e9f2ef6ub87HUA7gYG/hhWWdhYGkS+/P3nfkSF6U7qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNw0zsb4wZAmD9AaThDWqiAvjV6ZxsfKpG3uZIV1Nrg=;
 b=fn3mZtMl3EJEYDXo432CFlhtykrB129o9i3Ifbs+MF593w1/bB1pxTcvlQLEYX8gkFUIAep8SX70nnjc5ibpmA/WRKDx22oGESsapnZu1pRlUM2sIvporl+5y8THMA19q5XoilVZVprpgrE77we/igHF91btV5vbowZfK/toXxhuge1xpDW5tGY6zI6ubiWmndz0s8KXxFgHD/cqz12y+pegfxmYLKEfk2zgm3aesE2l35Cn7kBTFsGEfK7Nrl1p8w8+adXDqcR82znAeNHeYpEcybtVvsvDiI1r1bZC44LGxhRub5xW9rD1QRD4F5vOTJ/IfM2yIphodVMXnhvg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNw0zsb4wZAmD9AaThDWqiAvjV6ZxsfKpG3uZIV1Nrg=;
 b=J1M5pQDAN2NMktuF6T5bl9dw4xHqSE0AO9b1DkC8lZ3ihULDidRrKsoc7gIxgaVaiU4zENEzanJI0QQ20Ab4HZzkeUYhiO2Gzn3CLQQHmhdjdK2uMmLER8iFNm47N9dnpQkQaZljrMKWGGTotsKhUFJWeWN782faRfv1pmYM8pDbKn9vrE3Tp26mn6UbcWWD98MRZhyvqc45aiAy6yVu34z718yVTCXZGAuwggpN5ktCYCCLFcu5KZ2CE6WMkzGGzFhCVKKEzuMpaoAxN54Fi8FqekDeUxoq5WJTtPb+yBJcOC+1o/zzyvNmfTsGFGEUPuYPWF+fDMKollNFBeZ6hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:38:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:38:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 7/7] selftests: mptcp: display simult in extra_msg
Date: Sat, 16 Sep 2023 19:38:41 +0800
Message-Id: <90054f25d522c7252a511eca430ebe326b22d346.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694864093.git.geliang.tang@suse.com>
References: <cover.1694864093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: aea5c8c1-63f0-4c92-d073-08dbb6a981ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aY8U7k1BIZWIPc/Jo8IHmNmu2A4DlKulOoSslmbDhPGFWyL0GyuQcYKi6TisyHzTUUU8+ywQaC5MtLIi9bgNeJ5S4B6z20XvMFPjCusXd2leJ+OJs6b1tRy/kF5E7Le3zAZR8J8NEc9gemV8KEc6qiU/EFFKArfkkBMzPD63XdkifbD2Ay0CjjN6EosZrNhJTj0qYyoxuMG4xU44PBToHn9/USITD8VGwuij2pHnaM1mR3A3XwjRkFYxLzm13tOMl8QCagNV3dA66Gpwaj4FmzvyGRJPQhsrQl+lash3OTgLev/3K/FIQi+3nbQA1RcPvCybfTKNUWaXyCPXeO0d11JRYdj5WOYZrjJfrxnULxJC0aCDlVTOvK+EaG3P5hUzdeCkn9l2uCxQ/4ajhtgz23A0GSAuv7zxYuZJvHslPiTGipkKG/sN17K3YNec2JP0WqrP7vDceMybS5QVCuQADyyO8bKPxukIshD9kFhRBVAO5mxRCJKDa/zAFoFA9lPcusqjJh4omDZFViNvcgVQ1u8Y2+dEMqFpJgMoESILrJIioEV3tCxpc3rbG2nBYgqst0AYJQMKiM7gkizXsQcIUczg/595aeDJ6Bi4lJ3jQuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(6666004)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uZWYCrkfsEpVFgsspCrVputT85oNtHcJY4ebg5Gp80tzK+0K72ONI9n+WgkO?=
 =?us-ascii?Q?M4sTIv4qxxQwzUDVqS2vcS5xZyi7aIhJ4Eo/4ZQKxqs9Sd7KRzLlFG8srZTA?=
 =?us-ascii?Q?3VxNmLwPEvvdCyy1pZMUiXMth7EQxXxtlsU22fG0tNAwOPtXiwwgL0Rb2oHU?=
 =?us-ascii?Q?Vg0VxKIwVjn18EIKsPIsLzP6Ebha7jZHT4FI3TQTNxnJK+wH0OOmsidNEmZW?=
 =?us-ascii?Q?aEOxfU3B6eiAihEtR+gBNfRLVd7b9m8GoYP19EyKxJwzWagIF43JQxB5ORLc?=
 =?us-ascii?Q?TB2CN2hf5mxmo9R4cKdJepUDxacmVk1LLiUnZsIZdx3x+A4iu9PofJ9emdeN?=
 =?us-ascii?Q?loWqU4cve5kT4+63y5deQhtdgUlkuPAtrITllK3VWKh2AbNVDPCY0/kLz6sS?=
 =?us-ascii?Q?wEEMyU7i81aaG+GprU8HFF6m2mdjlrvqoDsDgljYjzcKRSOzgJJ+ukxDdUiR?=
 =?us-ascii?Q?VTpJrfU8wblm1VB7XPfdh0prDlImSneJWA4/x6hSM74X7ijVROVZnAS4BVfi?=
 =?us-ascii?Q?qo/tUmQ3upM9zZzBle5QPvkDDC5SnMdiBaIT4TN3baj4uPfD55exg71R9q6b?=
 =?us-ascii?Q?Q5wXJOsmaQ5tuMYS8YUl0jnsIcxAcOJRCli6Fh/OQGoKJMasZgKuThstidKy?=
 =?us-ascii?Q?tr8D6xZsfDWpR3DkqHzhN0VDYyr106pgCwZVGoOwDefOxATijPLWvZvzCxCZ?=
 =?us-ascii?Q?Zhx6SWrZh27iiegy6xElB/2x1jw9GUZFPRkOVPDu97KocudopYZAm+71MJc3?=
 =?us-ascii?Q?rFxSqNpMthxi1C09Js5rd+F/V4Xw8cRCyom0l8159AFxcHKr2PaOZFO9/t/G?=
 =?us-ascii?Q?pIkf2EF81YLyecb4fw9BmZboUR1fQgO361t5lni/crkllwmhcjHInS3QwzGK?=
 =?us-ascii?Q?pZjcUqdXnz5HNEClZQs2uFJLrah/z5i8mnCypzZgRXIbKAebNFRwm4Rc+WJo?=
 =?us-ascii?Q?ioJryasxBN8Zz/VdZwueQZQq/SnyrXaTmdRX9a3tHjenqIaKcxlNp54VZNuk?=
 =?us-ascii?Q?RyaP1ok/csRaDZ8jNitzOFhil6yvzP9/jeaBMZ1Fo+hvhJYXtWa0xMu+4XNa?=
 =?us-ascii?Q?/ishIVtmmwjkusW/EfUPZg/wR0tgY7xdi5oe1ypb8rGj+D90GXLfHqnWDwpI?=
 =?us-ascii?Q?El/rLjuuOx5oz+n7KJb2hUUJPYEeEOGWrvAHVpEhNpYHJNSMge62cDiuHG0k?=
 =?us-ascii?Q?6ONB+tqTTn+3mdIOkMndCwXPxwNzYLjfr2WmGDavCdQLzJd1ZHoV0RjIUiXq?=
 =?us-ascii?Q?32uCoQ2u0l8ihQVHYk+UCaoG74lUkGIngkAdBa6ffQ0tT6hqkRT9RIfZwBJV?=
 =?us-ascii?Q?vFcjQnJFXOt+Ea+W88PL1RXmc0r+kk0GDLDpIKicmzhRt7Zdi3g5/hSljwEW?=
 =?us-ascii?Q?ESc1q3rgLDo5fAe0Odo88wF0xHq3VHelJnLBtjceuqfwAB8AW41e9x3RuLun?=
 =?us-ascii?Q?BwpHQe2NrKMXz8l+nnnyM8i7TgNfjfOL0ImxdePsqVC9mhGJqHJ9WmX8WH00?=
 =?us-ascii?Q?+3nFjdM4hxXiBlDV0YsRGEw4W9fVMbTmImVT1I3V4oO3uIAU+bhLGW57hxPm?=
 =?us-ascii?Q?HGTjQh+mnMYrKonxwGCgRvkXjPieERjAAU/44+pB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea5c8c1-63f0-4c92-d073-08dbb6a981ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:38:54.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyP2uOllcw/Uypj6DrWcsrZHJH9cFLlDOBBu2IYF20H2i9MkJmQsUp/aUQcd5uDO0JNtnJAiQ0KFkrePcG041Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

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

