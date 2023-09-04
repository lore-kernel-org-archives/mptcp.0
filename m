Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02C7E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYbqN1jcXI7m5cFLLM0t7A8CbxfSkPucdQ8P3Ip0EfRqHJr59/dGSXa0ZXZD3T+TR9Wml15Dai+WebIpSOJehCZXCtGXVjsasibwdm/hfWsyuZL0+bptyz0oquXdVEHYrPZD3/FRmU8u779fqEmOM4Vvjs4lSqZ3ImjZBneuGijdfYc63X0cmpQEqlKk0xjY3oxIqt6ELAm1aI9+bhxzg9c4xq+kMhrQ1jGYdFvOut+D4JTxSAVz9m4lE5GDc5Wg7V4VSWaWiFqy8qSLGXUDKQxNVfp8MImkDDUmufpHLjhjkUqf59gg/Ds3Igw4hSe4F7CuOHk7vyY7JiXTJJVerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy0nI2nHJeM/jg1DedJGww1qCtAK1UiFhpihNncyhrA=;
 b=mUtpzdInLT7HrgIyhqWa61EwK7VablXEEEQbgISmjho7Ty8wL9LOuuOcmstNyRebYcaI2H09XSv8b5ImpJyh4478MrLDEew0gcT2j1/zhYQSLnYQCZta8nai5dQMIi84aXftIkkqhAxiQrSe1lRlg6NsBkuleoW6oI9ViHIYTKD3VxtDlzNjygnbHW1Vpe1vfjfE+8mM4dZ441qRn5MnIV2vTjP3iKOgsAVj/Q4Rt2gviHPnY/FeZONOPwnKNGzIOpx74mkSsTOpMxBvFt1iHH7SkBlCYgLeOURdwGlqYexecwOa6iO/OKVA0/BhbuPLGBePqUFuhirJexPFGA57dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy0nI2nHJeM/jg1DedJGww1qCtAK1UiFhpihNncyhrA=;
 b=dpXM8JTBegj2FSno0Qscn8qHLIxgzsZTZSj/52C+TyxwvT/5UUPwZD3MryNl0pf9rOktBW+K5lyPFj/Srf7m9RP5PF5ji8dZUQgTiUN4nAumHsQtiLFZ1ixwSRyBVuL9PGWSiLnHnppgHli0GbSR0TqameDCBGPC/LfcAiFzMv2BDRV0Ubh2brTkScIqWHr5F+BFUaAHQNCRcqGT4OoQ6of5Va8Xxi7wOkDTyfWEIzVW8UAv0gPlQqgRWGKyISs+46SDuMU+EgoW5sKPsIwC1cBtkxfpCdpPK5T0UjlSXj/VXKDf7I0evdNcID9o1pogPg3yuoddDA+NmoBp2Pxp+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:39:00 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:39:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/9] BPF packet scheduler updates part 4
Date: Mon,  4 Sep 2023 17:39:19 +0800
Message-Id: <cover.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::10) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 2712328f-14c5-4409-e5e2-08dbad2ac47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4O/wOuY9XczjVvTX9Y0wZUyAoOuLrUHBTxN2eZOo+NGZ+tKnG7hkkMDedn8+RWUCr2vGeLBBm2zOAe4Xv0nes1uwI8WFaQYATEqAuXHo2nd7jZmQ7B4dMnAiVVem7lmI7XXpmiUn8OgR33fXCm6SN1wauBmUc8FgpK2zKD7dgR22kSQLLfzD6nG3xHs5CHlKLogPJr/ylJbShhslSZtHW0+6cQX4Iqr14AMjBiENquO3COAe9d3WPv2b9jyRZhR3hX4HOlOip//lcZqV5rddAKAJ41Gbhu62sGe+GDlyZ86Z07PCjx8siJH/pAgX5Wpcsj2lr+BM9wqHcl2wbvvFXQeENXdGdZbzo2svaeqfFJhbUnnL0oii0YvKuRhtbruyH+zVN+N0ZnllCQ975LkxHnrbHG4wyG5xdUNDLkDnU7UZfQc/yLvcmJIlm7O3f0Npi8JSuRpSuwffwQ5GnFA7TneXL2q3PgSAs+VkcNfPO0r2u5/Q6M671swO3aqvnF8rXpaaMJKntqlJCd7qX5YqpyB93Xm4+iIHLXuX2vGYeHbtOXOlK+TalZjDU8nKKZIg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(366004)(376002)(396003)(346002)(186009)(1800799009)(451199024)(6666004)(478600001)(66946007)(66556008)(66476007)(107886003)(2616005)(6486002)(6506007)(6512007)(2906002)(8676002)(4326008)(8936002)(316002)(6916009)(41300700001)(44832011)(5660300002)(86362001)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbbOO35OsZ7qbzIxg3MM3O6I2ptIXZYim/c2n+SPYpVrAYI1gC79gD+BKFxE?=
 =?us-ascii?Q?QPjCOImDMJb+a+naBSWTQhJYSfcucNnugMmgz7rQItW0oNS3KPX5/U2YrLh0?=
 =?us-ascii?Q?GEzoQEkNgGNwPK5u66Mlxxfk6bKbNRuhSBaCW0EHNEA8CSq3KpdGEtKqDFGZ?=
 =?us-ascii?Q?DIgVjD9NAPgbYlXKfEQCr3ySNrA70Qw8f/blh2b6hb3kM/wo87GLmanm3z5N?=
 =?us-ascii?Q?uXLvemRmAS9082lGuTGSBqbX6NL6IhzZgQFQNFXwqQNfbUYH/9o1s0AnO1jQ?=
 =?us-ascii?Q?jjCBx9O+tyhf5XcDS8XQHtE3MYmmf3Q2A2kCzgJorH5xgxALNxnO1VzLVm3+?=
 =?us-ascii?Q?fprmG5l3GF4COoypldCopVxPQ/AuiJCRRs1awbGnRwUad6/oT9WHpKkt5QYH?=
 =?us-ascii?Q?UOYmR5txM6CSJUuSDJoqqFmOwdMrp6Fpyk2fvwPr8E8mHjal78vPDZa7BuI2?=
 =?us-ascii?Q?+OrLXjjOC4nRPFps1v9trhLXp5non7GDgVASyl94rlO9wLzA0yyXQ8wfl212?=
 =?us-ascii?Q?aW261oiLVs/6SgzybU3npFjemFWsOFY/XzHlFOaBRnap0HPm0EmDO2aZnd27?=
 =?us-ascii?Q?/sOQqpLsR4wwQGZYIEtBqfTlitFSmAh3ucdVS62k8TgrnFnDTy/gOvDxM9PK?=
 =?us-ascii?Q?NQq+92AVq6hjlKzK8L2YrwvhsJhHW7yabCILAFd68cgLQ3MfC4KDxmEphZoN?=
 =?us-ascii?Q?2XB282pJsZzFLIzJ4WUdRPKPvtz3ux+bzPf/Nmb9ocMg8Ps4Ce1BOBs+GTa8?=
 =?us-ascii?Q?wZ4M8on48jKg3Pq9pVi3Z/sHeFvTAX9dqV07w2Mt+vvAz6n6aMI5xlyABsrI?=
 =?us-ascii?Q?fne/oRbfwILdUrLqY1cl/ckAyuGs4QxsrV+b7jzvy961wag+id6py1Uh8T5H?=
 =?us-ascii?Q?eZrERi5A0dDDTrCX743s+uu7Ggws6QxJSjBZnvGQ4vwwcQK9Qo5+JGmKVjIq?=
 =?us-ascii?Q?7eOmNUnAJEP3S13TGtEl37lZ5M1bqm7DahFt9iYtiq3XnvRHLg2Er5c/NGJZ?=
 =?us-ascii?Q?iLyVwZURfzZxEoVbm3uWaI0hgK0dmxM9Rc8e3mY8LhEEFrZ69UBVGuv+Pnk2?=
 =?us-ascii?Q?KVUWhNgn9KkgYkE5EWn8J21SW4D/C9Lux8caqZXFVNVIQBIrsF1SSLXPwIOb?=
 =?us-ascii?Q?NOl8K/vpuafmc+g+UYr6WSgJH3P77N6OhaNn7qM/UixU9T7zyLpzM4t54LZP?=
 =?us-ascii?Q?6dgH0uQZ68kFd/A5drT3Uwhl4YvBMxUecxR2nZePJ7CuBQvHRPPriRaVx0YP?=
 =?us-ascii?Q?/F+n4rNAdPsQSTw7sNd+D3nphmQqmyue/u7EpAZYdSQBfECtveow5VJ22xnc?=
 =?us-ascii?Q?LjPfKJa9Vj/kOCgOBvjYXcbjKAUjXUD8eeQ3OmhRLoKj7yxanSsa0Ov3IQ6e?=
 =?us-ascii?Q?qrLJrrHEZ2zfb/bSkSNOb+MEsIgwsTd2RtOkEAlJrK5yG5N8/tZmlc8jjc57?=
 =?us-ascii?Q?+ZRK8PVSpQFl5UpmrQ3kEtON05aJVVu4LVFRQMbAx0JS6agtvp21emPkqEcx?=
 =?us-ascii?Q?V85Db5spDU7SHXbGSKf99EAEyDDrfg7xZD0p8CifhS1JgJOBfj6Msq/uLgh+?=
 =?us-ascii?Q?ujl03J5T4z1wrcu9HOFmq+aRkW0KzPpXED3iiyzeGsNmb9ClYL9yCCRVZ1om?=
 =?us-ascii?Q?OW24/mEyfxCHsyT+XllogGG0OwCMSY9+75f8MfJPjn4l?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2712328f-14c5-4409-e5e2-08dbad2ac47f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:39:00.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNDRPIV3o5AM31uDP8B1pwqNfgYF2/O67fQkmQq4asralmDE3AFhkO+9IlNXdu4BIDmAEDN/JUHN176bZbBpKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981

v3:
 - store burst in msk->snd_burst instead of in sk_storage.
 - make mptcp_sched_data_set_contexts static.
 - rename mptcp_subflow_ctx_by_pos to bpf_mptcp_subflow_ctx_by_pos, and
   add "__bpf_kfunc" before it.

v2:
 - keep sched API unchanged.
 - use bpf_sk_storage_lookup to get snd_burst from BPF context.
 - applied after "add bpf_stale scheduler v3" serise.

v1:

There's a bug in bpf_burst. snd_burst stored in mptcp_burst_storage in
BPF context is not used. msk->snd_burst is still used in kernel space.
To fix this, add two new interfaces in mptcp_sched_ops to get and set
scheduler's paramters from BPF context to kernel space.

Geliang Tang (9):
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_red scheduler"
  Squash to "selftests/bpf: Add bpf_burst scheduler"

 net/mptcp/bpf.c                               | 41 +++++++++++----
 net/mptcp/protocol.h                          |  6 +--
 net/mptcp/sched.c                             | 50 ++++++++-----------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  6 +--
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 30 ++---------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  6 +--
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  9 ++--
 9 files changed, 70 insertions(+), 86 deletions(-)

-- 
2.35.3

