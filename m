Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4A622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QYmL83pmvYJwQnZzOs6mi9Trr0cYsJq+mmvESuW7JxY=;
	b=atZhKWi+v5DfLiz+PUBrBXtqzzg9znujWgqUmJ+XBK5AuBQYbPN8sSNatS2en505B6PsIC
	5UyXv4TdS/RSCU36cg9mQsqxYMKaXyEzSD/RTim0mCuHiQx3F1H1tTqfb+M2O44RVqS2TJ
	/iNSh0+ttHlgUESPUPW93IPj2buoba4=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-zUSZ5lsTN4WzRy1Qg2P-Ow-1; Thu, 02 Jun 2022 06:53:49 +0200
X-MC-Unique: zUSZ5lsTN4WzRy1Qg2P-Ow-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fyh/77lYcIIF9YWu3l6GBdM/4Cl631vZSI4GAWihno8fa0HMhemzB4vciY1TIOFb9KCQPJBO/UIZ6WNtCO4gIwKaLo58VebgxUSN4kCaP9KrlZrFaxQv6xCptVxYxS/EVI6/ImsKGA/7TUJdwwQ443wQmHlbSwKAOZLSgrsJBAIAPJGMNeo2ptvOwrG1+ySMvOGfBsfgu2kI/gRIW+Fxhn2QDk005nx+m1/7iBbug5lv1KiootvHWnWLFVQNYdfYk2IBcY5XrnNaNLItBxQ8iG5QUSkR97c551neR42mFOSzxejccV1M/UeosydFSm2VGpKS9+TWFw0UlTW8RDyGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgjhypgD3BopJGqBfySpLtKLoSLch3YP2jpc1yUzgwY=;
 b=BpPwVMUXte9F6pOKRhia+i6/EDFHvm1mbn1ZinLORF8keCraagX75HNoAxYOqD4TcDF4+WUPo2tG7Zim/M/Q6yfNHuc9hW7GPDOolMX15dgWC61VUieKIttOxhexyhQCjAMQEDQTPSlXy0znXPYz8RxFlSUz2ZjZz7ALzmgbnF5Dky8oixnjou2pXrVJKr9QHu7LZ3DPY+DGovod4a+wlaQ+d76SGTAIDonQoCx4fGga9/J66stDzSb9y53sH1F93tMQlNZ8T2E1PLfasvuOt+oj5UHNJoaQOFWkqDygEgECN6rtE3iK//2VizYgoghNTl1yWqG86Yaz5joz/3oipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:53:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:53:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 00/13] BPF packet scheduler
Date: Thu,  2 Jun 2022 12:53:37 +0800
Message-ID: <cover.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1383c27a-545a-49f9-a899-08da4453e084
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3384DFEA1D440A702CD3D3F3F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZVUCjynhDjPXK7o4IgkNAAtIgoKcS3kT1TWaobcquzjbktkXCuMbWYWlUfUAxY2GbjxrPxU1yfc1ubipgqGcWC7puWmSNOeI5mMTardMLQYwr8akk0rlRHwVjJAP9XX9ORGpfTiEVburg2rrspCQEaEdjbngcbxj1pnd67VPVOEQKOeDQ2XMm/p4TBcs1o/+SsuGnRaVzDduk+LIhjQuEppwSI0S1lQBNBMwNnJ9YYkWLYQSr9ZHZk5GHQdECpRGzgrsIEYn2tITwobm8Emebj3ucVYKD8gvzVg+PpVsFH2GL1PkpeNbjOKnMooVh5PXZgKfK0WMmsWsjFvBQxsB5fMDJuFl70LaQ3p5UMsbnWzWYaiNlYFRQz6DZ8eFjiLORpDPQqwsUidkH/g+9KEmQqiIu561YaG8UI9hldUqbHEuvaj/TkKVsL2Octjqsti7oTBrCWBlyhwTJx51KFozZesIFOmMMwYQljzy93TCcapIfMBWlRAokIG+rOlOWi5zNRbt902OfcrcCrb9L/myZWEtAK+XZxqNM/CskRpXq5FtL/v6cZvyhiT3qdSR1y2ZT/c3NYCjb3hHx6FpH0feYuHK+j9l5Y62W1OK5HGp16duECrA9Q1vTzqefGwB/60wj0RZWjWuUh/0bYWTh5yWFS8DYR6GSVcUKvtH4tC8VUwlP6OB53hXZvNiH3bRXGE7zT2Gr4kwgYbvASW7keP/RSGzwAxdBign4UgBEgO1wJRsVYHw7TIbnJpmpjdCmF+PRngbZHQ7NpUSS+Pm0tv3Vw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(966005)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OyAYUHi7zMx6vj6TlYTQTr4c6Zh3fAIA2DMHdflqvVcxBen4NC0szaVfQiNt?=
 =?us-ascii?Q?J2luT8pzjF/ym6i5wfX3uDR3lktPEaIggXQZQ2IchBpya85QwIU56TDKTEWE?=
 =?us-ascii?Q?q4d8YYQbU7ejooV6zUnZUuWfAqvihWpSEjTukawTzU9TSLzR1gr9CPyfYpyE?=
 =?us-ascii?Q?OqyJDy3l6IUk34OnpVVlThO+tNyRYRzK4uCjDRu9y+26U4To9zdTgxHCtxjT?=
 =?us-ascii?Q?oV0TrSyt+hBlmR/MUJTaEpWNYqIzfIizu0QAw1JQ0e9HSVeBtMLuF4cS8efF?=
 =?us-ascii?Q?UarDJJvy3P0KNMbEcMvFTVuEi3tC1zrWYZt5oZsva7kpbcgGQUkSA738Ofiv?=
 =?us-ascii?Q?6KBGdOQ4ZJ8lsqRAlAR5CtSR8ltmyGtMF8qTNL4WE3+ub6UD2RViG8XpagoR?=
 =?us-ascii?Q?m7qmMRsg9lGPlWRrifW+1RixJZLwwFIfgUqkKQWI9FP9X1TvZjxrBMdgKmdk?=
 =?us-ascii?Q?ayQ1e4gpAOG0q2JCAxMbNK+s2fuNCsRFXBzlZ21ik3prlLHO2b0zESLI3H38?=
 =?us-ascii?Q?fZUDE9VaSJggvSeVVtdJiScfwP4AKAeqcLcyWq+e/4idMztTTcNRw8CACzIe?=
 =?us-ascii?Q?tgKRoQHMx5HSB/GvL8HQdG4rYeaHRLXsBh9pPFMmAD/BsJkudZHP02flYa/b?=
 =?us-ascii?Q?LMZS1ICRJMLcNfSt56rBpMsnuHoeetcfWDt7JLdh7/ZWKL6LbMgbQG2dHxrJ?=
 =?us-ascii?Q?+Wve3JxbMmU4iTW0M2cYC99v6BibAfHtd09IBr3I8hMKQisJcej+yGfbKM14?=
 =?us-ascii?Q?X0Lb66PGK+Bl1gq2YDyZqQeWJvPyJTzraD51gQcwrLqwYRhnAdSVggRh3VEx?=
 =?us-ascii?Q?X5ldwDq7TR+pIhsj88Nz0PXOYO3i2+LqyjtwQwv2+BXeBzVkz7O6F/DQG8L6?=
 =?us-ascii?Q?oinaR2Qz4rNdDX7GWTLLkIUO+aaX9TArZ0im5hxGOAh+5TYbqpPmT4xaGdd5?=
 =?us-ascii?Q?XuzTQ+ooFMHlR8NLlJkNwItDZSMG/ND1/hrhsPaN51iCWGaqTvI60R/g59c8?=
 =?us-ascii?Q?T3hrLogsRiNFVACiBcBey5Ip6vGekBYiLglHalku3MLjS9ffu6xMlqI3mFEE?=
 =?us-ascii?Q?fwBEon9uikbiAaEZ/20PpT5QYeFEaXMcGxwHIVhpQt+3S2dxpAtEXocZmxj1?=
 =?us-ascii?Q?9LXbJiMSzm4OVllop9cMRK59Mj0nKzmK5IbVBDTMPUK0cKdeNBMfRo6YlVeo?=
 =?us-ascii?Q?vKGoAaeZDFp7Z/pwivrxKYFch+z6DYFzRIcrgHjtNhYXtCYZ+jv/DIr9ZjFd?=
 =?us-ascii?Q?3TzDFRLr26cjlftqtkPqwx8YXXhoBVcw8vZrbktU3AN8i5WxV25uDsvoL+Re?=
 =?us-ascii?Q?29xkX5Or7IyCxHNoJmuZZNn1UHoLJF7RKmW4+Iu+3F5v6SGE/Bc4z1mptRn/?=
 =?us-ascii?Q?IKNL+Zd4FpIKIc5Cr25iaY90wwFBK8aDT45tKlB3kgS3YnAntdB3FFYSkUf9?=
 =?us-ascii?Q?5HQJhrw1VjtGHKEzMhkNjZMwzXct125nEe7rVGhW8E+FibXGpXqVkoi5H3U4?=
 =?us-ascii?Q?p8cTJiJ9VxZ3BpJjxZfcjREf99F9Suacj6WJSpqzn7UcWX6I8A8ELpJ5MtMo?=
 =?us-ascii?Q?LcUO1J2+BeKh92G+uAq2tBuQ5csgLrmgVIjSo0vk0TEFY3wmdguiSFzgkPp1?=
 =?us-ascii?Q?hot5FubZQcHRz2xdQpamWO6kfs43cFlI6+Ba0plPxE4IPD24hodV1YMFCkxO?=
 =?us-ascii?Q?jZFBBMwaUqlyr+yNj0yDirgyVSKFLZeg2hmGUzhx110aJMRS0JlsStTJM36L?=
 =?us-ascii?Q?O/IQsagl6VSPZiJyTdvZaUiTkBGrrfU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1383c27a-545a-49f9-a899-08da4453e084
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:53:47.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ojuOD6SnwcuEd6ARspgCYCbeqI6Ch7O0RrUr2+Kr8qDwLG8GqJSQredLIPDfa6rIEkak03tYNcHAKYNo4ytCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

v7:
 - Compared with v6, only one line of code is modified, adding the
   missing preserve_access_index for mptcp_sched_data:

'''
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -241,7 +241,7 @@ struct mptcp_subflow_context {
 struct mptcp_sched_data {
 	bool	reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
-};
+} __attribute__((preserve_access_index));
=20
 struct mptcp_sched_ops {
 	char name[MPTCP_SCHED_NAME_MAX];
'''

 - split the changes to bpf_tcp_helpers.h into "selftests/bpf: Add mptcp
sched structs" as Mat suggested.

 - split the commit "mptcp: add subflow_set_scheduled helper" in v6 into
two: "mptcp: add scheduled in mptcp_subflow_context" and "bpf: Add
bpf_mptcp_sched_kfunc_set".

 - update subjects and commit logs.

 - full patches of this series are in my git tree: https://github.com/gelia=
ngtang/mptcp_net-next
24744c54b1ff selftests/bpf: Add bpf_rr test
38025f9d475d selftests/bpf: Add bpf_rr scheduler
3a3ff68c3a5c selftests/bpf: Add bpf_bkup test
dca2db73fbf7 selftests/bpf: Add bpf_bkup scheduler
1c4aa6d66fa4 selftests/bpf: Add bpf_first test
22e828c59707 selftests/bpf: Add bpf_first scheduler
fec3332cdd65 selftests/bpf: Add mptcp sched structs
9827fdb964a3 bpf: Add bpf_mptcp_sched_kfunc_set
43422ac185dc bpf: Add bpf_mptcp_sched_ops
4d1b800070ec mptcp: add get_subflow wrappers
ae39f16c28a5 mptcp: add scheduled in mptcp_subflow_context
83e578b46253 mptcp: add sched in mptcp_sock
e69ba4ac0a70 mptcp: add a new sysctl scheduler
1f6ee94e97a0 mptcp: add struct mptcp_sched_ops

v6:
 - fix the warning reported by kernel test robot:

>> net/mptcp/bpf.c:165:6: warning: no previous prototype for 'bpf_mptcp_sub=
flow_set_scheduled' [-Wmissing-prototypes]
     165 | void bpf_mptcp_subflow_set_scheduled(struct mptcp_subflow_contex=
t *subflow)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 - rename bpf_mptcp_subflow_set_scheduled to mptcp_subflow_set_scheduled

v5:
 - add bpf_mptcp_subflow_set_scheduled helper.
 - drop padding bits before backup, use BPF_CORE_READ_BITFIELD_PROBED()
   instead.
 - The new patch "mptcp: add bpf set scheduled helper" should be inserted
   between the commits "mptcp: add bpf_mptcp_sched_ops" and
   "selftests/bpf: add bpf_first scheduler"

v4:
 - merge "mptcp: move is_scheduled into mptcp_subflow_context"
 - rename bpf_backup tp bpf_bkup

v3:
 - use new BPF scheduler API:
 - add backup scheduler
 - add round-robin scheduler
 - check bytes_sent of 'ss' output.

v2:
- Use new BPF scheduler API:
 unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
                              struct mptcp_sched_data *data);

Geliang Tang (13):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  mptcp: add scheduled in mptcp_subflow_context
  Squash to "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add bpf_mptcp_sched_ops"
  bpf: Add bpf_mptcp_sched_kfunc_set
  selftests/bpf: Add mptcp sched structs
  Squash to "selftests/bpf: add bpf_first scheduler"
  Squash to "selftests/bpf: add bpf_first test"
  selftests/bpf: Add bpf_bkup scheduler
  selftests/bpf: Add bpf_bkup test
  selftests/bpf: Add bpf_rr scheduler
  selftests/bpf: Add bpf_rr test

 include/net/mptcp.h                           |  7 +-
 net/mptcp/bpf.c                               | 34 ++++---
 net/mptcp/protocol.h                          |  3 +
 net/mptcp/sched.c                             | 60 ++++++++++---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 19 ++--
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  5 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 ++++++++++
 9 files changed, 273 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

