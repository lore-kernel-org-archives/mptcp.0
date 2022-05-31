Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C11210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6/AzvjbP8jC0ks4pg/jVhzh7RLdE2r/McU6SWptIllQ=;
	b=BkOmOxKcBYlJWmBcyQLtC65Px742Ff9BYd8WGHWYaZZLnAncGN0jsUmuDYpSQieoXJo6h/
	idHN9QSQnJJW/qyn0wZvWbRki08lA89bXnUXE3I4oTYGQuKEHY7b5CkJEil1+y29I8Bwwp
	Nf7PmbN5wbwqiC9tpo8xiuNroXeHIsE=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-URFvrtgNNoeOYgjH-wWtSw-1; Tue, 31 May 2022 11:09:48 +0200
X-MC-Unique: URFvrtgNNoeOYgjH-wWtSw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjjpCZurcswy4Kbi/37adLgPp5h/iPMPHS4JLY0Jx9Sqs9xefMDlQbzQc5mtKlmxrFcCCexPvr6Pmg6A8jX3eBjmxC7oNFpUHhBZxmSkOJAj9xUNfmHtfDJbglrEv+EyEMxe+/V5K3eCUZwXwxlfc7wjjPS4jXXhPiaRPORWlTOpfn8SQfTHPlb1oWuzxPWYvFWFcFaAyngmVzo9YPitzEP4qEVRVPebbhBideBxIzoiMfx3wuvsim6/Psc3uyDJWfKD/tc4L1RZ0ESWP3NJO6u+A2/BEvAvphS6bHRxaB1w+gatQBxHMKjeEw/umjyDkROh9eXVVYVmk5VwHck83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IosT91wqwOB+KMDjk7f+6XZ4diWcc9wcuN8F6GHZmhI=;
 b=VdpL8M4kVP01wJh5AAlaB8+qslQVtp658maKVgapi+T4x1wOC4wvaUmPd+6IV6jb53v6353bhUSGB2NnB+Nr+KgVh+5V7x2eafYtcMBakz1uYKaqP6oPVfQA1obNzfnv74l9xMfTE68kqWvou87nNrX7J7EQO+n8uXYTdwToP2bW7We8IImh9ZEcK+wCCe4yYNsKpqAhURIvJcPZoVW1LEvE2rVHhEkb/nnvVqNDVFYda2Zu1jG7X6mmf3HCG/mG2QGDQKVKX1hNqRSSVHJ+G6XUZstksgOeALnQI/3Vw2sNBad+9leqy71Wio1RDf5DPhGbyGyWoZHCLD04WVT96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4356.eurprd04.prod.outlook.com (2603:10a6:208:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 09:09:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:09:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 00/10] BPF packet scheduler
Date: Tue, 31 May 2022 17:09:45 +0800
Message-ID: <cover.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca61882f-3f66-4f46-d700-08da42e54e29
X-MS-TrafficTypeDiagnostic: AM0PR04MB4356:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB435661B318B9F931333F5BC6F8DC9@AM0PR04MB4356.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D+Gm0U8H5RoydPntk+a0lvv63RAf1lHCN08Z6Zye74yvmvb/YdZpwJqvDkhRRhAkR0WpJUDA225EE7RFQEIYB8QuAx0lmL/nkMtq9WQOVkOHYjTIkUO/pDF//jvL0PCKfiQNuqHiOyMQy8RB2V0BoF90//npoifIHHorkj/AlVRSb0PSVI3qw2cjLTuzRVQN7FTRWEVZtXLHUSNOnjQkLiDACsS9agIPij7m5FqBzS2I8f+DzD7IqiteLLx5h3Ar55qkI+TSevGMp7ceVM6LMTZFcQ5BypA0I0A7OsS+Al3i/1GEDVB0i5lFaLpJrpQbuZuHT9pRU9c4m/yuFOt7ojlOokPG/CjmAxg9kY85qQrnAkT8DSfEpL5w2iqfKxS1xGGG+zX0AP6gQjyf0sL7s4GZe8fsu3rE8p/ejwYbVDmnfxBFatEEwQZK4p5oO8uIVJE/gH1TnH4/9lXziOPu5a2WTx5fuXMYbY/sf6n93p1PmvGOS8dSyAXPbHvax7aRkYbUcTQUH1h18HWeuoPF1pCGlaqo/3bTNQia8erxccqJLBPqyeDCP58EBSxS8V3Zj8xkLYYlflhPmRYxowCICz89fvM9BZNbesg/rS+FkujPGidnya10bxbhv/JxqJXLd+xjY6B8OVbGrgWFrC9WrfS3BeO380JKOHP+Rlmb2Fd8Y2G0KRMwnJXJHCwSve5lmc+tevxe7MPulullAP+Mckirn4Emx3JfF3e4pDOeftfo8uidLPw7PI13jLsXvCNEJU4z/iiyZ8A4QAvSy2UR4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(8936002)(36756003)(66556008)(4326008)(316002)(6916009)(66476007)(8676002)(6506007)(26005)(6486002)(2906002)(6512007)(508600001)(44832011)(186003)(5660300002)(966005)(107886003)(2616005)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nBxRS/QKpIKhg8NGkCkHc9C7HFptCyfLlsfu6ulAwwP0BCO3eiPNSxlTpQ1?=
 =?us-ascii?Q?rJypmzMxVCXjLA7P9wNHYtCbp7aTqJCyvlMaI6I5BzW1Ittm8yqHsy4ezF9Q?=
 =?us-ascii?Q?HgNkPS332G7of0zBr+5xp1pITY31sgvr7dE9jlpfi/expY4sBurbYqTd4Wxf?=
 =?us-ascii?Q?GKVWsFmAtu2/zEfwvA7Mf7rvfP3qulvz4owIXWu6iRN4eQJ8GUYpnUK+6vdH?=
 =?us-ascii?Q?JfntBRqBwGNlXt+YqUGoMcack37ctD2PZvxF1M2bhmoasm40PVl0LvKAtURD?=
 =?us-ascii?Q?g719nDDz4s1imkGB4st05ioiGKVT/DYgR1hFsgynpzjMqqRIizYmG8OmeHeO?=
 =?us-ascii?Q?3tuIz0FznW2wUpPFyEr7I2UswKZ1LOaUqpwevoA3Cr/ZD3yuwHBVNK2lGeuK?=
 =?us-ascii?Q?mks2CVvI5TXgsIgC9JT6PzXyVgqawEAppX4fBdUuf7vksocKkUkxWrGFdT1C?=
 =?us-ascii?Q?W9M8WsJAdmGZRZO9O4BTrlKJhr5ddpKEFmdfuwi5hc0EVRvOm8kydB74Arbk?=
 =?us-ascii?Q?D7O3LWt7gGC2al8qgWZGCnLasoc/+FbAF2ROo/xp68cMWV0U9CshVF30HaWE?=
 =?us-ascii?Q?9c8CijepHhA0S48qzvBeoGAHP9dr04z5wWHSzG0G/gQRDkHgpoYe8BhtwEw7?=
 =?us-ascii?Q?9iSC2YxFWvrWiwBiFk8+VN2DaudAaOvXxZXa9Mvj8r235dDU32gPmhh8zn64?=
 =?us-ascii?Q?5bk2q9PWgWudtGrr3nYXrHM+l1eGcQYK8tR/Q5tJmnPGxHOF9+FjCycQZ2N8?=
 =?us-ascii?Q?KmuFAO7RWBKHY6x9oiuUrVIvU59+vOWCbw+enenlkHTSURIDvEqDc+AnOo9u?=
 =?us-ascii?Q?1O+3aWaMzLdddbdaJhKhH+LB8uA95G5ba0df4B1EoMEJFLK0jocSY1DcakOA?=
 =?us-ascii?Q?gwZq1OdY6pb3TiW6/ZeetMYGhVKtwjEu3Kib+XFRPludJA7QS89tSvZ39HJo?=
 =?us-ascii?Q?O6sluRwf/L7T7iUOdb2eNR6rFjkrj/6WlT+QC5fkxmqNoa0vYLTVZe9s33Sc?=
 =?us-ascii?Q?3QbOTeN5bJWE/wWy6n9sdL8xEwXn18n1bhk0dzRAFQx0igdRC5sKyRVGd4dF?=
 =?us-ascii?Q?62MUJswo9v3MxsuswPDLxEYFjA4MSleA0oweZ3MoxIbpHyEXU9c4Blib+piX?=
 =?us-ascii?Q?QoccVlyJyLfeiCbMOi8XqRPjEXWIU8xLafP0CYoiFDJPgx8NssQKJ8Ep54Rn?=
 =?us-ascii?Q?dagePwcPDuqxKliHTPi1bWlJlc9bSaMcsuAwXWXDKLyXh84v44zrqP2zCUVF?=
 =?us-ascii?Q?7IL7Box0521k2idqs9R68Zbh9WWrK3+qXGZm7opJd/U8fxTv89/KVYYwJUWg?=
 =?us-ascii?Q?z87h9b97SRDWXUVfKBORTPHiz31EEnWGbFxOexpXDS7IUXvmMQ2Fg32y6gJX?=
 =?us-ascii?Q?Vf3MpQo9EM/f9ztTvDT9UkcpL37H1vlYiymY21RW5E15gRSdc/SyAGtbelCV?=
 =?us-ascii?Q?V943ppf4a7EXXtOLV9x3dyxWJohI6tgpyQfPLY+mXgkbI5a8EDnHfBk70b6L?=
 =?us-ascii?Q?3cSeMZq16qmmVmLsmlI+kUa+fjuZ16EceAbqcNKLKQO1NAYLLD3uB3eHoXVA?=
 =?us-ascii?Q?ZRbjvmAljIIqzZeBVbiI4s6nphVcX/3nTjaddJ8H0Nt5nrKg2D32Ar0zzxT4?=
 =?us-ascii?Q?h/jRG3Q0HIAMz+6d+MSj7I4hhu6TXV4LP8JjI+9oAWZfFncj/gr97/FIO8MB?=
 =?us-ascii?Q?Qlb5Y3QjmdYsF6f06hAhyprl8+CS+TXwLtGH5n8DaoMOzysocFept9wwkxbw?=
 =?us-ascii?Q?/XoAdme140E01odu07dHSJJ9sdYym3k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca61882f-3f66-4f46-d700-08da42e54e29
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:09:45.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr4eg6azwqcYFsID5zV08D10afPjYngYhZDoD3EG98TLsvIsn7uGPE3bJtammbDHtFcJcMpUXUMrlx4Z9MctEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356

v4:
 - merge "mptcp: move is_scheduled into mptcp_subflow_context"
 - rename bpf_backup tp bpf_bkup
 - full patches of this series: https://github.com/geliangtang/mptcp_net-ne=
xt

v3:
 - use new BPF scheduler API:
 - add backup scheduler
 - add round-robin scheduler
 - check bytes_sent of 'ss' output.

v2:
- Use new BPF scheduler API:
 unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
                              struct mptcp_sched_data *data);


Geliang Tang (10):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: add bpf_first scheduler"
  Squash to "selftests/bpf: add bpf_first test"
  selftests/bpf: add bpf_bkup scheduler
  selftests/bpf: add bpf_backup test
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test

 include/net/mptcp.h                           |  7 +-
 net/mptcp/bpf.c                               | 18 ++--
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/sched.c                             | 54 ++++++++---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 16 +++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  5 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 ++++++++++
 9 files changed, 247 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

