Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332A10EA
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKvY1WHzVPPOO6eB14Vi1mNdqoewRwYHAfRfHXxvLlLhG4ntyu3y0ATFXgjgX3PCs3/JfquJHVaHi9o/xM2zvcfzL+WLIoW6jqP4OqNyJ6eyEUuhQEurVErSoGUa3S/2s+S5jDr6I/I6N6rcUw93iSz5gBKyfyE6myqBcrYH8gm0C4uP0yb8Y5jtYH8KSWcx1Dx5hD2UoviKxBDOSTndIcZAdAU5teQw7V8WZS0UNNDjelf4D7z9KAQZDjA5XkMtB83L36pLmqm2afVYa/g/NI2jGAO8msPBKY4/xmpHB5g03qk4aMexNV7aqiFuootq7e4a2pIJCtdpmJJZF2Rc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwQ1t4fpJO5OW0XzyNX032jYkmF2CUh1UWOqnAE57q8=;
 b=MmVSdnzLtoxfgKbsk0p9i6qaHrJ0adiVg4hY/FL59Sz7esZE2zuvujN0VbTLVEXsx0FLr+t/1HrizUVaIb9Vc/iyFZxpFldI/6ekSkpMA+A/OtX/PU+6ErXLw2FYKbWBm5LG1XCvNTlFZEE59T3yl5sf5KrAeMolw3JBn+IMLLkQTmCb0LHzy+PdEzu22ZALzcCsXhTrgkGOTid/trnHjvtAAr7DYmaChpbvr4eqKvanUDMO2q8LW5mARYYUOTvqci2/lFPIEIgFyTyYQO4C5K1ErNLkejtHVN5A4l0S2CsnSmg1UTYhZ/PceC26j5mbL/0wfTDG19/pewbsLyC+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwQ1t4fpJO5OW0XzyNX032jYkmF2CUh1UWOqnAE57q8=;
 b=uSa0WFeGBM3Flrja+biKPW4VWZsLVrvAlzLbZEORPcA2fnMduiiUgo2Bw8x2GqnsdVqms4Sv118AAUxEcNJWoh37CKcLGiX0GyaXEVcPS4y7cdZVsKNIhgc5nl1XiitePH9EnmRfhqkBsQWOv+CbgYe+RRlQEvMNDd43DNYIEuIQ2eVnDNMQM6A8FYPmE0mJ5qysGzFbgBMvsSbzE9BELSg1WizSFaJ+cBuTJuTCbHgnrMjf/ZRoP2tDE12M6Jg1uRKQvFzlE+dRTvrsy0515qjlqRjexNDYoqeI39VzYMmmtiqxs+tqYlpdLleWGHh3ccdRWhTqcyuM1+pDzYHKpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:11:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:11:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 0/7] update userspace pm mptcp_info fields pt 2
Date: Mon, 15 May 2023 10:10:51 +0800
Message-Id: <cover.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:404:15::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d3eec7-efa1-439b-6b6f-08db54e9aadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0xoE2ls3MGbCJKLlW/SYHH/lakfDF3pMk58A2tkUUC7lp2AW7gxN3ovJY07mde4FnzBKmOKNG3wgeKBfHk5LyG7WnKho2U2rfj5UfVccsuaVXD5PKclze9lgrqdRiQ8NqCs+0BRAJ+xuqcI9zLo174AecvBFhod2/554O/ipA9RN1MNYJNs8sd7wpKZxC2S77jTCmxDcsTEr3D/7CrOULxpJCH5jpFDGJqqTs2VOsqbGv85Z/9x0aFJk+ncJ3mbbRbr+MGMLAnue+ineEVoyV801kVg87QUXVjoZXWYavZXq054MJn95j38Umb47i87w0vo4URna1QDAZqq7O6eVX9K82+QoLcIUFDt0fURM0hf7M69sE6qRO+XqHoFJTOEQxxftK7ePUGf6tDmBFdejBlrycbEuCz2t4hHseF7KwUZ1A0HuRp+CaxN6945cdAjluIwO1KizOtbNLVyvuCszZCPiTDwpklpP9RrFNr5s8+3DZ7GL3hcWf2Sb0mjDXvM2BmnlaDT/ARfuZ7/qblSeCfgmutYDY93v4XnCDaaGR3Hy76zaZ7/bv8WDfNjYD6q9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(6666004)(186003)(5660300002)(44832011)(15650500001)(86362001)(8676002)(8936002)(4744005)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43ZE3wXduUtbswP+Q2IkaK2q9ZHuRzOQE3lL0E90C8M6b+VqQARyZIrfEoqc?=
 =?us-ascii?Q?eGVqSjFzWRtZGufEtYEpZ7q6kciPpxtUuBFWOflobnUw9N8+ptoriyaiM6nP?=
 =?us-ascii?Q?KJNtgdYzlulpks0MolBqr8F0hOYZwi9TBJP20/8/F2apohOIHE+kc/Qj+wTp?=
 =?us-ascii?Q?332bw8/J+JMl+50ec2e8Mv14P6a9Ae9ENeei4t3VhwD8NVGaO/5KE3ZRAU3x?=
 =?us-ascii?Q?AWmU6OGrEBpYJEHiNwfjzgDIMidGbd0v3bqFowH0h4oIYyf/PVSR8+1gO/NU?=
 =?us-ascii?Q?GsU5lSDYa4PZKnTdu8q2kHab1nR5nRuPzU1WVtGUs5uaAStYH7DxhGFByaSH?=
 =?us-ascii?Q?lhs/JPDuVafB2ljyzCLrywnvYZtWvT1ZcwuvsN6kaV4iBd5PfO1jmWcUSPzl?=
 =?us-ascii?Q?ESzhLPT3Y6JQOlskfzo3T5ckIQrEeLvn2Vd0oxebpCaDHeD/oq3w9qXCkE/W?=
 =?us-ascii?Q?hnC9taOEZuX1q7u3YAQVsnj4tfqgEwlIU77ORNN4lRAgPfqBNy7UmHoeflHP?=
 =?us-ascii?Q?6BqA2moAPu7UAsHFZWfbazydfH8EXQWQxSagaAZtFCiHkn8c0ESUylp8qZrI?=
 =?us-ascii?Q?5j0fU3a69IS9xiFXEYavo0MMrzx89RNqO2+EVYY2iUHjVCm5QfHEBgIssZiM?=
 =?us-ascii?Q?refh1zicwhhvwJcG0aaNvgjjARDgqiQsamTCrcsV1ilIlQIzomK8xseNjjrM?=
 =?us-ascii?Q?s00/OSyMUGUl08g3VTWIfQOwAlH+0YOg0FJ48XGBKxhJ1KVxajRb5VKmo1uO?=
 =?us-ascii?Q?ccbMr4Vn9S4SslZriUCvzIkoDXOe20k0iMal6O2gF1tlYj9LvRz/gNAp8Ivn?=
 =?us-ascii?Q?t5JLgVNLVUtNDtirYvY65CmUTXNFJVtNSbs8xi/7zksopElPkX5ceSmkc8Ii?=
 =?us-ascii?Q?iWX96wAMTOUit6d+q+yqSdlC80A9L8LeFbDVS/xMJl+WutqBxa+pP9uVs3m4?=
 =?us-ascii?Q?SmoaAZbeUnRRhldN61heO/lXN+ur7KaLrlpIrAhGN+FFUSbcTIi3ymhddM2w?=
 =?us-ascii?Q?6Y6GuwMUDTyyBqXG0cvT+B/BDeo/sobyjN4jsCsVQKdEvk4cwtz+n268P8vP?=
 =?us-ascii?Q?CtMeLOqDzIPQP2kMz6gqM/nGdYBVWpEhsfZZ2f9LZqgZN5yMwzmWWizn4PYa?=
 =?us-ascii?Q?n2HzvYgi3SQQ2BWvpuPH2ePUXd1JRwHkXIEWWFc4FaUl6x2ZtjaH8/jBvWk6?=
 =?us-ascii?Q?cerph1tarF7STNPRg9wOah5K5niiK+mUkcgIPX6gLsurbaJEHNxBnptTYz4U?=
 =?us-ascii?Q?0eba5fBfm1xv0IGkuH5POxJduGUkEu3dOYC7fXJGy8XtOHT29A7eYM9axWe7?=
 =?us-ascii?Q?qFrdycT91kNYB+MacBd6W0CxX2sVR9i7kTFhoxg+XEkCfj7Ed1cllDQOzDXs?=
 =?us-ascii?Q?SjsgagVY2K1ozYCIaA3ldiYBdVC+xuorgfzwSPxWk4nxqK/KTpjY7jcjmWIB?=
 =?us-ascii?Q?Hoo7T+b1c+4JzwtVRsiS2SMD9T8smQK75zYRmRxrri89XPz7cIW/Pcvq+o7z?=
 =?us-ascii?Q?4t7rkR9hBH3mu5IHns3a/r0Fxu2K0ZJBP0M98VYM1JLWIS/1qi2ihFgRMxZZ?=
 =?us-ascii?Q?O+9h2HcUdJ5DHYHCjKDpU0Zpk+r1mqZczEDozuYp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d3eec7-efa1-439b-6b6f-08db54e9aadc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:11:17.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhWYio9Nh6tRq4xFsRzHxXJdTb5FFSGh2NmOgambvp/zpwIWb6h1H2m5xysx23K39vxBmb1rLIRMEpTGH9UKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

v13:
 - fix all the failures the CI is complaining about with the debug kconfig.
 - rename endpoint_manipulation to pm_nl_set_endpoint.

Geliang Tang (7):
  mptcp: update userspace pm infos
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflows infos
  selftests: mptcp: check add_addr infos
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: pass fastclose to sflags
  selftests: mptcp: set endpoint out of transfer

 net/mptcp/pm.c                                |  23 +-
 net/mptcp/pm_netlink.c                        |   8 +-
 net/mptcp/pm_userspace.c                      |  13 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 701 +++++++++++-------
 5 files changed, 479 insertions(+), 268 deletions(-)

-- 
2.35.3

