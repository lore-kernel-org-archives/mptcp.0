Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D032C80
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHIoEQngxxTS8Zj+lczwXnx+sqlyp66bjyD95ldHVD8=;
	b=MDC0D54xG6GKAsGa9nymWcd1ObBFfR7m/R2MYURYVmA5NTI+0XxXerX/KNjUv5+JuFqZiT
	gnxezGYV9pbW0mvO5fySVWQNxnvhrV1QKdgNUkkjKiaw4N6VFAp9D1o4na1QY9ptaujfUT
	9XOusZnH5XqoBEpg4EQhPcKjLXiO0QQ=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-I7AvH837NVKjBiC29X08tQ-1; Thu, 10 Feb 2022 07:00:28 +0100
X-MC-Unique: I7AvH837NVKjBiC29X08tQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK0z3GOSSAtMz8mh2cFGrqA/ohLDcmLCsIXnGzy6mnNiFpq9nedv5msfpZlYgaERbXihbRGdd5Q9WclYl4ZVAgpQmJ2/3+pSAEV7LeXxoYgkdOx4G+fSMoFkHVCzNN8S6vgfpE+AOfPY2D9yLPWoFirocF0FE9rO2EinHt5wRtT/VdzXYiIxQF7K+E4CbLmTrJmQeX1GCWWEkdBNhY/3EkiD7wNrnl3N7AegAEp9RKQN7GC8D0jkMmFBgbks8E3Ph74r2GYrwGT49iFjL8LZLpRoPdxapdgZXvkWuLwXj0OYutoG4tLVe4NCsp7IJIPFKPa1giNWaxvAQUtPhfQs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg4WJsQGr4yLxe1BzNPIO9wyNDnShHWops5zccKF0+g=;
 b=cq65ROf3uvupnD2UWcJOeEjzNfKgX6GnEAp54B04bNMUhjYUti5zZbkBDXGWcw8s0JfNK7md6edV9ZdErhAplv1aiOm7wZvfe+2JvsCdEvM6Cl2E6sGWXresSlQtySu31CkSKw5uZRGAgdoNOI3P71q5Qn+OPwjN2VjFbKkOUE3FjVvdZYCo4YVzSumWikB39tDPJmUFDA4zXiTcSIlx1CK9yOIPgF0478+tF9MI2bAcH+hOf08YHzWAKh233VPLoGNdkxLIuRh7tBc1vQ7Nr9Id6Li72PlJntKtd3INf4f6DIgYnFKrokL/8SB5UzspDFG6JN20SHzjtigzHAOOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:27 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 3/7] mptcp: add the mibs for MP_RST
Date: Thu, 10 Feb 2022 14:00:27 +0800
Message-ID: <5f2be7491846bda35304550db3dd00828c5afc68.1644466571.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb77a351-a0a0-4c8b-42ed-08d9ec5aa2f0
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5761A9AD23A8D27B752D655AF82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xr8WcWI6wUpZlhsdJ21A8FrCLQr20vkyFA6h6nMGobaiGma9ELNXDTMfhNPOhu8DgLO1WyMcZl5vX5eeHlSMBPgmwk7CbdXiLNHrbPNtf/V27sYT55qu06JedSuKuGV7mpeKJsXBSz0KWGy+wVHeV+Hn60Db8mzlCqew1H976Tftvaz9YBBU6sLtatYoN6x57BPaubw6mrvdGvJ94L7pLD2tXGF+jCx8KBiD6LeFnr4kK83BoTXMcYZj4Ehk32y7d4M9fRn3tRqRjk7/aAoq1hQPSDUgboIXDXYD4jHNBtXyKEOrja6HX+kr9jijzO0a2u0SUFn07wQuxnnlEJuxEbOCioWBGH54YVVVXiwrVijYo1uCWQBCddB2ML620X528Eb7q6DhZvx1vC0ue4mB7WxStdMm8TurCU+iZJ2IUrpQy5C2HtFss7Nvtim5AUcbPO3qbFQB/iPqvZOQ7Ytdr01XqcqYrSxkjtk0AfWYuAEy5KtiWwFMeMP64gZzGr4e0calOtBGeMNMYyq22526pjne156LON2SBJ8ClTTzgfjLU+2AFgEzRu8u2yxLJhFuJM/l3qC7RY3w4k6p+n0GxIttTzz/XE3Bnl6bgKef2M1g436kggfa/htLTLrlDgZDwRIfq1CVyazMZ4shgpJBRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(66476007)(66556008)(6506007)(8936002)(8676002)(44832011)(4326008)(2906002)(508600001)(2616005)(26005)(5660300002)(38100700002)(6486002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BuLUt3Yt4Ywij0mOpDc+6G4hhRdRqaKCY23IQvzl6DnhLWqOnrSoLVK8EEo6?=
 =?us-ascii?Q?wKPreWAOz3wXYAKsYsJO3trQGm3CRRgtL6e9vVzq6E+JVXmAmrW84MhqR3nS?=
 =?us-ascii?Q?hZpfbaa/M6f17Zl7Fj/ReUWnYKf95xot1qgYfCphK+IWUo3sDlj07NitOfGH?=
 =?us-ascii?Q?0GNnnjptHzR2PO6GLVWV42pbqjOytgcN31TpR1WzHvpwgu80DYn93XbNcJkE?=
 =?us-ascii?Q?9djjouFj8I6yoUyGEPTOR1MytroidP1zYCcg5TvQHy9+chlahk1LC0d0GzZ0?=
 =?us-ascii?Q?4haaPQF5b2BrVyJARqznZ/x+b54DdHrF0J3DMATPk8zIkwUBWC9A5FijkHOt?=
 =?us-ascii?Q?4HW/sgvBFBmK++of05GrzyWGTPBJib9TBpTcrFXQDbZmsMy3zlKLZutLC1Ib?=
 =?us-ascii?Q?kkSbqW35FnBU+VPxtVv6vwNAzOxUlH7H83Kkq7GtwFyPfZy2SS4UaT+5cuVi?=
 =?us-ascii?Q?ptDiQ+fh07CTePNZCr3JW3UKAQ21bL6Lhj3jrHQOWAQi7EEETu+hMKYJ7BYr?=
 =?us-ascii?Q?kcp5cWR4nlcwordBGyLJaSZ9D1wiuj5aqDuh4t51OfmTnHECJHce9eFHgqk1?=
 =?us-ascii?Q?f8J3g+iEUjlCvWzNsPvxrNhu4anhdpyOWGmtAJRGQsvAS8HiLrzOyp0kiABh?=
 =?us-ascii?Q?/i13zOZlchZfdBsDqHWsNsnAmfyytOdiQoVI62nhdm+dJdwkJrnOxu5jx7k4?=
 =?us-ascii?Q?eQjZgXmt1xBCfcn6fZZLSJ03OQhMuEECoG0bT0uJGhL8TsETnKC60f8qb6Ia?=
 =?us-ascii?Q?RyNaHVE3Qxm9cYjRxI1yBZDiReE1Cvj/5sImtmTCqNLtBbfOTEPCt/sr0b1D?=
 =?us-ascii?Q?DIj+XLn+DS038QobeIu1y21hZ6cYn3YKlvfOhORVIn7X34wk2PF6IpkJOebW?=
 =?us-ascii?Q?JP4YgAHbcMUK+4fBFlAnMy7MS9pUerjvXm67ygR7zt1T4rhO4+VoMl0CzT9G?=
 =?us-ascii?Q?OEmmAI4qKUrbDqKmC9wzYFCqlm+MoShHdkNvi4ReWtJndKcJoxi+fHfiZ+Zb?=
 =?us-ascii?Q?CY0kTsOr5HJ7I9eHxWbCqPNDghs85M496Ub3v/nt836yRdSb5naubVSY0NL/?=
 =?us-ascii?Q?dMVNivaClV3DhcgxpScCiidSwHO5JxzKD3Z9rGy+h9AQLCmdzbfC3OxwQ7cQ?=
 =?us-ascii?Q?FfxPfcOiZcnpj+Buw+FgWRuPOTKXUuUkVvMZeUf369iBImgKc6Xs7TFhRWHv?=
 =?us-ascii?Q?MDBI2HC+ndh0GoLr0avwwWJytMfLb+Z4qCZ8xW/IPEyZc9B3Srxl3SpIsefP?=
 =?us-ascii?Q?DhaXmk93Iw+p2XC1EyN1POlePWyI3gg3SPNYxpoOAbNsybhM0Dw+jOQRwb08?=
 =?us-ascii?Q?o9RtgHjzJQatxYmo2W03TwOrGqUpB0zmHf48ZkNGdx+ndPInNi37IHQw4X0T?=
 =?us-ascii?Q?te1dufNoFOg/fQu04yrPgWpDQ4uUDJN2X9ZQXEfmOWLOk8UnCE2UJ3APZx+N?=
 =?us-ascii?Q?M4QzHR3OyshGp7NP5WUEFhfnIEWqkPdo3Ccyed3yfIz1jsfTXBk5L1/Vucwb?=
 =?us-ascii?Q?NXK0XagA8t14bom9hjLfx6yf9w3DizpqjAJ39TCx8CwFh4uc0gZTCTNoVPBK?=
 =?us-ascii?Q?gANQWQu6lD5KcApLwtK2d4vwNT52PgVZyPGKhmG9Yr52zMGMFbRhUVRdydlI?=
 =?us-ascii?Q?DDvUfWL+/lxNwOlEbsMdwJo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb77a351-a0a0-4c8b-42ed-08d9ec5aa2f0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:27.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBbhLOgHqkodyBccUkFBIQO1IT1ev6puGblhedAQ9mZ+S1EvHFbUOrKuUrMV04+UjfMMwJOsNJKGpufhH+z/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

This patch added two mibs for MP_RST, MPTCP_MIB_MPRSTTX for the MP_RST
sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c12251cb0d44..bb7808eecab0 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -47,6 +47,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
+	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 7901f1338d15..37226d8d5339 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -40,6 +40,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
+	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
+	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 670364cd455f..556d68e0e50b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -838,6 +838,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
@@ -1159,6 +1160,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
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

