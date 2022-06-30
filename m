Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31274A46
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 08:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFuT3HDuQzy+BgRCculXaeC1QE0vlN/I6N5ZhY2B7jbrtoasasNOvYPX1PSnPfCxrt/KhAQFK5+rc/9KJExgM+Goq3QkuId8txlEZEvnFXomVBpGrqIKADXGNbU7fypf26ztAfmIczZ3/lqOB8ivayAKG4XxwrasKdHYQFN3qzU2JOqeJ2OD/hBk3nEikhAbbdBGaH7nTH+RMdjSB9EzZU1SjiM9MiPwUXFJCXHZFVXsvtX6w3Qwj2/hjRflj/cfDk278wKTZoTczsk0dISzTgg5ru5Gw0ghV2GYE8oMZqRc3VGMV73mKsI5bJOoge/GiCDS964GRY/K0yrfwQlWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixwlI+NdPMRmXmWvUnTqXTcuLMSmx3RDM6GmcIlA8ig=;
 b=AkLwNsyfoG8Af++vUZH0cA2pdQ6/HDAUR8COSC7x8IeB3v1exZY7HTOUjoEvuhrj2Qzuc/IQ3R/zwti4h+rccfQQeIIE0ua+xUpBmFoqzb4sOpY4d9dm5/dEJGJQC/sa/IB+WyrbM+H23LtWtw/7EVMRJTm++Hc57CuNv+FEbaTgS2uGCAlkZiaOCvtbizvm96Unmy59H4PDHfN7esN6La3uZg6uNmMAWuu2MAcPbMgxjqItBFNDma/IkP5EWd5GgDqUsDWLn3z+v/adfJumIVIkSCBOOAjsdlmEpUMBR0JjVh4BWH4ijriQE0TxTYWL8AEnCNO3MQ2w9DUmkyFKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixwlI+NdPMRmXmWvUnTqXTcuLMSmx3RDM6GmcIlA8ig=;
 b=VhuVDLhLDADGgOaBHb6eZZ5PHKjxsRwGDZDPa8rGy4bwQA7CSRBZ6+jzkZYFnxDl6J5emwKR5eWXHilC41FheKjklGRyaNJ+WxNvyWoffOh3GuRj3xIBGuj1Ql4UCknSFBI0/ckpVj0M6JPhYgJY3v8//VPyyMXLnrV/Gnfk2lEBoNfeqZ2Xsz53nXq1YDe0eT90SCIr/3YZA0B+RLa7Ky6goJdg6Ntiv0V4CLhsgJl68lBtC6X+YztE9wa7l5zy3QJ8ohwT1/5n9EyToCD1GlgT77QEbZ3oHXvEXd48auOssfvlJT/CDD/l8sF0mYGOBSlCkpG5aCrsndWznJWqUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7778.eurprd04.prod.outlook.com (2603:10a6:20b:24a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:50:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 08:50:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 0/5] BPF redundant scheduler
Date: Thu, 30 Jun 2022 16:50:49 +0800
Message-Id: <cover.1656578856.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 017758bc-146b-4179-cc71-08da5a759d9e
X-MS-TrafficTypeDiagnostic: AM8PR04MB7778:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RMMuEH3ZGqLy8Lt16M04L52wng2Syv/Y3Zt/yVT5ZWN6hGL8dFQIfkc2CboU2xW2RqLGwi3EhVG2q7X73TCATIGGpb+MnDe9Mvg5bJChS01kgUlrf/h2Q/Di0jMkkUekxgo1KP+sCNyxkQIVdBeyIw+jOnmoIzad0zlFkFQZqzUI5FiL2yWgEQPTHWb/p9i6L7kB3aGDGpddzN3+L/4JIL4pPcPt3cVc/oL//ysqd6R9mZYalgpqc10hynK/qQRiVhflW+oIZsKec+EaQWC4ooqykbE3ChCJ55diKOxwYOWzDIQRNuYU5rE174HkviLQ8lTctyHbEasXiNEARInPj8268v1R/CR1seqQsgEw/SjTC+BC1/Nnccy3iMYA1iMzDjhENm8vKAuO76isV72vrsTGHZS1NPcP5qZ2RFBbw7mUMxuoT9O5bDGhS2V+H756q7QreZWnR14DCFDl4ADU/wn3zTGS+TlrGT2rUku3UF6ua6gVElVYz1qp46JPyYA9h3yizrQTkyRvEVLDVqvuBgTsjaa6AGr2XsI+xpw7t6nRk9VElSBwJVyb+BFRbZLA+dNnXIzHgERLC9JWfASI7/IndeWEIIu+Ci8Lb1hurNuY77i+P0P4Ta+U+E8f17ih8/FsmsAKjOjdO8zy+GQNi58pJVrW/QDOtRlXVeEEVWJdQa+EClmPhOIiyqoZkiLE9UuSp2ZOfE8bmY18jjfv/QRCa1Qpj8LsFvUO+86XnBMsVihwL/UUe1zi3BhiGO0HuwU07Ak7HpEgOGPJA36EkMwL2EX6sakBdBGk5NkM3NYOFqpA9Iufn5PUOlb/8DLQ3GyBGtoXluVSz8EHKsXN6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(136003)(39860400002)(41300700001)(186003)(107886003)(6512007)(2616005)(6506007)(478600001)(26005)(66476007)(86362001)(83380400001)(38100700002)(5660300002)(36756003)(6916009)(66556008)(6486002)(44832011)(8936002)(66946007)(316002)(2906002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDFMIRC//EAbhHkqMm6c6lzRcOHLnVMB+DTcPIASQ71o8n7rPFAsv6t347FJ?=
 =?us-ascii?Q?6bP9qWaffY8iAlzblgX3abuvw2VJ1NMsZedgjNGrGTG/cypEMyMRtPs9ElZM?=
 =?us-ascii?Q?+bRaCGdpnAdyUXDT1BeojLT7yhnWtjpFs+/fWA5RJQSDLAgrdmFjvJgwXji2?=
 =?us-ascii?Q?CnybqLxFiMVH3B4j2iqKooOD3H0UqOBHYEIBNcofLcQi589s5OpGiwm0ti/Y?=
 =?us-ascii?Q?mI/JhMyAb2SmZ82BfKwhZSIo/Km/zTcXcW9gpGX7ZH2/PPmHfLbU6yTDy+iy?=
 =?us-ascii?Q?MJmmGr6r+JeO4+8Chbzoq6q3u43sdlBmIlOZAf/Pgr3MDY2et1QWpLij6b05?=
 =?us-ascii?Q?gAY4fSVy401Agrn5gJImzYqGPiemLdX3UNuXdYChXFtQ/61VmcOZ9obBvnZm?=
 =?us-ascii?Q?0IgshKRr+/2Ufo6ojNjmg5TublvdKQaOwdcLnyXdO6/O2AtL9OPxesw4FRJP?=
 =?us-ascii?Q?PaQzAtY1VZivJ2kZuN37IN+c8YvcYSzMy0LOzYouYYscBLekcE5QUjG5TUBv?=
 =?us-ascii?Q?GtesYpAMX1LhRTwNYununyCUO1IvPs1EdI8N4wmGYepVZIGGIW0JU41xqFfr?=
 =?us-ascii?Q?kaTkX1DkR5mnKHAwdWtk4n5rFDZ6+oiHJ4Lj5NjDGNdRqbamalc9SCHFoELn?=
 =?us-ascii?Q?fcTf5Bj5ZOR2N3DVJvYFRLpUQWcZEqxDK7DWjqwuh3z+GZoeXMrcxnTaBv7e?=
 =?us-ascii?Q?C3W1rKRIUYBR6Va5Of4ETi+FB+EsSkfZYgbK3vcSxvLxUF04x6LmzeFTuOW0?=
 =?us-ascii?Q?UGfd5JF5eW00fSHTzpH/SQ5iH5hgvnLm5L/1VKfBx6+7H1NNMktb4+LMOffg?=
 =?us-ascii?Q?omhEwZRLZVsvb4NiriiXW778gv0FqUleB3kQyAVZsVUBbNiqWPdm42t9Z/0e?=
 =?us-ascii?Q?mTv0zLwJK6x+1g3ZUdZhW4iRS/iyY2lqC851sXmuiiIYEk+aYLF3x33GKJNC?=
 =?us-ascii?Q?31kEXREi055WjUmLPuKKvjD2eip+UDgC/QmFeRh/2qjM03rH5QjE3L867bW4?=
 =?us-ascii?Q?DK3E/Wicr//Gl3I82gzBojPD28+T4ng7cHhO3K/sStFxHwO/cAtj6fUxWJMZ?=
 =?us-ascii?Q?QN9QvZQ5Ddi3YRyE0tNvJOV9iiRXD/sm6i2AdpVGu69dRCuY4ZkvNE1JVooU?=
 =?us-ascii?Q?PxLj85RtjsMN8sTrxSxBZZhqxJLdawKFIuExjmXDvuBktNSVnSaY4LLDC6qY?=
 =?us-ascii?Q?8bkwWOauJVqur+b3tbJfe/nfqbheKo6SP0EL6NlIB0pWaMNWh9kczyogoEU+?=
 =?us-ascii?Q?IbfmkdMCf3Fv/SAIFkl/IPC+6xDr7TdJaA/CTypreW+vWA8+Fe/6JqKZw99K?=
 =?us-ascii?Q?cmv7YJ27zP1sN6Kk3T+BXN9ApREBDg0XI4gh+3j1xHSstbxG0uJTbOiYYT2l?=
 =?us-ascii?Q?MK+VS7RLQkyOu85h0nQmF/FpGu+yl4mGIRRgphJqJZ7div8WrV4KnVcR5Y55?=
 =?us-ascii?Q?0O08qAxP2Av3k+PM4GdE/F8oATHY2qJQ9HMILB0DqngzkCxTEUVgMkmhND5Q?=
 =?us-ascii?Q?lAOjUVaRFipZg6AKi+By8wRjHN5pUWPDgtMTOOHnXxShbC2PdZxILKgwFSbY?=
 =?us-ascii?Q?XIO7vBH7FL5W2c43TLn2gWaInAEnyeFNQ0f+/k0lvVF2ORK1lEROafUI3g4m?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017758bc-146b-4179-cc71-08da5a759d9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:50:43.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxdi0h1oqvql7kYcUEgQHRuLs3s/JDxuxRcayunOJve/R2+5AO1V5PRjeeauCjMuqOwfena8SyrS6cpKbOPjqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7778

v10:
 - send multiple dfrags in __mptcp_push_pending().

v9:
 - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
   suggested.

v8:
 - update __mptcp_push_pending(), send the same data on each subflow.
 - update __mptcp_retrans, track the max sent data.
 = add a new patch.

v7:
 - drop redundant flag in v6
 - drop __mptcp_subflows_push_pending in v6
 - update redundant subflows support in __mptcp_push_pending
 - update redundant subflows support in __mptcp_retrans

v6:
 - Add redundant flag for struct mptcp_sched_ops.
 - add a dedicated function __mptcp_subflows_push_pending() to deal with
   redundat subflows push pending.

v5:
 - address to Paolo's comment, keep the optimization to
mptcp_subflow_get_send() for the non eBPF case.
 - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one.
 - depends on "cleanups for bpf sched selftests".

v4:
 - small cleanups in patch 1, 2.
 - add TODO in patch 3.
 - rebase patch 5 on 'cleanups for bpf sched selftests'.

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (5):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: redundant subflows push pending
  mptcp: redundant subflows retrans support
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 158 +++++++++++-------
 net/mptcp/protocol.h                          |  12 +-
 net/mptcp/sched.c                             |  56 ++++---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++
 5 files changed, 208 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

