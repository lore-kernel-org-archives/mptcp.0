Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBC38F8
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 02:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645065332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D+EYG2S0SWuF84ociTZZ86Tl1mqDlAk453Zm3hf3e0w=;
	b=ThdHJ9eHPbXE7ngwXdJWPxQ3wzVZ+UaTNmsO6y3joh7VeKC8EGjT3WX+Q+n0YC4evA4lM2
	bXlwuy7n9rM1JO2y/SnZmh1+pNga5a/n3j7UqzUl2q0ALuxQX6sPILMslPCjMy9RETWtqW
	d9dbTm9ygmKIJHJDC8CmX5EROuq6Zy8=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-n0M-2T3KPd2LiX32hKDuww-2; Thu, 17 Feb 2022 03:35:31 +0100
X-MC-Unique: n0M-2T3KPd2LiX32hKDuww-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk487Zey9EWQxuZcl4+Vf29OX5Z7TGFsFaX0nMQWKjzhNmw/JN6tgohkUxpo6g9UTYQemefqd67bDiHe6bN+MYsSWXeXrf3cKabqeuiG62QeE7guBjkcpACeKrGD2v16iW6a0OwBraBwuGwIh7Me7xN9OWNPMq/bCIqFWOHsB+GsMVATqzxsJo6XmJUncB8wrFuTYo4h+lXH0GJey8Up0BJXsceWWe3ldICNjGdk4aTT7DmfqMUyUsCfGYXVlaYUNW1g5II8aCN145EipmKUP/7MrTDEc5Px/kf2ST5NRXZmFswT0w0VukdeCPeTOXHHXD3FeT2H2xt6Nx/ovOMa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgYbDR92f6LlUDjUMVXrZWSsrWXBoJ/yBxkOQ0B90uk=;
 b=HwQ6OoUb7oc66W/MFUwrQt3Gp7m2HKCagfHZqZ/eSI8C13jPD25lO5zD0gsu60zlGZQKDH+ccRSYIV+mq3dxj/90yo4vhcmCI6bq6wNbHY8kxvJ/+xvOGDJw/WnbUJ7JN97J5HRO6RgpUe7RjVRszjsCHi5bKeAZFhtZAIHj0wbzb5s1jeNsbS2Yz6DzDWXjMF6DMtb75KaTo4YKNltdxytVOTWGvO0vwYiBEiz3swzl6COgUvI+58yN+aV0DuuCRyrUcGC4wzkrGMfzttuOoll0wsfPqC50qCDF4Ct5nb3nPsvCzCFJhsbG9kGVPvA3NSCran2tRTVnjjN+ZkVIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 02:35:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 02:35:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: update output info of chk_rm_nr"
Date: Thu, 17 Feb 2022 10:35:53 +0800
Message-ID: <ee0bdc98d08bd060763e4000b4b0420d8649c521.1645065312.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6787a973-703a-43da-184d-08d9f1be2901
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB62833613A601BEA306DF81D3F8369@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fPgcK278Xzvf1sv8sMyuWkd2LqT3bPXEHsLWYClQuR2RJVQg+SI+QK8ViZOfOiteM8UzAw/iph62Gd8Qv5GLXTREu6R/nE5C2fH7j9UHcFtm4Lpz7++fRM8g3qLEqdLmETeYKWRtDhKRdySRbg9LY70BpFJYtzrzqndk/q4Na/MhfWYfd0JKJ5kbsbAc1BWVuIuYchvARcu0vJ81U9N6z3samSLHXwdg6J/P36XK6z4JJ6/dFjdBvIQL//+ZgG2KyX7OBpV0jcczQEKUaqpxXzTX7HG86njpoXDG3ZHhVNoiXCSRyjogXDZbErti+RHwS9PU90ZMBb4INvTigNUvN4jSaqdtedWdbrJ4tGHBmeU2AY+yWYudAcKXa22QA9a9RO7bHP/Lo5nsEcWLQHIa+W4X26lPxa8YkFpHUDY8FvYVU66o+DuAIZgJ3MGyHdTtNNPqu5elxZ+GNu74bSh9rWxh8uGezugqLT7kaRCjNJDcDepmcqtomZMPCKIF5DhIpL2CyEsyzvtKpeRTI/XKQuG8oeEKXst8LgLlXz3DaNHBWUykCecK0/jXaUC3Yjq5ZT+w8ti+i3lXxok10Y+63rx1i6Pe88FRTPX/LMHWe/GTvJTWoXUpSBc3MjOSezHu+p3I/sCmVFyG+d+bQXoExg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(38100700002)(6486002)(26005)(186003)(83380400001)(6666004)(6512007)(6506007)(55236004)(2616005)(107886003)(508600001)(316002)(66476007)(8676002)(4326008)(66556008)(66946007)(6916009)(44832011)(86362001)(36756003)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jG0eQpEaz1xGUf7rYC3I4Hl6eb7uwESD4OErFFO4cQELhhGfwewRxWndnHc4?=
 =?us-ascii?Q?MPGAkXcmtkKU9rde08YFRH3GGix4Lg0R6kLRhcbl9JEBtR6k2/fxuePxRlEt?=
 =?us-ascii?Q?0NOYNAozBvw2NlJF+Ffw+OcUjEHUfeVgjQTvo1xZhJOwM1n17ZTBKZlmX8r7?=
 =?us-ascii?Q?J9v0vPtoXSubkNKNHx9A6s2ApCC2ZnJrqdZ5xjzZjR7vdF87ieJ2nsMGAxZV?=
 =?us-ascii?Q?Fvfnw8JPE2f77crYtfMmYBncv8XDiT26S7Jw8QpnAPHPuOJFB1lM9TqVDaws?=
 =?us-ascii?Q?eo3QB0d5Izvcg7EXyo3F7QJPbe2M+/qb1J5f6vsL/QHlyZX4PMEYnq4NuFcy?=
 =?us-ascii?Q?RF+vUOW6U8FD/2Ht4papIEDXJqUl8QPGDCxobaGKAAL9Wen0y8SfA+BlMGuB?=
 =?us-ascii?Q?redudBUiCcPus7LXXGGf0peFntH9AEPy6zqrW0JEU1US91C5VvrxBRB0mYeT?=
 =?us-ascii?Q?wv10nSOaP9DU7d8KgTtNCI0KmEj6aXO+nytKXQzRNw99YhzYd3kd08gpV4jX?=
 =?us-ascii?Q?FWbz8ynO/CEk5T5y37wZ0EUW0tyzM6KapZbvl9P03zlLDjCjXowIT9I5932A?=
 =?us-ascii?Q?4A1wuReUjlxb6i+eN4oh8tiV1yU9va4m9vWbsWXJtED0MhM6z+ufZJ8m6CEF?=
 =?us-ascii?Q?d8+USp//8GVZA6a8c+jTuY88WiwpnaUD2VD7zjBtasdynSU1hhAItVz03DIR?=
 =?us-ascii?Q?TwLR0KqCiv/nLb8Q8iPqApdBWC4aZ4qk5ffgXFOU4PR/mCiw7cnQxaHUMD7+?=
 =?us-ascii?Q?Kb+BGlgQyVbVjJXUABu48XE4E7gD4XJXMouf5MPE3MjpyrRe2CTZhVTG2WSK?=
 =?us-ascii?Q?1oN8nW44k2X0586sFq7kNAHSDKI8cqK6Z5XA0KfUGC5LeA95KNbYSSKhQqdg?=
 =?us-ascii?Q?E03vLTUXZosUaDn8A8nds5D3grLsSQ76oTT0+bGNzAijNpFUpyS/BgfPNNoC?=
 =?us-ascii?Q?KcgcDoVpZ2/Sa7gypUEhBP1jJnT3lxEVOc6oaefFH56Zo/ZYF967+mcRjqjy?=
 =?us-ascii?Q?4xjNG3Jk5Oq4YNLM6pf7gvsyO8FQiGlnMOYkEY1MtURK9/VukCu5x2fQkIe1?=
 =?us-ascii?Q?t/KRXcSCcs7Rozux52JpyxgwAzKzyIivbU5rwwd0WvKzSzEnmG8T6M4AzK6i?=
 =?us-ascii?Q?3YT8L647rGfSKzfR+tL24tiQkJZaHIwZlcVAs4KSCdvKhg4bdgyqzOCsR7NS?=
 =?us-ascii?Q?PXm332KtpvEqT4v6jhyT+m3ffcOeDf0h6Jj3BTYXoQ/b1vSwv+J1CvMXqDZS?=
 =?us-ascii?Q?EcAzou71i4v52UCSxKT7dS6CIU2tDVPtDAM2Xnpj1sd1PxS9Z3+vLeiSGgaw?=
 =?us-ascii?Q?RCiHDBoKQBT4XNcBPaQHVqBNbYiCVcAwChimi87sGN9+z9xzDhu/XO6r0nBU?=
 =?us-ascii?Q?zBq9fuiBG+Kz+a1aOsRmsWeCz8IBDSQfL+SS9QanBeHNWYY92nVBP2dbUe48?=
 =?us-ascii?Q?CJyPf8tFYIkmwcZsme8dXUjgNz5OaYoT7aUnRVA/vaBTDnIyIh+fOr3Pwa8Y?=
 =?us-ascii?Q?HWE4V8aXZTrLa4BYNFVPAql8uPvj1Zi4mlyZd0mbSMTv7622lt4aPlyH95cx?=
 =?us-ascii?Q?v2QdOUOQa5Y523xJoJ1BvI5NNp6MTKVF8JQgybHg465xEHIUMkH3ByEmiHea?=
 =?us-ascii?Q?I3M7Yxm2/AiSSZ/O/eFsccM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6787a973-703a-43da-184d-08d9f1be2901
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 02:35:28.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSvwTtMmyLPrteHdjILhbph45nlc5Q17cV7EYZomcO27bPSTg/cMO3WliDgIt4pJv/vOElvWKvPl51wTV6m6Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

Show extra_msg after dump_stats, this makes the failure outputs the same as
before.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 37b3d00b2dcb..8708be740334 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1274,9 +1274,9 @@ chk_rm_nr()
 		echo -n "[ ok ]"
 	fi
=20
-	echo "$extra_msg"
-
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_prio_nr()
--=20
2.34.1

