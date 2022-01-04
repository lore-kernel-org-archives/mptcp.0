Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28D168
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 09:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641290308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BG1S5s2hmqgrcZd+aAqawcnQT5qYqd14SMFjfOgwcb4=;
	b=FFFlnzS0JyxIkfPHooM/BvgmIkzAcrnTkRpGwFGWxP1UtlLrYmV7LRGQK2JqcGlDGZdWDz
	RV76MZWZv07P4+coZ9JKgGUAHVXg6VGs7KN6kzuoo94/dJTdQjR+W8atpjfczojiaA263f
	faDYvGRUgdf4ZE/KFqKDKRxJNQwH5GI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-vD8aMSHBNC2xnnKoo48LxA-1; Tue, 04 Jan 2022 10:58:27 +0100
X-MC-Unique: vD8aMSHBNC2xnnKoo48LxA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI7Qdn8EFKQlr/Nb2staTo6U2s6wuk7Sd5Jo+UpOfTiInyfkXJXvL7IFdJC69KjphjCbIbTUwMk3rITIAf0QV4nCkvif5+/naht6/ZC8Ci88pKN1cosPFCPmkzoJl1UevoTOD2XYf+3uFeWSDLY4AxJbdU0BnRWC2HH0+w3kEKvHZc+4xl27EfAABhkREP6pyGGNRe+3hIj6k2Eu+db9A9n0goq5t7Q70EzxKmin1hh2PF3xwS0mJfnNEFyxcfvMUnAPHu6X2LVdEct+QzkhzrvlSTchULZE0lkgDABzIHXhljQXXCvlp13aXIBfHoOzGb05o1PpmoleGAce4ZlpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6gjIX/NIedK64zbJlqRJQReHpiDtzjBk9rcAt3jRjg=;
 b=EkaTduvhxYEdQpftj3EV64DaNo6JRUV166D5t9d+mkOd3cLoaoz6WSG8EzfuAa/lW1lhsD5DFd9ZGQLsFVinv02sFMdXLf59snTBKM2mWScjYZ8qoGERfozcIBKGV+vMzl4ljfDIK1dmRsws/pER500zNeLVr4OLKFfSUXbDQr5ynthYN9pAJ2qRuleo0bzeL0eHc3TQ/FrHelT2M4bSBb5hwclH49PxfNqWKNsjpenA1mIPrKSRVLuZTC21Lnbc+rPC08lDv+D2gmf7il8p6ZVGar/0KXdQ4QEiEqRptddGoum0q2yHvBhShq5GpdxlrWP0XaUOVKAOTAhgHuR2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2428.eurprd04.prod.outlook.com (2603:10a6:3:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:58:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:58:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH iproute2-next 0/3] more patches from pm_nl_ctl
Date: Tue,  4 Jan 2022 17:58:15 +0800
Message-ID: <cover.1641289518.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: 738eabd8-e442-4252-f50d-08d9cf68bfd4
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2428:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB242885D5A31CB8A6F832A9B1F84A9@HE1PR0401MB2428.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PCUM7B17w6UYF4cRs2ihrAcTc8njxQmcUWX4hxqXCNCPmRCaraVFxr7reQ+W8muMdBABzKyKtPL1qdyEuYRNFEmDB4ni/n3CaEeq/+6TPJACItKwia+up4RmN4zAXfGD+NNk6baIwdyffqBh+qmlg6yQLMgehv9jmPF6AHhsAsKWNEkWGnsrv+ESTVmHPrjJdRX3FCj/DstXU87nXU13pmiX/9DYLPhsvW5x0xYoUDM9lXDfPmk+GTzXOxHgjgLU//jfn/zFqQDGiL3O1wnFoNt/EmzSJx6p97i281stqbL/m1P1awz6VxYCp4F+OTLG5wAIdocTlAEGcmA9sIA/7SHT9jwX4mogpwVuFlB6UdH+3PgoDHO0AWLhtMVCNaPGh6b4F0KmMjBQ9gejacazUfspSmumr20IWoqsHM4c/rPnAbJHrs8uZrwNdtCWZTp/wEdsTYqpGS62l2L/hnd7TUqCSlF2StJGaRAAtJb5DDq0sw6LFI4pTLh0cXv/1fDEU18Dy8bKcN9C1xUJQ4edoENVgjPBRX/ru5abfrDWWmiN4Y0RH6jP9CkTU2B/Skq0kqroSZoHNe0FGwQYl6AHSAV1RjdOvu683cjZaVk6vXR9DYYaqBhI1DARMlwLVqyxjISV7XkH0rR3Kvp0wHIkrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(107886003)(508600001)(6666004)(83380400001)(186003)(8936002)(55236004)(26005)(6916009)(8676002)(5660300002)(4744005)(36756003)(2616005)(6506007)(44832011)(2906002)(6512007)(38100700002)(4326008)(316002)(66556008)(66476007)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AkhXLdEM4+1wt8esGclZGdapdBTUaT9thJ06AXeCSyxculnz3ItDL5vYkWGu?=
 =?us-ascii?Q?7VOIbEfks8FVYpaY8Gj46qraC6wYH/6EAf6Qjt73r8Pah8J6fKx7oCwuZX9u?=
 =?us-ascii?Q?DdIWmr82usf2ZhGP14Hti6t/FL9elJxJBgvpXOkCCg2DfSPHEq8teao0aNrs?=
 =?us-ascii?Q?xBjmKLpwcmm9kdHMQfUEMBYFLFDlFAzqI8H2aUpbvBJHbFQHDYK4eU740C4+?=
 =?us-ascii?Q?5iXSY7PRenoqZT4F1XAgbFpoyMXtL4zxAxIhKewCakaptqdq4udewIpUINu0?=
 =?us-ascii?Q?ak++Km9Pt75gtgwttvFLSOptBkguwMl50yaDm30inVWwNwY4vssrEmkepRx3?=
 =?us-ascii?Q?f11z/A57ko0e4+WfUD8agxHuxfyFqcZw9iEdNcxV3yamKcndHJg2ps/d3mxI?=
 =?us-ascii?Q?k55uK1GeWr4d9B26he5QD3Phz13Vp0hXH+cFH9HDkbdHitCC+eDm+pCN1rtE?=
 =?us-ascii?Q?1s+ROu9q+tHBDI2ePQNwX6v+9qL576qQ4VLUjCfGWz7bYozYXsM1/JvLZRCZ?=
 =?us-ascii?Q?O+y5utlBFG64UKXgc9xMRNbW0xG6Rg/45+O2pXTaM+EWqQRY5CLnoAaX7dR0?=
 =?us-ascii?Q?DNS4QkMre9z8Ed8mpzFg3fEESJCVmbzukn2c9+p9flzAuxjDtAn+EULxB6PW?=
 =?us-ascii?Q?H+bh/76O3wNhrwTNC8gTFazAOfneK//axIk7uZU6o0z30Fkz8QngYOc9iPAF?=
 =?us-ascii?Q?tPC5cM872VOl2bW8V2puDLNRucQGynxHSsvoq/3DsTIr4p4qgFv4nncRtRAe?=
 =?us-ascii?Q?R6HvyUxCcju7QGm4dxezeyv/h8EbyN2WrdzCn3sIoeXzj7SvhZF23doeP7Yl?=
 =?us-ascii?Q?wHbyZ1P1EjxlGBkJ5cdFZHNCqXrwvnwjDPgfMSjdyu1IALTI4Cp7fEGTsPRn?=
 =?us-ascii?Q?2tsmzEMGZQ2G6cB0zNtRqquj2iAuJrJpRtAjberA1NxlK4rBtXU6NJbvqDCu?=
 =?us-ascii?Q?s2OTZu/9Dm2B4dzRJ1VoO7JUZcc/KKlVzfuLraLshWNkWg/ag9xlGWtKsIvG?=
 =?us-ascii?Q?UFlovtSB13JwUtY1GTXHYe0kCsPEceQuIdvpFM+24cxdXgzKEVSdVJBAJw6S?=
 =?us-ascii?Q?E6bRwzj6UztR/7eejZlRj3+J2hW3T/PV1ewAa+70V2HK1bd/GfsTHSTfaMpo?=
 =?us-ascii?Q?M4XO1xVFn5HDYXPakr4E4jlyMs83Lq+P6ppEkfZ8tUM8YomitKpcLAKASSDG?=
 =?us-ascii?Q?ibZDjIpOrO8SNBioqlN5gBRg3sB1cBSK44Zf0FGxsh09fJe8tyhpNoK5pI6e?=
 =?us-ascii?Q?1yxtJ6jBeIG/7R8lNjaOKLZscRLeTKpncJrwUOgB3NU8FQAkYiyHF/m8XzJq?=
 =?us-ascii?Q?a9TkQUHywk4wCeW5T01CI+3k0Lapt+HNwPKR1FdZXUroD4bSAJei2T9vzKs0?=
 =?us-ascii?Q?eWpU+MvQqGBncHxayfgGskHdmWlI5XHTsu/Js+phv7g7Vp6pqWmCfQWFOLyW?=
 =?us-ascii?Q?SRoIp4y3FL19XROJtwUrEVydpfu7x3jDDmoQKTT0kyz/UU5bnY/aqBEbwXU8?=
 =?us-ascii?Q?ehxEm7vrSNJo0c79Bwthxu6KUSWEZTg09yAZplSZhpXHuhh8gMe9ca2mvs+H?=
 =?us-ascii?Q?Uuel9VoMWZWqqZlxb8sr/4VA23ASlPmxwlrPNz8qd4DdShDSgMQV5fCiNCC4?=
 =?us-ascii?Q?9UT7VjW32ok6nRwcsAawyrA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738eabd8-e442-4252-f50d-08d9cf68bfd4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 09:58:25.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWXFztWTAN/kgXdID1zdBgbRRO18LD/UF74XXcJ4B0tgWXYl8XGcBom4051GPurIPzPgoKvPYP2R8oaPkFa+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2428

This patched added id 0 address deleting, fullmesh flag and backup setting
from pm_nl_ctl. With these patches, we can replace all pm_nl_ctl in the
selftests with 'ip mptcp' command.

Geliang Tang (3):
  mptcp: add id check for deleting address
  mptcp: add the addr flag fullmesh
  mptcp: add the backup flag setting

 include/uapi/linux/mptcp.h |  2 ++
 ip/ipmptcp.c               | 31 +++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

--=20
2.31.1

