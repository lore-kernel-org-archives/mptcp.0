Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE517ED
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLSmhxGxY5DfLbl8EpB3KDvcNV5KpaDh5Isz27M3duR0INRLHeneD+3KwCRwWbOsgO4fXH36vM3mQpSw/rDiJH3e4JvG/8zYlpB1q3J+nzzxuGtc0oJq/6k/jqQkhysQtMSUs4nGutaD5nuWBoUUE/8bKS5M0mYLrmRfxRJqEw9UUWqd6xh3uP2Se3O6jKp12D4/R213gKJ/Ql72IxjVg6m6/zHDNq0wz4Nqj3yw+TfNuNn5OI7yXn20EZPc60rm0yvE+1lDSE2RDG9RLdiLcXof3/0/ZW2xcanFac5NbcOVZjuotm0kOO3JRRjPKDcj8DFNbYTWbURGeUjjwnmHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPjcY9C+/wdxh5CM0MlfF55m3NBSiHxEQfGYEfFRDYA=;
 b=QlIM04UUQpQqQOn5ejq6wnrkqs09g6m7Ob+G3snIrRkQFn0EHjIOOJypUfDO1NFwkkzn0D995q+BokqVzaUhTS6NZsTVl7SmIbBwH9IKdgGAvW0GYat9koDk8O/zsjiPoEf1AH1aKLzsdUZF7XB1sY+aMhUubZuAHdZ4lIDWycG8i/ALHdlTpv7legmnwLY63u26zx8pNm1R5wLmfMMBgWgYKUuk4MCEiwKtUFy9Vml6NH8ihFNqBYt5xbgxypa2pr7tFRAq9pUjBvXMEXrZqjfCmOAMl8vtGveFrtH5DlhyqkjEMjTG/SoZyz1BXpfEWH24n1LQnCLaj/nB96Nk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPjcY9C+/wdxh5CM0MlfF55m3NBSiHxEQfGYEfFRDYA=;
 b=jH/LABR9jxyJ96tgxQDJfM4MNWhlTiNS8GmD3Cn/J3QEXgOUOLpVAVUMsn30Hm9qiFpgN1jvo3Y5zQZVQfIp/+Q1HHwUymh1mgA1kjeEH0sf/3dBuoIgS/5yvcjr4fOC/ZxiIIgd0k2NXg+i6zch+PKfBGkDl6+Gj1iyMzW3uaVdepRX0wy7pkdceeV5XzG3fFsabrSRzzn5k0JmB8nlqSM/8snUrGpZhUs2suZX2hUNPhm0572C5+mneUNb9ZZz4RJEkJScu1DqIkzfLKcHJQhq+NlXhoMzYWf4o2ej4TIcjHfdrC1q9yl8Sz3rM+3pKKJrAmNoRRamYOmWTRhwbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 03:11:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 03:11:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 3/5] mptcp: add addr into userspace pm list
Date: Thu, 20 Apr 2023 11:11:37 +0800
Message-Id: <9c4298af79bfbf37412a96f945ff75466c45d010.1681960259.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681960259.git.geliang.tang@suse.com>
References: <cover.1681960259.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a17844-ff5d-4805-6ebc-08db414cfdd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HXE6gWE5Dxc9asYexyTGBwqpORZ7YW9XnAZi8X8b4rXNvG6ksfov50aNu6HWp3wc2A/Kd7bMAM9jlVNWm/5/sZo0qANrzFXr966qDwm5FnoZbEG8x6zkGWflcbYzvtgauKfUjp8lCVlZVciXApIni9ON5NZVMniyouIK+4bzgUVwpBDzn8joTZG8oTuz3EqO27WCS3LZT8vWnwoanHoNDDP2nXfu2sTmBsZzFaZM2WQL+a+tmAq+n/+iVLOcq3Lx88mMMfCw2iwRVXWKn2z0Yl1Nqt1BYL7HQLbunzLSMatrVltrlYYPoGC0cxfU90CwtyPYvnd026d6RwSW8f7E7FE2BI8AbeZI/60l6nZQhqLq/zj3wq+gx59ZnklV58UOpSKPafmRcwHrXr4yCOsLBtdhN6SRfXEwlmBZHaYurn9iIPawWCoRpbEk1LyPQIjRHrLoiomCTYiMVmSMzQDjaXywgJYNm10HLkBWNSSUYGXSxY8CnMBUokJp98cRpVrsvj9y+CsUiP59F5928k4vazpmhn7/7f/hHuszCnpb+I4Na77XWEPckD0Dcm5n4k9Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(4326008)(6916009)(316002)(66556008)(66476007)(66946007)(6506007)(186003)(6512007)(107886003)(26005)(38100700002)(2616005)(83380400001)(8676002)(8936002)(5660300002)(41300700001)(478600001)(6666004)(6486002)(86362001)(36756003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3WtY1OZwRYDQeXL1RbEB7R0mebsXS4OlNuBajyAu2rsYF8lmmw+siBGHaQRP?=
 =?us-ascii?Q?fLY/xEtlBb3vVrC2WhXfwxiASR95K4D13Ns3QffmHiPV0YH5+HpmtDa+Pynf?=
 =?us-ascii?Q?PCSCgayQPA34LrhZJVgcvXOyOUKzeivdNyNqe+rGrNTJcw8eLa+JLjkfkaZb?=
 =?us-ascii?Q?W0DgcYpzsY46icwmd+E/V2v8KjfmHUng8QmnJcvLKcY+rJc9t9DZIgNHCK2x?=
 =?us-ascii?Q?uCsUxDvLZp0VKoUGiTR4i91M0dJPUqCK5yhks3OTFrQVTejUULbH2CmRC2uZ?=
 =?us-ascii?Q?P0d8/MhJeqaVDa3oDokIjl6OO384n/QAtCg6HsLRwSYrbtenvc3M9f0kjBYk?=
 =?us-ascii?Q?Sy/+Ox3+lNzCTW5gnqrpWJne2f5eUsvYwsV4hdfV4/pf4oHUoS9fzpLeYviC?=
 =?us-ascii?Q?/jJIkE0G9YElSaA9WWjK9QFbNZ9vUDXPpS2yOdMQ8hkrwGNSMrZM43sYEHqR?=
 =?us-ascii?Q?eb8K1UcJ96EykDVIA0C3IqE/mrDUfd1xm65rulsBYoKRNZ4JZd4ENG8onsEy?=
 =?us-ascii?Q?XdGkv1AvYzXVQ0Hrn7BNdFctPLUYEIIG5o9/FA0awVYkmHyfEQVBMN1ngTEr?=
 =?us-ascii?Q?2KNsdvp3Zq1KddptOfUi8HZGJjXUIIK9u6Mw/vbeWuqZm9uVkPo8WOKpig3E?=
 =?us-ascii?Q?OVhfD0xlE3yOgF27nuLzcH1NW/NWqjU96mx2xiF0yb7mLyUx+B/gI1+TyFvG?=
 =?us-ascii?Q?OOh4LD+6u6ktzg8G0/gDSL1rBlm/nx1emC/CFCEXD17jutucDaPu0oQhtTaP?=
 =?us-ascii?Q?3oCk1HpDMAi8AWYvaXKVzhXcRhFtuVDnpeKwT+lqNfcwsLAXzGRW/KvP8QLr?=
 =?us-ascii?Q?qkWNyPPoLDXnMJKbuyfhvR0vffnoxHeShWhw2WQAFYoEL8Nc9ibJLjwHQufo?=
 =?us-ascii?Q?XfqvX4wDyl/N1CxdeSEngoeTmke6M64NtalQLskuit/ZVRGHdI/DiDXF2sOd?=
 =?us-ascii?Q?hZetZ2Lb2bwuAo+p1LewDNp6mLSjfZzM/Yc5RCSdVX4m3yCAyEP52PP9hOxb?=
 =?us-ascii?Q?aNnmo7EKWM87SRKaTtI09T3FD9HCZzehzMQmc3b+BUaU4AwbQOlcVdS3/6B6?=
 =?us-ascii?Q?4qGHwqjsunmy+p7rk7gpfVxHHRlU0Mc6HPVrsZcvKs7kx2WI0/1vhz7FveKp?=
 =?us-ascii?Q?IUCS/a/Kkgy2C1H6tkY84M732CdW1KSjfhlB6llFKDSAkvJnf9WTmBxCf0Oz?=
 =?us-ascii?Q?3ZP8KLLw1Zd1I6s6+67AxVL9eEdi4a4KYH0fQPFNxYmjT0IVin9mQXgJ+G6S?=
 =?us-ascii?Q?0w9XGf2cwc5OE5G2B5feOKeieFfEPRNsPzLlZhlwLhOEF8ufQ8CcvRjKNT2M?=
 =?us-ascii?Q?pVV+YvIyAVGJjFrAkhhv7JejfUuAasqjcftW/TOs9OtiMwWetCwqQ5OGPBOP?=
 =?us-ascii?Q?z8bFiglOoVQwRt+aUEFYol6P/S9cZFyRTdHE186wY/CbNe/8zpxzTl0C7IF5?=
 =?us-ascii?Q?qesXL4dq4w6KLcuTnPQ0ROmCzVdF6SaUHqlXxwKzFz55ueRPVAEJshT3jG+9?=
 =?us-ascii?Q?dquuaol4I3WMNpGeGmB3ZmgokDVe3jm/PAGrC6oyMfGYzwt6jhwzsOp/YcyI?=
 =?us-ascii?Q?m5QsDMt3dLMgIMZbYw6/ibuYI43qoYQ4b7IwGSo6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a17844-ff5d-4805-6ebc-08db414cfdd4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 03:11:53.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cie6XBOZCdv8f15OUO+zCg4Ta0Y+8zvq3nurvetTM5H8mN6Lboaf0ou8xlQYivJzOBslMRN4cti2VSAJ4PJ7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Add the address into userspace_pm_local_addr_list when the subflow is
created. And delete it in mptcp_nl_cmd_sf_destroy().

A non-zero address id is needed in this case. So don't clear the addr
id in mptcp_userspace_pm_get_local_id(), clear it in
mptcp_pm_nl_get_local_id() instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 +-
 net/mptcp/pm_userspace.c | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d85649bc27e2..bb237abb99bb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1055,8 +1055,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
+	struct mptcp_addr_info skc_local = { 0 };
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
 	int ret = -1;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6beadea8c67d..a1f8d2fab08d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -113,7 +113,6 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
 	if (new_entry.addr.port == msk_sport)
@@ -302,6 +301,12 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	err = mptcp_userspace_pm_get_local_id(msk, &addr_l);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -420,6 +425,18 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry *entry, *tmp;
+
+		spin_lock_bh(&msk->pm.lock);
+		list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+			if (mptcp_addresses_equal(&entry->addr, &addr_l, false) &&
+			    msk->pm.subflows == 1) {
+				list_del_rcu(&entry->list);
+				kfree(entry);
+				break;
+			}
+		}
+		spin_unlock_bh(&msk->pm.lock);
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
-- 
2.35.3

