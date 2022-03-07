Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA737A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646658570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yoew2PIMTyWcah4J7ctoAQ9iSAo8PmJt7Vdfy/vwV2M=;
	b=bhMJmziaJQmhF3aPWjQSG3IlJ8kX8RxfGBsP7moSSr2Ze2WSA+jl518hGwsh7xhejHedKi
	SbB8pCdp+k0SgnanvHTnWOPQ8LWrA+l+eW/1jxzwdrhg2SACLBeVYKyluGupkfKeC73BW0
	ktDjS4gy9y/mtPLqeqpyEoXwCBO2GXE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-c7KtYBmNPbS3tS2qEFSbeg-1; Mon, 07 Mar 2022 14:09:29 +0100
X-MC-Unique: c7KtYBmNPbS3tS2qEFSbeg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ValDhd37e8jUd2NdCgxGxNaD4irom3pMdE3HKAot5vrFN1S/1hUdI/iHIkbVSADXgoQUK7FoBY+otZUsL5IXvFqUP4A2qYuMgxjdZn0FmtXQrRAgbZa0807RCFc7gkJPfSjgy8Q41ZnRrhEzP3/IdBsRJdwzLDsu8Nh4Pw1cfnZSB8FfGdax4f0mt5+u4cZT+FuDSgFLdg5eOoGZzYWmE0hBB6iYdrHLZmavgAIHX6W4dOY4tLEA4MH/RB/jp7AjZsckRBT7/IRVxs3kGZHzyuVGwbU9lIVEelv4Zz8F5LxcjJCUoj6QYgGhPkBTn12lge7N5pPKYUK2u19ZVEy+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e7FHLNH56pvgkz4ViwoVUprrQ8XyisEB+eiPIjEuSU=;
 b=FaANaWPjuR0SeoBEZ8+Mv2tstg51q70gpmukqhfCqcvDGuZWo9qLbGgm59URD+19Ia8Dlh7OcQ5BmNovHFK0G136B3cBUFI84pRejcoCfMnVVT14roHG0Le/WBoaHgd+/5bv27ASSJjLLZCJg6mo8aBmZTX3YefoaSWqtWSQctMi4lEC2m2LCxFjUQmhE63pTVI6sICjE0RrRBQ2UMyvtGzhYcl/I3yc2GsI9ZlUn1N/1NipkAE8yFMZapqTA1iQ94IBKN9YEIEs5vz0wzXfpJo7/9pmZHhSuv+00Smnm3Z40zFwsOnuLcD4c7wEtvN2MY6T5cgIqeF7/8EDTBjtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 13:09:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 13:09:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/3] MP_FAIL echo and retrans
Date: Mon,  7 Mar 2022 21:09:14 +0800
Message-ID: <cover.1646657963.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0203.apcprd02.prod.outlook.com
 (2603:1096:201:20::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f73e331b-9048-4741-471d-08da003bb551
X-MS-TrafficTypeDiagnostic: AM7PR04MB6968:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6968EABAB7746255F29B6F2DF8089@AM7PR04MB6968.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L2eYa4FFRkj/fQNR8Q6dbPdl2+otUP+zU6XKL/85vLlX6nKaZU1n8wfo2aUTGhEa/rQWQ68tVRIbbYqoQgSHoD4Z65POYRk6egl+DoLsUt472s2zW8hUNsu6I2D1zIjhv+dYHkOdbS0WB0wYkGMjAkVekW0+MdwBzsNGwuTKlUndV6zrfu6kzcLP/jBLaTPLit0UZZIHBoHMZTRGPWNImxA93Swv8fCLhFYbPpP+Q0Iyqt7f9ZowM4uHpUnUEswt8hnCkKWY7h8qnaVNtqLC+Bup2bJZfGFYH47BA5txcUvTTmmGu7R7HRjtvV/vXRoHTAF3WRnLr0FSKpJCKzYJNKW90KjHogu432R1Ashx9WhwwDbiP0UeMJ+ibT0al5bD2+xi9x2N7lWsreATBcTLTXkg/bpDxn1iW3/AkLXahtNxhPVeXOjvwW0EOlMD9kmh0IN8AfetcFllyxTWvCmmueC7QWj4h4/wBYgWsNXYa1HeT20uG5ZpTDrc6rKzwukYibIoojiJiG2J1Lr2V8bHVynPOY7JhQf+ZOcQdEnvi0bk2qg8rxD5OGs39iFukTfeMOSmGkYLj6fvzaELSWnC+7wqNSu4aHE3MBzQYarcsITFmhCiWDrOuVXXqvswCz8HQ7I6T84BbWt8++c3mlZPH8uPaZqvTuObgagFzR+PON5xuL3krgDPZMhoptqDs7FcHegbbVnihMl2cIkHOzSv8tMrVJJYX2Ihxlc/cFGlcu3i4NfNtbNN20wZZW4uArAbSUmBVfgF2kKy9nIJtMxXKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(66476007)(36756003)(66556008)(4326008)(316002)(6486002)(966005)(6916009)(86362001)(8936002)(44832011)(5660300002)(4744005)(2906002)(508600001)(2616005)(107886003)(83380400001)(38100700002)(186003)(6512007)(6506007)(26005)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4knyrVnC8vn4sHa9HzKxROdVWZBKFBHHE/bUF4QvIwmw91XHkBkV/DfHIFF4?=
 =?us-ascii?Q?LvYubg8teXcj+FnOYZJHLyUr8MMboGux5gYLFAjbiHRC4TB1xcMiQ6pT7UWb?=
 =?us-ascii?Q?uNbWaSHUwbguTUjphiRPWoa6agD1/qsUuh3RXjDO8+7VRgwF5MniBGuYW80B?=
 =?us-ascii?Q?PZ/eKuvTLpYBLn6mD2pjnZsr554m1dE1XNCXN5rVRIWGp819iAlOIFmIkyvg?=
 =?us-ascii?Q?W8zblyoFD/JTI0b+2n+eOOUIlJ4BqeggODZe4FbCSgR+9QeSyY8y4sE0XEUL?=
 =?us-ascii?Q?umN3hRCeoxt81t7RXodRLWDHp79MG8oKYI/GtqMT+Yx5lAshoAO7HVGM/e8c?=
 =?us-ascii?Q?1V3hDWG5yynHrZqx2iW0oERFy58S9Qk1Vp+DDRcN6yqRCnoxu8/ysLK25u+U?=
 =?us-ascii?Q?rXqOKH4bao+GRqZTcB3sVm7zswtqMoTGcLiClQKz2YPmOGScPXGNoJtLr/9q?=
 =?us-ascii?Q?17nVXRWnFIDDKpsm3GzUODVup9gcEZTgxmSP/8gpryJVTr6uc041GJ+fztg1?=
 =?us-ascii?Q?xore4f+snV1lTWM76j6E0NUsbb9Ww78ZhDepxoLVRg4fdGTe8PfiJ8WoVnQU?=
 =?us-ascii?Q?Md82YULO/eZxt5b2HewFuGvgQVk9jTPVg7yUpSeBoCSBzo8tnox+e9Q6syyw?=
 =?us-ascii?Q?dwUPHRU3cIGc9FlNW8RTMLgtCCCcWoyV55xX9oUysqHBDk7LDNDcAxsvAUhh?=
 =?us-ascii?Q?BZZxO+PnRMbOYGgArVItMalOQRxB3IqNV0GqQGs4PcB4cmfFqvjg+h7qJAXn?=
 =?us-ascii?Q?AfiLnhj+DtSjGv9PZpUpfVDzuJiwPZiB1uhrcV48rfGh7bgBIU/JxBvleTYf?=
 =?us-ascii?Q?0THuHle7cxAlOLPLcvAksngtXzKtr6B+ExgE4GarGurww+4EoLP5o6hFsFMs?=
 =?us-ascii?Q?JoUO9reL2IT8Px0n/UvLfNAbqnR+S/lzluVN4mTfwbSMXVCyX/mt8kiJ858d?=
 =?us-ascii?Q?QgfRP+kcqjArFK72Vk92qkt2iGM7xDizVX2Pry0Xz+OsDCUNSTcsdc3gew3T?=
 =?us-ascii?Q?+qHHn15GLpUYKS8/qwcJ4jra4BEnxTVQ282y+BKyE4xUa6QaTTXxsaJyigla?=
 =?us-ascii?Q?3i7xzHiyZxd0GpS4eHWEnfRFwxty5fdl/9ZTfs7Idjf0C7Jc0Vi+EijAkDIS?=
 =?us-ascii?Q?h6vSt4Hs26yOdaGFZG4s1qxUS/J0O7v9R6PZCMo98EiPk53q6fgqyTFuueVR?=
 =?us-ascii?Q?/K2DOAROevN+Hj2H4pj7C2yI1UeP6JzFtYr90DW19pAB7xHnmuIYkpSGJw8/?=
 =?us-ascii?Q?oSxNAlk8nI7b3i4TXNMJoGg/sByHVAPVV7RQF45gfJyrmiByzFfdGnsSyc4U?=
 =?us-ascii?Q?Q4M/F5Zf36z/8ZJ4oMDTLWMAfmCNP9YX0TJXCaX9ml8xyF19q+uSf3TozvuM?=
 =?us-ascii?Q?jhe86AlqOyElb52LDVZT9L9brNdrNGkZlj/OFdIbab+Tq8c+kfF/yHWBzp8Z?=
 =?us-ascii?Q?2lnLeHI+k6VyShws70Z/wFQDnbDgSA0EpzE6I9xXzIfogBRuXwxZlgFLl1b9?=
 =?us-ascii?Q?+GNdyL0jCqVTkeCmXOVxTBUkjwijl4hrCb9LOQpYL85sI7x9O4cAw1Xz8HUC?=
 =?us-ascii?Q?mriypgBjv6+s68xTyuWbmykPQdG5r3rR7MbxKpfnEi7Oop/KxEs4+D7JWfcS?=
 =?us-ascii?Q?hlwo78mbAXQno9xm4+dYEhE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e331b-9048-4741-471d-08da003bb551
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 13:09:27.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NdalsNuBOeAFYp+igftX1sejEXP9xabsiDd+aOmzV9Hs/K5C0SBUc1Lcgy0MNZCiMjX0qhjNTq1SW8IpkN7pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968

v2:
 - don't clear mp_fail_response_expect flag.
 - add a helper mp_fail_response_expect_subflow to get the subflow,
   instead of using msk->first.
 - add locks as Mat suggested.
 - add a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261

Geliang Tang (3):
  mptcp: add MP_FAIL response support
  selftests: mptcp: check MP_FAIL response mibs
  mptcp: reset the subflow when MP_FAIL is lost

 net/mptcp/pm.c                                | 14 ++++-
 net/mptcp/protocol.c                          | 63 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  2 +
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++-
 5 files changed, 94 insertions(+), 7 deletions(-)

--=20
2.34.1

