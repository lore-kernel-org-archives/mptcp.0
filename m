Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420C20F9
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645423929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t5vdUC/2BmYSiIUTRP9Rxbiszxdud5zqz7HH++6DrmE=;
	b=LwIsWipc+Y8o4G3Y3Od4VqH7IhtVZTEpS7Bkj21d+YzaJXfve0sqQDQySrflhDt/O0zpUY
	Q4Pm0oqLULsfpzfcVSLcXm3nONF79MgN0G1KJvkFd6Cg/eiR7S3DQI+902RtUwX9oqc5ta
	ocRKDSns8lFhj45CBQKRJAdV12w/hHY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-h_dEUI4AMyW7FEyAlnZHAw-1; Mon, 21 Feb 2022 07:12:08 +0100
X-MC-Unique: h_dEUI4AMyW7FEyAlnZHAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWJCITqwps5bk7PeAGHaYO5tRIczzS/b7+QsIxZmJUjTsjqATyJoZNI0tPaivPujYEC9cIFYGWobVzXmVzXm7C9zHVdZAUjPkTxtB8EIy98ff3n31jHWfbDCjsqli5kYMITVpIr2i+uRGp0BqnOdtrmFXIHPJbo8k69XOQGv8VaJkWBhoNdkw9LvUDiuaRH40KJBZxVB/f5pqzShYKpHMx5CrH2n3r/BUw+kmQc0R/ENrV8kB72ZLXLO31RCn1RGm7cYJxr5EKvrVgH1wB1OdAPJ3L9yYrV5VrR3Jda/9cYYWAXxxu5eFU/RSDI1hrdGFC/cHNZxLKr5hb979k/T4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDmu/gO/0OytySZEjgUwiQCH3H5yB659YpyUC4/wGBw=;
 b=iAe9Ovgy5irfTKT9tXja/+1GeEVa8PAQ0wGK3/fEo1dR9e59O9vVaj0suDePLhbN/GazmOb2u2yTJhYlg/80BP/GZoh+1qRSIsg5z0E/Irzn9vPs4p9AQMLbqKabauMoAz4iAyykK3U3gmWeUI2iQLiKrvauniXLfnZjMklajHXneaxgwsWa7oOtf0exdDkXxK3h7nkI3At9CJYb9Rv0Xa/5+vGghoqZL1lMvb1KunW6SHMR2dvZZPbwDs1lvFviyaQ199M9wpzeN51U5tyZjptHm2VPcjvx3n1lxpE7+8C3ilN30sB0BU5RXXaxbg9eRQn+taHO36eZN5J6tGfYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3550.eurprd04.prod.outlook.com (2603:10a6:803:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:12:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 21 Feb 2022
 06:12:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next v2 0/3] mptcp: add the fullmesh flag setting support
Date: Mon, 21 Feb 2022 14:12:35 +0800
Message-ID: <cover.1645422873.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 805897b9-6f04-4bf1-1269-08d9f50115e1
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3550:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3550CD969A11EEB0C694D516F83A9@VI1PR0402MB3550.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LA/zPT6xgRmo8MFGbuiMeRGsS0AtnnxFx5BCPmWxy7E0W5XWAlx4UL6YDv7zo9kyLveTjepuYaLisZGOx6WaS0FoiUrtPlWqRHAcHGS8QoE5e4N9YQFgGDnjczZc9e2T3NMjchkwiiheyyBCxLX2GvHQ5RixhSevT8f2OoNfywori/drK6VkJ5YtUBuAu6uIuonpB7F/hzjQbOMvxhobeOe/vaHCeO5LyWIrX5vymqdotLlNH93GAYao4zixGVX1CBN83QlZ2xAyz7Tiw9mfnsi2tvr/A3Fe8Qa0g+9Kj5gQb71IblTw0tG8N+/2WFe6PjXQED0nlF7YuTn/XLUBGngwbLXL66lHiwDoqZGNPo1ZGguIKQ+Wq0dbcfbnfMXv+1vUtK0ykvRFv7sO6l3JDp8dp7WTYDJmjpqnlf+3ej3BHp9U7aqCFO0z7oYW/vTFGaKup+p0SFPHibPHhqsmR5zZKgxgEfN+YvL2TmRZM7oX1ZcdCUxnBcdfRl86YxphQzyFiUE9O3STISfn4eZo272NXb5BLZTRPwg5qbGZP9Y40kn6oEnro4+oVqSaFw9tkyjYq1UBrYro4cjmYyflwQA4CRGGdpwb9FU5rbZmj12M5L2EGVGLpD9AuBer/6WjyTcWXgnC+78qX8MXvq9YOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(2906002)(83380400001)(186003)(26005)(8936002)(4744005)(44832011)(6506007)(6666004)(6512007)(55236004)(508600001)(36756003)(86362001)(38100700002)(6916009)(316002)(4326008)(5660300002)(66946007)(8676002)(66556008)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbWhZou4JPbtSXKHEDNEXUozuaH63HICKxsnLJg9rUDcZ6IFjkV6oiyoFXLd?=
 =?us-ascii?Q?Tov7fay5AS8LjL9GEO06esSK3InSE2Mi841Upgti2H3oJWpl4+YhKN+AgvNB?=
 =?us-ascii?Q?UlGQ1uhSIb3rMw9GiYxz8OJbbcdfR/DaZCDyfZlobajkWk/V+88cdPTwIg0P?=
 =?us-ascii?Q?T4v1t8Pbtvbru144tdVhRjdlXQOLuFlRrk3mzx4P+dPkCXtob508cpSeffTk?=
 =?us-ascii?Q?mz5t3HqMKeNQMmT9dMGkZmGb1KbA4paxb2bid3/PV+mdcSNvrwoIpVv+MkJf?=
 =?us-ascii?Q?65cpf8CfMS2AaOgRDg4KN9uAY/X2pJnJX1psUKUKlBZxMbumDziGIqZ3QdJ9?=
 =?us-ascii?Q?iO3P+8E+m/mstO8bl0/fkzNmB5Bdm2Nj/j+IeheUuKRCfbKJUU3ZJvxtW8QV?=
 =?us-ascii?Q?ud3iC4eQA+lT5W3WjGhw3qSoenZpqAFe9Nxo35cZ/FVXJHuVqhL2rTEbnGBx?=
 =?us-ascii?Q?DlyVBslPB+vPCl+2NW/7yB+v3GlFIiAqBGD8b6uCYUD3wF5GqTZqDmUXcUu8?=
 =?us-ascii?Q?bQ27M3XBixXZ2AlGfiTNI4mhA9yXJU7iafU1qQog3LqqST4zl/cPrpVACLue?=
 =?us-ascii?Q?vooRQIgiCuLPF1lB2R2YRZCHZSud5oJwXKHxlyHiDW4SfWcvhTtLFg5yN1fh?=
 =?us-ascii?Q?TApRsnm5STJmdOeRHgQVXAV7hcCWxGApPCMbed7Skc8a6iwZgT0NoyBXs80w?=
 =?us-ascii?Q?Qv2EH795ygZ3sOzjnZOkFspC65ma/Ncg1eNGvWK1fAcHBQLcsjely3M83f5g?=
 =?us-ascii?Q?QPefiGVjpHWy+jVgjQ6euiKHIV+XoEOU2KJGNcFjnWhR2G8vCrr9J4AnPuL3?=
 =?us-ascii?Q?yvkf2J7IurPpCJ6kiqHHjj9cyIeDGPKAJ8nFJ6ANzuicu7EtohahVLop8opC?=
 =?us-ascii?Q?3x9wqoc8Rj8lQWKTRS65Ph8ga9T7DkXj0bfmeJ0lYqfBQ3ccnn9TqfPJR9Ib?=
 =?us-ascii?Q?fZL1uutqI+ZVkp6yV9+MMa4YY2F2Mnn/Ohobp7oYbB1NVb+iVJVETFsjB+D8?=
 =?us-ascii?Q?I1zcxWjPOcT/AyJ2NHf6YASCLsQInkp5pkNoevOmjvAOg8twPSM8y/zvJ1tT?=
 =?us-ascii?Q?jnks4lFp8Tl5C9tt2X8FIz1AhRTNGdRpyPooScG2eEKWtMNBHBxAfat57sbT?=
 =?us-ascii?Q?IF7S9TTUHi5R+ptTFOxUyCxtoUFx/F+z0J1F6fkNpFj5vZ5Y67Y8zNXZN/RL?=
 =?us-ascii?Q?MdBLW96aMic2DV2thEH17H1QJJ1j/vmxoF48ByYSKE9TilxJeaaKr1/hpU9k?=
 =?us-ascii?Q?m7NdFl3aiSK7MKxH7e+YqmcUzkGxveiTVRe93Ei6vlvfw41DGXAdrgkpdpeB?=
 =?us-ascii?Q?kulJc7kh2OJOzZ+WwY4EehGXkdKiqVAsiNbot1kWQlOB32XSbNJAJJAVnRjf?=
 =?us-ascii?Q?GBsAUy3YNucjWQeyKGYM0ycbJHGJbALX8BRvFBMosqFFR97N3u1F8TyAfGY/?=
 =?us-ascii?Q?k2EXUEW8qzccsjWK7jE6HjccuqV31CQLfh9V6ooZtZ1wr+mJJSuaxflEDwvy?=
 =?us-ascii?Q?Pah5N2q+RjHntcW+2JwThvQ1S0trvYR89fkASjNpb+q1njRL+Ty2NwuIDrcM?=
 =?us-ascii?Q?uDomgyBRImp2hHAKU411zX9EyFnpVXwz1iEw8yE709v9vqBr6ZOdLbxH/B0+?=
 =?us-ascii?Q?+3oY3ErjTOuvWMPzjh4pDxc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805897b9-6f04-4bf1-1269-08d9f50115e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:12:06.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7pfDEkpmHpOWdCO9JloXD1BpBJ4WgiAQjYWGOiBXgNI0wyhdoF+Y8PbLqBL7+8EIKAVnIkigH3U/x8iK+Lgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3550

This is v2 I try to send to net-dev, v1 was marked as Changes Requested.
I did some updates for it, so I send it to our ML for review first.

v2:
 - split into three patches, each one does one thing.
 - update the commit log.

base-commit: 4f015972988a5f5d74e1f5f6435d08506eedca15

Geliang Tang (3):
  mptcp: add fullmesh check for adding address
  mptcp: add fullmesh support for setting flags
  mptcp: add port support for setting flags

 ip/ipmptcp.c        | 28 ++++++++++++++++++++--------
 man/man8/ip-mptcp.8 | 17 ++++++++++++-----
 2 files changed, 32 insertions(+), 13 deletions(-)

--=20
2.34.1

