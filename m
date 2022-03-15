Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE211B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647327532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfAC9capa+dG+XD2hsj1t26KCF27EscWhUfjnUAQ0G0=;
	b=NogwEMx9zVDntPuHEbuWgAiqhjVLxztnpPXKglzX7Fh6IlK9T7Afq6oVM0nO2Dt7mUqGJI
	42BH1AtVuCW/2/8nbtYBdfYFdwZfYO/UiQj3Q48htnVsQHDlWDdxr/M+9YZYwcWtAg+n8J
	ICBeHGSl7WUzgLYDpLod909jpd9fL9Q=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-8nC72fw5MkikG9ZyGLURhg-1; Tue, 15 Mar 2022 07:58:51 +0100
X-MC-Unique: 8nC72fw5MkikG9ZyGLURhg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElPAfs9T8Tch8LQZetvoxCOfi/Rk4jBBb8USYeE6YMeCGCgo1T0bWSTv/2WgzBWjRIzOAGNSvT51le4+7I+tlSdEpWRYowR72/DfnQB35Ap/GiYw1IF52DfMvge8xOkJLDg6JhYvFkDmv03dCIY1rD2CVKOXLaj9KavECsKCKd57zn+N4T6/GipxNjjcVnGbbYVxQGcAE0euW7BDaCZ3pq+qGLerSV8OyywTR1pVtizSfmL9JX9JZy3SThyrFjX7yM3w1sIHhKou183zdORTThFY5MVpzoot/8YC781mmQky6Ce5Ul0eg8r8PWsPwnFJTP0jGWFVCsc8Q6/t1PQAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg4NsWCDGlx9EShkaxfNB/t/1lgKY+sl/WyEBTWM3y4=;
 b=c2Z6qr8rwB79CdUIa7aNFOftys9si6SRhDVv4PkHVWOqmlLX9QqgIf1h4Ruk5z7DTyy60TxqAKcx3040NZjKU6Za3+LTb6Px/ip0sll5Mm8at6c0taP/he03ID8z6/0M+MS6TpgvnD8Y0MCYhbnxY+b63M1FJcPHUnQj5iIqJVL1asSOlWT+VTl9cEbKU0KW+UOMtMPN0bVm+BzjjwPp/CuAdODrGuKqIHFYorWMf+b6+LIAlCS/U/tlQgxh74OlrOgONiHlrL1pbKG56kggOt0hxXKwtZZNxJLaM8PHc+Q9lqa0gqswmEyvcb9g8GC3vllfaT4GhbNbrnrG7VltzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3138.eurprd04.prod.outlook.com (2603:10a6:206:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 06:58:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:58:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/6] mptcp: add MP_FAIL response support
Date: Tue, 15 Mar 2022 14:58:23 +0800
Message-ID: <c00f0b57c4d6890d04d47d31502fc13f20473176.1647327162.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647327162.git.geliang.tang@suse.com>
References: <cover.1647327162.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0180.apcprd02.prod.outlook.com
 (2603:1096:201:21::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4674c079-19ea-49f8-04d6-08da065142d0
X-MS-TrafficTypeDiagnostic: AM5PR04MB3138:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB3138910DB2988EE655BD6111F8109@AM5PR04MB3138.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SI4JC0qrhHohPrUmm3NvG0EM7FBzrggRCsOioz/aWue2kmqazJn5r+Gw/aQUIRGv/bzyasV2uE5Da3yw8Kaa7FI+WYx4qmnpHo6JXgEYopV+QYg3vU0YmnEsM2DR51uM7oDyIg1ggEAV4DYBarOyDxPi7OVaUccBg0788sKO1GpxLoAWDaahXNbw9t0m+T4mr2nnFmX5zWl6KVi2YgxAwL4KGo8bFSmc5JE8fOSeLvznRJ02Q1ZTN2w21gmAyBPIS4cFnqvWDWYNaDlJncj8ACgJL4ROTpIQMnRVIs8jp2WVCtnBvHihDyEPeqk6OzErDm4rqNfZXukiH+uRTH3xfmOCH8AqnPTvNSmtn/SmcqiFz6EoeUwUGoj+vF9Sj+W5CE4vjkOzg0H8l3M7Kv+tz1r0v/jlzjyUPmP22dDeMHNakh79mL4+/xe6LRe3Y0LhB6o+5qflSTyLVrHEC8gjw96t7rFp1xI+/c2F80ndCRh9px62LzVIB5GMUfohR2QsYnUK6PAUFFneB98gnMXHn2W1lrUOwoyUvwkelDJKOU6XD1L8sRaosc82gQ/v4MZHgWBlzKqn18F8np/U5mD3qV1DGWsA0FODfV506SAer3t8A3YXlcBTHdUJxcy8KNlV08NB32kRznzJqgOnjVjMIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(6666004)(38100700002)(36756003)(6486002)(5660300002)(508600001)(66476007)(107886003)(83380400001)(6916009)(8936002)(2906002)(86362001)(44832011)(2616005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2w1uQgoobCsBr53h663sU5sHkm6dzx3cpFJtmnK9Ma1e2uzqjwF7btkVAu8?=
 =?us-ascii?Q?o4i+V4at/b1kwYuNjqeGZKTbR7ByoDK0ADWuMcqAyACrBoUeiF86yFfLMLf7?=
 =?us-ascii?Q?FYHaOPyV7il7lUiQyKwsS7y/UHJvz6fNf+auajgcDSX11S5MPW+hgbCJt7mZ?=
 =?us-ascii?Q?/b8XJOkTWOCS0f0vv1YnupQ02CEECo0DrCJxgXmfOC8llMWxDFFUQ4luv9kn?=
 =?us-ascii?Q?NW64r4NeXw9T0Es4c3y+U1GsirmMR/C1vbogyjicLbHE5sql/83wlLp8jCua?=
 =?us-ascii?Q?CekRPbARY2GpBmJ0xNWXXUoqqYxpHi54jYdvSmZa5kiK7K2eVvaOI8dJjdQZ?=
 =?us-ascii?Q?YHJrxwrqIVcYGHjQYt51SQyrTnk4UVLXxON+y8oSJzpWf2C0Z1/uAGDB17eQ?=
 =?us-ascii?Q?/WoqL3Rrf2azKpkbwtKKoRWSHEj0Nvj3zeKpzU9Yqq9gnl5zQS07g2U0gCkY?=
 =?us-ascii?Q?jMjShv7Nqsd+5GXRBG6xb9faMkHXLNFtE2+gruGn+Fv1T+QJi9glSEmlLXhp?=
 =?us-ascii?Q?DL1ko/M63187pE4Y2f0/j8ydXbJBMY8NRcWF3tLw2lOv1zdnDdTwK49simcV?=
 =?us-ascii?Q?5Kdjnnw17Nyx9aNN+PLWWZWJxqonxZ3o4T8nUmRKbHlAsjP3MGHQl/x1HKxc?=
 =?us-ascii?Q?9pxHM/7dG+1iR6hJRo1067bAZfVuNXXN2e/xRAB5UTpjD4xOZ7CLcHBJRXDl?=
 =?us-ascii?Q?5/RF9BGzw9lgEF6BvZMDj/Q427IriBnj+eA1Y2ak/Up8voypsw7cJa58W8bd?=
 =?us-ascii?Q?XQrwifH8sRkM/+ODc1ycP9yYxvz+BfXCGU5C1L2LtQU+QIzAFhNfspirT6zS?=
 =?us-ascii?Q?xpGt+Jzwzriog6Gst2DUsxoyskvQ2vNvHls0EHL9Kdd7hpruR7IKmNjReVYp?=
 =?us-ascii?Q?zUqH3M+zGMMAWf3Hz0BcEmB9kYNTvIQa+Sq12pxrOKTtJ31SB7bPDMKl7f5o?=
 =?us-ascii?Q?Q7Kkv6X6L7QqmQhBp/QVi6+aHOyH+7bI/RYeOVXrS1R2E/6/muBYYEKWAzG7?=
 =?us-ascii?Q?0eHOI4iDakokgEvpkQETWTs096o+83W8cOYmRFB8vLHfzOt+QwRMHK/SlDJ7?=
 =?us-ascii?Q?ApTEIiKs/9gmGuNrViwXVHv5j4Mq7lP8WAlNdO1yi2VSxCp49yPPwjbKqkhH?=
 =?us-ascii?Q?8aqH+DPRD4qv0U3jzjCSqlYOC8Zuwk8aBUZvvV3JJsb+y9n4ShExyXCbdbgF?=
 =?us-ascii?Q?sBetzOcOP8JeFdeQHGiNdNRGtljt5Vn/KRRSr8wYPpRY9Bx1j15I3UdgTsfR?=
 =?us-ascii?Q?eHfRBj1umuRkVI1zAFTggSWOjHBWeCXbKHrs5vD4c8okd9R4VXHSf3cj69eZ?=
 =?us-ascii?Q?2+RFXUdg/tvbQ8G4wYHUaDQX1MiBImbywbE9EShGz3120TwljYoFiHGhSGPW?=
 =?us-ascii?Q?6gOBoLq9FbtfHS0sTDUtxyLMzJ/e9FiH6KTuo3SqM3+gKwuV3KS984OvhFFg?=
 =?us-ascii?Q?fZJDYW9CFiBq214CXTDbr2x7Tp4ElO3dTDbcUaklzYuipQsJ9/0tWaoiAQqZ?=
 =?us-ascii?Q?3bc1cvGetbAdPtVUwV9XREY6AxbWL3rS5A8wcdZ9tiDngEtkhQR1TtXWJw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4674c079-19ea-49f8-04d6-08da065142d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:58:51.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mPnJSD7UIAe7vIZ8TSOuKeFrpMkkAZ3UdQ2gPgRH6Aav4qnUvKa4ArFIRSdvBSh6DMMwMkZZbRXP5oh6V63tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138

This patch added a new struct member mp_fail_response_expect in struct
mptcp_subflow_context to support MP_FAIL response. In the single subflow
with checksum error and contiguous data special case, a MP_FAIL sent in
response to another MP_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c       | 10 +++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..f5f4561f332a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -279,8 +279,16 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fa=
il_seq)
=20
 	pr_debug("fail_seq=3D%llu", fail_seq);
=20
-	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
+	if (mptcp_has_another_subflow(sk) || !READ_ONCE(msk->allow_infinite_fallb=
ack))
+		return;
+
+	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
+		pr_debug("send MP_FAIL response and infinite map");
+
+		subflow->send_mp_fail =3D 1;
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map =3D 1;
+	}
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..83f0205f0d95 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -456,6 +456,7 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1; /* local_id is correctly initialized */
 	enum mptcp_data_avail data_avail;
+	bool	mp_fail_response_expect;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30ffb00661bb..ca2352ad20d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1217,6 +1217,8 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
+			} else {
+				WRITE_ONCE(subflow->mp_fail_response_expect, true);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
--=20
2.34.1

