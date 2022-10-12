Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DC17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awlb9c2YCZZcGDKHOipR+CqtIKXF/VhGUvuxHTEdlj21jKyLEYtA4zY6yk504QM0YGD3IHMEh0Fsl/1FWFU8oP+Jj3ODSbu8QeFUwGvBn+huLeAA90jdEQzcXuMWu49+UkOoUUEFcyUsbkC4GKM9pitGB/csTsiTg2eyJCO79WAgOwzzpF76lSe3GtY0pBAEBYORfd8cDK5DR0HypP4BxU4Uf5ketfqfvlpVDYzuV/vBERi1wrlir0GPGjq8FCTtxkud5p3JN9zWjlUSIn/uolO+3eIlMYLlSFSFg45I0q4awJymv5etLfRkInB/UUKY8boUVvPe4hLkqPymxI70kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxQh1Yb/jTl6VKmqplPmD4ZR07La8WSewUrWkcN1jTE=;
 b=as09oGIz+GUhAZqdEs4IWXB218FIkIux62rmQxj3xim0j4TddIBK4wsFojBupaFbRLpMy5+i1KAbuY0j5OlbK7oteQktI8JqHZ/KmcBOLyPZi5BbhGpKg5TFzxJQBRQQ0/jY3+PqPXaer+fuhinYkirfwJWdINkPLTwsE3ZbsjoAN1Ul+Nvvth9P7fcNBPssY4vvRClAO+vulfkJjxkbyArjDXTYpm0WshT8ZZFaro+wp0ojzWhMASk/44/zTcRTXUjxIgqilYwith7Gm7BarBXuGhh7cbUdEBA5k1WHp7cPQuyjFBxGVGY9COFrjMvrPnp/g7loDwv44lbV7Y1XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxQh1Yb/jTl6VKmqplPmD4ZR07La8WSewUrWkcN1jTE=;
 b=mWFLwCorTapoG+qAKiBdejWD++UMGiQ98TTLYU36VcTRaNqpBgHpF+61ukRAY06pT/e55fXBPobWzVNnIUIszJYrICnx7Yr2TdmZtbkfVma6vK9XdztIpdFtECILkC9bzMXshxKKMcY74sDfHlHwlXGR2kgLmsbw9mewSmjePkO861+O/9uJK6gpylSKeE0RS2GOjFidArS4hvFH9c2M4cr3yr54iI15jJgW0hG0VeKOee84du1OI7tK1mKiIHMEf5cIZFiQPfHQ0ZaTVvtQAp5nr4ZpjqBJV1YhwEzE1F7C4TUK20Jh1z7fHoFYo3Nu7EshOUOO9l/KNKavG7DGxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 01/12] Squash to "mptcp: add get_subflow wrappers"
Date: Wed, 12 Oct 2022 12:39:56 +0800
Message-Id: <cac868d4c658f1362e83e6bba9d8250594f51a3e.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ca1888-df46-46f2-a851-08daac0bdf2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ERqG2pKgS16bfQ9iomKgfkHKxQHZ9zLnuVQ313UNWySzJkGgVLalcGWBZg4lRlYUnADPnNDAlGTcug2uvpuxgshq2+AbEOl8I07ILPLPeVwxB4slrzqFPyq4qtgcN7UEatRkyGqohNCmwj3cK3XoJCx3Tll8gTrYq60VywqMR8FJvJc2Fv+q/ZtwTkZH6IrdNU/B8XUzeLr4ro1s+XjhI+ZWJ+3NO2pOCcYGtwfe8RLYNuEbNiOU+v0KOZfVB4pHNnCO2NVvaOy3bWb5RF2uQ47324uAPXtIQ9jfso4pad34lWjC1tuEhqAfd7XspEulpq9t87AQpppJ25wxQ9I1vviGkzPDKmsWZcDOUKPOAeN2z1JoSqIpTB44Jf6O6ufqCdQ07NNk80ynjm0Ur4yYWG4K6skoQMmk6/M/t5BuJxcRrwzK5/ne9HuDFQgoA1LWi8wIjt1W5UBUb2p9Ot/81ikXU1FEbnFeooi8h8oqyC1i2ewB31lyJB1p786KvTVYu4CZ4V/NMkNCrPbbQnoME4r9myK/xRYy7HQJHcUNWLkWowoaUfHHXdyvQPmPl0Xz2ZdI5SrR/MNRDFBISs9l7knjjumMnq9X+nT3HX4zky9LapwiMQPrfVUtI9MYD9idAHvHKTN5FLBCDVdpOREe1awAW6EwCZHvHt4wlRY4tvJfYGjyD2L236uIcNOVwX1UthgRpyKP9Gc89cDG7UbAr+jTvJqDhXVSHM9SiCn7GoTVSgpIIUynu7OrsAPKfDoZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9rRq5avuLFxfqxzYyD30I8qms6anW9bpsUs5Dck5bJftn3f06lSx20LJKWB?=
 =?us-ascii?Q?fUSWJFtDNyUfufx0OAIAiwRRFElIuzumapXJFZpOx/exCaDJsHISfs/sPN0s?=
 =?us-ascii?Q?gWTd0vq0Ynkt8cLax7AreyC13eJcYAM3S1k0jJWVLxlUNeSXPQUETF2E471O?=
 =?us-ascii?Q?rlZc8bbFUKBzOmePjDTmjwGX+apA+12wknoMsZsD/DYrP2fcejtbg3PtMftX?=
 =?us-ascii?Q?NnKL3mIWTcl2yeJGVSOm/nLJh9a4j6+XwgKqrlH0/chyk9sd3c+4Dxhpy2U0?=
 =?us-ascii?Q?dus2TKF4yx9Or9eKo3po5ky9aD6nTzLNTQFkw13TZUT0SF+k72NfoET7LTUY?=
 =?us-ascii?Q?DnO0jQsB5Yk2HIUs0G1UEB1RKGQQe1V+n8YO4BecVnm9p7IILYWYx8L7fTAW?=
 =?us-ascii?Q?OaTaIs3KqtTGS0UAvKBOsXDoknfI8nVCSDrdBkAx7kAPlSkBe5CXPyTorFQI?=
 =?us-ascii?Q?v6hA4DN1ktZ1hvEarcvUEY/bYifRomvRxh3FyksbMIMeKNXwUrvJbfKd5URX?=
 =?us-ascii?Q?H1jcBWRlNdX4gP8OlLX52vjzGwR5x8R1kjA+ScbNQSAAsUBeFyvdyJz+PJtD?=
 =?us-ascii?Q?/hJzntWav5aGYLvoP2ADLn/1xDnZsp1H2kuK42aAr5gvu82Zt+qckwxoPifF?=
 =?us-ascii?Q?45YX70+UbFqtWSEFup5FEE9a+7jiuF8BJ75S0Qq25/4X26NJYBmXjHyhHhaX?=
 =?us-ascii?Q?4q1vDWe2avGkuvJprmqM2SPKLOdxT7oOAFZeZDxBvmJ1LLllz+g/YoYtzRPL?=
 =?us-ascii?Q?UgrXu4KpT1rIn6yWqDgMJvVaGu9EJj1c4Fx7U8ZLZzX9KJ749MyPdd8lD9Iy?=
 =?us-ascii?Q?nncCZgAZ1ExWqRAyaEbMFFkbD3vzDB1ZnV59/XKOEKOTvHXU1h/uIAA0GNkz?=
 =?us-ascii?Q?SwJQrhviAb7Vz0zom+I9J1Rg80SoBz98Qm9/xhpC0zOsPxMgn6uEDqEFYQDp?=
 =?us-ascii?Q?FRdZzb4O2fjmKDyIArOF7rv6uOzQZSvtBrgJye2grhvt/PmoUkfza5/eP7hf?=
 =?us-ascii?Q?F7lrlDtWYbEk0QzolaCMNBXL3bDJCGzxtR9lr7/esuwvuIPAIJq3DNphpTJ/?=
 =?us-ascii?Q?DwDU/IxJEQ28KZMQqaEOIk4XS5p+JLyxMcIVD1sw/FJbFHF8oN6Y/0TQUWP7?=
 =?us-ascii?Q?w3wT6h5uSJWnNjNsF0CbpCwFo51QUSKd7Lyz+w9QJ+d9p1rEJh0mcm+6QFR1?=
 =?us-ascii?Q?whH6XUgmCDeGq/V8ELqe5aFc+dCpYLPEjHh4ExQdb5tiei+qQfDhBMxnFtzN?=
 =?us-ascii?Q?VnKSGESTC4dahFCQWwaRofenBrIHixJCItRq9zn5sPDo5bIgHveBVLt1kEPM?=
 =?us-ascii?Q?MBB49DpAesJ+8of03qtUX0Aqe1wZjWzgVwczYcVO4aZqDXxZmw63ZeuXq9gF?=
 =?us-ascii?Q?f5LGIw4W0Yj2ZLo11qvGzYrx/orqzVZ12y1peVZaiB6lqz/pVZW4XCwr8jlz?=
 =?us-ascii?Q?ONHsFlf3nMk64k4QppfnQ9KJyrkzc7tTsTs0pZP1etFtcQh+5llnFnZVVJbn?=
 =?us-ascii?Q?EDeWN6Ft5uOnSk1aAry095O/uEO2ORvouBHc47CgDPNE7XfERiCUvtBROQJW?=
 =?us-ascii?Q?EtCfTXJtkRfsNJXuRtHJJj6iLcGILpdwnHLf3YSgTq+w5Zf2pGmDuLm5fX/F?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ca1888-df46-46f2-a851-08daac0bdf2d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:21.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4YySxwLDUQB8SrdQSx28qqZNujqRacvDd0IYpxTaGvzUruojVA8u6bCZtb0y8qIG9JKE9LvNyb168gUylHFVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  8 +++---
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 61 +++++++++++++++++++++-----------------------
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1aa940928b4f..9a2253436f50 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1547,7 +1547,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1616,7 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2481,7 +2481,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3199,7 +3199,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f866b1afda..d44c97bb41db 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -642,8 +642,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..9b128714055a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,67 +114,64 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
-	sock_owned_by_me((struct sock *)msk);
+	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

