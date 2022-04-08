Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EE2564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cGy4CGoVtJK5iqXuIxIZmkQvo0pSEJXJ6HPM/Sh0W8=;
	b=C9dQBUrCcIuFyLlu+PAqsz+iCuRTvE+ogiAQrIPU3c3KLJ1t5xqvbEqniRvnlD/k2nX/v8
	n+297JrFRjenEwGJsaHSU17GRaW4XGcIuDw0Yk9fVrp7yi4L1gtPEy6iKlTJmQ/dr96FJm
	JIWt4pEoafB2myca5QH3XgSXOx1tIbM=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-46YCn7wPNDGCgkd_iQZbrg-1; Fri, 08 Apr 2022 17:42:29 +0200
X-MC-Unique: 46YCn7wPNDGCgkd_iQZbrg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYMhuku8kQ3APFVlLCuuEs45V1QPvpiVMlFK4ZMeFbrA4oBIiIFWv6JxBZIdakbwy4Fn5LMiip7ufb0Lerzw1Cx4AiG0sb6qJ9HSEca/4Mtid0kBMjz+hxHTCIpEXC7rtRXMuYr0/ecVDrFJZ9cvVyUbd+Jtf4rrdhnyhlO7uFe7EPFrKG2Vq51D1nH0SRhBhEhDGKjCq3jqZYCxHqEOD8AN8+jqts0K8DgVYLU/Z488wfIwlYirwm0zI1PjEjcxv2XFS8JnY4vLnlJz4JN0b/thNlYkeQxzmDSxfgogKTxL+/EOxxW7YUT4KiOao+dUG3M5gKKjs1h7vk8bQe51cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70BTacd+Thd5F/6DQQreuSmQwBMGiTsYOi1f/7DhjTY=;
 b=Sta1lAiXrWpWcYF/euECz1e+jNc5E/2UnRT4cb8BF27klVVhSFApxhRnhlyIOgWaAHjBAVTxfFk7Q+I4jMhV2r9dGBv3AZ9BCrSoyF9JN4quO4zoFORXJCvHAKYuBsFfbCgRWVlPKs59b/B2ymikLmvlvTrQVRK8hsEX7cUZfqRnF1xvs0ktNjlhkCCqhw+STv0TAeuhNafE8jWwWnz0HqFtNetUUglMnkHhE+YfvDPqhr87c6rs7rl/Gfu4CRnW9YNok8gl0Nl8Hj+S04LVbl4H4YpSlGcyDFLkVm/8JfcGoMEFGUFjOoR10/8yDjlyB3mW7tOeslM07wz6MwIO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB3957.eurprd04.prod.outlook.com (2603:10a6:209:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 8 Apr
 2022 15:42:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:42:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/4] BPF round-robin scheduler
Date: Fri,  8 Apr 2022 23:42:31 +0800
Message-ID: <cover.1649432434.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:404:a::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5acfd18f-58af-4b74-f1d8-08da1976614a
X-MS-TrafficTypeDiagnostic: AM6PR04MB3957:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB3957BC737A50EEA642C30B3FF8E99@AM6PR04MB3957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v9boD8K+EhHfE9y/dX+uxLKAJlvgbj+SJ/PN7B+lloD02lrv+24qx5ut6GKNi5KD4kwoCNuvq235NsnwbJFWNJqR2+SodOYJD263X5huRhs54e73rPvxIo31wVzO1PkejWmLVY7juNprmm0IUoKn0pyGyyLMow8+CmtMXtF37H+HM5fklURlufB0LgyMVxOp6IKvOxrWxzUtNdIVxx092UIBUYxXaD7rNDL0J+CbRmWikmx9GChcKwSVCGIVrvPeJeG5igIIx2mbstfkUsEIBcCCPvbezkiB1QUasntoMoFv1toBag84D/JAmOmCjpDvn9kZzbP6cUaKfcw6L8CGd255ijPuMhwa3MfHb/J5ZsftHOuyusuVjPQLyjNGWNWDwzM482i/YZVi36dewZSjBOcgsnjWPtNRMeB2Fv6K3ddjake3y8knWxDBQ1Q0PRJhLmpk0Kp2PUeL02hL7fIT22blNltcb2FearWNqybh207fhf8dHtbPTJIwCEoess7+ONVqGHNJWyzajNP4F9ZLZ1NGnKLeLL6bKbVITtW5BfHqdf2psCNqahEf35/3zTVdwd6TjhG3WvpdTXKSHpEydqR+MiNPZ2UUJfiAgSaj5H+/Qxug8/VelvH5LMhk8g6D8i9XlyEFeIruzTuy1qjdQ4K2nlTrVJAldfb7lzoI62Jv5B5XTOORnDz4PMUu/hhXe/n1yAhP+BYZNWlxc4heu/ugNjdnnhm11A+5bSh+6RopgR2PDrgR/C2xl+uEMq7J5GUaBsgLmpoeY52RJtqxPFIN65+wLoV9fl6Qzs75Jj78NV3nmFYDfvym3DeU8eK8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(36756003)(26005)(6512007)(66946007)(316002)(8676002)(4326008)(83380400001)(186003)(6666004)(2616005)(5660300002)(6506007)(44832011)(508600001)(66476007)(2906002)(86362001)(107886003)(66556008)(8936002)(6486002)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZ45sSLpkHTG7M7/LUw9SPbCj+vaz2Z4ZY9NjDhdeI+qi4I2No6ED0LNb5l1?=
 =?us-ascii?Q?ozp2ANyJAVUH/wBTW7KZ5m9dHmXUmA8ZA023GGTgeezPCOZKSjwaMtMUdvjl?=
 =?us-ascii?Q?Rk4dNG7nImeLkoDzYfR9mbGP0UuaRNmOg50F0PYIsxSd68oWT9VdnEXZoL/7?=
 =?us-ascii?Q?6yVdH5i4x7g8P6IX2ZdvB1RFODgVBVLqMKfRkusd3yp7lCKvirK/cTMbdrT/?=
 =?us-ascii?Q?Fnd6T26ag84gqnVdY+Nq78lNgWBb2uA1MV2S9zaZHn21V+B9Sx8Kf+B0Ygug?=
 =?us-ascii?Q?M6fVkFhINc3KJ2ZnGBuXTZf57I2qiEWXuhP/T+gMOcY9kPqcNh6uNZgay7yM?=
 =?us-ascii?Q?AnKR6IAL/yP443yWFK7QFmVTz0oq6j2KBbiewbBa77NXVda3Hc5kJ22JfwTx?=
 =?us-ascii?Q?qirvHZkMRlBYIwrzt79ppnam5fqbj46Rg+cZNXWnfW5WyZ1FhdD4q3Cym8tZ?=
 =?us-ascii?Q?NpEk0FKxC3qYwq6p+2nfV5JSSgb12yAXh3OY3c2DI4y+qN4dIdHmLhavUAtG?=
 =?us-ascii?Q?xtq7dB1pGHcUM8J/LFfAqSmoWmu4tnSjXSRIwv/ncRTr6WjU8TKwl+BQ822k?=
 =?us-ascii?Q?2FlrbpVMU3UVqGDvvxYJdjxjTDUx6oMvcM/WnQZ2REdoJkQW4TvKnexP1sFo?=
 =?us-ascii?Q?wZT8zpwJLVM/QPX5Ld+cT/cBM8iLzVDFOP4C3LeyjFC9vHBIik/ArsajATq4?=
 =?us-ascii?Q?nt224WzQ3sfEM33Cfk1jtBT3vgqX5uG6T89aOjjYEFC52n/kSfBxrRF3tvo5?=
 =?us-ascii?Q?dI6BbWZM9NA6cXT0Tj9N5c2snLhQqJFt9W4lFX/ouXKoLpDBRvw8CdjTPDKH?=
 =?us-ascii?Q?sWdi9GPTRDktoERoKqMlWWoUqaqP1EMBIVvtucLzZhx78hnCq1OcM0be5bkK?=
 =?us-ascii?Q?uQo57nGASk4jx6TtoyAObshcm1545AccTKh2rukFNSwRE1jR0UC04c0RTiFC?=
 =?us-ascii?Q?uRF+bWbrgLpkAUc7EXnxHvdMjq/clhB4fwOcC6D5iDIhLBZHRaRXQVMFYQN9?=
 =?us-ascii?Q?An/LbDMnDSITR+0PcWfKo8LfzHsESjxFPWmShNiGcg9pU0Z9pmovwXw3YXyc?=
 =?us-ascii?Q?Ap9r8SDmbMJ2SunPgKsS744Gw47ieuR5aCeUTt/dtKx4thql3dPCHc/SrL6Y?=
 =?us-ascii?Q?VG6OSViEzuxjl4AiKRaFQfuqRlsfzbHfiIXHr6f5MiUpIje/AT2LoISd4qUS?=
 =?us-ascii?Q?9OiiErRTWmThPrM7ku2/NQdt2xXvZjb1q01VDfsVXpGp4Qtl2Sisw888er+P?=
 =?us-ascii?Q?KzXQflmQE2V164t3tobvdiL9HyifrJUl05XvQsh3dAQmCuWUrB0WuM57OAb/?=
 =?us-ascii?Q?6sNEy7mwP/vcRNJfaQRCHDJHTsKJ5HhUB9OL8ECHqxHkYe+R1ryQcZjYTwWa?=
 =?us-ascii?Q?w/MduaS02fMWq3xdh9eHLsmw38XXnWyhXfuAt8KrbRBRsebpXKoSkFW3kl7h?=
 =?us-ascii?Q?zmPitRuxQW45E4q9bdcQr/0odbXawLqV1ZfxVcFl1+08ej/q2kRfh2UhROXM?=
 =?us-ascii?Q?wGlK6Q2Yuw9W6CAUh7quVE/8beKw43Q9XuIj98nZfSEkdMN4wAt7hOjMCDnE?=
 =?us-ascii?Q?WXUHHMdBvRc5nNNMJDIGZMDNDyKN3DFBi1gXiBhs91OXEP9oI5BOQKgbVtFy?=
 =?us-ascii?Q?PXPH0BNjY0wp5ukECkK/1tuC8Ly8Yt1RCIrlmNV5BwVJlMrBkcx47IHPWpy4?=
 =?us-ascii?Q?GQMAt+Uc1w/nvktQmm8HEpzbODd+4YUTjeiX6Ekpnk6lY9SBTl7BqGLoS1mV?=
 =?us-ascii?Q?VfaAxTsq47rxCd/wZcs1gl8rcPGcRCg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acfd18f-58af-4b74-f1d8-08da1976614a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:42:25.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyQuNgVLJovgBbo9i2YkKkhPnAO6RVFtjO0fNELD2ron3rh16A6LosdnmFhcj2d4UCkrh6WwS+asQUT7adnNbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3957

v4:
 - add retrans argment for get_subflow()
 - deponds on: "BPF packet scheduler" series v11.

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

Geliang Tang (4):
  mptcp: add last_snd write access
  mptcp: add bpf get_subflows helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 44 ++++++++++++++++
 net/mptcp/protocol.h                          |  3 ++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  9 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 50 +++++++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

