Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD1A2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXU52DrIBkbgdbFf/BH9VxtpD6Sb0UtRTDWU8DeA12+J+LqCfPr4dG5XFgmaTV0MxVle56FN/Be1AH7iJfMQowPUmnbRfEaL7ah8e5LUCChQgJu/PnSCy9VJHpjHki75+OGQYvrPxuF1PFXhAvhQrW/V89WbVo7aZKq1K0bZ9SUkkPBM6ouimMmNCJb6kukDNHqwV+pYSEqOKenAHsm1KSSdTtwsEYJWb0ySrPxfXr6g10Iieb0Xhy3RfHEMQK3grxi0zocUsEa1MNiO67Ah2LYARQ38BfsyhfwbOMq7GsSnhldX8Cyt2Q2Kty/yFjE3pRynKxqNfauFoIGfxo69Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae9X+zo1p6924e58o69bAY0chhYEmM7pciRSNss3ig0=;
 b=T5jHQBwG7QZF8aa2iixXKW6xcDHCBOv0qppco+vgmweyEPyJJwHrRCsYnbhy82arqcTleg1xwpupZkZ/O/9i6paqIZAkqLs8usu0Wv1VkP4Est/Uhl4rmaD/X6sliHtMHMmwEc3cC7+tyZHZai6RVnDc3T1V/fsbC2qawe5udQJoj7uLaKjKDGnI+/hvkRpDAlxqW3he9ASc94LbkAZf0nZ/g8xgZitSckfhazmdmI/0NJ24Ih/eOH47khSzxo8Q9vzyqQLVoRwhQfQV0UpxJQXf/TBVkkNz39Qy6ZmyRT2N3cc62wXjhCFHVyolKLQ/55VKGwLqbMZcLahUjX1O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae9X+zo1p6924e58o69bAY0chhYEmM7pciRSNss3ig0=;
 b=uHBltbuyvhmYZdvYcFQUu8O/iqSdyY/Ne7K8O9fP9cDkdcamFp9IRwWKI2tAwXi++heITu0OhGRdP1kS+BCU9MSEvNv4R8SOsxHmqmlgJ2l7GPoGC48rFgyFt0P0RaOKiNLFtGgXy7IvMKaQ8b9euT/qGCM0Q5P43H56r6HHx9lAleRryk/OKPjc0MTbzgnNxrfZAoTfK7NH9uO/qSMzaUIxVREefes5AJLzZfIeresmehPuh6y4wAobVMCNRbVbA6FTQKy8PRgP56aRirjsYM+ZZuSqZsvDmcMh9I62qPN5INFnXroNIvRv0gf6vZj646bfFcTT1/c3LB23zIP7zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8298.eurprd04.prod.outlook.com (2603:10a6:10:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:21:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:21:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 06/12] mptcp: update userspace pm infos
Date: Thu,  4 May 2023 18:20:11 +0800
Message-Id: <0356f03ca8d7e6655914e26502308414d27d3ae5.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: e79ef8d4-faaa-42d0-4fdc-08db4c89419e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FTAXXn1xLOXdaM4rPFR0F+U9rqofNssuFdCzWfxqwkSpyLzQ3xRqIQuASiCIF0bqwN+oG4HrLHJgmqK/xypkDg8E/ZXUW7zQmGpiS3JfQLwtdqLczshbjhIFH1NPvbLwW0tcXQrM7D+mIzY6gACSfoTRbA15ZzFnVQHN/H2XnvUnCqFx4CpD89bPtC4lXzjzn5p3JTs9cbyjEKiN7PXReKL9Pn/XiCGMWqgPiu+jUUyiTX7wqc7KYUMQgZHX/aMLvFrArqiHt8BZvxk/FTedDggjlkjBiqNaSkdSMm5vjDHiqmJhCLe+smiCQid4lT9y2DEvmPa7JIyt0GT1CTjeFW6GdHncZT3MP3OxVPnv5zGIiVToHXbRo0J5ZmSmcNu7cS3rFTwP5OnFchTez5ItF0AvKR4ALlSpMMgg0vHK5YG9Qi7SJxKUFlnrd9jCJIqbl3DK644psyOFFwZppL13VLgDPm5ffDTK7ptOUw1DU1vS/ulZbKwmJDKf6Hvx9PpO7XkTF+MGLxAu2v2Co8OR5oSKOJh9gteLWkva6xD8qnc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(44832011)(38100700002)(478600001)(966005)(8936002)(5660300002)(8676002)(2616005)(26005)(86362001)(6512007)(15650500001)(6666004)(66946007)(66556008)(107886003)(6486002)(6916009)(4326008)(83380400001)(6506007)(66476007)(316002)(186003)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mAHLYK05Re9XSaOwAECTLM00PM/f435hWnfLAbqiqN4fVL3l2h7l4Q5W97b/?=
 =?us-ascii?Q?OaYmn4mTVpjhpqSlvy9O8fd1H3IfWGoIZt8ykHe24y41Yu/0KRZIEEQz2lbA?=
 =?us-ascii?Q?Jyk58taAALUm2JkbWu69Hv08bQfulZNzPLqroz5IiUZE/9/9eVhqTobpWsEN?=
 =?us-ascii?Q?+6ZXkE9Hw9o9dImQ56rxzFo42WRuibNZgjqXYHI7sjru2ffkDgSNl1ck8f4a?=
 =?us-ascii?Q?rBbV/+MeKE7SM8iECdzzWCw+vE/uwuO65kXG8Gak0q0rIQD2y8lGbCoyE7GO?=
 =?us-ascii?Q?/LHnnjK6dZ3L9QxpxTmQz/9jafqD0Wg3KiljuG+Ji1ajULOxjE8z9Uw9sKEj?=
 =?us-ascii?Q?ss1R7fdQydKQrsk2YHysVsvsgm3BpB6PjYejTRwVWxD7fzv8drnDrLjJu3Ur?=
 =?us-ascii?Q?4V3kfdKrZ/YlaKC4yQEYZF6QK3/0RGvu66/+Tv2WSmYdPLuVzTxeGT+mAoXY?=
 =?us-ascii?Q?Tn2N81uyqNhdpC9WBHZy7wKRim/eurhgpahc441CZU1zk6A4ZgHSLBe7+kbl?=
 =?us-ascii?Q?zn0E097l29MHVhKfJWw0u6yjmGb5Cbm2MUFcVaCguCt2r7tZvG+PK+bUY/HS?=
 =?us-ascii?Q?2yshU6/eqHMYa1XkfKtk6Qgfhnf9+SToOIedCGLgSMHi04iby20iqZzJaUnl?=
 =?us-ascii?Q?rH1TcvLyv8DISaKxRqcy7qtuFSUXKBK/KEXRaJKVewuHRCfZq5ZIRxSK+Mfv?=
 =?us-ascii?Q?Sl6vbOuelLa+fhwCoHZ1lx6d7a8w3hU1HQU8tuYopmh+HCE9EYMkXI8VrSHE?=
 =?us-ascii?Q?N7ksk7VsRUhzkWKc2eZYx+QIEhLDQAwKvyThCkw5ymxQhcyIPqNMTBgaXh1M?=
 =?us-ascii?Q?7BCNb2o2i4iTeCSGNbLBunyrkIljTwduxTCmUDKLPDzxvFqCVGqvwIpyJNAj?=
 =?us-ascii?Q?QnCIEajvy0eT6WaGcE19HuQDgIJRdZQzT31+Z3FRicGoGCxCbTPZRhoALzyD?=
 =?us-ascii?Q?hhx+NncoHKmA0xs0tXhrctcttUwQodIGi6Cu8nx9YFZ6+48GA2C/Yn01v/R2?=
 =?us-ascii?Q?++VXIZ8dwqGzqsxROKtc4IwOGvHci5Tsw1z2JLiOtaG+m+Dgi0hv3mxbPPOe?=
 =?us-ascii?Q?BFwVJpT5FOY0MjPZKAGSsPiEttBjnvuYjeXBHX47QykAmSDNaciA99TVKUVi?=
 =?us-ascii?Q?IvfFdcuHFGPwRBhjKSBJX2sLkAtpkzvXLFWIt0RVDbHAsNEwWDM6n1koujI1?=
 =?us-ascii?Q?snsvZPB0+NSfegYXOwnR6J3mDLx4lvhgZqa7DvUxi+E35LD/0OQMYJfR136R?=
 =?us-ascii?Q?jLb0k80X0m/8ul8JMQWYZn7GDpvBvBCJtW34s3UWzb4YGVfH48QlhLs0oqe5?=
 =?us-ascii?Q?56oEsPS325yV3UEsQrUIole7zP7fKEzbhZfpNpfUE8T+3uFGuPd0zCw14J8+?=
 =?us-ascii?Q?RA7v1QpBVVtziyKAFyrFAxUrQe5c9KbHWtG2l2djRLhJfXMjej+d8MsD8Bc7?=
 =?us-ascii?Q?/4qxT5XuJtVJDtkMVK3cIiTl8hon810A+MrW99KA2Q3tqiIoudd0PIr82nR4?=
 =?us-ascii?Q?MvaEKPf/oJ0JmB6+C0qa+AQ6JJlhLQUfM9db6M0O8TlOQr13SBQ2nn3JSS8K?=
 =?us-ascii?Q?RzW1qDkCH3VAd6mZ06x8Nw2zKXz+nXyr5QUHKs2y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79ef8d4-faaa-42d0-4fdc-08db4c89419e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:21:00.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57UUY1qdd0laqrRv/spyVe3T7GHZBlFLvnQXkbr/PWyBq+E2ReP3RO/x/v85PcQNju4uGTPMj0XgQcoiO7PDfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8298

Increase pm subflows counter on both server side and client side when
userspace pm creates a new subflow, and decrease the counter when it
closes a subflow.

Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
address is announced by userspace PM.

This modification is similar to how the in-kernel PM is updating the
counter: when additional subflows are created/removed.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++----
 net/mptcp/pm_userspace.c |  5 +++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7539137719ef..9ba671902e69 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -89,8 +89,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_active(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(msk)) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows++;
+			spin_unlock_bh(&pm->lock);
+			return true;
+		}
+		return false;
+	}
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
@@ -183,8 +190,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (subflow->request_join || subflow->mp_join) &&
-			  mptcp_pm_is_kernel(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows--;
+		spin_unlock_bh(&pm->lock);
+		return;
+	}
+
+	update_subflows = (subflow->request_join || subflow->mp_join);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c50e1507ae35..98a5c81083be 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -189,6 +189,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
@@ -334,6 +335,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		spin_unlock_bh(&msk->pm.lock);
 		goto create_err;
 	}
+	msk->pm.local_addr_used++;
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
@@ -344,8 +346,11 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&msk->pm.lock);
 	if (err) {
+		msk->pm.local_addr_used--;
 		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
+	} else {
+		msk->pm.subflows++;
 	}
 	spin_unlock_bh(&msk->pm.lock);
 
-- 
2.35.3

