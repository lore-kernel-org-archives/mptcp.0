Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9945652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzRSKdgfvdMwMZvXvErGEehZremH3oyiEVXFoPcyME6le51Jq6m7esKjD7ZgPou0oGPjCB8ObR9VKE//n2rGQkTmn0gAlbccUPsHIi+0/52l2f3s+8DbyQaSnVS1wpQLXiQXR2dwhechR9Cm/k+0vIAydQLF43w2081ZfiuVWufpzRIGhLeabLpZ9zDbl6hvpDbezWIEDjTAa79/jmYXhTCqIx8+h/+bFy4xEOcCyh8jathOcF97/7jBQLZ9EPfVQtDpYKFgsTUQt2drfo+2qqzQ3pT+XaSdA5X7ok2HMpDZYEZ5J2Ktk0fy5thpc33xjscj3egxSD+vyEvCHlVmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxLfNDdIoZElNrznniz+mjSsunkrGrYkamHNbix1hRk=;
 b=kO10YOBS3rmDZp/NdAbJVCeinMDttC+kZ5GCvmFrJE9UrFm+PiqOUFkdCJotTK3p7tMvnsx+keYOuJ3GkXodtqcCixHtOmWOzt0TvjafmwBob7ZZjxiqORKtwb2+ngG4jYHeSGG/S5eHTA18cKbPEvFFN6lWPMX4gt4YA17+1tPgAJ6Lq43JrsO4i5eysqt6SCMXYpHewZWji+AInyOo0G2w3t8Wc4MTPNOJKWBYaqOUrOEgW5PMd7m1TbiqZFhrhX8gJSJunl6l+Nd2K2e2BFwqs0Hsfmw0canEXhJYFhTavAgCXAEQQeQBsaJVzWHvj8VsNJnPEsEJlbuRyNbEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxLfNDdIoZElNrznniz+mjSsunkrGrYkamHNbix1hRk=;
 b=YUQqw8JYoiwcHvHVnB44mmZf5/C64ebOLlwz6kG3r65U4u4tSnurrvejJeaOJ8xrPYq+WYqEBNhGHK4Xyi72KKJkU8GYXTh5tbgjfjkIoXCVslOG6tM4FKSXijiYODbmhpw7VINz/BP8wYVZ1wrSc8ardDh6leHc71LgCzi7rKNVTrJDN1fXBEs1ZclcXiF0a1FwYgmIpUjP+sqJTQI+FKJzI4JaMMzWRLk0yhE/nZv9tgI1udWI8oK7UH+SYtaofr+qoa8uUGm44XCzzRHLUmmVgwZIMJk9yp6Y4RfqwFKBCaiehK0C/9/N5uA8M5WrXpe//aAFIGEQRfEuLapRgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8230.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 07:48:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 2/9] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
Date: Fri, 11 Nov 2022 15:47:57 +0800
Message-Id: <8ee705e20b7f45d94f5fa47c97024cbbbfd4d1b7.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 7814c2f6-ce2d-4c0d-b77e-08dac3b91ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iIU9wGaQJ8xdgIboP8SZXPFYxs6xQG4gy/nrWA0/3vV/LtdJqHvn722UWTN3lFyzgoxN86ehMK76yH4RLcalv/EINf8CUok5ifuwvY8ZHrYOGC4vt8vFhIZUtcuGirBzJ2C6qSWZJ8imzUCKp7r1HQOcRUX894m7Yqiz88+RFKnxIa0YTlzUu8bHYVQmkcAtpEvozO6ky7iw6hMcfIyosBixbY9CXFx0CuobZRgbck268cR1/fhuYtZAy+0PvvuCeTfOSZVezGRFiKlGqVXAZf1VLsZWVxIqd04g2UcLMICPzG2oAthiBvA+ogLbctiwsUzMLNcbYS3P8Id46auPdikCU3Dp+8Y6goiOvLZ5CPQZvQJ/nhshLrUXTejJFvee/8xZmyVmD1Zq665r+wpc22W5uNZaWNtraloHZGihXG0KzhQTfK84bFoWUtGuAo2Y+Blc2IVOI/SQFyCYtFHF1iROzMlSZFqK9IOOS+/+Ums2slIhAtAh2csVC0+aBanuFt9ESjPVsgybVsVuhPXwYYFsmPUHtg3e1MC/TH0hdMCIW4DnvdobJ4B60KzgIHM5eLDZWODqPWW1ftGa7rp1i6bQ50kpocN6POvizv8pLBwzSQvCpCf4JJ791NjnZdhHv1nx4aZ63nzOcAhrstHmbLWdxbhko7UNFYlPTKzQLR2IlcG2judVkG+YEcRypUSrr7eCoE5CMmsNiIPaQ7mvXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(6506007)(4326008)(26005)(44832011)(2906002)(38100700002)(6666004)(86362001)(107886003)(186003)(5660300002)(83380400001)(36756003)(6916009)(8936002)(66556008)(41300700001)(478600001)(6512007)(316002)(66476007)(66946007)(2616005)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZ5856SKopRlSpio/zijudk5BbiPlhGhDkrBXGcX1Ts6cMPQeMpwZsbhrSuq?=
 =?us-ascii?Q?uyUVaRDXL6ammDLualzME35Bb/n5uADGrVrJ/uUV9ydYOfQtGHUFUsuYlMr9?=
 =?us-ascii?Q?hk3PBJ9RUpwqAPnsXEFNbg//BUN37EnDYcgfrdoFx2v4sopnDzK2Tw3J3DIW?=
 =?us-ascii?Q?sJBHbu2UvrYyXwCxtnIBk6eotAQXETac9f9W7kM4nSTePCPDtUEzJgY6e4ea?=
 =?us-ascii?Q?NmCZZ5a9paI/8KizhNPgJTWSZ0SRnr5Gdy9LLy09Hr2naXm18oyzwgrR90lN?=
 =?us-ascii?Q?XRMV1X0J1E0WUGoSkaflHLirIs/ZaZ89fUyFSIYIhVcq5LA5Of9Em2pOtFwS?=
 =?us-ascii?Q?W9RGNUEfcRgNaYitpyiZI1oJUcMopNHfvDAjypdnGzFa/tjGWQakW3j2P/4G?=
 =?us-ascii?Q?uj5HMurv7qdz8tu/oQn/qmiG/fio3Qv6UHWAMDoe5iCuz40oSXYgex6DvTjH?=
 =?us-ascii?Q?UKjgYfUwn77DgQR/PAegLFBXMz/2Qm6o8KKm+5S/7M1idkhquQChZPTz3YSO?=
 =?us-ascii?Q?54WFY9HwscWV/3OM4rfa45G4EmN45RfDGXjNtVv12oLEIoKGKFLyVPTzf0s+?=
 =?us-ascii?Q?QYz2siYsK9+um9nNi0d8eixzwNj7LBlYK51H6fvkP2hNq+Gh5nFfFDQ+JjeH?=
 =?us-ascii?Q?XqCkUgsySeLuZCvqrNoIeKq2nfYAJ0PBNDO+4Ad1RcDN15uPuVyIsQ7v3kr9?=
 =?us-ascii?Q?jeDBCW+P41G1YhRShBXDPGqtk1dVddfhaBtJAj+lkiX42b7WPvVRaT8pZHq9?=
 =?us-ascii?Q?M4a347opxGfpo/tzNlNxTpzHsLzHVFCIMvWZxjM3RzLsGqi3k/h1GZo3MApT?=
 =?us-ascii?Q?7Guv4BHe2M6v6MV89+5vXp33cGEWx/mxbXb6ar9Fhn2xfxy78gYI4N458QY1?=
 =?us-ascii?Q?lHzr9NEMhBLnpVf6IR19kxug3KY2s19LCAE/O8lk8uKcjQJuHoUlNN7vLQv7?=
 =?us-ascii?Q?K1hJCBDzHmVzmKYKecPu5EmDjLnKrhQ/kZCtJIsL8opDT4Wy11p7vh8WyHl8?=
 =?us-ascii?Q?bIPVsaZchVd6FDBNejeQcDVdTUo75PuwoocY+K8pAE9lZdh9x52bZeTY8vUM?=
 =?us-ascii?Q?/gzGzyeumMbH0++LvaXNSymrLDBqxFTa65ogF1cAwImVQ1IdGN6qqCzI4aCy?=
 =?us-ascii?Q?4xF/GDhubmqCrKOHQwpI8G0SpVeqLNErYvbq1QdnS+YRfqWYHGoXdZ2ELOEn?=
 =?us-ascii?Q?k3dr0zq7jRAl7AeQ/MtGoyJ7FijG4P5XUG3PjrPJ+tqOJ9nsU0CfDg4IvQRm?=
 =?us-ascii?Q?uXYtaN86XdoneQ83XfoSGyiFO5CQeoOP8Ls6/1BnzHrlVLKMEfTTsbCZ6xla?=
 =?us-ascii?Q?+JUKp4Rc3zrVXQio1r7IuDP7t1BLNls+i5/uDc5EM+aiMCsu/53CEassMt8v?=
 =?us-ascii?Q?e0rMHN8x+gxJOwRCqJ8bxE92ADYI5wvXfUI8KFXDeBrWyLoKa67M+DwiToIB?=
 =?us-ascii?Q?8o/Ht8ahrd00E/GhqGRD2QLQX6c1jEQ9KSk5mqiXc+GjEZfnWZI0L5tRSO9E?=
 =?us-ascii?Q?7lxf40/5V9EnerG1ziZ9WsHNtjBWz9/rKE2odAd+u7GsDO+3G+lzL2Hgx5OH?=
 =?us-ascii?Q?YfZrtVjbDve9Q2fF3cwDWTFgjw2/RBXNW9/m0SVjsF3JMRlTbBoy9bG5ugjN?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7814c2f6-ce2d-4c0d-b77e-08dac3b91ac0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:21.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN8O2RuhohPw0K9YRgwbkAFSt08mYLOn4hVvnaDAjsSgaHy1IDChWFD8fVwrGZL4f1ciRn0RxLA14/4QqjoXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8230

Since the burst check conditions have moved out of the function
mptcp_subflow_get_send(), it makes some msk->last_snd useless.
This patch drops them as well as the macro MPTCP_RESET_SCHEDULER.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         | 9 +--------
 net/mptcp/pm_netlink.c | 3 ---
 net/mptcp/protocol.c   | 7 +------
 net/mptcp/protocol.h   | 1 -
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45e2a48397b9..cdeb7280ac76 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d66fbd558263..08806f97c8fb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99faf7c1a548..9e5b3cf27a45 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1469,16 +1469,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	msk->snd_burst = burst;
 	return ssk;
 }
@@ -3284,8 +3281,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f805036e3c93..4780fb5a8087 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 struct mptcp_skb_cb {
 	u64 map_seq;
-- 
2.35.3

