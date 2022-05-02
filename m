Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A32F29
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 23:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651534139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZQiYA07YkoSDfTEPyH49pCBcIHpMQnIFaYPhPSN9bM=;
	b=l+S8Z8FPnXR9eBgF8jGgYWPISDe0eG5cKnO4yM0FIL9vp/0yd2bdzM0+SrpF+iS3fdGX0V
	BIiCierrqvFh9SO0mHuq7mYOi5ows05DxDD1F/rcV8cwKjFQLaOqnUul1Y3J+th4UYvePa
	Vqe3Ucngxz/taybg6OnRdItZsEaAfdI=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2177.outbound.protection.outlook.com [104.47.51.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-IJNLgt-jNSi1Vj8yA0blvQ-1; Tue, 03 May 2022 01:28:57 +0200
X-MC-Unique: IJNLgt-jNSi1Vj8yA0blvQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPYgshqDOKr9Un731whyctdHQRCc7XoVTrqTED/jO0bbK0y1ysG1BNs2eC50Qc1+LNe1AdYCjQU1cmw88LOk1vQaIi8zpM8ql3Las0jjVf+A45xuf+Rosjt5pxK1cSsMcxnnBdJ6OsvB+UDyNHFI+ZtdqQxCbmIBIuBrZwg4tZKtxguqOT1NU2qhGMtXNu5qeNqLZb+TwADHMp+kWYsSTAc51NXgvQrpcq2Gdr0UEdV7bxfiX7c4F7/deDUN0TcBEegyRnrOShsOxaYxEVPMrfdwNvR1MwjjV9B7+xbmsUxzH2+HX6HwiMiE4OoDShAuxHFmVb4or6DofH93FwwxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaubN59tx86sw1EqKSRp0uICPwHchkFapGueXrexRjM=;
 b=H5ky5wH+MLbwmEGT8q1CmNCqT256VgOb+7fy3iVsclAzyTJ+XjgW3FZU928tAH/pMoUHh+mzh+bZWJnaOsU2apkmHPq6oU9Kj4h1u+iT7J8Hj6e5ehjTYsYiNn41xwQiyv6PIfA4o52Om8GBahITsbC/9ziHOJHXYKZhkw6Qya1ieT8lazJCJ/5eD1m323BUmifOkPu3U3m3CckW5K8Lvkg17NOt1sgK9ObACKZBXfsD57airb3DwfqEyYs9cyBwbuWL8X2JIkCZBT0xHinhO+WRjisiBadcXcHhIwQ0SVG97r8aIlUc3Kb7UVBMbVYrq+2Eo+Qzm96mdh5QcCzlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 2 May
 2022 23:28:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 23:28:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first scheduler v18"
Date: Tue,  3 May 2022 07:28:30 +0800
Message-ID: <3598eabc373ce9ee056cd2219fd1714926238702.1651534060.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8a90b97be579a420d37c45012bbf1075db5a81eb.1651533987.git.geliang.tang@suse.com>
References: <8a90b97be579a420d37c45012bbf1075db5a81eb.1651533987.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81e5a2b2-be3c-483f-4ceb-08da2c93874f
X-MS-TrafficTypeDiagnostic: PAXPR04MB9256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB9256DE2FCDEA6537ADE57B11F8C19@PAXPR04MB9256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7FO34enfFGxq7Jhj3eBdIOaq8HBPF3VCRWW97rrFvdBwz9cFyPiNMqeWiT6HVBtr6asc2g+nUzQk0y8Mv1ThZsFb5mcXdFUTbXywG7HRHDCKMH97Ft3ShKlNkLQAnHSbgos4O5+KYRFxyBipFuIqmlD1FHVElP9jcBalCUu7EqObCW/mpzPW5iqpVJPHyS0IFuIcdq63aPk4dvVvqQWl8PjYW2sjKUJLBpBcvHqG1ehIGpP5+EYjgGYmDDu2ZPiUcWOkm6q8tCFTlar0ttxwnD8KIrFAtIcuRoXtl/ysmE5GEMerM/4TiOladaYO6SmjOOemOiGxWf0IuURKd/K58jCyxOXjslBaWG87k2TBfhtpesntTgAtWsYVjaAXt4Hla3ZqQFg1FnnHqblquVL1uqUxXO+ZW80aoBmF2yTjlsAp7v2V9ocyN30gbZL3Wpsz7choc9Dw6+qo5y8/lvFeO3HS3jUaeXk47/K81pUxqgBTS9w6v2FFYHg2tmOr5wgIo8HNBza6Uiwxetdw3ZX1GIX5ozJNSVYvg4aGjTUbserVQDipTj6dC2NA5uHTfNZ/t8L4m/jp8PSEMIbPYdVp0UMZk5LVFhpsCK8ZOWuXR1mKlPSRbfiiVpgxYYTvUATO84puG1T0mpJrPE8533sevm5UfMANFY8HIs3EvpYSk2TALf9IM9yFnBN++l0p2XfFmHWBuepVt47HNWX9x8ABFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(107886003)(186003)(5660300002)(44832011)(6916009)(83380400001)(6506007)(6666004)(36756003)(2616005)(6512007)(26005)(6486002)(86362001)(2906002)(316002)(508600001)(4326008)(8676002)(66476007)(38100700002)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnRcIZVyDWVmKdnOExPquZy9IYc/sBRt4nz3xQYgZ9yE1tf6H/f5jVdlq6Ub?=
 =?us-ascii?Q?un0tItJ7Umv7UTtq/942C2ZmvuUl0CjcIfnM7ZXS7Y7+3jc+5mkJhsHLGLPF?=
 =?us-ascii?Q?EWU3CSuulO6Ip/1LSl4+4pxxtwBG+6WSsiWFE4FHoVJPpPG4Ak3hUgoQnK1h?=
 =?us-ascii?Q?a7a2NdxW24vbiL/szbbm8c0ra6bG2WKGPE1jL3JMy+1iKsm4nceHFq6PVzbl?=
 =?us-ascii?Q?8s75bQVvx+9GaGjocXj4x0G+0OQJqVsocBMRfZ+JOAixggVq2S4UMTjMv3W0?=
 =?us-ascii?Q?cTZk0iQ2J8APgsHs0bBRGN7mrABShKflLUGfPJu479ZW+3VO8xSQssUiGSU2?=
 =?us-ascii?Q?hteafl5PFQOIAmX7BIlDmWuQ/5X+0wC3VKl/S7x6w/2aJfps5PWEawyLS6d7?=
 =?us-ascii?Q?/IgyCc3xbKq6BYGQglDg4s/POwR83QD40AE/FC5p/LT1aRKPrX8oilbA6E1B?=
 =?us-ascii?Q?Q/jqmC53RrNp359q6EbtwwBr5lfd7Ew50H+PMxO1dYJ5i9ahgqZz0a5fV97Z?=
 =?us-ascii?Q?1Cek0BJtWwP9J8kIZMBW1vaPfi9rUzoxKtdtih8op84YqxZb12QzGVKlRX0C?=
 =?us-ascii?Q?0C9Xo6YpB/EX9iLxYjkzhMS6ooQFbXKUC3aEy79+ccSySqEOCVVHgIZJM5l5?=
 =?us-ascii?Q?NzaWlL4/PAs2zRJA8RlKIG9fiemdFDZsdJqHvqKuvPALE+z9QeDc3HcD1Jp7?=
 =?us-ascii?Q?K/NFUO/eYKy7ui2f1sdO5Gq8scSbOrRt1F/GrrdYsZnLnQWZ28eMwtWrhZ3o?=
 =?us-ascii?Q?XendGDRBK9WZS+7VK6Alm8sHhp1pKTEUUD1y488cXOC+KDXO1yw2lgGBcltz?=
 =?us-ascii?Q?yMJCEX8m4roA9/f6c888qhVkX3anS91CDVYrdXtdeOX5zDnAJue+CIcV7EVt?=
 =?us-ascii?Q?MQ1FtPuUYCpaNa3bN100HrynokCiHWWFFJ3FMrwyAo9it1Vqnb+eIgKD8qAd?=
 =?us-ascii?Q?dKkVHAmzUQbh9jv873PZ8oGGoD0vAzc/aUFhgO4GAO6iZLdC+km5g4HC74En?=
 =?us-ascii?Q?ReVWghO7/08uKgeghvK1NoEH/1F5EsCWNabC8W5CAmoD/D+MVBgmMImBs7k8?=
 =?us-ascii?Q?ESvahTCOyPERRKqJPfbByZsf8BDwv3wzi9JqefKKZr9whM6o4Xxwr0o2rNNU?=
 =?us-ascii?Q?p6GoVcE0O8vugx7oAJyyRy+yUGpH60KT+6GHam5IkYzHv4PyGocIf03DLpRg?=
 =?us-ascii?Q?yswsKiWodWL5uvdWxjTLZDBm+C0fu5qU46qchjDtNEvC1Voh2wNfhTvQwJq+?=
 =?us-ascii?Q?dbasJUbKVfoqolx6aZpTW/Ta2ZzxJuNUMi8sI2zrTrLMVO62H7ZUkRZLt99g?=
 =?us-ascii?Q?bSPfYeEpHvqgx2YXyFpXxT0SkMGAdRwswBn9XYaMlYNV2uivDw3lmJR0PLPY?=
 =?us-ascii?Q?yq+fky5xfQgcUXMBHJFM5pN1FCyS2tWtSOfPEEN6wjwN0RB1WXFdYDvwJZFV?=
 =?us-ascii?Q?6R/F4uP5UzindCPoefxNVD11cHYMfPAm6e4BuozSZYzHvYnSOuufsswtJ5yP?=
 =?us-ascii?Q?QbuNVDoiPXrNHSKcEYfULzK+6tIVCGuVWj1lJ72o4goplnwSdr4xsXaXlpc5?=
 =?us-ascii?Q?d6epQ01Dd3adTvXSx53Wc3Ir0SRtCpT+73AH5G9YGgtc49nG2+X6LJC/eFgd?=
 =?us-ascii?Q?VaeIFEeGleV4R+uF9tROAy4y9DI0QPv4gwsISkpa49NdKNpaKTDlYOynsNq3?=
 =?us-ascii?Q?iUcwiLAVue3ZHr/T9PfeTx+YFQIPjECrGRH7uK90YmjCcRV3+LXnV/QK2+D1?=
 =?us-ascii?Q?ARiBaghrARtMstXoAOKXf31mVNQN4gU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e5a2b2-be3c-483f-4ceb-08da2c93874f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 23:28:56.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K02Sh50bc5frST53viYu6+6eJeutGy9xxtz7HeBIJQ5cYQXwLTZik9zKgAQmvpMOhb9v9aZGp/04TzG7vsfUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256

Add const for all msks in mptcp_sched_ops in mptcp_bpf_first.c

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index 0ca9754c078d..8c8acf04fb92 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -7,16 +7,16 @@
 char _license[] SEC("license") =3D "GPL";
=20
 SEC("struct_ops/mptcp_sched_first_init")
-void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_first_init, const struct mptcp_sock *msk)
 {
 }
=20
 SEC("struct_ops/mptcp_sched_first_release")
-void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
=20
-void BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
 		    bool reinject, struct mptcp_sched_data *data)
 {
 	data->sock =3D msk->first;
--=20
2.34.1

