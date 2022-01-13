Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F972C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QbAq0kToGK2+HvVXbGVMthY8adlDdWa2fU/5ApYZuQ=;
	b=LNqInOimF+vk3eYvrHD3oXHM32PkUxFxGxRSQstLim+IunrBY04oHLQ8Nh3yLbx5s//am8
	5XWH9u9dJVtjxNC89h/xWfPjzgwFbxRacjT9AKwjI5QwRm+fDBFE7s0hq0eLz8PTJKDEBE
	cH9prBElKFDl6S8nzoY2GJXYejCFNDc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-d3p3HyM0Ol2MCbrboyc6Lw-1; Thu, 13 Jan 2022 16:09:27 +0100
X-MC-Unique: d3p3HyM0Ol2MCbrboyc6Lw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5sEQEQr4Q3OTkmVfpv2eU5P9F5j4v549hU/OB+OAyBgFgtDAU02xS0C4Opr3TSscr/bccCWp5wQ/MwkWitx3W2hTuhIaKiUqiQfIFLopoedAoRSOdrqp5MLImENGj60157pnO4tByAzYFp/xUqGtXFvGkyq2Zs/pXyXWCEeIsMLyeYhxmCs/BUmq8bzn8g/wDHwSVdgjQnW6F5hMJTYh8cOIJi1OEUk9r1dcOtO8XsC4MSH9Do8sgVOqGSRm/nnMgWX0XZPuIQdyXjIp8wGREfsAMn7DsJL0ZNT5w601XLMaOiPQqvNP56zQcWJteaLOMo/PO+xe1DgIxLp5oI02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErT/ROtNSGf1h0WHym656o+/yRG5w23fEMkg2Xh4NJw=;
 b=EzLnOhvlEZdeXgQ+IDewytYfbB17UyMo30V6JmvmsRSUBL9hAuxwO10Ow142riE2xFllPWB2D939kyG8qEqpoz87Z0CoinVJidJsCic3QalncylcfQHtveZIAY+GkxLEQg7Tr04VUimruE0jtUVakuAh9CtJljbklodoQIczropA0Rbib7KOnkK8fi0pGEXcQQi+n7pN1Ghvp4F5paPwqG1L0MJmsxtatzHR9O1eMEtxiUeRsrSTVc1g0OpvyTIJ83e3K5mpxXS99p1AVwPnYWxpupPch3qaYoFOdcuO8BXlXSZGibZ3OXPAaTjbjgqdRK35docsz2VILeaCfosiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2489.eurprd04.prod.outlook.com (2603:10a6:3:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 15:09:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:09:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/5] use 'ip mptcp' in selftests
Date: Thu, 13 Jan 2022 23:08:34 +0800
Message-ID: <cover.1642086296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642085750.git.geliang.tang@suse.com>
References: <cover.1642085750.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9910c83-fb1f-4800-501b-08d9d6a6b0aa
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2489:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2489F7A492259788BBDF31DEF8539@HE1PR0401MB2489.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ogke6xAUeBlAYuU3KB0Uttlxsn/wP/NbYKMMUDsswGKp4JTHT7UhICZ7H1qTumeRhbWjwTOBJd/S86/wDedXVib5vR0J259cO2SbnAXH3eH4fYEYeRvGVKa8gs7x3aRnFK4lmERX7V2ZSYBrAN2b2rwDUdLMr/l7BfH+uMu9zi/emGQALpyiDYiivbhaNrfWLkzrU2qj34iwo96DY0zzWjOf16dXyUwV1oT2bPQmU84eQDjbblyF6F9Xwz/oxAIQPKVBI6C0kfFm6K5aE1wRHC/0YWVsaamEjK1NF6J2/m67Cq8iQOKF8dDbJZmqSy5SDquzLjm004a+8fRgv7Bc+kDXMCxN/Z5KKTf0kOUjjGl6n8kv3919/YAOVIopkRWZ6X0URPrYG7hIsbqybp8lleGkAU7vUKJa9GhV44EDoWmHHh5SL3Qc/0DM5QsOwCapPmlFWw9z2kCYl75OnJyz2AHsy+KHor5BNYatXHCO8bZZf1B6AYZnrfhjCgnIDxRmaIu/n+6+TvwaXcxAYv+N9IjJikMhTInz0dAtKqwxItxUlHLGldxGnARg1KOQgbsJugFE84D1CD5EOWP+Xw+HiHeUhMZRVGluengXOBqrti35e/GnS6vnwF4mgHXchEmUnyzAc8VUax3FXQf5bhxCiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(8936002)(2906002)(6666004)(2616005)(86362001)(44832011)(186003)(4326008)(36756003)(66946007)(316002)(83380400001)(6916009)(66556008)(508600001)(5660300002)(8676002)(107886003)(6512007)(38100700002)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJOzpj1niYanrwaKDBJkc7jhDa7utJrSH0pXyBb64KA5gNJCr7vVwvo+UdX5?=
 =?us-ascii?Q?mgdu0JEoC/eI7TEtbYNQEqXUMq5EkJ+jSLETNAI6pmpEVzGNqPbxcX9t4QdU?=
 =?us-ascii?Q?ZNDsL+vUpyc6qR0qOC7LYDIi4cCSYnKIbbN/0bKVeFKt2xUnj6+lGcyYP9LA?=
 =?us-ascii?Q?g26TL1AIlOtrMZ371n7HZNp0LwvK9pt6me8Gck9k9A4dRbEbu7gjZ3eyZsGr?=
 =?us-ascii?Q?yBkTOWRYVwDkvHuHA4xDYqomYrMeY0uzgPvJbsH1CDa4JpJgbINKg/jVMBHB?=
 =?us-ascii?Q?wKQNdxLNz8jp2MeoxynNgZjCB/CqYvUJatD6UgRj0Co0B4l2oaL1+A0WOwUV?=
 =?us-ascii?Q?n+F7EgDVXtcJg91QvJi0IzmT4Dwvd5R/YmotfNDy2C/AyACuDfov8tbu/bas?=
 =?us-ascii?Q?ciSZ6KSeQVnXjxSw5VgAVH1/wFz1Ru3JM8qzo0LdBXxbUEcBj/fv6QUPyzBN?=
 =?us-ascii?Q?ZcZ4/ZLe+rgZh0TwmDy7Q4CUu1uCjgTprvd68z+GWyTQLVokIMjvCiPAu//f?=
 =?us-ascii?Q?sIRXNCywnx7UG5akXyoGXaOU7n2C7/sqx7IbXqfF9ftuQ4q+tg0q9hqbF5g9?=
 =?us-ascii?Q?UdV41bwkilmad/+ue38wZ1zE7gFLrtCqFVPvT9qW5qODQnw88XK1V0ntPT/n?=
 =?us-ascii?Q?dBE3HfD2utCf/H7dAgKe3DaOcf60GlqSDHmHMVAIW+Fr+C5WFDr6ZhalHzBu?=
 =?us-ascii?Q?HThaihN1VD8egpisVoqmOYlf1oWRThpXjI4qegeOtaz+hV2Utyfo0mBhhszD?=
 =?us-ascii?Q?MjS2U9eDC5YzzsK7PZSUQKuUyzSfVLnyDbeTiE+y4MbeUvrNtGB5l5Nj/0DF?=
 =?us-ascii?Q?TK7GzEl605v98f/kWpXlfJqKNOvbOumk3EjhesMMxvdlXLCjL97h0UOATDdu?=
 =?us-ascii?Q?44/8OdzXUX7n6q8VzhOdGfr0AVtIUmEMDDmstish8Rxa6LVAvQz6seZg1ZHy?=
 =?us-ascii?Q?WRVMxjnXspBQNQPXphVZVaE1neTW7vb/jpsfwrOdfMXP9mi0fIG2HB/uwU1o?=
 =?us-ascii?Q?Gn3NZhxIy/XAffN1QpRHSg9CR9zvFLuVv+Ak7icp7GMjv7lf+f45h2xvLAKq?=
 =?us-ascii?Q?mmzDjoWJfeP4X/bZLtncQRByclL0i2cVRF30UOqV6nvk1AZ8OTq2Tl5bW+S7?=
 =?us-ascii?Q?eLH+nFINBnhmDpGgoPJtH16G/nciqGh9GSmXJLgzxRd32ZGbUPJGar8SyKFV?=
 =?us-ascii?Q?lLUCY0omY63tV38Ubd5MoiIiKrWU2FOzX2qk9dHu5R6Ft5BnO227u3ZrNlGA?=
 =?us-ascii?Q?GDowWFV7mLI9TpGrWo5X9IIEnkiv72JgaHcSkcbI3qAaGwUke5ojcWxwEuBs?=
 =?us-ascii?Q?njeSjkW/Iq5ULadnAuMwaX1yJY6+PSO4OcI1mJtuVWOejik02qVUbURWNYYY?=
 =?us-ascii?Q?r5z0qQ8v7fOt4h1/edBKO0P9oIW2Z2nZlpMKEngc17s04s+/jY56iX/FooTl?=
 =?us-ascii?Q?hnUvXc91wp0v0Vv3sS3c6NFzX5MK0NxcC24RsoCD+QCVfamMBKX1ZZRMC00y?=
 =?us-ascii?Q?f53nOwghkupnAOqQGnzt/GxLnroj/MDDfPNYaGvUECGUaZSrBMLrky89h1H+?=
 =?us-ascii?Q?rzFCN+hKdcswmUaAxKYxCgW0+NF+BS1If5DObN2nrEVG8e5z9ynGSNPQQOp7?=
 =?us-ascii?Q?TXRGcgoFC+2KlysdKSyhvADZcSoKq3O3ENcCG6osSSytvsocqFBmZAjYxLK6?=
 =?us-ascii?Q?/FnxZw+tfprHg9xDbOXCjj7MVlY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9910c83-fb1f-4800-501b-08d9d6a6b0aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:09:26.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dq1SNVoM2TvE6CQFFbOlg/BGseQ2HmXeT3Qdazi0e8KXX+wZSa/nNRPPRgvHAmjeZbrejuFK4TMSetrxjJSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2489

v5:
 - init _port in patch 4, otherwise it will be a random number in some
   tests.
 - depends on:
 the "set_flags port support" series.

v4:
 - move the patch "new approach of getting addr" into "set_flags port
 support" series.
 - rebased with "set_flags port support" series.

RESEND:
 - update subjects and commit messages.
 - rename pm_nl_show_endpoint to pm_nl_show_endpoints.
v3:
 - use new approach of getting addr.
 - squash four patches, pm_nl_set_limits, pm_nl_add_endpoint,
 pm_nl_del_endpoint and pm_nl_flush_endpoint, into one.
 - rebased, fix conflicts.
 - depends on:
 the "fullmesh flag setting support" series.

RESEND:
 - fix typos and checkpatch.pl warnings.
v2:
 - use both ip_mptcp and pm_nl_ctl in mptcp_join.sh, instead of
   replaceing pm_nl_ctl in v1.
 - drop last three patches in v1, keep using pm_nl_ctl in
   mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh

v1:
 This patchset replaced all the pm_nl_ctl commands in selftests with the
 'ip mptcp' commands.

Geliang Tang (5):
  selftests: mptcp: add ip mptcp wrappers
  selftests: mptcp: new approach of getting ID
  selftests: mptcp: add wrapper for showing addrs
  selftests: mptcp: add wrapper for setting flags
  selftests: mptcp: set ip_mptcp in command line

 .../testing/selftests/net/mptcp/mptcp_join.sh | 878 ++++++++++--------
 1 file changed, 502 insertions(+), 376 deletions(-)

--=20
2.31.1

