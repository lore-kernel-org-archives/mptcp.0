Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF179E4
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 11:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNTr2IkhX5fv1FAQAKv6rzVn5EEg8xv6SxzqJkyf9xofBaXMelHpBnLLZAZ2WuTUOHsvgI9GttZukx2iS1nS9z5jVE4FoGLIZiG91ZzBjRIO/24PSIdNFdzNfmjdlht7WNErY8Zwq8GYnlKnYWxsDdsKvbXVT/EQdWTfqnYnovFfI16K6B1wBI8NUhH6xcKSFWDGSJibdJ+P4fuqiy3PxZTcYOcPaPdL9K0W5BMgVtgBuullnuaSMGmkff7G3T55lfETlj4gqhcYsWpC+JQzb/hI+q95hZurklG3MYQkyZGsBgi5i1E5QxdFFwhqynGNYYMUrHsQnbENwV087yTwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msWpftxtBYhi4F/vyxfgeHNUPm/VmwmDKYkSATjtVn0=;
 b=LL2k5J3Z7fvcWtntoGcny6YM/xiOFqELtSvXXj8yXbDRKJnoiXNhig8URyAyX4stHEyBZ8ZMVNGqgOr4UtaHY6VrN1JZonoogLBNbdp3ARJ90O2tvxxEYY3BcdmKLYhKMpPeftL3vP19XxVz9uTqQW8JkR0NyDN58uBMEPT+4Y08bSD7NeAQnWyrgD1nvt6b2PD3zDpD9gd+rMx0cjPQQT1iYtx3vdYz0ldkVDKaaDk4XEptpU/Kd5oAm66rTA665Xz64N8dDL3wlYSJ6cMEPK5g0XyBZn9wQcPh2AnGqR10v+/I68Hj6bp7iHU23yF2EvVzQINU5aExReAhv95/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msWpftxtBYhi4F/vyxfgeHNUPm/VmwmDKYkSATjtVn0=;
 b=RPiWP0+PRvdb8OkOmHxNi0oIMs1MvXQ+kkiU3ip+oLX1rNP6Sn0PoJ+diJ58iuCnKhGEIIm6z9qY42Jv7yWAw+sJ7A9P+jw6GT3Bz02yPK2yH0q0IAcpPnhN5Vy0U2DJiX8ugfR8Djeggnd7XQTRInZYsX5/RzI1G2ZarHKYMJ4zIzzeNp373Zikc5xPZiwIeD/l2jgQ2KlQ6JJfX2aptiKiGIDOTuj5D+zqxxmEnoAumP8S6+XoexrN8bEQ1SEm300nJP/y2m1rdzTRMvMXxU0Z9GoQipTDxLLQ8A2gLBNtT+ksQieqNhLKhb8AUN2mO/DX7WvjDC2njA2aKSLi9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 11:03:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:03:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] Squash to "selftests/bpf: add two mptcp netns helpers"
Date: Mon, 31 Jul 2023 19:03:17 +0800
Message-Id: <12b7a61266146f6cd9e4e366ca3d562afcefa794.1690801329.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690801329.git.geliang.tang@suse.com>
References: <cover.1690801329.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 472ca8b2-f229-458d-5062-08db91b5d2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZyHXyVnvdPuZ4O6Lz7tCaDjmDVnesjSVmbKfZvnv0xWok2BK0yRnzuW87A2dIm4utDRYiAuEA8YYjulGAgY+2WZ8VEocKG1C5i44w1IRci6G9hcOlxemExIisluOXXFz17D27BAe6iOqm1PkPdObaEVEp/ocy6ucx1mGa4WLo99GXGqDeyWQi+x2HjVjLflR5eosCtqI738fVbFga8pFS5k+yPnRvkAEN50lmZNvEUN2bvwt7yvlW1quocN/Ja8G+Pjevp7r0gVQn34HtqAYmqoGahLsmEisoNEvIbrdUX7vg8Qmub5T6fg0ILzjIjOnlnHMPqiYt2KjFQ/FCE3AKwAQybyePrBzRvuWazjrMX0E8IMmK+yxFG1K2rM0jjkJiyK7rQayVfUNL58zD/BRms2g2GVD3RA8+NUS9prYev/nrFWdV9e6BBMfH+ZzLP+z4RBF3eq4jKnbEWm2KSRssPZIxGV5M/IwFyK7/gY3JqIJpF0LYS3zNb70/8CoQwQ6LckpB1RuDe7Nx9bVCLcoC6japrNDRUd0MmOIKygzCYqakqMy7z01XzBNMHC52QP9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(6486002)(478600001)(6666004)(83380400001)(6512007)(107886003)(6506007)(26005)(6916009)(66556008)(66946007)(38100700002)(66476007)(2616005)(186003)(4326008)(5660300002)(44832011)(316002)(8936002)(8676002)(2906002)(41300700001)(4744005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eoDwMpVDFtN8i8bCCXj1M1MyH5Z9UdWfeHFfJber/cEzVPdlc/j11bv80FS?=
 =?us-ascii?Q?07U5GEh7MWqlJi464aAXNdSvEqhsYCZ1rAWbsVA1wQ/u0+1SxEtHk9cyHrM1?=
 =?us-ascii?Q?IWjLGpaglG/ROy+GIx9qGzyJMCpqWpANc91RXfSeW/8zXzxVYbwT9uku+hXH?=
 =?us-ascii?Q?onYE6CUURmYrhvrvLNGlJTgW6/Tebji6jtXi7oJShDB+gRACV1unjdtkIPaN?=
 =?us-ascii?Q?k32p4e593vODpBdVVvdr4EoWQQab63ZmgEkQDT2J2SdjRm/VYvyRRbQ7qUgs?=
 =?us-ascii?Q?W/16NMNDXpqFsUlfeT7v/QUjOnp2Rfb0FU3idtenfMHJeH0MyP74ZyCPWGph?=
 =?us-ascii?Q?xG7wsVsKcpxrVmr6qONay2ClvbqZd2vgZ5jQfn274y0wu0dq7lQtoDjtNzyc?=
 =?us-ascii?Q?T1eY8YmU62GdTdSeCg5jmml3YPpXlXFX4Ylu9pxq3/XKKg3VHzaOyrUsRn5O?=
 =?us-ascii?Q?SXo06sDNYZPhWvTfrYFVKqXtiyIN6Z9ZoVaT9cVQEVBSeU6O9lnafipxes37?=
 =?us-ascii?Q?uiJ3Vk0mQihJGxAVYEFQkku4M07XhdY2/N7vzplYiqXQ/39aVVYeDaX59W1z?=
 =?us-ascii?Q?5l9EsMuvaG9apyITsQDSDrzhDvkfnMIXPnWGs+xEvbpXmcVfF6d2vA85dWKN?=
 =?us-ascii?Q?8XEUiqO2oBPfaa4YbypbybkubyJJ8bjJi5gqWAUvRvK4c/ApB/44E7Ux2vuk?=
 =?us-ascii?Q?6Ke/oHqW9O20fE5pF5KdxZaYw/IvbAaj2wbEOHr+hGxPZksGvNK7WwIHaJ6a?=
 =?us-ascii?Q?utJiQ5isLQeLFuXgQiMHz5n9CAvykWSqa3zpdN2apaqVyAz3wIZJoOPSAVpm?=
 =?us-ascii?Q?l5pAb89UkH9oI9EQhPu8Xj+tauHyLBlmhKHFyXGqWHWgN9FUJ4AtQjq242lu?=
 =?us-ascii?Q?5Op7NEWewi1iv4MfNM2y75A++h0BAEyVBrAvZYe7AJaPYUOhZJA5XslwGi/S?=
 =?us-ascii?Q?bv10yhQTyAJK5YrRcHvvUsz6TJ7FCZmvyB/P5VQSsF5sVcjUPckC2OAR4lKx?=
 =?us-ascii?Q?vIOfk9ZSTFvAJkEOEn5pHPc4ECqxdO0Z5+PyvKR6GPpRmfhBodbXYg15vhBt?=
 =?us-ascii?Q?lkTOHywqGnvmYan2ue5w3QxP+zinozFTT0ZcsULFY7pyQX1QcYzqgGQPDqRi?=
 =?us-ascii?Q?FlvxR5LwqBn4k0Vnd6/ois5rdSkaXgEglxpbIwXsDwnxvwsLOgW9hfADYYz5?=
 =?us-ascii?Q?d1MzIVImmpx7Zl/1lz3cT1w1Pvm805XYscmXsPnbQ+wGi07YFt89wqFHOFpG?=
 =?us-ascii?Q?nlJ9CWzZ9u4dLSYpS25toB/WY1AcuIxjzFJ1k4MgJcr9pDoAD/Ddz1QPdynO?=
 =?us-ascii?Q?CUICJKgfKOsdHjBNItQ9qx35fSubM9lxhXgydh4Sl9J23guq8hUtIARAJgHv?=
 =?us-ascii?Q?uaFZpVO1ElbUCDOcx3hHZkqxm7P//r0bWCdPkNkX8Yxa8bkINW841oiODLMy?=
 =?us-ascii?Q?0ALpf8DVetK+O1PY4nhBzeOMTU/XUci9vp5d48hgr5YD6tRfvyRv3+zKJl/E?=
 =?us-ascii?Q?qWscW89x+BsjwsbO54cAz1PWMSTtK0l1IKBA4sFw73W1Qeo34E+lWuMaWLL6?=
 =?us-ascii?Q?4MPUZMCkDVPAHYBaP4TcCqZ7YIcMPKsr9BMLuEFQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ca8b2-f229-458d-5062-08db91b5d2dc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:03:51.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lytOTptpdRAuPI5ux7XkdPOwcuw2+ZbaazD7NJsyvGfxM+234m/W2t6VyeMmIRoCO3GqpizbixVIImQrczbUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

Just drop a black line.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ad6b5e889d9d..09770aa31f4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -198,7 +198,6 @@ static void test_base(void)
 
 fail:
 	cleanup_netns(nstoken);
-
 	close(cgroup_fd);
 }
 
-- 
2.35.3

