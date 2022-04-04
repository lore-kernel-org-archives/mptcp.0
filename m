Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09A23C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCAUJFfZTvD2CW4nAOu7enI6uiPvelc1FWnwTpfq47g=;
	b=iOXhKtTNboGKSqE++0uV1O/KnjDw7QibRVVmuRNowcaGExWB2YpVImKtiTXfFG1NlOerUY
	vPaOjUgGBQ8LJa3PekKKrNRon4TwmEsVGmR/g3GVo8jyuQ3LjIbcyzPSi7yggCksN0FCz7
	Z+YAOkq7vrWeFnyaNEMIPb+uFayU5tw=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2054.outbound.protection.outlook.com [104.47.8.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-DxilCQYWPe6BkB-yIUAMlQ-1; Mon, 04 Apr 2022 04:10:56 +0200
X-MC-Unique: DxilCQYWPe6BkB-yIUAMlQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je4WHA5K+P831hXn9ygIexJ/q89yjBj88MnZim9aXCdGK4e/fqQpgBiSSpWo1Z1nruVSDLVxaQD/cBq+ohzELjgbKuQ/lDAk3ZAtLsIv8Hd8FyQ6OjOEDjoMwbJeIMpgwG5zbbQNcur5QOr2BGYXZdCLRhcs4VsrOhVM053j1LIoORmSS5OMwAVzi+9n4Qn+1jbm3nRKaKp25X9SOEnhz2VRA2fbTU/I6eeZTueftPlSuZ1fBevCOfZUKQcSmNvI1L6gJ8GTPao8e5b+CFLyfe/sGYAM3rJB+PdIR41ZXyeZi3zoBnaW2HjLEUppcSGo6lGPok/fSCHmp95z/hPdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLS3s8l7b2dNdNZvl/u6To6L/wlvIU1qXwupFWTACEw=;
 b=YbggU2QdcmSiWG8T13NsQoQtvu43U87JjtTfiFndzOOlrkVzuSEVpcIm7sruhrJLLzDumrO7hPHwWSAq1mDmlh44oFqnyaEfYcTyQuQvc9jpQv5CCV9bm0uos+lSgndj/IkPEh4/sdRBnJt/upVo765UV0LlpYYJxxfzrPBwrrN9Odak4OXoYCGbAmNVmGVXRsgoV4gmAPqYXe7wCh03f4Ubke93vC6GXrnYJGNi6Sbq1LIpBO/ePQ2CdnCY4dO+mSIKZ+su25CKGaCqKNt0EOtOAacWkoduZDNKRnRpnWSdHsyjXN6TObDt5kxWBjGyXwPsOm0yczRZn4eVEYnxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:10:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:10:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 5/8] mptcp: add get_subflow wrapper
Date: Mon,  4 Apr 2022 10:09:57 +0800
Message-ID: <34603ae4ae8d42e145594d02be3625c1c0e0c551.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0168.jpnprd01.prod.outlook.com (2603:1096:402::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fb83c8-a040-4fbc-b19b-08da15e059cb
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB718952C23933C2C4145AA641F8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7/mHWObHdPS/O1bwfCVdiR1YDbMudIr3kCmIykoPtdi1oOXKqE1HTogb+hYLLJtTogcCOV/NIDcsobMsLAwdvFcFh6Jtg2PvQtbKnzqHjhwMHiO9VRxCPI0l7Uylqz/FpemgIsjofqb7xpiuVw/lFmgo6dc6tQBxtvFq01lt8NFowHQAmuf3vbRkzM0KgEF/0tHPzROPeed3NqssoHpUsEgY3wt0B2WQTIdO/gkBjRGRdviUeH2HKc17u29YIxY3PZh0cMn9hrYWHF2sGRYewdo/15OB4KNXB+ycNJzxmgfCGIEPKA2wuoJKdaY5F4vC4ebL5RNuRKZLHpGAsHeq1fjOQFJc6ieHWp/9qlSa2t5WEBP4433dYc6xgbE1elKlJBaF2yjB/h5WQ20PbdA66LZHuRN0b2xpp1XB3qn5U0jJlWd1XZwIVoASaX0ivVvTHaE8WBsDNPa8+blprdpIwrLp+ABlamq125NXonyn5tzUzpPGHVcLcaEKgEsYoehMhGmc6dbjilugAWZz41X8rhRm/rgWktYudVtVBxId9W9HfIBcNBHYrwBOPBnv5qVndhbGc8iiWAtcnfhOE8lD9Djp/D1xhLS/RaiBB1BCJS0X4jK+61AaQ/LsIWtpGAL3T2N7YJidLfiBloYyuOIFWrclafb6EkaqJpgwPVwYSdsaGBwZj1Ed/++TaZhA9gJE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?59l3Ph/95hPtWr5fN7+CkKFXEUSDPDI/o1Wb/AvXT+d2JlslGtKix1jLTqpz?=
 =?us-ascii?Q?6fpsW8rukHZ6YcN7ve/SaBPzStO/1Li1xz/bM7OOhoTy7+VZ4mIUfriB3hh0?=
 =?us-ascii?Q?f7RCQQ+gu6RcinawZRiENOEZR4+O7hZdRbySC+ZP9346+LcgTSloL9t5aTPX?=
 =?us-ascii?Q?ftdKe9RHnah7q5f+tp2H+NmSLFYjiFi/I7/zQlwFkT8pYTfiXfxtF9pYSh/V?=
 =?us-ascii?Q?uEWSAumcMw/i228PkssF7N4DqqIGkBqqHKIQrkm76KlfDdQyAO3V5x/xk2A6?=
 =?us-ascii?Q?mY6d6SV5BOgsZDf4Sk/OOXm3PweKiR5+c/ndtER5I8egD7o0UHNyGZnQItJc?=
 =?us-ascii?Q?rYFY588QFCzZI4JLczim88ExHOfwIJCBaOxZDpcCFL0XkA3CjZpKUm+atVMg?=
 =?us-ascii?Q?0pfsCvy9cECvnzAGYY/qfwRiKHNoxh9oDYdXIke6/EFWMz/2mVbNe2dXfYJi?=
 =?us-ascii?Q?Glq7cAEs82hLCsy3lz6BLTeXD8wOX+45y794MjGos26ehbBkdaBYJHdpM4Kb?=
 =?us-ascii?Q?yhjp3n9/Pfdk42qERWzuH0fkCc5qrhXSst6gXVryrAgzESzJvYn5ljn2mTer?=
 =?us-ascii?Q?3NgN9cwHFu7hEnWkZmPg+pmOSAhiUnqsTbk1K2rs82J0EiC2RlyOYwwwXwaf?=
 =?us-ascii?Q?4X2gO99WTPoQvuvuW5zE/2luXAePcMK8ibHPwt9jYPFpzLIoH3vNmoZ33vAn?=
 =?us-ascii?Q?P/aqGvJlvwVhwJgJBaHvaGwTenB2vRt83YyGdNjhzpHHegtSczjrVo9uSjpY?=
 =?us-ascii?Q?73uJDq5v8q1st2Hc4CL6ef1qlmdNNsDzdxGh/TdLV9NK85B8d2A0j24fvehB?=
 =?us-ascii?Q?TkcY5x+IwdP0xM9erhjx248uFVjHeTLw75aEKxee7lgf5z16tanjdcOKbPp2?=
 =?us-ascii?Q?PXKl9DFWJGs+avI3siiyitWVM9GuPRlsLhLd7s7Tbq8dCdEMu9n80Bxw7esa?=
 =?us-ascii?Q?YL06ofV2vno6WOThk86wWqHTnOdDoRM+zVwwg54fKvOTXqlGMM0IuKpf5vOL?=
 =?us-ascii?Q?gkp+HgH++MnH02g1MMQcg6oZs50IrxlB/pRn0Ro4027qVg0SKsKm0gFrf+sT?=
 =?us-ascii?Q?mzsHtwpztFm34GC45rNi89rCQrKJ5J5BsAxDRt17YMG2sXvNJIuOuoOgx8vy?=
 =?us-ascii?Q?ZpRnCoqqNZVpptxYjlz+NwKEYR6UtQgQRabIJ0gyD3tP472EYp4eo8U70Lzs?=
 =?us-ascii?Q?V6qp2VJ6xkGdDpXv0rdkjskdsl8X3uAAShfRdlvKw8lgKVX88nqwCo4K6w0/?=
 =?us-ascii?Q?Fqfxg8ZCBEw8WzmUMGrOCc5amBJMCSGkB8u5WjV1D2neHCCtPWfaTDHeZm+8?=
 =?us-ascii?Q?O6Gey6VBOnLD+SsywaaOLaq5yFQYP3PiBYcpifeZI1jhaGHuS6JSGN1/qaC1?=
 =?us-ascii?Q?fFwN8GpTXWAlDfYTKy/S1ECtqk4YMI5YRDKP9BjW3SLv+wyaveGJbA84iI0l?=
 =?us-ascii?Q?XOiTM/nYNCw9dtU0Pqbwd8xUFVxTds4FiII9qJbSsvJIH5A6ec15G+SZq/X8?=
 =?us-ascii?Q?z18wa9IhFCI0tbx8oxe9bR21S5qS7PYs67kTyEvTQYpB7lini9FYN9vD3mtz?=
 =?us-ascii?Q?tt5PiOEcIKGiI6ZvBeZ/H+fVD2rlHZ7DZ2TdBigoC8dULd706B4uwadm0xbG?=
 =?us-ascii?Q?8Lpa0e6UdERjWSqSWd/4ruGSFV/DQtwrF9i4eySECwzDRHpQ58ndy3gMhEvf?=
 =?us-ascii?Q?QGwxHSDPMBYN6AI9SCF7YG9IEWAkiY0pt4mF7iSfxLeyXNPSAADnyUydZB6d?=
 =?us-ascii?Q?W6irvEWlJ+wt36Ai1OeCGaB97DSUrRU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fb83c8-a040-4fbc-b19b-08da15e059cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:10:55.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wByCvOxYCKwaGY4LZqF5UTlteMlodmhSoBrCRAgMcAsqo3eTIqdr04KhQhPo5PY5gf17rBlsrKpj7NJ7IdHw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow() of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Move the msk->last_snd setting out of get_subflow() of msk->sched,
set it after invoking get_subflow() as the return value of it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 7 +++----
 net/mptcp/protocol.h | 9 +++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 37f4f6f3661d..c9e49b2561af 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1507,7 +1507,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock=
 *msk)
 	subflow->avg_pacing_rate =3D div_u64((u64)subflow->avg_pacing_rate * wmem=
 +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd =3D ssk;
 	msk->snd_burst =3D burst;
 	return ssk;
 }
@@ -1567,7 +1566,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1635,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3137,7 +3136,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1016dac065c8..3caa1a08b7e8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -619,6 +619,15 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk)
+{
+	struct sock *ssk =3D INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+						mptcp_subflow_get_send, msk);
+
+	msk->last_snd =3D ssk;
+	return ssk;
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

