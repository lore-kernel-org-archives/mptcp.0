Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42716652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmI2ZLGqToawyPiodG/gfJ6LbhBl8ovwSXDoQjUF8+e7lHXtWiLBXMjeqoyRuc9a73Pdl4ImQOackGDQbAE9SM2NaaclSc1qhosF2kipd/dVeYBhjXaZSddYMFJ2uupZg95fOVR62Vdol1mlLU7yIvT1GXhbEDPscq80lk+S+heX3yAJf0q1FEgWrwJGhrepUB7HuaPKMs7FAN2kO+m4YPHjRuf7NIYEMXlbH2sSWaqzjp0QGb7N+CU/ZCVgd/ELOebNhfz7AM96nLfD8BIEeX2gfyuTkuutGGkjJPpWgLOVopEBcJnsnTZrYuoxB85BZaeVQav7y+t5nZ+2jIVpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y5vbbvYXrZXwE+gjIbR+2l4vlvdXkbRjzlxu4r22eg=;
 b=HRvpmz5B6PMsYxEyMAAvJSFIUhnsrFQDDMaS79jwZelMQ9xjP/jKY9luWbwDc8HVMMEocpXabRZAupoWgzdZOm1yEZEBZxFcQoTYH7AqmLpEx2bfk+eUyqzNd1U6z54AMKyClvrQtB00ebu0DGcDp9VooWYkuEHAXBxTiHU3juHFf5IrHb6ESqKNnYdfT6eiCArVNAarIsQP21AEerf9jhQTCU8L9FuEbWEnkUtuHqyvoDx+72V6I0pl231WhLcKKP+e2CK1aVe15i1XjW7ojV1VC1OW9eEolAErFKDbC/KpaHefxwbnU7LEX5EEDbJIzks3yQm8rReWwhOsN5Y3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y5vbbvYXrZXwE+gjIbR+2l4vlvdXkbRjzlxu4r22eg=;
 b=5BLD9/nrjoQEixj2+MKPxBCLm6X7x4ecsK/fNz8AK6I6KeNWkQhTdee6N/xVy/nKnX52JrKKDYBcR8k8owyrbJuY2Un2ZrFuBlExTg86dwrbhkMz2FkkTTJVz2PQPbYJJ8pLSzLIPG5R4L+hUz1f9Dbqo9/+Q/1EV5tw0zr8qqpz9TIHbAVcabNA891Ovd8qstfSY4uL4sdC1GiuVXmtPm1X9ogyWyO5/Gmk56xoo7kYaEaeEviHjqm0N1znhbuf6C79BKK82kA32if8zDZJdm8aA9zuPoQsVN0rT8S77JNSz3Z2YNsTX1KEXwFR1MLaPu2jkLumQt2avmwbvUnAXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8230.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 07:48:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 0/9] BPF redundant scheduler, part 1
Date: Fri, 11 Nov 2022 15:47:55 +0800
Message-Id: <cover.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7a5924-0304-4b5c-478a-08dac3b91371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pqD71tV/u5cuqzsxwXJunMdT/LwUvPM4u3RonpoQ9yWZwq0pIDgHhUFNn8rWE6Fx8L+DGYUtY9tPM55GI2Lq00HUQBLq6hQvAy4wNsSKKiPcB6vKcxFBowzbBlt5tHZbetKagTvinycuGBxK1XZ4ijJ6QssYaNjLgJj3wtbCc8iTlwvBU4QjlZs/c09GumSEzH5ApE3aFUmxjprmItXDxQ54sM76EGyzGlTX4C6omD+jyUa61KgFG61rqE/k5BmseqHpkCu96ktqoZ6xCacxg4o18+iBPS7cC1jzk/v6JUvGQtOqIHq5o7h8VZBwuMQywjqQBzJPdbOrA+xPcUHtD1orOb91yCHdca0TgBzwjbmBRhcPF5ZelvcYfEjHEL/ExCIVr3JQ23CP+zDC0R9janIdyaxV4vcX5HbURbPgLAXekYtIrTdcPAoGn2OrwtX4CLv0wgWBU5eVzgeZ91bOuOWf3EdZuK6BsuayE7F3B5wJrnNLE9yylRO+YP5Zm9yzuTTx4ep4mj1RY3WzVhbrOlnui1PD/rpByxY/8/8CJte5CzTciUVfHjv/1mo0vOLoPGhcvgcRSVPSiblrzWpFLR1wP3n8td0paL0pwy9yGuVy6G04XCONuGtJAZatvm1XZ7Tb0kX76TVhZrAeIgrJvn4UJUnpfoi27tRyPhYYETLzDQzRqYzuFNjyX4e2MnEJM4xZJENhpiPd6lvFD6sXOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(6506007)(4326008)(26005)(44832011)(2906002)(4744005)(38100700002)(6666004)(86362001)(107886003)(186003)(5660300002)(83380400001)(36756003)(6916009)(8936002)(66556008)(41300700001)(478600001)(6512007)(316002)(66476007)(66946007)(2616005)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJ0bgdNrcS3nW8FV2eZ36coO4XssN5+TFPpWLGlJg/Vk9DGM8AXqNos4vta2?=
 =?us-ascii?Q?xD69lZcrvTqrvlFtxWWFqRO8T6mtHrw/GMe+bBlxximB8dCHViPl9bpGPRmP?=
 =?us-ascii?Q?HvPujjYoIpKn5pIrMKiE1gnJ1YnOKf+BVgjCHF7UXkT7Tvka7jBoGn4HVFCT?=
 =?us-ascii?Q?/W6OpJmQhrBF9RSIfh5XJg0Srl8yfQjdAQ4IxB0hqHmlc+zfEitUPl1ANx19?=
 =?us-ascii?Q?F8mzsTtMpmY8S1iMdzbbRwWQAqWVwLV98tS2BtfRb18kKfFmaj9xEKDZRYHd?=
 =?us-ascii?Q?B/REYZp44zTaAhoVdrwUlZgFui5AivrOjGbwLqOH3XPoKr65oWNM9lC/x/F5?=
 =?us-ascii?Q?8bU3i1vhrL/5eMU+aUqPqDTs6mFka1zn4bOfcZBIBZ3JxPfqURmARZznmchc?=
 =?us-ascii?Q?I8NRPXgFIjHr5DwFlJUgqnEqqCXr9g2tf/msU41aMMAXhMyJXDg49yt2VEiS?=
 =?us-ascii?Q?I1ittx7SQtWaW1sy1GAQpyB1hYYXPpgCll85oPQJcKyxK673Z/sneohMET15?=
 =?us-ascii?Q?ARKmX+94rf4tAP7tQme11TUkTIHBTO+dftpik0btcExvy//4EN0dWiz22jND?=
 =?us-ascii?Q?HdP+lc7CcKGivAsv1twhIBJirfkT41nAwPedOFMaeAD/94Te0u21UGYuWtN4?=
 =?us-ascii?Q?piUUVdjlF/rFYtMAwTcTR3HEZic+PwSxcQY0qQL5KXKB34mtP+xB+PLpF2a7?=
 =?us-ascii?Q?4WNz53i8ou7LAR9i6XEikwguRV9NqbMSB4Xs73jfxhqPlrBAVcqFCPRvCzBO?=
 =?us-ascii?Q?SRDxd1yt+yzGroH3j6BozTAMLDLvo72d2is4hVhq5OGBQidl3L1fiW3OYCnq?=
 =?us-ascii?Q?KfDoD7ynuTqLVf4nyAyTejc7uyk5eD4m+LrMTjCI6gP0dIJLDbBLMwPXY+Aw?=
 =?us-ascii?Q?O6nacIHwFOGmY2CJfW8GlHtt3pfZ5ovWTjH7scSbBwpGsTb+qXb0kc4VW+t7?=
 =?us-ascii?Q?z6rPbt49epNORCDsLnVEWuYWUEJc+NsK3/1vzUP0aULPJa4d6T3OA0lt08FB?=
 =?us-ascii?Q?Rp5DEvUDds06EoJz/P2Bnrqkos8fpEoKfLCi4KcOXTblzyb0dAtBR2suxW9a?=
 =?us-ascii?Q?xVR2RCVAti2/Epd2vVNvHQCWT9KS/C6pStfEMKQVA/f93l9bhMyKOBbrEkxf?=
 =?us-ascii?Q?HO1eZOo398lDusGKAcLh5bkBDq3vpQSU7Tia9QeftpdPUd6fEAidRWCWBVVM?=
 =?us-ascii?Q?VJaTAGO/v2/XpEsasMfCdtYGG0Dy9H41vmx9M5hCCNCySPzgDFXkAPenHmtM?=
 =?us-ascii?Q?/O2aNR/dF52fB5ELF7ctlt8Hl+DESjfzQSkP4MLzx6G/sBVVwihXiwnkx7N2?=
 =?us-ascii?Q?0OLw0O97PRKpx0xQ5hW5UuE5x26+jok4SGb78fEwi1djBVTDe/Uq74xKfmdI?=
 =?us-ascii?Q?O5qs9PfklhJRZbwTkWrKo0yJn0QJ1TJN6NWinV4FGCOd+9JtKfIUoYkv60GH?=
 =?us-ascii?Q?pKKzjf+yJOc+CMc9aciIfaWBfo4WqzyhWy0o33L4neRF3HVx3yVixQS1naa4?=
 =?us-ascii?Q?Bnp8Z5qG3SPnwhik8IF0xUrBetnsGjWh6UqiiSZT8AxAZhgHO4ZedGQyN+zq?=
 =?us-ascii?Q?UUfUXjsDD+JXHY2Vy9aG3+m2w9e/U1eKNmdficgUNcK1a1ozGnNOvr0lBnY1?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7a5924-0304-4b5c-478a-08dac3b91371
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:09.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMBG3bXRLsgCecZAg7kSr1LIBgyWWr5I4SmCTqZ9bknXLGxHZc12d3oeVV1GxbifZqlU3eoQwuTCUq5cw6c9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8230

v19:
 - update patch 1.
 - split "BPF redundant scheduler" into two parts.
 - rebased on "export/20221111T055536".

Geliang Tang (9):
  mptcp: refactor push_pending logic
  mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
  mptcp: add sched_data_set_contexts helper
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"

 include/net/mptcp.h                           |   6 +-
 net/mptcp/bpf.c                               |   1 +
 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        |   3 -
 net/mptcp/protocol.c                          | 161 +++++++++---------
 net/mptcp/protocol.h                          |   1 -
 net/mptcp/sched.c                             |  21 ++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   8 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  10 +-
 11 files changed, 143 insertions(+), 97 deletions(-)

-- 
2.35.3

