Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF11FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RlqcFEjipplFYn/otQWQ+lAtY1QZKxnJHMf+uUYTjGo=;
	b=kYa0Cg4whoyTmTF2pnP5RsZ0XJgSAArup4Z2Wyuqr59XoMJMVHBEYERjOjQCa7Z6Avwuzs
	Rmfg63mhAGjXQ76yQN6uy5/dI8FBNsfLTqXvRBvpbD85s7LzwEIyKrkiSRj4cf+Fmy8sKo
	R2DbisT1k8993lvE10sRHvIux1RaWUs=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-lLCqCFStMwi2fEbU5yUzSg-1; Mon, 09 May 2022 17:01:12 +0200
X-MC-Unique: lLCqCFStMwi2fEbU5yUzSg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hz0k5rsU/7HkrxxT+zmYy1czIePAlJZd/I2EWWZdHrCU+MFWB422Bhzt7npcUROMDyaMSKBIHtgWWg3NAqFlWUkqOneYFOJDNltgEj6q6eTXjwcNPmtitzTJG8y4Su2NRACHdCaaiDNsjyYgFTKgNuJDeQCY8/D4YC1+CaIMHqF4cLn8g/YFZSKx4a+FD1R1SgYxXdJBsjNkS29Dvaxthzr0yrBAKv986mfxiJ+F1N4OhI22150UgT/d+96svuFSuaUgtRZwhA7TcaKI75wSYuhoQBZwqP5hRBHG+YwKrjX2VtsIl6CvQol+MooRv/vXrhgeTMb3B5ZvplHcxtKTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mImUQiK7bd58zYw7xdA9JGyTRLkcHX2sZZB2h6glkSg=;
 b=lb2/h+BDRRsZ4uMNPhT4XnBJVCMsMq3cn+P5CEepLKjgdHblgcdRlkRG/Rm4BPOVN9g0fQgDPKXPmxy9LZwT/toQqkYxTY6+y1wfpQ5Cbu+y/ASH2ZSSBpXqC36zpeFezOoGKF4ynPCXXh/bpCtd3ViI56582QF24/iy+JGisdm4S8YUgZl9fUcH52icp4l4RRXGrEdualvEYAdnovl6F2Tf58F+Aqh+EfPegqtj3yEANEGfgvqoEpRCNsKWKK9gZgz1Q0WEqSJdWYQbLjY12FPsFZxMMIOPdPlm+00PmgjXJIDmVnojztSerurYQFVZiQ6lw3zQQ0c1a/oHiI3j4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 15:01:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 15:01:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] BPF redundant scheduler
Date: Mon,  9 May 2022 23:01:06 +0800
Message-ID: <cover.1652108279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6001b90a-f15b-41c6-531a-08da31ccc16b
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8107847223C5BFFF08334182F8C69@DB9PR04MB8107.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xnHnBRKZ1sJRwk6d/GlVmqKLAtfMJAjZT4+82bhYCK5CFZo9ADfG4ebEAzBzsW9W75xKnyNErUNAvsa9PNfGNvhfIjKAJSJXslhi8V0OH06yJ6ypYpAW/2IuUnjINblJ0VjdPyo7NTj62kRDVHt0LCCUnR4zqmw3+NeWx6sTRnW9ma9QlJvavPXbwKS0i2EN249FymRFhzJSHWnUPV+ocfw2ymzjPNVwwP2bzIqsaGo5VNwI95QlawNUvPOu/bgUWHbUYua8mAXFVHMihf8xNmo4MLNn+6tm5NBwaUWBlApPeW/mJtgsR1ZeDTgyQbm+PdLpYKZGVjM6Srs9nZRqzqPyBlvdgBp5VzugkYM+sl4ahd+SqdNP7Xa9e5iRMlKPj9ioLXy7IB/PUKh1rw+KadyoiImdmpKYH1KrWAyIPyz7kOZO9DLUY9Y/q+A8eKtwPNTzwZAlhbIKOOSCW0qPVOREKpWaZpB1gccJ8hRKUZLG1Mjmj+vWaHXkRcXBDGiazjqdWmsokw8S+HAGAopIknlVb6sDrgdPtzs7CWEk+iJu2uO/4ZpSGmRVHZQkyLdhMdQgHlqQrf8kNgQaCAYN2HEQluDlTtNayryqORSaxaBlcCjD6L1qvefw0ahKcw9rShCmEwN7gtKcp0sCydhx8X9mtKfA3EbowOl/bmrAPnTwCkbRoiKuEXx97w6yFp5H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(38100700002)(508600001)(8936002)(66476007)(6916009)(66946007)(86362001)(8676002)(4326008)(2906002)(26005)(44832011)(6666004)(6512007)(83380400001)(4744005)(6506007)(186003)(2616005)(107886003)(36756003)(5660300002)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ZDEJ0ZbiZ+CFVrfuPs4UssMvQF5ztADAKX+165pproQ3H/wOefwOu9BwFoJ?=
 =?us-ascii?Q?kNMR0NU1uBftKEkIjCvWJUKUSboKUkgr/Zljh4y35DHDqS6fUvcx5jmT2y+7?=
 =?us-ascii?Q?LD+60DeKqRQCcTHHx0td/R/Yoga2WrYtodtWKF45Bi1MU6OJXH9HZ+cgxtR+?=
 =?us-ascii?Q?zYOe7NESpd5aBPZGVDhdtwfekFNm4BqEBMdVGYjn4uo3eLLEDHNNUCIwsU84?=
 =?us-ascii?Q?v8baotQT0a1w3/+/JrC3bce/QCnV8HrBiDUivfA7ZKGtH1Hm6QjZDOlbPySs?=
 =?us-ascii?Q?XBgctDfB1TvjjUnuEcf8TC9ofbM+Jz9D/F2i0bFuOAmWgOHRZEzLrVSm+qcb?=
 =?us-ascii?Q?R4zXEmS+hyHxNtcJqs2Xtmf0QM5io3vl8qNF+bDfsNqIjcX0DBFLlU/7RYE1?=
 =?us-ascii?Q?I1A840R1J+jnrALhXJcxbeCmo2nptIcCUOPqZ+e/6h4+QLAx+jCPOgNjoyfG?=
 =?us-ascii?Q?vbEdCGZ3RsTL5/lpwfSxEIUer9dcdFy9ZQd1NazO1pRgCgI7N+PsVTMHh46v?=
 =?us-ascii?Q?V1Ar0wJErrbzjlvOvMi8NVIsFXheC7JVbhm7iReUrY4SsqdhC5R4+9/Uu/H8?=
 =?us-ascii?Q?rtAT74ZdHya3qMoT/lMGxDp8Ycc1I3yte/9/WapINlAYA0HmMzO0AyYO8pTe?=
 =?us-ascii?Q?n4B1hWHDZ5WVUyS+0Ip31Y8igTuuO48Vb1DnamwKJalJ6jPOXyjVC2+D2GcF?=
 =?us-ascii?Q?1beR5RhTkIYG5wlRU8actGWwRvNeVyKnx70bPUpsf6wuGnlGDSHjxfE1w0Ec?=
 =?us-ascii?Q?KCbLxvIc+2Ai4khQS2vu0E0vxT9IBm1gPxPySalikWZaMPciKLPpvhg8zd4v?=
 =?us-ascii?Q?cwrhCeFbJtgO0xQGvwGGanIY5Y56bezcq1qADi6d48cKigbherh+ucOPq9m1?=
 =?us-ascii?Q?Wt4kV6sdlXbH933K9ZJ9artW3p4OqfbSEYq3bO5s2k8USFxZNHGaWTL9aH5M?=
 =?us-ascii?Q?Xu5bg9X3gkBiGLjwzhkF/nLD1P9Idw1ahB49lysGHKFDiRMyLHCuK638v90s?=
 =?us-ascii?Q?r+PxuQa6WXzooSLk1QZgA3pRt5eJpx8GczGgnoYyo3x5QAUYjQ2U/cDr0KRu?=
 =?us-ascii?Q?QE1lEqTjkfu9S+DUqDpj44KL0xeKGxEhwg4oB5IjSMMw+U0e5pBKUUp5UYOR?=
 =?us-ascii?Q?EnZjy0rOa4iAEtjxtcqEboc4xuQJ7Z/+K5F69ohQYp0H01xJW+KALyieWM1G?=
 =?us-ascii?Q?A1GLNJXG25QfpCM9YTRXNOlDmvdqewy5kAl3Ku+4htOD2dyV8TJSNWbA138L?=
 =?us-ascii?Q?MwQu13VFhQQsumEuiehuFda1f56AIwswWA0Z5FJuJO2/3BYdXmUCTkDQ3nnL?=
 =?us-ascii?Q?rXvzdwJ6spIVKlmmJGbJIGQ7QE9ITGenXTTo8w9OcTxiWRupOKUItpje9CfH?=
 =?us-ascii?Q?bPjP2ZP1xeSGzCqojH5nVHtuiI+zfwA7XzpF+AWlcl4CwrNTJjcSWFWupr/T?=
 =?us-ascii?Q?Dx1drBVT65fMdFeLk2EhK75XBzTPXi0W2Rd+SfxKdQYPa7HkMtrgpOAEi1or?=
 =?us-ascii?Q?yw7x14DwM944NCd/7XTbXmB5JJ80YAgL/gAXS/kKinBw5GeOz+iGTEWN1F1p?=
 =?us-ascii?Q?b1pyUsx+sLW3lIZl4KYUFkg6utPjsvNVqShpVVEcrFlpgEEzulJnR6ZGIkBl?=
 =?us-ascii?Q?pSbObSLs9xKBbyaduIKQsGRUjHiV4Ah0Zk8eU6Hvf74m887W9of2zgIgjSHu?=
 =?us-ascii?Q?5PjlyFMM8s0EMG2U4erxUAnVu+hWWpO/YQ2vE8CtnIS4sHUAg8rY1TwSrxM+?=
 =?us-ascii?Q?vzgHgMnEmPiVqyHSW1nqC6BGLNnz9hk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6001b90a-f15b-41c6-531a-08da31ccc16b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:01:11.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gz71ivjON1N7yCftG+6Z9yt5UH8xVmfFoSJcLgtsXB58oylb16SLZico7T9ifvtoVsjuK6qIdrYd9OsL5j4Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8107

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

depends on:
 - BPF round-robin scheduler, v13

Geliang Tang (4):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: add redundant subflows support
  selftests/bpf: add bpf_red scheduler
  selftests/bpf: add bpf_red test

 include/net/mptcp.h                           |  1 +
 net/mptcp/protocol.c                          | 26 ++++++----
 net/mptcp/protocol.h                          |  4 +-
 net/mptcp/sched.c                             | 11 +++-
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 52 +++++++++++++++++++
 7 files changed, 120 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

--=20
2.34.1

