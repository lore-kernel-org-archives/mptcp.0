Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08484808
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 04:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFuJdEm167K9XuSm4TVnxjIaEjCtM4iBZEKjTTYnFPjPEEzgebIiCNJ0Bz8v7IzJW528yvikNCK0wBSKdlPDyZqBYfOSpbswzcjd2POBaidzStK8mIL2wjVizCMRKwxt+JzWZPfEcE1HWj79/7cRTzbBFuM6BkknJDOBPGY8RkHqt/8d2EgF9mWPll5kry8YHH8KwiB4MQ/MK9qKBnORoHA6fSs2YCOM8mDlo3Mbtzx5pn193f7+5rpc9YYJd3g6tXLJi9N9WQqwbWsPRgOrLrgK55DJ6+wSz7wxLMcBMW5obVJuXCPhFx/ZaBov3uINRaHC1gU/ch2YWWBhs5dqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdw62iMEnPmwKqDSqm2GpnYwBqpJHmKoISQr/Y3Ah+w=;
 b=UH15gCZqdYs5L5WZiRrc0BswxVIA8D+ANfk7msjfvpn04QesM+aNB1T67poBBH2P+jm7eEpazG6r/cLL8wUfZS6Jwx6xd5GNs7QoZIt4If1uNIGP1HmrpJIWEmLSyp+Qaxu+GmUB6vswlM81xK7yTIbDOWIDuwAhEaYjk1KaAVpJamvU0mZC9UTIS9sAiZMy0voWMx3+Usy3IQ/Lq3uxy85lboaZ0pxgvsOeDQAyT1vZHl1+LTmdsxUoVMPPp64/H+FrE8hHWlQNMYWFaMXkXzzW+RSry/ISXKP5z3pFxMFrJfNC3lAqlTyfAaF6QbnVSR29rd/+MgfxiDII3tQPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdw62iMEnPmwKqDSqm2GpnYwBqpJHmKoISQr/Y3Ah+w=;
 b=pa1gWVlkxGkpQ2IUn2h+HAZrlL3yZ7NjLRnREpFq8lwwDVRkiU9rgKbjRkYV6Ga0oJ28oyoTWxHTW92oOnRfcUxcq/314/lWy1Z3OYMePJNH0aWoKR+XAO8l0O7v4hZ89GcRXaxguL7v2cc/Z8q4BPblIleqJkHf5JDj2VO9wYnRwzibArAY8Wy/F9loUG8T+S4kA8wC4FVcwlJ2eCsuyxPzXj6+2rIyrM7FAVLQ4RWX++6ub7VFsaSGvJggZsyxTBuwTDwHluTFallJyHOF9Up9/n4odi2fYox3mxetrfkiIYgm95drYqBEcabWxhponrUA3hSRadTF8ejzB+43ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7146.eurprd04.prod.outlook.com (2603:10a6:10:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 04:20:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Wed, 10 May 2023
 04:20:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 4/5] mptcp: add addr into userspace pm list
Date: Wed, 10 May 2023 12:20:11 +0800
Message-Id: <fe6f8aa092dea9406495cac56a00fa359626dbda.1683692137.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683692137.git.geliang.tang@suse.com>
References: <cover.1683692137.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1b74d2-8ddc-4575-39f3-08db510debf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RewBL3lckMRqArx3rAG8/ZDvdx45mWEsXb5AyTuR4NbdoU6I6tvUIOeey3GKjUYXY5/DMwxfCK7/UKl6pY8hWPkMQ5zFK0oPlSWZOM41laIMhtg72DVyo+iI4bBu1dDbOFV2E6TQtOhwzdDzkWO/IQeROdpQcAN5/QJDHRyj15xNnyG6TYiKHQS00oOV8qOG0pFVTDaRXwAshL+kLWT7OStDkKpcmU2R3XVz9Z00ZilowW4IRKRxJbAo085hGyYoYdee3x4IpC/Jm37YfINiPVzjU+brlbJQVUfEcm4Chrj0Lh4gFbcv3vukGenKeKUc3JvV8mHKDOp9bWSbod4QlPgP2KUZwzbgZWSpXmuiowiGHeSyH2R1XycFOD2MlAu4yV+6YeTtMidmOKFvSHPpK1mpFOjHgKmNnRRfV85Ts3/yDv38SJKyP4rxmKNxXlTAjrEEWKDu9fEmjcXxvWYcmzD18SztvL8A3Fwm+tX6B/2XqQWwsuiINkdGHYYqT+YymxWVVtNQ72l3V7lqySLH41YLofZF8BFobTSdGFkIzgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(66946007)(4326008)(6486002)(6666004)(66476007)(66556008)(6916009)(316002)(966005)(86362001)(36756003)(83380400001)(2616005)(6506007)(107886003)(6512007)(26005)(5660300002)(2906002)(8676002)(44832011)(41300700001)(8936002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3H4BTJ3/qNTEjXMFr6/kPZHgp63QAxIEJReAnK3IQuZOJMV2Eg0EYbz0VKP1?=
 =?us-ascii?Q?OR/mNoRNg8nnYGBpAuU92LlUG70SxR6EvHU1zkpMDH/sb9HQAq3YUIL6ua78?=
 =?us-ascii?Q?3fQhd/N+64Sy/oCX4ZMsO5bWJZ76rDmky4/tEy2CKl8Je3IdWHokJxr5F2rd?=
 =?us-ascii?Q?aVZCqhaWxyO3+9TaUP28IF0ptM/gMeh96hTiWDneu7+DxNom7fk5D/WF95SQ?=
 =?us-ascii?Q?l85KDekbjZBhgNLIZ2TkMrnFwC2D0r8lbEqQ2gVtQ78TDtC+KYV0fYO2LzTl?=
 =?us-ascii?Q?yGJYqWuW3szHYJFEXaIj4y1PDoKFSCbliTqGyfH46XMYGhjrE3vmUwzKx6tE?=
 =?us-ascii?Q?eaizL7ETeZsNRTI522kt1gYCrRQuaKEU8ZgbWakGKKbQxyGoTH7P7kUax1SD?=
 =?us-ascii?Q?PQyVQrUE1DSpvHIfyfAxbLZsWGxadblqByVcmnQn90gy7zVf5HIT0pRBe2uL?=
 =?us-ascii?Q?8WxbZdQ3p/2rNaOuVwUX5FBAuH4lZ6dkZuec+66LtTxtAQJV4Ida+1YH1mvy?=
 =?us-ascii?Q?R+ie8wajgLvN7Gjpw9byVQrPQ30lpNC+J+DSYB2+KRIF4kXegxuG4nqFnSHN?=
 =?us-ascii?Q?ZApIv5Y0/2HmgZuNvSuudZSoACtk0v12aYlqO8BoFklUl+DVv4NSb+TUwIlY?=
 =?us-ascii?Q?ollIPeui9oun58T3GfYLDbae61991D7r7gzxx+V+ObMAevLx/WIN/Yeud7ME?=
 =?us-ascii?Q?GXE/CloQkko1UMySt0bpoJq3OOVDfR1QtbxwjSEoTGsDGoz3Z/Fg5Xn6TFzw?=
 =?us-ascii?Q?pqxNTxCubb7B8xCfd4K6+03/zSNJCl6wUEqnUnmhe3Dukr+bFUyXcb58Bqw+?=
 =?us-ascii?Q?uiOf8vfOzCjf+9cGw3j9s61VlgjGnIny6VYR65PnYqZ8+h2ihot2ucVETsyw?=
 =?us-ascii?Q?zKCR8Vq7mQ1Xc8jhZL865uNI2vLZeJsVG3p1D5Ehx2raehGCtHrqezX50pdO?=
 =?us-ascii?Q?qMfyAWgmr2D9KRaUEM0spZX29pb6oO0LTTusieDASep89xdCKYKJjy3lMyGE?=
 =?us-ascii?Q?qrlLhKcIGDBIsdtjLdtF3Oq4ocAyX8t//wJrNuoC99JyFtjVV8vDYfq2guSY?=
 =?us-ascii?Q?xkfHN6fzn64XOdKK2FYkyzWc+Op6bOlC1XplLHaXnB2mYezR+Rs74oXLx73j?=
 =?us-ascii?Q?sMT9zwaFlzTeAY85s68/GUHRgUJw2tymm1roEo7YcDGrfbIvfu/Fe41kyhDv?=
 =?us-ascii?Q?a6HB6NBQLPNFmVXKyXtJ7yEVKyjG12TPKBxWv6CBE9qu1mgQZ8X/d83UAL7v?=
 =?us-ascii?Q?xKWBuEvXZyB617Z5PdMML+9z45MUq/TMI1I9We3tLc+sxX4hPPINIV8sio/f?=
 =?us-ascii?Q?ItDvAwya7fAktvmTHVG8lhWxn03oKpV3F8+yx6D3QUxdIzqNHZivghGo9Umk?=
 =?us-ascii?Q?1zPH0GumtuaoyX2Wk6CNaoKvpm3c4WXNnG8CZWYNFTVZbQ6ExqO3DW5w3Ohv?=
 =?us-ascii?Q?qoDtabM+B2OCqPdRu0QZRciCVF86EWhfS1esJJRHuk4asgEo6wgvxVePolHi?=
 =?us-ascii?Q?K4Ckuyq7oW/gvlh45Jos/zr53ID8Ihb0bcs2BSqDGhXp+W+DII6h9KumeSS+?=
 =?us-ascii?Q?rDO6yjdoB/thrH5whtHhUm/+fZD2aLdD3DoqLCkM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1b74d2-8ddc-4575-39f3-08db510debf6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:20:44.2540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BK3JkAJp+P4HBx1h4m9MhehLGnwOdMh0O0+/yYffAPK4nzJsX81BI2tH4hE8LEyzawNXHRjvCrzbmdRuA5TDlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7146

Add the address into userspace_pm_local_addr_list when the subflow is
created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
it in the new helper mptcp_userspace_pm_delete_local_addr().

Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
it when connecting fails.

By doing this, the "REMOVE" command also works with subflows that have
been created via the "SUB_CREATE" command instead of restricting to
the addresses that have been announced via the "ANNOUNCE" command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6beadea8c67d..016df47d7d6a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -79,6 +79,25 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+						struct mptcp_pm_addr_entry *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+			/* TODO: a refcount is needed because the entry can
+			 * be used multiple times (e.g. fullmesh mode).
+			 */
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
@@ -246,11 +265,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* If the subflow is closed from the other peer (not via a
+ * subflow destroy command then), we want to keep the entry
+ * not to assign the same ID to another address and to be
+ * able to send RM_ADDR after the removal of the subflow.
+ */
 int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -302,12 +327,35 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	local.addr = addr_l;
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
+		GENL_SET_ERR_MSG(info, "cannot alloc address list");
+		err = -EINVAL;
+		goto anno_list_err;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
+	if (err) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
+anno_list_err:
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
-- 
2.35.3

