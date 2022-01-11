Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429372C80
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641868973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eYnu7IRZaLp0pQjTYuHPhQS/bRuSS1+NVs3BGLXIe0Q=;
	b=Mmdihzp9UDArFvdSp+Jt4nJWIb21CmnnBwcDULHA/d+p0zBMcVqIXoV9Qkh6ogoGQfztDw
	QzwRnauG6AYgurmwYvvHI/nbkgcVcFta/5GqSWItDOIlkOT9umjHTi8ThamkXUbd6hAqRk
	NooHSSjGirKF1TDVZA8+FLkZbOby02o=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-UKi06vPGNW66Bx_KCujQhQ-1; Tue, 11 Jan 2022 03:42:52 +0100
X-MC-Unique: UKi06vPGNW66Bx_KCujQhQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8cpCYkHX0VfP5q/pTsWghDMM2Ddo3hgVQcD61/CnsOcPvMwa33/TyK6onhElNvxh54H7rBpAQdWudiYMa9dtpjrBEyM80/Gu+/Fbvi1N9Rh1oMFMkNQLBZa55tSfFPO4Hb5dMUzcAQJcGMmfH7+d7xbLgcctmMIK38eg46ME6RHvQUwsU75awM8Sx6huUBl7tRUqQIi+YEpDeL/H0Uz4hjKLmQEjl5Vd2lBfBpczMqz4ASB3yhagBf85y0l570BTLpjKNmHrGWJdQP93YmFwN2wWC7lGVU8js9HaVtC/FoQMIwp2CxlBT9lCFNuzNyA/m2uDZ7J4xLeChF6e4mqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAFHQMSj5EotG5sZQjbx4CslEpoHH2KZ/KE+GC8LWhM=;
 b=gLK4WO53JSZu9rvYjbFr2DrGWwjIhAVTSr6jiwV6WxFWWggS9yoie9XUw6zjapJRjNHORWFZcBLZvJjbPH/xZV0MtcwCUhr1lYQxF/7qMFxIs7P0+aqr3fncKXFWYDyze9pC0Zdv5OpIrfBikhkaaKKXZca3r4kG55i7HOTTWR3T1ZD+Bv3O0DuOWclG4URAIhzEMrECogA3hWrkHlp2XcuzIpCUtsbebuo+LoxvoBhjbYMTr+6Ql11wWLaUP3ah+Lmbxjqd44l9TIbWRaWRBCeFqP2vrMrXtXzVsrPIUxTHRr/fB1cYN0zIItbuwWEUchbMgNBCEbNn/XNyLhY+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3435.eurprd04.prod.outlook.com (2603:10a6:7:8a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 02:42:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 02:42:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/3] fullmesh flag setting support
Date: Tue, 11 Jan 2022 10:42:44 +0800
Message-ID: <cover.1641868545.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6724177a-1b5a-4dd4-429b-08d9d4ac0f37
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3435:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34353E23CE9EF54B3F289D30F8519@HE1PR0402MB3435.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sk9BGpkvqDwmkhWpTNzx3gHQexYbHiucMPpeLX0384ZYRF07JHMD8NQQavQWAdY2LnMZjpzYpGtbPVEtf2XilVayBmX/SPtuy7CxH88T6nPWNGt7IMSp+HW1aWR06f5UAnwfE4z9EhZHmd0TQyrUGPF5AF54B1OdjdB+FFrCgg0vfJAnQxDO1/R6BSaw5Dfj72aUKrJ8sI4JzEhYs15Z4Hg4N9ifkwgTGg70a6V0SVul6cym7FtKByuahPKf5s6TTvxUl09tTDJ6O3dLRJ6KXzStdXnqTFT+kx02ODAhfRAgWglWKSPF6Vxd/wEYYD34rHdSodBL7lUe6A5LpUR06gMiB7o/RBH4Ds/QJuabJ6JFx+WhCnMPQqh/twPT0JSxDWQaABJ7nn23MkGIVmBC0g8DkukkAanjHzoJerasAnkow0R9qvjmLTUcrJnvEY2o6KcSQFIGEiZxQbj1gJXpdmC/z7BvEb9y4WX1r1tG51E3+2xUYt/ruTuj+4cd7XQCQR/Kr3X0QCZ/ex0Nv6vJZsgXb5X0HKsbBqlq+V15BBvlWzmegGPJj1XOVGEtfTnVcyQ+/JsETFFBrh7mglELtH82961OayvDiVPEWrCcs8DKRChBdJuREt9v6s3aDQmeE8wUyeCbOvr2s6mu5FgnUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(2616005)(8936002)(6512007)(6506007)(508600001)(8676002)(86362001)(107886003)(38100700002)(2906002)(316002)(83380400001)(6916009)(44832011)(4744005)(66556008)(66946007)(5660300002)(4326008)(66476007)(6486002)(6666004)(186003)(26005)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0m1O1c9RTO6NIkx+68QPyn62nOa3TiOo1tv0xzsXyeGmAiugIQtLrk5kBpn?=
 =?us-ascii?Q?ALhQdEbupmXyre4O26A6DP19B34pXUpTnZMlDmrANkCHn0dun9PNGkxZGz6s?=
 =?us-ascii?Q?7hjdd7Nu6mZW5xV/MWJKEgE1iZi+y8WrpK7R7+K7w91sh4t8nUJyt+RZ22By?=
 =?us-ascii?Q?M7d9S4S3pTezvwXElpYnNE83thE3XSXr9+Lcl6rPiiOPHoIH7DJvtSkpM/zq?=
 =?us-ascii?Q?+8wLV4zL+vsbACMSYXMKfwSOZIZjlQvIddh8D82uJcumjTcHpAoHRlTvTKiy?=
 =?us-ascii?Q?AnEhfM9mSWjXgVOwiFec/31nn8/om+Nh6gXePDUJS02a5K78q81F8jVcmSJd?=
 =?us-ascii?Q?maHLdH1te4dk/vFmaWTX8Qdx/qJQNTIjpLeICHnhmiY89AKmYaFe1RZQ3Qqz?=
 =?us-ascii?Q?ZItHVDDTCneFs5KSb+6DOyKffxWdf7bfGaJCUF323IUwHfZtJZWFeqHtVv6h?=
 =?us-ascii?Q?SdzBivLrkyZR10H5SLJv7tjHDgaeNk7L+EE4UlFnz1y9vPWPU42UnGlxWPIv?=
 =?us-ascii?Q?Y4/heol6l6ASy4ernOcDup92jWASR3rWdZ4VvK6Nl1wljikDAjw2iOO+u3QC?=
 =?us-ascii?Q?BMnfsUVpKVDM8nTjq+MBtNlIMHcnQFlbF723YUPdLvzzdYQKYlQC6dG48L6e?=
 =?us-ascii?Q?elt3Jyci0l5rViYphZI1+esmtUqfTfo+FXkD3De0z2rFHf0JUMj6I4SaDFvN?=
 =?us-ascii?Q?1uOPsEHZaPR2Xh8MVc3im4QVmdW1brEq/tgxYQecwOyzpotiYxpQGTNgWNNU?=
 =?us-ascii?Q?BPFYTfzy3qFb5lNyazK4+ZXZNzKnBaQloe0sxC25X0J6o42UJvEISCnR0ztw?=
 =?us-ascii?Q?+p4f/qO36mJGJp61tQizN4QJw5B3eIBOOhDQmWoJ7wsemejgnu6ZcRzQeLKb?=
 =?us-ascii?Q?UGdfvkcp50+mziazCYQlV6Tax+w9pmXZrFvgeespNj8bPpGd9QH0+Do7MHqb?=
 =?us-ascii?Q?dGneDGHFkv8fXnCSjDObzsqBeg+0Wy55AcDyntNSXyjbDdcJGJiVyrtt8O/W?=
 =?us-ascii?Q?1LoK9aY/6dNPTTacNUtN6VyAZBQke2noSG0nQaOPIm9J5TBF7JC3fhO5aGOE?=
 =?us-ascii?Q?1vpqffsgJMW/oGbcWyC/bVOvVXfmcsUzBvzW0OLiWNJvY4wkSwRxwi5DuGo8?=
 =?us-ascii?Q?oFWN/KXmZn+JkzRntPWDhZLoKec/r4pr/tw81HLVV6S59orOZcf7sNAekLqb?=
 =?us-ascii?Q?N1E7BfiP6xcgRkXMbw0vBODuM+PXzy5bBxPrldNaKP+e/RHpz7TlPiLdR1Da?=
 =?us-ascii?Q?T0969h8EhGNORPn4h46kPekgfhtiC8rAucCKqyu7XU7o2hlcaFV5+qNei4aT?=
 =?us-ascii?Q?FWnxHrTyST73mmoFRio6GInEuk6xlb3cEw3DSy381nbq0w+ncT8u3uEgqzBJ?=
 =?us-ascii?Q?lJyoCfcq8crNzlXpbY8+kPKyUMadKjjQUugL3gOKTojY5ZKOkzOZAGL5vdM3?=
 =?us-ascii?Q?pbj2esgOprfxsRx8xqSMeMhmHOgYEiN3VNX+PKFGROXSZc0FeCzv06uOOcC2?=
 =?us-ascii?Q?K9u/lAHK1ZCP9JLSijBIqvu5TNl70ZueKzecLyfNGqHwVTMjTSBaMIjoMwui?=
 =?us-ascii?Q?T62X6RbQW57vKDTsKmGsarTBZfF0bJ1y+M1C1J0E/dLY84MCHai/LQBOzfIL?=
 =?us-ascii?Q?vqUEpKmJqvclDcvjB6cCtKg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6724177a-1b5a-4dd4-429b-08d9d4ac0f37
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 02:42:50.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSjsQyb703YdMSkiPEvC676q5Os9yWFfdZ3FVt3HCvip0ur2pZ2rva12/DxKkcDscDzxl/BwAY2IzgX2F9E8TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3435

v2:
 - add MPTCP_PM_ADDR_FLAG_NOFULLMESH instead of MPTCP_PM_CMD_CLEAR_FLAGS

Added the fullmesh flag setting support:
 # pm_nl_ctl set 10.0.1.1 flags fullmesh
 # pm_nl_ctl set 10.0.1.1 flags nofullmesh

Geliang Tang (3):
  mptcp: set fullmesh flag in pm_netlink
  selftests: mptcp: set fullmesh flag in pm_nl_ctl
  selftests: mptcp: add fullmesh setting tests

 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/pm_netlink.c                        | 27 +++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  6 +++-
 4 files changed, 49 insertions(+), 13 deletions(-)

--=20
2.31.1

