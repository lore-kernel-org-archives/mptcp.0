Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C79CA42
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="r1aZKPP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxbPFrB4MANG+z2lLWmjR0X0q+ZzXfz3Cmfs7yevyDjBzkg0h/zteqgA5RUJgIyynqCRq4OMWjRSHoyhZL4dhNtDJWHg1o6k2wQUzCnJ9aHIBfK3X87I4bUGlzt6Uttam4BX+Ppejy/61L+a3K55ia9fqMDqg4kMrA6uAjlE+zJOsSdGUs91io+S8Bm3xwD1OgGiJMv3VAl13Kt9tIP7h+OsHVXF0Szm+s4gwAn4ep3QIR6va+smfpUIqPdgAsEVKByOI00Km6A+fqPoXtpw3kK9UCuQfqRr2z2LO289pbSW5IDnTsdbtLmyKViS1003rrVnTWhe0u2cVlfYz0V50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=UfeMf2ODCoaxj/aJqQbwvoNv9RMaDeCi5L6O4cbILsG9w9FnqPRTGFJBnoYr5+uoOsLWtvuvMNKPwG9b2usbxK9Mtn3LT6K5vxnd9+PSz+2hN1lHFJHl0RuaDvZ87Bz2rRy8J815zW1ExAKduK5nWrKI4gaTsfCuRUFVON09/IyZbicsBG1kwDPWDCiupc1MxP9+90Uz3pH/Z6JHIT8gXGufxX1GW3lFI3ZhT98E1mpc5E5GnzovqMnsNfSmyHbNDQA8n3tJTqkXOQnm/nOaj9JYkMgUW9wZ+3MbO9Hdizk6qUnPtSJLEYCLJp7mABjMckUiqDurUjfrBKuPcnvX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=r1aZKPP38ENBXQNVRlKWWPLUzOUHDubpnhuGTKv+jPuqtYNCo9slUZhOzwMGISmsecGbVqUEghahl0v6urNNYcgv47jXjhZFAesT7jU01xfz8Y/OUjPFG0FzQT0JgihTrLBPri7sbZhJhqME+PJGl7RqMH0bHrIK9AXRIpJ3biPeyswKtkDiZ2FLyRhyJWzBlIDjxCV5QqZ9WWfaUzdWkUd2ovvfck0gHouP1fJaZRUky5/CO/SNMlydaQHRPL+Bx/fW2Ba1KwZnejRCrLIVQFZsTCC2CzVeFuXFQWkncJ3q8kXm6N/cvGqu5XjkRKaqKC2f1M/hMC8FLl/I6ebJFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:02:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Mon, 9 Oct 2023
 06:02:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net v12 3/5] mptcp: userspace pm send RM_ADDR for ID 0
Date: Mon,  9 Oct 2023 14:02:58 +0800
Message-Id: <6d3363091007ec414d010dc6ea278aaca682a894.1696831239.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696831239.git.geliang.tang@suse.com>
References: <cover.1696831239.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8de738-1d42-4761-757b-08dbc88d4745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lpaX1/XMxeOIeHU2G1X2R8SASskX0IbmSr03ykhpuBZ9XCb7QgsDLMb7UAsMiaWYKvw2qfx2z/Ernq9cNjBkXlll3YxAYQGMgRUQaINRKaBinjIy0ROp6rrj53g4wHugFH830MAEkaxkfso7j0uAie6y2Ak83awAT051I3MqR68yGsY35rsdjHkJalh6Mt+HyXkPgS4R0Bs9VK32uI9flDbtExzfE5mgxH/QU/IretVP//RYttX7cptiOOIhT3i7SbXjdIRjAzn8fPWZrPX6yXI3y9XayN/i9vFDwXZiQYcaxCpECPI512fZhbcVrMuO/t7XQ6ZQEIUuejoqqItM/8EcHGqIVqDv2Xbxxdfn2J8i194orJv7nN3PbO9bZExj2hglr1RlQAD1KN+vuYDZdLn2z01XoCSAHCHanvvH/UgwQL6UD8QIIksT0mrm7D9WuhlQ4FqBogzYEtpzut94k6BJokLREdHRnEmpX77j9uZT0FqAiKDMhsNGOD3501zbFmbQWXqqAYA66NSR6uoOf335m77htjzU96HeCOh5XxIKmjjehIDKgg/s2WuDjcD+NHoDSnIAXE0gbQvlqOB6o6ShEjGcVMHwvaiS015Oivs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(107886003)(2616005)(6512007)(36756003)(86362001)(38100700002)(26005)(83380400001)(2906002)(44832011)(6486002)(966005)(6666004)(478600001)(41300700001)(8676002)(4326008)(316002)(8936002)(66476007)(5660300002)(6916009)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQaBXg/eCwMyfFFDCL6zKqYjcAvO4rTqfjqd/tSu1F861kEGlmrpXajYha4p?=
 =?us-ascii?Q?WZMw3qNKveI6+txoJ9Ji0CY2KNIx2n7mN+6XpMg1fBPFsUEdgwD4VeANmv48?=
 =?us-ascii?Q?LDR8tvjjAFassrvBtPrfe8ok810T5HMej+rawFd2ek89P5tNL6KXvm1U6uvl?=
 =?us-ascii?Q?bsNz593dQ6iCxc5iomUR0Bjh7txB3udPesiKdY1DQ2cEG+yl9oXiR+97NUS5?=
 =?us-ascii?Q?lEykR2TbCNjmjZEQRx+ZI65ra3mQ7L8SmdNLgQPznhgTKTZ504+COl1PwNth?=
 =?us-ascii?Q?u0+ExMfNo8bhMa2QZHPhM/XYuGZQidp4aC3B041XrWhUMlL4H9d5aoYtAhHY?=
 =?us-ascii?Q?lmYkqdPR6j0KxKTAtu7ziax7M7O6HiFREEd6lbyYosAakzY0rsbCFkSsiIc3?=
 =?us-ascii?Q?flm0BsKuvGfDaPcnqyE4r9tzo1b1zlD6I+pV+lQkHj5cr95DulT8FgjNZMAJ?=
 =?us-ascii?Q?6qPCKhGIlW4cFA46RxKKXUkOso+rt+z3GO1RHaJYTOshPhvTqLBjwNp/Lt+0?=
 =?us-ascii?Q?DsEXPjMy9bXEw7epdbDr8S+ka/PAnt7t9p2dnEhQtu2WYCLBeUSbgCvPR+DS?=
 =?us-ascii?Q?I1nLnf3khiQDvVy6qDDGmyVnuMeqxluhLNfESN9tFb/DrT4HBmcoQOz/Tayd?=
 =?us-ascii?Q?dF6GAArJCwLSOf928/sJEZ5tqUzVIw5TOt98LUxObAxUbke7N0x8D52L6lWe?=
 =?us-ascii?Q?FgnWWBeAgQC/96nVa6OAqjJ8LbM4MwTxvNaSsTpRInC36dAetxYZVYddAGJh?=
 =?us-ascii?Q?a/1+T6cAfTRLx3Go8jT5EVyfAoR+QprUM+nOiw9gWYXCowbpewNxoDAYQWn7?=
 =?us-ascii?Q?AxFT+UHPzPleyMBvMwJXkETmFlt249WtaTXeYmAFCAOduh6DS+UvTPokXeEw?=
 =?us-ascii?Q?nzR6AQEGoCPVOCNJaaR4DZw10QVKDP05NM/ggHvAYcIwStje1jZaIg/GwX/w?=
 =?us-ascii?Q?VsHRZxXF8QaInY/uerItTX9yVcFP9WDk86xTu2gr/erU6R22i+zPmOOYeAi0?=
 =?us-ascii?Q?Af8BNuwd1KndSmNFGkpPBQr36mFIebUSqBx6pX8EViz6zKP7ijQ88Yojyl3o?=
 =?us-ascii?Q?b2AXjUwH6D3lo05a9olkAfZgE9uMdRnOwygG4QPlFlzNFOXKIHgGmLPHeKx9?=
 =?us-ascii?Q?bIKZ8pX8g5fLo9x7x6znLhWMlqgip4BUJs1UNUo/Ovcc1hw13UqCgzJexORd?=
 =?us-ascii?Q?wviYF4BJDkz3pxFnQwPHeXs7VNK518IDFT0HKmcq5gifILmK1X8YdcZxTARk?=
 =?us-ascii?Q?Bd38kGjWzMdBl6H5pYcJ0EFa/uBnflUuRLlQZDbUE4b3IXjIyIMxV3WLN8bQ?=
 =?us-ascii?Q?gMkcDCiZCEBV7gIwj0CRo8f6QUcQPD7/JHl7gPC/54/R91KOzddOzIjVQ1e2?=
 =?us-ascii?Q?LnuBKNioiVOxRQ7WP0xUf39FGASDBbm5fRSRZ9hdfLaH9268gRBXu0BXWt79?=
 =?us-ascii?Q?Y6sdh7jdFB57yQ8sRg/CgMX3uSqbxtATRyv4796LEoUAHUFRZyyOQ70wlWR1?=
 =?us-ascii?Q?LvgrcyHJ7vvjc15qTDXr00AZvJZ9Ab5+dmq4a6/CzDZAAwWBlfDlEqckci6m?=
 =?us-ascii?Q?PTr/GtqOD1llIW5wH+58ETzbZ9VMB9uFeh/+2zSo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8de738-1d42-4761-757b-08dbc88d4745
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:02:11.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5+9tZ59Zn5BixpXfnT+nYXTn2biCBZi7OlYrnWDg0knaBWJ3McFaJxXctAKuJZLofPs4E8Q2uR3IBmVUlpO2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6b8083650bc1..ea50e694125d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,40 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->local_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto remove_err;
+	}
+
+	list.ids[list.nr++] = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	err = 0;
+
+remove_err:
+	release_sock(sk);
+	return err;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +279,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0) {
+		err = mptcp_userspace_remove_id_zero_address(msk, info);
+		goto remove_err;
+	}
+
 	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

