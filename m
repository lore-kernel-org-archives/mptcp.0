Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EB2F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644414492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tUG/CK7RxdSHtF7EuPUCF+GJyxxCWXD4YvTTzqQ2bKc=;
	b=W1ibdgpNENvNvQVAzV7upR6jKf+0nqaAf1ZYa1tIBZAtsWwjKycA4qeQRFArzuoNkZPhYZ
	Pp4RBEqXdagSHibmjrRuS32eDRGIPM312hL+iSzVvaCDg0AKQ3aNsHq7CFSqZMqBfq4Ovx
	MuTF9dpyJb1aeIGS9P/lDQqDDIeb6t0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-ESkh58WcMv2xFy5jrkMJHg-1; Wed, 09 Feb 2022 14:48:11 +0100
X-MC-Unique: ESkh58WcMv2xFy5jrkMJHg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGpIbCVquOO1I22STI4tiLj8jt886S5jwlZnWoLGe8TUXZqUFIDEHjS9PvdoPj7KTBbtFik1SSlRkaAuPgB5lgyicp109FYMzYBwLkHk3EavjcD5TBjxh823i1poyfX130I2NkBFIqqwY/Ni2MjLzpFKBsL7VoPyq5C73FKwGYYhMJi0lKFxktdr+4HjIFClAE7jiwIvUn8I+wySdT0hGvrIfX8FzRSW7sU94FI7j8CiPRKsn5pFwFtKQXuoONgOOnET0RYIf65qwg58vAg/wIBSzmdTHDt21IPEcAvKFeyPoaINQb6l4nc/otGbUPLiPos5MA4YOpEjV7rorspkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsZYGovNFhzhbqlwDOj45TVKBJwdpm6F7snzQjKgVow=;
 b=hbDDRQBegyTa/huWLCQL5kw7eTluZtAMrngZpn80KM6JAC1/Qzb3NtPzP+rmehXBJRsqsNk4MRYVAYjxxt2jRcULToXklhMawoG+t9xJh8viKzqRCqp5aM5150EZKdIYaTQHf9eB98fUYWUnA9ehH3pZz9cLDVmx29ZT4oSxcejLEA88CLIOu+eI/0GRaMEaKIoVZ3/R5LaLLhJdiRor5mezFF50fLpvA+Wn0PzE8AESmj5/I2NrfVvsXOO0F1jUzgCeS+lGJaQfKPL+9dDxNnn1VtWE/8AyCUGzq0hiQPHiyxPrWyLIuz6icA88zpgYc0H+VzD0w14iummTjTVOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3147.eurprd04.prod.outlook.com (2603:10a6:7:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 13:48:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 13:48:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mp_fail testcases v5"
Date: Wed,  9 Feb 2022 21:48:34 +0800
Message-ID: <d7ae1690ad1da5e0614e239a429e91e4dbc52155.1644414480.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1faf31da-f024-4e4f-629a-08d9ebd2ce4a
X-MS-TrafficTypeDiagnostic: HE1PR04MB3147:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3147E69056EAA6433C57A818F82E9@HE1PR04MB3147.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F/o3OrOOjDU7AT6PFqqa+LDSbaZ3Dc//DrK1PIE3AMZM+txSS+ZdKd11OC+DuyC5nAfelkPaBVoD90v+nsm8RvXmYKAZbXnesgL/7pmmWs7MMuLZo5eSX8WINMesjIv7KK6fQYi+4hnawOJtqim0JWEdYpJZ6fiZS9Igd5EPBuEwE7KlY8KFc30BIrHjnsJfxxV9DAA73tk2+zC5NwJq7uqLBwk7cTsUMRD0Xx9PpIaSvPbToey+2ScuyAvVa7gNmLBoYBqTCG4bbO9r3IUuhZkX2j83Rz25afbtnmRA36DtmT0zTN/ocj4Wf9LQDgUE8KSptKR01d429QxoGsTWq6rU/DtwMJc/uOj6WTGjejGHuauUwU+UwyifQFh9ujkTvD51Q19ql+2OglwSmgXBeqJV4Cvqs3MYs1XdRHi894s8rfbig10OHqoVGMJY2GmsBKQ4gW32ofcfrhWePeMoeXFTtZfjxNoC00U4/fxVOPPoHlakgG4tIEnkUJQx9Z2GwWIFoMGhg9XGSYDbZMlBGfA+ed7w5gyNB5dQ95MPAog1dsIRys61Trh+tz+nM1sYVxaKygRXl02DZXu4dHV9slQvkl7IQIFnZNCFt1ZmM6waldKuCFcg8VHR+N5DjG316UeQI/0TwwE5qbBc4Kk7sF7Lg/M/CwpoaAh8g55FizcVKWHV+VlrdBPAaZRcnfEIQ9NcyUmJsIi4MuXFBoc7sQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(316002)(6916009)(107886003)(2616005)(2906002)(44832011)(38100700002)(186003)(5660300002)(6666004)(6512007)(66476007)(86362001)(8676002)(6506007)(66556008)(66946007)(8936002)(508600001)(26005)(83380400001)(4326008)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r7CH4lVOCE2EyTFxMp4gBJC1lT7WFC5dMWylrBW8cIQbcsVRUcm5usH+G7Z3?=
 =?us-ascii?Q?CggxWr8iVPZceHfa11LYoNnkorYbbv3HRD3BAVR4OUX8NvJX0IJFnjB6M1Tm?=
 =?us-ascii?Q?TXpMDKRkGWkaedHdQaRqCi3BL4jDwBOxmiJip2AoKq70xQftoBLDrdTDtQHh?=
 =?us-ascii?Q?7MrhKYLrguTXAV5QvZh4qunfUBlnA+TqmWpnIRiRmcfgjalwX4UIhuBRraYT?=
 =?us-ascii?Q?7NeRdtXoN49vlllGxFcfBF/+/sh5kOQIN3SGW7MwxgWBvhQrRtY1n4jYjJyW?=
 =?us-ascii?Q?UDAYMqaZN7rz3Tm3zMy74AGPYRsOO+hYh6E9afJ0XkTit4+2xunWQkOquyyP?=
 =?us-ascii?Q?BnVWv4BQnPijQVBvzqfYb0foi/GmO41vR5ZdNLCSL2+5nDg2R6+aQxgw63FU?=
 =?us-ascii?Q?l+/o/yCn8Ni9jwOPjG905mYI5Y0wOX8o8mOFHOzQKhcf7Xov/aQAAebTFN77?=
 =?us-ascii?Q?+ylfZjtG65p+MdhapeLuIIEiYiKeUOZhrzVCgEHUTrugZ+VqkBYWYn2dd9MA?=
 =?us-ascii?Q?IuXmcKHg/xsq+bd9IevAAh6hWF6wgpWtUlB+QxKAHNuqp+sWP9DBrQdrXjAh?=
 =?us-ascii?Q?6/KiEoJSkXdqNhXQB01YQuYiYY0WutnLfCOG4+cYBQp7n1i4lzKmD3nHX3/W?=
 =?us-ascii?Q?QqoNpowhYm997bpmzTG3qHnxKmkx5lhwYDWin6EkneZKwKfVbxW/V4LlLvRf?=
 =?us-ascii?Q?598mzzD67SWnoKdzIy8oBHGpocq3yg1vVCXtYi5hqvnV3ymJ14R1QGWo8KDN?=
 =?us-ascii?Q?GhPG3jwtfr5wGwFnIKEygicN6QpV7zCz09CRq3p3iYMxHGyH1UkoZ4AXKIIU?=
 =?us-ascii?Q?AHGIhtvrwqggnPshyBTc8NU4D8ZtICeXzFvUBI1U16d+vfJ2vUfZjjKLq1nl?=
 =?us-ascii?Q?oiWmHh8dld/28V00VuBrA+YDZnbZfQsA7ixbuaatwmyqtbU4i/ugfds2rYem?=
 =?us-ascii?Q?fgi9kDNN7KUat9MQ2EFJbd5dBdCIwjwdp45xbrj/PWSB7KlRmHjZPs3bU5ys?=
 =?us-ascii?Q?/gypvuVAp+bCA01O/IJMkVLVslKTOCDAaBBj1AMbtS3qtLpdVgkdX5p27ohI?=
 =?us-ascii?Q?8TCQahB4dY2FstQqT/dR3VJFG4IWhAtNIzbLDkqVDkANAOElgXB0Jf439zRA?=
 =?us-ascii?Q?RfPD3YD6W7YBWWncBmsRlb95jWqcu/0D9UkZhvQZy3lLsDZMdJbrSBaOxvT8?=
 =?us-ascii?Q?M7uksjr4LJjdjzLFLa3DUlB0jpTEJYaimbKXAzR46NQhp2+aVm+4DGfNRAuU?=
 =?us-ascii?Q?D5J6Mq94E5d6vLoVVglwOknPoX5RlRH7WNcc5HHaQ3K0xibvgIr5g6sBjPZC?=
 =?us-ascii?Q?77NRhB21qyDwIRPZjw2EKoDDhVOPwoaoZFe7568OnKtj5lfCWG66w0XOOVeo?=
 =?us-ascii?Q?2VojkAKaTZUXRvcnH2eOpSMCvV+6MWNTUjQ5tDm4WCSZ6Wm0oZMyg2yCezLQ?=
 =?us-ascii?Q?6sEz44dHJMMeZ9bKpU2dSONbnKUoiGbYdbGzJoPgUkD6Yrq+l1uUk1nDJAFI?=
 =?us-ascii?Q?dvfrz5g8Sg6Hzg8cN+/CCMD2f3e9lKTvc30Pcm1X/WRuNe07bTBfvlcKhQEO?=
 =?us-ascii?Q?mctKacRPnRgsMppZOrU/d4//RMaS/Wo0c4qSxfFt2smSvFCbxJL6bogplvMn?=
 =?us-ascii?Q?/67I1TKMqDZRPBQ1axq/p38=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf31da-f024-4e4f-629a-08d9ebd2ce4a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:48:08.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFnzJagYLx+R/tQd51YyYiy5J8awK1NmFRssJht1X+D6At9+jmBbxfgudWaKrc1vjYstScSzaOW5nlYjixVIAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3147

We will get this failure in v5 in rare cases, about one percent
probability:

Created /tmp/tmp.e4nE5Q14mj (size 1024 KB) containing data sent by client
Created /tmp/tmp.QwpQYClFnm (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 0 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         sum[fail] got 0 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 0 MP_FAIL[s] TX expe=
cted 1
                                         rtx[fail] got 0 MP_RST[s] TX expec=
ted 1
                                         itx[ ok ] - infirx[ ok ]

We shouldn't always expect getting 1 MP_FAIL. If no checksum failure
occur, we should expect no MP_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9f5c9afc26d2..cfa5f168e6db 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2287,7 +2287,9 @@ fail_tests()
 	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 3
-	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 2 2 2 1=
 1
+	local pedit_action=3D$(pedit_action_pkts)
+	chk_join_nr "MP_FAIL MP_RST: $pedit_action corrupted pkts" 2 2 2 \
+			$((!!$pedit_action)) $((!!$pedit_action))
=20
 	# single subflow
 	reset_with_fail 1
--=20
2.34.1

