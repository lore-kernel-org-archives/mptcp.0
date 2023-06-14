Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928977F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBU4my6X6RvsH+3BAwQvlTTZIeMG7D1XkSAcZb/l5jA/mdA0ypbQYQTfJ2OSZvI5QH2PCly/tX0a5SASZ2+jdfKnvwuOIansU5+2wNex6y4H4zUMft75vUzRNaqpbLwIIjfV7AOA/vAX3vpNyWOog3V50+Vy/P8EW9HAAZOr8r9uiF3699M3/rRf5PYgjOLmwJEtXgJzDnijUy793tPSXTtml/A5iAGcuoEQvlptfAya5G2EyHy9hPR/SOLSptR5SazWH55jlkl2+3xjSnmebSNtfPuJP5hLkyQHwzHI6Crqk6Yq/1lR12DFU9M1yl2td9lS+f5/T/okgwVAtJSUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zsa2kJwr4t3ANO4D/e8L3StC5FXv+Urvkqex92PF14c=;
 b=fqvr5SmrJv1sCG8QioTlitCjAdsjjqH1Jn0hvEZGvZ2y4jN0FtGtV5W0oi7Yf4YekCjnInCoGr+cScCbLwMrfZYq/5uarVnkwutd8MCEoW6pil6qx0aSgf9cJs07RRhfFnyl/qnMEGtcoe/7tR6yiHOM5cj7rKglG+BRp3u3oajgOb0hJVDXLZ2mMmN+PLDu6Oc4YZBPyiQPwdlTftaSwmGHiLK0AdpafIQOX6091286sP42VqLGTJdr9FkQlzQuuuW0KMYqxGu4ywgqrT5JvyE0sc6Sx+8NuX+0/7ZpPfh4cq/uGC8OrMLnrA+aufvgawH/WxV55G9fl/qgqh6gyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zsa2kJwr4t3ANO4D/e8L3StC5FXv+Urvkqex92PF14c=;
 b=H8aB51QG4ZUnG6K/MznpljDyx0fTaNlgOMmAzj3ZrfURV6ZjnER0r9LSuoASiqaogGNOtTQD65AI9/U26AZSU4vh10J7I34oZPC5IcbBhUNzV2dHUmnNq7WPeU3srjS8lBeqhmC6+qCJfcvvMYiEVJMgcHNqb2sOxRvLJ4zJjglBrT4Y1WySdWNSvhMBcbwh+XqeZzdzQaimjs8fVF0+MDU0bQkfxWfmk2SLETGTEzBMG5sw6RtIGbhLoBzGcP9QsqxyEUCwdbPZSBG2FFYcg7jkXwSIlLoU3sBEMEzBGPEY2167iRWDhyi60KBCnFv2uSDObgEv5Cm+Ib8w4qnMHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 05/23] Squash to "mptcp: add scheduler wrappers"
Date: Wed, 14 Jun 2023 10:20:52 +0800
Message-Id: <256cf1d3f00f5577d10f885272f1725b3302bd62.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b4262f-a216-422b-a6b2-08db6c7e2fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zuz5bndHwKk2XDX9+5SZP/sjgJjpnC/aoAj+G8jxYXMDA/TGpNl1V1h26NbJ0eAAMC416maN8245UIK1NeMudDbiCdlMD+QRa0lNeTMrmi0ptg6LcecX9MUbTLvPktm8br8Kbn8tcpQY+XSdk7oWb4zJNdfEy1pmspKfTicKu1TQLJhyrPGzc4XWWnL3Ojv5Z0rd2+CT4l0ls6dxRmPfc9uDWScaNPHPL8ySsx6pxTPHnv5J/LYrvB7RqCZJh+VBUsWgJQVJhwEme2rIGCuTqdsrPeKoeHzk8PpOdaP5FfzGPk8DiOZr8kTr1GhCxCk+S3iaUqejpgabYzYx3owTmdc0dm1IL6Ag+rYl6+osKe8TZ6zRmkE8oTQeZVGSO5DBW7gWp5sDx3DyKHQPG6sGogYlRcf1c22DdC3y/eseM0inbONwzH7LCTjohRFvUnvsVPlhC33doDmO2u+Khk+8T2HkERbph3e0A3sm08x6rUqkt8/XPxSrCnV6UAevJNPilyHvFhTq9KAVm5kKVt1jo4Tl9oxgrgMKLFuw394SbBAZCpFpltJ1DxkaqUVr6qMA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hm5NpP4gCmkxhyKLVtSQlPhxt5TdhbeIYg0ossKO3vsXtt/sVWTRx0iyj5yP?=
 =?us-ascii?Q?Y+KxZFeresQSfNq7G7/ZAx0MWla0g3wu27Zkz9iyPucw1zZhp4bJ/L8sL2jL?=
 =?us-ascii?Q?e2ZBC/pPuyNsb8Fh/3TyufmLztvenV0rDxgpamVdJCRkXaB9VxIork3E65HH?=
 =?us-ascii?Q?qSjTjx2rmPciIFYvMdm7rtg1N7Tcw7AF0NZNu3EBCBNlHIHfV/9USAdtRsaP?=
 =?us-ascii?Q?wgnmkiZGy1z0PjePlDjbU2VqZ0IUVdjmpugb42hDWOkirAeP3TgCrp+doRgy?=
 =?us-ascii?Q?S4GamLt3BAtJiYuTmGCbSWl7Je20kd6yoBDLbhmBlgBuzJiofBH4CI2FYXuE?=
 =?us-ascii?Q?phb6qI5TyjlNK0qEtJWJmqnLbuolUGZMvPpN0wMauepauMRJkSw5yc0ul5wP?=
 =?us-ascii?Q?dTw/CISxxWoKZtmH6/zmcyAjSZKWnTLT9IuRK38qajxmPNVEWMDF7TN5NW0z?=
 =?us-ascii?Q?Bl+QGzw/WBPr48q5pT0PNGwhywEWMYMOEKVD6TpxFYlxLFZ//3bNcsqiN8qp?=
 =?us-ascii?Q?Xdk7euKkjR53WX0ShWkv9kBiHERwnCgA0IxAbSdbrWG+AolB+HkigHUSrNAp?=
 =?us-ascii?Q?/0NwvIx38XzAzceLLNFds1f7wnjTbsTo8pTtNmbCfLx4yPk8K4bchDSG5fIr?=
 =?us-ascii?Q?3kzJKoVQfcOvlR9aHvTB02FyGjWKaPW5l0qGhahOQqssAVJHIy5bMMiOTIlw?=
 =?us-ascii?Q?HBqHEeHZlqt8lSHca6KmSULydvVViuMEhYcgaCTmlWOSzF+TBPXlTcQESMjT?=
 =?us-ascii?Q?h66WBwXkOUCDkgE5rtZVe7nwUcnLrVfgmcSRHurggVVtx3AavGMfrW4gB/0F?=
 =?us-ascii?Q?hHW/9An5CuPnbaJSwKYnILwPPzi7BNpuIeXpCwR3CgpUw6e/OMcyB4sPAwNj?=
 =?us-ascii?Q?Cd51IawNzqyZ1nS4/M54gxmzVa32kF2twYzIg0W1eu/AXmjlz7czR9gcqp3M?=
 =?us-ascii?Q?BQlJMXrKvjIS3yTDBb30PA+kPMwUJnjRe1JyS/pFyK9KvQjIYrqHiDd5Rl7g?=
 =?us-ascii?Q?Q58S8lbOBXABoh2+oACkL2PGiApu2Jq968NGEOxoLqP9BhdQA64CfcMlSPc3?=
 =?us-ascii?Q?PMfGXBXhMIWXuZuHFiDj5eKXA3xvOElllr3GT1+5yQgnun7hou8C2AoijCpP?=
 =?us-ascii?Q?iXibMPJkNgVelHO3+BlWOVw1EYlOGzxb6T/7OCnmoSHBKMrPTiaNzPDK+r2f?=
 =?us-ascii?Q?MRe+XeqcoA15oeKM7xYaD6GHxP3dpx0lfQiIo03qccSSBbfdCWZrg+6Pg0dB?=
 =?us-ascii?Q?6jAn5WC2NCSb6JTFzUcwpOUif5E/2opKlJm0S7bTtfcV6pxZMN6igtNvmIuq?=
 =?us-ascii?Q?5GeJyphbhF0zyrTqLFxwkh2kQtxxhiMCzfdHfj01ZcaQkQo1TEhz34wA5YHz?=
 =?us-ascii?Q?2RGc1YGRl/8huY2UTztOnuwv5D3u3SHq6MHCZ9NVldyp8XoIv9txdAG8R7AQ?=
 =?us-ascii?Q?TfssEjZ4xzluFJWMVe9QwZkPpErAGocrezAQPOO9MI0Sp1cyjhqhjRyDWZ6e?=
 =?us-ascii?Q?b9mrahSVGQsi3I7hhi06tZpfYOXVOI4VXDaviCw6rfF46ksnzjkj0KDZHQqd?=
 =?us-ascii?Q?9vwXn7YjnehSAaFFwRsa8+djjztsaRhRbfnrfVlq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4262f-a216-422b-a6b2-08db6c7e2fc8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:22.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIuGMN/5g6nmeRJ0H3BtnBxSZ1aRH163sR2EBaClz6Qr31rbAhP4lwJtSZTtxyz7eXI25Sob4EXYbNagOBhS6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Add sched_data into mptcp_sock too.
Use msk->sched_data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4e42f52596d4..bda91399be49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,6 +314,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a15d7632abec..ca4bd53cf5d9 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -125,7 +125,6 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos)
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -155,15 +154,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data.reinject = false;
+	msk->sched->data_init(msk, &msk->sched_data);
+	return msk->sched->get_subflow(msk, &msk->sched_data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -186,7 +184,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data.reinject = true;
+	msk->sched->data_init(msk, &msk->sched_data);
+	return msk->sched->get_subflow(msk, &msk->sched_data);
 }
-- 
2.35.3

