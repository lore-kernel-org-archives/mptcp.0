Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CFD7E
	for <mptcp@lists.linux.dev>; Sat,  8 Oct 2022 03:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYUVkDpyg7r9Fh4PUtT6s29BdAkP0TPzVCxLmTaBzREexg50lmoi+woGFIGv6XKe+rvL/HE3ocVWfbNl0cwbnf2l3mZFPpKRjvrOGXtjyc2oUfROKNx701CUKORSCE/2qgdIRo7PSdnmh1G38B61zY+r+3ltObdu7oGx5YNVNx0dSopCcCQWJdAV8sWKqYRPojdXp/XIlLTd9pUups7sbLN6PSZTbkev8nvROUhIJOvmlBGR2SRtfwGnv6ok6ECH1eHt/nAEmlsUieCSeScSxtNixGnBk946jxjGVFX3JZv9wOlb4Zu8ojlNXmFA8NbaRXIAPis6hn3NZD7vIZYXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdGTzB/C0uqOK9u0bhF6uNefInUBHf8UVP1cUI2StSI=;
 b=n5I1Ji0H7/c/vOV7DHk7+kcmIE/VmPpblBWBLWjTHXg15b4K2yLrsMS38SM/sLcvmHW9GPIk8oLIVX+NfNmxafmcFCf/1aW8ezUgVocUdLtEBPr7iew1b1mrpcw3DdMYrfONQ9WqGD+cuN9YeRj+5Z8+GhCHeQMQujeu+pnBWEzz/acCi8NVGpa1Sx9lmdkAOQgLzd6++EL/xo+sWDZbvpleO7fX/OqkvMKpylX/0+OdWMnbAjS6a1s1OuDl9RP5eSzYXRez/xNlQUCEfM7sNOlYWbdLgSlSR5HN4mD0JV2NB+dGUcLtDMJtTrSVBlrLR5K5n6qJ4OdBaqPxzqMgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdGTzB/C0uqOK9u0bhF6uNefInUBHf8UVP1cUI2StSI=;
 b=0qNnPCBp+AE8SsTNjiecRfDZl9VD806qbjybLLo2CqWE5uxg5rigIdf8NtvSFFJ+iLakifjd7mRoeg/skH1RmnCHVr99WWgsRMUuSkcphNbUI6uZ+3NSqTCl5yBERsfkW6xLRS2bg1LVEqvQvrwnyoSIE4sm4Qpw5KCKIlUxSswvfZFoXsJNM3+vUTsuAU3PCVafkjsIix462Ra8yStIO431+bXhu7ad52OhSGtuvQSod9vEdaSyn9CYUV2invGNLhtGCd/b9WEPyhp6QzHXOl3w/nzeYXPhfAES8BqPIG8bRO7Edi3SHv1wdB/oMx3N8rn4c+aUHdujEZpMOuPy/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sat, 8 Oct
 2022 03:59:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Sat, 8 Oct 2022
 03:59:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: register default scheduler"
Date: Sat,  8 Oct 2022 12:00:15 +0800
Message-Id: <20221008040015.21176-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b5aedf-c761-410c-a5b6-08daa8e183f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QXTOXeQCTUIN1AE1RW4DvZRTvQ3wnNQgnHEGFU5kabE/Wl0/o74C2eOGDZ3xr4ijnw/KdgO0eGW4yT1AZO50uVIynr673VMQQzjHkeeV/jfsI98VuncJPW3mHjvXoG7h9vEpP0y5PGeqZMVv9QwzkenJUiS7UQQSKKz5h3fD01NatY+h+qPXvpS1yMj1oQYHJXVo2Cga4FZKFv4hABnXUn4DoW9/eBWqgAau4WPmndMGhVqtC3xxy6tqDsqry0tHJRsDdtYPRLBKilHtpQPKqcnTpPuqlt+wkdBVbojlBcJ+A8eY+old6T3a3HAMayi72esMmyFPbrruoRQ7i/fkeFZXi3qoCS/sKht+yTyMUWhTJUhl5Fr3MmHj1BmdhxLMSzrj3KycjXmiU1WURx6jprjD5uCrh1EkwGRS0LoSN3+L3ALeGS+DCoaERUjNk4YreNyYqvCDqSIRAymzu5IbXG/EMP2lIaFjWvp6pw5JVCU/aCZe1458bQwh8VxruWrETBvyhIFq+QZSPJaez36dOHTGiNixxUx6UiWvpnOFeKxKKF6EVc8Bb6vHTG5iSwaQUgzGQVr5f9GSG1iuHJdwwm3rmIRssFRC/gmv5+V9aStIz9sE2vfG54ohEdFHXsn3rxC+aoxt9FBZZ0RQ/6J3TvCxI+JN6jC85XArakI/nn5qLuN8IvZRlq9ssePngKOL6ZPIQu400Mi4S+Xwyh2uNnNTuP4qagd4ER5DaATPWGFmmDA3AbGP1pzysYXBBx8t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(44832011)(86362001)(66556008)(107886003)(186003)(2616005)(41300700001)(1076003)(66476007)(66946007)(5660300002)(8936002)(6666004)(8676002)(26005)(4744005)(36756003)(4326008)(478600001)(6486002)(6506007)(6512007)(2906002)(6916009)(38100700002)(83380400001)(316002)(9126006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkIwpJqXi0Hx0AKASrQglgyWZ2xPJFZl65ne6UZM7tQ+tb4MwK4odn4Gkx2B?=
 =?us-ascii?Q?eaYBM8eyCec2YW0CGg/R2jcywj4ZWi2iusQvuXpSYwHDfq/9bFONIbVX6Agw?=
 =?us-ascii?Q?EPDm0wr9tkx48xKH79GjyvGARN8U4nXeQ3dDDUZS76cz4BG97Q+3w3mU4v7X?=
 =?us-ascii?Q?nDAuDoz4InGvN4tAUc0RmVZpHXmM+nwLGgCDMjlpFs0wIgXV4U6Vr2TsB9rH?=
 =?us-ascii?Q?LZo/DfBSp0F5YdZr9NINpN/ZEPUHT32S5Po+ZIwgutF5x1QxM0ha8rnpiIFa?=
 =?us-ascii?Q?sauJgYImcytIkuvVdTofNR1nhQ4NL9RQYJ6R0NY/Uw2DQm1HA7En0LD/yfuG?=
 =?us-ascii?Q?4hek3PTUl5ERRuedW2rJTGCgJ556IP1JLoAgIQb+LGMg9jSCTwsA4aM67SqT?=
 =?us-ascii?Q?NBNl48cpTnZZN8Y2zVQpzF8TkzTdp3L6i8gXr3k5wESRw1TpNHF6OVcSN5Cw?=
 =?us-ascii?Q?pbWC1ez0GysDhFyQ5YOSkrrr9e5xLRbeiPshFI/WWvo4Ft2r/8xeQkqT2fgB?=
 =?us-ascii?Q?wzLPOjoZaQUlPKRniL/0x1ElIgfLX+dxbMBFn1QRNpjbtfKAsUFJnARE+bBO?=
 =?us-ascii?Q?nFA1CSJmepS5zyvZSZ/CkSQX7NVeuAUldEw9x+V9nFdwJJtBG5+6gadBkAAr?=
 =?us-ascii?Q?QEEz8gN1pGeHEXmEbyzonMBTraxLb1lYLsXL0D9pmb5ZhNZ3UeajDhscg6pH?=
 =?us-ascii?Q?y0HrPO6LWKyTLcgyAZrXG43aZ+e2SjAAxryPcGU9PmqxdLUBePyZdT3zk6kP?=
 =?us-ascii?Q?LMwumpXOwTfuPY3PtjYOjFbtNzW39HKP5jbQQczOZLIQTFGCq5CtHdRSOQHZ?=
 =?us-ascii?Q?HUKMJqsd1QL6Lex7yntmNXJ2YriJ1frJ911D9ikPJuFCJCjNUPQDj+CX8Woa?=
 =?us-ascii?Q?fGTai0WxmQHmqKXsd9gAHrzzRTfm9yNYgypeCrHvCOh50V26GeiYlIRAeX1i?=
 =?us-ascii?Q?yKm/cvzNDESyFWUNfKhWHKGfLVv8OPIj0+CQpSVNM+EDcCVawNQBAtvSApik?=
 =?us-ascii?Q?+Z2Owf6icoJxMl0YA1qvfFt2yrLK5MEI4CoLgjcFR0+h3PfwHxy+jON5afjH?=
 =?us-ascii?Q?5bnuBjBTrnbu4FgIZxkiIsOJCiZm+h7oQOkQuEQFI+E3gZR9a5xVWj3SXivs?=
 =?us-ascii?Q?NN3lQUK7myPZ6N4tzPeTI5K2ac6t9+80EcyWUc4tajR1N8dfMG9sqoca38q1?=
 =?us-ascii?Q?KI0gtAAbs3i9iSec+TnpqMtwocFnKdxGSzxFI2XoI0B4Q8GHh21SuopWKgA5?=
 =?us-ascii?Q?b885/yg7tQ0qKapx7VAtP0JrgRVpAYh/KDBLRyq3Vr9IdCIT1DkJ4Av1YCh1?=
 =?us-ascii?Q?7L68ItyWZ+UvFryO+SsGo26p3jIj1kGEgPTFPrc8HZlKznP+sRj4iimaRB7H?=
 =?us-ascii?Q?VorgsqtqeNbWfBR/0rumgHrOzaSizUytLfWrcv9EjJBQRFlbtPb0HJtqHvth?=
 =?us-ascii?Q?GvoY7Mserilje1CaDPuKiDwjXCkn1MmPrO3T5F+rBq/I9lfnblPMcM2cUnmJ?=
 =?us-ascii?Q?/ci8uJfpXg34v17tOcH7B/YFXlLal4Bxue4Lqxlk78pSmr7rxIk9EhAVr7N6?=
 =?us-ascii?Q?04xUXgoWsxMcv8WKLkh7BL7mCGzWwEWdVqBkdcmHAvdNgaPZY+lnJfd58ICt?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b5aedf-c761-410c-a5b6-08daa8e183f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 03:59:36.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRcPDwGTnJCfCjwuzJWMDrODuqSOXJyxQwpIBRnAnhOIh+vR/Qr06yTTRv0GSzgG+iICHDdgbfj5VqFLzAAp2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

Set the default scheduler when the input parameter sched of
mptcp_init_sched is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 7b697fb154ae..1174fec7928e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -94,7 +94,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -106,7 +106,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

