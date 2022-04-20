Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0287A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 05:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cd9tvbX5PmB6IO1Z6Umyf8sw7JmH+rSzOQI0lOoT2Y=;
	b=NF7NA/4AGNU/niYFwXNxB5aW18UvQP2aYmOFOI2c5AbczQLmig2t5CxR3OhCR/JMIWkifc
	qUjZyfdL/IB9tMfTYvz17NF7AUXqpdVQaqRjHzk6dJvwjGWjsxLcR9Ry76kcAD/ERMcs0O
	GBiYrJFtys+EMT9lH2c3NW8L0qE1mHs=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-eNOwk2KVNSKA6PLyrEwuSA-1; Wed, 20 Apr 2022 07:02:41 +0200
X-MC-Unique: eNOwk2KVNSKA6PLyrEwuSA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOdTpAcwOqe/ygTInF5A9DnwJBOOPECGde7drXtKlx44AIz3ZzpT80w2uXWvJZ/3qRFvEeuvolyAOzzIhCm9NbZhv5TKCR49HTwOKXkN/R24zfiC2wdShflS7Wk/0iqD59q8lfkD5QFW/bS5Xke+VUx40Rnfb9XtUnT7BaKhrMwSLQC/nop9q4zoPXDuHqf6NiF4qh1NwdGXJEytCqQL4epKx34OPOdxytW2yUnKEeG7AOEh4g0DgBlewMCUnW5lRw5E2HlZ2paLlYavHmdG3gNKdqKSIkFObwbQgG5jdES9MdFkk0jWegsEozaQOyoVuB5uWjnLMztvqWemisdHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GruCbaXTYsRw2tPGG4NrD5aw/L6220P7aJNXJgRJKUY=;
 b=AhVQCk4sOc/mjjs/byh/H3leg1dRGpqLmb75snQE5VrFzV0z8WV0rxDlz1N82+i6KvO5wh5eQ6yKUU3g22Jtog8kUrCVce6Pg6bO4i+XedVMeiSRuDDVWRwZ6/Q+w0QoYirpmja086QBlqgsea/dSsvCUZumpbYOOHr1WWk1RCsGvQMay6rx2evAz76xJStQZc2kcqSGFk4EfrKtwnTSnout4fst184kfQqw5UJ5yry8JRfZmVFJGcV41a5wJym7vQpYUEKKNL620S4ZSngrqZ/SsQ+HdNpc23XCFl4/5ikC8E+8FwAXv7R6Kw6qzzYBuFYGWPIQNTxTwqB1dz6BOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 05:02:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 05:02:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 0/3] BPF round-robin scheduler
Date: Wed, 20 Apr 2022 13:02:52 +0800
Message-ID: <cover.1650430881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8dcda68-a459-41fa-8b42-08da228afcd4
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4303955EEA5601EF37098E27F8F59@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c8B+QSmQuQduc5vL/8U+e8lFPtivrpuvKhJHwSwT8+QBZpvpph0IZ1Xd5wu/zyY/KRWERI7MSyKWcymg1pVmQIRFIxRuZTNHLNeZ9E0o7NM7DomrC01TBCnZ5SvXEnikZ4ZaBy/HWAuoEME8ZMOHZRZ6JhrTs1YA3xkauyUl6UTa+r+F8dT7nUbklTmAspx4Hum5iUKWquGcF1sjXJ+hOBG0C8/bmqbjzTD63OHjVXzseD37KVXA59og0mRBCV2QXyrsNjaNcGl9GAG0qm7Uvgem07U4enTXQF8s5MIJaQg+pTjo0pHyn3W3hQwIn5VkwA7XWHryq7vxb15NKFPU7n/g9COBG04jMWVDnb4zu3NtB2HReHTAukTVhU5bIUF0B/m2OyDRN+Tu2bIPLovE/VeFPZYufIHfnGiGcON4fVIKH+YD5WAQRU7Xre+wrBn+m9shMF545TvDNw9NxgmynEWvXIxQ5hYzHRim/1JyucAE7tY3fsQkkO6cVkTrjp+nNqEWybsD39dJRMBqPwkhbciF5HV6tabQoIoR8iKMwJLGqhM63W21uvUaszyTbk8KWCjHaXUFV0McZETyawhwdjjbTZH5wTaG33s215Xe2nyZa9Fh2qDpuUXMBY0FY9CxEk0i/9Q1Z2atD8BLqWORS8Th2ijoUCkUpAUWpswa3Kmkrd0S5CtcpPvAHnNJwFDx+dOIG+TFoipidZIUnlxi5Sw/imBp/1W9LLGdx8bJC9/XAepuHxjGPwlvQt6CrR3B2Dbi/FlG7OYx7pRq9jb7IaiXsxd5f2NDuQICXRBFZCee3kNv1oyr5B0zD72o4IC7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(44832011)(5660300002)(26005)(8676002)(6512007)(4326008)(6506007)(66946007)(6666004)(8936002)(66476007)(66556008)(186003)(2616005)(498600001)(36756003)(107886003)(83380400001)(38100700002)(2906002)(6916009)(6486002)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VUu7ciLCEhn4ahXfj3tx5DIcOsCDXLcTLqWeH8SGYSFKIP+SRY1isabkl4Uw?=
 =?us-ascii?Q?pIdZlFyyK8oVBJ46udDFJJOok7wC76/ZNQbm/6EhvI/DbwI4XhtIIX6+ZtCM?=
 =?us-ascii?Q?fZOngHPS6w5SHUMLqN/l0XSNdkXwYvTocE1ajBwc2O2H+8Xn15WWM8SoLJ1Y?=
 =?us-ascii?Q?2samLFJoKfw2EMSAy7ZfWqTsdChxrg9P8jQK0zFBaR1zF1Vde/Fiy6FvVjTQ?=
 =?us-ascii?Q?//LZdQ6ztlhznotUKYqWKMUs+Zt4H2T6EkUFXjc0DbiqRJuae2RMW+pINr0B?=
 =?us-ascii?Q?wm6CgRbZMEkZTS14VJjbyZQ2re1XUcFSlV6BQ9ihrSk2hMIlOnQ0U0113Plk?=
 =?us-ascii?Q?iQ3mSQF1T2BMfvPnPnNQ5b307LnqMIWrmU5zv27DqhdKeZxzv5+bOMrR3R6o?=
 =?us-ascii?Q?Riq5TW2x9/77FfvSREZccm4K7SAfRX9IBQMOle5J3I7HTShy55UOoqHzzEZd?=
 =?us-ascii?Q?xuQ/KqaSzn3oL/ThEswEbXdGRp9dt/TeO9QExq2/CsfaHOtDchHWZJz5xCsO?=
 =?us-ascii?Q?vS3sxdwiqxpxiEXkIbaf9dttDJbksVGTguOqHS6IVoyLiMubCMHQUK4f8wgw?=
 =?us-ascii?Q?flNwrI2IpUyREdx94zHEySlcPZdyqbDKISS9j6HpZ66o4tpl/kol68hBcwo4?=
 =?us-ascii?Q?JpCm8LRMjCe8WQWl7JRrYoCCVmeED/WuOVsF/qhvvx7yHEnpwPNGVGZx0JB0?=
 =?us-ascii?Q?QJ4lTKhSDmAA5DsMP/yijJzDIBRfMVwBYA2uKhpXxbIBhbCdxUfjAhSIRfkc?=
 =?us-ascii?Q?HrXYqJEk7yvHvAkHBBkPiIHreBcQSmRPZeR6JC89WyKVV1TMilw20FUVJwfG?=
 =?us-ascii?Q?Ky5jnLMNL0kT48oR+jJsktUgcQSbUWa36w1DAB1LUOHDAm+ORBsHrb4MvIrk?=
 =?us-ascii?Q?iGklfbx/j1udVsNHKrBZSEWch+eZRi2jwILMDgFazVQv4HMkyPJe57UoHI+Q?=
 =?us-ascii?Q?dK8LZvWjqlmONrPRitPchzXLCpfZEA+9jvz8NO7PY+eOPvdxgczXnW9lFLs7?=
 =?us-ascii?Q?L4vtjcU0f/o5s354tzMUMfZqf4Shovkg6IcDYWyBF3Viq2IDl5s+bq22d4BJ?=
 =?us-ascii?Q?eMCOzgF4i0qhKOxKopjfBqNlDsbrxHQ0W3TaQaArvhlIgoaAgZQLhIyQOd1c?=
 =?us-ascii?Q?K7tQ+5N+JKFHjdeZ4c2Dlkx3Z1p/MDz5LUBLqqnbjPs6cjP2jrAXc4EFF9m6?=
 =?us-ascii?Q?br7fJsnedsjzMootyUK4wHyejCLGaGRft+jO/qmdrmdKbxIJ+cClxi7TWIqg?=
 =?us-ascii?Q?/2FPwMdWnT3ERPJzKVTaNUKn3woA6eoRd4Sw8bMzb1oLHSZwG/b9EnhhuKy2?=
 =?us-ascii?Q?LrQfqFAEWwRyYIemCSOBsWx4n881DG+6pSsg+AiTmpUln+XrJEjrU668DkrU?=
 =?us-ascii?Q?a7siGokEAy6DV9+v09LkwEWOLMREcl9Rmu6sq6hPSYpSEisn5lKJ8lpgikTc?=
 =?us-ascii?Q?FMFZnTsqOwmvHIMzYvY8ju0I8xdKMwrtK/AUvMFbK++oL6MKXPwx2GA5F23H?=
 =?us-ascii?Q?GpnxDhdxe6Fr3Ew96N8J5kjIQq/BHoOf14tELkG4ve1e8Im9EjADsswgrTRc?=
 =?us-ascii?Q?QNvkEEoRvxCtj5A9oT2+oWlXteqKnuN4erjyUcLuveGJwh1Jr8ZfcUyoHuHd?=
 =?us-ascii?Q?Kzo3RZU6u31VfF4FsDzT4/7/TMhMSMTdWwinNr9OAIi2AlLNSKdA9Bma1yGJ?=
 =?us-ascii?Q?K4i4RwGXSaTXymMs0CLUCnHGmv6kkvVyawDQ3MNMRdu5zg3miEnC6HHg+ouv?=
 =?us-ascii?Q?MkeFWfr8BO6WxsUv0moF2hj042g9N/s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dcda68-a459-41fa-8b42-08da228afcd4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:02:37.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laoDTQ1Wjrwk1J9RX5/kqjg10t//m22cqS7kf/2pz8NJ8ENrnstmShBzzpbbsk8RMxF6Ao0PyYXVa/Xjul6I7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303

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
  mptcp: add bpf get_subflows helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 44 +++++++++++++++
 net/mptcp/protocol.h                          |  7 +++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 55 +++++++++++++++++++
 5 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

