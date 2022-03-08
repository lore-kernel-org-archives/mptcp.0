Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AC7C
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646736465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J04diHMyvgaC99M2DX6BIpDEtsyxPeZJcfrA0tsydMs=;
	b=ZdjQAuPuz1pme2OxP5HpHExESznJytEltM4rBQQmeSqZEozUDGRfTMjyq75jLr55Sfgw0z
	Hrn/YmLbXq+VNJFJMtnfKoi66Tkr6+r158OLFxX84fpLlZ+5NEwJAVq0CIsNAvhPzyFF1T
	QEwz/FCZt7Uw4cJoJEKyTZsxOe/sqqI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-IiTw7oJjNRSZ9oMbRbAPUg-1; Tue, 08 Mar 2022 11:47:44 +0100
X-MC-Unique: IiTw7oJjNRSZ9oMbRbAPUg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTizzwv3PUrreynICD9fXAnBK6TeYC/HUcTeEzcqb3Z7/9IL8mT3pa02TFdJegYvFm3EJChCVvlacOEFVVQZ2RertM/JRV/4fETF8VVfdIWQvcMx56ZmdI5zWFq9a/0ZfIQJRR+vDT9bMWkr8+iMt6WwgjgqXPU2+uI2L0tIaFAIk+HCYheHlrNLyf9hISxNSDGiGAaRKywMxZsVPUexpxxIm419PRi6Qx1CEkDbOMbtqkPaQDCke8VRBCQYlGAEMIzZYLLh7iiB3TiJM4eBYqmWO5RziA6NYHuP9lndJx0Lo7t1RxfrzKr5BWwJoZ854+hcUEmray+VXRYD7d3+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olIiRRN9jQ5vvXSGaJl57nQYxuB8wPgxwivuy8KISy8=;
 b=WMuezgOTvjUlj1qSKJsQ6YB42chbYWK5qIciAM/gzFsGtib8beoWK4G7FR1bA73+/tTpNURfrysSDEtGV93WeDyq0dXfIp5ijJJMOWMo9096fGzicV2YsfKTNFWaiJFOol6bMmTVT5tiaoUUsXuAfdyxNjLGRzHX8CqoFH/NksEwPvt2mia+huPxtKxf1n/SwDdOnXD3s8pZ4QyxX0YY3yFNS3gFT33gROZ1miI6JwWnlTpwAwqfboZr+gg+uhTJpC5Xoe95XiW9GV9xnYofTwS4mAQzKvD6ZSTUgqU9/YjaGO+s9+j3wSdrjhkYDZRgPjRyuOOil6yYbVuS0emKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 10:47:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:47:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/5] add skc_to_mptcp_sock
Date: Tue,  8 Mar 2022 18:47:27 +0800
Message-ID: <cover.1646736285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fac1df82-7075-48ff-bb12-08da00f11215
X-MS-TrafficTypeDiagnostic: DBBPR04MB7929:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB7929EE0CDC61B2A2E0001A2BF8099@DBBPR04MB7929.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tc86MeUBjBg9E9o8CGLHo0hj7hiNdUR/uMNcCcc1QZqd2AI0DL+H3+y1jQO2/6H/t8gWaepjdD+Vm6C4FcyvUCtgBZayAH24Q1QJp95WiIugQZvMRA4ql08O8LyNZL3soFy0jKBhw+yFIfxOV14Fr+3yYmx/zi/uTMkk53OoyHS6p97rQM0I6isl6NYX2znxpGie3PUPWlk83KTmJOW1M4qeELxSgM3ccGcNzGYUw74h55AOdujFb7/wMSv8bGHHr2pacScu4PzogD4IG8PYx261cD4xIGKNeVING9UO0wYpkFlYf7BKo8E2MLNyKWGWNbiJ+B4UQO9sCTl/8kOyUGuyFG7nPibqxHgDL1UQMc+NsTkogNjV3oyJxXqD3GP538LN5aJDhGHDdOCAqSbmjDks0+dN2aaFCZ6shGxSvF/ZenC7/wfYMQThL8nDhHJY1f510Kd3S5R/go6GKycPDTMOEQVzvyD0cm4er/vGLz9RSNeFKBAs+rEB+jBgLfQ84jGQiNpF6OpdIP11bc7Z9jNSgN5m6PVxAcZ4VMdI8zhI2srOIcH2alHQpMaUWL0wuMCioC+OM6DiV7aQqqWaZU7uzMNBBjA7NLd38AufojCC70LeBEnGfduBs3yTjo1G8g+5Bb5UEaL5NfQi3hHC74v2cNWIrGYteyXhD8VkTl5yJqUIHarc+iNtaVE1DX7I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(107886003)(186003)(6666004)(6506007)(2616005)(38100700002)(83380400001)(4326008)(66946007)(44832011)(66476007)(8936002)(8676002)(5660300002)(6512007)(66556008)(36756003)(2906002)(508600001)(6916009)(6486002)(316002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ETwhllX/6cM8iySrOroXIoYDTkITM3J++FfPWhBPZWQ0kDW/5qWhrQSEYcA?=
 =?us-ascii?Q?LIdACCNv3sex5D/K0AjAy+iubG2nukzQu01zmFOomhKbbjOUf82WNPqi3pTd?=
 =?us-ascii?Q?pFAFmNdD96Fdqdb3UH5asNthiZDBUdZtPis/D+E1tOvx12d4OEK5sYoVQdTq?=
 =?us-ascii?Q?jQYW2e7ksa9xBkfq6kQbd9HEw1M/3AzYiHiJopzIWtr0jGXKEjqte5ldpJd8?=
 =?us-ascii?Q?5cImJIFvR88kkIDd7bVOewFnHauJVYAqtnyHw267gh5Qa5bJox6peLntrjPR?=
 =?us-ascii?Q?/u611GvPGsQ5vRaKDYUcLpeysTP1VhQcfX19uk7fyR0XPaGEjneNbSoBulld?=
 =?us-ascii?Q?dpCXa9WXjLxWLZVzoPloVHBdS79u+rJRSKCc/44KmHzs3Ca+DOeaU3h8q9/r?=
 =?us-ascii?Q?BTiaQIJ/4Ee3ZAq2Ihh5TgZkTFxwbQx6KvTnlpRO24HTbSwffoVyx4bxTGnU?=
 =?us-ascii?Q?1/MnRDbshQ4dNYZrG8ysKTl/sJ6CXkbkyykMgSHdwB0XF4w9h/t+jSSbPUIC?=
 =?us-ascii?Q?4sH0qqCHydZQ9wV8hZ5wppO3eGD2iXy8ppgSCKoWjrGEPkM7XdgnL2B8f6zZ?=
 =?us-ascii?Q?DNxufD2ltEqaPeRDWFpfeIbQJigGI5QguafmLztuMUt3mgLuamGkQGsXDwMd?=
 =?us-ascii?Q?zaVlcqt7jCu/XbLJhytS7kH1X8AUKPrkDtrrcABkng7hExmRoo+/Mr/Vdisk?=
 =?us-ascii?Q?K3vpXKNhugI1m43kRim43TeQyKfDEtvLvEkYxodLLYb4NTaBPrHMwzlW8tZ6?=
 =?us-ascii?Q?cgrefIl6b06KKPsbaDHCUxuPhxwsYqWW1vmfR5EzDgK2/U6MTzxFR/7woV8L?=
 =?us-ascii?Q?qmnbUhH7abK/Sb5ru/h3VSKHGkRQTVLM5dCPCrwThBGRUETV666H2miPWq5Q?=
 =?us-ascii?Q?NseljJU+ZI57ut5gVcd5oZ0Y9pMI1UBdiEDVABzwbzZeZYR4D/DZ5HglBooc?=
 =?us-ascii?Q?6AnTdxxtL+EQjlNggWOprGPDzQ4iLC0PfaDSQw0CRGMPCucRxyRoNrM5Cyne?=
 =?us-ascii?Q?I686ambePsniwwbGffhXXRCAdqoVTiz+oqTrq1WL1kyuppQijtJDupWrR1VS?=
 =?us-ascii?Q?GZsJFUz7+m2WtY3TZqqvn8OWMd7f3yMjQnzpTZUlksYvthqACU3+qMXu1Q7C?=
 =?us-ascii?Q?FzwV4SfxXlMRc4Jtc3p0RzxDjLPnR5ctq9UdJUiWQN9B1IO8sBl/i3mNnjFW?=
 =?us-ascii?Q?+EyahdLZlwktS8wFLXnVgLynOy5B16CAxOQSDsg+7tJlkCRCHF2yoHxDex69?=
 =?us-ascii?Q?n77RMCT5MVD3iweoBGbgSWE2UCbp07g/gk51h7rIN/Ucqa6nqnx+Yg+nBcG7?=
 =?us-ascii?Q?XQBLzUiIGoGWmnH4QpVkfDT+Bw8DI9xSPMW1v2MOfvKnyFw+A6VAJkqluW5X?=
 =?us-ascii?Q?vsdggHwWhqxSO4F6U4ndfW+1usjVgmL2jUvnow4gFWVuLoZprTlBsnejlAlN?=
 =?us-ascii?Q?eax3GdkHr6IXYk/taPuWnqjS6c79TTgq3sOdAIH4rXkkg76snO+x+nimdNAU?=
 =?us-ascii?Q?PJM/z+P2Ex2g/Yty5cTZKorsLG/gxQCRQ4o7H2JFY6U3NYmnvIQkqdbChY6V?=
 =?us-ascii?Q?pSKEUqob2lmkgkpU4j5fDxJgKPtuBV479TNzCgwhYddN8Cz+1qrZLnHtsaLH?=
 =?us-ascii?Q?3rta5/Q9Qkcj7x8YMaDn3aw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac1df82-7075-48ff-bb12-08da00f11215
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:47:41.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6IzV7GbNfofHLP0HsjRQBClCPxl+3P/vJs0oCurudY+wO7idyoFCa7T5E8aLFUKzfqA+SZMHX9lZc1W47qu0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

v8:
 - update as Matt suggested.

v7:
 - parse msk token from the output of 'ip mptcp monitor'.
 - add Nicolas and Matt's SoB tags.

v6:
 - add skc_to_mptcp_sock helper and test

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (5):
  Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
  Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
  bpf: add skc_to_mptcp_sock helper
  Squash to "selftests: bpf: add MPTCP test base"
  selftests: bpf: add skc_to_mptcp_sock test

 include/linux/bpf.h                           |  31 +----
 include/linux/btf_ids.h                       |   3 +-
 include/uapi/linux/bpf.h                      |  14 +--
 kernel/bpf/verifier.c                         |  20 ----
 net/core/filter.c                             |  21 +++-
 net/mptcp/bpf.c                               |  62 +---------
 scripts/bpf_doc.py                            |   4 +-
 tools/include/uapi/linux/bpf.h                |  14 +--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   6 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 108 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcp.c     |  22 ++++
 tools/testing/selftests/bpf/verifier/sock.c   |  63 ----------
 12 files changed, 157 insertions(+), 211 deletions(-)

--=20
2.34.1

