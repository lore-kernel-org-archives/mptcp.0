Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D010373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2urn3mj8bKPuICWEnSOn6hqQtTXBrVKv2oZwb/UX44=;
	b=BXcPvsOWnCf8brW07eU0t2Z7+GxDe2k/kj4AKcWLGeBVzOJZh9uyk/d9tIHPUQJdMetwNz
	Tgqc0CFbmEGysyMA+4urQ9ZtWrtpgt+RG6+k3vMDXKKvy4Xh2ck0xWQoAL6Fc/iwm1QJ3d
	8HYa3iMSU1TNwsMOOpec8+9YP3h1ERE=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-ghBomu9ePfm5WqhHKnBNQQ-1; Sun, 13 Feb 2022 15:50:09 +0100
X-MC-Unique: ghBomu9ePfm5WqhHKnBNQQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOjo8x90AZkh2duCWsRbdkza8PXJM6YIrKNXQC/ohWsnNHiuD4uihmorX44vmMU5dg1QFkC2IQxqJrAjfLe5OiiWC/hiDpUDFusXq1mJ3QlxYPGXb4dq6THOvPxg8aCOgNtCZYC75gi/3lh3cEef8QuyptWG0hWKO4lbykfT0vD10I0h6AB+IB+AUAoUD+aCdzliJypC1kHY49xtO7A1B1lgwMoFMmf3AyP/saX9hOrkj69cSuIVAOt5S+cPynioyDoVglTebT1blEV9m+cm/P710NgPyy7L2qJJyTCvfaZ+tqfQfc8plw3+e9zfwYqT+cn6cDeKwa+6iysqK3qfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0jxqUMBE2aCtMYHfUvMPKc8+YPAi7YlC9V4Dp1GBxU=;
 b=aipTcPfiZpY/iO9vEc0c+ZsuEy+DVsx1WUYUuKVoipxr1UiGvTSvVlpnRbdIx2kG70lGSsdqdfUuO74bbxYKWeQsYH8fwYIN23eVPoybZbr5Tqz3ow24bX0jdgCJB/KdwkSWvJBOaaU50Ft1DCJFVqvkQ6rqaKAB5qeZhiKetnTlPcJUJM7Uwm/mSgSPt3LYskMMMs466R/1dWCf2r4kyY+mbjKRMC8eDRdhdJT9gIKSyqKMK91G868Tlq57S6X/kmTg7fiyy3JaSK0miIDbm6NPAizIg/2ofEIu61Q0IhQgPCKxNHSv4If5hiEW9xjooO9byvx9bht+frxXRqe3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sun, 13 Feb
 2022 14:50:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/6] add fastclose testcases
Date: Sun, 13 Feb 2022 22:50:30 +0800
Message-ID: <cover.1644763526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c475dcc-cf72-4f7c-bafe-08d9ef00209a
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB48454C20B22E3679118A238DF8329@VI1PR04MB4845.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	++rnV1tUlU2pC9xkOdmlAys9x7OsZ9nUJ7ucY/9HMeZTUh4iSeJQOiJX2LOEIYZs6gZpgOrcKL8Ag2Wj1wc+Orn+hXS+U+2akHdEsWOeJgAe43HL8TDZS3UFPIZPt++BFI9v3fo6S26Gh5nn3cE5ZEegpTmWbdYo4tOOelCeF47zfzw1WDUBaPsaMoSSU46GjuHX8M2c4/oj9Ggpv2A3y2cokIUqw7PNqhoYj0YlrNZkZ2sRNamg7FrKjK9JHxTldIOt/jHM9gpXDl8F9CwVQVVpYLTB/lqitM8OJfHtC/7WX4N+ksLx5bjQeZDrVG8dEV1Q2J8IsHebtI5bRYvg4XA6chDuqlgsPpt6yZJN0ASJ1sZzARiSW+qp2Pm2waCVKJ5Lln3U4B6q6udH2HJft6uzuGAw3IiYTZCUgYUgbKxOb58Z4CwbH+TeyEFl2Mb3MXWN9sjOPDfbwNoiwPIXRFLZsADNDDW+6LlknR65Kmb6Mw1kVKgLEX/M9qRBm2OVY/NfF2TW/wrLcAybLuIB7MCqEKhOINoShqN9m7GDWroNORllqUCYEfwdZocHuTk4Do4FMmI+pr5oLWmELG83MV+ASJaMsT/018N/53x31XSmXOFtfxdFhGBDsDlKDvsgdNxZeBAAWWLJuTf1IBo26A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4744005)(186003)(86362001)(83380400001)(8936002)(6512007)(508600001)(6486002)(6506007)(6666004)(38100700002)(316002)(107886003)(8676002)(4326008)(66946007)(6916009)(2616005)(36756003)(44832011)(2906002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5AbFknZhGeGIiJ/Lqma9rpSYztxydGMeJZojVZoa0IbAQffRInN+VsbxOx3e?=
 =?us-ascii?Q?3eRxVDHNCcXHXx9dSi7S6ysmU3JJggxmwwylzz8SK94x+3wvDfoDnKgny9JD?=
 =?us-ascii?Q?WrUhLCVvnHqoWcu+z3fD2XMSQyylmgFwgsGDhOnreNTKrOGw/KXqtzWmvxrz?=
 =?us-ascii?Q?DxVYoDgYtt7ztrQKLx7yiRpaBIXMvnM4YUAg3zrp4hwGf4TcK0GqFhomFqqL?=
 =?us-ascii?Q?CocXJR6W25P2wk71ueBZcjWs4K666pWbUPgBzGZpCcWKjl7WA4dr8/d0bF7F?=
 =?us-ascii?Q?eJqiuoLD12nj7rVfHGcM0TwRf7B+dZ3IJju4BR9wM1VhNzLdOg01UMl82V9P?=
 =?us-ascii?Q?tPVUp3T9b3mORRMP7eZHGTMyngr5qtVMAkz0j1f2NSJR+OKKwN9qvS4wsqFZ?=
 =?us-ascii?Q?fTEBcK1n35bFknMydeg2LU0dBaNulrwDx9mKRNkn6Vbujw/teRuHJBpUafkl?=
 =?us-ascii?Q?ksBz2EXHebpVqih9y+81xw1/98D2M1+IiSCH0tDfDz+vTQZ6+dYlKjXz7hdn?=
 =?us-ascii?Q?tI/ExJ25dSpjJoUtQo1UHKAtRcCKqWS7Drp1QRDegU3NAMptDbNi6/bcYquy?=
 =?us-ascii?Q?+3uNAcUTx035HTTKAJQkh0nTgJHup7T1O4pj3oxoT8rHkGIjQsF87GOlVIdY?=
 =?us-ascii?Q?WMm/rY5MBpoKO1a4O22btBhvg7wgMfIHqkyC+LgCYjkUtrY7dcQlfYLSwdKJ?=
 =?us-ascii?Q?LwCCk4hafMsprM8V9Bb7/cGWT33fDtzp+zvx/q4cAdFVeLabPCk5mSBCpTnq?=
 =?us-ascii?Q?KhR8JGbW9C7nKR/LM1Rn12lldKeZRw1vog/quYxZamuNKZZZKdkWZzP2fH7Z?=
 =?us-ascii?Q?HQtGC/+jEeiLiJ/ojJbBW5FHCQ3BfJiGIGNycZV7CtZAoPlfvhuyYoe5xDC+?=
 =?us-ascii?Q?BawCcMqd7cxtkvivavpLt+rE5cCkc0gqCwol/YdC62l9kX9QzVwttnbTiqI5?=
 =?us-ascii?Q?hmNscG6D+TEWxP99h1dC8yUZFFHJslRGZmzLxrrNiB61TuIdQ0ZOuq6RUfVP?=
 =?us-ascii?Q?z6e+kxfW/ro6OhGNXJalUfJzwvbvj9Fx1ewfMzpzy4+wVOVLReYZoltxpMg9?=
 =?us-ascii?Q?jxkvOV8+jvEdYLDBOt8fIlAhw8mfkX/GdALxUIuIOntEOiTwMNqnw5ze8Rxm?=
 =?us-ascii?Q?b5++kyQNWnG4181syOu4YR2mm5+MkBffvIgMD59iCMosdRI+GMQWVYSvQIUr?=
 =?us-ascii?Q?jHzv3VBGwaD44+uzI8pJdKsOpMJYv3zOYP/JqSoQ5unn7nytsrNgbMja5gpf?=
 =?us-ascii?Q?OJm1rRBH5nr8HN0fH0cTnjbhFPspc4SDx/VaJPmtpZNyBbKeQtUNpb8WuCSu?=
 =?us-ascii?Q?KrcE9nIlVXhTSniVpCZPv/UQqEofVdfEWFrRWtKeZJKsgd+uoDkE7/eYy5Qe?=
 =?us-ascii?Q?KqXq2iWcmW+AtVl9erhUN0lQq4juBeHE+X4ngw2GW3Hzkq2pccGmkQMtX8p1?=
 =?us-ascii?Q?Boztjjc+gcYTBOWHGFXASeM5dulzRJy2qF/bGoMYA0J7iuM5rxHRmkU/0tsD?=
 =?us-ascii?Q?Qy1g0jyMKMufoUoyd983/64aHWT6dUBRcc+sLo0mT0ZdaxJ/dcQlwdZqpHle?=
 =?us-ascii?Q?Z9VtpmG85mpu4SrNlt9HrcL1Gdwev8jl/glXQU6qE8TspIqiw/p7Yyh8yKG0?=
 =?us-ascii?Q?f9aKw7VDhFcxpwNFujarnsakkTXFcuKCJbjFeaNhfSLbduio9rzzcMtmdLRL?=
 =?us-ascii?Q?uEkFazbNwTuXRyTzmJhXELOJWlw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c475dcc-cf72-4f7c-bafe-08d9ef00209a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:07.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/q0MAZPory+ngkMwdXYNAmlnqeYD5r3A+aAWZB9rPK7s5MhcxxJmx4Xc3pb9G8AgAc1GwNtvQ/EMyNmbPTKrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4845

v2:
 - merge the squash-to patch ("Squash to "selftests: mptcp: add the
MP_RST mibs check") into v2.
 - update the commit logs.

This patchset is related to issue #48 and issue #197. The two MP_RST
patches are moved from the "add mp_fail testcases" series.

Geliang Tang (6):
  mptcp: add the mibs for MP_FASTCLOSE
  selftests: mptcp: add the MP_FASTCLOSE mibs check
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add extra_args in do_transfer
  selftests: mptcp: add fastclose testcases

 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 143 ++++++++++++++++--
 4 files changed, 140 insertions(+), 16 deletions(-)

--=20
2.34.1

