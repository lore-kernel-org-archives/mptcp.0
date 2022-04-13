Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BE1FD9
	for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649860220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PoRbDBZpQobhUR58OFd8l8/GdVFudIuVpfVZmH/6UwI=;
	b=gkneOSQIOWgVsIhZRE/64r5uiIf5byHBPRdgWRSzhF7k/BXeqTLg0pYnZ9Oe2auPX8UbLU
	vfnXPYnAQ8PP1qT42rCJOPn0X+oMQ/CmEMSerWn8e6zkdCYLHpVHn7naTr4SbcfyKh64gA
	m8SueVl1O+Iy0YleWq6H7AX3kIjdhdA=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-x1CZxLoSOwK5P371tjl_7Q-1; Wed, 13 Apr 2022 16:30:19 +0200
X-MC-Unique: x1CZxLoSOwK5P371tjl_7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egLTT3nTxUEScQJ9yu4WEw9yodWgIqHHn3LT0TiuXK3xeZX5up+yMRt+2Ex1ZP7/iakCUKiFZ7NpvjDwUANeC+WFiP9XvDy8jjixg25LH/ljJEvcbBjzaRli6tM+DU5Ma/iiJ5JWr2SM0MDMW9UZREuQWQnxGk/wx6ziIppnnaR/D+40l9ejRBcdyGshqn/jB9o4SGh3bIjnVaLszORrwzWXDlBPJrh1BvphCthtrCnamIBsLl0vipc3wvnTTkAw543raY6jD0AQeWr/iZEbYXNl8VUbCu8/UvhsIm5tkjhCbOOypF2RzmDyYRYE1keZjIs9WzBT0uMqkwPnPsbLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6+XY14jJ21r0oZxe/iuJv54FDvVwA1F9/FZHLDDnVs=;
 b=JO1W9r+SCbt2XUA84snUd7JWRLdtVYfk6wPWscJ8kI4J8oJL3O3LcJVxHGCsuJ1a0R776vbEuudcMjIfx0hB3kYmYsLi4Fy3e1fsEtm+COfddM4lh3X2FWSBV8YnKhG163SzMLzRmRSOC9d2qGrTbkxDcCbxCTuNcHjkte/YvFD0aJbvB4bvFisdTjYXm0DExtdWqqTYgCnglOpOXElri5dI1sLt0oqt0AvdRZ0w1toqQ6ElbnoLA7TBFuYuKKDXzEtR5SwCwIUNYSfrr/w3iky2lxrNNpetabxLYeIKnSlNjyesAxqHlKPAg7/hFYLL708bA4vz6zZDiKK2gqIUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4551.eurprd04.prod.outlook.com (2603:10a6:20b:1a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 13 Apr
 2022 14:30:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 14:30:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/4] BPF round-robin scheduler
Date: Wed, 13 Apr 2022 22:30:19 +0800
Message-ID: <cover.1649860043.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:404:15::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb5cfd7-5d3f-4ddc-8162-08da1d5a2120
X-MS-TrafficTypeDiagnostic: AM6PR04MB4551:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4551161CB848F6CB31B6F474F8EC9@AM6PR04MB4551.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5kLEEdI6E8QgNQsWXBOqjfD6Fomv6rZfEgdrf+HUxW0a4rvqFscnA+WBdztZURkTiyUIQUuhAgzX1zUUu1b2guEQKm1fvhfuM5izKCXlQTSmx/zfzcvRhH2R6u7Sz7cELS12ijLV4UWp6bBtf3p+PJn0mLSGAKtpv85MhgZNLpm/K+vkZ19otPBac1YK7PYdGw04B9zA3TxVoEhN6klH+fhHyEWEGfxmamgM1/PwklZQG+bwaxBLqRVJnDBV4c7Ok666rJtgjY08Ya3ZHrPoNbb+1I5cnPrMM5KfRmELMaeN4CitO1BLn1fyULOOgtzqgl/gpSo2PPeVQpXddnimmpIE7l0nEFGdOy7Xe166wSJNjSxo6cPrlbS0dwIU5JDlBrMz9bE5zGYqtzD2S0d3COi+5IA4fE+4z3qcAn1otdcoYtaDyDZX/M7BRi2/1ufSxhfT9Covx5VHWiAnfwJmP+6ZIkyC59IfjXVOTMwvWR+o4gZDKWBDJ7mcpNkc+lZI81J0Sx2FpXvMmGFq1OMbB7suKImAxgVK2tPgtzQ/kHyukBjiTljwcQFJ1Wvam4/AZ6NQTa2z8ln8Q8f4ezukKSt+xtcEN/rxr839ma+nb8q+AhqXOsMvxhsWdx7ORqG356PazQD2clM+Mb8WjnZPdVMVHQJAOXiODfMcAmkKGdzsZp6hBzjRcy/o/rJbzTJejETivGT0pnVy/XU6IvqJvLELhD0vC06dDiwLJkcAbD8HDU9px5AA3vKE2rPN8F+WVvZyZKodHs/KMdp+VMfxEzUkZD3mQVqPO2TO3EhottpyC9du2rRv5nuZPMUaJevO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(66946007)(26005)(107886003)(2906002)(5660300002)(2616005)(186003)(86362001)(66476007)(66556008)(8676002)(966005)(6486002)(44832011)(4326008)(8936002)(316002)(6916009)(6512007)(508600001)(6506007)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZH7oDiLF2P6kG2EuJ3ZK5vc2V6D5TJFnkthB6xAGSJe9AtmY16faKhPSPdXN?=
 =?us-ascii?Q?V/J2AFX46p+hdzrcTcpkPnystE+//eToif+jZHdy538gatW6xwvPgl/ybDpE?=
 =?us-ascii?Q?mOm/BVGvkEjzOEAFEdDRV+xytPvUCh0dDnYip8vyrl+XJl7RyPoip07jnb1F?=
 =?us-ascii?Q?6FUCZnrMdfwlsrwl81/mcmiVjNxrU/7TPyWv2Mk9iEKxyF9vsBxts99mis5H?=
 =?us-ascii?Q?0uULeM90GGkPI/uL6l17Rb29RZ8ljDfGRw0DKG+T+mt7YT/4QsPPDG1HmLCa?=
 =?us-ascii?Q?qngCjy7SSiIwDek3KYp3abStI+U5oiXX5s1A+q9Jg8yPYvXOYsfcU3ypHyy0?=
 =?us-ascii?Q?SOZfXA7XHrZi6jKfuq6c1eWbey98Pf4fgatDAMGyYMST1AJrMIJT1hO+JdRs?=
 =?us-ascii?Q?UPnsI8L1dzz9GeGORAWkJ1MsqCak/lURvAAdyL2uLCMEyJsHHZATG5L8LrOZ?=
 =?us-ascii?Q?T7U7jIff2AjpyIpnJHeO8thqFwbOHtUBxHOrpnusrL0nVxRvB3dchMYDinMZ?=
 =?us-ascii?Q?KbwZEQaoO/H2ZtDrUlwBBckhYt4a/9jpjat+5QuO6h4KSUPEjqZT2tKSWhB5?=
 =?us-ascii?Q?Grxk+7tytfRDzQqsqg314Qu6e32aZLoFJuvZkAQhOJucSE+OLprXZ/EqDjwi?=
 =?us-ascii?Q?mFIZ8qZNvYVctNqgNQYkSJ40RSnaPK9+Kx8AshqJ5v7vVQPayULkKV1nfjRq?=
 =?us-ascii?Q?GFeHIVl4ljYRhOuSR7r40RgHLgUjKzM4nO5C+CnjyMh53Wwhk2wGErlIf7fU?=
 =?us-ascii?Q?4NJ5RQ2HHfqgyfqyZ/OUPStLqE7tZ0wTuFByO8HCA+XgkdDFOeD/EAXwUECL?=
 =?us-ascii?Q?+UK5RVpYYlX3uyXxFjjvo6sJK5sAFG0HWsGMXEUk4LwplkpGo7zQHrCYR3li?=
 =?us-ascii?Q?UhAVPYna8jBZtnkVGGunPjThd8XlUwOGkJNISJzHikt23dfiisZtcBNRKF/l?=
 =?us-ascii?Q?74eIMjWXUxkC9hjsXO4bu5ub39xjfyJX05QmZDUUZr1GHd/kZ0hpi8Rdm9vL?=
 =?us-ascii?Q?W1NfLScFmIt1+4IpdPY49A5nlgVKhdxdcI4OPHuSVejO8d8z9CNkI8Rml7Qi?=
 =?us-ascii?Q?JFClVj+XmEAfU6ayk+cE+XcDpwCdK9pHlTPzeSETh/W+1jv2ZvvM/3Ir4/J3?=
 =?us-ascii?Q?bL5+cU8n+1MLcAS8OJq+72qiOf50TjVTfclZoHm7HYP8cFU+u7ZX69EwnEB1?=
 =?us-ascii?Q?91vjBo/3rC8LlKZkIlcOj69GL+jfQ1NJXG14y2qfvbnEKEyGfHr1lrQEglWU?=
 =?us-ascii?Q?BPsMD3lq6qdfQ0p9TuFZWatrbEaE8ozcpGDsyTfsYA0bHzLerpuQ668vYlpy?=
 =?us-ascii?Q?jlAG+jQmWNLseUbrUg/H/x+Zw+JyrAS90JnkSTwieXBWjP6X8p10mtpve6HX?=
 =?us-ascii?Q?V4ZFG60eeaQXVWygJNTDtZ7qykXtgHdV8n10CxpgNmZmS2X6X6NoFJ9J8Sam?=
 =?us-ascii?Q?ObmKj0w5yHD9TW5r7cogMfBTL/ePkBLlGuBCHfYGypntMInCDsoSmAZV900a?=
 =?us-ascii?Q?fiLkLlu4gDKd1iJwIyRRKxKEzQYRGieO//OnZZyVUK44w6pHxkS4qCruu386?=
 =?us-ascii?Q?IR27FjDCMHQmbejwXbKSMT07hYuUkQVZZB3RuMFxaNdRZ0nPbgNWq/3EWnYV?=
 =?us-ascii?Q?ZSDQJP1fnElb1lN18OjnFPpycArpuAnK5sFecoO5maWM5h7CwDTRLk6pztUx?=
 =?us-ascii?Q?O7rxE+FFmUNY8NlRPY3NQA317IxK1kLm5gTxIcrGFaeP2WRr801zeTMtiVEi?=
 =?us-ascii?Q?DkvMzs8QGsEoRE3p71uKsuqTETw0pEI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb5cfd7-5d3f-4ddc-8162-08da1d5a2120
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:30:16.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeEfgW4TfBzHuoFslWkBi/GzjD8Yop81LoqbPXcHO6xIasPPua/nWr7/wBYBe8zDuD05WtjSnzgUOVyXWDo0ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4551

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

Geliang Tang (4):
  mptcp: add last_snd write access
  mptcp: add bpf get_subflows helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 60 +++++++++++++++++++
 net/mptcp/protocol.h                          |  7 +++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 13 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 ++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 54 +++++++++++++++++
 5 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

