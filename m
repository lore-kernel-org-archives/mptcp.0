Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37CA2A
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 02:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652667373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WcY0qUdlbR0bI9pEmbQOJ4nytcTygkQPstryNMI9uQQ=;
	b=IbLn2rBiFtThNvarEfhh49WfUOcWuJnhx5vml5ZzcdE4iaLtgzS29Xf1MD4PZkP/QypZxl
	CT/u6XD/e5H16LxyNeKSkYL5hMnKhnKb7wPfwED4WOTi2MqPdnT9UL7ucPVxcbcoKF6zA0
	afUQm2F9yBGbkAkKpYnqD9aY0J/lWbg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-X52T2dlRMYyCj2Mnk5_iLg-1; Mon, 16 May 2022 04:16:12 +0200
X-MC-Unique: X52T2dlRMYyCj2Mnk5_iLg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhlxbCwWGh8dxFcLqXxXn/LzHI4WZw2TAE0abTGBdlORz9rOuD/7R2q0GkvvPnnOxCZjf8EQrDXDAH1/vWbksd2RemkiO7uDbv5Mq2Nc+b8EDxDqouuQGi9m1og21JcV/qQuGKw5DCILw99Tk7v+WuXvI+KqBsDZ2bZR6IiveQgluv6oIm1TImo+ncLLPGpvRussVcBCTo7cv62rZUAuS5pKjTKdpDuFrjPaS2oggBl3ThYPhOzlRoFGHxbnfF3+2FnjZVMpPwoaDjyk2Az52cFylELsVAwEwm1V55s65xKoAlmGjcrmG8uCVvmHrRZb9C1mxMMH/OB63C5dKlrVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXjgKVco8o8BVdX7MH94LS2WngAjAqLbrNeTsAJSi4U=;
 b=bV7JXaYe2vNJYfpbLLwIul/9wXvr0mMVt0oFP7BnGeFk5n7YgBBd0f3qqHeALURO5NnhReXmVEGZ6U+lnPtnnuvU7Igy1iVXIt+zjpLJ++T5G+YbS11R8JW0lOAUcfEsaLZqovl857IbpKZYUFHGe2STbKsCmJ9zS05ltB/X/h1y26J8xary01ofTqxir3KgTXlgzwlSABzyz16Mz+31oQf3Z2S6obLbuC8hYaRccwAl2AGVF05w4SDY7ucgivN3BMX/uo9RVaFGG6iM4bOT0agb8SDnTEYkbz07J8q3/mf+LrqMUEEJs1D0aIFs9x1FRj8Z9yX1jw2CcrCZ4hmJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5395.eurprd04.prod.outlook.com (2603:10a6:208:115::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 02:16:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 02:16:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add sched in mptcp_sock"
Date: Mon, 16 May 2022 10:16:09 +0800
Message-ID: <550c72ef0be9d4c25874c997370dbe541d2b28fd.1652667282.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca84bc5-a080-4078-f4f1-08da36e20b97
X-MS-TrafficTypeDiagnostic: AM0PR04MB5395:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB539567F270C4BD6F563D11A6F8CF9@AM0PR04MB5395.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	peIYuzPsPK3mMide4ui3ppoKkjdrdFpeSdn9ra09aNU2sQYk1ynzkogmFNW8fUXtum6p6W6+racfYYCWn+R+2I2dm3MNVK1B/klXML7XtklqN5o8jZOi+4uYXU6Vq1t4iQcXrbv8NM3l6Dt4PGmjyr2ZS+Wn/67GlRnARTaR64X9of6jeKaJbdfFAdshli3gsgKS9O/8oPi6LeLHEImk7W9BojkxkNSX2WhPKOrmzb/2Q8DAmPFwWsVgu2T9PipmKiy2ZM4TZzokzAZJrj3rlhw/AYiEneK12D+SlcAqHu3AmLsfUB+0rclZACADNVUM2wQywlYmywjlvol+RSRiNuAZIRqcjPMu7AXugTYLiXN7JMouh5cvzVocwylhSL4pQLBV6mA6Cx7A5b8ljYOwGrQpWzSg8/PhH2oJpKHXsxX1M4PVbJHcCxjPEP8ruKATGkvFYMMbm354d4f0xiIPQeIr2GGVj/ed3eygORMGDa4eatpOGz9Irj5S0UYX0ZxCU0DGEm4m3gM1wE/JnWuf8t9DOE28leiOMzkRo9JhFskDyVfx6WOPgYVJKKIOy8P8nXFiU0zI87Y9atYG+vA2AABeRi4Md3wghpQLoMYeCXxmDODMdOc9apl+DwZgEViSDG8hFiOXvUniOtovml5edZgZsNVelpR9W7vZMtDuEVa5SzQ1bw8RIubm5DSkawW4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(6506007)(6916009)(186003)(83380400001)(26005)(6486002)(508600001)(8936002)(107886003)(66946007)(44832011)(66556008)(316002)(36756003)(2616005)(5660300002)(66476007)(4744005)(8676002)(4326008)(38100700002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vmKs5oTCqtvCo+7TY/JJoN+1ixTGqbzj1lfsugtugycEE45Z5qBup945dRDe?=
 =?us-ascii?Q?tprgyf1Pf4pk/IqHlNnBTqqj9QhP2h6Cp2m0AO4AeqbHjwZHk8iexquotXm0?=
 =?us-ascii?Q?SpbT+TbxJ7WRCuO4PXhYtzRCofZnsQHOh7cthT8lJC0UfYK9oQE5QS9yB2NK?=
 =?us-ascii?Q?QVc4OwKNy/SgVDBUsoNROu9wWEhj2hDMaGkPvKoo7/UOwc5BYrNqWZct/46L?=
 =?us-ascii?Q?OtcWeLcC0ZjnAn/aIExH8v1MArgVwlM9V3AkSESFefMO2frbuRJUihx2QtI7?=
 =?us-ascii?Q?yffh7mm/FG+WUSDVrUGpRwL1sD6c0PuS34S0DXhS40jUUmEg6v8Q5RBQle9W?=
 =?us-ascii?Q?j1BG5GQEbtyMYwZGfx5lSxWO56nrh9KglGrO1hjC0xNlUY4BJzl97PKHyx+h?=
 =?us-ascii?Q?uNtaX5sJBBqhQLTBaB3BPVGNCWBU3/gg7vOZJme+M9YkgHO9kOk+Tm61u7Rd?=
 =?us-ascii?Q?8TJWgQYzvpiL3wvfXzUSlsMz3OmoFIdEBdBEFSyG7UAVyykzaQg56g8ui7si?=
 =?us-ascii?Q?U+s3n5M1+mLBG727nFqCiCV9QeoL1w6Ml+Y2a7jWyZ+eptS6H8wD/NdacLg4?=
 =?us-ascii?Q?aelv2m5YiGkX5Lihlzq5jpLF3JeWMDo3OaiY5oKt5l/snBhWBUeE6l5eAjim?=
 =?us-ascii?Q?6/3nXBt/jfAGfwPd+LwXw1a4tC+WziJ6J9qZkh56ep5U2T1fBoiVpeYcEdZm?=
 =?us-ascii?Q?L6/iDOhnE6PnGkdTF3JIzGFwz4HczVp9gL23zUWA5rXzGuFKV2THDA7LZ6VE?=
 =?us-ascii?Q?ylhmSpaZ2Vs2myuSBwUuj/2MiHwVTwH07W2V+EYYU9yZ8YFVrouMKXuQeBmr?=
 =?us-ascii?Q?VUoQ37kt0qvoRwz/5pkiM3pc88WmXmBYApcjNAT7jMK3EuIlx5Uh1KL/bszL?=
 =?us-ascii?Q?oaupapcDjJX1DlpLNi36hc7wwLqzrfIiW2PfiLlFbcVX1ye1Q+d6TROFe1Xb?=
 =?us-ascii?Q?kXKJwxw6hacQgl6DYe/u8rdHg6ici+SdRvFL38eVK2uN+jJ37ILsZ2PVaAo/?=
 =?us-ascii?Q?2stelI387D4LZRdFHsPt1wKFyYDKdr3FNuyzE9NUfJIjtuEKY0Q5sWBgc1p/?=
 =?us-ascii?Q?YrBu+btNPf8e6r8Zeh1eRzCs5D9KfGVMpnjGhnNxFAFmSTfgAQ+JeBx0zerq?=
 =?us-ascii?Q?D84y4fWjfbSx+2S1tnS9aq7RlDVUi/geoW2b5MHrAs8jH9HGQJmyn+RpefL7?=
 =?us-ascii?Q?OI67W1Aa5CU+Uc/+zZtSeUuTG+Av/Iu1PgmVVVuMyo5ntYyW5+fcPmzsixWd?=
 =?us-ascii?Q?A75sOlTLrI6tSU7o01G7wMnkSEfICpTQP8snJVFdmDb9urq18niSI9eslL72?=
 =?us-ascii?Q?Xu7V0jE0g15sKvM8j+TzV6t0J0Qhw57SjttGn/QdK631qfPuaVakeCfpNHRR?=
 =?us-ascii?Q?LdnBHDyl71cq0oDqyv++7C2I5n6Ssb9S4AT1sLG0vnk9OlWpO7O4myHAx8EQ?=
 =?us-ascii?Q?y2iM6Q4uPmqek/edIWYHGpkIfqvCZUmOelNl2xErmlAanrP/mNBwJAePP6kx?=
 =?us-ascii?Q?xFTv/mXaarbkiPlDI5HQ+ZhOtVNlhiFZriiXtH/t7tUgYrJhmduTznitYQGB?=
 =?us-ascii?Q?SGQC9x5dkwfamrIR78PPXfA1W4NZK1RAeeK0zy6W2OswcIHn8ted6NUrGWqo?=
 =?us-ascii?Q?cTrafSEI60+HKs0W8nPyrYqElS9ClybVp0pLvsvj5TarRNGkEk17EN0YTrcB?=
 =?us-ascii?Q?BpFgZxtYJfDvn9PwtcqcTwYh7oGbJHl+jlSuMGGVz5jwz/OAX0ItY5+pagQD?=
 =?us-ascii?Q?ctOmOFBsEI7JXmMaVekoE5FubIWzTck=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca84bc5-a080-4078-f4f1-08da36e20b97
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 02:16:11.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLxX7KjsrMFm8xxVS+a0ByR44o7Fno4URpQtrmg91RPW7LYuQ9Dg7pT9G9F/BDoy+eOs2KF2UrxRRBYS0DX+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5395

Keep the alignment of members of mptcp_sock in bpf_tcp_helpers.h as the
same as the alignment of mptcp_sock in net/mptcp/protocol.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 for export/20220514T172044
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f7765a5be329..aca4e3c6ac48 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -251,10 +251,10 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
-	__u32			token;
-	struct sock		*first;
+	__u32		token;
+	struct sock	*first;
 	struct mptcp_sched_ops	*sched;
-	char			ca_name[TCP_CA_NAME_MAX];
+	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
 #endif
--=20
2.34.1

