Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CF7E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 09:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih72V6OvAWSYbpxdjMuWIfs3ou6JHdJMsuXSA3FLPHSqA8hg+I5AuZsatmLCAs6a1wcgJ8zgEmCxrZ/mbRaT0GSPfVAPeYdmQkKqm50Vhu2Ss1ZU1hsM+YJ08BSzJH6/DXZZae/aqoQrEmxoVC6OlRn/6ry0lYdrlzihV3EOKYsnu9wJYaGPL4FEpvy6H1jKu0O4ta8j/QJ8PW1GEyUKyjr7BHDDGiXVUy3dTY4ngKePVH+giB2YxnjSCRvn2/+yUowUFEf+EQ1V2hF0/0/dFzLpmGal4jjXDmwCGiauLFyFAouLgQQeRdDMTOHYlxIgynOCsPeJuk4R5O8Gc9Nyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCfSn5yZ5WJfk0XrZWUj0Sdu+dDr3kJGMNZjj4NJhzk=;
 b=T6JZsdFN6UHm0eM0f3iJ+HCSx+j74KrF6vGAoYD8QWoNVThf3FwTTM22NfYVR9K69M9/xdxDfU4TyVBhUdWX8gKJnONc51uNVLyrpE1QMP5vKuXmGhpjVx6LP+P+H3c7F7JYKMvfEX1QevB/JjgWDG1SaoGmHPV7GgUGwEegcSn/yBUBX2313OKdmyBQR67FapREZxU2AyjKqcCyncNCmno5trfkfB/jydCNOWkF+y6JHVtIl73njR+oR/7gzPmnWtxD9A5g3j+JHt7GT5i4OQQx/JkWegF49rZSNcqpge1gN4Cb8qpkLasmx1nvRyOLS2CHY2pIwWTfOMedKOyC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCfSn5yZ5WJfk0XrZWUj0Sdu+dDr3kJGMNZjj4NJhzk=;
 b=RMpttEhPz7rOG4LTUe++VVFwUuVSrgzhG499IJLpArez+COxDIOixKkZZUPHZar0C2g1WaNzBe7POCpvPnQiUOC0o5lufvrhYnjXcO6/ss6JrDPHcUHFZtxgo/kWykIGD8Rzrr3TjLvue2+jx7YRm9jU+oXks5J36XDE90YoWELAWlEnGPBhJxP4zu2//5ZYVnSkHlpdRvjutU6jQHHMkRtVe94gyRGkSEF+A9CQnT3ujpkypdfU7SDCe+F04Q4dBEnFkBrWvLAqElKlCzPzinBpOlir6DmQCIffE/AheNKg7Md2X409LExQ8/SvqF3jwOYM8ASvFZLhIBR/9ku/Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5739.eurprd04.prod.outlook.com (2603:10a6:10:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 09:11:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 09:11:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 2/5] mptcp: redundant subflows push pending
Date: Fri,  9 Sep 2022 17:11:33 +0800
Message-Id: <946c9ec14b547f75292884c03eee94bb05b6621c.1662714028.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1662714028.git.geliang.tang@suse.com>
References: <cover.1662714028.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efebfea-72c3-43a3-de9a-08da92434784
X-MS-TrafficTypeDiagnostic: DB8PR04MB5739:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pSIistM9M9IZj5LZeHqi/avuBOlGzYSlFJrL/v9T90vusN9jrPCzaH+27WuFVq2kpl6KaCfkmjz5Qz42ELar3XUcfm+uSB8HT++wA39UJ5uO2qKqQOG9MSwDNO8km7E7hPMrLiIHyb8J4hTcfptL6PAPW/qgmeyQj86b4m/ucVUnguE9+ZAmZovRM0Ge+m1AZjhtMjXIQqdDM+P586j1/ar9MoeDPwflre31FReCAJrpnRzXbhZZ7pmycwxLK0hjAhOaeGvtfhZl1aKERlNVfxz8sZc8ylUF+vD9rKKcCqy0+1teOR7NujD9A2PWaTiGxQNiGlWnTFHZKBQB8udCMv1FnVegg306KK2IyOGRqTGFZj9dROScFobnSxAMBQhkVc3rbKpBDud7mdtlYXJOVxzkC3C8EQKfxPFciUoYO4VFzWwiVcWKO02MsJ9Tlt+HJSAKDvq9nOJ9tYp0m79EVw1GV7nJWqPRqvC4LJTtWz/sS4tElv9dsWzI7imxi048K0SwT3h1whcfGoMscahBdD+wloDki0YTn9hZDa+CLk5S17A9JTWa8UGl03Gf3t+kYi6M6YPIgQ0fRcV+X2duz0uA6Q7bqs/QbuoupSb5hFQgR6Sf1W6L/MmDJwp0rZDLBAtLJvxdd44KSYsLgrbUszN3aldBmoq5bY9tNodit1XviWgP7E7X3a3jui1qa+96zKmILSvgJdk4yvFiqgrCfU96YzW+t+GnKmdXWDQEnvysOGKKWARI6LhTSdLWy903
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(39860400002)(136003)(366004)(2906002)(8676002)(186003)(107886003)(5660300002)(38100700002)(41300700001)(6666004)(8936002)(2616005)(86362001)(4326008)(83380400001)(44832011)(66476007)(66946007)(66556008)(36756003)(478600001)(6486002)(6916009)(6506007)(6512007)(26005)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fENIa7ZLBNXSXwD3IT8Mn/CDZAeWr23syhe6Aew6Q+b0Mq3tgsDx13CGffmZ?=
 =?us-ascii?Q?Iir+l0ivNl/M+v0JJv5SyePEmcAGn+sVT3YMo7eMA+kMudvVmE1RgrpRLidI?=
 =?us-ascii?Q?reVQDB4lvfweZjhug4kCEzWa51x4JesIs1BO8gvZkFyqx63kMHBlYTGWSlfW?=
 =?us-ascii?Q?Fl3pE9oO32nFsxLTmaKrpOQJ7OUdpS7ilV2nweOV4hsfPF8lsp9XncEKDH87?=
 =?us-ascii?Q?jZlqc7e0m38BxcG8ukXhpiW2drYV8urSSryJVZnJb+qCm3hUzrNvOstl7xl+?=
 =?us-ascii?Q?ift+mfPPkMr1eNns/pjn0RdEmjOasjz65BezzTMI5GmbqMNE6nEIjn1rU0Ma?=
 =?us-ascii?Q?5cS6+eV9TVLeDmQgIvx4ttIusW0ybcteV3lGO1WmectEDXsB0lggEcj5Ta7S?=
 =?us-ascii?Q?i2CwrzZlaIW5RmIo8LXf6PqpnYOW3dFmDxSA6wQ4pa+FeeRjFaj4fmQDGap/?=
 =?us-ascii?Q?YpUbUSXOODW5gdy1q6WVJ/7cGOt5l10wpRnk2iwQwji0aWcfJ6J61CU9mFv0?=
 =?us-ascii?Q?DlUU2PTNZj3dnIJOwuhznH2HZYFt2m1QzaUx1UIyxkU4kyNBYqAobx39sXcV?=
 =?us-ascii?Q?vohmP+uTfgVh4s2S8ZbK+knepce146iE1pK747aqSIi2tLQdhX8UmkRgfzPw?=
 =?us-ascii?Q?FVy7L1pulSyOfh/WD0z50cFg2NjWnoNpcv1kLIAPKHCw81wVCHY7YwMpkNcf?=
 =?us-ascii?Q?lTDUx+hFv9zb/zRw6OHGCIpwPnQx1x/ynSsGE/uVag7k1F6/Mh/YuT3BI1MW?=
 =?us-ascii?Q?VxtsqGIVGCBAew9vUonmrjKypAjp+lTWMfcXp6buHmRqhaoB9DW2Nmbq2tzx?=
 =?us-ascii?Q?80g1m9ORjqwD1sFaC/gDqcbBitch3oEIFQosXfhYQ0bCih/ix91eZmK3KHiI?=
 =?us-ascii?Q?JvdgPzsL7IDYnxvNd/skCq6HEQXaFxg5q7JXd4/3/5zeJTVaiOM0YQVRUBGw?=
 =?us-ascii?Q?qqn8Yz1UQTIJwsep8tnW+j8tj96NmkW5iaYxKRQVw0e5XP3JIHtz8M54UWlR?=
 =?us-ascii?Q?CWNc/r/F5s7Jss7fcYAIYyUAdPGE8YgXhvXc/JxrxWp9jReXLvnGno7NTOq8?=
 =?us-ascii?Q?eO0TjwHd22GZzu7Nz1OYSSH01U9Y3q0CBxCFUc19+uAukvaQv6/MujciJOCg?=
 =?us-ascii?Q?qb0eL892IHZqK5Rh/9brUnSygTYxOrFQ7D0e32Qwf22MzRsHArKSWHrrJ7QO?=
 =?us-ascii?Q?8vxdUxp31n8sDJCRa8FNcNN2dm1SrIR19034Slw8J1vXC1nPSp7Niwq5SB4s?=
 =?us-ascii?Q?ZYsdjStB95gsymXBGCvY7UAZ1BFdGq6sGtWL5wnNS2DHVPxI2aFwxxqPZwkT?=
 =?us-ascii?Q?RjZ966eEx3bQ4jLKXrH1eNucamjg+nu2z1A5Q6167rbyGbXBGj8wrhG8b/Ot?=
 =?us-ascii?Q?gEYfrT8mNqcXsBM5DOY9Kiw9lNzaeMeCB5zGLhv6D/9G5opDXdDkOjwxNptB?=
 =?us-ascii?Q?wQe66Vrn0v6RRlBZR40OTyxURyH6xb2DbhEmCA+Ie5PayAyWcTS6BBZ6le3z?=
 =?us-ascii?Q?5q2CPWmMIFOdUMj8ErJDEwAZMTaFbKUV0p/UKi/cyLQbKu1sMfXiOKhhhjuu?=
 =?us-ascii?Q?DBVjW7U0OU7l7q4x5XMrgEKiYsFvKmmHvZ85erUM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efebfea-72c3-43a3-de9a-08da92434784
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:11:28.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXPzb3YyEtN794BTEPQGntWeeCn0wCQ8uv9FJ9CS4CnwHqvRXQbJ0hTI5A9r9CgCnpN2NNIEBuIXqgS8v5Z8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5739

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 96 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h | 10 +++++
 2 files changed, 65 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8888de922475..be62126d7c63 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1530,61 +1530,75 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
+	struct mptcp_data_frag *dfrag, *last_dfrag = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
+	struct mptcp_subflow_context *subflow;
 	bool do_check_data_fin = false;
-	struct mptcp_data_frag *dfrag;
+	int last_sent = 0;
 	int len;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
+	if (!mptcp_sched_get_send(msk))
+		goto out;
 
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (!__mptcp_subflow_active(subflow))
+			continue;
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+		if (READ_ONCE(subflow->scheduled)) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			struct mptcp_sendmsg_info info = {
+				.flags = flags,
+			};
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
-				mptcp_push_release(ssk, &info);
+			dfrag = mptcp_send_head(sk);
+			if (!dfrag)
 				goto out;
-			}
 
-			do_check_data_fin = true;
-			info.sent += ret;
-			len -= ret;
+			lock_sock(ssk);
+
+			do {
+				info.sent = dfrag->already_sent;
+				info.limit = dfrag->data_len;
+				len = dfrag->data_len - dfrag->already_sent;
+				last_dfrag = dfrag;
+				last_sent = 0;
+				while (len > 0) {
+					int ret = 0;
+
+					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+					if (ret <= 0) {
+						if (ret == -EAGAIN)
+							continue;
+						mptcp_push_release(ssk, &info);
+						goto out;
+					}
+
+					do_check_data_fin = true;
+					info.sent += ret;
+					last_sent += ret;
+					len -= ret;
+				}
+			} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
+			mptcp_push_release(ssk, &info);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
+	}
 
-			mptcp_update_post_push(msk, dfrag, ret);
+	while((dfrag = mptcp_send_head(sk))) {
+		if (!last_dfrag || !last_sent)
+			goto out;
+
+		if (dfrag == last_dfrag) {
+			mptcp_update_post_push(msk, dfrag, last_sent);
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+			break;
 		}
+		dfrag->already_sent = dfrag->data_len;
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
-
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b6411285a0b2..149c1e007d5b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -358,6 +358,16 @@ static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_next_frag(struct sock *sk,
+						      struct mptcp_data_frag *cur)
+{
+	if (!cur)
+		return NULL;
+
+	return list_is_last(&cur->list, &mptcp_sk(sk)->rtx_queue) ? NULL :
+						     list_next_entry(cur, list);
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

