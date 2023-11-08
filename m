Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F02CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wzcq5SYR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib9CanxaVMI9qcngfUq0ExLgYW4qK3hLWZL2F+nO1EspAVPp/7qN7R43uHEmHcW4v/Ins8JZK817iWOvL6ZIpfIA/MMlraWs2S2GmOF87+LW13zzhJa8PRVIKNcITmnqX21Rd9eyOzLmpn4h64au0y+4OHGG4hZ3O7bnO9sJ0l6CS7MGhKG/xqyiCZmX/Rh94yhmVH2j3urjX6GwZXNou/Zb+n5kZvqJCBBj/27zZk9HJe84lu1c5v0Y6lBlEb8VhI3xgvnGM5l5lRRefAwtNZ//3dDdnyisZy7zFDFF32S2jjSm5Kmw9yN06QfZ19lhI4MNagVIToAoGC94VHR7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRMYjCXMIU7R7fJukU+VlrRrIQKipuIOZjjFKjJYgNk=;
 b=FUNOtGKBOM0vqlwJZw2YW3svrVeeJGGdXDNzseMisF0XAtDggBvn4HXRp0laSOzSOGu9zxROmAbrY/IZqwJVGf2Dkm4gO/NWVbwjCxVXgBlSCt6RKU7LAehjnq5PtKjEAueLplJONZ4ExxPDOELdY2TOEyek+iOf/vjwXlzc32kpU5rEidfyihmPo5HLKgCMfYwez4z1N9zXLwkd7yl3j9uzbbKPzX4M4DZNA1y85UuiCEvOKJRVyb/HD0imAPHlTT0llvsGOlWT8g3B5S/YSmkOa0BdvZSQAxTH5lAKMu2Bl/OvTp2AQLf4aOLaVicltMd9E8hwY0y2ZLoUJWIdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRMYjCXMIU7R7fJukU+VlrRrIQKipuIOZjjFKjJYgNk=;
 b=Wzcq5SYRq+jys6BP/BKyZGfOIAY3uvtJlthl5NUNuNrNvHeCdGB5JP7PYpWXZrAbPd9iy8NRX4RhOms08TCGKxJ6fr3vGSAcNR+rCz9jvRRJfRmdUyaaIqo73fhs0rZSSuXwH0Ru1IINym5bw6FwQQZ4ZT4zyEn67h5D4EF8liVxQsdJuoZNABQuUpVuf8+qcbcWHJoY4DwVqyIvHwY+75sQEN0kom3+fhOuT8AErwWn21QVE2DKPKbYB57fNouCccftJK9MOubALtmWxRuRRvQSfmDcuqMmqjb2UA3B/8cGB3bhJbf2DjfZIS0iSPWwcmKqFJOvE2WJ2ulAB5fe2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 10/22] selftests: mptcp: dump userspace addrs list
Date: Wed,  8 Nov 2023 14:49:40 +0800
Message-Id: <57929c92d5849ba5f9e223ef35368f96f20bca85.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 01962876-d440-4000-05c6-08dbe0270d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7k/6CqvwgnhwGBBU6PkfMn/j8kAES7tj1IE7f3wT+njjOE6VtEXeTRziKQtI62XE2qTjYNT2X7BwX1BQqmdIVLlINvIUK75kGa6X2wVZutIVLNX4tb1ekqD7xy5RhGI2T+dLG6GBw+3HtCISDTKg4cUaskaia2Zl945LnMK+ce4/EVZ7DahJeZNLZz4nlXWQ8/cg76CaJWxhkpbDTMDsS/H3nJrjkL2zbE4cXNBHvb/14iYgGbAtVIaZJrnnF48hlHSI99Qu933foo4+7dl/JPWZRq/GpdTStI95gF76is9XpmsGKL6wVCUCdXrbi4QIiOev+wmEZebtrBcRxOMZyG9fn3a/1kQ7jVdQ6pHju5iYyTV2TswOa6THAVNeVxqILJkKK+w4Jsy68vEQhr2hEXXXMPYThHtAf4tkl7FuNs64WbnLiZYHqNJ4WUNpBQJsgANzCw1m/U049fGRnZ4dY3t4cPJJBkmuvEWw4/LRuY0mI9IdXq6VmkL1nOyIv7T1atAI/XkmSQDoQkuwncBd84qXg7hdU66jTvqKy1QO2sA+22oo5/kbVCf+zns6+OVUpvAQwcl/yY9+rHF+c9HgxJIFHOCD1Hb1BZDFlSpL8bw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(4744005)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPuR19DTTHF/HSSzo4e8uiRWYYdB47wT2qXdyCk6m9FwRmNBUS399l9lZuIl?=
 =?us-ascii?Q?bgR5wg6pi3CyYBFXiM6vq6TwpvI59VJ0+1i0oHCaON7yaJ2PkRox9Zo6myTR?=
 =?us-ascii?Q?NfM+xiyOKEZqqOk0JXpJ/tDRCptDhVn/fk083eeGk1v2Bcu+NrDfBzaR9wxT?=
 =?us-ascii?Q?Q2MKjfbFP8Wf2yUBeJC/+uRq/fyZRX03y7kowivAgxddu64ecaYGe+zHwb82?=
 =?us-ascii?Q?TSasA4DwEiHTxDziltSSj85JL6Wl92yuQj4CfIYEgyq+J4UmpbDIAR/Py0Du?=
 =?us-ascii?Q?sRr9wR+gWbOj76tJFA7urVO9r2j8ZOc9cIKE+6cUjy2YyhKrby5FAzgOJhuj?=
 =?us-ascii?Q?apKhxGbt/3BGMZCuRZZ8HScZTyqfcUYpB2RUB9L/e6UckfnzSykpAZ6vQV9E?=
 =?us-ascii?Q?F1d7mMUCyubCbVj+0Dr8xuzmAX4NzEqR71C7/hNsltaTeuaCl3hJpcCz4eNa?=
 =?us-ascii?Q?28aoACKNHCBmKX1xbm8tFKqF/Pgx5v6/XCJ+vk3+0vCuiKKQFVb4Rs+iDXFG?=
 =?us-ascii?Q?CaNxKlxeltaNhvOXdBk1gfzxtFH2bjpMOr0I0Vwv1ynVn0bPSSKBryrH1MK8?=
 =?us-ascii?Q?dZXDihJg21J+waPeHHLGhLtP0WqSQ/eeMd2k1im9kdrkU+Y7KhZukvfdAHuR?=
 =?us-ascii?Q?c8diMGz8sAiVu0WlyPl43b9Ka7Trr3ETF3gPuOe9NmjrpJDBvup3Tw+yv4Hv?=
 =?us-ascii?Q?Lx97B0WrUoBqHljhDlGOi6kvUCyrjHwK7OgGtUGgRC989EMLZfVARCgkWXVh?=
 =?us-ascii?Q?rWjailwvY3/EogVOEJygnnJ6IlgMTCDDcmR6GzAxUXFkOHO1TLgO5yv1CWfH?=
 =?us-ascii?Q?n2Miuo7FokYBDs0COxZcU6B6WIORWhC9rSn46S/0PpPQnf2ZNN3jkMHwJD1A?=
 =?us-ascii?Q?8sL/o+eEILForYw8N0N1EYAkNKu54zWmjeNr+Lp+Gs5+/CTEdiS43sxKfF6f?=
 =?us-ascii?Q?JLOSdGzQ4LGbCamVGi9+aiHRkUffIf+TAWeFpjb/jKTJgewUKjj93hiWQwxl?=
 =?us-ascii?Q?PCdvkuL4LIzvgg4bjJwfFY77Mz+v7mFrobXI0KLaQs+vLZRUL4Ma0edMm9Oy?=
 =?us-ascii?Q?QYChrpHA46030sqXW2QwHAIghiiTviCiYEljPmjC2mLea4u8rbPZT2VEBjB2?=
 =?us-ascii?Q?MO48ezkcHNJpGE+6VHurSbdcw6SXeQNfc7BKWyTaqj+BJFWhwee7cOmYJMv8?=
 =?us-ascii?Q?yqx36djOpEeqmWywYXBN5ENNDnD+J+HwiUuzfNr/44Nv51FneU//pxVXf24I?=
 =?us-ascii?Q?1+lQrQcBnscv/QaTQc0mN+lxompK8GndJ/E7hRCo5cN2apyCGNxfqRtoKLjQ?=
 =?us-ascii?Q?9FwdZrh5zGBTwCiE4Dyiz8J1yPvjr5v4Cdci1lqymesl/tuDsy6vAaOSSnD7?=
 =?us-ascii?Q?F5UtsWY8L0Ld1ZptLnytBilqMAzyUsYlMzMGmmjUc5cELpgMW9G3uJqdYT7+?=
 =?us-ascii?Q?OejQcwAI+Ga0dexhNVyKGzGVnLs4PnpHNXd9DQd6F7+4QkMZfrwqgld8OYGO?=
 =?us-ascii?Q?vk/HxSN2hAAWbks/WefHedcO/0/23me72JcFpIm1VpvihaOANWtPw7+c/EyM?=
 =?us-ascii?Q?uRZ1dzP1mGZapVZIsSfKuvuUYrUz3OqYAdMYGXpQOywSaCnIMl2ofKkFVRdd?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01962876-d440-4000-05c6-08dbe0270d82
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:54.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9xq//iUbdystlDKLcSjNDRE/W3ESj5lccrKpwDSjo+l9XR35s99YRXx92IksJ8B5gyFmHIxRdtyhppt7zwiGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

This patch tests newly added dump commands for the userspace PM. Add these
commands into userspace pm tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ac7cee3f4dac..581d61448253 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3389,6 +3389,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		ip netns exec $ns1 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3413,6 +3414,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

