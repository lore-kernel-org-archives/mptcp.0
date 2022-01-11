Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42612C9C
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641913584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KtF05nF6f7W2GSnISyLsfYPERXex58xD1mTCut/u1IA=;
	b=jxbiaUhPggt/pC2AMoPEFoQU4oW6VIuquhmajnGinL8A9Sf1KPFmmjlLYseGDH6uK08MqH
	Id0PKkiOje6I9yjLQ+2N8suktcLx/CVvTYB8LVSwX8Zo+eZ8uazQWqBymp1yEDWDXC/dcP
	Hjz5w6eq+G6u1+MGjm9tTgepomc71zI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-EF8Z9vV9M_CQjY_kFGyV7Q-1; Tue, 11 Jan 2022 16:06:23 +0100
X-MC-Unique: EF8Z9vV9M_CQjY_kFGyV7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkzoVJ8klJxW1K943qgrCS9pt3oEMJ+BCUPfPGuWmc0K3OSR/EfPADzhROOZqlTxUz7oEWBjtcOdjYRIlVOw9W0GQFVYAkGhzvUJc5xJO4ZmverjJFhbwswfcWoNj0vGe4t6LutPAbKSHasNWBASSWvXXrZPCxV2ij2pF9c9HylYhbltJSsDMEdPFo/bktYgOo/PwrjFKInG0x2JxnwVD2W3XnTkEHuiLskpwknchalB6B+u0gD2lfJeOM5bakt4Bb+I3aarK/qZafazQ847OPpx2j8kMnC3P8EWbA65ag9mfAw7zG8P/jzKZW4NFtJ/ZI4K9jUkSgKmB+dib48lbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTUqUQT9B5r3lcyBMrWTYDOjz4kSSEBncunY2lAGwuA=;
 b=Rds6J/krQ5G3eAaImaYL65zSLT8jlGTVdkzPaWUrCByKXNxdtkqApqT9VadaDkdoBkrZDR/9ludiJ5GAKF3N0gBas5w/cLK9c/+VUl1XrSegodI5/15BAoSfw+TJ2QXypd8IIsfyvAzNhN7dfHV+gCfqdXUrxILubrfM8cP1BfI9+6O2zCTILsuUtlOTNdsVG8JWYebXZckBH0Y47QrcitDQGV796cmVYWM9ZAJW9nIZQuWhE66s9bxGePFgsEjNfo2neLaHKiVOqfeT2ttnyHMyzJzTEP7yoaeh9i4RUfAYFBIVybra7xzyEdTbuGpXW9S3GAhyH3xWlN4gaGHFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3066.eurprd04.prod.outlook.com (2603:10a6:7:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 15:06:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 15:06:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/3] fullmesh flag setting support
Date: Tue, 11 Jan 2022 23:06:09 +0800
Message-ID: <cover.1641913113.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664d25cf-03ca-499e-7f6a-08d9d513ec40
X-MS-TrafficTypeDiagnostic: HE1PR04MB3066:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB30669E9D2C5A9150CE486844F8519@HE1PR04MB3066.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oX0DDyQHg+GYV1qEiV4EqAw2WdO+qcHBgysmB9X6m36ErC4gqOVKfnb8iUz+j5k9rLWZF4HF9K5Co9jm7aMXHnYIO/QjQq+VQxy2Uk3dnhWn8ym6CMLphZyRzSiZcwQf6CnbQq6hULxjH4c/hTEZ1bebuuGM11RR1JDZQTTatIK76STDxeMvg+2vHkAyATTbKT6vAuxMg3S6C2jHP4sAnF7BHn7UYdQvd1LLEzjo6cwZRKJSHHw6DZhrBrB3LjTht7SU13Ds2Aj8bgnlO4pbX1gA7L2VLA7nNwUKdXw7qcoquxBHkQqJw2AmtPGMXZuUsdmX9PyJGQiixnNYzOhawiz3CEnbMFNBocmk/bXaIvhwgd2y9a9fDBp3eCclo8ooVVuTOAJzYvfjjPjIVTdEb9j9Dk0Fogtpza3RRfXB10+1EneTOlFjJC5PMJQRqdxWdKVWSUNqPf8Xel35PDWses8TiQnzWFfCpO/2lInwck3OulCaxxixt34iAa7ZXXmuyvhRUXD5g4qnBnu9SfPn18LOoiU/V8RyUcqapdfOvcFncizj5JtCN/RRA85d7EVVrAT4GZ/DWacEMXpUd5Rmxh9eYtgiEykbsotq+XD845mmijjiiJMe/uLhZN0OoClmpyaPNFGmb+IxrARGhVpf1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(44832011)(508600001)(66946007)(6512007)(36756003)(66476007)(2616005)(2906002)(86362001)(6916009)(186003)(6506007)(83380400001)(38100700002)(66556008)(5660300002)(316002)(8936002)(4744005)(8676002)(107886003)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYhP1LmBUYuPzEppPpUHfmBE+mitf8Rk4DtY1Qrw9snztKFIpUuzEndJghwL?=
 =?us-ascii?Q?pMYGCmdOKMfR8pgexOlYeqtc2C9mo7XQ5iK8FYlPfTe9+KWgcFJmkT0TWi7D?=
 =?us-ascii?Q?lWTod408sDwbAH4dkA9WUQDqmZrMX4UURQtx6CqmC6FCko3dy/62aP1wdiPL?=
 =?us-ascii?Q?7DVcwfw1XzUd60GP6MK1CDRYTnBHreZSy5cMIUUrEIuUlEHpTffhGnLsne0d?=
 =?us-ascii?Q?cEcQAoxlXCRkvhRdQpE7uFfmGgjgn/7cm0otOWcLCaYhDdGpMjbLF5h1Tv6U?=
 =?us-ascii?Q?BRqL+jb4IGRcu2DMcbZUCu61dZNZfGCEMIrwDqREQurfKW+K9mDIiC0UsaZg?=
 =?us-ascii?Q?100sHoXoUy0MdXD/s0azNEzh6PNMdMLn4EwmE1iCANnCwIUYLeks+MBsUR/P?=
 =?us-ascii?Q?rlIK/F8VufhYbS5ZnG1uk2eSMblcH0hr5gcl51ZPp90mgTU9DzqrcBjY45/Q?=
 =?us-ascii?Q?ItHmFJ2G7yKyS4sN/i6tNSFO4AH9+QyuuMoPIsyTmr/ks8URmwPIr/6M+cDF?=
 =?us-ascii?Q?jTV3QO+Esd6v0PbeCRc4c1MrCC9MSfXz9oHoQ96UJcr4Fc7l95ucnQVjR+bZ?=
 =?us-ascii?Q?fcT4PBDUetdcv2eMo9YomCFmcHhuQ3yWhDLerj9BotiEVaP/NxFDEGtFXWEV?=
 =?us-ascii?Q?OHdj44d/i/XLG3bcPJAIy+wJcEjr+voDQ6KQSB6/XIqUaEex8yvJ5Xvr+9US?=
 =?us-ascii?Q?AdyRtxpF/yT9a+5y55tZtyewAxLmeIegRh/djFcGjNoyOidg0jvzh9uyYJTq?=
 =?us-ascii?Q?SarwRAFEMee8ijVRo7s6SspxpAhRgSsqoqTNJt+E2nlKHtPI7PBrvH6cAN6+?=
 =?us-ascii?Q?5guq3hkPU8B7exR/POePWXYnY5dLBYwmY0vI5VzTT6lvnGaF6CVGSOFQt+tR?=
 =?us-ascii?Q?alDE9iuB28/mtDrwz6LpPrkxAa78w0SZgplzif+cT8E3qhJ5QOHDyJQIHlre?=
 =?us-ascii?Q?SYwAw3jD6o7sVlPnVGNEheDptMXEMScMN2VZ921VCcpgjTA3lGj20qH7Yebl?=
 =?us-ascii?Q?VZbyWFgL+7T4Gl9IO0J6N70es/yrhaNeffsw1T6t/SOCEGJk0xazBAGLWUpF?=
 =?us-ascii?Q?+UKAH9yxM4Y/pmoRq820hmP6P4iJ0Z2N9xFHK2C4dAp4qePqZl11oRiAiZWd?=
 =?us-ascii?Q?G9f+vliv9NVK8vDyf6eaw3NOfhYqjxouGvwL2TVe41XIqWBvpK4KnTeP9we3?=
 =?us-ascii?Q?rtvmJIksmp86yAynwAbC1rh9UG73aAIpX2zt17gKI9iUdPCNyngzi140zng8?=
 =?us-ascii?Q?4QhApwH37PUw1JsEM3UMh6heVY91lcLCFWS1a9sPPB/c6gchqPCCOLl8VE3U?=
 =?us-ascii?Q?NDQlHj+IZNwqulBfLV0dxe5tVhqVLd5wx5mEKWWVwXRtKab15vdlQdSGhHgr?=
 =?us-ascii?Q?VMlq/ZKan7WWK/22mfC1YjA2YwWe1ujjv9lX885edB1x8khOMleubcgAPjru?=
 =?us-ascii?Q?yRYxQgQIAzD1RPH3c0uyu9kBowPU9emy+kcZUxmke3w8k7SpfOB3qo0DjfgT?=
 =?us-ascii?Q?XYaL3Pj9z7qGjSQwEoW6JXjHPq8RBL3+qmdWTbOpHOaAE7uMn11Y+RYT9HAo?=
 =?us-ascii?Q?tvx3Yj1Hh10VcjoieXiHy0bI25HqRMAqppUUJNpBSLLYiYCX+WWrox+I1GFw?=
 =?us-ascii?Q?mV3uKuI1LfNDqxwmbChyNOVy/JFMfoyK1h8PZJktHHwjnaRNOIEdTpDi5MSD?=
 =?us-ascii?Q?GGDegJuQGKrrfqAPFMf5RTkxt/4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664d25cf-03ca-499e-7f6a-08d9d513ec40
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:06:19.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLhzjsrgMiAN+aM1gJXDeXiBX52v9PdX3vbjjHURSQ0MMho3DY2Kc7/Q37e3Blj202UaC0OByX1tv+7QaENkoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3066

v3:
 - drop MPTCP_PM_ADDR_FLAG_NOFULLMESH.
 - clear both backup and fullmesh flags as Paolo suggested.
 - depend on:
  mptcp: fix removing ids bitmap setting
  mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()

v2:
 - add MPTCP_PM_ADDR_FLAG_NOFULLMESH instead of MPTCP_PM_CMD_CLEAR_FLAGS

Added the fullmesh flag setting support:
 # pm_nl_ctl set 10.0.1.1 flags fullmesh
 # pm_nl_ctl set 10.0.1.1 flags nofullmesh

Geliang Tang (3):
  mptcp: set fullmesh flag in pm_netlink
  selftests: mptcp: set fullmesh flag in pm_nl_ctl
  selftests: mptcp: add fullmesh setting tests

 net/mptcp/pm_netlink.c                        | 30 +++++++++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 ++++++++++++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  7 +++--
 3 files changed, 56 insertions(+), 10 deletions(-)

--=20
2.31.1

