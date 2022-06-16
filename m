Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BE7A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 05:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI57NsnTuNoN/JhIM7xUbSMsYnwD8TvIsnmReMOK9wd1wTKIDaVU4IMzoRU8o1OttCp/2ggb8+mCoPewl5zqQzbhH50Vbd+8tjtvg97eU37vCV733Jp8G6TgnJQ9KeaeZsYvvkCmpLYlRKEEwgzC5mfCJwkxhQYrZEzEVjjBHCLa8m5zIjouD1IRluzgk0zxO1MOZIk87rohrZj5ucspZ6fbgu3nxqnBw/DVZ4DmQpmVfUN4x6tFkwOempsiQpksdVYWH719e0SmP7wHkCILxFghc+zjbSH84hCss1sLz/5M8B+SnQMOIpviyv4F8fTKY8albRXD9K+DMuvvnSEXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UneIhJ86GcxT/IK8/G0S5j75R5FCi9URVEcNBLaps2U=;
 b=hVGA1vVZc7ajXkX57wLQuX3kYyZS1iZ8u5bfpwNTozf4fcAE+ZqlP9WBg6yu/bRWEggYyPUeGjBt870jJKxM3NYoVjSFM86VSw6Y4uf9ac/D4vTV5wVaIUx4/3+/EIICww8ygm+/hJEFGZxQ87KnQkEpZQKQZcgIXG4RpivWqeyQKdNFxbtlgOzQiI1ht5ZeqKig/5vtiRkFPUQAfJ8AhHmpHsH4O3sE0dWzd5q5K3MGSHinLHAOuIcXAumPIbNpG17bOReWsHVmdSwHp5j6+45548rJGnG0L2ZroRS5CijHAJbO2bga77N336gxK1UicPCvxN7AnWkyIpm+t7/m0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UneIhJ86GcxT/IK8/G0S5j75R5FCi9URVEcNBLaps2U=;
 b=H5V6caq3Wgl/r05CjiWpG626eomryo+qYRIM2w3JzVzVfRRiyc9y3K7KeOgi3yRGUnDISQLN/NSOW/zzDF0PkDY6Xs2s4agss98I+7WWypZlBn+86b8yo2l256WtpCkacPyleY5yoh5e4NctB1cLuoiIDvd0L22whIZlt7HVjeaXkVt0OtJyfLmMQkQdACrVd9EnuPXjSvsM0KiLtGmVT3jiKDc+jTet2HZ7+xsFAxOPrctEcoDU2c2QnROtQiRQVbFmHy9Kzve0U3H028dWhMPMxLD7MnLZ3pCCZKokJJUyxg4DrrJsvUnj/qsHrwmB520nau2y7hqhuZRRMfAfVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7880.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.21; Thu, 16 Jun
 2022 05:02:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 05:02:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/5] mptcp_join userspace pm tests
Date: Thu, 16 Jun 2022 13:02:21 +0800
Message-Id: <cover.1655355422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa273d29-7aa0-4a62-cd84-08da4f556c94
X-MS-TrafficTypeDiagnostic: AS8PR04MB7880:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB78803B1F7F04DB28F9EBB12EF8AC9@AS8PR04MB7880.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SxWOP8RvjRH8Y2VNCtgkWo7p7XCjn7PzgGCvdZ+kZSya04aMhLU5ZGVsbeUw9zZ4qIQAOFDngEKQnUfZpO8kUK7Hu6VD0wMtu8D0DXTTNQkDqJvHjcGwXqevKAQ+fTZ1pvixsddQVyzNxK5d7DrAwHPjquoLgIoGKcrbUk/E9A1eN2Uf0ndR4zwiYrEgMvx8CQBpa/JxAnHADY0yAClUq/gZhlffeSsyHZRcPqRi+zkGaTmX4bG3PGeYHRZ8JUtl6CD+LFPe1uIKOXj6JR02pofr6jeguRLqcjqXluCGw26qL2fmiwq/pmxFnWcFeTVpchIhkBYXNtNQAyVTNvPTgzCeAu88IeTjXb7ihv2IOVrDnxFVNuO/6qd9cvFeTOT69wrMLXiQIFfE65zDS8BI7Cw1sK3p8FlEdr5FtgEVcGGh+FYlsXm9OcvKYUUyZZsoyGOn66ORIy3V+Z5x8UriEhjK4Z2+DuhwFL261DjN2NSlW7KbskXTmbjCiV05mN0tbKt3E1Qcf6gV2rMbfSZVIxxgTIqq/6STLTL50CIwIKgW+M7Bxr86KSaQ5vPrFpXrwrGus/P26u3ie6+k0TW6pDBQALk/bWgK8B5l5ZBJikcC/VYCxxFnEG5PC+wTrLdaUIJLxTmIQt5J8L/ceP1o14w/modtpsmq4I2P1dowU6wkwvFVepGuhPBRBhRPjvXW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(2906002)(5660300002)(8936002)(38100700002)(4744005)(508600001)(6486002)(186003)(44832011)(36756003)(66946007)(66556008)(6916009)(4326008)(6666004)(2616005)(6506007)(6512007)(316002)(66476007)(107886003)(8676002)(86362001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bN3svJWOiKm14z3VnRWuNUY0Ssi6qvo/sTofiPAsFFlfAv67isXPZ0GCxfnJ?=
 =?us-ascii?Q?+1RVkt5pMOBIX/xK+CwZSmun6+HM6MrlA3wgXYZWdPLntAhC3dD6DGOqHS9H?=
 =?us-ascii?Q?xdgZcfb+KbQB4sOTI5uyEwV8OhHX5UFWIf8W4s/lXIDjpuph5kHWvI515qQK?=
 =?us-ascii?Q?0LQjwqCRBSjsK/MtFVVldm7azdlnY7MgEAJPgmaNoukK3Kk1P396iWJxdklv?=
 =?us-ascii?Q?gjkViwOyNc+CcRLLKhO94uVSMk26WyXa9u9ramaUsNCN9SC35fJt5xV8m2FZ?=
 =?us-ascii?Q?tgjB3/X9wEgXxNWN0n0S2ADrRw2AIrlUXmrSlCI//Ehrfa8edYpLIpznmED2?=
 =?us-ascii?Q?3xskCDcwXrwwy4yH5bNBgGQylgPWhUR0vBaZj7dYsZR8f7zuwl9o/V/dYIEw?=
 =?us-ascii?Q?FztUAb+wXkTPyvO6aJj64cS61+bbT6EziLYcKS5G++o5DtnYEe1y7fdDo6Z4?=
 =?us-ascii?Q?Sdvj2XXUiK+U6iJe1LPUApEPWTtXVK93IpK/JdkQ22f+p8pBao+an2XW9nZj?=
 =?us-ascii?Q?tqHtWwn94OVs8bOr2Vf8FC84IPTSoM5KUJNStS+cYmaizNfosBjS58563PWM?=
 =?us-ascii?Q?4xoFV/nbaMLf7A3hg21EsFEe0RDNb9tb5Hgz6LckXKVJXAcg9X/v4LlrjTm7?=
 =?us-ascii?Q?VzGIK5v4pu4l2mXd4tWb9G8rW5zyYV5PgFgNj0JYqPDzOnrlv5h9eHUuKm/G?=
 =?us-ascii?Q?kavEVCy/uh2sGfggJRPrpHGmGdpAXkqG9py6mG6jveUXiRzCVIvCbHw818Qr?=
 =?us-ascii?Q?KBOH4Q94jKXKaVpzatz0T6upU6w9XG9lswEfnb+vmUAeKCJnnuj1kXmvWXqa?=
 =?us-ascii?Q?7XBQyn0Mpq9wpGw5AlGiMwKuOTzotAkc79zxBaAZGBYtvKIJZp1L/KFt6FFu?=
 =?us-ascii?Q?6IwrLTyzAHDMcvTLTZ608GPz0euamJMuGAM2CSXnoieLul1hgojdjOP0XFY4?=
 =?us-ascii?Q?Z0ST+VgpnmFBWtJLmPfXYNGTNP2dZm1rkY5hkLH9XNIUK2now6K9c4+qy5pN?=
 =?us-ascii?Q?OBuPaQtOpE9TiPYOG7ONJq7JD5PERhhH3x+CQted2WpNZIvPgdXR47tUo7Xr?=
 =?us-ascii?Q?sjEACrppXRC3nJnljwy0D3bM/TdC56sL1w2dwe6c/LVW5VRX3ahXVnBlA6Fa?=
 =?us-ascii?Q?nZq6evHUdPyFF/xs1aaXnc5g9JSsBjJgeAkQOPG10tSAryhd07QZb9fx2Y5O?=
 =?us-ascii?Q?HnQJqkQbSgI9MWINWefkqq7zt9/ipqEMcYNyjfy+iAPw9ff0HyWtNC66k25r?=
 =?us-ascii?Q?Hhts/6y5W6X5Y+RXL/8KrB+b+Sgg8CVVbBzhw9Tt9AoA3pmxMidRWocQ/U3n?=
 =?us-ascii?Q?+BtAjD/DIOlZoeg92Q8hRrx89nOzr3S53tt8lKDW7k5cbUlmra2nQbjKWqOE?=
 =?us-ascii?Q?7ohVHcMTqssZhIZH194KJN0Jv3BM5im5Jg96kW7eF5z3PX/mmDkJDkvBWCfy?=
 =?us-ascii?Q?BvvbT99J8pFNK+RdbXiQvUokFWXF6zn77pUTfX45SXDGxIqojokk8t6gR6Na?=
 =?us-ascii?Q?PfZilMMqJYKt1qd1ro3f8yJPFh1EofuT71s23ihikDQ7tA+YxNezCw6DldjS?=
 =?us-ascii?Q?5Mt/3/mPbMVJqqghoRLEiYE2OlSb/rgn0kMNC8Ppyppsk+ciz+yzBrJ70RLr?=
 =?us-ascii?Q?aYjffp0EkrW7Fxsa7rd3S5/TpqjYHKbCQJzTIEE16ATA7GT+dnfo1B5eguMa?=
 =?us-ascii?Q?QBNLgbpP3rGNEjYtl8mt9x8Z15ZoFZrHFN//2ifXF5Cb5tgJXfp/TnzaafVh?=
 =?us-ascii?Q?wuNqG2xqhhfM/63TQno9SwPPjePy3mY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa273d29-7aa0-4a62-cd84-08da4f556c94
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 05:02:34.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPiwnrsqkbSq/nR0kzYMJ5Ntv1wzdPt5uDLz/gANlHp+JxubttpqK7zNk494sE8RdmG2VJWSHWZ6WbaPAKxZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7880

This patch set adds add address, remove address, create subflow, and
destroy subflow test cases for userspace pm in mptcp_join script.

v3:
 - use MPTCP_INC_STATS instead of __MPTCP_INC_STATS.
 - drop unneeded pm_nl_set_limits.

v2:
 - add more tests in mptcp_join.sh
 - patch 4, add kill_wait helper as Matt suggested.

Geliang Tang (5):
  mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
  selftests: mptcp: userspace pm address tests
  selftests: mptcp: userspace pm subflow tests
  selftests: mptcp: avoid Terminated messages in userspace_pm
  selftests: mptcp: update pm_nl_ctl usage header

 net/mptcp/pm_userspace.c                      |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 82 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  2 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 40 +++++----
 4 files changed, 106 insertions(+), 20 deletions(-)

-- 
2.35.3

