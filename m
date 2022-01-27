Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D12CA2
	for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 02:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643250592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bA7fXUP3dP9CfDdrOZJh1mtMD/eujXYaqwv92dVD8Uw=;
	b=L995AgqlhSkQqlGJLJFO9o6XiRu4J2vXQQ0h32bFUeIPRjxM9zCCjLhOMkGuX5Dc1lYujf
	S8OhxRmtoHG/rC9I2j31ZiCdM2KA77ElNLgLQFlvpKaeNGzmGuMFPkEfpUpJT+Ym3pZBvM
	DgYT7gx2Kavfq3r8MsO9pFhmDu7sst8=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-JoQz1eemNeSMaKt-xILeFg-1; Thu, 27 Jan 2022 03:29:51 +0100
X-MC-Unique: JoQz1eemNeSMaKt-xILeFg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNseuTavbZKdI6RRjLU5PnAvSmf6Pus7fVq8jRs8KOTRMC2I3HrkbaHmOz8Y9nn/XG6sASg8ZJlCWEchqIBD7pYdvsLl++Ow5cFXekhZL4sFQ7pUiYWMIS2dbVsOpb2taG1goWDhjmtMWN6r8q0NyMIeMFrx9XsfvdH/jCfSvYH6ZYsySgfa9UxJ0OrZoj4/OAXY+HpYInfIB1yKsL6Qz+L2idzxOL/gGCRqUGmkZPtKCQFIc9jKew2xdasn/frXhf1U4C55DvI7dqqIss56iWN9Cb19J0LcD8FQAzASgVZ6J9eMCOXnlnNzOP5aJmzT7tJgAhJWp41PNzaec8oa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tNt56rmaJQ7Uk7Ov+Mm+SGcjoSxVHWReXvYM5yYy5I=;
 b=MPJNdsB7akz0SD3DGgy5ZJJjIk39DuZOOy7uBXrwL742v/GYSHJ3aGMtC6eKnpyNO8HGGlQULqgwcZh6EsJ9zn7r2ZLbLoXT9w6a5EKFjwYV9+o/aAH0WQbFD3CZvzNL7WPhOyclHhhHQLUpsLLdhyqoVZxh9fYL3BsC1KA13GYYnpiU8iK1Ck9lrb8eO9ewDz74LJxEevPbUxhkvdW5hmRvpRkFrEyvWtgOyYas5Of6k30OZibHc9BaPue/YxmIZf4U2GPpwZurg7peSJ/DyF6t957q5+NzUXWmhmkAoQy1lDuXCbqug7Qwkzf/dg/2lia30/AQTKm3tLL9akPF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2792.eurprd04.prod.outlook.com (2603:10a6:4:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 02:29:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 02:29:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "mptcp: infinite mapping sending" - fix csum
Date: Thu, 27 Jan 2022 10:29:56 +0800
Message-ID: <f2761a60658d4f54e0d39fbf4b4fe45e387e5b32.1643250449.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac31d0b6-be87-4a51-bfd9-08d9e13ce43f
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2792:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB27925B5AEB14AE05D34768D7F8219@DB6PR0402MB2792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6gMoQeEgPKrOMS0J9HWNnu2I9px0P0dbNjfjXDil4nxxUEHUFQ9/KNLsAwnr1HZZcGJmQ/pQHhyesQbFj9s0DYvDQjeY8KqmdfF8bx6Ep1KiU+Uy3WLVekE4Nw4TWwBvYKmKLKugpw4Fr6jsn4dpPZAgPiTK+i8waM9IFxc066vBhosYyRjjYNIV9atxJE62+RKk7y6kP68r/FVsbRhxoM2b5RaImgIM8azKQsqj8Uuh76SZDbQoo0VGOoD7PRYAwOVeZwKtxf6auhwl3kO6lQldLGnkxr6EkPMMfFzooKur29LcQcEObNLrw7tdhLmG45ftoVNkeDqRIXnXFwbEzLDTLlB4lxIz53xSityICVJ2VR4wvumnCpwtIT8eMygErhhPi355Ha52KPJxbCeFZ/yWr+SiT++/65N6QhmZA//OuD+XaJ+q9Bf0ESSupOwupy0CSWIcfVNVmSjnAVg4NoogchhejBjE75j9nPHyfYOlA+8QwOXXv7/DXHVTee69nNHvbSlaMBUB3YpV3QtkrsriGtN2qNuGjYVf8B/VkB/q7QxyfzQh2hP3rOkkAQdCyQpkkGdGr2kCT/jxBuW6XtQJFh5cxs9m1K5gXrbjY9yMvXrrlkTCOOB+jAOWQHHyOdNkoDnzEKM8fnggqN53BA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(44832011)(55236004)(86362001)(6666004)(5660300002)(107886003)(2906002)(4326008)(8676002)(8936002)(38100700002)(186003)(26005)(83380400001)(508600001)(36756003)(66946007)(2616005)(6916009)(316002)(6486002)(66556008)(66476007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLRxMAxguoJsrfxRYGfr4fle9j3l6v4p8daOSyun6hN4tZZ8p8nv06TMunsi?=
 =?us-ascii?Q?TerGssyBMECCXM7KgzJ7lPLElImli1s7DDo4jFbBRsXtGUfWvQ7PlsJZgfhj?=
 =?us-ascii?Q?L7+vLw1qx1MHg8A+kqzLAP7eYaVWvCBRcAArXB/kjkcew13y70ufv3F2XBnv?=
 =?us-ascii?Q?qgPh+ePL5cKSLQxBICM9LnqZ0v4a6wSLQSy26l9HuSrlDO2wWMM0aJ5u/x4t?=
 =?us-ascii?Q?yI9gfjkXzQi8xoGR1YnkVHKzA1fiEyou1p1UQgfX+ZrRRSVhz178yXk8IAkK?=
 =?us-ascii?Q?sCHengElWw2BAR4XAppy/5RaGdOWL0ms0slPy92QY2yfeDrqG0ZHFmdpCS7K?=
 =?us-ascii?Q?xpEKUUxayblpzEh6y5qoNEB1U5o1OhfTisungB/f70d2Omb7++Q1/t7JmuO0?=
 =?us-ascii?Q?VSBHiuYBCuxl32P46pbXC2BbBC46hi4MlIVF80Y79IxFaRWlDKYYZXJTNDmi?=
 =?us-ascii?Q?llGrj9c/gP207DBWb6dQn4gL1G3ieIXIqnJnLVp+XJJ9ruuWJFqFHkXqft1I?=
 =?us-ascii?Q?JpXOWZoEG1ls1WJbI3TBYHf8Nt9ZPa1tE5iSpqWbLFpKopVRptJPH/e5lk1F?=
 =?us-ascii?Q?nxy1aXncvj+6GHePZBrSpObmtRUzfX6Eu2AgQ3IDZ+0074BxdrWrImxKSw1s?=
 =?us-ascii?Q?UJGaXa7+wv8UjhM+jSGh4KftmFj7M1fmXg+qGuzZvyuBncsZwGSSrX444cqy?=
 =?us-ascii?Q?0bkWLxdjw6pDs/+g/eP4MIVUIwQsf7jpY+KwLbXcwahPL15eB+YHHQPWxLeW?=
 =?us-ascii?Q?1jCvzALfqmX/49NgCTzZgLZrSg4IfCvbKumIm3IBBhGRKo6r2ce+tfNxc/B1?=
 =?us-ascii?Q?F94KM7lLXzhhnl0GXaLWP6ppgymM2l7gSoXSZ7XCBoPRZcE2J/lfR8z0fvcy?=
 =?us-ascii?Q?KezR+NULGg3z7HHBcEo9r4nZYWjjVKJJ26kMjkFMUYa3ZdjBVLqtxZ8VHtAd?=
 =?us-ascii?Q?+7mtVrGLYR4GihThNtyZF+H8GYFw+ovYnYQu5HPRIul64vDypFmjxG3MlV6A?=
 =?us-ascii?Q?mFPgMhPtdlQLONQjf/7YrsvpwQ5oOEAtmz6xqbTbRZehHU5kxrF0d90UwU1u?=
 =?us-ascii?Q?Q7jNBbncTDJlRqYWzfmDpT/hUa6woQ72J/PyRRoCXtZ/nNFhv9PPG8CKzd+4?=
 =?us-ascii?Q?8Ic5LtYrnrWizxELmncAJunnjt/VXUkhdHEhgYM+uXa5+0E2B9QYKVN9Wiuh?=
 =?us-ascii?Q?O3WcT5jfCTEFv+ECbnZyo99+aJJza5D+JUdmV62dotPSs8lFsGoaKYQwHkbX?=
 =?us-ascii?Q?KlWxQsi0HNPv3kmTjBzG60NON0buulAqyN+pVILHJhr7JRTuKr2hm5Je9VU1?=
 =?us-ascii?Q?XREV+ckiKGUVkB1ooFjnL9qdTP/bZd5RJ9zG/tFwN5CWj/T8rm+1QmrHSWVP?=
 =?us-ascii?Q?nCzSQVHlOwZM3hh2XudvaW03O3wTOXcWjV2uSDVnZndT5+4yAV8mR+GUlNT/?=
 =?us-ascii?Q?4vdA32dwwvAUEm8+kzOTr8/01LKPwnvh5D9j1eUMFteOLNAi6G/csH52hm1O?=
 =?us-ascii?Q?BkwQrf6yP76ReNFVSP7uYff8u3Ht8NnBDkQYAi2Sysp0eAjghLhxgRREDDVK?=
 =?us-ascii?Q?1USz4wonfYDhdznQHTivnTLYtHS1UdI1eIodrwUJ1IvcsZq7n0kNlIqsluYE?=
 =?us-ascii?Q?nOCaArBAZh7LLlBkvCsZ2wU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac31d0b6-be87-4a51-bfd9-08d9e13ce43f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 02:29:49.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUnfdRfhqLA2jZfSmRHomce/zRlO4GaFlb2Y7Am3M5Y57+ZFPj0IvE5mAGGj0lDIemLKiSjiPmBTg4812sRbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2792

Fix the checksum value of the infinite map.

mptcp_make_csum() will return a non-zero value when mpext->csum is set to
zero.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
 - add a comment for the checksum value of the infinite mapping.
---
 net/mptcp/options.c  | 6 +++++-
 net/mptcp/protocol.c | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d0d2eb8c8ca..7abad31c2b84 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1338,8 +1338,12 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 			put_unaligned_be32(mpext->subflow_seq, ptr);
 			ptr +=3D 1;
 			if (opts->csum_reqd) {
+				/* data_len =3D=3D 0 is reserved for the infinite mapping,
+				 * the checksum will also be set to 0.
+				 */
 				put_unaligned_be32(mpext->data_len << 16 |
-						   mptcp_make_csum(mpext), ptr);
+						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
+						   ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 526a0f5ba415..3324e1c61576 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1231,7 +1231,6 @@ static void mptcp_update_infinite_map(struct mptcp_so=
ck *msk,
=20
 	mpext->infinite_map =3D 1;
 	mpext->data_len =3D 0;
-	mpext->csum =3D 0;
=20
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map =3D 0;
--=20
2.31.1

