Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29013C084
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="k7ynx+Xl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L12fWq9r4a1Ox45P4VzypR4XHwfXe14s2PvnxVP0Cv+t7linMrhiNEd2MlPle+YvBjvCGiwbZNWJu6hpP4RQEQDM2t/RqZyZLLc2YXWAGFxUMp6ZFJcHfU7CN7GbzfS+k+6macpxMqI2T6cd77RjbA6XTlGtKBO8Ip/WKwCTuomWy/2gQOWKwKvayjlzCj9a7IdDDkc5eLCDqIk7+5u026m0ucWFUGKESGecuqnOJUQV8cRjnzg2LzGXFbplNI8wq68Ijg710WR5iSX2gGJSWRnnm+vheB/7tZxa3bHP2prKWLZaSs3jd4yv2jq8tUM3sYIc81QzEu9bnoK6tD/Tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR76IQ1dXbU9YiWy2FB6TwbaXjBjpBAZfYIDvebz13Q=;
 b=a1BtS2PFMumJM763842KQCbkSW9UHErsUloZ/G2okdCO3oaIGiqiWjgD6jf3nBVmZf/TGwlIDMw+qvYEgzJHUW4FiwOVkmpD1HqFLSOn1F0jvLytTO54+xhVBjJx8ajWVhwELEkpSwK2frQaJZdLeNem+G3BH6/VzMhDHmUa5d7o2t7J2KelS4SBGrbvGhnSoym5pJeegDN7iYzDyU5S23CkwQKWpkV8sRW1nOrnj+e02aO99DV3idQ7CcuKnpXhvR744H0nNSGw6s4KfFgTKdnaNFFJg4qQMQAYk7Sg9L6RQz84T/KdVdkiVax0u/SlTFrqtigVQN/CU+ZJ1koyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR76IQ1dXbU9YiWy2FB6TwbaXjBjpBAZfYIDvebz13Q=;
 b=k7ynx+XlA/y2a5D/HuAMBe9bFSEiYJnn/IhnX/L2QjoZZh0GTPcb4/5A+GgwA/R8Qea3+LrOoBLd4gK/pijEVyaEh9Wm37gvMoXt/9q0GQ3dSvgBvlm8NW3RpaZTe4xhMSjtLz3HJz5b8XRoIdjs6VukiBZLq1PqKeed5Z1gXp71Ifoi5Dza7tWsmOgrh7QSvPEYaFe56zPVUkTmWNRJHWhuAzpGTIr7WGoxH5LcCPHbg23CedrnTqS3y1MMwm3UogXGV742jA2UGXrMgJBPTwvFV50B3n7czvDfeXAVW4ibGdOAVRGgG6TTCePAI65yQ1MXZnrQ5oMfSaIH4syByg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:55:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 15/28] selftests: mptcp: dump after creating id 0 subflow
Date: Tue, 21 Nov 2023 17:52:38 +0800
Message-Id: <123f0f31fe8a5bce793f8b893fd34d47884b1ab0.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 17291f36-9fab-4332-b78c-08dbea77f18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Mc81kg9rp5qCpHk+ArIXcr/Xro0x19zpEHNBjqP+WuycMrDhGpeRA0ppY+ENOKuy5UalfUOfR6U5fnHbg0a6fZEWsDKWtuAMIoGQlf4MLH/EO6NgCdrYnjvcFEBPXlH00WRESQ7WNpNR14OlM6d2r8ZooAh94p8YonLYBMdb3CC7oYVVPAf5ltm2ZUNuJRJfZoGxksF5L+izXHS5wVC3TktwuZH2+OWXDyGhzO9HMuAumxGk7pTnR2lMa2r/SY00UI87qoTixFQtGhuFPvQofdPYWjAPPMoUq6URzUI9oMxmRQsgjLbZ8oVRkJZAhGzYWEBlt5Wu9xMBA5W44n2Oj3HDRLO9CyX9XeOZJKzZzQiqQc5N4RfRvZzNm/XHXp+IXcAg6k1G2OepJp76JAY9YpSmtIGcNVFxqWTMR52qC5s8cGsTv7489umbJC9xy+Zo0ZPUhQHZAki8IpUqL60660ur4s17dkICdXP8qBEUq8ZJn5Pgu4wgJhRjXKhWX/34QYQ8+m0GXd/WToBJ2gsuYxXaYcKo3lm3MRJD7Lio3BK32vuHonMTyubRx7DdIBR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(86362001)(2906002)(44832011)(4744005)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rZh4Ncf0DvlBtabYB3lOe3/oBQ7/hkp48vYt3iDoXiejkDCX41NmtLp2TitW?=
 =?us-ascii?Q?qj8F+7pV47hA4ncwDSXd48I+gH+nbk6xe1BGdtJMwIxR4shdC0Frq7IwZmqR?=
 =?us-ascii?Q?6a5LqsrLhyFS6uign0CEiLoM1daNl34SoXTs+C4WnRcN3McKSVvGxbyf0oWH?=
 =?us-ascii?Q?Q71oTqu5BuyJ3/LdLjHBpoZA6TuPrkN4Bm2M2NAMHvanWu5Pf3cZ85lRZl2h?=
 =?us-ascii?Q?j8BZFW8O0UBNpyW6pf86gLcZalQUuHmyB/SMZc3oeuxrMJND8+pJ0gRJcVVp?=
 =?us-ascii?Q?BzGAWZG9aYcelUGq+gZ+4HbV5BZ5+SY3gGNZTjrjr6KSdwN2t8WrNXJb3pLa?=
 =?us-ascii?Q?UY4+qyMEn8AS84VU1r26h8Dom7Rd4F6cgUYoIjQXmmQG5mOhQzQjn41D/A5P?=
 =?us-ascii?Q?PtvsfCh80OHptm/YbUCeEBV4bKRCakG7giL9rhkeUsD74l06l7/05ihEgB21?=
 =?us-ascii?Q?x6RO+xfs/5c6Jw+dR04mgIVwp/Ht3SmcvOLEn9sLOwnRuERcUVyn5lvIKXX8?=
 =?us-ascii?Q?bsKenOoZo4Cgq7JxL+9x7Wb5GmqDhI5JOI/RFhLvhErVlQncZyWPC285M7w2?=
 =?us-ascii?Q?uC5yeoR6TO7Vp8XxRN0ULn0uS4rStS/ZuCQNhp7KtQt4+xdA2WclDHHKj3Pp?=
 =?us-ascii?Q?FJQtsvCnDhJu+ubiOUnpANK7aGc8ygqMmpCFTAAUtZQkWxFxWss9Z0TZvLdd?=
 =?us-ascii?Q?+0wDEmfK7CPwznmklhbwuficH9LBrddRWd/djRiFTp5HfinZVKO419pkVasY?=
 =?us-ascii?Q?34edAz60thrv0f8xspA1WYBD7dd4MHtjowgUHvV6fLE98I2C9A2XBO93H8Na?=
 =?us-ascii?Q?XkCKS3n79n77lcTj6/9NB2jz4Z2IT0RNaOD5aN0Z2bnUPKe7KrDlny9NWr/i?=
 =?us-ascii?Q?eQztWuxAe8WjmLU8ov8WOtla37EaievOt7kWDeuA4Jd7VwRkoJD7Q+t9SHpB?=
 =?us-ascii?Q?dIsOTOymHxZ1bhVFpwUsOz+6s3rjmM9u2OukTCNf765X7jYDy8ifskL2epeJ?=
 =?us-ascii?Q?KmuoQl8TsRfJVLdzekVYCIFkkzGBBbeLDBRIAG9wM6NLF/kbYEPkolw0eMwR?=
 =?us-ascii?Q?pmpY2nXCNRWWbq5ygLvJHVq6gblFVTQhhWJlwRjeXaJQ+KuXeL7NWsT8m2yV?=
 =?us-ascii?Q?gd0C9b6TAfKkbwDMiNX/sE36GDp/9v2MwvoeMe1hxpan+Qb4KwaGn3IUlaPq?=
 =?us-ascii?Q?RffMLj8xMKM4/WlO9gEw5+KNcazA80SCBfOBDK36tFxka46DuZ9Nb60p2iCF?=
 =?us-ascii?Q?fxD2ITIJocQ+3nPSbNHaU16/7rMUSI+bIe8oLOPYuHMT8rHfNKE80Wjys4dQ?=
 =?us-ascii?Q?T0KsWtANK+QVRIh5cdfBDNC1mKx1HbHp0vBMC9z85pThoz+Ca1hevUuRnTGH?=
 =?us-ascii?Q?Bpspn+nK/2KKwcSIIuh6UnpeeCujWXTJ8Q8ftURth60Gdagx5GtoerNULrt9?=
 =?us-ascii?Q?jZgezUQ4P3dx1U6hPFkGkll19Xm1Gco4zFC4HsWP01ACuYgQqaXNlgTHTDm7?=
 =?us-ascii?Q?KurXFhRQsK9awoOqgbBSf13E018iAy2RzcXFMeiVHo+4OYRPmI4IOwGBUQuK?=
 =?us-ascii?Q?HNAAy3mPSw64iHz3akHg7FxtDYEJA89dfdC3uW4a+qWCEwvzaqZJRnaWglsA?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17291f36-9fab-4332-b78c-08dbea77f18d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:08.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PmCdNNKcln0TFKiaOby8TvYcZxphULty7My8KBhRXepYkbv0jZeszaA9LT/i6VrjO7LzU7mCKVSVmORwhG10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

The output of dump command after creating a ID 0 subflow should be
empty. Since ID 0 address doesn't list by dump command. This patch
uses mptcp_lib_check() helper to check whether the output is empty
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index eae9f84423ee..a269448bb61a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3455,6 +3455,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

