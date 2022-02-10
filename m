Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C72F23
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RRHTFvPBdOo52tKAUtrMbFk3uFjcf2b7LLh8+6h5Tgo=;
	b=XqoVuJ96X7kkSdCuo3v2jQYL7bv8DCN9xqs7i91R5mRJXJYRxU7XIW5pO0B8t3zIxTsLJx
	AC5854UqHliz21tqnwNBGa0yWbO0r8Y8jXzrQrdGs5JSbhHnmbFTuSDnU73EMNLA40qX5U
	pbsVtzKBWvZQFuLV6i4yOlvh7xdjb7A=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-OJAmR7zAMQWsr25RgB41WQ-1; Thu, 10 Feb 2022 07:00:09 +0100
X-MC-Unique: OJAmR7zAMQWsr25RgB41WQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfJMYUeZoYZVS6ChlL1uE6Jry7bVT/ya0j/h9sIWaFeRIjhempzboDv1EvDy4523xDBaEXPAKCYwpwCgoSLZwXwulH0BjMiZt9uyb0Sk1gC5qRqScyMDjYXe7qnd++Vcskzv8uWbYX9WRRBtoJnpze6R+/IrtHjebZkMsJWJH1MAeGRTMiRIG6C4l3iakbbUZEdDNlRtmzCDqnFkQyfewVIRYEpf3aVYdWLACepUpf5ITcE5b+64+IxaowlRrJ+78pK1QrsJlTHymCiDcKqqX9jAeJIFu5I+3jn4BjGFJHJkQPKbGdk8/sl6CaB6dDETY5Wvm8mz7xUoDtL/jihk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce0kmayK9GdOeGuo+NSnQvD/e0yIu2l6XHhoau3NfOo=;
 b=EhwQFeFNzapbOSoqRuVg+lvLhWu3wNmG3kbZHO5vxZguw+Bc4l2fA/Dkp8PYISHnGlzFdq4TQ3KZGtqVXblQ5rVCXMgjMcm6dpSihriNVvlst5Kf/CR0vd9pfMynFPgPWnHCwmQ5FhOgCNFOhChS/AgOaPOc8qfdzoNxVT+zIFeOZ52DlmVi1mxkEtaB6chMAb7tPQM007D2BUSf2Bct5E341wiYQPyDDcly6J5KrIRVL1WSBsJ/E7f1hCGaVinpnLjpl/dHPHxX8ShQVQtjVqTBkqaGIVfJXgLiL47b6U1mj3KwovELKDJC138439jK5nMGiyEHLlbmLg+y/MywvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:08 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 0/7] add mp_fail testcases
Date: Thu, 10 Feb 2022 14:00:24 +0800
Message-ID: <cover.1644466570.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26baebbe-0e58-48ea-51a4-08d9ec5a9702
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5761D5047B5DCB161E84B97AF82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KyEVNOtAa+WVppeaSdzKrF90H7V24DPSiPCmfvmNRS5y2FWL4iIrqwJJjB4jaBXqw/GQsgiB886D0YkqjvaKySfTb60JQ+638FiS03E+t9YWewuXf4QmeFUdpac1lzEyL4jGA1nSZzWeWrAJ5KpQrTyDNpJkvZr5qlDfaLBHz4u8dT1VLR7BsVsma57GnaHn+swTpEFUDZ60sMaWfRQLAF6Ww6sRfVXJY60glE+MU2Hg57ajj4L9Q+mp0iEzJJsCcd12GGCtEjf8WV6lPY6n2gVp5YyMiKfP0ov6vFxffaou9Bcrvp0TJ/HCOKuLVNQQCwCx22RENxynnMKwXlXn5aK4eboBb4LaN9C+grJ7NhLxNIKQfXBGC9Yt6wKlSU1ia2MsOIx/4A/AXM43bDvtu9RS9/x2J3hdPPpSLoUIznuYG45FkiX8qMTZudoH1qZbK4e5H8EVBr2LGBOdZif7R3WfCvCsHP5OXuSOtrs1xK7dbbhCiW6dLBCAGaEKTi9bln6E7qksa+QsaGy2tGN4ko1wpWpyI6qwmscHXp0AD4ZlcOFKyjlpSWHFYzryNF06+xIiaRk2BqNYNkRjhlRuJUjxhxbiNH/fx59Wwq3JNxw00u+PeEaS8EyyOujyJfKnB4SXOgwiSqfA7dcHpK5S3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(19627235002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(66476007)(66556008)(6506007)(8936002)(6666004)(8676002)(44832011)(4326008)(2906002)(508600001)(2616005)(26005)(5660300002)(38100700002)(6486002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUDVA8GwmYW3rQip7q19H5+UD2Q+RcYsyAB9speooqH7tsqztlIq0MBeamZW?=
 =?us-ascii?Q?JvcSiLkYIfO/JYOHh6XA0Jdhmi++vCGAp0126/Oyue8y+FjbepaNinzsMNkG?=
 =?us-ascii?Q?sJmtjiz/NKWW8JyJ5swbHy3eWFN5Q5uzy8N48zbfl3nPrtQ5tA4lbmMfZf77?=
 =?us-ascii?Q?2MUtERh91Y/o4nyjX362PMW1KwQGPUGJbNEAPipguq/e7QyyB2etpAbtmRZY?=
 =?us-ascii?Q?X0XX1UH+0INFx5N8oWW4DM1ZtuqYq9HqEvhEUhToO9G2d9zIPL+q0SGlpdlz?=
 =?us-ascii?Q?nNu0KFh4D3atnI1JZR6m46ASRjPfOi/QSGL7yy5uLAvRkGUnTblvn2HGS5nq?=
 =?us-ascii?Q?kdaNhSx99eLxwpRK9NviMRkywCIbue5fnqNlmyydl6AZluioP0P+4p2ij4LL?=
 =?us-ascii?Q?rTSJ8W5zqLZzaQ3zMiLRTG9QyEDcMO6CA0714lSABlLqPFAS/Bv/HjZZn30R?=
 =?us-ascii?Q?L/BghCtFXjcObbqLG1cm/+tYRVT134GUNpsMJkEg8fZXvE1fjinmL+Wn63xG?=
 =?us-ascii?Q?/39lRtAkmRyueAAB9nw16DOxkpR6SAqCsRduqrCjolATir9vt961Ib80ytLm?=
 =?us-ascii?Q?VokYEIaVwK9IkO9IUk05gdTkarIYp88ys0sISL0ZXgLOhIvl6wq60Q6kWAdV?=
 =?us-ascii?Q?BV0emLrsLs3iaaHQzFUkRtJQ3Ubj9fzFigtsT/IDXiNtG6/QCmXqiosQ9Gdu?=
 =?us-ascii?Q?RuXeIhiL+aFS+RKkaWrZl4TloQ9l1pfYXvV5WF4kR/q94mxYRaZ+VQWabQmu?=
 =?us-ascii?Q?TmsofEBs7BIaYKWPzGmrOVa+yxxJK+nRhjGtLXg8d6MfOtYXFYQzFUXGoJYC?=
 =?us-ascii?Q?UdqI6n3+2LBmjDetCh5rNcZtCq19KUEy2SHzmP0MUaKlQtStE23pwf2vF26B?=
 =?us-ascii?Q?fNBDWPs58+80IRBKiR3FxpIpffAjRSIjLLFCYB0ZPoLHzzr0/FsjRaCJsASc?=
 =?us-ascii?Q?hVlPgUjc4/+zXsY3qAatjTgYR/xqibTWLwudHlrA5bDjTW0J+nzz/KoZ8v7d?=
 =?us-ascii?Q?D2KaPltwY5sSKAIQBOtyS4OLljgRx0d6y/6GK7R93orkwPREyUgNOssxDD4S?=
 =?us-ascii?Q?UH5Xu9NZLtLnVUJSAVJ3DhPhJbV2f4azY6G9sLZnzBLcMB7LHkBAK1fOirc0?=
 =?us-ascii?Q?Ws9uaqvjxu4yGXctDr8iZu1k5yVq/iThNgZsjH9EtY+PAYkfb9HsmRc55HIc?=
 =?us-ascii?Q?yyZSELOzZJsBpjv9ZZH8y0DCf1y3F7CiREoJKSomr8i5RB/v+0Jyb9g+ztZA?=
 =?us-ascii?Q?oGZrpskyWpD7gVZFtXonslPMZNpRJL2AFXs2vJBC838VWp8h+X67WhoYGt/L?=
 =?us-ascii?Q?0B5Ar+gynkbWme4IxwPbowvzRedJDRVwGF+BSaL1JyL3uXOLq7l6QfhYdU4+?=
 =?us-ascii?Q?NoDutJS+t3gqmrH6ZXLelJ9tyHto7/twtLKk+PkAxP7IGeq6wuutIkWuD7NR?=
 =?us-ascii?Q?8KtgP0MeSu4Yl6wqgQX/qqORMVIKw39uSMq38M5dMoqsy/x8SQ4iSOt1p5Ba?=
 =?us-ascii?Q?3/LpjMbNHa8JdXKTNHpXni/5CNkA5Cn3v7Yxe6tqFcW73tKXXW8pXwGZZkbg?=
 =?us-ascii?Q?yb31HzJjLcaM/BGE60/QkIzfLh1p7ZvpRZpcwUmB1fhaqXjSDcj32ti+nBD9?=
 =?us-ascii?Q?bdJgR0GvfLN1stewb5VtpkU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26baebbe-0e58-48ea-51a4-08d9ec5a9702
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:07.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD1Yb7GjfBCFtJkQI3Rttrn8U3l5jagXuRyvB6hVMsKHRTwL5RhWgJRF6kwrLWYgxeJi9ruxKYA3IerQa2vGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

v6:
 - Split two patches from the last one.
 - Retry the multiple subflows test three times to fix this
"MP_FAIL MP_RST: 0 corrupted pkts" failure reported by me in v5:

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

A test log of running v6 500 times is attached, named v6-loop-500-times.log=
,
in it, we can see retry happend 8 times (116, 136, 236, 295, 297, 402, 444,
457), and no "0 corrupted pkts" any more.

 - Reduce the single subflow test files size from 1024KB to 128KB to fix
this "file received by client does not match" failure reported by CI and
Matt in v5:

# Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
# Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
# file received by server has inverted byte at 195585
# 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ =
ok ]
#                                          sum[ ok ] - csum  [ ok ]
#                                          ftx[ ok ] - failrx[ ok ]
#                                          rtx[ ok ] - rstrx [ ok ]
#                                          itx[ ok ] - infirx[ ok ]
# Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
# Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
# [ FAIL ] file received by client does not match (in, out):
# -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# file received by server has inverted byte at 169
# 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ =
ok ]
#                                          sum[ ok ] - csum  [ ok ]
#                                          ftx[ ok ] - failrx[ ok ]
#                                          rtx[ ok ] - rstrx [ ok ]
#                                          itx[ ok ] - infirx[ ok ]

In the attached v6-loop-500-times.log, no "file received by client does
not match" any more.

I think this v6 is very stable, but there are still 6 tests failed in the
500 time tests log (68 77 97 112 161 243). These failures are all due to
get one more unexpected checksum failure:

 > cat v6-loop-500-times.log  | grep "\[fail"
                                         sum[fail] got 2 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 2 MP_FAIL[s] TX expe=
cted 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         sum[ ok ] - csum  [fail] got 1 dat=
a checksum error[s] expected 0
                                         sum[fail] got 2 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 2 MP_FAIL[s] TX expe=
cted 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         sum[ ok ] - csum  [fail] got 1 dat=
a checksum error[s] expected 0
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         sum[fail] got 2 data checksum erro=
r[s] expected 1
                                         ftx[fail] got 2 MP_FAIL[s] TX expe=
cted 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1

These failures are related the checksum bug reported by me, issue #255.
When transferring a larger file, the checksum sometimes fails. Running
"./mptcp_connect.sh -C" in 10 times, we will the MP_FAILs. If we solve
issue #255 in the future, this mp_fail testcases will be more stable.

v5:
 - update patch 5 as Matt suggested.
 - use '|| exit 1'
 - drop jq
 - drop pedit_action

v4:
 - add the mibs for MP_RST
 - patch 4 "selftests: mptcp: add MP_RST mibs check" uses the variable
$nr_blank, so it depends on the commit "selftests: mptcp: adjust output
alignment for more tests".

v3:
 - check the exit code of iptables.
 - add ip6tables support for reset_with_fail too.
 - add the null check for $packets
 - rename nr_mp_fail to pedit_action and get_nr_mp_fail to
pedit_action_happened

This is v12 of the mp_fail testcases with Matt's changes. It works well
and it's very stable.

Geliang Tang (7):
  Squash to "mptcp: infinite mapping receiving"
  Squash to "selftests: mptcp: add infinite map mibs check"
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add more arguments for chk_join_nr
  selftests: mptcp: reuse linkfail to make given size files
  selftests: mptcp: add the MP_FAIL testcases

 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |   2 +
 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 200 +++++++++++++++---
 6 files changed, 187 insertions(+), 28 deletions(-)

--=20
2.34.1

