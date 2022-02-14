Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2EF7E4
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644819799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YK6acx8/0o7F0snb+HCsuztrM+6AVZ7Ba2FTr0A0L0=;
	b=TNnrcH5dZ0JB1JI0kA9ZKDzTyI1gEo0DShGV0Mi6Qas/7K3rPjJQbjRmq+hRTC34CYbMDx
	lGWOzgtBvNWnA/Q7nBCpMkVT6vXbx2dOxvnzpvr44sQ7R5O+SWrEX62vw0TH90Bu0P8VCQ
	Zqp/3VcXE35iogrZBKNch4f2kTe5fZU=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2056.outbound.protection.outlook.com [104.47.4.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-QepRkrT6M3W8oocrsT4Jgw-1; Mon, 14 Feb 2022 07:23:18 +0100
X-MC-Unique: QepRkrT6M3W8oocrsT4Jgw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU41CkzCdkYSC4heBQjni1rL5En4zUHnnhBcQYXkOw1tUogIBP+ri3kkrhAz+m3j9UTi+MyAGe+RLV4Djc/i6qzKflKb1WXm12XZB04NYrDRbPm5E0t0kHxRztbuxuVgdMtYAMsseDmZxJDq7+8Ehrx6TzBDygHDFeFo7HdIMZCVLD+FMoJHVOkFo/NiiqzeTbCiNhZAlq2t7KQdVFAoRc0StLctKDfxoVL9SArVncF0T5zM/Radd3sCxwkxEvZzBcgbhX+7Ms0pnVtrdWdyskcEG5xZagCGQ1WDklJMKrsrqPJvxWjdOMnnNDCi1Alt6O4fIy9jMSIEwBq5IiKgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f17RU0+sZ9siPrxRcNbbs38aDlOEM8y/s2N5ZChcObk=;
 b=U8FOJX1S2hAgbaukMaImxYks5U9YBgiugaIH+Y/0pUgth9uxEV4mhFpgRKNqCzWQfvzjlg3FW358rS5v15AZmK0EAznZyw2v6POL6fs7jhZgJd61X4nwe2YTQWvTnmjmU7CTGGJC8i5IrTj7jnUJCd4Nc3tqNUKFH6Li8kY5m3xh30oKcuA/pVlxe6ToT6xVzrIOE5dKWqRAspbg9X8ZkXnk2qdlzbyVOXOuTd+WnKRE47wX/akvZKdClsDbOFpbAFzUN/KCRZ9dBAGTY9AjMeQ1NcoLBfBFFJRkkjaYKcKJuYLY8jKEPgOq5TRcZeA/HUzvmGLatsKtPqflWj6s7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 06:23:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 14 Feb 2022
 06:23:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] mptcp: add tracepoint in mptcp_sendmsg_frag
Date: Mon, 14 Feb 2022 14:23:21 +0800
Message-ID: <58ffaea5f524fe49c8bd0ed11caa45a2f6a79e1e.1644819421.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644819421.git.geliang.tang@suse.com>
References: <cover.1644819421.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0674737f-41c1-4c88-ee61-08d9ef827cff
X-MS-TrafficTypeDiagnostic: AS8PR04MB8609:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB86094814B960EC54EDDA4CCDF8339@AS8PR04MB8609.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TL6KwN1P6Dw5eVNpVZcOEPd7AhNtVSdTau4qo4wcFIRMQHNi9nIlVkh132tAJYBXHjrtfWq0Nk3snDf3nhm4VU/+K5oRpOpnXCJPreN/8l8X0l974vN6ADmS4rjooP5QXol59pGeqtYH/OFHAItbYek/bvRtQOoTfMjfys/ZaKOeT3fSFi9B4LBdtY3jQmDYXzHfPezvgz1ll5md8kxupPzLnRK6ROT5YztzoXl4XMpC2qJDBxmHcGNPE70XoZ+xcfYfg17WcTUL/X1CLpfKtEbZa9RjbG+wb/NQuym/nUs7HVsVfJRQNrOsmVUVq2H5Tde9gcx/6Ve2Rfne69t+UMgeW2+OcgDEQtBCMVMrzM3GbrtqFRQeEuVbOGvUqtoMW3UAUMfTeSnSwIUIQx/9LfQdXixxnEeyo+KkAIubSKscv79C1ZQi01ZTYAlVMByt67kxpRAiTkVKPr6zU1ez9VAPzRc/oZzMmVfNJiYvqPEZz4Piwk+blo648uVsB38jUheKXQASHx6tndlIAs9WdLL9z8pOcahEMtk/3j6B0m+LRuMx3oSUQB8w+yBqQpBXxDr8N/WFBZTmLXYrCcPE7Lo2R76iNWL/TJgwS42yYcuU1KspmVGaMnjFNDeb23wXNf5j1iQKhBqRWHNsq04TQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(2616005)(186003)(26005)(107886003)(83380400001)(2906002)(8936002)(36756003)(5660300002)(44832011)(6666004)(8676002)(66476007)(66556008)(66946007)(38100700002)(6916009)(4326008)(55236004)(6506007)(6512007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzRpiU2CohFsiMA9HXtLD4Ae0sBuELIRK+PCO3PB5GKp/1OSjPLMyjZFd17W?=
 =?us-ascii?Q?QNVMGbFhhltHsqvu0X88NmEIl3AURtRBdTRqTDGhgbXmreTQYi+LicSAqxLJ?=
 =?us-ascii?Q?9uVZoDBCLASesVIh2j6GiJKPi3XovIGvFq4IB3uK0IRmgt5mt+jQmMKzI4b+?=
 =?us-ascii?Q?ueVcMSDQPDfg2YfLGGMj1zbkUWOLHj9rdn8jgC8VFon06YrMMabOb5M8C1SI?=
 =?us-ascii?Q?8j0FhxYxIkUFlpRllleGiI8NNSdSPC4+c2yhD2gR5bsPLM4SGG8Lr2pt2n7N?=
 =?us-ascii?Q?h9A2cXW2bzW0aLa6l4INjA0arvxhzJl++sZOUoQzNtJrBhGsRlSa/KaEvhxC?=
 =?us-ascii?Q?mw+7sA7tdB1S1lqcrI12SJEPsgLpYYZ+g1CaF50yTkGoGTXL0KZcghNRK03F?=
 =?us-ascii?Q?NZq9ZFqxrtZRPYKsPvuyP3wXxWfG77Fo+FgybyeLIvU491JWrabj7ZTP6iKt?=
 =?us-ascii?Q?wLTmP0iRFTUKfUruyAY+OqEM4wIyUNrDLOjTtEEJGjm5IBxod/FJWIFKV/rJ?=
 =?us-ascii?Q?LaTO6P3vPOLDhXYBTje5wvbrDhqWSa1GOQmSjwtmq2EtPJwelZIVCihLxb7k?=
 =?us-ascii?Q?9v071jvjlQ688soJi1CbUUWniEuzqQz5Yij9UOfLLtX/YGKea2fl8dKjGHwq?=
 =?us-ascii?Q?bZCtK1DFjZtjT6YTSDJQ1YSfYJq3zSnEFoJzTq/bswKpg7jK+WoNprMKe9WO?=
 =?us-ascii?Q?bx1KqEyqSpfWd918gwubVFeZU8/7Rv8d5OPDWPR49aI1QGKmFqfmcJdwUfjo?=
 =?us-ascii?Q?i6Jy+JNtAahUdNFBSxhS3KG8lefUKYALtG9z3vZsnvso/L9Js16WKZi1+xHX?=
 =?us-ascii?Q?onO+OU57xRqDGBv7RYtUbU41x/AQorbisRnEg3MrVlCJN72mNCNiO2HlcoPl?=
 =?us-ascii?Q?piAWUeNwkiGAeA+xyJ1dXDmTIgRWlx+Tg0MRlqvhofprvOlJzQzwxqNSQMu3?=
 =?us-ascii?Q?gBvlrIahsSidoUkcAWiHHqC7qGbW7C3StwTtD4XjZs0RZgHTJK6Vr4O/GiYm?=
 =?us-ascii?Q?Wg4Gwlbmnkv3T+flQbTBja4SNMLadHtwj2i5TlH+tGtsV+4voKYVDvNXOCBp?=
 =?us-ascii?Q?wpPz55FV+ZQT2/MOMTXhw8Fv1S+FCKmJ7xFzy+klJoUngyzfzGX8LKyI7sTE?=
 =?us-ascii?Q?2lCmTaawGfZcX6f9Z2IjbTC0zmQWdtczZCCUw4l1Oc1fnNzW31QLUuYFFsb3?=
 =?us-ascii?Q?8ZHHbpA5WJ7+9en2E9f6ksX3o0vjhDpXsZKgvHpGm+dL6jPzFrNjb8t1IiSg?=
 =?us-ascii?Q?1bM+SFJeb/LbH91JDBiPWge6TAskbu9TByhLDqGAWO1QflCztJQS5STrMNKI?=
 =?us-ascii?Q?22sxAz9QPL6KZbWGfUsIKUY17g1H/9dvMV/mmv5qrEZCCUcz6UUrUQbR0B91?=
 =?us-ascii?Q?goAwvXULsXvK+Rn+428ngC3yt2Ne2lCGQk7HyZoCjvwKJr5mElxnin11Wpej?=
 =?us-ascii?Q?EMzIn0afShr6ba/Bz2Qv3JSpclmOgfm0t1aKRPBCEGImClJ0iCjendKQGwGq?=
 =?us-ascii?Q?uTkI5haq3LwjT50QVYSyBXLOIQluUnE9wpqj6PRKaeAkCHULBKMvw9ivBXCF?=
 =?us-ascii?Q?1gkIL8geyPxEkOZAhKlPH7lcY6uigVC7RqD5eMYkH9TixybtNp4B/1GcjE7D?=
 =?us-ascii?Q?GYutfkl5ZsUX+Q7F+kUiEho=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0674737f-41c1-4c88-ee61-08d9ef827cff
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 06:23:17.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXppR77XpmJ7R/YhYeDPON9Wo6xkXcT5kjP6mwesgoh1EYNBBKh25oOlH8X7Ha0H6atITc9JQqa1HT0wcB1aag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

The tracepoint in get_mapping_status() only dumped the incoming mpext
fields. This patch added a new tracepoint in mptcp_sendmsg_frag() to dump
the outgoing mpext too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/trace/events/mptcp.h | 4 ++++
 net/mptcp/protocol.c         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index b4175a52bdb2..563e48617374 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -117,6 +117,10 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		  __entry->csum_reqd, __entry->infinite_map)
 );
=20
+DEFINE_EVENT(mptcp_dump_mpext, mptcp_sendmsg_frag,
+	TP_PROTO(struct mptcp_ext *mpext),
+	TP_ARGS(mpext));
+
 DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
 	TP_PROTO(struct mptcp_ext *mpext),
 	TP_ARGS(mpext));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3324e1c61576..4599bde215b2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1371,6 +1371,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		mptcp_update_data_checksum(skb, copy);
 	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
 		mptcp_update_infinite_map(msk, ssk, mpext);
+	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D copy;
 	return copy;
 }
--=20
2.34.1

