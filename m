Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1B7C
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653305632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17n/n+zZTKkDrOGtM9M/ybSxw/ljaKDcsnksZx6dfZc=;
	b=cG7MeGUfVvmFdc+I+2Tlw+SyYBGeWKSOdh5u0UTYyfhMrnAotCTn15nXC3LjVjz3uNOIzD
	AdjbtR1XU4Gv/fLIsc+5NLnoeHRoS1V7qpkWzzmZP2eJjTvCb5+QPigEwaNAVBrSCvDdVo
	i1c0gfkXrkXD5zI/6/8JccVvDvVYGNE=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-1bflxu8OMsCB4pAEnmh9CA-1; Mon, 23 May 2022 13:33:51 +0200
X-MC-Unique: 1bflxu8OMsCB4pAEnmh9CA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfIxXPxlJbpGaPjRomVg/ktrRxqP8vB2kru//b1rgaYDXWnvQk1iANVa8ppenQIXdERNnavKj0lPpFhfNQrUF4oL1ybddr5IIm1xjGgs4zOiCW+28aJNGoezDHSi2lx12/xwQ4ZR7aDtXv0BXfIomtN/j2Rk9JVlQ7s2WwbMnaK4Ymiwo2sm4EpfFw/3133PRsCv2xsf8PZk//ofrW9hB7lPzWfQ/amnU2+EFuVZmODq/Ss9NLyos6T0S/5s7Ly7zEAIHdxb7bHJ8i1pL7s+14w9QKKY63T6TQs4VF2DRK1sWGw/i+YQViXZZwhs0recaI2cy97l8Z+nrc3ULGL1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mXNueFtOlAKlfyg6YN2SnAi89vAEZvRizmUrnz3U18=;
 b=iQ/ZcDrb1b+5yPxOgPG7U9E7U3Y2/OeUKNPQBYC11/JNorslJrBHRdSTjLE7PZ0is2DsiXGhPR7twVrHWPuAkxmYg29fn2DD3Dhh/pa1BFKek9nzAiSpmcqgGb1+YXhOLzLrYHv+EIy6NugjlgufYIpm/xtlVeeFxxUd7qD00rpRfYnC5uDkr/d+i1WZfugeF++4hFZuHtHkmVpaREzVumzKXCJnylK2MemltMpADmO9mpMqm04+bYlyyKmTvKi6WWtnnt40M0WWDekmu6AjpbUwCnDKDjYdeD5nz6zuexgvNbuSOhPSx6ax68z49cR+tQMvHLgSO6UAEXniKqEITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3899.eurprd04.prod.outlook.com (2603:10a6:8:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:33:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 11:33:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/5] Squash to "mptcp: add sched in mptcp_sock"
Date: Mon, 23 May 2022 19:33:36 +0800
Message-ID: <d7b1c1435e9f146011acc7dad70756bbd31d956a.1653305364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653305364.git.geliang.tang@suse.com>
References: <cover.1653305364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b684003-5f16-462e-36b9-08da3cb01b8b
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB389997F9FFC4E14B2674E472F8D49@DB3PR0402MB3899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g5EsmVdyfRpX/dQHQYwdv/qrPfQ3iI++A/aw/H/Wwokpmk/MdGLJjVj5Nix0+MqoIe4PeJA87uiuXaKF/0DDZi8GeoImlSBwT3T5iLiWKeRJpfxSN+icZu9j0BfexNyvwaWTwZ47IXQWfUo1d6wpmT9KtgMmb1pcO4ZiDnFuMk6YvgQGdoBoIMzJjoZsrfYDVett8eV0/9GwfY+QJ8ZrHb4cdGOZZW/011h6RosKAA/Ox/HblY8F2uwXkQw8NRKMwP7/uhPn4H52T4IqbFqJLdXVF04M+ttH3owZoxZ5eikO1IG/iXQQ1CDx9xyJ1gvdktc0bBFYBikhe7JJmbfmhA/lUWcAn+lnlWsB4FWEGiW0PtBDsUDYG3t0lkOg+Vt2f40oBrrASOx6vbzt3rvvwjaV8pFzFGRPQAlBZz+eVFyUJZD76q86fr2rzadd+F6XqNcAGMYPpWe3FNaLHXDinFiw+LkdVwzDd6iE+4QwuQUI87NukZtayO60K+Un5FiDD3o+kQ9IvfRYwv4JLUdjTUCT+FARm57SsUQTrL9p29vZr6bJC4o5qN4mWzKIlfl2wDgfNBUUH4pdIvoLCGXT9MAi2jdy3OeIAa7MUA2zy6FPQX4bePQ6rmxzx+nxr9PrmQGX7oEv9ZkRapJMFlKXgKqsyv5cAPHALzkYcztQnmveNsMIq9/CR6Ghgm/blXv+EiKHaIPXWNjl1RmZ9p8PBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(4744005)(6666004)(508600001)(38100700002)(6506007)(26005)(6512007)(44832011)(5660300002)(6486002)(83380400001)(8676002)(107886003)(8936002)(6916009)(316002)(66556008)(66476007)(4326008)(66946007)(36756003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgsxo2TgcsS8+AEUdhw39+b6yXLtkoOF4fGYYIcmXJnGZXymBVd6ZYZDYROm?=
 =?us-ascii?Q?T3ux4HppU1V7So25otevAeg2v8CYf/zfA6ZiRINGlpqKC7ZaBV1BLEM+MY5B?=
 =?us-ascii?Q?qYlaMYMTA+o0vCN7vu+lPymuEzl0z18apr+TzS8dfxj7+e028FeM5974MTGF?=
 =?us-ascii?Q?2+hAjv0vOc3HcdRRvgbzNWIFxdbrQNJO/J1EeV+QGRrWdNcV3K/XSuxYh6LV?=
 =?us-ascii?Q?RqxeX6CTkF/FSLDO/2ZCmJg+ZJKnUPsXqB/av9NQ+HL0nu5whsdiQlM+jDqh?=
 =?us-ascii?Q?yCjJdugdelqtfBMh26npBDdoXDt9w9F/6lDMumuo1hZDyaasrhgx239y5XPX?=
 =?us-ascii?Q?twpEDJ3wH79GYuPuctkHEDTBua8h6zGrup9ZNE4IXs5NjDF0xPePV7YMXU6j?=
 =?us-ascii?Q?2hGvVzOnR2abLla5i6bhuBQYHkOSIhIQO+QdJUMZuARY5R/5+lreIfFsQjhX?=
 =?us-ascii?Q?e3e7sluSLH0MjKpW8EuKdmaGCCsxLAAbA4fXsLjI4UrtYhkWAnu+1fCELYf5?=
 =?us-ascii?Q?QH3hw3TlRZk3H/DDIvEKkAnA0nmuk3uxs7Mm8T2MTYXYs8HkN9EjqzZkqQfv?=
 =?us-ascii?Q?p9C16pJCNAT66RV0yZRHWJIAHFFRhjKlLZNFvkhZfj6QVBTf04AwpsRqZhhM?=
 =?us-ascii?Q?CUmY2czaC2EzE+674T8qZ3NU/ymJynl8pXguv0/WsZ6WWJVUkSVcawtdBrZY?=
 =?us-ascii?Q?3WYt8NOxc/MX3bPPRdw+Uj95bp4aJxsDEMymMY4TQG6NEwJJtcMS/YIxzr5w?=
 =?us-ascii?Q?k9jLgeorRxXX5FX2WhlGReFTMuqqQiURKhqu3c3AVX6shedabCQwXYtDvnX1?=
 =?us-ascii?Q?bx9VZScHathtiHMWDh3rBhkdYypAGGnpx5waOJ7RxLw2sAjF0KQPBC4pyJZi?=
 =?us-ascii?Q?uyUINxxxElq7G18+q5KNXw+g7Nfj4WsVneQlbSHy4TEt+PgYUGF+XDIaueg+?=
 =?us-ascii?Q?aclqkpSFnQCM9q5qwPFP2uWKUm0gvvocjsBHTi+YDxNafYgzvcDgPs3XAS/Z?=
 =?us-ascii?Q?wUGhjC5N+MZhaLsggVXwKLvuSNLPdSkiGDfK8Y9wJO9+lsTO6hwamkEUdSlp?=
 =?us-ascii?Q?Mit7aD3UZ0z4mqn9gWnCU1WltJq/LB7Da3ApvQNneFR0/dVzb+lY9R2XYZAb?=
 =?us-ascii?Q?z8f/ERxmy+I8zMD+7wvoVx3OP64us/poUfXpbmMngZ5gyFWho+7iZAb4ALWV?=
 =?us-ascii?Q?huM9V6/dtxOqH6lMV29hhxJXBFx1Dcho4ChuHs6oZq1NFoMv9RYgY5aNF9YS?=
 =?us-ascii?Q?d3lp9JdXgVCDAYXVbC/H+viF4VwioxmTBjrNkPINesJkFILAYxdbh+jdvF02?=
 =?us-ascii?Q?ZAhzkfMCCv3WMdq/8YUBzhPLoQBy9jC08Sg32El81g+h3mvpiEinIN0cFm0Y?=
 =?us-ascii?Q?n95HFhLTyYgQy7/WkZuEkmTtTncnZLvP9SP8M4BQjx5aUEarndhx0QiSJzt7?=
 =?us-ascii?Q?DwYMQjg9snQ6MkcSXmiB+95mfOLjuONR8OoD2yiV5EICTHOlsiOiBG5BTyqV?=
 =?us-ascii?Q?+LPZoLKypEHIYtz1nE4mAZhgsDrAyw4s3zp67LFlQnAY2tYIp6RSg3sKKELn?=
 =?us-ascii?Q?ZRgk/g+mqlA7v+HmiIkLbdGqtA5sEZw/eXyq+lDFrTNkBERW5wEZKSkd815b?=
 =?us-ascii?Q?xYF6e8opwam02fNptCyFeR90cBtuXNvXwZYVZMF8PlQEhq8pw+Q51ih5BDIp?=
 =?us-ascii?Q?g3vFbASypSTy4Ja7aBmZIk8XJd23vHectpT+aHwfZzqV9qQXhlU5hHaoJrBY?=
 =?us-ascii?Q?EDaCiqq1l1KEaY8bkkM2/7DGL38I/c8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b684003-5f16-462e-36b9-08da3cb01b8b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:33:50.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMMCBUgNXZcNr3MieEqVnnQT04tNddjJlq63LsDbDuKUebXNFRUWbT02MDDlKHzmFE2nHwawF9N6YHUd4Mc8bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899

No need to export sched in bpf_tcp_helpers.h, drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 17d97e21b1ea..cb3db7ea36b9 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -257,7 +257,6 @@ struct mptcp_sock {
=20
 	__u32		token;
 	struct sock	*first;
-	struct mptcp_sched_ops	*sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

