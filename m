Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE425180
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 02:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645325949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c42McbarjYPHYYY23YP7e5AsFRB0aq7neEKfOWJ5LKA=;
	b=MkEpSTvMwcMWiZ+7m6CJSFlE7WF85o2oLqdW3ppltL8lgEEpbhRvzKCWaZGmqEw6b4I8XH
	LvVk92ifZQrZwFXygUBmE92ghKySIKpWYMLsAKwLLXx5n5EsKeI5QAj0y3D3LcN34JMRk2
	S9buQigNLuqseF0IOy3+y5ad/PvMuJE=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-jphNiGPAPyuWgxIPLv4XXA-1; Sun, 20 Feb 2022 03:59:08 +0100
X-MC-Unique: jphNiGPAPyuWgxIPLv4XXA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSETbhT2+G3HGIJilZhNlOVSJ+cuUyzgUMmt/YcGunrPF2jv4CeeqnYzZ8IyBe7ZuReH6m6dHBJa/pSNOh2TuEnagW5IYp6nvaEL4hOeoRVXITAFI4QMZCMULNweUAkv/PrBjETPt47j12w3rsPzQm2JORk/K+9yIxJ/lFZOKEHE2XEX+iNqTMi5oZs5st5lhoQqiv2WRr8Dcb9rqoAA/R0DMa+pq6S1PlLd37R/Kk1tH+dU/N9Pb/V2EvkAsPlxtc+S/myQMWz+28Y9L9/aCRkZdmn8ph28ycu/mXen/ayadKHtCBUt28LN/QAx1wwrXsDREOULQQdNC+AsRdAS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma7ICWOV3B5964le13QVBgIAxMg9Y0N3HMvJvof2A2o=;
 b=dtssMpDBfHsTQfunjQl/TORausGnL6vI5LwY3bZ8m+dnaL+23TlDbKfamUDWkyT1gUBHL8DxeDqWsK6RnT4H11HtpJp19q6xAWZw3lj1Lwi4iPDS2C+CiBDa2ykt4BkiLQqvtAZOqm7NKAjWk4FbZqUR595WJTO2cFYo5TMIvzWFyrHcSjiWGckALDTYjx9+/ooELU1XAMm6uyYkWWfNIzWKV9d5bjKr/mGN1WC/6p/QxPg93F7w9byMAgAuta7CRThB73Vg7Af0tppEcDD95STLXkEWodFylc/P3DaXlTNhb3HGv0xBM/MLCLy73e+65/jiuiAdgecE9sVI5ar0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 02:59:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 02:59:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 00/12] fclose and mp_fail testcases
Date: Sun, 20 Feb 2022 10:59:26 +0800
Message-ID: <cover.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0156a7fe-4c4f-4d78-4f42-08d9f41cf578
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414A282EC0E152BD8E46401F8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A4OTwZGFUWBtmfUgaBKKMr028xNlXXwxpKo+Pc8gQ6FiXW+yexfV4ll3wihlieugWasDxXB5YSoDQNf4zCi/D7tRoExVSPzAN+XqedrtvKOrc4q5uXmXeqTPkVo2RltaB4RQw4fYa4JpQmLmAqNqv/v5RRf1wlKC+ur/tCNZYz1m0yFYxGkVHp1DwRSoARWvqzivQvR9YtJa58vG7vbmm7fKkI3iNh66zOf8I+Yr8ODpVoXX50khoaJhzzAVuiRvAJ4bODWZp2jlb4Dk4OEJLQJuB2SMfLDHGCM4q6ra7IHQf5aBngVA8C6+HeuTcD+X3xlLXH2p11cyIls1wpMeota8475rz/ZckLdA/HwYVEDbVid8e72zp2xL8CfM+MYke3BXlPVSZgOCQoEd5auaUV4kRVhLaaMXCx+WasN9RT1xeAjhkEDExVPtw/vyE8Ac4pTafPIPki0CmE6UFSwKlO3QundB4W0QfIMk3p6hl281tbRxPuxx8a+e7dRQPk2ngC68b7b+Y1lzZ9ad4hXUEaUg5dKLZNb2aNjQ7XdxmMRx7HNoHNMXodcPDAMqq/dbejzTNk8VEaNsHN1VkEncPALhsOFYnfRPaijAuu3RZbaDAjK2yrRfch5qx1IdkbFsQGvk323yM2oa0pQBD7SFkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(107886003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UvwtDhUg2FIPc/ba/yO802DmtI7oLKunhE5sonFkVfrFLkYNlyBBY8VYVW2L?=
 =?us-ascii?Q?ziJ59YQwEZHSmSnmOABIvI0cdeHKeawYnC5G5mpB+G735wR7QphjysI9qpTo?=
 =?us-ascii?Q?MfzJOZdQT/0rLgixjahn6ZjUrsK0/hDry+V1KhnArmfEPu+5StetwV2mwQmr?=
 =?us-ascii?Q?RGtqjdFwvL7KzpQeY5s/JMvEEoOIq5e/n9UZXCxMzxOcuqsZZmeq79wk8/6P?=
 =?us-ascii?Q?giHfAuZi/UKZNjfrxmS7/K9eAl0UEPKd18pqkFp28TWp/je6noaYK8ZYaqgV?=
 =?us-ascii?Q?mobXK/zoydUwv3bo+44FyIx26I2aVZro14eyVZLFJCqTZ9Efza2Y10PfDxrc?=
 =?us-ascii?Q?9+PaR7PNgVXMqAvis86lSJfv5Nd7u9Vi73lsM/UiacLo7XQ5dYfL3hiP+JcL?=
 =?us-ascii?Q?en0sHZjMTUxgEVtwmU46scdTPghsmMT/iLqAXZoac5+SUrt603r6FSbeZujA?=
 =?us-ascii?Q?Jb8zffDgAyK4MA/3z8hARGZmhUeAGOevl7/ucWwQyQcNwKzR1UzQRaXXV/ht?=
 =?us-ascii?Q?p5UpqJ/EKqhEV+N0Z9acUH0RTm+S0oIi/AffvZK0D6i89GyftVMV1Mu4aMCq?=
 =?us-ascii?Q?MgR9tMDv0GkSuWzgasvWC1JOaWZiEfp57Z/nhnYYB6Kp2xHFVbupK5dLxkQi?=
 =?us-ascii?Q?dd0ZSMQ2hj+5vJpMpH9yDChEZw1Cn8QkZaKPSkjTLC4CmzC4mCrMWZf4CFEX?=
 =?us-ascii?Q?/GpRcXDl6bnUt/cIioQVZmzVRQDD6B5JtonN0+un5GY0Ji8TlsHvxjSK+tY4?=
 =?us-ascii?Q?gH/ZfamD3thgD2H6Ax65hxagdUK1629Qrb97OlKZdngwkLSJ/zEMyQzi09ym?=
 =?us-ascii?Q?aUNtTWj6/tqaDjNb2j+t+IBJp0J2BJgpFoBAG4xcYlDi6fDn5hdVWyRC/SiQ?=
 =?us-ascii?Q?ibOWp/SX0RN+WAmZ5+zphl1XFszxC2/2HgF9k7cKcJvN0yREsAOVnoL+/F0m?=
 =?us-ascii?Q?NYTu7UoqfnLy9sxbeL/a+mQVx2UvtimAL4I3Q9/hzxfZcQfjpBaOp3nj/E7w?=
 =?us-ascii?Q?wbTtX3/JbKo+hHWux8gedJeIOkeheqzs00Z57xtO2p82XMibxE7nTossA85K?=
 =?us-ascii?Q?SD8ylg1nSKOrzYJ6v7n1SL2VxqjsEbQ0fMPlyW/vSiT8O+FVVfv3nDuaXaN1?=
 =?us-ascii?Q?Afk9qXE41N7Rekib9y/VU8uMRusdYmn0vhpNjus/T5Pm19QUSwb0LhgQ/lGn?=
 =?us-ascii?Q?bXC4c+U7nH+cBlfbFFITyz9up3t0z+dsZur/mVAngjztiwYsvxcBUCNvkSOj?=
 =?us-ascii?Q?xbvuqp4KOYvSkg5jCZHcuG1UGPc7rpImo7bk9G7UOVej1is0j7xObk2cFqzF?=
 =?us-ascii?Q?sZuyFHp2bMBFmUrqriMLsCotXBBVfP6iF2WGtrCU3/i+1VhYow0YYd6oE47R?=
 =?us-ascii?Q?Ncp8MM5hJj3LcZB/Lw4OL92Vjp0AQK8whHTLsrrNIPvVSoGlCKg0Gkb3Wofh?=
 =?us-ascii?Q?0IJi50uzFCwBtSt4Gg3SCKw+4yqcgPGlKkcZEDgVr2GYvMHqDmr3wEMDk+QK?=
 =?us-ascii?Q?eJZAytwdhQ+iGPMA2b/H2E4MbabPp8Cj2gdYhz6pEmaVmajxwByr5mWI/L2u?=
 =?us-ascii?Q?RIrfuiQFQ6ZImAofruW86Ed3FNrq9LZuy9CfMlQKX8HkjlzttoHyuZDhbq70?=
 =?us-ascii?Q?EgOyZVThZbIqHFhh42O1cup19wp08VryGkYXlXxov3reb7wNt+fN4r7yZSh/?=
 =?us-ascii?Q?+rCErbf4eoXFonHTTREvHXc8MfY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0156a7fe-4c4f-4d78-4f42-08d9f41cf578
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 02:59:06.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ydMmUUHQX8LYkiNDH1Jje2c3RK81vTPXzHmceyriNyOyNIwoT0W2Hin4d1wMgBVS5sqdmS1C6hriQwZhHIt5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

v2:
 - keep the order of the applied patches. Drop the revert patches in v1.

v1:
Resend all my queued patches in the patchwork. The sequence of 4 applied
patches is adjusted and rebased. No code modified.

Geliang Tang (12):
  mptcp: add the mibs for MP_FASTCLOSE
  selftests: mptcp: add the MP_FASTCLOSE mibs check
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add extra_args in do_transfer
  selftests: mptcp: reuse linkfail to make given size files
  selftests: mptcp: add fastclose testcase
  Squash to "mptcp: infinite mapping receiving"
  Squash to "selftests: mptcp: add infinite map mibs check"
  selftests: mptcp: add more arguments for chk_join_nr
  selftests: mptcp: add the MP_FAIL testcases
  selftests: mptcp: update output info of chk_rm_nr

 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |   5 +
 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 336 +++++++++++++++---
 6 files changed, 307 insertions(+), 51 deletions(-)

--=20
2.34.1

