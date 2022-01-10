Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C9173
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641805710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iuXg3nf/MlcSChNrblIDtD0Ej1p81PV3zm4Fgay33qw=;
	b=aEqXLsqK1bo20wEk7VHhfPzqYV1PYTOYzqDREdLoovjEeSlK2Siuf5WD/ngve2eQo4js+z
	aTaMleS6XaHsq+bE9jLWqniuWwLDmrWWGj14Wu1Y2xKMLlj4/pfP1oh5VsWfJnJk7CqtGx
	cI6rEb35zoywMbqSQrfyPOu2Lhyzkc4=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-UeZrpv4wOweqGU4ca5K8lg-1; Mon, 10 Jan 2022 10:08:28 +0100
X-MC-Unique: UeZrpv4wOweqGU4ca5K8lg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiQK/twNOXTbGxGq4YC7t7fCmPycMTzYvgjDbPfzMUMS30gXXvF8VyEAmeZd2m/EJMeQx9/EuyBSBfn2HKB3XAHvkRXR/OiwBte/txRwmcLaRJROfRxwQPCSaSLythPZWHUKQPS8YFwhWKcHLWOOMOUkxggif4XaI1GMctDIwfRm3UNsqSrU7P33/CrMEGhfiEh8Who2VI8GRUskQarCwB+EGDUW1n/pRnGN6CYyqkDGVLKvULYSCpMG3euaIT1i/CwpB8YLtYtsTJCNTMmEEScw2IMBpURmme0eHrl7SFTm5fJsC2ukVx14yOLvGs5zpWD9h6Foss4t2zbuz/pDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FJR1mPLXoIatNgqlzAECapRlXdc6j8Fw9G4uDO4pl4=;
 b=SwHZnON9DsoCuhjONFZqVAIcd+utDZEJny4pa47FxUyS8WDf59VkCAVT39ouefanEQey5DpjOU1mrqoCYRi/vAmpjJS+Nzb8RM8FXfAQR6kpGU6CsGvQ97V0qP4OBWd+w2hhv2ijEyUqiyzvz0Fa5/tklwGFS/T/zoxMykGp3ckk/XNFjO5flKvFi73eZFqllAidRK6vMlQl4zX/ILOeMh/TnTb6Q2J4JcUW71Ts1CCYsACBkfns3wgxDLkphb4aBGR6y0mwY4X+vI/KX7k7I7n++ofeons3TZ7WDA6GJk1SNONqyUH39kueT0RZTavzPamxFVS+2mAGvvLLrf7WOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2252.eurprd04.prod.outlook.com (2603:10a6:3:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 09:08:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:08:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 0/5] Clarify when options can be used
Date: Mon, 10 Jan 2022 17:08:17 +0800
Message-ID: <cover.1641804767.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe20933-885d-40d4-dbfe-08d9d418c303
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2252:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB22528E0B9AA5ADBC8803BF52F8509@HE1PR0401MB2252.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dkFkTC53HawrYWDdrGk99QdfnyyNv3yZ+IyfsmEGZKjMt2GfGND0oFTnvZHdhEs1BJg0LRjwRDucxWbxdvqkcqIyq0PkNZhOhpU4a4qPFm6wAKxnOwMRIrOXm/aqJARrYG53qPMlY4QtLcnkKy+C2kiHAQF/kDKptCpTOs4kiYnJ6Swrs95zc9ogAxtZ52WhiRPPKcDGmnDBB7IYI29iK39qZD9FmdDO7Mf5Xz85JtrZl5Li4sRbD3wO+rK54nSbrlRzmqy6GFnFOK5soGdNCYfaC4imMo3flZX1pMpMNT9taNHelZppqUqkEXikeMGL2n6JpO8mkf6TjVbeD9bAnlWXVPz8Xk4dFq9OoUXIPLdeOrabwzphkmHfDIKclFil1+xg6K7CGrZv35pAKly14pjYnAnIlJ8IuCItmfTCYrBc06T8KetUZYWfb8xMe+8HHCpbAptomP6JcUcQcvkPVczg0epJEx5c6N4SWnWdCfj5nKZVCxsIFbRPnfIy/s7+qgWUdBCx92N6fWzQKl4qSGlFY02K+bevP1U+lwK9ddDX4w7WyI1NiQhEsCod4zrMoKwu3C6Sw//3Msrl7Ab4oi2ysa3X/9zy3uDdWEqhapewSPfdMlh1zjAUC3+GLUOyCydfFGokdUIpK1oRS7JNfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(6666004)(8676002)(8936002)(6486002)(5660300002)(86362001)(55236004)(26005)(6506007)(316002)(2906002)(38100700002)(6916009)(66476007)(66556008)(66946007)(4326008)(36756003)(83380400001)(186003)(6512007)(508600001)(2616005)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7vdOMMv+ACK3VgQCFg4aplFRuSKGV/CCafOWb7Gxp2upFflHNz+jQ8RfEkmQ?=
 =?us-ascii?Q?2yVn7OfJk/PUh+tDkQ5ekAz8H9cEn0VJkDG6CahIEu3v2iGAVqakLlQPJ+cJ?=
 =?us-ascii?Q?p++wX0xb6UoxeOWBuTp96gUBwaiXo4wvckpZwbwpUqnoatVRr5exfPDJtz3V?=
 =?us-ascii?Q?XVrvpHxA4jKVtq43BbSeJ3Ifl56vLPGzdi9RfOm5DLnAbAVos4/r6uG7Q7u1?=
 =?us-ascii?Q?9IrDUc7SVRD7rgi355DP/o2JlhFjx/WM51htU5NHuehslyZKEoxo9zUbAknc?=
 =?us-ascii?Q?zJSb4RN3TLJ3jWlXVK3itd/P0PzER+/1vAPo5QWNuj/nszJ9xmC9E3gVq5I9?=
 =?us-ascii?Q?rfrvH9ycOECxOO0W+w2TZpJwPxUmpGmeydbOViFq8GZqhhHp0VpSdzouWJMG?=
 =?us-ascii?Q?1VBzWge8TUEzFyRAMHI7bc4RwoBX4BS8+adPQi3KM2s/+62HMFt0g5QYRy8g?=
 =?us-ascii?Q?XoPHq+qpFyWCM5icbwSzRApfSYgtQs9gGPZHUcWSSRwGYQ/NQfp9Dim3nRc/?=
 =?us-ascii?Q?BRQ5t152GcY1rI/QmJAA1amQKlu4Aeaoipok6E0GpvwS6hUDOOo7ipFbLzIt?=
 =?us-ascii?Q?zhhCSE5ptafFcY7S74VF2lW9HLLL7gDQCbIZID9aGAV8MKuQjaqg6W8JGWWF?=
 =?us-ascii?Q?iaMZ/6q6DURmU1yHRD4xsiyYvogh4YaBwnK4mGlQ2hdlZWaKvAvM3UFmklBQ?=
 =?us-ascii?Q?s8/49dwxd/Q7xJzOuKr1mxQ3k7cyz38J9lIsFkHeEYV/jNaN2lx8jq0280E3?=
 =?us-ascii?Q?UhTp6/Z3FFQMZd9Xf+z+2M3vetHLI3ncXvFjhTm9xe7Qbl5o8bAWNnZQaZaa?=
 =?us-ascii?Q?kYG5vW4rKJGwAHKow6OObi/yIex6aDxLHqUnHTzpro4LDpJlKvAv+TOosJYU?=
 =?us-ascii?Q?5r16DG05wGaAIOLObmvfA5gsK73paANupyKStACPX6FATWf4vGO+UBQ6OGux?=
 =?us-ascii?Q?HjVDgto7dYaeUdteniQM1r8+akeoPmCwGN89Ff/q1sFX6qccoahUa+Akddfb?=
 =?us-ascii?Q?58uTuCpUkPgr0qxqytyokeGzj6n2ij6uG9DHp948fYFyZr7rfMfesANvTzid?=
 =?us-ascii?Q?vFg9kS0EKef5yNdQOppQ6L28nMuOU4Mzl0rVlv+8GIJYslNn15IDpmPMACLM?=
 =?us-ascii?Q?yFD111ehJzPwTMsBpKukXQL2//qu74NqXRCMeIvHNqrn7iVAUSndCiS7Mdfd?=
 =?us-ascii?Q?adJgx9NyJMgtZ7aUFXL6b5JY9J7vGkNOBd3tXYZpvF3LfKTRLfAcY+GUX4F0?=
 =?us-ascii?Q?sAdnA77zJDgZIh71FviwbZY2dE8xNdSQmUOocxpNiVSvN2pQKqGte9nhZw5o?=
 =?us-ascii?Q?DmhfFQ1HqY5ilAiHteGHt9acMXXh4FVee2j2kkLuEAfYCDoeHFQTDwDUqb9+?=
 =?us-ascii?Q?eBhIoP7fRIa13XLS8cXG7bYFnqS3fl+G6KAaXrxSCzLbHlZyt9Zp5YmI/oiQ?=
 =?us-ascii?Q?0f08kTPlZ5u9zcwwfdTgcg6GqnZ8xSvt96a0kcPO6sUYRCZOUq64TJg8VW4U?=
 =?us-ascii?Q?f1hHmICsE3C+aonI5p7Q9MBp6ILmWzj4Z9i2lMUIISjYLGk0+7zU/DoeII4h?=
 =?us-ascii?Q?/V5IH0+EsukK45XoMc0r1WBJH1sJQNChXbX88Aws9hw3Qo+rWFUJ1FAC+jcw?=
 =?us-ascii?Q?LbWILSthCR/MNg18XbGK0rs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe20933-885d-40d4-dbfe-08d9d418c303
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:08:26.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIjwlsrsH9hx2I547504YRMMUN57C222D2OLx7cINRdXvYqu/yuYNDhF8IxAoKsW54LaF8B1wH+0CzlD7u1oLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2252

v9:
 - drop patch 1-3 in v8, they are accepted.
 - drop patch 6 in v8.
 - add a new patch "move the declarations of ssk and subflow" to avoid
   the compiling errors when moving the mp_fail label.
 - update patch "reduce branching when writing MP_FAIL option" as Mat
   suggested.
 - Change 'ADD+RM' from 'C' to 'P' in patch "clarify when options can
   be used".

Geliang Tang (3):
  mptcp: move the declarations of ssk and subflow
  mptcp: print out reset infos of MP_RST
  selftests: mptcp: add mp_fail testcases

Matthieu Baerts (2):
  mptcp: reduce branching when writing MP_FAIL option
  mptcp: clarify when options can be used

 net/mptcp/options.c                           |  64 +++++++---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
 3 files changed, 152 insertions(+), 28 deletions(-)

--=20
2.31.1

