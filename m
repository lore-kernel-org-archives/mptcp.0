Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F728E2
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 02:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645325970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtSIU3UEFkw6SEidnBvb4J8P1OHSFYsyRu+UcNqB2wk=;
	b=StorT+OBzYent3UN+KJ8Ca5WG838/QKL0OLa0OZv3PF7takXO1OURhA98S0WG7rvdfL5M8
	spFrLgB4wsXkUOmCPRu5VWHbAQIKbHCAxWrYdgUfxLIEsFYwwNLkR/WaGSIqtp/ZGtkDqc
	iU8FeaEGEDvrwMPe67wOrvUMT3w49wI=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-cURRwAmwMl6FcLbpG0e8HA-1; Sun, 20 Feb 2022 03:59:29 +0100
X-MC-Unique: cURRwAmwMl6FcLbpG0e8HA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQgHy+yAZw1zaeCguX+xXQaipCfR121NCun/LwIMLakzC4962V6p324zhiO5YQvH7tMs7AuaBrOAGel7A3EZ5TQU8LhRH6KVcjN3b+V2XVhgdf29QPlhd+kx1VN7wXYzQivSUf18w4FfMV6qCdE2XyC7s8J/mBPNm2HzoLQuC1XxPQUVosCvrvtA3Ay3EdYeGF9jYC/fSTCn3tvRxbB2VL5g7Pc6v6LTeVZf1yygDUfrB5sUHVuUrQLbYpeAlq22K2rnVPgZTwvC6/RTZLktEwrGf64d6ofcQndiSZrn92Ahe/2K3TIvs60Khp3oi7keg9GvhglF6hLlfTzDwCDf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE+utjFsFCiqq8qjTOQR0uoEev0X4nb9y+t6wfEfbIY=;
 b=SKC+8AdgTwclUPAxLcy7Sa1CMI4HJDxv+fH8yfNwCPWqUPJ3YfBllE9VZZehPFj7O0kJ8KPRuZZH5B6FLmr0KgOHV6cQrfmG38WqQyyAkoAnlSlaYfk6vdRfQU07p8D718eQvSIKFvd+VfsQ092BpdKwy0Ey9cERgldzJyfpxJ5EDaYluyOlQxEo/6+ws+z76AF39O8881w9r9zd3+X5lcY9puKQFM0YLB3foMmO56FNNSavAg4LPX6tkuemUeR/8WZkhfzsJKRk9TXGZcs7DCDj2glIrh7SN2GPiQCle1fYMpo26TY5guyX5NRiF+GKb7pSZxM/CBjtlKujlmL5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 02:59:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 02:59:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 03/12] mptcp: add the mibs for MP_RST
Date: Sun, 20 Feb 2022 10:59:29 +0800
Message-ID: <f90fb9187006f0a6e87e1b59f840394d1275f507.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 894f7042-87f5-467d-c7dc-08d9f41d01df
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414D86974960B932DAEAFCFF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kxBB/4epbjCqFeMP5ro+uJBwGA0riNTVmAZsu/K6whOyNO29QoSKO9GZP3bjuWOkjsTZA+3NOnjLv+U4MRsv1G64uzzKPnPVXEv9NzgNAwPKVIl5QCMiVXIF3f5bcqy9tNTzL4xaZrRW7r5JrfJjlF1X+sF+0++r0yEkBJDsOE86KOFzFNKhdOJyMfSPDlQ/Ce9nNiZz2eNGoA8zPOHswFlRFGUMATNBfO28JSmiG5XzyeZ0WQIJ7HI5SvJiozxA34Z+NA5yXLMO143ij7lsnNnMKNkx8057e3BVMJ/p0mBxPuFtViXZu/6O8GKBxbDNNiDVG9muRS529GRgb0DtdZ455Ibw3GoN9/P3jXU0rKxmd00MNJjKeaO42KqbDWCVE+yxcGMwhBqUSwhTHLIepWh2bL6ngcUq/JnFXApmyBCv30xSk7185mE69rWAojwN+wmOveNGsT3m081I9U89qzHNDOLGAnPyPj3H2DOH7WDvvKt2oq7xO4jBlEQyNQNnn9PqVJA3YmysvtpBNTSq9sIJhlRlzWHyMKK8iZUCyu8WRcn7kZqY43JdUv1A7oqVEpExet+y4nglUf4s4F7FUgDrLzm3wi1kTcy5i8mEJs8FTEtZD/gXItLGQmaf8EbWUUv6zCpcN9lwcIDsf3hZ1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lyIawhH8ZQ+NGThDaqDJkkF3ADc3ffOtkude7Y0jaL+GXgIDiIem7hJ6uJjU?=
 =?us-ascii?Q?nrLqSRe4JPTT8vbkhxkYxB1ptcTM12rcvo2j73cSCIOFb4tudrPexs7dJjMm?=
 =?us-ascii?Q?xijtM4PCi1PwLwe41CXzy/fVTNJ6wj8Oyugx1bCQBN2IcVC95pM/C7DWimNc?=
 =?us-ascii?Q?an1/E/YDpjBowJgpLmiyrSU1VGoi3Sv3Ewvdxf23ENLdx+lRVxOltq2G5zm2?=
 =?us-ascii?Q?MMCsJiCi889c9vdUEDyGcajKw5JALnKYDafE3q2rdi/nxUp5iBDdmuKH9eab?=
 =?us-ascii?Q?tJLcOi8R548sfCNrh94H7tugmsTyNtFKHKBGAvulKjsk/G+gZIYo5v3PSahh?=
 =?us-ascii?Q?ujMrA3+irobiuirAzg32zybJzcUs7JDco4pYsQQigzrIAgNKkzTPkHyiEdxS?=
 =?us-ascii?Q?Q5u39lAuCeQZYcRQJGBQpsvv52Bk7b3EpTKAVYJSZmYUDqowpvbjaRqRfTZv?=
 =?us-ascii?Q?A8R7hj4tEbfaft8gmGB5yoqczqwQG5i1w81JFaZsrbCiRjKmTVFPn4OmvSuk?=
 =?us-ascii?Q?sZygiIltQ//NtkM8hHNDIShDpmP4WmWfxWojyDRHYao5SFpPS2qOUuXnKkNh?=
 =?us-ascii?Q?K7v7dBki2OiP0UMeDvMXMyN5l8OngcDNjIZHqMcwJsBFppvgHXknuBWBzbK1?=
 =?us-ascii?Q?R5apkBD0V/Ohi82b2ElLFkL3mq10zM3My9gKOSPRqr0udwEbQ6q7FnvJDTi1?=
 =?us-ascii?Q?GvOSxQJpVXi1iu1eprbBMbXceKcZO7Yr8n3n2D6AAFauoOcrsENAfnaUl8M4?=
 =?us-ascii?Q?JzHojHj0RpoUABDUQ5uckVQYPCxsCOvCIIU4myeBp/l+/dAVmIgF8nT0SjiP?=
 =?us-ascii?Q?1P0ASYzAjoiWT+lK6KD3OczLiRN605sCFmpRHpLsda53d2Y60X0M2gI14Wvq?=
 =?us-ascii?Q?+ooMvyhYxdQOP/bdjnZyi3cQAnJTl0HRLb53SyXEqxwum8dP+1xV97OXaTdv?=
 =?us-ascii?Q?Hcjwt5wbCvnTmVTNgmNjTzfoWc8Bgm/xy2BGbYOOzFuouSnV5gZIfcYiHYrk?=
 =?us-ascii?Q?0IynNbZ56sdn22OaYHHpY2OLadSO/7n34dmHOw/nuRQgrxk/p/RfJ0og/noQ?=
 =?us-ascii?Q?gi1+a1Sjyrsn/92LfqbQ4Baqdmj01lS9qcYKyBDzKNKL/KNy+PM7gQP6QEpC?=
 =?us-ascii?Q?lAT0kxDlbwxW0Ct2+x6RVLnd0RuMdgmi9Hr6PXAK+tBmA1V4fAfALx1148DF?=
 =?us-ascii?Q?a/Bti45nu7sswCC28n7KMPf3bmKj7VHpx1zlAqm7JeETadK+4sF3VIYHQgTT?=
 =?us-ascii?Q?SwzgWHohnCGfchcbVyOK8XdcVSM9QoYTtnEwzgPn/0i4oQsk1FJviJhiB9rr?=
 =?us-ascii?Q?i8YFpWwJLne4nnwEGeY5nCJngtz0qmKi4aGyilRaMGu06dNFt7byjl3ytXKa?=
 =?us-ascii?Q?DJi4/NrjI5u38T0fHsNQPv9NWeVqnLzVkqqoA2H3jaMjtHASUEAQEq/9A9gn?=
 =?us-ascii?Q?/Jt+W5cw/0ptZmaI/pCC52YTcMsG9dmND9QDIL5Xt2rWYPoRJ/7qpxWZounr?=
 =?us-ascii?Q?OFSCymE4tKNMZ8rTisBcprwECPn5HzC8OL/OYaVxgOxkY/4ZrPZP0RbSzRys?=
 =?us-ascii?Q?QKMgpzuo6GVC4Q/gw8MZOFEBFRgYU11SlGdXjVtZtX4aQuISZCua1zLx8yI7?=
 =?us-ascii?Q?m8i+STrxqB55XWQUEKZeTqAjcGL/Agnv4FqbJXRV4HF9ra2TdW8kIdnQbQjV?=
 =?us-ascii?Q?PWNLLY9CdEHA9fAzrDLqffIE2bA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894f7042-87f5-467d-c7dc-08d9f41d01df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 02:59:27.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8cjgeOriRq5BB9DJI0kekEPGJS88aqc6wcWPI958vGUsUllwhJKBhXzVcrwqYWzeJbVp1Dnsbv5H3rOLuI7nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch added two more mibs for MP_RST, MPTCP_MIB_MPRSTTX for
the MP_RST sending and MPTCP_MIB_MPRSTRX for the MP_RST receiving.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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

