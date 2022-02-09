Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1229CA
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 04:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644382389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcCDJzHNV6kcFpm6QUQWBx6GY1KwXHjb2MCAhKpBMzI=;
	b=VuoQQ19IyKExTeIeV4J1EJrfiLQMNLCWBsa+ukScTv3Gofbb0MVWlcQdwKXYuahWhkk12U
	octwAvrde61eVpwQSI2BUjLskjDWAF57DYNiuYau9aBNsg8SDK4kR6nz9Fp5wRlYx+VhKO
	uXgKyI5UwOHM/bvpDOcIQxzgw/AqEeA=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-znD6YYH0P7qEkNAw3nU_eA-1; Wed, 09 Feb 2022 05:53:08 +0100
X-MC-Unique: znD6YYH0P7qEkNAw3nU_eA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAHVffEDVbwCamwIsf6haHJUji+DOj2opHZ4u4O3G6myQVbd0jR4cUueCh22Sv64RMFx8TCzmSrjFfJr7paxHcNIpLUF8vnCqQ7nzqcYwdMWzIGB7N6FKgUdBFMr9fBai4Vrfdt8Nf7BCqgyrHIJQYWIPmhxd7wEj5s7U7ONHqk1eljrfkJ0kYBUV6zwEZw4eb/kHx+EU0yrwmZQ2t1PbVD7IVuFw67rcn9NYq5HOpmdmzHVDECAhA2Jro6eeYGyojoWHVgXsZU3EHDKkPjSdmwIfBAMh+rm2DZ0046jDYup98ZQv/GWNxdZyBqBNP6xqRawPdHhNH7NGjlEQ+EWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a26/8dAG+o98EF8E3cZi1/wwV7DYzSfMYnFb5dQLUqc=;
 b=dYxdWNbp4NSx4hOWdNdpxVNpwCmDqbuJAlJ2oXdNfKT+tsIv7BYPJeaBR5mMEdp6a6wpwZOjNYtxW0UhHj+TeAl0FBoO+L9YoMnUCiaUqw5AA+JMzu0igC/jkQRAGCTzdVcXWsiyK5n3mIB6AQjenILCGhXH2Ivdj2M+V00aRCOxy/o85VzzhvY6qOVMPeqM6UVRVxqzOvMUittDnMBnAWywJRJOuLg2Roym82SdE1L2Lb5Q5yh2VMJxT8aMUJstiRHxNcv/jcGccgPzEACNf20B+rMgD5peTKhU4jOMUe/J9AoFzzdecYUZBsCbIfZp01YGE1R83iNSYFk8vIrToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6125.eurprd04.prod.outlook.com (2603:10a6:803:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:53:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 04:53:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/2] Squash to "mptcp: infinite mapping receiving"
Date: Wed,  9 Feb 2022 12:53:19 +0800
Message-ID: <621a0237b6c15001e3590b27358dbb854c2ab6e8.1644381932.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644381932.git.geliang.tang@suse.com>
References: <cover.1644381932.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 275e5e33-615c-4c83-ed31-08d9eb881093
X-MS-TrafficTypeDiagnostic: VI1PR04MB6125:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB612558BB8842FE40EAB04BB2F82E9@VI1PR04MB6125.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qNX/MG2hKC9IkEhGY9WFO0GqkHR0HxFGsy+lutBlqj5wPFuXsorRiKRkaDpHq89CZwktuhSgkDL6N7OX6zsHR3L49t0cyfqLIF8f7ClW3JRgM0Y551vHm162Kj+s9aAFiwiskqT/jLGQ8z2CyZw3nR3Hf0tVjixdmFXcDQii5YXxT2pQi17HW4Yi+tQ4GPY95hwFObkrYAi0fL4QPZxrR7XSd+mlcST21TZ7DXgE0qMwv1kIY2Y2umA9rIYo/s954+GK2BxEw4s23okxROpJncCZLZu6G59EfpL5rAeVbN68eiuV0+6N2HkNnwEy2SwZ0zSXf9DehPzXHqeHvfXwjM+iE69KKZn8UgeUQBt5ejubuAsgEMnoblEoeCj/hODablF7NtKsr3a/FT2I0OKGdbGiDBGXdo83yK1qBhF9gr7uwZUG/F5JQvXlcmKn6Jip8MTZfCPuSI3ib973EJ0SL/uEczSJREbtW+1OGqdQaAueiDekUPBfH35I6KAw/RHf5fRrcLx5R4y43DFY6eKvupdDHU4mJcv1tQWaF8dxL9l38cy6N6p5wr6u6ZXQs4RAA8fl6UwBLisZZKWfDcFHqGSnOxlbmU5TIaBub5NyJKxHGnVKV4Hg4aP9a3YkKx8Hvt3Hxanzi41f0IXHvV8v1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(4326008)(66476007)(8676002)(316002)(66946007)(66556008)(6916009)(508600001)(36756003)(86362001)(38100700002)(186003)(55236004)(6512007)(2616005)(6666004)(26005)(6506007)(107886003)(5660300002)(8936002)(44832011)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tLfmO6LcfZ8trUj2csSUtVRCP3/BFY+aNioNQCnFnrZCbUkgU4I51p2zZj0s?=
 =?us-ascii?Q?rZ/M6IRPrJgJaOkz86v8dhjZVEj9uf3YNt9LmVLDKLLdSQxPEy+WPfoU7Wei?=
 =?us-ascii?Q?BHXFryFpu8f06QIeOwXix9MNHgOR7GBvENjf8bMQ84de03n1Eu/CvSwwH+Ui?=
 =?us-ascii?Q?pggHLu6iIVrQ41lqII1D8SnbZQZejm9+5+9oBsVGh5642yKEAjGB1AU0WpPn?=
 =?us-ascii?Q?0gE2f/6CJ854dmRyKsEhOlhSayUS2DAKGQIfSppj5GAbfOBD22xl8vziFe/K?=
 =?us-ascii?Q?VAvQUu64D8Zfe2tc6MFK+qiesLXMuGeJfoGJp/6aMLVvBiLUuEfhO57kBQ2A?=
 =?us-ascii?Q?3bFQpbmSC1DtuNDXx2cJ2uILd5sgY8NrMNXRomPno0LCbpK01i+WYQbFB7xg?=
 =?us-ascii?Q?OdWIyFXJ4eRBun+Bh3MRfc/Bmvy2H34RACs0q8f1lDDghNUn2s3UlBKhAxC1?=
 =?us-ascii?Q?TRsuwPFNl/N8YwalkAG6Gp1dFrppYztLqkqYiA76rkv1phlDKbiUGIxjgfmH?=
 =?us-ascii?Q?u2fHx3VxFUB7AN9nfxK1zbF2d9gqQKm4GhuKHgyAlDA5bARidNXvO58lmbYf?=
 =?us-ascii?Q?pNDDL+1vZDJtD/Qb8nhwfVyxCXhgY4vs/hNMw6K1cXKwWP8adqJxJLYIUW3C?=
 =?us-ascii?Q?nHnXO8x9M4R5KJAqSqm85RQqer7FnNLKGHZAncwjvF5LHVUFFS5uVjgb1yXI?=
 =?us-ascii?Q?Y1Jo5EwVpxBSqzuRxeQAIO0rDCzjDgFLWbUk0Yqw5XLW5Xwxtw2yKJe3+rhp?=
 =?us-ascii?Q?Ix+3dHZ2sDCLYepCU58BvNEjAZGswzNBX2Ok3eBgdCJS7OOODgaOKG2p+Udz?=
 =?us-ascii?Q?o7jILne+RcrUHokR7fZYO9Up6qg3RkMt1y6zzlPcEusUnMjcatkRrrqPzFOb?=
 =?us-ascii?Q?EXiAYJQHlXG1nuqmvjo3QxVFl8kFXxath2uFGhDDbYJsqHdQGzG89Jr+msJ/?=
 =?us-ascii?Q?jDhiVgCMQEKc+ByKpueLk1cLr0A9Y/kJudsMRIAeeR4zYMD8F1Ad9vDqEH6T?=
 =?us-ascii?Q?qxp/kkOmp96ZqwpRe3Z4xDF2wYTDKow+ANag5uWTJcWj5Hqq2fbNMu+wF1gP?=
 =?us-ascii?Q?75W+iKlyTlqCu3d2LHbYldLCSE2TXv9pcKz/tE8X5BPxv7D5nI3eSw95no45?=
 =?us-ascii?Q?Sdx1R2qRgs3KQlOCb96wAKlmM0uSknD0mfTCrQUy5CJCxqHZJC+VLBheVAqt?=
 =?us-ascii?Q?l16xCNq7/4DurI9lLxa6d+RNfdFtXzITph7S2EFhv960Clkp2WVC8EVIpiFr?=
 =?us-ascii?Q?vxtitZcLfsnWt4mBUQDPajkdX7OeC/9kTqR+QOIfjDhqmAYECwSsJUKbNYFw?=
 =?us-ascii?Q?FVIWsBNn4/xJWDOScOqaazi4EwP57AjQ7PITctkTVwBzTaSCP/JQdZj+B5lA?=
 =?us-ascii?Q?VVdJWwcyNKJBSp87YjQe6fA+Nolw5xoTozKErU13U7ABCUGbcX2U79esVvID?=
 =?us-ascii?Q?KOS39BAomTancVvhFyRAYWfPo6XTlAi+kBBa8hoBEnDm272MOYAP7GgUC+d2?=
 =?us-ascii?Q?SZj46KK/SPkUrgJMDeG835kKusO8W7VnBJ3Ob1ALq+pgbtMjU9Qk0FWLm3H2?=
 =?us-ascii?Q?bitIhP2ZGdNzrq9/PSdwyH6mRjXjNuBDtmgUBqNOsPFhLshczh8E9nvkglXB?=
 =?us-ascii?Q?/tJWDrcPUgZvEtFzcjUR044=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275e5e33-615c-4c83-ed31-08d9eb881093
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:53:07.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOOsRJ8UIH1nHSvW+19OzYqh/V/0/9NjwDDfGtn47uu962m/mg/0f9Nz1fIo6BUcWK87g9cv2z96QGydJ6pxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6125

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 485f00dcaf84..ae4d855f3c2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -962,6 +962,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
--=20
2.34.1

