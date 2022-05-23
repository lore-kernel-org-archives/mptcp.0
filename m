Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BE7C
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653305617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TUqjlu3xI89SRMn6GjBrat9Pj1g6XPYkA6LWW9XHbXg=;
	b=A/E/MrrH0mRpK8+HxBzj6cF2cgLRw/k6NxFsQn3Zv+TOdAoSx4ShwRBbitLmkjKffvj8/2
	LQKpGBwIfgSYZCcYc9Zm6Sqqv6YnvsuAkNw72VTPg8UiNUWbjKWO6RWKwNtonVhRJnErKt
	+RRd9ftgBBLtWjryJamSbTDPg0devz8=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-hvYdFVQvM3WLxkYK_UUPrQ-1; Mon, 23 May 2022 13:33:36 +0200
X-MC-Unique: hvYdFVQvM3WLxkYK_UUPrQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTf9BV6EjGSnw9dnGJO2m6Rk4m+UF3e6yRdwA7SrMza5ui34Dl4fvqBa1w7nMCelOkCvxmvThxzYG+joriVOHR898Z22BCqaV0W9i77iodmUqzox3j2lT84RCx8DpDxYWrQIEN1eo92M/5BYTwpUSypRMBWCKSl0oXQZ+ksqlNpWF8N9HABQDuJ5LRpoG5k053B2j/weSH64mSanGY1eKpx4Qoef3HrF+bXWHFJu+Utx3XfhHnX4yOs7haa55CF+qDJ8ahNkOn/yLNBk08qngXzmmmdAqc+1iJSddNC5Y6vdmhE4yb3l68rqNJkvaiVQ10m8tjsyKs16rCUISbcU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOUteCmnbofNETm7kA3Wm/cUnXD+RQzTxBlyV5nDiZQ=;
 b=JsEhHZqX7sgLzYB6g5QbjsrnA6Yu3ij5/nJVuW/kgWTPmalor4cKgL3caCnd9/8ABwaXTa9jNFQUVwzIt56RwhwzGGHcv53w2BqGnGGMAI9padE0h8shCEurBhL/q32M8IeOMEOQIhAeQq9UReahMseF8PrJ1uGzKtT7vx1CRxB62raSQx0Z6tIxPCx44dn3tRRqZz5jRh3ihHll1h9hDAICBGSbBmAtMWl26OD3TZU+SdQ4UZpnnYMesHAXziuTCV3ajqryi2oDZDCpaic0/HT4lnNcOTEGcdz0aAKds4/iqipj9B5JLzgzixtmUmAquCtHmlB21Vpcr2uzUtvS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3899.eurprd04.prod.outlook.com (2603:10a6:8:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:33:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 11:33:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/5] BPF packet scheduler
Date: Mon, 23 May 2022 19:33:34 +0800
Message-ID: <cover.1653305364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c9b036b-81b5-4bdc-b65d-08da3cb011b5
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB3899D242783E9B95861ACDB6F8D49@DB3PR0402MB3899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zl934jNYyQJyG5emyzvqTS9iC6seOGLfWAMmBSP6l5J/8H2rRjF7Cfjz3q8dVMTm6rOPQuFjdwZBRfGy9mi5S2/v2rQRraOhKpC5/b9H2X2vYLlUVG/+svivqMiIbeu2HUVbAPMat7EPwBklOwJhNFzgAfB/AkrCDD97y+YlJxkYIuU23UQpaI3xbMNpPMTH+R2gRTxbKNzhPFSCHA0mX9H+8Q2BR+LjjNUVsNhtgipkntBK+TUvs0vhMWMiUbtYIkz9ZHNC/xSQBXc7Gqy+T0eqQ3QMrMtkBzaPOt7Aq43MlR5PTKDKgyUkima90TU5zyEKuMlES/45q6eezM+Y5qNdNVIUrc3S9OKHlXClIBB5uN6aNd4IkJ0pn0jbELwk2vuG5Lc2cBGzyO5aFuQ5OP2m2hlBbeWCZFzxMwKD64UnYVGe/+B7EMYCIfwmTKH+XE12ZLBMU7CRawNrlNBcVxFC/N7/skqrtAlzxVfK3sB6YVixEYBJr2dT0SFhvuNcqAhgUzjCIQsJq9IOslqEdKjlC7BabKKZ4UkxwcaWTmNIZxh9UdmjEWdNSfaDMpJoso2MGt8Z+QtiACVINOmxb35+EnbLny0Ay2wdZ/XNGAetM5nEZyj0oZy/C/p2eOs8Zc2XguVWEFjKy3Cr8qQGzlA29QHn4kDQ0IuQBAfw7EG36IUj9Ky1uUCBzO2rP5eYzKaSKBeK+EbP0L4gC8y/JQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(4744005)(508600001)(38100700002)(6506007)(26005)(6512007)(44832011)(5660300002)(6486002)(83380400001)(8676002)(107886003)(8936002)(6916009)(316002)(66556008)(66476007)(4326008)(66946007)(36756003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WnI2MSBYnwMc0G22arU45/tmiUof9yb3Mv/WTJUXx8bw+qAIzKsYGbZKUGxd?=
 =?us-ascii?Q?E89H+WoAenA+xrGC1zSMOhh2MJP0ZIUVqqYXOWeEXCr4brbQfZY56C+xVqEy?=
 =?us-ascii?Q?cDHeOs5JnkCMFJ2164f3J8qaYP8sj3kxk0B9vV72GnNjIKCH2L2AwxR6kZ7P?=
 =?us-ascii?Q?Bu56Ol7Jz6zt8/URWIsy8BaC67gtWSZ6tWO/z+0GHYW6yrW9nta4LAsd+7L6?=
 =?us-ascii?Q?XtufUk37x57PaSvRRotAC/44bqDo2aI4kmXZwd5VbqKcg0ruQLD8mQqzFInp?=
 =?us-ascii?Q?iKsR68lSGAUXac8k3Io1CSTmgaYzGov1/AtL3XFfejl+lRaua+UoxaPs1RF+?=
 =?us-ascii?Q?mgg40xg4H6s6mKcz+3W2Ef/wDX9CLbDVKJL7n9bib62EZYdtD2a28TEhlbxR?=
 =?us-ascii?Q?IV8AyLgoqzvVLd5AH85xHPUTJe3V2XZoPR6rjRafTqpW0z0VXqcrgduYamcr?=
 =?us-ascii?Q?ql8dlEXysROrZpYzj27LVFcdfj1GLiCwS+YS3oqLx7Nk/4PFGp4KSXGU93IA?=
 =?us-ascii?Q?mp9AAf7PfyiDEFgQ/uZrmCCHBnwcQlYOKWF/HA6KsMQO1ZO4p/RLFx3yfQ9o?=
 =?us-ascii?Q?aUyA1cagdZAz6bveA46mr2/727AEwtkg5pOa6SNs1eLZr7OV0BiZ4hO079Lf?=
 =?us-ascii?Q?tMsiYi7u7ZgW6Mkr640pUWTKAZTkZWwh/6xEdXPgb2PsWWHlc8/mRvub4VQA?=
 =?us-ascii?Q?G6fDCjbTTiY0BQOFD6jodXBauTvvP9Wy/8iCArylmk4S1BEn2GQn2Qy66iUb?=
 =?us-ascii?Q?zg09bbjhQ2W7Bwqmh3/xuWqjYiHnqsk76OCwBkNC3dg0vipN8cCOTePkIEZx?=
 =?us-ascii?Q?bdhETz0m7udgZkPaAdg1IzyoWdN72LI+zCLicyYUj6sdv4mHGpipXhOkAh7b?=
 =?us-ascii?Q?Rp7uhjuvnsrF4vxR0FgtgNBn5gR6q2Uwike9XIr6tnOmPQmzTrjEpY+0E+MB?=
 =?us-ascii?Q?LwpHUmTS23FhHfIGz7tHN6oVGlfkqcREeQUi6eJQoFDMBHYpGK3zyWo7Raf1?=
 =?us-ascii?Q?ACkY3Ll9TNLKy58FUr7gBU8GH4e6QpFwmphdYqInSCOGnEZWIxXoLJJ/O9TL?=
 =?us-ascii?Q?BXG0EiVDIx4Nynrha/Oak1c+zekrDKJURI83l5GPxXQvHq6fmAzXLsnncek/?=
 =?us-ascii?Q?uhf2cNaMvzqr5VYcn2otIlYpYHdtqXdJbqF4NRMcB9cNCYY2Wfmha8Kx9qmw?=
 =?us-ascii?Q?4hw/XDbeNkLtbp1ITANiYrTKN26Bq5aamTPDmKPTcYqkdX41m0xwx118Aec1?=
 =?us-ascii?Q?WBAgdE7sEZnP3Gir97Qd//UFtSbd7/u+N1BrnHr5sNqPDAr6WlffXtKSp+dx?=
 =?us-ascii?Q?F3UarUvSTmQHTr09e0SvQxhSPP4+Jz4GUWJgZPJ4FqI3UO9I6LW555EhbpN4?=
 =?us-ascii?Q?4fmjgFn2w/5LITbQ50Df64SscpN3C74OB73Jg3R/V1n3Nn+icWNAaHn2NmQ9?=
 =?us-ascii?Q?RApU4IpvGJeNimcMCAv7q2Kfpm1J7Sbe0wubAy9DFN3C10TIzMg9Widgybzi?=
 =?us-ascii?Q?feu/nXXs9fDeTxa7yvxbHIriaEvxEpCa5K3ds8xtQH7uaRCMV81yFJr4uMUj?=
 =?us-ascii?Q?OEqnovmxTBJz8k9vZvIdHEbbfrhjmrSD4eSOQvrhh9kBZufrfnMYsgbyt3LU?=
 =?us-ascii?Q?4VAxvEntP1tzFMB/c5TKiaSCd7EhAOEU2p2naR+f4ZZiPZU1yHp2yWa92xrB?=
 =?us-ascii?Q?Aah5N+s7b/Zz3yL3IZg/hR1vEV0aCR99xQ9fb3z6C377BoFwiZj0WLBXFRZW?=
 =?us-ascii?Q?A8t/GwRw6NVmCAnVRx60oxMpcd3oZ1s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9b036b-81b5-4bdc-b65d-08da3cb011b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:33:33.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cybJFLyoFdmGsNAMWMtAzRap+8fPR92EWmGTFIPE5357jywH5bTBquDJw7rGbQcXUQIUMfDNr6ZV/z1008+S2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899

- Use new BPF scheduler API:
 unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
                              struct mptcp_sched_data *data);
- base-commit: export/20220521T072520

Geliang Tang (5):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: add bpf_first scheduler"

 include/net/mptcp.h                           |  8 ++--
 net/mptcp/bpf.c                               | 37 +--------------
 net/mptcp/sched.c                             | 47 +++++++++++++++----
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 24 ++++++++--
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 ++--
 5 files changed, 69 insertions(+), 57 deletions(-)

--=20
2.34.1

