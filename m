Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D487E4
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644819783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kVzRux50PJe+ioDltyEONPIbd4mEABlbTVAJX+cRnHQ=;
	b=KomQTHe6JnlD9Hymz6dxxAkscRX17zrtxFmiCzJE7Fb4/QLVRWK3mwdr/TlS7TE0h/2+Pd
	NhRKt8zX6wUHedzYdpSjnA81fIRL66E/7fOiWEn7Edfl/5vPCLZQmnYnao+A4vzd6Mv3E9
	oSz8goKid5zPedDYI9OnO2fEd7Kw/0U=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-6KymCAYQNeSTI1eg5hh0Yw-2; Mon, 14 Feb 2022 07:23:02 +0100
X-MC-Unique: 6KymCAYQNeSTI1eg5hh0Yw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf7N6dztGv8IUeuxs6Y2Ubx3WPHw9PeX7lgSSWXBTgtSh3tIgegJfCer73uGNTfgCPQh/F68dEJVYMxcpUWuOPyGzVbVd2mHTRfsq1loecQqzFsjHI+rltIWAg4kryIemfkPLGO67v49HHpszyeWoiSpGP6IYymA4wBcvdU0LsfEFYO8nsCfzd+qlvJC6g1bWGep4vPzFKR/ThOSQGapZhxqjzNVzRwvtUEiODoJ6V670fPeY2fNk+c/tLy4sl2pSTs49PZ+NzczrjuKCZ6+B8wg+1xNOahfGkzo6wmiJPcv3/QBCYZ9eiLZSgFZFg106NfI+WUcY47JEWsd5yGVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnKQhK9s3Xv/ABfLyryK7Fa4hx47muTgaa7JCzlCALw=;
 b=NT74Zyz3kLGCDhmBoveC3ule+1171ZeBpFpz93KqYNRQ0iv0Voj8SUOTMc0JD1pLgABxokFf5e6sRxCVKO+qUxq0bOlCirhA4r97uvoVmxRvwZfa0NND9Z+2iMPjKssj9CqXV0DSFRJjF6C5UMClunGVqW/AvTJV/Pr9mPaW9s8K2C/1u8Bj266JpZyM372KKPo+NGsPrhNmHbxaMlIynVXqgpMtRKPe02jnub7AukxTwm6uv69MLOeUFiKQSpycJEGsWErGvl0TWnHX9lJcNm+GRMnI7EWP0+sSqnGoqdSA7YZ++Hr4B5oxM+IC+84DpZQKiiQJh21zLx5i46aYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 06:23:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 14 Feb 2022
 06:23:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] dump infinite_map in trace event
Date: Mon, 14 Feb 2022 14:23:19 +0800
Message-ID: <cover.1644819421.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ed81d79-2ab7-4d91-e6f9-08d9ef8272e2
X-MS-TrafficTypeDiagnostic: AS8PR04MB8609:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB860927BBE12C602947E6FA74F8339@AS8PR04MB8609.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h+gjZ0Rvysps8opPzcpCVKp6sYZJON3mabLMVh8eQjAGXiMgcjG58rc5Tp41lcNsDTnYNwlZbCW0MWJavZoqYDdiZaWvRHEwk2MvBeDxTqWMMQZbqiCx24IT+mZlMM+/9cPfl5rkXx+qT9mTEfc2rzRNEgdYHQOSeuS+zX257X3U/hsuea4rKnJuMwZpZkZ2n9wXrDeE6PtPuuECo9yxL+yYJPVw7SI835wh00sb/qBx+cAdIweDdP8/uiMXy7ahHmAfmziqNJMeWAjt0r9R0sr14JR7GsMtqoOlrgrMSdZ4u9xCzPo3QcaRX0lP7wpWRpWuUFnV0Ysy+THBLCNAZbp2mrhcGWTzp7W+qU8y4ZtSd8NVk9FMMhGiF2jR/Zuvpw84rnM4CKIzv848ffWbojLId4od6evcMrK7cNBHxPHz9OYwtyIU8VDOgToNfP6E4l+4j9FAcLj5W7c5GP/qoUyMUD7KoUAhSfLjAxV1VbdGjVW8Fqj08OsPZs7l6fnjsfjQQI7yn+6JW3VvaK2l0lBjmS5rDp6jD4LnIyNz6U6juTANQ/HnLXc6swsmiuaSbAScSyxT3RaiWz8dsns21TTUIW/qfs1nnXIpTvWWBqgW/W8Fm78/YSV/8Zu8QNSn2vu6az+H2lc2lLR6Ireg3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(2616005)(186003)(26005)(107886003)(83380400001)(2906002)(8936002)(36756003)(5660300002)(44832011)(4744005)(6666004)(8676002)(66476007)(66556008)(66946007)(38100700002)(6916009)(4326008)(55236004)(6506007)(6512007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IFGRBYSL1VUZueCilmvN15e7l+TUbS9mlME7BwJq/9InLxLm41+O28xy2O5o?=
 =?us-ascii?Q?YN8GwVgNYOHpP6FTHPTVTQgZe+Z4wt6+bUwWUN/gcU80dSqkofJeLutCGqWl?=
 =?us-ascii?Q?Qa62974D/FDgDcQ71UYB9RDBGqlGW3S18sBZLAS74L9HiJwq+9+fYlJ8c0hU?=
 =?us-ascii?Q?PYJn2nDF5Cp1Wynow2DkNIkD/VMDA/XyQYpCKfCUU6fr5LJZniDhoTnmDoJc?=
 =?us-ascii?Q?o9h0TPdBPsyx4+UGRWAUcK2D2NMU8E0LjOyL27l9lRbg5+YDMzK6RKP4xOWI?=
 =?us-ascii?Q?OHLZdPJaJjcwMcVocFxZR7k+nrqC3dtNpeTdVGxuZHKI+p4b3bVkTjr7AOKW?=
 =?us-ascii?Q?EgzJCE0RUm2412tVY1VvUrQlz/lZEberO9FJhYSi4P4CjGFIY/R719QuCqIj?=
 =?us-ascii?Q?pkEr7P+M42YqPWfU54L3LVzzuH8a3ehMcl5T9eO9GhvIY5ofMgyE1UM2LAta?=
 =?us-ascii?Q?UgaFCzF0j3rP4z57rxRBABjZugyp3IFD1/rs5vLhQzQnXgjzxv+IjfDSp8LW?=
 =?us-ascii?Q?o6w6V39knUwgGolOjStEFz5UcWnBqvzV/t3GaqI22muD6Ag+FCDY9BoeD9Yl?=
 =?us-ascii?Q?YQ9UyEriytoDLJec3M0lkFJ/dE7xNXiRaloS13c6+HqT2J5lo0OO8u4i2RlS?=
 =?us-ascii?Q?pZkwd3XHCVNqfc/UJS3nDrV9whQZRpor9/VT+5Rul5aj3cN5PDhYjp2Q460Z?=
 =?us-ascii?Q?LRtB0RKs8PbSk2r5RLSRb8QbHRdk/j50tPSxlYVZpKiS2mbpGIxJXdSKTPmn?=
 =?us-ascii?Q?pdY1mmx7fh4ZnO+iR/WeWPWXNGjV2VvO2+bH12uvwvqwHpdh6cArKYoR2o7/?=
 =?us-ascii?Q?CSQDYNgnN41blEXni2Z6TRA9PUm5FuPSbWtis9U1LZehBW51iSuWTL9Ovr2G?=
 =?us-ascii?Q?0lQtZ5EviDVfJ45HWV3QHlADtBSLIzVC4gr36KuHJSG+9l3vkmZQoKm/X0Xl?=
 =?us-ascii?Q?QJNdq3zZZE640QTyNiYGQMczlAZPCq4XA7JpyixetrnulT2jpvwrp5od/gw9?=
 =?us-ascii?Q?oIgdyWL6p6A8dc1uYaEiTymYWRvCv9JGr8HDvTn3hcSOwVONQpmYwQdk1MQ9?=
 =?us-ascii?Q?r/bqlGAAMyaIdV2ZX99wGabgKRaAE8Sngbj7Sv/KJNBi3rql0FTTsWLn7aML?=
 =?us-ascii?Q?G7aEHLh5kETsAUahJsmhZsJ+nbsKVMp3WUsJjny700zpp2BxEyTkLcGtrXr7?=
 =?us-ascii?Q?Z4LyEdcWyJJH0fXyK/HTsjgiDSWDNQ+3LImON1MTkNTn6hvqMDPmYwwKqmJj?=
 =?us-ascii?Q?Rzum6gvIsQWwXEwfoJ3pRmBMEqOhvb9EjhrxyiCuFlXyvu4u5nFol7dZ0YOJ?=
 =?us-ascii?Q?XLJRhf6ue+Np7EQcztD1vxpjjt0lDbH2Iu1P3G74GrVOLgySHLsCcqdUpfHo?=
 =?us-ascii?Q?GQMenLN2rmREs6Xj3Wc270MynyQzW0FVpae1tab+HTQs0ypyOf1nshY09dIN?=
 =?us-ascii?Q?n1+P9K6KPZnZvKp4AoyIblC++EZlX6T1dTDZLOasd86jKNl94IC8JopgBNkJ?=
 =?us-ascii?Q?V+pS3U/of+ou1ylLS/SB2/BZpk2IzMA4rVD4R4x0621H5dGmpt4CQY0VfKwT?=
 =?us-ascii?Q?DtIWdk0etKiP9Z8sGkN2N4Nc0torZ+yNAiYyh90ZPkh5A0lEW6qVlQsEYIH2?=
 =?us-ascii?Q?W+O+sONnS+TV6+NRBQp5UC8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed81d79-2ab7-4d91-e6f9-08d9ef8272e2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 06:23:00.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PujsgkulnozZfGtbR2AC7j7c663eRfIVLMmy745WWs3FVqvK9EYzPCiEj8v6NAu0rV4zL+pnD4E8JeI4h9GBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

Small patches for dumping newly added infinite_map in trace event.

Geliang Tang (2):
  mptcp: dump infinite_map field in mptcp_dump_mpext
  mptcp: add tracepoint in mptcp_sendmsg_frag

 include/trace/events/mptcp.h | 10 ++++++++--
 net/mptcp/protocol.c         |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

--=20
2.34.1

