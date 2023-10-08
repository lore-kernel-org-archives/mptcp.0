Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9D20E1
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Asj0z7r7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY+Nc84Clcq+R+DILLlKAZGI2kRg3qIgSWqEOIk05bTIslNzPp9jha7iEdEciajYm6gw7bM4WLZgF/0BsyN/jA0tO+EJkDMqElt8nwC3mlCSM33rA5x4/CuejLRC2Yu3IfzNkXCh61B1F2f6cyzB4fjgq/V9Y5j7zu/gKTAPvRW8OWp6G8pY2ke5QlhVnHB9YNTr1eJiZfic+lobKl92pThp+/lnioOoDo44BOJoixDaupcy0UZtQTwp643u5RN8+//wJVhs748lBWrV0qB7iYXusJ0c1YZxhi35c1168zFBfvcqyNYnjOYH2Cy5fa7M+AUatou6Fl7WMRf3VNABEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKec3J81LeiqqlecrQBw/SwyjIqivGN+aQspdHQh4tw=;
 b=CnC6AvvD9z4AxGhlrJu+IFgoQVkuudpENEx2sleU3MsK9KA+a80C8pXXsmMc0Mp68luLRyyyXPTxtoWwW64sJlprscKe7w0V0DhsXNBOlryLwHBh1P8KQgnirkhNGF1yChttqKPdTXE7vEBHgmeMJfVYA+8c6N4Zw3dD4vW6Z4ceHtoZbk3/XDHVz7O2pClaozgmrm7Mqatjcz/+GgkBlIZtrl+roDgtLnDuFh9Zldxf+0kDRdnu4Pa2mJwF/rS8IInyxAKTwTmuI0h9bU7IrvCIaRPLZUMAYluIL1Gz7xBWpO8LQHmh2F/KbumNY8yFfEtWrYr+zz9d7cPhJenzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKec3J81LeiqqlecrQBw/SwyjIqivGN+aQspdHQh4tw=;
 b=Asj0z7r7LaiYVSRqE07p4KdtzKl9MJTGLpK+6CI5J5mHqXn6GFb9yPfTrJPPIk9O7J1CRjMnJHedkFmJp+s51h81lZo55WLsKbEcsTa39XVD+hWnJZk8qUUu4ujy0iXnqaAx1t7FIKMf7C6e4SZ9TMVLq//pxv1Zs2tcVpquLBbm0zao7024hNkHJV+8AjhtuOKhu6oRWOezSqUZd/dWai3zf2Ir/ka+NDyvkFyh2+9cVkGdg+GqJopjzuHKaovZlH4N42eIJTBWE2HD4wOK4ORB/9wzLzE12IhinC53I9GMiyWlXZQIcnYXqroXbdlAVFUkR8tlWBgFcMFrHTDiRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sun, 8 Oct
 2023 10:26:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Sun, 8 Oct 2023
 10:26:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 3/4] mptcp: userspace pm remove id 0 address
Date: Sun,  8 Oct 2023 18:27:09 +0800
Message-Id: <8cc9892f0516f304f146318aeb21a6e935cdec39.1696760702.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696760702.git.geliang.tang@suse.com>
References: <cover.1696760702.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f99490-7380-4652-2ff1-08dbc7e9018b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sFPNkw8TSdeNRAtcDm20xdnmxQZBBY1BtSPdhKuR4ei2WT+v6QSZ2Oksd6s9HHagl55CMRadDu6D399ibFZpKj4E7Ml2Notsk0liHFOXyF838EGcdBTxjAWSrZk8sKtR+3I/CxpsDoEcgH+7rFRhswtUt8YdpnpYHGS5eZ8F7prLGKEHvICN7Mn1gyproqQzK5k4JQZuybzOz6hLqx3Vo6+JNYBy0h3eYGLJxZ+mx9KC0QZLxzKzIX6+ekp0w6UtaJs4bAi0MXVPHv3ZzcID4mHH/KgaXiTMpZ+AXdojX1cuBYj1OQ3e0YrVJpDgjYl3vsyy/GV0rcnwuDQHDvMfe7HFJ/6UniUZQi2cvgulKHdD1nl/LnmatuiNItR2vmkh/GQ6fWV8QQe7mpbf/qMvXomnl0fJH6ipoL9e4ALy1d+9FnBbTiwVz48Ue1mcEwYi66bwXnWxLgM7FvI22HEwuLCCVJo2d+ihDoaTbzBx8hD2S+JPqZj0dxil7skmy7niSMVA7eYzaKwFa8pZcqzfsP9vUIixGY3zyLHofLxjt2xyYH+mIP1vltt0m6j7BYjWbtcscKOo9VXm5h8YcvGr7mixSHjoSA6P+PpDdaBSEOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(36756003)(38100700002)(2616005)(26005)(6666004)(5660300002)(8676002)(8936002)(4326008)(6512007)(6486002)(6506007)(44832011)(83380400001)(107886003)(2906002)(41300700001)(66476007)(66556008)(66946007)(6916009)(966005)(316002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1Mbhx43UeZ/BFUm2DHwIDYygoX/6c661DHw3o8o03gsvM25cYUu8be3MvKE?=
 =?us-ascii?Q?PgMgFko6q+LidmC2rsVvn1xJKmits2VG5vNUl3fK3aR3N+F+MK/OkpRju+4a?=
 =?us-ascii?Q?EDhrx6Z4B/XKI3/6ddwGmjPVK68rfJrvNOKAcRErc5rMiTDoWgP1ExTKN9lN?=
 =?us-ascii?Q?cG3vGVYHRWAGuIg3CTK/NZHrItsxgAVfzy4ILV8ggNwlfQkE7aEnFZm3XvjW?=
 =?us-ascii?Q?NEtgyd34g3M3Q9w6xMu2ASV2WmL/WHP4sewtA6XuYJPg/YxTodLhh76NLSQS?=
 =?us-ascii?Q?M8T9k23szg2cRl62Lpo+ebP7jYrcwqr/hQapHf9NfjckWElAybqT2Bjd2Xws?=
 =?us-ascii?Q?3eOjDZZc8A5EBbW+Gb9w/ECbMLWFD2EKhoiNPjib/eEuAZtYkjPUEaFRHoU1?=
 =?us-ascii?Q?eyG42UHNFP8x/spKBUqyuwbFlgcoPtI/7OIE3OZRQ0GV9J4l0PZZwJ6/JRWJ?=
 =?us-ascii?Q?4XFoDqPPLTFeylgcujqHfS4wf325CLySj4pmKfUcZrUE4C8M+xN8+GINYBD5?=
 =?us-ascii?Q?9/XILaEPdpbjhpy3zyQkH6qVOpvsZXcXp3G7dBvcd4FX/dJLPgxbLM0bTcRi?=
 =?us-ascii?Q?4uOchiRWfkNpltE5ge8QZE6iBwrhB3zHRe+woyCFsMe6e5TbwsVKX6Nn1nVM?=
 =?us-ascii?Q?3Y/1H9tWdTJbE5QByAIpYAdrNPpbtiGicksd4XTtGE23maojRG/hAMbwag+1?=
 =?us-ascii?Q?hkvJCPD+jQ+bzobMbdrfnOLNbrfVnBDbBURpSsvqJ0m42kLAZyWUvyZQk16F?=
 =?us-ascii?Q?8qPt/Qg/Oepy/H1asXSgznQnOQA4YZmWwSFIcosfQqyyKi+3A0pDAo/Tc14o?=
 =?us-ascii?Q?85JFXA7hXYzZjkOthp5YOAIuiJyB+pN8iRH4OmHcdE3OYCOc7mQE3GVUjgMM?=
 =?us-ascii?Q?qBGT6+iQXA4HIgqizMZtUCLqLH6O1T568S+4fIFa6xkBBo1lRslqisbqjan/?=
 =?us-ascii?Q?2rwwpaFf4VTxiv1oWRxU3prJBIiNYHQZskGTHDRzuPfiUUnvcqql/VcuekS9?=
 =?us-ascii?Q?1vRXSUT2LvKpO6Q9N0TJcteVeoCa0jqFDfvrUqGR02u1tKONryPdxCbz56QY?=
 =?us-ascii?Q?59CgHPw1lNKgw1p0wSLmmGM6hqaAcJ90atbKmgbTTRITovbRy7yIp07fdH8f?=
 =?us-ascii?Q?3F+pz2dPyqgqHAuu+SOegLv33HunlYbXSLs9TEba10Df74uvcnuqU4RHZpDA?=
 =?us-ascii?Q?pKomvyoY/fGszl16Rt7HojBcmTcsc3E98BWYdtWdTvdyatWAbaYnQ+akM1ba?=
 =?us-ascii?Q?o+mZDqhhZN/IZM2bDez30a08dVnJLODkNSoglvTVd1diLr78OYJo28Y/iyNP?=
 =?us-ascii?Q?qz8dAwUtQSsrDnXxUr7XnSByhoFJxGLUoG4+KRoFpfwmdpB6dEAYIF9VsQ09?=
 =?us-ascii?Q?DDmiOVpdNN8RvhCO19Kvg4SoP8RsiNpnWP1Ode+7SrKbf/jH/nT4hwsAH5YC?=
 =?us-ascii?Q?bQwYojpoIfoTLm5OgT/S1n4PvAPNoCsNq5Lv2LYZRxB/hDenCyvW6eD1/yf8?=
 =?us-ascii?Q?bHMTDGXTDjjrhvtQxC9Jygx/2omauEKXG15nHgbcIisQwCW0ICXMG9D0vtmo?=
 =?us-ascii?Q?dH1alRZyXBTT5BfpKvmXZBNnTpVlO6B/+VGYw0HN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f99490-7380-4652-2ff1-08dbc7e9018b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:26:17.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuuH3/3vmul/Bem165DjAL7RNA63nFVDcsVzjf09Q3I+N7InoQDOd++CUN4gD9740FqPS10VAJkzYijIJpOyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222

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
 net/mptcp/pm_userspace.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6b8083650bc1..ed9db6a4e228 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,37 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
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
+		goto out;
+	}
+
+	list.ids[list.nr++] = 0;
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	spin_unlock_bh(&msk->pm.lock);
+	err = 0;
+out:
+	release_sock(sk);
+	return err;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +276,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
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

