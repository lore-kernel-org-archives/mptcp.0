Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FB28F6
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652271467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1MbWMUnJBCs8M1+nyFPnnHETiwkqlv9ph24Fyf2HJN8=;
	b=HOwMZKMuaMsEqgerM0L35UVWim16iRGmKP4vKpfusE2zX7COV8Y3p4NnK+7rJTZPM1tZ2v
	dOCFNsoCNAc+9jkcOZTWWtVF4qkUXXFgoMc7PuGuD1Oozgq3+1mA1Kjd35OD+d2yk1GB3N
	k/c2K7V0HYfHry73ZQY1fqwevM8jidY=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-WdpzwWCtOOmI4HlmY_sPRA-1; Wed, 11 May 2022 14:17:46 +0200
X-MC-Unique: WdpzwWCtOOmI4HlmY_sPRA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdr/oFzjydtWkrYVsGCdzPuuMvDkFTcYEh3AS3Q/AifVELhZzpXsF6rDVcIvBQ1bnEhs7zFHla9Kcl6LyTMjc1R9S6a6fS243odhN25WQsqbgxjPyaw3djsSYNtTo6Ue2MZlmqZmZ8F1H76nBCOSeUz8l/DgRziNnpuQ7r6Il38UujpbLbjhr1JmzAxMqrJ3hNGKkdpK5cINY7Uy4FOXL7pAuMhK1zMInunetS4X/nbMKgbMcvOD1IEc/LVe/KEqI5Okb89RKN3vH2Q1eNDPrfHucmPrftMjgL4WQITk1asi6F0Lj4P5NihNBD10YOmHW/XXOktdWOBcff2GqMvUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7AyH3toHTLD4NlKuJW2XglHYADD+iLRYZND+SMtdHk=;
 b=N0yPbG6ckdWsL3SNXFIfN+CdpcgCYGmjzuVExjNA5q8sCgUu7HLioGFLhmmil/5yS0fpumlViayIEUdxiCJI0uPoiaEH4cB9BBB72b48q1yBtrN52PsFLSb8Ht7nHLO2rUcOYjWPAscLSHVjk2zm2ihmAwqFTh8MDhL5IWpQLLwfgleDacRJ83YpSBDidylxJRluB5ymr2y5aIjEs9ls+MkHc4gldkwDXFlW5LjsSxpJ3+vPqtWy+2rJkUBq3S9MCOzwA0xIT9mjMSIYycuYkGvqeyEb6Ts8tf3sF1Wo8FubybuYeBA1qU3hjX7mOf7uWSJrpq1L91jOgqmCrhnzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB6131.eurprd04.prod.outlook.com (2603:10a6:208:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 12:17:44 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:17:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/5] BPF redundant scheduler
Date: Wed, 11 May 2022 20:17:40 +0800
Message-ID: <cover.1652271034.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e238cd5-c3ab-427c-4468-08da3348406f
X-MS-TrafficTypeDiagnostic: AM0PR04MB6131:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB613196699853D43B849172C1F8C89@AM0PR04MB6131.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oCkZqljG5EY4JwkZvG8KERJpOlIEK99m1gi+J9TynNQpWQcdYjjv1AFodmM+9RZd5QUz0aEGDGM6JJLvYqHdT6yg8haT5JCUxH3cv7mePz7AYbGMfOGHfybfk1NCeGPxt9oP6jEnhPgLzwKHeTbPEIsVZrMeh4oDEssSbTB25IBS1/n1tebdSPFWfwkXlzXmF+zGyrp4uDddOUKG3t7Hre89ntXcpTSgWVj29bCfTzJhT9Cy6S2Y8YmCYRsZtX0w5O4OqjN30pjnv1y0OYDgusZ7nOqVOiUacvxWloT7dfWHS6bsxZ/88HEiNWhBcpeGWPTB3O9tjeKGlV9jsZAMrsXxdMjID8enKJNkkYswrtoE8wc2LNNoFsacpKM04XuBX/sYQZY4txAf1q83hLeUVPsOqWXikz3KiBDhzRCAbzRY/gZrkaem6/aY4v3wsLvUgt4YksIpbiXBCJHM59I5Nzy8iayD12GzcxMdf3rYyBhYZCS5qyjilBr9j61/PzCWz/TD8VwnWTQ0kWxD+9VYcnZWVo8kQukrxkUxiWe4vH0kEYBN4C7EQwqfgCuA5m1/5UhZzQ0wUGXkBlhGDcmc5ruujT1KPacdSUya/X5Bc6Du7vPU0dnDRM76DX7uSoGLPhWMWdv8dFkFwkfUXKiKhwYCBQU7MDvSsozWRhLTSFiCoUanpf6Qf8UA0Hsjzu5VS68ogJ/BaZf4GPDeAKEk1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6486002)(38100700002)(107886003)(26005)(316002)(2906002)(6506007)(6512007)(6916009)(508600001)(186003)(83380400001)(36756003)(5660300002)(44832011)(8936002)(4326008)(66556008)(66476007)(86362001)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wl8aLFG3hHGEP4svlc4GdVdvt8CSuTpEyGYmWSC82ukZ268tRnlOxlAyyTl?=
 =?us-ascii?Q?fekfwGbnGxzF9y5JY3SZ7QaHOR80ZbIOKA+k5vJL/uMJRpbERBmen9g+1z/H?=
 =?us-ascii?Q?k+Pg9dOIMdmAFNeN32Y83uNhMRRL0gx12sae7KT2/pK1X/hYBipq6pjBjDc4?=
 =?us-ascii?Q?pLjSuFvHbV4eFRC7o3y36C0pr/+BleWrJqL3RHW0eSB39aBD5UU5z+/Q1IWY?=
 =?us-ascii?Q?A+/DViH/vBCvmAD9QvonQHRW2WAfDsaF6NAmYAN8YkvWWwZOfeYFSjv5yxcc?=
 =?us-ascii?Q?qhV4bl9YS1gkuovh358OhvJsf3tnjxbkh+Slxxo7+X5xjNTP35W+5GWQYjDH?=
 =?us-ascii?Q?eGs8TW3gMPLjVQ4BSgVi0gP613OaM9YufLScSxR83ZaaSJ3YAibPW9xwu8nQ?=
 =?us-ascii?Q?rud/cNZodOjtQynOW4jI3YKl+uOAfnNM16UtDQc7MrLBwBLYfVcszS0SsyzN?=
 =?us-ascii?Q?OCKNhvDqTO7mH0yyIwUhGFWM69xDElrt9C9SHRbyRwTOedlhNlS+/AuAq52I?=
 =?us-ascii?Q?iZYgWDlq/Z/iV12ZkIbcsb9M8EoZ1oupqbZbD2a8aeRxY4/XDR2usAPqqGWX?=
 =?us-ascii?Q?cQUSGl6Zd1qgBap6GC0aSOSOKVCQemm2AekyC3YF9NEuPFedXfKUy6JFPgeS?=
 =?us-ascii?Q?7sDCZfn7+h3arGCYJvW0wlpRqzdeoUFCT5hcPk0gKPxzxDtp025U5Upc7F+K?=
 =?us-ascii?Q?fVfCQ3JDHFQdvVJVOBKmOrjGcYZBvMjcr26EGGa/7ES9b0lcNcWaQLF764IS?=
 =?us-ascii?Q?tMwruqhz9hekWA6IjFyvwYTxoh4VCuTRh84f5cjSrKPj6QMZgMYkW/C13EdN?=
 =?us-ascii?Q?FhM5w/HdhkUWxKgwL4cQGpE2t82Ud8L5kmsDkIYy8dJQNa7GTc39r33qrI/0?=
 =?us-ascii?Q?uvUB1Ci+BDPnNqcEyoC6mIyFURO2H0f1Ca6Mhb6w1zbVgWhBii+KOTCBdG2P?=
 =?us-ascii?Q?+Vj/lrBnO537xaJ7ym8O9XzbYz9iU2OG9Cbjy9EambqEiXhcqPUssnMf5mCb?=
 =?us-ascii?Q?KLaToKCz2qOrFxUDq0/BrORrWJwJHYVdEAbfkEw/q19GhAzPAIvT3oO2u9ct?=
 =?us-ascii?Q?/VWn/5ItXhJFvY7fGw4wIdy5jtDQZj5Dxq6ol+NrGeOtdaiKr9bAwf4gKHwI?=
 =?us-ascii?Q?mDOc9WHSFXRInGKaInr4yV1j6Ey9ILSSrKZj8ttP4AUgW+ZFjirAaOUmdEru?=
 =?us-ascii?Q?nJX6NTtgPpDkwmdHggf5P9FothDdNNnI6xALHzph3A8cntAjR+j6CB5PX/FN?=
 =?us-ascii?Q?Gms1fdMcgu+py/8mNZKOZTnA7qiKDeK5+UHZLHkg+8b96Ss6HEApT6zaVmnQ?=
 =?us-ascii?Q?okpK6rB1O5W4/st8yBBpNRxceRGXfEfJBkWSHCkbkMrWCUrWDNMGCgop71kT?=
 =?us-ascii?Q?Z5dwlWK9Rayx3xuQR/lC2G8C+gp+4ZIhBqIbLUbL699R15OM7yAajezUSckJ?=
 =?us-ascii?Q?EG8ME9s+KrE+MxTEypMFyI4+R/SwgDAZHNoutbQqa/zk7Cy8MRWLdAWYEV/v?=
 =?us-ascii?Q?QSxvXiZuZPpG9K7xVffoZdqEcYJZqZ9jrL5pykUdcgOLpnDHyMcrVNwB5BDx?=
 =?us-ascii?Q?Ric3l38AN4PkOMz0ZKIwiQk6wgMd576rYT86kxZgALGnbbZ2CG0yQRCTuImX?=
 =?us-ascii?Q?+JiEKwR9f0RD11uZFBhCfjPFEVH1Y+vMPIMXQk4CrOjGCadevphbM4Dmaapu?=
 =?us-ascii?Q?VqMCloV0hTcH7bJbm3hm33uDVOxfAL//6D01+NUfbj3X2ddz6fcjcmUa/Y1e?=
 =?us-ascii?Q?NfOeOzqry+7ZXShjGf2a92ntOGp2sh8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e238cd5-c3ab-427c-4468-08da3348406f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:17:43.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEVjpQBwnR5I2j2fmltEtILlUKCREmuC8JVcIK2B4hjxhlq5kw6YNcqWCjVBx7mv0diwToTyxWMmwHtk5702Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6131

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

depends on:
 - BPF round-robin scheduler, v13

Geliang Tang (5):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: add redundant subflows support
  mptcp: add call_again flag in mptcp_sched_ops
  selftests/bpf: add bpf_red scheduler
  selftests/bpf: add bpf_red test

 include/net/mptcp.h                           |  1 +
 net/mptcp/protocol.c                          | 64 ++++++++++++++-----
 net/mptcp/protocol.h                          |  4 +-
 net/mptcp/sched.c                             | 11 +++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 54 ++++++++++++++++
 6 files changed, 151 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

--=20
2.34.1

