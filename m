Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8992FC13
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BEr1UYV4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ/lytoUlDJjSEmb65RP8i8zX4v80FqvZ3tfJuPHAcFPJN2JnPQ2w3puMRXVT19S7/AyDPwv6CL0Bwv2KpusWGEPhzYJuqX+pmgdVZrSS6+UxXAoNsRqhHfBgqdQtj9umKR5HrKymXrzHpGfCbWDP9wBUqVFwxLhDgm6S7Z7xl4Xi6lNLg0A8ry1fx73zwp/9Qhq0nOCw/sYuBcqS2rLX1r2qW8bb+TPoMjAFcwPTN3iK6IwTJ+M5Lo07sZaYnrukUO/dDejDbc2Tyh7wQhuRU7Kkqbx2QHa4Nq0zwS+oxsjqijLEJBm5uJjylEVW/PmBWcP1OXUytCUo6RT+IfzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0yS3cDi9k1TVhY/Z2tsvNEnfjIbIkPbwwTd7wQBaTQ=;
 b=mXXuL6/D2RZ4ADQFx6goLGzib17eIV1k01t1NJ6iTXqUuqpONRQaHNyteCnxmv6T8pg8Jjdlg18AQZrCKf0iKiw8RPMAvsgwOQ+s2cCiJcRjvvI+cSPL0e/fG1V2+XWe+6m51/x2GkR47lCBOfEjrdfSZyp01h2NSpMyjyi6SmB4rQDtvNRFznUoDBlyj2h/AUICBje07dLtZQauiT7a2+ArsQgtddyUs8OMk0S6gnsVcwl0dQ7+jBB1M1iBsZ8Lv49FO3n9VxXsB1JnExiDOrgqEHXzqocYmoJI3PlnRaYm6/0l5EjoqRJPnI6oiojF0o5c/7Ltj2XmVc25o0NP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0yS3cDi9k1TVhY/Z2tsvNEnfjIbIkPbwwTd7wQBaTQ=;
 b=BEr1UYV4Pf385PceQpZr7AsD2bav0zXu1TS3fi+bqgykTOmSTmIQ7jKyrpKJXPLTQoPFDKOdUQpMYYWGAV4uaDK346pI79uWpNA4pw9QcROLeozx0/QWYz+lQoz9RavcDOQL/7UyI1t78SAQPYg2Ix/W5+Ru7hg9yA+ykD5PDWHnSTiW5tCqIQSiEZyMjjHeYHX3nq5gSNEuMt2QAlD8YuCR6YQR/vrE1qydiSzQ8F4sJAtRaIjKx0jdV5IwcrSkPdWy9PcEu2qHMQgmhbV8bCjykAcEvG3TMw19ihjZ8IDLsrzA1A3bRB8h6Z0/kvhOD6uKF2QGC+8/XhI9NlmUVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:51:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:51:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v15 2/7] mptcp: add __mptcp_subflow_disconnect helper
Date: Thu, 12 Oct 2023 16:52:00 +0800
Message-Id: <b152bd033bb04508b40d74151402a1a25075c50e.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697100600.git.geliang.tang@suse.com>
References: <cover.1697100600.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa88cef-e29b-4e67-c0af-08dbcb0066d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sEbLIVvyeS4nd2GrnlXO26rNrn8QqprzMbKbZSJlRA7Cew3MjYcjvWPjQfm082QZ18ZRv3W9sjG/2/UtBXO+0xwMrqKVVUN5LmIy1B7FwoqCtsDpy5xkOpzgegw5hmz99acr8+V9jnVjuG1PBsGlPhsnPjKaK5dogETrYwyvo4fCUwmiwJYU0OunMYSbPNlBYZPKQ0+C782hmqExOS/6jpbqUGpEHSEXnPr9M/4xpSGWvx7fbB3rcwY0GmbB3An981GvErkQhLgyjsUkX56thasn9yUB9c7E+XZR5fme5sQx8c/P8+nM/0DyPKzuOgm/4s+06/Au4fMHvjhrNYozNteCvt8I/T1DiaJzmmU2wsSw8c3b8S3T5rwKNu40IoOy4w1ZA6MGgJyyhi67rHF82wT3uKFhs5kxVsJoaANOzM1EZfgBtGzS0cmBKl+AD3l63KW2Jb79uydUlDOvG+WQtnOk4efDNHhFAtiePDoBsW5d67jaQUMmPutgekD4Imo8uHOkhG+jSejmQy7S99elUC/9gTRvEk5bSsqvjLfZyFpFjBwGDHtHiXlkZSaciA69
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(6512007)(2616005)(478600001)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(6916009)(316002)(54906003)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RLRWfcx2VbJ1XeTeu0kTSJkQ9j7myglGPpJMTwzhrOZ3zZet1UJIxkgezp6F?=
 =?us-ascii?Q?OvC6+2jLb+zLfb/1kiflJeD/QwLs354vg7spZ43gLbrjsHjApjp8/pe5o/sS?=
 =?us-ascii?Q?vGwWeQrF2rB/jTHuqioY3sYLY1beeqi78bPT56VcrCUpP09D30F6H2Cx90ig?=
 =?us-ascii?Q?xXUypOovXMRL/Ifj4m4FPW9QpBU0KiVqIUaQ8IQZkYmZJZwole1h0bVwDgxV?=
 =?us-ascii?Q?lItiWh/jNtji3WBJ7pwWArZS+ci5jJsXO0TNaljskVqXHhm94Y1ykZ1EQLwF?=
 =?us-ascii?Q?AOz7tmFBgOTr72TsX/B0RagpbECbvhjhBes/+6q16sdkfrPqnpS8MCULuJLo?=
 =?us-ascii?Q?EU32kAH26Xm32PuzoTwr5LCkYsmRfqFKhlwKoHKOpFoLnzs25vUltQ8mQ8ed?=
 =?us-ascii?Q?e6A6HWF6Yyh8UboMslXqJZQs9kYIrnellZWMMN6RPDPk3lmxWia1j8jiCpTE?=
 =?us-ascii?Q?anNXUCDTA/GR5TOYhbiNE26hbpeW82b7ymlICHcnCMdp60NP6PO52CHQ49kK?=
 =?us-ascii?Q?IAgAaAHiu2eQMch9qMqEsAsZrwBWlEEOeZAjkLi2pwBPIbTbj029Nbl7xX1S?=
 =?us-ascii?Q?J3ZCnk/qfwVG9Yxp51TEXr0KRnLWYksYHShGfywEwbKWCaDmKxWWGpEMApao?=
 =?us-ascii?Q?jngrNii36RUAQT8er5AoeeOk7oolnMXMHFomNmwHN3MSUjpPuoMxADkTEP+Q?=
 =?us-ascii?Q?o6K07yQOBdpcch8PbpSJ8JnhidOPAks+uSHGjqo0ytdVWpOgNf0DUiiopf87?=
 =?us-ascii?Q?8/Voz4VTW30K5vo7awIJ9OVGMdwdU9eZ61+Sx2kqxhGF3XOUCubUi+GfSF8U?=
 =?us-ascii?Q?GxYvBdOmyDu21zgi+kOXi+0CvXqs8TGeSh9nTEUeXOJcs1gcgFiphy17+sVu?=
 =?us-ascii?Q?RBO5Thhzp4tK1eKkBPmU/7R/PkCrDQnZ709TV3RBWpy5JMFAAP48Ok5O69HK?=
 =?us-ascii?Q?689EeC2aQZy65U0aAlCoRxDqiXpm/iss5C48HqQ4Rhmv4RbdhdukGuYzK4wW?=
 =?us-ascii?Q?yXnAfmcTb7U95krl8pU4R8womsKSqe4r8n9ke/0PK3ZQtIkyA3y7GOKM/8tD?=
 =?us-ascii?Q?+VT4CUlKL2DXl5KQPT/4t+4P+PIlXcNrFtXz4apCOnGppYIgQgv+eFsfvrZs?=
 =?us-ascii?Q?VyXAjELS6uc3i5QTO2dEuirUIklWT2Lu/c25BhF7rgTMFj75rviNZ0WVdjOn?=
 =?us-ascii?Q?sMwkFxTu/6kVC6jJ57DccYhQKf2Bt9bgqBP5flrZXKAPaorGw6iy7HJX1bdB?=
 =?us-ascii?Q?3A2qVT0zdti9Xgx0pYQirLjkSlH3CbvpGBSNhyphMmQSbclGdzjbUWcMdFLf?=
 =?us-ascii?Q?N9roeKDPgneuXF9DU3f92bxZv/WB6xKxuQPnonjRCTtX1Xivv62kL/yw9NtU?=
 =?us-ascii?Q?k38GtFwMFdfmNZ5y8tOLl33yx3ShbjlAhun+mBTmcrUKLlXy6hWYpggtqFua?=
 =?us-ascii?Q?4SyYuBny8BjxfZoEyOFX4FzFxeNZeMcbgL5BEctm+J+3prZC7YsjcpE46+3C?=
 =?us-ascii?Q?TxD+gGZXrMwIzOPdDg+yzsZe+hq5Z6xqJklelkNBf2RRR6DXoss/lsyx0gSG?=
 =?us-ascii?Q?vHYbqMOx/Dn3JxPXqGTGorvXu3jEa5h23GbJU27Ah9ZAGdL7aUCRuqCui8sW?=
 =?us-ascii?Q?NbrleKh/lB90EKukysniHTE4vCn89jf45qwjXxykQ3dP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa88cef-e29b-4e67-c0af-08dbcb0066d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:51:19.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfoZHvt+OmfbG2kbySfIAxHK17w0I0FJ3aO75AMjvmjlh8cc2JFx45F7PKkCHnopVT0Bz0HPxQjkLh/zB31XEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

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

