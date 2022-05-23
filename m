Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD7258E
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653319554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pAQA7KdSBpigSgZe2FQSljt0BuQOA06qQVf/nsDaNiA=;
	b=UIDE2Y7hipnqAk4z5+wFs9DSU6Iip16szpYYL6BJ6an3z1GVMq1TOel/a/zbS/yyPN4zYQ
	4E1d4t/dDIMFHkWZfmyc0j7aSWP4iCPOJicThCJg93lR7dcvCrMSPrZEdL1X8g8xRqKscc
	25GDF4bWLJjx5spsAbjB5kstEicKrL8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-fAZVVm78Oyy2lSTbJskWSg-1; Mon, 23 May 2022 17:25:52 +0200
X-MC-Unique: fAZVVm78Oyy2lSTbJskWSg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbqdI//cH4B/Pb1Bt1vmTCIpldqqFx+U6cODixB57ghBn2Eyop4wvU/z8T14SZRaTI8uNR5ZJYZK6gRr6gFWUfRmNl30McSnjeX7OrdoAedK6z23uaLXS47cquJB0hkh5Cd95GEyo6/tHNOlQ4e2ro61FVijoBQyKvUZZRXvQ5/oK3pc9xOspMdQTFWKt28nWpwi+eolX+Wa6ljwwf+gHbGOJYmAdKVfp+Vn54eMVipF4IlHk767lBSDBo13SasTcSiJ0WB4OOGM+34nGMPVzhmg8Oj4OmF2p26IxctcF71b1ICtXuSTc1e3erYGGeenHmPskfapoDWtUQYE92nR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8rx17N/pRlfy9KhZA4ApuTwE+kKn36oeneoHXHeWo0=;
 b=J7h+TzmEa0fguK/Y3gSdpbIbc3DNE3Qt8ECe7p0KB+vBQ6XWK83cziQa1VVoavsekfEG1Sv3FWI1ZVt+m1jbvLnNocxxtx5COoIh/1oAeWc/KtPqASLIicZ4p9Z6vRweLee8EBewrEMjv5bL1PYnh1xjd4fRgXqbCFGTSxla1jQHV+3zRcCySkE0yAviHV1i3EmyswVDigYGhXjQASxExh7rERuytD7/2GkaTeOXypddwe3hYPsRS1XZY1Tz7mmnlYC5L5ZHTRtC1OmoQnM9N6idX9Qg0adjXnvtXbPdn3Mxa8WHghOON73buB9Vqo2m9YGBAgXIh3NeSTXvAizAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5681.eurprd04.prod.outlook.com (2603:10a6:208:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 15:25:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 15:25:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 0/2] BPF round-robin scheduler
Date: Mon, 23 May 2022 23:25:52 +0800
Message-ID: <cover.1653319279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60f3f8c5-b943-447c-872c-08da3cd084d5
X-MS-TrafficTypeDiagnostic: AM0PR04MB5681:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB56811A18DF2F3166A181D2CBF8D49@AM0PR04MB5681.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	21GkHFrDdIj4nFt9KIoEMjLWFInj8Nu4KjJBj/yl8Ye2ILdDk/rW8ZQ91/GU3/0GjSG1KcAlqgaImYzm7u1bFDgdJxcg58ZH3rNH3RTYF1Y2/vjOs0AegDCoHFDkgX8efpMu44j6TvTUR1TJLDY8JrOjtv4CiLM8QjYgBndLccxfZTZrUA/4w0VjTgR6vMzHYXvDPQLRXak8fvkKttpFlNma+SpmIMJ6sULBKYy0gwyUVkQE2dNWCwhhhk5xm3e/PJ7es2cWke4bULmdzW8j/oqKYhB6tm/H5316Wmx9GD06nZF8dQop41JToiPVyLNQEx3vHcuMsuwrDqOsPqvScDrFWmoVAckOZTkaC89pNsjskUger6uHtuE1HMWWXY62+4SaITG4HFeEC4M6ORWArrzfVOJvwySDyUzmlLRFoYjd35s/g8QW+0zn6O2Cshpd1k36BOXCs05/G+8i8kiCn1bB55HAtoUguqrSkMaEXlVXFuNlkDMIYS4DsMJonY0VXl3DOAypb2Q9qY5a80O9clZOUZIWDIRSX9x9/er4peWcf1D7D5se1yCFJhH045veBuynzJONmjjzy4FhK09GVlmG8TXfL8ulU//zZ5bPnYY7DwfRZDbwbVjb9KlkHXSi439146f0nN2LmxSdTh8UQ5RoVqEG0uLknViBvcaf3dyu60wXEiWBdwppAt2jH+/IJAcvTfr5GXQRNyRbZR04wiHhCGU6bHjUkYunZpuxvJ5Nq+ZZRP62kNHcsNL9mnGSulmW+QIc9zOG18ZN9G/c6bLElb+N3Zic4IThjeQP+yohchJIr2+XY7hZ4T9O2pej
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(4326008)(66476007)(8676002)(66946007)(66556008)(83380400001)(8936002)(508600001)(2906002)(6486002)(966005)(316002)(107886003)(86362001)(6512007)(38100700002)(44832011)(2616005)(186003)(6916009)(26005)(36756003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nG2cbUVlWb0vzPQF9HJf0GWejYnD5S6vDrF5oGF7fvFJC8400I8rrgCfE6Zk?=
 =?us-ascii?Q?MIKx5LjtTOFompCR+uqsej8HsPEVybMNCTx7MPRJtssLGvgjEDb8S9oohYb5?=
 =?us-ascii?Q?zFhSsEJMEA/s8ksrxNaKbw0Qthknz0vbUrGikaRFvvNNZJsgp3I4VkpNe2Yi?=
 =?us-ascii?Q?WQT7ET/XOlr2CdWKCXn7gN4oPWJ3NS73YB4ZRh4Bp3baua3NyQt4fQlSixQr?=
 =?us-ascii?Q?AfJEFMI5F9rgr8i0/Iz3LYumiva2hjaDSb+oLln6+908BY67fqrwbtVpjYqx?=
 =?us-ascii?Q?y0jfigR4JdrEqN3LvtzrCvE+kq6EHhAr31+7rGHa4vo1kSQOzOnTjCyE5nFK?=
 =?us-ascii?Q?GyfN8G61wVjJXK8N/KWfPFnviLmB9a8Hni7OfNqQ+nC3F9K8Xgm08HU1AgWQ?=
 =?us-ascii?Q?DVaAWgr2iW9LVPf+c5xsjhubH1TowwA/HhxOnoqHzD2p6IlNX7ZwcWa7g4G2?=
 =?us-ascii?Q?cz5SgRotHa6Oy5z0r/Wxj0mVj54/g7JJ+NNh79/kyARByzb9fZldW7uMhTYx?=
 =?us-ascii?Q?A+lAwfeIFj+bjNBHueeiNxyvHbX8QrmTt5jUfHJWdLKjyc4/nq3v/71MdVQj?=
 =?us-ascii?Q?wYZSqT2adod9P3V/ABSnqRW1Q4N6u3pMG6WAofl4PB8CSQWbNVi+y1cwwTbI?=
 =?us-ascii?Q?jqN91NAeo2CmSHBcOwz1PrL4Befy24FbKfXMoMZu9ZTLJxe2+KprsMzcm+Ll?=
 =?us-ascii?Q?imZjvgR00YspzFJfL4WCRpuG7GgjxuH4MieCzLsAqyx2UDx8Ja38wWpnqQud?=
 =?us-ascii?Q?mkSWSRKhrqMKg38gJYqbTX/PotohGun4c2uNG0kHu4gZIQVpbQ6kSnObgLQH?=
 =?us-ascii?Q?XDw7DOPESGY0jx6mU7XqqoAcj/FGcU4WzQ4gbmoQBrEYzpldfhHc51Ktl2lT?=
 =?us-ascii?Q?k8B1nEvYydeh/1HICrC+XIMbKkgF5NqJeuphjO1Vxr3JYsC4AX8EGniSGmnn?=
 =?us-ascii?Q?xZW6UsmumH0EECJSM0xPuwyR8su7WJf47j+/KonjVzvqHhtznj6L2uz/i1pR?=
 =?us-ascii?Q?phs8g7vB/9QkxRI4/fiD2qisDvUsXd4+vjSnUGemNY0usN2iVKrl9pWzT7OJ?=
 =?us-ascii?Q?c70wmuNXyD+2Yn4UDk5+wCezZ6zS/GOIMhd4n708eaSIDydGY5KoZWwz+uwH?=
 =?us-ascii?Q?e+QFi0M5hJOL925fnHtuH0v7l5T0baB+MycCXobXQyOG2smRVKZRnXCH5Gg3?=
 =?us-ascii?Q?oE+WebnufOKtQqBlUMRCGDHSS3D7g/Hz/KssldtsrZr1bRn2GvuaYcU2bK6Y?=
 =?us-ascii?Q?aP1/Khe4f93s9NXtd3PNXoVX0753tNG6de7TIfy7Pqm7BrHEqhK3Ggdb1Pny?=
 =?us-ascii?Q?HRSr2Ky3qxR9mIVinsfxiNiP1lh6eZK1EarKm0aaKEAi8bwDWEvAwez+TwUf?=
 =?us-ascii?Q?YZ/MUujSZTl4qbfiqNaizUt0aLjvaLGLmBqCt0s01nz8drENMx4qGfHv0c0v?=
 =?us-ascii?Q?q1hGZeLjuz4bHqNl0HArN++XtB2GYMplAWdsUnbFoCr79F/CF0fUfr1GTd1O?=
 =?us-ascii?Q?Ki65Bsm+jJUHIwqepMQUAe7jL674B1XjYaJu4buR1d7BePj85rc9sSKK3l+2?=
 =?us-ascii?Q?q4r1IeH6FaPdsUR1yhmF7OvRZI49CMhbGiXdpLmD8/0kg9kv9Vpq1KXN4HaQ?=
 =?us-ascii?Q?ihgVK447kRbAf0B3fayi4j/ERRNo7gWNBilvPciZgu77/piouvack1YM4wDr?=
 =?us-ascii?Q?FN2lmZZ0793+hiDJRudRUgDOuY66ydE8W7FNEQkaOR3/UkPaq9j0v4d1OU01?=
 =?us-ascii?Q?njwNrB1ACI2a23RBw8QtiP194l11ZNM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f3f8c5-b943-447c-872c-08da3cd084d5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 15:25:50.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThaX7bvouiuYCoJa68ukQISgYpW/ptHisMTz2Gg5cBQX8Lo+jrSnQ+azvyMNRGlp/e+dPaRKdauCk84lFnvNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5681

v15:
 - use the new BPF scheduler API
 - verify data was sent on new subflow in 'ss' output
 - depends on "BPF packet scheduler" v2

v14:
 - export subflows number in patch 1, it will be used in redundant
   scheduler.
 - rebased on "update bpf patches on export branch" v2.

v13:
 - add !msk->last_snd check in patch 2
 - use ASSERT_OK_PTR instead of CHECK in patch 3
 - base-commit: export/20220509T115202

v12:
 - init ssk from data->contexts[0], instead of msk->first.
 - cycle through all the subflows, instead of the first two.

v11:
 - rename array to contexts.
 - drop number of subflows in mptcp_sched_data.
 - set unused array elements to NULL.
 - add MPTCP_SUBFLOWS_MAX check in mptcp_sched_data_init.

v10:
 - init subflows array in mptcp_sched_data_init.
 - for (int i =3D 0; i < data->subflows; i++) is not allowed in BPF, using
   this instead:
        for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++=
)
 - deponds on: "BPF packet scheduler" series v18.

v9:
 - add subflows array in mptcp_sched_data
 - deponds on: "BPF packet scheduler" series v17 +
               Squash to "mptcp: add struct mptcp_sched_ops v17".

v8:
 - use struct mptcp_sched_data.
 - deponds on: "BPF packet scheduler" series v14.

v7:
 - rename retrans to reinject.
 - drop last_snd setting.
 - deponds on: "BPF packet scheduler" series v13.

v6:
 - set call_me_again flag.
 - deponds on: "BPF packet scheduler" series v12.

v5:
 - update patch 2, use temporary storage instead.
 - update patch 3, use new helpers.
 - deponds on: "BPF packet scheduler" series v11.

v4:
 - add retrans argment for get_subflow()

v3:
 - add last_snd write access.
 - keep msk->last_snd setting in get_subflow().
 - deponds on: "BPF packet scheduler" series v10.

v2:
 - merge the squash-to patch.
 - implement bpf_mptcp_get_subflows helper, instead of
   bpf_mptcp_get_next_subflow.
 - deponds on: "BPF packet scheduler v9".

This patchset implements round-robin scheduler using BPF. Address to
some commends for the RFC version:

https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (2):
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test

 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 48 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

