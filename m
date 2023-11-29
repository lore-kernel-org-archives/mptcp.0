Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2461C288
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V7qvNJPz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqhMPgMZ/3JG//eBnrq7ahZ/xFv2kj1g5tZYDCg79KIukS2MR7zUGehPUzE9z6Z3BIjBTA856tcalA2PfIm92IAjwkHKLqIljChqBBQPC+U9qhm/S0Nd9cVVjDxwYaS7WNi05NfTz3acVW9G3F4feodx50PycWVKljl0SnELUgbTCzSYp8p91A6E4cSMqMDmt/sDbCnbx/8E7mpqc4or/6vKnxUvv2vSbXx5var+ql3NFpnlVZiBVBQYEVrHfo2gLjWu/pykUT8a8bEwHqH3u/kliNgf2njdbQmTiX1e6x2B2DvLcdwnRiwLNejW08TIJ0/OqPnelG3ej+0sV/5N5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuOPg3apuhWcJvjmcIlBjY7HX3E5npWt4IjoX82hVkc=;
 b=OmOn/C2BVPaAXCilHl9buAgxMxgbHhWpT5IszlCO/1+IQ3/0sPiT/6ljRmBjTsQeUFNe9Gk0iG/haKHRayxMvUzhXzO/+J4VgsR9LvLrysxaiMmy0CRoak081PMNuV1l8Ig9xK7zObLRhYAbzccKcRfwGxudCQKOYWcLp/N72JV1Pw0wsxluCxdu1aMY4gC/oonr1qNwzayVfR6cVwzeNvoBQn6FGaZHyRpk7voKgtMNnZyr+VqkQXpFtxJoFmG6jjhxpTFjoy8OldLYj8r0x/A//sjHgqXCFWPdEnLJXMXmi5pCYwRMVz5mMGgqcNPo5b2c1YE5QS3bPuFSs4Pb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuOPg3apuhWcJvjmcIlBjY7HX3E5npWt4IjoX82hVkc=;
 b=V7qvNJPzMTfrgWfNleXSontkuDv035Q2fIc6vFWHeKPla3/q6Dq+IhKGDl00VK7/WmeFI7u9mt658wo2a/X1tQrR9pt53uLpWtwD9b2nbUmLrrVU0pA5Lc+vbZ3TSG02Pwg0jmZPAc64qz4A7v9kssvwa0Jxd654mlil1CVKWPYz9Vm42tZF/NGjDtMzEBdPONINlCWNlTKOyoQCIJf12Rfs6DbDwy7z79I4JBlhBNYKPIvrcPpg40C14sHdgFA51Gx0nv+8KwRoXc1rYuYH+hvS/fukGc6iVWnKEJPkLeG42vfQhql5EU2mMMOJCPaEGjstnQrmoXgX2wpWaMWfgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:10:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:10:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/5] add MPTCP_MIB_CURRESTAB
Date: Wed, 29 Nov 2023 19:10:47 +0800
Message-Id: <cover.1701256112.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8c80a2-aad2-4f9d-5009-08dbf0cbcbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Im5RIWbKkx3fT1G1tuNO7M8mept6+TMgtxouOPoSXRsPgos/zy/B/spGPvSOe0iB74N9L7aYRcSvPEFVcYuMR2rifTXHKnpUXIHOslNP759PwADs5rT1T/PdGM8oczSvnQ5GlshF7vOrfXaWUF4UDmIXz+A7jykLZ0+ppcIA+lwEwFyPHjd0gp4Lqy6vNpFmx24cOtVwMTkHNkNDn5NryvTS94l/m/3hEl4YdIOrCPBnofGWqW27MAVwANkv+oExtZrl+aG4ckpVHC/TvYHaxOTCg7U8faChOqSr9Kn+5GZhIVpSqC38z1Y+WTs7WZeCWuQxk0b0/UVTOFshvP9DNmAFGgPaOwcwZ/XSNxgfCLBNXlKgAlgMGIcGUdDsZxDnN13aVwXBS/xRmDaFjhos6dmYA6G0zvm5syki5h0s6Cz9xtdyLa0b3Xndy80flU1zM49EP0EFrTqZX+xtpH5e65VSG0Vwjpk5wZDvaWNzlh7sC7M6ZlkfAfc3nU7BMLgoVBidw+h4t9MygMLi/Y12/p3GTJ+dTFghDcCWGi1UKz820gzRFniVtTBa/Y+dtfCJJFcA6277pLxlov9fyxQAgRqdkUy2edDxmfbkT8hrTjhy1dRJ8Q/9GfK4DLM/dEvtdMoXdapZRWSlqnUslojNjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(107886003)(6512007)(2616005)(26005)(6506007)(6666004)(478600001)(83380400001)(2906002)(4744005)(5660300002)(41300700001)(6486002)(966005)(66946007)(44832011)(8676002)(8936002)(6916009)(66556008)(316002)(66476007)(4326008)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rn6EWoeFlW8F4LqiVmH3XfettyL/cvt4KkdXs7+UPM2WyTvIi4AaAA8CoMsp?=
 =?us-ascii?Q?SiOFES8kdjSd1J6rffNllXIqG7sbkx5lrbekzo5kud0xhbDJzhyV0YiUEuA8?=
 =?us-ascii?Q?wCPohQgLjXUYPMD8GOrJvTK5GavQzhHouzn1GJ0Vp0Gso34YgyREMp5hVmRb?=
 =?us-ascii?Q?/q9sfnr+mrmB2FP2+0+UXZBFpd3zrVsOfNAJ3OvQTm450KoxQm5eLCSLNRG0?=
 =?us-ascii?Q?v6zugNjwcH9yEoYtLs2Qrek2YuWAFj2aBO5BPuie5ExBHdvii7eXfaQMVQHz?=
 =?us-ascii?Q?WCudFSCGbhXDJ+KaobmYL6tBNofLmK4LPmeqifuXpo4NyTFyyHDJ2rbtVLZ4?=
 =?us-ascii?Q?pCQZEpKVioo/6NE12Y/dvUl6SDBvPtjxOJBZYaM0EMLY6cAEgaDduJpV2/dC?=
 =?us-ascii?Q?hjq0Nl80dySqhn48WubywKTb26lBdh6/TJnbuCYj5UOfwG1YAe25uxAs8Fsl?=
 =?us-ascii?Q?w+8qfIF2rcLK/Hqo2mqJhyBf6Q+boB/GqwPDhAaUSRLY/UxkDDbAQXdOvwPF?=
 =?us-ascii?Q?/rxYbP14hf+WSQm8EHHs+nClGhiF4IG3FpuAWGHE0qF1NKyYm74DpC2xjY35?=
 =?us-ascii?Q?DIjUs8YR3Wp9Cx7BHErmcwe2iyjiWI6IK1ndH1cqNUfPTz9hQF2FbVbv27Ka?=
 =?us-ascii?Q?mPB7+AMdY8i2xU3I1ivS8i5dg4ADK9Az3idNAkaxydXV+KtK3zEER0MzNDh/?=
 =?us-ascii?Q?lMJgCQh0aHZKotqMEloUL9u7EaBa1eybrfdO+vH9/7CmHLjcdcz+ibETA30V?=
 =?us-ascii?Q?SbSnVz+KK/lBblRIcdfhXovwe/iOuW9yTTYWT+8NJAWO6X9QMKJwa301eP3f?=
 =?us-ascii?Q?F5L9JFZjZF5HdZ7eXTRVHtF+/WD6cVbmkMhwFIOUpMorMfTiKSs6B8V7IN/t?=
 =?us-ascii?Q?v6EvrE6A0Y9Jhq/j3nndq0cm5UZi0JKHR8uTocGCsA384278OqBSoKCXlNGS?=
 =?us-ascii?Q?W1E7YY7k8qVROrxd0ObM9yikQm0/O4oxD+S1hHzUtxeIxeMXZkYfNvxbI+C4?=
 =?us-ascii?Q?PDu7BIZAzg2lejdiCeYh7eihnEOytEEhXpzeM+BjJOtNfA+PusWErPtjhD0O?=
 =?us-ascii?Q?XKseCZSPFkPIJRWApgNSFHznt7h2CFfYw3XijFYgOxOmBA86FIJ++hF1/hvo?=
 =?us-ascii?Q?k5Oc4N+Jm3Eict/xnoBqVX8xc35kGzfpF/3M7gxULAneN+SedzwHubY14zfJ?=
 =?us-ascii?Q?L1zUyafBWKrY58fsvNpArOT8hpr4tGbKhpM4TjjSIm4owCbKs9TpTYFov6Ni?=
 =?us-ascii?Q?nfpcsP/Q3KilFwsXD2usdPHe8UlbIgWZrepn7limeUUbrBWgVusRhBrWnKsA?=
 =?us-ascii?Q?pfzvWKkgBaTEmcIlqbR+qFQWTBn6eMGHfbNEFja0nKFfFGbRXYlKjBnDoqIz?=
 =?us-ascii?Q?KvcwRRx/wkcHOBjy9bRzb4WoFAE+oc/Ai6IjGgFHC2OkCLucNqV/il7dnAou?=
 =?us-ascii?Q?ey/am6oojUCuf+bNGOy+SKS1fOsyWA2HOqVm6rLzp4k1ggtUSuWo7cSQw/oX?=
 =?us-ascii?Q?yKXuFFrF7ZuZbITi19vCdeeyKhxgVLI5efulJvkC0Ct4rq3z/BmhiPoLh1sO?=
 =?us-ascii?Q?HvxAET3+EyVKcQEYEntoCoCoqex1IE7uxWU+aUW59gGTprfLG3bpDyz6pV7f?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8c80a2-aad2-4f9d-5009-08dbf0cbcbfa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:10:30.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8O/3It4PGepD4YTfrlyLCA+HvjiiMAsalgU0Jes38E6xKloyWiy/Ks2A48YYc+0cRiVBJuWyayBdkZbzJBMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

v3:
- add mptcp_set_state helper

v2:
- use ftrace_regs_get_argument instead of regs_get_kernel_argument to
  fix build warnings reported kernel test robot.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460

Geliang Tang (5):
  mptcp: add mib counter dec helper
  mptcp: add a current established counter
  mptcp: add mptcp_set_state helper
  mptcp: use mptcp_set_state
  selftests: mptcp: join: check CURRESTAB counters

 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  8 +++
 net/mptcp/pm_netlink.c                        |  3 +
 net/mptcp/protocol.c                          | 57 ++++++++++++-------
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/subflow.c                           |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++++
 7 files changed, 86 insertions(+), 20 deletions(-)

-- 
2.35.3

