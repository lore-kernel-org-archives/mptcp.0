Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1C168
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 02:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643165780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uL0rCgD3PVun8Ag65B+vzyL2tgnb56UxwJ55wH6JvVU=;
	b=WtA7ma5V+bsm6U+NdyIVZkTtWqDxtJM6HaPWh/qRSKH77C+ZR+LB7gTL0TfEj6UyHPWmWF
	mJtQ09COyvwKcBTSZMHiI0ocm9+j3Yp8GLRiiyAYAstBYR7ZaPm9q+NpXwRkuepOW1dsvO
	06ucUDSH8SXKWDg5zQld1jgmsCIg0Y8=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-QuO0r0X4N2aI-i7NsA_KtA-1; Wed, 26 Jan 2022 03:56:18 +0100
X-MC-Unique: QuO0r0X4N2aI-i7NsA_KtA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIgn1H9QqteSjiKUdxhvyFV51pfQLwJt+nz5uMPu65gcdr07VlnaaZ4uyOBJDu+ErNGNqkofTza3skcFnfisHoBs81JTcb9gj3HbBuUpIVmaOj7gxcUw7mDORwOAOwdcNWeHdNtT+jggasCvyq6kza8+JyBnRrDXvLBH36cFY2VACu9vvpbci96xgg1fTMeZDXS8iwXgG6Kk2I2fm3A+xyDOui2oVBOT2VIyEInDVij3Z3yCM625MApd7LyzgtgPEwXHmVTkQobhvtNflIUoiLpPU/b4jjsD55uoPWyZ1lOMlR2zXGJyT6DOu45PqBB9TW/n2nG+ACP1h2diJvuyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUSUHQ8pTs3LhuJFuCHvy/eHxenxxLTa3i1NZakFov4=;
 b=cCK605tdpDElgmPC45c9KfzkAx1ruRTSPZOje6LViHHZp7vlzHSEBAWKRPDYkRxt2Y1qvPVQczVwsb0aYcN0c0n7qKoRy2i00YghLL8Ke1VAd50KjxLn00XfoytHmMWnLy+dyi+85MGWxWX1afOR2LgzcmiQipf+LqxxpcJ3pQWUsyKZzz/IwMiTEuZUM62q9c0xXt1HEWbHDHGsfnqxfx72kVEfOOP+dq/7mLWJkkh5/kORT2RUspQHdienhfm7QUKTlR2w0sanRVs49kJEV3x/4ATqDEo9N+4VKy5Dh2lBEOulWVMPiC3gMV/v4xvkQ8XuJkf+p8LBbizmyiz/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2391.eurprd04.prod.outlook.com (2603:10a6:4:4c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:56:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 02:56:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/2] add the id argument for set_flags
Date: Wed, 26 Jan 2022 10:56:21 +0800
Message-ID: <cover.1643165468.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caef1e93-e04b-4d2b-5b91-08d9e0776bbf
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2391:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB239105C8B12EFED5A0649FC6F8209@DB6PR0401MB2391.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mOCV8PEIYNZNVnCxJKTNULZcXzehRWuo3rdK3xAGF6zSsJTJR4DUj4ATYrNWlQPhNFnX8c6608smmsbaT4E7AttG6St2yxJdDknJCIgrggp2L98qjcE0AxGiuos4KQY7oU0mrSx7Q70Ya3QZu9Ww7PNyu4FI8B8u/AdYO7iQyITcEXiXX8jqpB1dDITH9aqQZLfn+CVg/+TfTi+PLXXxpHkExFJ4D6uWxApxbop8k2mNbMn0NOFjSaDnSKniUCsO5I8JleyoZvdweUSk5QQRvjKd/YHahbsyAciSWqcZh615YEQvelCkDB8B3ewr7vzFLXEViibL3ZDrdsMIwLqrIwGX/UdnQUSbnCvlAkJESpRFrMvkyTj2JizFtVNueX3g5X07InSTE7nk8LKqlmnkMbvyRCT0YCt7MEboAT6iwtJVyCEKyJ3vKSV9fGNcK/6WWi7dvAHhffWvTTr+JIcr1YvB5Pxlw65EFmUriaXuC/ry54tTpOOQD2EZDUdir0BQOcEDxTAt9MML6p0Enm9yc5xA9kIrZ9e6YVcubiaRSgbP0lR//c2OFdGxP7g9wnLRBu89mNYgF6dzH3d+Rg0hxqO7c21r0EaWp7zmA2rqMAyBPGT1JLFjxunQytXgecaBymJdardIR6BPkv5ZqwSC1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(2616005)(36756003)(316002)(186003)(6916009)(26005)(6486002)(66946007)(66476007)(66556008)(8676002)(5660300002)(4326008)(86362001)(55236004)(6666004)(6506007)(6512007)(44832011)(4744005)(8936002)(38100700002)(2906002)(107886003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WzrKEphaLXHZFEXHNIb2B7KJPEGIxKps/xwbcID1p2Ksr+hGjzhNyMA7S39+?=
 =?us-ascii?Q?+pBtMzXjcNXu1O0wYTo2TzOvxWlrncYyKsZuMlsNtPQmPbKw1lER50BvU4/6?=
 =?us-ascii?Q?8XQlUGCPsmc3BCxZjNswS8UQyJUPcZBsHHfnVOHH4V69ZNe9Gfpo4BpSFmyv?=
 =?us-ascii?Q?AVVy9sNBtlP49i/fOGWodhk81/3ekwnLfGJRZuPfjPtUmgcF7Gxf3t/48B7E?=
 =?us-ascii?Q?vQDkAKDx6ev0mD6jDlLkupPgZ7dqX5UmoZ0RCV8BQtnQfNNXpUF+lAdwbDkZ?=
 =?us-ascii?Q?B/EeBnhJ+c7hgIYTUxqZFgxGl+qLvjPUTHnX8CeYsC8J61iFo1ZG8DKf3JyJ?=
 =?us-ascii?Q?2fLDVgIWzEMta3t5Ft8v7so/f7uuaZMteJwfLkUin4rxLfAoNEgCt28Uwdwv?=
 =?us-ascii?Q?nXBYyn673K+VF19lLSpT+yOnAqNh0bdK8mfbuxCQz0lesdgrSUVbLxQyGL64?=
 =?us-ascii?Q?wt2gDB1Oj7moSt88nqlV+qOz3lDczwg8KYSiWYOyHBeacapPRlTZjrJ0RJ7K?=
 =?us-ascii?Q?tjAtad/6Wiqken74wtKHTYLwiivQN0zaKqkVmx57vUQeyiVq2j6WafGSJodX?=
 =?us-ascii?Q?1/dIN+PNuJJXGPAXaom06uWN2tETiVxVThZAiZayuzu8snJ4Yu7oX1mV3pYK?=
 =?us-ascii?Q?LPdbDoUWu22syNgV5+Z4yA+j4qwn0oQAl4p1wi+1Il+13TwlDz2qL+aTKZoL?=
 =?us-ascii?Q?NkTaIESB053wHlpXrhK7P/sHcj9AOiXLRX6QFA+BhRy8pSM+mrlSgmpFOd1L?=
 =?us-ascii?Q?RylJZ7osb64KzIg6zpmKrVqnItSz8eGPQhtlfnbzAAsPEPFz5g9jdSjgVoXP?=
 =?us-ascii?Q?w1m0QL8g+HyBRvMg3gEoG8xGvJeDb5M9tl4hFpQohOSUFAubBu6WAK6peZS9?=
 =?us-ascii?Q?qckwFeHVYoLaONyPGKWRDjk449uGVIxwHOqswldQTaUDV1X4Cx/9rJN5IVBk?=
 =?us-ascii?Q?0fgAWDFJWbJjYT8XxVBwZBn5IX5JDAzmgaNrGgffF9AJE37fVM94eINsciMv?=
 =?us-ascii?Q?nuv+Zz3EcoIp+4+3y6LgQ6K7/svyWOvTF8s8Q+Nyg+rUscMBOWtxqc6V8TnB?=
 =?us-ascii?Q?E97i6//3nK+gxK/dRY3PRb4/eumCfxCK3z8CyEWwRX/27+WjukCUxW0msUqN?=
 =?us-ascii?Q?IvHFOf6c5+rWEAL0WoQK6MZyQQa9rUrcIrI6aiWj0y9SFtdf0gmKzhwlIs7b?=
 =?us-ascii?Q?qtIGOHdRB5xbhhvgkrc+sG/iWG1AlAkLFosuNFikGB9mBXgwSrLJ/kvwPEI+?=
 =?us-ascii?Q?K2ZqwFpqN/x+jXjCfcUQ1cQUpjIOt+9in4NGu63RQXrg76VnbX5XwESkmEIU?=
 =?us-ascii?Q?+au/06cLCr1BXkrLUVPOWHm+5Gp5AyZIDT3W2DBlp9l5OO8p16wJF9m//fFS?=
 =?us-ascii?Q?ix8iW/qESk/LyH0RiQx/J9Qtne2+ALRk348lMQypeIlMahtQlXSY35tINY87?=
 =?us-ascii?Q?90HBdjOrnpGnRiFOI4b+JN9M69qiu5Oxe6Wau+ptnoFxKPeV+d5fwoSHwwP5?=
 =?us-ascii?Q?yKaC8uoh+xXGlJgb73FpKCH+NVSvWKp3R8yLmTjf0h78rix/xkN6x1L1l4Hq?=
 =?us-ascii?Q?tezdtThIkJYglwo6xFg7bamU9b0vwCzti5kY5CXfikwsUma4EAdg5Zxvdm9N?=
 =?us-ascii?Q?E2oXwNjVzV4WHBbLBDpDz4s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caef1e93-e04b-4d2b-5b91-08d9e0776bbf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:56:16.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqqgBFMXeUhZ7jeXuRFwrvLYzYtxKFPUuxYIEmjSmefe6zKf/2UnAMHXvNeSLymdBMS614UBWUhNMAjRD+iniQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2391

v5:
v4:
 - update the output of pm_netlink.sh

v3:
 - update the usage of set_flags in #1
 - check more of the intermediate states with "pm_nl_ctl dump" in #2

v2:
 - make standalone patches, instead of squash-to ones.
 - add test cases in pm_netlink.sh, instead of mptcp_join.sh

Add the id argument for 'pm_nl_ctl set', and allow to use the port keyword
with the non-signal flags for the setting flags in 'ip mptcp endpoint
change', more commands can be used to set the address flags:

 pm_nl_ctl set 10.0.2.1 flags backup port 10100
 pm_nl_ctl set id 1 flags backup
 ip mptcp endpoint change id 1 backup
 ip mptcp endpoint change 10.0.2.1 backup port 10100

Geliang Tang (2):
  selftests: mptcp: add the id argument for set_flags
  selftests: mptcp: add set_flags tests in pm_netlink.sh

 .../testing/selftests/net/mptcp/pm_netlink.sh | 18 ++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 63 ++++++++++++-------
 2 files changed, 60 insertions(+), 21 deletions(-)

--=20
2.31.1

