Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A6173
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641980041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qrTYfd0EqAoUZZB1LfPIl6904dgkxbbPQIrMT6zc5eM=;
	b=DjpYzyT8WHWzZ7M8WRC0w+NfFLcAgLEg1A5vHtGSUxx2qIv56eOobk+wp50Wbo+V4vviOp
	hwJ1FBOSgbMzd1c/4LwW8iGBe5BJNvPHSdYuco29fpOVB0pH7aGCnsJ5YYVLhKS6BpLEPW
	xsBmA6QFs0n6K9fTQWAQg+IROtFPDMk=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-nkk1ThAsN8O3Dm-OgkHrHg-1; Wed, 12 Jan 2022 10:34:00 +0100
X-MC-Unique: nkk1ThAsN8O3Dm-OgkHrHg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6lT0Zrdw/zckuqrqrBFNebTiAprbK4RN7jHKLnlJGjuHcgZjfHLQ3Gd3MezDuGSnbF9m5saZJW4mC7M+Ru9Pk4wTPbnpDw0VVmMvVgFpWe9LdxkepZjHI6p6MnICVVYlBxck28pyrj5YeHrZTzQ0HCAno506GkAEW0bmXI79iYlHPIc13ouNpPuAUctd9sJp3JLuKcvsd5v77NxKbxRpzJZPjVsgyxkakuaTTMKI7PgoMZw9BwTPLZBja+53BwBVzqD79Q/wVcuiWZ0N9TdBgxYjMy9Z3ZhGJvCNnGT8MixnNIlJWQY1z/RGIJ1vDsKIuOX3OhB8OwMKTAbHYBx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuEok46Ddo7wyv6ytZ89JSUs3T/T9Lrg2krGQA0JOm4=;
 b=kzo4ePYcZD1REdEePlTIiff0G9e59AqV1GNkwlIUUTqNfIDnz9qauDr/cqQ3ATX5TeUoaXQERntnJN4Go2nn8gMq+6EpLYzJBOaqA1d2L40wflErSfCcJZl4GAgkjbNgsroxDjTTOFn6WlhSs/trYS1/DuOV2GAjiRCLqBxtsW9CeBdoRbr/fzofM27mvPmgq9tQkcBmb3RTZKlsteqybSv0PhimeLCKpJ9Om7c1rtc9SYSLehhGNeP7KIusa+ZdGuEr6fFng1r5CwRbRe5zF8LIJPvztHmvyonIHjtmz+5MxBlB8Ras8G37+5IPcDv3wVkjUeg9WN7j+461Ro4xGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 09:33:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 09:33:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 0/4] fullmesh flag setting support
Date: Wed, 12 Jan 2022 17:33:48 +0800
Message-ID: <cover.1641978967.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 642134ba-2480-4b93-5b83-08d9d5aea8a8
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB429054ABC95E11E2DDEA9BFBF8529@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wgnVaZJZhvo3PpYt1UKo1GDVAL2pyvnFkXEhoc4kXBoOPSDhZ1ujO+7HoMhor3kj3pblKuxU/k72isoXnsbik1/eYKGtELMxZA+JZLZcblUNIPyByISLryqIsuokB4smxbMJTzeZ6fo2gU04Hlo/iJCZk1CElz2h4fd7EXkk6oZ+CKWzlnt+Wp2emA64sSZNO0z/dO2ApAYa2q/B8bf4nA4ZQe5CRpXxY6JBzKCaYl5+lgh/JKF54d22WofwykBZkumTeWe/2k9dvjs/zQykEDVA60bzU+jhQfOCbnWkqDF+c0lIsfkqrFezqh/LaZA5BTZgFg6vwiLB9HVYiQofDFLmW24/7PdM/FnUnhvg2KckwNTjS8seILD0NLnZU8ewNgT//7qDhwI37sTa6Pu7KZRSIN91JdpsqqJ+7ib2wYYuiwvnOh4sRc5VnSEh35sa9l9d33ZYlYlIP422L6xsDZnQm1U9yG2ZaGbxnR+V/Xp2XGm9tHyx2CrIlgmGCOpj5r/OefQy6zuh6i3GaKX0cY4KtKH2bCeBD32zREASjddZFtgNQeEdz/RZ92q24KHNkx+XIiqI5N9sXgcs7cdxWs0lIQRNfIFSjL2lKmp3/6/wKkD71H9cstkQuoN6qz4zdEl628xltGYPO1265KDywQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(6506007)(6916009)(6486002)(26005)(4326008)(83380400001)(186003)(316002)(8676002)(38100700002)(66946007)(86362001)(5660300002)(508600001)(6512007)(8936002)(6666004)(2906002)(44832011)(66556008)(66476007)(2616005)(107886003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pxyLPiTnvd+S/yOVNvRQLi/c6rguTc5hf2+XKXzn0vm4flt3wg1losV+4kd2?=
 =?us-ascii?Q?vNfG7OQ2WraDC9gtYzgKjjQ0EpwYHPomk23tQEJhcYbs2cDUEMOb6n4kQPM1?=
 =?us-ascii?Q?VxvvIM1Vo8YxZne2XzGVzpM+fcWncvzh7eJFAU/3pT90J9h24gvytCsTi52t?=
 =?us-ascii?Q?Bw9bipSz4CU0kUAA1IlnuB5zaOCw0/MTWoJYy3knRP9oSWNuTq41/oLYqS1j?=
 =?us-ascii?Q?K7mhoDa3IRuLrn+uMvzYMt+Udkb9zA2p+ycpJwqhz/ZQNt7XZSKwdT64ba53?=
 =?us-ascii?Q?MDCHu5zz3zj5sFarrllgw/F+NMcH4K8BQ1/AmWy8nnVVjFALLUUsV2Z9Ecgo?=
 =?us-ascii?Q?Oe9elFz1Rya9fXtMH6K+pPWVZo8L0n2uU/BGIiEVoFLTybglp1R2m8rXB0Xv?=
 =?us-ascii?Q?neyQsyY4XzIJmBAoRVCPsUcAItnehDpq3bbXso/prUenale+ZKCtzHm8BSVR?=
 =?us-ascii?Q?ejh5ywv/Cr7tdmHjmkcB4gTBpTz7oiYTnEZX7Jz4ZMNBQS2U43U7MmUNhLc7?=
 =?us-ascii?Q?nSgxYHlK9O4H7F5vL0kPsZwO154hitrK6ocvSYlV+ieY6otJCVAPMKK1Mlwf?=
 =?us-ascii?Q?lsb9zZL2iKaRAEmfVmOrrHuqt8zkgKgPSBlB++52CQDzUzNeYTOdk181wNuY?=
 =?us-ascii?Q?azeAYd8JUGmopRvdPgv6eXGmFoVyUHk+ZUsk9m5HHACohLaXGMgcuzE91ziN?=
 =?us-ascii?Q?ANse2GBFsctxbZzkgXrWGaSuwx6lvoV6TA/Q/+epZG1+p2IRxoWl7c3sqfUx?=
 =?us-ascii?Q?sKQT9Bk1n+UU700bS3V8+o8wegQNU05wXWIHEkBg0hAGULvAoyPZzcA/+P3l?=
 =?us-ascii?Q?7ibUc96w07/QffObbCxbiMpe1cn4WOKMiKOU7DgkM2aZlsmKcz+sllLr06yw?=
 =?us-ascii?Q?/IzIwTut/U8/5y685G2ThA1tlm/ysOlCdQQvW4LyZj++JJC0qbqRRdWSBn3L?=
 =?us-ascii?Q?kVheWh3WzLVmL/SwinWwmBc7l4PK+Q2WWN4n7KT4DxFmPr/qXq68HI9d1NnR?=
 =?us-ascii?Q?vw9Q4VuLuUC3qJc/m8zNeY5zN3gclkScuQG2GkvbBygey2bpfTP9ERoF85wv?=
 =?us-ascii?Q?JO+lmgSg9RJ4yagobqJKO5LGR4sW4HSvbEPlxYK2EGfcwVTiPaX5Qg7h7nmM?=
 =?us-ascii?Q?6YL0W7dVA2XfbgHhnmAQfUxtyM1MBW6hkJBoBu72kBMExdnJuO2xmCpqjjsB?=
 =?us-ascii?Q?e185yeQVol8cs7jNM50l030ZSNIW6wxvQ8xPOk/sktNxYkg4D+ifRNU0pBnn?=
 =?us-ascii?Q?qOJf82oqUl+gAkcGHzfpcUI+b3xW63TAsE33aVuMh9HSNe1TgCn60Fjy/h1i?=
 =?us-ascii?Q?hyejyp6N2oZSHXRXlgagfcHkkwX/n3P1xnFfD23L7RO/YKuTIVb3VSax8QY+?=
 =?us-ascii?Q?vp9lqDBbCCS6Y+ceIE6DSXC5uUaDxy+2p6EQ1ySF+sJPdsZxcJ4wKBe0e/Qw?=
 =?us-ascii?Q?jr/V8Rmo2gC1Ai2lmNgUQXDqsjrutdECw7TnoDrJd1SG/YB98oQyWTSlGBQ5?=
 =?us-ascii?Q?r9d0I/cu/vqXZjVw+dikrIEr+/rhlGCrRyPN//nibT21EuZDjkHR2KjTC1t8?=
 =?us-ascii?Q?60wBT6qwF33wW1LiWJ2R2tJA/UMbseuRwXlgfeotqn2/ibjeriSRlx47abu1?=
 =?us-ascii?Q?gTrpVbLhMX3Q63ohFL0TBDE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642134ba-2480-4b93-5b83-08d9d5aea8a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 09:33:58.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd4IHbl1rEOmnenJHKdjFRaWKDe+g/BKbVb1cEeL4yk4m8y+TLYWnz4lGIL/8PJy7uStynb1Q+9LT0URDdqGlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290

v4:
 - update patch 1 as Paolo suggested.
 - put the iproute2 patch into this series too.
 - depend on:
  mptcp: fix removing ids bitmap setting
  mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()

v3:
 - drop MPTCP_PM_ADDR_FLAG_NOFULLMESH.
 - clear both backup and fullmesh flags as Paolo suggested.
 - depend on:
  mptcp: fix removing ids bitmap setting
  mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()

v2:
 - add MPTCP_PM_ADDR_FLAG_NOFULLMESH instead of MPTCP_PM_CMD_CLEAR_FLAGS

Added the fullmesh flag setting support:
 # pm_nl_ctl set 10.0.1.1 flags fullmesh
 # pm_nl_ctl set 10.0.1.1 flags nofullmesh

Geliang Tang (3):
  mptcp: set fullmesh flag in pm_netlink
  selftests: mptcp: set fullmesh flag in pm_nl_ctl
  selftests: mptcp: add fullmesh setting tests

 net/mptcp/pm_netlink.c                        | 35 ++++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  7 ++--
 3 files changed, 58 insertions(+), 17 deletions(-)

Geliang Tang (1):
  mptcp: add the fullmesh flag setting support

 ip/ipmptcp.c        | 16 ++++++++++++----
 man/man8/ip-mptcp.8 |  8 ++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

--=20
2.31.1

