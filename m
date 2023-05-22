Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC813AC4
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE4xahjcgBTrzLv3yEQ2Shf1t7lrDMMDmFwzriM9xa76LFZ78+k6Lr+89zO2yRryP6CkyWkIA8n5bi9YkmmBSYGMBZtLPcgs6DEa6bsVxsRsjGipG9Jit05vYYsq9vq5l6RfGQy9hB7kEdQ/CM2+FnLxbO6uEmpjV4/LLYlbb/nSGzXTltAb3134Zatue6w0GR5p8Zo8eqffRPpj9KiBKChSuNcS9thiEAQ9Fxso/61NSz0Sw3wf9WZCh2O1Sxc4wnei7+TwhT1blAGrfOQep992NVXA4+RF2mYzTOruZWEBLN0W2moVoAe+bE67usoLdkOg3LUqNv/TE/IwXirVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EW8ByqF8OMOzpFMvz3km7qnu4UIgagj3YX9sO7X9UU=;
 b=ZypegcCT0wtEZWFSI1MbLUyHImyEmQ4goRZ9gWUJGHSzrTLqKliBHmvRKD9sXNhre509Mep5vGHNxIAOniW5JuDcWqY6xtyTPP1Iv5figp0fLz8zblhNKaYtWGQ9zXEmZPAQvitk+zsz+DIbaSJZoXhovnvbI5Rt2ESODBL37Hti9h5AnMCgI9BMKzLRZWj2QNi83+nQaYONBfyvzRHoAlPICaa9Bjrlix1bdK2OkJ0L+eQap6Pr/MdtjBxjuX+yZgmqZBIU8jIQYBEqS1mfYsYfGRwm4tLP9Qk9/z7J8E4mRIN+xD/w7AJtZ7qrHSN69NR+KZZJAs0H4XfGnemYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EW8ByqF8OMOzpFMvz3km7qnu4UIgagj3YX9sO7X9UU=;
 b=d+XupdliluP9H7nAwdIB8E2DLQQJlONat4vqARJ2PFkQv6n3CHs/ikulUG4b2Kq/z9eC0sD7/g/79oKrxP3PgNjzwZTJeA39nmc/OO0Uab04a5V1guwGaLzlP55YatUfVX8xMAbo9b6TFF6k3XO8EkQAXfXw4YPTuw/VIlsyEeZ3yptZpKmYAq/eb/XHgxlPOqC0BjAzyOW4HM5wHDuxQLKsifg8PhGaPUVxvg6pphA74SWUR/mZDpzRx5+OM3fqDlWX/m9wkClrjVl8sTwuEOt+/qJkV1OdQh1VhZ3Mtb/icLUJKzL9ylMG+np2aDExyDEkxdJCvZTbyQTEiUUwFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7728.eurprd04.prod.outlook.com (2603:10a6:102:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:12:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6411.019; Mon, 22 May 2023
 13:12:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 0/5] update userspace pm mptcp_info fields part 1
Date: Mon, 22 May 2023 21:11:57 +0800
Message-Id: <cover.1684760588.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb03024-a557-47ce-0509-08db5ac62942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RftY0HzPTvOOe8AGyvKp7qaGPWcBgr2wpqm07zZExgZZey9El/JwMU/4pUZ8MNZZT+JRoymFUpXRRunyKYQbwawuZopHX9gsKjQOLpuFhcvRMeP4KKn7sgTQhZoWgnWFuQTZodcGrYWfjWlQZbptgIpcqxqr9ra2B2pGuijlc7EvVIvD2+Xd/QcBvfKjLAakxzHcE0yCZ+nSPhLlfIeB22IhRU4h/7lc1wSapCBfHulIRyJTBu3Y3bcGhpbvhLMWE2KzU4+Ai3TD9PXSsRVpgPr2RffLm7UuYu765mpuMCm0tSv7ZBjAgytuACiciGXQ+Y1jK2tPjAjXXR2DTJ8kamfgigT+TXjpdDiQmyiyvj/gC/wifV1R1p1Uf0qLXBYW1yRNyREzceCS0872xA52B7CiSb5y5yVEbQUYCjj5j5u8j89iFwN6weSmkAl7jeuaUVeDawxvo+IHGo/qJ/WrttAOCr7ux2v+tbSZjd0IVk43Pm5i7v/QTsVVXvTEvIqHvRiCzDj0LO2itfVBVyKNE8lNJ+yHvdz4cuPXOxJndWR+C1N3UAKp7y6vwODsvV7Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(2906002)(15650500001)(5660300002)(44832011)(8676002)(8936002)(41300700001)(316002)(66476007)(66556008)(66946007)(478600001)(6916009)(4326008)(36756003)(6666004)(6486002)(6506007)(6512007)(38100700002)(86362001)(107886003)(2616005)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yUTZTiZ9BDRcY7gdqfcviva7b7TiePahpU5+FV+Cyc5/OC/2LMAZzrl0zDWB?=
 =?us-ascii?Q?qTDL9TbAdNcGZ5SDRcegqnZh40QcLz/69YyZt8bVVxtUb9GFF1jCXXO1XzB0?=
 =?us-ascii?Q?PSN2zDeDMtNHEebWeocXXYQnGu2x307t0/ytTfp/HsMpbG3qTHbeEPOw6OfQ?=
 =?us-ascii?Q?P8qXJ8oVV2LOS/P4qiq8JBqGmhN2pIYzIFKFYrLqFqVU+MkYQnQqiZpLAihH?=
 =?us-ascii?Q?0xlJkBLphH9cQiQZ30Wf0RvKl9BJ51I5ooaqmfZHu/Q9teTv/ukHqSTlJVmR?=
 =?us-ascii?Q?jLSXLZ8PnnMOAfpsT+xA9IM4avN8AnE2CI+maaPrDJafG/Fe4S7gGk1y7EPt?=
 =?us-ascii?Q?pptnXAYkmTikgIspumfVg3pa3yTMcq/35KGxg0oqurVDt5W/AUVzO6fxScOh?=
 =?us-ascii?Q?KjEV9BGppStyuPbwrQuB6wQaXi/nv1INXBs4nhBP4tmhokHReDxnzI470Gbt?=
 =?us-ascii?Q?6cstSeRSt+YhiNZckTYpruX0eEnSN+g7xRnhu0daZfjr/QVH+kOLZGeACAdb?=
 =?us-ascii?Q?bYjNhZE4OUbxaP61gswUpyfMhmjZAYqr2v0nNXsEpGWq/sVCFgBa+u2AIJS0?=
 =?us-ascii?Q?2vJ+4Y9OMPQVr13Dqnm7I2zh86/xkk7KPU+Y7s7veG0CWNRNWW+lbyq3rJI8?=
 =?us-ascii?Q?c85s0oXhWQNeRjXwzEOihQvkH0zNpJVOGqOln2iBXRiNxV+DAxE467+0a3lh?=
 =?us-ascii?Q?NKPtj4FgWRps4xMbL5cmiJBr9YfA3FbshPYsuhw0IKxKHIDHO1zDz89RvuEw?=
 =?us-ascii?Q?ktLWxcLb3NF8uO9kd7cMQg9wedy06lZYQvE3BL0Ag+CZnCnpeKfmAchADM6u?=
 =?us-ascii?Q?3Pz0Hrze2X711xBi/9WPXXedashWBlxmgYy2uJQkd3EFhE4q3eTqfFmEecD6?=
 =?us-ascii?Q?J1jCN3Wmisj1cm8XdGQtJWUPsZgNL5YbdejYAtH426OfrHWPD2CIjY2obwEF?=
 =?us-ascii?Q?cbC8CKLYVrJvQfxwDUCg1WDxYKgglYPT3rgsVbHDo9w7e630wlJLMM/C2iFH?=
 =?us-ascii?Q?pNUZ0joHAC/k3XAxgECAIskPcICYj2+LaNCKA4JZG1GKQxpmV55YchfMHNFG?=
 =?us-ascii?Q?cPVkDMa8ryaLLXjq88OMmpgPdbDw74ESIgWND7HcjVObLVjTAXxQvTsTH1Th?=
 =?us-ascii?Q?/RrWL2Id7+99M//qbzefa+BmNyLZqv6dwEf4yI2EImpREQpbuQq1FczrtvZL?=
 =?us-ascii?Q?HoOq3HRb6JnBp22FJXGmH5wJZPNK6K3ZJDrtnT7T/zSnNWYbhx/0X9qPWtAE?=
 =?us-ascii?Q?9R9vRup49XRUwlLWxDJILs+dcY5/wfuDhR2rv/fQMr+MrY68nFwdyvKzTcjs?=
 =?us-ascii?Q?yoquqT0t42BaTwx/q0Ct6xfyD91aUKs3wcicBM85Fm8VFHVGlCXCGQbyYkTp?=
 =?us-ascii?Q?/M4TBq94LW5esnrPXmN4kDA9GNF8G6M30f9w8mhGsaRwoT6lPfdgzY5/KsK+?=
 =?us-ascii?Q?Vo4zhFRNML475i9nMgt+sHfdaz0NwMeX3NeOoFl9f3T7JGJaEsbVjfgY3q48?=
 =?us-ascii?Q?L9BsEuNLrR2sNX2zMcQMEVy3N+xtwxQWc9spQZ7M+pcDI9EzrhWT+urHo3RU?=
 =?us-ascii?Q?IxP++whjn7+h530PoVr4XDqJFDOzqbdqG++hvRZi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb03024-a557-47ce-0509-08db5ac62942
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:12:14.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQDHCtbP7tm/r8c8rdPlfaPz6DZGozqupd8C34W/3MO2GTbKyQbLBB/NN9+xpyNFRS9WSufjKpC7eAf1xyxuLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7728

v14:
 - drop mptcp_pm_remove_addrs helper in patch 1
 - add two flags in patch 4, the address entry'll be removed from
   userspace_pm_local_addr_list only when both flags are set, by doing this,
   it's now independent of the order of the remove_subflows command and
   the remove_addrs command.

v13:
 - move the RM_ADDR command after the destruction of the subflow in
   patch 2 and patch 5.
 - drop mptcp_pm_remove_anno_list_by_saddr in mptcp_nl_cmd_sf_destroy in
   patch 4.
 - update userspace_pm.sh too in patch 5.

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

Geliang Tang (5):
  mptcp: only send RM_ADDR in nl_cmd_remove
  selftests: mptcp: update userspace pm addr tests
  mptcp: export remove_anno_list_by_saddr
  mptcp: add address into userspace pm list
  selftests: mptcp: update userspace pm subflow tests

 include/uapi/linux/mptcp.h                    |  2 +
 net/mptcp/pm_netlink.c                        |  8 +-
 net/mptcp/pm_userspace.c                      | 77 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++-
 .../selftests/net/mptcp/userspace_pm.sh       |  3 +
 6 files changed, 94 insertions(+), 9 deletions(-)

-- 
2.35.3

