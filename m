Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B751FBA
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKcQm23VBrENeg4VJQGwsjobodr1pSgVVAqeLT3WVNuiupXpmbMB6xUWkJmT8TgOJStzamJdD4u7iOOfTcmm6CjRY2SsBe91hBDUy0QUTnGviKkSnjSLhhE+Xww7CxtmZbRsad2PLEnRmm36Z34qqAgDDCqBZrXSZKUML4lZMD6twG6t5bejI/n4OpLcn9oivspct4vjoQEUIfv2j8HsTo6oxazRzBnRtOy5GhUHirATw16dcmNnYj0UU1wdGsHK0VcJXU6G23vimwHZMMM36R3KvXrn5yEkTlWLjJ554cDPBGdBvnonRGIJyKkNISy37ajAOZc3DTzanAG4z+N+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI/7nod56xEtxKtjvYfiREpPD3qfHSjdKDUq1N/EzZc=;
 b=aCNKkD6hFsiehzRHTsy67viTqp3rFWRk9rW7HFpnOq/+hgXh1jfo4orXBwmRuq64MTUOXsJt8MJ1UDyKIhwyxRVb8tqyPGljPReWpx2pUPf1zTBD4XtMHqy6Y+OnHZhsDRmoXa9iwM7TfiIN+jS7dZ65pdz7bbH789xINNgvnuUqzJay5XgSrMQnl4bTwukUJc+6/ZzxE4zlTC/lNM8rVOELyzdcnoo1JMd9O83wY1j3Vqlr0NGxakVl7nA/0bgQe6DNHg90ZmlGcTvQPEUmrdwRphYssJXwdLO4YpijeXOeXQxA3Bu08V3Vtz1y1nKIOiRtWveu4urvqeiKzobKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI/7nod56xEtxKtjvYfiREpPD3qfHSjdKDUq1N/EzZc=;
 b=kgBlliV3bvi93cTC2yCoeBZKHJqBfJSq1j8GEsXECoqcBezlU4cA6zkkZDAhgiBXb2zVA0VmYvdEBSelr+bPVUJsvxyRx5PWHF62auIFD/79A1s1d/C5bWvjyyi5AZu+19F5knEkkEHfYw+5jBps67tAvXiWpgaSlYg/KGfvd7/BrBCA0wNAsEvqfqwJZarnbExh+qmYac9mReXdhQGt34Gnu4yJS5oAXyiCqLiBV6VUtVNjKq8xmdlYlBXgNMiPr8JjCBxjnBdN2XkqfcF2MvZrzQdhzeXEAUf8esCorKZv9vORo1cny6DJYdizr9Q2tNjygjG5bTzeXU6gD//JnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:59:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:59:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 0/7] update userspace pm mptcp_info fields part 2
Date: Wed, 31 May 2023 16:58:49 +0800
Message-Id: <cover.1685523463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: b1661e19-be07-4bb5-1a44-08db61b54909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WayleVY5HWGiYA37ZMBZiiYLEP575/l0htCI0tVMqwl+cEX5JTvgAtscY48mET+QeuMs9/DPB0o60/V/PdUT75Jjywr4s3EQQJUHXWzlUZHrg23m5potFIwSiL/GjICXGDvYIml/hSKsramrBDViE/OBXrMFe7t7ojQH7QbNtn4fghvRcJUVcrHIuh2mIAD3K4LOmR0SfpbsOPYdfOrF9J80V+xmyv/361dj1mfJjfITXfrUW4cET2vin0jMimJrXnVecp6a23WQARQFU2aw0x7YKR5PVYfPkD2XIGwXJ3Ipu59wJ7L0MZR2xmUvbLaov9AeWlNv7YWt4qxwS8dF/KcHbRQeK2YBbvq4szue+ySDTXpeQsyOYhXIL0Cs6k80rPUkvb2i9mXxNazujtIU6IrpvjLKlV+q14LTKPLYRJN4ss4pEV7edmKhsLiyCtYgpzC4R/iLmtBO4S7SbJUPJ5vn2Sc0tDrsZUsJHtytkhqEjRg9MShB0bHhjOfZmSx7D0J+QKUIhlSnjX7DcBcZt+gWiiWrGC4fyUMe8wGnCb3IByH/R1MMeMj1LcpIZdey
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(107886003)(2616005)(38100700002)(186003)(41300700001)(83380400001)(26005)(6506007)(6486002)(6512007)(6666004)(478600001)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(8676002)(8936002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGO1VWv45Dl0QHvm4utoEtvMYoG2wT9lP5lJ+cO3AyUxdgeoehzs4F+ZdiYu?=
 =?us-ascii?Q?qB5yQJTR8vdZ5MLjWLnUdnq/U1GCl+n6bh5gzdYLuYTx1rEPQeFw34iH1cUZ?=
 =?us-ascii?Q?BbCNHv2Iag+xK5aXax5tuBVZYyc52216D8DzqX/OkojdiyFiOrtKibPlQMkr?=
 =?us-ascii?Q?INzXUU2e+y9+lA0DaScc+HVgVI/zsffkeRxsd8qTZUeL3w7ViCnj92VawUCL?=
 =?us-ascii?Q?w2fglpIloWe7+ludK9c1P2CQmiBhXVUCLmb1TbA0oY3J47OCmyOnTJ4n6Ll5?=
 =?us-ascii?Q?DeDBT2ZCmTjNahCZPLBZIfq3iG4sT3C5veU4VNZN7ERb7fbM0J+mkTLVYrjN?=
 =?us-ascii?Q?awIXKAJb+G/rvFzVe1hn5jZW2eaaPYrZ2Or+/gtW7N0d0bZDgEbG64eZmCvI?=
 =?us-ascii?Q?uzpAsuGuO5IUglNLhh3J1Ptg7iAMf1ZvGAdLISAs8q1MJYmx/WM49h/o/1ai?=
 =?us-ascii?Q?zJuN4wTk477nx9/d5EKTecvZAEclwHHXZuc8ikKyclszhL6s+zF4N/tyQhSt?=
 =?us-ascii?Q?J1AWZICJyyQQbkl8iC0LPteSqVZO+KpJQ4oBxI/tQwVgnEiQRqOj6jGWv3bC?=
 =?us-ascii?Q?VnMK+vhCi09Ycau2SbjjEZA+mSWX01P8AfFSqfG+jW5f0dEDgIMz2hBDcioj?=
 =?us-ascii?Q?PPTEJbpIlSX0byOdB/IFtifjT88kf1119V9Byvyc4Y6cfHanjOdYbJa7MFnN?=
 =?us-ascii?Q?dKvAbejwzQwMwtGZJ16i34wiLJqxeTDMX0ZoQ95ygrPsW7VStgdM+1jIY71k?=
 =?us-ascii?Q?zh0BulXMEjxMtOY0gFD8hSnpKtZNzAeZ2X+GymosUT+dZq9phJ/3v038ie/V?=
 =?us-ascii?Q?7asl2KKQUMojkPdWPgiKZJ6ig+v/wDzx+y54I2CzgkQZj3/rQvZmNvuCio1/?=
 =?us-ascii?Q?Dwpv5G5cZCdcMe62VE3LWi4mIGN0cZUFYvDu87kS9Idp8luBhovfHB5LMyWD?=
 =?us-ascii?Q?ubb+QkJ9FTIMDE+S5VdgBe+yhHV7omWGUgoZ7NolZV6jDRazi0aj6PThohp6?=
 =?us-ascii?Q?imwZdKLB3nfWMRrJns1chvv2xVLVF67M9IcqUkyWZv78lSLUCU52gJUDbacf?=
 =?us-ascii?Q?Uw7XcjaSaHzOu+1Fwd/uMwcJ46jub79luY9h6wk4uUlEwFFrBCRK3JxM/vQx?=
 =?us-ascii?Q?BioJdbXjnQntkmtx1zuSlnL4UuilcfssnpXn+yglrwS9T8sg/4aiJeoPHC/P?=
 =?us-ascii?Q?WloCh+IZJKceJMaZqXkQFTxUC/oOg08H1zYEkDfgkICmgUDhNFBr4Jb3ubp7?=
 =?us-ascii?Q?tDDqGirbLUs8qKDy0Q9Dll97NlRv+Kx+6fWsOZMTYLd4NnI737cuSVb9xu5W?=
 =?us-ascii?Q?twGhtFP26RkoURWy2LqeMc+24xgBAXIb0kRcjmr6jj8gXE9wIKhRCo+xFEK4?=
 =?us-ascii?Q?tQSmc2p+Mz87Lc6UidHx8YuKTlHpAgzW9HmVPq3itdb9EFTKCmnaswncowr/?=
 =?us-ascii?Q?RYWbzsqTnrv5mfyK4O483aGtAIHv8xxGSjcOb/M4ohw69cFLItTs9M322Ic4?=
 =?us-ascii?Q?5esckPN5UOfWuGW21/k1uRaV/Hb90BVe1WHlH0Eu1q6/S+mbd5zVbg1LZAlh?=
 =?us-ascii?Q?EwzoKSLujWF5qGMk1pSAO1jdEqSD790PycsEsm+u?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1661e19-be07-4bb5-1a44-08db61b54909
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:59:04.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cpiTx7meO7irybI7jQAjuW2au3aEEnJOhgWuzAMYqf6RcKW1IR0gdu4ku+isMMN9gyAe7yDOuob+k7azet6Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

v15:
 - fix the failures reported by CI in v14.

v14:
 - rebased to "selftests: mptcp: skip tests when features are not supported".
 - patch 1 "selftests: mptcp: skip tests when features are not
   supported, v2, patches 8-37"

v13:
 - fix all the failures the CI is complaining about with the debug kconfig.
 - rename endpoint_manipulation to pm_nl_set_endpoint.

Geliang Tang (6):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflows infos
  selftests: mptcp: check add_addr infos
  selftests: mptcp: pass fastclose to sflags
  selftests: mptcp: set endpoint out of transfer

Matthieu Baerts (1):
  selftests: mptcp: skip tests when features are not supported

 net/mptcp/pm_netlink.c                        |    8 +-
 net/mptcp/pm_userspace.c                      |    2 +-
 net/mptcp/protocol.h                          |    2 +-
 tools/testing/selftests/net/mptcp/config      |    1 +
 tools/testing/selftests/net/mptcp/diag.sh     |   42 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |   20 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 1040 ++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |   59 +
 .../selftests/net/mptcp/mptcp_sockopt.c       |   12 +-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   20 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |   27 +-
 .../selftests/net/mptcp/userspace_pm.sh       |   13 +-
 12 files changed, 784 insertions(+), 462 deletions(-)

-- 
2.35.3

