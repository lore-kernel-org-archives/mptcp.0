Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327B23C8
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652270961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WPlTwMaLIAXUb/g0jyz6UU4og+u/GPXa8ISKU+gGy7A=;
	b=M7N0s29F9oKuItxPPjoZccR0OhvLYtsZel8FkeNxUi4eVMv1ZLpmPz0Q7oD3fK6nag5w9E
	rU4VEivwX+kSIV/Xn2qdflB1Kt65r15mmmRoojIsH4Sfk89gfLmpXTX5E5pR+XNi2cnach
	8iIS3xhB3/+/ZCWsmWzZFL5GIrnw5zA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-yRU1rWxuPg2JMFrcb1S8_g-1; Wed, 11 May 2022 14:09:19 +0200
X-MC-Unique: yRU1rWxuPg2JMFrcb1S8_g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIG3O8T+6QRAUFP6w/DcIS4u2eOhbyEKZ7xrytifSOn7QefUUJWjoFRdDo4OT0ZcI5OU/c5iLHW9VdW5e8y1R7QYHHjUO5y3c3ELnQOUpeu2KVXuS8/LhTbLqwSaAW96Gjw1vp5MrjRyQDhs2Cyx+NGWszEphh58B8gdXKzfpc+1GDUhxyEdMVs/DclPTEgYRnXCT0zKchKpQD6DBBQWlQR2UjhuEOm2lpxpOBzSXzni5fuxhPt+IrGYmzFooocyFJu7qdUmd2+D0wTfhJuukKEcgRrt6VX+3qmnu1XV5gHH2b3uBR6MayC6VIK4zYWlGv61G5LqHar5tx9Mqqecxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDWDPKc1POF8N1Ahfg5gznvmcWYSSWW+Rhs52CKFtP4=;
 b=TPkFvznbi7IrMLgs05sLPogzTT5Bebj4kEEu6cvzD3FBAidObnnvR14A/m0rqJbvaPSkF1en19CIOv3xzZ2LQajMyX7yUJIsS0Pg64o2A3AVfU/p+WMia0gCqX26wgU74kL8QAMsP+IP0/kGQQ1FARooZA2421r7W5kihqLDs2etCTCzVcfUkx4nw6vqWY81vmaEjqw7z7RSkkXCWgO0socceO+Z28FueGz/aAx6J83iHNaGw0OfOwBgSqaW2wGLsmhJuDiI1emIJGmbPQrXVUwNf39MxW2ONxsgoiL70fKLlFgNul5V/hgP+h7OR0LIIk7suwvx3WOWZWsaM4hHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5716.eurprd04.prod.outlook.com (2603:10a6:208:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:09:18 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:09:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 0/3] BPF round-robin scheduler
Date: Wed, 11 May 2022 20:09:06 +0800
Message-ID: <cover.1652270663.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e9e88e-ffa5-458f-9074-08da3347126f
X-MS-TrafficTypeDiagnostic: AM0PR04MB5716:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB57167EF255353BABD89D4335F8C89@AM0PR04MB5716.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4hiBt5OXNmQA9++W1dtbHTIBOqDc5rt29t6SuAwKlQJCQw+lw2d5RWOuBJzXm5ZuP7rkkMl7pLpvTDFAEGGb0/uhAxxvAXpBAk9+TevoQVC8vZpzhdw7pcX7Ix6mwaJeUCOVaxMTvThmx1bkNSUlqsB1dueJJ8d4nHaHjBB50/ob1HXchXFhRA3L9Fy2T9ibPxQGnjOtpftiJWDKsAUm+ykSTZeN8eGt6Z9+AyFFWs1Hn16yS3fIUi9qHbYuhiCD5iwEbuX1KA0l7CQS6cQPmOInQy4VCw1ikSxEA0pG5lnH8CvLdEQRTdIQM3jTN5N5iRfnNq/9RbiiypNF78wLa1oYjG5d9GDn6cuxYPY2J1lbHg1Bx+z7RAD8bu/ZV4FMehGL4VHWdf/fTQlx+sA81Tgr9REDEhj1oOLp+o39SNpL9wqAf6tn0t4CauH7gxj4LzgRmp8EzAjAynCnZn1ZSGD/iHBVZ+EOrgP2u+Iq5QsHNHyxNKklEmMBqlLiKROyNW8dKTfTKKzxss3pnF5mpGP02CpW3PQf96YtCE5LMbr1RDFdG4K2t/vA16bxapFByypthhKBGSnmQtH6VrzrQ2VlfwzZoE7j8NaXfmFrPZ+0dSpUi9xEwaNhO9OhduFNbbWs7i9ALKMJadFigpdRO4RQQEV89eomRSDkNoWSWB/vs/b3yKDbuS++fxtC4veqPIr7KKysENIr9vwEvEDIxBHq7M6kMqFOZphxUGUoSi3Inttx1mK+u8CQnTrMcxDJQxnfNasktnnYwALQDE3RfFFuGq4bnieNczWoqyOCLLHPJloo1b4qaRL9s9GUlCbU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(6512007)(6916009)(316002)(66476007)(4326008)(38100700002)(66946007)(26005)(83380400001)(5660300002)(6666004)(186003)(6506007)(2906002)(508600001)(107886003)(2616005)(6486002)(44832011)(966005)(36756003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?irIy/NeFsbE96NJHvTCuOjJGBxcfyKAvksnlnA61n2Or1I5OXSa0gZ3ElLEB?=
 =?us-ascii?Q?CZjYKe+g6k0XPi8FT/cqAac7V/ITRhoXeSISYQlW8QNs0EYypH8W8VYrBdyo?=
 =?us-ascii?Q?mn5sGGwKNRxauo3TuK2PPzAyYsGS8rH7Khwb1CEM3D3Qd0rj9HdWwHI+t+Si?=
 =?us-ascii?Q?GL3OGCNBSu7fEN5XkCjAXwXZeknCiIvzLq3IUkAJ6NsIp+b2u5ZZInhkjon9?=
 =?us-ascii?Q?JBA63F9Qnd7/cYHgNrLPM9RN1GQFZ4VzgWD/vLWx0l72cU3k3k0axELO1zxd?=
 =?us-ascii?Q?rjuXlKxMK5aloQPd03QUoeGVMaibtBGl6dFHCT/iVCExVLUGBygFQ6pmQSR/?=
 =?us-ascii?Q?0lSM2Fr/4KENWAxDo5jZt/ZplFoCnJqKEjI3XyKVyIMt+hYLCBfPYYEKZpF9?=
 =?us-ascii?Q?Uw1A4IrwYXxFFmH6wOHLJXiYFLw2lJIwfhaMmRrqZRQB2CtLA+x18oMj60Xt?=
 =?us-ascii?Q?HTWpZrKzgnXQcPQr2vnbMyoba03VTdFVDzrd+A5Jk4UK7gVx1V+SxSFmDah/?=
 =?us-ascii?Q?Eh4BrlFHvyTLU/qWQveoROhS0FpfK1DI7ocmccW+adEtfYFjVdL17G8B6Z0Z?=
 =?us-ascii?Q?eieRVBVAotfRtaS3RJp+qJxYsZaPgN/g8vsTYFNjG9h4BZ0ktrAKGTX6iEJU?=
 =?us-ascii?Q?1zKqelFGGt6wZanwZeSvqEvG4e0o3OjfNl1WHmEVbBAlzCgqKXHrNN9qR45B?=
 =?us-ascii?Q?LhP6YYuiR7rEQfRF69SPxvIJkaI7KTjUqMKAWPgt2lYpwMj6gbA0+DCDo4Tj?=
 =?us-ascii?Q?y3MjQiVGOi/Jle8HWRgnOdVMHBwTBUIo4RQszQDX7ekxSCkIGMG3tjMD/ROC?=
 =?us-ascii?Q?z1NCa0KyFuz/oRm5Z9w78+Svo/aCUBoe06nK71H5BjSK43hb2g81kPbKCiWK?=
 =?us-ascii?Q?ncsLUKx/bSlUP+CibYbLFpK0UW/TsS/aUYDg3cu9PEPArZZzNYHzsRmPycL9?=
 =?us-ascii?Q?pt9cu5uYESa/D/4f6t4d5wqBFaSVuiKKALxuagNkNnMNozrGg+Dj0QOFr2UU?=
 =?us-ascii?Q?Hbrj3fm20unCrpNfrJv5ZglS3NUi9KcP+5sIrD03K8stoHWgpu1iWx4eTJW0?=
 =?us-ascii?Q?ij3L3DWSlExe6vivHukNpc6a9AGGgJVO5hqKfHUPLvsqrBuKa6/cSbQo8mKe?=
 =?us-ascii?Q?5M53dIQNx5HH0kYyxqfkLYqfhAeA4sWH7h4KFss/UuYh+zEzsebofT9xSgmz?=
 =?us-ascii?Q?IfRhf6qzxPgmwImZNuF+f8mSlHxamGOFMQ26HkxpCjPAZPyh1B1s8GpBuORj?=
 =?us-ascii?Q?VmqZP7bVQDz0f8UovvozdLB/54gE3zmGgx43c1692ABwSdkIHBDEYTcSxPpA?=
 =?us-ascii?Q?056AvbEC1FjMcEwimxvHQBg/hFd+oDRlmTbakhhvEU1bTNOEjMIvh8ieCpF/?=
 =?us-ascii?Q?CAVizt30YynZ8sKfjFSSui22kwVTynYFuCxVxTfJI7aKtG5OduhxRbVyxa6f?=
 =?us-ascii?Q?qJuoSacYU3uMhP1m5pHXm7o2U4Rd1cjnj4LG7Sq2kEQWvJvXP/+qPHuB2YtA?=
 =?us-ascii?Q?MPbu1MgkI4RH+jdealLLp6YHYESocNY8USzF6GB3eDyL8sRd3mQw8gPBLhX4?=
 =?us-ascii?Q?82GWqWyIvq+pW4s+a/666psiPRl6usb+VNa5zgvPaA5BC5DwuTrgVAyFLMm9?=
 =?us-ascii?Q?NvQdp56m1rS5M1IBF6VGTUETGFICYA+KpTamD7PBSYDED5sBzhSFCW2s9QSR?=
 =?us-ascii?Q?PmaCaOckR7I0wwGQRRCkmEu5CLY/VBEmslr52BoFHv9dhKlvTInlbS9JviHM?=
 =?us-ascii?Q?MWzIyhenjvOkFb11kUkHQHpHl4ZYuAA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e9e88e-ffa5-458f-9074-08da3347126f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:09:17.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnZj3B+lWv0SUv856esZBbjFVUHheqHNkwqPVlsIyZj4v0XdsuxX15AT8qIJrXYLD/Pzl06/+iuSKXNK4asTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5716

v14:
 - export subflows number in patch 1, it will be used in redundant
   scheduler.
 - rebased on "update bpf patches on export branch" v2.

v13:
 - add !msk->last_snd check in patch 2
 - use ASSERT_OK_PTR instead of CHECK in patch 3
 - base-commit: export/20220509T115202

v12:
 - init ssk from data->contexts[0], instead of msk->first.
 - cycle through all the subflows, instead of the first two.

v11:
 - rename array to contexts.
 - drop number of subflows in mptcp_sched_data.
 - set unused array elements to NULL.
 - add MPTCP_SUBFLOWS_MAX check in mptcp_sched_data_init.

v10:
 - init subflows array in mptcp_sched_data_init.
 - for (int i =3D 0; i < data->subflows; i++) is not allowed in BPF, using
   this instead:
        for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++=
)
 - deponds on: "BPF packet scheduler" series v18.

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
  mptcp: add subflows array in sched data
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test

 include/net/mptcp.h                           |  3 ++
 net/mptcp/sched.c                             | 15 ++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  9 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 47 +++++++++++++++++++
 5 files changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

