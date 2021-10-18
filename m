Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2272
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geFu4KXYGHyMODhkl/ULu+RyXiw5j0EI88/Lu179FZQ=;
	b=ZVOkdsmg89BPCIMpRGVhSyWEsN3BnANa/2/MUXRoWYiFT+RyTnIlbPVzzplbFloU5eOVsg
	6oqkBcqczKP/HBIsZOLrxUgw5bZLGVP1aAlpCuLPPUtcI9Te0fBibgKG37ddGoOfJyktyN
	ZwM2saqBITHRQB2uY9u2bL7lbU/HHiI=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-7dXhw1XUNiGTdvitWVhd3g-1;
 Mon, 18 Oct 2021 14:34:10 +0200
X-MC-Unique: 7dXhw1XUNiGTdvitWVhd3g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUNXi/i6xxjTrHw2cfh7Jd9dXBGJDkcmtqwIZAuGYZ5EMMAwR6RGKrZX97ODkDrwAOaG4S9dEAwi0B34EyKNwNIZvqHll/tjwnz3c2s4KTb2nLVvdF/IYqZSriwDDNEtrKFtPcheALjz3GAr7x+dNuBqvfPeGMHCMrvAgFiygPVlWCWwqLO5lPMbQBIqmP4L0VA0nyY6Ep5UmTSmbW7I9Et34DspcynEwYIkV+WF3r1RE1QK54KA22VJOFNKYyc2htkc5QISQECSW9Pj6CGVJJ3f1Tljei4HUgbWOhpv5ofdc9LBTrYn5LMwJ7eekZJBiicNDSmvDyyDqGWpJEQHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MacGNwJD8EAQQ9iNDQpbU8cEnzuW8bT+d4vwHRrK/p0=;
 b=lGdXCO3QI8Nn48/jqOq2BNhzMnzFKlFppZbi05Td3/Yeun3DXqB94d8Ueoo9kGhEmr0NSEX5FgL7xO92Fv1SubIGfyxqHHwUsAuTU55aZN48b1nUZeYdUBBewhXXehUQV+GojVyFDmXjlrNTzDYW/ePhQJBoZl2qIEZvTI9e/P6YDH0rs1gdC0MrvNziT3DmbjEQSrS6uK3Fw4Lq8qCQPzTlIv3UgjKTX7LTWJN5Ar0vwHNVbyC7r0mYYvIubwWioj3PO1JZ6Ft4c/OrhVNmdrJBNfBBMZRGWusM9hrpLJg3Qxl7kKzXAGZcWTLzJqv+I4ooacP3i0bf9Wx5JNM8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3340.eurprd04.prod.outlook.com (2603:10a6:7:81::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 18 Oct
 2021 12:34:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:34:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v7 4/8] mptcp: infinite mapping sending
Date: Mon, 18 Oct 2021 12:33:11 +0800
Message-ID: <c3f8032ac11bb2592720d585df99fd863ae89b25.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HK0PR01CA0068.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Mon, 18 Oct 2021 12:34:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c65328c-1ad6-44b4-b180-08d99233944b
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3340:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3340551239BE2D51AD8D2B77F8BC9@HE1PR0402MB3340.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xKj75a/79PtHOPKG9Yqyygxo+AaK0uKAYLOdrWzkNGyY7fDMksbV2vjapx/LKYx1oNjcYe3P7PXCg4Biy+W4xzKlAdiBkT2GWaVS2KNkWZzzadsaIdqxyjaq4mjJ49GY0hdLbmOLUkN0uX+Q44n7vHIk6+Hizk771z2E0cLlZ1dIEWs39AHW1unutGndVLkstDHskvs0FudHdCSoZZlZsuGWBG2+mB8seCu/RQQsUN7D0C2tUok9dfbfyjIPiWEe6VX7lcizQVxgrBPG4g0HLt2it+uShIEnJVZi2MQEjkqlDnmS/ebkC7yWtcbI3mdG5Rq/JU36cOHNwG+neC7xZNcA1nNW9F+QDNHjZhnqWBV+j2vT9BdEhPAfCw9RM2Dc/r7TTViBdLjiocRd0v40k1P5RyUQ9xn2u0UZb502uknG1Gs6qwjAXKA4l2sKCjMBPByOovx0NlcJxPqevSFDnZS5m1nTSfh/7pLekx5h9kkNIRY64J6oq8M6kXSzHpJ5e4IHgn1BA98TLn4dv2AdyrYwA8YSy5IfQeHLL1oo+4J5pIu9GkBOCT7TLhnv16rNfU6i3PzNNxh0KXf5qf6Lw50NdTHNgNRKl0MhZHmeI9s8E2ZwPkdSfQAWLYPbUy98yUT7K/il+Tw3qVM4IeuPKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(66556008)(66476007)(86362001)(2616005)(2906002)(5660300002)(38100700002)(8676002)(44832011)(8936002)(316002)(66946007)(6486002)(6666004)(36756003)(83380400001)(508600001)(6916009)(186003)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZucIBN8eptZm6qt/+004VxUqcr1C5FdpqYWn8ghUasfdBmdHyGry4K1ho9JQ?=
 =?us-ascii?Q?eLuv97v7naO2nxSeC/8/Ndm1BpA9z+/CxiDH8ayFbDZgU+FbeClx0o937c5S?=
 =?us-ascii?Q?Ye7U80Bl49kPUNIo3VlJE9xBahT29fm4me4mpZaLPLA80Ripk6ZlF364aMUx?=
 =?us-ascii?Q?S9rc2f2p0rAsiUNwxaDMXFM53SfSLbYoDuGn58N7WM3Yb3kWHK2yB7jguOvZ?=
 =?us-ascii?Q?YZuueQUhNQfdstILpwkcvinK3nEZMMrckwt00cZCFD/h0w28Hv9u5/guRzcz?=
 =?us-ascii?Q?S9lchBVqzYJoXmD2ag0tj21zGj9zkGk/GdxLLEv6AQZ6RKFT5ktLQuX190ht?=
 =?us-ascii?Q?olUVU+ll550uNMyivp7bMIFz6+7RMYcPLBsOzwZU3306fMaor8OSv1GvJSUw?=
 =?us-ascii?Q?3ity4WEQIribx2UuE0/AN24vqxzOru9X4331NYMXEumyiudT163D6ULhf1yi?=
 =?us-ascii?Q?e98i8tKVe22K49sjS1Qcwi/z8c87YlVlf1/+h7TAFkaWKbo0T/knhgnTMnyY?=
 =?us-ascii?Q?BcxHyureIWhcJrj0rb5iLGBpr00tCkUn23XuAS7jStzrjkb6GNuKwiYzqOVU?=
 =?us-ascii?Q?c6IZY6EiKGlN/Uqog9FwUbc3m6ORRm9eGm9BtLnmBOc01ofZ9ADclKNcZVQE?=
 =?us-ascii?Q?Whxmd7030lwa7LrBQPGQLZDdinoMhsmN0GK+Ts3sFWnOxOnYCYTA4fGQqz2q?=
 =?us-ascii?Q?2x6uJ3XaXskcyI9UTfBU4BpJ62bVNXTq0wzar/3pND3a1eoqMfjSj6hW2Bnm?=
 =?us-ascii?Q?qYASNh2xCQzcIEeNzWCCmoGj6R6zvRF8NnKTzm7H2WmUXnz4Q1bdMjBxrku3?=
 =?us-ascii?Q?RkSmY9hTFERLC2LbiCoDrVp9bmDL3JPIUVKGarlFIKcn75JOb1FdygZ5DQtR?=
 =?us-ascii?Q?FaMsiQd7iCHB08xqUosPa3kG3AYGQ51erqpKuO9cIpYn2kU9Kbhm/h6UUNdv?=
 =?us-ascii?Q?V5y9ULYgumUzkZkZkY5psLushhLRn1A33mqXBZPnkPaxmaWeUsgPpiBSKgO9?=
 =?us-ascii?Q?NfIa7FM+w0lOqgQRJVGm+fSHhL5OrNUe6QmVTomHcDZ5BNiGWZ4qpK1E8LiO?=
 =?us-ascii?Q?Le0GJvzv12LhIkPqb3hl2WQu3hJiq884QRXqc6Zx4Ky+YiGKxJUJ2GxK7g8h?=
 =?us-ascii?Q?BWvQhd2Q3pBeEI0t/IFmApYMMbYZWdCuWBGuySY/kUsiSSFitq1KjGHUhyuk?=
 =?us-ascii?Q?3HzCx1y/3MeBNGXPTPz0i6bTQOHDua8ch3nVJ7zZmeUVrg0tApJw3ZIq0cl1?=
 =?us-ascii?Q?/O1yodC9ZZDvQ7sKTROBL7K582bcbPIb7zJhRR8uk6oPfWD6qtrrfK7ecrwi?=
 =?us-ascii?Q?eKLtpYbN3TZ3hZlISq7l4LzULCHwYqxk1/D36z2SDTdhDzIcyeie0WyL+ICK?=
 =?us-ascii?Q?ekntjkuw6afBodwFDTE3XMt9tTmZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c65328c-1ad6-44b4-b180-08d99233944b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:34:07.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++Eg8A3JMbS7iflkn4vAkdlCeHS2UehwYx67yMM1qLsrLyM1ePMN6nJAezon24kwB3UbHlGnst4K/etnA8e+sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3340

This patch added the infinite mapping sending logic.

Added a new flag send_infinite_map in struct mptcp_subflow_context. Set
it true when a single contiguous subflow is in use and the
allow_infinite_fallback flag is true in mptcp_pm_mp_fail_received().

In mptcp_sendmsg_frag(), if this flag is true, call the new function
mptcp_update_infinite_map() to set the infinite mapping.

Added a new flag infinite_map in struct mptcp_ext, set it true in
mptcp_update_infinite_map(), and check this flag in a new helper
mptcp_check_infinite_map().

In mptcp_update_infinite_map(), set data_len and csum to 0, and clear
the send_infinite_map flag, then do fallback.

In mptcp_established_options(), use the helper mptcp_check_infinite_map()
to let the infinite mapping DSS can be sent out in the fallback mode.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  |  2 +-
 net/mptcp/pm.c       |  6 ++++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h | 12 ++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f83fa48408b3..29e930540ea2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -35,7 +35,8 @@ struct mptcp_ext {
 			frozen:1,
 			reset_transient:1;
 	u8		reset_reason:4,
-			csum_reqd:1;
+			csum_reqd:1,
+			infinite_map:1;
 };
=20
 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 422f4acfb3e6..f4591421ed22 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -816,7 +816,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
=20
 	opts->suboptions =3D 0;
=20
-	if (unlikely(__mptcp_check_fallback(msk)))
+	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb=
)))
 		return false;
=20
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..86b38a830b4c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bku=
p)
=20
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
 	pr_debug("fail_seq=3D%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallb=
ack))
+		subflow->send_infinite_map =3D 1;
 }
=20
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3163647c501..70f2e0e212fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1226,6 +1226,22 @@ static void mptcp_update_data_checksum(struct sk_buf=
f *skb, int added)
 	mpext->csum =3D csum_fold(csum_block_add(csum, skb_checksum(skb, offset, =
added, 0), offset));
 }
=20
+static void mptcp_update_infinite_map(struct mptcp_sock *msk,
+				      struct sock *ssk,
+				      struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->infinite_map =3D 1;
+	mpext->data_len =3D 0;
+	mpext->csum =3D 0;
+
+	mptcp_subflow_ctx(ssk)->send_infinite_map =3D 0;
+	pr_fallback(msk);
+	__mptcp_do_fallback(msk);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1358,6 +1374,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
+		mptcp_update_infinite_map(msk, ssk, mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D copy;
 	return copy;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b9fe56bd572..906c65fca04f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -419,6 +419,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		send_infinite_map : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -852,6 +853,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
=20
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=3D%p)", __func__,=
 a)
=20
+static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
+{
+	struct mptcp_ext *mpext;
+
+	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
+	if (mpext && mpext->infinite_map)
+		return true;
+
+	return false;
+}
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
--=20
2.31.1

