Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E57B
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 00:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654732879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DkTUePaGpALSpyhr+xffK9ugAT+R1GI+mXAzTKT/68w=;
	b=Q5lLVIdQqT54/eYowKdDdBJH5bSLjIWHvjrqiWNGV0pMzqo8oDO8Qd14z/d2QvkQM5pZNa
	uxqDrRT9Wp/Tghb8Dh6TOYjvFrbb0T/7jrMSiE1Bepnspp3foiVcni7CVOSZLKYQgfo7Vi
	/clZPxXts9UUw6hwkkZMcyaCcf1H1QQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-tBZCRvBoMsOPVsQdEdTo2w-1; Thu, 09 Jun 2022 02:01:11 +0200
X-MC-Unique: tBZCRvBoMsOPVsQdEdTo2w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7oA+G8aH2e1efHGtkoETdEh2APHjv6LkDgkL2K/O7Qrr0H/WtpyjWmbZQRFQAH/+njM1FuSApBXKZdkcsfPo21mnGWx8ktrfUXKsSIR3PuGIlWshaYO/rcn1ISwt5XRikdwBXPStFstnqiLl8taq2BsV6CLmHFXpL6Kw95danHb1DZl4UpLz7SzPkgLl6I7rRHE55YCQOBRgISeMIm3zn/R6+Hb1e+tJSCOQdgB0FCZ9+3/ucTHAH/ntUshoYMqAmeeNOwXMtU3AKz+FMzHNPAkJPzthdSFmUritc52AZE7vin9p9J0y32HduXIacZulBkzPML/FW8j/ttTKzB0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cFJQ4JtQ7crPL6bucf0r8znxPR2dofNzi6ekzb36lU=;
 b=nJaWPcKF0NvdHFKlqunsIdcEQm4kOep2pf32WZKt4COq+JkcjZ06mxAphvtKebRGLjgRyiORWX/JLAsWjUpTZSihSqo9hgsW4RWnnQAqU5vqWAEpLRYJ2/j0jR0er4eSOcMwqe3Pn8Ys5YUk1nAiTbP7fqdAUbjWvbgVW7Wrv2UdRc1vNU8WNKyY6qcAqEd28u6vH1KFt0/60kZ+u2nrsICVwnHucxZcQQe1KVCxcjMNtrSd6ifXvg8i84cVUx6IBgfyETvOPRCPFuMPF8xO+rb0ApQtUlJArk/pAUakWCu5JXP9YPD0gG6BIbbIlK5LyrNDChaHOvcIxYtqxF3yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cFJQ4JtQ7crPL6bucf0r8znxPR2dofNzi6ekzb36lU=;
 b=F0XCWpjs3um5aXJOwrk33oCFpj1dQqKaRb69t3FyPiOn5xu6OPGJbXNa7bbK9S0M3zIK1MSHDAPjLcUk6yItumls6e2O/3T+Mv3i2eUe9LRVrzWyF12VEt6XNpzrADVBZFSJJ55fXxc/jvWQccH2SPLerGq5IuHasjtwxatvG0LsTR4isaKrTkgJfqgr5hjbZ9L/3e+oU+1KrGcM/6zOmu+NCkrWLWcp09hUI9jLxU/LmTrk9QO0YLwfFGALCYQAnq4Es8VF38yXGi5YUvzWllXdm7xuT3gXhsO89aUAABCe2n0Y/LG9ctXY+rWw3Mnp6heFA2YLFD4xh5eHed07lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4263.eurprd04.prod.outlook.com (2603:10a6:209:4f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 00:01:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 00:01:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/2] mptcp: refactor MP_FAIL response
Date: Thu,  9 Jun 2022 08:00:51 +0800
Message-ID: <cover.1654732564.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26576e9-c33b-4d6c-2555-08da49ab2740
X-MS-TrafficTypeDiagnostic: AM6PR04MB4263:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB42635E44EC226EF6073240FCF8A79@AM6PR04MB4263.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2o5/3wlNmH8Yj6f9tSJvubvFv8w+xknD03W0yZQgYrRdsrcPF9uyVtOX4oX4JG5rOW4LuuYOFiZ/lcqsH+jbY0H5iPlOz4mnuQaHLbQCjBj2b+++4Z5J7glwLP/KHUZwCyZgzV7rC2B/AnoOdWxeWEJeeTCmcTPuNsK83MhyeQmIPiE8Cuujrkx6H+yXR2tB9RDOqRBYWOxKcjPmCE5B4sziN7Y8vPJlVR3ajnHoBnC+YDPiXIfhhIv1YCFJtOjIplC/QHHumgrwI8n+d2KnjEJ/FVEvGi0QA1s2JysuU+r0GFJG9FTMcUSnimTWZ2itEW6d16PqdR25kjgzwtYDVNEShqEbX2R3WcZvsWjFc6t/ZEYevcfT5vYhqQx7CiaonoIwIOoXfJrZzZ8w4GsrsAZWYVPjbfdxMKhdbNm5Vy1MlMWdp7bWXJ9oKIWWukBdecVoEH91kubccyvGuINzEXuPRkiT8R/U8iUE8XWcaRIbq7f+sgm9wYPCoZAhPlDELqtH9X3JzmvQzV1OcbKgL2Xa/0zNT0BkpG7aHDzc91iu4iAj5vcx7ESDkd+cwEw5nzLW6r+EyWWLNqKJenVGVmIdP6OHFCZJihnFPaQZQOvxjYulVLwuHdRmfxCnN5lLDebXNGpzwjYBFlcXwI5VvJG1a1pg/q9E5FXOW6Z/+XcWm12B9uq/ff6ZId3c0Tre
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4744005)(316002)(186003)(8676002)(6512007)(4326008)(6506007)(8936002)(86362001)(107886003)(66946007)(6486002)(6916009)(66476007)(66556008)(83380400001)(508600001)(6666004)(38100700002)(2616005)(5660300002)(2906002)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/XVBa4LCWZuGdc+FoclbX0eaXb7NUDegSodB/LNkgjEIV7NldEj98P0PVYV?=
 =?us-ascii?Q?NqhGQBjAK0+kYcfdF69Q3LMkZ8BZJJu00g+HzeTMrQd5KJwuoAkXq+G6lxHI?=
 =?us-ascii?Q?zxQRzqZ0ANDqtNqbm/B8hKlKSZeT/4VWzeg3HddOdTuSNaLCPfRC02IZ2Cnw?=
 =?us-ascii?Q?A71p2SVLXoxFoRKoac+XbopnN4lppRcQK48AlLL5OfywOZVIWN6RGmKSQpZf?=
 =?us-ascii?Q?iqNsg8JcjsY2WbstV/CoRJa48DnnQ2kuqwUOstNnnbjF8lAbVBTe5iZKZh/1?=
 =?us-ascii?Q?q7Kb9TAmO4SajPdz+fThHKIlkhKCUWtMryU0N+tTSgzDFIHWmk+V8vmpoy7s?=
 =?us-ascii?Q?Os3uVcYNd24BsZcuPK7LWkYPuM5HIowBG+8FZ1ilRn4ZEpkBKaAcrp6+UbR5?=
 =?us-ascii?Q?3pVZzmm/IfGolVyN1yisKF4LEYkaDYwH53akMwfCew6q1yqGtSRcDTxydtl8?=
 =?us-ascii?Q?AviKfvxX+uvNqi3ZKI3fr8/ViHDVj2aBwo2Cp+SiifsU+4X8SiqGd0ifxn0E?=
 =?us-ascii?Q?ZW1nDMlzUCx/HDUR/YU/NX97sNAoB14fK0ZYdBabW8ufPFhnhyXc/BcUsOkN?=
 =?us-ascii?Q?b4C7XoHUn4LV4igd6qJEwJ1wdnoky9PWoNc1WAs+LgP5FZkirYwbuqvGN1ku?=
 =?us-ascii?Q?aQvK+M3aepiDX5a6KxGYO1YUSIKD2eOprSBuNourJtpfNIP1mV+CJfEF937g?=
 =?us-ascii?Q?NP9jH4GMT48KAJN4VYqHEymuVtJ/EKcqnqCuzQIpTyBOZ0rK+4vv74oUu5YY?=
 =?us-ascii?Q?FzszGoWb8uCaOShFoHypwxATjKD49acc5q5brdEPYppMBhcrZAW41k6cdqBU?=
 =?us-ascii?Q?7s4Hm7pOv+KGl6UI7qrNOGNA4+44reea/Wz3K0Y4/z9wcxI2K49tCKqe8HgS?=
 =?us-ascii?Q?JlUDUXT3i7vTYoHFnWSqJOy2R6S8z9qgVXlqfBmN+ajxQ+Fxnsqe3aXyXvxL?=
 =?us-ascii?Q?zfxF+WxfmUjIK3mRY48fd5WZ/AFBGOL+vLcfUxLlheH2pySH3XHlzdXv4UFt?=
 =?us-ascii?Q?s++yasHVNa1qIRHTxdOGPNfQbe3vqVYJUGizFXNYjualqqoiPq9c4T+FQ7Gq?=
 =?us-ascii?Q?51FA26HQEpuOHFUvF68Yi03iEggxgAfdShIEClN+GKJUo5Hs51g8EQSorhsN?=
 =?us-ascii?Q?/1EqNom4wE9YMYZqilOB15G23rZrAQblv/FoiVZ8Oiy35iT1YGcQ5Oki52Ni?=
 =?us-ascii?Q?I+euQ92IINq0pZ+UFCuY1QVEUyeRdwwwIQMnV+3V3nOKV6nbXKCE3Amm6G9D?=
 =?us-ascii?Q?QZrHze3Z1g6+TJ8nBvJUu7MwMGOUlGiO/mYhKeE6zFW8XvVnNQldk9mj2McO?=
 =?us-ascii?Q?iYYhl4go7Gmh2eOGDIbdPUnTjLonL9zxjN+vEJ9fixMfCGZjCVN1M810KCpS?=
 =?us-ascii?Q?iUtD9wUubMF8+eNAaA8yWT8baTCcS20E3IRX/7E3Huo8xs8ZLxcPmBo3gnH5?=
 =?us-ascii?Q?iErkf2IHoSo63VrmlnJTVYubyRMS1ypQbzMKn2BW2cWbFDTny7ad6Kr+l2Wx?=
 =?us-ascii?Q?3CyL0530+SqIl58TaKHMwSZ/kQ9gSmtEB2AsdmCIE//Z9THThLmENtcZbM18?=
 =?us-ascii?Q?OelmSNkyUMwfrlEpGZtZaZb0GhAZsgwM9eK9qDTO1z+SQbmY519wrNhvCzMz?=
 =?us-ascii?Q?rH3h8obEH5CHCCiMpazmj4TyMydYlXW+oqLUjsD774rBor+dZrXp3oLsOJGv?=
 =?us-ascii?Q?dhU2QtRuorzvPDIhbQpDM8710OmkN0CJ0lrrAnfQJVCba/Pi8dBNl1n0SESb?=
 =?us-ascii?Q?bwpMLoozmgylAr61JC7HzhEJ0Xw2J8k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26576e9-c33b-4d6c-2555-08da49ab2740
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 00:01:07.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTWL7bfPsqB5zLiQZOnW93Ra8QzfnYUeLICqN9adOljRIjn7OJjbvLpKD6ThqB43H7RlRRmt2Xs6acv5bxGPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4263

v4:
 - rename fail_sock to fail_ssk, fail_timeout to fail_tout.
 - move fail_ssk and fail_tout check from mptcp_mp_fail_no_response to
mptcp_worker
 - split into two patches.

Geliang Tang (2):
  mptcp: refactor MP_FAIL response timeout
  mptcp: trace MP_FAIL subflow in mptcp_sock

 net/mptcp/pm.c       |  7 ++-----
 net/mptcp/protocol.c | 37 +++++++++++--------------------------
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 12 +++---------
 4 files changed, 18 insertions(+), 41 deletions(-)

--=20
2.35.3

