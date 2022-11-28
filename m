Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983E364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAZMaRfn1g7Xmekin/LKQd08V6eJV/U+M05dyUb/4FGOcUNmfJ9wy0ocbb52/U8wWKK6e0YKYa54fBZIYLwippiplTlo/MRQSrewSklDUjEiQDDkS+SzL+WUDM/PLAD9AaC/V7s5F+s28tVNS/pZZL3FhjESjzkrIPRzrJABD9G89vqvbS7uMgfmih85HOy2ABTkbk1OHKdPbw+RwkBGyJesLSXQFRpPx9LlAU8+FTtLoPEUW0akmlD8Hksf9X7jQWg6wUNgjy8A4vqawq1u73zAgrQhy5GNImpWXfZ3cf9zMFmR2XIW/ED4GdLH0DgUNR8jdIYrfVCK1IsFT+l7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vwvLJkNcFgD/dBTwcZN0yQz9qE9AEawGesbrkUu3/8=;
 b=OjGYn3TVjkUzcaLarhudbpM7P+JdxwtHe6A3/Kd66WCLB1azbpMTejnLgihAywQzcMZaKeoIX7exHOkbTNIqyyFjXpDOJYxEFsTuLLe5hDlVv9wTeoXOozScg+6yJAqBZbEQ8L87H51rDVlIr7XiMPzJK5ocUIsiwzQUR0hXqJgidsaQkX1+1O2Z4PX6tTHVneHEdA4DUkzAZFea+bxT46zJlQTEoo804X1CkXJLkKgT3smrhQ4T4+2aWo/eCdjtuNOUAfEOO/eAtfW3oozvSsPLMa0puAOSxL0Xio/sfdKQpeRmjbpL+EyY4IPnU6gJ5OngfCnpE8tKRU9dpJTS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vwvLJkNcFgD/dBTwcZN0yQz9qE9AEawGesbrkUu3/8=;
 b=KZET1ONO5iqQ8gkh0i7caE2htyekxZ/6asvN/ScIazH1fpL+dbefw3zr5eU2OizrJ9SJQ0rDmKcufMPyTSC75LC6OgBnLH4IT86LgUbETeUkIEahlMX7zHpA2CunkJ1jDZMyxx6ENGYipxJQ5h0un1uXlx4q0JiH/IHiLD7oW5XRnGG889FoiaOeD+iaGns3vtx8hhnd9h7ZL72rsiIctVWy02v2IDm5umVKmnbBjOQXKO3N0fuX5jS9fxG9kF9j3YxzyW4S5PS3ky+W5Dfzr+F9Tb7HgGwwoLzvWAGoHESjyl82+Yqm++XyWnimEUHtEi3h+IU14sLbzZ+WHrTHOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:23:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:23:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 4/7] mptcp: retrans for redundant sends
Date: Mon, 28 Nov 2022 11:24:00 +0800
Message-Id: <5ccf6d7e7d997261a49f63b4138282615d05eab2.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669605531.git.geliang.tang@suse.com>
References: <cover.1669605531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c26a4c-092d-41a3-d51f-08dad0effd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I8Emak98QW77TNrcejKwtzn00cJTYBsGACeVUmd4k4DNbfHjr6WKIknXOYeC4G6dD6WFairNUlUc/A4RdrZfoxJ0AAQoDFCr0BkaYaqUtgowN9s8xRE2D3qJmYe7VmqFrFY8Cogqj46w3lXBJ9/ScM5TGMMmx3gxjN86SVJsLHIVZjeHlLnmZdOvLAelz7pabaUopmy3Wpg0ulSrcI00MtLWU/UXm4ZhHRFuHhdO/lqNAOyw25Oob/eHEg1l5KuJnj6ChJUarV1P2FftVEHrnbGad4lQrDlFUsve/AlGpYQYz113/mnP+b/+SsuyByl86A0ehaKKwLCTb3eZ9HeMXayjoPUAV8vTyp7WpMhoah+LGn7mafplkzvBOZqPFFYPRh1f1JQSlb9JAgWXpHQkHPyLhFLsdsLRkIibGdupBfwaaiuh6diA0lIBt6tZ1y0B1A88ZL5yCSWpRlrqVonNxK2iUpzJElJ2zy9Acke71BEGHTI/Bc5wLP/sTAnd1jE5dcJ4jdLJMxJ6xtCU7Rvlw4VZWGwY/tAhEsN1dj6H8pwM3lMgmtuxeWXkCw45/zkDgPZHRL7DbkOlEySUW++v47RVmM1zukIVP5Eo5Hp8eFNxSXI5rQ26rw5GtdGyWU82EYr+QU2TX0k46mAWqmnXsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(6666004)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9iE4Wn/DgN5NU6z9JieBCCikdTjozmXppdVWx0l9EAEahVf6ERRwBYQUpfPt?=
 =?us-ascii?Q?d5xd3XgBoON+ycvrMxgnjl0HdjvnJc9K2hMSovYCX8JPMNOdCX9FDisEA/wb?=
 =?us-ascii?Q?2RHaOTYagIZXUHPAkDHBKQcwOgchkqkKKlfHaRZtZiA1XvwhsSv8NCKHZwa8?=
 =?us-ascii?Q?V35412NhJytse294KVOEDzlV7Zp2sZl75bZJ9VPE65hiWhPuCkPbIfBHzDgx?=
 =?us-ascii?Q?lgJzMRGaWwdRwFz8CfjF6Hzf0POP8f72UIiUztEOcwmo/0hlKB8bdxtZbl1f?=
 =?us-ascii?Q?NQ4rNKfb+h6mVEcK2dDOA+tPM8/xi31/gw2m1jqZ7p5jzEKkLf/vsbtUXPM5?=
 =?us-ascii?Q?w79f+sfLb0DhJo0DlxlWkXyWyNY6h96sT4XPLKp+0viJ/GCpjy7tfzSjy8T4?=
 =?us-ascii?Q?6Z1mdRK/CueLxYg66vuFxZnSuaIOeaMPzeu2ANYKHArcXzBd6iHChg3/5kOT?=
 =?us-ascii?Q?mwJ6xMQqn5seHtQBAIKLr94LuususvupPCwnMlM3hwOJUuB73LUnZJYt+JmZ?=
 =?us-ascii?Q?1O3fU7w7kzuvDwmg+acxZrlMwIzAnqu1ZKCQSj/kFX2HhADD+Mdx/UfWszyv?=
 =?us-ascii?Q?j5TbUBBR9Oy3tsEGBDd8fsuKfyjlSehMQUkGFhUJ6iyQgfu+QD9stFgi6t24?=
 =?us-ascii?Q?4N1mL7798CLXxE3iwY8TZn2rYGAoJdt4ME5uidwysUINu+jY/8Lwh+H15vo0?=
 =?us-ascii?Q?rWWwYdszML35fPUUGKqRdi6LoK7i7/U5K4GOYb67vUUZWvgsMBY8QEJDTAj9?=
 =?us-ascii?Q?4YPntzIq5Gfus/MrwqO7pxjthq9dLS6xabClPVf6SlyKdC0rDKAksqrldjsm?=
 =?us-ascii?Q?mesBZ/iKBLnahBnS1bqzl13wpkPS+pbyMf5PONrgWRkvaKAoo5C+x9FLx80y?=
 =?us-ascii?Q?Oj7heSGtNIYZ+RKhzB6CTNAf2Oah7e0unX9LykNBWn19fPRO1pc86La1XmSE?=
 =?us-ascii?Q?r2nAq0NhEvbylq4Eer9X8wAXpSX1X0VZJ4W9ZjkLBo4s6BxkxWsqL18i2Zpa?=
 =?us-ascii?Q?UWd2aQ/M1HUtReM7+qPqBcs3ElQ11RS1CS+TkCWhS/hB4Q5JUbdGE1PaakNQ?=
 =?us-ascii?Q?NWG3y7J21ZX3NtYk8jfCBGh9eBJ3QvCChTEwqkM97I5EztIMWNsltv5Upn32?=
 =?us-ascii?Q?OkxEaTz1POfxaf8+zQuwKNQKAnmUu8ZDBGl06DlzLyFjmlTy6m45DbEoMeQ8?=
 =?us-ascii?Q?eSNPha3QwBmW7VavkmeNHX3oXBKnSQmHjsYYj7/HDcRHePi/eYCrV9fZdYr5?=
 =?us-ascii?Q?xJkSlqyFZFksqXkZEWTJYyhQEdCe/qyRNWMsQWscBDfYrpBgYfjRAXF177kl?=
 =?us-ascii?Q?jXbICnf29QGF69FtQm+8Yigys1pqzparI3/Q19KCFAajRbvpoIPx3jocpHXV?=
 =?us-ascii?Q?5iQQPVJdCmt1dSyj371WzGYau1OF+hNeOduiP2Kr5iubAjHjT67104y1rley?=
 =?us-ascii?Q?DNSEL/PWQnY2KhWigppI2Viqx5NP9WLSFyKAUcSLQBhoTNCAONrIzi2Etw4h?=
 =?us-ascii?Q?9c5sy1gJtfAODug0HVnmKRudpDygabDa084e+sCqLT25C+AUSuJAp3ykIOk5?=
 =?us-ascii?Q?FA0ze29va8M+pOFSqz0xsTrvocTFeP65OeINc8jE7Y4KRoXpgKJhqgptOtJY?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c26a4c-092d-41a3-d51f-08dad0effd75
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:23:59.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVaHYIR52hN+ey6KFd+/+9m+Dza091W7EKcwr8C7bpcYVs9zrJVnKqgQlds+zhMFWON7b2j1PoaJHcvOfVYGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

Redundant sends need to work more like the MPTCP retransmit code path.
When the scheduler selects multiple subflows, the first subflow to send
is a "normal" transmit, and any other subflows would act like a retransmit
when accessing the dfrags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8c95affaade..3fcd6af96721 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1562,13 +1562,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	bool err = false;
 
 	while (mptcp_send_head(sk) && !err) {
-		int ret = 0;
+		int ret = 0, i = 0;
 
 		if (mptcp_sched_get_send(msk))
 			goto out;
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
+						mptcp_schedule_work(sk);
+					goto out;
+				}
+
 				prev_ssk = ssk;
 				ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -1594,6 +1600,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						err = true;
 					continue;
 				}
+				i++;
 				do_check_data_fin = true;
 				msk->last_snd = ssk;
 				mptcp_subflow_set_scheduled(subflow, false);
@@ -1625,7 +1632,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 	info.flags = 0;
 	while (mptcp_send_head(sk) && !err) {
-		int ret = 0;
+		int ret = 0, i = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
@@ -1647,12 +1654,20 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (READ_ONCE(subflow->scheduled)) {
 				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
 
+				if (i > 0) {
+					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
+						mptcp_schedule_work(sk);
+					goto out;
+				}
+
 				if (xmit_ssk != ssk) {
 					mptcp_subflow_delegate(subflow,
 							       MPTCP_DELEGATE_SEND);
+					i++;
 					msk->last_snd = ssk;
 					mptcp_subflow_set_scheduled(subflow, false);
-					goto out;
+					err = true;
+					continue;
 				}
 
 				ret = __subflow_push_pending(sk, ssk, &info);
@@ -1660,6 +1675,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 					err = true;
 					continue;
 				}
+				i++;
 				copied += ret;
 				msk->last_snd = ssk;
 				mptcp_subflow_set_scheduled(subflow, false);
-- 
2.35.3

