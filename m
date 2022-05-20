Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F267E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xUPuvPm4/+gG5plGjlb5yX9356ABl2TkttZ9hG+ZXr4=;
	b=aR7vcoPRa1fiKLWaT+y6ztsICLilmY5pvxYdlLnLO5P17msOlwKyEbWw5BTlnoPDR23CpA
	rSquJMtFXI1MQPusoM3dtU5dvhtCm6x0j/6yTmnQ3gL3n7sxy274BpooCETF24dTXuxRV5
	QG1ozuw+qkoeRcXDsuTIpQCfkQ4o/z0=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2054.outbound.protection.outlook.com [104.47.5.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-BXxipQHWNkqIgg8v2ktyjQ-2; Fri, 20 May 2022 10:04:59 +0200
X-MC-Unique: BXxipQHWNkqIgg8v2ktyjQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVRCpP0oWapmHtbzftuvkuEmBH0qBdxlJddjAInBxpWw2CRifcuTkdZ4hfj8WLviB6b3qkOwryYCZ0qvQVzJ+oS3Tg6EZYPn+cbgnu64ReXPHAd+AHlgvQjzvsUFoqNDR6TedfAA6utfJAKlDEqbBLHMMRdkSSc99KLOfgv2fOCiu3wS3Bs3QqajQB/lDbo5HUAFGF+HqXNRxEYrAMfOhRGT2hHQyR0bKAjrbOPbhV3MbQd0MAEpOTo85PuSzaZ3E6j7pbCsQmS+6OdW7OVLbBHLNtedth9sUdAJxrMpyhCE6q8BYf2SxR64vGJQ9b0fTDln2BN7dDhTctDyJti2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn0KZpPyuhaazcClAu0p7F0DT/PzEFt3lrYnat09XAA=;
 b=N+nTDQw+uGgON8nDQ32dWkD9cWNxzmuYded6Dgcon5TgNjJA2VymUmLC2F2oGnZMq6yf18wnhhnz0ZGPvihnWAMcUNndhHTI+L1k7MDvoWKj/v8iVfbK7ZaJd6W3jm0DE/Fboj9b+kbQulIDHmfcwtj5TAooJrm5jfM8UYhzX8syjUbVRN9vuk0sXRSAFjeaPI3enFD/jqs1bM4J/L9denRKO1dkIxmd9KycHJWOim+/qKsU8IV/L1+8/nvmZl2xrUtbOA1jNrk7DJ8Ne35mZUr3bO+QhJMQbtcw0Xnz1PicY0feeUTxvKNyK8KvZDG7HWE78DWBnwIODfx3djymqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 20 May
 2022 08:04:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:04:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/10] BPF packet scheduler
Date: Fri, 20 May 2022 16:04:45 +0800
Message-ID: <cover.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 143222b5-eeca-4e49-df61-08da3a376e5a
X-MS-TrafficTypeDiagnostic: GV1PR04MB9149:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB914995BC21B32BFC53B1B98CF8D39@GV1PR04MB9149.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D4s7b22yWj0C8Q/CFSjD6jEulSw4K0FH8WaoEBu2Jb/eNuU/6rHxQfU19fSmLozTNY2ythXOtOBILYDzM5imPA36gtGFeCso99odmjdKTJz8U0vCvjjVZgaPgnGnOyiitVWhapeeNRLhO7ZN/aImPwUObEu8pebMnfcE0cxgkH1KT4hrrUmmbiHSf3weXkBzy7QbhFhOWL91UwkuRMEsCiFfkkVzra4pQRONwI+vIdrrbSakukHvsfv/SY07/LHS0H+lgrznQsBCEVu7sVtY82yyqpQCIP29II1HLNDv+oKB0TxWReBylFdvnUv0t3nuFQvNKbT7Peg0/yHS2X3u/uE6Ahm4oR2tD9va/3gmUjZKDEMHlFuc0dDlRU27MDwg/HXaGDs6nn4VjZ76FcBx1j5ZdYX9ZpZ0TMP+oXwMPBAdZjVj2Z8zmBCaGXczQ7auL3C3Xsqudmudox1PMdAhveSq5WNkO8InLJaQIK86Sea2EEcvakwWwDVjx9tzpgtoa/nevBaIV3PakA/1Tb4cSKLMUNstzadf7WhBLWm7W5NL3ETaNNHFPb6AfE8fcplNW/zMNTFSESyqfOeljZq4FT3F4W8Pkqi0gxnwY2Y8G8kIBc+RsysIJiKyzgJWSiyLxaO1/vqYpt00Avld+rpAavu20tIAAnAh0MVHSH3X8ytvPfdwswZMRvL0aYXn/AcUblAga/f4N3bNhfehob7Ahg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(2616005)(26005)(5660300002)(83380400001)(86362001)(6512007)(316002)(19627235002)(186003)(66476007)(4326008)(508600001)(36756003)(8676002)(66556008)(38100700002)(6666004)(66946007)(2906002)(6916009)(6506007)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SnBWnoTPu3u/GrSEVxZT3DtUeaRcdmDeDynJ+1uZmxn5XPQCeky0fgRo5DGN?=
 =?us-ascii?Q?z3Kfaj2qNQQHD8n5iqymvER72yVJ3e0enES+PPaitCqbKtVR7Al8hsiO//wD?=
 =?us-ascii?Q?hJ5gvUEPLPyolZR5iswMk1GwbkzetyYbO6FJdwlNZM02enTb2ycNjVA4jn5L?=
 =?us-ascii?Q?MFR4XcAZEELWGT0L1XM0h4qeOAGH/8/UTx5QdEzLzhs2TAOzBuEMEK192JC/?=
 =?us-ascii?Q?IMXgNSM5fGOUI8U7E0rm//f/bJKE3aEKe55CYpc2J4cUgAmrj94yVL8oYVJC?=
 =?us-ascii?Q?a/GAEUhKCvT2VmdzPQzCMFcaZlif5rR++VEypy6V7ZDeNQX2yUcgsyOpU9C2?=
 =?us-ascii?Q?gKYglJ13EBXO1gQlXLVxGgeE4/PsWNHDV2GBW1Dg6V81KlA8bt5fjIfcHUQ7?=
 =?us-ascii?Q?J5Ertt3Qymbvvbh6ABbjGIebIZqARKSwaJSvwqQjJQuMq5gwXIEo7iiwqfoK?=
 =?us-ascii?Q?J0yPBHFe/5NSeyK5t1Qky9TvCuOGrYymqCHWBRXxl1qWehQT5cJq4wfcTkIy?=
 =?us-ascii?Q?QuUq5VU32krtTwJ7795YI9GafAYvEZeYMaldasIECg93KJIYAVKM9kAa6njS?=
 =?us-ascii?Q?7PhKLC9Go5pVYEWzhsBF0N9r+EkJEDL9WtES8vMooTL8nLnLDpiZXCpRa3A1?=
 =?us-ascii?Q?TqvzZ9nxacRRyztZA05RcaNbA8lAqgW68A8YTqBnZ9Wb7HNt4sNjZKYrADAz?=
 =?us-ascii?Q?fVfR1ogZBsiR1fhnuplYmzkmx/cP05HFCfHt4SdlE2zfV9DnZAm5OgOaZJ6g?=
 =?us-ascii?Q?cNlMtBjSGX6w1Py6nAa5HfbCmKkK03XiFYOPW2fZBGUlbcaF5wcIqKwyiQEv?=
 =?us-ascii?Q?iwh0U+4fgjxhnF6NXMHHk/lwzzo1PPWTvuySEXeP81ZzRmjSJuyT6Bq1lB3l?=
 =?us-ascii?Q?0NauiGDJI15iKCWfJJyIqsmUpD4WUisJC6GAi1vs5/F4tBFYo4+RkfnuQmxN?=
 =?us-ascii?Q?Gjx0f3gVThkUGA3lpG5HooAL14H2rovohFP+zWUDlztVAg4YfAOdKLo6fULs?=
 =?us-ascii?Q?Iu6ylKHPPrjdobhnx2RsWgwJMB8ChMgAIrkDMK7kuzuSEMHt2yANGiOe01/3?=
 =?us-ascii?Q?mU0lAiprBwaKk//rWF1hEmto9V9sxhLZWE/wWbhdel+LEJrh6o/nn6jko6hV?=
 =?us-ascii?Q?p0jrEfOCjgPdUEF3C9MRfY40mGty7qLS98jKNkp/h5NjZjf55YvSmTiRXFi9?=
 =?us-ascii?Q?3dE8w7fmSRfQZxq15C3c9rp6J9L/HBr1+KwaZxx75RxXgk7rAHSpiYtlemnf?=
 =?us-ascii?Q?pYndkqcrImqMiI0kEuhfJfy4xuHC+AVBsV0ekmAAeG1LQUoEDOY+lVZbu5yh?=
 =?us-ascii?Q?GMsp1Uh6PgKFfw47wOuMghyRF5MV79R3KgZ+yBz30sxP8pVumrhponou2iDD?=
 =?us-ascii?Q?Q71pIzkHavInCOzkdm5O5xss1YilrQOhDt8lZxNFggYjkKi1Pd3HIIBDDkDO?=
 =?us-ascii?Q?qNyKQfpQwwrnU39eBQGMJRfzCM/oJxrKXtvm2veAfOxXFEZpAGgyX/pqI1V2?=
 =?us-ascii?Q?+yC/US5vZ9ELq3xGzSWsHzLflVDXf/Ps8AUhR9J6uf+hDzeYp4FFwkn6upem?=
 =?us-ascii?Q?ggogD+xm4EtCTZ0P56ge4gbmEEQYLtgGtjrmFVGn3EBV+ixp3NbgP1pwmAjR?=
 =?us-ascii?Q?ZcL2uje2i0F/qlhYVleMyU7etCt+tZ+3a15WXram8UUE9YhkNhRVh9kWNuSR?=
 =?us-ascii?Q?ORepkwLxKX0NTJHKCRtwDkgHAl7eqmKMUFwUwFPRUbe7/zDhesSWCBHHnz4V?=
 =?us-ascii?Q?uPD3RAFmB4iPgdk3karvD3mPZWjWLlo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143222b5-eeca-4e49-df61-08da3a376e5a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:04:57.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zju7z6S0vYFoSnr2rZC4//9jE6Kur9I5BjBciDVVx1XhOSXD5Gf5lA5aoG5K+kULhCGz1A6DPf+8RK6aPLSmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

- Use new BPF scheduler API
- merged "BPF round-robin scheduler" v14
- merged "BPF redundant scheduler" v2
- base-commit: export/20220519T160645
- This series will break two link failure tests:

Created /tmp/tmp.bTGaRxJupX (size 1 KB) containing data sent by client
Created /tmp/tmp.K2Llsy3W03 (size 1 KB) containing data sent by server
Created /tmp/tmp.4uLEQcKbee (size 23622 KB) containing data sent by client
001 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [ ok ]
Created /tmp/tmp.hV4OKPkqoH (size 12288 KB) containing data sent by server
002 multi flows, signal, bidi, link fail syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [ ok ]
003 backup subflow unused, link failure  syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         add[ ok ] - echo  [ ok ]
                                         link usage        [ ok ]
004 backup flow used, multi links fail   syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [ ok ]
                                         link usage        [fail] got 11% u=
sage, expected 50%
005 backup flow used, bidi, link failure syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [ ok ]
                                         link usage        [fail] got 10% u=
sage, expected 50%

2 failure(s) has(ve) been detected:
	- 4: backup flow used, multi links fail
	- 5: backup flow used, bidi, link failure

Geliang Tang (10):
  Squash to "mptcp: add struct mptcp_sched_ops"
  mptcp: reflect first flag in subflow_push_pending
  Squash to "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add bpf_mptcp_sched_ops"
  mptcp: add subflows array in sched data
  Squash to "selftests/bpf: add bpf_first scheduler"
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test
  selftests/bpf: add bpf_red scheduler
  selftests/bpf: add bpf_red test

 include/net/mptcp.h                           |   5 +-
 net/mptcp/bpf.c                               |   7 +-
 net/mptcp/protocol.c                          | 201 ++++++++++++------
 net/mptcp/protocol.h                          |   5 +-
 net/mptcp/sched.c                             | 107 ++++++++--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  22 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  76 +++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   6 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  39 ++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  48 +++++
 10 files changed, 419 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

