Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF02168
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 02:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643164528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KjsegtucXh5+4jZfg5XhE1fmVKl7ZTD8GLsmrGj5EBw=;
	b=GaShswoChlEsTSdi9AnQQrNmdHny6cIn+GF7eqUkP+kuQ3He+v121GdEeZZR7WOVNFXVfz
	iz8efQ29sRAvwiWfza7oLvQBdl+tvchNFSlneQqQQFVH20RMVaUu1guJvctUPfRXK+j9Dl
	KB9VIUwpS8dsasAUbqZRV/EoXpjWGBQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-n7L9vdXiNjqaDF-N4ku3WQ-1; Wed, 26 Jan 2022 03:35:27 +0100
X-MC-Unique: n7L9vdXiNjqaDF-N4ku3WQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVteJhUezUKm2Hg1nE45M/O3YgCOIhBXSOri+o+2AYt/Ws7hzD1YgkHB5vNdpOh2d7LkDkeSER954l36nK+BecQvyBJvft8R7GchBzeoOA4ujgn8/6XVx0FW5IbyhHI3+ti3ca6r1Zg2nNIOw1cb8dahPPHL+i4vQJOgAszedDnyPHlppcYByPrzuqKANv9YYtl/WqlSNUSIumGYxzEIe1drE5+WL/xZDlVfqFu92uLhGyYN7ZCmVP48FE//y8UFEWIS7TjAtqRbgSALeAXBoQaCO2wDY7NqzlbJBWTLWh+qXCxYan4ircWRjhqK8T/A+ysDyZZhyhFK9ycwLx8BCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pzA/L3tQtSqfEfCiWbWqz7sZvgqqU1MlnBckuSxS/k=;
 b=oCJ8wTz206IqW6YlE7jko7TXUbO83nS20pqMOFY5oyM8zpPbq9129KC6oSSM9qGq0ExFMOhhg3VBS5osvQB0bI3DCgJ9xjOq26T5uzBXM+D4lyAIDOW1bsiVKcIrUbUvlXX4ZrenOoxxOcaDwdsqS4GITZH85y0lAhZu+BqjAahSlx/raKnaFSoCMRdqLSI60qyFxxesFFCtmQYWvOXPp78sLHFIKmSLaanvtOpd1RFlIgeiBMjgScDCB/+ihoMuP5uPPNDBMuLbKBe+l0O7AIQCXKZKNulMTZjuP1mirdLuk3zNZXnDkWoVBAF+bKoNs/3ol4JaWS3VKmqAi7REFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4942.eurprd04.prod.outlook.com (2603:10a6:803:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:35:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 02:35:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/2] add the id argument for set_flags
Date: Wed, 26 Jan 2022 10:35:26 +0800
Message-ID: <cover.1643163993.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05631442-57b3-4409-cb56-08d9e0748108
X-MS-TrafficTypeDiagnostic: VI1PR04MB4942:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB49425619D74D0B3BCF20929BF8209@VI1PR04MB4942.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ySiUNvxWtZ6qEsOJ6zOB0ItfayC+8SiHdVvbRyh8rg1Cv//P4yzKnA55JZUixEvG0ZooEfXd4Rf1i2xxLCXQeKXdNzh4nPZX/8Yd66HyCuuNaqhhhD8XmH0WJNstzY03Njy7kTxkj4g61VgJWT/hFn4GeeIpYnalgrm4F3ajSy+Nys1dN/xkeP6TA2ut3lIgfp9b9FIka0CgH2QIUHR/aqAf1LfULhWrWDfvHLFIdRDnyri0uCXnR2QMbgvT0/oHxaubyiWzIxK6KFno8umwXVvvcEmlHYG4sdisCi3gugK4qpnLOJEI7sZ8Mm+2DO6C4Q1sR+Fo0i1uqeofc1GGe65QetxtmWNwu6Gv4dsEHcp5gWNzUEbeHy5ursauRecUOIPKH4WQP8489b5H3czrM2cR50kH2pQ7NZcDYFa+lpgzJ2rKezoiNmCP3e65BCov/ok9tTmRQOmX+DZ9KZsucKCjw7OiGVfBLJ5jt9xXIP8ypZBDiyGPXEaRP55zisxdmf8/eu0GdzzrHFq/xEeei9W6byX2cIkCmx6VX2PmyPXGY5Wr9wc3G2mQcc2WBYCiY0jDf4UL70e8qnXOinGvqi1x5itxMs0vcRl3uqXlLRYUPlLAuvZjFdtzktmnOvMju3jC8zlWfVaVGbZqmsgvaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66946007)(66556008)(66476007)(83380400001)(8936002)(8676002)(6506007)(55236004)(2616005)(2906002)(36756003)(38100700002)(86362001)(5660300002)(508600001)(316002)(6512007)(107886003)(26005)(4744005)(6486002)(186003)(44832011)(6916009)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wLogj1zTLddvfsIKiuAm4zpo+9GXveRQd0QDpgJfIber5qX6axX+2KISYvV?=
 =?us-ascii?Q?shusaekMbG0EHRAm3wSCwE2O4QhIk4CEE5RQpdEoPu4inz1b1cF3Agna6vec?=
 =?us-ascii?Q?8ecXsaHupVaKpriTNstgBmdWvQB4wGFjjBS6XzxtGIYFV8eSB9KHDi4IuKC9?=
 =?us-ascii?Q?2J3Wk0HMQMaQu8+r7Dd9zZixgtDoxs/ubngi78maqkxjbJVpQc6PA374aCQK?=
 =?us-ascii?Q?eCcV+TEr0iDkshXydiPGAsKi7zGsGZ7cMX4ql0zyn+iThvpvesbLIPxChxqS?=
 =?us-ascii?Q?+fqkZUk8PgzHmNWzPHoN+CH8zOqzc3z83/fe84yNmn8/cDB+3o1uWycxcE/M?=
 =?us-ascii?Q?vLzDf0HJ60QTni8wDlC7uVWmGdU9WTB4cxke99C9MinCWk+aFxx8vX6AC2sT?=
 =?us-ascii?Q?LP//K8n/poHLdl8RWhBe57iMDknLjOlPprhjmiBw5xnVHbDzpUZytZCMAr97?=
 =?us-ascii?Q?iwYX/4L9unjcngadpSUizbK/FaDTzO6PmoxU3ZaZ3wenjy+xkzZMNGRBRUAb?=
 =?us-ascii?Q?ECC3FpClFsTXDP1Cc3NKr9x8QSmv5EazayhvdBePGoTAYos+uEwIC7CIIrTH?=
 =?us-ascii?Q?EGuyGha7CJIHquTK4NyRxmevICedyXsUCgfoHurNOOoyPsHqqjsIeYBg4FXG?=
 =?us-ascii?Q?gq5zajwsycqCzySPdG+1wWqVLUDPBn0ZQ3VWUHBpw6AIF7H+NbGVEmF1ViJL?=
 =?us-ascii?Q?am3iqsNzfBSeHpGcgDhcXgVO2xeEW/4KPt1IMvGN5I1+CqQWYkRrc21o9CYB?=
 =?us-ascii?Q?7MB7P/1v0+Ip14feQwuE+a7OkCkeSeL2TzvWWofRpm95E9DsT/D3vlDtdvgp?=
 =?us-ascii?Q?MoIXYMmkHpvvjt/EO8iXZau16Qj8X00CeeMKMPzOD2Jk/flrpQzm77bFPcpl?=
 =?us-ascii?Q?neg4CSOEDER9mm330BPHbJUoPgX006lbIVPoH8vVa7oneG7f+6hjqvMvDwv5?=
 =?us-ascii?Q?jWuo41p6pKBo9teCt+mpmGekXEhzQK10QM4AmsiDmelaVLRAT6+SrviEzuuW?=
 =?us-ascii?Q?08yNitMHzBu00G6ZeLt0BFL8dfBiSTJ+g/GLFqaAPJHk2rnGLfk0glhRUDGM?=
 =?us-ascii?Q?A9Y3ZYwuOvMcm1CyR5nF+qyl/zlmeY+pFZasHWwWvxbMtbiQpDAZ3qFpoT5M?=
 =?us-ascii?Q?6rfZcakEDfYUNaPbCWA1bCPTmv3jiPgtJ2zOuvbTbsrOTLhxhZbrcVl6oeSr?=
 =?us-ascii?Q?SqpsnC75yQGAmiTGiZ3FWUM3mDhq8S1wsNCABVZ0kMmZWwQ5r17gl51ALLFO?=
 =?us-ascii?Q?2tsUF/gGVRHtyrxW39FW8RVRPTJ6zpJxIJS5KbZmoI/5LZekBcZaL0QEF7Q+?=
 =?us-ascii?Q?NFZ7M3FyrvBvS9d9t2UUExWNdLngDxOxW97jLzZGFPdp6Rg0N+A0pFOZ7+1b?=
 =?us-ascii?Q?q8h8fGCTOTOF6OLR9oxtKxK2Lk+peT76mBigM5RycnKHS/28DdswhounWa8S?=
 =?us-ascii?Q?hDF/gLf8sqtMEMkyl5PY0aNvUar0SL+VoOeiASVgxVh/ukxGtDfFFNF8fz1p?=
 =?us-ascii?Q?Q8wY7hC4bdg6ePCS28O4cS4bwH+xcZwfbyklPRAQecN/ToBpIKjNtUjHjMJy?=
 =?us-ascii?Q?5yTgR9TOvaO9M5dHfSeBHA86/w4m+tAK2nfXGCGBegTgjCoGkiXHRxEBr2jP?=
 =?us-ascii?Q?PSF0tSymwcU5fFyr2Qex8s0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05631442-57b3-4409-cb56-08d9e0748108
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:35:24.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZcP8RG+l8L7MetUdcT3KIGz0Pzn10bRaaPxb9zNxokA35YAz5GEmkuCiYEcGXGETeyaCmzPPkCFPP+q+EHJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4942

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

