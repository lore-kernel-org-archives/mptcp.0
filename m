Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB01CFAE
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JneaTs2IgIx10DpHv8LvmWsJm+OIz8qzbKqM2UfH2PJHhCPgUVSfuOUVVeUqOveAplopGK3HqveFmqi5J4ndMUHJMuhdsedQkO0viG4GmEnkx+SgUjtMjsGNQd8oD7ScjdxVnCQLcTo8JrQUJCbWcYKFQU71YozNckbXHQ8qdbyBlTT20NXTYkZtXCR3j4kRUKihtkRuPX3YmoftYs1ypKqWkSlRk1r22DqH9OiZ7E88p4SOKc2dVqmlmNESiBg6Gz3ANAcFXJXIEUPtqCn0oQXOWGMHtvtpp9C1b9chE8SJGRuWNZv+Tg4fk1O5damR4vwNnc+CIeHkJK47B2W/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PLbF2Ucj+6/LAmmvtwIOWgLC0KEJSeeLTAz3zv7U98=;
 b=Pklsf8dLQLr9oX7poBCwrQoG/kJlO+qksa0s9vNjOHykZXTjd4t8Rriirur0FuSB+6C1qPCogF27xWuU6qyFxyuVpBe9FQjw28dLgVaHhih9MLJ6C1Ks7yNc0Ho0Kxravw8Dwbp8PQJbsrhCb3qP+Nqy7fcZKkcfX6D32yVqqQgVEWwfS59SSDkFZ1BHgNJrr6gfLdrpaQ7E0i9JKC2E/UsM8FNQtzM0Nsa4klilrTsF+DCHpNK2xuGOhiiLfOnKOcMQRUrbfig3+w0r8AJE7wGSZ69HKycJVqfjBZh2nSVWZgErliEdq0YswaEeheZBwo+7F/10I9CTzB6ZW5B+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PLbF2Ucj+6/LAmmvtwIOWgLC0KEJSeeLTAz3zv7U98=;
 b=c+4b3lJJHi4bAZrbqy7kpR1qUEZe10qcmUi+LCN4G7kBoI8IS/9b1NtsQx6j9szTVvkFH2sWtfbD0Xc9ApkEyy8Xj7IJfGbIRXOp/p4XQihM/cHnE/9u/CJTT+7+VxaAwwfVOUXMB1KMkXa8lczmpkL9Prhz9sz6ngU3N3xJaNqcD6tjrVZncSEud4/rO1z3SMr9r/FZVTKv4oYyDydiKDkgDhTeLbxeC8ndAeGN7FUExRI0a3WntNrLqd/E3xz8J5/5vxDANzIfmjuooeXhBvkjX6pM1ek8dFQLeQ3cWfQQvV1QRi+ZbvWwvIF72cP0+GKF82OlUc5bIBSyIQUHWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:03:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:03:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 7/8] mptcp: userspace pm remove id 0 address
Date: Thu, 14 Sep 2023 18:03:24 +0800
Message-Id: <7fa0ed9d9651452f86f50514316feb44b9535014.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: efcea1af-17a2-45fb-fa5c-08dbb509e811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ck7M3GGDmZmyRyTP3J783YHiJvEMqJQQ0ufhVcgbQ37Sew0lva2uv7zJbaPzhmNSkObqKKbvABBRPJ87Mbg1KdHRuxzYld0h/xx0+fU75TO6kAltGt5DQHvPmEUZW3OkDCI31VhN1NPmzJlU4hvjOGK0LCSQ+NRYQu4iyfGpk6N35P5A9LZ1tYXgOV/8nYilMrGHc9UKyThD+iuGNv2vQ9coqV9EcCqVC2BTVIr/z6Jfcznm84Mxnl6+ujnVDz2ZkDZaPOxhVqeKyOvDtswRf/IYjxh/Mxur7lRMjNbtUR9ZYvZf12iqMSe4X7r3slmHRz4E7B8u19jL775O2LKliF6q8KPyuq+d9N7CBUmgm76C/GUYUhUupJlr2J9EE4pMYUwjnDC2Biju/oDLPnXN/7Oe984df2kOJ0VfMmOikj/1hzpOfT5YXXeDE8tPcYzKlwqZ8+QYhsZPRwUANmpeOu4XPDKffEy6TYR/sW3cHF+r6nTs275mq6C9ZIAP8+b/Axrywy96a9cLJtw5hmUkvW+jWae0aLLDiW07mkF4yhU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(36756003)(2616005)(107886003)(966005)(478600001)(6486002)(6666004)(6506007)(83380400001)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(6916009)(316002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MeY7VcJw4VrmkN3IVyAiKxnyLYDKdffCtTQPgO3UTOru+s1+lvT0iBMkDAC7?=
 =?us-ascii?Q?e9rDwC3fC+ApY/i4USz6AGidygXmtPWFyeIvVzrari4pwSWWS4XYdW08FHLk?=
 =?us-ascii?Q?Za07MbtTsb1JooOOfUOQhzOnkYW/sc8C9bY6/Epg/JSDtopmcdwx+YJM0h5Q?=
 =?us-ascii?Q?CnG+xz3sJ9DAxpDqpmuTVcUA5YT+ex/hFoxSQ5JAdsrFzbRY8PcLm9WjG1/e?=
 =?us-ascii?Q?z8OB50r6OEzkCqrfigqRtjn+OpehZL4cXKBF7WmCrYBSDY1Ta2UTz+WjEwgC?=
 =?us-ascii?Q?Vwicp8qNGqHDSjRQ61bODkRuoUEtrfNYCUWQuw8jrti/6vN7OeH3mkN6xJ9x?=
 =?us-ascii?Q?+xoDdOrM5ZRGmwzK47AmKvWGFc2e4Zpz3jAtaHN0fwJMmBMh/wGW9He/uB+i?=
 =?us-ascii?Q?2mNWPVxMtkjekHamNlICPL+mj+eBX3HI90nYAnjXJ6Mz4PM0MHZ2J+ad0ug7?=
 =?us-ascii?Q?3F5gZGRfYbV9CHvVlVEIikfX/7ANey5Qe1pdZy5M48qxsyxmW6S5STpwT3/A?=
 =?us-ascii?Q?hzAsdExjHFkKR66nuDc5mYOChvDPUnnan10mngm2kq24ElcZg5Oyxi6m1wlQ?=
 =?us-ascii?Q?hviv/HG7XPp/qLntm+qP9ZaxzkjXQvu4+FQud9oqq+xrk+BNDGO8FTDkDqtm?=
 =?us-ascii?Q?QsD4qCDg/GzH6/kxf90GIvcYD3QhC4kMYlhe3iEvNbu6MbWXRu8AE2uUDaHu?=
 =?us-ascii?Q?Gyiru4tKjKKLEPHiHXeGPVAD8DAm9xX8PgnguUZMEX+DKpQw0A40KUdG7DDk?=
 =?us-ascii?Q?ygxBataY0UNNfImp1uN3rD3qC9seu+0ChX+A4xHrNzvdTAnMSARiVuHmRgsK?=
 =?us-ascii?Q?SOBSRVDlk3YeCI2/8cMHgFO4Jo84+goHj6pFoP07jquGENjAJeLoeTJHJydP?=
 =?us-ascii?Q?teDRYWrUglpJRZtnMg0aQAtebV+sgNfO8APtG74QTljxCCIS/JRlTul+qZGu?=
 =?us-ascii?Q?DIOZ1dZCh1D41CK94HniZEb3AzASDOPvzHDIHsp+abtsc46EYLXXGv5IuArz?=
 =?us-ascii?Q?L4azbor4gOYYeFpVJJ02wPOXU+XetH+tjka6l/tj3IBdqJbm2AAgf0OOzoFU?=
 =?us-ascii?Q?GO6R8pDCtvkxWt4Oob5UhkEX0Zdjj7Rsz4sgEhHyc0X22LzcQE6MZSSBg/Ve?=
 =?us-ascii?Q?mKJTHFTFkDKsuY/u4LRObGkTHkOMh9FC+ME1cSrL3d4QEqBi4XfJQFA7s+Qr?=
 =?us-ascii?Q?VPmaL/dd9Yjzsrqhs78ReuypVECBaHzaargPL5mPOrQTlIRy3YnsEaSo4P+i?=
 =?us-ascii?Q?zzt2FmpM1f8pW2aMGF1bddeEdwiFEe/4WoEorgfWLgeoOOL/F/JDSMKPgSwE?=
 =?us-ascii?Q?lYQRGGK49KhBnrbJj/3mOGDaPpvGAW3Lg9wtao2x/cGi+x5MmaL4SpUr7apf?=
 =?us-ascii?Q?7hpOgKVjNtWX3HtrJfzYwJqymTCt5pRaMiVVZtZYBOJ+AwxniBtwZyFhFh5F?=
 =?us-ascii?Q?akIa/7ZihmKgGBxqGaGcRKN1dX9+NiPiXr9ANscnRKrXmo0FDF5bajpTkQTo?=
 =?us-ascii?Q?/VlBPkuUeyW+OVBOJ+x+GFWhJtIMiE3Wz9hPzxCGdG7UD+IBvTxkIYfgd1h6?=
 =?us-ascii?Q?YSE7DiC8+7PVKEmSXKnmS9pADuV4ceB8lz8HfJ4g?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcea1af-17a2-45fb-fa5c-08dbb509e811
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:03:55.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7McMjWa7E1xRM7S7GxBvUe4aVMyAXGQLUyzIex1UwT/eyrESno0g0DDW/B2JJYNTT8oHHuhffKTSyJ4Y61J8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

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
 net/mptcp/pm_userspace.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..499c334c0e83 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -208,6 +208,30 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct sock *sk = (struct sock *)msk;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	if (__mptcp_check_no_initial_subflow(msk)) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto out;
+	}
+
+	list.ids[list.nr++] = 0;
+	mptcp_pm_remove_addr(msk, &list);
+	err = 0;
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+	sock_put(sk);
+	return err;
+}
+
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -239,6 +263,9 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0)
+		return mptcp_userspace_remove_id_zero_address(msk, info);
+
 	lock_sock((struct sock *)msk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

