Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2080.outbound.protection.outlook.com [40.107.13.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F3566F
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZvVhHb6u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGAOr9sTgJSe0NRMtfiZEQN8Blt+jz9OUN8m5EKjPb7FXlH+bADpnFMOk4QOoVD6N/QZF4D2hEfACagFxGXlZ+0AkU2ZzYzv1T7MZScw9KJXRZYo0Ccrswcg3+P/JLBMRpJJYNNMGyARVqJ8Z3nChNBAyyckb3xPxHiuJcR3oSC8OMkTWYqzGWC9iJ6JXGx5lkM0lB/+uru1LWEYRFaTfleFO7ZeFowpwCQeTCx1wXLaAjgsBYOlNB+SBLoNqU5+ahsmcmYdRMuVwNEtQsJ049TbdAW4+0ziCxqd48Hk8hQhAtAY14HlnnOeDtujE2jCQAfLWy2uFXiTDaFFKVjH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07wY/NxqgQ+lc1e/7te8ymJX7jdB3T3OutYH3ELrjY0=;
 b=UoKD8fvwQIDU917jsC7Tna8ceMQDw0Yd+AYhovz42nGE73bcOKbAO2u7ZN5944AiiKBkEgLIZ9xOwFdjOiHTp24dvseR9+zn6TpP1BwxJjdWtu52mAfDCTdAXEikDEV6sHfvsj4FKJn1WpKJ3ywetTfwYnzqOQSs3PKGy9AHhFR6aySeCtW7OVfjGv7WoUDlUbRTb1/okPeMRZGmx3I0xJclhn1h6KT8bQaOgnQ0qFIli7rB34XMSBVw5px5GmCxFssv5p6jdtJq/mLltwVMd/7GRTR7z/3pkhEB4+CVtgPRaomKoxcZefdKAZpRnQoZFt0tW5MzaBUuX+NhtEpK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07wY/NxqgQ+lc1e/7te8ymJX7jdB3T3OutYH3ELrjY0=;
 b=ZvVhHb6unIkh22gouskLYAUn+CjBlU9dSLHAJDnu7+xoAm/ydpjzCjVru71fuX6k0uYOyuWca3PWwY9BqaWYr9O2KyqPL5Epe50MQET0angQkthVjtj1dV/YjXu9HJEvAgOOLPnDD7OzezNIhPIrjyM+MAnNdc48xP0JaOlGLiQfKBipjdi1069uH4JoVMaGSwqG2E5/eFXX+IeA5FidA/X2ez1kELiK9BeYIvCenvJQM+XWp+mJWFUyISXgeDV5YVvqaAsyWaxvDB3a7HGM+B+E+ryykxFVnxO1A3biaNOz+Ri9Gr8hjuRmlsbC0hUSPtFbPqU0nc8OiLeYG4Fdbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 04:08:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 04:08:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next v2 0/4] add MPTCP_MIB_CURRESTAB
Date: Wed, 29 Nov 2023 12:08:50 +0800
Message-Id: <cover.1701230012.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eceb6f3-ff1a-496d-2954-08dbf090d904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tR15RmizFKGj2J4Z36PMXARHTQzAO3AvFxzXfYJznDHmkKtocJ/Or4Q987X85OM1zV6dPmESFuoPoF3cUJNNyMSD9d6CBPwFjVwebSrt4YpjXecfetUWKLef5CZYTESVpWO4l2iFykKyFqWrAUn7KQ1Fx4UEEGbWVq/R7xpV44Y7Zm+POJAhSXSw+6C8vN+RhMjUV3168guTgbacFJ1zWkiR+paTrG8S4PtY6XYpE4NZgzBOG8DV1yy8SWRl6ap8RlhCLD+c6JbsCmoeUV3nCw15V0Hzs2XH7e8hnlDAnKz/Dj76WFSk0uxsy2DUJqpQc000BdsUSxRZzybOeogt+ui09/kwn0dPdJk0j8Al1voZkpaQYq2KzLIWhLY0+CiMRPuCwOlpdG+REZ7cBF0N1bZh4lSczBgFy+0nhSuvC16/EaF0wXxx5pBPC+1HU++t/EllE4dTEhDvj3XIPtDQDljspBH8GhsDpxplNPnbHAf84oHvQqq49NklHrVOmAL/fbL5oupg55+uBnbGz1+RcvCziK9YUw+zgDWmMp5CQdUsRx/CPZ1CilAgaN+PrwWBkmmuCTm2zZZRzcOE5PIk8WQaWZA5mt2XcVZIUhrs8wtR8oZOrwY3uv0GOC75Jqt8e0S44/qlTmZ3bqYv3Bk+8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(6512007)(41300700001)(83380400001)(44832011)(36756003)(6916009)(316002)(66946007)(54906003)(66556008)(66476007)(966005)(6486002)(5660300002)(4326008)(8676002)(8936002)(86362001)(6666004)(38100700002)(6506007)(4744005)(2906002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CXKTNihNjeQOr9n7IAzXjbrHLYeUkXyJHahFXw0phqQeRBTL3jLWkYYF6+pz?=
 =?us-ascii?Q?YKchMXo2ZoEPM14n2ChHZVUzf3JmqjOgm6ol+Q3FbRQka+PJwb/DmuR9zLC4?=
 =?us-ascii?Q?CLyKYHO4ya2Vyq+gPuY9sFM2nQzWJqJ2fLra6YIVShGQJ8I4va7SHEvAbpP5?=
 =?us-ascii?Q?WlOAaeIVoX5o34tIVS6TfCN7J1R6pizKplGNCRRi1DNt/9k87Ok4c27Y3hv7?=
 =?us-ascii?Q?m9EZwo14umlTJ4lr90cr64YsDgKk9bnH0s+sQh2fLsAnrS/XQK8CbseRaNzP?=
 =?us-ascii?Q?InXrgaECtgQN/tp3A3/XaJECKsnb1eDCEjHe0qWsMzj7rjNMLvhbORwCnFsW?=
 =?us-ascii?Q?CcGa6TelFzeXqf+U585KgPxEyGfS7sKVEdhfhrNACYRQ/IcPtidLeiIBZR1g?=
 =?us-ascii?Q?csOt3CDAGuRcH6bXs2BvjxCKZcxv4kQ3tzgFzFrMuWXafcDxG22IFlFlygoA?=
 =?us-ascii?Q?Puvlp8c6B8DVTCMUy8kFh2DbkYGymRsq0v2Dv9b5GkwhUcTB5lyi1RbgQvSb?=
 =?us-ascii?Q?0pU3U1TjWlSzqxRdrjnGK4Jvj76j5ksmsCyudFKJXFa/+k/7mAwam6cgY1FY?=
 =?us-ascii?Q?63eyUlGDuNLrfmk1BTHtbtdPkPPBfu68fVidO9YlLlPHtAFb/X0Rk2qlhFq5?=
 =?us-ascii?Q?+IHmvpjFtq9Wj8N0sjDeQBIL8PwaSsAQ8cAha759ZhEFIxKbzmz0ZfbgjAyn?=
 =?us-ascii?Q?1T7hxCITZCUtLemal7ktKYnnKtToMyUFosISAsTCLMb7Vc3e3GgpSfImJ07s?=
 =?us-ascii?Q?6vtmfXJ0qHf6QteNg9hP5Eg43D91qx9cJ8dZG/qP2P604AZdTDYrxha9AWQY?=
 =?us-ascii?Q?9JgTmYZTBf5Cw2PXcZxkLY0ubQgVOn6lo9fU8jmhXxxOqamLgyn4Q5lYgsJ4?=
 =?us-ascii?Q?WLBBUIJbwttxhxzECTSpOFpCOCVUpHPqBqXMJQZc6qFMPJABpWREJFURbjrx?=
 =?us-ascii?Q?Mrn6Ej8hXNwaq4utdJ+nk9WzxuEKhfxIGZkmu3owbO2/AIDxXWe6kBkoSJuN?=
 =?us-ascii?Q?NJQU0aMkaS+rOsyF6/Y5MSAEBRyoh1f2SrtOY6iYpUNMNY4bI5Ng5M8iIaN9?=
 =?us-ascii?Q?DF00A6XHxcf7rGc6GuX9t325dgqtoe9o+/xowUQL0bOdv89Yx+ZA5L4u3Bvx?=
 =?us-ascii?Q?8GPYE6Ul9py/uVmfJv5YCrPFbJXLX3n53DaOkQFlPoGOlCTqhyOyjVZz2Dmr?=
 =?us-ascii?Q?zIL7mGJfDtijkoMnNEVappuaEi5bBq5jKFB5LWWEzmUikcW0eEGWnPeZBoyt?=
 =?us-ascii?Q?hUM52FCPaIXDfq/y/t+pmzxgtUoX2e5qOxNVpVFAXlPFXD75kFXF5xYwgd53?=
 =?us-ascii?Q?JHAstF/vxHDIvY2THHLYFpepRcibb7hnyNlIHjO3LKT1DpvB3eLz9ZpxCxWM?=
 =?us-ascii?Q?t65xr1jw2y2fkclxW32XApvPThHtp5Jtu9pkWUN2Ptc8fJ1JJfXKcKuBoFSw?=
 =?us-ascii?Q?DYGGDCCSNzx9gTgFHE7d/p2qqPtanONBZTJYNBR6Rd/30YLoPxIZ8k8gy+5+?=
 =?us-ascii?Q?W6TpgoZzxuCtV0p99UjZYqADuHXA18BnlAJ0XXoX2Q6u+D4mDZ+FknryOR1E?=
 =?us-ascii?Q?Rd6l+z9pGHMNBpRTOKoknSYJUgZAMEeknl12/qQ2GVU/HTt0jLmL5dqo6xZo?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eceb6f3-ff1a-496d-2954-08dbf090d904
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 04:08:31.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGYoO8MfyITGMRrU7pyIJACK4kDdXgHLYP62Nr0cwwKFEJrdlc2a6vrpx8X7yLRLeRCOJVddxotTgxgOCiY43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

v2:
- use ftrace_regs_get_argument instead of regs_get_kernel_argument to
  fix build warnings reported kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311290855.aEWX2Ohy-lkp@intel.com/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460

Geliang Tang (4):
  mptcp: add mib counter dec helper
  mptcp: add a current established counter
  mptcp: add a ftrace callback for tcp_set_state
  selftests: mptcp: join: check CURRESTAB counters

 net/mptcp/Makefile                            |  1 +
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  8 +++
 net/mptcp/trace.c                             | 64 +++++++++++++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++--
 5 files changed, 127 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/trace.c

-- 
2.35.3

