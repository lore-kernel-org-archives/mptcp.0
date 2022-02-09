Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D52F24
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644403377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NqDACVIiOchJivO1/yQKYNcpgyoVNoHO/ve1FIIK3JM=;
	b=Ygnags3bf45GWMt65KGJ5hdRLu9OzyLfhdgzv9WAtHTU1E8wHjpTkUDhf2F/s7Tvitu6Pa
	tmFVdQF/H38w0OeK6Ne2f7LgASV44vIa7qsX9jAT5y8l9iRHr/0ukQcPxmdc4NN4n1dngh
	4QawodQcmI//AVD0INlXj96ANJ8946Y=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-QbQ76JBDMCORDzDVYiK5VA-1; Wed, 09 Feb 2022 11:42:56 +0100
X-MC-Unique: QbQ76JBDMCORDzDVYiK5VA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpghPk1tMpm0pICkk9rqd4atBJugfMHqzy31jn64WrEW2Jh79daKNatHDf7X+ulc13wUto9g+b7Jokq0UnM9n1YoTvqnz81eJq1mMPUQJoHe7dvu0rnEyCPLBOrQrQyjh1TPxaV20Uxs16VBXoY4FG3WvYvLueILQvLiRx4MX0mnvu11+YsyRh+S/r0VBruTk+COC8mVFstT3mp8cDjPHHktXfj//ls0klgiH1ltSnQ5HQKckZ5feXW1+VGnGJuYigFA3vPgY39BCCfmRd/IagXkIX19m8dUzrxTHqHQtrbjlmx4KgnxKfRrw3MBDBaSJ5K2FgJb9PykeyILgxMcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kimie0c/baj/We2doKcCDFjFgvXK9glvr5iu6Dv79Hk=;
 b=MFspR5rboOqmHPxkh+wY4c38chESN+dUo+5PEdv4Xc9sJnD2cycciRkfNnf2Df5LamJKz0bVXmpzvtF2FefAEhbby9k6kjJ+1KZiUWVuHctZxfM0q+f9CX1i4qHQZ8elbaMd1XJYA+TUhSEB1WIYVNrMOwI/SAftHt+Mlrhw4b5HD699Dk6brVTXAP1sGJVNSPWgsZp67ZuMizNmHh9VIFsMbG2LNTkCHMmyr9qcox8FJlgrZBEw6BbhEEYDaMOIt9I+BrVrJhBzCp1jfQO4pw6JjA9IdiLwSzh92Zm+w8i0PyHcdroW1+nL1dN2MfhTkilrsjeutGiLeq5Qi8Q3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 10:42:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:42:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/5] add mp_fail testcases
Date: Wed,  9 Feb 2022 18:43:08 +0800
Message-ID: <cover.1644402973.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16786a9-c41b-4bcd-6d35-08d9ebb8ed05
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB5807C21ABC510CA17FAC9346F82E9@VI1PR04MB5807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KGEv4qasmmR1j+S8IKDRImBtqEVO3Rz21Sx2XnRXOKqCKn8o3KdG9B4XeD8+pzk9xjULIx8/JG1sAGMqv6HsmY4izRoAXkaT/D7lTSQZ+Xu9rmeFJcWUP3TujvEvr/rsYwY+yM4Q74L9jQk9ElCGyaKfLCSmWk9PJLMnxzw3SoTfG+CCKGFwCaMG7OhcaIaas5oOhpTCkBKDyEDrUokGp6xo87h3SK+S6JwDg5tkEiklB8MXy3LdkXY/W42gX7tLsj+dZM2xlHElM377jJt37QWZhAyWhed6+w62YrxifvTky2ln+y3kR+fsGJYLBzezXXBwOwEDwadbInDljgJZk3nDZi/LiWuBNI6dTNQhVBXigPpCQSdPiFgXAri+nbTDt5hT8BumUg6Z1hSr5YL/WCmIhD0XRz/6a9U15kBy+EvtECCQJIBGqizI5S27wWs5xG25lfQbs5URlErUWeLtbsPgPpEHj5Q3BP28hvb5hcz2TQE7HrWohmML4ygL+eRC5z/PTL5hAZqfRiJtc3HdDQP56ehl/BvM7cYRU+QD2psikNFNnfL/o1DeB0K554r87pyb9GDx+exDn/jwvZSIE6CQVzlCiVFdOcM36I3P5sE0Mu4mYZl7g24E1NV+LUlkl28cKuuHPXS5U091JwWOsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66476007)(6506007)(66946007)(8936002)(83380400001)(66556008)(86362001)(6666004)(55236004)(508600001)(6486002)(26005)(186003)(107886003)(6916009)(6512007)(316002)(2616005)(38100700002)(2906002)(36756003)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gucpSX6OmSXxYunqWHqmW9n4QGiUbdmvqC+PhilX1099QbiuVn5vAV7EPQEM?=
 =?us-ascii?Q?LRMAAxf+mRl4CAqqvc/cC4vlhBAv2yzuU9PPf/fcs1a1Re41SKVCDFen1O6U?=
 =?us-ascii?Q?OQU7YUPgI96g3zmmd1rJYNq/Bc8nBi9P/pFjHTVRWw5BDTrmHh65q/DQLKEd?=
 =?us-ascii?Q?gjK+ARkiPHZeXLtuwiDUXW44759ftcZ7FBvqH8DFLHRsISf/ImySm/YzPFj2?=
 =?us-ascii?Q?Q6A7puNznwbXNfNZ53vY92x/PcGxTYJ3eqEzWbrLuAufumHiUt76wJt2QqcI?=
 =?us-ascii?Q?1WrmyY1GAyn0HBP5aWMKDvwvxrWq4GzbQnYybVorpx2uG4drvoJzjzsi5MVf?=
 =?us-ascii?Q?GmdNrmJWKWtRPKSZ7yggubU4kvlRCcpZgRALxNcOBPB9DfzEbTPnFoWnLlnu?=
 =?us-ascii?Q?EWge5ilkT3rA0h6MT0aelSc0dinzp/UzdQvi8naqpNg6XxxqWYdAI7vq8aGC?=
 =?us-ascii?Q?A4ag+dePT0JhNYMBmQ+cRT/vRQRkIp/Tp1nWaNjIbYVBVsV+EqPvmBWx9Na2?=
 =?us-ascii?Q?vZnuwyz+f1N7kx5LFaR5K6kAt+Eh4ZovtNFZyW5q9iR1g//8Qhjetog8a8aq?=
 =?us-ascii?Q?pW8tzvUPwg2ooDeuzmEDJcpP0CsXvV0R3dBB45yMDK2of/Sh/RDrleY55Mpr?=
 =?us-ascii?Q?3lETkw/c8fwlijS1cn7oxKY3JpUH3ratqO4JYdeedK/4aw+dBfLizsbgkQdH?=
 =?us-ascii?Q?qEHhFvXmJHFPN+AyEl0cSI0ORCP6BJAZYLq7kTACwUHeVxxopA12Q4DkYfrU?=
 =?us-ascii?Q?nsQaRUddIaq0n+yDjVninGZdodG46KoqvoeDfPIKYdV5BUSk2XOFlBWJ5aBN?=
 =?us-ascii?Q?sk4pCg/ZguI+jzRPuoqPZcnQ/KVMNJFx2VH8Wfx9j9NiwSlr04SrBYr+u1zL?=
 =?us-ascii?Q?95gT4DSGEAndV7ckwekJzNXXFH1mK6k0qYI6nffyrcsLoPKib86pWF3g1MQO?=
 =?us-ascii?Q?vEsMhq52qev0657oEZ2U32M3ZRTL32HevjEZ9nnyblYSy0SAQUJiJ4jPU1eV?=
 =?us-ascii?Q?KSl7vJZ3CZgA3xiAdleu7NsuTsRMx0/TQ4XOReCeKUbi82PVjDwlLfEL6H3q?=
 =?us-ascii?Q?tjEQAtn20y3qWbD/cJckSqpmvs6qFz72ZUAQAa7ho0crwqWwQh7FWXpbrMQ1?=
 =?us-ascii?Q?MP+CJYVVDw2JEF3Y+ZIC2WWPUYRczked/+Gxq2BxFNYn5M0kO7NzUjWpGrYQ?=
 =?us-ascii?Q?JVzKePrjTAjqP94HpJZclWVdSER3dDyaDaDGsJ48WUvcEydTZ4oel3sfUVD6?=
 =?us-ascii?Q?zNuUm54knbca4AOkbXyiNSL9effI5QReD7OVXjD0z1Z9PBJxmOtw7ZPuti7y?=
 =?us-ascii?Q?Jw2l1k+kBxd+sBwqRPu0KJZ3MB4DAcRB0NBfmBkPl+24MHIMPMCcW9mRawRB?=
 =?us-ascii?Q?zbLZwiX1cwj/MMIo2x49a82pcM1e4FGdML12H19H6r5UJOsMpYvkdhS5KKzg?=
 =?us-ascii?Q?+wvsEyh8/zxhfgWg7taa2spC5hl1pt7PMnDgtKmpjnReLEgwKbq4sqhWCu+W?=
 =?us-ascii?Q?/0a48PnJ5oMSLyatYxrDLxUey6cjshO5W5RZljr0QZ8ZryokOCzQuJh96bpa?=
 =?us-ascii?Q?lzVvhIGEzx6PAOl5gjADRtr95Biy8BP1ZZHTFbKyMDC8P1xMJZwWM9e9fKdJ?=
 =?us-ascii?Q?vxPDvxKSaGVChHmEepqQE5k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16786a9-c41b-4bcd-6d35-08d9ebb8ed05
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:42:53.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hL5rk5SI3uGLbYabOAyZyWY61+ZFHU8U9ffmuFbE870RmVU4o9Q/e6m+7LGmarK8rE6J+yRlt0q/gfCLBth5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5807

v5:
 - update patch 5 as Matt suggested.
 - use '|| exit 1'
 - drop jq
 - drop pedit_action

v4:
 - add the mibs for MP_RST
 - patch 4 "selftests: mptcp: add MP_RST mibs check" uses the variable
$nr_blank, so it depends on the commit "selftests: mptcp: adjust output
alignment for more tests".

v3:
 - check the exit code of iptables.
 - add ip6tables support for reset_with_fail too.
 - add the null check for $packets
 - rename nr_mp_fail to pedit_action and get_nr_mp_fail to
pedit_action_happened

This is v12 of the mp_fail testcases with Matt's changes. It works well
and it's very stable.

Geliang Tang (5):
  Squash to "mptcp: infinite mapping receiving"
  Squash to "selftests: mptcp: add infinite map mibs check"
  mptcp: add mibs for MP_RST
  selftests: mptcp: add MP_RST mibs check
  selftests: mptcp: add mp_fail testcases

 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |   2 +
 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 192 +++++++++++++++---
 6 files changed, 179 insertions(+), 28 deletions(-)

--=20
2.34.1

