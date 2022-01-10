Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76862173
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Aox4Q1Cx+H1li8dcnmljfsEZ30aIFqgQHz9EjgOu7A=;
	b=HhUmhdxk6mnISxDl0q0DOS/BOJdtPFv4MC69pMBGAv4JOe/nc52PnNoob2lIwIJQiuYEpb
	tJUvVsNMZYCmKJeNG9S2wgzR9GeXATJJCqCd8rthmTKIVeZBRQ4B5AwlT26JzS4O81lIMn
	hcNXYVVYwg8o9LkGGUgzu2QVSs/j5Wc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-dQdy6IurPpO3_nL1IqinwA-1; Mon, 10 Jan 2022 04:30:16 +0100
X-MC-Unique: dQdy6IurPpO3_nL1IqinwA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqg+itnZTzHOHbDWmvEWrwiJcdnd2SwqNFhBZ/30ZvEPu055pDoK7dYX+IOu+6oMHsakQCmFQl/aZrojzRZquOF0Hablgc875pBhubAdshPzo8RQ16a2tQFG/pUX1bPxtocBOgeAGmNGjRYcRwnjqx9UeQo3e1biQnlcaO/WJDSeS4kszEarhoMOc0fdqJUo57IUfTPZY5bhv+QC9a41qk3R5LTONx4d5OtDxVkpWS9/fIE8TND6i8ioQctoxXbnFChhnxR1tI/mLwaDbn5ylgc1DkvkrBUQvgf9N7uO3+dOjJLIf32Y00vTMeIoFrQIQMGQJk/YUwn/A2X2rSuSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz9tVKrQPvmBtTiwl0UuxaiJitkv8dFdkAV2vK5NAeM=;
 b=OhIgdnOJ3cysd9ERMnMjuSsxDHHizS9XIzo+ljvLTDqbqZZ16DkUPe1aYXwUeHOWxtYSi/IhdicXkNLBstSE6mF0P40tb7Hn+PLPLY02uQWUpPfbVKGHsqn8dPDzz5X95KgHCGcV4mfmKI1IhvzTOoW57lBcCcFaGBzTNgHX2lu7y8WpPwz2YH7OIW5G+uTPCoJxbHV9lSr/Db14onEFqs921hU9gUt4dPuYbv/uC3RlOKQDCSRJUFXkBFZkUQiw40g7vaZq/NJrASReNpN60rufKpCL0Y++yfeMYZmJf5fnS7OtMiQhsJoWzmLFoiq59NUJusAfIQ84WnvjpS04rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:30:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:30:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/7] fullmesh flag setting support
Date: Mon, 10 Jan 2022 11:29:58 +0800
Message-ID: <cover.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4926ea37-b7cc-4a0b-dda9-08d9d3e98333
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB256920C39566189E981F3932F8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/tmUq93Q1pg7y26E4ijPHR+B1XDfNoiV9A/Vq4Cn5QnAVtfuCSxQv6Colqa0xp2GmNtGMPdd1P7IkWo0NhmvoSektwIWnuODY/g5oWI6hEXUlSk4w7Ebe6QYSgEpS1o64iOJ46H9JckOACSzwZKtg2josqHsThGft48J1hLrIDzG+HbZEdOLKudH2gZmLLPDCMbRCr33oAHO1/UU3s71kV1fLD0Vaun8VOu6KMLeiWGJqxOdACSJjx3ay1tALLXZxuvizhjhIO/msTKZVV6RQLWu0zRBHzMnXCvSnwPISQTqQ9LjNP2V9s/uxuZ5qeQI9QgMj8ionmYcXyOaMYtu9RiXoyebgkfEV+wmBre9K0hol1LojmRntIk8GPuRVkJRWX1knyJLJecvW1HhM3X5qexePb13soHK2FN4TMDr+7/n9qhrAvozef4ynmSdYqwrmARmmUrWtTajW/uCCCIs4vGttxhONcgXKAAFaMJKPbY39GUCNRW9v7ACAeMLnSf9PRNjE/rBCL67E8y6j5bJMaYjEgfEf6eQdthVjp8XPZZiMJNTYBcbhO5QN7fkCLtr0X32/8N6vWJ4muZLnhWMcClXZg+4EGgQHz5gFZXdqdL9AwWs3xD0MpzrcB2cL5kG405jIJJqvE55kI8tZ24G0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(83380400001)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(4744005)(55236004)(86362001)(186003)(6666004)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngkRKFSP+DrhuCSjkgdNU4NPMhelxTuQ6gQpDOCfdO1CZmB+XoZrwuezVo2P?=
 =?us-ascii?Q?wuohO7DytHodmo6VFln3gLFtBbbec3OImzIM4VkwaODrRKhYvcq62PNJe/9S?=
 =?us-ascii?Q?F/izRRo5370tGN1dTDxZNZ6Our2vZR8u10AiRvwSrYPSBSoYBv82E5RKFiGg?=
 =?us-ascii?Q?IgVCGYjtuCgM7yBLhcEnN5HdzvsrqpBjvx2E5yopack8klTUnkthGLsxu4Qn?=
 =?us-ascii?Q?nDZG5edtw3pFsd4OHAPF/BvjTrH27mx5QPUEvguiyFieS8XWg3laMD1gmEyX?=
 =?us-ascii?Q?yHgzBxW3hr8x461/pSMWOV7WfgG1mCIgpF5SAIQpxLEjswy6daRoRNZ11cy1?=
 =?us-ascii?Q?JHTsykbrKjh5n4+FPcmEENOmn5ZsPpPXmoOIrMuoyT/x1rGFNzMUug9uxovC?=
 =?us-ascii?Q?gQSONAoRIj9MrwhWS2oJEbZ4gxElLj95gv0Hh79nGp+LDPJ3Nb0uTeyIwJV6?=
 =?us-ascii?Q?V0ri0A0YWaZbpzdKeHTIpPcyIXVIrYdhkJUooywnjie87JCR5pA6WxU+pBxO?=
 =?us-ascii?Q?4BuVKX3m0Y/0eKsuN4Yjzpeab5u87FF5pSrX7rsTrNccLXd5xU91Rp5fz0X0?=
 =?us-ascii?Q?DJoUFVhfFN85goUWNpat3RdUgVYQX34Z+KEMarQnvaMzG0FFQnRzKiJRdQwR?=
 =?us-ascii?Q?g69i/Tmq3JfWbENxojiK2yaPcGnixZvTFIguSFaAjGKPaSufJ4HQSFGyfUDM?=
 =?us-ascii?Q?M0WAAkGNfIoPn/bGqRyg9YgvXHl7WmbIawqYSnprvJ0x8HxjMzMvqeXuS6+c?=
 =?us-ascii?Q?dZ6qbE73ZP/xQNR6CyLaifC/bGZrxU+UYokH/F2+vbw6mVNh8APLdnHgWbD0?=
 =?us-ascii?Q?Rg+F4dFzHfSO6isGPr1mVrZ7F5Bzk5HIDALqS51bPMMYAQQ36TwC1H9uWu45?=
 =?us-ascii?Q?Yeti+TcPOjTIbXeJegniNFBfvRTpOItOhOcaNL/ltZhl/olY3SAmMxkw+TB7?=
 =?us-ascii?Q?hLK2TQgz72MD+3ksb786CF703SXmf2A8RZGuy/mrBeTyrgutQ/S+lA+agXYP?=
 =?us-ascii?Q?rl6AvBw/wsEqThWG3nux2eaK3YqUOcLqnOlmMBDVbQHwur1kJwO6bGJJkRCU?=
 =?us-ascii?Q?kk2Z23Wq4ucnNsPgafkRMR7qiska7Iw93XxBjVzvSBXwi+KlHc3mDDhGV6RC?=
 =?us-ascii?Q?JRSONR14qo4YBy2jPbsBZ4bvJI8kYZN0apm3EE7nhUYfvWk3pCAfs1vX5Sx3?=
 =?us-ascii?Q?Sc1j8MQD5AAvzJhyzSjNHofU7CIbvg4kmvP6q2xG7vX3Af9Cw0UTp9gsEO/y?=
 =?us-ascii?Q?87iAa+DNkF/2mtSM+WzE/YXnNDfp3IfkSXvJJCG4afqlCYqIOwctiRkOthZk?=
 =?us-ascii?Q?ezQOaViobIEoae+XMqte1AGlfRjlP9CHD6gOiRYo2F9RYzBgTHaeDlAmd9Td?=
 =?us-ascii?Q?QRA6ess0F0ajGBrL/bBwODAE4wwucxgAtqJI2xrvddXQGLvC6yOCJjLp2785?=
 =?us-ascii?Q?HekFtot8ZXDtsjEYCeGdKvXwo7237odTEdois0KQqNYviMk+Dbh4iAZhJOEw?=
 =?us-ascii?Q?kEMCFsbLqvEilcIfhH/zAS3l02LrViTl7cZUdAPhDZ5avOeAa1KJnSVVn8q0?=
 =?us-ascii?Q?wvFta28ij1IFnozFSWnMU5mhrRcRYrrwfYsYcOlQZ9HYWkpqEICNzlnvuRTM?=
 =?us-ascii?Q?ZrHR2LwqfjI0uNSVJi+bsLw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4926ea37-b7cc-4a0b-dda9-08d9d3e98333
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:30:13.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPqoGHQ+KKyJ1gQgH29dnNe/xlZ1EVwQxKWimMNQdEXUVFIFbQeO06K59KZ0vd7YthgDbfuKPu+AjDs6cfoJ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

Added the fullmesh flag setting support:
 # pm_nl_ctl set 10.0.1.1 flags backup
 # pm_nl_ctl clear 10.0.1.1 flags backup
 # pm_nl_ctl set 10.0.1.1 flags fullmesh
 # pm_nl_ctl clear 10.0.1.1 flags fullmesh

Geliang Tang (7):
  mptcp: fix removing ids bitmap
  mptcp: add clear_flags in pm_netlink
  selftests: mptcp: add clear_flags in pm_nl_ctl
  selftests: mptcp: add clear_flags in mptcp_join.sh
  mptcp: set fullmesh flag in pm_netlink
  selftests: mptcp: set fullmesh flag in pm_nl_ctl
  selftests: mptcp: add fullmesh setting tests

 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/pm_netlink.c                        | 45 ++++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 42 ++++++++++++++---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 16 ++++---
 4 files changed, 82 insertions(+), 22 deletions(-)

--=20
2.31.1

