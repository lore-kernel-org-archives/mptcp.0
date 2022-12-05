Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B87C
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 12:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naA8rygC5mP48SBPhDAOb4G6xiOU0xaEE80NfOGrz7ngIW3Y8Jg0y+AzImKRkefWaGKt2vbAC/4WTk7hUE8LCAkEGpQ5RUbr6vQqlZnhPQNUMEPZ0zB1Lzadx6ksT30Xc1wjjse0FZrlNuZ2Qq1koGzsTyo2kikI5MU96QKN2gCFZufi/2qr8RA91nPgMXb+OJP2hjiHwcmMbnxdCLCdO9jPPF2RP1wHyGW1QcWbtpIrzWegr+CPvVIRN4QL1VKehwR4ZPdH6eOoxdVm+9QpXi5JQPGmEHKSV6RXIrZ6da2QcPg3u3fQ7RWMGcWC5DB4hKdz+lj2OaswF3SIwcBlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrBxmtIim6xToAxTKclmEYP/klUdgkzfIG6uTUw9SPg=;
 b=C4av3/oLgJ/+hrMfkM6WRquZ/buEvxgDn+JPzDjmHvvtIx97nRA3O7AIRKNy0XJlekQBHVXoaEprIV3qDVqYVmXMShiiO5KaszSWPy8tELHR1r9E7fyJZJwYkyF+RWpbc71FTeBthRwc1wR9AYLhreeAr+cVhE1y+7I2p+7u9np7qjHahAPfAW6I/P1w48glTynbovNYXeO5BsDE7h0IOdaCS67Lv064d+iHm66z6RPOH2VTYkudaGV34Wts/FvShsK6nv4sGOysYuDI9dOTbyFmFHw4lFMBvIKaoLZ+6Q+iFSYHyQ2st5zCsI7yFhAmEvw4Ji/2tj27E2ODSdoKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrBxmtIim6xToAxTKclmEYP/klUdgkzfIG6uTUw9SPg=;
 b=4m+07GsbGcKqfvXtCtNUmsE//fsex9z5i+P2OBKgpVlPDUaWzi450UyGInqNlfVJmmRGjhd+8mQ2LrwL48xD922//MOpUpjWlNKn4t7OtqgMlXtOU2P9w6UlslIzaV1ANIM/BAGw1JXsjd75vsxKwWsKAPlIX5yBuH180m9uqACr5bOoXuVr/3e1KWf/c6sAS4et0wYSopLieNzpWHsRB8cSnFhs/vqYG7cjioD+5SGFkhrcmK6IhrKc2nxSH/17GSVFBLiucQmkxFA/nUZ1rk1xdTGOyC5kpUURcRvn0Nih1Jsb4p2n4VmAtCSFA5lp6gIYkW3dCC6BCE+/qFkerQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBAPR04MB7224.eurprd04.prod.outlook.com (2603:10a6:10:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 12:35:31 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 12:35:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] BPF redundant scheduler, part 3
Date: Mon,  5 Dec 2022 20:35:20 +0800
Message-Id: <cover.1670243225.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBAPR04MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: db5cc09f-9f7d-46b0-7a91-08dad6bd3298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WESVD2E38C285isn1M10LDVXXk3DxnIOMKTwg7wNah+eSZ4WBUtAHC7bA1CFwnIRbXkJpdydvW6rSAQ0yzkV/bcxQfFjdMynQbUNS7SH7s0oLOoV3OyoMPozCiW7dRwaPHCgvdVvFhlkeil/waxQomi7PmXZYeRpfR0ikIybKuwYCko7Jotl6x7e1VlxZWUHxxsSHV1UhVREkJp5INB+pl+l+SnB6UoJ9hpiN0Zx+MnTpapr2IY2hqUh5Kx4cjgc9VSRMo1y+SFdx6ErJz/ci8hdKI30KXFCUpZr8n19+WlWQ6XnoSDMX3yMvljRNW5GoyyjM746LyqbKeIO1sMKuGTCtOlVZZWUkYBw2gipA7YPAzDLht0SCWrD8hCmB0JKfGiAiF4ZdCd/NyynWENFv2gEtq9IqW5aaLRMwU/AHjo8NLuBg3Ne7DKLaVURZ/iQjnUD4+/y7l/Zjp1hGZfEpGAgLP0WKuMvWUVkIccz5JlLvBv6+x7kXOc2V0JuTmLdb8dJaxxn3udIZqNZlLJnkXUXsKFtwDCmeQIzGPkEPvK+nfyYMCpCPfAOT2B1y2fvncOrMrzzfLqcel4/+61Dac+ceQkBCgqGkxfmMX0WRnjhRzwRCQz13YPWhL+kWgRA3B1jUHPeXf4kn/AWts8C8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(376002)(396003)(366004)(136003)(451199015)(107886003)(6486002)(66946007)(6666004)(66476007)(66556008)(8676002)(38100700002)(478600001)(26005)(6512007)(44832011)(2616005)(6506007)(186003)(41300700001)(6916009)(86362001)(83380400001)(4326008)(4744005)(36756003)(5660300002)(8936002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CJT/jT1J7l4GZsca3zON4pghdV9UBBt7mig/T3s9jJgPwfnGMmBmNFHC2NSz?=
 =?us-ascii?Q?XlEMKRjdSRkfVFKI0bcEL+SkCyKVl841Vo5QBymC4IduAPZoEnYVTQd5H2eD?=
 =?us-ascii?Q?90a8IDgw5jbw0yfXa2mn/LJbh2LVT9W98BIMH5WvRdcDHroPW4LuM7hIdTlL?=
 =?us-ascii?Q?9087HRJQuIsHyysiuOkfP8Kaq7AfLMTZDsE4IOfo5CXBqMMtuo2afVR1aRrj?=
 =?us-ascii?Q?rKBQlT5IN2SyDsgFgzBW9DehxyrKs4IwjLT4Nrb7PfbOVxVVyTgoux/7EGYm?=
 =?us-ascii?Q?Bct+JxI7cQOREB5W/19Up5ju0TKwwuU7h2aWqLzXWXSsTRKbt29SaiyxYpzj?=
 =?us-ascii?Q?azItpLB7wK5+HayQnnyKMrXJwe/Nwzd2ZCWfrlfexDapv9NSsFNAIZ1yM5Fz?=
 =?us-ascii?Q?ijJo6hXmKxBmpy105I6G1ToR3ZsUorTen8EkDBTiorqsiAIXaJeUc/ygC3IE?=
 =?us-ascii?Q?XItxrolwaBN2GzvBO07CKlDWQ62Dv+QoixLAVWXavv8oWOxjv2tJ3rZycwma?=
 =?us-ascii?Q?j8JAVOcnpAi61fGJT18ZRE0wexmVTLKbdfAaE1u0Bg/KLnfoSRLN4fHisfvD?=
 =?us-ascii?Q?Mxbk9J1KnSMTal2jvB3IlIOmfl0WVQDc6cvvloUxw0W3EmjdkMUTGDFZz7rB?=
 =?us-ascii?Q?9QkHXCZuGgWvUReXI/a7eWGvysJZvPES2MUF9PWQfANqvHxPxOh1/R4Z4XnJ?=
 =?us-ascii?Q?53rLQ4ktS3tuXv8h86XXMPfPMfDvEQ019wHnPNQmBJPDBrUJqVcj6PrApnbb?=
 =?us-ascii?Q?HD4eGoI0Dw1RbxU04EOvIdIav0NK1TARsnVZPXHMqAoU8cA4CLC6ykHSBL3j?=
 =?us-ascii?Q?R5KcQyCkVDWxtzWLFahki0uaIWMBwuUyyEibUD0YJjvJbkKdcyzO5nOTF3Go?=
 =?us-ascii?Q?K1gucff/cW+0plGhwQcCi73OrXjZpvZRry1mKHPO8LEK7WMUYItirN5XRsct?=
 =?us-ascii?Q?Ep4sUmoPsfGIseE789AO6V7qdUrG2/52Tr5lmYnNJbRBM05o/sRUuhA3MaxF?=
 =?us-ascii?Q?kNQRKLlovkzp5RkUZTwOMNNqgu93R/Bb4h0OHUvUeaD21bnwdQRW7moxFhOh?=
 =?us-ascii?Q?DEqiKTKUv4Y2BACE3NIiuyd+tykNs2ibvFclMfJmdjOehZE68Qto5QlTYMoN?=
 =?us-ascii?Q?ORM2Y5yVpBh6hnlCiSG7rU1Exa3+bm/e1amQPBAToN/IGs4UJqg4YPwolpou?=
 =?us-ascii?Q?inPocFilOlliCYMrGtf17YLQIL0x1wm103jaqWoS+WeJwRX40K9SuD5OCTGh?=
 =?us-ascii?Q?pJlDd3msogQ7ET8SdXOytlZUK+G24rqeukmdv8PT6flBzlPJXE7Q6dKXo4ib?=
 =?us-ascii?Q?28NagRrjRGl4gPoNQ/VrSWr9N+nDbtv1ZUJ0uk3JmJvPxb0/A9nSU/74maW0?=
 =?us-ascii?Q?UWOEhIyUiktz8qwFN1RpKBQSJr46n9UTGK5BxuT1XPN9/FYNXH4Bw4STTExP?=
 =?us-ascii?Q?jwCw227sXw+lffRlrxHZ6LTRQMzVPhFKkEQwRk8Cy8I3K+l0lrKY/T8NIQr9?=
 =?us-ascii?Q?cfOexJc71lqOj715KI30LudSK1vYRl9mK+G1Gz6qmNliTq5Mb7mb3KWld9Lf?=
 =?us-ascii?Q?F9LPwXZA/1OPAjO/rvqULM3uOiA20B3BzWBtrO4jJT1bRfjOd7N/YcXYYdiZ?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5cc09f-9f7d-46b0-7a91-08dad6bd3298
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 12:35:31.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFxIpxmUp5IvH/iyYnnIA9jVSYVgqF7IthF0izgvO2dbhmC26TmNyODP4tI7eJgKu0Un29h8iEgMgIZ/KNygMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7224

- The DSS issue has been fixed in this version, and all tests
(mptcp_connect.sh, mptcp_join.sh, simult_flows.sh and BPF test_progs)
passed.
- No need to set already_sent to 0, drop this.
- Add retrans_redundant flag.
- depends on "BPF redundant scheduler, part 2" v22.

Geliang Tang (2):
  Squash to "mptcp: use get_send wrapper, v22"
  mptcp: retrans for redundant sends

 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  1 +
 2 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.35.3

