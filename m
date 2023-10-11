Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAF1F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C5CQYtVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkwrInVHEKgPDrWTI+WGFoZKqRdeORbevtbSTP22VPECzbdM3E/0aZCcY774LulHAYeLMeJJ/rk/jjkkVJeEGsETlWo3Z5x14kl2Rrrs4U/d0rqIq6a40pRz1S//1ni/HhW/gVN95SZ/PFy9ylIApFXZVhJNkyWpfdE3UgQjBRRVwyRN330kvAybLF/pwprfUxfC/ZkIRI6ogThiB7H44HjC9QUcqCrs1CK4E8FVsX29E1tdRksWMFoSr9jfIW0VGT9E5+godBNFHU7HaSbX4MXV92eiwgdrbiiixpzfQno72BhapqhoY6FFDpZvlNy/YXL/r1lN9YZ2IMIIageCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o1mXJkT40BxaDOTAaoqgp4KHmc/54JRtvSRZhyLXGg=;
 b=T7bOVjj92DfGcSrSAfDUJALcBrNtil4jn6w9ygan8LHM0xxExNeMPJyx/xZxDPOeiRG3O2k3MA9QePO6ycaDrzZTFvEWEZYUoiE/jvq1rHopGlbTfuzS217Y+mqpTPPeJqR5GOT6iYii7mITjnXEQnDXDlEU/nTYljvjfnENmYE3D3/sE9WhkqfzKay7xdeEdJ1KccjHPHAodhX3j3zeIGiQs/wrp4Nxv6cpMrM9N+pMGXBZSmjqQqmp8gWYaWEv0MTJ9JECW9fHMxkmFmir7e5X4anL5bGmLRa7djrjXGyRxCfNb4Sr2z+Lhqql4K4vtw35hY95XNrkAZrM+rgAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o1mXJkT40BxaDOTAaoqgp4KHmc/54JRtvSRZhyLXGg=;
 b=C5CQYtVMil1mc64C3UARi+ljOP3DMv7QMwvgSKcxw5eS1SnWveJrZfVZocBfgzn9hwyRGaRGtlbyRD7xZ9qjNBsmLPSSlosVUDkn6ptkdJ4RQSWT4S8Wc7vTwH/Wv5uMbgv1qPHvC4byyxTf9xPVL+Isbp+mAZ2lCa5UWjEH3XDKuMZ80dbAJp8/uqdcKtFQOuZjkaBR0dM8rfpCydsAqxnrZY2FHr+/ki/EBJkLnLxyYRsqedu+RO+req0flCpvdLuRH3qlwlrmzceh4IRXy6OW5JIH7Gi11GWg8GczM04ADPKKJH73wRAmbZiHO+6sHsfj3XZm8xxphyJOnmBsyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 13:33:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:33:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 0/7] userspace pm remove id 0 subflow & address
Date: Wed, 11 Oct 2023 21:34:55 +0800
Message-Id: <cover.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7fdbf4-c7a1-4cdc-5c44-08dbca5eb718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lzYcwYPaJcKfCJ35WnpWgUl8cA+OBFUBKmA3N/TOP6Oc2LJknUl9szWZQsMw50bhaCeAKkzsEM3/0KYjIsfSXa3jFLhJwydQK11TyWAXMEZXSHcPVwiDV0/fm9nx/VzkRG+T+gnO/ItLNl4A5BD55ECrVYN1/zHDc9PRmf3gL0br7MGjPU7ZLmZqy/bnVVOQXnlh4awEtAeFHI/l2h49fck+MIEZZSpnv/ktO5swnH7tbCi3O5WXwHezZxNDgIRoYGchyg6jiEMU8e5/gEa6oLXLUEuHeptNt4sLvxJbQHerhytDVjjKtuNpY4BlIe91ukqaB08sawmTnplJ+KHG50HtZfA0R5BrbVX8N+gPqbIo3qQfjWWDGsq2jNVHFYbH8FgVNYvCzWUtGeL4UYyE47/FHJbbQd0JTIkjNJKz+jqqU3iImYFOEgJMxdD6iFALj7bG6lj1Eq1WJReAFrm73rVyWJPyJuGn8Myt4CKej+ggiClPXLuxJFAs8ipj4DfZSW9kMFU7hH8EiEsvt7ljbG4qTBh1aJPzODf2DHCgFTIEH5CQ9Lyln4Kn/VqQliqV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FXxvUuRLVyY18z3vokqX2Qtb29Ve3Na0URClM4aKvKcmRoZPjBQ9NmNkk7Cy?=
 =?us-ascii?Q?jr/0K9ZI9O86jahGn1BmZx/i7Ez8F7R/oSXTKkTuB2JTQWN0AdJSUCmyh/jc?=
 =?us-ascii?Q?jgiWrMl27eHwMXniUrRBoZ8v2aaEFdfOVBYdLPcLcttDbXzn80yeCfxssgLA?=
 =?us-ascii?Q?Wk4zyCr9u5y9WIe0aj9wX+vcRmxps4Y2mzz+3Sot1LyLwFCIwyRttiBDByqy?=
 =?us-ascii?Q?OjxM1pHXIgynFz6ZZ+Vyo/BdroX8ZHYCLKTTxBUPayMrbL74qud4vnTgHon2?=
 =?us-ascii?Q?Zfe5Mdwb+ZvyEJaQagaKxkrT2HC7vptnEOHzqZEM9Qkv79nHXr83mavzluhy?=
 =?us-ascii?Q?VM7xO/ELbU8SA1bzg1W02S9aN6MqZABx2D/nRLIniQoO0ghyNMFdSOi8h3A3?=
 =?us-ascii?Q?Om9AxewWwpDKQphy6k4s0esZM/FV9qolXFBQmi/MKDGkzOga6rDqAyTF8tG0?=
 =?us-ascii?Q?ObGgecw21UNNOi+HQZZzr7OJCTGoVxQoplmTI+DfA/U4Cw2okwXc8zQ6hK6w?=
 =?us-ascii?Q?tGiojmwweq3kBBvdXcqtYP5kq8rgzvtFGf3ksCNLWjimURDjb6DOp5oJ8WUr?=
 =?us-ascii?Q?9KXAyrw+2qpzZ77lzTmHxfflIoDtGlqGUtDDIRaycJv8zTIrexB2gmAzFIXU?=
 =?us-ascii?Q?13IKzu67+aNRrdivVXVi/dCg70vcO4HUSHz3K4Mq08+9bpUoTdcPFz4qlwko?=
 =?us-ascii?Q?T41l9TRD++uaZDBsSBHuBwlHnuYjtEwu/SFhz1gBQX7JyBE7L0SkoznwRaAA?=
 =?us-ascii?Q?1TTAY/ZdRyf8/Ytnst0L5rTPkOf2g2+IcbI5oNg/kyUb4aaVH1C61dYxYcBA?=
 =?us-ascii?Q?UkgEBUjOCS6js4RR2UlOJxedXy0JVtCR1OiY/94yQh/hKvT0w/+gUUJZbrbV?=
 =?us-ascii?Q?PBi9x/FjTqtxfQIo/ukA5+NQLQ8yxZYwSbnNI+oqTg+dTpKD1WpBIf43hfrv?=
 =?us-ascii?Q?5y2pEVU/MJPNk0Xb63GoZayluRdrqItdCtPfMmAJLONGOQnbj73HAgJtuDHf?=
 =?us-ascii?Q?8451pt6s19FeOm8FZqb6C338yibTHTEfsXktXzuDKIKWIC8p4nDHH5ojVtpC?=
 =?us-ascii?Q?lvMO7BaeOlDcswS+iy4gBPMx+JkFz1GjGSGQJtuI829bqp68kSB6nichzdWP?=
 =?us-ascii?Q?M8ZdE1kLsZzfCI7x6UjTzvuX8FINRwsdRAnzHPjQwLX107Ib5Z81wIGc0cVn?=
 =?us-ascii?Q?6TdedrzM6IMGjdsps+OqESf/Mn4TbJN9I9649amnGpkgb5EoF3n1Crf5ONQH?=
 =?us-ascii?Q?DOqNM3escqAfFoKKYs/e7K+ogza/2xUhvR90u498Oa4HbCmzvYmJ/koTJ/Eg?=
 =?us-ascii?Q?Vq/8UE5FtCSsnZCRrfd8N4q6ylXsn10DAkKkStY5nUrGwJmGYw+2KZ22e6mj?=
 =?us-ascii?Q?ZfAUYz5lArSwAV9yb9KOw92mPBS6uqMk3LOlvcvt0OkUIqlGcNRfNfSBu8RC?=
 =?us-ascii?Q?ZVWngrtlsh36YOqDJCq7ROdjlDxX4UwK1T3159T900/iWWB6ubK7bA357fil?=
 =?us-ascii?Q?4G1KM4rrXLGEc6GPU8fmOuv9WLpsC5F3mDQKPqZ574VSUAd1ud5M3Tr1dKLA?=
 =?us-ascii?Q?ST1JxKGMj6YQhcEBfwgEwC8E/KBd5wzUEbqtGLU7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7fdbf4-c7a1-4cdc-5c44-08dbca5eb718
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:33:57.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWnXQrDfwUHitHj97rCljQsX5ZT98xoCqQDBspkxUTbMHJ6bOM+8GvveMg5zEIFA3qMfRq9nhWOo7v4WrO5D0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

v14:
 - reuse MPTCP_CF_FASTCLOSE flag.
 - use tcp_shutdown instead of mptcp_subflow_shutdown.

v13:
 - invoke mptcp_subflow_shutdown() in patch 1 as Paolo suggested.

v12:
 - address Matt's comments in v11.

v11:
 - avoid sending RSTs.
 - rename 'id 0 subflow' to 'inital subflow'.

Geliang Tang (5):
  mptcp: add __mptcp_subflow_disconnect helper
  selftests: mptcp: userspace pm remove initial subflow
  mptcp: userspace pm send RM_ADDR for ID 0
  mptcp: userspace pm rename remove_err to out
  selftests: mptcp: userspace pm send RM_ADDR for ID 0

Matthieu Baerts (2):
  selftests: mptcp: join: correctly check for no RST
  selftests: mptcp: join: no RST when rm subflow/addr

 net/mptcp/pm_userspace.c                      | 45 +++++++++++-
 net/mptcp/protocol.c                          | 28 ++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 68 ++++++++++++++++++-
 3 files changed, 130 insertions(+), 11 deletions(-)

-- 
2.35.3

