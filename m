Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4392C80
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 02:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641868644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cbHGPLBGNjGOZdF7rPNWFoiZvZ5QWucnm+AmqTm8Y/I=;
	b=LavgObqjYntwsHr+WivbD197x+FOoLP4+L8CL2ugY+hFv73GQ+PelKMMsTa22EBFO5liyD
	BshjCKMs5mpWSRi2att+NWqVoRgv8zHTmbi1gqI14KS5sKnp4NQLqzj1KDMu4S0L+RetdR
	49E7IMAphiaWdrBd3ziTz/XpvqM/ScQ=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-NWFcH-_9NMiAhosblUnkeA-1; Tue, 11 Jan 2022 03:37:23 +0100
X-MC-Unique: NWFcH-_9NMiAhosblUnkeA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYm65rNVSEoMsYSRUNK+6nXtX2fFkkur1mqUMoSCyvqs3CeKhWx15C8JsNHrSdkfo3mnY7bKTWZ0pfmINU0cBOwq4pFIT2fMgWQj8ZTPbVeZRlsguTaVPvi1+LTDUWLDpSXqkpJV28xCuwfUKU0Pg+GHmSk6PHPcCyyY88TTnF9AmnHof98rIqTTaBC2ABJ3IPq5T8GPg/ViA8tjAHbHwwePkMuX0F/iqDSEetUxeYfqDZAd2IvIpRWeL4dzLyaMP9LBw89WiCHAaTEsv2zfpb936FBqxwaPMtThgBQKYlxa/uvvCX0nvdqwOrOTVW+di2Dr7K95h2jgjxvXUykMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNcTvvqzzDXBAKQCZtiyceZOWCUVELTL5NTTen7q22A=;
 b=TGrvNQzmLH9r+TlmfrL5DVIqZE6nJsHCk1GkfFnyi7I11yf9XDg+zTyxYN2cl7BD8KqkLPXnE9+rNbLc1Jjf9P8/+MBNx5PwNgeMD7YRR4ULCeciBb//gdZ1k9AW3491e9+m2JZ1F2Xw3biCRrwLBwppNhgnO9MsOx0VQh0SG8lqh5FV3cpJo0iGblv3tzs3Pmggo41ui2kJOX6/VRGisuR2fb/S71CvFY4iR/dU88UMLun6QZvcAZZshrEs2JDzXaxeXJtRQpq1AV95m4WDQOrIwab7Y1EnuI+3kDoU9K76LFb+zGoMZ5ml3Ax6luFiBvaQpgBFlzOf7nhSBaYn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3017.eurprd04.prod.outlook.com (2603:10a6:7:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 02:37:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 02:37:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v2] mptcp: fix removing ids bitmap setting
Date: Tue, 11 Jan 2022 10:37:10 +0800
Message-ID: <fd0d593b0f088f5024b7a9a5f292bae4e67d6dde.1641868302.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a75232a-3ab9-47ba-6d55-08d9d4ab4a90
X-MS-TrafficTypeDiagnostic: HE1PR04MB3017:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB301719B3DF34292F77950F97F8519@HE1PR04MB3017.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	crPj9FejBwrKjMb0MS2M43NjZ+rNqv3sQNHsBgwAecGaZGsTadvNHmd9dNRzcJbHEf4IGEz2Sey3dpvXkcpYYsI+deCWT3XeQRtZiIvaQvKG7yH1eBDecSZAmYrxjALiuGtAbaLbZOMfiE7M0mnEEw539BT12XY+T2P++XgtfizFjP28r8FrLqWAKYSxy9RyZOG2StBeMpTME1pewIDFOikNIxxjTcbyNX7fXEURl2M7t2VQmVENH16fsucJkDjUEbSNAufVNqpDeJw+nHc0CDPaMsmxlhKDeZ/NRiKzFKA/Rp91yL6ItxDnYhc6jNAAcQkPk9dmSUclATygrrAkDvfbadOVi4xyZvT+mkDKEfCJ4lJQvQ/aPpABlul42ML3xUoe/K7L/OWHLQTAwq/T4GalFUUjWlDIXpn/WexTgEOCjwyJWRVE/+kcRT13dyQ2qsmNe8WpNl3aFOWKRKdwtTMiwSlfAmX0KkdfAdCTwfJsr32OxdbY8uA/zS0IMR24A8cdTsxIdpfSkIaZX6yQnvtpq3aZWN74d422iFseCfL7S6Qxj8PMif8Ok3woN3p8PG1I+rZoTwYc+tmMvToPymsqLTR0KmSjk4X52FEwL+swItl5wp5yTr6jhniIa4jGMzmS7VO7fKB+9V4g7jLgaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(2616005)(6916009)(86362001)(316002)(6486002)(54906003)(8936002)(186003)(6666004)(4744005)(66946007)(6512007)(36756003)(44832011)(66556008)(55236004)(26005)(8676002)(6506007)(2906002)(4326008)(508600001)(5660300002)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1hEYpTUXCLV9GE1cR+rwK3UBU/Zg0MsTk3U+H6APPb4Rs1DR/5xnCAALIM4F?=
 =?us-ascii?Q?hyQNHSKnppI6JOcuwVOhDSLC4nAY6KHaH9cFkCDnqAI/9jEuypbcVJOXTN3d?=
 =?us-ascii?Q?+sotlhyCZ2Bq8s7aHOMhcIVgvP88A9gkflmYWP1uKZ9vnIz9I6eGir9cR8H8?=
 =?us-ascii?Q?EDMXppHo9KjAMjPXvrYiwBQiuGbZzkkPdmsmD8k2GC6wc38EJQ2B5UYERpTf?=
 =?us-ascii?Q?O89+qstgJ0APoRWGTorFd8WWCcSuQfcbPnELoOgSxyKMlUMyjZVkOjEROeKE?=
 =?us-ascii?Q?Pc5ZiW898JxxjIPbzuRimLwgSwc/2tv3aPVJWV4VDQWnPhPEoZkO5tzGGziZ?=
 =?us-ascii?Q?EJl3x2Nrl5Q9zgpGAZgc7by++OtYodWhp5vVxxqBCiNjHlNHUx/BK9Qkt3Vb?=
 =?us-ascii?Q?Q7SjsrbQo8Y3ZNrtG9AvNpHocmB5L8+9TYbUhT3ZJZYY5xbfKtJ7AwmcaRtX?=
 =?us-ascii?Q?3BcZadCvtyRJolfDYJ3B6fWHtj7qqoNE5r2VsdbZMLco4UXNoSPXc66YXZCr?=
 =?us-ascii?Q?/B39KuzOgMMyv1idb7szQfzEYcrnlo1cPz3OuRSZOygLddhAlCKxxTOFPyDX?=
 =?us-ascii?Q?QVSXDIfWj4fSZo8PwlExtcGrC8zG1vzeCaWqGqgxo0MSLAdczD4PCNWKk6OX?=
 =?us-ascii?Q?tPlXN4gAYT9txB4FVKveVpXRVFg8hCHllbH4OwRLR8Fi4csNYy8mWP7AABmS?=
 =?us-ascii?Q?7YVvxd82kNrxNc/s3LNs8nhQ9rQzb6jTy41Evx7gZl0RtW8WY4clbpQtAf3w?=
 =?us-ascii?Q?dN73r+KMJ9aklAPXfKJH/fNSHTzwbSpyhsepIuarUmYiOZfI0XI/8SlsMKGd?=
 =?us-ascii?Q?pebVAdBaHZ0fda8F7SlSTTEeW1i4i33vnyr7kXitfqH1FCHT396ywcU+ZXdO?=
 =?us-ascii?Q?aMzI075xCPl4Tvw/TAHEI7n6XHhipjUSmcrCM0TLTLOS9ag1uui6NkaeR6PD?=
 =?us-ascii?Q?vTOeh6BgxJnEjo019nMD2CutsLC9Xh9kB6pz+XFiVIBQlzyc6g/nz3qtdFCy?=
 =?us-ascii?Q?bXzt7Wr8cnykRPXjI5Q4ftlDWy9zssCod1V1E9GgHfE+BImJa3QHIjX1c0Ug?=
 =?us-ascii?Q?MjI+KiI+y3oceIqIUOQT0hOsf04wNvcia9p0KMDfhgOrHE2oflRifJPpsN/9?=
 =?us-ascii?Q?4OB47KaZDY4dBXiyzXNDC3hm8FSA+x4QGXyRY0X6gHNiWttpH3iaqX1YKpSO?=
 =?us-ascii?Q?tNLRszDPjUEjvyQyohJhPgcJs597xi/7yW7L9Jhe4enY6jhYtqzyoX3yan3v?=
 =?us-ascii?Q?c5RpJ+OCJhs9gTdnP9zcAG7CJy5wJ0U95o6tGOyNd6J7HjlKJCUNQ8DJOonL?=
 =?us-ascii?Q?eNYDJEo6kK0BjkzF3H7gOKY8TJvx299puiT9taderoI1ZEoOwk1skRUCa3Do?=
 =?us-ascii?Q?D+1eY6+cIRPjj03z896zLfnn6EAQhUh4tB+jRrF3Bszb+zGTT6ky+bo7aKZC?=
 =?us-ascii?Q?JvmyXaDAmJwrCMKRg+0Fdmwf88DZSU+UlmN1CGqvV0RwlIXbqox66r6NkgU4?=
 =?us-ascii?Q?g63wwIIvfqe8VoF3MFipS3sFPoqTkxGIEHoWHD3PdAq7VEj4/qZI+JAjsKO8?=
 =?us-ascii?Q?u7oM8Gn7RmD1EBZUmW7IHeAIPMDMYFZrdIeuIjs5VIr21YzmufItZ4besdk6?=
 =?us-ascii?Q?FqtvEXASTE8AeGMuyTB7m1M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a75232a-3ab9-47ba-6d55-08d9d4ab4a90
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 02:37:20.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1nfOboznCcTp/KRu4eUplexxtzJsuzO1y9lBXzuhm5uqbgj2iSSDymWCVxun7jql5sgK8tSvab+93R0emQYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3017

In mptcp_pm_nl_rm_addr_or_subflow(), the bit of rm_list->ids[i] in the
id_avail_bitmap should be set, not rm_list->ids[1]. This patch fixed it.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available f=
or each msk")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
 - move out of the set fullmesh flag series.
 - update the subject name.
 - add Paolo's Acked-by tag.
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f12effa71942..47ad00d01cf2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -777,7 +777,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp=
_sock *msk,
 			removed =3D true;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
-		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
+		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
=20
--=20
2.31.1

