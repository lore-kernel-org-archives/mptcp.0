Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5510E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVPpMs/9hbiMzXjgAfJLlfD61aFuP2jOnDmzwrdMMbuwjq9Dsn8/L0tYMS6rJOPle6wGSOH8th7jZCKpdBULzdFAWJdOHvlFOE/vjLGV8OTJFPQpYaO5QuVL6JiQux/VlFML6pGQoiJGI5wbounbtyq+HbTfYRYuVfSXlXC+Px9hwy6aF0IKacikLW2C0wXk03hUQdaWTaN66VRqhM7Kt+VQCTXSzZ+lZb9hrB03U8nhCcu+touUg3iMBiu6+6DEuQpqMPGe5XYjWoG5d3TB8JhbE+CFBhmIpzJD6S+XAt4Y0AVUzsD65HjnapiqYPnmStVltvcBWB4RL5ssJK8WlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvtzqBLCPAvfs/X41u0wdhO3mZHbgJgkIHqahvuRGIo=;
 b=RredMvfvuFl+2s0+p5dbyvC87fYCuWGUaj+SWrgB+H9o23wWPJsmV9M7JV50QKCFuBeF20XSAHE1/oOwX0SgF7HyUd7UTR6B0qG/kFxyu7eC+tNYLFRvI4yoYpntoDoQn2fUpdI94ezGYZxvhK6ezT+7oQOll/T54Oj7wwFAsEr8Qadg+XPjYdfA42Giq3FhP7cOulQjhMHFZ6ot6/RyJSyTaBr/zEIH3sXhanNWw+0TYrV5FNo28Is6fSliRYwyLBcDBwrzsH02mn6soSBmS2SYOTUC+OHoVG0DwyXzKSGgDBKZeVuycOm7zqcidJJj5PZpzR0li+RTP4iYsGksUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvtzqBLCPAvfs/X41u0wdhO3mZHbgJgkIHqahvuRGIo=;
 b=cY4Q+9HPYu6GPnQG9YIV/JW7DH4rY6STDS6zK3eV3ZH4C1BWbgiMVATUqwrZ6fLQG1NCXzfNkKBLTG6Y9Kl68BCjQTbhWYVHNTRvzf/mAyMpkfMlFmsGx10QxaJj2aGf4mN3uDVNp3pd6J/ariy3hwXRFSJ+tPuu4UzQTTVIdbGb8ohQCiQUR+YSTV1RtGxYt2nXyvLFPF43/0jS3XwTF0b0Lg2uQL86tEGoW4kSTSeq6qyt23PhDZ+/2BnLp6Cr6s7FEGI1tNBEvVNqM31JglX477rccMT0+BwiwVkJAhM4PhZS1aAYAToq36yQgFMl4b0HGifFaYF06lZM4n2FzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:03:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:03:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/2] mptcp: update mptcp_push_release
Date: Sun, 11 Dec 2022 10:03:02 +0800
Message-Id: <514fef04b316a78141427871827a65046256e93c.1670724098.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670724098.git.geliang.tang@suse.com>
References: <cover.1670724098.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 617c4ac0-176b-4cff-81f3-08dadb1bd76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y8zjtTDHWDiQcS721wlRxjvAAdz+bVg+0QfA1C2PscKfcpfUByu0jZ4fW9oNLiPn+G+JMmbyeOkDxPeU+30Hh/OtSQoXhnZBC4z0CNWlgEUrsI3t0Zuh2YnOcDtf6YSVgwlMYyYpdItkCPawjashfE81mBDenkmMbzf+9Tw1YcPVgnCUDR6DB98+KpiRsLXuPS+l2LiYz0ArnzDGyuVvrTJqghP1fKFkajpUqziKIopzAxcCWGXs0e/3bVyaA36iqamyGar7fEOJ+8u+qb+rATpO+HieZ42dYuQBv390lK+FVJJiVTN6HObJK1XfgdUQ2qbsrM7bIQvOsD4gPiyiACwc3xG/j7ncGZEJvwzzAZsFwvGdE7jcIoxNaRKlTUeSlHs/YMmdRNOVruYhHfk9UYR4QYHX22RSNFrboNeqfVit6cptKL3BuV+ZX+Xq+jf1zh3d6ejWlkCxgM9BMRhLbhotc2em+wlVzf6txmZaj2Ku2HJISz554hJtMvqGXQybo4shTzYuF2TYVXW4vHnxNIv/XkmuXTOV6l/sTom9337WmnMn/RVqS45GORWC+NEBoEtvpQOlpBDzPA41UQ438gkxQTJd9SUqCvtBWEbo488WMraKlzTjzWxfWGZUdKIHxPyPoDsQncCWYki+yGDOPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bmmBRKGhNFGJRFW5/dUfwZV5oi9B/YpcT4TYvncPEiOJaSNMLqeFGUTlgd1X?=
 =?us-ascii?Q?H+XjcYIrVxePSVvqAidnFRdUFFCsk7qCt2kfuIHpyuxFOp8TvvpvDJ2+Tuya?=
 =?us-ascii?Q?zuBoFX6tK/XXcmHJ90GKere79YS184Q9GJJoIS9Qs2Igqt8fDeKxWHSWjaGB?=
 =?us-ascii?Q?8kfvFPXlK6aYDzMCxeIGdFMFPdO4e5IQ+Et3a/apq2s6czuw6ak4x5KjylQG?=
 =?us-ascii?Q?IFpmo1MmCRtbQivgZwv75fE96mjeWPEhqsq5/fKymtAFCdjKYiXwT1tdqLp4?=
 =?us-ascii?Q?TyBKBRFRu5oC9DvQ9QaZIMOCOYIGG8JRmi+b4685wkeJOC6IbN2KiY/sWesp?=
 =?us-ascii?Q?mSnECa9e35JAtnj/61GF9ydndF3pFrdVZAZ9WoQ5phNit0/TMni71+FEfUR0?=
 =?us-ascii?Q?txmJ6Nkrp7BmcuARXCQgcoUtGN2EnMjg0ksPZc1AOobI7Oh1QLkRaS/9+tQ+?=
 =?us-ascii?Q?7KRL/GNQR7GbMC0BcCWxs+8Tx1h9+2McqSjX0sm1mkAvt4LLiRdj7l2K08vf?=
 =?us-ascii?Q?KAE1ADMhmrEsdbl00MLurJDGy7rCDcKcqmiSlNTOWT/tu7S0snAKlII3CTQk?=
 =?us-ascii?Q?7X0r8PCP5WwcSk4jbDs2bQ+mZyum/nYM4fItz07wsuKu44MzBguPEdH8ppBa?=
 =?us-ascii?Q?EuBMmc/7ZQsXq/cN+WfYu6/jXZRKJhuo7c4S7Ekllyo3aDhrXYJVZQy4ek2M?=
 =?us-ascii?Q?IpUImjwOdXTzmvlRwW4AL053NK+U8H94V1rAy12gcUc5/zfCK4xqk0Ct+/xh?=
 =?us-ascii?Q?2aeOQfSWa66q2DVphRDZVnPGdsxTKcdODY+lJ0eRw5BxtTKS86NIeb8geTnY?=
 =?us-ascii?Q?+SaT8yB/x5dJUZYU1QaL7KQ0Qbhi3ERxTXuo2DTiWfjNIVvCYhZgs5PKJhEC?=
 =?us-ascii?Q?/gg9CKCvuSaUxko2N0oama7S/xN4lNLphzWSxJHf7ZU4mEG2Epyw21XqgLvA?=
 =?us-ascii?Q?Lv/gGCy7Ff3yV7meMODYnSNHhtm/aSyk9EmS66UqBLE3VQN5mCt8o8z5GlhR?=
 =?us-ascii?Q?FNJ7D0Sb5rASIcDXRxv5wzWB9RnkHe39Yd/SkdmKhR1SgTQknwJGZnxsCWOv?=
 =?us-ascii?Q?fP/ytgWqy5z5jukmaKm3Ri3z4Mw2yPD7wJ+gvO7GRAoWPEnW+CjhMVNV6FNg?=
 =?us-ascii?Q?AYzKkQCeKLOmSJnLLIrLzAO0+qFCWX/BLA64yO1id82U8QiEA6nCkmDZ//8c?=
 =?us-ascii?Q?/RIiqGrWLuk1j6iZ2x2XEFkS3ywdwotIZsHY3TaFB6Acf6EKVD6VI/lkcDkK?=
 =?us-ascii?Q?WVHdfDXQd1F6kcuja1K/pXOGh62zfyigUac98jRHXiw8ygw5tZVzBRS0KvMN?=
 =?us-ascii?Q?VG7+dk8VlM0jYt3jv7sADrTSzEe1SOdiaUsVyQSXN7WSby2mF8AEu1JGWTqA?=
 =?us-ascii?Q?SvQIggbZJjuszQ5uMrXUqXjZG0ea9Y63rOfTdW5m2HzN9QfRcRiHsCetgha3?=
 =?us-ascii?Q?PBu1fYXXesCv2QQWFGKnQe330ZujfmHQ4NnIsaqNRNR0HfTFKmO5xWJhoRGS?=
 =?us-ascii?Q?BdfAgA7X7+YEmlwQdWefLIVwHJ+d/FzUguirtAyBsaxRNvvtg+DxTM/M8rRG?=
 =?us-ascii?Q?bF8Jr72+coLjmXwJ6r31jADL3HIgAq/pucN3QxjnraOxnnO8RKNRvn31lokg?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617c4ac0-176b-4cff-81f3-08dadb1bd76b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:03:05.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY/F9az6COfPQLXI3HPEmGzALp7YD82HMgSwKLZya1nRIxB4VZPXZ1DqShMd6PafF/8tKzk5CTdUlsu5Ie+t2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

This patch moves the NULL pointer check into mptcp_push_release(). Also
add a new parameter 'push' for it to set whether to invoke tcp_push in
it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b3e5d30adbe1..2342b9469181 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1470,9 +1470,17 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
+static void mptcp_push_release(struct sock *ssk,
+			       struct mptcp_sendmsg_info *info,
+			       bool push)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (!ssk)
+		return;
+
+	if (push) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+	}
 	release_sock(ssk);
 }
 
@@ -1578,8 +1586,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					/* First check. If the ssk has changed since
 					 * the last round, release prev_ssk
 					 */
-					if (prev_ssk)
-						mptcp_push_release(prev_ssk, &info);
+					mptcp_push_release(prev_ssk, &info, do_check_data_fin);
 
 					/* Need to lock the new subflow only if different
 					 * from the previous one, otherwise we are still
@@ -1605,8 +1612,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	mptcp_push_release(ssk, &info, do_check_data_fin);
 
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
-- 
2.35.3

