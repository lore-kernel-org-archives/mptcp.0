Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D2621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651022890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x4H15N7p/Ttd5I2d4HSgeBu1E1m84BmdHY532S6QFJs=;
	b=eR/UcifNcbrVAHf9YNO61TE+mVEM2VGsXnHise4azzIT2n3ZjjaMCldBviYkdlEl6Hk5mG
	c8JnERfb13tG1piSlSztOhHdwLIL7/nWNm+8+tTFvAEQE2J3KYbV3XIQOv+ivydUvD/y/c
	Jkxp9vLtiwslzskz4wPDH1tQxLntyAU=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28--lwEB8aMNDCFiU5_O8hsNA-1; Wed, 27 Apr 2022 03:28:09 +0200
X-MC-Unique: -lwEB8aMNDCFiU5_O8hsNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU7gxT3fOiJosVUT8FSh2QUXkNwThBnOGOLGiBCEGmgyzReDoVKoMUyWSFHufjGZMuH01+DDqj4dQR2CuDsldSxD8CBP/3+9OCS7tLAR4F/GSipy2wS5sZiIK+C4WKQgl6cU4fLobQihfU3QZzU6CTk68AAxMXfQouUWlLhzgnl/L20MBoKc8qwrTw6men7GsxFXeB2FOA4pO7pY2r9rX/dSIGKlgO8nDNbqjl9QQc/JQ44SVsSTMtXl+OtYsVc3RxjbKvfzQXLEQXnD7QgcxxXiat81aR/MroPdx78RFVod3xGL3bfb+iRHodE/LiZRjFH8jiLDvgPDsQK2KKvokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc0HC+WacGn/dBxcWdJLbwg6GjKZFS8UIgjjapXyyxU=;
 b=VHnOtus6S53a0Zf3wEk+0MpAnJh1PFMw+6eUtXz3Q1vCKvhRjeSmyvw5aFuJTtSFXY2+QqSlA59SHqivjVq4G87G6JmYHKxIFJX8qed/a8yS8xNzDb1LLBQCvO83MFmvCNWQ5qIuTBjCLffM6Dl7SMYQUoc7qs//yo0M6rQASI/e53nWpuioXwlK+++HuLQ3iVSWRo+2CY7a+7aU/SaWx9TCXj+u8aS1BbpeG6qM9WgE8co3tJsffREAlY2r0Hk3przuDVPF0S2y5BUbK23AYA7A51RdK81zTIgB+xkjWYdE7BfMIcdulAsyDHGIgMOf1QHm+VzICqpPIs1x3xUfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2670.eurprd04.prod.outlook.com (2603:10a6:800:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 01:28:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:28:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add MPTCP test base"
Date: Wed, 27 Apr 2022 09:28:21 +0800
Message-ID: <38168fb95c78454db24726d2bd45f2d65d977fda.1651022882.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3918e90a-3fd1-4ec3-439a-08da27ed2dcb
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2670:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB2670BC332D393D320107AB12F8FA9@VI1PR0401MB2670.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m00LAO2DUXvVMDGLtfkZDs48LxWzLYBULNIG9Tq1FqG6TvS/ZPQ63yORanQF8CLJuOqATkBMwJIt82Mr1zp7cBcY8l538sSEeJ0LQkhz3q4n4QOBjcq0IZQ5BRPFiNNAjFrxCWXM3QGPYiVqOSnJKi3EhAnnFj0Q1HHza1o6fWsaqLRryuFYN1NbCpbmKZMp7JtNn2MFOhtbEu2+KJOedLSTV4PeoI5m2V2dUL5k6KrIgsQoZwE0dHHd1xBpDqgf/lCuEtNyZPnWEQcJwMFByydLKD4CiZmrvs8fAhKzyX2TSK+HqGwo9TTVOvnBawW6iIXfBRseXsPWnQWaoWLsbL3CXkeN7zRl2n3H2kKbU2GxwpkYnBV7AlCUoo32GCRVzHPYmCDvzriUh1fpPyj2WE1hxOV3FyTYO3VQlbioIeKfSL+xwf1yM77fcSpSgO32eTtuN5Ux9OrT0CKFk3i+377whzIL1VXDFswv/D4ZLfwE/UQtBoboXgH/M78fNTVVG+/6kQoH8YAi9S8isIiy9mKKVVo4aP4YTIJdsPrmK7s+bFD/1P5xxICSjqmgdLbAdMg1VLSYf14uzuWP9phyEC+eGctLcaf49k9KGGXOm6Ht2D0dnz1SUqaAdB0fHYdngBQM7gNKkaU7iARS6OaVwGuW9LKACsO4CA1pRlDT/H1rR91cRc9XHbKCdWcdjXPU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6486002)(508600001)(2616005)(86362001)(6512007)(26005)(6506007)(38100700002)(6666004)(186003)(44832011)(2906002)(4744005)(66946007)(66556008)(66476007)(316002)(36756003)(5660300002)(8936002)(4326008)(6916009)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cBtrnJKh5Q/HaFC/VQIKDMbMxV2Sc1T0bu6FqPlTI2nwoYruz0q9dA2VUA4T?=
 =?us-ascii?Q?kBqoj5S+U7/le5sTf58SM85LFNhBT/QsL315jymCLDpRUnpKaDpVSmHGOrvL?=
 =?us-ascii?Q?7rwRREtGxrtZND2oflPCZvsPUEdWSUALrvjpw1EGmU2kBokcK5wNVTznVB94?=
 =?us-ascii?Q?Tlu6chuj6gOwgCULNpjUOKtPujYnTYNTJApmdwCQYRdd0H6UarGY9A9PQz7i?=
 =?us-ascii?Q?tdU4Jg2nByqZ4EIhfGmTo8XBOHqRFYaLbs3HJP0m4kfTN3C4lRhCBLD9K9z1?=
 =?us-ascii?Q?VbgXBHqL53lt70JeNqlXWonmY1fB1DI4Jowarld4NVXEc/CABB86PW9i+jGm?=
 =?us-ascii?Q?rj0FX0PCoIc1t6WQ2bSBZ3EPz2KD3R60/nzCj1sqRuUBwWI6WYWcqdujejV3?=
 =?us-ascii?Q?HdLeYLoVERCdJ5ym6PZQorih4uBRK97Wm0rqCCC32yTjbjjp/FVZsOQ9L4UU?=
 =?us-ascii?Q?bBKyTZO35cekBefwRMObz4ZOPR8rt+eoJ5mGqZBHabdwo2Zb7kkGF+k/cveT?=
 =?us-ascii?Q?DrlKCGknOfifjIlWFiuP0cRs/bFRtkTiOrfU5Ogd5ucYLpd5nk1n01DuqYtX?=
 =?us-ascii?Q?8M4FsLuAF1NWf08kDdACjX9jeoUb/4PiN4FbRCs4qVEZAHyR74R1a0y9cdR8?=
 =?us-ascii?Q?QfXtqEC0aloW1Gl8VlFNJa9ZQ156+oKjb5e4XInc4Fi9pfDG5jJmxOophb14?=
 =?us-ascii?Q?JlNloHqQwRwseKf3GQywTC8z1DusUKsOm3xj755rWcEKxbgiejuSCZb/3Nh+?=
 =?us-ascii?Q?7cq8kIVD8fpCd3y73p4SvPUI8DanQMF9O/swdjW610Tb6S8i+rgE0WZRR0Tp?=
 =?us-ascii?Q?jdOMs12CR3WK1NKghmFIG+1GmJA8tqW8SvvpxEiPuuVqlEykU3wv1dVEMLbk?=
 =?us-ascii?Q?/SRoSTIpMuy1xOaAc3JEe8qDkny7gNKeo7AKZUiZ/xk8qCIgiRpZTdb4Jxb1?=
 =?us-ascii?Q?WtrkfkXJf/WJW0369XMG6kEIWRZP7zH5NvyHwbVXy9aMOsa9/AlvYkvkO8DX?=
 =?us-ascii?Q?GO3zhQBvCyS+F5GWuW5E8w5byVb8zdRByA0CHU5VlnNvRRQO7TEB6R2nJKgy?=
 =?us-ascii?Q?vYk2Go0/ORGRQ6rFEWvXk82QSNCgH7bQmShmfr9kx7NwXlCrmRSn1OI0bPZN?=
 =?us-ascii?Q?dx47SPfIeK2qoHPFtgryPTB1hAMcaCdQPP7CjhliQEb7MT//pBUgZV9ib3D2?=
 =?us-ascii?Q?CDb8DnTgxBLrO+5NPGUwEyQSBtjW7wLwCOzCq7GJzrDOJA++00SRRyZ+ombM?=
 =?us-ascii?Q?TsvvtGrMpBxJ82vAtFQmnRI3wzfHX5uh5vxIGMwj7M1iK3BsYgzeWMquO/FJ?=
 =?us-ascii?Q?/a9H/7JrpkCobMEsffFnUEJmN1vWWQs4Wp5GHyt5tdJuV/h0E3GWvmKLVPc4?=
 =?us-ascii?Q?ReWdmcDIOGaIADy8X5hXKh8yWqzgt8OQDqpBEl29VRzT9pNfMUWHsz/gfXhq?=
 =?us-ascii?Q?6SvU7sCxmCyS54MBFbRUPs24KtH+hiHi52HEedM2Su1+ygvNK8fTwaE4UTag?=
 =?us-ascii?Q?adxToxwcXBgdpqPKrg1JKQzxyba/1i+pJt4XbX3eaCfs1HD6sO5U9X2DwBIz?=
 =?us-ascii?Q?+3g+TKY36XQ48iiMEAfSAu+pOXDD3TRTB4jlHy6F+Hx32A8qcieZi+EtWw+f?=
 =?us-ascii?Q?VtOGxeS/T97RePdERwjIyGrVpzCZ5LGKiazjP+D4XLJjNF/wpp4BeuBB4aNo?=
 =?us-ascii?Q?dXlzyNmyhJwGokTI7YGbKpC4aQlKFSgQuFAGPftaukCNRPr8IZlJUIHYGBJr?=
 =?us-ascii?Q?W5/uIx+akourfspeiKnOSh9RLlsWnaw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3918e90a-3fd1-4ec3-439a-08da27ed2dcb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:28:05.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQrhVKGn3OXnsVvrvLD9kbOgHr9fkZdCsGnxPKs2euCLQJiiSPZmwkUbHNXuy4i79E00Crx4waKjIfgqVrUAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2670

Add CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC as Mat suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index fe0d3ad6ecd8..f3391d0abe58 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -54,3 +54,5 @@ CONFIG_NF_DEFRAG_IPV6=3Dy
 CONFIG_NF_CONNTRACK=3Dy
 CONFIG_USERFAULTFD=3Dy
 CONFIG_MPTCP=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
--=20
2.34.1

