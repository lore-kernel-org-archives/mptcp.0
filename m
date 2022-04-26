Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2536363
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 04:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650947166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KlJ3nk+XL2N9PiLF6SOcMd14CeDh22h1mLN2T5s1ZCQ=;
	b=Rd/NxWD2CGU6FQCoL0/ldrlXhpICKlNzxjzTXc/hwxPaIFqpD69Apwo3Dh12Z4jFYKTAGG
	ZhteNNR929HS2he1B/YhbCqRRoTzvTRaoPKn9nrV1w5BklGpMAKqlrha5FgoIFZx8ILBb3
	OPUTRPJyoPAxYKitlBy34LKhWDkzD4A=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-nMx1fwoNPNOYnnUi4dISTw-1; Tue, 26 Apr 2022 06:26:05 +0200
X-MC-Unique: nMx1fwoNPNOYnnUi4dISTw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHZwFvLwSTTD7UGkWpA+LzIxJTOS0BtEZaouDvTnorJQf3gM5w16k89y7bNhsYylQ9SW8WTjJ8oJPuNTGJgP7xs1PII+u+JsMhO1O1S9S3sd00PNsp5AUmQrydsuuiur5vLKv6Xep+SiGCkKPzjwmVJ2+4y0w3TVHrQZ6gmw9JYIP2ecLQK6lIBGahopUG/1fMWT4m3YkiyfL5E+6fdM3W7bSIyvRlsAyRytO3/vH9GFZgnX3dS4j4GcmlzAaZkyk+ZqbbVW3A0WxNzFSWWMB1c2bkKu2h0ra5Pksl1h57NMKyjFQj+MpvKyTJ6IRdhgyuWaOoqWpzxuGLYE2u16DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcnMSUAFC5J5nNY9hYdCOsVW9FGAsQwLGZT3lIZE0Po=;
 b=FVegzt3mSOtGTyKcuMf9/wYWV44jVvSAwb/pDwHE2dao5W7qhLzEISxEX/AlYMdVRBxk+/6+qy8rfKmm+k4a6Nr9gCZDOEvRNGPeu9wiSCMM75cYOuhXpoAX9CZ4h1wgXrsdu9ESEf9/h8vOy2n7QPHHARNbuQJ2F19KiqB7eEdWm0DRLFG3PscXVaCGPmEaxbQnjqLWj3GisRRJmtmX254wLTHvD1N3df8oIu0iTXyCiiK49VqHQqly7t4iwZfNam0UbzYiiEgo4yjrqkDV/vAPxaHM+GewHYmYB8FlJBFQWz8fFfUrKhbM5ZwSf4ivRtx25x7HwYgBRR+d0bNQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2962.eurprd04.prod.outlook.com (2603:10a6:206:6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 04:26:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 04:26:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
Date: Tue, 26 Apr 2022 12:26:11 +0800
Message-ID: <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b78ce3-dec2-41a6-9e8c-08da273ce0a5
X-MS-TrafficTypeDiagnostic: AM5PR04MB2962:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2962D827A4C902561F96FED2F8FB9@AM5PR04MB2962.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yRhXlORZ7jFeNqaaYPhhYy+mtKZzI9QcrEhwzdg47+FKLggTX/7caX03ieu/hBXjasoqk0Sw4Qa2JN2Fu+Yzm9YdUolY2WXKOVFJECjd4BagOLFMWJ3CJKmGJI8nmb5mZOO7fpkIr/Fzy5H9bgwbF8Ig3+7eFRN3rztKJMHdJYcDJiWyv3v8oF1U4SoFakfIjpiICjUwe2Ds1T5+vUl/CiMYBxSleQVYLCWixCxP6SC0Oq3wpC+M1dgZiVVe3RR2aGCASaUE5FO1hpgzAb3VIlR0qFp8YtjVKyHNrTiHM1rpIz22IsHGcAWT8PiKp5Ls15PmktRt36pnh6lb77Ler6+LbcGnD3LWveNf1qgyLrud8AUm5vFdQwyt7K5WmXNVP6Wl2AyNscXcbUlw6wvuXLdbQGBzfdxKhKldb2ZlRECAn60FRVHRzRpHMoRIaDmAXNERyqqKFAQwqrNV50jUcjBao0rAHDJWQJWzqunnVqR3rwqzJEwS87eucjaaBbjShSbt4DNlSp0CNYkIyZW7K8fKYF+WvC1yir76cQjKZUJ9qm/JaDAuiWbM0Kiyr56a/0CM/5uV1dWaqDF60oCIOCjkeddMHKDE9eOEuChzisnIFYWAGUR6D472+af9vDZzhQCUEQiKEeK2qjbX3gNtfNSkVGpfsmUBA/jpfU/AVF637Dn0phqQSG4j9kq8EEnXnzAseFSmGLzOixfBuAN/hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(66946007)(6512007)(38100700002)(2906002)(316002)(86362001)(6666004)(107886003)(83380400001)(2616005)(4326008)(186003)(66556008)(6486002)(66476007)(8676002)(44832011)(26005)(8936002)(6916009)(36756003)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QhV0ae+5Y0aC5SX5qtF31pbXEDXlxgEJDKAjegPZ1HCg466fAECiT1+ZCWEq?=
 =?us-ascii?Q?vVDFACXFE742nhUV4YYhP2uxAyohTob9oPcV1Ct7eDuFgMmSAVRpTypGK7AM?=
 =?us-ascii?Q?1yzCGgDXlRGFiySR3NV7aRK7cLDYG8TNbvkpMVB7NY7W+kbwQPTRe6P53cJh?=
 =?us-ascii?Q?qlbKGDf05/CrMbP7Ie7afC7ryVhf7gdo5yL/p8T0lH13oXbbk1bYJckpwFZP?=
 =?us-ascii?Q?jpv1PIFKlaEPJj/VGuSq8cQhH/0ugJBhf40vcP+HbAs7NcIOB+kk1iIhXcwp?=
 =?us-ascii?Q?bxWLI6287GKlrC0kUBHQNJNnAnOgKEKWB46v5mLIMHZVxCAL0MoSbbQD/BEW?=
 =?us-ascii?Q?XMHwCkr3ipIoP2rcn/i/vTFKmnQmzuVLiID8ZEm0ccP3uvbwREePhGJZCySK?=
 =?us-ascii?Q?qYtIarACCIFbkHArgc59E46rlVjNPYOBz2i+ktaHVZgpvSQ8zYhb6bODp/t2?=
 =?us-ascii?Q?Q37klMiCtjfTZnBeEsfNqrkQ4tGHFMBAvfMpqcUtAKaINEwXomJ8p/kNMcWL?=
 =?us-ascii?Q?OoWtRWnlgiTzNvP8m5VoW//25UR6dzgXt8NmJFotHzdHyRf9+vz85G9AtChl?=
 =?us-ascii?Q?/ld6YMoEjmgI5bS/M0DcRMcCuNgzfSETHoFKk5PW8xGFQY+gJKx1FZSqcoxb?=
 =?us-ascii?Q?t/zF1TPrc5FMKNBadHwJEvzlcvrN20ypunqDETONaMKF7+819IeKa8MAJIkj?=
 =?us-ascii?Q?srJYeDagSZtn1krNoiHmjGREpl6EmMmgXtZuJzRfqhpdHIGmcmXlJkQoBpVi?=
 =?us-ascii?Q?26JlMtAenVaxZ/ILpEjw/pM16tkL78N3aRDDP67tpvgqlK4MJHVQArHkmJvV?=
 =?us-ascii?Q?jqwiR5Sszbt+bHt4AtAe3wGr2VlmzdjAasa8etHorIq7eeZm+6BJiEoByxFo?=
 =?us-ascii?Q?67FzJNpijaG6//6RbmQo+adDkKOA6JOXvcIswIIkN09N+6Wni/15U2TY9+J3?=
 =?us-ascii?Q?31/3hamMmRZNejkAAfhdw8nc9uG7ePD1N/iTfOxkK0DQsY3jQ/QjmeXW4PaL?=
 =?us-ascii?Q?qSNcIb3o872/f2JmHurbyKMASF6i3DL9KopqwNkTA75n8ISoigCr2C0WK4dV?=
 =?us-ascii?Q?tc2QlI7hcAop+ZGM5hnd23Xh7qyyZzBXE+QbVHfdb5qAYOKhKT5f+7G6Rcc4?=
 =?us-ascii?Q?Pa3LrLqw5lE/LKSGD/GWV+EIrERlJw/+XA5uWE9xeraIn6IvrnRDWV6Mz/uQ?=
 =?us-ascii?Q?qlI7dL7WOY1MYiMMYrQKabPDdJyt+R62tSwvm7YBDKwDbXcBDd8bg0FRefYo?=
 =?us-ascii?Q?ubGmjuf9lGu7dUt9oKPBdlS7IJQXvKSgcKOaNZ4IIZ3lDQ6fDo8jPnIr4KCt?=
 =?us-ascii?Q?9uhLKC4i3M+00EXZm+mUri3Sra7vdQVaDlzkhGQmgXWmPYyxlYXK7C78VvzI?=
 =?us-ascii?Q?C4yafnetsB8UlIP+2Ib8wpw8IaquWPI2CGg8f756nq4IjhvCr69eH6XSO6Pe?=
 =?us-ascii?Q?B4B0pCKC4HO4gRCe37lhUfIZf/mQMlUMTG+8CjZFw+CBMXZ59Rlkt09mVV2w?=
 =?us-ascii?Q?7TS1MBAEZIKsA07j+W7l13gq6Ei1zgdPPp+tbUMrn0Mz2B/M8vIqg5wCfkEk?=
 =?us-ascii?Q?zYssQtl7hoA8KWTTEdYQm0xwMubUFl0curgXN1Z16+Ny+fk0QgvbhCkrTbbD?=
 =?us-ascii?Q?aD7xL98XE0IPWMJIrSeF5zBas3IxoBxf8kzFfTOMxmaxjfXOWr1rINNIdycC?=
 =?us-ascii?Q?TsHBtjJTgduLpL3xFVjZxkhscE/PvNo+zI6LFQhJ5MzkS8PZNbs6M+9ZrcHO?=
 =?us-ascii?Q?7V7t3m9stosMssP58h/7io0y3LnSKAM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b78ce3-dec2-41a6-9e8c-08da273ce0a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 04:26:04.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luK5MrSh3UaYVk6NQ5wjM83sTJfhMhugtnN6UubTGufluk95+J1WnfoHGqPieNIdmSSAJiWlIcGq7P87AxQ/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2962

Add CONFIG_MPTCP check.

When CONFIG_MPTCP is not enabled, we'll get a clearer error message:

libbpf: extern CONFIG_MPTCP (strong) not resolved
libbpf: failed to load object './mptcp_sock.o'

The message before is like this:

libbpf: prog '_sockops': BPF program load failed: Invalid argument
libbpf: prog '_sockops': -- BEGIN PROG LOAD LOG --

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 5cfaec4e7245..7b6a25e37de8 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -7,6 +7,7 @@
=20
 char _license[] SEC("license") =3D "GPL";
 __u32 _version SEC("version") =3D 1;
+extern bool CONFIG_MPTCP __kconfig;
=20
 struct mptcp_storage {
 	__u32 invoked;
@@ -46,6 +47,9 @@ int _sockops(struct bpf_sock_ops *ctx)
 		if (!storage)
 			return 1;
 	} else {
+		if (!CONFIG_MPTCP)
+			return 1;
+
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
 			return 1;
--=20
2.34.1

