Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5168
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638430233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaXi2OH0054c64TSaYlzTic/kCIS5r2iKNLwJHBXEOs=;
	b=laADjKc6HzzGSuhW9kqggSzNWaD/u8a3RHXzYfQgxShmRACminCwiFDbSiG5N8Z49yhmKt
	ftqluBme4VCiSOX2hDbWw6F0P8Ria0UIgvtAfzRvC3b7d8ttlPuLBcGUSw+nP2VQ2mbSjn
	SWEnjtigGDtCJVv4EMPstetWV1d9NVc=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-1cM_wLHiOiWi3ojIytqO2Q-1; Thu, 02 Dec 2021 08:30:32 +0100
X-MC-Unique: 1cM_wLHiOiWi3ojIytqO2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azEZnaCU0Pbv3IL+TKzdg7lrCCFArMQIW7ah7tbXfeme1PUQtx9oZrPbPA3fqS90E6+3OvEsc26dK3R6sQwCAA8bomXJqQTigJZssViLo01xQw9r0aG/jxbiOwXEGEfjBZr2sYCxM95ptLWiH5FBFafVMBwXUtbkSzrYHFRco8udjXlmj7LwQAS1VZ4Br2O6qCpAUG2f1Bokae6QxrDgF11agNqRQV4ZBjYNe1cYeEs5OCl8qBoH7RCn0FY76UlSQEOz7tvpvw7hurlWj5JBzl5uSOZ8WkVxoc2KvstqGcgWILz4VbS9xxMpKA5w15cYTz9mCq9YoNUWxE00qCNXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtiqzO5llNNLYlJBDY87dJSc/1mPgaAWGbi+GHX0c4Q=;
 b=S9c3ABn0bUiMM5qhzYoCngUi0oCh5Od4ZaTV5p9Iu5GIznR2kCzo9TXPdSumga+86E3CxKRZvWctRAw12D26mRGx+hIEHYqCu9rheKfULWyQMd5dQkNTj5scnwU0Qnw4FiY//67S++hAncm56ol34JuC2li65XIYcfrhVdI6i3YX+79mR14gEZVNq71jqRPA1WdPY1wsLDSNe1CX+m0cSP5883CFSCvkIDltz6Iqgt0klIQJikQ4AG5LGS3RF9O4PjyeBJRjB8Y9BFLHb3v+vCwYQuXtuPbhA67MsmB5zMYIY6zl0DZY2w5DicbdzqQy535LiRK9+iCfs6il2tJvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2555.eurprd04.prod.outlook.com (2603:10a6:3:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 07:30:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 07:30:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/2] mptcp: print out reset infos of MP_RST
Date: Thu,  2 Dec 2021 15:30:00 +0800
Message-ID: <2bf7defa730b4fc577b9f4893083ca394a6da094.1638429740.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638429740.git.geliang.tang@suse.com>
References: <cover.1638429740.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0221.apcprd02.prod.outlook.com (2603:1096:201:20::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Thu, 2 Dec 2021 07:30:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f818413e-5a54-4344-601c-08d9b5659dc0
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2555:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2555DE06F19C5CBC797BD6FEF8699@HE1PR0401MB2555.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v8RVcm9pXfVUKPyjAMmJTh88YPgRrE+ES2gsK+390XeZWa/ZYRaftGQviV0VRGhzUHG2VFayKRXfvEIYOTXqXGzaAr/xpaWvN1yIgw5d+5r85I0PmWIp18zRaQAzSjHrww2wEV3+CRpSTEWlnDEEacuC5aGquT4RsJPO20sqXTfE8xqw8yTUnzEqPVzDP2MXqXeOzrVH+hrxisCOkT13jJPpu3A8sPG1EbtnciNo9FqgzNOxfmTnmMj3E2Ch0XVTDB5T94MTNIAsc3JJAnPpS6KHw1GneCpM+8F9Ps2YE1Dse7J/wR1lGbfKF+RZD+ael55VMHtj2Pst3SoECrI6meeWyhRhDUP8Sb864idtDOkadEER1pJofeW9eUTliulb5jr+dgS8RUEO54/7ePVoptVydTDd3c7zHo13xExJMViiK47oosYc1rnV1EkV+75IkB41r3LfNQ8JHZ0m7oSuezAWQCTJBtOpt1Y18GFqR/gGT54305P6oeI1K4dj89m8ddvhsoJNCLEbLHSk8sp8i7t05Qx46rWIyPa++o4HXhmO+tfni4Tzxvsb3iQZCccTOiLTDpV3TJvN7rAEZu6Mhe1QAhZ/JFTbM3ljLnveUz5Ouxt1L0pFN0juypbCSsEJYTphMHEyNPLExEbK1MK9FQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(8676002)(4744005)(66556008)(6666004)(2906002)(86362001)(956004)(66946007)(66476007)(44832011)(107886003)(2616005)(4326008)(55236004)(6496006)(6916009)(38100700002)(8936002)(26005)(36756003)(6486002)(5660300002)(186003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xnQ8RdQWTG5tGdLQ6hWRrSSujbO873u+jXnQnFD9JUSsUXbGKeTCmMDl4YGZ?=
 =?us-ascii?Q?pwaNITF53TA7/2h2Z17YLvtAaRwdyS5LzFZXWOeXEOJE4cFQLTd5Wt9UsOQH?=
 =?us-ascii?Q?eNRwacdaXUyFbDMqIelnQobCsu5ODmQg37elz+Ult1lEQp5ZNwDqUt9do2rE?=
 =?us-ascii?Q?cs2XR3gxwRYxUKy9fkEeDyXDsTPIGFwe11q8Fu3HBaxubGLmexzpSCYZeR40?=
 =?us-ascii?Q?CDC+/UPNvvs5Um5n7AKkGDeJAMprSsOESsbciAXqkp8MRXGGVB55/kkoMN72?=
 =?us-ascii?Q?ELk6lJE3fidihdpxU86LSiAl6OQwReqg+1ERXGDiwq1yBP73zhfQdBHSTMf3?=
 =?us-ascii?Q?H7b+iCeghbsIOh37RiMxwzVQumIP1xUlXjVsDseFvaxhwrVnPnI5NIViNt9j?=
 =?us-ascii?Q?BpG3ivCOlzWN/A96rNFvUn4DHVSNsjg3fKv2ekRwCdDvzzW7B2phpYxdon1g?=
 =?us-ascii?Q?IaM+juH6BNuEiNqVyQfSgJX6amt6VfWQ4xhUKAnH84nuzbPzMSynavWfqciB?=
 =?us-ascii?Q?ri3LBAG46LwPqVt1hrtN8BrNF4Apwoowv0BPzDpgzc+JUn5m8VSA9vfojjVB?=
 =?us-ascii?Q?lq9fs19ZjC2eIS8812zWVOZtzHM2i85O6+WnXj7b710TPC+bi0IOUwxMYcjk?=
 =?us-ascii?Q?7tQLyV5MJQkMR7wtw/wFyf5gTi5IgnTFX4HaAdyp5qn0Un+B2m1gFVrEHd19?=
 =?us-ascii?Q?Yf4n8c5JwbDFPQ/mLYuhqsU/IkoZtjTEaLB+GhrCRioLRC5qEI5FUgIM7ktx?=
 =?us-ascii?Q?zZwkzl0RSh0ImtDjYnqMlhmYVs49b4NBjAWCoBsXd2IzmG+lILzq4pUAPvB0?=
 =?us-ascii?Q?1r9gXvzs4Q01g6UY/CqlbFruD312OBZVykqs/8/xFrjp1k5XuoBe+JTtbuFJ?=
 =?us-ascii?Q?t4OwbcRKtWi36xZ52g8Jzj4jIYm3RebF2SdOpZZaIINkmxm1G85XmzHSgsF1?=
 =?us-ascii?Q?kzg30zi1oZHsl4WYu+BdyqWNkHubaqPPJlPOvkMSmPHvFBjBYcW7OgQYVrQk?=
 =?us-ascii?Q?mFeWVXPib/WukjH0IHHUWtV8dgs7JUZtVv4cSCLl7udFjPTcz7nwEiUT/KK/?=
 =?us-ascii?Q?oC13c2HoBjBgRTU6JRHx+wReAcjFJgp3WnbUxrYcOotFA2XZhQDIBod8xxJB?=
 =?us-ascii?Q?SnuPjOSMfHOCOdkOTIZ02FCMdEqisUUjxn7mrHqxjasbskk5TZ+2cj+daS3j?=
 =?us-ascii?Q?CSbqaIksaOOHiK3+tr3qwH6AduHI9uVdovoz/HE3chPJlJYOKcVvsfkqP7iQ?=
 =?us-ascii?Q?5PJJqYTUjSRI/Oq4enepnzhybF8GuthUAjUdYAC6p5t4WrqJQZv33wftXqHC?=
 =?us-ascii?Q?H6jdvffqW9oiKFruMtghep9RGid6uXVi6160pyaNkiU9GuyQGObb1yist0ZA?=
 =?us-ascii?Q?cur/i/7D/I0hMad03v9fPwD57IDn4i3LmPFyXqD+4kkYz3utsl8rnGeoJuZO?=
 =?us-ascii?Q?Y8VtbnC4ZMf/Ms1jWj43LF23bWNpdoqs2bzsnKhlFCyvewEzQiE+FPLsErT6?=
 =?us-ascii?Q?dv7XrJYAHdeR+5GBhrNX1iS7E0I1YssJVMZeqcRCnq/zS8SbWxRS77jbV8LD?=
 =?us-ascii?Q?KqTqRG9FNBW5X3g9UupMNr9L6FP/D6Sn/8JCjmX36NEIw5uiJY5HRGQkto7o?=
 =?us-ascii?Q?mmPxGrkrZgaaUdH60ZDPtJA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f818413e-5a54-4344-601c-08d9b5659dc0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 07:30:29.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is4mae0w6NLLqtgCkRNa2WgUTj5MDWd/y/kJgV2pjJ6KGxQDcn8Etv5LkG3w1aNSVNkaf4a5SVi9rzRrIdgLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2555

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 73242304ada5..417cbb947832 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		flags =3D *ptr++;
 		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason =3D *ptr;
+		pr_debug("MP_RST: transient=3D%u reason=3D%u",
+			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
=20
 	case MPTCPOPT_MP_FAIL:
--=20
2.31.1

