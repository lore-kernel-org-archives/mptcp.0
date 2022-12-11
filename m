Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4A10E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF9GM6CIxxykSUy1pD6nzfIgD3/kKQVlu1u3PAbIYaW6urjF0owPvh42+8V74nbIpd4PjW2R4e35nBKKnNTUFOjei7UYxRARC/jO4+9etV4gi3BxB0cpHca2010GSFrTEIK7GRdAL8h+sDrz6QhGgEsJ3vuJ9dMansaysoAIj8sijEGd0NiQUvO6H7T6C2RCAOXcP2A7NPuoLnnf9DbchRMHIIE5j4osI87+caITNsasgDhm6LNA2gBbt5ytRQSQb+qZ5P+HAgSFZK+zkAFPWnvIF//EHbulaTPGveyv7dySFoiJEI4S9RgOIL+xn08gjuiY+96EnWfDgp5yIIHTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r73mL7KIJbbTVTWRdj2JMR3oSi7npcq4AR/SUp0ujvg=;
 b=K8DZlekGTFMbj0sGgtoajpkEVVh0WNLXubW0egCn8d158X+Ek1EGIpq2jXfaQohscE1dsvgIjOZC0kUDIwkvdacwpV8Hg073l5tEJ662VmjZHSRNwpwrDY5EXl0g5ofl15V3CvUAl44/XqMXJupr9cjDDaMeiWN1Q8jqcIvgfTD7HqfDXa4T1zULWaFhYNZ2FvhFHwR2YIr36wPFViBFLMJbEgVexq+lxXEHobrv+2l788ylHzSAU1ra1DhtiT9NSY1EVd6j7sFdOK4RYQLcYjnYnCa9IIqeYkLV4yf4nviGR0nYdIxlG1PqZXw1xcTA6XYuvj2/jPBLD+tjxGoIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r73mL7KIJbbTVTWRdj2JMR3oSi7npcq4AR/SUp0ujvg=;
 b=mxOvFvt5zKMEgYW4wqkcFnqFWdF/qBvqoY8ZXDz+BZZxfEyk10Wdx5Ybq/EKchsk827jmRK4EWoWKZErFaINVY6bUR5r/osFQbR1m61Q/60RV0W7Hk6wUx2wsryhItQtOoOw/fdJZOcE4PcZzXmW+2gqPUG31LNO4ecBbRxgd5cNGEMdh/HfLYx1X6pKntYwmkbVbiPMBmj+T9+OU9HFz3jCdk2xywet/oCKazES+MPFep/mCaNqzfo1xT6szzvgABXbYjLaV1qjJFCubn1JoZIWytP3YCJr0oLEWGTiqXG4d5EbmI9BM0VTXQ1yztAMANCs+60txHQJbduk/xgo+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:02:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:02:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/2] BPF redundant scheduler, part 3
Date: Sun, 11 Dec 2022 10:03:01 +0800
Message-Id: <cover.1670724098.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e4963c-8305-495f-e4b8-08dadb1bd3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QAJ0wDkXIe7TEu04z/LeQ3h52sBzNYi9FRU+HbOhH6sUpypaAJEMJktpKA8WOQNv0EKJcfwKOcB4CzNGe26KXBNz38x44n4zfGVyyUeCcGkLEL805Z10ll5Wd/Yw8N6yaA91gP88tSArckLEPWeqUyOU7TTcXhzP7dgQv09M9AU2kav+tVH6NW4o5RMzY+MyCRqr3o4HD1PEcFeNTNR/sJYVs3VZOKG2+5roCVO9+MgXKD5dSu6nUPt94z1S95VaObMJ/zrPsvaSzNVSOz7Zuvvt2WpDXIsJpdVY6YEfG15utiR8Z1krcQ5+GtIuW8Wq9lUmhhZrRUOAKy0FBUerm+8IXqABJeTSwk0gMn/F8CMnCxNDv5CFmVaEN4hs6JfjXa5tsaTzZPLgFv/w1WzZ+IoK+7aRzVcvvEJNX+iN1173eoLQO5aj677ZyS7bd8NUuRWzd5VnAlecK2smIbPbvMp+BT5dZa3B4QOqYKm5q6ywENF/TE1ZSb/BMlU+lQppzDzzLebtlLVl7ZbHF4iKrwGQJcqfssWGQBrnMgdk/xeSE19IEAD4M9fmJa0pPrV5ma3nbRKxDrAaLfi2RHOa6hY2dYPia1IVOu5sFLUHhI9w1OPgyyy6g1ASHuSVEMtG025F9+aM8Z4iQqKVq8/DSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(4744005)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUllmp0TkQaQYvbRD1ey/40obwgnPqpVNX8KqeHLQgi+iMvSo7dTXTYceHCJ?=
 =?us-ascii?Q?GQsqKS1ki61/B3sgqOHWE6fZXJKE7OoFquBW/Rku1L4o+5JInPaYPsKAeA+U?=
 =?us-ascii?Q?g30i8fa2EfMLntYJF54UruzFAablgmkQOYQrQuaan45CsmUpsKckwaM58D0V?=
 =?us-ascii?Q?OFNucLZkwl2n4YwmGwaCbnIdIOsshUj7c+OLyJbjpinYi65Y0UbE65JKhTgl?=
 =?us-ascii?Q?G2Z1QR+fT9+8xALNFxU8u3riKU4pILTKF8Qz96kpbeBEmjeDe7tdsaSTIOBN?=
 =?us-ascii?Q?KNELQwXgYO+jomt7ZIdy/i1Dgr0I2Xi22bBlXU+wWz8RMbPAhdU3UtRFS0kG?=
 =?us-ascii?Q?nqHRA4xaHjkR+Fxuuwh+gK3Q76RXBBOi8WR2OTEZDx9yraMTytXk2Rcu+12R?=
 =?us-ascii?Q?qz2ajxH4QmuyORnEQHcMjbW+R8ua5bocJpvN6T68ZfQYBv1EBgKjY2oHVXze?=
 =?us-ascii?Q?WBE+MCXBMXzUlff1MBNTTKZjQ5puN3eZj8cR8iBrVAkHTkf1mjXaqw1KsPhg?=
 =?us-ascii?Q?was3c5KskqlmYFbRHx+2Tjq/LeMzhgX3fbTOl2wAONDUW9nXlhqfRCaFLEyV?=
 =?us-ascii?Q?ijEm7EYDOkw5LjFXDqxg/ORA5kp4W6MHy7rgXAqV/Ozhgr2KNfUbK61YwixW?=
 =?us-ascii?Q?GA858LR12dYzFB30x22AQMdTvXa6S5p0S4h/1QIQJ+bTKCM2yzjhNZxh0RgD?=
 =?us-ascii?Q?jidZwtzL17pkFg9IUIPNNBw4IugjYpWbN7pYmAAU9ZJbPpf80f3QLm7FAB90?=
 =?us-ascii?Q?xTQboTOJJ2TlJbx6EXgS3ub9Ndj+KSUSC0SEFsOe4ALy01s1K6nQRS61WXxK?=
 =?us-ascii?Q?V5O9DVHCh6zpffIYkbI5iNrNCnlZFT3GhS09DWjmt3P7h9LzuULIyBS5G6uJ?=
 =?us-ascii?Q?0S7dUPYEha5IXjVblEP4qAyu8LnaM5aXU9388SL7gDyxM9PTKZ+kGViGL5gu?=
 =?us-ascii?Q?kzEvYrnB9fWSVV8hLfj9mnRh8AjrtQgvfTkr29bqdE8q9uxxJYJUXRLd3+0W?=
 =?us-ascii?Q?gVidYHFnHiJBnN9uYEk5Wyk7KqdGFI7JqSAR7/p2h/B6OON9mLT/VyZY6Qvc?=
 =?us-ascii?Q?0GYhdxFIQJhneu5875tU3uXSeFhKyz1hQcXDI3NeMmKoGoBPvCfsTOUXkf+u?=
 =?us-ascii?Q?JJAnn/WhvqK92t+7Y3kmvufPFKv8UyIC0/geBrACv/GLC/daCpdTEbsmdGsn?=
 =?us-ascii?Q?vClVsrropsmdiF6n/pCdJUIwipWiUh/AYKCh7luDH/D0rEe+UQUTAReTiyeU?=
 =?us-ascii?Q?jNIkp3YLDFI6h5mDM0sBhwLnxlH+HeeP1UKxoCFvNA6j5oerYumAVFG+ks6k?=
 =?us-ascii?Q?PssbG+v2wJWEr51zz7/xmZKGVEsxv5wxMII0qp7l4dNCU/Wmb2tWi+zV2FPq?=
 =?us-ascii?Q?kIU4GpTbLhmaTpVTabSJNERg4cjAKfdKnkkSMdfb1QPXgy8kwQvkdxWFFEM4?=
 =?us-ascii?Q?sYUjnkOzxRg1k85WVh69lhH0De4xNfEOA06FV4SIFbFK5fZtv23tQozkExhU?=
 =?us-ascii?Q?OpT2JHevigL+b3GavstGhL0Jd9rczaBtGuEx/VKCXEyOWFQBjgDXL6BCmBEr?=
 =?us-ascii?Q?kNjto7Od/vUARAZLjd8BLODyv/dbTH1LLnT3thVR/ts1mSKjFUqgJpBSkgHi?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e4963c-8305-495f-e4b8-08dadb1bd3ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:02:59.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WWOSM5PbZMuwZynSHeSMeeqYP57DxX6IKGl9dlOZn5JhcDfEqp/ZfYB/rhhzNWQ0EhOHKOJnbNGJPmv/Azv1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

v4:
- rebased on "BPF redundant scheduler, part 2" v24.

v3:
- invoking __mptcp_retrans in __mptcp_subflow_push_pending fails
  with a soft lockup error, so use MPTCP_WORK_RTX instead.
- invoke __mptcp_retrans in __mptcp_push_pending iteratively for each
  dfrag.
- depends on "BPF redundant scheduler, part 2" v23.

v2:
- drop retrans_redundant flag.
- call __mptcp_retrans() directly.
- depends on "BPF redundant scheduler, part 2" v23.

v1:
- The DSS issue has been fixed in this version, and all tests
(mptcp_connect.sh, mptcp_join.sh, simult_flows.sh and BPF test_progs)
passed.
- No need to set already_sent to 0, drop this.
- Add retrans_redundant flag.
- depends on "BPF redundant scheduler, part 2" v22.

Geliang Tang (2):
  mptcp: update mptcp_push_release
  mptcp: retrans for redundant sends

 net/mptcp/protocol.c | 63 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

-- 
2.35.3

