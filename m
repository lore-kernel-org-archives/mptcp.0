Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AD364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3Ll3U96HmK0auIy3lW3ZsgeO4Sz6KeHK1TS9di+SfXhjddU1Cx4tzB+fn6HJhhpdOflemb2F1U4bCJQ0QdU4cQQ5/73BkEFueXh0EEjZ5kbZ+NI4T18k+y/1vZVqNiQSv/lz1CFkJZYj6qrunLE8+hDqmr0Cd9mpUQSmjEloHHqzKQwKRiQW/0sUbPUD2sMdKi8HYYzUJbhotITn/po8c4cdfIM0rQVQdgXqkya5Te5sf4uzb1k0LrOkNVksrvLaY3yvwcUrkJ+oGs14bqFRs3eukyignDSRqzijyXZSSD4vMH6eOwNkDaTths6XTZ09qbNVHsO2TVObTL6rqxUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOAIuz7o0dfVD7iFJozmkBFylnhD/MjZZHEqrbZABdw=;
 b=I8lpREF7AT6VEgWLmM+rLRdZANtTpDNcEmQ6D1NB7FwvAomSO4ajzMLAMiD/H126evgVHmEMKsoBix0tUgNJo9gjuFr/OMWAR6Q9lKFXzylVo2RLJ0MY81K3rHISFUA7kb1C4cwgEzTkVWYPCT91rSKQ6dGtWyLZzyn/gSW8ZoScYQxv3wgM+ZFgZYvzeipFx5KGEufA1Cv7NIMgozuwqZ9p7oTtCtBCpCFk6MUq0FJhEmEbe4GDNs94MTLwEtDQN5xDthkQqvfrKAAA5IdfEdCCTs63MoytLmRMbLUoU9FpmWJNpsEsQfr/hWd+g3Ni+VYJmDvXRELyJWcYF4GkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOAIuz7o0dfVD7iFJozmkBFylnhD/MjZZHEqrbZABdw=;
 b=P/qIOVkfAt81zcA2hsNBoQr6OmA6HH3Cz9oKP0Y96hwU0zWLZcz2SV4mPbNJXEc3it8+Lwfjqhv2p6VqNOaWqpewB//ErGzujzsCApNObU6ra6Nc03KV9aEp+38pW8X5Xbj/0eUFxDGXVL8JulaW72nsB3wuwRDl8l8P/3K/CskQcW8rWKDBj05SsKZdjojMfgEeSK/UgmyxoAUuAZirx3nhKhYcjGA7paz09AwFhjhREiz9AYE7+DySHs0HVAa5wVgAgoN8l/40C1DTiTpMEVAb7xDbAUXyhsaDPqiGKfvS+dverXv8Xq5atgRPEZeCNLOHVqbDZ36SXHGd8NQaXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:23:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:23:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 3/7] mptcp: use get_retrans wrapper
Date: Mon, 28 Nov 2022 11:23:59 +0800
Message-Id: <cc117425adae04364df19ae3b3ddb6560ebe7069.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669605531.git.geliang.tang@suse.com>
References: <cover.1669605531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c7c092-19d6-47d7-04bf-08dad0eff983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RR2insQ3R2x6A8KI5I1w6nIqNCr5SV9jV83TN+JL7rgzn4InZeqdkOgNdXpJN258cUgLs4Nz3F+vNsqT49qYjFAGqajVE+AU9etRib6DztGNEzDbUZTwIqqB0ZitFXk9wMhE+N/WHt2BEoJTWitAesq1CPod/GMGSW5v3+d8G27QBB0zHyIlqsGaJ3bZFTBase46FgqCcbPXHwonr12Xd3OwEg0nc1sfHvSPnazwlvf6g6ej4DORj7dj4CxEQhicKwKlKXSWp+tGa7ziQody8noJ4NLWe3++ciKNNxE1JzeYQcdKRaqdFpwSUqR1eLIvE0xSaV9awi7DFbxszQwA4O/BCxApIQe9Jd5OQdWyZPDuyIwZP8VZwI4skUKh+zxjfL8WCSxhQrkEO6CHQ1iERBuhPg2BzJYyZHNjUb93m7f0/KZpELGjvyDRLwR3s/YEWFTVuTUAo4wHPC9zwy/+/wIi5NLRXfa1zFwfAqeYahNA8r2qzf/TBfgyT/az3Yi687SQwk0TyUdfsXy5y1dAMvcoHlWkPnOKc+tSyb8t9YJX1aacW0zDvKNWhE7/O+z/QDqPINVL5ZkV+U2H2ibNiTeaIR3K0wzJQ+UinYy6j4p4NRXRHowPWZHxYIWP/KDIzlSGL1CYWRcIfST7hCKkXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2hSoa97UbbLB/eP2OoCI586x2iBieki6bam2Cqxb1ISxIo4/X1YbNXSWAyy1?=
 =?us-ascii?Q?VPFG/530h0KR8XEWM91gqdwbjdf0HJtgdq4MXyhfWkiar19yPVI4dlWddGq1?=
 =?us-ascii?Q?Z6zEvScfmV0TGhoVSa2pPF0SMRP7tpn9okITQjkPxa2ek7CnFPFyIyPH2RQf?=
 =?us-ascii?Q?yg6TZjRP0pT7PJCaBWsS7LU8p3x5wN5YsqsBd/g/PUt87B0i6f0McmCkId4Y?=
 =?us-ascii?Q?8yhrKhsz6BX7FFlK/2rJHlnumc6UkLXBHll6tynXq1SgTo2r49yrIUmo8xMK?=
 =?us-ascii?Q?nUKgPfM0035MYDoXHepn0qTrUlpENH4Y/2ALgtANFrp6QGNOoc3WvTN4V1UI?=
 =?us-ascii?Q?ulWi0LdVxC4gh5QepA5JzgdpWICL3VmI5gDe0zs5o4ujJhO5PmFnxOHlvcYn?=
 =?us-ascii?Q?1BQzGRhkUdaj7npvLT1Oa1fFsCwdLfIutMmWZLtaUDNSUGVtqQP/XAZ5Jhvi?=
 =?us-ascii?Q?K+5SChyxvaE4YHp6WKULBIK6OHtxML6lqM+jj+496EXuIBdexAaWfz7whmDe?=
 =?us-ascii?Q?tvlLas28VuUoKxLuNcF48guf6Dh0vnaxgK/NFyQwBh/FHAFgWvA+JTPWpHUG?=
 =?us-ascii?Q?644ifKAhciqi3xZLn0ycPpS5l/S0ogSCUA1iHX64FCKw7EmREhVtNToOPkZW?=
 =?us-ascii?Q?q+wrRNrLH39f9YEdcK+wtR7OJhDHrZ7qX4FnMK3C30JPMo2B+cOgoXTMGhCJ?=
 =?us-ascii?Q?9h+7OHXne6fLhi7wuCeDn7SaWN+GQazNQ2ZPoWasTAvtOBSiopZ7m/5vNxs+?=
 =?us-ascii?Q?hHlhemDVItES8/oANUVpfR8Rl/Pzomey7DspB2Qw6wLPRGKNJqT4VkzmpTec?=
 =?us-ascii?Q?Ea/G1SemfDaTaaF+6W6eLRGiZRiymm6dZ2pYBTPoOweaYr+D8o3QJNU9Wt3n?=
 =?us-ascii?Q?SPnEv0et+wRHpFrqcao9n9Da34UFX8SI5fkQ/dWiLMZxBll6tn39V3D7RX7V?=
 =?us-ascii?Q?rHi1UD0M96/F/veP44Q79K+tV4LLSpJzGmNKPgzwTBMSCxcHlPbtzCe0kboo?=
 =?us-ascii?Q?zXrC9cKWya7gxMTT9PLTwLdyotZ7oZYbjkBNXkex4rwTUZeQqOP/ExfkZ+5A?=
 =?us-ascii?Q?8/X3A2tUpmK4/Oa6sZIT4ZGwfaPqxmOWmwazxlxvHmyhIftFyN1qwBNAwVsJ?=
 =?us-ascii?Q?VyONGo3nFemT2YHMjOBMOL3E509irmce8tI4bL2qQLArH/dpY/iQEEJLhBxe?=
 =?us-ascii?Q?u0StfvqF1xiHw/HvjOj7eJ1RXs70AvkFGvq9KCwnJaiLIHa614IO/AmBCqJt?=
 =?us-ascii?Q?MCYmq7IxQ1ktayjJTp3rcv5aMIi6j87rl933pe0g8X6mY9iNO/qhBDQx3BZp?=
 =?us-ascii?Q?blRN88pLjz5Cmu/RHZ0ExKrkAbpci6U9u8wBEu1H/PobmausBREStjMJlEur?=
 =?us-ascii?Q?T5jrzztQ9molh3cZHCTk31ZTeYdO/puzKrKeCIWtnoJMIhGx6U2jrLHdi2H1?=
 =?us-ascii?Q?yJ/7sUm4LmOdd3839f74zk9Y8YpqPyeHGd6QOxrlY8urKcA3zXIja3R8mAOC?=
 =?us-ascii?Q?XC8TljWTUcHVLcfCY/P3V9VIC8HsJiWaT8iT3ftu31qJCYBraHxYIk+a8qNm?=
 =?us-ascii?Q?ajy+F6fJkcHcDpKohcRIvtNrcDjFjtNsyppbllaV4e+jRCURAjA1/FcSepXm?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c7c092-19d6-47d7-04bf-08dad0eff983
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:23:53.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXDNXWLfCP3EmQjQZp0fRU5qJzp37P+BZGSVOEJKonEm8NJmwSeotdyBnKimFnGyX9SDZKPcOJYzy+H2JFDeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

This patch adds the multiple subflows support for __mptcp_retrans(). Use
get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_retrans()
wrapper from mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++------------------
 net/mptcp/sched.c    |  6 ++++
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 65eaf59c9a6f..f8c95affaade 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2243,11 +2243,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2517,16 +2512,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2545,31 +2541,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
-	}
+			lock_sock(ssk);
 
-	release_sock(ssk);
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 18518a81afb3..c55f2f1cb7ac 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -156,6 +156,12 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

