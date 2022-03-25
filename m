Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B028E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648224796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L113C1CyIjigBHSG3Ku25ohLRxwOK7rng93Vdk/CJjg=;
	b=Ygcu9nu2NgGQaS5A7VRHnZTxu48UZjAhc3gTLUo0mEHW6aCF9w4BjTGd3vCVe0v8xbeNvV
	nyOSOCrlO0jSvj2x3Km0jcQcGFRjCfiG/RjlyUtt0RZCA8CmwMt58oa9CpKVinfq0wTGg9
	rBUXcjk50XL6r4YmwI8pSeoKjtcvBf4=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-y31MRWJ1NjqA7R9A_S7eNw-1; Fri, 25 Mar 2022 17:13:15 +0100
X-MC-Unique: y31MRWJ1NjqA7R9A_S7eNw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXNnKCDtrhpZ7dqg1uLbOnDCzNBQQD6eO4rCHRxGbrHHfE0ckh6rMfzKLJmADzFgiup9ta04kiBoUkskP58KcL+9KPyRZny4e4kpUIF2BQ7ewWTkm1Tg56xKbtgbCDu0WjozeQBNkFjDU35IxBPvAjoFEdAZYhdF8Q/bD2ltj5rHYCIjC828zDaLg0Ikp/5GfrSlL45VgEu1pvNlCC629pGa8EnswUkJTc4pm89LopsztULfaIS4QjH3dtJffkvvJuv1d8i6sZbNvVUdloqydw/FxJtRBt8I7+79d7XvcWPaJP/LRY/3x0Ck1C9VcBG09XMlJeWxvISXFEJWNf3h5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyK1m92KGgv1I1oGgO7bR3/zPiwamjdS6o2JFjVrnqY=;
 b=QkNLtiOKemWgDUa9V5Px45C4ShSrJsQAn8DCbFGMkVY0DDyp4dWZeRW2S/cG7ost+guhVnoYPxPUQYKJlDAtZXvWxOC4S50Up2BW6TcLqVgH54w4X3mpaP6u4A1xupsBYTDUOU5NAfPmXEmPctig7j14h+b2YY13JkN0P2D4U2BE2vuvGLI3ff1w4f1OH6G+GKc011PNzdDvZ8YVA7as0rDeFP3fyqT2Z4STxDvlNzKW2ZwSURJq0zEVikuNXrGShag3Ab4mVmGVnXKYbnNWGnEOSPmZ1sMbGRvPubROHC/7aTa6kLCi5vOqPXhvo50LVTejCtYEwEhWTHhVh+8jeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3938.eurprd04.prod.outlook.com (2603:10a6:208:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:13:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 16:13:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 5/8] mptcp: add get_subflow wrapper
Date: Sat, 26 Mar 2022 00:12:01 +0800
Message-ID: <da6436c3a362f92d5d575c52887051c60a1f1f0a.1648223504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648223504.git.geliang.tang@suse.com>
References: <cover.1648223504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13893a06-3c22-47c4-9659-08da0e7a5d81
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3938:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB39387A76DDF376FA73B146D7F81A9@AM0PR0402MB3938.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hlb+gGzEKV0RVEaQacZTKju6MrahmBjwUAdYEpqm35rS4pqAaq+CEzPmaRJv251rsvaKH6r0eVuZtpJWiAVpnFlgMi+o2MRIPp0i4hw1YWhCi2LuMFkscAj9iFN0IG1K4Ky+2FFk5+IU1B933eLHA2zrKAwjNLnrHMi3nlXryHXoK7zgfg3n9XOe62xUclB4xBX/7Xs+Kc45p2epr73hjhrSJccdkX7GIdfMAVK8Rh2APIgZEo1Ndet4EAL986cIQZqPE0PFRBoLixMieHw9VO9p311xcm2NQxMxb2PuXwRi50inLht22FpnAcgZDvXzV7vHhW97gQxiOToXib1OUPSWIK7TEmf0hXBmT5mZZL0IrBZauoEzgAZ7pxmWAVpemXWQKQAUvlnYDtNQtsZr9b9Kcm3U0e03XFflLJjW/Ifkae95Lv6XjQHYBCQhtZ4kwZlXQuTKId0Kn5G6scunK3iri5CLpzDQd+glMNP74N5SQp0SkeW6fiXwUWSauWR3Ecyzz6RiS90hbMU1vpxNMEYvoSIZIuk2oGwFFZvJrR+fRHM84gtt5xx3C2d9TNMT1Y8LZpEqPIQZShCci5+ngYc5C0ndX+Nep6B8xabn41QyJPrVKapkVTVSOE9FPRWKNBzw9v3qmxEsZRDROkp5sMGk2BDDMiCwL4DK8HdF6Uo/Aou08hREDy+f0x/rBm4d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(508600001)(8936002)(186003)(26005)(8676002)(66476007)(66946007)(2906002)(38100700002)(44832011)(5660300002)(66556008)(83380400001)(2616005)(86362001)(6486002)(6512007)(6666004)(6506007)(107886003)(6916009)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gZjVS4MwisNZvqUZlXaXBi+QUG4lsU6CeKggC4kIxayNkrDUhLqf0/r8tqy5?=
 =?us-ascii?Q?g914AOgUyhCTrfkRGKt6J1Dl4pWH9LXIUo3yZ+tEGTQZy9+HLdhwKpngzHdN?=
 =?us-ascii?Q?Hc6qMe7l/oosTE1ZxwaUsAM1tuxykDvh1SKbLWQM4Zjxz1a8f6TNiLFKGbcC?=
 =?us-ascii?Q?N77Kqc8ixyqXgDYXnCwDZ6v3Mlvur0R7F3StZJtVMvn6tMsgPKNkGxAd+q5l?=
 =?us-ascii?Q?4BOjZJoBezmVyjtRZoUNB/MylNFmvWj1+xUc1yAOsRMHZ1rVwdV3bFZvRSpi?=
 =?us-ascii?Q?2ifDO1vGC3diQ/8YtE7Vat7adwsMfPHnSS5/Fq6fX2xLKi8R6rOMVxoDBVu1?=
 =?us-ascii?Q?gv2ZWbvyJvsDe3bMecZ4bsnOoJqgKhsSIeLqfjK8OItjaGQ1EaW2IegKKBbz?=
 =?us-ascii?Q?7oELT6V+uihQqsZyRbSpBPJk0WIv88CpXb9QUVeY4b9RejGznqxv4MVM4bVu?=
 =?us-ascii?Q?3A4zrgvdrhHc8MVcSaPykcqozAqL1nqZi5SAE7aYCPQJ4r8+BFJZz7coYESW?=
 =?us-ascii?Q?9q20L2NnxeEgIOdiPxUt4eHhiR5ik4642D6YUbdCxNnzUSj+hE+ufhTGMF24?=
 =?us-ascii?Q?NmdT5BBhDZzYCnhk9Y602PCuQrplt0HxHc5THiT2+IWNOniPg0WDWVs1xMzc?=
 =?us-ascii?Q?OGAk03iIg0N5GFjigtLbx3mjnCu0J3FF3Yza4CCiQUWSj45Il25JBdmvaxFK?=
 =?us-ascii?Q?fXk1WUNDp+LPRIDgzsvJea/AEzqLdmN/5YtLiNeva5Neq7tPGKM4AYgWA7Fc?=
 =?us-ascii?Q?+rdURJ31x5E+38kpVVyQTjHay7+H3O8jHMT/zynAwkk7fZRWd1SymF5upxF6?=
 =?us-ascii?Q?JNMIVIjk28grHhRQt5ly9+tYFjIGuSN9iqLJ+QiOf/fE430Gu6hUZkHA9bWY?=
 =?us-ascii?Q?ao5sPlM2PAcbQ7EAgEJDxXVtjpEU+JLH1Wxt2BpcLWerdl73rJIZuN63gKX+?=
 =?us-ascii?Q?B2dW0pl84/UxZaCHp6cr/2BQibYciaFDiMlaFK1hiIOaS8h+J2qHO4aoicCS?=
 =?us-ascii?Q?RPG8qukP5hlYqWsQw/OOo8FeVaGa3iQ6jE1FZLKDo0MyP3Taf2UBHal4ex/A?=
 =?us-ascii?Q?Ddpt+Sxv8FK0gWeuAR/h35x03Xdl1ACOP5MF9OWlL3j13jTinp1dRyYtre9c?=
 =?us-ascii?Q?Wg2nLqzc12FJhancGSjx6tIx53NLouhLn1c9fg6+nwS6B9aJU6xzsfnrY/lW?=
 =?us-ascii?Q?tUwFI0y1tILAIAjk8UNqvvOb4BhPOHMbao/WirnllBTBTrE988+/BlW8RDjz?=
 =?us-ascii?Q?cMQa+CKmPROTPOw8mpIdoP+Nq6wBjqFHjqsieczdxrlnEftMjIa2s177qcnf?=
 =?us-ascii?Q?9/DQI0QCVdchk9SI2uVCr0AdalXvTzYG1nYvKchomUSEWfn4yT9EgkP/glhG?=
 =?us-ascii?Q?jHVNL2Tmo9uPgvymklJgvfx0Kv7ba/zrbgZwBGc2fMuVBSt5OCc40Gw/BNv9?=
 =?us-ascii?Q?nbBWcLRy/q1RCucXkQ9ahzTOWzUAnUDFwWWPeypzkNyygBbCWbh+TIIVwQj6?=
 =?us-ascii?Q?NjR7yaym0KB/bOjboDJeis4P9fCpYv6YSLHPZmFIMyVnWom3CVITB4q2ETLU?=
 =?us-ascii?Q?D4HSoKjRynEg4FAW50Jjkvb1WVl5vw2K7zA2NnRZKtRXszM4QvNVeS9EfsQW?=
 =?us-ascii?Q?TiSo0oP5QlMD9PBGjL7IvAYY9ggRCEcrkx5hA3uuLisaWkYJJXBdrcqmjtF/?=
 =?us-ascii?Q?je0RkqEM3HwLJRG5OWQW1cCx3Q8zaPUd+BABDVhRNq+J8p99xSoERxVZJ22R?=
 =?us-ascii?Q?+an0boXEErQ4ID1Iz0zuYcqEsjEvjes=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13893a06-3c22-47c4-9659-08da0e7a5d81
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:13:14.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfdCFoJAMkmblfxBemhWGxJEmKCI/7RnjPWAZ2gQKreAMligGOmZN2/kT+GTuRM2YNG9/BwA78VMxgqrMaCX4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3938

This patch defined a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 82b3846147a6..7bc7768f63e8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3135,7 +3135,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
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
index b70582f9c3c9..92813aea0f12 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -623,6 +623,12 @@ void mptcp_init_sched(struct mptcp_sock *msk,
 		      struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

