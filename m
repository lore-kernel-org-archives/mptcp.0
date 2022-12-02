Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A64257A
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 13:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StDqgpMXVUk13Ve/rXIrH+LYuUmrqJj/duvUXosRR6Xe3lZmxgVmavOzlR2+iQzroFQzc5l2L0XRFvDzDONiReWFKxAR/24iwsC9qeOKmAnLquKqO/vLCc9tUnGOhOioC2bfA6fBcnJ8GW1R19rXvuMXlfOSp5Tabz8FvhH4iHZTT+ciVdywE88KOC9YP1E08f0j9zCrD2nsgRt5xeTZvVhTL9bmf7e8aL/BFdAaJbtK5/Nz704rMec0ASUKmm+5oJsM1oun9UNwG4klg41/9B2PQeV6e08Sqh5zOTrDKQHw5kuYQyz8bg2kJYPpbMqR8/v94udz3EJtRN1vAc1+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz9q0gJnpVwfDpXUYlVftmGAroFYmhWCrjPWKzh9eho=;
 b=CYovyzk00XcqbvAGYuMglXrCtkGDlIynH2cSEtedoMMUpWD46TRbl8nZH8MzErzpeWErEFbziz/AnRrJWoQOKI4GfV/pQ04veQiRp4MuoMW2HwOizQFnu1kSc7n3CNdUeqH0LAkLecrKIa05VFzw+vSbUc78Rj9/MpH6q1RAbG/RLtHqJDQ4ntDGRdzcx4Hl9OnogabTiiCV1OlxiWP5duSeUxvUa2X2HaS4vr/UQD5exLWe/6pTnV+6Lo0ayJV7LPyIBAHcxo42vV1WzNLy/YuXjbwBcu5bM/ZqUxceBwEDWUFlF2rvsERUgCoxL2x9hUCCfYDWZqoQlZBSTySlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz9q0gJnpVwfDpXUYlVftmGAroFYmhWCrjPWKzh9eho=;
 b=Z71aRhX/Ee4eGxfcU9f9ZawO/626x6VZBQnNyH+vessatQHLgX4hmlKewd0yp2NI8uI/68wWsksYtd2GuIKMMfQKf9gbiuLZB7WtMGe53VK3QRhFH+NIPfqHVKLwijWimNS/dZAAIhK2Hi+X6x2RIlz+o4lHbqOvJ+jmczOOywFTUTGamLLshBZUnHer/2dKMBb2a+sMh7AOAjPVOi+XK5ijnZrP+ffvA6RWwLkKC3ecNrfeSFA0cIF4N5nfgRhqKG2kS0jjE/YNfW1rYnlEuMWVQzu2g9gPlhiDm9PnFDzTKaC0gf7ncHm8miIdFkrcrcZgO5/q80/IU6f95ETo+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 2 Dec
 2022 13:30:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 13:30:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v22 1/5] mptcp: add scheduler wrappers
Date: Fri,  2 Dec 2022 21:30:13 +0800
Message-Id: <7572b8c0a954b1336214b6b6b04393b7dc2c7404.1669987293.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669987293.git.geliang.tang@suse.com>
References: <cover.1669987293.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: dee4f970-9b99-4985-bab2-08dad4696396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U9YxDHnB5C6XozJYdY2zU1ECRqyZAbrqGsiJTwyOG7kQV/DcIMh73tDE+xX6WhAEt/8pgyRaTJC0DPeSczPg6DcYs6kTJxyF/9yl1xLUPfvYivTJoIkaLNdAJmxuUvqfzBqwEv/BRLGhBmyZCx/ENjhIKU0LTjKTQ5ObRJ5B2nrn+fx5UB50S6CCySQOL/Oie8nteDokzqIW3DL4HnSNxMjyMwdhNJzKkVGwOiIgZhK7pg0/cMbCVa7bp4ynf/cyhk1HIhEWn+Lj7ZVyRCS2ZzGA+OUHrEGPTaQPdMD/6nV3AaHfPvpSY8nKKnGyg0AspfVH1wS4PvRxw00MY803d8st5mEEGflVApkwtydNQkew6iEHNreKnLmbArKDLbZ4ScH+9UENTqfmcRp6sGdjyX/WsZP6Uv6g1KxiKFvZ3FBVsf8mvZLDQ5MgcpvoAgIQoEhJHhzBxrGeE6eapHOZpTbS1nK3aCaotq6JB4r8/GohJS5Bv2M1D1BHE4fqQQ6dTXGG7/qVwwimENa3CtQXHpQ/jTUmh86sK2Fuwb1bZi2l5i0kEwE4eMTxNf8lY+FZ2iybuTF980XP9o1KkpwXUoX+QVTy7raJ86hHbElj3AO5uXDLRXRHTp5eCxbzpi7fA3FQsffTUXQPaBjhQ71Drw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(44832011)(2906002)(36756003)(316002)(83380400001)(6916009)(6486002)(8936002)(478600001)(6666004)(107886003)(66476007)(66946007)(5660300002)(2616005)(4326008)(41300700001)(8676002)(66556008)(6506007)(86362001)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QB1Bj5LaVgBFnGnT0o03ZyI0lo+r44HCtvA+B96A8iKwrWr1ibq0hz8qShuW?=
 =?us-ascii?Q?7D7rq+5ZmoPUzR4R7ZTE3jDajDi5vhILY4cAeaRELFCBaYAEgXSZJ5Hdv9Bg?=
 =?us-ascii?Q?82sOBm8nu1ikd7zi0OwTeoldG9hmKUoo45FZmD18eKXFSUr5nCtiPAIiYCJP?=
 =?us-ascii?Q?P4xAfYD93Hr/pMzKaYhsnjJLYwinnB7qiL0x17EFLSTqu2H9RGBVFouCraLb?=
 =?us-ascii?Q?d1vglKGse/dyL3cbix8cydaJtUdYAWG78NMfjOWakWA+ZYvVKFVcXcwf+dCs?=
 =?us-ascii?Q?2kMKzbLiLRmYOmJSIiSh2S9QOLCCZH+aoEFhcgtp5PS/sTOYEI9zxqEoBuwF?=
 =?us-ascii?Q?EP2AmdPRwEuBtVZtvI3whjG2Qu95jtc0dL36PoMOL0+I526vJVx07pZdRU0T?=
 =?us-ascii?Q?Qo4K+vYwOoMUiDseLnsglsaecHNa8Dnwx4PuTD86s2zxHHALoqt+OvolTOpo?=
 =?us-ascii?Q?5pZrFU0XpA7rAky5cbi7essOzaSy3wv1xC2cUHYTV/rTMWnd8dAU6tI5hn6h?=
 =?us-ascii?Q?U5UZzPTJNU/oUquUtTC/B7R3TxonOa5VgL8yaqxazsekOgaNgpN8AgCxmEDr?=
 =?us-ascii?Q?10x0QA1Wqrpf5rw1sJKGoNsUP8LmJGGBoCUcA2SN8iJBaw+yUIFpqzuWPERF?=
 =?us-ascii?Q?lyRaqnQNAtCwLsT8Uk5XpJawLZa+Xd8MKPKewxUVAE1xI94IkPYIjniTbZ4W?=
 =?us-ascii?Q?soUwK/yua9dTHOdlFK9JCGFPI3ZgaHs+TVPgwREWqfhX5vIkSbB4vuEwSu/F?=
 =?us-ascii?Q?NgZzeEVRFcX+nrUwP7zqXa2evFFbGqOv2IeM4jJ9wy9R5sihsE+cuFQQIArU?=
 =?us-ascii?Q?LCsUvFVwlQujrrgUG6QyGHxAgl1pt9vkpB/jWbq059IteN8+UxTB6F1gHjDX?=
 =?us-ascii?Q?z8MEUMhhl/DMJPoV7TG0Hr1lfO6gk1p1dvgtjSBnjoTXqkwDA09qLURdbLGF?=
 =?us-ascii?Q?VN+QhLI3Dp9xYPuEK8Y6dJajSt5B5qP4TXDc50JhD8hoXy+W2xfTpIoP5UFM?=
 =?us-ascii?Q?nexzMARFzkvrKl4mBz+ThQXehwQ/StAKM/ssnyMtVVL5xU/a0mjMKxFt98sY?=
 =?us-ascii?Q?tI3U5le4SVdSo2UIeGnb/gboZnkX0292BFAolQzvsKKo+TqWT7wuqG4oW8cx?=
 =?us-ascii?Q?948QQb6FMmMFZ3ccjEP6/KyrV4bLNqo/RobVEUvZzutRxPjSHQ5VAKBmdtVN?=
 =?us-ascii?Q?EW4kanrDWLz8WZF1qIr+G1Xq18P1cXfspmAPpBNN4gi8mkJBzn5W+SxRSErh?=
 =?us-ascii?Q?wfWtPwhcjAil5VOALKjQsmcc6VTW80+lygn8ZZ5ygAJ20uhnUyqi1cFNJjhZ?=
 =?us-ascii?Q?zGNs7EFdWzpz2Vz33OE3U2ayX9SiGJnef1khp8mBwkU2upFT/yLsYMh5YQR3?=
 =?us-ascii?Q?VlFglrgCjpSKDYtTHOJteAxLPe2Yr17ePbk2OHfqoRmoGO3rImKIa41lXj1j?=
 =?us-ascii?Q?g8RfTUdebS+W+YtiPW0aHLfFdh+kV9NEcG7lCmiA6Oyv2PovuoA4jTOQEMSX?=
 =?us-ascii?Q?rEWZctpGvio/zhPEsBFL5LbyoxpZuHl9sg6zHAzpVkcKJVSppKYBj9PBoIFh?=
 =?us-ascii?Q?pOQxhC6bkL052aJI8vHM6m2VPKD9ILUcEd5fi5UVEq/HWZAjx1AjvdMOUWsu?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee4f970-9b99-4985-bab2-08dad4696396
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 13:30:33.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q81RpIfcTcW7ZUPV+sAEdB/WOmdVzc6I4DOHpzKKnD2GsPW1rUn6AjD3ATsjjMJwVjB2EZ37FS2wcmVJEIIvng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99f5e51d5ca4..d8ad68dd504a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1397,7 +1397,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2213,7 +2213,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 224f03a899c5..adfb758a842f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..c4006f142f10 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,53 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

