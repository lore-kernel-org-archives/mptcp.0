Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22277257E
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644682545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jf7ggTN1LT6SG/cNOvhxwM28cRgV+Hw8XKFdOc1RVc=;
	b=ig9c7tqDdIj+hOkv/ISmKUPYxhr+k2a8B6ueZtSzYNf6Q7R7lsyhV9KBgWEBZSjx49MZhA
	sIjq1K2m0HgC5YYvPEIk+jZOF/LIJlam3UvGZ5kOC5lJHrpiKfzUL8fUw9v5Ocz4xiLw0+
	hbAPfDFMIw7p5jjthTdpoOP+W+osM04=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-VvSFzIt_O2KRzB5_uhAuOQ-1; Sat, 12 Feb 2022 17:15:44 +0100
X-MC-Unique: VvSFzIt_O2KRzB5_uhAuOQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KneEKLrdD91c0s1szliQsj9m619X3M+h+uLuZHpAK2zOMu710g16sGVp+bGcdPi9FWxWxi1mqMUQzY/MUAYLtJF2JGgY9UegWVL/t/mHLsWEMBvkt4OxuVE96WCf0UA3GPZhauXOGGpGOCB9p6dvQfMthEmIlmly2EBk1kTk3GH5xDK5Yu/ontyimK+dRQRWik3AVft4LdtwAdpzGprAL8L2SFGf7pKBhVmYOZm3STqDsNxjZEGgQV6j1dos/Lr4oqspZOj/oGPPJ2DY82ZC0964BS6tPjgLXE4quy//SaS8TaEAyVweCEqHdTp32A9DR4ekmPM5B8NM5mF8ZMQGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShXKQr5iHgn2fGCuFb4q6GNG7TfB+X12RBs6VH66If8=;
 b=LgvvXDgsmwb0ideMHawTYiS++rPiJLu9r8wXa9IZ4Qw3xOiZMM4vqT4641pYTL4Vz/MysxRG0brMfS7QY/otyfmozq2XUi3HLuFu6hktUWMtgLtqNegXMmnDXvK9yLbN/s/ouXnpFhoRIRleip/B5GOzYeDZAj2L3x1eHA4Fzv0ERe8cvsyY97i6ruo1A1IzVPcU5tbZFRU9VIrmWhprRwYbZwooGmChWYUBmECqS7EtaUwQ3DulLagf4vhgK4E9KgXCjK27m/cisNzuIhjr70HD9ddSJOXbQ7BNASy8v5En6ONggnzia/zb65EJ6ebv9MYb9cMlHi5Km119cTOjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6548.eurprd04.prod.outlook.com (2603:10a6:208:175::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 16:15:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 16:15:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/6] mptcp: add the mibs for MP_RST
Date: Sun, 13 Feb 2022 00:15:37 +0800
Message-ID: <4bebea741f83c861ea8d95d4d319e19a3199474e.1644682054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644682054.git.geliang.tang@suse.com>
References: <cover.1644682054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3ad4719-b00a-43cb-bd71-08d9ee42eb29
X-MS-TrafficTypeDiagnostic: AM0PR04MB6548:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6548CD4C7C29A91F987E77EEF8319@AM0PR04MB6548.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NCqVZy5lSDdRDjfWWFcgz/iAFKlSt3z6LK4yI4n6BiUUd0jM8hk7+aRwFNu5xcueUuaE8BsIgXffROBkoWXnv+mbolgDft9b5DEqKPBorLj7TKWRZQyY5LPj79bR55ZDPn3CinWNL+IYHBkO8tsRDldVRFU/Vnba9lr9NLCyCPHpEmbEazjW4VeB51UXxN++BdapscK6VSu1egTQLdZFPYmdPUnbfRnupfmfjVAbxciSbGf6ctuYItYg9EBaloZioJ7b4KYazjjQxy1LMn2MoujZbenGa0uqWJF62x7b3IjUT8bXTriQojY8yyfIzlKPNfzw6sNHe9JXqScpilGxIXka7Vy1WQfc37tCduszScp43Uy3/FAkUko9Z/dyjuaSVxql3SzTcJlsqfGXfwp9ghqLqSluNvpTSO1BetVlJqsl5YEel0H/t9q3OVKvcJ7VuZjKyIMOb5rxjnj51+UvqKDTuWwcCLPBeAcZX0k+bkiCGZ7JP3ZWT4H9ULLvjSiD+gbPnuqW0ZXgsIoICfwoKFEt0Q+IO0VDb9J39VdrXLdBhGy8TiqVoTiVoBoXaGu7HNPIGM2qQaNBRXnuUHVV46GZ+2RuKAr2N9XqIYIPapXd7qvQLCiPYIbVUc/Akqlj0hydETkIryx1s97tBLPhODKowrdHTB2gikVbgCOhy0qzLxmKgGsWzviiw8+eN6K0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6486002)(6512007)(5660300002)(107886003)(38100700002)(8676002)(6916009)(316002)(2906002)(36756003)(8936002)(6506007)(66556008)(508600001)(66476007)(86362001)(66946007)(6666004)(186003)(26005)(2616005)(83380400001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6lJrInt9kSQau90edDpoM0JshUaDCKvjYq41agR+cKlL2ULVr7HuQZUp0+gR?=
 =?us-ascii?Q?UtsX/7LTZMdCfS2XCi1qs8mJy4XQH+MynXs9xN49viHK/MVfy1dCu3pqNWk3?=
 =?us-ascii?Q?QBEudMpncfPv6Ox/FhSfqVUwIdOmLrLFwbSgV0Qfeo0bR7OjZFCmjDegIXqs?=
 =?us-ascii?Q?NoUzOeYXBYytYhzEAlNmhLxXU90bU2kITuUyvloeRHHZHUxcYQcP/j77Qi2h?=
 =?us-ascii?Q?nuio4HtlUqzp7ySsEqNFTNVISvGvlJXVE/l7GGr6t8CA/YMr9jIhp3drm7wv?=
 =?us-ascii?Q?7uM0Qy8i3Qf/PdJ9cKqVkVaSUSFjS0YiTnu/bn4sRMRwnOF9ylWigALnRaCV?=
 =?us-ascii?Q?P9w1TczbC2wh64yeVSJcCsT/L6QJmaCqAQzsYhVL+UCqP6lKOkZ+WZA4h0sO?=
 =?us-ascii?Q?4ikelq/gloHDIk82S+eMcuWr1ieloYrnKFwfB29C1ZXNhkDn56JTuz30NWdu?=
 =?us-ascii?Q?OdbpGMUrB/2jCKCfKW6e5yl6das0w2vqv7MNFES/g29Ssi8aRTysphGmChEy?=
 =?us-ascii?Q?oJzv9itu3XxfCjaOrIqAyhxBsxviAmyzoEtrbDg+ZbwRfU5Z/Ge9ros/nqE7?=
 =?us-ascii?Q?IRK/kc3gPkKZgRTbnPnBm8UVRRMNtMmZg4h+XYxjerdNeQcLxNVkF0vVjad5?=
 =?us-ascii?Q?/tBx8cWykJWg/YU3nudPr5vO7nU5JPslSe4u1I/vrByAA5QQmnOgJrzel45r?=
 =?us-ascii?Q?yw66wrWhMRd7cQPnlM40vyxkkJhFP2z9wyOvmrEz+P7wbzaQ3GuFqcWt82zt?=
 =?us-ascii?Q?Vvz2PZm3Bc2a/FAMYuTbkeG00GSGNaLbd63KmGmwIWNtkz2UkAm+c/orVkC3?=
 =?us-ascii?Q?35V+qrEPoi2oEaSqDGLQMqCJmAlsbBETKu03RI0gW8II0+6Z2p6V9ejUGYLr?=
 =?us-ascii?Q?rYncKvUk3Krt2KqYIdXpY3jPizkKRbC+YTl/Wo9Tqmfi0JkXu//4awhXklJW?=
 =?us-ascii?Q?J4h7o9623F6AG9QGqn50MG5kZ8dR7sCFAid7RkiuiHFHdj46DUra4sTVf7zv?=
 =?us-ascii?Q?Boa0xk2unDf0DUNyL80Ie/XmWBy6qKyCRH1G4gK+9AYZbDA/+rxraQL/e0Io?=
 =?us-ascii?Q?Q8BWCH3G4xwcoPLhN65SALZXURNGaBNMjPkvOTBGDmMj7tNAx70De36QAR7C?=
 =?us-ascii?Q?daLkmUeWDb4aNmYPYxfGvJGGgmija5L5B/s8ELkzjPhuDD2c3uHxN2vXViiy?=
 =?us-ascii?Q?cVl+Z/rsxatphZGiowqJ0p/dUyIzt2c+3xbK+Pwkc3xY5btcpVbVH/P3she6?=
 =?us-ascii?Q?Z0xB+dZVbevnbPt/Es/E/CSaL7H0D5/DzR0tjsDLyC+8OVFvwLcg3gfmR8ie?=
 =?us-ascii?Q?fi6w9eBzQ9h7QRMXFT6MJlBnA2EBNUk6AtrLgK4ooJHf+s95x3nMz6pk4z/4?=
 =?us-ascii?Q?OeYt8iUpOwp5+0/FofQgDLIBLjchcd0yKO5ItKEJNMHxSkXveM6UEAR4tNKM?=
 =?us-ascii?Q?jZOzcMosO0NMGS0nx75qjnfXlt1CvyLf0L208e+iClEx6VEEz288ORwIauaD?=
 =?us-ascii?Q?uRKt3nI9Dp0KGeyzMEB9Nc45x/wURwl7aQ7gUqK1x1f0xUtpd6KordcI4h4V?=
 =?us-ascii?Q?eG1sly85XkafE9gWpjXNsVkG5DjIo8jd355jTGGgwNszki2ydaD3kPoW8qI0?=
 =?us-ascii?Q?b6WfERqMCiw2cnER9EJ6mRQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ad4719-b00a-43cb-bd71-08d9ee42eb29
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 16:15:43.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFK9QePbq5Ha2a5ikK09iKSjBIEQCTHoyVDI9zi45+X5QWwMdXwed3EX91qr58ob3aYM8X5pavhsfLZX1oEv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548

This patch added two more mibs for MP_RST, MPTCP_MIB_MPRSTTX for
the MP_RST sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 684643f8af53..d93a8c9996fd 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -51,6 +51,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_ITEM("MPFastcloseTx", MPTCP_MIB_MPFASTCLOSETX),
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
+	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
+	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 93dd5176fd5e..529d07af9e14 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -44,6 +44,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	MPTCP_MIB_MPFASTCLOSETX,	/* Transmit a MP_FASTCLOSE */
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
+	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
+	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e775d75807fd..88f4ebbd6515 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -839,6 +839,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
@@ -1161,6 +1162,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 			subflow->reset_seen =3D 1;
 			subflow->reset_reason =3D mp_opt.reset_reason;
 			subflow->reset_transient =3D mp_opt.reset_transient;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTRX);
 		}
=20
 		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
--=20
2.34.1

