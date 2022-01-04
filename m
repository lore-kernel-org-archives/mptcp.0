Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A62C9C
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641290317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVWkqQ0Q2WrjB+7ZrZ6mC+PL9HHlNrPAcH5sh/FudGg=;
	b=EW+uyJa7Qdndqzmh0WuZw1Fj+gomc7D2dg4RtcMAhsuKcesWVIkXO9YEI6MgGtMoXplbqH
	ytzS7aq/5af4dFFPIFwIaTXBUCLDeX1ktVZgn6NqPG3X6VRvNSibSMspv71i7/ErTTps1p
	l+XoVGwqD19M1aAOJrpzPyxFmIhy3wI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-FdTeX5pzND2MeFMfkj0e2g-1; Tue, 04 Jan 2022 10:58:36 +0100
X-MC-Unique: FdTeX5pzND2MeFMfkj0e2g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClzHltZTS75DzPauYh6jaV5CJN5Kj4egFR20g2EwYQdklmPbocq7Z9mltVj4ZC5uZEzeR0ORyks4jAuV2G0ZdTg/q5gHLFxzlAKEAy3omUeBnkd78b6JTlwK2TYQZeyxAYH1MYf/RSZzbE45trpi3OFh43A2iFDZzkZIAPDYWzyy9aqdMVamG7jpCOx1m8rQfQuAFO/YKWyPnosuOPU36KlrmFMzj3jEmM4lnRiRLgnAsNaI680EEllAlmbONTIiI1iGThMdHypVlui8ds3bNJqa/2AJj8vr04eJMhAkbDTu7YbdLGi1OXU7sMqt1lSgEnyu9YqV3wHhPUMwuGfk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmsGJhIFk6Xo4yD6vsrQOUGHy9hC16dCZQ2t5Gfv/l4=;
 b=gcKD2abo3xb1sa9mZw/leby8qrnUcOQ5RbGOg3qtCcN4rHMG1IRkOQpkyUcqMZrgk8sVgiwielifZbu6tlhmQGmF93vzLOgCOT+7iOGV7IGdHJdndyuWDV1W1AWHpXLvKtZEa2GK6qVaDMqAd2GxB7ROUQTxh/NOPIp87PGpiXe35/UcBzONis4HRG6hX4PmOKbil1yPN9PHEFyp3L9G8QBd7W4Rcc/vUshzooJRMo/VHYK7kpI8DaMyy/f4JrvbPMGtQV+w2jV3tmpKbjxDyJKKtCGdO1Xho7exnZWivwctMy0DWGBHya50AVrWjI/RfB+ZcJhtqCSt5SsIBu3Vvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2428.eurprd04.prod.outlook.com (2603:10a6:3:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:58:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:58:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND iproute2-next 1/3] mptcp: add id check for deleting address
Date: Tue,  4 Jan 2022 17:58:16 +0800
Message-ID: <e45ed5bcca8c7d1692562cb20c88185fb7e331ca.1641289518.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641289518.git.geliang.tang@suse.com>
References: <cover.1641289518.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 698628dc-475f-4be9-e026-08d9cf68c5d1
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2428:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2428722CDCB80578A86CE915F84A9@HE1PR0401MB2428.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RlKHc0bqNt2pT6dz6Qq4SSYgr/IC23s5S8kh2QZjuVNm1dA2qGU3JiCNMBiLXGAfqocelFJVn65D1SazZkGS2m/21WC45kW+w2wY09EVleb+O01g8Nb8pmMhV0ETorY8yMcGlicrqzshbRhT9tYo7w6ILH4HfSnHYwQCfekPCZha+RoGAEuUExLHNnMXhExa+R+SrG8+grbf0pIt/aBUZDHDbugCUYuyQV99yEjOUfmemH/vPHUPyOk4gWlnXlRSKpJSAtOPbGaNtNPlxvCGaWHEYbDR+oM2vxR+1tCrEr9KT3R3Whe2zaMy8woghcJTet1coCzH5Oedt2gWrboAoDDZbf7XoSWxiwA6pga9fXNt6sVPkgxTQ3rB/CnOGQ/w/Fu6XH/i5UNeOZafRWfazzfZL5Vn6kK+AsaWsKI6XgD+7gspRPxJvllsoDwPySYfjIPEIbeoRtsyiZbSNZd+NlP5bx2QudH7cwcbEA5SHasov0Qzj0xWOMOR4EkMxwLWk7jvHI0tJzjzCmxBYT/jKfOvOwcEXff5ne2BjBCRk8hppRxhmdjImuu7qu2gqfbdXnOLx+WwCM49uZxGRqy+edBtHlvx8FOjwhP5P7Obfv6RhPtwRdrSfc8BCjI5CYFpHcqp5h0YwIEwuVTK60oHAs0oarLl6IeOsMdr+8ldk9URXZzAzCDWQS/4ObKBfi8AsAu1CpKBvAqw9YGWRLOSqyRBRoJE4I42FXD3ypnWwXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(107886003)(508600001)(6666004)(83380400001)(966005)(186003)(8936002)(55236004)(26005)(6916009)(8676002)(5660300002)(36756003)(2616005)(6506007)(44832011)(2906002)(6512007)(38100700002)(4326008)(316002)(66556008)(66476007)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RykKUNhKJLinQPN40GCK5Mb6J4/nbfYK0H/wtsjUBb8dSO7RvpTjeN4PGHIT?=
 =?us-ascii?Q?VgbSOW2Cs8qTQx8Vwnn5xzcj2lzPxct7M/0VXP8mb/bAaSWb+kuJ8ZhasneG?=
 =?us-ascii?Q?KOtpD6nvFoeXBBzXMgkXwgy/4IhDsQiretRov4Pv2bDyEU5Fh+QqujhgtK8t?=
 =?us-ascii?Q?memEB7LbTTLFzthhBpJ9B/0H+4kr/0MnW4zbhQmxdvTVaAI5hql8nT4QTLo1?=
 =?us-ascii?Q?aYEQ/rA7V44X+3/simdQ83AaEzeM+A6o2DVk3McqECNcJVWCKMB/hyxCgTFT?=
 =?us-ascii?Q?Q1c2EXt1t2MS18Cbnez+EzAFG60xaANfPkrDeTWQ5JVPFz5t+U1/xI/SDh1A?=
 =?us-ascii?Q?JDRJN/muoO1Xq6c5qlDPaFA4aRP4QDSnVgkBsoZ2qsEAwef3Nhms1TnZTrrn?=
 =?us-ascii?Q?8E0Hgil15SMLiz3qOwLR5hAa9+zZBJHgF3srDhGqn394poG8vh1u6sjlqixX?=
 =?us-ascii?Q?Slkzst02XmX4AWdZDiaWM5/+Igpzp5izoOPYe6oVEPUpHD75psN6oKGKs3Ui?=
 =?us-ascii?Q?oSLNkM1+6TsHvO0KKq3CScUVsKMsIZidJ92waPC73L8yDr/m8e+j2jNY/1ro?=
 =?us-ascii?Q?P9Kb9wphNjw+YKlV7J9NUAZJyW2CR7YkAkavE0OblGBzwjPoc38col+4/u2e?=
 =?us-ascii?Q?GHkxUE4S1IndQPxru2LUH1DaZx6bptvKMX4u2AWGJTp5V/OgB+6wy7tVVIpp?=
 =?us-ascii?Q?9XwxSBue6pFOWEYHQJVEBGWwtD1sAnCWEWXht4n4A1+s/WBRx7+3tKO7Cw6G?=
 =?us-ascii?Q?OSg8UTHgh76I6sVepKsPu/EsmA9Hv+i/SDwKoO/9MNWyPGgcVSDEYucHWGIf?=
 =?us-ascii?Q?/VAOu2VGHDUXKv0TyJm3vkhSJCpV1doe34bxp7QDB0TJh8wHXgfKQRwgu//L?=
 =?us-ascii?Q?D/+WFBDkTctD8o3rmj5P4Eo7Yt0GbIWPJssW2LjgAjqOvqowc9L6lK2k6/Zc?=
 =?us-ascii?Q?1FXTHEexvLCzWUSCiwkcY4B3Fgn6eByaiSATkdwaD3HmlYhSD9n+hepzKvDM?=
 =?us-ascii?Q?3pO5O7SQJLwDUz1zL5flR2VcP37c0g0CmUysbswtpBG1Lh4oq7hSPsmkE6TM?=
 =?us-ascii?Q?F99IMR6tw92lDAOTzUc2km+cExo0xexeUTeLkEELoLj50KfyrvZ/1l+caXHS?=
 =?us-ascii?Q?5NNabR7Im4Nk2pF5x2mcxNE20tYC3v373l7h4P0+urE8edZawYuorraIOA/r?=
 =?us-ascii?Q?lxx8mNOy77gKVVr9/5IPjPZo3WgpN2qhbsd3HacWhaGXeKMwRLcgAie57RLN?=
 =?us-ascii?Q?ORWZbi6b2eENFHXa0W35+gKLI3NtIo1B6C26oWt7YtB2/JOEa/5YooFJxGZc?=
 =?us-ascii?Q?BZQMFBG9ZRxhyZKhYSOteqnV1QlmGpt61KsHsoDuOrvAk3GkTbt+DUfljvPo?=
 =?us-ascii?Q?5+zyoLC7YqsRfVNzm9KLQ90gxTQiqn1nvxDY1EqRxtS1dzROtCRCh7ng3C5R?=
 =?us-ascii?Q?JSJUsU3irbrydK+XaPNlhgI6qJ+w/j1LspSdL3AEaPYkgpDiRa6Zbd+z3zS5?=
 =?us-ascii?Q?rWwH39lwlGQ7QWUOou7e7RU9yYqQqsMXdcKIn5Fb1KFlI1ypzxBgwPKwvybi?=
 =?us-ascii?Q?2O28FVQ0iCdu5iqo0IvgTk+iIAOl4X1ArY2HHpCKfVLVkaMTA4ttOE8+2Nku?=
 =?us-ascii?Q?vhx4U7nYvl2I7wzEsipF7Tc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698628dc-475f-4be9-e026-08d9cf68c5d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 09:58:35.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTJtouQY+vFIfoc8TsVRl8wCmH52E8UgNWtJK+QKdvq4UWYbBZGRNoqZCN8x0xh4tMojUeid8gQYKCFRUFKP/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2428

This patch added the id check for deleting address in mptcp_parse_opt().
The ADDRESS argument is invalid for the non-zero id address, only needed
for the id 0 address.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/171
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 ip/ipmptcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index fd042da8..c2691ef4 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -18,7 +18,7 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
-		"	ip mptcp endpoint delete id ID\n"
+		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
@@ -142,6 +142,12 @@ static int mptcp_parse_opt(int argc, char **argv, stru=
ct nlmsghdr *n,
=20
 	if (!id_set && !adding)
 		missarg("ID");
+	else if (id_set && !adding) {
+		if (id && addr_set)
+			invarg("invalid for non-zero id address\n", "ADDRESS");
+		else if (!id && !addr_set)
+			invarg("address is needed for deleting id 0 address\n", "ID");
+	}
=20
 	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 		invarg("flags must have signal when using port", "port");
--=20
2.31.1

