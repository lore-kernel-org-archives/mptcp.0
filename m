Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5A7F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWa8ZW/J41OC8t89qDl8q5SUr9FB/ejDMJUioBf7pIFagoPg/L8iSyGiOHimDB30KaAFHXv1MKynJm6M1tTSimDdHUiIdHhl0gFIf84HMZk45Yko32ljaGdozIg6HOxpQKaJafBZ1XJWhFC/Q5hjzffewZcZ0jl+1sNRmJ2wzxk7CuAdkCWsLVbrIO2Z67lemowoItoYc4z2MiSDpBpQVYXeOvUS5xbFvpVaWxai0MjnmGU9u8FRW4qqVtdWV+kYMIt59dgNu61r+gGdXzvfIxYc/yt1zSSvIsrt30XKcBJzeqpylvePpxZC/XpCCJXckduXDUo2XtszsT9++SOZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq1wsrQB3/RIXoJhaAEw++PJGxECafmGrZEKC5V1Svo=;
 b=Do5RZecqypYEeHbqE4hvZg64SiB2lVjx/kHBPUFwXLDwCCp4ENX592WmxrJrGrEMobbpHOELddh9dvf4dWjklhb/q33s/TaLRKIwD+/PgCreZmgPlcLlts1ghmn0HIUzQdnABmugVfh/efQZhWbNEwRmHh/6nk6qDNu2s0qTxtT4boErWum0Qx0LtqE6mua9l5TP3OWfDhUIrXBzGfFZZf2hDDBExF80Oyme8rUNNpSWjJSbkgtjUxooG5btGvGXKRk+LgfCyctmTd67pAN3aiRThbNbS2UU4AChB8107l1ZTnW3pvjqZKSAphf9qmPfi5rcQZPT1/EjFuIAURIgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq1wsrQB3/RIXoJhaAEw++PJGxECafmGrZEKC5V1Svo=;
 b=bajHIZHj8Ab1zju02Vo5LMJ8+TQWClUEf/AU6rE9EjMbeA5adMs/EcsdMG0qIZdkLoJVaUhGVHEhXWWkRuInopa5AxqQsZT1YQRcc/DtUES702+/tzsf9Z3JK6lnw7lTgLejLNBp/MtQTm/273GuX4K1C5C4H43IzLtGwxod1yJuu5/R9cyMcUgcG58x8eDpslajxUy/m828rYZ2LyFkU9ECMaAkt6TUWhHOxRtImOZ4wHsmleVVqXdbBA93a9ygBAs925UDJIVbnhxF81PGI+8CrVghIJZ9vxvwlfl0x0DUwFnmB8KInSLFdIgPrnW0SJzSQFfEs3vvxEkdj/wjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 04/11] mptcp: drop last_snd for burst scheduler
Date: Thu,  6 Oct 2022 20:17:52 +0800
Message-Id: <477a7782fc1e495f0d8ef112ecf3c457b0edbce1.1665058388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c1f1c3-fc42-4a01-a13d-08daa794d3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vvxHORvC1A1RzbO4/KjvwwomAVzYeyUEgxqZC44tS27IS3QuUk7WCGOZLgWlk6OcnhrcIxXrFbf51lPyl4WRtvNCSOt4vSNHb1xRUOYHDCZZ+sGOCEP3MmFYTyx6vCc73Fbp2ihlNJbQ/NJkz1wMjj7Qq5gk/HLlD5ShZQUt8rS/F/7vXIWDc+g76P5P2iNerWipPswR5goIJ1803p3a2bZl/ASJjESPcid/Q6eXDo4kHVoBjwNmg8xtaaO5z4p6qBdzXA7godYC5unqJfTDRd62L94xwTZMtkeRrGgOs/Pp9V4uxAyupFpqGHySSntpEy/opeeVNTob/hYFqxat8HeljwZF+QWgtW+6aczjXVKJhfDz88cXo6Lq9vjffcQFGEPVD1DmyTvt5B2GifOG5E632ki+M9I2mwQq21XLp5BbTzM6NyuvP484mKPg8hqAHL/hva5i9qVuvMpql02bd/ip5IYRE5YoqUBYiRf71gNdB1+bGyEdwRQ2tGAKMzhLxCjogm/Q5/72BlOGwwm6my4UcpORnCGeNJIwAyA9zMZPf1JRSG1GmmdG+R6RrzAj2fm7RrVTDQUrzsthy4fcpA8fkLdE2pb1OIYIK8w+UQkcDuFKFiWttSo8UzDRZZ8BAMRL2fTpgZrpeIyZ7OyJOYMNiE3imz3RO1atMvaRqZIO2+DkCDHZirdnaFVtaJ7RHZMrV1Z0yI+LKangzxH6SJ2Bhu68mIlust42zXtMAG3YeegbikSA3pe4XYfEGm2g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fU2H0dS6SCPT6D/Gy2FpucKQeZam5lZ2tZjX1BTSVEroeVx8dWhlH3BfHcU6?=
 =?us-ascii?Q?iggU9rOGguLgSIzsXAlqmNXTitJx35XkQ0iLVGPlrWdyyP+Wj/V1H7W+cOx0?=
 =?us-ascii?Q?8P0XWGobe90vN3gCK4+lMg2d71fPBkrHqJNTdQTHnaz90IyK94aNe1uWxqSi?=
 =?us-ascii?Q?8OHoZED+Yvp38S7eWL2nsFHhCv+F4HapVEAyU/w7k4MYHDpR4HkvsojVfMmh?=
 =?us-ascii?Q?5VcO2kvaR5u2vHb9azLEWnDVbWfOmvbj9KF25bSFL0kUNwRMoEUBx8UpWiF8?=
 =?us-ascii?Q?q9F0RRe5WL48zGn3qczAVnA25UK1Aq+H6TQis2oSHyn6e5ZRaPOHO5jkQYwK?=
 =?us-ascii?Q?/OAZa2OmaWD2LeT8XA+X4qyV0Us7WuEIReFK9IQFgKY00/yvywBkdS0ur0Zh?=
 =?us-ascii?Q?MEDJM5EvYY/ofLZKPjjLwTMLm8MasghV7yY/sKB1uppbz0NYUupwbir0iadK?=
 =?us-ascii?Q?w8T3sN+7euj3h5tvPPOiJ7LVU4DTuXd453jTe8BRAWMkreOk2Mo9dcT7CpCA?=
 =?us-ascii?Q?/7gWpqzQDuXEk8OdbsyLIlanhJQJ/KlrPq93lFfQ/Woivj/w8HcQSKiiTJqE?=
 =?us-ascii?Q?zED/K70v4okuuFII8k/QQsW5/HbJumenRLdZxyJq8wyD5zV4DSGiINNySrkU?=
 =?us-ascii?Q?vemydI1Gqt7J80kvkmEpVfCsNBHpHYpODYf7BnpqN2Zqgd1hRr3d2GDiwjF1?=
 =?us-ascii?Q?yUh2OXMMBn/0H4cxIXosVx0+mbA5Rf5UTX88ExK/I/ZIcoU8cBnp7XX5QU0m?=
 =?us-ascii?Q?GU628TY8MFXrjXw+nSui3JnR1sZO0aG6E43DIkGY0FNPsyoB9uh1CyJJ42yQ?=
 =?us-ascii?Q?1cmf6ld4/mYc72UX//potZbIH7XrOW3uVJPmi5jqW5eJJPM4MZFNbpVI0S+1?=
 =?us-ascii?Q?z6cVg4JdHfws4jZjHHstcvJUrnx6uE6dmvjjeCIOXVYEFCPhmjo+FkMAe4Bq?=
 =?us-ascii?Q?LcV/DUmWLFSDmSAZAA/68HJDDrZzMcIxEjjP6Cx9m+4uD5kEU10oVUcShHJO?=
 =?us-ascii?Q?xh9cEyrdGJnKvF5ONU8i/5CV6Mjsj/qJxjw0Rh/WJILZ0fGjn7qoAnrXJ+ph?=
 =?us-ascii?Q?LReNThA/lJjaJsmvVR3hr7kDVuRdbgBpXCPOm/CtmeDGZXFeMhCGdJTtbXxD?=
 =?us-ascii?Q?iPe0XPe5xcC5jJyt3vxG0ZViVzj93QzBFIWb7cvvRYxxN4D3jWMC8WkdgPkP?=
 =?us-ascii?Q?Hd3ewn2HQDFHzxwydTPq+BSXSzh849sjwI7KSA8dJUGQESoDhAFH26t297wL?=
 =?us-ascii?Q?mUm70OvAuipjJM53/ERvM6Evp9i2Rm9Qo5U8lE7RCOHAblh9X4S8stB9tlIu?=
 =?us-ascii?Q?+LO34lI5ZMTTZsgvmf1R7dOih/85/5Yv/n6BG4D0ghrZoeeKxLcMtD7F9qMk?=
 =?us-ascii?Q?fKKTcQFIfF0pvHoQJY1/LkKsqgU8D1CbOSB5gNYPBub8fzndzJg6pBNt1NBn?=
 =?us-ascii?Q?ILEcTpH0oqt2acnyhT05sjTtANMhRL85kOJZ57Gqgin4BuDtqniymGl1sBaK?=
 =?us-ascii?Q?JxzZix8fHNmLQ7IznbcMuw5Cp/FThBfScml3tIDSFyFgtOHobMRvKdqtmYDN?=
 =?us-ascii?Q?Gq9BuWDyu6G4BxtEvkL8R9Pkbsj9xNgYv5NoHFySAyzLPPKrLHVrkUcUfCon?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c1f1c3-fc42-4a01-a13d-08daa794d3ac
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:07.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziuV1rDMCc6tZ7uGcTTmWCumxvVwbbMJkCwlUrOcJ9M3zuQeNyuJ5PVhJbgR85dJgsiPLASlDCiuCTiKluOqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

msk->last_snd is no longer used anymore in burst scheduler, now it is
used for the round-robin BPF MPTCP scheduler only. This patch removes
the last_snd related code for burst scheduler.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  9 +--------
 net/mptcp/pm_netlink.c |  3 ---
 net/mptcp/protocol.c   | 11 +----------
 net/mptcp/protocol.h   |  1 -
 net/mptcp/sched.c      |  2 ++
 5 files changed, 4 insertions(+), 22 deletions(-)

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
index 9813ed0fde9b..1f2da4aedcb4 100644
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
index bf77defbc546..8708e1e4ba16 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1469,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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
@@ -2343,9 +2340,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		msk->first = NULL;
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2978,7 +2972,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
@@ -3239,8 +3232,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e81399debff9..05f4c6fd0cd8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index d1cad1eefb35..3d805760ae99 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -67,6 +67,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	msk->sched = sched;
 	if (msk->sched->init)
 		msk->sched->init(msk);
+	msk->last_snd = NULL;
 
 	pr_debug("sched=%s", msk->sched->name);
 
@@ -84,6 +85,7 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
+	msk->last_snd = NULL;
 
 	bpf_module_put(sched, sched->owner);
 }
-- 
2.35.3

