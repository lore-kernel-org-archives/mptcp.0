Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981633D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQZW0k+arP3PMXmWXxUjG6PMohXd77Ou2xgy3whu7AYOtfK6cioMGi/Vkhcn8E6xx/YJp5rSxTmMvQrpNZKMoKOWmYm4WbOCU1jAtbzzib9mf6nSn1BdxxrF+zgJrbOFkH2+/mjZhJKMZS2pq3VM3w99Tz0lE5Vx64HKR5pQ2XA2XZP91oq10kfDw2I+8VLJ0qiWtVJ9IY9S+KnMgQa/uifpfXeZyLd1wHtRDXPKn3X8ZLJbhX81Ttv7f+Xk24ioAJELz8VjLCo0j5vkNtCb7FgPVWtKIz/qLwcOQQs8ZDO0botdRoCy7/yfVCC3UxhlW+FRPsmO8t7jBYKhjQC2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTWQfgRyfDIJ/IWieb04Sfn3zbsFzyD2WEK4NWd+sws=;
 b=gZ+NA4g5ummwykmWbRBO35vBzTGkc0NQZ2Tv6myFosU/DBW473vHT1pa2Ji9velfZhaiVBcoY7EkxSFU1b4mOiGOiN6QNTxZR6+kMRLwt2EcMnLrEXt68DwVd0cJwhgo3sBV2FUDRIa0VIYord3+hCb9hY/0YkwDzgdlkkQNuqEvYBDnGZIxezSTtYtxV0Z8H/EhFHzmcrYi0V8c6FBCuPinM3N2S2gQXHfzsuDMdCG1371jNxC+GTYagumpsE4OS70QfpbpXk9mX0rLLdioAm8Xi0a2BwKfChnrexQOm9Q02Ma1DMCOcFCLoHUQRV6Ksw/qWYojX9/65vnieueiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTWQfgRyfDIJ/IWieb04Sfn3zbsFzyD2WEK4NWd+sws=;
 b=cteJ+rC4bnU8I/Ywf0UChMZ4KzFXoYhaNCnK4kKUXUPsjWyQsMQtPjxrt1yg0eIVh1urFUpKuRUt2fePqV8EsWFE7eWmsdUzD8HozEGcs0d79LODB1QFxySYggkEXvoG/YARuHFtemyf3x2OVM55REZCKImRu7sD/1tdJOpKVhJIt5VqUI+6cjS30p0vOQvh5EECj42PjbvJ1M4YilvvCB3O7+kjOJnfIQCPyscr4TMzteS/MjYostapV6+UrSbw8E0o1/luPA4s0Ucu72dvZ2q3UXfIkezQjWKxE1Px1DWIzGIT2ghcvdo+Aw8m3FmlY1BtZvb0djcAlHIi4OYUfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:25:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:25:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 07/11] mptcp: use msk instead of mptcp_sk
Date: Sun,  2 Oct 2022 22:25:15 +0800
Message-Id: <4e200561e3d42d7eec282c608c8b9c0d57ec6ad7.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f133e6-a6ca-4819-7eeb-08daa481f9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r06n2wBKWCS4Toj6vS4EN43uw9ge6O85DDfSHHUlSflIN52Fu8UkMRRYdIdhTivu5fvAU9ZKZHWBMfUUNj2+iyWhXbn565MyEZKFL2TammV2NzGxtEy81+Azj1wXZ0LUur1/GYnCiDM1Fb/Wv46m68nsJ1qc9vENG8UTpQLPsiqchR/wQ2iJH6uZS78ePa/tIawEzodkk/GfRA8KqUYnc4coV51NHKJSjHAujnTgVNItepUmcbtk7LWHKw+lXXI8hywzSL3kR0GOV5/qTPBdbnXEds7wlrtQKxfUyK4HisNdKCFhDpNGecR2+EiQkCymDNk/fFpMeG4GorRiSY11amZ60yVqmoQrceOZeVsddTxPJmAjRX+BjO7GGzTGRVu/94r0FnrMHv7w085q/Ha8PcmqDz1R4W/s7jW/OYcQVtn50FtE/RWZasaeq7FnD9Z9Hb6KIJLyCnGbBRxVYAmo7slmmzJ/TQxd27FOlx6kElk0L2hBqTGOzcHPqgSxdmdcbUIbZVvYLkazqr2i1tIOedGam+eza5w864o5hAIPsTDxStrcTL+3hQ/o+U7jGClDg3cwh3+wogxK7e0W5I4k6V3tyvG99cq6S4igf6q1dPPKgVBWQn4pHZgxrFc0rIjABS4YI3vxgNYxgK2tjuWb2ST+PgKJgvlzVRw47L6P/BbPs9JSGTyWA0uVOGV2TSeme6M/3g27dkifpYiUFwscag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?omMtjadxzDxlp1SS/ttxl821wGUHNjAI+lFON9Taf/Hnl/3xjTu1jndVwvT0?=
 =?us-ascii?Q?C8QFWn1ryXOTvvj8HPEcPjTBdbq/3vcl/iKPmFE7NnZh8R7YCNQWnuRZ9BQV?=
 =?us-ascii?Q?l/7ixWcwfpMs59Sf4MkliR0owTJx7K3YCQeGQkdihw9DK/KJbAZvhJeRORuB?=
 =?us-ascii?Q?7kOCGleqnj/jPquTCQzOHFFMiidcwnglt+V0FLsSAaTETmJ7pCeHatrmNzvw?=
 =?us-ascii?Q?LwhV04MelKAl4lOB79Z9ZjKw0O+X/PcPgyEvc0QGeMjo/+Lg/291+1UKyjiF?=
 =?us-ascii?Q?OjcEcPb7nueTQfifGeCKh4tINcQk6twgEuGHr9QGyJfqz6elJiJ6BTIyqbS6?=
 =?us-ascii?Q?Xkdej8rm7XF7g66x/llIP/6OYr4LRl1lGVotlXppJUkeQNFyooK/gz9ll+VT?=
 =?us-ascii?Q?fZi0lKImFPkpraYPcOzCtN3eGXt8HwpdtRMKEGB+wfGcdfkjWT1uxXngVGv6?=
 =?us-ascii?Q?LfRnNLDO7IqIvRvNudZCi7l90a8VtpOunvhzzaSkOS5Dqx8pWshrWfVmjlz+?=
 =?us-ascii?Q?2kbrvbj0A9aT04K5SgFlMhSDzKyZIVLhQB7rtA2WrNYiQyLr3pu8wXEGzXeM?=
 =?us-ascii?Q?BktI5Suj96DaxSOBOJ63Bl4fBxU0e4g/3dbW6da2rKAT62s6M11y/48jKdAW?=
 =?us-ascii?Q?vWesoTMq/nLj/96/3U33+ZrR/asnkTBX8HuN7BPkLeYGtk3OmTSGS3JM74RZ?=
 =?us-ascii?Q?QyUe0ljORFMj6LkWKSkS/didEg7T41DW/VFMfd6ZPqsWCNuHbFqpbdJq7yoN?=
 =?us-ascii?Q?GqRk1H26+EaZzkwYeR3NwWsFA9fhm/n6bFVn7jx84ycg4avJ2uzAE+FdWVEZ?=
 =?us-ascii?Q?CHbtNt0/dIsz3qwDKvUszZ5XJ6Xp9cpPVlixsOeu/41x75DgNikznWMz9GMo?=
 =?us-ascii?Q?G7LcNscfF557bWZSPTU9h9j5muTkddx22eiooZfEPIS2svGGlDKeRuJerQnI?=
 =?us-ascii?Q?qR1JNm6FgAGr9mipuvHeYu1gy+uP3KNcOw7QcjIVvfL1umrLNkhHWcrp/S9j?=
 =?us-ascii?Q?pmAdtDh7QUJSlqzlZDGFBTOWMXHYBrU7zjX5/8d6ECndTQyFPPKyTQWCii+Y?=
 =?us-ascii?Q?x7O5BObHDXJBwEidVpHC9YZwwv9BJDPLW7p8gWBeC1OGd8ymb0tN/lg0Bje9?=
 =?us-ascii?Q?Fse/agQphEIj742S19Yk3hMziWfkOgCgH8T+WTT70m0sri5cXnLE8iOboLLV?=
 =?us-ascii?Q?XV9y1d6wRxF6vfRRbiaIdzvP82PyvzgYE2BH2VhuX/JqzydMFG4f/htyfMHO?=
 =?us-ascii?Q?DFdqmZfRb0yozNG5sg5sosgUq1bKCO//zLPlggnmE4By1vmqJ6J8UfJtZqEX?=
 =?us-ascii?Q?CTpM6ZyEY5SmTNW15dzptfKtLDPybuNxkZ5KpfT0uRJQa+9wrihcLfOjgnhQ?=
 =?us-ascii?Q?++7W7L4S3K9+4EAxpzZhKR67ErX7xuv1tbegvIpi7kHK+zS7ACSkEHfHW45g?=
 =?us-ascii?Q?mZdTnhIFpgVNXocg8/sLG4uPScVs5SaiBe77wtQdbXaDtvaZndZOv+T/3fSP?=
 =?us-ascii?Q?0Pnsz7jJ0LZaarR7opipyhhpYjaa7LVzArTPMUdWSx0LkLXswd2hE7oKIhiA?=
 =?us-ascii?Q?WaXiUusq7vXXr401ZltX3ef+xR9VBKTKy4z/gLIy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f133e6-a6ca-4819-7eeb-08daa481f9a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:25:37.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M2NZ+iQRj3AmLSExGQWyfGrpM+ycEdDUP8msDjimR5Wg7226N1XoywEcA3UzBVIOEjpB7TGhaBeE3PwAjaS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

Use msk instead of mptcp_sk(sk) in the functions where the variable
"msk = mptcp_sk(sk)" has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7108eda00b6f..a8674b431593 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1612,7 +1612,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2242,7 +2242,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	struct mptcp_data_frag *cur, *rtx_head;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(sk)))
+	if (__mptcp_check_fallback(msk))
 		return false;
 
 	if (tcp_rtx_and_write_queues_empty(sk))
@@ -2924,7 +2924,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
-	if (mptcp_sk(sk)->token)
+	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
@@ -2983,8 +2983,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
-	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
-- 
2.35.3

