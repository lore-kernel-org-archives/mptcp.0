Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A133D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7+un6VjIj6g++loZyMpb7Kz/NT3aFyV8Erry5yvusaM=;
	b=gKF1pREwdg3z8Rux0cvN8+p/VHzmQmcW7R0QR61w8/wlCQbDvTzsAkZ7tW+3lukojAMpn1
	8Eh95PdrSTMmodI2pmTxYaGJ457qBMzP33pmO/r/h1TT6d0mjRgCDRHrrVRmnw8swalKcS
	qXMtXoTSrUlcTc6tnx9nqTpJ4x0YZ8I=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2051.outbound.protection.outlook.com [104.47.6.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-QbpQ8fKGMSmSX8WLzxJ3Gg-1; Sun, 20 Mar 2022 15:09:17 +0100
X-MC-Unique: QbpQ8fKGMSmSX8WLzxJ3Gg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT0bUWRznWvqXe8cb7y0E6D6PWthNpVn709xiXTmPS4x4kA3uC4Ak2Ffj1/M/s4Tjeb9NkoKgdWpUQQH0szTwgHeyfaFagNVWD5lzuDlKvWQ1Jr1aetv8koatqVci4Mc7Rs361e299uxlfmrXbU/4FDl9i5lX4jrY3ro4pZusrd8s/m6ueEPacfzLgIIu8QCCl2qJamIu2qIHubqAbPfddjatl4HfV2yrvIlM+mWq6zMpeo9TY4VNxkl2IFyMDCh0c8wE1h2fC+KLB9H+2Rt5WPwpyO4oULbcZrH20vS6HNU/53KCh3yP2m3+546+i0CDzuoCyyRTIZ//pdCqV89mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxHzD3ZFMBPVcB4MoGUusuarcGWsn+FNA/KA3L02CNM=;
 b=GKnhjeZcHRjOIxlHvycHOhCN7GgK1UsMMdz1o4qKZeexaz6DB1eRPFOicjeqPwnkMdl5h4hjkzX/lZZH879lgsZKoTV02KUVU20fhegpr3QQw4y/47gqT0csiZaa1idXF7CxrzN5d/5q/M4pBCVPUiQoJ090JathpA2AWHNW9A9sEtxelF0BT71smcGGHmimR5+9AxxqKUNfUCDorWvQMBqzYEqyGTIiDWRJyw3YHNBk7ALnvNQWciSDXUmH1ei+8WzVoABmZmSgvnliiEFzOhuWuImVAAcphyfSY4VbZLVaQ+OV4koCrrT6ql9xwUrSUPa59uaD3EEfJKIz8z6Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:09:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:09:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/8] BPF packet scheduler
Date: Sun, 20 Mar 2022 22:09:04 +0800
Message-ID: <cover.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f120179-853a-42f6-9659-08da0a7b37d7
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB70350AC3BDDAA72484BBB122F8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i29Apn3B3Nwn+kWpQFLJZtyhVhwuzNZE0cBZmBTc9YxWbmRJ2WPHKu75JdNnXH7pquccJ4XPHbhkHZ6Wl1kJX2NkvtVYYQOh5VnruiIqIMezEYlB8KzoNXpJ+Kf5dc/KMufyv0vmXWliH+cdj33chWe/y2lxIruYOabc1pMFTFxvhi2nhoSp7QyHfHmrrkPhE3PlH7KaVrLRlg+D+u+3JDI08aHyw10g87oU6cUy/VDaRKDjaOiPAqRm68wS+IBi2Yubq9eySAUSWU55njGvi1MsePnlscAz2PM6nBiAPwQ/2HSZhjDu3i3TcsBL9dvdo5Ix+Sn40d0Rt7DZh2CY8ia7UNBKYcHE3Xz4POUP+sRAD7vPYkLdWczBoBwdk3muP4wxeSMwyej7A4C3l7X/OCgFZGcGg9XS+mxIywq66rLmd1W4oeNhLLYWwjSNVicHnuCQPDIZS9+1ESEXVFJmMjn1qElFVYmTr3TMwT0aX63dG7162ZSk0S5cI8jD0oS+5tAT0BbYS/A3lazb2ECasU7tc8L3PnFy9fvZMKdgDwSHGpHc1hl+7fpFmblZWnf5w+BqQHXhHwLQzaMREIhR4XGzlQPgAWQ7YKpEOJoW2+/f/0J2PtAON0WA1/z39EyYNVkpZbSIotr+uijSB3Df1tmyX5HZSu8cvXUC5wJHfyY+KU+Fzcpe7AQiEs7uePlGi2oYjvZziRY4Gur/TpRurvDmy94Ntl1c63jdfKQ4xRaHMmXWd7OkiasGah3LsedDTWE6F+1hTDt7U4HznFi88pgy055g7N+g4FTcDlqJ32RtXlPRfNcet1rBVOFjyolj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(966005)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1EEbazdhAAAx7D/SvgHXK6J6luXoIal85IJy+JBSPSpXGlJ9PK3uVfn4zcjN?=
 =?us-ascii?Q?/fOAmNno0ItxG3tZhXA4dpaKp+s73xTjEyWx9w6EtmyiQzjWiXQrozwlChWY?=
 =?us-ascii?Q?WXzWwSdrbrytDDZgTbdUnYl7P/KSyor3T4/JmEUnO+TwTyczhjcipPKWVlCr?=
 =?us-ascii?Q?LZNVKDZntZeZzGNSfgO8OiJ4CmByDWVkb49fDMpx92rE46b+wpNG4X7YszTp?=
 =?us-ascii?Q?J2W89xdkRO/NABMLOfJL5ZB5zFS06nEF1puGn42c+NSqkkYOtZ/Yt5jLytLi?=
 =?us-ascii?Q?3oO8Vf0EL4e2xr4u7pWpGgr495FeFkRivf5sqgi/+GNxphd4Vr6nPee+ht/6?=
 =?us-ascii?Q?5KEeV3OHt1YAZuVlw9IMD90wzlpjGQz9kM31racB7JWCiX3K8z+68EjTp7Xi?=
 =?us-ascii?Q?kZY2aMZwhwbJ1+k59Rkw+Glvt9uA8xeyHWT4hkHqymHYlRAE8i6Q3C5+fft9?=
 =?us-ascii?Q?0yJMBg5UqlM37XI83I35pAiZKONoBJEJ/gXpm9w990YEVij8OjcfLAm9d0RY?=
 =?us-ascii?Q?SEi9zYs3V7ed08HuWMH5DaIPB6+FYAYn6gevCnsLPWXjfMZZvEQU+aJwO9bC?=
 =?us-ascii?Q?ML6pXxaO5GSgfJ3yOvIYM9nRNprzCUvUk9IAIRH1hfEQdyYxetSWCVnyFmq7?=
 =?us-ascii?Q?aJC1AVjor7Ba2z+fZ1Z3p5fWCqErKSabn6/lNgfACtg/TGkpLic24YmmXb2V?=
 =?us-ascii?Q?Afd1S1y26zu1suhQ2fZDJBW8fGLjx8IIjeD2p3GlRok+vD9DtkTM15z3le8r?=
 =?us-ascii?Q?6MUGGGQo/UQ4LQwBcABH1ntpAWAvtUkAvGrKOFdZRGh+4iiQS2GophSWozUB?=
 =?us-ascii?Q?2q/uvhrGexRAYpshZF+/vveaRbucQkZ0Q8KpI2OC2bdn3LN6F9mDlCRgT3AR?=
 =?us-ascii?Q?TnGCHYmBc26MaGLjT9+gwvkrQoduiPKakjIYGPktHlK+BwFx1LPSk5kqfEOP?=
 =?us-ascii?Q?1cBT8xxAMpQjYZR/8n8EPCUa+XbCQeCRT15I+NzgySMlIbhNkzxhDrqFFPHZ?=
 =?us-ascii?Q?9PWKJtS7wR804LI/MNs07P1ONhYs4+JP4ihn5yPzgZXDxuuHEQl3OJhTC6Ej?=
 =?us-ascii?Q?OmfgfMGbE/g3SGQjqMRs2zRfIj5Ao6ccJrycgozl2HcX6OIjC/eBk6NWZblW?=
 =?us-ascii?Q?+x81lR0gvudO/Cmvz8KhMBYBJQ7laRuet3U6bhsnVSErYO716V49gLHO72EG?=
 =?us-ascii?Q?X3nTK3CUn+6kDCBoyakbL1DhiutAPaQo4PpGh4hy+tlFnPkImvBWtoY6UZRj?=
 =?us-ascii?Q?ybukYzMAai2iijcW9bzo+DMOnn5xQnwc1ouDrcOoYgtNZ7y5lBrAe2ObhdvC?=
 =?us-ascii?Q?4rPyO8URjrJcBGTcwIc4dCqpAT45A5nkeM0kQXlfn/+bMmIkzELl0+NiV6AK?=
 =?us-ascii?Q?wJ3Vre/siNgP7vkWiYLJ11pwXfN3TBJdOduqR1jPYvwxIfXISr6SLNhVR+Jw?=
 =?us-ascii?Q?GJaAbJtKF0X+Nf8nnq+zoCavAErpzFNhsDrf8oqFJDfkC5VYO/SNhA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f120179-853a-42f6-9659-08da0a7b37d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:09:16.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHJHDTxhC3LHPPKCeZt6HEiLGf56UpetSOYLl+jsBkGZe6RKoVYPhfcw/mqpGEnM06cTlQ7H/LJH+RZhNGfN4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

v3:
 - add mptcp_release_sched helper in patch 4.
 - rename mptcp_set_sched to mptcp_init_sched in patch 4.
 - add mptcp_sched_first_release in patch 7.
 - do some cleanups.

Depends on the bpf patches queued in the patchwork:
 - add skc_to_mptcp_sock, v10
 - check more values from mptcp_sock, v2

v2:
 - split into more small patches.
 - change all parameters of mptcp_sched_ops from sk to msk:
       void (*init)(struct mptcp_sock *msk);
       void (*release)(struct mptcp_sock *msk);
       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
 - add tests in bpf_tcp_ca.c, instead of adding a new one.

v1:

Addressed to the commends in the RFC version:
https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (8):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add mptcp_get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 ++
 include/net/mptcp.h                           |  13 +++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 102 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 +++
 net/mptcp/protocol.c                          |  13 ++-
 net/mptcp/protocol.h                          |  11 ++
 net/mptcp/sched.c                             |  93 ++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  42 +++++++-
 tools/testing/selftests/bpf/progs/bpf_first.c |  30 ++++++
 12 files changed, 335 insertions(+), 9 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

--=20
2.34.1

