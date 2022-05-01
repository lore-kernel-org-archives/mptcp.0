Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624728EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651413445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C6rR/FQ9vgGpfYOJZy0KtcBPa89kmyklrxWBdkdLe4M=;
	b=Tp+8ribYd+DBkD/GaUjBLEkEd7srcagyV3OZnQVcllk2Sgbvrc2hyKAGPDPB/K7QN0dqRV
	pYrp6Z/e/31/GbenpmKHgZbXZpQCtKgZEjZjX+1b7+spSvO4ES6gpKDYer2r8UBdoonYnr
	/srxiNmwuGjMSEvbWvrosD45c7wPHYA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-iUWniCfnPYqJKylZndBCoQ-1; Sun, 01 May 2022 15:57:24 +0200
X-MC-Unique: iUWniCfnPYqJKylZndBCoQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhdT1k5vzXR9oUAvsnhieYgXo1KUFNgMGRCDqdRsMzFzZMRqfTEjVUuDxbwGvD2XTNFi3RcNfQF+mafKU56u7MGd6pnfkjCd7Wlzs9cigLF+WTvPjxV56Glswgz63qalfyjiZIkglZZkOWO/Bt+pnMAamLjKrHl0/cCbEix5eyBHSw2iCT/eo39nPeaGmv+Jl1UaOiMrPCsoVapRwSD3Ea5emdBoMxeoRGs89vk6ufLxgmhNHJ09vzEMNqnJ705bGiGHI8PeP9TBC1VhYr98a1u6juveC5rPxFTIYt37+wlOillXGiZscdS4GG1UAudBpM76m1emStdDzAHTG05Sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpPV8Jp4rp1SsZ6L7Z6rEPdOWlIDfDwKSbYYZXZJosY=;
 b=cH8qGJyvV/kkCrfRhjN6cH9RWr+9RrS+0Lg62tfxMFAqp7SSzC/fAW6sS4uCqu5rdJmDtHAjOYlddnm0ziey9mlanNAC6C4KlEetWlL1PQpK2Va//78qv7UG8HqhNRgzzSiV2wm69Vn2X6kzubNuzPH1AzUApPxT7qF3UMY6aFKj7xNog41mkYCYJaxG/gxehpCYdWk68YGwpM++zehLUKny2B1dtWqvDPRBPoggq8suznB7U+oF966M4paqSJKgirglTjCn88TYdNjltBSf95QUQReXg8vIbDxyOcFnONFgGx5i9Q0c0b8y6fGdXQGnKdoLPWH+Fyf39HApuMyplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:57:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:57:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 0/3] BPF round-robin scheduler
Date: Sun,  1 May 2022 21:57:11 +0800
Message-ID: <cover.1651413062.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c8e56a2-2e92-4691-2233-08da2b7a83b8
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB62835E0476A8721359EE1E46F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eSJfbv/waHjXOjLIdJ6W2+Bq1fMKTwcYMbzGimd0xtr7cjBfpeR3kZRu58F14ZJeKpj/I12e3kpcijhf/7CuteYqX6ayJNj54p2dAkrR65uk/kdBvwfGhManFdCXeutTxZNCik+c/H/7sRe3w7CXjJ+j5+KWkeQP8vFnj5NAytxNj27zEJ0LaBSz+IfloO8xOrQFi2jcAnDcZoHB7bRkBmIbyy3V4AWtW6ia1Ln+tAGUxrGjbo1/RM/FObleKnb2OTuInJxSMGeCp2GZ4Gr6K+50gEzGAQ/p3hAZLDITUQ4Kozjm8vMWdEjBtYHZiaLvxiE/7HN6ro2rSOVay1upmHbYumDx5AfNc4VYn1MCpC+XFudRw9yFzRagxbGQHfPeSK98IEf24B0hqW6dcHp8g58KqyoJBzQoFgFKQJkUtdlNZbtaGzcEsS2gZnOvdzAt7w95YiBgO4I/BegNkrmAVAdwxyL/n/3LGObUbk78MJ3OhqfjhfK90gLQqzFcqrPYBQOwKDS/QMKAwbUoJTl1PkVTKbRfIJBPrsT//zOt7kAdToHosuRqj+i8mK5QOdhCk5a6Sp8SUdU/oj8HXniekDGUB4xZHerRz6VqbzJzHLLXIJjI5MIxpbzvk30MeCo32OxHnYLNdPDSXXg+IAMFuN2jIMWjGxr3Ps6tO0efGZm4QG3T3kI1yBzy7gwJLKDWbB+BrswGylHCs3eX5srMilVyYjUX+21XK/DQ+AZqeSp1Jo5d+px7WDwbn13sAp0UyVo2xYMVhNTvD+WXCPf9KKoN7iLrv8IC8qnUO2FEZ/Cp8axzNSzL9bMRkE5U3x85
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6916009)(966005)(44832011)(2906002)(86362001)(38100700002)(107886003)(6486002)(36756003)(6666004)(83380400001)(5660300002)(26005)(186003)(508600001)(6512007)(8676002)(66556008)(66476007)(66946007)(6506007)(2616005)(4326008)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5MG+v2MZHUjHze1fuHIgVCo3aBmcTHyICxFfmLODBXYsivsHP+zicn9HKbrt?=
 =?us-ascii?Q?zfqtCSHqaXBHRs2mbFEUmFKNlhS/BUZEKx5cECDuM6dPZuVnbibo4CR3fhQB?=
 =?us-ascii?Q?K0GV9IIEkWamS3JESn+zfQF4fBJhz8FcZFdkKQEswY4o9MHx0e9BIyYbOwey?=
 =?us-ascii?Q?9MjoGi+TdVUs3V3URSd9Q8PsK2JOZZVHrtafY77os+Qba4QmaWH1xRyG56Kn?=
 =?us-ascii?Q?d+lSgQ8mp/ysO6GwE0Zlk9ZrfHaCLoaKGt/0rnvvPLUQFD4VU1I3rN3wJgYM?=
 =?us-ascii?Q?zPH11b0ir7uEkSrdxVORMUhm5hgWyf6pUxEbnxDZADxzNbbg3a9shwnOTUN6?=
 =?us-ascii?Q?7yJ7pNSJrszgmIwzhYonicetWmJEbOxPUJ0VvWZcn7UYx9GBnyIoBEPDbnvQ?=
 =?us-ascii?Q?CJCG8MSaupgiR69057YEzFyy6PjhLyQgwggUV3DjfJGmWfFPRcAAWXSrn1QH?=
 =?us-ascii?Q?CmCapdLULOW6sgujD9kE7OOuuQKZoyRNUc8IHgH+el+zOOpmD91KGfHKR68r?=
 =?us-ascii?Q?owLDxkeWD5vZ8WD41WuXcoHygIJGZWyg0IxUhTwRtUvn+vmm9AfvGVKa+S7n?=
 =?us-ascii?Q?HEX7UHfZN4uOwKeYe34RTxXNfqcfj27/Ln08U9O3tzOdoSJNfHyMD5yqxItT?=
 =?us-ascii?Q?vd9vJ0YvUYeF7uSFgncEquY9zRHg0mChjLJQTgjcuUomQkh6EJyPofkijyZx?=
 =?us-ascii?Q?fnGZWZfRZnM2j4U0QTp9JzsUocbXPU309cOSE4BrbSUa/7kyxaWZYSAtl2Hf?=
 =?us-ascii?Q?z67bmcJMAFOXQLWPop4Qodl9w5NLfuU+eH+6qK3+Gx1XU3oQpDNrbsOa+U2n?=
 =?us-ascii?Q?mHuCwn6eXHIz64PD+kY0Q5lyDxz/7UpWX60hGLGt74YhIcJfVn/FSsPVfHAh?=
 =?us-ascii?Q?CfkCvPhfujxNiku+ztvcc8KyOyMIK0OvvfMr4B2EXgvq9+tOgoF/dsE+x8AN?=
 =?us-ascii?Q?KTLMkkDH6QbJKrb3sSMMrGt9gZPwn6UYkvBwAQO3mVwofM3vPR3li1hIezbN?=
 =?us-ascii?Q?tFAdk+QDB9bSHiWngq1lUoe8f8fDhCQGlxqoMRtHAahgH2kmDStekGxGQ9QS?=
 =?us-ascii?Q?TPE038R2qRueC1LaAg13duMsieoa1im5oQNYiofTQQdlYsvokDgTOQ5/0a2x?=
 =?us-ascii?Q?3CW9/5gx1orj6hbXqwMsV/UMiHhAu9zyNJ+8FndVeC/P0SjO1nBQ4s65f1pL?=
 =?us-ascii?Q?LA+aTAxsMjDLZAasXFBJV6EEdyd9IV9Nx6UWTEhAHJw7XqdmIfrEpR50oKtm?=
 =?us-ascii?Q?1gjDAE18F3FuIt+XpBTUMuz1Oj4zyJzVj3XuZ3TiddHCDGAdOeQwiISJRgtP?=
 =?us-ascii?Q?mDddj5f5JfuWZJxT3nbhX9Pby562Qhw6kKqNHYhV9weW8GMt0EySZW4bvdSk?=
 =?us-ascii?Q?e83kOxb/VTg+uNlNhPGOCmUuq0INkaDVZPeD5TFXQSVk5jh6X8o2qxk28asQ?=
 =?us-ascii?Q?QWlwSI4uEehvNNfrqpkEAPUEt3QR6xEFTYLlo1iajfWOIygGx8AY/hO5rsFP?=
 =?us-ascii?Q?CJ3oZsArMkLVlaPbvLQohfx59aJXIoyPznPWCrDpZp0lxZ6emPTEnrl0Z34u?=
 =?us-ascii?Q?rphabrBWDWC/rAbjFnCyIgWdhA0psEfYmlp/JRVjjVyftqh+c/TFXVAoD/uw?=
 =?us-ascii?Q?Ss294BGq5JS19wEPAm1mbsKX8cdiRFVe7/7g5SdS08mcpUjzwKBpJzZEf0UK?=
 =?us-ascii?Q?qOV0LbeL62dnqgD3E5tjqSJY7KOaUX7F7DIZbteqtwmwuhXggk20kfU3shaI?=
 =?us-ascii?Q?cOk8kaq0Ly5y856xH/aq/4jYwpoBX4c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8e56a2-2e92-4691-2233-08da2b7a83b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:57:22.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQ0Ibk9ePlmtERUX3v+aHRVhfyV+JE7VD0Ejf7ATOINZYCusyMgiwlatSG383F4wbeH9CDfPwDLoYl46gI7yqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

v10:
 - init subflows array in mptcp_sched_data_init.
 - for (int i =3D 0; i < data->subflows; i++) is not allowed in BPF, using
   this instead:
	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++)
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
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 include/net/mptcp.h                           |  3 ++
 net/mptcp/sched.c                             |  7 +++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  9 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 45 +++++++++++++++++++
 5 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

