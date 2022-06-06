Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DA23BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DICXqp7jaylwAxaEQrQO4N8Hoy8v7WcbY/BGP/+0Jhc=;
	b=iVC8/6aZa2MpQjVdserUfDXyDkeUzwYT3l6461+NXSJNp2neUzrKLgDZKhSQujpCKVsuBY
	uBTMAmbQgtCNyJKArO3BUuHJgRnW1UiKXLFYrOzNt04m0ud5gNBbr1LMcmuHztOl8UqxH3
	gEJZ5KKHOLZkMAftRmaFiOXr48h2dwg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-vpvowXcnMCK6nApQgZOjcw-1; Mon, 06 Jun 2022 11:37:52 +0200
X-MC-Unique: vpvowXcnMCK6nApQgZOjcw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkWm37NJfyWF4kej7JB4gR19M/l5gVSe4I0OKrk50Mh9liSp3dwe6J7qw/XHCkFlkhtC5bDvesncUhcpwlAaG15C4Yf5XvFASTS8NBRlqJja/NT9JPeYIOVYdIeqXWxqS3zsENQ7Q0d/eFmJTB8lB8GUORZ9YlzJ5IbQO4v5kgjNuncYzBHs+Y0jeKNsKlvqtSItmIuX+iaZk79yA2gY+XawfxvjTAq1oYiMUjRWSyj/XDBfzeHqRE8F0FKXbffD+HzyM2r8MOTOr8C2Qpzio80LHHBRQnCe1caMPiXfl+Hdp6BoAGz4hRpMBnzKrOO4GoZCvT4Vk4EKzI55ASpvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oACFN5ZZHi98Lqsk/wEpZxG19qemf2J0zyHheeU7c1s=;
 b=VeZ4nkU1r1Oy3/7Oe0PubazX+R8J0JWqN5bLZ6qKGdUTCt657sur/WibN2rofjhWwvdlhOxFP6KGiHwzqa38wRmInmLV910o2CRlvhRT3reynu9DbkHsmSs0sjhfGotT5TdJWD/yYp3BJrvSPiKebHpC5qNCrfdhIaIjVm8bGKonl3N20bIaqrPFijKPc42zx28nKOEfrM/1obIM3FdxXMVUw73v6STrVZMzW4r5Uxy75vxz/CKtOhymodSg5ku+YmicRf9KXfFwkPAzWvAMHflZAQ5HSH1dq9S5I94YpPMT1wckjVjAtnKDBTYulKMVFQa9Uemq5cmHJLw8CZj0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:37:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:37:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/3] cleanups for bpf sched selftests
Date: Mon,  6 Jun 2022 17:37:27 +0800
Message-ID: <cover.1654507832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 136e0753-0f12-4fc7-2bb7-08da47a03910
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB47518EF3C1A8D4F39390B668F8A29@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZgCMH6ZiYs6iISeO/3D/Rd1deMnmTXCJ7Pd3M3nC9Q5Qjx6SQ9E5Ab1O0Kx0ZKiJeikkPB78F1w0ElOcwKdffupAj6Z7pcXCODq7ffe8TjHSJ0CkdWCaBqb5j80Ap2R3G2K70PfGR/74pTbw4yPM9RnKZT8zPRqxIY4cF3c0leCcTqNmRlA0FJys4DmqckNzQ1Gea5gmk7C9M/8LNWYQtNxMPpKXsEz2NwgtyZZUXESe30k1bgD+fe6kkmsW+8kJpP39YvsziQ/l5LkHcEOZLZgwPJASJlHtqN84paOd1hpZ+RyQIh4lA/T+zARW/Th0kBCxFv/O8esIvZ/VzimSlGZzlE+T6mIATBo13WH1CiTlQw1R9/RvHj9sNUT3XkgHGFMur4aqs+J7I+6pS/JNEhPt3GSaq9whrBPzFbViXWgz0QuKHMm6VwVB6x+kOzJiN3ABe+OSAkQuDxaXBlQhRWnyAOqRZkaPbgGyN9Fj6JL0Fe9BohXykV7w23wjcttU3x58+nMGH8HgLoDZoGaorE8HfWrRyYr2pq9PFko+yxNk3Nh0rarV/AGj6FtE61bv6ZcEwumik+Ag7g359ZzsLVGOaZY2qJILHEuSefckPhxMvzy+xgNnEOfnogGXPdcQns3effmD4B43SzV6aSw458oX97WZ3IQeTcY7aSl25cO72xMkk30Sx35VYKBHew0C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(4326008)(8936002)(8676002)(5660300002)(36756003)(66476007)(66556008)(66946007)(2906002)(44832011)(316002)(6666004)(86362001)(83380400001)(6486002)(508600001)(38100700002)(6512007)(6506007)(26005)(107886003)(186003)(2616005)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DqRaN5dqqXrJklQQcIaTG5JcmqJDhAclcUSsuw2JOgwPCfSRuSkgvQxIVlmj?=
 =?us-ascii?Q?uyu6ikJO2SHtBtagqWsBdjVbqMFbweLhKJ7IGyAifqnHoyUH/uC7Po+vLQFP?=
 =?us-ascii?Q?AKjkOJM9eSbWpDp1wQakWwXIUC6+u3U2xahwektp2Cr/MgNEqEV69HHXmG8D?=
 =?us-ascii?Q?iktyZT9rIOeNH0Ompvz/EyOK5GEypWhjn0uoETGcZNlxHODvYmlPQaTe4cK9?=
 =?us-ascii?Q?pBh1hnCmtKmEwkByKUb2/WerBwBHaXWwxKD65CFZYe+Rz4eHtgPliWj7yYhJ?=
 =?us-ascii?Q?CYk2ZRHumhBRUOiXZnzSQlh+V/IYcdKX73ePf5aONiWLDhkQEf4BY6WHkIyw?=
 =?us-ascii?Q?QNRJQ/C0LzzuSvpIaY/5QolHsPXyFlXc6iyzdbBH7sSemDZRcgC7b1pv4DaM?=
 =?us-ascii?Q?QOV107IyyAYZGrPLWqTFS5OS0w5xe0XDpQwbttwJ5od3xuEvoDqmjqAQqCqp?=
 =?us-ascii?Q?sE/IVOqYb4NVzqCMgt3rtHniCfvLBkbFpdNDmYIaJFCl6TYBLS8aRoaIzmd6?=
 =?us-ascii?Q?OoURYjXz1SeFGhEufRSaWdxecG1Fr51SEr3bHtIgkYosx8GouQNfis1P+4yM?=
 =?us-ascii?Q?TDip134JsVIYatgkPr4y781CqJ2AE79O0Lad0985MTVh+HYYZ3H63AVesBQ7?=
 =?us-ascii?Q?A+HFZOHbamjNGv/WBPcQKGudXdfliJ5ZjXMqw/UjoXWORGB2vbG6lIGNFV8Z?=
 =?us-ascii?Q?h3gmxCltgGmD+JGKMs51VX4TbeuO807vpkFB78JDivmJspsZejPiCaQ54127?=
 =?us-ascii?Q?PSfuV0k57PXxG7aJQaFW1k/NKQC5iDLk4m2J8nqS9KMgeax4WO8mFRV32da0?=
 =?us-ascii?Q?fANd2sNZTmxX5fg6obc1Vz7/dMoy4fGWLFUeciivKX8iDrW/A8sGVPXXttaX?=
 =?us-ascii?Q?Ng7pOOQ0xC23fzwduUQrbQ/naXChhela1ezm76r/d/6meTTtZdBR2Xp2bS7u?=
 =?us-ascii?Q?iHB7sD+gWdHh22P08UdGUqc3PJoqpKt0hzB6qnNB5Jl9xZShZKAmRvMgTchX?=
 =?us-ascii?Q?/rfqPqijM38Vn3Jts70Rxnhd1rrZ+1heTTXEZKhvP4GCQODO/c5pmd58FC+e?=
 =?us-ascii?Q?4FsIzBDFV6DnGDZ+H4uEsVIj6OALDtnRbNAgAxKwsAt+pfhHwDTmxKd2/K42?=
 =?us-ascii?Q?4MtOUcScnVFLTnlV8u/4J4oTUMIV29f+sJRxT17+9qPKN7c1OFixqhTJkkQB?=
 =?us-ascii?Q?CztKC4X3zI8FYumcKjvf+91nN0hSsCBrltG2YDZW13oSJVdXTn6uDdPBrejd?=
 =?us-ascii?Q?mVmyYRhxcjZPzt9bGeIjaMTa8Du5eIkDoOhjpvzGYVWy2vIcDTSNfA2V5XLx?=
 =?us-ascii?Q?dYRMHQrsYlUOza1CPqhDlKCmutGvWpzvT+4hqJTpYrJvipMam/RUutTt3WPL?=
 =?us-ascii?Q?vm8VEaAQA/wx0aQTfeBeZsWHvGXLgPicO1VaQgW1LsKtre+TPrNMRGJvjvom?=
 =?us-ascii?Q?ySNKXkik0yz6lqOelYg/X/WYTXxouhwcjj0mD7WU8gxpq539KL3LyuwQPt65?=
 =?us-ascii?Q?Mn9fJriugv2SPHyUxjctBeNiCjGw7OfpootR6YnCHi+s5g3tGnVnczLs2Sbv?=
 =?us-ascii?Q?1MBa6DSbv69Et+jTjqMueZw9TOUvKafFaQRzv/OQzrkaWdtgrdaB1rqnLGEM?=
 =?us-ascii?Q?w08qMCtznAJC6LSt8FyZCf4Bua/U+xCz73aYA6XsRAvP2yIGkx2nlVmen4lm?=
 =?us-ascii?Q?NSHNnHqc9JmJXdzSaVZw89RRZrP/u0LCaaxtIlFUbQbXUuzqudFtLiyG6Bci?=
 =?us-ascii?Q?0dt2zdCzmi8VqRGSm7nHelxs9SnlRq4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136e0753-0f12-4fc7-2bb7-08da47a03910
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:37:50.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W83+55eAX+gY49cYy/ABE0/KGS/Cf1oCOHe4zf/8bYZEPWw3z7el+OaApj8uh1v0ZPeeRoZxym7ZhEyHKIl07A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751

do some cleanups for bpf sched selftests:
 - add one more veth net device.
 - use '10.0.1.1' to send data instead of use default '127.0.0.1'.
 - add a new helper has_bytes_sent().
 - update commit logs.

Geliang Tang (3):
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 63 ++++++++++++-------
 1 file changed, 41 insertions(+), 22 deletions(-)

--=20
2.34.1

