Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7414F9D
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPPAUItR9J6QerPM1g/R9G5LGuK8DLJVKl1NQUhQuSKwwQwRoLjMKt8kJhg7FLkHqx/n8R4DZMAjZpiQGfM+9HiZJe1YQinurzKJqVWYSNwnKXw71ZdZaombm2s/8Qy5j6E93De3nRDq7alo5ORgzSAgyW0QNey6OrYlF9c8Jm2u6TlHWRocSjj9l0NGCuBlbocGYPJ2doyF8EiaYDsff8r8h/S+jM1FjJ+jHUrIIu6QIFuHNYyUUiicCDsHP92D2962/mK/+HJBZ1d94Pwr9IYUqIGikRBHiisUL9m+cnD8fQ3Z9m558PN8HKdlfjXJo9cxqp7TdoAbE7Otpuhe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb+QmPb2AwTKpmlBvuHg5wN/u6K6Eyv817LU2Oxu30o=;
 b=eRiZ8RlJ4jQ/o60iVQP2YRueCDV1zH5TXLJpscjwdOCwblmX7EVp1p1OemG37R8clX+CF/NZ+QnpuYjPTbFAopGDyMEP7z6r6XkZ4UmswSkB2+liwdii0/8vkCaogrSmK9LmDXStAYb43rjsSF8sf4GLjtB5rauWqgk+zStd0M/vgf7A3Vr29ozFDU7nrG2N+lYtYg0fDcDHlIoW7bEY27hF/M1Pf44H/ladMGh9RroAWjL1CSFZE3GvVaRw1bXEY1sPIPjYGeMe0NUWO1Ujq6zsKtY0sqU8lQ56ukCugM6WX0KOHGknoy+gTBIQ7LgGw/G8J5aCIBZKQYvZiCkfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb+QmPb2AwTKpmlBvuHg5wN/u6K6Eyv817LU2Oxu30o=;
 b=B4YM0iNZl2uZ4h2ncKws7QmVvS5jF9t8h4RajSPAB0Pqe8kOTbfMiB0qnJItOG4skfaGQ1NdSlDktgrATTfM1iIFKn+2539TyRTtHA5L2mp+J4msT9xAtFL8yEXuRqTBXmtUkGv27nS3eENuI3P0FgY9Zq+zsYgbceHYI8yA45CDB++0Jbl3OAmmC46JDafMu3AoKOY0Icm4hoLnhHU9vuk3/KZbuuiqOnalBKl9UFtXsjpaZdXFAxdWHGxmX2MpQ/PfNNBhQCiE8uRDQ2X9JP4/NJ/hhbd3lXHFUnkKv1DHkTVW6aN1SKHOFfFwA31adlLTFhsuqoiGQNOeN6neMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 07:58:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:58:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/5] add bpf_stale scheduler
Date: Fri, 18 Aug 2023 15:58:28 +0800
Message-Id: <cover.1692344463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ef804d-e262-4de8-6284-08db9fc0df58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PeHp3bWEW4LxfTH2EBu7AOPSQoNlrqq2fVRxkqyLYdxVC4PUwl+BYjlZUW0Grm9EXFfANEHdbkjfVgA4pz0VzKlQhC3yHhS2B5kwsLzewddVwVnMNL6IX1YPyB3lfNDrh+TE9OqyA1ZPrsG5MUTUQddt9hGnyr+mTO4WUycjaoAU5/lu2+tC5mShk3jh/NK3DFUZAQnH4iMXQuW9K0+fQUV+mJOYC0IlWQmE3ZIn8L0Df60pV3TkPP1Lh267HYsbiUsQjxQbOo83vsWr8q7LhQxlOreMXpG0qNVtONwTdDCJMFI8JhnhyO1mjuypb/viQnZnlik/B9A+6zz92SCTOiHPpb4fvA05yyZkx718O2G5q38aAZT9njO1Jke4epH3aBkGfki3oD6ydMAVsadajTew2wQCVHXyT3ZuZDF9qNQtMHuCUILdWRgUH7hUL0+s06k9jE9csnsDTB+2M7zMzoHAGp5r7Vs1pr0jBspxeZbsVDo37LVmUfyQi6+h9mSQeynrDXzxdqiXsYzVFVoIjoGcBpTN/MSyEu2SVoivHF/s3Ypnh5rxZ7M4VZMHFx9UHf5DgVyGrUFFFsE9Rn4IN2weiSlgbhyXUT4JPhKI8Ws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(966005)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1FoYD3uLcU+cInWpgPx6NFNlPV4wydTeBavTfNSmHzhE3lgQKml4Qi/lRNQ?=
 =?us-ascii?Q?Lmbt4Ve6n6uJ6GdAS19FUxOi8SptkT/Gbvv3SoHfDQXCqwHjojtMEtTsfqJr?=
 =?us-ascii?Q?pyAwQr3LHSCw0mlKGPwWVgvIHyDlQy+TDbp+qNA4gYWqzbErbotooFFmRtzI?=
 =?us-ascii?Q?dDucMvr2+5Iv0cpwzUcipqKjLlb/AV6oUoQh59L6W0MFS83Dv4cRImupdniz?=
 =?us-ascii?Q?B60YuoQp0mOZ2QLF9EFbhsmsVmm87iks4uHuJ6SXSGv1ZFliOW0DS8dArSoW?=
 =?us-ascii?Q?8l10MjHmVTsHY/nIOxUZLUbSqYDg/DSJw0lOlXMWwrf7QlP/EO+8KVf54SYD?=
 =?us-ascii?Q?owLENbW+b2AOD/ZmfCgOLMo1QV+hc4Q+Juaq/1ZRRgcRyCvHR8YuRPM2UEmL?=
 =?us-ascii?Q?QygmRTJsOu3GKAk5N7VT9zzOD5loZtaHIJTd4CD+3MehNGPPB/8gfSHdzcvP?=
 =?us-ascii?Q?9NzjsZ/aAfIv/53NUjMi1Blaa5smaAEY5sy5nvfqYT7RTc9s9zxnDjtm7Yez?=
 =?us-ascii?Q?f0tGt9jw7O4Tdg3KnZZ/ha0wjr/9ePfAY1NfcAEhdpcXi6AvAinDu7/4DULp?=
 =?us-ascii?Q?/GDuVmaNQqI+/DcrOVDkLdsZOgb+QZzq8XjTQqeY5Nu2WZuHXLXKd0LDY7Tj?=
 =?us-ascii?Q?6G2KcOA/LQgZTEtRjKy2BiC5y6EcedGpU/vznCVQKys7rTKEGviVJZ46dI1b?=
 =?us-ascii?Q?cdoZvjJvv5W/0vRdI0a3Kz6XpT1kv0rwxDiwdIlh8eKppvBFsS0TXUaTvLNm?=
 =?us-ascii?Q?WLKKDGIFkMEGWRILdFtbzlifT/2ianIfiKRg8xfvesoC3ImLnqoUaCRlOM0w?=
 =?us-ascii?Q?AJoLlST7lb0QvVZ+6EOAr8/znhVrT2Ho+nN/PfzU2aON/axjNJtLa+sr755G?=
 =?us-ascii?Q?CDhY62c3HugFB+CtI7kcqIxXJUYCtoFVyxFbWSC9rIt4Q9uR7Z2c5mczNd6v?=
 =?us-ascii?Q?ls0xo91jVpWHX2aLT+kunYitmHKbbnRTZYeN+6kSA4I1nEuOl7ye0mjofv4w?=
 =?us-ascii?Q?q2FcIlmDbJh42bKEqoJpqqWKrsiKW4D+TH+k4RFdsrRP8IEs4aeHpYAIAX58?=
 =?us-ascii?Q?pP6tRsCItsB2adPopCnxN509UGYvhwkZeUrJsNpfjiqY+f/OhY0FFM5hY0BC?=
 =?us-ascii?Q?1M5yTo1V4fdHSImfSmsI6ORGFvuMwlonZHJMdKSiD6Y5BbI07LDo0YNddNdh?=
 =?us-ascii?Q?5Yx/SUfVRbZBIBwPMqICHubKrCNHdymELaRG17qfMonDKCL5TDRdIp194iTO?=
 =?us-ascii?Q?fVeV59hk/kzOzAjOmBxY5pkLdn7E06rqt3o2uZUodv7VYaa27jT1klMrDge1?=
 =?us-ascii?Q?oSw4b6k1I9hBIfSPAryxdKNnOpyaQ/1r7GRsE22HNyNDkWT9D+qmcDm5LNqI?=
 =?us-ascii?Q?QjhF0OX8T5ov9VhFs+bLV2mz4nqh+EwdNtvSWL+bvSEdSQWkkX7Nj4GnsYH9?=
 =?us-ascii?Q?rfT97e0NCCYeE5KjGO6LaGTbfktzey1EbWC/4CkJ443h0jGyZylIiOKX6c39?=
 =?us-ascii?Q?7tkMXrjcnH12IDRMjPBUUZjX9VHssIICdz6QmHhzDb5G8oIq3p+o/CXb3Bah?=
 =?us-ascii?Q?kkPR+A/dJGAy12lnhKgAQmxFmEdFKSoxHix9Hi7e6PonJ6YgZhLg+UV35cWp?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ef804d-e262-4de8-6284-08db9fc0df58
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:58:13.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU7s0ybebmLWYk+WZG/xTMIM7lvXpbKVIS8n/+83+FpsgnXGB+rMuyConULnRgcxXDC8chDglCBgjAckQiqd0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

v3:
 - init sk_storage in .init, delete it in .release.
We invoke bpf_sk_storage_get() to get the sk_storage map many times. Only
the first call is the slow path (see bpf_local_storage_lookup in
kernel/bpf/bpf_local_storage.c), alloc the map and cache it. The
subsequent calls are all in fast path, the cache hits. So we should
first call bpf_sk_storage_get in .init, then call it many times in
.get_subflow.
 - if no subflow is scheduled, it should return '-1' to indicate an error.

v2:
 - store subflow ids instead of storing subflow pointers in sk_storage.

v1:
- This patchset adds the new bpf_stale scheduler. Use sk_storage to save
the stale map instead of using subflow->stale flag to manage it.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Geliang Tang (5):
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_burst scheduler"
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 +++++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   4 +-
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |   2 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   2 +
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 152 ++++++++++++++++++
 6 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

