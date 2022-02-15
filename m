Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62291388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vcIQ4mTQOtuMl2IjA2R/iOE5hddFWAq1D2sM33CMMOI=;
	b=INqTC75g/PX2/DhNcQmqQ2J4SL3tKzTIL1n3l/PmSIoQ5SnxIYjCW+gmZXHLg6ZbEtYQ8G
	+c7djZ4ihejU+Q0zl1iKerJBj6x2RrEl+lmgOdjHdjABT/j1zK01Kha4hQiwOFuAUDeD+m
	IqHtOvrquRblwjVm9Q4VcViCrbzY46A=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-UBhIDyJ9P9W3-TGO0Z4XRw-1; Tue, 15 Feb 2022 12:12:04 +0100
X-MC-Unique: UBhIDyJ9P9W3-TGO0Z4XRw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRYWgv5yApp9cI7xSoEZmfogCB/aMb4+nBTqwNCUtSbZdD52NNSeqt44cMgBV6jLSveNCBkJ0Gsu23m96Gowk2QHB0Wn84pepGan1q4H79IKGnFbqoSWYCCrQdyjU75KWReAylohUNd+Awpw/3s465FqctyBkAyv42wGGZct0AqDLPD/CllS3J3fCCeFzjtli2YxmtZ8361xsw/Lyh3R0utKqRXl9ArkURjSlmibxD5oQ1mdG4ve5aoid/NVdchMO5QcZIfWSwF4AYuOFyEnJ3lDEcpvf/XJ/w5kfAuBQSmoMfy3Z5n4Q+ZMx4fc0u/LzULZ6yA4kf6E6oNroFPJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwW+cTZS/xp17ekFZ7Q1F+ZT6TX5rFak+WKb/wf4kRM=;
 b=jmusnZz+75okgLcJjVKuaK5CdNhhZ0Ncn1ye/92OLsFsIFITR4pOz3FZp/F1CKSU+Nb9ByDBsdIpVNSkKNVnCroLwcf9it+sriNsAxsLDEtMNhI2R4QhxQNvOskRnOOuqNwJgYbWEeteRgZI1C4+dNAvHmFv21NFKZXgJjo9Vgxd45Bm5IYoUMEKXq3nUDkgQnb/YOsR47PmjiqWRP9pyTXEy5heUpO3obtGX9cAvotM7wnHAvLwtgIiJMoe6RXAGztoMECe2wGKwDddmpI5CGECyaP+l4pnHUl+oj99anhXGhq/eJ4tJ42WQOYkg0Jowc4SSwvhdHKCO2KMtMXbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB3985.eurprd04.prod.outlook.com (2603:10a6:208:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.22; Tue, 15 Feb
 2022 11:12:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/7] add fastclose testcases
Date: Tue, 15 Feb 2022 19:12:16 +0800
Message-ID: <cover.1644923074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1632690-7e01-4def-3fa0-08d9f073fe5f
X-MS-TrafficTypeDiagnostic: AM0PR04MB3985:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB398521E51859DF14875C608EF8349@AM0PR04MB3985.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sr3JaaZ7ElQ73F3vNZd88aHFYAReAA9lsM9MqqqDiXxgVQzPpM3d3KWeV1vf0D0jeaQhFIcry6wEabbnvNi9ZdJyISMDYMjAXZESF0SPUsjknR7u2GdzUJmA6NLauPoU4QZNavKXtlyEKDgjen6YtPbBI9Iit6C6+9rWJLeEyHHs1dRtVc+olzjX3ZaQwHJn3QTLbdvO8a1MBgUIpntvx2YJmwV24VA/IT/VnTLs5uM0q4E3ofJt9ukEJByIFerB3hDGZEsStgfiuGGgk6JUp4LeiIs1tRySmigpVyvrU3nuiLcgyrFU4WWQGXBUP7sJfGQCglm5VJIGZQ3gps1IPUkH4eG0DwlxtMgFbJNWDOS70KWPnoxiRsIbXGObT7Z7Xzy2aLyLSgj64BO6XDpcO0gTQXZJ9ec4FrUDg/51qru/sIJ3Bl2wvVJ+VHkxvR0H8cxe5LIQ9MFk5s3Rn9fOOhqJh8O5EQZnRk8Mm+D4VtSQGikjEups1lhcazXSwPNx7g4AQLlVCiqupARx3iDHGJbgD9ICA7EzO2ddWFVUyK/g57jzffGhG0w1LkxJEif9TiGDqJnwdujWF8ABIvAlzXcwWCBimWDBI546DINwsVvSwu5dCWvbU0Hp2E3aV/Ha1o6QO34LjUpTUDjX+4D8jQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(44832011)(36756003)(55236004)(38100700002)(6506007)(66476007)(66946007)(2906002)(8936002)(6666004)(4326008)(66556008)(5660300002)(6916009)(6486002)(508600001)(26005)(186003)(107886003)(83380400001)(86362001)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sssjH1RTXclctJOY1aEFPDq1K0rFTe5aVIKsTV9mqGuEzHzN18coPITtCgcR?=
 =?us-ascii?Q?OACAskUWRofk+V6CPQQgBan+sBb7f2bbpWUlx5uxgLRzuAVEuDQBu9VxNP/V?=
 =?us-ascii?Q?k4up7QlVKJsjVY+4SQC24OBQRRlw9yMTmmsD2W5FKe+7nhFelFuI7k36IH5J?=
 =?us-ascii?Q?Bvv+2UzQBOZj++FNKJZE5+JtWvEoSrYs1qnHHwivNxEdxIw1kWGGSzEZL7cV?=
 =?us-ascii?Q?VvvctiuoH9qYB7IxIjniKfr/vE8lYo/U9xeJXyk1beQW+ipqAxKcSTg1T8yv?=
 =?us-ascii?Q?+jqcjUtJZdyWP/x6NosPfkJqg59l6gAMwoyQ7oCkqMYPcL+LFX27Hp41FXtm?=
 =?us-ascii?Q?ELSEQdD0YZkIl/dJ5705p+Ly8lWyGy1kx36BBygVFfQ/f/xGfaj9MY1ZzUPJ?=
 =?us-ascii?Q?cNwJaSCtWjVLKw7y5gqTwJHe3rQJ2zcR46dT5Z7yGmbSwN8JjFuUiaxC1/63?=
 =?us-ascii?Q?H9BcHKjhQwI3MTZJg001Cysxnce1yVvQ0vh51s+Hc1YrMv6h+ACswaMIPYbv?=
 =?us-ascii?Q?8xpcXn1L24Y0tuSFTWR54qLMIPNCKfP40fSZ+huvdmSVElZhnVw65Snn5Jl2?=
 =?us-ascii?Q?XGF4rbd5ojW9jdCYGeehdmhk2ibzZnXug52EEf1uSrDZpr7VgBGh4MPNyqOO?=
 =?us-ascii?Q?ByRCsRkgwr6BOpAFKRv716Cd8Jey+PolS1F5VRhPAPzdRmoExYM1+k2gFYf4?=
 =?us-ascii?Q?iuf/b0p6PCdfhN4+1UMO5xPy+BbqwNW2lqsx5MGoazqsbR/Rea3lENFSoi48?=
 =?us-ascii?Q?I/azsHbbaFArJ1u15w0RQrqGek5wsSF1KRyg89vOVaxRQqYt1/H5o/aNJPpD?=
 =?us-ascii?Q?NGZoX/EOEG5CSGkppVS7igO/jycG2RsieNRYrgL5rMOWbzNeHdv1bOusJD/J?=
 =?us-ascii?Q?GAelgRwrIGFjQf0u2jmJub1UWHwQTXqT6aUYL1YBob9tz+QVHnWdkjCy+SS4?=
 =?us-ascii?Q?ce+Oae5vFqtmcyXv7Hlc1heqX3bDV3NCmnITZjCA8j28kwaG+EwSfG9vzxRo?=
 =?us-ascii?Q?nOgk/PV2t1jKi11oup18o6uZGuLuxwAq6T3iniZTWAPFuGlavIRD55+WwuGq?=
 =?us-ascii?Q?JH0iXvklQhMLEKle1nR7BgRHaf12HvVxWt9T8n4fxbINxdCxCD2PNbsLVA52?=
 =?us-ascii?Q?9ZelkHBKTsO4lDDYSFD5CwGYGTO3V6r9032/blbFXIZq5ZdONYDg+KM5wHfx?=
 =?us-ascii?Q?fbhpul2Y3jL2A3qBrvYRa1EkjuQ4mOxCDaknpLNhYWhoxLaKV2QQIQAyuMaj?=
 =?us-ascii?Q?yZu/stDapyqKRqGO2SckDDWP8ArhiXa52LFvt/chIJhNDCD3OYoW2G9rgJTz?=
 =?us-ascii?Q?wOemZOzhvXTK2j4Ugzpupz5o+K7jY68YnzuHh+C/SEtXn8NrT6xhELfJw3I7?=
 =?us-ascii?Q?uz6mStV0Laalpbx8ldKzP+mwoR+pvNIkEnjzJ6i5iVzQeOZNVBTBXR3ZoWCJ?=
 =?us-ascii?Q?BA5bs77JZqLjZLsrKhKsBA4+694UqyCAGYWWM2hLPypZdUXkE/8Ne14Z+H6O?=
 =?us-ascii?Q?Pj1ea8l6O4o1y906eaKycmjtIpXaVCY0thTYukErLim1Uuwe5DQ9P36KpivL?=
 =?us-ascii?Q?LcLjAEZP8ZPmqNn7bwIBXe1x2YYT/Q9CKC+dHN6bETknNMyUHBj/U2WFGPQS?=
 =?us-ascii?Q?v7xjNXMDdJB3b6crdF5//mI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1632690-7e01-4def-3fa0-08d9f073fe5f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:03.1539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vAXPnDzY1aJBCc1lscrztaPhbYeyJQnGsbMI1pnLP8Xzoya/FT7HhiUyx98kIniU+kLBJ9AN1hzAmyWaBVvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3985

v3:
 - merge the squash-to patch ("Squash to "selftests: mptcp: add
fastclose testcases v2") into v3.
 - add a new patch to check fastclose in mptcp_connect.sh

base-commit: 9dff76d953f7a0fe2b27818f2aa93031c9a617cf

v2:
 - merge the squash-to patch ("Squash to "selftests: mptcp: add the
MP_RST mibs check") into v2.
 - update the commit logs.

This patchset is related to issue #48 and issue #197. The two MP_RST
patches are moved from the "add mp_fail testcases" series.

Geliang Tang (7):
  mptcp: add the mibs for MP_FASTCLOSE
  selftests: mptcp: add the MP_FASTCLOSE mibs check
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add extra_args in do_transfer
  selftests: mptcp: add fastclose testcases
  selftests: mptcp: fastclose check in mptcp_connect

 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |   5 +
 .../selftests/net/mptcp/mptcp_connect.sh      |  37 +++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 134 ++++++++++++++++--
 5 files changed, 171 insertions(+), 13 deletions(-)

--=20
2.34.1

