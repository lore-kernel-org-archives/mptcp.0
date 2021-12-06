Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36668
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 03:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638763190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u1gNOZMY9hFV/1zq4nlugGwbYW0A0X2B1E4NefvVpB4=;
	b=KQNK+j3P4hmbzVXKYAv+7B2t+1RyYBUtWXPftmiFMeFzhfcof0BmejJ+b7Bo3cuRn/Robb
	ejqEVTQKQULOUV/aJKWrYAuZ3jgy4O9UWu5wBl/0N2p7KmoNjMn4zok3vNNL/MssBlpvgH
	JH7mMfYDyjbwzp+eqeTDKCxiM6fyIZ0=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-o0QjF-KbM_ifsDpxr50BQg-1; Mon, 06 Dec 2021 04:59:49 +0100
X-MC-Unique: o0QjF-KbM_ifsDpxr50BQg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGipxKAeDwkSUBLLIP6GccRcNV+5TFkLYHfEjo3SMZdEaQs2do8cVcCCEyCbkUo5ZeJ3P088v898sHKZsUOSQ2ceR6PVf87OfAgmDkphmmc0ptluKC8Dw0ANKEuUIpk77MqNlw51OLR8vUTyUYfegyOaa2yz0t4La//0OnBWTKx34XWLWwSHEzta9gSN3At1Abp38dIzaL6ki9uMb6NahgbQ5nhNZuVlrWeAXZHNKa/n8DonzIOWEXtS8d1ygVCaKZ91hQYI1GwS6nBRxhbkEK2QOwHphJoGsM+cvjNw2izKaTVD5zeri1CL6TT63nERX/J8NQKFuVIPXujdsl5pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAgWJT7iB3Oj4MMBeHx86JN/5Jfd/h7e+Aunaz4ZkiU=;
 b=UIIMC6M+gpgGj7DqN5PZvbwX4J0bCC6s17RELBDooA/5m/4BOsotBcCYkkvgWE49OORagF//JphQnDyAbIKzlwUDHAh5dwc9IUorHiCFiDWs3sD8svG4oTy+HtlIODSYd9l/oCZ5qwtWHBfhC1vaxzU04IbKKh+tz/HFuQ1m8z6hYVhq3Q5k8Lpj0kMyRC4325cIHLHpCH2Jd0ghWF7BZsqvIqVBNnK1RPaW3xQ2UABktJZNE3oBAYqq4l00VuynsBeio6h3RhBcyqA6cl7VIosHrfZLdm4SFxOEz2BDG5q2RWzSkCYiylRL5n3bHU7mrllu42cIqjK5pVYK62ShXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3065.eurprd04.prod.outlook.com (2603:10a6:7:1d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 03:59:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 03:59:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 0/2] send MP_FAIL with MP_RST and others
Date: Mon,  6 Dec 2021 11:59:33 +0800
Message-ID: <cover.1638762825.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK0PR01CA0069.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 03:59:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e7875ad-5395-43cc-dfa1-08d9b86cd78f
X-MS-TrafficTypeDiagnostic: HE1PR04MB3065:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB306593682552454F5948557CF86D9@HE1PR04MB3065.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YphHhekRdem8fP0HCwOrbxjRgUbjOpZCy0FwrqLS/27TCVizL2V9eSTLJ+f2XBwb1P77EPsQZJH9GAnD9q7dZQ4EE2N4T0DL0yzJjc2zffH99mZKgbtbF9zTg5tOdsRo+Ae5FzfCaiAiDIFWK44OeHFQ3QR5+c8LAwXrrOBZaM/1VDdJ0QNeiRDylblkVwNuqddKTF5GDQS/Z6JHvYYWOi8m/hCJcx6DOVSx1RiDqhOKJ3DcC79HGbuctnLf+z1xuVO4tPnTybnuZ9a5Gx3PkgtRIyvv1bRlfm7L/9f28HDhQ/QEws8Ak2xSQ8Yhk5HZJNKqxII83AnI1477Hp77E/rgnX5ATQT4GaD7GwPxmA2pUXwenTkDB4nQogffTe8bKyd2sKKC5uwpiqxzmDiiefd4JTUqEbXoi3VkN0sdAkSya9lRDSluUvSWE9NQVZ5hgMhEJvk/zhI/LsXniJU6O+m1L5gGxwMVsIc8zVZ5XY0fcw0OxXktou8tyHpoglmvEXrxtxtV3j7yCO2RAnftzzfrs2sOsD4tc0j4NhsXHpBkLIJVnOl+GCTP1OPfOPip9qiKvAR4UfxMjfSbBoJ4V5+mzOBGsdCB/qXVj/sXEQwHCWOplDHXX0qO0v42aEwAcuO1NIuWZqYIQh+KtbhiBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(4326008)(2906002)(83380400001)(6486002)(6496006)(8936002)(38100700002)(86362001)(36756003)(956004)(2616005)(6666004)(508600001)(5660300002)(66556008)(26005)(6916009)(55236004)(8676002)(4744005)(66946007)(66476007)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DwTawvzIPC9UTMJL6fl6/VSZkqDqlQD0ca1nEfspzFmtKR++JW6POeFZkIA3?=
 =?us-ascii?Q?b+a9pXe6hO8zgbOdYyqMtr9Czz0JHeFTOpJ0mIS4pI+DUNxBP/4OSD5kfMQL?=
 =?us-ascii?Q?cu6izNVS6ZZL66oEmvFc9BEO5QLZOL/ldSi0YXhlC1zT6HLFl+4xGE9ZmJoP?=
 =?us-ascii?Q?EbV6YGbHSbANmGyRVAvVVYjIhyfZZ+MA0XUWpuig4CaO2kBVSchKH7wkO26L?=
 =?us-ascii?Q?FRjkkpDC/x+hi8vcESQbcfrIEkxbRjxieF0qx9Twvew26MA+9dAkNe7LYiSr?=
 =?us-ascii?Q?l9XGPmJTS1JzKiKdMgzAe766Mdp9Im8fVbybPu+WFdw0xhQ84+HSTkTB113e?=
 =?us-ascii?Q?nSxqK6hxJ+6TuP7n1dHPY9O7fJGfaCFCaUnN5NnQ6AEx0TicVlDtBF4ojU0k?=
 =?us-ascii?Q?7J6lDmk7om7anPxkoiy49HwhkEw9Du9C1fqFnWnJwfKX+uwMY22haTeNwgVZ?=
 =?us-ascii?Q?6ioRbm5sKdBeTndKakAZEiHn3N7bPekwEfslOclBtVIWqiKO+FCQBIQUEL7z?=
 =?us-ascii?Q?EU7C7itA8BZK/SNEiWAYILyDoEb/zYar+aj+/D3REBXtmJo7fNjn5g9K3HHm?=
 =?us-ascii?Q?WbZc9HPpj3NctuWUE+v+21QcOXI9PtXdW+yDuKzp+lbF0d9lT6ZhtBbBxa/B?=
 =?us-ascii?Q?/AMARUkcYVOCXXFAQiCwxgoXL50iYhISfCTSqrf6IzRtiOH2/lK0aibLllYA?=
 =?us-ascii?Q?/lncFEapCQQuQOoth5+Xu/jMixYX6j0iscF2K/bKYdWTM5N87wlxkvLCPNtl?=
 =?us-ascii?Q?0O2bp4gqRr6gSvDH0dAcnlSspbAAH8PVBSZlj44PF0Ki95e//0TBjY6nhIU9?=
 =?us-ascii?Q?LNusP9pktogpHMUXAzxdSdSzW8DSPQ8ZTht32umoqn29/Vuo/1Fwi43V+cRV?=
 =?us-ascii?Q?HXpFTeL7yONjyN8lfuNUjVq5hHwp3kEfz9W6d4KMiUP7PiJE2e3uea5/wFuk?=
 =?us-ascii?Q?OgDjxv2TmOS+r6Je3I51JExhjXiAlE2TRifD6pCWwPtu3UhJOXtQLT/a2h1p?=
 =?us-ascii?Q?MysZ6MwyvQeC4cEQ2Koqb7bwPEm3hyH0a0K+MGqUWNWLCr+8gIw5tCCjjI5B?=
 =?us-ascii?Q?GaUco//lC6Ij6zNUhKvucW44NYvRrvVlnSBS/iNS9l/2n3Dt9SMlZIEp4uld?=
 =?us-ascii?Q?q7/Lgxc7BPrnDxQey5E1IbjytXp2wPGCoL7aBYnZknimBUNC18IU2EQySsOq?=
 =?us-ascii?Q?9tzaSZrNh2bQPZDPcN3FEDePIWQ0dpXjM40el+sLYJG5FzppMZOOrYpp+SI9?=
 =?us-ascii?Q?X5hOQHRH3aHLPSs/0+xSG1g8qau0fQ0ovIP+oAVAOOvOlfYXWf/L4YQ2X6BA?=
 =?us-ascii?Q?AjGHC78fwAK7J+TPwtUUYTmtMcfXOumlBCEXy/CPstEefkbO7dwgmnQhqG+p?=
 =?us-ascii?Q?Gcmc88Tz3DTuwj3K1uIxDIS7NcKE2MRk8UVleOOU8diDlI3+uC7Dc0WshXtO?=
 =?us-ascii?Q?vKfNIXPE4qcDkqqRTyfZfnfjyPv6joq2Dyuav7NBMouxB4gZ7ehESVUjHYBy?=
 =?us-ascii?Q?J9ay9KD9Cm3CNBOTGjWpel1tBfp2wBRYjagmDWK9mpwyGbUiM7oZvVxYubJz?=
 =?us-ascii?Q?8tABKvm1yV58jwKbwKK6/SET5pXEpUFH0eidJpKt4MCdDgjzDcAlWyVLehac?=
 =?us-ascii?Q?/aZOAc2yjugNf744sfVTsI8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7875ad-5395-43cc-dfa1-08d9b86cd78f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 03:59:46.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //yuJHGbc4vISkJDQkfHiBcE90zeHsfL1YWx3AHZEW2Z00feTNwd66CK7E2v/y+eAVhQBlA4gxk04LxPdDLfvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3065

v6:
 - patch 1, use the same xmit logic for FASTCLOSE as MP_FAIL.

v5:
 - Since MP_FAIL could be sent with MP_RST and DSS, and MP_RST could be
sent with MP_FAIL and FASTCLOSE, this patch fixed the MP_RST sending in
mptcp_established_options() and mptcp_write_options().

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

Geliang Tang (2):
  Squash to "mptcp: implement fastclose xmit path"
  mptcp: print out reset infos of MP_RST

 net/mptcp/options.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

--=20
2.31.1

