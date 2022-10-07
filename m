Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B7468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT4xU8AEMSdac1s6M2crBFiv0xVsQav2IkY48QIiDQAzQysQ+RPzXGceYo2Ukr/f2hmghuOtVpfExIFBaEeFMH8I+RxIQBo6e9Kn45LwSR9H/OGWBRUz4tjLVQlcYGO5pAVxnH9otdrFvoGcwoXGQP99BZ4+6QQEFQPBZH1YUxdOXa/LNDdVhwplfMENty284DG9/uYNfbYXypitJlVmuSZFXF9XZfqVVpQRsfBdmL8rvPS/odJw8irrCcwHyVB6ZACTgXOJHn2Myodf/HNKLK2FNa6uzF6qseG7d7N5fXRs3iSiyFrCoBevOkfLXQScmnmgSAv1C0/EruKJIgtpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzlSSmSQgHn3kDkvpL/2Xnm8lIFDUbUD5W53C8Eq1cI=;
 b=LqYGF9M7rYhRdjORPsO1CcXD2JRHH0tFaAHc25PJN0rBm5MEBuLv7bLeNbbnu7mKiuxkPBdm7S+A9PM+/HCCWORdqgdZOuL25YUjDcAELyEGofZNojE2myyqQi95+vb6AVIIi6oA86BnXil2xpK64Cicn+Yf1f5kzb2Mm+tA91Vxuq/u6vmR+srKKx1Ovd4pTM+NJDQiMhbHOSl9ygLMfBkKqGOdwc8n8F4tpG1GYWtbmkFI76P9nzGPqB8GSNjfSg3z5o6lpuIdv/PJgv6TM4uXYYUdDE9zlcQvnnXf4N4FYH877LmPIlvcEZlyy+Po2Ls4EVkyK7QoYQwWeE86Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzlSSmSQgHn3kDkvpL/2Xnm8lIFDUbUD5W53C8Eq1cI=;
 b=qwCVWaem82rEEKSFdzuYf9DP6WtqEolcSpi5a6FqBHyoD5AHrTz4FMDI485EsZiP7ywr9XxlHVMk8zaDgBqBpwSzm4OKvozoBCU2bPopAdSNexFwYXHE4sYZyRgqA2bi+RsVkpGWOlSdtl87oDm9KDnqXApNE6FIzI2V+dT5XeFcq7eS35ViwKNNBWRYm+h/BiVf2OTUrElAgzCjLNzuqdfOerbAHNYFPrgpx2fqdpRFOWCvQ4Z4ZW6fu2POCkMPT+VI1VcCVAc6oHL3TpbZFCCWr9XvZ4Hf+uEXrhLPhBWj2T6jksjhzt/4kdP2urHuWcAsyZ1MrX44k/LoQEXnAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:01:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:01:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/10] register default scheduler
Date: Fri,  7 Oct 2022 23:02:24 +0800
Message-Id: <cover.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0933d4f0-b07d-429b-2e8a-08daa874dfe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	92Pj89+38OwPgmDDsmSQzgATT0nBA4dUcjTQJMRy4tMPfFWKLt/ePt8JhX3+Qj97cPfFNLL737POoT0ASP7VUQRONhHFop0BepyOWBTEgTfIOj6o2AtEuurKC7+VEYiqeFe9212VMuAblSqAIUDITdPYQyfIkO1eTtHeAqR3hdh3LgXawTJmDbngINmuZ7fsSjNIavoh7liSa5sd3sraDJ4r36EIS4z30sbYghU9TyQ2DPpdLMpl1nSp7H9iEYwPyKgS3vDiSc+Dq62ErRoOY7Qc3fBPssQslOypkywxuy4N2Dg1f9gKMVGl7gh6tzK96mSCYrTMv2LX0o5evcltVaPDBvrY7mNMcMTsie0liMbI2/FhNEvG1YDF4+HPV7GHuD1z0VIVxqYHtE+3c1byOX2USwHPrWDAYPS0Gm5HFYRMhRP3rEfzX+T8JnLSu8Lcdp9bppptWudMsUiBPp1H2cMAMKTWtAc4PGUFyRsHrLGb6ATpRdJDQEtzwEgK59lKs4CBDQQBVrGc+/iCBTfc61jPgA+Yi/Z3q0Y3k4/ahrqglxI574tx92wpSadL1Nk9L11NClV8f56sOBUVzNPCo2cgl7JEZCAT3DeX9V5vcmlMRVCecwK2CgAXpG+exdVqLmlq8Rp/5KgtJiTPPg2vtuyFLwFaG37pBk7TQaKdZh7jcGetsata+UCsCJISB0kzfgHm7CR+bf3vTRxRHGvTJCnGFLkhs75nLAA29uNp16Ku1NqOPpJhcNa0+KmNH9Ib
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(4744005)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?szlJCGc7xUlcvBxBXkiQWG0P2cKm9CKf1VEt5lXdK8iT2+sdMEzaCvdRYp5T?=
 =?us-ascii?Q?X4aS/wMDWIEf7O2Yrni3weh/1R7YuSesOgrHIc0j7zSICV9LP32Wrx0oZ6tp?=
 =?us-ascii?Q?Ba6vAsOdQ9mtNaVvAm6nDBbdPn6WGY+9fnp7J6Y21CzzQPrFM8qKpE8z2Fvc?=
 =?us-ascii?Q?QQ3lwSrJ5TxgrBQ7Ap4nBorpf6FtwtSUgIw3rVdXuCdjnseNlO73v9dn5zf4?=
 =?us-ascii?Q?gQGoU1zXyi3KgtrNh96nl804jLZjSeld6+VGGM4v9VdZpPDgJD69rRWWz+V/?=
 =?us-ascii?Q?652a94KYC7NgKmsz9MyXoaI5TeBNl/mj+lx+1/GOz8oe6nt1D5mza8RtKUnz?=
 =?us-ascii?Q?m3ywS4XjwO4jAe86I7NGL4sD75fN7p/nH4dnoatJbbRIQCCb6UGpI0pdXGlZ?=
 =?us-ascii?Q?qtFUwXBszOPso2KLfMi0C4M9r9++rprUzK6U5qb+qD/VzfMSovYziKof8NyV?=
 =?us-ascii?Q?IrqNO3uoCa5z5oWuKbDycMLhadSJnBzPwpDOyWLcyZ7WW1wYDoxhZ83eNsYC?=
 =?us-ascii?Q?sbTnDelvP9ni+zWap0gf/FW/ubBDjCplJeYhKS7mGh/79q3T7S6DDpmRmL/t?=
 =?us-ascii?Q?DaF7Mx+vecOX8SUcFdnzA70og3tanuwx2YpxZ6W3iBCOd6smMGMMro861law?=
 =?us-ascii?Q?fMV8w9pjknFHKEjUYtHQG3fkRcPvWRoXzxkGeeMeOyMpC4da6T/hUizaFvKm?=
 =?us-ascii?Q?hdIglu1xeMUT2jpf3Bx5llR1/aq3M3s8ZsDDuEjv2ULYvW3EzJ5L3P5q2T0t?=
 =?us-ascii?Q?xm6vuxxlUFRb1v4OCqD52DfzO0ylr/8/0LiZdwiJfHMxVi8XOOlcJqteGns/?=
 =?us-ascii?Q?+yEDjB7kzpDOZSBlHQNtO8h2/ozf7K/bN1CI30T97/Mz/I1dVoLGSTMmOftQ?=
 =?us-ascii?Q?usA7/YY/BwOw6cAJqIvm3Nwox7HVTyo8hn/M0xsFfp5U/B8rm3bapu33awpg?=
 =?us-ascii?Q?PhEj1feUCYjcNrkfJeTCzbmRFOKJNoG1fPOmXI0554N487f9Fgiu1Uba0USr?=
 =?us-ascii?Q?uUPvSqNdcJKCibZyhWofJVnCsONZA+6kUexDQR7X4a3dkXCXTF0y8RPKB906?=
 =?us-ascii?Q?E2KIqfvlwvTKQS0z+Llwk90PQZGQHx+Exhq03yHYZvcdSIGQGwY3nMe1rpS2?=
 =?us-ascii?Q?CDJgrZ+AuBx04vWuhJ5cLMqU6FsX43k21Ay14sAgnSbY//eGANdejKPZmh0Y?=
 =?us-ascii?Q?2AbMDDVAEZpGC+uvhyB5bmr/Ht+mXmSRPPffjUbokrJaLD2hZSC5t3uPofmN?=
 =?us-ascii?Q?8+ouXkZUDxjB7+v4CzyOR4WyTXJVEZkv/C/Bd34LIeZyRvXxhybN0CshtzJ1?=
 =?us-ascii?Q?e0CYuHKfNG2Ck1YgJLp08jYk4Y5re0P+sL6geHFMzwC0I67wOnMCJ47huwYl?=
 =?us-ascii?Q?gVZA2TivpaS51aHitbK5mvI4FL7RTDP14vCB1rnbJgWFE6Msw1B55jXjYskA?=
 =?us-ascii?Q?o9A1l8oWPuXTiql9v00XgfJvINFb04WqtRYWjgUlhqvfmNW/XwCXmCTDFRrF?=
 =?us-ascii?Q?iqlftQti7737cVp79mRqq4dszgA0h3L4Cb8QC7KgTljiRKSqoAhQNeVVw9Gl?=
 =?us-ascii?Q?HSjl/XnAMxAtYgUQcJi92gsGZAfeDe+qJ4jSciaEbnELKTG4jfYjqO5CBDLm?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0933d4f0-b07d-429b-2e8a-08daa874dfe5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:01:55.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3c+1C4EW5DSVUR/9PKKv4hw11hi8u72/pfjbF0ax9U2hvSWgPeze4XgHqQTdDm+G71mII/JEdGD6WPYkjCk2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

Register the burst scheduler as the default one.

- depends on "refactor push pending" v5

Geliang Tang (10):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add get_subflow wrappers" II
  mptcp: add mptcp_sched_data_set_contexts helper
  mptcp: add mptcp_sched_data argument
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"

 include/net/mptcp.h                           |  7 +-
 net/mptcp/bpf.c                               |  1 +
 net/mptcp/protocol.c                          | 33 ++++---
 net/mptcp/protocol.h                          | 13 ++-
 net/mptcp/sched.c                             | 91 ++++++++++---------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  9 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 10 +-
 9 files changed, 116 insertions(+), 68 deletions(-)

-- 
2.35.3

