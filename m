Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B90EA3
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 06:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651904288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K88mYuinxpzwRHKfE+/2IsE5r0+L5waZ+pLwUPPxuPU=;
	b=KRlV0J2jd59vzKfL4uMqs/UwQiA7pdMyWTftrw7K9w5H1FZq5z4LbSDnWAjE56Pt5o0EI1
	0HZcgKXlbH/YlgDVGZ4D/WJbHEishjySdx4+n+Nh825kevhJhNoP1o3a9AVQXzvCP6RuN2
	XTUSdj6shJMospiIi8WB2bu/l+FcDMY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-BLy7Rt-mMoe0zpOFb7-o9Q-1; Sat, 07 May 2022 08:18:07 +0200
X-MC-Unique: BLy7Rt-mMoe0zpOFb7-o9Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOX7J902eKyhk3xp3V6z3CAgvQpvrhXy69IKUn9BAVTQaV6CWeGA4V3ia2xTVbN7fZiPB2roW8m7urCIFHrH0sbg7viOX5lL6IZhLOFmI2hHV0KNAqqbt6OBTeF+TQzSuJz+lurpIu+qDBvwskRkT04CRWoFUZXYmdR4WZhNkqJmor+/dYnanHwWEJvke/Dx4QQlYzesSzqIPta2MEj9w5LZ2suuEYXbAWng7zAG4USamP42MhqAp+UzKwn3V/q9TVcu+GCxbANL4CVGn0aYn8PJL9UPEu93lmNhhZvxc4Qt2XK90//ENCW22O8iSAoAipdWqhS0GozCt8k5iXjRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2W2uV5KEmTcHkcgdNxxS3KJGMjrcuIcjYuUHo9Nvnc=;
 b=Vu76xaM9vWRqYlqKKu3nec9q3DkKIbt5Y+63Qi3YT39x8wrt6U42049BQn+zJhlluw7KRsY4+xR6VZhSKnCKSsEUncGg22xEQ+MZiizo/LG4oeHVS716ZA0SbmnR040jw+7b3micVevkbkA70BcHFKZ3h5f7yy0LWyh+vGH7Xjh+jGcxuPAAOcma2TQuPLTMuUC4AWIT37AUPZD/fuVjYrHz02biw+vk6nHHoApS6wWNWu/5qB4KYSDo6s21LcF28r2Cvac2fnO3Zwfw4IotoOsrXh9OFQ/5wt1z9MA1sQhztEOH1SPlneqbPjORcNy444CxhCRKbE4FZnZXXR5wWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:18:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 06:18:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: verify ca_name of struct mptcp_sock"
Date: Sat,  7 May 2022 14:17:33 +0800
Message-ID: <76fb385e983811d40ebcac3602ff034b169e96a9.1651904166.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
References: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50bf9373-2bfa-45b1-33e2-08da2ff15992
X-MS-TrafficTypeDiagnostic: AM9PR04MB7489:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB748993025C7B6E18EAAE281DF8C49@AM9PR04MB7489.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ao/1jz9JTkBzWSKIr6AymCY6j7+GlyR7PsxEGy5lmcsdfHjUier149jcxxpaUCx0kfjdDtwKo/XeHgl3PI1/rw8uSDySJP+HyS7DLsTJ46Mo/1oHyuZvUobOxi/CkT753nJoWsb4BUBHoY+fM14l9NkBx2jyfjsvKr/AbokTYhHsy3VtTS/otWR7z01WBwqu5G6CQbyhULGds/ZL5vmaaatP86TEzT3sMEb/jo48njwR8MGkOIcelpJ+W1TwFnlamAjKYMdgmtRlYvu8Uar91JxqsHaCI3kbDlcUogLSTEdofCWJzwHq4u3E8oGcLuIN9NT+a8UpRb2aZUccWAWrHLfWD3ikfrG+DqmkSuUiE55oRctzxiSb8H/V/2TaOESOiw7/7FbQ77JEGzZ/8xaVJMKl3RokaSFn5grVa5y4AwIyjLGJbHD99huMNgfPUQ6oygtsq8wEY8vX03fwb58CvaStsLJqEuJegPud1FnqRdBHUvFbgXjFvFCqdg8ZOoqtuv5xOzRl3OAkFg+pxtlyNWCAIWmVlr8BcBS4eYNtTUvTZi86aQKIpE9nOB/moJPJV3JL7jfhbtZ5NiRvDsiwvAiGC4rhWFsM/iF/VZ0vVrQeg/CBgaL7od3vBkxs7c5aoUl6oDePRpetFU9vqriMmRqBGvJJBf1dOc98u94bCJxEzgG9Bo0Go2u/gpV/AUZe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(8936002)(2616005)(2906002)(5660300002)(44832011)(186003)(6666004)(316002)(508600001)(6486002)(66556008)(8676002)(4326008)(66946007)(66476007)(26005)(6512007)(6916009)(86362001)(6506007)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mYV8r9r4+VKuCyHoh03MIxeiYCwDY7w6KQ4TUyonFo5zbV+OGALYNMa+L/fw?=
 =?us-ascii?Q?7kqDNvwIO6pA/91dM8uya6pQp2snh2tDXDrhrCerKS9QMLUBPK9hIMgOGtv7?=
 =?us-ascii?Q?jty6EPGVt1qPUONAjRkjOyudQ1tpQXN9db+Nqsb1BuJKdLVyxdgQ2XMZP8Rd?=
 =?us-ascii?Q?wbI/Z7VrS4ZYGTzaUhT620QucA4usqIy2YuOZ7Pw5Qabhn1E6aF1kJO8OLHx?=
 =?us-ascii?Q?oTWtNjS+0nDIzuz9DUfMGshuwSxX4CbjhUKzkBfga6S4QiEWXWbCBivXr94E?=
 =?us-ascii?Q?fR4txMOaOsjqkHabiUEN1E7RNBB2Wo+ZAkn5QwcAhsWTmjBdSMZ0qhlaiJIK?=
 =?us-ascii?Q?i4s6nPWtBP63o6OVsMTT6v1qLcbPk02ys5EJzNWTDskJ4N257kDr9+dB6I00?=
 =?us-ascii?Q?jb7wZiKUrIfzn2AL0W6YTSj+hoG6692NaQyB/Kqr4SRmt8cXeoMTXO354hkV?=
 =?us-ascii?Q?PIcS0115rf8W6Grj0fgjVtkBLg880KgNbsAL1D1ouvVv7l5AYHceM4h4zttH?=
 =?us-ascii?Q?kJUvvwFcDAO/xUnkWFzroKcgEYWO4HCSAxqzfm6ooRmkKaB4uA0ZajcPArvT?=
 =?us-ascii?Q?9gwOFUoYVBLjb4D5Te9LWxw7pPCShq62HdpADGYaXf38DS1tT1OtTFgdz24N?=
 =?us-ascii?Q?QJRfIp3MCMix44cbRJyqubZLhk6btvel0cupyJA1wNYOZhvtPqQ5nPMYYImq?=
 =?us-ascii?Q?tY+HKqc2QjotsrxYEVKSFXwF9sGG4dsc5T+llmFMhOSc7xTfS41CpEy6/rhN?=
 =?us-ascii?Q?ZqfmLjIalmV4/HDvxBo2DeAPVkjbqT8mduTxXaWPI7J9qt5mXNUNU2F+Vet0?=
 =?us-ascii?Q?Rsdd4l/kVz83lOVgWOWF0qQBAddKU6T6N1Q5SLrd1KEXBFHA4updVk8lQ8h5?=
 =?us-ascii?Q?ZSgMloUSs/sIpc5QnJFKBCD9E+LEFUOuSjTnpVfrshQF521jnYDJHEGDPy3P?=
 =?us-ascii?Q?fi+TP30gvm6nj6k/grNLMt8nwUCqboHYkdHkhrVTmA9WqDHYPd5hxg0BXUBo?=
 =?us-ascii?Q?rZnML5azvSrRiMUvjwxCTkNmwNg8wsI8aDmlKdgEfHVXralkT7KFKqgRfywS?=
 =?us-ascii?Q?cpzcGnL5mmOPtl/0LX75OphmqlnPvbJnuYtKl7DCM2kgvWzCkfyYLuJ5tSHm?=
 =?us-ascii?Q?O1zj6O/z6cRKnlGlyvUpKOnBqNfl2itFKjGGmeYHt2/sIIY1uh2M6e+IAUW9?=
 =?us-ascii?Q?UIo6+JxzNr0R08OUddreV6bCk/ZL7nUW06u1EIdzwDxcZlbmFPtZR1nlbhX3?=
 =?us-ascii?Q?tcdxraI7uw1Hwl/+quMK873mJ0LRfsHp7FAvA2cIm5mSGb42p9NTiPdMIZ1S?=
 =?us-ascii?Q?kIvSGaUfsgxUPor3KSLyyIr2Ydssxtv1nclXdYig9fhT00ECht+hb9r4dLSL?=
 =?us-ascii?Q?xpFZo+sSzGsHRwJi9h0bNi3Fu3wTeqCFoZUZ1JfktqooEfgtcLDwmOMhdrqF?=
 =?us-ascii?Q?Douj1eOWEvsM/RMzkyN7oSIAcNJmX+J5Fa6QL9cj9YpNfG5aAymkLExgmYr/?=
 =?us-ascii?Q?EmExNSo+Opt4SdAfOolf28uBQipi1rHh/oEdUbIYNJ4IhAcBt0cmlxfCo7pB?=
 =?us-ascii?Q?0JUliWP98rmFmLa+8fQlvYm+jZfe4UCW8O4An8Q+gRg850KzFaVIjWObgSoW?=
 =?us-ascii?Q?VltrgTPftjzruJcQ5hwuQw5roHiTTh1E5v/vtjxX5KNrDJfiMw7mr+pCuNuF?=
 =?us-ascii?Q?jafUt0l1uCGOinHAFn+cE2vrMA4CmqO2ZclDQizzK66xmWlJeRgpW/S0gpvp?=
 =?us-ascii?Q?cn8JF6MU7f/8z482QA586kMAgq3QYYc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bf9373-2bfa-45b1-33e2-08da2ff15992
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:18:06.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MT4j2FjEpiLE8U2lt7P+9OQ56lfsYiY5TtkVlBezk4oa2d+ItjS5qAy0bFr/oNuD2XdOB5z3VckU1NloFmQh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

Address to Andrii's comments:
- use ASSERT_* instead of CHECK_FAIL

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index ad7f91d35e96..ebc9a187acd6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -86,16 +86,12 @@ void get_msk_ca_name(char ca_name[])
 	int fd;
=20
 	fd =3D open("/proc/sys/net/ipv4/tcp_congestion_control", O_RDONLY);
-	if (CHECK_FAIL(fd < 0)) {
-		log_err("Failed to open tcp_congestion_control");
+	if (!ASSERT_GT(fd, 0, "Failed to open tcp_congestion_control"))
 		return;
-	}
=20
 	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
-	if (CHECK_FAIL(len < 0)) {
-		log_err("Failed to read ca_name");
+	if (!ASSERT_GT(len, 0, "Failed to read ca_name"))
 		goto err;
-	}
=20
 	if (len > 0 && ca_name[len - 1] =3D=3D '\n')
 		ca_name[len - 1] =3D '\0';
--=20
2.34.1

