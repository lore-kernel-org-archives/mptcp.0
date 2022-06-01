Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FE256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KBQGrHyjCA0zOO5XcBbJrTDGfNm7ndNxNLGZxjHdUHo=;
	b=gTtKMUXfBlPNPHj+kx85bjxdX14yWY5RWKHD4dA5tvdJvj5ws5m/ZWnJrP0EfG02WrX1Ah
	5STfBlIliXN6M168HJkh9XEp2m8DrFfXto0RsGy6e+dpZ3COKCeBhlxo6fDgEWCsbhOCGB
	t/ZKy4r/pX8Gh7cVWD9uqmfyJoYH3Og=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-BWYf-112N6Sda_XSqIXbtw-1; Wed, 01 Jun 2022 16:08:28 +0200
X-MC-Unique: BWYf-112N6Sda_XSqIXbtw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3Tw+CSed8qNotwKi/yQL7nyvGjGFIZfAAK8SO54OYfCkTTwT1wCsENCK3NX+dcPb3lUi7+LrBEAUFjLNW/bu2iSsnafk52Wg3vUDrcGZPO4hjCF1O/G47qBtZQXPRJwzvtxjBYYUx+K3VYZiHwU0upmKzohAJzFUGwoKW6jo8x9zQfvayIaBAAq/RK8bGp1SZnZTqU9f8alberNkrDke5Yp+y4YopCNVD1uFQEZyKygbonA9zRnIFxwScxI5ItwxWHxM5IMpxM4xHgEm1xuunhlxWwl2WDovCCbUfOeQ2yd0APBeUl9lckzseiEi0FwiaizFdE2Ax5c3FOUAoi4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whsKV+RfkD7Hr4q62N4iBHlof58kudxiA9UwTeOcaiU=;
 b=KhZMfotOa5BPh1oq/7HAGDSlBLXCWicLeHH8Ivee8pWublS+6nX7bbmInqI21i9pPfepf1nOtlx2bHB1j6iZteZWQvPjkOmrqXPt01+GvaDVDJwzzE5jbsdrv0l7KiGJ1X3rLtBSQFMfiGqGuHqXOhyKOcnnc7Vv2y3PDltWGle9NmV0OwfcOCcNAZgriiuLynLcwOArdvXCwtNG89a2xmjFy0hiGTcuggPJCcOT6vzTnmnVU4eYWLmQFcM9ZX4s8EbpDUyXWBkpc7cC4cvMtm8FNQTKegvFzVSGjVfHjwR29aQW694ixL3JleIWqm1iEVsAyMbor6tU34ErMJM10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4805.eurprd04.prod.outlook.com (2603:10a6:20b:d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 14:08:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:08:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 00/11] BPF packet scheduler
Date: Wed,  1 Jun 2022 22:08:13 +0800
Message-ID: <cover.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0212.apcprd02.prod.outlook.com
 (2603:1096:201:20::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58c941ac-fcef-462a-24ee-08da43d832d9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4805:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4805C15F4ED7A3E7A222BD82F8DF9@AM6PR04MB4805.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BxAPZwHY9I9g/SWVH1W/ETNA0pfIBu3Numxp8fzsdft8R8ivpqYLhwQWXyn+L1wSZd58XR4nYy13fihnDqdrbjmLAL+6+fX5mKB0V8klpT2BsUah2iuTULOuXy0M8y+uy8TvVi2fBMZDTKu8x6pC3CFCTKFX+V0BvYD1kpKhIL70MFTrOrJrFEe8Sni4rbNV6oRyQozMrNN6Sn8Yp3B/AVWQOj9TZBzjwTspoJHYLP7HaalU4bYZUck2MYCQhrT62k4wEncxcDTM3F9P2XjgOKcgq8WsxvzrHE/QhfpEn11PBC/GuLP8AJCgFJJ5DNXAcLhXvRQrXY1uAb0n3+cqF/bfP12+i3SS2pGQ44w+4dk0wqXV62eqf+s0XU5x2XGozAPQ1CMkUxHDQh2Y3w+7DwGkW0HeSEAjsdKbtPAmEy8MpHD1BLfFusOE1YWkIz9DEumHmqf3fBuCsAdpat/xabTqH7OE1HAMCYU2ROwk8Zayqtp4XpPe8Bi0glvcJv5tXxk3H3hJeeVePAqT3ccp7hHCjVt+/CajXjzn1QRRxNdMGY4R/EEirwdrbT18MVFOKbyIp985fT0QZ9WxLcMdOQNe4pi0Q4gPc9sPknclkRfRrU3POeSJxSV2LHhxgW9YAUPKDnOfyE45C0NPTpKDJZVCRtALsZWLRdkd+RRYqVxVB6KUNuOdYC1oGU4UOfXzGVsNp+UCzn17ttLaEG2fXPZj5hNsRy1vHWnFjoBO0oehN9feq+WT64GV2jpL7Ti0Aa0hPIZw0a/W8TAd2DmWBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6506007)(86362001)(2906002)(66556008)(36756003)(4326008)(38100700002)(8676002)(66946007)(66476007)(316002)(6916009)(6666004)(44832011)(83380400001)(6512007)(186003)(107886003)(966005)(5660300002)(8936002)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qbG/xM+0SPq1ibmRhxA8yEe18Pd6MJGDdutMFlLCI9Xp/b4hlp1DLSx1PYQq?=
 =?us-ascii?Q?3X7GSGtBFt/oNmIyaIRtcZz/fUcjMbRwynDHqzbwnUvLiS7OLKc5D/AGoybN?=
 =?us-ascii?Q?ndutdDrbtjVeLgEGONDQtgVaElC4idQypeM4hLCgolGUjt1qCYJ0zyvVbZlh?=
 =?us-ascii?Q?jOUZ57k2fNr2tHwU7nGgS7zcKaQ22nbBDjGC/JCy06dReNWRsRHYTx+xV2NB?=
 =?us-ascii?Q?c3s4X/8OaQkzOHLv+SZ7MJ4+wJcRmSSBLcbYFNAwJO0bsUvxIJOztpEd1U/H?=
 =?us-ascii?Q?miyLYrVbS5X/icRDDI3J0c/o84lGueByY+IZs6XsdAbNlC4QcYvYpEPseXuj?=
 =?us-ascii?Q?xlJUV/Var5knnlfoWpsuCraSBV8WK6L69lYp8ms/WLS0/hpIOZZRlKYtpk9M?=
 =?us-ascii?Q?NsrxU1O5D3gAzGtiyhh6nc1BW2+z31GCA40xrQhTj1ceqmxoU9RJyLZhgU1g?=
 =?us-ascii?Q?ecGXnqtMj+h5hhau3GHWPhavdDmeNteb/UOl37mrw+r6QM2VwaKYGyKmq7GL?=
 =?us-ascii?Q?YdsBoECcgaym0+K4wTr6N+WNssnp6yiweAB2TDPR9VAk0CDMh+bOZvcxXg6l?=
 =?us-ascii?Q?lo+30sRQUfm8D2TAtfledUZScpXy+2AyOqzUmVHvnHYQycN1ZS7bWyzlfkun?=
 =?us-ascii?Q?7g2070zdD0Q9WQ81dPZ/ZC+0pgaHBzgaYmNa8PwJRC4VP+avNiOWWUhGGDam?=
 =?us-ascii?Q?AMhR/1MDf9hPcA1NckveHehQS0yUZNzXn2GIKV5Z0gCu2Qd/aZsq8hvZ+3qL?=
 =?us-ascii?Q?9e0Bxg7f1ITxbvNNoHUNuXiu21AjlyeJ2Unz8OFtiT+Lyv6yH7bblQntOXCL?=
 =?us-ascii?Q?YWPx7YCk/nAJLFonu8cTdDoX7S5akxrCOyTsdrNVfkhV0UH/er74vLLfrr/2?=
 =?us-ascii?Q?LoSmYaCwsUH1abn02pdzuMt+MZgkn+/CfbUOv5lTZG+E4gfzbXnoHYtHjT1X?=
 =?us-ascii?Q?/n7Q7T1VqDdbEmLFBbyBrs98K4fD1Dem6o+ZNktQsT6tjYqABzuxFD6fpRdi?=
 =?us-ascii?Q?vkroeyuIuvObIFL9kFqowPCT1ItQxUeSb6d/ulAjaZgVTscyEnD1Rui6/y9N?=
 =?us-ascii?Q?HVSUM9Ir7inXnXTEK+3UsGSfiJZuJO0jnxQZrL6zXQlRpTMqt6QXL9yED3DU?=
 =?us-ascii?Q?wOdBZjXyIwSg8AXODe4TAszOLgtbpQ6eEYGUeuMe6ZDr6J0kNgAULacqtGf2?=
 =?us-ascii?Q?cIWvyfr2di+bwHZFp9lkZCA0oj/PgcQqA1c6T0wW6PhadVK67RfU3qVlV+NX?=
 =?us-ascii?Q?wPb8CbHf20qSsXyv17VE0CghlgXTEUpCUeQxkQQsWAzq9uKQyJaBI6jzCCpu?=
 =?us-ascii?Q?CzMr2rcMWHFT7Tf4GFRUqX8sh0crsFhm8SxGx5n7OdJdhIxagbCPgl1OHv4q?=
 =?us-ascii?Q?DgeYYnYZBAtXP1R2XtcKg9/cyyOU38VpA0GpfogT91KRXuByfES0kMimtUTI?=
 =?us-ascii?Q?NWOisaBSYbTkOYh4/0zzWxB/CY0xNOHT9jTz1JGCKSaDGwIj88DnM3wm0hSp?=
 =?us-ascii?Q?7HOXWFXcLl4434K3oy79eI+lscUPG94dHr2navbmKOL904NuIYUXgyX1hsFF?=
 =?us-ascii?Q?V41eqvotS3rQZM/zY5Q7+mMIlnw2B4VBeM3Ap7rN/JtvJK9n/ViT4tOUOcn6?=
 =?us-ascii?Q?Lma0VqjRWR1GxWEKhQxQBeXXC9GFxVkj19ZcYZeBqwP9KuW2O0UKU1Bl3Iej?=
 =?us-ascii?Q?X1ohfL2qbdrjNKbJ1ibqyEiCcPycD5AnpVcUxGwU+cidWdZnbTHsbnNt3oMu?=
 =?us-ascii?Q?aS91DJCLEUas1wk+hM08Mh2xwf/dizM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c941ac-fcef-462a-24ee-08da43d832d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:08:27.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FJD4kD7FSHuFnUoZ1K7UIixb3KeSoOYT5vE09J88gZxcdWcJWwAihrFNxx0KMZJdw62DPnXDqYY6Qxs/qLdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4805

v6:
 - fix the warning reported by kernel test robot:

>> net/mptcp/bpf.c:165:6: warning: no previous prototype for 'bpf_mptcp_sub=
flow_set_scheduled' [-Wmissing-prototypes]
     165 | void bpf_mptcp_subflow_set_scheduled(struct mptcp_subflow_contex=
t *subflow)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 - rename bpf_mptcp_subflow_set_scheduled to mptcp_subflow_set_scheduled

v5:
 - add bpf_mptcp_subflow_set_scheduled helper.
 - drop padding bits before backup, use BPF_CORE_READ_BITFIELD_PROBED()
   instead.
 - The new patch "mptcp: add bpf set scheduled helper" should be inserted
   between the commits "mptcp: add bpf_mptcp_sched_ops" and
   "selftests/bpf: add bpf_first scheduler"

v4:
 - merge "mptcp: move is_scheduled into mptcp_subflow_context"
 - rename bpf_backup tp bpf_bkup
 - full patches of this series: https://github.com/geliangtang/mptcp_net-ne=
xt

v3:
 - use new BPF scheduler API:
 - add backup scheduler
 - add round-robin scheduler
 - check bytes_sent of 'ss' output.

v2:
- Use new BPF scheduler API:
 unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
                              struct mptcp_sched_data *data);

Geliang Tang (11):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add bpf_mptcp_sched_ops"
  mptcp: add subflow_set_scheduled helper
  Squash to "selftests/bpf: add bpf_first scheduler"
  Squash to "selftests/bpf: add bpf_first test"
  selftests/bpf: add bpf_bkup scheduler
  selftests/bpf: add bpf_bkup test
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test

 include/net/mptcp.h                           |  7 +-
 net/mptcp/bpf.c                               | 34 ++++---
 net/mptcp/protocol.h                          |  3 +
 net/mptcp/sched.c                             | 60 ++++++++++---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 17 +++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  5 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 ++++++++++
 9 files changed, 272 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

