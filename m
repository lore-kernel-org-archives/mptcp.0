Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74B173
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 02:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643076342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PyNmjNPD0X3TXDGWWT89VYboTRP+hltgcFZh6vXZ7DA=;
	b=nzbx84HdQhV97ZM5CEhkVpV6L5L3rJ8fHQ23gH+kCo09unveko+0HFDlakorJGBq2dGgbl
	eQ1XhDwsk+yrKk9stqLLf+89cnnXaLRxU5vntH9oeam9oryhYnhv57RlKIA9/Ljd+MhSNO
	UUUjDovcpZAjqDGhcOZjtUj3BmJKwLY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-2wfMBB9KNJmWGst0CgnHAA-1; Tue, 25 Jan 2022 03:05:41 +0100
X-MC-Unique: 2wfMBB9KNJmWGst0CgnHAA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFqTCL2TCcXgduf0CTyBJkyjrZttR7+jWHpSD3qscNCFwJae9c1DRKiDUHZWDpZ/FpHAL40Tf1Yt76GWwU9nZmgcKZfLpcIgL94pURBMNZ9Cq+iytBu6Uot4AVKqheIK5SIOzCJATMo//dAzZXlk5/xj9HPYjxEWXFXUxujibvIPjN8HpJIgzl1Lq5Nrgtmdk1k9gOFt8hFad/svrsc6hzWIJPdoBumHANAEGpix88teyw2DHS1RVJCVpFy+bT3tYlSvqiBB2GodRN40UlQbeCxGkR+Oc4mBBK35bupJAcZEObChNgmIAvSJAK9XLr2GVDLY4j7YVFhYfLtLyRjNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBkIx1BZzLQ1ncKlTUarOpoqFopJiFc3QNIPjf3i/Co=;
 b=llgx4+YgKfpR3nVvkpwsXajvTsgu2P8DjUTXpKICPJQ/Mph6znB2ZfdFoPoDzeg1ud6TgUcsYmaTTaeIlNv0OyASwICZ/1Wuhz5WAB/BUMv0sRfk1mr5w7Z9ydIIN3h/u2rUr6Og6oVxwPI4khF4AtNKudtG6+9VaqX+OBlMyfLg41FGHPDe5mo5iRPK+Pdj64cKsqdUJAN2UDodi8qISFqhT4n92fqJL+SSoypWqyWjdydUSIi4PsleTfpcAUXCJrsIoxkKVShjqvqRGOUuiPVJtxm0KHqNpz/2TGaVKnnRp0iOKj6z0JzwlOnRRpnJ98PCOrnTMcyMhef874sehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7169.eurprd04.prod.outlook.com (2603:10a6:208:19a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 02:05:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 02:05:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/2] add the id argument for set_flags
Date: Tue, 25 Jan 2022 10:05:39 +0800
Message-ID: <cover.1643076075.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b246dd-50df-485b-5cd6-08d9dfa72e66
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB716949E60A51AC14A6B89C04F85F9@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KvV7khYHcilm5QK+0cAoFXT4AbYiBO4YynSMLVFhjnv+2jX4K9A7ogCozNYlspxAIKU5NSk15Rh5tQFp6krgKvORV/zG+F3ZW+17+iTEH5GSHDC3Rqq/k6Ue77wQWl4EYXm2mpDoU99PckdrrpuMHOlQwQoC5pKNufn9kPu4H0n1FokGmVmtflz8XLhTWWranOZaSSwrd2MuD+YaEfltQn+xPkk3JqQzTYwEf+A4SaA7oxCkOW8aPs0Vmxfdik5l8irfzhQDPS4nmgX42BKqRk83vDdbJVCeW7Ww4i6zWDT6d3duOni1zjgeoPa2v4zlMmNMezu3+jZ74W777yR6jRWAst8yAQ1hEqcoX8eo/x4JJJSQDu8MJqwHlQ+EyQV3n5GxrwfRRVrnl4VcMJ4692xGpUpIse3BbH+0Z+HWV0vEcetBO6ZrSyHVE3pIC9XwvmLeYRfA2k+7SIIiXpHkcy8fePlnGwou0vV3u7WIdkX00u7jc/td/75D6hsHkxTucBZUJ74LxAat4YV2QDJEUPhpAmYZOm5U3cXEf1Mt6p3dOWm2knDy6kM4X5UJehrU0pbPc1szep4zMp5RCRV5/RuiXB4vdWA8J3uXJOIxhLvVRB0VZx0XUlgkq3PnyRmzypa618+mGJVDDRxKrB5lag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(8936002)(6916009)(316002)(508600001)(66946007)(86362001)(5660300002)(6512007)(4744005)(38100700002)(66476007)(66556008)(6506007)(186003)(44832011)(2906002)(26005)(83380400001)(6486002)(55236004)(107886003)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXMwdGBtLZm5iaYpByL+pcYBYsVkwNekGApF6KayTk0x+h3ruF+R8VwaKpxh?=
 =?us-ascii?Q?CfOBlzyuTq4D5bVa8r2DTxy7JxqrByVf2W+xSS/PWOjoSD1LHzzsZZqg0SCj?=
 =?us-ascii?Q?fGoirExG4qaBlkuHidxQhLllADCksYzfq8VPXMQ1UjVj2Lx5w4aXWglZEYsJ?=
 =?us-ascii?Q?2GT0wRuI6Zkb21GtMH74z7zGIStQtBYcGn7n7ULa8v52kZ5XCbbv38Dps1tU?=
 =?us-ascii?Q?0HkLhLRtyRDRHCE/rQtw0gW+dsIFFjxl70uygWoghG9KXf2qR1Q01QeNJ9Gd?=
 =?us-ascii?Q?aFngsM1TN+T+FjNff54xCcuuskum0NZfDyNx529ZQmUFVsOoX2dQLAFfYd30?=
 =?us-ascii?Q?Puh6siAa3ACS+lb7tVWjLQTuTdqopaYB1Uaqp9yA3J6aF7beK+xzg762PcLM?=
 =?us-ascii?Q?/RCXpQHN56LNS5ymWTggi0/EkxiFLr+pt9BzOhPZyJNDavCddMDKdDNr9Lmz?=
 =?us-ascii?Q?zcUoSfQWiqUuzwUObgTOKw2wkeMgdteN5X3u9obuhzB6hdY1orWxg3DEq+Mz?=
 =?us-ascii?Q?Uy2DkOdVbBfe8wBS3J4PbNDi92GLxY7kZzfET/f6atBIQxG5jhjtcNXl0Hem?=
 =?us-ascii?Q?XFtmvWSZK5UPkw7jw2Uo42H/k/5kWIXP+sgq6SFmYYmVIj0rKbXQJ2R+uJhA?=
 =?us-ascii?Q?Myk+WgUBY6gEkMaBDKmOzs88hRJ/umNK/R/iSe5g7vvrwK9HZM6/N6BuUxrx?=
 =?us-ascii?Q?brOFxxBULzAPpVHIGF4G7naU4jPI083HrznxXVC+ey4e2YB05C566MWcl//G?=
 =?us-ascii?Q?tPpvRrj3uBK2UTGf6jho2Mdg3aSrFhMZMQo4npABJCgqbx/jWzEjz8TT5q5I?=
 =?us-ascii?Q?4VOnKUBl5+ti6RNOH9xe+tSbi9tWrQ5U0Chle9yB/x3RFY+oEhYIHlSYsbb1?=
 =?us-ascii?Q?hBVZMEkjmSx/kbtNyRdeBtk/BF8G4y6qx5cDm2sO1AK3niWJnW84q6PXcEqJ?=
 =?us-ascii?Q?5WQutUM156uCAKg3rYRunFdDsIQ0aaNq5SLJoUnZdR5hLYyuMY17w/R+BdDp?=
 =?us-ascii?Q?OxdqpOfmcEsIRGboTgfSZ59s0KfCDGZCPxvkxnYCCN6cpvroO+WwND1Z+a4e?=
 =?us-ascii?Q?x28GTUcWWrBtk59evkx8+tv2/EdyZ6WzSNQAZPptkVJ1jbrjWENlw2QsmEa5?=
 =?us-ascii?Q?on9dV6jjVRDiaONvVwJMhv6fWhCmQ3cbYAvrzeW3SnG7YeXre8fPdakdyv88?=
 =?us-ascii?Q?o4gLnx1of4Ch5B/Bwa9Qc7+DguBxta//PV4O834wO4p4w+/F8rl4yB738pKb?=
 =?us-ascii?Q?p0BNAPTxb46sBKZi/xnv8NZBoHlCdF4IdmkJE4hPzky91ObQ1tNg/QfEyD0G?=
 =?us-ascii?Q?ScSK1gnjO/6uJkpbjsJ4YcYsdWXyABV0xNsmgg+zbcbo//3vqlr6RyNqJT72?=
 =?us-ascii?Q?oUIyQ+XAakYAZzptIbyZmtsBjLVrgLDZN1dJWMOKddOn0XrPEcpvRcgKrcxH?=
 =?us-ascii?Q?ppVl6z+e4nUDp9AVPHZca3ccG39jvWLvLQjaje3p4AMxSjjQEnojyj0pa/HA?=
 =?us-ascii?Q?0M5BMuVsOx85zgXmLU8RHPPYwdQl8vV/FB/OR5yNYgjZ8/aNKQSdJmOU64oM?=
 =?us-ascii?Q?nslAIe6S6QNUcd5g6odxiQGoZeOVI2Er2VLLjzH28wMBl5pVlWLMRXwd44AK?=
 =?us-ascii?Q?nMPJr1s+Lb8rgag2C4Z8bbw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b246dd-50df-485b-5cd6-08d9dfa72e66
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 02:05:38.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktMncLXWIE/1/Y9sR1OWYoAVJhY5cFfecfsWuoRYKSaaQMj6Fh31gngQAN4GyBHeY8SyGPfUxzvdfu0EqBS64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169

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

