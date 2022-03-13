Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E573A46
	for <mptcp@lists.linux.dev>; Sun, 13 Mar 2022 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647169160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sP6ZUv1Fc9Ql1bS5anXDWNmRXNxobs2S0W/s/CdUYto=;
	b=Dc6TMBC/YunymN32Rg9jReOCd1PrM0hl5Q1+Yv2kpszlGfsjzClcFNizouJYe/nrOFEDZy
	Rjr3TE3vdBXq82wWRc3veQkINY7THFq3y77b+aOGFWoLCLOzuhKbLtMfzFFpMuW+6zg+Wl
	tMqSIUfsm4tNflzo50Dk1GmoTVMd0AA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-Ubay5OPDN-C9oJpMT_IkGg-1; Sun, 13 Mar 2022 11:59:19 +0100
X-MC-Unique: Ubay5OPDN-C9oJpMT_IkGg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNvdnmZk+P8iLkg30I4KzD/0e7jOmLmeHX7+lPocTbR0MlSAZ6fzWmKdtFo1+n1BBZI2YPLpF3cjrKt+aC/3zxBFzAX0TV9ponYcw0XzAsvgcSFlAfcdtUgA2qeAwtQYJqb1hA3VmCMfV4pWbwtpw86+KikMovAianGX7zbnxHx1nzYsR24kAQJaD6gqtuFzlORHAkmSZdqGXA8sTBi2P7kYDGrxQ1CvBDad9F78LU/T2vpP5dNNBUn27JdeAEuRyXzirCs7GHD+qrlX1crZ4Xa195shSZIpk8/FQ4brbLPx2t5O2g9lmy20jSswgbJwftn/FPEERzVmkPfJIeBBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hOIUjmoNlyFeYbf/lfQ+IsEU95dsBSxEf2bVJAEERs=;
 b=WWVwuHgLuLHBrRhfFajFEZB7GWaJzLKLJSZoLsdrS+jNs7tYNMVH8KvZGFTtJOOTnO/RO/PK3TvPQWklbx5yykyFw58wPv8AxO01kQoqVHNnGCsBz0lvcgDDABwafSU5liUiw2+wK616v14HtKrvq0Xra4ox8u404r5vaQ+EO7R6OASsnsZKuc0MLEAi15AnSZeH4HNLAObB/psDAagMErR4K19vvJVKf5Hz2qaGcbjDSMecd+gP2uRFxPrxapwIeX6owofk8wwSefTcgmIdHuQgKhP5ioBqBmaB9GALIAZT8yg/kw36BM0BC6zUpWm/p4CilIfzTbMJ1GX8MSLGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Sun, 13 Mar
 2022 10:59:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 10:59:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/3]  check more values from mptcp_sock
Date: Sun, 13 Mar 2022 18:59:10 +0800
Message-ID: <cover.1647168955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 146eff5f-1d8a-4116-eb47-08da04e084bf
X-MS-TrafficTypeDiagnostic: DB9PR04MB9283:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB928382C0AB30B39D3AA78469F80E9@DB9PR04MB9283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mHgG3BcBw6vtYCivVBSUPtN3VHXj6wJOUkodKL2Pb+iukCBlqhqBiVTxnOCF064Ao2c2WR1yHMQxt0OS8MpX07FqkdAaykishF8NJeSGJZI54JLJfwX81cL+sVMmY552+4eVLLVR7QIf8Rp8c0rfKODm0M95icuB3PwekXAypvtsyF1cbos0+eLG69kgYDFFsWznj7PuincHFja4cNBf/bwq5783Vq8v+0+SjmGUslHBKxH9KYwY7TgSNgWR1NzqIiX00YVwe5lHK5ZXXUNin9+ITviGsP+lw8aesi2NdQCvgHzh2Xt6qVEXCNKjg142hF9J2sQvEFO503yCq/RkG7/DvuG37qIMQhztcJxlhmsT+TbnUcpew3RYbVFH5YNH8gRPvbRdeDhgctnvNZ1KePo9NzGkAPUeUzlbGhtSuZkV9HIFOn+f7UQnEtRqZecutBot+eBu1T2DKj0fxSF+UP5xD2ABd3oy0x3JVJBcr1sehqhamopH/eboriFJD2YHoyT3aWyiZC6o0uCwNwXP9E0eEJyNrk23xnY3AgS4ynRVFRTSx4N3Mk7UQosn18X7QTsk/YRxSjmiZBHlpkVKZax2vvG2p5WMp3uwlmvij98pxtrCIVy6OvF0pbsldt8W2hoWvywHaaJtm92+8P0h9HTDt3HmGX3FsaE70VKLhpUd2Ae5RJgVxwbJxkMTaDrr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(2616005)(38100700002)(26005)(186003)(6916009)(86362001)(66476007)(8676002)(4326008)(66556008)(2906002)(316002)(66946007)(8936002)(4744005)(5660300002)(44832011)(36756003)(508600001)(6666004)(6512007)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yxP8Por3TMqxMAgJMGVOLZxgGyXQgsmAOUlfGuKfTHNIOGF/iLQ7Y6dHs/ZN?=
 =?us-ascii?Q?h3NejF0hy+839gTeQ5zj6OMq+yZydfsz1IN41gaFK2+31lB8YPArS6qGuVWa?=
 =?us-ascii?Q?AKeO57M32EJlZ/sRlUCe1GpSwnfqoosl4qCHMSpzlgGxxV8Xqi9eP66Y0Mk8?=
 =?us-ascii?Q?aMVc1yQ6IYFvFd8fxcYH/nRODd4qYns0HHdDnPA3g6qoSOpH9Y1Pe/DL6XFL?=
 =?us-ascii?Q?Q0SJfKc/npy3m73/vbyYt8ChmZkoYJ7/QAtbxa3hn3vLHMmD7YpiB7b0cgF9?=
 =?us-ascii?Q?fUXH0fMTbvFRtY99w44ayMrJyHymCa4BpSwx98OqOi6/Q/Dhz0NijGlsB3cJ?=
 =?us-ascii?Q?cSpLUMic4nNw5mjX+mII0Xk7MVsmM/XlOrRfbv7PsP3k5GRnc/CD85SAN3Ei?=
 =?us-ascii?Q?byAG7SjFiEnYCo6zu6xFbhDa76WCreLkzUXUMkAGBWhiZD4eV7150WMVc2qS?=
 =?us-ascii?Q?L/61IlZikfmNwFY1ChYfOgyLxWebwjI4dBgyEsjCxqlFJ1g43PkFdQ75aO2z?=
 =?us-ascii?Q?v6hyb9D3BtWhPnrSdsM7/8VDIAew3pfPg9plm1RfyBEQDJE7hOIpMtTUaHJW?=
 =?us-ascii?Q?ZwNWXnKd848IzXMa5oC9otaoZgjC4B8QbpaZc2v5TJQs8MjYbuPW+LJncX6F?=
 =?us-ascii?Q?WJwSJqM8Pe2pqvWhwVEiJCcVPLgHgqdKiZkCx8liTDkfllkRJ8egmAaMfjkD?=
 =?us-ascii?Q?5v/LNI5KFdjlA7dg2lYk8CsHpFOew4v+jQTg+1jxiJgDrDOjds6pRcoZjSRR?=
 =?us-ascii?Q?8XZYoYWmPzOMZy+eP6rKIjmd9q8s+NSzRUX1BVNdgPHO54l+CdAJImdqPogI?=
 =?us-ascii?Q?L3j3cLsKrIkqIE1lQArgWp7HXO4MU+sq2hu15E8IppFBbt9pj/1j2Bc11CvK?=
 =?us-ascii?Q?PSHrIBnD/zFfN3lNTQR7QDVZzKKG5v+hSC7QzPduPI6DBwBHQPUtgQZDNaBw?=
 =?us-ascii?Q?d0oTquoJDJjdBNC9at3agQ+VG3un5vygq9FbYyhZOOB60ifOmBkqhBqSxh2M?=
 =?us-ascii?Q?psQIPXruNXV94iDY0EVBpj+5wnGserH9RbpvKXNpVZdkunAcXVQNIyJAO68x?=
 =?us-ascii?Q?1yt77VS5n+JYCQF3LNEw8gFchta5HolOBairRaYAOmkifT4ZIp/qs7UlqOSS?=
 =?us-ascii?Q?TwM2HYLzIS5Ru20//8MGo+yOUOoNUWFcz6KmE3MnI9biZnA+hGG6zDDb2r5K?=
 =?us-ascii?Q?9kLZqJaWoAgZRxYHDv+LXLuBWf8XLJTzsCE2AQsaY8nr17sYOEg5vsKOH88o?=
 =?us-ascii?Q?CH+vRZKyFNCGTYdBT7hLCQnlLLUvpgnnu/Y6sx54gy/nZNWV11CMDIOKWRps?=
 =?us-ascii?Q?D3W8pf4oCCBNytPLVfO0vI7BxemvAJlBt5BOQYL9Lj3gCSbDZORyGZFMUCn6?=
 =?us-ascii?Q?y8zPofRwf7Mz/ZDgX0Lnda47dBEevzzobERD95AgMdelyJOgkCI7abBppNB5?=
 =?us-ascii?Q?hng49mB7yV1Y6Gk7kG9qIe0rYHu1JIDsUxfhHQ8WANlqZZWmOOj69Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146eff5f-1d8a-4116-eb47-08da04e084bf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 10:59:17.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WORELzTqCPL8mfn6ZDWGglWBrYxq+kvF44qeNyEBgTBI1Bq8XhnK1ilbymLe+OnAcg7avkLCAvfyst1va37Xtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283

This patchset checked two more values from 'mptcp_sock', ca_name and
first.

Geliang Tang (3):
  Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
  selftests: bpf: verify ca_name of struct mptcp_sock
  selftests: bpf: verify first subflow of mptcp_sock

 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 43 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp.c     | 18 ++++++--
 3 files changed, 62 insertions(+), 5 deletions(-)

--=20
2.34.1

