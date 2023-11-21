Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013A63C090
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="k7BC5FFs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrbUpryPCC0RwhaOi26N8MVgcJndcSFrCC8x/8F3ys3U7heA931CFuCfzwQekBKTp7NaGRERtiSi9brbLWtrXlW5myYQk+Y2DeGemk1jFH5jD2RIiFXAhLMFh4Utnd70fJUacRfVhLQUVDmddOYIhxhBlPNBJfkyh52qnxwdPUMfUacnjLsOBt4qAgU36WXtUa1rrNwDwL33k2yVlcqFr/MhpphxEBsjYGC9LcbirlhWaDow7DaKzqgXCDl0t96fzFzGeo5lIFWWn66QcJsQEt2ga/rovQxfC4eweUFyCDxn72H8HSMjkAWMDWT0DVJRQ2HZY6IdM6K79wq/oaykXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaR7AP/rwQiyk3znsFR72rf1Cpe44kDc4AYDX4mVVww=;
 b=bbKym6rzl8oqEbxhJ6tTeW1siEDjizy/XqtoUXO+dVsjchaZHnrYgls45Le+TFk48IP0nIMXu9ZCyBIwuJHeh9oGUDtNelFvTV9qBJPKyIcvWk48PxGi7gvpNsHTfGd7goTpG7glRWoovydduc/eBpJkSbpQeuYjXj0xZx6/QkrWE4Sz+navjFbiPqeAdCs0xoQ8w6c5+jjrk1Ia6oUIz9pX2iVzHye6qcrHSYHOFJUrCTZ2JaPi1Swi6xto+IaZCaMX3NwKVZARR8F0G0O8i/Y+okl2VbR5L/OA5UHYbdhp+Dntza1hXIwWCaFEUMIvoo2LSVkQfjeKQtNgl89awA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaR7AP/rwQiyk3znsFR72rf1Cpe44kDc4AYDX4mVVww=;
 b=k7BC5FFstEOvxb9cAoKiwisYBH3d2WKvDHB5CBPNNqkNhsOIAUU2GyIcVpDIe/+VTi4KDWqa77n6k4XE7ukWxQQE2MIr4imCIlPQCVu2XICYJwf50QRtageJOSD/lWGrBIAiigbpdFxGECNHcVCRySwSnnZFIjxA451SXCdyWpKkj43mCrw/Vh0TMoxERvzjqSlHcyC35/zmWK1oPI8I1IVxuexy69S9VHsmLc4URhXZ/WIwA1hoccmNLMMSbVsnc6yKOdQFF+aR01UJWDFAgkITXjnjNsp5vQg6+br6SulXYNEl79FNi4Kd27FsHneEteemtXEZ5qiyDvFl3bgVOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:55:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 16/28] mptcp: make pm_remove_addrs_and_subflows static
Date: Tue, 21 Nov 2023 17:52:39 +0800
Message-Id: <e72123eac3d75d7563233a7afebd5d55d4eb2f6b.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7a2797-51f1-46b5-614d-08dbea77f547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mb9TylbMpRrnTG/hXrSMmelK6l9K0Xzo1Gp6HqJ82XinagqG4rtojHZXb2ymCDlLe/0jkn/IcVqv9ZnfQ8YC3ByhwSe4rVPlTVSQqt0sRSXoGQpVTXlhPRLHRq6gHomnTG9WSdlbZIW+7K9ZXoa82aTFEWVBMoNv0MZqsDrLduZG7Cr30dzwpKukMJHe01245jLKvSQ7YD+LnCDzNMl3Qoiph5l392ANdayoVEHMi9Aq+ejbZ+B6P416f51wZIEIMMKJ3HBiBgU2AcRONPkRUT74Wrvv4yYg5c6A8Yc/ghV/Q20QIY76VG001/Iq0cO5THoWyD/S55JU1josAXsb+8ZHSJXGdJ3pRHLyimuAMzg+hxD92xwCD7sfFp5lkF/QS13yt/Zb2gzZbiGpa8fd6Gb4juH1QnDwSzd0h3qoB5cYdpIDmbH7whwaUrtCA4mQO+kvFstZ3sBEValU+ElIGswNUK2neuak+43zg2lUrv1MicMd2vfwQpsFgpWQFEomtbRj5eNphxJI8hiK8SdgRURrafMNlT2cV5ZuSjw/E+jMAspZHLjcSIojpR9UY/vr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WbYEODuKTGHR0vsvGZ4NBPJIojxzHpLkRBbnoctPADxTFX5YC9S9achi6w/4?=
 =?us-ascii?Q?23ksOjnuvcjRO4Ach8V1ZONTcmh6Qun7wY0jPunXhXnlmoEhNXUOIRFE2T0f?=
 =?us-ascii?Q?g5tOZpTzr2viB3LnQLWEjIqpdw3fxHfohRKMAY328dKF6JiW8Z/xEOFxLe2M?=
 =?us-ascii?Q?IuPEIMxMt9Em6I74q2pXsxOwuH5TvE4O5QAWCJyupWZagjfPS4PxMPLuIuUC?=
 =?us-ascii?Q?TVfCBZ4NJbGyJEVes1u43NSeFszDkhMO+l3DSRnhl22+e1Uhq2KIcING4owQ?=
 =?us-ascii?Q?d3zRki3+uUuHu6tAfquRbucrLX6nsr6rJNdh/GdOA3TUvufNEegR3jHZETPN?=
 =?us-ascii?Q?eeoN33YxWgRf7UPkEX6ECDn4cexk0G06xVgKRvNiqXLSDGuHu0OzSuf0/1BE?=
 =?us-ascii?Q?zU+0XrCHVCT0Ls04rjw++K7ohSbq+EbZlh1Z+Aa/yW/CqYaCg2EBNfsXX1Qi?=
 =?us-ascii?Q?5JuqCnWhRLokzKdRLoFFuc4OtgHxMJCJKPLzplpn/kEJKIH4Oman0ujTvQVy?=
 =?us-ascii?Q?RzKakNRLEPT+vn5neW0Lu1cjB1Y6J0oGTAtuUm4AottbhVYbZcv2x+Zr2kvm?=
 =?us-ascii?Q?G/ttWiswyZBC+7iBFt1dNJWVVkubt1DS76k/XF57KWiTsjanjiitobBXsZM4?=
 =?us-ascii?Q?Jewu2+kxc4hYTBcDfG8SOyCNRwffUTw7eMQ4+PQvkW2+WpfWT7QRqWa1azOK?=
 =?us-ascii?Q?9+fxgpeV4UG6rlT8/KzFveNrY9bN559izY1OqrUxWxM20ukbtGpHMJTvZuda?=
 =?us-ascii?Q?+pLIlsY7Yv78nrqSoZEwMdewNgZmIoIGtysBXPHPok6x7zsjNiDIOsHyQhcq?=
 =?us-ascii?Q?6MlHPTHonQegh1lC1/j4InTQaSXFtGMuCS2P5nzlNUmcCvsQyfHhmpykUl0X?=
 =?us-ascii?Q?KeWQwyM14OdQFSPcc0YHmp1xyh43LdxeMnBLTcQ4iNj+SbaxL24PnmNxeHMM?=
 =?us-ascii?Q?uaGG9imLrbq8hnBhOrV0jcel2bz4+kcBbstxsQoD8ghHp6tTZZskbiM39Fiu?=
 =?us-ascii?Q?RklKAajmNwH2AeEo7SwQ/QGUthCeLyqFWEPUsc2nmSsOVCVOiRsXPhqRI1+E?=
 =?us-ascii?Q?KpR04jfRen7lvodwzZ9yFdSHzjOs0+SSY7lLEXd/AQWvpP9q8lA9saKMHohy?=
 =?us-ascii?Q?15yIgicJEh/LV0FQ1hbQxM3QEEWBDkVRWTdzm1WbNT61JJWeuNetsiwGTSsW?=
 =?us-ascii?Q?JLW5qTyyZX5dp4qR1x4yERt/XQUCvSiT5MzAbU+GERvkWoLzm1ZKqzZy6jpk?=
 =?us-ascii?Q?PmwNpbe2bjD1mzyhfuMwJDcp28LNEwtk1VBomAOsV1fpEYEHeIRL6G+QiG2O?=
 =?us-ascii?Q?XCkbiA+bMbF97nqsGoatL28fOEcHW8ngDGCFDhs/jEgGbESGUCi07LTyZ+cN?=
 =?us-ascii?Q?laicQa+eojYgekovxaJtRJhdYlO0wksf2M2jyeN46+9Tz5WuLyQWECJrqJK3?=
 =?us-ascii?Q?2As1o4F6B1GIbvk06vp4WmueCt54CZvKwyqJxKlfxos34HT5xc9mhnKGkUIy?=
 =?us-ascii?Q?h0kUKUcMKVD/5lmnfUQ4YbsOe2dP0UkN0a7/eYCQXsAIz7ZCwg4mu6eZdR1b?=
 =?us-ascii?Q?r6xgEAb4okM4XUZAPK8lNMiWWdqKNmtSa1gzsOEj0Nj7zAHrAiYp7EbgKz3J?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7a2797-51f1-46b5-614d-08dbea77f547
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:14.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qm2DCPHwRFkIqqpLF+z8kImkYV2eLjFsnEmnk36ZoFJlz/cPmyWef582yS/VeiJ29lFKpA/4fZZutd1WLmqBzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

mptcp_pm_remove_addrs_and_subflows() is no longer used in pm_userspace.c
since the commit 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove").
So this patch changes it to a static function.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/protocol.h   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cc4ac206f848..a510c7d56d0e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1489,8 +1489,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list)
+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0460cb391ede..ec5557697c11 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -941,8 +941,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.35.3

