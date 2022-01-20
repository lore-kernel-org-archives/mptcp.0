Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206162CA8
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642662984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuyaWVFKYbCDcs4Vur00Hl1MmzNtkuLDczQOiaUhQuA=;
	b=MmkybYYGZ2FKR0LEYH8hlG02Xr0Ze9uCV9TQq7KOWRwaC7K66aKq8Z5740NIrcp0lRj2n4
	+QGdcwKeMQuyLswFnJdO5CeOBHT0tPiPYW5gKxTcLGArtHGUAQ5oHRB7Oux+B5aA2+UJ68
	LNzAjHtYwnRX3SmhOmA0PAkZFBosOlw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-Vg0AwkBIN9-C3oHHxZ2xWA-1; Thu, 20 Jan 2022 08:16:23 +0100
X-MC-Unique: Vg0AwkBIN9-C3oHHxZ2xWA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITT8k11Y/FX69OO8ZxeDbVbykqIk+8lrLXECc/w5S01AS023l5+Y0ra/UelGI0WKE02mPkYP78WJpWnoFAh/3/wzYhSuJF51CQbaRKT/9uZ/HeC/aWE9DZmGQVPOf1J+Mz0czfZLnL3Y2paEVJXyIltCW07VsKq/4ahwH8CpdCrpArdJXmkM/cSWHQp3ARXjHP2us76iykI8yDcpY5Q7hGM4ibBx7SYm3kCC6MGKb/PLUikxwkUKQB+iAyifnECEU2BoVrr8L3N3OGlKJ5/+gbn8QYlp1dRVSZsIA8j34b5pEXUfjpsDPBCXYTJDyxZpDYr8wVO+vjt1m2876uME7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk5BDNh86E/WmzYh0kvjYiGVYtgW6IAS0V7z87Sw7js=;
 b=kjkAIcG+Z2+I2IBkWG4ZHVTySUuOvUr5wqqvJgjrsr6JCTmwT7hL9fDbLHRiTpUN7mcyxEeyqTHKHtQjQ9zMy3OGF96kpy8swgcTPUPovZD/S67PfMArB7U76QgMPbcf51gx/8DwE565qgBAap4dgLvsiVyvW2nJ9dCyAzL86TDU9iR4g5khfqQECqlYb0p1Lq3NohMDSnNx4+KS2VRseDKJ13ib7SMVPOrjZjYRvc/IPFoOUV79+lmTQWzfD8N0eU8AIxKB/u94HkY0dMvhq1Jb3873mkYz3cEFo7JbEfQE+Y3un6l+wOWuaXcogq1FMiy3J8BBLSkjkxEl0mJ1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2441.eurprd04.prod.outlook.com (2603:10a6:3:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 07:16:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 07:16:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add backup with port testcase"
Date: Thu, 20 Jan 2022 15:14:29 +0800
Message-ID: <fcd0eb14d057385432c56c8eff3354dea454c8ed.1642662777.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <62353f253ecc5eb7724f0599cf1baf087e2cfa5a.1642662752.git.geliang.tang@suse.com>
References: <62353f253ecc5eb7724f0599cf1baf087e2cfa5a.1642662752.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: c431b343-7d70-4198-2db4-08d9dbe4c261
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2441:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB24413C39A1502350FB6C82B2F85A9@HE1PR0401MB2441.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kOWL+x1qHcInVRnFbumN/FrdhESg0p3rJe61Rj5pHlXWDaKkrG97+W99MMyeAxwsGwOODJagUXuMS34P4spA33EMz0B3Fxxh77jj/jicufsP6F7Fo3BJVttCPZnSeo/ym8mMZKdfo9hXl7YB4sBWitEZ5PQsbgI4j2e7yWQl1rjHTGyiXlinGg2s17CweV9bN8K83QBWG+MGnLElw5bQgIM8fu+mlV3mUoodntc6w9j9ON8piUr76nCcuUegIU883HfBwj+LHWl9APwu2n94IuDIhbqcVNA0G/agYQHQaaX9aBucOYIt8EseunfmcjK3SWVB+R2RF8idzdhFxZ1vltlWavciEjYFii5+ZuKyYTfwlYUyFRBCLQpbF8d9C/kZMCjsJRkTEfN6nEgLlF3b1OI/OIlJyPyTZXeCstDv6aGMzifGcG0V5lRUSWvwMEe5pzWn+A8Sp2men4eldnbM03tad1T8cPOK1C0o5+CEXyC9cz6rQ8b8sN7euExl94pNaFSXRvhdUTtNk5X+ziSwiqUFMerlT5wYF7MaxLQxKHKmpDTlE49YTr0e8TBq+bqHj2RVL57txRaxlHacfKxzVsWzo4VzF2cIpn8awSYigk5NIhFERUaFcwowhYscq/iroOCFFYCH4Vfravj4gbofMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(2906002)(55236004)(66556008)(8676002)(83380400001)(8936002)(2616005)(6486002)(6512007)(26005)(6916009)(6506007)(36756003)(186003)(107886003)(44832011)(4744005)(66476007)(508600001)(316002)(66946007)(5660300002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2byg+17nXEqrmnf3CyN5q81zMPoh3dQA1r6bLaXVD8XT80YocFn3163+Vmio?=
 =?us-ascii?Q?crLWatKoGh2S8UC8cOfkG9nEghFpDdfQUB8zLKw0kmYq4C951QwFSIRbM+J9?=
 =?us-ascii?Q?Ekq/6rWRFzuA0/V79NiI6AC9Ic+1McHTJgrLDSH1slkHhWQk6hJmjrCN0vHh?=
 =?us-ascii?Q?Otti9oQ748j/lyNt8SQf2EVupFuVHtHNfw0+cdui4S10UfOhm4qrDZHobDAr?=
 =?us-ascii?Q?QqB0vPUYAJmZ/QdRwBS9I3bH+3tmABhSQ7xONx7x7QQUS4isAyj7ghjE71Kk?=
 =?us-ascii?Q?86LM6xrSj1U2oQLNCh70zHLdw5ozrrVVqbHif3QkWU8IlhQKnExoQQbuprsA?=
 =?us-ascii?Q?Q3JI+Nz20Hj6nTSMaDBPesrQbx600neJdlkfIHLVwZLke/CHWugS/0r1b9rL?=
 =?us-ascii?Q?RelJP4iSKG9D3MJCTFgUYFYVcxvIickD5qzNT0j1TZgJskfNfTmbiJcPV4vx?=
 =?us-ascii?Q?tCnNxkSZ1eDzg9PpAK5v/Stpgz+uyoVB8CoGXLIt47Ok7kds1pG2MBHZ+Jdc?=
 =?us-ascii?Q?g27GR/m0BxjfKNeEB5FOo3QbCbGwTJqWBuPDHzqHCIq+n8Dnz3H/yuK6++FG?=
 =?us-ascii?Q?oTp5yArhRyDcAUAqhJBwoggKLiuT/piB1HxOv/DsHSWGfNWsXzrHD+jE9NN2?=
 =?us-ascii?Q?XZTmhQlvF88n2076nC9L4Yb2F5zxRl7/aWpw/HrMOPAqnakjdqGMfnhE4IjI?=
 =?us-ascii?Q?C1k14l6NWCccRDoSCsXHlXh98Y9K7EvtC34t3psVJewqqNRxyJlvI8+Mekuu?=
 =?us-ascii?Q?GE5xnnlNghme+NWLjlfv7lwD+wxBBvAkn76FR/prw8TqTbu6IVecLcg2PUhw?=
 =?us-ascii?Q?CFlUwuFtGJkkmeo95ppV3fkeZ+PlDMWOBmSRgr8y1G13xGvSyBWBguCHyK6B?=
 =?us-ascii?Q?qIPoU8Yr4hAeSxP4tKP7icBDfgrDYYt7lP/jxIHkiLl1Sqxw9JF4V1xWd3Cn?=
 =?us-ascii?Q?TDBwNnbksBpIwCUOBpiPpsKRtuxEYTk6l/MfiaOSOXoZ7V37Ak2zFPF5+i93?=
 =?us-ascii?Q?gcoBwBqAXtxiDRx1297AQxeaIY6JMAC/v+sPaPGvDkYxqNvn9ae08v6lbL9c?=
 =?us-ascii?Q?CLbLEqICBfg/AABFEiNjcjLpE7UDi36IzfxwNXNSugx1+z649STbxdmV2BEa?=
 =?us-ascii?Q?CFMDmP164IY2LTltyEhwUI/p0GCTGnYrZFGLw92+3EU67npnqxnVi9kKJJtj?=
 =?us-ascii?Q?fP5rU+bS4sYnWJ2jBzpeUCbatGgO7y31W83tAChNcR1ema/cus4rGOJZLxxg?=
 =?us-ascii?Q?aVUagoKC493VxlUu6GNsRji5TtjMLlFxO+iCUSTyS/p6lwW0DNx8YNdG/acD?=
 =?us-ascii?Q?27g7OhsEV9f55l7T0Ge0ls+/mBAtfdUwjHpvUsorzpjjZOK9tnnqZKW6kKpM?=
 =?us-ascii?Q?+DvElND+myMgeMokJur+oU54pA8EkbwfYZONBKHwuGbZNY1HrFqeHuDikulM?=
 =?us-ascii?Q?BEdjpENlLwC/RvHzrkPG82pTbum58xWaQatUNhBJgVSNl0Y/n3uym5NahBBD?=
 =?us-ascii?Q?ol/sigrquU10huNEl+f+2UDWp/Bb67XF5jrMpEWJzNy6/sAUimzCesdqlhS9?=
 =?us-ascii?Q?0OVnsp/QEXyKG1pgKWGhkOoxKvAl5rPR7OABvrUzWCfHIdn4CQ8A6iLDfXcf?=
 =?us-ascii?Q?A2P7cdu75irC+LabdsRkwFo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c431b343-7d70-4198-2db4-08d9dbe4c261
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 07:16:21.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkzlKNL+pBjp/AdH5wGlTehnEVJarp5oAwHf82BGkOyjRuXcTO4AY4Apg3x8eK4h9ebTWfcxl70nGUhkXDd8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2441

'-z' is incorrect, use '-ne' instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ba7025064fb6..ca6e47203455 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -500,7 +500,7 @@ do_transfer()
 						fi
 					fi
 				done
-				[ ! -z $port ]; _port=3D"port $port"
+				if [ $port -ne 0 ]; then _port=3D"port $port"; fi
 				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
 			done
 		done
--=20
2.31.1

