Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01267168
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643360147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FTZmMWNq//OZB8YTgaD4+kyYti9WDw1JFdaCTO5ACMA=;
	b=c2YdyesjMmAo0A/YzIMPDvY5y/sk208jtHHA/B5A2qEnpRQEurNQ5lW7lLVr13CeTVoWZK
	WslRBPn8bp5o3k6ZGm8EkQNmXyoPux3pWX8rfaEmAlVdWg7Hs88cqAzxxmyx5jFjuCNRiz
	f24VEXwP2a955Oek8N2DXGs7PFTFNxY=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-pw7jfycOOeCYxWUWL3DSLw-1; Fri, 28 Jan 2022 09:55:46 +0100
X-MC-Unique: pw7jfycOOeCYxWUWL3DSLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ70TRUETnr3nRbIs75ZYSjrKCAwvw4Hlf97XaIVBIYthtddQK3NOfEzm7NhfeAQc0ftGG1xl9gO/kY4CNJ8WOOxy++SsCAjRqqg6rh42g1HwyOhj04/qx5wBluaEGI+z4nno1o12otHnW2Ob8KlJhuU6igOzM71hiFHlKB+XWFqprPxogwf+m0ptzgrjMpJb5xxCxmGc7SUeLgEgTZ30X5SNmq1XbPZQK3wDDfWsBetSAzQxD8JabdK9Z5j036QfWPEAJbLlWmihrQInw8cjdz/3u0srEYXw9EyOxi7eBJU6OzC4U/RrKFWTHKSU7XXu88RqKuE6GbHozTBBS2wFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zv8nLWWPshUyEGkvH7+0XPpGG3WMaSsLgleduICxKXc=;
 b=Fmf3CysZNFRbHBZNYM/na5FxkjJHzWjWGt/ccxVO77a77EE5jk6u/1rHJe5XrlComxyViHrBPOdNY9mYdAbbqrfuk65hK32WSMx4ew4SLiqAULRY15mhkO+SMf2fILwp6Q/5X/mudD6ZHPNtx4J5k9v26tr/2yV3M2YgnGOVhzZTG1ZU9d+r36HAn/F59XdbBN6d9mFbkemJgYUHwIymXenwtQ1Bi879ua9QT8KqqQqzhZkX8zawH0z2wSdoAMDp+GMaLctLVbavcg20byLVXR6QzZNoTxOU6UIsTyWtBkfk6rOEZ9AfhaEir3cSlZH305E4d3vHSnt/BKePVoVyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7232.eurprd04.prod.outlook.com (2603:10a6:800:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 08:55:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 08:55:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: use MPTCP_SUBFLOW_NODATA
Date: Fri, 28 Jan 2022 16:55:51 +0800
Message-ID: <c360d83acc0aec3cabfc37d84a81b159cb185a68.1643360139.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0174.apcprd02.prod.outlook.com
 (2603:1096:201:1f::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1187a4-6ac4-4a44-30c6-08d9e23bf736
X-MS-TrafficTypeDiagnostic: VE1PR04MB7232:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7232D1D32852476D5F301975F8229@VE1PR04MB7232.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hCEPn7M5U9wCc+D5DIa7DMljB1WkWNOzojHt6fOmnobqYTQt+O+GTYqWqumHqeo26G2AFLsP4V4H0abWNfoLprp+n4jAEIjPnC4o8Rvuctw4mhUWlOfd1hSHmDok8ZM2i9Mnt999Sz2iqguCseAMFlY0xP7CreiOePqAlKDlf8EVZP9+jpRtQy7o7uH8TX5jlJ4L1dQDr5+X2hZVd4yuGS3omh+wI9axypUGNgPIVvnZM8EiuSpLSYC+saVJ4A0tATqRbJHXO3s4SGAfrZjycmo2DESAjYTA+ihh+YoYbYiudqD7sjnlGHI5tS4yforg1hCtx9/YLoiD3S5piJZE+vE4yv5/e/phUOfnlFRVxduZYgZP3Re4qsGcMnTAQ7GTcy7gsn6s5YjKyYaG+iqduFwJFSrZuyVkfYxrprZeQ7C0Ue9N4t+No9X4Ng+2qjorTjnQPdGlP0gFeOvWho9NqKVyTPXDZcQSL8ulOv1IVq0XVo9cL1iDtKGDVOh/T5ugdoKlmvpnQ2z6zDd2DPkc5U8DQl77oPt+EzGiiloPgsBlrxRjuGaVBUzwn3iAXZ3u1q2qDqtf02XZ9gJQ5lapjiTHw0kdUjkcW9PPEGoH2srO8pxpeEbkNUdQU8/y9m/azauRStzh0l58go3+6KBWGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(5660300002)(38100700002)(508600001)(66476007)(66556008)(66946007)(6916009)(4326008)(8676002)(86362001)(8936002)(26005)(186003)(316002)(83380400001)(6506007)(6666004)(55236004)(107886003)(6512007)(2616005)(36756003)(2906002)(44832011)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2GO0wEe28j72bbbtDh2lrsc7ZQ+vqVa6KdJ9pXkPxRnm/Hu+pCOqab/2rTxZ?=
 =?us-ascii?Q?CUUpoqp5ONt5yR7dEzdbDMdf5dvsWOL+ISY5bZ3BJCxMqIyJAhRTB0KoxuWS?=
 =?us-ascii?Q?AK4punV2anPKS8ZXY+1okX79UMG3H0bRDwDkQri0UNzoZ2dvl6d3yg0xzbSx?=
 =?us-ascii?Q?D8wkOFa/AH8Qogf0vYL/FADnT628UVYKlxK/R8yt9BOx2vIyUYtoRiEeKmMk?=
 =?us-ascii?Q?Qym+wGTDozMu+rgYa5la0M2p2njMdF2mzzjtlYCNS5zzayKl3wVojfBWFj6f?=
 =?us-ascii?Q?6oFF/ri56QbFSC3gRwLGeDccQG+ekIsahmbVX+6MI+PIy97mxiBrsXoEGGt7?=
 =?us-ascii?Q?/qV8rDmc+DKrNlb0IuFRRjWG3yefm/B8xJn9KUdY2zs0ywJlNWSGY0DLTaIT?=
 =?us-ascii?Q?J6lY/wWf4jr8Cbpk5CGMw/Pj/PdKC7O8NVVySpJ+1MhIZXcPgYNLnjyyGW8E?=
 =?us-ascii?Q?q/FY1jZ7JpWgoC99VPqfFon8uZPlsWpocRAPeGBIy8BvGU0xzPFtoPG0Z3z+?=
 =?us-ascii?Q?Anzl89sOivTbvzeFUoOr8yIolSjR2x1fvJBxQZ8Ov1NegXVDzRIfteCp4hlx?=
 =?us-ascii?Q?bVssYEiqXN6A/98gEyV/MvzCZ//6R49rs8RncDKG//jtZ+oHnc6d0hUH7dGh?=
 =?us-ascii?Q?rZnMid7bbxFK2XCyd8gcV+92x5YS4zfdjKou7LOJSJ/I49GLMBXQHC8mKW4e?=
 =?us-ascii?Q?ieNcDGAupqIVPntuVnvatkZnRGRmsDF41o4LlVkFe4PAL1XlhJxm0AbkX0xU?=
 =?us-ascii?Q?ymKZRVlvADBHjR7iIGQefJfSgsWuwgUN7soXbFIuncbeUMZZc7NXaZlgFhhb?=
 =?us-ascii?Q?ZyMT94ScxPNoCEv3k45XJ9CP+xZtSUW9d/HeMgEfOT2Fvom1N8EyE50HgOxf?=
 =?us-ascii?Q?Tq4HAuPAS5BCebGgNQm6nVJFC97lxcHt+n7CnVpdu49ebig5SaEtm/wXRxcL?=
 =?us-ascii?Q?sVyDODARV+5hV3cK8VjQngbEt8mKpoZAkRknHuxeymaPbkYlvPTPSkd0vBeS?=
 =?us-ascii?Q?LHKmd7/7mloIUGeoV/nn+Sv8RCjmRag15U1hBnDSUq9u8b5dJvHtdnm9JHj1?=
 =?us-ascii?Q?O8xcrMdgXV3uFbwN6Ny/8fUI1waQT+2E4sFfG93ZkcCq9RWOn6ck68waWG6a?=
 =?us-ascii?Q?kCquy5XHJUN1mnVYR7oxRnw8Uu+gboMFCdac2fvDEswzQKA3Un+y+4EYECzo?=
 =?us-ascii?Q?X33VR7Up8PmIKi2uSC3twY6VrDcSlAuAWToQl6EYeSC8bBnXVU5EXPEWw7I7?=
 =?us-ascii?Q?RHtMLibQaBha6htXOWPW0eLLR6m46TRo5yOvhvUh32CE505yNhVR8L9zcxOI?=
 =?us-ascii?Q?SA2xYxAxGncoM1jAYGQTlpoMJiyter2fruXgzcNjnWWYjHN7+YNNQ0pUDHke?=
 =?us-ascii?Q?ohx5LfaoIdlq57VtbXCVlcQeRzF88p1mnmNNAerTX6XOFHd/pXEg6PsRhJkq?=
 =?us-ascii?Q?NmHhYlRmXO+G934U2gZQ3vS7U8HhUpJzUPbxaFjGHHyR4eycpjd9/as7KiuP?=
 =?us-ascii?Q?wSF+rcN+l5GTt8sGFSHk3qd4flglXqQkV1VJdYeNQWGEaM1VuJlea9XpIX/N?=
 =?us-ascii?Q?x55u/4thLWFOK1P19dDNxwoOaoLRpJLjlMpzcBR6uUWysjR3HxpqYJRuKzC0?=
 =?us-ascii?Q?v0YJeh1K4JYdy4yzE4udnvw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1187a4-6ac4-4a44-30c6-08d9e23bf736
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 08:55:43.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCg4ftQ+eGtFtRbMXdGIaahon/stlQF0lnPMT9ctUVKS/BTP+nftgkzCZl1BUDlnOcyACrNewN3aQ6mf/Mfu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7232

Set subflow->data_avail with the enum value MPTCP_SUBFLOW_NODATA, instead
of using 0 directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 097292b7d2f9..88ee94adc38c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1108,7 +1108,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 	struct sk_buff *skb;
=20
 	if (!skb_peek(&ssk->sk_receive_queue))
-		WRITE_ONCE(subflow->data_avail, 0);
+		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 	if (subflow->data_avail)
 		return true;
=20
@@ -1175,7 +1175,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 				while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
 			}
-			WRITE_ONCE(subflow->data_avail, 0);
+			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
 		}
=20
@@ -1188,7 +1188,7 @@ static bool subflow_check_data_avail(struct sock *ssk=
)
 			subflow->reset_transient =3D 0;
 			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			WRITE_ONCE(subflow->data_avail, 0);
+			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return false;
 		}
=20
@@ -1212,7 +1212,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 	if (subflow->map_valid &&
 	    mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len) {
 		subflow->map_valid =3D 0;
-		WRITE_ONCE(subflow->data_avail, 0);
+		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
=20
 		pr_debug("Done with mapping: seq=3D%u data_len=3D%u",
 			 subflow->map_subflow_seq,
--=20
2.31.1

