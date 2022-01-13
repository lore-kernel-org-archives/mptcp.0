Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF07173
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642065182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CqhxoXFDaGRfRcefqGS92doTOdHiV8jzOw5savcMNns=;
	b=iWxT/Lov/sLdF35LiyX8PtJq4qQEkjCIk6Ilh6DQW+5XlC+vGC1/RQdKzyCtBfBBsByw9J
	C15h2c0VvogjYYnDfgpMfefPRdLdzHR+xY4YVVpwkgp4NmKWpLpJkafg2B3/1e9kGkUa8Q
	ryT/GWjOts2DDWlSIzp5ia/VvTZe5vw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-Gb2JwqCCMrOiOUWRKVcDSA-1; Thu, 13 Jan 2022 10:13:01 +0100
X-MC-Unique: Gb2JwqCCMrOiOUWRKVcDSA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRCFelBAGZwM3ovwAAvGcPPuCJ8d49D7P0xIyLbC7vLCbIlu4yv4kx/cfjNnyYdiua1rva2RgWk7PJmGjXYDzy15F/lyhotOM6rfXoJhFkCR63TM70zmMa7cAGTYOWwhzUpijPTaao7jc/HV2RFdUrOdLLZ/WjFCuj+Vv+Vy1ULBttjZW6YjlPuDw0YLSSsDeGFyV/sxrmJe1cWLsX7ckmWA4UXo1fVfDd8teqKVPAixnZy5T1DApT11g6a2pzL9ooU4k1JXpvhaNXaq4GNa6CeDSce4nTQOo334IfAG9JZ4HnvEBb9Q3f95bJtKb5qw2uiAtFYHvTx3EM2AUWsnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w8X6WC7at8nYnhRL5saUbZpWtA2cGSJP7untpsfwmk=;
 b=mwNe7twjK6SZYy7yGzvtrD9qz3OqCrHmQ7V7p730neyL1/Y9QLNB1z0+NbvdM81JyVOL+OSzYb62sZxyzNFe3JES3p6lQQW9vKeMPPHS6aALd6WswdgVz+5d77kLc/C9RoEZnfDRZ+Kfh1D84POuw265kbi72IF2HxNWkjEMQN8MWm+bhJekKr+wNYfhqon4l+DBVCUcUzLtKalsly9LB/VFJaWF+5m1txRZtW68O6i48D/8golxLh+Otj3LLrMhkyruPGjMJbRuCQTE36s5hwr8dpUyP9dHJwx1t9iiOs/4MOYHLp2CZX3ZZROofJL+bc4iM5U2MQsQwUbL2mFBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4404.eurprd04.prod.outlook.com (2603:10a6:208:74::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.12; Thu, 13 Jan
 2022 09:13:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:12:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/3] set_flags port support
Date: Thu, 13 Jan 2022 17:12:36 +0800
Message-ID: <cover.1642064550.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70b4c98-48b0-44a2-7204-08d9d674e4e7
X-MS-TrafficTypeDiagnostic: AM0PR04MB4404:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB440460D7C2683986C9482483F8539@AM0PR04MB4404.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7yFn94pW+Wl2Ryg9+9tdY/PwuZDj/wo1p99uuqr0Mj3Xa+8Z/C/nWdBBThMWDMhqiz6jPYyKk8qPw/KjKtaybHu0GnRXPlNqVFtjyrVqv8IBLv0iQffGJwBn+nshKW+1QHY0WEdJu7HBRso4DO0xGkWlEA5f+oejWMIv5QN1i1yG2mKhk0vi7+ziIi9+gtWkdhn2cpzIlnJz6uNnJyES1lVY2bE1c2DQ+UoDG7j4kfiGEQF/psbYSLthao1/alO7AJr1m0igauZwc8eXyEHVJFNfkXxvOmrvtmKBnC+SgszP4udEURboE49Kw00vArrEanJ5xvcgN8YsYK5HD9/x4JUHp/rRd5Qv35lKfJWBfLuH/mHnn/N7LgUtiw9lAQ65V8ulvK0qh4Of89k+GjnQnF7uhpNRSDSHe3JcG8NI86e+8xm2JTBIRV3aykKgeaafwZHTNhSa9qPX6Te4qs6W8kDPT0SHHU8Yo8p4kmVNIOKbNgU/KMGQi5xxkn1gLNo/UaBwCthLFp5GaLAUxWOrumStDkcTAEvmNami1SRPqzP8/ltHVK4HSXSVM2AwnkYNRgimi5TG3TnYqid/v7FGnNOYiMHw9M68u5ysrIx374Xh7cVJ6O2TGYPaDJoc8UEfC7LWCkfecWA3ocRc7XGmNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6666004)(107886003)(2616005)(508600001)(2906002)(186003)(44832011)(66476007)(66556008)(8676002)(26005)(6486002)(316002)(6506007)(38100700002)(4744005)(6512007)(83380400001)(4326008)(86362001)(5660300002)(8936002)(55236004)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1anQJJvYt4cYlz7e5KjJhNQXw5CWVCtqGJSSuZFtaqrosOwzN/mvQO4fB10?=
 =?us-ascii?Q?D6n/t/oEgBTA0myHILPfzWTgl35MoGBYH8bmI4FxT9IOFlpytJe4uN+fJo58?=
 =?us-ascii?Q?ma8MexsQZMOkDq7tg9MZk0MbypfVcXbcrRYuQYYqjqPU9Coa+EiW6LI3j8cW?=
 =?us-ascii?Q?9eDFShYMHQkANTc9lhZgrLMcasJr+dqSm+HyiPGi6B8Aqz/14/M9ZOjoG1f7?=
 =?us-ascii?Q?RYdJsH1QuE0AJiWnsaYT93czKjJH2YoqNTXhbrxcpsBUmy1Q6INOlev6MJtu?=
 =?us-ascii?Q?IDkZgI1caKMup8jEb1XiCuHZ0V+BfDqTApRniuIaXpQVy5cWr3AVCDPxePjn?=
 =?us-ascii?Q?J8gYnsrzgteXX540J52SETwFsqivOlDEnQB57ExmJR7biTM/XpHTSY7FQ6nz?=
 =?us-ascii?Q?muEvW6iAq/lm1ZFaGTKp63b5NvpNTIdSohZh2l0ih2lYkc5dV631hx/9bDL2?=
 =?us-ascii?Q?toEuPpdL3l1hQBla7pPaL/f/SL8TYdt2IOsxILLWnWgNUHX4AFQY0a2TTjtm?=
 =?us-ascii?Q?49Ej37iV8Act2lCNM9Zy6DdjPttTHGSDj10i73qXvhX3cEOm+DsYJTJiYXaQ?=
 =?us-ascii?Q?LyOOoxvv0aKucbF8OXYf5SqPD0iK5j14oDch7hfEyDcpcW6S54w3Trz/5AAw?=
 =?us-ascii?Q?EJLGPwTELSfERZIn+MYPripC8H4jPtQcSlWbD1uyTMJ4QdgA628EnpCBJexh?=
 =?us-ascii?Q?Cbd9R1vgX2uZazj2pzNaVwubF0EdXkaxLKHyHT/+GI8WSpVZQeZEyLv2R3fL?=
 =?us-ascii?Q?3Ti9WM2rLlHAagzLgcrKyqstSaJlI0BM+c0HzXUSepy/1LeYrOWfrOVcnAH4?=
 =?us-ascii?Q?4hrT1W0uc/ZHwMy9+ZzoUZWEXeZ2td90QUCHL0TlBdrWRBLHLyCeY0KzA4Xc?=
 =?us-ascii?Q?Q/9Vxk701PZ8IArw8t7rM3KTB5bIis2uukrPhYPijeuuc1iHuaQrd59e3mzF?=
 =?us-ascii?Q?Dfy5PsG/I4GLWj4UqoX6hRXiIFZevg13UbtVFQ2wRgwagVbVMqeZe/qPoP7K?=
 =?us-ascii?Q?ucuGtJDw4pwFbQCiuRi+HTIC9o12VIS4JZesj5Yzsgs0hswWrluBI7fNnVZv?=
 =?us-ascii?Q?lQ+FCJN+Rr83VKmpLnOBg4rpdrNX/UXcJaw8/MEULk7mQTtsDOLQCXJeEehi?=
 =?us-ascii?Q?wKHRiwolG80zknQn5JIhx5CWLBc5WUV4yXKjHMlQx4Q0QIsXNRZnkEpLvZ4f?=
 =?us-ascii?Q?b1x2SfwFVd35iWgVh/srcPT4zf8EpsXZAbcdDuakp+fpyAG4sRKICX/gXTs2?=
 =?us-ascii?Q?FKNiyWK8PAyTEqO83o8EBkiWGuoiDNJDvnis3moBCeyj0Q5po7NtfLYRhTaU?=
 =?us-ascii?Q?LLCIhGiV0rlZGkxf+JoAwjdCCvtx77RrNtxxZ4abWBt17nj25ooCpe03uxVP?=
 =?us-ascii?Q?w2Q0aLafnNXcjwVf8ebQRhIwmgYU+wO+VSVEkuDpO8GR3pPOqhDEvkt1Ojyh?=
 =?us-ascii?Q?Z0XoztGdniAVMiXLRtCALXSbz4+TjIpxYI1Dn569sgJE24O/a5O2oHrdd920?=
 =?us-ascii?Q?e3mDX+mbC9zI4ZAAPsHT1J2D3YEqhJKN80TTp2GOs7CFM3ODCcTd096TSqUf?=
 =?us-ascii?Q?rhEX2Hg566BFtfG9BCtSDcP9k/baUp9CNd5CJPqk0ag70myYAW8HdW2BLRiS?=
 =?us-ascii?Q?51roXLqwTKk2gS4gT8gplvg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70b4c98-48b0-44a2-7204-08d9d674e4e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:12:59.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xh25+87nPr+MF3fxlcSB87rvSVbZKVKu68xbxMXLf7u/4un9oiYAtG0ZTov+4ze1iZCgMAqntCfiuejg2OakLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4404

This series added the port support for set_flags:

  pm_nl_ctl set 10.0.2.1 flags backup port 10100

- depends on:
  the "fullmesh flag setting support" series.

Geliang Tang (3):
  mptcp: allow to use port and non-signal in set_flags
  selftests: mptcp: add the port argument for set_flags
  selftests: mptcp: add backup with port testcase

 net/mptcp/pm_netlink.c                        | 13 +++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 14 +++++-
 3 files changed, 59 insertions(+), 13 deletions(-)

--=20
2.31.1

