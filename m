Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A420EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UECOEqFotEq55CcsQPhmuUGo9vN0X9dAUVVRMlo0Pqg=;
	b=BmOiIkuw8ZjhuOzjCliwmUeB3RXfojS84pXBLVNrwczBLDZVJmp/EeAXIvCeAD51cBUF7x
	b4Ys2zpJShdhDZc+BcVTwUBmaaZBKsPdzpnO1bbhLRKy6kT80WHw/ngxFeFWBsCd+sEFm2
	GPkvT1S86fuFBUCs12nKOMnyTcjFjGg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-UYEOlbK4PjS_i20lw1vAcA-1; Thu, 07 Apr 2022 06:10:03 +0200
X-MC-Unique: UYEOlbK4PjS_i20lw1vAcA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9Mzr++Q9m2FpK+Q9z7/VlfyAhY5d6ofniXI+0QNQ7GUa7AfMD1WxARCWxs6S/CLLKByxjTUsHCGP9JcU/gYJ/Jf5MAJEmkm1+mRj8LoREbfBqoufl4jRG/80jfBNmUWIimmdW4X2RF8O1wZ7HkkW8iCBjonQsSjAdsvBKs2cl31ZJyqEWQivGsvucgNjuzQExgIIikd+owXCnl/Z+A+gn/n1fqrR6JRfSxY0XRuHcmj65yiI+ji8zhc2HMptzXYzWHZPPooDCllqaPGrnXoohZFJTZ3mrqNjpkIwiVViTRU7DOC5qe+sS1G+nt20v05zZaqosTkSWSZQs55f5sNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=625faT+vgofAvgIlZR7mgJJpeJX0yadmLHdyThfy6IQ=;
 b=MTnswppRh1nzxsWc87CpHEavpSpyO8FWxceI5cJ+iqmwkbHDzRLA4Q0C0bfuinwxEOqIV0Liel717+F5vzQM1RJGPSlRUoiusMKLZIN4jKUPGTBWH2iwwiaeJqAnfHzGg8lWe4onr63/BzfbEULgFdNL74VDgITo7yrSGKx5KecN5Y4xtx4ds62pCkABhhhDApslFWvbN7vq4QYtTClADfr79U0t9MuRYn4PDT0pcCumcd5AHjMnx4rgSVifqT+CVosMGwygZVU6I4WdjY7tuJb7DT1PiFEyD8ExtJ2P8tFNuKffpgsVlocJAbmkPEFEsGz5P1DlHBH7MLflwsy4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:10:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:10:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/4] BPF round-robin scheduler
Date: Thu,  7 Apr 2022 12:10:07 +0800
Message-ID: <cover.1649304364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc49bc1-3b17-4181-0d33-08da184c7cd4
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3354738578C92E260898FF2AF8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YcJOllLuTsPmzbbtvyvpn2UvVuIMHnytaaXEqd7Ww4snqgMe/p8UbdXw734xSG9BzyfasPhSVbStRuVpW/uryaX6tbLVc5kLmJmmbeeGx3wspm/eZcNqp5afP/R29Ceybq92210QUVV/CyThxWJ9+jxWW/ZBIQcdsodFeZ8H/6Y0iLn0SOQpFPrN2u8LBnUppXUUi01rZZmP0kXQWkX5W+k+g15kPtiM3qe4Vh/KK4Cw04ycIysCR6JPWckShjfWF3Fh76IW6hZJeK6Mfkk6Vbiw4ZPEcw3RA85utv5kat+NReIIKZKVamjIFxxLw4vcnhisbpf/L05L2ZCCOYmfFAocq+yEXjon9AIJR02JW/17ME0HhBKuiKP+E9z78xQ8cmWAoQf3bg88Ze+3aGSd538M+VyHNeJQnz7D+R3x77nw7Uas0kTr3pMINYhqgrk3GOkgRlprXinLqQWtEeIOH9lVqPUdiby5/BGFbufbnDxdW2/Lpu4devGLny5k/F40L4Ux9lbES7b/MbwmI7KMYhyNtjbZZcShUUIQSVAhWjEvFAatja449PqtmBCxj8MiJIEpxP/ObCrifBJeV95vvg63DpeiKMo9oa4BEXdkES1TQdB4DudP9BzmW5m33AaOg9HSpf7iZb1FpPafjG5o8vtoXkYUVLXulhpuA0cc2OIHD3JwRxRfaVjpUsp9J8VAledcI+1t+DQi27kaoSsTPQ4waxMVAnpIh0swIXY35EHO1Z5NkdfwcERu5PoqrKvXwKtsALOwT9uzqLe8rc/wFh/Myo8LaMeN6bzusgIDfpGGq4Fxl5eKYi4yey31uznk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6916009)(107886003)(186003)(66946007)(8676002)(66476007)(83380400001)(2616005)(6506007)(86362001)(316002)(4326008)(66556008)(26005)(38100700002)(966005)(2906002)(5660300002)(508600001)(8936002)(6486002)(36756003)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yrSIjd5xV7oCphYVYaBtxCw6tLSAT2S0TrVy1BDdG1mm7hW2/DcAGqgndrS1?=
 =?us-ascii?Q?KFmDSOUwk0qGitiwo8l2/m5SD13Ml+KkXActk7lXV1hRq+M9Sj6fU04b0E+b?=
 =?us-ascii?Q?WBK0R6BVraaSif5rhfkqGPQHv+2FfG2fg6aTgOZhdtefofo1rrqtuA58TfM5?=
 =?us-ascii?Q?/ous/QQII3bhaNiTmDky+hYe2UnQxeQEtcO7wMTSJ0Lh1ZgdfmoFvWE18cW1?=
 =?us-ascii?Q?dHV7UCDIdkDyS+aUJLrO8E4CqWXWnub34beUtW9Oa6OKLxmyO2hAqCh8MGuK?=
 =?us-ascii?Q?jpuzcPVcQrz+BH4/LlpPgt9Vctb7iT5LU3iX8U1BTlF8Ran9vq2eqRVCmxnc?=
 =?us-ascii?Q?U1X9yHPA9lP+bTPGLbH9m+MXnw9GZYiIDyzaC37m+ZppWniY4yFAyG9EdbbA?=
 =?us-ascii?Q?uZUtDx1R8hzgYADfvOxPFj3AvN6ymferz0AP3GmtY3l4aPhC8w2918R+XumB?=
 =?us-ascii?Q?vrWOwJm9MhxfycoL0fQu3tduLpNNO4P2BI2s90g1pfJp1AgV35HF5iEEdLg9?=
 =?us-ascii?Q?+gPZ5Q8pXfKKywh+DAAsC/dR4O0OsK5+9L35U4dTfa5mJN+jdC8jRCDG8zmV?=
 =?us-ascii?Q?gTvEY6OlcP8s/bfAqkIAFkOX2KjpPf9pPPqbLIZcp+F2HcjnMOaEhCDGxLQ7?=
 =?us-ascii?Q?xaVeUAY75IzLp9i/jFJhugzL8RYBVyeAeX/iFmKPBSvxrqxVvA0j/5PHe6AB?=
 =?us-ascii?Q?Wv0L0M1B99J5gnT8m1Dh4sjRM6b+kH7t1lQ5aS5eNYb/q6HDXuVizQ7Sf/fA?=
 =?us-ascii?Q?XcU+dwy5OhAkL50KSg1trId4/lDNufAFOVhy9hG2i59XfRfKJAIZQly0Bj2Q?=
 =?us-ascii?Q?aqxSmGo41w7df1y/T1XSzzHWlbn7X3pHEfiXBIe9RFUDi5NxCjv9rIV3Eqfr?=
 =?us-ascii?Q?om/xu/NlJqSPgA/aqCxZoCMepFBtdxPGj/uk5qGqAA9HzzxHGcxNjKW/28Ep?=
 =?us-ascii?Q?R49qEbSSGWzcyfdwn5cjWDgZMjpoBbhv+ZwVTf1H4tZl3srzlHAzfIO8iDxX?=
 =?us-ascii?Q?hpwF1JGlj0wyNlXnt068rOveothwP3aBUFmAbmdZuL3bl6Rz8PwaGuuMe/Pv?=
 =?us-ascii?Q?yn+Qq8Y32C2fpTR5roJQe1InHe2UZkP0/0mukzfR8oCLG6/f4hqi7Glo3OXJ?=
 =?us-ascii?Q?9weJp648ix2OBc2dFrhYe/XTbVp3OEVroxndU6rR4q2Kng0GPiW0eUHXBpq0?=
 =?us-ascii?Q?C5MRTsUumdy71FfPf54oW9nU8ZVMEjKrq1Nhau5sr4xKCy6oiViSo0yLGJgm?=
 =?us-ascii?Q?0mbsMs0h45BRjsmzHqLY2y6NM4y5kUeIC2sxwGD7p2+3yqk9mdnAlsGF6KOj?=
 =?us-ascii?Q?lo9eezyb67L4DrVFjU5eH5H9Vmqg+TgX9DG6Ts/Fnxj1gabV+h3athMR1jYb?=
 =?us-ascii?Q?W5E0+5YGzkBSu43dzdRouhxflvEFUnVMo3AGnRWxciZp35go6EuJC8c7c2+B?=
 =?us-ascii?Q?BzAP036o1w5wRvHZDAG5ErFwcjBMCaIB6WxLcKqraxiRyNXl1UK8Ebk9qMHm?=
 =?us-ascii?Q?9c/6jApAh5REpVVVWJVVbYdy0tByiLIkQ+hi03xvAYNqAcXkiGWbFBiN2YmE?=
 =?us-ascii?Q?0Uwy0NRL094gASVG1aguhVEH3og8dcdOTgJRPNkBDlE7FGhvG49657S1oi8V?=
 =?us-ascii?Q?PMASQ5/pdnF0cFor/1NOFSesVGFNKy8r30sYuK/Oj8CFsrlnfNsN1thaMxAl?=
 =?us-ascii?Q?5D03lm0QHcLk03ixiS1tFRC5lUATZJzBzJIMEupfZgGJ9Y0Gu1cAxr74Q9X5?=
 =?us-ascii?Q?91IIzJ0lRNKNr6g8KQJHy9z8rF87RGM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc49bc1-3b17-4181-0d33-08da184c7cd4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:10:01.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVDkudk+sBPXX5a1wBbInFiu3pW/ZwpMRNXVQsqI2ZVR53gjcrd3ZPvgf8Ut233/0r20BDgI4b3TkLEc+gLxhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

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

Geliang Tang (4):
  mptcp: add last_snd write access
  mptcp: add bpf get_subflows helper
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 net/mptcp/bpf.c                               | 44 ++++++++++++++++
 net/mptcp/protocol.h                          |  3 ++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  9 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 50 +++++++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

