Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3357D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1ebcsTxd1iER8EJPyzqc4w5yHF3FGXKZoMZmYQAYzk=;
	b=H5yb778AkyJ/oHv1VAA9oXtSFD0zwncIkpWxebKkl1NmUGl5kMVjYuDrslyL1kcu58czoe
	1b61KRfFfJ+X0aJUj41NODV3xm+gR3pTajH/zCp8LReuJwULYgNiEQ/q9zoEM355K71++u
	mZ3JjEKiKRjvlAlXhGVg1gp/unQz3ls=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2051.outbound.protection.outlook.com [104.47.10.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-htetd6pMNveMvzie6D-NKg-1; Sun, 20 Feb 2022 00:18:03 +0100
X-MC-Unique: htetd6pMNveMvzie6D-NKg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvlwBFYhR4i76QkTP9SqarIeD2csy3SQZmAyF8+hrwaXAvWCdrLsBDjiCfHnhxNYMcvcwmF+Ux4Rt3IkP7aFOmFVMXHAzRvUZR0rrWJdX6u9Rx3O2c1e8Mqdyy2kG6lhgt3xmYtLdjp4rIYbFe8co4hs5CnHshwWMoLjsaOW+S6eG11GgmsZhKpTgk04XC7hhcJ+u3UxBqaQOgLQqlCe/go9U9sVewoHF7VgmX7+EsQcN5D+Z0m1/4EtZRf7smh7CQksVHKKfmFs3ePOD+FvoU02t3A12biAwrxQVJsSqkLe2BWR+JRcASvkZ0zQhcCEynPEmudxyzrzC4J3//Jxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQlD2HMKAIEWyBHYOTBSdlaBR/AQX27clSKT4uHjRmo=;
 b=H2pGIy1sVzXGiPXkM1Xxkk6eToxwU3hPVVRSUB1vS/DBIkXZ4Mci7aEhN1Jt02JTkene9+e/Hrjorw+ngT7QCcpmS3WkZqBdj61d6tnbyZZTKQPOdUOZplmVlw482qxfxcak5U3te28IG1vDlbNTD6H8+kWBrzz0AWD3b2DwTRGm+OpN6iyNdR15sedlRoVDtaRZU0AZ+9NI8i8iR15huM/xA24WwZ/wp5qnpC3lilTap1GpPEmGS+XMtqehKkuCRS+AzHgOYzymSMR7ojGEmu+U+t2Czsa0EwAQrk+4PbpwTALen9g7uboiOYJ82OI76mUIyEM4L2LPyE+Lyncg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:18:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:18:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next 05/19] Squash to "mptcp: infinite mapping receiving"
Date: Sun, 20 Feb 2022 07:17:49 +0800
Message-ID: <f6f8a551751a4ceb49c7b120e0c56be433321305.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e92e3f-3cd3-4dca-e89f-08d9f3fe134c
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8812166B6D4231AF5CE6377DF8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ea8qWRH9LAVPOf5TPEmhFV3WkjOllkeQrQwdSp7aOjEZu+yDRBLD+IfiHbcra/EVkfKZCOvuxr0ngsN6Dz8ZkbLNBttk8BdnpA7Ze+FwlEVfXg9OexWY9hxgqadWrfQKuI+FfxwWjlcIXPFGYbwMO5syzBUSJUbjt+Do8/hwqwagmVeAwYvG3tK+UhhFLLwBqRmXwHImcFldLdZEN3oUAhzMIn5OI4bNNspIGoa/heCI0bLokARSRaFSI5znQrWZ7LgT5jRXFvxKoxfyWCWqbdV6LErhkk92/0JPI+glXyR1pH6uKiDKOa0q5VynzHAnpvUvT/MPNR315Zg3aiJBHzMOZbL0zqYgeAgdjLddP4RoTuj9j7MAUnaGP7zzvbHlf9KXNwH7ZmuQ9SeAGyTgMKSK98IojeCqV3ma2F4ffdfUyEfaqjuI3FzJeSMU4/OlZCG+lF6nqddDQViNpVAToUd5Sv4KBRRZYk/NltXxa7BeaWzsmAwglg1M9ORGv4iynGmzDMVuXKI8vVq40rNJBFVCecpbwAHGThu51GrFmtuCoUivMNVKoCmMXY4/FlnoKgwPa8IUNExf6sHDOznW5oj9P/DOfaHwVV4G4v8AgU6AoYbDojbij2Ks1zZn4/il1jEA7IrlNtyxefVmTVBmhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(186003)(8936002)(508600001)(6666004)(107886003)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wy7vEcD3D4tbXotHjwBEbn4lFlwSsacmCpQkoz0SKmftcYf2cJqvzqm2TVSS?=
 =?us-ascii?Q?+PvZJeyOeWFD2+Lbw/lTRw55odaiLm8VF5sWBNlHH7JPcsY83Xv03ln+1JAy?=
 =?us-ascii?Q?XpOyw9JlRHQyEYPfKv/u5Y4StWjDLDcpi0VnLCCw2z10MIk06J8XOM3292E2?=
 =?us-ascii?Q?rV9uhSDaPrCapKUrf4jzQhstg3xKcun3q63RZAZdXEtyVcVtabH1h8UKioUW?=
 =?us-ascii?Q?0sLGtknvGKxPSGprajJ7X7WKSC9Nw8MO91eDowuZ9uqRUs7tUTXLlKnDz+Fy?=
 =?us-ascii?Q?fiZuXHFEkOd5QngQn4JhnlCerVqIm8+Wj1YOHvZkalZnaiqZjL8cWvYpyDjM?=
 =?us-ascii?Q?GkE1t12eligAoWkePmsotBvv/DjHHhpaXZit0VvhzKqimjps1dBA4goNLz+n?=
 =?us-ascii?Q?HHLACdioQQpsNy3h2jJoLDKiYF8lO+nzvmBD9F7P49I9nxoSBLlZK7I/MHBt?=
 =?us-ascii?Q?iRIjlNesGG0Cwpdjis4NCzOiS15PdoNW6u9H1v3inLGubURE/3NMMGEn7ATM?=
 =?us-ascii?Q?pfk0x4DB1O0spHWNySrsgZo/C062Hzg0qsYrh7apoz0y2LXElCcIInVzI9ZT?=
 =?us-ascii?Q?giIY5LHM7ApPRSV7/Oz6OCz3zYAEovLtQyGwbNw8bNyoe5Z0DVaLpBk4PPCV?=
 =?us-ascii?Q?PnbCmNyDRICvygtnf4bMVpoG4euOPFDQPucFCOD5i2o0NKY6Kp8exZT56KbG?=
 =?us-ascii?Q?hnEUbw2Wud/LQ0QVRnE51wxMps0eR3iVbIYuqGVly6j79mRGQ2Y58bsLF9Dx?=
 =?us-ascii?Q?+zqWf1rMVfDNUgm4OFqJdNsHRxyjLDKCMqYemO/JoiO5hjzCkrSHggGF315r?=
 =?us-ascii?Q?wLaWFiOTdIieQ826v2UUhtLAiuER31QDd84jWZkrx5ObRjoxtYucGie0io2+?=
 =?us-ascii?Q?iWSA09aKQd3hmenaeaTRdvFq8YfcQo99b6tYs3yE1FCQF8IBkCZynxTiU1g/?=
 =?us-ascii?Q?pX8+RV53vAg7WTZjUUMGGi06m8EQeOSYdjEBFt+Le4Af7X65llaBpG38ae9N?=
 =?us-ascii?Q?5hFkx4iCF3jqH7zXX/GjkSrl7Aux2lGcN0ELIWogTy76WiOcqN8pN26o0YCF?=
 =?us-ascii?Q?zqmE6t3rRMIakjuU8CJPjlHZ7HrYb5ItU2yS2+Vaq6EqmuIKlf6m2eN1BGIC?=
 =?us-ascii?Q?34Lt7Ff3+7Bp3iYUFVKZGIj1qK0g3BwqtPvKPpNF/BACMBFgqO9i3mjk14cL?=
 =?us-ascii?Q?Yde9iMLuIHZKTztwWVFuZGIriSk18GIcn0riuhWC0rs5fXkeJEaTbNIPlqnS?=
 =?us-ascii?Q?HNjWmcralZD1s5OT0NFO1EzP0Rio+cbFk+w4m+6PyNttiQPVDTXkKYZNyWqD?=
 =?us-ascii?Q?+jydlGPnbwO5dp7ICZKpEEZg6iClM15U69dq2Su1BDSognfTQ48o2e+RmwLq?=
 =?us-ascii?Q?DRnucJTim1sFOQFBuXW9RbuseLx7QxFJ9dd9/Mx1gna9hNCZoUG5BX7/Bvu6?=
 =?us-ascii?Q?cK1RwmHbhUVIuOnEdVYI/+TkMB6w+oecs+YhNGZlyhuhxd51Rdmyra8j6lnM?=
 =?us-ascii?Q?bB6o9tjQPEuflBhtXxOkNDF9YNxbJH+RAAMbMZvX1T4SupvYQ47DK3kEKBjz?=
 =?us-ascii?Q?hG63NylHpf2yOIrrRLYQ4awoFwbisXUgHOxqoHJFFMfDriyo6MLpLfHZNg6W?=
 =?us-ascii?Q?xcl5iE1L9iUYk5+hkIJBmobytQ66DXMVzRMPxhmPFlC4shJLVnddcA4oOrTt?=
 =?us-ascii?Q?knj46s107sN0h5pCPrNX633NIEs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e92e3f-3cd3-4dca-e89f-08d9f3fe134c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:18:02.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3P4AGQqqGWa6rqOohUnz0fcrDXBny2Ge7wQ8tv1Y2Wt1vRPk1th4S8YLX1AkDYnJnSpScbH+tSfr3WW8xcPp1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c05c19f92532..30ffb00661bb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1006,6 +1006,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
--=20
2.34.1

