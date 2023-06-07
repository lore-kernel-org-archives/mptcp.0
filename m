Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE713AD6
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmZ8fZ0zmFEPU4Byh3DnznKV+S516J1bIwov/B3nMrboDJN9GNYvFyVS2qUdiZX86BOXqULuWT4tHSHL2PVTjfnXnBteftm9MMN7b2rgrXgPkimjBR2zOsnJfd/JTqCOSZcvnRGVEfzpP2sH23ug8+q9OBhZ4TCpEQniEteLdteNLVNFs99CykWnK3skSDayH+c2Di/05bAheJbIL3lONeI9WqoxZMOlRAtAjHgkA0X0nwxqaFprdpZc7oyDQ7Fl+uroth56lpFSYKzMLxgMacIRadf3QXzXG75wxyaY4+z0bZCyyCbt4uoCmZ5TDBSd/N8Oq+A1t49U39hQjezJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS8As4uK99vbWlsOQKd2G7tFoqn6NMJNoVAaaXMCExA=;
 b=jKz9YWXL8nblveJA3f7dfSycv59JvkUZp3vS/Xu2KxhFPmljmp3EJjuUafIhqGCIxxJIZMv0hE4Gpa7A5Luj52vfQQlLmNHVCanEZ+d5zkWfSvzrvxdAYjfzOlQL7EfOI7xB6wiZrcapTQRgpCtoAaKO7A0eT3I83/kkWp1Z1l73JYS2eHDjdUsDpma0srMVYwG/yey5GkNfryMYBLRLszetjU8mj3ZxzbnWFQCxlG9usbcXLPFWhbUwwKKQWZNfD4+bjyKbZ8PRq37vfdD2qzdvjpM1KBJ9Mh9HehWgKeu30HDMznCpfj9Py/CvJQW/lEoDewHdKgIoRmG9/J6eMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS8As4uK99vbWlsOQKd2G7tFoqn6NMJNoVAaaXMCExA=;
 b=zi4MsivSpbfD1FgEbjyF4RodNfIwOrl6keMvaP7cDs54r2HeFK6UDlBM3sg8bplC9qe94TBKWw2Ye5PmzIc/WhXeal6QE0vz16CC4ImwBi74MT4pGaQJvbws6l5ITyk9/PPlkzsviF+hM8wBBDS5/HZMvJ3Ux6Ezqz1Hpkf9jrY1Bpqz1UggheYb3Mv00lbHjlnJ+z6DK+bzp2y4y5/a2URrJx/+igjOFcwQc1LbE9efqlcdt0tjOfWjdQiH3u6F0q5B21T+dv19nk8TnlZxk6po11Tt1bI9ryE3xdNsZqQ6OpTuZ/cPwxDIGv/IbMdNkH0xWcrITtnEwU93UXd3kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:44:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:44:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 0/7] update userspace pm mptcp_info fields part 2
Date: Wed,  7 Jun 2023 19:44:19 +0800
Message-Id: <cover.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b98f5a-888e-4293-9f08-08db674c94ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kmQjs+pkJ9FGX3Xp1+NWISY/XE4O0W/zfVlEGQ0Hc8BJs70HaoCTVd1c5JVS7o0jA+x+3nTflp2iccP7gEc90utHnLd5nC+zqdaTBzS9qN044EBZG/K4Mt31LiAJJoSyiMAqvHbMPzWoCSCikjGj3iz/fx6HKrLHwf4O1XMn3Os00N6EAcgGEtnvLiKZHSjL8YpGyVMiw1l4BLlzoM9Estb3YAmTpg8+DLydukdG/09nqMVcBguPQ+OIxNCnRADju3ixi1pNnStieWEkJLHkGTsvbABbbgUh2wr3fiZmHmyDTHhN34N4FN+Zw1rKhy2LtuMCDHCNi8wFzDDRArVSyW+WInoRx6uxgTcAfRMrAr8iUrouhiakutSJCKLaxzAVwKq8YxasawGlQraAeqpqG3A8vRw61SmN1wPy6vfAVqVCh9fP1xJimt2Zs2UrUMh5n3c0yY24nfyHseQMnx+oRriky+lM+u0+lJXq02ahl2KL9WIZ0/lb3Bj2X1LyTOchSG3BJXRbueqvXZxQH3QX41oNr5lufXpubUDJtFky4iW0wef9kgXZjtCWu3erdkQs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mwcKyOfSkeK/79JXkXRJn6qTx4E9imRnB2fnvIAOBVhJQoVG+An8svLxyLzR?=
 =?us-ascii?Q?sYytHhzM+YQ6NqX90Hy/iTAnZGMQKE+dV7pXTMrXemNITBES7h75ZxQjxlq4?=
 =?us-ascii?Q?GGyr+UQ3at7fvp0a5FE8/4AK8tfLEBKM3V2nxqtbVHgS87YCn+53XxLRFSLf?=
 =?us-ascii?Q?6d4P26hHtTPs9wM3YOo7gle6woWu1udAuC0Bw6vyITDOMkiQP4egSzp//ahb?=
 =?us-ascii?Q?zP014KCpcz70u0O7TYnKdB5+e+DuqnezRyxKPqufRzKO9R3ISqXpQ21wuEuI?=
 =?us-ascii?Q?elqhaaI8IJaiR6+EUlu6WjW5jV0+o8XKI/Aty28VZQAUk8uW1wHjhXpa5RSW?=
 =?us-ascii?Q?4p6NfOkGTnui1LiiSHG4XrXLSzYdo8cJcL8jncRRvrRJ27jJGTAWseUDtQMH?=
 =?us-ascii?Q?mZk4O/3gVnAk7gPgRq2y/DHeVRcO30C7QYtnma6WaC2cd5TI3yfXonrcq82m?=
 =?us-ascii?Q?N+nRDDzNqqLAiqjoSYcWGuGVX3fSwSisWLxeGADVtW+pf7+IwzI8Xn8Jg5AD?=
 =?us-ascii?Q?nh4YPlZotMJupk67XFFr8vcwS/lz3hKqdauNnmn9pEt0G5f+8PadrVzivzya?=
 =?us-ascii?Q?tUvbva54MwmZSpPGzWUlX+KDVyCtRQWk87EgUQYiVMicaKJYmZ1lRbJlFJzc?=
 =?us-ascii?Q?9yMhOuZY5sOZu5KZF3NE2i3Q0LN2bdpQJGmNz9/mdibRUePPkAQuc1N14SFm?=
 =?us-ascii?Q?0l7vv3LorYsn99FdpF1/uwiOxlmd8mI0HEom9sD+yWIpX9A2ix6XYQHY3heX?=
 =?us-ascii?Q?mczuz2m3ogFMvOkvcmdPS0RcdnXUR81Us0YXMsG5ilSNe2ZWFmAAEqIfaYiv?=
 =?us-ascii?Q?gN2hJ4ZNBuKNRn7Fz+MhdNDlJZuBt2fYSYAm0vkW9dOLx8yTKYN2TEhHSyO9?=
 =?us-ascii?Q?E0PX5EJT4nvI04cdNedCgSLEuKx6rsVDh0hGclzL7adDKKZZUnET6Ze2HXGb?=
 =?us-ascii?Q?YGBLHVaP7ATCMnFyHaaFbeaxs9qJIwAjfUWszOkLjCDoRF5CaXlSQtu3vGtH?=
 =?us-ascii?Q?irrxKm0rHbV/H/lMsSuMDHxT19bqe5leB61K2eFsvnFAGys+t0wWODw6knML?=
 =?us-ascii?Q?acRRSkFKJJw4TS6VUx8S4ydmqxzJhyffOCXg0xPenagKhzulREbw1zxP99DV?=
 =?us-ascii?Q?AZeWWlWVWR4fRXcNoMZ+XgtBfFzF9OJfN//L/X3tjBPWsYu5k3hru5gYILWI?=
 =?us-ascii?Q?Gs84KaIKPKohvbjMaoYxHu4cf88nejgrV7q/IvEbMFN97mO/sTbddQsOLGpS?=
 =?us-ascii?Q?ERgnYFykbNR23KiNet1JjzZZR1GEMkF1EEfHouGFJC3nCVv18vT+KjMtIe7v?=
 =?us-ascii?Q?AQ0aJQdRdB0V4wfP2Ep6XxnaDeuXIIXip+5Nsap7M1fFgYki6/AuyKAXkLXI?=
 =?us-ascii?Q?YGQRwo23HIlnsy7Efyta1K2LHGELWeAUmdlF+DFSIHq53l+R5b0aM6oqicWE?=
 =?us-ascii?Q?BmYak2X/x9l4HdEHpDY7odXcSDfj6wqtKdr2X13F13oLu1xBq++QlLcrszJp?=
 =?us-ascii?Q?MkkfmYx2uCNbqIEZdK11ffhnBv7v8dUMelGdVcHBtIrY1undWHP3q1mVcJIt?=
 =?us-ascii?Q?8LoDRS+ga7MXVusdFUOSNVavoLcYXxzHocxIHTlF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b98f5a-888e-4293-9f08-08db674c94ec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:44:41.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e68kG9lSWmBpmWhl0blteTEc2y1WffJQDQSRO9GQzcyffJ8+DwzIL0u3S3nYxRwN/GIFTU4+XqIx6VDc3fhRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

v17:
 - rebased on export/20230607T094151

v16:
 - address Matt's comments in v15.
 - the last two patches in v15 is deponed on "selftests: mptcp: skip
 tests when features are not supported", split them into a new series.
 - this series have no conflect with "selftests: mptcp: skip tests when
 features are not supported" now.

v15:
 - fix the failures reported by CI in v14.

v14:
 - rebased to "selftests: mptcp: skip tests when features are not supported".
 - patch 1 "selftests: mptcp: skip tests when features are not
   supported, v2, patches 8-37"

v13:
 - fix all the failures the CI is complaining about with the debug kconfig.
 - rename endpoint_manipulation to pm_nl_set_endpoint.

Geliang Tang (7):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflows infos
  selftests: mptcp: check add_addr infos
  selftests: mptcp: add pm_nl_set_endpoint helper
  selftests: mptcp: pass fastclose to sflags
  selftests: mptcp: set endpoint out of transfer

 net/mptcp/pm_netlink.c                        |   8 +-
 net/mptcp/pm_userspace.c                      |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 545 ++++++++++--------
 4 files changed, 311 insertions(+), 246 deletions(-)

-- 
2.35.3

