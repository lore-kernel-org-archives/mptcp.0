Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BF68
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638430215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CPEJ0mkrYbjeaP7NDt+hWxw4uvwTMUP36udlYOPq618=;
	b=mx2AFgH8pScwWLTRWrxTmqymn4IruQvyfqGfzc2agVrmnENLzQzdvmyB3R6QnRE2lSn4I6
	zvOSOcMS+by3IVhqiS3/oqFhosgmEh8+nQfuD+o6ilNm9IgNCRaPdlTLUeVEJDWKrDLCri
	Qbh9h8BQEGAiFkV9Ycew7mFLdq+SUvA=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-xhHzVXB_NL-CrMNDLfyYow-1; Thu, 02 Dec 2021 08:30:14 +0100
X-MC-Unique: xhHzVXB_NL-CrMNDLfyYow-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el8x/vhiYShnROPDzwECnjwT2/eO5DB+gNby0QSjeCLQmQdpOlYex1BhjSkxau9djMFJULVlVrajJu4O7WqqXZ+nzquMWWgP78e2y2ZADr4cRs5JlRz9Yq5v9Xxfd8Ticflgznm4x6JmF2+qkFLn2r7GLDGhhgv2Rab8weL92whcfx4vtccrzXAETgHUkOyOamWN2iJ0i5xwJ0F7tWCzKbh+7QEmdXGf/qiCMvMawiGeBOXwRMfmgCp/kKwlGz3StoKtOAQU6ZEjShIcS/79Yf6C1U9nTLblGay/QwWvfLGx1UO1izSFCoQalbTeGNs+nNjSV2YnGaAzgdiyhEqGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTcR6a/GMOoiYRmCyIZsItLVXkSP9A95zR+NFmr+kBI=;
 b=cCa9DYWcEMuiyNQW2hPnO7mONfyKw98BZWk8OOJUkkSzzPp43qaboM9hbNqh9o2F4OUFoSM+rgpqdk+ZbsZc1uf0daHFZXSF+vuRF7uzjrN6NczhRQ2xCc1G5yYSun6+KDFEKrG17a9ZYIB8HSxs68t/Blove6y+yZQTthr4LvoXFBQoqKwn1+lhwoUrujzDTOVtU/04GX71zpk4r6tojxhA4w/gY0Xr9CMYBYb6nimdb9MwgDKUKEoPZkHNNdw9N4gHdqVt9GSGvM7+GYN+99SFVL09OL5pKoDWex0H8+SFei5ved5Q1n9fRUfSLnE9dulz5lF5jaP0ysLidWfn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2698.eurprd04.prod.outlook.com (2603:10a6:3:dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 07:30:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 07:30:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/2] send MP_FAIL with MP_RST and others
Date: Thu,  2 Dec 2021 15:29:58 +0800
Message-ID: <cover.1638429740.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by SG2PR02CA0001.apcprd02.prod.outlook.com (2603:1096:3:17::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 2 Dec 2021 07:30:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cdb33ee-6e85-46b8-8c49-08d9b56593be
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2698:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2698DF6DA0B32E53B7938468F8699@HE1PR0402MB2698.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qe0K7LGuSp4Racw8Rhr23AUxnx4U99/SHfFkAQziPVYcPFqZBYxPvuz2TlsS/dgNMkm92aI//0r8G17viCdz/wxgUZQ8y6Gso/QZz0zmseM/kVp8WUnvd1yk+K0FL7HrhhKR+0c6WNy3Ecl8IEjmgAbHTikyQegJ2GnUUP3JVcI3/snjvLCKu+6pozcM7KxW6/V8d3QyZAi0n8CXM8XiKxwzZJoKO+BfpkAexTt9fagAzIkKeWXuya4UsZ27T4cz6Xgp9uSuwIhRjIteL3HsmWeZcx3Zu/lj6zbmWewZNVveYJfX4eYU1MZ1PBILEIHkYoaT9D6m27NiJ2os2xO0qTD2thP+k3bnMLfPg18n41hsT3SAT6VMp5u4U8pKgbgIYNQFLx5cSL8aRqxTZmHI8EyTfUSxDFfEljC77VE5DBResMZDi/A3Om7bZ0rkBxsvtHk3TBJ8LjjIfe/sh8LS7RcMRk1KxGhCJvLGn+ycaufYaoWUkNPwvZGr9VDdMHDBuXNocruHmcHhCz+nTVkFM1DckzvF1jshJRK+OUSQ7IPCYRzHoE4YgVZQn2V9DXpJc0rnicT4fGdikYN4Skr3XpBbqkMZu6QdaMgH5Tfd+vzf8QxsJ8y9+BU+hrZr8CunHW4pMnKIxfBPfIYUMD7z3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(66476007)(44832011)(66556008)(6666004)(86362001)(2906002)(316002)(66946007)(508600001)(5660300002)(36756003)(55236004)(6496006)(6916009)(186003)(8676002)(6486002)(83380400001)(107886003)(26005)(38100700002)(2616005)(4744005)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeOkyij9xLFQSy3McI9/3xgB04ULaFRHw+0RNAaIppTxO8GqEDtlrs8jXPqY?=
 =?us-ascii?Q?kVh7/GQWCoV6ggbLh04P2e6O1eDhatpydykhEvaJHCkPUbL2XaaUuTRw8YGc?=
 =?us-ascii?Q?UKMksnt/Q/XQowtsNiaJTKMBT7iV7gJNVC9sx9H1WlooxVY84wiYMWNzV/oy?=
 =?us-ascii?Q?NbJceF1RT1VkCNy5GZyV+MGn9HcCsVbKvaOXCa7JjOb3DEDR4xZwLv/EXYAC?=
 =?us-ascii?Q?OCeVzmaqtuap3Lzs2/0G0YMXk6XEXl2kFQ9UZpbvb0aL5qfoX8Ad+nLG4g+7?=
 =?us-ascii?Q?hboZqwfQiekWCg1fmwOcvEaORQImWq59qWXMPbdC0XZVB1NsbHnCIJGGi2BA?=
 =?us-ascii?Q?SnKryYtOw9x4oVUBpo+N8Aknw6JApsyZv3slTJFZuGTf6kl7cdpWxO2XXb22?=
 =?us-ascii?Q?nFwBvqTW4iNDRiJMHsyeJtlv0bMSWXvin/QDqXq3bh5hII0imaaalh7/QONi?=
 =?us-ascii?Q?rBhH0oGN2jmWJsdsohzM27LKD45RE0/CNDp6EFUoJIbPE+0Z+v6Tw7/kNbUb?=
 =?us-ascii?Q?fHfzHHJzuDDF7xiqPA4wBIFEFcUdvG/dAeXfyBxha4zh+sbav9rd3RnCk94F?=
 =?us-ascii?Q?W2VyfwSEjWq5gLNLXDVjF49meP7tvzf3I9eW8Jc52O/llnwU3IkEb+CqkCrL?=
 =?us-ascii?Q?LxPYFc7p6G6XW64eoWImIIraTY23ZuqA70qdXi157L8hH4P6ywylcS7WK4CB?=
 =?us-ascii?Q?FXrq80GH1C+3EfZCvJy8aImkcO+dvu8gjiQMGrY8+GCxbvto4AeaEq5rV1eO?=
 =?us-ascii?Q?q/ATf6Sp1H2DsoyBGDHYIO9S6M9SIg4QdNq7zKrrplRjJn+Dn5Z9o+kiUQvp?=
 =?us-ascii?Q?8ZyfbZfgymM7UpXwW9ky7Gk+ZZ0J7TkpjlAu8NrBzmWT2d13Y59a/LzG42Wg?=
 =?us-ascii?Q?u7AHXvretN77SzqFSBCccwWJtiGpYNJmy8fuyD42aRBl+VV8H6jR6BbThP/6?=
 =?us-ascii?Q?bSgL3pd4wu298b+Ukj8DZgkPRWKznsFYHzx+kC7/ywhzIX4R/BQ0VnVDGo7s?=
 =?us-ascii?Q?23mnUNg9Pdok+PdyVizg+Q8RtRXgcN1eZmQYYu8Ip5xX5vzPSsX2KmFYC86h?=
 =?us-ascii?Q?L+6FV6IolTZZIUG1v4q2l485ygI8e5Q6qe6SYdCAKWmQwT7ElvZVGkPtM4x/?=
 =?us-ascii?Q?Ox6+2QoT7g/KXrztoP83rIwA1F7RhpsbHURtF9CSJaB7LoirHDK7j6BaE/Wj?=
 =?us-ascii?Q?L7Ml1U5lHIDubOVaGgN+YqjuOZWBzB3oEDEoc7SW8e6DBNCApHGqYDPI13bE?=
 =?us-ascii?Q?k2wRbEQ2srprNs/22QjM3uxU1x6b9l9kplkUEFlCR5er/5aU0TVMEFmHgyRn?=
 =?us-ascii?Q?iU8a6tnDlU1uV7mVaM5f/Ef39ORdBQbEdmC4K6kkXkekQf24WruB3khSNYJ0?=
 =?us-ascii?Q?WXcUmrACYQgJdQZLgGdTC4u3wlpCX21uoo5Qt9fBft+cCwmkluqXHUdriKZ4?=
 =?us-ascii?Q?yj63KHDhOh44qNYXkgvEn0aZpDpHB3TLratDBiVvkZmvVB8OF1aFR9nkyOWu?=
 =?us-ascii?Q?N0W0lkU1XdTewDqUfXclD8lifjkTSFAUrnzpt5JLrF0T1HXBHZHlEEqW3DGe?=
 =?us-ascii?Q?J/6j+iUDtZkGt0C77mvVF+iebjXmloNHooPKbWyOs3wd3hY15iQ15goBuKsY?=
 =?us-ascii?Q?ZOGV34WaGomi2jAzqPZirfQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdb33ee-6e85-46b8-8c49-08d9b56593be
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 07:30:12.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8TNvfF/L7JohcPqSN98QOBYOQ1UhJBWBNh3DzrE62yAACBD+9V9Ooa99IRbqjkev9UlVIeE+EMTe9abxuSbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2698

v5:
 - Since MP_FAIL could be sent with MP_RST and DSS, and MP_RST could be
sent with MP_FAIL and FASTCLOSE, this patch fixed the MP_RST sending in
mptcp_established_options() and mptcp_write_options().

v4:
 - add Matt's patch, fix the missing ";" in it, dropped two empty lines
and added my Tested-by tag.

v3:
 - update patch 1 as Matt suggested.
 - do more cleanups in patch 1.

v2:
 - rename patch 1 as a squash-to patch.
 - print out reset_transient in patch 2 too. Please keep patch 2 as a
standalone patch, not a squash-to patch.

Two small patches about sending MP_FAIL with MP_RST.

Geliang Tang (2):
  Squash to "mptcp: implement fastclose xmit path"
  mptcp: print out reset infos of MP_RST

 net/mptcp/options.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--=20
2.31.1

