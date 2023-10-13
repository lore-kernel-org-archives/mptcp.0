Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB7290F
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hXlCq/n9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np0Hf2TAts/DHVdRmby5Um5f4II5ID9fAya47YhJMaLsl1TFxJPCGIQ6iPONur3/gmXWaoYHMoAZzej1pJUGTWg1BpiFtCbwTYd1SrWjeUE7el2JD7dhTzeydQUeT/3bj0o/00zFywqV2sDWYx0yNpBejAodkjpVvVsiGTZe+BCi/B+IH4HDW1tvRY4pqo0D/Iqon0R9XUdPv2AGTzFXBba95TPjvMz+1+lWVpCM/hoU+uURkTVK1wXmiEK/pmEQ4Mi1jU5eD3EDG/Nzd5JhnujCWKijHO6AWXtwjMJG809UtpYIHLIqsFy6wVjFmSjCAas/YWiXn5XkonlBF8fRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0yS3cDi9k1TVhY/Z2tsvNEnfjIbIkPbwwTd7wQBaTQ=;
 b=DrD/HPRWssmQG4+I/ZN1PLio6i9OzjxW0XmZKNLYPbPiSrKP3udo6KYVv0OKjEbHbWcgxhQIGSd6ONAXqKeEc9NkII3CWzNeb3yju3G2I8lC8xcCJJ+SDJnKFK55kwT/aETnw5ni4I9SwpGxwhJjm35JOs/tEW/3iXuQeKnebCZO55wdDSBQIsX4S0BbOhWhcj7gizVMUAWbzyuO046LjweNiu7BWg12I2e3/aE7GysERn1Y7vqsz0dVlbLJ1scVdOGZ3NFbrOQJrmJmnrsqB9rAkzFqUmiU/xg9WjFpgfqJ1mCsupmdSNLY9TV/Zhlbhwy6DToADh4JUdXkMm05Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0yS3cDi9k1TVhY/Z2tsvNEnfjIbIkPbwwTd7wQBaTQ=;
 b=hXlCq/n9fI/68s91GCVUgJmDJNJGHk/Tefbbb0XMrevLoLJpANtzqjMAUWzwiAFWFxybvnRhMlu/upPoYk3o8jJw8QujgEezMHZ3kteNtDihgFg2ut8ZAszDuHqeakZxA4ppMBF+xB7SzdcOtP0ByL0KEPdQP3KkHdlksixSgQ9c2a8GpJYkcYnIXz7cv+MJXHUqaHxA4IwxJ+Fvnl+eqY3XkuPhZmTFgZBvnQvJM2FCG0D14QKrfNRaQdsVHIXCzGv3GbV9RWNl3ZIQcyTgcbZqydUFefj/im6A9gBGChPttiu8gIyjoe6YonnbOEY3xAJBkSXynX7mCzCJZ2qO+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:45:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:45:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v16 1/8] mptcp: add __mptcp_subflow_disconnect helper
Date: Fri, 13 Oct 2023 13:46:36 +0800
Message-Id: <e70739acb862dc2d7cac8be0fa745a8a4aa0bfc3.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: c3341768-047b-4784-db4e-08dbcbafa749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	98Cy6fOZswwiCVlrJYPv6q2fZF2G0CqX4QutyCxXhvFiEelXFadm6jqPSUJlULMYsBQjdi9K5/FZmFB9cm+pJjDqltWwBNENupniYw1++pE0DqsoehVGO1BJtqlrFCj53YEKRQnCf/3vXT2/kg1Zqys1lwqUL9Cg1hCbORTjP1oxJpl9v+Yu51giFkaVOyqN5J/fsmQ4vpXuyZpVOtJLm82PrN1k90YJF6Q6RKBW+zsw82Ih4id9EkTOUaMXgaA8RTfUUpGIkALsLANG1nKNLRHpVnNjMxpmQhfPlsygo1B1gla0qEPBx4nHBBXM4ZwG4s+c1jzXhEbZioQzzTYDBuZU25oAigL4YZ5Vr+8h9s7A+CG/wHslTRgzu062X0RCkPpsgI2Atugc0FQgWNAFzy4s2xch7SeSCZ1BRpksLA6zvUzhvMUmKR4LDJEUWCP0N41rcYf9/Cxh78s8hYc3luRbjTpmIx6NBf/8NPO5ujb/fXpBCBTQ0vT7pBwz0gK6vPssaTUABjtTyLY4+5iPM2EOzLwh1/dyccPmXa/kgpC6Vr1tESn1OekfGP0S/HtuvB2tGZcLsojkEnsmCwzvVsvJoqknRrkvsNo7OXhymI0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(54906003)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DnbL0kMsk2SxwuXe8HLjku7we/UeSSclCknkisq4mVxxhknyRBi8oTMvmkSU?=
 =?us-ascii?Q?Lr9U6qk6PySeQeLP2FT4IYkBQUolsR4vD/szuiIGxM1brsmgFpUOD0XeXIGd?=
 =?us-ascii?Q?lHbk6ELsfa3NTGu1cn79QtOiAJonWN5DQTcAZ4y/Dd/KmdsWkQpAjDELvBTf?=
 =?us-ascii?Q?qrs7WY7JECJQh/sRLSEgqHxhPZ/U5DiFVNHIWRSeO/UxNTE4aqMg68qHH+X8?=
 =?us-ascii?Q?B46JRDv2pz55gIVpSS4LMf0moxFoe73tJxWNDgFN9bTnuLmcH1MV1ARjT5Q8?=
 =?us-ascii?Q?ltwqAD2NZkqgilY/uxd0fGBUnf5PDQsySbqv5WWhLGqb6DVWZWnkX+Yl4x5e?=
 =?us-ascii?Q?2p9kPWodRE82ioO62bMOHBwjkZzynqwbXfsKvg7AhuCaKktJaref0P4jl4Hb?=
 =?us-ascii?Q?yDy5inaGIb2PyfI03J5kiksGV1NFVcp52OtIFJpdQZd0zo475Ft9wlVx/gIc?=
 =?us-ascii?Q?Q3AbxwIh327xWxgtzRKDWIX20BwYpbNsBITTL/TnT/Xfb87tjvdqQjf0GpgR?=
 =?us-ascii?Q?hXaU3CiW5Syzx2cSS0bXANv96FE8/sHAC5TsQdipYsF2vAU/OxfBZTjw0y0C?=
 =?us-ascii?Q?LPDpg7EG1ohKOC4wtz8y3N3R7YfIT5SKkhEZUEMrw9XDvGS386+5pS9uBmLz?=
 =?us-ascii?Q?CynhIixsD43qdn7HbYyLVV3f9frqLBnGPLcHdqBnodBUNRQ6Aa5MOZCZbKWn?=
 =?us-ascii?Q?IgMivaWfB60XgB3v9eY1IdULoU3Rk/IZRo6PA72nT7G20RpEv0NxlPT8+bRO?=
 =?us-ascii?Q?6R6iVZfS02HogjLg4yapgJQht/tK3DmFwCaSKF0aDVrsvqqpAUCr/S+0DD7h?=
 =?us-ascii?Q?gD8UlXEd/UtHE+BsGuRj67vB/DNVP4zY9zI7Xr6HJC4tMyES6quSFbx4R2p6?=
 =?us-ascii?Q?1+P1yl4PaxPtZZSsM7v0YRCEI3qNlnDrRaVxf0UTkdrrmV0k9USaHmgeKZdG?=
 =?us-ascii?Q?Q3+jKfij7PhaHqhvddUXfVAPNsDhEp83RA8ASe8BxRc/emGm4dvTDUrMduGj?=
 =?us-ascii?Q?371EpY2Xh0DmTWbyznzsRu5LPRXiF4uUl8nGUESwh0RA1WJKvycgwNtrR6zm?=
 =?us-ascii?Q?/IksijVDnG4JN0P4e3K3pSWlF1DOukUx2V3tDIvr6vc7I3y0Jyy2jcA2Ivfg?=
 =?us-ascii?Q?KBfnOPuenQw1E2Xlo6Axtk77ss0g/GrmgI0J/STno61hKlDW9s8fRUPbCtX1?=
 =?us-ascii?Q?Ao0v0LmtJ5eKnw1cwzRRJuoCETEMbonRW3V6Tla8JmYbLfrOZc8rIEYDHY2d?=
 =?us-ascii?Q?m7ZNjZX3oD092ZtsghqwcdWw0ofa8oKilLKWdNiLRM21CYHAkii3LjI6R2Zs?=
 =?us-ascii?Q?jBqpC1NOomEyBZhdNKbK/0P+bop8WZ+D1f5NT3UJRf8y2pBDjuTHCmVWkOKn?=
 =?us-ascii?Q?WeeqejSAbaV6Z9rWrfdtA4nQ/xQLg6nGr3gSA0V07WUIalgUkBJhR9zL9Cge?=
 =?us-ascii?Q?ly/Ky3JeVPU32lWKNuWZ2zALO7x0TjfSsUIMOmMgcFag7mPqc70Q07wpFLHu?=
 =?us-ascii?Q?DqXPq0ayyIES/rs2/Mg2dIUYYntFrcSvJdZmJ9edizAQmVgrYSGxQ2UMfnbV?=
 =?us-ascii?Q?YDS9seb5xSvsKnfVUOlYdWZKfhjxbg0CEjn29EN6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3341768-047b-4784-db4e-08dbcbafa749
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:45:49.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjKDvicyIjNSsleCvI4HnNPh6mjnNZxCWbLM1Ej+vXRFZEi4rusl+/PMpLAyK95EYzBq49Orkg8AhN1oLxfTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

When closing the msk->first socket in __mptcp_close_ssk(), if there's
another subflow available, it's better to avoid resetting it, just shut
down it.

This patch adds a new helper __mptcp_subflow_disconnect(), and reuse
flag MPTCP_CF_FASTCLOSE in this case. When MPTCP_CF_FASTCLOSE isn't set,
we invoke tcp_shutdown() instead of tcp_disconnect().

Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30e0c29ae0a4..1a54d55f8bb2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2366,6 +2366,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 #define MPTCP_CF_PUSH		BIT(1)
 #define MPTCP_CF_FASTCLOSE	BIT(2)
 
+/* be sure to send a reset only if the caller asked for it, also
+ * clean completely the subflow status when the subflow reaches
+ * TCP_CLOSE state
+ */
+static void __mptcp_subflow_disconnect(struct sock *ssk,
+				       struct mptcp_subflow_context *subflow,
+				       unsigned int flags)
+{
+	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
+	    (flags & MPTCP_CF_FASTCLOSE)) {
+		/* The MPTCP code never wait on the subflow sockets, TCP-level
+		 * disconnect should never fail
+		 */
+		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+		mptcp_subflow_ctx_reset(subflow);
+	} else {
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+	}
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2403,7 +2423,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_disconnect() path,
+		/* be sure to force the tcp_close path
 		 * to generate the egress reset
 		 */
 		ssk->sk_lingertime = 0;
@@ -2413,11 +2433,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		/* The MPTCP code never wait on the subflow sockets, TCP-level
-		 * disconnect should never fail
-		 */
-		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-		mptcp_subflow_ctx_reset(subflow);
+		__mptcp_subflow_disconnect(ssk, subflow, flags);
 		release_sock(ssk);
 
 		goto out;
-- 
2.35.3

