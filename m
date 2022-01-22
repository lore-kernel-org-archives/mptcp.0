Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EBE2C9C
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642842026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exKyCxPys+ZbGa1YSvUpKby510uxT+j0SMcpswHl1Fw=;
	b=A9H7ayRG3khspGxtSz1/HxwAypnOMb6IKoNUbnf05DA8+k0Lo0W8hYHrC6IWhgdc905ARS
	YQoy3zA0/yGNh6dqgSY9fVAW1xiy+m3uVHZP12LBjDa4S+2at5VbYuyogjnyBHbXlxu52m
	y/FuEh2N8rJTYe74dMaYKdoBakPo3eE=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-KsnfGgwAN8ulsY_HCZWTyw-1; Sat, 22 Jan 2022 10:00:25 +0100
X-MC-Unique: KsnfGgwAN8ulsY_HCZWTyw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuwRCmqvPVLaRyiTdYhj2SWjGpAYdZMRC8YnJtTRn4dPYJdm0eq5/ROSKPP3ersZNyGgAy7Jn5h6du0WvQboZOA3oQo1KoWeW0x62KJlvDVH15BkbqSpOTSzRF/aK73f0H9DznmJqLtuqj5iLZCgrfU6m2uPuUojpIG05MxkIhstTi29ebVHYRyB8nl1/Wn5CuAACHLFmw+xvqCbacm8zCLceDHYHF26BFz9tMzSMLInzC/aG1yr3cMSAvXGF49te3ej8ba/tKzrcQqj71bxsSw1Gj/3QsVjLLppDR5krYJbo4bH0JQoKRCLpkLCsNLR6Co/8K04CXaYNc5afK4Mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGdyF3yHd1YX4lS7ZkAo9Pof9c7ERd98t5DXLuR92MQ=;
 b=BKD3mAVaNhER62XPRBzuZtpT3+QacfXpPQp1mwVTL7mAOagjLIYXBr0byDwgL8LY3yrZe4dSqaEOULhPx8F4RZKgjfS5lSNy0CraNwKUY/Qgetj1Y9EnbEpQJvFhRD3OxEzhsTnTd8QOu6HUlYNWWDI31yJwEaOhit06v3XanR58ZN/FzOiaOakYZvkc1dDyLO9ffTO00AKQl02ShdIrf7erfXTd3dCIvj69vFyZLtdceSEer7EzA70qDUWNnYbn3bLDnar+ZqBRJEDXnahu0BwynyOm4iSXIJJvr4NBTfYWo+yZUpmezH52ZMlDQr+FLj5CkkXSRC4oiEBcaW2sAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8854.eurprd04.prod.outlook.com (2603:10a6:10:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Sat, 22 Jan
 2022 09:00:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.013; Sat, 22 Jan 2022
 09:00:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: add set_flags tests in pm_netlink.sh
Date: Sat, 22 Jan 2022 17:00:03 +0800
Message-ID: <6c188cb9b8df2f07782f77443431fbd1eb04bef0.1642841713.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642841713.git.geliang.tang@suse.com>
References: <cover.1642841713.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0219.apcprd02.prod.outlook.com
 (2603:1096:201:20::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4ca4b55-8493-43a9-9464-08d9dd85a05e
X-MS-TrafficTypeDiagnostic: DU2PR04MB8854:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB8854A7859FD76CCE7C6E03DBF85C9@DU2PR04MB8854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fyI/sgD9R8FIrh+3I+MYzs/hQya2nb1OjqjocTSC0qmXcd0OfWWbSuXjsilcAc5bJsEZxkv9gjux3PPAVEgcnSSm6IBJRNjLOSuCsGhSxuzNxJujCs6hFjgSXlyAwHmXa1fHrM30DVIL/M7x0NUIFpGYTX5P/k48MydFRMxKzXYMX+C9tjf7U2i75i9FCqlPJsN4l3yLT6DsOWYQ4rohkXxBJMbW7FNfuU7eW/ti3mpZ5R0rz5C1Rb4Tx6njFwHl0fN2WCaVSOHd43l6Z6d0z3ftZGSRw/icCXLH6G5y6pd5SKIaEbHIFz9ANQr7EfJztWWQX7RAqSkx/JMooolLTmo8g0RaCp1aVRbqYlaASZppKIteWUfe9ZiYyepLgOHphEjSPB8yML9vkLcJAkbPqMxy4jP2CABQUnVVnS7s0+3zBqv7mpRE+oKb2XLmva/IaRh5fDuF4xWzTEyKv/WZaUNT6Y7LX4dOQAO43NtTV070kulNDRABrEJPDtrTzP2Gfa61xP6oUjppeCMJjFNsKA8isYwVj7bbgVTjty8chmJ76JVtqpRbhCpw3NaZEdRGWly8gQqX2B/vPx6gzbeDRVR2GQsNVvwBCgGij2Nd0FcaT0eyhpw92uG5lvO2+ZtqcXTis3nNYAsFC7uEH39e81UQldZgP9PCYvnwB2YTVdsr3dsXVZEK0el6ERniiTZ5XuznqYt0P/UGqOiDqnPTAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(44832011)(316002)(5660300002)(508600001)(186003)(6916009)(4326008)(36756003)(6666004)(26005)(6486002)(2906002)(66556008)(66476007)(8936002)(66946007)(8676002)(107886003)(38100700002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0s2t3C5d5V74RULlULdlrMPSUDkWhtcuO4bsU1l6GoyxXUxus05c2phbnCV?=
 =?us-ascii?Q?4t55J9J/SEn0VGNsGfbEV9rFnh773lkhE11krEc937Imd7DHWujHmBjX5kXp?=
 =?us-ascii?Q?5Otx7trI64W8+No42wcxiG3vZbUrr98+/ebMwCZFxdBwDKsj7NBXrCwuqRxZ?=
 =?us-ascii?Q?nA7tgpAUgoRqqR7AIWyY6MTtECY2DhaESP+pVoK7fDznEenTiMVrf7G6qq+Z?=
 =?us-ascii?Q?RsJV53SN58iG2S0cDGtzu/nnTft5WT91NMYA4oXHBAH3DtBZUHeZ58OvrDaJ?=
 =?us-ascii?Q?WH07z179SqmGWhUPs6iw06vtOtCNYHPdj2duHbWnq+bhpk3RW+O34pn38FTy?=
 =?us-ascii?Q?PLV/lbOUfTgNjWuCWAk5TBl0nFbmMP3C3jmboKZMeDI8K1T5WA4AoGuQ+OXP?=
 =?us-ascii?Q?CNoxcgeEH6ayJib7sQs8LDihG8Vv22atqaELuD5LovikgmWdazkW52338Zd6?=
 =?us-ascii?Q?doNGHV7DZNxIJ+IClj/PCswczeqnW0T3JFhAZabLzzsnEu70qbFwv1wEODMk?=
 =?us-ascii?Q?BDYS0Hp0n4fkujxAX+z71vijPr+WhkiW2mx7Wfz15eMzWp8m6U8T4goa9W+/?=
 =?us-ascii?Q?Mqj/eJh1hl82gyy5glS28MxtaRD7kJ2ooseZQe5ICqb6SMFKOPa0jb0kMNC4?=
 =?us-ascii?Q?/L2tOjIUoP9RSRQtHTdeLKvyp7ItLh+A1kN72l/psX2rloIF7DOeIzLwc6Op?=
 =?us-ascii?Q?AY2jWRJ7BfHkXA5Py9Q5HkYP4cMoSNx9S7jYNSHlEZb+NJWfRlReBBjVdpWR?=
 =?us-ascii?Q?LO+/vKdiCzQz1SB91OrmYhDuqwJbNo7b+8L3AF83jWVV+ONZBeADgNRQcSlq?=
 =?us-ascii?Q?7trqQnJtaTrZV5cy0TVl/8zv43xtt2kUH6Azi+w/SWVx8U0re8aAZKdsbFSr?=
 =?us-ascii?Q?vD7UYH0ERU4siuDZNFyBAGc5TIufUOqiZHP7X/P4/8TMkhfjnX5PgEbP3YtO?=
 =?us-ascii?Q?aRDi1tykClseNjZSGCSOMLwjpdjzaJUtIgRwWq4rHcll4GOMtzs5isSMz6GB?=
 =?us-ascii?Q?20MTz7r5IzPIYWK4Mwa+m1p/ZXtfvXDReK6I2syiDsycGCdSzD2HAizvB3EQ?=
 =?us-ascii?Q?k+yKFgxssV9bChbuUrbpbDApOWWzbh8vtd2spQG35MmCTl5HSTkipcVqoV1R?=
 =?us-ascii?Q?gSlQc+DaIS6Gd/B4UzEUDFMLWakj/dVSrMsiv4VuX+OFtKFPwhBieay5Z4KP?=
 =?us-ascii?Q?o9nGbQx+G/GbT7Qez/dhZ/upL2eJhGK2UT85sxnBweujkvRx6W77VSofD3wv?=
 =?us-ascii?Q?QAqcIKU9xnZNnoqZmHbUH4CMATe8Ys/80fqyLEgBmScqz3JpQkaPvA9oqRA+?=
 =?us-ascii?Q?xHVSlqVROnR62a17RJj3EfWb+CBUkFN+sLrUya1qO/DnFNQq3p6KlKbvL4Ij?=
 =?us-ascii?Q?CGA/fyla9UsfOwubK9Z6Y8pJoJdrmpuBAS9QY4Hv3bwIGnFiejGmQxUJ7fRD?=
 =?us-ascii?Q?jw3qAdVnsWxZ6mPIP5yFDJ5IICrDRbunCMJgz3BBHcz8rvWeDkrzAtXXFk0a?=
 =?us-ascii?Q?nv6ZlQJxP1EouUOfk/yS/iLcTlvmKVOf6mSgiYd6Osn279IBrHPQRvYVIyNK?=
 =?us-ascii?Q?LkaJSLOMyTx2tGUMDUoTVKuYmbjnhzJMv4gbnO7e7uHiPR20DqFay9eIpm4z?=
 =?us-ascii?Q?rL7GQzkdbRQ1D5nIvoOL+90=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ca4b55-8493-43a9-9464-08d9dd85a05e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 09:00:24.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM0xfixi1sZFa+tjhiPvhByy49LQEypCknKYVaeA4n/FdPJKOWxCF1DKwggPiDE/8b9iCe28LS5ElBeZi9vk6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8854

This patch added the setting flags test cases, using both addr-based and
id-based lookups for the setting address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index cbacf9f6538b..55df8b4e33fa 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -164,4 +164,14 @@ id 253 flags  10.0.0.5
 id 254 flags  10.0.0.2
 id 255 flags  10.0.0.3" "wrap-around ids"
=20
+ip netns exec $ns1 ./pm_nl_ctl flush
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,backup,fullmesh 10.0.1.1" "set flags"
+
 exit $ret
--=20
2.31.1

