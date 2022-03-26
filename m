Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA8322E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648311878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Bi+1gpeUkbHUQ3bVyj524hfPbgBm30/t5PFY444jMo=;
	b=MyQxCcuM9IxmvMRSDFEQ21f1b1Xx5+3yejXPwekeZLq/vyuT0ed6P//eTf7MdJpyem4nIv
	oIYiwCftcEOjS03Y4NJpecOkMd7Du94BdgzRTsDYT1phHz7NpJ8Do42EHx+CrsG4hbLKDj
	YBrs63dpZmQaYZn97qIzdI7/YmoLICw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-mT5UVGgUNmSGYuDTj30Cgw-1; Sat, 26 Mar 2022 17:24:36 +0100
X-MC-Unique: mT5UVGgUNmSGYuDTj30Cgw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrgrA/fwfMVC2RyCSWAL/H6Hy+ymsvl0EOR5DJIX+NmqUgtakXa67xsXoCQB9ke/WtNnj7zPsUVNJc2sSzCq59NPemz8oSSnbwGGUGxPDVIkxU1+FGjH7uYrHEekuah/MVBBnfDrK+/ZG+DSUvhG685doUniIxc+ZrCxx89W4vBJAy/jQZ0dPHGJOC8+0DfjUex/HziCgz7K5IKrxZsGAnkU/IsOJ2BXn7bg2rxirlBUGr1dFH1nq9cwIVOLmp2CIeVjOgZoHHYhs49uMQl1dSrhO5EOMiY5sLqCiazoZkyAS/xJEiuvc3tuwz976JS8qdzfuYIlNB2WoGjBoksh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIAlbLnpr+1L4rWXqWrZ++BP+Yyfcr+OtgaJf+zOWpo=;
 b=lFswAVftEfOYrByv1taGj/pVn75pArBQ6Lr5aXabeaF5ZQliwHFQYp2Dly9NI/wV6nST9YhxYWmWk8VEcmctFwrXAfXDYrn/YVOBssFcn/Lr0Fmtn7JQ+6puPze1RI9nGYDRMrzkvZgwIE5gteg5B/qLlSJGq/HosHU/a9Ui55u5pDfgzACf9QZfx6bSXG1/2UHzJpDhhzoh61iyVH+Q/YrLXCcDb3Wyd56VkfnHm8zCTG0bVR8f47HsEKM4fths2mKNrEcZuJsKGcwPO39QI8S+MNzCC1GHhHp4wd11vgJQDWFfWN7Q0wAlgiWJZTiGUSI8gRC3XSQrEwirPGzWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sat, 26 Mar
 2022 16:24:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 16:24:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 0/6] add skc_to_mptcp_sock
Date: Sun, 27 Mar 2022 00:24:27 +0800
Message-ID: <cover.1648311457.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8c7bdc-0bae-43b2-9bf9-08da0f451920
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3067921C8BF4E1A1C20EB509F81B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z1dKDpInqk5RsGlJrzNoE5OXXjtcLwET/5WhOsEaIbrHsqqxGfWL3E0z1Ev8ZHQCkWY66CetopWmjTC/Z5iquowny8AJ7SPabP5B6HHhOwFBJnimWF+Pi4hVFj88/fC+nbh9LDFq9PrRIwHb48MMLtqd6UG/csSd8YnWopbY9X1/9K0eP6HPAjDH3bVCL02GhOw+VVTUaqramcL31LyBZMaTiFQ46WA2Xw7CBWtGzCHpBZuTuAgxov3OJ+69bbzyGyFE1FcrBdjMhxcP+GFrGMNaTEToVfGzZ22K4UZqe1z9MP1A/yCTw3fVK5oNYIBaNEwXTF5QZQJciAZGrfpOsGI/gkl4efRtfXyxs9DqWaFxY3VPkzvcdtd9c+YKbqgT431NDcY7iyJtonsVphc5Dt8esr5TAhZV0B1mFrSyyNADr2GDPs0KbaGzMd0D+cktXplM7pMlx2EibFRKdmurwFkgj3qb9J+fpQXMC5nnO+Pen6anHDBPDRbX6RBjI5G8JoEWxfiea4ZyOc0qZl/ofxTCXMKTcN1l9/zR+sjCB13YLZ0Q9UQk/ra0jcmT0HFIXmSQEK2sHATIX/xcYiDSHCTzcRtdXLjE9/VnnczhMiSP+/GKjT32tfvx5LBbYb1Qwt3MrQ534FlbrJeVOQ0NCEIBrsqDwijQeWcOnUA78fUQg70ZJ77xLwYY9Jhx+XVbUr3ZxrX1dTwlQ9VFu+PD1QFxJhgoDz+CvB55xK4ZJTSEuIQVC0XJvrmZdo0Wu7oKyu8axenlx2ml9unKmA35+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(186003)(107886003)(6512007)(4326008)(8676002)(38100700002)(86362001)(26005)(6506007)(66556008)(8936002)(6916009)(44832011)(36756003)(508600001)(6486002)(83380400001)(966005)(2616005)(2906002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Peyckw2+fW149LwYw9zu/7snu3p7f/QU0WoOHdRo3KR132F1OPSkBnW6uEf4?=
 =?us-ascii?Q?lzuVUeNP3FpRB3HaZ3mJRs4EYkdHFmjURG8kAPk+Q32UUrwvGNl5nx6dipVf?=
 =?us-ascii?Q?aY1edsv4rH+Uo89YRqsNJ3gwmPdkiWBugpSlikOnTa6sWH/aZCPvfhHILjGZ?=
 =?us-ascii?Q?+wDGy/0HA68Ouy3DCsxlkvvLk6m8VXBeFf6KTXK0sY4qmWSXDQQOkec11gd/?=
 =?us-ascii?Q?5BM+Dbpcy94sWJ1iHGNysFf/jEK5JDszupzflFMVIb6zzEnsdIb2J5kaNLfc?=
 =?us-ascii?Q?KkjvWi1Vwk2/3+/FAizyk4gxwtb7gr/PJ4+Fi8+bG0YZVxNLFadgZgQtn/zn?=
 =?us-ascii?Q?+mgejdFmXpCprIMjLaYcjIkQ/NI/P1ni6s1EHDeDl7iYBXhUU4Gjlstgbtq9?=
 =?us-ascii?Q?BT9Avr7KL0NX9bUXvgHGiuFuCIVLxvFszPJRmqnQtxdrPzMMXTlwJtxmnXxo?=
 =?us-ascii?Q?OqW1PLJ7NqZ2fJTn0rR9+ectGFfxh9ugA9OSDcV2fGQ/ZmuibkEYJkt+2cLB?=
 =?us-ascii?Q?QlrQUtiZyMEasIOPltZKtK0H28/BjUYxS7WtQ4RZ1vyiBtt1IHzHyqQP9HwW?=
 =?us-ascii?Q?OUtRrKCr0x2VE96+J8M7X6cOryXLpacW7AMlwqul70C4ljkP4E3v423e++Km?=
 =?us-ascii?Q?sOQfRZBrQNxcm1qmzzPEXO7g/EQKa6oiWbF/bPNlnbKuIj+nm3omoNtywjcl?=
 =?us-ascii?Q?0s1TEzvMCRCDy/+0r0/Lsw6bEs5fQukAeAi8wJtmz6+ORMQC3MeUExPA8GrU?=
 =?us-ascii?Q?At/myi2BtbzQMBKesqTPaTY4lP90IAg6ogGA3uHeghY6cGw4vDbSCzfkTbXe?=
 =?us-ascii?Q?jyjSJo1Nljv0YAKEfWjjcJJ64sODVYbJ+bDVq5zxCdo4Trv3uwk8SRF9UPbH?=
 =?us-ascii?Q?qzINBHj70pFpGOjxQMcsg7a0iCZx2+KD/pI3UY+koFU609UlzzqwOlnHAB78?=
 =?us-ascii?Q?SE+I6o2NCzy8/Hz5E4/N8TO6nGn7kLt9SsR2xQBWpffg6b5DPbJerMTs8C6/?=
 =?us-ascii?Q?JvKD5hboDy2tigOfE7PwwuhHZgleyyus3nYDXBR+bR0eW1Qflk9mKLa6VyaJ?=
 =?us-ascii?Q?5953SoIli4ddXjzQ9tlHy3xOsM1455WId2yvNh40SKZ/FOd1tgs+ecvr+KRL?=
 =?us-ascii?Q?eFSrpXvYsi7zQbSy6Ewu6lwVG0g27ta4Drt7c6yg/hYEW+Y/botmO1DKnnRy?=
 =?us-ascii?Q?WFdeKbei4Xx2z/AWnxGf/FzMOtQ8rAbcueU+wiBNcEgCBOro9+poYmVlejn7?=
 =?us-ascii?Q?YfvD4Nsx0+GhQtLyd2g+iPzeYY8DbfnNHm/RJlF2fGN7x/61E2Cgi8HIQr3u?=
 =?us-ascii?Q?jQTwUjFXA6hX8ML55pO3jKQboLEIPMxzy2yplfS01iRJmSEsRWvd++rhaSjK?=
 =?us-ascii?Q?C4i5DF2MqRUlIi+K6QxKtp2vUkn4MOFvLBf2QJX/tU6MR2x0Q3biT4pw48xw?=
 =?us-ascii?Q?2pOQLbfv4hNVW2A8opICDuXrMVtG9QJTrg9l5WkzdPkhbqiPxqjt1w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8c7bdc-0bae-43b2-9bf9-08da0f451920
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 16:24:27.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5VSKT2oM1peMyrFjKEAUxEI5Luzp/2h2Rmsz3ZNniVFEcaJwmr2lMw3E/zpnkykrhoCul74gvF2N9S4ugXiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

This series addresses to Alexei comments in [1].

[1]
https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp=
.thefacebook.com/

v14:
 - merge the squash-to patch for patch 1.
 - rename progs/mptcp.c to progs/mptcp_sock.c in patch 2.
 - split the token verifying as a new patch from patch 3.
 - update the commit logs.

v13:
 patch 1:
  As Mat mentioned in the "BPF packet scheduler" series, BPF packet
scheduler depends on CONFIG_BPF_SYSCALL. In fact, the series depends on
CONFIG_BPF_SYSCALL too.
  - change "CONFIG_BPF" to "CONFIG_BPF_SYSCALL" in Makefile
  - change "ifdef CONFIG_MPTCP" in include/linux/bpf.h to:
    "#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)"
  - drop "#ifdef CONFIG_MPTCP" in net/core/filter.c
 patch 2:
  Address to Matt's comments in v12:
  - use bpf_object__find_program_by_name, bpf_object__find_map_by_name
  - use -EIO
  - drop close_client_fd label
  - add more CHECK_FAIL

v12:
 patch 1:
  - merged the squash-to patch for v11.
  - rebased to export/20220324T054815.
 patch 2:
  - fix the libbpf 0.8 build error.
 patch 4:
  - use fgets instead of fread to get null terminated string.

v11:
 - merge "check more values from mptcp_sock" series into this series.
 - patch 2:
   - rebased.
 - patch 3:
   - rebased.
   - add 'Copyright' entry as Matt suggested in v9.
 - patch 4:
   - add test__start_subtest.
   - add some 'Copyright' entries.
 - patch 5:
   - change monitor_log_path to static
   - drop bpf_trace_printk()
 - patch 6:
   - use TCP_CA_NAME_MAX instead of strlen(val.ca_name) in strncmp().
   - use 'sysctl -b net.ipv4.tcp_congestion_control' to get ca_name.

v10:
 - merge the squash-to patch.
 - update patch 3 as Matt suggested.
 - add sync() in get_msk_token() before read().
 - add a comment for get_msk_token().
 - update subjects and commit logs.

v9:
 - update progs/mptcp.c in patch 4 and 5

v8:
 - update as Matt suggested.

v7:
 - parse msk token from the output of 'ip mptcp monitor'.
 - add Nicolas and Matt's SoB tags.

v6:
 - add skc_to_mptcp_sock helper and test

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (6):
  bpf: add bpf_skc_to_mptcp_sock_proto
  Squash to "selftests: bpf: add MPTCP test base"
  selftests: bpf: test bpf_skc_to_mptcp_sock
  selftests: bpf: verify token of struct mptcp_sock
  selftests: bpf: verify ca_name of struct mptcp_sock
  selftests: bpf: verify first of struct mptcp_sock

 include/linux/bpf.h                           |   9 +
 include/linux/btf_ids.h                       |   3 +-
 include/uapi/linux/bpf.h                      |   7 +
 net/core/filter.c                             |  16 ++
 net/mptcp/Makefile                            |   4 +
 net/mptcp/bpf.c                               |  22 ++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 209 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcp.c     |  48 ----
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  76 +++++++
 12 files changed, 331 insertions(+), 84 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 delete mode 100644 tools/testing/selftests/bpf/progs/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c

--=20
2.34.1

