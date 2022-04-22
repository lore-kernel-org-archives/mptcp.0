Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4D23CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C/gKiaBeJWu5ZUQd7sqTMLRzwbJ9hyfob4bf8l4tN68=;
	b=UpV7E+KBPkIRsXT4gpnoqEs0MN/9zb2VsH1crztZz5McF5nI5rJ6mTABGpcGwUCb2GicTB
	PLColaGiK9A2urqUNnc4V0GAy5txsRSTd/ynTAwz3bLHIC6wY/0c0Anaj4L9PEk/wQ4hwb
	rLQV+ygsc74WusvCcpGVKy9rbWMekBc=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-nH1FdxbgPbagomDbpWBrZA-1; Fri, 22 Apr 2022 09:47:00 +0200
X-MC-Unique: nH1FdxbgPbagomDbpWBrZA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Llud8YxaJJE/bnrq48ZQ9hnNQpH/VhIZosI056DajF+GdyLqDUn23l5Gv57HNhrMpq1Rq/yNr4ymW6VQqnpoy+eFv3vm3cGss3OI+FEuJavfCEKiVyXDhMRCAul0lNRfrgzz0lG/UOZDpPkEEeHyHWjxAtc4OGcIDJFF5dZWERbEsr52c1TL/JwxLAVME0cjCp16ZbZMt67BPu8f4Gq1mtv+8HMMTJwW2XU73yoCSDbKoHpFPuiSVhhpgz5QD9aAag2ASA6D7StkrnINem2hXEiW8lKc12Wuc2TEB/D5go4NSek//43mMBIY7wBLSmXiHu1jt3Vs7AMoYOZRgE/tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZTpI6k8JGzqweZqGwaFiXa8twf1d94lBT2pmVDR8YI=;
 b=c+Me2ugpvWkuKAJO4UtAJfJsOeKFLXuXH2l87Tm+SDVSQVm+V+q0f5xSSx7iIruSReBNyRq8kJd/moShsembULhfZ3/pBAcVn6katiao69GQF6cVPWzrjODFExDW8BhHMg6yg4ljJ5ctZwcLmu9ZJWtOvuN3lnbtcZUuRkaBZ/ExOLqZIQ8lL3fEs4X5Q2YqBdDFUJ0Km26nqgrUclSOmumfxKwQ8QZ0YKOIZzM5OcQYUmGP/+NO08Hg7c6qNYJMObS86m1MbaxUyKd7Zz7wp0l0niwEw1lP3I6Yv2zZzIhBfkCUhm9WzonVPAwhMFyLi+pM3SuYKLR3xm/R3J0DVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9432.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:46:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:46:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/3] BPF round-robin scheduler
Date: Fri, 22 Apr 2022 15:47:13 +0800
Message-ID: <cover.1650613515.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:405:2::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e04fafa-07a8-4f2e-83ff-08da243446d2
X-MS-TrafficTypeDiagnostic: AS1PR04MB9432:EE_
X-Microsoft-Antispam-PRVS:
	<AS1PR04MB943286CE5A2180272807FF97F8F79@AS1PR04MB9432.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bDon4G/QUVZWxZULmodSFuyxUkeKzRknAUDv0Cgx47R7/gjjlD03B9wNFt1RswzAMzu5ypM122Q3+ZCmSwcQAUsPUvVrAQBedjlTl5RIjtcDJMjxNisPN+9QNnWZIfCJCofS9HwZUek32ejyOY3hZcouiD/hvZY0vgQUa06T6PUtKYRu9w2FsUbuQ6zbsm31eFA5AYPnUuHR+OquifrTzafUgbtjT6SWrSNb1EOi142ADKaLRRCzZTTCehY8H3IF6xDoQWaa8yPuP45qRZs32AV3yOZCetLeCtJ96uJ5qixuMMMYs1Z3KpyaG4QKH9h8y3dBvAxivdxBJRmIDzQZlkj26+D01vpPOoWNe0e87MkR9yt5qwPgdI83LcpBIJ5lSFR87bRm7quRKMkcLCe+4e6MsqgjawlksVQTICF2RGU7FbkUiKLnqBM8qcUJnAAMNSKmgJWw9Q5iPKOq6o3mRxH94fIBBS8iHu2XMWKuS1ZMdRGBAmM+7pDiUsybCFXtpbD4lnm+oSjeO94Nj60eLzxNqjrRbpX4om/u2GwA12f3syqZbaR4df2l6B7pfuAlV3Iv8X0AwJE7AhGUwTCq+thbklbbOZx1+JK691Ap5eUluINDJ6b2UM+lE2kodUnKUOrFBBC0DUExysG2n7eAZeVPR6CckZUBXH2Gy2LGhyQl00ThHTIsmQo/vmOCfe0I8RbGuNjecJXuINgiFulXokONGi4/QAnpKh/yY6dh30f+3UN/Lievn1/enuX/5ehs3FmEKBo9+x50zyA2HkWCG9m73ZWO2zh/qndaqYKsszqh1oVJBXscJiiP5k6yHAMs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(38100700002)(5660300002)(44832011)(36756003)(66556008)(66946007)(8676002)(4326008)(8936002)(66476007)(316002)(6916009)(966005)(6486002)(2616005)(86362001)(2906002)(186003)(508600001)(6666004)(6512007)(6506007)(26005)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOJWh0GJXG8+b9SjXwiTy2bo7SCYHv/3DGzS0Sh5xxQ1QLRBEGV+yrBLX62O?=
 =?us-ascii?Q?8mXyn/XMu5hrDz+fLBDwwrEbaBIuJYuplzgF5v9v/WpY85+f8y1b8V8YyQxL?=
 =?us-ascii?Q?yEgyTjCWsfCjoMnCIPWKEM7BP8lL99atB0HwQojecy7rGhUEOc3WlbQnaFzT?=
 =?us-ascii?Q?yiGQpWED2uRB0Q6+mgfHeuJMHf8LgCDzzcyQK5AdKDIpcst8ZduHXHtbZEL0?=
 =?us-ascii?Q?Kjo9yJfjPeWaY+KnCgr2PQuMpeRXebT4WwvwvVKMoLpKkCtOhZCUo4Xewmli?=
 =?us-ascii?Q?LtLTqVdzkv2hD2/ueh2BTeGOtXPwA3fZ0uMQDk1LT9a0rT8i9wpOe5Yw+ZTU?=
 =?us-ascii?Q?OKqZEu8YDrY+eZ2BWKNiduEVgqODK7uwm5ZSu5E3IpUz5FnwNKAOBwtFIOCH?=
 =?us-ascii?Q?RhNyDHpLEUcy2rwRR/9WDCkxjbTbqfwN0fQ3AgS+67zGQ3mFgStrhUdVZCQC?=
 =?us-ascii?Q?GWdv5nJgWkqTFfL99NKMaSbZ8189EjxnVq1xK7AxQFltGxQ3tIaystlWS45g?=
 =?us-ascii?Q?2EW2PPICFVJ97F29B0stdGuTyjlxmH1qK2Bes1oUJ+Eq7M0TgTV+nOVDy23o?=
 =?us-ascii?Q?xHRlvj4m7vfC37DRTkjwD/4d8XhubWg50xhEiQSj4vjSswv8qMxz4vuM/HP3?=
 =?us-ascii?Q?Vdli+mQD41Yg5PUmbkrS/H1v+smdNXchuMPLa6qGlsKcx7cJ5Bh7GvmdM4tk?=
 =?us-ascii?Q?z2PnplsfmX6rXtH75Vo5UvVKmWVgtx3ww15HLPdvEtv0bIgz6PSC1N4ZERlO?=
 =?us-ascii?Q?NnEDTBc0ETfvNIAq54DLu97JMSEyBobJLExDWcu4U47fEpIoizVdJNiQ9o++?=
 =?us-ascii?Q?rk/M/Jwra3U3wCiCSSjeAia1bQRAluQlWZo8JlVq6tOPR7NfnZdGaV3RBatM?=
 =?us-ascii?Q?1Vr/xeTseuce/uxrtPq5Q2h9oGJMiyeYZrWlSdaKkPDihNmaXgy5cJseJ6MJ?=
 =?us-ascii?Q?1NWLGsbzqqIYYxYd1QDE6ngo8PMynTpIc8HAj35ke/O31rPyT66HMAqgz4H3?=
 =?us-ascii?Q?tUyRYSdod2hej3xhD1Kxylz1FE/zbbHRsBfsf9kOQgD1tmqv0sWpjXSlXWmv?=
 =?us-ascii?Q?sEoXW8s42vA21Bs3o5K0+Dyt8pVyXo+7RWIqvu2NsqgvBOV5PKckRIq09kgT?=
 =?us-ascii?Q?2Gb9lWcd0LICjzuU55tXlYLL4TvhzZzHEA59qDCDhu5k4B8NW+4QFEBZ9Ywv?=
 =?us-ascii?Q?dnCa8+MnAVxypjb9QC8hyw00fOV28Ly89qgHP4osGh4TJ057/OE41YHoezDK?=
 =?us-ascii?Q?0XafNHOUd09B850WRzy3H83ari1kPy2FwIR486eR/gB60oRmcjRU/0YKaLOD?=
 =?us-ascii?Q?dhu66L6mRXOwkLHlVwHPsUb0P6kASQ0XcQL12Mv6isLe3r/mtGohi2Y1YE3s?=
 =?us-ascii?Q?OdPxsVUjddrQaiwqJ0a2fSfWrw25hC5mTck7oVVXi7TjA4+x95eq5QfhCa64?=
 =?us-ascii?Q?XghYoQyyNv8jx2E4gfavwxYuodUqfL+EZuP6zdjzo2un6W9x29S7jQJRlhP1?=
 =?us-ascii?Q?fLPa+NMwgulCDyHZgk00VwRAjRsjIKDCtiDHvYLyu7MzUQfAm5i1MFc9diS2?=
 =?us-ascii?Q?bTjxkECUfWYH7lxSr6AqH9yf+l1qprTzuZ7/hS4NTHqJnc+Fu1TsfOQKfP9T?=
 =?us-ascii?Q?JI3m32Oc+9b6Wy+TPav3CQgyS2gpJH6XOTJ7uvLWwUOd7h4Qxq1AuxVWB3Vm?=
 =?us-ascii?Q?U6lylmycorQxFmPQCZqDheJ+gsFQLqe0PrYTFYH6wZgQQNla+hEFuj/ahMXO?=
 =?us-ascii?Q?Rdj396Rpxw/YXu+kCyhZJ6dfwqQMtec=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e04fafa-07a8-4f2e-83ff-08da243446d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:46:57.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaCLYg0SW3+rY5W664FVBpWAC7kX1RIQSCPlclKWTudq8qN1UGQT19jltTv6ic47ediLhQiIAFT0JSeWslHlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9432

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
  mptcp: add bpf get_subflows helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 47 ++++++++++++++++
 net/mptcp/protocol.h                          |  7 +++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 13 +++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 55 +++++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

