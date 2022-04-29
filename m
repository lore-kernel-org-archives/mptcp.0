Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC71365
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651243899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uz1gOGr+WFlkBX8yBv5Eb8YDAx19FFr2+7RehO/D6uI=;
	b=TdvZtYY09NHWLf8/ZabgWPUG6MIS0gaysSUgufeag+sAW80hhVoW4R35PtpXvGYipZfc1O
	RpfzlfWURaMornRboRLr6ZhV6r75R0RXMJov6qWZmMRXqHmtrQftSRKw2Qq3h/AB2Q+8Sr
	K6DJcxCktgxeSzK0QqSFZFgOMNC0yyg=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-SupmkRlQOgylwvJjE3pwEg-1; Fri, 29 Apr 2022 16:51:38 +0200
X-MC-Unique: SupmkRlQOgylwvJjE3pwEg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+z/kVg+PRPSyXp5Kkw6ek/HAYfKxFBeUW4xXjX3cVb7WRXTUPqKwIXBriICe30Px/LTk5jzNWiksu61KSNFOBECEZtasjMEsQOxohahlAnDxfT0ylEOCg2KVe/BEeijjCQedyxL9ew4pAvW265aTAlI9xswdJ9WQtonmdGJ+RmjxlEPJQzmlp/YQTMjlGuZTpdo85trbo0FxBlT2w5V3SDvkbQH5VrRGoqZswg02UWaUHQGWCe1O09VmQv4Q4V+mm4F0pBs2Sq6ephtOKFGigit6Q+pXUJ4xgtEls7sSHqOkuH78yFONJ3Kk+MiWZUXmT8iCFm+HdpJ+rndTYAOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfRDCM+mAq1I6wpksiBO2q24CF6f9iMV3nF8kmuW6T4=;
 b=LqeutcmeoOIkBUVU7hBrB54cqrYMkMgQnEfykfxeCw1JINcSOVsgGU7ySuW7Y38m9jyRQ0CowqTe+RUX/ZsBqOL4xr0lsIMrLwFnn+l4em3YiO+MWtcGEu30DFtzJV1bubEo4kwotLchLQzRxfSKc9Pn2Gfr1UkY2is5/mSfsjsLIYN/Thw9AMv0VanVYGjyUHZmxYpRmh303UjmgOop0z5dycRvfw70NfGTcmn85Q/BxsCzvSUmbs1smNqI+UIECjJxU6xM5fM6QROsjACLLe6VJWCTQE0hLFlWsYn3ZhK4Od6AfwfH3THfZp0kZv3pRRmy92pi3YKhC9dnEJamWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 14:51:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.025; Fri, 29 Apr 2022
 14:51:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/3] BPF round-robin scheduler
Date: Fri, 29 Apr 2022 22:51:56 +0800
Message-ID: <cover.1651243739.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f18fdbad-9bd5-4df2-0c1d-08da29efc33b
X-MS-TrafficTypeDiagnostic: DBAPR04MB7238:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB723882EB75E34D0C25BF7D17F8FC9@DBAPR04MB7238.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jbe2wx38H9X8+xeQQyKCYLg7dylkEv7vo6yuu4nnqngegvZXFPuY3iOlaCXPJ5Di+eIIRESHIEKN3cRaZk8W7PghCM5wZKK7Nj2tNkRTOMrUaNVsjpdm5we/+onv5V/iR/IsrTClyWVEWPIiPdoF4lf6apUlBQ2JByX5SeFmyoE4CR0Nb+RMM9I+hct1/co5MNaX8rHuYF8NKx9g6SteAo/tswo8ukaYzn2SRsKw0p0RGZmIU1G+42ZDm0MhPhop5GuGYigE0xZmwkPm5HXgpcQHdUgffGs+TQrsOrnHnpRPKYjTeIYTx60mGE8e2ezpPaF4EqvEHoDvo5Eqnv2m/SvKM5NuOZwRd8iNz7ugVN3SQA2k9SLAheANc+Gr5sEWYbKpzdwldef5RBj73GHsEJdikpIPkM+2o2wNdZmfz8hfs0pTQ3K+j6FK0yvxKnnhSumBxMxMGSpVQKjXcjyjhczK5P28T+yGfV/Ede7a2ZrDAXH6c3Ldr6BBbcz9kOKo9hyxg9G8CMiTjoAcL75ZlsYUF8Rz7GAXuSGOCnHiR4KXOMINvm4qBGabphJMCxTIlzd2yDyDy/iOx8f//2DsDTmqvSuXMl2E91CHKC57MMc8GVMHrtlwDsgi1iTjTyUqOvDnkl39Rf+w+xWBeKlBftiQQy9BvCicU7W8RUQHnCif0wCDjO2Ryma43e/bkYhlfZSYxzy3Y38SPMo3E+eU1++JCXox/K29qIgIL89wzEv6pPlgKzuffcyumWawKQezMjirY1RZrKZnEMUkS2iOxFp8vvW1wliDdwAK67NkRQBFI2ntpjbLM5RFCgogne6I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(66476007)(4326008)(2906002)(508600001)(8676002)(6916009)(38100700002)(66946007)(966005)(6486002)(86362001)(26005)(2616005)(6666004)(6512007)(8936002)(44832011)(6506007)(5660300002)(83380400001)(186003)(36756003)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQa+nntcKOcWGEJHkQ7YT8MuYMWdZlwRuZQfB/pHFeYXVAvgLobM+3tiJ68z?=
 =?us-ascii?Q?S2iMj9JMma3n+Q+PwVSqxFF7aJaLmhocvzT9yD0HfL9UpbyJeOd4ZeDGkzSD?=
 =?us-ascii?Q?M7H/BYn2N0D8mB6DOBoxX3gYb8LN9k7EIfQvCGjIgw/dvd6x8WnjLMH1jvHc?=
 =?us-ascii?Q?IrsPAAEWYaKzu95bL79zn19cxiGgYAltMYZhlzqtjvvctazjqUf3sz7En0F0?=
 =?us-ascii?Q?VAO0h6YwWxcFG+C9jZLfwNbOXWCc1d5PjVkv4i1lUKKAWfuHsRroH2y9dLkF?=
 =?us-ascii?Q?d8Lv7y2hUrRtL3jzV0K/3IayclSov6kh5w0n98drqgbssX4ag474su2w4M+/?=
 =?us-ascii?Q?sf9R7Cwtk6u+82OkXF9o5ehyglFp5SGyQdsDRGLG/mIAFCdIgsMGzqPJdray?=
 =?us-ascii?Q?GfWoV4hrxFt9bfv55qenXaX7bVjUo4LpemGSOx+RDf3yDVQR8a17u5TDZ3Nv?=
 =?us-ascii?Q?HWNeGq84Tbu0CTtQHW1AU10vwqEnl8IjQkPZbjiL3lMdshvQT53Ovr/lBy5D?=
 =?us-ascii?Q?eKG4mNY7xo+qb8k1eh06S/eU4kTuN+D56txov/r0/aB5KJ30QlFi4yHXuQOe?=
 =?us-ascii?Q?a1BAgJ4FN0tIcBrxVHGKySMfsFP2NQ+XEOypk0T3LoyMjFlFcTlgd29BVoB1?=
 =?us-ascii?Q?yhVEIiVmbZmCXMEe7yIYxte4k7GCUsvDmcAo7jymkkDT508bhvbJlfJ14HOb?=
 =?us-ascii?Q?xSFGoqBkHbjkSxxgmQMUt9d0wZx5hgPrmbWtAuCY+0pMF3VEA+EaB7fqq/7x?=
 =?us-ascii?Q?pEgGVmNX63S5d+OPS+KEOiGaG2hwwY+M2dLtEptwA8k7oNC6zFuLnzdVb4yy?=
 =?us-ascii?Q?K+o+S2V/5/yxED695Fyo2mHa88r3O5JTCwGihrMC0T/qKdsPFO4Vq9BQBQFz?=
 =?us-ascii?Q?1TejyloAcH34/QKTqvft9+Eky0PLC+aK0c2WFzKKwkcu7sJsW5QIy/JvBybG?=
 =?us-ascii?Q?13KX886pVw9IeC1TA22TaOKAhXCO/OoYs0X1xWzNglF8S9Td7iCAxtJm1o+V?=
 =?us-ascii?Q?ZVlQoNWOhvGh/paS724j0xhJoRs3BZD/MH9nobuSfEy15Pp+//OkiRhBsY/i?=
 =?us-ascii?Q?7nHR7Ji1L0ppxooPcmnTGnXDFqZQN7ZWol5IdDCOKXhEHliY76lCN7EeGIBv?=
 =?us-ascii?Q?Wi6bQ9V862nbyPL2r0Oe2IBrS2RSSld8uQYPC4XjcfTumCIstBCli28TBTMN?=
 =?us-ascii?Q?Vx9/8GmNk09ylfQhcJgVHLm3qUqKP8S4yFBasSvvzjhCh33AekZRgnFO5s6E?=
 =?us-ascii?Q?7+LPVJYR/4BtdB5cJGNi3cfAcfwOBLEh/xHdRVz+9QYz81YB8pCMlAUKzT/M?=
 =?us-ascii?Q?Kx4yAT1b5ihjXfF1MWaAZ11yN8YE642AN+nMBkBM0aq6p4c9dgvhoQuPKidH?=
 =?us-ascii?Q?QO2L6sAzLai9+vOa8FNrqnVXsMBpfVztP8vEwJupToh+hzFtqRPMxzhBmYUE?=
 =?us-ascii?Q?8hQqGK5gkQIqlGVvbSTY6nzQ1TlTOaPwg9a9Jtg2rc5DvvFfA/+2z6ExH7gy?=
 =?us-ascii?Q?khsjq72iMAeMFHQW9C0tjBzgBb+eNGa4MiA+kZXurofFicKeYBwnyNB4YChV?=
 =?us-ascii?Q?sJD6ykLlmO7en29BHhzrblxD87YOKptyaBf2nYFQ2lRukC8+xjFrgGTMEIML?=
 =?us-ascii?Q?BZ3QE7YRMk2jO+FTFpQZv5x6qF49/Tbuua7/pNXbGpzbRqQC8ZpMnedRMp2E?=
 =?us-ascii?Q?R4w9T5BPl4iA5OvDRuFvfwhmd3kliP8K2yuCZfRV7luq4WOjZgHg9p662sqc?=
 =?us-ascii?Q?d33EN58gChfsHcW6ItKZsHj0O7ibPrc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18fdbad-9bd5-4df2-0c1d-08da29efc33b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:51:37.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAMlYPnVehm/Xdq2g6fT87dyOet4nSOiRqxUMKiYKK0LXS15czC1aTeiCaWXv8NPzFuxKqpRBKKecs5epq/oxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238

v9:
 - add subflows array in mptcp_sched_data
 - deponds on: "BPF packet scheduler" series v17 +
               Squash to "mptcp: add struct mptcp_sched_ops v17".

v8:
 - use struct mptcp_sched_data.
 - deponds on: "BPF packet scheduler" series v14.

v7:
 - rename retrans to reinject.
 - drop last_snd setting.
 - deponds on: "BPF packet scheduler" series v13.

v6:
 - set call_me_again flag.
 - deponds on: "BPF packet scheduler" series v12.

v5:
 - update patch 2, use temporary storage instead.
 - update patch 3, use new helpers.
 - deponds on: "BPF packet scheduler" series v11.

v4:
 - add retrans argment for get_subflow()

v3:
 - add last_snd write access.
 - keep msk->last_snd setting in get_subflow().
 - deponds on: "BPF packet scheduler" series v10.

v2:
 - merge the squash-to patch.
 - implement bpf_mptcp_get_subflows helper, instead of
   bpf_mptcp_get_next_subflow.
 - deponds on: "BPF packet scheduler v9".

This patchset implements round-robin scheduler using BPF. Address to
some commends for the RFC version:

https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (3):
  mptcp: add subflows array in mptcp_sched_data
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 include/net/mptcp.h                           |  3 ++
 net/mptcp/protocol.h                          | 16 ++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  8 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 49 +++++++++++++++++++
 5 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

