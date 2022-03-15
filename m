Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FA1B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647327512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hm7EhDLqdm6/9ubxneDBweoRdjE4qJLkcplWjSjU8iE=;
	b=ePjmgevbV7b85wZuOG5NmCaKAmOzoVEv1mAR5Wva7D90kedesDvleKvxwEcJmcNkxtPEBe
	2C6oVhRlldUddM2SzcTdM0HQc6Jk4cmiHSbaZ4dxu3uXaSNM2zAqgo8fZewqp4+56TCVTQ
	ILexKhsOj0fqnJr9X6gmSnEfKXPqXm8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-S4lTbV0GPMGzseSEDy2sfQ-1; Tue, 15 Mar 2022 07:58:32 +0100
X-MC-Unique: S4lTbV0GPMGzseSEDy2sfQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUMEJQO6MUlfRscD3pimZ3/NBlKy+F48gjMLZKkgtitse/Ab74X2lYmxpNyCF8/6fG5qtVSKqDgNLvnufdZrWCVnU/H/lM6yOXUSufuC3n02z9gH+YvZwJfhnG+TvOQsb6M3rNOW7u7WdZStuR6LzhQDM/wAE1m9/Fz+cKJy6hdcdAALTFFbraR2qtXlGcbMrlcX/bNRZZ8Js/w24JNL06rUvs9m4jTTHJCfzIKGaaAbYFODhWk5c5keB2ClA9IgiMLjv2aixie7LmeWdjhDfppj3yFik65/6WaqrfpSxoRBADYprcznfzsgthUiBq3XphuPwZ3wMwZv+RSJu8rKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrpZapT7HKByJicK1Kri5I5lUayw3uXHxNQJt+C5cUE=;
 b=FFPzePZFa26RlcD7eiNMu+hCK/GIRTO6JqZTtmPQULR2Qs8c86cl5rXDWWAg9FQxtazj6AnueYoDLwlxu0meHRphp5xEaMXNnZ4OjnVHih5Vk6KdHt2EjPHo/R0dKei+xIXxhjJhMgoyMr+3/vRm6qXKX1TD1hxwOaiPgZ36Nhar7RNvLg2RGahX+jffJ+vsHt1hpeZA4sBCQhY3OldJZ6WWPnzFGLuECNKAbHhK+1Bck6xqxcW9NRqcD6o7atoOkNGPnVVFFm3icAemWacUQq1m1nhoysPb6wO1lCs2pA42otGa6BfHaPGACANPE/8zoz6cJyWj4GWc8LaMCFOtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3138.eurprd04.prod.outlook.com (2603:10a6:206:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 06:58:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:58:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/6] MP_FAIL echo and retrans
Date: Tue, 15 Mar 2022 14:58:20 +0800
Message-ID: <cover.1647327162.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b764c5ff-ff33-4e48-996d-08da06513668
X-MS-TrafficTypeDiagnostic: AM5PR04MB3138:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB313811568D20964B105E045CF8109@AM5PR04MB3138.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S6DGkEDVYa3uAxS05MY0WFWPae/On0z3QpES1jWfJUOz5A4R6HXWLaUbdeqK2Ff+/70XZn/vukTno765mpYLvgoCGpZNY2L3xieH7wWHDXDaFCaZ2wyy2AG+ABnNKc2sJczT2TXcW5rlyuxSx/CfleScI/8PdLaGOlmSdtKyXardL6vncYRE3Q7AGpGIIuAGRxmS6hSm65tzc6EwdyesjuOJ8m+BIfqiSeenxk/PZv65OjJSY3HK1YC2/cLSws5TyJsBYjK8ubrnEpgXj7SiSqK35RkV0lWPg5q5+mm4rY9LS++NtJBg+z6rbgQ8qJQ2m4pj/1RKMJHQ3xKFbfguyWlVlgRHRghIFqoshkWqALKn8gRjpyJ8WY2rT/D3QgZgHxJ/HzfnO8Eq4mugWMEK6c00w+Axqx7OrPsGc0G5Ky/fz7gWSbwBIs3sw4nUUiUPrj9sdua4gpfJt/MjTlQ/Gde+F3dX7aJutbi8XwRuGq+kzFj2k0a3Cfs7YNbfsMx+45/oDfhgoHSv7/6kbu1khvcnDxMAfWc1glSHWDAmDZ9cQIsLEdTVCsyReCcv3P1g95j2eHg+28/kNFsLKmg+buYUY+EQOFhebqJ0aFa7do6C86CarwYEYZc7wu6Nj6cMgPLfM5pD1a0GigOfNxspsw/GLlU+GXGA+AuQZMZ5MD0pJeNOmKIWFpiAVH6/mIGXrByDcgtjDCOD3SspDm9C7mgOoSYnq6snXhjo7Ql3xiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(6666004)(38100700002)(36756003)(966005)(6486002)(5660300002)(508600001)(66476007)(107886003)(83380400001)(6916009)(8936002)(2906002)(86362001)(44832011)(2616005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYljQrBmBDhdGPO5s0xIsQSA3/z0QMZGs6M1fQefCGIalY9+3/SN32znJUMS?=
 =?us-ascii?Q?ADcqVizGZTRXfL7Hn7vDODTmrrjTzAaF8jaDccroJFDmyAEh1jj9KdF++N2M?=
 =?us-ascii?Q?o+DIUeKikz03HYBsxzus5ZCbbt0gBnEjo1vqfE52ztr14y7ilZ2qur7K91ST?=
 =?us-ascii?Q?YepsQ/JCw1MQzKHF8gdU7Pz/LKU/rZ3/8HmcMRlNMU8wqvQKPWSDTtXmPRdr?=
 =?us-ascii?Q?uWomze1mIZzKXv1XSiF0Dqxn5+TQotWFQFcBE48Vk9TQ0t00m4TaDjFaZAJJ?=
 =?us-ascii?Q?GbSiBRJMKITF3ZWJfAC3XC9j7skHJuzZJTBGXZN6YvtrlqDUHdkaOVU8ssAb?=
 =?us-ascii?Q?b041q0BJsxp6fBPPBrCtT5O0e3Wq4SvasqA7uhm+xKtSBtGOQfP+2Ng5JXfg?=
 =?us-ascii?Q?imaPjwEcl2DSrDID1yqr/lOgc2aOUYgmPujiu9veBV01E+wmKjrXe3Z43KWq?=
 =?us-ascii?Q?Jk9PVMJz2OiNrZ401xODjmjuwwEVmYhZtudrYSBkh9dA4LFhXwyTmoc2bnpo?=
 =?us-ascii?Q?Whr5qgqriVYmPKCLKa4jpCRgrD/B1HlOAh0sjUsXtQFTPSoX3XIdLpaQInJ3?=
 =?us-ascii?Q?h3g+LkKoIKr2eojF28sLvZV/qhXvsAWbhKfqRtG8jCzrUv/ryYTHVtK4prRK?=
 =?us-ascii?Q?A3rKsWkcXkpKpw+FfVDyObKswK7ouX7KWIT/RqdIDhrdXMYgj9cm4l61k3H6?=
 =?us-ascii?Q?8JyzJcFEE/SmiOhMefOZftGJksB4xp3gVIB79Xrvwmhy8qf36OzskLqtpCLj?=
 =?us-ascii?Q?Iuvb7ojgcORGWp9+oiKQfBOpnT6OmhoLcfnP/7YL56AuCKjupaKwbFzrN1zv?=
 =?us-ascii?Q?/8rKcIhDoO6Mue1eoKUcF9pld42B/YSvEo/9d3WwMqqQn+N4pb/EehBNQERe?=
 =?us-ascii?Q?HSa5eCiCHdittSKBJBoNUnBCR2jJJQj+zZEqaljVAZsYLvZc4L/C48Rb4Ema?=
 =?us-ascii?Q?SE+OpqMsU8MkTeniEJYBYyW7OJQh7aWYi39qyZb4fVmf5ZtUSMp6a6ynk76E?=
 =?us-ascii?Q?4wD7ycEl2NIK6N/h/dnQlmGJmWP+e7Cxb3/KRnEZm1W0/wofDFlc5/vFX8GJ?=
 =?us-ascii?Q?2kaBLncqzbbeqJg40QMK8jTZfGSzic2qX2JZob1Gqrw2cRz3FCudvavu7i1M?=
 =?us-ascii?Q?QZY2Z3Ht7Nsu3nTsrQLV45JFbrzLmnLJTYQGGSECPs1BBZB1mfSKPo9CkKau?=
 =?us-ascii?Q?45emxeuG56ZbXO9G75g13pGt+YxleqDLEP+Mk6HQtHuJOuKP+6dWFefiFUu+?=
 =?us-ascii?Q?CvLQasNJCTrLKqFL9ByY+gkzOpcuNfHFLJs6Ag71dreZuDFyFOtiS3aV2oB6?=
 =?us-ascii?Q?i6DBzphc1M6uNl2fI6SpAqDH7rSfwmdAeSL3x1VcHYNKDI/efFZcPicK1/V+?=
 =?us-ascii?Q?IQVD5X55J5MA423nfAzYwAQtXaII85+tDM5ly0IyxuaPxzbMC7vACivg+jWN?=
 =?us-ascii?Q?Spw/EMlMDxmqBQJL5MG9EdyD5fakRvgQvUo0UjXA8dSpYw3vQ8GagzNPymzY?=
 =?us-ascii?Q?UA24WVXuaHJ9Wbmtv98/UGifg7lQbnT738J/nbqAKOwXM6w49i23k4/NkQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b764c5ff-ff33-4e48-996d-08da06513668
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:58:30.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0D8NpqvrGvoz1H+XBaC19tXs4u3IpL+w8kWoYtSm0eeaFbgZkssNVlBxWnPuSZ5qYPcE1ViKQmy+uSs/g9exA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138

v5:
 - re-check for TCP_CLOSE.
 - add a new helper mptcp_check_mp_fail_response().
 - add two timers cleanup patches.

v4:
 - start and stop sk_timer instead of setting and clearing msk->flags.
 - add a new patch.

v3:
 - use msk->sk_timer and a msk->flags bit.
 - use READ_ONCE/WRITE_ONCE for subflow->mp_fail_response_expect.
 - update selftest.

v2:
 - don't clear mp_fail_response_expect flag.
 - add a helper mp_fail_response_expect_subflow to get the subflow,
   instead of using msk->first.
 - add locks as Mat suggested.
 - add a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261

Geliang Tang (6):
  mptcp: use mptcp_stop_timer
  mptcp: add data lock for sk timers
  mptcp: add MP_FAIL response support
  mptcp: reset subflow when MP_FAIL doesn't respond
  selftests: mptcp: check MP_FAIL response mibs
  selftests: mptcp: print extra msg in chk_csum_nr

 net/mptcp/pm.c                                | 18 +++++-
 net/mptcp/protocol.c                          | 64 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  2 +
 net/mptcp/subflow.c                           | 13 ++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 49 ++++++++++++--
 5 files changed, 139 insertions(+), 7 deletions(-)

--=20
2.34.1

