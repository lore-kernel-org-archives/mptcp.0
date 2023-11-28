Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE735888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CQ2TbfT0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU7KUito7axJumRgRfp9dxNG3pt4HOX8lHqVRHxyI/5f0QPSqCw1SHkpmyRxwGzOU/VPLrrvda6LB5TkfjqnI81hKRMUDaxi4mCg9jXQSxx/8Rkj1vu3215gOoR8ynox0XOQ7EpT57i8+LXiV9BljRWZb0qBY75oA4bKpBBKxu8gd8K8dcmz8QCUIzHzQTzCy9WNkrfbHhmXe8Zru1QtJrkDrwH6RVwBxPfkof1B5BwWPTuJ4Xh9oQV0KNC3zbvWawybyYEqsrWXsCQAHO9JUR1Fu1sgxCgKkwANzfcOxXeVpKQ67NLPZERVkEg3+5j6PM/yTZlklCuIXrDvCRkZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNNIrA8tXFI6mjCSG5JZPitbSE3DdB9D37M0K1Au0SY=;
 b=KqLSdi+rMfnss44WVEQ4GOjJlpvxTFAKlDb7vSs8bSPC+EuBQr6wIu0vmtesuutE2qA10oiFex2mn1YjT4XHg+pYnmI8cFZD+c/q99MTbTQmWeTF4lft5nk4BRrUIGuBk0x2UEB+wB+FUay01WfZ4y24hwOVaTmedelX7ePBOGjP/gx9Ch4V6s2zD/GNxMDv34tfyncwhKgpXhX14cjn61K4S9IqT4DfQNznyjRd6XJ8gseDlZ79BnYGJaiBGObedvpLaUc/dQ21RoTtwT8DyMSlbhexCMcFtSDFjSN5ZvvZtsDYsuG1XfMtTF+emuyn5GIPbjUzf7uttfe2Fb09UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNNIrA8tXFI6mjCSG5JZPitbSE3DdB9D37M0K1Au0SY=;
 b=CQ2TbfT0FaHJYETQnBo0z+f+w+/Q+LkM8H589CB8zUOfvExqkpuPiNYmz3IulZplD6MmzBL/48P23T0SoylnpmhNDy67CIYxR91hm0OJYyffef+XJQlGEQOs5oyjhVBPTbBH70HmGZ8kKRa3uIycLFuJgQI/CCvXSimYPLFZZCvgDDLYY+hmSQn/g93/bM2GmGjDWpjkTHBQxfnZXfQPJTaBShDWT65e3yZRORuHCpDMBDFyKe+Po+zp0pQbam80UIF3GI6Jf71uCV5pRVafXc5TzU+Gr3Ykhrx5w0+eSqb1W0HxZecWfHU5ttG3dMwKHXnOfPoaT9EH026CbBbqZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 18/32] mptcp: make pm_remove_addrs_and_subflows static
Date: Tue, 28 Nov 2023 22:22:11 +0800
Message-Id: <ef955b6a2d54ba386d03be542dbd649dc14b651c.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 52823523-b2de-407b-34b5-08dbf01da849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RasGabi+S6SCYuOduExNv4xwkCLEYtx/sJad43ywFUw8LmOx5Q5roKlryzIkV6oPX93YDxV7toslpp0Rpi8NZvDAwbbAcTipe7dL2X16pkcRy8QPuvIsLgT3sToW7/PD5COtxl4CumOOgKyskE9AtIcag6jdoOR0J6Zpwud5Ut1S1pUuMvj9XHzjOX+IoAFPHcIc2YExjj7mzuWmbKIc5wkAZOoQLnrwrb/B0kOTuWWckCug63Iny/H+QMCPr813bXG+v8ZZyCKzCFaI7V2hGh+Gve5vcBhERAHvesaCXuJfUU55i0PaVSYvak9n1qKpsWKOEQ16TtJ0GQxqC6V6ZrjV49aIN2kW+1uxxMFTtESi4hmo6ULuUesftgzqjZaeCpfGnvea/6E+F6uspMW1vsaxOiybyAT9mrBb/83Cb0qDnnHGbkbHkg9FwWMlQWf5v6zPbvSSwu8JOChZ9WVX7JrPJj67S8JQojegPRzSvn2PR8vIcVdo1Gh60Uahka8S00D3hvEhYR9gbh31D/VwW0KAkjjP2YHyTwqghOov5YuUEW8SNq7RyJygz6dok6tV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KyaxAXkz4eLqZhOTEHA2xw5rN0C2IQI4BxmtDC+LVR9ubeUp4e+YyFW76Wen?=
 =?us-ascii?Q?enI5stiCfd4EEuOLb1oPLxrOPktQ9lb3WaTDZsDD8fLACWUeijJMRT+xE3R9?=
 =?us-ascii?Q?d83PgV2v2tpsgtLQqUZxz7Mfm+GsTdeF/i9Te0Z0+J2v0dMV9ciuwO2DmA+4?=
 =?us-ascii?Q?IVaJvOecZQAAg+y38zPbj9Vr3MhX8ayE8rEG8GHJwDzqkHnPJ+yCSESPipHI?=
 =?us-ascii?Q?LGBo/aj0LDHrOn5upOchJjoDTo8kLXO5sEIOq+IdPGNvZon+VOeaaocEbqqQ?=
 =?us-ascii?Q?xtbgjjRcrUxFv+aJLSmgJPqrJvQMRm0Bz+uGPuqsUjnG3cviZXWu/ZBxQN6U?=
 =?us-ascii?Q?/MnNajTYpFLkqxMNfUZoig/VCILrsQipA0NDc9FSB0q264JxKWTMs4UY4i9R?=
 =?us-ascii?Q?CxDmHp0e81RJCMy/fLkHLl/2G6ee2oODsBg/Qo9Pw1G4WQ16gPhTmvkYlhvC?=
 =?us-ascii?Q?x/3Dye9/hEedTVaDTxWcUQ7NHzdHBdDrakMdyKMMnU7oYslkot+bZ9Sk8tTk?=
 =?us-ascii?Q?H+1nZjffklAyQsGGS040wvZmnrXH7iD7K9nQyoGzQmmEI/eiJy+fzxBHNoQR?=
 =?us-ascii?Q?dp1pQ+QTlkdqOU2L1RJxzaAKwNPzX9udqK45V1YF50qUwSSbknxskp6jQPpV?=
 =?us-ascii?Q?onNomZfZPI3wDeoXVL7+6TPlIeHvE6PY/r87PqcO1ZeKjULz3rS8yO4PLhh0?=
 =?us-ascii?Q?Pk2YOMrbSySk751Y7+jm2y23+bTJFyi3/OlxhjTx0FRXWzA4Et9pRvcfV+Vb?=
 =?us-ascii?Q?1UmCJR4ubrrrhRu1xShXYAwSi5WP4PsWKmS1/R9ngWs6OgukJukYQa/cja7u?=
 =?us-ascii?Q?vvsbiOQgxKS446JSL0+W/qMiGb2m5XMdz8d/biKWyMEw7DmSrlUtWgGEXD5a?=
 =?us-ascii?Q?EpXVL9G6hwDxJFgjrfFIdzcxuGNlFxeUlF8Bhyx6qhTMCA5WzQTIPqDZfdN+?=
 =?us-ascii?Q?6UZ0zznXm1xrQUxy/DX1sadclrlr5BQl3RcK3pEgLRrDr+pnGNj90xyYQYMt?=
 =?us-ascii?Q?cpHuRng10SPbiv0xFg6idkXk4NDbG6YcannzRV1jCLm1cYHEyRmCuXCjfBdd?=
 =?us-ascii?Q?7HizSxp3X4Q5cZK81LBpCN1X0Oht7maZaau8LyeXQYjbNVzvOp6+blXi5Zs6?=
 =?us-ascii?Q?2LaBouXwRgyJ/H7q1z//Gveps5fBskzTIsKBzW4Nw3bWxKXu/cQ/N7kRAGLR?=
 =?us-ascii?Q?pDRDgxHDt17OmNq62NKnRPtYB3HvS8pbtpLMq2DXwoRPPVkznaDwADOKL4dH?=
 =?us-ascii?Q?PXAWSsXRXes/tMvNo8rNIVkpVDrnQDxhKcT/uysitUBtXXnSA0Ezvil9O+YU?=
 =?us-ascii?Q?ly69EvBjpPnUtFoTmXekev9wuJExngAwqQDCAnh9xHY3kZlQuF79ME64vhks?=
 =?us-ascii?Q?1brOT7YabU6rGosCec09I7wYS9Ec5RKfxCpxEBjT2bKA/hdpxqD9D6ocImus?=
 =?us-ascii?Q?mNQDGVweBWeNpJs11tOR9ujOfVg9MTng/jrBfFRiRke5qf0dFcXvZP/vxSnw?=
 =?us-ascii?Q?30iPTj3WqVhZVhobNCCBuI9CqF/bzV5bYjJkfm/o8/gP+0ou4ZEipZng9q79?=
 =?us-ascii?Q?F2/WuQ+1I2kgcfgwRCSdH0y8tGY7QSTQPPP8AUMl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52823523-b2de-407b-34b5-08dbf01da849
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:57.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuWL+vEbX3flejtxDh/k2V2jlgA765Qa/9YRc15AyazrwzekWhJgWvUqkyEYgxIzit5r6bEzXsrLdkwOUwA3NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

mptcp_pm_remove_addrs_and_subflows() is only used in pm_netlink.c, it's
no longer used in pm_userspace.c any more since the commit 8b1c94da1e48
("mptcp: only send RM_ADDR in nl_cmd_remove"). So this patch changes it
to a static function.

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

