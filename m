Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81A1391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q8sFwNwrL8Uh0BcMRh9F4Gra+eCymJyuhT2gOO6Jd5g=;
	b=McFlqE4ykKR1XaYiuQnp8pm/8ZiKjyNsYtYMggv1z2hQUHVbXIPP84N7WA5d+EO6l7dzMs
	s0aR+02sTpgX33AmyJ286+H8LJ+50k2ZGkP8wZCi9bi1BxtMcJ8FZAcZhfY2vyJjQ7CuJQ
	Knu2s/HtoRo/mvsOC8VxdJJKeByn2YY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-mR_1Y8tkPje2_edKODF_rA-1; Wed, 23 Mar 2022 10:29:09 +0100
X-MC-Unique: mR_1Y8tkPje2_edKODF_rA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQzoT7Q2puc4mXaZpbpsfkkXox3R6oBavPQbqHhONO9og0Y33oZTRbWXa7fyo2OtJG6YvqFlY8CStdnS1+hBUrL/yom75v+kH1pO7KDqHJ7VV1Rpl7aMXE9GA1D8/WRhndYv24eNjHZA+p5cGT6tXWekBq2iAd22zjJ9FgkxFH79VJwCX2yLWWzNbabepaYZQVgZasv0XGid0DzbLRJ6gTMJxQPmpGedVrnLbDYLcYNG9b2khYdZvecxPrtDtmGI6R5lhx6sYD17eA7OMvk+JVx1XjcGuG3lD/CcWVpQinxVGDh80Gy8xjjS/iyIVT4mOEDJf5hmRNrZbL4VgjXsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wbnBV3Y5CA1qfEw5KZabXM9L4ASAxtH80vqUEPZOfg=;
 b=H+fvLpooKuNSIJHS4UBnn/REUEkwhSzAy0xTQpC4vaNnRZSWjsTFyfek0EBwlUWehxrXaQLU2iQPRyCvb/JZdnH+AGGBpg+Fp6+KP/ht/XwTzjXUxcdDmRh8G+3sXMgxwTZys06QwIZqZRs39g2MSHtnUENoxxzMmVEzmlHVL7PN72/RhacYlu53Rix5jJg6Iu8kQY4jewbswjYIqJyuH6P0QMe7/g2cb0NMk4+VrdjO/q7YrQWe0IxmRKCRRhpPqH6RG36s+OMPyyHBydtKY6HlQhb43sj901iFOum59BkphtikgCfm0IAimQPaR4ZYAy/MaSdX6c792EUTUuAz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/8] BPF packet scheduler
Date: Wed, 23 Mar 2022 17:28:59 +0800
Message-ID: <cover.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7307a6a7-96e2-4c87-c2dc-08da0caf945d
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3359:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3359BC7CC347756A7A303368F8189@VI1PR0402MB3359.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BCMfU1XD9XRqnmJzyhb881kLY2eS2SzS3EYGJk5BcVwta9pOcvW+5m9tYZfH0TtbYJcG74tkT0YWB57H3/fM56Wfma1qrXUca0oKG5FEAHSuEI5LQv7iuAqo8BrpxZpgLZ1DUkJ+h5Cf+XTWfMEnD+T73k5IPXwSRpIjJsy75sRLGBFVsqAIyi4X3wUG4/mnkcmoeAVJ3y+XauarFEw8m4qF/KlvvrSvEh6nGW67qKNv2GgL0badkie8RnL2O9nukn1uiHn4Wiz/zJ6ieg3GhVzcdzdC1eLRYaq3m1XN6HgieTZkykLmOjdvJ28uhXMLHp1NqPRUAqHiPNLN797DmLOf1qS5PM8n68t2pvpNPiytn/JRoYS1b9frxUsV9K+X8ECSWbXs1i00FEqHkaMtqx7NW//U67Fq8g+IySwcxIuGHE6S0fqQ7E0gb5zrYp30FwSVINgmihbyNOQcV2K6ARkYhlFO2try4kF2IOKOFaW7EtSZViiX7b/BbJ8V2ak4r14u0eex5sECR9ltSUgHmTPpm6WGf/yzj34UQP4db9Ytjc8iic9d3Abqho0Z/Eo9eXFtNCMR03cUgpAal22PERsNLu+r09hOSNSSIhHls3vQ/5W19LRbr6S1jAnmSRIvpWFlnE8QpzKtqpbV9ijk0pyxXgrEfxSC0dEaXcC0TnxtB2siAt4K9fXNf4VM4zqQxpbG8FhjbO0uh89KaTTGH42eeiS1bNAIPC/BOOTT8ubCvdfTYQN9ehyIl2hX+jl8B+1IDY+r8S7V3KM2WpJXdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(508600001)(6506007)(5660300002)(2906002)(38100700002)(2616005)(44832011)(966005)(8676002)(4326008)(6486002)(66476007)(36756003)(107886003)(8936002)(316002)(83380400001)(186003)(86362001)(26005)(6916009)(6512007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrLda36tXzxCdR0I1V8d7lMB9jm2Fann83PRjnS8gJ3dch2mJucZVQYYFrqc?=
 =?us-ascii?Q?AqvazO2arreuAGc9ZLGxxSetw6DtCWbRlaqaF+xF8pZPOmpcTmd5aJt4Olhe?=
 =?us-ascii?Q?H2sxV1QR+xEBr95tPcvU5cHmu2BfQcCyRFGA7DQ0bOzP5lUah7kI9k+YoUbs?=
 =?us-ascii?Q?ZISkFFg56bj52gJuofzf2MCL0ThQ8t3HKrOVUKJ0Hz1ind5fvsE0Zl8hBp5j?=
 =?us-ascii?Q?D1QGiJkCofuNZbt778wwN1B+CuptddXvKosT0tD8hQG5SpmQZqQBICjWdtgC?=
 =?us-ascii?Q?DTzmzw6NWcoudho8Dg1lIx1/UNK441x/ih0fJ3tsbaIDUb4Z7uUXGqmQAEC5?=
 =?us-ascii?Q?QdH4kEetwJZnBgVGTrcushSLdZC4Mp3vDg9A+yQ7IzX6LRgC0f3MFHws2IgT?=
 =?us-ascii?Q?Mnn+NeL9fNz/kUCDT9MQDCKI3TI4F7N1As6AckGsLsU//W/muNPH+4BcgINZ?=
 =?us-ascii?Q?6B/r62Ex4ByyzuQP+cthOjmHZuyFVKwdhZi4uDeE6HZcwDis5Cb34Va0cupB?=
 =?us-ascii?Q?ZoQo/U15QEGZQu5G5LfKqe56TomQDrfEVjghRK3ADQ4LkQHoW2qXg77BYw6V?=
 =?us-ascii?Q?bqVwB4QgvgmHpIErWkS2nL0ufKQCidI6tVtslgnGs5bpqT5C5w0SbtSR3m96?=
 =?us-ascii?Q?U5UEwkFBckWxGdCrC8wzJ/mdVy9oLXkhjZmf5+pamLrpKWyVALQhMblXY0oH?=
 =?us-ascii?Q?AcY54AfcXBdImD0GXN2GobEPWA42FBNhbuodU0/52YHWqPoS9B0r1+VgfDk3?=
 =?us-ascii?Q?iAkMzSQeCf0P9z30sIP5cOUvXkZZFlmEJbdKJco5Y4Rm5ri0oBhehSAlYYZb?=
 =?us-ascii?Q?CHVGkNk08TOVJbcG4Roptekg0CQ6WjHxaRSFXf6Iv8F9Lk3qe4YVCLMbnVGN?=
 =?us-ascii?Q?xeREty6WRRUJRNIfazdchlY/rwWV/MGJq1uSsPbVSbbt/SkjkdL9D7Vprcdu?=
 =?us-ascii?Q?r9wQYeYZ632dfhksQyzMV7bR/WtrEPKgnQeS21191fgq+KDV5Y0oSTJgpazY?=
 =?us-ascii?Q?wWYRWxwBk936SuvaxvC4buiTAmkuNka4S8XdKvqbKDcydzzwytmfvGBKtHoT?=
 =?us-ascii?Q?1giiPtJ5eaPFhIlVvJJ6IZbWb8MYFKasdV//HBlHHvUf/V7MLrGVsTvjnqbq?=
 =?us-ascii?Q?Jo/vPzNP9ach9aEFIv7E+yc37j8JSPqBipmSS/VcX6TjXOMfFPACuGC4KgmU?=
 =?us-ascii?Q?evnKqmCPOWgPXpVLo6+PuYkIbnBZOH+l1IF2JkRb0T1bQ/xedSOobn/N2f3n?=
 =?us-ascii?Q?mTkmGgOU6Jmq700KoK8w8vNb7mDl/8BVbIa9MbiHKp4wqiSXKrfNGI6l4RT7?=
 =?us-ascii?Q?uzFEZPH0C3aIaqX3g3RYNQ/Q3u8Vn+sp4wOHGcRWTVlOwxB38nsQ802yvKhp?=
 =?us-ascii?Q?rjfh2hq3GPTtHZ2LA+M3a1YeREGs3zHZsoTcNpOimzChnGX+1BCMWjMUR/wI?=
 =?us-ascii?Q?t48MsKSyN4F4TNcEs/e2iPewLizmUafoANJJwAnBFb5i6rN6Oo1PPw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7307a6a7-96e2-4c87-c2dc-08da0caf945d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:07.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfCQmIv1fCelwCdKb9zHsKKPu/wlLYkYqv3EeWk8kuDAixBxd6M6EZAqYkhOEyAq6Bu3zDtVWdDdluIakQ1FWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3359

v5:
 - patch 1: define per-namespace sched_list (but only used init_net
   namespace. It is difficult to get 'net' in bpf_mptcp_sched_reg and
   bpf_mptcp_sched_unreg. I need some suggestions here.)
 - patch 2: skip mptcp_sched_default in mptcp_unregister_scheduler.
 - patch 8: add tests into mptcp.c, instead of bpf_tcp_ca.c.
 - depends on: "add skc_to_mptcp_sock" v11.

v4:
 - set msk->sched to &mptcp_sched_default when the sched argument is NULL
in mptcp_init_sched().

v3:
 - add mptcp_release_sched helper in patch 4.
 - rename mptcp_set_sched to mptcp_init_sched in patch 4.
 - add mptcp_sched_first_release in patch 7.
 - do some cleanups.

v2:
 - split into more small patches.
 - change all parameters of mptcp_sched_ops from sk to msk:
       void (*init)(struct mptcp_sock *msk);
       void (*release)(struct mptcp_sock *msk);
       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
 - add tests in bpf_tcp_ca.c, instead of adding a new one.

v1:
 - Addressed to the commends in the RFC version.

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

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 102 ++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  13 +-
 net/mptcp/protocol.h                          |  11 ++
 net/mptcp/sched.c                             | 149 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  42 +++++
 tools/testing/selftests/bpf/progs/bpf_first.c |  30 ++++
 12 files changed, 395 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

--=20
2.34.1

