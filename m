Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99835888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gAczQzzk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED8lN08zx4cm94soBUa9bC0vlXOau0L2A8X9314Z/x+fruIB3W4d9vM+LU97BUXxrZ49AnRewYCbcy96FknqiAlfv9lUxjrKBGdpVemiP6cfEb3oHoh/+HA5iMqxe36wUqshp1v8jgPKfQvW934cyoB7IPSz4L+1E+ixVduK7DdM2eUih6HznNUNNx1rgG/6d/o+h6QxveDUg1FY2OpVQSvWw3IEUbVT0cESzrm9J7kfS+TevkqXgBTNuYgmJ9QltPcUtvK9tbHB/gmb8YYCzlNWnZtQ54c9MDS4oDjMLARNE9FOl3VM+fc7f4x010aPrV0a6XucqxpynZjPiEjq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOexJeyT5bCWWizWaaXzkD21u/XqAHdmo3atvnYy6R0=;
 b=TyznxJOPzGyhUzYw+EKoo8RX/92LF4ssfK2MiD5rE/AomLxCXfoHs/w4KzlcsU9xjvAhBxmeyFNSkvbnFur2dVovhKkac1YyPzzZEBBaP0mHoxmZookLjU5RZhy0+JUIfTpWfi5b4+Xjv+40Pdhvzu6QZfiOTXsxR8dtdQNQM/ood9K7+YEr+ijfJUb5Sqo5+LUXC/ll2IlHr/3tetjk1SSbfEFG9uZ+XcuuJg0HpdTuaJjl2wygUa0bGA0ujLoK7nTGSRklAJZ1awQsQpGFN1sB9s0x3duM3+pBfgf1xhhVhTL3su2w3dt9pKhIhYIdGmTp872HgwtdkcU6tvglhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOexJeyT5bCWWizWaaXzkD21u/XqAHdmo3atvnYy6R0=;
 b=gAczQzzkmGfjXqjEWPdk2c/iA9yGxyiNcg2+OQofM9ZnE+N2RngaxypeinCaXzMS/cxcMo+LT4EW5K2BmEFToVi/YjG5sIwCjD/Ib1Lnbx/zG7hDT9fZfQi+DiteXBUJUs88YgGowcKke0/bOeGwstXIJR/quFP5f9G4r+n1Jw+t58Ei2WHl36omkThPqMRHX+ULdPttSWLxu6DHn9n1ia9nOlog2zaIBiGnTAtnSVI0fRoFsi/xXqD7zXE9z6nGGA1UavfLTNN1x/3UneWEGFxd9EeOnAjRcH+zJ7tNndvSEK6rjYucFMeGe/He8EpSVrWiaBJs2jGlqgvFv7DZHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:13:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:13:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] add MPTCP_MIB_CURRESTAB
Date: Tue, 28 Nov 2023 22:14:02 +0800
Message-Id: <cover.1701180777.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0049.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e0d9e9-caaf-47eb-9da8-08dbf01c3caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Guf9vny6V5Td2rJArE5+PxJPjDdJzP9FvtWZRwcNKat1diAe+tcJpCfMbzkNoWbG2UXVWLyGYicbTj/5jce7LS4k5deOkegoFpyqL19zHo8yFoCFcdjY95e9xD0lQybKZ4PG+rsGJ1NQ4x2I1W4x9HJ7h7Z+hfH889cBKqmNcl+gwg/JM0x+6G4cVUS7qcAe5kHwX36nhc4MghAs4LtJXhjRc7+TEkI6mO3Tmea36LfuYCVEXcdNiwSq2+lGtltRueWR5rjRT3eU6yHLSs1JsOBRn339Z9xiHUAhIWLrGRSovP8J4vj7ygzjX8bUg1D3Ki+LXfa2vdGHRgN9ftL4sgP+/rt4FtGh3Qqn5s3pUEtXd4UHzrC0ub03UT1UMj8LTSC5gCzIpuSN+aMDZ83WpmP9dKZSmoHbs4yM/N7933JkEAFF/XDDNQCbNl0SDv5Rm53yZZItEIouGeq+khxUZ54QVtWky42M4YWmUm/29Oe5kIwnOiP72pMvZL7Daoiry8rVOD4dIN5wTGKFrTnHPV0Imt6q23UdR36l/VD+CFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(966005)(6486002)(38100700002)(478600001)(41300700001)(4326008)(8936002)(36756003)(8676002)(86362001)(6916009)(66556008)(66476007)(66946007)(107886003)(26005)(316002)(2616005)(83380400001)(6506007)(6666004)(6512007)(44832011)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KSUXj57bwq5LoWnTTWrS2EpexX/rVj1CHIOMiny7bF3rsunJw4C+da9WVB/y?=
 =?us-ascii?Q?nhxY74tFS4NSbVpXJia8naJEOILzJSjZkhDfJE5Ut+l9ZhQacs+ja5oJxl+M?=
 =?us-ascii?Q?2WBgu9GcLlDQ2/amWh0QFSahuxiUORSpeayhwWBmClvzsjvKsFVcI6j4Fjci?=
 =?us-ascii?Q?lntZyj8GYeZgK3Q2hNjSb/hhAl6NP6aGpnjthRTdPb6K/HZY7aSTcNMvHCjF?=
 =?us-ascii?Q?9YrsUSzMtpoYR0AsUAzH8hjXeLAE5VcP4MQqkZIW2P9Z9t3kAqzCjxNEAUu4?=
 =?us-ascii?Q?TlrI8elH874y4jNpipyr/Go6HZ6lB+IU3xxgjCjuRIRNaFkGnXB3o98lKjc4?=
 =?us-ascii?Q?8hRcNlAaC3hNcxM3oTdYS++Uq1T2D5SjVeLAut+Ik0pjlBC5tL2G8fX+3U1i?=
 =?us-ascii?Q?BXYhcGwiGijLJCtOnEZoT8bHFEBNToA2sHtcCo1rdL9c1VwPLiHX8uyl84bc?=
 =?us-ascii?Q?ijej12BTNDDE/2JohLiMMmN0dIu182u7o1z1px1/4MGOCwrHVo3+QXYtnaZ+?=
 =?us-ascii?Q?4tx3RNrJGb2d0wqRnLUM1xyj5je99RmoEKCYW7KowknEfgWVWuswIJky0YCg?=
 =?us-ascii?Q?MpwUN7pSMbVKHZ/t1Qhp5sY15QSNloMid43Xct+a1d1YQLaaNZo4OZATktCj?=
 =?us-ascii?Q?IE43rlkUmCVh89shIiq0O3hnCpNYlyvegIa2nmSx9SgG3JoIjTq/lwnTgUaJ?=
 =?us-ascii?Q?F6JIcVjofHdhDAQoV0mPYfLad/A6wZel78SsAuySqWDIP/okbIGXU9J+p4H4?=
 =?us-ascii?Q?HdvYDQ5QE822iV2wylpbm4WCevMlOF6Uwj799etbG3KbxaLz+XsuD20uQvWB?=
 =?us-ascii?Q?5saBEi5PspAKjEBqyKqvWSPBjqolaytuBhQTei/MnuI4NvnNIAN5/S8w8FxL?=
 =?us-ascii?Q?wg+f4QuTT0i89UZk8OeosptYZ+DHtegZRUOwsZA3Yt9B3KTqXXbexTg5QBFB?=
 =?us-ascii?Q?hQoIrDj0CTIo9iLR8lH3laHILZDLfhkOzwGqipjI5inhbRuzgPNy6GaBbu3z?=
 =?us-ascii?Q?dATRm5qxT/8xKXHzBboGMne8dBig8GkbWPqAf0KKVwPGBOOjlZIB04AgEHQI?=
 =?us-ascii?Q?d6LQVj+AngwGC5nA7BCJjvAeYb72JAQFVRalvK/zdPevVQqt1xb+bNMJc5zt?=
 =?us-ascii?Q?0KJMH6IjrXzRGANmyJHNW5kEu/tJdXI2TPxCBlL6eNWDH0eza1MNiNvgA5V3?=
 =?us-ascii?Q?D/QTgeFPcgSFo6F2AhL3eYCFpH4bBAAuKiVVbfntErGaIXKTmIBBwrIPZhEv?=
 =?us-ascii?Q?kon02Ob8w4RhSg2Ms8FrmJkalo/rSeKKNv3BoKvnvNwGKn/5qdBCUJDKqZpk?=
 =?us-ascii?Q?tQ208Nb+rQU9T89Sxb/Ehlv9ZApZKgmUNpnSfGgewmwO+WlwRCu0GuYIcOd8?=
 =?us-ascii?Q?/oYm21WClAawXGTcthTaFBttLTRLhAX4i1g+d61Fz9YPXyOGyul1wgLmXhra?=
 =?us-ascii?Q?r92CpZlX1gbQtr1jl2zBKFzp7gFUGk2e4WPW2om0PSQVggynBSL7/LHxVwhM?=
 =?us-ascii?Q?+5m4SAHto8k1Gbwu5w65q7Pr+ZUIFjeBpXAR1F+AofCxD1r8Ayau6wnXH9Cp?=
 =?us-ascii?Q?WJS4jBm/yhZ3BmSoAo4bHLN1+7RKQknU9B7zr1Lz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e0d9e9-caaf-47eb-9da8-08dbf01c3caf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:13:47.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oucVQp6kTVaSKsvjbpOVHYm4HcvF5nRUE0rUQgOlw+bL08Nv77V4zrhnBY4BgD/0DqkqTLTH/voHibmWdGZenw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460

Geliang Tang (4):
  mptcp: add mib counter dec helper
  mptcp: add a current established counter
  mptcp: add ftrace callback of tcp_set_state
  selftests: mptcp: join: check CURRESTAB counters

 net/mptcp/Makefile                            |  1 +
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  8 +++
 net/mptcp/trace.c                             | 68 +++++++++++++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 ++++++++++++++--
 5 files changed, 131 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/trace.c

-- 
2.35.3

