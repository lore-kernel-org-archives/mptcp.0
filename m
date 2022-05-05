Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125036D
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 04:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651724357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=11WFGDLGJ9drhofW7b5w4LVKBB7tcwwIY9jamMekvaw=;
	b=RZXQfORNparPDwUxEaudw/c3Sc6IiGkY18oWcSYD6J9ee0Q728+Qpw7VOMThTR8AqDOTsW
	h2qhMHYmck2oaiK3k8ZekIENGol7uAAPlGv+8Eu7kP4jF3ovCd6CgfRrj7bi3nOExZIDck
	ghK3KB6LXacA4bBWl5I1iL/5wV6BQhk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-76rjPWuhOAqyIrB5r1PCyA-1; Thu, 05 May 2022 06:19:16 +0200
X-MC-Unique: 76rjPWuhOAqyIrB5r1PCyA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoqlQoFjjxKRuzaCphI1wLanTV3dJTRKWkB+XFVcGbR7+MaNlQ8qnmATuysmLXX5OuWbC2Iicl9n0fypVR66poNt6Aa5+y4qtRWvJ5+SMaeoCzRzNVH0k5kaWeNHFEpRG3Oevrkmmf5qcMmnryuU91RCeN7DgXS3udLb2ZDnc+acOmlSU6/ofDC7Nuyrg+cxcYYS7kqI+tLj+Hgc2GZBh6AsSpc+dsZlL6v+frPW7NrcNNE3Keq8AEnRC8fDmNr/rVeIXNhh3xDe9gncDN5KFBqZ1n6W9zmWHQQLrXpL/mjxPpSdtBXuI3BA5Z1vPVkGAJMDNcDrsxWM8E7r0bKdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD38Z2ghS7PRA1RJ2Ag3mWfEiT6WqVNknsssmrx/2wQ=;
 b=ll8rf1IuHbcVOT5vPp96IEdIiq+uzqGcrI9u7fSiVCAhDT5V7MAUZxf/sVZ47eReDznQYsy5SnsSAR2xG4yYQU1A9vjzXSM/7s//Z7ssN3MI4I1uESOlnqF2yvK2ZzFXVRaWVdHgSZ8i57fb5vB9YkxGT7p37MC5L2q/jTOitHVkJW+tMnTzw9vKphAReDUQKfcEc8mab9n8k0v2Xy29miV3nJLZzCMat0aI8a2LrvUvsHO+aAPSZ0FQXJS6AN9eBrmExsHfZw4np2IUP8YHzIi84x+NkfyJlB/bmx3PbYOofymH0keHX+265lkM4nYbc9wKbKKctWE0wYIbsij+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 04:19:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 04:19:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add MP_FAIL reset testcase" - cleanups
Date: Thu,  5 May 2022 12:19:03 +0800
Message-ID: <5f8677f1bf662a25beea0504c7981ab2e4c5531e.1651724227.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77dfc8b6-bb31-40b3-1848-08da2e4e691a
X-MS-TrafficTypeDiagnostic: VE1PR04MB7248:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7248066299F79F5BFB43F105F8C29@VE1PR04MB7248.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n+1Jo/27CgHkD4FgMxaY++l1OnrTWm50rsyS2cWc/enm4nG6e+PcOAKHYHBesOof8BEXtygB9A7d9mq5iXY4z7mWIz1JLyLWG5KhPIstcFvGtb3/5QSuynLatyp3vluPh2IlvTq/5CCJX6mfiDpJnqCl/xvJAkVdQ+ESaMSIhi4gUU70dw9MvIfkYGejs58fQnnRVJ5ENSy4L6RSRtVtNGbU5h1oROkFbdYMJjsvXy9wbBDnSn2I0uvCcpI1aiF/o8ohN3T9PHU/NzB7xF2bJCz1errKvp+2DZ86dWdgDwmA6+7+63kIMp73G+zWsCc/ynrtuEWNQ///1D9rIVjTa9bLE/3yWo+4vZItgBnA/Nmgs7Ga6LEifjstTMXDazIDvOrg2Zcs3O0iyVY0P2cKD2p0/hP/tNjp7mDpb17qA2Tgv2Uozdo1rOXMAeipqikNePXaipN3AIL2MsxZ2MkzJwx+gRQBX89jBFieQH++H0uxGD1niqOiKobQ91Fa7HzldY2Ck95wrWhfpdQhAE/yPQwpV2OUcGIRxmdGaQ/WNa1axBJp1quDsd8HJ/HGSbI4Xx3i2VgJjt6E9VDL5ma+U4mGon/SaDpLjxw1loO/5Snr1ho4vDKZ6Uzgsea99oxYHgeENsG/xkbatjeiHGoY5gJBSmet4otdIGcqge2BBt/2R7sDpmOMIoFL74bpY+ik
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(6486002)(316002)(66946007)(5660300002)(36756003)(2906002)(4744005)(66556008)(8936002)(66476007)(4326008)(8676002)(508600001)(2616005)(107886003)(186003)(44832011)(86362001)(83380400001)(26005)(6666004)(6506007)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzZjX7u1dRPlXAAS9gwGcTgQUBNyPKhxIiUAQ5PkzMhgGF1uxH1vo2QYe7YL?=
 =?us-ascii?Q?WL/mKyfDrXS1Tlvy3r5tz6S2yZwE9NLymLsisvyH5KVhWW9dmC+RgbhvBxW5?=
 =?us-ascii?Q?eW4goLdlByRzA8+cGHJd48LQjyqqbuYQZTvVcMjH4OZOftnnN40w+asPISBD?=
 =?us-ascii?Q?9vya7z3njFSixjyIAmgd9GAz65D5y80sxvVn3EkoaQsykXlYb9q76OyTH2+R?=
 =?us-ascii?Q?JhoRauWTMityK/gPNzOkBDQpWllYCyWd5TPr6fi3MzijIdIP3qSeEyHVPFd8?=
 =?us-ascii?Q?tBlHo7pwZ0zKvPFslyMAnt458gEf/WgEJprksZa0nNykImZqQCekBuIUPEfP?=
 =?us-ascii?Q?MIwI69ATTcG+qVT6HdOssaZsKmOT5Mi8KDHy5RCUq4cYEjP8YD1ih/nsiYsb?=
 =?us-ascii?Q?QBoq83NN58LY1kbupQ8tO3xmfqaOZbKHszXD7GkzXWjY8iscU0pJ/8GOdrgK?=
 =?us-ascii?Q?M0S3uIN83ZjXLN7lw/hTtoeYHsIxkYAMKVF0uFdnuyUmlET9AK6pJPwPXuC+?=
 =?us-ascii?Q?xQaYU9pozLesqLveNaozw9wMhVD/Zg5TS736kqR+GJcXbvNOv3aD5Wr7Rpfy?=
 =?us-ascii?Q?IGx8WOqClt9s3mLo0V2qD3Z3dH9Krqkf6GV7W2m7Sd24bwKs9KKg8hszIjBw?=
 =?us-ascii?Q?LiKCHw0ZU7L/lzEAzTZqT6wdXyUvRCyql0/NTAiNJ9ELHY0SCr0ROkkVTsMs?=
 =?us-ascii?Q?AIJR+hBJPKWueqLUxJ11PEr4DerUYzJBc8jL237EIEUpny1m7woJqMWkCb2A?=
 =?us-ascii?Q?gGnkbkFhIpTnWJSOqY1YUn92hwq0gnyMtWWULqWjybKAwcKCSFV6Lf8dYlw2?=
 =?us-ascii?Q?gNx8ZFvlXrZ1CxDjHOX9OMGlZzu1CKYbTWd1CzF4P3f6RkffBU/TJLWQ+QFv?=
 =?us-ascii?Q?tFYxTWY9cShFcSzpyx+f/P1fwe1qLWrWL2ryyv86+vsxx9q1U/1mZMnVxgy8?=
 =?us-ascii?Q?dgcNSatb3O7mk+sEIMvNEU2elMB78Hkm5/+WiGvOZzEYI2PQmuWeIxc55knd?=
 =?us-ascii?Q?a7dxLgnr3M0EGGxNivyYDow8gRGQB6s55ayfwCMNRdbHKWVKjY8ay9JZEzKf?=
 =?us-ascii?Q?UCTHXVGjtHMW5y6cC9z3d70kjt5iwprHkqoWZr584rEO3uD2aFoTv/1Qh6zw?=
 =?us-ascii?Q?ngpUC50dyQ4DqrFBKGAQj8FMFqb4u6ufMFFyB1xP7AkWrzIy3eq5RkFatg1g?=
 =?us-ascii?Q?neAbbRtkc54SsN41hJG3Bn1dxhRc5WvE0REyg/QpPgA7qrSHTrg3tdV8+he4?=
 =?us-ascii?Q?n2ScKLHN+pUJYvCZMfc035QL4rneOyZuRA5391uD27vXPu8pjNPDSJ12opxJ?=
 =?us-ascii?Q?ITwcqe7t35mLlWRAvXSZzhy7K66onKr7pi7mMc537oKFQB2QSZIakSsxTmWT?=
 =?us-ascii?Q?GUiZuUPHXvW+CZlRWOIDKRPfAV3Z+xe+9SVgoAlpyQ6vL+mDlRo/5XDUTnfZ?=
 =?us-ascii?Q?dNPi9y4ET0NikO+RiKOp8h5JcQgRNbMIwRjUgbuw/a7EG2tH1OPrrCS8LjmG?=
 =?us-ascii?Q?Zz49ObWnfhHauXmup/kudMHajbLkPHudH6vSE4zQu942SXS+eAFc2qFFGhXb?=
 =?us-ascii?Q?vuMTJ5QdZaRHrYtgQnMo8squlDn3azQLkaHRcKL9bPAw+efU2xUyJcki3zP9?=
 =?us-ascii?Q?mtTP6fCzZTqlZuvqtgLzI0twiHXLj/vMTPeEX8R/DaNUELOsoGIF8TosRqde?=
 =?us-ascii?Q?HtZ4jvWaK/lApF7bQCwgwe3LnLr2NHL+uJtIbsqlPKZ/YepeOrRuu5YP0NX7?=
 =?us-ascii?Q?CHnW3/f5jPgo1fYBro3AdmVb9M///3k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dfc8b6-bb31-40b3-1848-08da2e4e691a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 04:19:13.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdSHLae2aZpTj/HL+gyGX+UGhQ5dldHOMjfIctom4CastHYNOahNk4KI2eRjGIYn22L/oJaxpcIoi3rKQIDURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
extra checksum failures now, no need to add '+'s anymore.

[1]
net/sched: act_pedit: really ensure the skb is writable

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - keep test file sizes unchanged.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index a5e90532eaea..1a41f9ba00c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2740,7 +2740,7 @@ fail_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 1024
-		chk_join_nr 1 1 1 +1 +0 1 1 0 "$(pedit_action_pkts)"
+		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
 	fi
 }
=20
--=20
2.34.1

