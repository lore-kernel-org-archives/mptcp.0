Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099DBE7A
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9uwlT4OOjIcVyjfl6OCvNUWdCqDvlzXUPWBi9RISQMW6gOnZn5TfdweD9L+GqQM8qMNaYuOzllZE3kWi0H5Kkmgk5N+u38FAbOOlL4RX8arm311vuIdl0fLB+nvcKVJ6kH/MDmnMyGjhLBfeeH0zVwbN4wuuPrSil7IiciiQxZwtBE7aCkTff2rWd+7tSfEJD29pAY0f5ewuAbkNoOKiu0LWrItvRdtVjtg7BUNbcKDgXO0xyZINjWnHznKeD8R/e6v3hNg2l/EMoP8lLY7y+CGVJPS4I7XSfIveI9b+xgvsE/a9aVgsTPGDQ+5qxTVFp25H6gYagbdEsvwt/7oTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh7T7oenKr78ujL5a+DaylbuAD0J5c9SzgYJSfgyRPw=;
 b=bUilmFQ9k4Sw6zmnjsoO1vtdEzgyjMlAq0GPCGa40BCRfoC3Du8ZJ12xxkukKo4ya4wUGhh4Q7R4OcOLBG3SIjxRTXiIPyDPIDOPUEoJe08I++nE9tMJOKKSU+M8g+H7ryiSjdTHOj9WrpE8QJW2MSeGOiKo83TbKz9GpfBmhz0HwRRwLD8pXIGWfIkZQZQwU36PJgsoWtZSZWHU6OfNXrClLCkFyNI2AOn7IDqRkLQDCc8XyHF00t/EON+fmjRR3o6BIyqAp26F/ZL6lWCtHEOrxsmohpJSjDY3ZhTZKEV2tkEgnEzfHd+kceGVuXhwdnG5SUUuZh5rd+IUWWf0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh7T7oenKr78ujL5a+DaylbuAD0J5c9SzgYJSfgyRPw=;
 b=Abt+fBMIcZda4FQSVWlr+j+IwtOu8wtqd9ZvdGeQ16m8pXffdMVfIPES5ll6DqCi+6o+OgFaGvpdPf6TjGMxOFPpiNW/okfWq0Z9sTTY+Pr4eiwZ1656Vb4V9k05pjHQba840ynzXGy8AgUORF0X7gciKi/PaXA+7r9Jjy2mOvVNGfAQppkiuivbPUnlqaIuuNKDqT06Yl74A+e9z2qA2e6m5YcAKoMGl3hTEnp30wzDUoVrX4mT/pVNwGAJlZNgPALdvq3zsiIKLEHLIUWHbIVw1+trwi1481t762ltLhVE32+nEOHFNhKLrBoXtWgDgYY5FgdvUNqnNyWmvGEVug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 08:02:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:02:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 0/5] update userspace pm mptcp_info fields part 1
Date: Wed, 24 May 2023 16:02:43 +0800
Message-Id: <cover.1684915182.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc2d331-f3c4-4459-9074-08db5c2d49ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JR7e4FIcR3EZ/Hi16WfUFWSZNMO6Ru+4d/NaW18HKpjVTrB/CIcvSMAydPdDxKWajzxeFSncxjEut/iAHAKbiJM3o4ptZxPutL4EJF0C+Ade6NlDiQmBo0fuZh3ndcj+ytJAoRnPOgIk+BWiIagyahV1ZdJVsLlBRyf2QLlnKUvi+8T7DFqVu4TTziMfl60t8oB/DyJB47Q+nP5pDbJvjSf/Rd6VQSd2IkSjZefRlo5rOUpylgfwD2PHUCIGU3Ev5aqpj55iFLVNv+HaawXdL1MgiJTe9cA41sEh4jdMdjVUpAf3njPddBCmAZ7Iy32w+R/GaSQW/XcWXLznzzj2gi4enxC/27npXMo8ak1Ani8qFgFC4pMWXVP+jHa0H1lRb+vinM80Mu3fB6nkWffVfmAGCE/dlrPUO4LUWbmOsREke6gFyzXwGtNMtf8eZJaAj455VUf9EfZ/DJ+/YV+kYSACJ/J9y5h7ZGKxGPMMTrfxr6qOHEyCxvKgYmwRxXJ6J92JrdFlarImLlLlfMdgvKfpf4Q0h0sfLo4dYkEIhGpR0TJ2mj7W8C2z1k8RK4ny
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(2906002)(15650500001)(44832011)(5660300002)(8676002)(8936002)(83380400001)(66556008)(66476007)(66946007)(41300700001)(4326008)(6916009)(36756003)(316002)(478600001)(6486002)(6666004)(26005)(2616005)(86362001)(107886003)(186003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gedDkoMRzYPrWfEvp7CGli2Pa9EuHYsEmaf1kx2QXHheXetkTPbIP0UmF0m1?=
 =?us-ascii?Q?LPKzFX/Hc4s2UP7dX4Ka993F8Cw3G3HNlMk6HArfu/XWihik75Z8k9zOyw/2?=
 =?us-ascii?Q?ZgM8thw5uycHNjTVGtfNGumqsMf0Xbx3WX435PpoWXfOVKocHIwjVvFTPcit?=
 =?us-ascii?Q?8qYbI27DxoWgKLjues+jt6bZxIqdOtPZ20RL076MFU+gB/ml2IE83rYyr+/7?=
 =?us-ascii?Q?kbq4ZmGux5UoKFcMf0cXYfiU012xspAzyBzm1yRujrCnV5pzttxzFRr9IFpd?=
 =?us-ascii?Q?i8Xw7xTblG96K6jRTfgn5iY1l/U3AiPmA4OAWEXohXrcnlwF9QnIs4xXh2BF?=
 =?us-ascii?Q?h71owZPEByDl02WSNA9kDl5H1//8MN0VkIVUbU1SZMUkYVnJS4DS7h4DsWnj?=
 =?us-ascii?Q?rrwzCNdiYwrsWOKBFguIKCznLH8CZ4IiTR+hw6gpjALMPSUShEgRAY1/lySt?=
 =?us-ascii?Q?e2x6UsaMsMxRgIYsW5sMFziubnJQolxzSb3cjvHtw5lP4a0gTJHFGllDW3Ny?=
 =?us-ascii?Q?dTFm/bUQR+ezoWNy04BFmXvm3L2MAm+kG1e4VUd1kbnlieSdc4Njjyz0uU9r?=
 =?us-ascii?Q?koOgSm/z0egPFw2d5rWdp+b0xrryZa4SKzD90pw6zjhg5aMhuBUviX1dg4+Z?=
 =?us-ascii?Q?LqqkO+gl0PHmzxjdmT+ehnT14hM3CUbXGcxsILBre5GzDKep1rYcslH5Favg?=
 =?us-ascii?Q?MyX3fQGvX/7Wv5m2d/3Q+3nbcB+HUhIZQav5H0bTLK8Z3OLsUzXqMQEUKTRr?=
 =?us-ascii?Q?KkVUJZLEriVwKjvioA0InaCPDtnQ/VUoWlZqNYVw8cya2Abvyu39/bJCK5Qj?=
 =?us-ascii?Q?7C2yu/yIKNcrGwYgYAHkyVqWweSYOW6uMD1Cqq4aA7E/34kVA/uqqNZ8LgR6?=
 =?us-ascii?Q?g4Iff2FMaGQiMdtFMwVqkdZpiGIveh1/rCtvfl1CxB+EMe58zFIwUM6hpPCu?=
 =?us-ascii?Q?7HtQv1l2oJ/Dkj1ltLqISFocB7SZoXcpN/7Hav44oJ7TMgKH8zY676E7sUi7?=
 =?us-ascii?Q?7BYtkygyb5TKkUx3WWOLyW3FV4CFiamIJbxKIC0AnS2TnLgjRRZ71dBy4Doj?=
 =?us-ascii?Q?NIEVkSDe8mMwI2wB4q+ZxfCDkJ7fgL4MY1aRG4t9UgalqBMyknTjNgiFlFHJ?=
 =?us-ascii?Q?RU+7EOEpVKeI1TByvUmZuphQRWkOXPV4x0gQIDh1O5wqyvGwTInrkRiJ3fTW?=
 =?us-ascii?Q?leNgM4Y7SQSZdEBJD8sN+dyhd7RhgCN4D4ihy/ai5DuqworMmtGXKhzQaS9u?=
 =?us-ascii?Q?ONLn8XaC/xHimhfPbZCAXB+kIiWf5CZcQN2k1wLrcYW2XQjX9NGUvDvGR4Rd?=
 =?us-ascii?Q?+Ce1rpfOSBheez55tpsWFQt5ot/395T6fefbnyPXIlvRy5nlfUF6YfYss6Sq?=
 =?us-ascii?Q?Od9gnOJZSbBx83kSSNJCnP7X78x/UYVqQUVtY1yfayKs4CgQ1qJuIcTs63IG?=
 =?us-ascii?Q?iZzAxKVr93qyOhHKcNqy5IUEH/MtrWD0MhU2Qv/65eG+mUGFILWbeawxjn9r?=
 =?us-ascii?Q?/NBQhYIhInjpPtaOxhRrUZCLomPRZ/h+jBslasAfiSz9blaCkSu2QrgYKBds?=
 =?us-ascii?Q?sxlj1HOI/ouLVWtWI6n2iDkM7wGdZtyl/lkF6lC6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc2d331-f3c4-4459-9074-08db5c2d49ad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:02:58.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/IIQVgWD1CWmL/uM3FtlU21V3iBaO3748+VJezjCtUmDKq/jH+voKObwtUjujoEI0fK94+9S0GJKeZ2gu8U3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

v15:
 - drop "mptcp: export remove_anno_list_by_saddr"
 - drop MPTCP_USER_PM_FLAG_RM_* flags
 - drop mptcp_pm_alloc_anno_list in mptcp_nl_cmd_sf_create.

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
  mptcp: add address into userspace pm list
  selftests: mptcp: update userspace pm subflow tests
  mptcp: update userspace pm infos

 net/mptcp/pm.c                                | 23 +++++++--
 net/mptcp/pm_netlink.c                        | 18 +++++++
 net/mptcp/pm_userspace.c                      | 48 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-
 5 files changed, 95 insertions(+), 6 deletions(-)

-- 
2.35.3

