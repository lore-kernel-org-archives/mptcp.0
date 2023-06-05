Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DD5684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLz71UVtdW/uztLqH3eAYo6LR9VbsxMH5HDbG4OG1PmTXGR1fLhnC7Rk3O0FrRYiK7J0Ix8EfzweZ1et02e5JPnKx2saLAK9xEIm8Ul1HHvj5M4pPjNskx5vD/AqeY4mIL/K9ZMLTgRf+Gg5rdu2JIsdiVKEj1YBVihAR/BuTIxLrL4UStRp8A6bS9Z9AOMEWGxhNzd1BdO+inCAErVY886tNnTxDIl7p2bPfFLFVt7pRlXTzCMcbrx0gs/8C65A96hrNCEy89TmjWTTHsg9GkayZbpmj4UFMtoJ/1M8HxYsPHMXH72r/fAK5IIPOpLEDexRN3z/hUI9z9oKBbg71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=mSmn9XMISRRfNCBEb5yk40bMk8+5G5MY7hhhMzb4vZsAHdz66miiDi3IFKjktPk9HkGKzlfGF1l0mybBHwlRf5sw5SzUf3ZuS/PbTY7neiFszGEfKvRkAHANcIOr5P66QfyrJnI3oyNO8w0pRvXd2VkLbRDm5h7y+eYCT/Zw380LwS/usaqjdg2Q3akYaQItZ9X2QdzoDDoVdSlsDRy+9FrB6dltlZQuJ6miZq4+EbXtOA7LY8KTDEDQcwfziReDX5Yo0qFGkFhxq3BwE+n9AVp5lVuqF7M40+AwZCcjf4FZdVpF6QJoQkj5FvQ3OsLj7+x8WYbIVd/7lDOlYUMVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=ZlenDR54S3YPYo1VxMbAEQUHIzN1bYsF/WBsxOukGG+xQwy17rgJTNo5YsXqnOkqkW8q8BUSBUJDqsigefW5i/QhyBZuOcDXIJWcKZXBcUzS7UtyQd4JuOj/Jo9ps3EADnJernEjNRFBwA5cg1AismlzefNwkX3G2ez66TLDAkiDiJJIxkhqo6QzoOgtPjDXfevBKJhvcEoqLGuOmRTErMrwwU9xe/gnox0Ufvelct6C0+SlIntu8RPxW6gCBN44XnQ+tyN+fT7hm3CszhuKPelF4BTOCsAP6M+q/WZYbyfz4phR9CMMDV47z6ZU9XVj1pAQwQzDAY8L6D65N3UfwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:05:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:05:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 11/14] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Mon,  5 Jun 2023 18:04:06 +0800
Message-Id: <0e001024a38f9f2999fec9588a15786d19cd5f4f.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: c5803318-7c17-432f-d513-08db65ac71ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z9ARkhxcJzTGKFucJjQkY2BW8G0/PPL/LgOVeWgCn+XNrOcwqSv4vGraczJcvigBGu597KLGLDWEFZomnu8fkSIgY3PdrkFOIriqqefGVxXRm/k+5o750nsvofUGWf24Gfug88FztSksCNNkl+xFX0oDDtohzmofvyhcjWp1c45CY+CN0EG8zDOumoX82k/KUux+W9XlDrqwFOQ0XjMYZAHmAqdThrhWUlKFtgF7OE7i1GMVM0EYqQZa82JbYBz/dic3vOsEzlaTOiPnd12FwRZIxZs2SeApybSbUA+fLTo4YwDCajvopRfkl/MNety3SYx1wRm+KcGOVAAeUeo6Ve77a9mLPvPKcEAPnHbU+/OwAFIingNs42lH3BUl+DavI4KmFyClEWx4KaPowmS5nea2VQkXIZw/APZkBSuX4/PAiw6PSD2crJfsKvdCrZ0uT3pQeMPGRDCim60SVaO7WqTvmLUAjEWbu7gkx8FD3MEYUmDR7XVBlDt9YAY1BVX2ha0ivXQINyr1IhCz6iFl7QPs2clbhG21kU/1AKHtVazubYEdq51NmO/8kowqHIo2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(4744005)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?guqFUAOsXu0d1uW1REoTnirnIIdkD6KbnPHqer/pfVMM9hRG7DKw//mSi7CI?=
 =?us-ascii?Q?Ms/toI5GbGnCKRl/B7hgz6HMs7cmkFGkkS2IX6tSsxrD5SqS5dpZApQ6338p?=
 =?us-ascii?Q?nJv8jcR/OWOzAG2T0bHvN+Q/FNrH4BInBTIqFmBXDo9uuFM5H4/rL/2PUWWx?=
 =?us-ascii?Q?+U5TGmaeueRxUEgOmsvIY/X+cukVJ91AS8T1y2HZ7VdjkFsvHUfSjGMGgsGR?=
 =?us-ascii?Q?EmjKCDXfXO9io3c2mKOPe9hpp6hY7SSUDjn9EUw2hBht6hG1WrtUTU2385q/?=
 =?us-ascii?Q?uvWkzZKqWIC4Ckah8HFJzzYj99Uc4gmiZxsjV4BPevb2UcXUbTuwkSfVH4ZT?=
 =?us-ascii?Q?mF6awZImfKUp3CRtyFqsUhJLi8XZE0wsS0Yhf4NCmRRy5XNUm4VLoG5MLArB?=
 =?us-ascii?Q?kb27jQRqYU2qUbEo2hm+iVEZAqd6gBYblphAiDu7PpRJp3UIZYnzZDLePjGJ?=
 =?us-ascii?Q?k0Hq9f1lySr38VoN3KKpgJfuDlDz5J4ojqdrN5pM9pp+kMryiZpSHvKoH8BL?=
 =?us-ascii?Q?Orygo9b5a6Z0qXAmV0UZasGUbxWN+t5X0IUvxWgHGTdIj0+y70UJScHgcVTR?=
 =?us-ascii?Q?c/cgunLMwYhXmkUNdfyzJHk89twXYR9esk6jaAHRGkQ3doSkf0UI+wz7FY3z?=
 =?us-ascii?Q?GxT1UhNpyVuhjEq5ADDgF2A2yZj/HAGJ2PdwomOxDSpij26jwhS1jr8bwuic?=
 =?us-ascii?Q?q2F0rWRsKHR9sAGOheI4u6HTb2Fkb7m1gdlE+KeP9fvs3YOjttMzwKRWDoii?=
 =?us-ascii?Q?qXjJ17MCvybFOy3BnVIxtBBVF9JbhrYFxkLaqwNihPLCEeYR3Z0F+2cie9u1?=
 =?us-ascii?Q?ojltkHI0d4vhUkDbHD07p9AOl2ntVKByEq+82HhJl3kFQPK74tlAWRH7cPAt?=
 =?us-ascii?Q?dwZZK9cTQWpRHQrg2ebT/WsYUxD7sqnbrRR5+mS4H3IjeuffxO700Aj36dJu?=
 =?us-ascii?Q?F7HDn1R4PUcJzJEmpGOJUFGWkCxVq3arsvXPoQvxbzCuloSFIaR14LYWb1Dz?=
 =?us-ascii?Q?NAbnB0lectpiNr/MWL/NC4LBUPFBtweuI0siDYwh6VoEQaTZCI21IyT0buaG?=
 =?us-ascii?Q?LuuVhtUEJYISZ1cs1A3n9QA/G2o5C9i4Z/pSm9k6PkvN1GWVJjwTzGHsPBtw?=
 =?us-ascii?Q?CI2lqWM6Ft+H8snEZjFke7A6kQbybcGIv0tOliOJ5cZWXnwutinbRBv2PsDU?=
 =?us-ascii?Q?1qTyX1OhBJXwGXcVPORTN3FibU7GRXO4EDInkS3mbsWMyqXB0jJbkqD7wLOc?=
 =?us-ascii?Q?wzICG+dZi1p4bQYu5NvN+pv1mHp1Rh8Tcd9PkwURn3QagJKOxqFuvNhIoGt7?=
 =?us-ascii?Q?Bli9eg2IjL/W3ITJCuf7j4HdEhz2KbNRDojrRis1cqqfJxxvSTfEYF7snxJn?=
 =?us-ascii?Q?pJuw8wh6LuFjW0KZtg+PMjKNwTsUgtV3oBSZsA7yntPhLedMiJWxU/LcS1x6?=
 =?us-ascii?Q?yzB4QkJV1eEJPC7fwaiJs2d5eKDj8mX/LbjXs1cTEHsgYmW0ZCycfhtSyiGQ?=
 =?us-ascii?Q?7qZXyG0XCwNdLrn8rsbcwfLc3lqcH8gVHD4n0GtmNubye2UiO7wLpZf6w409?=
 =?us-ascii?Q?985d3Ql2CEfTFd3p+HO4DSui46EA3GcGu5/g4chZfiEaq1gWkUaIn5/P5QVq?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5803318-7c17-432f-d513-08db65ac71ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:05:52.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y0F4TwRLlmPQhPP+yJo3CqnhWBh3UG+nngOaxFdc+Oqqvnr52Y8XLnh48WkJCnWwn88XpORvjeB02y3ygrSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

Use two tabs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..fcb023a749ad 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,7 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
-- 
2.35.3

