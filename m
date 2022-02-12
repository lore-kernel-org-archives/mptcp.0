Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A1257E
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644682525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yYf6zapJ18olVeerX5KUZd8SjGw0afjEOv2gTex+rCw=;
	b=VZuR3KcEY5nPZuhJgUo5Oe8JuB6W2Npu5IfuGSvS3ARq5H1QV36mUAt7k3DG8TYI0hgR73
	LPIhjdNRTnP6dGedpT52yLdi4yh5JUz7ThXde8Kx0XR2bvDKlIAptoLEoiXC0U2R4e07k9
	Z0z+XmvzC3tuFNxtuMbx0VI3bSXOY4A=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-K-g27UWAN_2tJ-5h7TzDKw-1; Sat, 12 Feb 2022 17:15:24 +0100
X-MC-Unique: K-g27UWAN_2tJ-5h7TzDKw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtHhOo2bX1SiE+5wpD3oq+fSJ7mAhbDfrelh16jPJDcLguvO65zkGDpLqOmUpJ+sgdtU+7CWZ6QeufhmvrdzZ1bENprweLRlB0lfjexsu5Bn8neIpjZCrY7APrwG7WQYi8hO34kMwNE2EM9i/CE2yz/z7HDJx5AVbgibOlczEGcgEAjNRl0PzaF94U2vsWCxxm7PasngnZ097eeEI0W9lq641oQKPi9nvFCCZZU/XLJaj8XGRAMHbW7EmVI9QshcUapo4hMShMRjULZE3+M2R9T/ECF22bVcAzTy0USzLraT6UddKmAu/rUTYy0jt+cRQH08C5F2J1P5twJpfGGkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TnLK1v/lmpQ00WYmxWtd0dxPGjs5nnkRwuXKEyUwqE=;
 b=PLTJ1tPF8761jZl/UFc/EPY9HouMZEAkbU0+/MnQ13HYNJslyQyQks/1e9CZw8OQVJwOtA1FmJIE17Vt7JesJTcrw1v7aRUqTUUonLDOsctCDWH74Mck+OR77stas310V3m7qbXC/oRvUr0WTVhZtGIRbjBkKP6i3s4r+Px2dtwHETOV4XYdawVIY0UO0ONxd/i28ksNBzac7XapyxUfVoIMAOAdVLzfCaLzqiBVyap0UoDJ5V910UTpccIaLxf+r1tIEVeSZQjKC7DDopeiphszcRlWt9Z35qldGxQ4kwgeeDgiCe0dJchfUHEJJKfCBkC+yfPlbvqQKGWH3np7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6548.eurprd04.prod.outlook.com (2603:10a6:208:175::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 16:15:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 16:15:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/6] add fastclose testcases
Date: Sun, 13 Feb 2022 00:15:34 +0800
Message-ID: <cover.1644682054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f28ff94-3fba-467e-f8dd-08d9ee42de4f
X-MS-TrafficTypeDiagnostic: AM0PR04MB6548:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6548262AAABE4C84D0C83F06F8319@AM0PR04MB6548.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vzzekY10oTgCvIJ5JiZkll6bnYpzI0U73E/AP29YSKUJc0z9wKNswwPijouw+NDO5lH2XzbjYRWrLbcZDE4mMXTU103NzxyaaKso9hEI5JatJlC66OzwFZJnOMNN67pjhQKlWQbL6dlFPTFHF94ThX+9oKo6emVjKTvxV4kD0/th4vkPoy1jjR3pIDwAL8r8N58npqX1WY9u8Z4rAuIftqvayYzYnRsBgD3FB2XQgUE9dfNDbsc/uh/xFP/+qUJWfaPJEHtEoCPaGgTHq8wvJ+szrsHITkEqhfR9Fq7YDF9honNzvSTH6SIufEQ2rn5ssIg/CTqzwmmW1BosOq4nJB8PZuB2fDlvUNaZXFmHd/YfGaQ1PpQAkyceR38hiXV6wk0Wh+LZWBdCXwpPZKxpyDDf1xzw6wbpx/E9V+AZettcE1VaLlRozvlgLoii27nCGoWxxGGMVqG5NlVapCMyWjnx8ytFGgJHOQ+z3ObRnaLwnNWFt85coyJvP+sQFxylCytGelQ+V0G+oHH1TlPgYLF0Ebb2CnTWO2N3jAQCNwGOberHRUQ7uX8zLnm77qfzfGsq9xqVMNQ48ompa43N0ug2rqOqlrXsSSgbJE/A0HyXJ+qBwLYTDOrBqfrRaddePJYl40pRSaXXSeqcjmfUqLLcuojMAEVd8+FMjlILHEaQpSt5nwVke0w5lIfAmZ8OvBKyofHhA4tcURgzi0QRxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(44832011)(6486002)(6512007)(5660300002)(107886003)(38100700002)(8676002)(6916009)(316002)(2906002)(36756003)(8936002)(6506007)(66556008)(508600001)(66476007)(86362001)(66946007)(6666004)(186003)(26005)(2616005)(83380400001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xKIoZ79mg/RPGBO3WacfOMp/YwyM7/EU192MkSk8XFVyfc7Ec/P3DpcY9DmQ?=
 =?us-ascii?Q?i+P3ClUEhTeJ/HaiXVoUXGdAwKa2yBzYCMfhSAKwTqHRYKsBC+WchRelUGsD?=
 =?us-ascii?Q?2kBdr3AE3IlXzMC7H7BPnP+QAHvBh2oqU/OKaKL9zByCmJObvgsiq+2Wfom/?=
 =?us-ascii?Q?3ctXcgzRF0kB1pZazPV9Hx4ev/7sQ0FTw22K7IN8FXbrA6kQ1YYwj7geHgjS?=
 =?us-ascii?Q?ntPOpB2K37Lz/A1yvvO6lkrhPz+vBTvfYHHYUdJrr9SFpGEz4gnPSdB0Yzym?=
 =?us-ascii?Q?mdIbPYk/Vcsd1Xvg0zekOmsD2XWyT4+QeTmTDACgCKo6vpL+w0aPbPsyYuCn?=
 =?us-ascii?Q?7IlyXvweV+PgAO9RWyOypeYuQRSa+dKsNE8/SZWJbgDsf0iqhrlcW5h7+6nv?=
 =?us-ascii?Q?a4R8O/XGsYE8Voqd5PcSe+vCUZadtJBcKfaOMKxPEg4UIH+Rb6WAyF8vF2+e?=
 =?us-ascii?Q?8RYBlpcW0QiF6LJKYmDiYc/bPQaYIHdM8ohMCEe72kW+vlUyeYQjtHUE3QSi?=
 =?us-ascii?Q?2dU6Sy2eFvwwjGwbUd6sjpf/r7SYgY2rP5O+6KJSoegRU8ehKe0NTLabQWOW?=
 =?us-ascii?Q?q0I/BTuWpoJuu7+kUnm+vXC4bYYmB3N+886tHZQf5zTbdtyRirPsfzMLnfy1?=
 =?us-ascii?Q?Mhjt/1cVxzFgOz7RCIq9m0nOP9RwImOOUK5RYWlF39+wiP4sluxQVuvbor1y?=
 =?us-ascii?Q?yvyHJeJ6DL+lLac5YZVyt5Fh7FNFVvWa49DLLbQ35+EE8yx47DaCCVVyEVVQ?=
 =?us-ascii?Q?k58wtjlMGKcGV7X7F1CEq9Uv388i68QyILzfKPpysiNamDRTuXlWuCXcEdhY?=
 =?us-ascii?Q?tmmCpO/aHIe+Is49mvoeAYtnaguVhXLMxZvV3fJLtGbuzPbYuRGY9jtYDF++?=
 =?us-ascii?Q?6/NwA3A72h9luZOgLRX6lyJltsRFrmMnzWBP3Me8gFpTPmjicwarvLNypYPU?=
 =?us-ascii?Q?Rp/bTCmlt6Eb3yDS/O5FMHy0e5hAM2IgdPFDk0+A46S79Gf3bAHXyIAEVtYG?=
 =?us-ascii?Q?Kg+oHWCbNgRmH3KtsN5cgCE6SBm2U/W7PxSBcyQcRmr1k/jHDXvFbLjUmf2g?=
 =?us-ascii?Q?xDfHk6eTWvYqv7c48fXvfw/8WW1tymYDi5kX0jonY/98R6xNiesEKMhU6vM5?=
 =?us-ascii?Q?wBbmrLH/l+sP927feIv84cB04NoHLjalXwR7O1KYK4t50K6tPeKF4Zrdz6yB?=
 =?us-ascii?Q?GSBdxXdnYcfgzCQGnM0NH5j1a8HyT62Xds/+NqXtY/u715RY0DbX0c9WabQw?=
 =?us-ascii?Q?IghARAUWLyshJfdXJqr1wGUKTiU1cJGQHsnLYaEeIDYttT1nEjwJNFj+dBdI?=
 =?us-ascii?Q?2SexNjcypfpWA9/+5JULRGxXsb57DKmWuWhyFInzHej3bwABx8VUVx6HjiCU?=
 =?us-ascii?Q?LMXtJCJyzuIws7tV33uJspizOyJWE6tG53NRrAANk9T/03dd5FxElUyUSURq?=
 =?us-ascii?Q?AXMl3vAxn0lX8j0zWwlC2rvIBYyL1dv9EWcYZyqT+SoxXxbneDVqN28Gzfj4?=
 =?us-ascii?Q?GB/dVfX6FIE5GaeN7GLHQFFtOuAVgcf45lTC8g4mUxTouA1vqL9XzTx1ve5v?=
 =?us-ascii?Q?bNiPysxvLjELnlnn7Ce/X+kHVt7HbjiOOYtpOxcUbedmh3VSEiN+gi0mR4Xx?=
 =?us-ascii?Q?EIXJyQGOpu2AAhExdSr7tU4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f28ff94-3fba-467e-f8dd-08d9ee42de4f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 16:15:21.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 258omyiYSC+eQehCxA3DsY4utFgNdfNH69TY+fIjpWnUjN775jSvfdMpfKggbXzVUvqbyzIkbs+YEstC9BeFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548

This patchset is related to issue #48 and issue #197. The two MP_RST
patches are moved from the "add mp_fail testcases" series.

Geliang Tang (6):
  mptcp: add the mibs for MP_FASTCLOSE
  selftests: mptcp: add the MP_FASTCLOSE mibs check
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add extra_args in do_transfer
  selftests: mptcp: add fastclose testcases

 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 135 +++++++++++++++---
 4 files changed, 132 insertions(+), 16 deletions(-)

--=20
2.34.1

