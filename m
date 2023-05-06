Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5B1105
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkeXiyKlCyNmgOdi6pQUJWnyA9fND5O7OAZkp4R2pSar288UNCZnPUc6yrckgLpK1rpaXpFLFb3p+isu/+Pgiw/9SNmY2MJujoB02LSYIN0F3JOQEPONZO6y/eZ3Z9uPU5F8z21VK2qhB7W2sKFzQluFRNt3f8h1yScjUVwMfhOKed5K4WjlRYt+5+Dxxb2Yun7Bkke6BQ4O2FvZHpJlicn9jx6XOBtqyQzNi3DBqUjfeMd2Jbb9BHQ/kwKqdNpHulFa+C4ynFkpVbuGQoEh3+GZMN85L20QrKEIDroI3KM3WuUi8/w4/ESzWJ9Z+PRc2K93fhPR6dUXJmH3TqBrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFeKgTIUxSp1hBXp/SEUss+C7IxsaLYaSl1BjkQignI=;
 b=DDkEr/+sSARO+/8yu0ZqHIsU1anxLW/SvrGbR0yx+WcUxHHTNF0gslInT2nqQtLgnCI3BfTUmFxjD0ONfkD4k5gYbumQcZfX9A8b9Jyh0XSXLf1unYL72foF1xOfQoDs4wEn0ZTAdDzrtJoSmIisOWw2S5uzmq3+jOIDO26luAJeyPNQYTnGODJCrJkJHX6243frp8Sa6A51nmCJIO2A3WEBENTh5z0uJTL63Wij87+CxFbYAVDZTD1M7p7gy4zmojlqGEJmfBQdKCMoS3d3goCM0ofQuj9JcP91zrNq7QMjRNmD9SwRYGwIGwmJEZPSAIFGk4uhAqelMifCVWWBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFeKgTIUxSp1hBXp/SEUss+C7IxsaLYaSl1BjkQignI=;
 b=qA/lnUd5SpiucuT3pJAB4r5y0FgecXj5gTuheiUEN+k3FU46zCQmUTWATSivjTVMlG35WAKEARy34w5uOisWBNIlP2iy0+EnVQIY/Pw4nvsohHrTz/6is6OMdtPGJcpTz37A0pcJtrVuvZytygkb27HAa7Or/Pn/oojJKNN8vX0JsnpCjV4TJua2S+ehs0bgeimpplydvU3hXVsP4SWJUh2mMamPLWiUq81KQ1txdfSoptx79Tq6Lo/q2MHEqxL2MU4yhr8ivYAB3yzRcq3RlSpif/HT751YPm5fyGjDeXC1/vHqLPzKmAZV0qEBMeU6PKcsjaLUQweo/c6TtfbIig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:08:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:08:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 00/12] update userspace pm mptcp_info fields
Date: Sat,  6 May 2023 13:08:48 +0800
Message-Id: <cover.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d34504-76a3-422a-b640-08db4deffe78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Li4JZAjAi6i+y+OrDuYeba38F845bhD2Z2JXgUwlaUxYQIFukCuJgtBXm5JQzKudF/k9vE8mMcsJLsaNdX4BniWxbTyHhyP24hlsDNFEjaGW/YC9tahRvxN1txJWjNpoNAvQeXxjWDSfp43Hewji97UiujCESVS497LjqLYCNXlGoaMJQFdz+93R+/Zl6jgiONiuZrlo6baYwHVcRJjkPwak6NNHqWDtl2+AOefbiwJjUSNY7XJJuCtj4B1dkVfS0ZlyM03XWx/3OWerf/LDvsRyrnlIPY4DW+wHpK2ziayk4HJbN536OAK9p/DhfIGRfK1sPLD1I5m6f0fmIdVf+lfUAkfYu88HYhiB9n95h/TYw9q63XyBwgqRzoxnAM73FbT3NyK9m4PToUlsQSkqTQe8Ix/vkYIXsja8Dh8vf5HT942WDowZV2xkJvVTKSVrbQREJuK9zZ8yIa0ATq44CGLv60XghSuajEdE/ceB+wO6fMmY3NqyRDAtgQRB5xG7IS+qBMIxOE6ZSSGIGhrT13iTlv24PR+Gvr3mfVpJ7OztYT+snMmkSHGMo18W/97Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(15650500001)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jNyz1MB87GtdrHCDv1vF3mF3HOO+k4m8r4yjI0h+H/bABZvEWaGPjecPCpIo?=
 =?us-ascii?Q?IuSRh/ANDd0BdzWXOlB/2S2i7piF9/aOVATuulH+F3urF1Ev0u9hdXrSwuIV?=
 =?us-ascii?Q?hVXQXth1D0Gk7qzjkxhdv3YaCtDldD/BYJJYFK5Jq3HUUM43HcLBpEboh09A?=
 =?us-ascii?Q?NfcyLEaWINpPfhbjeaxdiP7F4hR1rf81jOVYX2Y3DF91nKeQYNQBotKfnWx4?=
 =?us-ascii?Q?zQUS8eiyQKVvv/WVuFVnB7eeyBQVyVlPRCRQ0T9MmwJ61pdFq6erAJJmckiI?=
 =?us-ascii?Q?hmI6WbXfaVR7OVDZoo5GIrSTiShtnB5h6N8WzVn6E92o6/enZ0vJJKodPhSC?=
 =?us-ascii?Q?7jJkzf749eSqkI7ql7UWcYJxj8VqkQgEajcIg9/9AllQCguyiHvPwjJYgw+F?=
 =?us-ascii?Q?I8IQIk52goGxWufDX8fxkh6oRlFybsiilloWro8Bbr8uw80aw6QszOGD098T?=
 =?us-ascii?Q?MYNdzXuSQv7/c5YI7CWjrmj4S4WwAQ3zNWA4MB+0ChzqkG4XZjle7Qcn4Ovl?=
 =?us-ascii?Q?Y9eh6E7bqtlKb+maw+d0w68ocFCqmipcLv46WLlE0eAxZ7aBAUSd6uCYJLZJ?=
 =?us-ascii?Q?rYGaF+weYLp4E1TjNBTGFQQkjzwaHkauIEuePAgtrH1aV1oNeroGrg5NTbaW?=
 =?us-ascii?Q?/+SsGA/BcOGqjS3DlbldtoWVmxyOjtRyp4oSB8XHWp+e7FW2UFg00U/ZZlEb?=
 =?us-ascii?Q?wQdia67wPTyMJjpgBx2Wu0xeApJiBuwd47RZWOXUNDPpxt4wc5KLz3dGhDBe?=
 =?us-ascii?Q?s9CxIJ2rYw/MI9LZMANbw1YWe8RWqbwKOAxkQumMCnHRD6Ib9AvxjB3qxz3G?=
 =?us-ascii?Q?YEL50H/38GHtCDZ6PFAWw+pBLt1LhPzBh1wuCbHyNV/tc3L4QBUbQhN4Uiin?=
 =?us-ascii?Q?vQpwhi+mXCJgKl9/Gb5Q8scXmaHUWzfLkDG51fZnJrhkJKSW5qfMA41pomrn?=
 =?us-ascii?Q?DVyxg5mRcVI1lj3FhgNWVqnShwwzf8QZXwwb3lloA1vfL1UlBe+TLjzKgLrQ?=
 =?us-ascii?Q?Uv0LqcfX5PPN6e8xl3R7FHDVwqPEoF0Rpwt2rH6YBH2xL5q/1OsUX0M3r/PH?=
 =?us-ascii?Q?Tg1DPzZ2ry5vQY8FdSrFse4zuKDsBHTWxcPh5rz0iixHnbF/S3YYxpFdMSuE?=
 =?us-ascii?Q?czPPzcYrKlcGJ4x/fMPYb7sy0RiDPwNbVz6uNTpni0AAGtY7g9+BXA+EZRB/?=
 =?us-ascii?Q?uvetqTkPER+2kwaMNWLbLJVp7lgCDt039zlblbopYTqjghqerdixFRmo8D1s?=
 =?us-ascii?Q?20IIfLU3fJpYJ4hb/Gaa0dxFVb4tin6y1C5+60A/WIzHphug4K4+Fc8QfH8X?=
 =?us-ascii?Q?1Ddy0tbkKa/qBOeYpXlLyzxmDkxwFZTXW75kjyV88jf5NIdEgHVCP+pDtUIe?=
 =?us-ascii?Q?pVmcxd+SWFzuZ0YPDjbhUOOrGxUx/D95Dz1FPO+wjq1yOAOqBLH5yw4AnrMs?=
 =?us-ascii?Q?+nEmhbEBMBGjJXuI+ye0IAmsQe+DPrQD1BHFPB4byTkVYepQAP5PTNWNgSwv?=
 =?us-ascii?Q?wzmJLMD79naSbMLmMl7B8aI+ulpCL6oTO3RBepo4fzP8kJR3NoMzVmRRl3kN?=
 =?us-ascii?Q?RXmNzh9MJUPa4Ze+nGnQpSr2axxHYi8wYPymDrVO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d34504-76a3-422a-b640-08db4deffe78
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:08:56.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1JRsTKvwyZdJmuZl3e0axzTtQSJXnrG8Q35vp4xsvoG5yIE7zYEHXhl53bSMiC9ZCTzxUT/P5BiSEGUKE8CQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

v12:
 - address Matt's commits in v11.

v11:
 - #1-#5 part 1, address Matt's comments in v10.
 - #6-#9 part 2, update pm mptcp_info
 - #10-#12 part 3, some cleanups.

v10:
 - fix userspace_pm.sh errors reported by CI.
 - fix the bug in mptcp_pm_remove_addrs in patch 1.
 - drop msk->pm.subflow == 1 in mptcp_userspace_pm_delete_local_addr in
   patch 3.
 - exchange the order of "pm_nl_ctl rem" and "pm_nl_ctl dsf" in patch 2
   and 6.
 - update the commit logs.

v9:
 - address Matt's commets in v8.

v8:
 - address Matt's comments.
 - split into two series, pt 2 will send later.

v7:
 - fix userspace_pm.sh errors reported by CI.
 - only remove addrs in mptcp_nl_cmd_remove().

v6:
 - send a RM ADDR from userspace.

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (12):
  mptcp: only send RM_ADDR in nl_cmd_remove
  selftests: mptcp: update userspace pm addr tests
  mptcp: export remove_anno_list_by_saddr
  mptcp: add addr into userspace pm list
  selftests: mptcp: update userspace pm subflow tests
  mptcp: update userspace pm infos
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflows infos
  selftests: mptcp: check add_addr infos
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: pass fastclose to sflags
  selftests: mptcp: do endpoint manipulation out of transfer

 net/mptcp/pm.c                                |  23 +-
 net/mptcp/pm_netlink.c                        |  34 +-
 net/mptcp/pm_userspace.c                      |  63 +-
 net/mptcp/protocol.h                          |   5 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 673 +++++++++++-------
 5 files changed, 522 insertions(+), 276 deletions(-)

-- 
2.35.3

