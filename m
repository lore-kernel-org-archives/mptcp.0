Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA17A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xOo5XuUe3kRqJLF7NXHVtkcL3co+BTqq0d0mWFhYJgQ=;
	b=FTIfE1/814Hd0O4AVW/yJvnZ6Blbt7TzC8NysylMeOl0VKuQhCkPteCHWXtiyapEa2icCK
	1wWipL4bYHzP/pTz9Zl5YuPY7WsFGhv+n1nSPSkU/ltKnHysonbO9yN947uspHgUNCjz7L
	p5H2YBSY3WPWUt9AHSU+G4JTkmJg/9c=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-HMtZ8PmdNper3yA-R1km5A-1; Thu, 19 May 2022 10:25:20 +0200
X-MC-Unique: HMtZ8PmdNper3yA-R1km5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzqnwWzW+cjKkSpNq3sfXwYkSORjOcks+WOA4n4sEw4gqYhqgsHDhimjBUj2EOOmxz5o5McK+Ody/BzJ+acuG7D8w9mRL7fWCIKwlyLsMxZfA8lapwi8xB1j8Y9GGsXvHPOFX6JfBJEzjfZPegH7JGTLJSx2pCX9PHmNqE7D9woT/PlZx5yEO24fmy9BbybP0/eW9sc0SHIAaO5jYJZjuq0mF+TAVQ4sIYcPG62edXuoYfIPcg7+GAj1+FkX8nBfge/n1/3lgKg6B8NjEaH8QlUaA3knh5meTKIC3UaLCRhmxKI2xJ/0zzEbFe7qwU9/x3+ExWwVBMMemUFkIrZagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpKOEFEh1695SSBoqKVjiKEOHbl9OHOX6NfHgrv/a5A=;
 b=IZSTnto6eAyhZyuD1YpB+0U6KYaNxihBLatmykyMLYG0m/9QQVp3uwecnIRtGFDkZiffbRr5KM2UEFDWB2EENmShFjALQrJjo5wdMTKHte60GvvDstAk+t/uYE3RC0zrz/b/bUMlovjlwhV6qCgw5LQldUNO2icHAsFnwytk/MFCGGzWNhaxd5lOGTHoygOr2Mw3x9a22bZzfp9i7hXeCKZqB+So8rR0c15lR1/Fwam4DtYoTZQlbJMbpDcfXcGMs8gSFNZdt3n0WSXhDMBeTHuPWR1IlfygbLhpvzDrANkMPvGEz8efRjs01brZu4fauOHxoqydbwQUQnKtsv8+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 08:25:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:25:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/7] for bpf-next
Date: Thu, 19 May 2022 16:25:11 +0800
Message-ID: <cover.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c8a9921-cd9b-4326-92dc-08da39711b55
X-MS-TrafficTypeDiagnostic: PAXPR04MB8752:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8752C63DE571E26EAD46AFA7F8D09@PAXPR04MB8752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IoXjkTAcM3G/R4VBGuokZnjuibCn/kEYu1IooFL3F0Mq8AsEg3sxKbETS4Y+t1z/5xxV9mkfI5fu1z42xO+8GH7YxeRMkt3UR56nCWhH4ql+sQI73UgjK4FbZyEwxYBvl8dEVpSRo9JtigQUgzCeuDt97gZo/Tc4/Oiro8uTclVqLss7IJabRBHYjeOg2pAt+ErGuCSk3CDfm2WTrSjImqy+dXNK9pKb/nQHeJviq5t+HRMrG6xWHJyg1HJlewimBtGJBIHIMO57XJjCyoolCEVNqXHtOg9Nupos92DAnkVyFnh1Rh8vEZmLHsrQI2WNhfEIOOZ9Ip3gMfN/qqCY3LvY6+hPgKBbeHeqgKfHPCjnAvshZ0IzcuMvpkRIcPRVFwJw3K72gEAlsSJK5lyYdf1EFQlnKJd3w/NpfXhdsErsYxHfvTF6dOWvIIvqXbDVHOCv6TpqxS5SVLtGv6gAfXNhJkOcwVTWmMI6vLyQpJ0edtAG+h/53CTpzsm6f4WxqqhjsAOzEsck0R3E6v44GSiCk/mtU3QolQPqojMGtC5STboQZ1+/5YQdSf3ySUgnaI2+Id0piT3hSxff/l1K5wD0IaVJ5QfNpINvpARI+dDx60RmuY2FBufO83dVont4ouOp/j+NxFj2NJKSma8bR044e3ZsY3JTJabDeDJwb+CMy2xmkLe6CWQzTsWHkCxGotgmtNQi4XBDxinKwUb/sQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(36756003)(107886003)(186003)(38100700002)(2616005)(8676002)(66476007)(6916009)(4326008)(66946007)(66556008)(8936002)(44832011)(5660300002)(86362001)(26005)(6506007)(83380400001)(2906002)(508600001)(6486002)(6512007)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gMrbqncgciV3LiT5cMeV3aXRAAo9RuLLzool4dUcdiZyyoADyzu7xaO2J27?=
 =?us-ascii?Q?Qhq28U9inR+A7vqmJL55OuAu6iIvk8jLetzOgmhJRLYfOFSiaDRaR34GTlBz?=
 =?us-ascii?Q?yIc1503VyhJbJQZq6uLl8GcnNZ7zWn2sU1iWRN6khKgsyI/3PlVIpcoNOnpS?=
 =?us-ascii?Q?RllCUhWRGajbQsihY6LmtxfVu8HSfyvyOIrTdHTfulhhLHBLVKdvMYi23gzN?=
 =?us-ascii?Q?k/Gu77fbZvGW1ETBXQt5pTbhWPwDzcZPD3Lf9SlfsuJZE7usnfmK+wu/P6qW?=
 =?us-ascii?Q?N4n5NIws9fJdm3x7gf3zPRFlJG38J0J1CExJzQukiETxDckaNyTEMoJsphtt?=
 =?us-ascii?Q?iNzg0Eyeh3FY8HqbvJ2Gojx0He8YBAqRU/UzQK6bKF/LKuAhdmU0wafX9qgS?=
 =?us-ascii?Q?Cyu4Ns+sperbIWwyyGNFJvTedcq2YY6jQ9zHDVO2ITFCCHCIvNa79emziThI?=
 =?us-ascii?Q?yswHXyXBNgx2MR1b+1BAS6inSxR6qQImyhu5nsQ9DztOFQWrS3B5Ky5VUXT1?=
 =?us-ascii?Q?/KjOU1m86+530U1CkRvYvdlsO6pojfT0hGdhF1qIYz/rwRVaARb1zrdjCppa?=
 =?us-ascii?Q?W9i3fPAujCtPKfZqEMSKI9TwkhFejXwclc83h7oM2dfQ4wpXp/ctgUf1EogO?=
 =?us-ascii?Q?c/9sogRPT9LaFj4/EaxyIzB9BDDtNu/UpAO6FQurozUKqs2mMwRvRUVBOA4w?=
 =?us-ascii?Q?2+yFDxSqg8mSfvo8SSpZtVj6N80ia7l7LL2MWbodof9tkxlk3BESWXapc7Xq?=
 =?us-ascii?Q?W9Ovwt/wa7bo5P+QjJc+GbPHhIPyGvCJGotOklyMyUa7FpV3fF4ry1WsIPOr?=
 =?us-ascii?Q?epZ9MVOW8rCgXeb+obN/Yl3DCyqlDilOCkjdrBw96sMBdMzNppAIvYO/jxTW?=
 =?us-ascii?Q?SL5PKWl1k7k6Lh/ONVMLKBz97VEGhOm5MOumpdi1xNVkh8Lz+TyUo6Fw0a7u?=
 =?us-ascii?Q?4y5rCfo5vTJGKwhu/NSyiuj33vLFGBjaupq0xAAWsVNjw9VUl+usj9QhDkBG?=
 =?us-ascii?Q?czUuBZe4LQ89YPrp5u0H1uqK2CP9BFzJL0wkZctFlW7JBtVI0bWdivXbPXo2?=
 =?us-ascii?Q?POIehYvULpmSG8GdZjfV25J1VcF16wFu7Q2jfBnjPMwqXvk1YMCwH/LTEAnj?=
 =?us-ascii?Q?+2RbVzpt103Wcx0FQkqsvfEqxstZOFopHf2OjvKf5eU6iaUMHHR4+lqIbZp9?=
 =?us-ascii?Q?pcz/kn8MjX6xlP2JerEKTbGAEhw3ek6hwpZQMgt0d+Ry4W2o7wAAYlXRXWMs?=
 =?us-ascii?Q?0X5zqIha2PLQ2CFCfZTKwe6DIz2MXJDKP7xzU6DowqGFWycxJ0bOOSNiYv8Q?=
 =?us-ascii?Q?zvZ4tvhHJA67CcZALy+P3UeCF7Whp9lBuDmuY44jRikcrQW80TGmBuOP7EGk?=
 =?us-ascii?Q?XDDKRB/Lj6pkqvszxR08jvSYL8xcYXvwHzaoQ53gx2jqZAPguG3YAw7aEfoy?=
 =?us-ascii?Q?rVTu5SGaOvP+Yz6Iko4DJOHKaQOex+Z5gQQ/9aPQ4p1grEFgtBDCbqDhMTS/?=
 =?us-ascii?Q?+cSVtkVwFJ3O1C3FbwFtZLrJJd2ULprO+0QcC420MleoWWrBUYxkRpnM8mSS?=
 =?us-ascii?Q?TnrE9nOTbcpjYFNgznAqdlu+ch2ounvKBsRLEn6QpLA0YEyvo7vS7Q40UmLH?=
 =?us-ascii?Q?Zxc3g7lI/8MVSJEX+Eh6PCrR5ZZfgIF2n8oxspK8cjpD3o8YfXgPWVD8qpEq?=
 =?us-ascii?Q?qoD47d28A+UFGfKrWvgn80Sm5YnFu0xOStQUa5c54XYx3KNtfKoeQJVo1Rhd?=
 =?us-ascii?Q?5K0CAcPeQl+khJzZ3Io2SMZNuOJtP/c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8a9921-cd9b-4326-92dc-08da39711b55
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:25:18.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB9SZK925+5TSAUtOUCwmZq6BNBLCj1cm9OgCvpQAxoRozLjOCB2GZ8lJv9W+1lFLQC/CsVTHWc1yS42Dk6srQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752

v2:
 - The series is for bpf-next v5.
 - patch 1, keep bpf_mptcp_sock_from_subflow() in bpf.c
 - patch 3, Drop the 'msg' parameter of verify_sk
 - base-commit: df896c77f02a ("DO-NOT-MERGE: git markup: features
net-next-next"), export/20220517T155019
 - The last squash-to patch is for "BPF packet scheduler" series.

v1:
 - The first 10 patches is for bpf-next v5.
 - Rebased the "BPF packet scheduler" series on export branch.

Geliang Tang (6):
  bpf: add bpf_skc_to_mptcp_sock_proto
  selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
  selftests/bpf: test bpf_skc_to_mptcp_sock
  selftests/bpf: verify token of struct mptcp_sock
  selftests/bpf: verify ca_name of struct mptcp_sock
  selftests/bpf: verify first of struct mptcp_sock

Nicolas Rybowski (1):
  selftests/bpf: add MPTCP test base

 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |   1 +
 include/linux/btf_ids.h                       |   3 +-
 include/net/mptcp.h                           |   6 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  18 ++
 net/mptcp/Makefile                            |   2 +
 net/mptcp/bpf.c                               |  21 +++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  13 ++
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/network_helpers.c |  40 +++-
 tools/testing/selftests/bpf/network_helpers.h |   2 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 174 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  89 +++++++++
 18 files changed, 382 insertions(+), 10 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c

--=20
2.34.1

