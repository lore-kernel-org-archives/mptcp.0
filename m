Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD915B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gelDjw4LiVaYhx14vA+XXJ7KME54JxsAA9wakNPGmU=;
	b=cX4yd9BV0C4Wy7ShimixPJAiLinVjJT1tLNfzlQhQDltGuHwz2BdlFOYwldGcmiT8BiTOz
	dk9CW8MIkZDeY670iLbXtRZMm364tKSZ+0JjO+W6fBxO4XIPHettbVQn41UFJ5r6W55Pwz
	u/+tYZm5s0Sm3not9Cpkr/a1rc87o4E=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-wv_C7RMPOvi9HEaBoudjaQ-2; Wed, 11 May 2022 05:39:25 +0200
X-MC-Unique: wv_C7RMPOvi9HEaBoudjaQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8QFgOiRwqj4NJ8igWck/Z/Iwf250X8BI0N4172h2o0fk4mqGRSgVWW+HppjzFTuSOSRcDTaj8OUClfs5wj5rYv0i9Dja0yJVCx/sFlrcLDJw7tADgJorZc76UpK9YiJH19yRw36k66gkUr5Ga7YScNuOtCBUejAvvg3bH8b7I/LZ/P8TRCXBVX3D/sI3+Qtv6A30I1BWA/8JuB1wwjluRztw1A1kcQ8/+sR87z6M9YI6a81PeJoB6Ss8sUbkVxekBPmtzxRCo4zg899WHBO4aN/SNY8OT1FOIXSC5pRktdHJH1FPC/wQ3nzG2MsNYYyU/ecvgD6+qRA0hpmLmWaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhPoqAUaZdK1jjwhngqegtR9jbRBBVakBG/5jvj/Iyc=;
 b=AXNB6PKOnoZo9cMq4lWKqfJE+QoSuTQv5CSMnlQxM7yWX4G1vwov7vFzYH6P43FdSrpElvxUdbvtya0b7njE5J1NzJBUaQE85vZTZUjyOVtGlZurGFwcju169CbS7vwvpP0i3e5Qd/K02wGSyOU8g4n85nONm0KxgMdum65fGV/dY3NqFj/6dE2u/2lsQPmWf4kJRW6BsMMSVni+qoUCdQ7l7nwoBKErfVOKFl/x0taLJxMdCqg6OOlVWe53XBl2pDd8qocNDW34Ey1Y+sZlJSgRNxkYHZXbBN7nN30jlCOOGUXaupkSB0BWpAiGVSEF7GDs+lo4AFsX/mIRt75gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:39:24 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:39:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/15] update bpf patches on export branch
Date: Wed, 11 May 2022 11:39:01 +0800
Message-ID: <cover.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14585d0c-9ae4-4b60-d368-08da32ffd73e
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB71568E148FA295AFF4161185F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yFF0Mjdglv8KHOu9fm0ka7O577HqgDQNccbz4u/qsjcK1aihR2eRVlha1TG3dpRFHUsCYQ1oi2XYwr/G5NXtktYJglR5j7Y4dJ9/VtVddW9OMkhOn5i3E8VzlEHUwg+KrBab8N9NwalzlxknXtQUZmr8pJfmiyVkU/60d2SzZwtXOTaWK27fARkQ472w8hw37rg0W/e3im10Lkk7O4j1Miv9ENpTU5Bn6QFiblN8uiHSjfwmX3tPvoCE9yfJko2gogByQ2GDq/hQEelnRNGl2rXEMYNIVVxgWGLmSgzj8D1A/J3pv+dQ6N9vtzD28qk5n80sklNCCvW9QeS2TLMcGN2qrjz77cP/Y5JeafzaDV12ks+HGBGOuyiRe6OryeWvsh+/yBaY0G4LFwX7Jqf73DulEho/68/LwBGcDiQ04sxbM/6q+7g2wpY5DyBWFl0TvR/dnPTHsUGpGdDKXFYKOkHBZg4QWlitrgDAzSUFdz1mz1eUv51UNBhej1d2s2jZP3m0wOsbwANuslVUx0j1oXplMOguPpsCzTBt3txDSq5tHtF5mbJJ28kEpvgb5jhcdOJJksBJ+1SmaNXgKysORUflCDTsHUptAkQ0O6bbFpr+eYnz2PFvuXe9G2wFaf1OtVNJykITqeOVVzlZ/vI8ifGU4FsjYOFMGOCTW9cNM0261iN5J3bU6C/ppd47CmPG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(107886003)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(316002)(508600001)(15650500001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQA9N1k19K20j6zsO/+WuUvDpVrce4bhW2y7ykrtiN6I6jFxJrU66v5/nIjp?=
 =?us-ascii?Q?y7kKUFwwBoKIfhNO5t+TENUcK4gTrajAYoIuWAxDyIO6gu7mUBFWiLISno+1?=
 =?us-ascii?Q?kaFJuz2f6c0QP3GkRbhPi7lLNMLfkH/aX5tcVULRYgLA821pO2CmUkRBFBUg?=
 =?us-ascii?Q?Km1wSZitdGrEE1+eaOl6d3eFU3T2t0nMYmeCuvwEgouQTAHoYDLjV05pj0mY?=
 =?us-ascii?Q?+vwhwLqFc7zoa+PkdSo5LolktxEpCE4kpLO67VSUQODJJhJmaXHIWjWsk+zD?=
 =?us-ascii?Q?ZE8xWfEElhmDt9vyGA/DphCPSBNisq5ukS1PRsa0j+JPpjBDFxrL7qUMvdGR?=
 =?us-ascii?Q?BKP0U2hbe/D8XXXssl4xvT7jY9O/tFlmUnwG425G2j04FKHQAK/+OeVv5PQZ?=
 =?us-ascii?Q?LLrGnyxnFFVpfvGkqJ7t14DEPv0D4UBUBO9kIDF0XH/1DrPtRilyYrG4OZhF?=
 =?us-ascii?Q?K6nSGvxXvyUxUoqscXg/XJWdO8HPpQFjPtY4rHx/b3ACw2GxtcpGc3qLSTsj?=
 =?us-ascii?Q?EcY77VKb9n1VTUBvACJ6B964IjIrprnjtSizOmoATrJ9zBYVrt2ijHt4jbQ4?=
 =?us-ascii?Q?fm0k7vaB0KEPoyUdpBwJPG04Q3DkQBzToQCIKO4kk35o8FkE+6/XgggsSO30?=
 =?us-ascii?Q?1LIUhw3C1i3EwcJCcruUSXGWzAk4voQoqWdYH5/mbb+pX86opzgpVPc73Yli?=
 =?us-ascii?Q?9ipslgX9lmb5YYdHPr3FgtiTOSSIbty9LFh1mLzWAsNwDS6u32AUOYUAjSEQ?=
 =?us-ascii?Q?Sb51UL/nvtsMtXBfEoIImRF6cCjMbJWWGS38KAUzqNbI2dg5gjcQWmuK6/Hk?=
 =?us-ascii?Q?Tf6ZMIP3333UlGCejZ9pkaiXE2oxIHzb+Ct1H2TI1SEu5jFfpn6AbsFTQI0O?=
 =?us-ascii?Q?5T1DhkyjfwKIXzjt22ts4uuZOuWw3UijH1bs8hD4p0fgWZSC70ROQFHULWLM?=
 =?us-ascii?Q?w0yODihPXSH4WBbcO3iuIBWEBLRXJ5eIdssl6YbxqMrwjR4hN4S/zhUrhu8S?=
 =?us-ascii?Q?ZfHLd6BQ1ZOzgY4XJDejpAxCA83m9OubG2Medcnpur7jtAaBRT1NDFCzjAL+?=
 =?us-ascii?Q?5yD8LmhyB/iOQu04vabRg2a9iwmu1NVDcLP8bMLxPdHoXNDNosS8h0UU24+m?=
 =?us-ascii?Q?8aqg/4GhFV6g/2XL9RZkifTMHT3D7sp6/VfH5w8mhD78IZ+5dR+ta90Y3h3z?=
 =?us-ascii?Q?bc+4lXaJ3DWAp6Fm8HZMUG99m+/8W+yX9gG5VvUNh4brYDMjZRyGzbMQhoCC?=
 =?us-ascii?Q?bLVMGZ3p3jHVnYEDpK9NTRfD/29sGuPToTlFmZ6N3YgSmk4orfhUi076ePID?=
 =?us-ascii?Q?Mr0B447PDdZ5F+vO5XxfpMSzLodEsonFCp0IcsgCpW9QAWMyDVWXsRH7vp+H?=
 =?us-ascii?Q?lOCTl6jXEAEZp3sjYBkq+omMLe0oAK6+zvhvz9SoR+J+6xXJ7qduMOB9JAai?=
 =?us-ascii?Q?usnhT4OpE9VrOvzwAgQOMYMVe1QX99C47Ibblu6Yeb5J5uarWVYnoVy9FCIL?=
 =?us-ascii?Q?bUrA0MOmTMnoN+2VWwL/p5Nqu7l9fFoanIoj+fOsxM7VDkeE63IozYWw3GKM?=
 =?us-ascii?Q?z9YRT6ewaKi2uZwDk93rJY/9w38qeGuxihiLry2yO1ytVCj6B0Zu1xNnRmBp?=
 =?us-ascii?Q?z2phZj91s1dsqw7usS6yH0pmGpOkmPvxqlxvpfWii/5n3lMLfMXPV6+F+kMC?=
 =?us-ascii?Q?H49YtAIHAJJaWZT9BeVXk+KCgS+aGepo0uDm0HR8JNyrsyJ0FBlwvVssOPzk?=
 =?us-ascii?Q?yhisYV4TtSiGk6yNYkJaryKjewpOK+k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14585d0c-9ae4-4b60-d368-08da32ffd73e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:39:23.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMOTKXywYRYFtoTqjK+k2wldfDrpYFOlaELWrG21smtIrVXPdiUj+b6xLfxJXTtjMIGdRUKSpP7K8ImgQ80nGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

- drop bpf_mptcp_helpers.h (Andrii)
- patch 6, skip the test if 'ip mptcp monitor' is not supported (Mat)

base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
net-next-next") on export/20220510T054929

Geliang Tang (13):
  bpf: add bpf_skc_to_mptcp_sock_proto
  selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
  selftests/bpf: test bpf_skc_to_mptcp_sock
  selftests/bpf: verify token of struct mptcp_sock
  selftests/bpf: verify ca_name of struct mptcp_sock
  selftests/bpf: verify first of struct mptcp_sock
  mptcp: add struct mptcp_sched_ops
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrappers
  mptcp: add bpf_mptcp_sched_ops
  selftests/bpf: add bpf_first scheduler
  selftests/bpf: add bpf_first test

Nicolas Rybowski (2):
  bpf: expose is_mptcp flag to bpf_tcp_sock
  selftests/bpf: add MPTCP test base

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |   1 +
 include/linux/btf_ids.h                       |   3 +-
 include/net/mptcp.h                           |  25 ++
 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  27 +-
 net/mptcp/Makefile                            |   4 +-
 net/mptcp/bpf.c                               | 175 ++++++++
 net/mptcp/ctrl.c                              |  14 +
 net/mptcp/protocol.c                          |  32 +-
 net/mptcp/protocol.h                          |  12 +
 net/mptcp/sched.c                             | 141 +++++++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   8 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  31 ++
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/network_helpers.c |  43 +-
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 378 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  80 ++++
 25 files changed, 1009 insertions(+), 30 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c

--=20
2.34.1

