Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD8257E
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644682530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KpuZVpzF+bAAVys0+PZ/IwynSD0zwCWsUrjCOfjL2U=;
	b=K9OZJdfdug7sZXStCd3MsTmX6ZQyDXz/pw7v4MRQ58BQfTV0/7KZfZeQA9zyf7F4pNGCZa
	WNmwHFlXl7Byk5dEr4I35abIr3I+twE1Mgc//zuaZWn2qBy/uSWcp/EUuKjq9/K8NsrpsQ
	WDMhY9GfO3J4QqiLgSimlhmIiXePO5U=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-7FiZQWSTNn-_FQ3EA6pLwA-2; Sat, 12 Feb 2022 17:15:29 +0100
X-MC-Unique: 7FiZQWSTNn-_FQ3EA6pLwA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNNEt3CSfN3y/p1ODiTmSLMvhikjNMQQrElZEa70iEGR69+uptW2Q+3CLi7IEIUcmw+cP/CH33iPrWd8d+esH7ixJ/JucH8KsZ1EuvUO0tZqwlN5UF3S5hxvqFalGQjw4JVH88r00c5f1QPez7kwei9tpdpqaENU29rqQDnPXpBYBOSlHrF1YeoNZwkiT7h1YL32DxcpObK5eMWFtwzv0ou2Y44djVguot8J3HCgSjPFwO4OJrBbyG6n49z3Llg4YJDOriPZ1CmET8FwW08aHbHh6Hd9upCgdhibUX/ULb1Y4IBYGAhq5JNfnUGTP6tN8nWQr6liIGDQ5JQyYdux7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlLFFyvqyQbeuKuGk+tzDgmSBzLiDDaUb/+MsZzTQrw=;
 b=FC3amyoHtg6iZ71zx7sTnDhwOUgymnwChn6BJ3xxQUt+g1/HNa4tmvZcw9ZlgJeR+Qkj+9NrFlUkW3vO9nRLUBje75k+NLSDpDy0x6gKoZ3vrL+mqmj2cMY+hIS+4hQbUlHA8zR1KGBGYzx82YwQGNsFajsOh/KfeAyUtyAvDoxBcYQQZxBXhoaV+nrlcPawD79aXHKeZMiigqg17Aq5icpNfbV04mRzx+9P8oGw4q7ifdj67vHe7HKdRl1btKINklcR5BAgzpP+z05IGNGeS5UiQ9nuGA9rxhosnBhQhpSBmvA8Lt0nM+iD8cyRl2j5NueHL67CC5/w/YtH2vY+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6548.eurprd04.prod.outlook.com (2603:10a6:208:175::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 16:15:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 16:15:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/6] mptcp: add the mibs for MP_FASTCLOSE
Date: Sun, 13 Feb 2022 00:15:35 +0800
Message-ID: <84edb0aef28c74422d902474216ad7add42c440e.1644682054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644682054.git.geliang.tang@suse.com>
References: <cover.1644682054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db99244c-5385-466d-e231-08d9ee42e268
X-MS-TrafficTypeDiagnostic: AM0PR04MB6548:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB65482EE6DE9DB235AAC14901F8319@AM0PR04MB6548.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8mXLWBzaTnQySb/WtrR+nfg5HI0NdM0W0mIXOcO73L/GRDKlipVrKevv/pvCBssbqyHl80icK+qaJT4Y0KZdW9/kUV3ORRLo816tB1VY2ZR7FR21ATJdYMghI47oX6HSe/lQCEGoh7GYG6WFXmUSkl3+SAI9Gr967GY3f0DT0/QNEgwnZLvtJOh67f6kyIAUTAP8jc/rVJIhOCjAJ5fi2GiwfSdY3WdQ6n9gP8HwXTJjMSog9rdFo9PB+k84FKqklMPJt5CqhIHmjgl2YqcgiRJa4eYGQ9SmoqDvCDIwgmWWL34gz5Q/Kjd6Pdt9hze1d8syWgQyesiy1xkH/B3Mux4Yc+6NfNXktnZNycLiSyq36OrbCVHZYvjzDvSpl3N7N8yktvF8/fGNImAaJNCBBIx92zOhWVdJgPGuGeGQ746Qxygn8/fsBcKOiXdEEOHipkaO1kaTVWP0FNlEqbncCl9gpt7j9OCvO9acLGKQFYs63XzhqZvIMQ8DwhMS173upEaFxXCCpFMoUHo4rrFiHgwrts+8Ve+AGIANu9iyDdvtc/gxHTtbDbPGzkDjSq42r73gW8F1PKj5KEQ34tx8vI2+7E4rjUgnsJcBYpYK6SQjhg2D6t7eC1SZLgS6P3LetvtrNTu9va0J7xhpc8ci0I3Uy4GfNISCTTA9t7jF9qsdyGgMShI3LBNOFlbN4FLK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6486002)(6512007)(5660300002)(107886003)(38100700002)(8676002)(6916009)(316002)(2906002)(36756003)(8936002)(6506007)(66556008)(508600001)(66476007)(86362001)(66946007)(6666004)(186003)(26005)(2616005)(83380400001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/jL3MuzjNZMNC4pbFLbapI0PCX19ZB10dlaEWmWQFI9wyoyImbto/vcgl/l?=
 =?us-ascii?Q?7OnN1iyxH+ZGKDjqQupvqBIkhXS6a8W56uJV7FVj59Kceg3B2lPxLL33Br1F?=
 =?us-ascii?Q?eIAoZ4gRSvV+GNsKOmwRldfS/iyuUIslvYRHBQF1bcednIOJ8eiIIgBoMtqg?=
 =?us-ascii?Q?ZlnHChNzQKSeZx7/hYKY2VIlT8JeFVD+Nj0jZaz1p1hEKs/hfKJP60SU2Yv6?=
 =?us-ascii?Q?T3NiE8fXywjD3FTdvQAtDI7A3VzOX/WbGRvJJlEb5MCoo7eLG8MNlzdWZmta?=
 =?us-ascii?Q?F5QX8rYA41Hbp0Bvz6haViW2FgZD/aOlp67rV7tGPzp6iPNc0vJj196sETvg?=
 =?us-ascii?Q?JqGKKNkmR5/EN1Ug9JnRAzaPqSbBkaH5Qz3ScbuQkF1LtBqZgW/t4UH6SRoJ?=
 =?us-ascii?Q?iYyykEjdoA12oMVcSyZkbLwWvS60cVCe2WEvcOxrC4CkB96vZs/8AqDJSbbU?=
 =?us-ascii?Q?+Km2yOEWX/wj3yrqKmjXo2NSOyJHaRL9P85i43a7m1PKZFDbKaOtAwp1b66q?=
 =?us-ascii?Q?XZgoVi3DGXgzqy2yOqDsq1r5FuP7F/GHVVGC0IhzzIysWn8mwmJ4sKka1NfS?=
 =?us-ascii?Q?mctb3oxsVJ8gvA63lHDwGXy9bdp2enghOwggq6zQyHPoog2CrihaWER1Dcoe?=
 =?us-ascii?Q?MCzvx8z6klqj8jfRD/HKPBRaSTRD4lC02pGsz3TcLafPIn5jriAv7n6vIykR?=
 =?us-ascii?Q?q9GehdciwikTCnqC6qSKfAM5KtTBWDMdPoaCC3W1nOAn61sZhJWlQ/SFT4eE?=
 =?us-ascii?Q?mb3/p2e4GatGpYGf1we8rDvtDgggobEVX0b2Oi5a1gCYKBvfXXNFkZBhwI1B?=
 =?us-ascii?Q?T2riSLFYHSciLtlCdnqbucTZDJ+5HijrGRyKFPIg6qFrU8vxhDRrnQbTfKcJ?=
 =?us-ascii?Q?EexXGQ/ZrqHbNYHmXjKPsEAgvnl961wpQttx7mc9NUanRxTRqI7T6fmpD29I?=
 =?us-ascii?Q?iDBVIYYOEFG4/TA2+FpMi/32aGqahTDHDbDCpBef2fkR/mv6zENMxSkSjBK6?=
 =?us-ascii?Q?ywFlAb5whhKvmrqNmXVdfLNdM5Lgo330W/I1nxZKwEU5afU8dhYTs54E+WBJ?=
 =?us-ascii?Q?kUaAA85SM8AQ32WApJb1dZxIjz11olJsez4Nfucpv2LygYAR9PesOtxUBGtd?=
 =?us-ascii?Q?axiWcq/YOi4HomIAXhpX+ROvA+fHJqvyU7XdcYV9KoiyIJAzcsxP2h3NSNEh?=
 =?us-ascii?Q?WAe1snwzNJ9UqO7BgFttgXVNSs1J5IWMwtM+tp1gf5rWXpjKZxrgYPwlaQ8n?=
 =?us-ascii?Q?RUGPkLOlrSD952KCFvUwbvS/N3ca+DXGBnliw+MW7S/HgL3l3KIU0OgcF7+J?=
 =?us-ascii?Q?dnJfqvjgc4eqvfjzQwlPLfzw1r+P20+UJz0R1n7Eb2rnfX2wLGNZPg41PMyG?=
 =?us-ascii?Q?lKzrBS3kOGh2MOuHdr26QL5kzA7eQuQ3VOlk8iEpPDhh+rMoc+50ve1rmp8g?=
 =?us-ascii?Q?Ny/u9+ho/GRlrClNzaNhCHL4YKxWzYgqDu30560+6EzT7A28v2zeZfb4uuxr?=
 =?us-ascii?Q?bzmqJlrxWWs3W2rOVSHCqOdwcazITXSKPTqNPI3mYSdlsGEaG1aVLbkKWPGc?=
 =?us-ascii?Q?NSfA6KRBmAOFoWf+sSbAbCmVXVQV49oGVSDJGxytmZJaC5YkYpWKT020qGJ4?=
 =?us-ascii?Q?bDy4SFsUCEZfHLFJxSxtOpc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db99244c-5385-466d-e231-08d9ee42e268
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 16:15:28.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ymy5w2Xkxt7Hjk7Ltq1xAXieTTlGZqFkRFdzVf+sa/0dUSHKXe/lpXyi7HKWwTCiTYe7cyWAbKR6uwYzKoa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548

This patch added two more mibs for MP_FASTCLOSE, MPTCP_MIB_MPFASTCLOSETX
for the MP_FASTCLOSE sending and MPTCP_MIB_MPFASTCLOSERX for receiving.

Also added a debug log for MP_FASTCLOSE receiving, printed out the recv_key
of MP_FASTCLOSE in mptcp_parse_option to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7cef7409e300..684643f8af53 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -49,6 +49,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPFastcloseTx", MPTCP_MIB_MPFASTCLOSETX),
+	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 785cf751e5c0..93dd5176fd5e 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -42,6 +42,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
+	MPTCP_MIB_MPFASTCLOSETX,	/* Transmit a MP_FASTCLOSE */
+	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0401b22128c4..e775d75807fd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -323,6 +323,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 		ptr +=3D 8;
 		mp_opt->suboptions |=3D OPTION_MPTCP_FASTCLOSE;
+		pr_debug("MP_FASTCLOSE: recv_key=3D%llu", mp_opt->rcvr_key);
 		break;
=20
 	case MPTCPOPT_RST:
@@ -832,6 +833,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
@@ -1124,6 +1126,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 		    msk->local_key =3D=3D mp_opt.rcvr_key) {
 			WRITE_ONCE(msk->rcv_fastclose, true);
 			mptcp_schedule_work((struct sock *)msk);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);
 		}
=20
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
--=20
2.34.1

