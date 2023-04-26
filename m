Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF81C2E
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 08:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8RKhjB/kEdBFx53Pobgi41kk6GuTbMLjy4V86VoJYnswC4Hbck+sEQgdBsiEYTGcpbqf6ZV4RWIvlDA+8Qe36BBDc+8oahY3sBVtDY9HfMip32z149ATX6umdA0WTYZX4LH9abTUXpZ/+B/O3YG20bOdfOe/QtQwHuAc8RzGDL0tD0yTH9EAvtR40Va+BngwSux3VkomglKtV9qfdnljdU2L1T+srjTWndHfDZgiyk/ZBLM6jGx/wDOID9Y3qqJOpOg56Uj3rYUhm/69fZc/uc9njiPsCzcJKe+xRFtCKzWuntO06a7Ra35udnomFGgxXpi/JTILPiMQ0JoG+TZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuE1OglS/9nVupcefvppeFx7YltgK13fPiGeZLXIDBc=;
 b=gp0Xvh16P/3K3RFqKEraKsMK7f+WTnQQ6+wfgJlPSsvqKFl4D9gIsGmKXwMw+/bYE/KoPXKC2ZMLGLL1eZXLGiaJXBgc0HBGZk9/vJSvXUKODllaRfAG2/Vjxq8HXr2wcgJePctSfCsc1jI4niFPFfSMyGtNXn3G8E03YsQfmklFYCtrvXPAx0YL1dSb90K0IEFbNyNqWoTpRRJALRn8zVhgziwDIyywWOZKc1xetNGzbdg1QsactYvLJtRj0Ut+jFSLq4VWY1E0kzg4sSxlIxrbjmDoyjdEqYCHs4cbJGVEmqfyWenA358RtZ18JQ5ICC3Y/NhOY+GtkVMBUl5TsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuE1OglS/9nVupcefvppeFx7YltgK13fPiGeZLXIDBc=;
 b=jMnISjr8p1/1sl7tPgdFuTdPauhtJmgkTBR064IgYucLfIxsdWRmMrz94AtNsZeBxS4OdhJhWhN/WB4r4dWwdNHk1rOuPnwsKWg5BIcdT+VBn/GJf1YRcDYwwnzznT5KygjT4KieW2pv52vTyrfFokRJ4q3e1invco85vm/K5qrpuR6m0B0H/2ID5ZH95d7tuCMt9HNq1uoLZtPVQj5J2074qPQ3FlZInFi605OQFRK9dvXuZWdgjHAGeb420/VGJZeowbs+ZftCxo2PSVTeth/B50D1hSgF6R2YW6AneKliyj3K/TbmWEZ7z0RwmBjUYusFalvd5Zr6+7CSbJce7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 08:56:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 08:56:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 3/6] mptcp: add addr into userspace pm list
Date: Wed, 26 Apr 2023 16:56:24 +0800
Message-Id: <0d5410b79cf461ad9f8bb8a15d960ca9517d0bc7.1682499136.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682499136.git.geliang.tang@suse.com>
References: <cover.1682499136.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e77d573-bda6-4a63-f14e-08db463431d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RT5UKUhD0G5xatm+AjNSjrdsfYtqC9so1zREI+MKS82Hdt2Bq52DMZ74T8jaOUBtPxenRCCkoGB7hMk7xUDuyRHtNYRsuj4X8CcgPzpTS+kg8Kmcz1QIh3VNAjJ2JWmfJKG5Mz87+OKRXv8Z2UCQEUHMMkIbL5LyxnJRFqJYF+GW80ZcElpxB/d/YBcj0azY0ingwo5RgoLEZw1/7TjxBvKLXPe7MmBsEJC2Cv6CMm39JUPqyeRUbooOw2KlDJnUfZ2lERbQZg9+tSNgG9BRhCgGiPHgQGYFXFo1AiJzWbV9YmcUheholJabJTmGQMKXReCUhCaYItdLHe0+NR6I/QpOoYALKGeHmMZpNi0nuo6RuuMCBKl4Aui+24My6fR3B3f0OFFPyU0q73JnIQzL4PfgU671DViljZLYVO9h0cCmmlaawprzsUTUiqTqVHBgiqT3K7l6+kP0RfE4fsQgzzat1ox/u3m5/k8dhNmDxIZfYio8L5W/Se3pZwLYW17AXZVzHPz6rJ3KEqJgygQ5t+H6E8+BXkfpiZczmkF3L0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(5660300002)(6916009)(316002)(4326008)(83380400001)(186003)(36756003)(2906002)(478600001)(6512007)(26005)(6506007)(107886003)(966005)(6486002)(6666004)(41300700001)(2616005)(8676002)(8936002)(38100700002)(86362001)(44832011)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1iFysBx1InfAbyH9zV9C2HaI+lPKu0GgNji2DBgdVkSi39BdrEZO3WCgDRV?=
 =?us-ascii?Q?2FoeFoTu3t687e5Puzm7GBo68J5QkqBfFD0muG7nIauzTshQVkdwxBmwYjQa?=
 =?us-ascii?Q?+BLN4ZxhGlXHddNlM4ZOyeV7Xxdx82J9CvvdPJ912wQu2OuD8FvuZ22D3Nf4?=
 =?us-ascii?Q?g1y8M9Ha2N2HIOmwlmKZATllGEKhDzv8dcLl48keVB8QGPnnUAlCmmVi8Uq8?=
 =?us-ascii?Q?F7GSR/Rlhjhrk6e13WuTSY84ZIrPQ+FMUtjNjb2tvnHm+Fp2j9bnWFWTjhyh?=
 =?us-ascii?Q?86mv0FMLeVLN0YZONx639NMkAndgwuN+3vMliszioiixkq4FSSWUq6DIETek?=
 =?us-ascii?Q?Dj5XhyPhX5h+3sUQuzWLG4dkaFiBqL8CM+JS7rnyImfeJ37/xSHyUmZRx58d?=
 =?us-ascii?Q?YX18ZECIhot1azLch75Fj31h9ZRbtJGYk836UWhBXk4IZjPHqLXDHUkTwGff?=
 =?us-ascii?Q?bIl9PjXGq9Z1c7tx5hjNzlWqSv3uNfoxW+J2twU/Zx42P7L5U87IVZxMdcjz?=
 =?us-ascii?Q?TStVxwFWAJx6kI1GA4rViX4+S3H3IjSb9RNIxFDW3kTdAcVVuQm9y5hP2W9V?=
 =?us-ascii?Q?98gUsBcYATR+EN9u0WpP9oe0OCyTsmKYblF2NxEQryAHrp8TV6WyBTrARGhG?=
 =?us-ascii?Q?gglJb5vEIMkgYCYT9J7q8/xUuSE/60lRBFUbPpBb4aAxHWPZKyyX5tbxCmf6?=
 =?us-ascii?Q?M/M0AcegOQu1oingC6mJl6enrJrqyPAg8EuGPv8iSXNtLoKnN5vTeGxrpcFh?=
 =?us-ascii?Q?Ik08OzuXDCwVQVEmioh3kRMO2HNCyLQlP+drPjv2cp4toAriMf60tvW2Fr4q?=
 =?us-ascii?Q?K/2lwK1rX2mjnIuWa8FjufY070X4WHmf3sXuHOOCdq1G5WK6sKvJK2SfOouS?=
 =?us-ascii?Q?2uRNM1isvxIZTD3NCC5mrcHxkPj8NxCzxAh0nrvzhM4ULPFp/E1rIprOGyQQ?=
 =?us-ascii?Q?P9mOBVHqt6UtO7h1sX55F/tsfhGUYeSnJKKEcUR3mkfX0br3Bp/uqVvs13dE?=
 =?us-ascii?Q?4lVEborPzm6N+XXEJRDKB6hyKm8+h+84YCTaihpvpvsyt8B0E0/cvNb74DCb?=
 =?us-ascii?Q?KUSDXo+iCiSqQ9C1IH/e8v2vchHQ9hCbB+QgdJhj7vttrLQgzpQc/TBC5744?=
 =?us-ascii?Q?JnkBRqfnQ1Gc7dIwH7iZvzeNwsDe5Q5NkFpwTemhbTd51oWAc8N5gKwO2bud?=
 =?us-ascii?Q?w5wNV65epqOBjVpxDYTFWjqmajz5C5/2KGu2fzFL2wBtQ6S94Ml3Su6q4Whv?=
 =?us-ascii?Q?AQrv7DTV2baWzQpixc00Y2pOCmS4WZaGuI4q/M6/X2Pb1cYFtVT+bZMNN/QX?=
 =?us-ascii?Q?azLPtHIyUbIiuT8MMJR6IDLfeJL7L+RJIdAkLUn3FJ1/AXM7U4rS/BjCBq+v?=
 =?us-ascii?Q?IecHIZtANHYcyI+Wy+c0l5XTI89Qy83EprIurH1P8L/r7ueuxD7BoHoSdJ4c?=
 =?us-ascii?Q?ry5rcRaJx9LBZugFNUwaQASaIN208UYmC+K00EBPhUyOslfW3mHRFFo0pr6f?=
 =?us-ascii?Q?IxPV+AY/OaT9/G+Zol8NpqkrpTKPVRcH7p48ZwOPtE45ordTqUSjOM5+zfPe?=
 =?us-ascii?Q?iXhsWu5r2jIUzhlXofBOD1LdiLEMuv3PyHGMXvzc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e77d573-bda6-4a63-f14e-08db463431d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:56:59.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rf7iOjblp6UN6tfs8BC9uEbKtYRDrjlruyLmPfo28lN/GfBlSzxVpgX2x+fgF5Wxvln6LdzJ4dBkcFUA75gBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7500

Add the address into userspace_pm_local_addr_list when the subflow is
created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
it in the new helper mptcp_userspace_pm_delete_local_addr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6beadea8c67d..fc96405b7616 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -79,6 +79,22 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+						struct mptcp_pm_addr_entry *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
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
@@ -251,6 +267,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -302,12 +319,25 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	local.addr = addr_l;
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
+	if (err) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
@@ -420,10 +450,14 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		spin_unlock_bh(&msk->pm.lock);
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.35.3

