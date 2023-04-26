Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62731C2B
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 08:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9K8U4rqb1GHxtQz44LtMMhw2zt7UJoMEyKYMEyOl2PPf/zHhowXuWYANiw5XIHCVAI+FT+ZESPs898p+PXSKrAEHp/mUV6o9aQ4159nombtNV42hY1dXhaCR+sj3kyD0pcsmxP+nifCwkHFsVAtOyFUaqns9KUOMlW0hu3FGmq2CAZnKB6D09MyZ1Y4LqXxWibemB5UnPfUjPWX6MHLP5USb7fovVeBqpiXvL7tVRT/2+HfVmbYKYZqRnrHzjmvoY5JOP11XdQ32vuI7m5hCaEAiOl8Hrw84loidkRsYubpllMzoBiDkkPd23vEmr3+6/UbwRXaPWsPeP7C/rSAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=OW2PqOXlsSborT7vHhGFrXnr5i5bk2UpdaQpRHjVqUgztO1dh6l9nltg0vKz7eWbpAHeBp3l6EaQVDOq73x3Vuo4qqJABCA6kExTzsW1Tqa7s+nFhdQO6bn73HR4+6XvAj1zElrpo77QfYaNf0KBVvqcyGghxCGX5RExbngMma4BHsz6bkFIKNtOoLin9Pi8XPvGaVDkzkwznNyECrv4Ff/yZiZzQWpBhAQa1s3qoRpabaIs2sB24nwBKlgM4dBYbmyfgHzYz2HLlpPwfGStrI8MS5gzo3bAXggesu5qHmVQ80cXxQLHGoJ0ykzdsK1T6RSNmJqBWFaELxfz3t98Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3bl3W2DePJSR+A5CQupDySYUYnnndOVDynmbOw3Eb0=;
 b=N5KwCz49p8tU09EREsDNaBaInweaBfwtYCRV/O3zEJpLobAvG44iQMUUd20AjAlexRFD/KVoYjlT3DLEkNad5eQzytfqbkwFLeHpvvVH7izpA9YuwUOcava+NsGtLf0qrmXT5aQDBfDxNSrM7thv+RYuqRr64DTAwbLH8TLWE6iFVAUE5td2uRUzFSAF8u+4Wxbk0ySVqgNwUfhc9pZ3f8bBrx65rQiXtGYwaYOoYshaAL2JqE48r+HGocmIBnR3m846bSA2xBmIkBEE310h9p3u4HbCkfu80YadaExv8rLZZxvsttNyLhGVYroc1gHv6mHFWUL4xfi5RGGDkgNLUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 08:56:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 08:56:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 1/6] mptcp: only send RM_ADDR in nl_cmd_remove
Date: Wed, 26 Apr 2023 16:56:22 +0800
Message-Id: <829320e51d3eb08db95897ab5a8ad4c20660b24e.1682499136.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682499136.git.geliang.tang@suse.com>
References: <cover.1682499136.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 154e5084-c1ab-4533-fa87-08db46342936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XoDNDrPFUGfkR8fMV2KIsvQmMVHbqVqEQC2OeTngkRDNf3xCqxpOeRIcflcgmg8SD+IDRi7Fht13B4WIGhbf/k3Z2IGPY7XRi6TvvWgEgrDkiu04Ym2upkS47+VRW5JGnqkyjx6CdJutHrknQEnEpW087+LmNaq5lddW1St3vP07CcE1ugsDNqphTrJ16q98BJZ5hGt4o64njTPVRhJYdBPXIn2Fy6PcoSZFxf0eAfuD7TCa28F1/Afm2prDk//VrqI70cChVsG2NawRZO6BF8V9qhri/lqUFl+9GkxtsCLN9kOJacEx/EAt/gvhtin2ZY7vQuRPks74LvI/K/KJuk/oRuLPz7YVoth7164omRcx74DQdinvarBdCFV1epORSDp+ra31rYF1aAhbTut6jklLadOVCOgvaOfC0LSKou/F59GGbuTP5h862ZScfvDfLrCWvoGCco+iA2bFFxVfyxY8k5DQDpUHCVKE2plVvR4FnAI3lTkvr5lbut1siAB+8QhLPzH4+g5kPglupyQrU42sNVaaXJ4YIESClALLsbU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(5660300002)(6916009)(316002)(4326008)(83380400001)(186003)(36756003)(2906002)(478600001)(6512007)(26005)(6506007)(107886003)(966005)(6486002)(6666004)(41300700001)(2616005)(8676002)(8936002)(38100700002)(86362001)(44832011)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EyDkNQlyVI/BNPdNJXK/IrZEcX7alir0jIpNrzfXaQczu3XVs7feGHJiMI21?=
 =?us-ascii?Q?UL7phw118FfhIHekM5JC0uddREvrOaHw8oPGNV0Z8GkSgQBnrm5Dw4eCFY2q?=
 =?us-ascii?Q?GSXsSAW+jHfR0s3ZkeFO+24LLhsPjefy3bTJIzrKBmpGv5YHNipORaKE+8uM?=
 =?us-ascii?Q?hWgUJiYaiYsgp6ueu6atCgTZNPZi7D0/UOmFwIj8BHmj7ZgGiV92Xp1bxFc3?=
 =?us-ascii?Q?WwUS0154Gc4gCkR4BXlVVU+REAKVGLz0IMHKMfG9eGLIH0mkw3d5gJ6SU8No?=
 =?us-ascii?Q?mUe9B+dCvd1W9pPrMe1YMAbywlOJMYnoA0AEIr/Vx2GP4V/L6ATcJm1IURc5?=
 =?us-ascii?Q?BCRW858Yb0yNWJgVpq18YqKKzVmKxl5+2iNbggED5DqbZA0Bi2f5Wdlf4moF?=
 =?us-ascii?Q?TiTHTn/dJcYFOAo+ICqwiqpO/Oo9BJCXBtnU3QNRvVrIezLzqyz8HzKY1O4L?=
 =?us-ascii?Q?W541ZkSh52pDzUMy8prvlm/adhmAjo683e2UtzLPQyhDXlG4TGUDBBtYeJAC?=
 =?us-ascii?Q?Y8xZGz0EiGpMIUHgV4yR3U78ndnizbAjmwKaVPugSCeXMguI2wSF4MCpF75f?=
 =?us-ascii?Q?K/B6CO/58q2KMfdAzwKo+Ux8qn+h8YP18EeDWQgATMUj8bbaKMvQAsi2JvqF?=
 =?us-ascii?Q?CZqoZ3h5t5thJcybeZ3zg4zBX35vyiNuksEfV/mnPpZM/v0+4Uh/QrNOJvW6?=
 =?us-ascii?Q?+g6Q1p02jaSYaNGK6v9Hf0BcdPpzgeQSMm/La3Eyk/rnLjeRgO1qO9vUiM+V?=
 =?us-ascii?Q?B4kPHYsllEcjP4QRSKVicUjJeJj2RA6THmOTjxn3jBkXUJsY8om3RnW3FHJ6?=
 =?us-ascii?Q?lxD32sUmVMyRTlLa6o96/uYyJpAidIR2TPMINDlTvlqayalHY2b+w/xB4qub?=
 =?us-ascii?Q?Ny7fKKI+dSNeubih4dZnXAISERz/4Mvo9J+pXmQvRopkpMgnyq7efsAAjFTJ?=
 =?us-ascii?Q?3Mud+2WMCDq7UDLrcBmVS2ZlPvWm8VZjE/J6Pv4lIohpxEbDPkQCJ55ynvQD?=
 =?us-ascii?Q?ncCib50Eg1n6FVbkY3HXNaQeoYPps7LLejJPC8nhnSK0y5PilzaULi4DU9zg?=
 =?us-ascii?Q?fWw3NQoJU22rDc09UDbYsWiSQJd/P11ZBLf5hzlDDLujmidE5SlZm7nymyzX?=
 =?us-ascii?Q?RG67oc0sUFbRk5HTwNGUoYINcaXs+vtHI9hPLM+2PDZSpsQmmxOWmHeOxWwS?=
 =?us-ascii?Q?4kMRh/+L9yHtZPrMb5zfpAH2WXVRzcYJju6aQvUwRBMt7aFnz4FZanV4Iano?=
 =?us-ascii?Q?474XBQPIWdSzdsbAhd2nP9oCndgXY89ISEoPIHKHAWfIO8VinJfIp8M/ryTD?=
 =?us-ascii?Q?CALP0TsKUvDDGeR9oUO/k5JceUvrghl3Pq+4zXR3Vz8ZDrlYI4p1+Dyw8Giw?=
 =?us-ascii?Q?pV1ZO0AViSkasuszRYzG0ATdtZhmrRRgAdEyYhSgAD9PFhDTMJSPzXBUbk5i?=
 =?us-ascii?Q?6iCuTKXE3ULHcRZwxzjoA117b7PSmDrcmVUL+5w9QoIygA9wHGv43tesTxsU?=
 =?us-ascii?Q?5PDp8x6TOWTXs42okwkMhbPaPO6vYrmnZzJ3NzNn4h5F2e2rXZ3OmnezOru5?=
 =?us-ascii?Q?lNaktuCjfZbiwP6i2Rxv7pVmIwby1QvFkK/UvLEF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154e5084-c1ab-4533-fa87-08db46342936
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:56:44.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG+4A0odfGdB+qr4jlOZM0vCLerMX2cfaL8QkP5yy8Ay5YU2+Z75a0C8WVr5b9FiM5WUw0I5e6+cj6GY/xpzWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7500

The specifications from [1] about the "REMOVE" command say:

    Announce that an address has been lost to the peer

It was then only supposed to send a RM_ADDR and not trying to delete
associated subflows.

A new helper mptcp_pm_remove_addrs() is then introduced to do just
that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
subflows.

To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
command, see mptcp_nl_cmd_sf_destroy().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..784145e6a314 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,24 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
+			alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..6beadea8c67d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c39e172c95db..1a2772902e9d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-- 
2.35.3

