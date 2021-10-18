Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722672
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RRB4GxQ9wRGItiVdMzz17WMVAwLXUitXSYvIt6b8jFk=;
	b=BkVQJz+QhvIKts9Du2S4Y3Lu4g+zQH/o6+Xs/QBCogmGhSUN+pG7fDfJSZ3dmgfZBPFIwH
	X652f3SSfcg0hNiQGyFZB2vtPJILwrnFf6wSYAQFeaxPPHUhns1GLnpcKu4FYuHos6XLyB
	G5NL5Kpwa5hAPFkQYoBQPce4GF16dCk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-v9kiKV6zMgGLXoIbxphkgw-1; Mon, 18 Oct 2021 14:33:37 +0200
X-MC-Unique: v9kiKV6zMgGLXoIbxphkgw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns8C45PTt4m3kjEKz9vpS0rEn8eB4AfBAaU9Ho3qXvHDHLgGO94yk8tpaG9kQRTHIwg1/4Rzf44CAJRivbANZjBz8EgVgvBUFjpz17eW6UuMAe+DdMAIfOBhiGyai7LXBmROgjpig2zqTUjdFNret4hxqoGx8urQ7Q9bFBu8WGy61soiTPBerw2R/vPYf3pa9/0dgU73cDAUEnWkiNkpDaWU5RusgvABsKtYKmK7mbQsPMeABWFSAe4tokP4EtTZ9TcqVeTKHEP2aWoVbIaVacfV4ZqmL3z/aF4buK+33+upEX4T/h+MB/9ehokRLGcDIeuFO0osFTJ/aRM0Bckdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PytR7LcmQug/7IefomlN1nR6jE+Q14vQmHw9SJviyFo=;
 b=Hzoy7huUU7CpwmlEy/BnTTA2nT3UNgbApFRdsSOGc2xVkpdy5KCu0qbpACmuV+PwxbDbukUHtyxYuXCQXD34aY60YTDOvC92gE6+ERoMze6Uh+LMQSKqKk7McjaETxQaXlUndegl4NJO+3OE1hs2eZFCvoy+CY9mrCW+vX/h6vxw6XdG1zXtJqvYFkKueGokSU0MfM3j68jOtgGPfYiSIpMtoBTYWWtjM/ylrI+LRa09Pdmdt7GF67yfHvjM1bQf2z/3KZNGfWlo+PnguRuS5Qk+auBa70XBeOwQF99n3Rdj/uxxnkoB8p1O9CjNfgzod30DDbFZOs0r7Z1NW5xXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2825.eurprd04.prod.outlook.com (2603:10a6:3:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 12:33:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:33:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/8] The infinite mapping support
Date: Mon, 18 Oct 2021 12:33:07 +0800
Message-ID: <cover.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HK2PR04CA0054.apcprd04.prod.outlook.com (2603:1096:202:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 12:33:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d0fe0bd-70c3-48d0-2a24-08d99233805c
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2825:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2825EB60FF13295129E8B8E3F8BC9@HE1PR0402MB2825.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	In7GFV1JaMYI83KugAnLgY/Wqpv1/xufj5J6/gsGb/vQfpULDOGYKFEVwciPlRlTsPp6DjDO15lNPzfSXEY505B5uMcvg5+oDlkp3LkgpRvBGDiCCi52azlsTKoNmPpsuVfc4wtZIyhJeMoalDq78cctVy84XTtvsdcSN8Y78QACcuxoKkw/l4ugAfxKMehW32BwSk/LNnvwku7iltceLjfEnMbZMdb7FarapvFYvYVct6prX5fWuJYbqZpicy2lHEIx5sZB77wKfeiwKWpNkcPkuqlPNDFoR9vXsanqhvO71rpsAzkMw99AF6O5cNSliUauo6IN1JtM2gXsLzRJM2uVVB1lt0F/g0cXD/XACJk8dmwvprHGQAOigg3qt4w74RdLd7NBpo5U1bP9wkY0yTLwZEldxTQrsNZ9oZ6Ik07KtITCeofqeLf4oc8wnLL619MWbD1yoPX5nxbhOd6aOhALJVGeMZvsIYwxw2qoQ6kfe+12IesmGxjnajdHIZ5dFFxc1Si7NSphm2cMUK1Jp+pqhZMnfr4cOT6hXZLiMKv4wEBXWRifwqtvnViLzRtpumdmqmoyshDAx7yDZwALRV7nLHwphvAwnllUaKpeEylnRz71K7WXbRfiEib9hbPoWrkzQzdjATgisx9J9jsosdpnhMo3H7R+R76IoeqQc3tKzneS0YbMGJv1MiFXLLsAtlQB5Enipx2aqvJn6iXdOSNScdrx0rJtBA5G5xEYe/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(36756003)(2906002)(966005)(6496006)(66556008)(38100700002)(8676002)(107886003)(83380400001)(66476007)(2616005)(44832011)(316002)(5660300002)(186003)(6666004)(86362001)(8936002)(6916009)(508600001)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34l/yd5d98iu+cQeyaIAzE31CuxtXZ4JZTGRKcvvAD45sf4HI3QEA981aoni?=
 =?us-ascii?Q?+b8sXBvEwUF3FQsVCRVEARtIr5lx4FTxR1Oivcj3Eesh/QAXmWtif6/GBbbF?=
 =?us-ascii?Q?i90Z/qF5amM4rwximcbLTimDzdj4aN04SVRf2kCuQP55srbS/SEs6eaMuXYi?=
 =?us-ascii?Q?PGrRPCWKyazA3sKZV1ETuLaB0C/B8XubqSecrZEtRRNgFP4pG2+5CFlFun6A?=
 =?us-ascii?Q?JBuFC9JBdxuKfXcTknWzgtvdhlu9RiS106OIPnRpHkClSUhlUkmApgZRj1w8?=
 =?us-ascii?Q?mPQ56Zi0879y1YKtln/TQm59I46VEInY+SzL4GJmQuy0VuYuHDr0OpGCsMiC?=
 =?us-ascii?Q?XvflYX7Sp9FvWdfJr+eKWNlNCgLowv7yehOf9MvygrevxaI0z/8UGXVEeHDH?=
 =?us-ascii?Q?6inAdSgADpAMeTmh5OH9RrbsyqAZEW5tabv0aPpVmRUOPv6kqWP1VqzPTTlv?=
 =?us-ascii?Q?aU+0fngZ+gCoaXPMF6tv5Ppw/LlIa/ngiQLKWcF/tH57gH9fhnV37fl4TO6a?=
 =?us-ascii?Q?TBfb5EE7obOia7a7vU5t0/ObQx30bfYm0nWa4Hk7/jTMUkQXf9zXlStise1J?=
 =?us-ascii?Q?nDqqZOnnBWhmo0PFPJfUNbbDn1SUC9A6xhD5ANMD09GLwmwnyX0frr0Z7DvH?=
 =?us-ascii?Q?aqKvPKZkMSBYivFprR1BY7EvLKdCUC1nEMQg3oUf8g1XGYfAdvyGZYgvK6EG?=
 =?us-ascii?Q?nnF5AkFOEvvXSYSVyqoSNlSPdvRvfzDYmezpQ5ekXXGUttHEYv8zy2l5EDfj?=
 =?us-ascii?Q?bew65i3iZgeAi2K7jSlSMciuvYH3wCqb/4e68c8Nssx1yi0CIRupzESEYqKb?=
 =?us-ascii?Q?7SB40ybzIs5cBmFPYJyIvLvbs9VLNnOWuAfCmlFGXWCDLH7qMmYtmaLnjmxZ?=
 =?us-ascii?Q?h3gEs3OE6fMJVB9esi5Q6FMskDVCoNmIoNq/IWxHsjPXyrXYCcJQb3x9+tdd?=
 =?us-ascii?Q?JRwb1IjpwsaDNqkBy+x+W5dT/1uHDRnTTZpF1f9TcOWinvdEI/Gb/MwzNQIY?=
 =?us-ascii?Q?5CB6Tsd0GJ4Bx33BfWqph3qkxwh7kznme8T9ikSb/6uKTfAKaO7BWAFFdVvT?=
 =?us-ascii?Q?s4JKG2tRWktpTINGiuQ6YFCrnSGpXG58it2y0QEKCt8hoArQgTjPwHZv7HFJ?=
 =?us-ascii?Q?EpEtmLQ0Fhr7bOZ05oSg+8+cvIo45TdjHa2k2n6VAJ0EENIzmZ1Ih77zsEgl?=
 =?us-ascii?Q?OvV/d3KntgmiH+/NonIr3HWJAqXhZkQtoFpF7TxU2QDCmhNpkRQFS9JCaDWA?=
 =?us-ascii?Q?64TCu1MRvjInN6+qY1c6KoiCGmLTcgeB8XlnkRB+XQ+i2Z7nnvd29t081Eeb?=
 =?us-ascii?Q?XJsXqoTIoRiO1UYVdx4VMszwIbY6+wqr7cYNC9UpYED9wIWTxLDzKMy8SYhV?=
 =?us-ascii?Q?v4sZfcTz0blaY9yY1Mt5GczL1e46?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0fe0bd-70c3-48d0-2a24-08d99233805c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:33:34.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6uCjLseTm43aTDoieiGSfM9FBf4OzhBLSLbWcP2QyfhGuLmVBTlmxt3DN69TR/pzM4k9Gf7Ny02mav7BSzruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2825

v7:
 - drop the patch "mptcp: add last_ack_dss_start in the msk" in v6
 - set allow_infinite_fallback to false in __mptcp_subflow_connect and
   mptcp_finish_join.

v6:
 - use allow_infinite_fallback instead of last_retrans_seq.
 - rename mptcp_is_data_contiguous to mptcp_allow_infinite_fallback.
 - rename last_fully_acked_dss_start_seq to last_ack_dss_start.

v5:
 - move last_retrans_seq from msk to mptcp_subflow_context

v4:
 - update patch 1 and patch 2

v3:
 - drop MPTCP_INFINITE_DONE flag
 - drop MAPPING_INFINITE
 - add mptcp_is_data_contiguous helper
 - add the fallback check
 - The u32 target testcase has not been completed yet.

v2:
 - add MPTCP_INFINITE_DONE flag
 - add MAPPING_INFINITE mapping status
 - add start_seq in the msk

v1:
 - add noncontiguous flag
 - add the mibs check
 - tag: export/20210904T080009

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Geliang Tang (8):
  mptcp: don't send RST for single subflow
  mptcp: add the fallback check
  mptcp: track and update contiguous data status
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add mib for infinite map sending
  selftests: mptcp: add infinite map mibs check
  DO-NOT-MERGE: mptcp: mp_fail test

 include/net/mptcp.h                           |  3 +-
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  2 +-
 net/mptcp/pm.c                                |  6 ++
 net/mptcp/protocol.c                          | 31 ++++++++++
 net/mptcp/protocol.h                          | 13 +++++
 net/mptcp/subflow.c                           | 56 ++++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++
 9 files changed, 142 insertions(+), 27 deletions(-)

--=20
2.31.1

