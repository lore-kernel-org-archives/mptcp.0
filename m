Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5718B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZIS7NoWuFTbL0nI/Vl/e+fXdCrt+O5A1M4aTxmQRyMeru/WVMRey2f0IOcwomYZCEPhpjq4ok+2584J3QgKFrY37C+oTFn99DLbZQ6e1dcz7dI2aT8nKUY9/Bj0/ahH0E/gN96+Epx89MbwWZedP80u9J+cLvJXoo1DtKyjo7mtCSvd1wO3mH2/XJpY/kb6iXAREJpy6CFn2GXOBbvRx9cswhnkuLgAOWsZ1lGYBbNwTtF9Vxsl7Syxw1M0irJcqpkQ5/pc+gCSKjxAt96NXu4+kyFVBuPGfolJtHdz3pO7piyMulWB+NqqBZ+gxAMiBgI/k0cqiXCIMdFVUPsP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X03DE5xNpS+F6b6SUz8zJ7sWlMHjM2Uqa0XkzEJZvvc=;
 b=TCHa0hv1TIpE+LeLwR14Ok4LwupUaL2lo1FlhfdWoBpVJMDWhSU3STDeJEo8RpltU7PECaoEy4E05oAX+boYegpim9xex82f5t2cQQnRO4167JBTm441q3X3QFtqCHD75lnBgBcVvMafxuVldcwjPHb1W/iP1/v+hjLy/TlS3Vhl4EufUzcuR+TTG0SzwEmSnCgagDdPEAfEba0k5N3nQx70lg0XBS9cZ0UwzmXTVpjO9U7w8ZBFKGG5KvIcHSfUfQGbom/4lFca9VVK9cvkuPgIrfe9liFMktPueB1PIVu6jbCoQ7nBZFTNX2xJAB92/gJmMVnvTOCMPIL0kMmbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X03DE5xNpS+F6b6SUz8zJ7sWlMHjM2Uqa0XkzEJZvvc=;
 b=ho6QawlKQZN4J6mMdX7oZV2cm21yDcph2XIrx0L5NVUP4vATt0hkE1NA2xWv2WxeVxAVWDzfmvyiBhn5RPZfk2Hh8H8bL2kSP2EmN2Cu5Kk4y8wTeRddfL3VOlfUehM71kMLemQalaN0wnQBkENtWeBKccvicYmRN/v6yh49IDxMUXgLGJnH168JT4bb4yE6krpo6Mc8xVvQHAX+4OjsMtoa6NV1kXjyP6Qz01ZS3C0MuiisQbaxdw9lDx2P9IM0GeOk90MXWztXv8Ndd79hL+aNzWJWiAsY9s4KFP3ICTg8Dz3sAXWYCDpvAa4nd8PfVJ9D1nmLUHASUuTQmct2hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:57:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 13:57:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/6] run sched tests in a dedicated ns
Date: Wed, 17 May 2023 21:57:08 +0800
Message-Id: <cover.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a77abb-cdbf-4520-f716-08db56dea34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qZoK3b/tzRd7AoHlgRLHNLq9JbNxBd411Gf2wLlzmvI/CmbiNVUoR3mbJtVUCwULGGo+i9rJXLvbfrcqtLLRMRXaV7cKe3QnEkvKc9X7yVX6vnEe4Io7N/ZPYeLi696Ik1d5dDL0N3drMv2RNO9CML0pWUW7KqpHpep02FH2YuXQQa22TeYX7oVFIvJkgh9lmkJcwEenOZ5Tt7oyW0ywIFqKsnMKKxaXwuH9uWA1nssz6VGVvhs6MGNenFTfPT77eRZvgireoZdkbyVMAqB5tzmar677w2g9Pp/46Tl/bKLpiqTpCjtwV+dqBGVGEyveq+XEyqEzgtjEN8HprW7lr7/4VttvMPA07F0BBC9eXCydl4U9lb3GeZQYXax7Jc8QnWTvii9oWrAWK4aaPUtJDOzUHfQZuJr1U6l0h3jGfZCrNGD9x+c5DNduM2STXH9/gsO1NwwFquJ5FUpFkdymhoQKZ8qfrNccnRy+7wi57pjA9c7QiMwfCfAVYZQp0GWts4PnPtGzWz9XpVdNAUFlJvG+uJKfZGpkEwIQfU4ff+HqSJ3ay++fCvEKjNrRxqTs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(316002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(86362001)(478600001)(8676002)(5660300002)(44832011)(6666004)(8936002)(2906002)(4744005)(38100700002)(6512007)(6506007)(2616005)(186003)(107886003)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8D9WKIppNZcxCvZhGtyWL+yF9P3OVEEe8gH52afyF4OZPzC2Oft6BVog+Ekj?=
 =?us-ascii?Q?9V5N60u/sRAsAeMFTNPMZjMLSZSbk65lUN2NRhX5f4elPTxyc6n0pNuGRrqx?=
 =?us-ascii?Q?4/cUEoMLzeGDtjalqDn3mt3uYGBkcmROIj8FwLMTVxS7hVGYKNXo2u+2qFVU?=
 =?us-ascii?Q?ZgYddnXFmJ0tEnjmoBoMqhq7EZ7RBNAG4SHk/WAtnAbOac5kNAhWY1hCj22L?=
 =?us-ascii?Q?3I8pTj+Hvq/aWXhVjqqjBDiSOepF7GBihfd2Ok1/eHcLV6EtuOxPUfQoCvKj?=
 =?us-ascii?Q?b0o/Jh7br8nqyaXR7SlASfY6WLDsDLGhVjjARWaK9qi+Y5GDnmPilTlwxEP1?=
 =?us-ascii?Q?HRH9+BGgiUC7q0Hd7gzuNYREaFpxJu+BGKrdSIeQl6guwrn6MtAIH4RPzhZF?=
 =?us-ascii?Q?ABCmBr2yL+sgJpb/Q1cwJ/z/xDdDlDvVVaeGU/4hCmffsvUTrl0btaZthhTY?=
 =?us-ascii?Q?hyaWKj8KdosHs0IdpBtV9QIgeJ8aSIO2DKJ0jN4OsBjQ6UYDjjpUO2wWmlyz?=
 =?us-ascii?Q?g4f6tGFgWqjEJpR0muG5BphLyGR3dKOcX0COmoQewPda6ABphBB7OBYAgnV/?=
 =?us-ascii?Q?bIaVXQ1SdpSJ8EX4eZ6NrVFJvATIJxdMtYd7/r7hl4rHNf7VmoDQX4TE7GU3?=
 =?us-ascii?Q?ibFICw582lUlXGD4QE3RAB/KS2aJOLo2AWS4pWNFpDrnyvNXX69F71QSoU1M?=
 =?us-ascii?Q?qP4uRviW9h5infsvuSjKMHX3qbQH36B7RNt0a7ngwFKeGKFpIxFK59P7zJI0?=
 =?us-ascii?Q?cDJDzziYRyHBQjH4OVKGONC1toloC3ssUOO3vNauv90w79Gvw/qfujCI3kbV?=
 =?us-ascii?Q?hs7nt+ZTdoSRMKk5+32NxfXjoNtWRgMx93EGsjAwhcJaTWYLBa3hrUrhrY2x?=
 =?us-ascii?Q?FiLZ5PtV7XQ0Vdn6juwwvL9L6OphYKBM9X1eAkbG5CfJNqOboYB2RDPAPcHK?=
 =?us-ascii?Q?XNY9gEMsDRoV3KAVDaqcF4fdfuNNxV8uLkQ8RnsHF6Lxmk8C3U6Gp3cofbZl?=
 =?us-ascii?Q?j+LZczJDHDU3kFScTVHEUqk/MIEvlq5CWkz0GIETQcCelbxoSKisH86QbURU?=
 =?us-ascii?Q?JlcBkQ7Qm/z8189wLpFtTpps/twfvUG9tWRYzeM/ji0SsKfL/JSQHsjdZZ3I?=
 =?us-ascii?Q?fQ+LGelp+U2WeeYCNK1R0pc3LtSeMaEPFeUPhpBG79na2GxQhcUjVEkfpxaC?=
 =?us-ascii?Q?RiCKggzUnaGR+yZ1x2sjane6MdCZOQwkjeaZAOL8N9jMvtx5fSopiAaahjpy?=
 =?us-ascii?Q?xOZ8Jio/7zrweoLVHFoWV12XQdnFA24Hhm1cjHA+0zl6xqqkcl6E5C2i0qXj?=
 =?us-ascii?Q?OY8W2ji/wdUVOuJsOFEPCePI5gXOJBLTSoidkt5epdA5RM1Oc3ACK6A9BYKa?=
 =?us-ascii?Q?HqKLKDDN5QQrQQRMKtRFQXSR6HpgYa+35gMNs6uJ9afQmJezIqTzJr5MrQCT?=
 =?us-ascii?Q?QRNg8tDXwCeOVMnSV0QQ7i4zhpcJAXs0gBGDyUhseOCLI1XjaKVgQQmrxosE?=
 =?us-ascii?Q?zSYP4NYR5wEEF7leX+g49gN7wFP48eGZwEsq29Kf48SdFo5TPq6eR6mnLZPp?=
 =?us-ascii?Q?rAZQyczffpXGpCkQ25GMf0bd20ooG6hRAMdX38Uw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a77abb-cdbf-4520-f716-08db56dea34b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:57:22.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfJZOv80r47xqQDWagkxUU5n5cJWS9cYns6It5YsxXBbSV9gIGthwCweROZZcp6L0/NQwnkFExZItTufinLx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

v3:
 - add two helpers.
 - drop sched_cleanup().
 - the first two patches should be merged between the commit
 "selftests/bpf: Add mptcp sched structs" and
 "selftests/bpf: Add bpf_first scheduler".

Geliang Tang (6):
  selftests/bpf: add two mptcp netns helpers
  selftests/bpf: use random netns name for mptcp
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 107 +++++++++++-------
 1 file changed, 66 insertions(+), 41 deletions(-)

-- 
2.35.3

