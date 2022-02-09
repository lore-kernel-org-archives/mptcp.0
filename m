Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB122F21
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 04:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644382384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=29W5+B/k9ljZ+pIvEi+KDrCKesYNtUTBnEmhdlBgBzc=;
	b=WeJNTVWORRZm2h1gnULduTg+KS1rglHETLZ913mjAfpf4lQRgPlvUEwmzbQ18PZiB0cY0p
	Pskay63QN23pjqRZ2u3GdiKT4OECtMkX2Xp+siHkIeUitKeRQqrDACOjSpJckdWinnYyhz
	Dwe1EN49JAE9QCtJ1abgyhzX7DNZ2q4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-QEUCqYvTMi2Vryzu9L261Q-1; Wed, 09 Feb 2022 05:53:03 +0100
X-MC-Unique: QEUCqYvTMi2Vryzu9L261Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbGNKDOJ1pfV8iO2ePoOUmxsRFbZv5Q0kwrKIlaxtvFNBinZp7nwqkOxrouLax8eq+JxRmZRWwv7a04lsgJO1aYu1ijQki5wXY0wlvE2mibv4I53wgTxTmkqkE2/Xbxbl9qrfohMuPmh3c+9eIYFMTifeNBvjA185Hk+hswm77FfSDSRMA+XAg1a8xEK0kTaDoqRfdW7fChzrHwWthZXfheO8tKKXnxAFcgZOOO9nke/83ATEx3rUFdHk5MxZ3PID/0aLkax8OdC3J9BdRa6Yz/uKSGJd5WpNSFE7e8+zviFyU0Up+A5b9adaOG4IwDzZoLoO3s4vi3m/RG8eugMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWiLQxbBRhX06Ioz/NqcwsFIdmfgR6X/1RPfuwlj/qg=;
 b=IWHsY6OgzebXDUc0R6NM97LtDFQfJuMau5IxV/ahWlSLJvS5j7KhMgeiBvyuK4BMCSGTu/rX2CphUJt5J058agMvAMDPJAtD8rZuN2lNYg4QYfU6onn5mpFnaaMumT17PIpiHxj2jgIDh1yx60qVhtFCysakxqWAHlT0UtDtKUJMbzYxi7RkMbgeW/nhZkHLgh4jcKJ6s94pebsLpAJjmitfSz3zWch0+WCCzkpF5RNVeUZURTZe88+ZqsituIXTEYnFIosBfgjuid1uhL4llpl5Ori51IzMp9h1G0/ZYDV0fLPexizTL1C6V/qADtJBSI581rNKp/lgI/V4sMiZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6125.eurprd04.prod.outlook.com (2603:10a6:803:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:53:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 04:53:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/2] add mp_fail testcases
Date: Wed,  9 Feb 2022 12:53:18 +0800
Message-ID: <cover.1644381932.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd98327-107c-46f3-fa06-08d9eb880c5b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6125:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6125C03564581F55F60AA3EAF82E9@VI1PR04MB6125.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a7Uf/W2Z1JLdexw6f3QqInsBrxiP0zhmRvCbD6WGGd+tJA56HGQg2xIb9+Ne4VSfGu7a9CeaUVisTKvThlwVI4sZgzxm4blP6NOJmYSK3WoMRzVI6uNq7wEUzl30NDZFjHc4KHnXEkeRCVZ8A2Peg7FgvgUiSK6phm486lnUSmmeYPzzPGq0ISZJedj9LuP6Lam+AB3Caesy1ZbI1Spk02lBGmZ+hHI783d7TTJO5o7dxBoAyzQr0SsGOOgW5EukaF+gasG6cWn2RiFAK900AZMADSe/8+/lH55/J9beRFzxFM1/unrkajgAHo1OXw/LcrGnYUbaih744tnIKrs8Y1pcyvIiOuXA5f5zNmJi/8ZtYBAcwZv1YmUZ+9L353rjBN9MpZXl8XzOvBP/zfACRxj3sFUAzk4GagAh3e4A04KfHbCd7FQ0rv2DGbBUAq77/e+IvAmcz5E1nVs4zgOOtc8zLEJ3qAzKVKqe5sZx7tBw+mPFGVeZYjQZqoTCNChUdu+3w+dPyzHSW7218iKW9/kPMFJ3crsU12FzFZdsZ6yluSPewFzZ8aJ8ytEX/NnFT9+gtDaWyXhSaOkwNYxBAWZVUTgBKdL9ot3XUIJKRL/Oxkg97VEp5lyz1T3s5aqUyySgZdvch8gyz+j+VYZksQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(4326008)(66476007)(8676002)(316002)(66946007)(66556008)(6916009)(508600001)(36756003)(86362001)(38100700002)(186003)(55236004)(6512007)(2616005)(6666004)(26005)(6506007)(107886003)(5660300002)(8936002)(83380400001)(44832011)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Er/1lmM2dtqrPWxyhmQadRIWXRfOBxRdkVu49sEG9DCaYjMjRth+57/7I9Rd?=
 =?us-ascii?Q?rLCHwL5u7/bL38jDBU8ZDr9eI8q8dC54dt0eGs6qb3qzKDkt1kAeBTIZgMb7?=
 =?us-ascii?Q?ybBUW8kAEuSIJz6/+0u7iusfeWSgBw4kKREUnGlLB4cusEcEScMJt/GWrMLR?=
 =?us-ascii?Q?NjUzW9NGXJ5ntm59cEuxCK4PAk9Md4o9xMBgD+e+/TuDh0p6CM36zFQlIgN8?=
 =?us-ascii?Q?KGSHhD3dTLVkvZwFE1nWICtjSwsGea0R+defN6+0sRb2hQ2oWM9fgtxVLH5E?=
 =?us-ascii?Q?yGDQreFmVUdcctmh0WN5Bu1dpuwOyRo3/DqtlAzDdYy62k6rGFLbA2Z5H69s?=
 =?us-ascii?Q?HuoAeiZYOLTNvfoZC3hC/pQXijnG3ianDu/KbfImFviGbrnYyvMOJDM+QzkI?=
 =?us-ascii?Q?XSVypx7KGuMnXe/1imL6RGCE+Nuvg3Vz5NvKF7ZP8YuVPHLY9VuV2TjFyXpA?=
 =?us-ascii?Q?Y3Mul0gwtkqRtmC6ZikMnBq87OfPyh2BLFowXZxuXREBKy7YUEvlkV44UR2q?=
 =?us-ascii?Q?xxUDZ4m9CP3ZhZaZMbHcDN9HTStgqC7ABcRHk1uQ/HYsemYoytkbSGhqHsKT?=
 =?us-ascii?Q?rS6UWPJpZ+d/ZHU9J+yCxyk3rOHlaLodkzjbt98y+9806e5fs7SD9Gaogg26?=
 =?us-ascii?Q?N/yIl1mT2C/PN0La5/TqpkgcYsxzkyDE0v7OUHn2g6xFwY2rQwGpZkeRclgs?=
 =?us-ascii?Q?0nXkPgZKl6kkE7q+P72uCkiuCZ8vbsowPJMfySLyioOqV9rFzgNRXKeHQ0eS?=
 =?us-ascii?Q?0+f31EKtUTS2p9YSUHG+vDVmMDmj/GwBeVL/kdAEoB/L5ca6STSagvFlmqDN?=
 =?us-ascii?Q?LvsPB9n5E/uoxGlVPnNb8o2TcZy2Sm3f8pcARn1gLYZOuhWEqhHk30f+iD2f?=
 =?us-ascii?Q?uF0vMU4KyVcyv/LkY5tgJcdeilGnY+3o2ZofGXVjrqlzMiD8hGcqY+AALVYx?=
 =?us-ascii?Q?VlmRLrN0IxX+pfQ5fgNokiMBbYl/nrhIobHUmFM+BsUitcfFFy9IpNdMn1LY?=
 =?us-ascii?Q?DKQOsyn4bxMQolwn4dNGP/lXTGr8p9Vj0rRjefyU5uUe0pWkWPoOEtgFNEZ/?=
 =?us-ascii?Q?zp5ydZcBLx5kamuzo5tEX67ukA+Wl2xZY0K1+4SY0f/K6sd0iAf6gI0pcbeQ?=
 =?us-ascii?Q?hZqYdOXD4SdrKeZmMuUuJoXWc1ASXlnfHm+LEKbvHtkrH545Va9c2Lv5Z/Pv?=
 =?us-ascii?Q?NlEA6gMBn4LESoeteXb4Wn3soCXJv29kKKicQssmGzf8IjW2xiqj6kE/Bhs6?=
 =?us-ascii?Q?lezA+LZvpTi1AFHWbR4wI0xu8E5sFYV4N/N5svktMzheHz+TVD3+XTXH19Uh?=
 =?us-ascii?Q?saUPGu++wyEHFj7xNIArxTKybYd5uZd3yo/JpgSFU0VneNsYv0M/qc0+hEVs?=
 =?us-ascii?Q?JnlmCmznmMG5Q3sdRHJg5e9YOQHL1pjiBAYsOfvqdlgy+/Kr0pkjf9AkjevN?=
 =?us-ascii?Q?fCnGt52siGP1g674FO1JlLBFRqFSfcOslfAEq1ePBQp4NK7EKalldoKwjwUI?=
 =?us-ascii?Q?TqRkQ1lLQoIJdc85EdtDW4NW0iJM0+5DNlx8Y/HO6YzJ8Xv0IamE+qr4jcQ0?=
 =?us-ascii?Q?xr1YEHfcObANTe8d5uvth2FZW370bFTdcoUkWMB1GpEH37OWJl58EwKdT8nU?=
 =?us-ascii?Q?rOwPFVTJTWG/aK7gXxv05e8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd98327-107c-46f3-fa06-08d9eb880c5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:53:00.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTyCcgoZwS2mnBwZpk43iDD4mBdmtSalbxktoIZRwxjtesGszPjb447dzBRXPZ32Sd52bJm6kiCTsrxnxpisLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6125

v3:
 - check the exit code of iptables.
 - add ip6tables support for reset_with_fail too.
 - add the null check for $packets
 - rename nr_mp_fail to pedit_action and get_nr_mp_fail to
pedit_action_happened

This is v12 of the mp_fail testcases with Matt's changes. It works well
and it's very stable.

Geliang Tang (2):
  Squash to "mptcp: infinite mapping receiving"
  selftests: mptcp: add mp_fail testcases

 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 154 ++++++++++++++++--
 3 files changed, 149 insertions(+), 14 deletions(-)

--=20
2.34.1

