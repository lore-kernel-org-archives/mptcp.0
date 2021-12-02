Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E92C82
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 04:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638419167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JloUPV+n5Ss7b39nnrCdmSv7lBvs74XZHrVtllZ0GfM=;
	b=Aowu/Tm9/bxK7H4t28AcstnIqgdnuiOUh0UEWVntpIPjx6rgJjHsSEfUpcMlnuxlCHNs9k
	jzN3KMVFWh9QSEfM79VUcv8PLnHXy4z4sV6IrmZufrV5hX+MxHv18CRDtMkarK1ncS64CH
	HBbEJ0P0SJrY4NO4Op3LGwT0H7T93Jc=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-uxs57EJ7MSaEUlyvEREi0Q-1; Thu, 02 Dec 2021 05:26:06 +0100
X-MC-Unique: uxs57EJ7MSaEUlyvEREi0Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QszEN6S5so6zqWiJNcIK0k6raPPYMJJZ4un1reY5gSrQK6ndNVdnYdkmBifOqOJViB4gz2yTrqnCHdvEXP039CzfKq2hyiv4hKc3nzzOtIka2186NDkmL75UcIoprBIoM0PupJftUX/RTrVvT2oMedW8bBJJkzFu+zUmIUB8bsJYwlsSR6dWWs76HBoLmAmRDhks2zhYUrQLsrZQjbScKFi5nrEIizjyoV1iz6Ea6wTxrftYXMhgZ3eUf7ADAStJHfN25jkgQazAnIcS3SXSL/Wn0mozeWfY2de+G2nZJAgQy1G+sxW/qqP+MhuIP1SiTx55oMjpfdw78MeBd56+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GttTSyjW6YSZB59mVJRsuYDr68JUjldJBED/DUwkce0=;
 b=OStnMaoBM4Llh3M3d8R+w0ljtVv71SiD53FxH4GOV9coImCD5AW7mPvV3Llwwu4gBq2lcBqTdG1hJJY+SaQ3hiXd2XBClUG/wZu4td6I3mjTqKxwFAYAwyz5t3akQXOVT6B98/Q1uWW20dvWg0pO/cqm8vbAIxZoPXj1SM793LyZJTYV5IVKLBhnp+lW9HGSCrJBRL6TUxKjXVq7kyWsM7Lty2DTKuuZGKoc9XMjfPcGc4h1K8uW63e2lCWQzXc5JqCoS+RjNeuCZkq+2NEAPsrDt44rBmc1fPxPI3c6zrbVbJ6mw9YVjjHU4S47mk83SGJ+PiARGwfg1nw8Hej+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3514.eurprd04.prod.outlook.com (2603:10a6:7:83::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Thu, 2 Dec
 2021 04:26:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 04:26:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/2] send MP_FAIL with MP_RST and others
Date: Thu,  2 Dec 2021 12:25:47 +0800
Message-ID: <cover.1638418477.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0202.apcprd02.prod.outlook.com (2603:1096:201:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Thu, 2 Dec 2021 04:26:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50270ec6-ef37-43fe-c2ea-08d9b54bd9b7
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3514:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB351469F9292C95418DCD734CF8699@HE1PR0402MB3514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mlOhNb2wD5gurU2C+h3eFAO57699XXGNf/y2kPIPM0hpUPXnv6w/+EfeLLwQAMmUigmwltFjWjxH45z01uRy4JfQyTT9IArEpfqaqfv6u2FQETrwixQCVOiNfpqu4N9l59z7BII0YYbqMaRx5i1qJ6t6DhNilQxT1a8ez6mUFsylXUsNQVQ7YtTjgQrlIFnsyvyk707KS0+y5aQiUgDRvTJz8f+e0FGSjGOQHMowNuJ1fA9H31xSy9LGiPFpzWyvkdnGHvafRknfygtay7Q5BR7HzDjrylgQKekr/rN+MYpPBkXi6UNu3QUnsoRaHRINp3HKfS8KA6XMQaXE89jfW+aB2uqbMHJPzoND/U6OKYSvditS8NNSUHZZn3HY/NlGREHe0JMWPjXEeEtFl5mmICkEH9B/XXIxY7M/feUajy232GQQjVNxk+XnpssuyAjKljRpWb33uxtGNWvsSXPMRXvV4ruHO3j5cgdQuJyiWXvVC+tQC2Wi3KP++zm2aUcRJtrmabf4wW5xqegs+kMTtEeOcosyLisxXHrEuGwItv+M6yS28qxeJxETVWhRgFD4U9Z0X7BXIVtQG/yYsd+hCXsFsB6ejfEgxpi2zqFFE1+7CTM541QLsMn1Af+Q1iwkUT/RFAWTgb9U5y1nAV0d/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(26005)(66556008)(38100700002)(36756003)(8936002)(508600001)(6486002)(316002)(6916009)(66946007)(86362001)(186003)(107886003)(956004)(5660300002)(6666004)(4326008)(6496006)(44832011)(2616005)(4744005)(8676002)(2906002)(83380400001)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ScJ66rPa+JojseWsh8iokVEbgWRG/cYfjjbMzIha2my0z6PzsyGPpMWfZ1Yz?=
 =?us-ascii?Q?jFYvf6XIrFFDzq/OngUfK1jKJ3bmCxWw0+zZ8Vel/V1MLbeLQWAdpCN3D1WZ?=
 =?us-ascii?Q?1DZAzoiCWW8Y3Qn7wHfzQ+p0fon54MwjBDUO8iM32rixtqA12O+j1F4RXOVU?=
 =?us-ascii?Q?z7wEKgExqyabPq8D6AkBXS1sGzs7wy20r6mohvF8hCaVdNq2o9bR7U3tW1wX?=
 =?us-ascii?Q?hVlngLfPfLe03uGOS4vwMxA/mJVp7l6Oz8+KiBAJueD4Rb5BziPwETRizrDp?=
 =?us-ascii?Q?hBkZ88MZ3y4/GLUtemHMtL16FB5kNOvAAoRGAj+MeY8BEb2rF7jAJ6eL7SPg?=
 =?us-ascii?Q?muXPear5ghkQQzEt9UHVoF6Tko0WjQ4oIADmYSbLCPoCIDsS4Xy7LOMUiicE?=
 =?us-ascii?Q?uQmaf1znbP/pLkBL1hrmd70eUGBCDom0OJE7GiKBkzrWrnrQ5ydeR8N4bfc6?=
 =?us-ascii?Q?LbVNnMKjEijJ6Ps3Cwzy2EUJffpe1Pv+GA5IIPMVM4ST652HrO6COsZK+M6o?=
 =?us-ascii?Q?yUZNbQ1qpSdSJjVEEe9nSR60DTHfvwgyxsynJZklBFUraUlgzT+uFe2I76fe?=
 =?us-ascii?Q?AbHi2uXlMouYeueHm4xsy7vLS/hjgOqW42X0O93bpEhAjTKeCQwhvyFocVra?=
 =?us-ascii?Q?Zzno9K/BOtJNF61NmAgx1j3GGgSaiqvupfNcDLx8X+YlJsOcrBGHoPpASPtl?=
 =?us-ascii?Q?BznnJ28+NoRzgTU107hkI1emPXbUdadJypOh8qqSATTbWccFLqIpKLukSnKs?=
 =?us-ascii?Q?RCLCDZlLb3xFaV/bnkrbOr0NG2Ishes6cP9QRm13pGVH2eie+CcVacsIKF7Y?=
 =?us-ascii?Q?4MXiLX1J3cNHTTKWLIYiMscJUjEPPA+V6/U/x24i1du0l8+oUOgnVWM9yi9/?=
 =?us-ascii?Q?XfTADY08rJQRaKr8zfua8SJSTqmuhh/jHgXdyHNNCyCLoijnkEREWCSgr/5k?=
 =?us-ascii?Q?Zo/eSmL70CIQqqyJIYnI1cHeyGD7kS1N99jxkfBfgFzecxqQ9BpXVMGaaf7m?=
 =?us-ascii?Q?UIxrGE/fsoBhIm9SnpjeYxyP39K/pSGj1ORZ+2fj2KkiV5itP7pITUZqPPt5?=
 =?us-ascii?Q?jq+y2hIOhSb4MOC2s7UsCY2IL82WWHtXNqvR7di9wZhaHBo2Fc1nLHT7mxEe?=
 =?us-ascii?Q?GGbMxsazLRU4d32+WdeWZbrHNxabg0FdS73Y+ae0IinxAZu1jmEjljgCi4h4?=
 =?us-ascii?Q?KYwewPhhTU1KoBxHbJWH7pGoLp1pId4z+eW0DKJPOkNaeTBR2AOvWglfCuye?=
 =?us-ascii?Q?19RXYv2Dgl4BA7hXHFrRjvY7FvedJHRgng6xK+rcf10drNoZDblgVFI60gtp?=
 =?us-ascii?Q?y+nWlUJGd9Azi7UHdlz0fQMBdlRwyTOR7Ohx+YDGK9s14pw9kwXThWq3mUFZ?=
 =?us-ascii?Q?2auTTFJtlOQijgb5VdF1wAwqELbeTh7jhAjIvqvAzkoPE9EFM2BCqohXJfLh?=
 =?us-ascii?Q?e4/Ehkrr4iEKGR0CZjsyyK0QX850Z4xckrxZyIIJLKoGCANdeSylV7WRVXkh?=
 =?us-ascii?Q?rnYEbsuLkYdb9ZljLYIedNspXVbmuo4BWzCj28u+nXRR0L5ke8rwJDaNzrED?=
 =?us-ascii?Q?S8ghuHop1HWLWCSE9sXg1TDckhsYffD6AF0yBk4vI8pdbPgVBGYZIpBU+okU?=
 =?us-ascii?Q?FqbrDEKFPJhYvfnUsXYoBK0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50270ec6-ef37-43fe-c2ea-08d9b54bd9b7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 04:26:03.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfDZsKhoqN9WBB+WIlipEHDcNcclG3692jFYasHsU6FPhM8V/L2//Vdux/CaPhuqQx5sOHKg1AaHL1az6dZy8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3514

v4:
 - add Matt's patch, fix the missing ";" in it, dropped two empty lines
and added my Tested-by tag.

v3:
 - update patch 1 as Matt suggested.
 - do more cleanups in patch 1.

v2:
 - rename patch 1 as a squash-to patch.
 - print out reset_transient in patch 2 too. Please keep patch 2 as a
standalone patch, not a squash-to patch.

Two small patches about sending MP_FAIL with MP_RST.

Geliang Tang (1):
  mptcp: print out reset infos of MP_RST

Matthieu Baerts (1):
  Squash to "mptcp: implement fastclose xmit path"

 net/mptcp/options.c | 62 +++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

--=20
2.31.1

