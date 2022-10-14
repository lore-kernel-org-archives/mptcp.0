Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FA20F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5S8XCYNdKoh2Q7UPLG0bItMGzkUx4XKi4+1ZutWa9PRDQ3aNgBtDOvLSilr+52+MQ3SAOK2bInGyi5OW/F4NLVsjZqdwRaem0hLI0OpqkgND5wKxkEMVsu1+idD/lpsoML6pXhi8U4EDGAE830tXwvreySz7Zbm7aYwJfslBCaVXIgwZGwofNiFcGmhtrty/VKmCKlos90ZurOqxna7F+dX2I4v4BpOHk4fsQPocYJSWWxzfsfkEVQ2wzi485fRDzqPx4exdzh42RxH/DQGnRShH8mqXE/n8F8zYFbvu1sJlHldnpeI9cCH6JGsGGW/9x8/uJ36WgUDMWBHiwnuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5ixfVJ30rpvLembGJ6htiyuEGZ6/7aLsXoqdMEApx0=;
 b=Pr6hb1o49I1/xx/Mg2lUZWyo9Qm6D61g1nogAQOjL1nWI1QrgXlNtK3vTmHGJfIULAYSriNYQiEABqmV8eLOJ8ggTAEl5gC/odvgG2QPd9BwfHdVjRATOWYaF2tgXBnC28oFpUsFssU5T5dPKpwqOVV8z0dv50OQ8AJ5G1L3kfwEjdpI1RrgD9g25sz/mu43mUqhzBJMX3+3HKns3qo1NR6rIze98Q1qM38zo3oqANSahxQx5FbJfujw9x5ICAkc55u9fc+8OL5LUNQxe95m+6VInDQOab4FvUy/uc7yaezEX/PCrf7aavgIkYTL0mI2wPiw/Ws14DetMEBdKD4uFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5ixfVJ30rpvLembGJ6htiyuEGZ6/7aLsXoqdMEApx0=;
 b=du5tU9t42CwdILH9Oh7HYs70of7h3BgN9e3/m5o1QZlI4jhQnt9m0+CB44FgFfc7/1s3Z1dpexfsfdvieogd4dxxTjirg8y6YemeQI1tGvvNBmYQ5sqPpF4Ek6ZLwO8NrrKF6nvv4P56FJLnjCr9J7yuSEM56H62O1pzGgqAUX0XWUBYupbY3bqihK4dZpR9GqfT0j8ZmtvJ6n2lg6ko/BUkFueoBziWRf+zcejk4lt3o8VZczYvZnJcWSeP4Jmn+M2/cqy/xZaEHF27rjDi2d/1GDPrqePok06IoKrC2DXlacdv8AIzULiabgzK5mz143ggjI2SM/NIsE1A+vaLjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:33:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:33:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 04/15] mptcp: change 'first' as a parameter
Date: Fri, 14 Oct 2022 21:32:11 +0800
Message-Id: <5bf3681d13de5577e2ae7b086a3a4a1ab1797444.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:404:a6::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f068c73-c34b-4644-ae78-08daade8a8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4b8lwiUQ8mViga6DiRKaSc0S9JdjXNIFNMk4/TrPuaX30PzEK840aYrz8ibyIClI1IGb7L+crjDEbGiNooR3QBdFWXuQ9UHd6OA6yAbs/+c5G8db0Mp9C4cIIXZI2q0FXzw7GdW7kIoCE3csqu+H2O/WtVLmsGGtO4/uqV1RZyrKDvd1EwNVnCqDXmlvKP5BUjqJWi5DjC3bRs/+/ltZwg+eIwLXP3MK1LfNr7AMksL2t4n7NMI3gCuLEbixyRfe1naW19i/qgL0XpB9cBdxlulJzYJNZjEJEk33+kNWdpV3zwIU7rnY9ELjkDtJKPDppumm2+asYhjVMApthizHxthban78vynVFfHZyPUx5tLi+xAqu8X4qyyaURUPD2UlRxGp5R70HBFMXPBrnKAMMdMmuFLzf826JrOI+uszRB+kN2Z9FE0x+X0LjDNFzVxjQhnNlube8CsvUaSF32hTFAg121VxLAuZmT6xsnDphy8/Lw1lMPxjEZpExosLIz8T9ccHeXQOct6YH5hWE6MadByLqWVQeNwwGkBmkyLE2Ew7rfROSL99HYXGoGei6sVz67lGnG1l8oaipzt9pa01DM78s/5GsGHwjzSiXZg6UTuNKu1ij69OLpqturgn9MUbgQfdEwD+gLwz1tgEHwtCppv+JekhI1P4KSsfw4OwtF7M76ZwCVldWf/ZyGZANbEOQ7SexaKyOuCVyCdTPArNFArIbHNwZuovnlCuVbfo2sThopOQBc1w7zgSH4/XRZHb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(66899015)(26005)(107886003)(8936002)(6666004)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDQtUkHmgHhqk5JuOHjeziDprLLrGH2NdF1Twb0UeWJiz/uj8ZRGQFJZsJvW?=
 =?us-ascii?Q?ZrM0cjcQt3m095A6Xgf2uFkW0EUTZpUCQaVhhGwULOderrncjyg67SEv3azq?=
 =?us-ascii?Q?02ff3P1zQlbtiSdAXLfdC2BnhlIUr/l1iRu2Pih8A01lQ3dThHlPYgGVi/uN?=
 =?us-ascii?Q?2ZnJlN79lGrFKDIMYvVLuGzbWlAb8rP8Gy9Ywjr03GxRDZhufDqh8h72ReZm?=
 =?us-ascii?Q?Cn3vJQx1JDysbpGwHD388eIeXVlwFviUp6heoHi4AciYTJ5GCZezQgJw5+No?=
 =?us-ascii?Q?eovboH8epUIcmzq9rMpTEG9gmlRpr2UT+S+r7xjK1KyVDH4n7acjoQPGiyfj?=
 =?us-ascii?Q?JlBjxPTHJZIs6RT0Xfhps3WRj80Rv8dX/1WdHHEijfFiUcjHrUmi6qeCaeDE?=
 =?us-ascii?Q?TFbazbZbwjvRWYOp4leF3Yr28SjKFttSEQnhiBh3TZEFPchKSO0oMgPRpQTF?=
 =?us-ascii?Q?tMs4Zz9Oan2y7yt3ZZOZ7tYmLKZR6abyUkEngd+g60oD/cqtWvMYhJfhmpjD?=
 =?us-ascii?Q?PvawIa1kdAgN7UppWXMaw0CiY3W8Ky+QEWIMG+5iBMlSF7LzGXdGjVvHAlvn?=
 =?us-ascii?Q?0wgbvo/nDBcY3H8gJhg1h+unK5uZ9hhiAll7Li7Ocgc/MxJqPq2YFceM7Apf?=
 =?us-ascii?Q?a/nCP+mpp2vdE2Y1BgcmeLqYNBlPQVqwZkDlv/50OkVlYMnn1aG2lLNZh+Cp?=
 =?us-ascii?Q?6SWVdTMpD4Tq2NXT0ewpE09j8OjLyTxi0JJ5C40kD21oAaTtkDsHtHWOPO/y?=
 =?us-ascii?Q?zfouPFEgxY2KYk9A3HXBaUXvXwyN+IKV7yt84DT/Ku8ZD3kI3U4x7tVYup9z?=
 =?us-ascii?Q?0wfBMSMQGrJtvAlOP6WUhKlF1SlO8u0uMsCzFIsLPJ5ub30MRZ07yqw6XoKn?=
 =?us-ascii?Q?bMnXGsTYsJ3HmsxbA8h2YYHD0vY8yYC8UZxRACnJHzzdpaYZu2PnatWkFhxV?=
 =?us-ascii?Q?VTcVAsFDhXe1wCIME7UJo0hh7BedPSbemUspWQnd+bpd7GKXSmgsZHfrKyED?=
 =?us-ascii?Q?IfnKMMEbNOUkXMptZ/ZBmwONDYEm9qZ9zmC38aMBQKnbGITVuLt/r2LKsR+m?=
 =?us-ascii?Q?BgnHUMTXctA2gXOPyzUikOsztUbEnObRS+8quq/sYiVTjjBSicTI5fHoURff?=
 =?us-ascii?Q?/aPPYhcB5fB8LL5rarP/cV6zF9SbhJQPAXZ3LMnYOUYg5aZ70Gk1Cae8ysV4?=
 =?us-ascii?Q?zZeZNf+2oBHju6mbNtifAUnDcLZ0TpNFYrCqacVflrZwiph8Dkd7QOt5wzgm?=
 =?us-ascii?Q?CxxDr2hhvdXMLL5vbkFm9xKQl+tRQekKkQ9+ia2ig17kv6/a387+tP/JBxvV?=
 =?us-ascii?Q?rpE9jAuBMS71N95BviC9KsZDuWNipmbFHYmHG1V/TsbT+xaiC1ZXSnoiu4pi?=
 =?us-ascii?Q?n6Oh6VlCIEW9alb9lMLwy3j5p1kCRr/L8qhzAraQdG+9fzolhkLsi1kCKqWk?=
 =?us-ascii?Q?j/B5EQipdES1KwwDmoOJvEteJFKR4MHt8piJRHXy9YRaNMiBOsC/iUDKBvcy?=
 =?us-ascii?Q?ECWMp0L1/hX7ZI1+i8/QAyoOe1YbSsdTSHrFUO7K2/1kLiUuRK/ulnZoIiOC?=
 =?us-ascii?Q?yn8saKyUXkzpi2pXV86oqckgNOsyHb/ZnE/wDGLAyl6WT3+EBweOE+xR/EQn?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f068c73-c34b-4644-ae78-08daade8a8ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:20.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viNaBTCjGeM4ENb55QP0gkbfKhNWLYVqVqNqooZw3fzOGqMKzgnCkLfgM4nt43FQGyi2u9gyPNpxbvYzZ2zcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new parameter named 'first' for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
function __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 989708e85779..c807220277e1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1602,7 +1602,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		__mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -1611,7 +1611,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1621,8 +1620,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
+			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
@@ -3212,16 +3210,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk, false);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
@@ -3312,7 +3304,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
-			__mptcp_subflow_push_pending(sk, ssk);
+			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
-- 
2.35.3

