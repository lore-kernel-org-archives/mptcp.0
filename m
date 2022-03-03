Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D7621
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646287485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qMaBlQjQQ5Qfb4/dyjwXJKsS22T7CXKZUWTXJhXrO44=;
	b=Vp5pLmVbKyQV3O15kvZBiuD1iVBKey+e7tc5N4GN7ZVGmNINs3qtbi0OhKA3wyd/diClAz
	5lFVrir7/qkaggNMNN5NQRl/3Ub05jnoXC5QH4TK0D7HD9oNK1U6sxJEdZ7HUomPaPGKqz
	5VKlqIjFzHKFWQOlLj6jBoXwubAWO5M=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-2HbnylsCP0Gbk4Q4iCHvQA-1; Thu, 03 Mar 2022 07:04:44 +0100
X-MC-Unique: 2HbnylsCP0Gbk4Q4iCHvQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk56BshXFYCbLYKQJUxGvfEtyJATp1MT1/67psQR8BtXnva/GUoKwMlZikHUir/l/iVTvXuBvw0EMoPBxSjSYBP34a566OkJqE4wZ+k+rpMHyLo3DF4K9CImqqpLUGmykPXln5vW1KpjjHs9wD0YjQhUEc9rKZVOREtWO7LUrAplCg72xpYlrwLTaz2vhVCgc2fu2wbfitJj2lkiP/EovwQC3Yf1iICqR/yw2bpgnvuIw4id28dRJGjgBfi3m13XpksPqeplHnCY7umng4xDozRc1rRl6WicXcw9NGA1f6RoRPyS4bEpnpP4ZVYP1iAqhBZOncSfMk3qwML/IS65rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwdK9AYb3PATCW8tcV1IXQsgRe849U0MqiLAKiiXVFI=;
 b=XNgX77ccFOgEd6Z3VWXz2lSKnUwxS5Wg1Qf2n3xQDf4utU3656mQnpRDwHFv2CoS7VrBpTgwozkiZRUDkxQJC1aY0f8vboA5CBnQ+b5dVVnBBpA/2TosoQhA5FJlHM44tguYbX+4nW/+qe7isuVgtNGnhTEDvsCHCGMD3/bzrFjZ6KIhaspf+wCNuIa/1jfrEPWKTp3BikVt7H1exQPDrT0LXtvw2iESiVxWUDJz5lo2ZTGon6h4uhaRBs9GvcHthnbciEOsUPNqQO5nUNBNxfL7w2Rrb6YPtnFRukFPiTICPnkianYNs6NHnePqXcHtzwx0alOhtQBmznfB70LyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5041.eurprd04.prod.outlook.com (2603:10a6:208:bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 06:04:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 06:04:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] MP_FAIL echo and retrans
Date: Thu,  3 Mar 2022 14:04:27 +0800
Message-ID: <cover.1646287286.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7ffb839-9950-403b-c366-08d9fcdbb5d9
X-MS-TrafficTypeDiagnostic: AM0PR04MB5041:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5041F2EA19BFA59ED189EF78F8049@AM0PR04MB5041.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MqiSju3SLOweZVwByoWO0KDuOj+a+yxSTZsavCOwwi++N9mHv7ye6KF3PBn3Huo3+XuIKpyhyYtG/7uJu0rzMAw3nwkseVbRgN9MRDqw7jU7CD3Z0vBATIZneJoBDFC2RwvA5gUZqXYJT3vNSAkeCv3I3VXmy1u3tUiUI5CKYh+3Jnoeo+Bh0G5L5vJTY+ycQq8LEpF9Bocmgpjyf3FQw5NkMn9oSIGBG6bY5WQOGeeroBdRM+icw7wYD/g4mnXEfQFwskpy2JgOIluiDgOaXmvebKz1OaJxvPKYxwy8ZY9YVrWQFhmXy8cFoEN/L2ofXtmpPJi124n0Q+MtM9JEoRLg/tKKghng6rzl1COpbEYo9RjuF0MhUhqkVhp/5qY9q9XgIn8Pb5Y9Nq2wV8mu8yakyOaKeP5I/voDc2BmuUVFtDs3rzESVE6Z7nvnnhuf0jl+2UMaLE9K084RM9p5MdeRfiiybKN2ecKxhPQgZWL4t9xXBGwSFtL9Nh1+N02wfEo22DgoT/E+/3QHhrxLYxxez06TCNk6alTdwp+Pi2HV1X6wJ005CeVpikp6gon2i9Z8iMRrRFNwHyxx6J7A8UBnvE6noRbeR48Uvq9zrNkEaDxdSf0XLoPPxQJ846jl5S2Z0/J5B1RLKAugMkPxynxdDu/lYU3drqLiRME1nnoXBKUxyKbWeY+II/vmnv6cmSkTnPoucsUEWFTzYJUbTwh9/IcXIqsivDLoF8TYAedO0quSFq/yEyd4UMhSErQHS3RHqEn1tMSsEQIR6sGsgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(4744005)(44832011)(36756003)(186003)(38100700002)(8676002)(4326008)(2906002)(66946007)(66476007)(66556008)(26005)(6666004)(6506007)(83380400001)(966005)(6486002)(316002)(86362001)(6916009)(107886003)(6512007)(2616005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rC9rw1JB93Vb9wnAO3J80NceRgf4vnY6N8AG5xFJ64lZl7dBtHWn1DWsmExS?=
 =?us-ascii?Q?GhA0s1oStoeAFUFF2Q8IrpcwPxRhUJm0+5iW/m4McVGaMrSHjnzDg7YF02uP?=
 =?us-ascii?Q?IY+b+JXgGuE2qGNBr+5IZFzImcuMxVE8z3jVDtYkz+dIeAInx1xlO2rf2Bec?=
 =?us-ascii?Q?crYhkH29SYaByBPyOqSVXn7bFNdkSuO9yc6qlOIk1Cf1pdo/7PL8xJrfphKH?=
 =?us-ascii?Q?7NFeb0QoHuB3j7xkuWw0bmGYpxghqHA1VcbdF8n3g1FytD8NpGwA79p9cqWY?=
 =?us-ascii?Q?FiH1piMwUrgtlEJNFhqH593SH8VuXVrjjy3b2CTg+x5iYqWpuqj2sw9tt/Db?=
 =?us-ascii?Q?Qo6ygTsnwouEIILb3IpWlzWc0bdXolY+5s6pXJks7bI0wZxXUZFXU4xX90vE?=
 =?us-ascii?Q?uMtjn63L9ebpuMIdQlBb2sbg5+DMAQesLet1C91gcozefgM5p+UE0r++HJ8n?=
 =?us-ascii?Q?f2eqeA1FhhwhQAdJVGh3AOB0fNMnvZX+uOz34Xmk0bGu+6ioOKuMYiDwao1v?=
 =?us-ascii?Q?OCBPFljNpusYBMvwMru2u5qJRQJkR4Cv+kgAWBRwSoweDt2IlBnCEq2T79Oh?=
 =?us-ascii?Q?NfMm4++S4XgtafVTFKV1Zb6y9OqA5WUIf89OXpOYs07dQgtD/KEF56c6QkrD?=
 =?us-ascii?Q?5wNzqYjVaMuxTU9ZpxFek0uEseyYJSDcLiZykNN0tamxnNLtekF2QCrHd961?=
 =?us-ascii?Q?JDCF9Q/2LcyjD5vryUz1/OAg8SY4ig3rCE6cWWbN6nLeaO+Icz4zFJLZAuSF?=
 =?us-ascii?Q?E/k0wf6fP0RhQhBLHhGzNLw58487ptKXCcg4Uq37TIAvD3ra3gWOSl5c3zJ5?=
 =?us-ascii?Q?YXsRHnZi7N0wF0rNHYi3Aj2mWbSsJSWX2YXIbqaOaqcmBI0b7PmuA9kkAmjF?=
 =?us-ascii?Q?tSerrfzsPIvqJ8dnlUDBNnNfDu9Yf/sd2cR9HZqEMdt+36HDMLPtu082FyKw?=
 =?us-ascii?Q?ZVdN0Wl68rvcppEu/PP0vFnZHpKZ+Y9p/FCuIGxazsE4+5xeTiylRssUC1Ti?=
 =?us-ascii?Q?lYbkjmAf/DLBNRr2/gChOo78k3YOO8VzMaRr9qPjxbufQBtxfRlOxNW+1mX1?=
 =?us-ascii?Q?zb6sQj9OkiaW/fJ73UnBvPJGreLNLDGKUGkH8CMUIGMxoYKA2FWwSVW9gcM1?=
 =?us-ascii?Q?N18eBYNRLNFlQgG6cN3GzVCALThUhv0UGmDecB4BzH9N0jQzlybAtQRMozHE?=
 =?us-ascii?Q?Avzwvg4xiib8mQYjaNp9h/flPqNpI0GRvoMKjZpnqCRJPYaSBH15oBnlf2SE?=
 =?us-ascii?Q?2x95aZ+EYPNv2yinhXWY+VybqvyQ2Zmpvmv96KHNBfb70kTawylwoBF5cKca?=
 =?us-ascii?Q?aoOctVGZtTDkvlU9wtdUhw1I3ZR835fIqrvgwmzbKQar2A/wmx85m4OfM/TR?=
 =?us-ascii?Q?kP2TD8vXDRVeNA2ycwbdUzyiv4NHihqXy4w2lR/HqO5wGEqSh0TTYlp4I3b+?=
 =?us-ascii?Q?oHmK/pIA/5WYA0ys/DqlF9BDeCXEunQ0QmeWuGNNY0/j8PIsEQQmOqokYooo?=
 =?us-ascii?Q?4dE3p7zEjM/6pjlYRY+LpFdY2XH30ArGTUhWx91ips8+uiXTQ01wW3qqa2tG?=
 =?us-ascii?Q?/ByJlbVIF9wMbIu5+mvD3A+N3k34R/is65ILRD5GgQaNx3fVuGP2kseJw4D7?=
 =?us-ascii?Q?FMdkgXVyxyWrVMKNoM53Y6M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ffb839-9950-403b-c366-08d9fcdbb5d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 06:04:43.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AdWZLpbL6WdadYMK2ZVsSer9KRvxXi0EBgcQ17X9/Ctdp1vIL11QSNlY7MVM52PnpsYwzxGluC8lUIcDyS6lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5041

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261

Geliang Tang (2):
  mptcp: add MP_FAIL response support
  mptcp: reset the subflow when MP_FAIL is lost

 net/mptcp/pm.c       | 12 ++++++++++--
 net/mptcp/protocol.c | 32 +++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  |  3 +++
 4 files changed, 46 insertions(+), 3 deletions(-)

--=20
2.34.1

