Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0FF15A3
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 03:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646796980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QczyTf36WLF6RiwPjZcEUbZdKCp4RFvJhvgbWA4SnIA=;
	b=QMMmmzvjfxJC1WVGZf3eFPWUCRwpKGszmVGZrBQD594CEnZDZMcyLuyetScucswGt99OxL
	t8L/Jr+hP98fltCH212gmw0I7/iPXLGkcGgAZg4b122rIVi0C8o4n6jAzoKCJE1vsfQtyY
	+uFQfj6zOKcZhmtrAxA+ojau/dpRDJA=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-nPXgjy-wMruAMfYt9wi5nA-1; Wed, 09 Mar 2022 04:36:19 +0100
X-MC-Unique: nPXgjy-wMruAMfYt9wi5nA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avCqQh1XUb6rOEn/Q/qug31e8wtwfWc1zPF4ec9/Mj9QLQMonj6aEbZzLapmDZJiPqVB47NKJvabg99L+B/xI0aaJPwyn/BVqXBH/smg8WTNksuIUyaeTDldK1nOS9a+b0t1xP+eFmN+X6AgvgPL/dJmvFFTFIOhEie1ojAhrnLXTuC5yZurrkFh4Q7yU1mrUmaB65iN8fyo/2uAWBymo0xKc2ygb4VAYEGd6SWPBeG6N58Nmv5A4bE5Ke6zLAkmG0QtZEJn6Wtw0FBePqL2isbEPbnLA6hgcY4gzUs2kVivSvM0jiY7I7To8HvW1S0yAhjhb7FlQfaix45unSejNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ0l557PIJKHti6t23iVEEtFuxpn33BRZk+pmmHRMtM=;
 b=l6RgHXdrNj0Iz5NE4UxkTIRXdHRVYg3bPtjv3TDyODwK00eEG/pSbPxlwi5xkL0bSsWFg0ZWIB4NZbgxbqP3M4m4Fx1jfN7u17No7znKVCHddDAVDBrBDYBOeJERfkH+5pAmHUTjDSNEDd8j5B1LokJ05zH77kP61nhACDI3X6yRroWuy9/RhGNdHcU/+y3anObyioruBwQCOzb2ere5N51FLP8FHuwEHARCNbY/nPdZ7GEn/CpZ3ChQsuJIhzIcW7w4cwzpttGSAbJJSfPKweMNZJbWHageDCWKLXJDObyAzDPBqvAjOxS4wThZ4ovKqpl7UbMjFYXB5GentenWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6333.eurprd04.prod.outlook.com (2603:10a6:803:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 03:36:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:36:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 1/5] Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
Date: Wed,  9 Mar 2022 11:35:57 +0800
Message-ID: <f44e1094d7b65fcd79c8813b8674c578377b42c7.1646796538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646796538.git.geliang.tang@suse.com>
References: <cover.1646796538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79f53dc9-2f9a-40ab-2962-08da017df8be
X-MS-TrafficTypeDiagnostic: VI1PR04MB6333:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6333410A352F4401AB07CE6BF80A9@VI1PR04MB6333.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nNjh+y6B1MAcoa7n7+YSAv9GED1kaV+0JZ1IotLuOwqYArgrzC8kgks9KojV/r0CgZp+BJbua2zI94XyK/FfA0su/GI/SfHKn+G2wXxt2X3K+2N1pPUiPitVs6O/LnaWkiORXb4RZj43xr6lJEcu8DUyvO3LOOmHoi91kKePjDQmeRnwUslQkAux4i+Qp91LE7Bc+8ZP18hrWY9ZFYnwRTOplu3/BNJKYZyLfSkUANDXh5ev2a+oeP0Few5P0FXtshMGmE9zf3sRpdC5TQmHw5j/LYbWboWNfWk3TmoNyfbxhvUTBg95KLHyJDNZ6OD3YPH8kkpB4F4Dp1BFsWuQYPrwcTUDUuYj/s1Qo52LEm8mWiAPx+2+VI0IE42+928PUuKnnFNKc+ksbxd/EH1gVPySrdTBNq/isYKwyj2HyB0IaaFItFASk/UYwEaPVlXbUOvHufJpuM52deGouEl5sPuuHhPXqQ2Y9wmh3cuzJUOcKfHcwJqN/QK5+gUqflnSwZd2V+scfH+SQCK6mvdhI5QJ5r/cFAkgK68VbX2d3yu/FJ4Yd50RUWF7VaSQUi/hrf6w91v/WJFQotM2MLFOo2h79fH3U0wN+9YebMByei7sWNbpp4JjvziMNRyuh6ED0TYWc4+qtYMB40Cc5g2naycpv22yPoaGbP0zNzVie9ccLmhESfCaxFGOArwYwpY5m5LIFzTWqAluV4A61AOsrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(508600001)(2616005)(107886003)(316002)(83380400001)(6916009)(66556008)(6512007)(86362001)(44832011)(66946007)(66476007)(6506007)(8676002)(4326008)(36756003)(2906002)(5660300002)(6666004)(38100700002)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dg0Mc5hiW8Ay3ey4QTom1PJ962haK6J51BzkycoyLL+jbDHPqYXaV2TaJ46a?=
 =?us-ascii?Q?fzIUMbOuaH0mxRLqTgKDIPh34nw5uxP71zj/W0gzDYhjgOpHNnnY6muXGpLK?=
 =?us-ascii?Q?GYF0lIDHYFKMJHHjVXg79A8rQUcNGhFZ9q6I7MTQ4OfjoZCkJl1VGYmTaGvT?=
 =?us-ascii?Q?6a2EGOrjxVJsuWnoGBv5vNTi/3mZBjVluZWRYhxrZawGrWq3nDAZL5wzJkja?=
 =?us-ascii?Q?mAs9CBan7tEbLAqU7Zao0qlFBcD1jKT7OOJWDPhWlY87YbQuk0Q0IKFJiXE6?=
 =?us-ascii?Q?+9iLOV4g0cqQhlnTDX5pWuTQzCZaEw+8qO4oORsPACUq6edd7nNG1ahSmywc?=
 =?us-ascii?Q?SmB89Oj1jHbQsexcBJxLbWksFilVqJKomdW2VOV3dOK0mzr5EJFc6EbPDwof?=
 =?us-ascii?Q?CIOvga4wGEnThy163rL4sTQh7lYDNlFvcxIsicpb/+yHOpBd2uU5X9cl+78l?=
 =?us-ascii?Q?3CyjUqDCOB4Yh2sDDbZjioQW2dNm+jqIzfONnGCWAx7a1zpnJhllWYcDHEhM?=
 =?us-ascii?Q?gO1aFJncIAXaJsSC42Bkj6pYkP435HuAfJtnGX0p6WMxzTHD6sCnJo+I3Nef?=
 =?us-ascii?Q?dY6sTXAccDqvRGDv+I+q4huGzmt1x86+UeYulu0VIO+/1MW/BI8108YCjeJm?=
 =?us-ascii?Q?9BBImKrxGnaK5C9UPGvBtZKLnne4XHcGeWVEpCyUYaaepgKXFqkIS3gQk5Gi?=
 =?us-ascii?Q?5eO4sx+pNC79dXUJttRVcm6ypZ7Jbh9fA0fdPlux59u7W3jrlqYk2QSy/dG6?=
 =?us-ascii?Q?Ax8jNoGDGX9dagWDhTmMU2pv6YTz6c946gEMnrm9pAI2mDd2m9KRNVF9t+QI?=
 =?us-ascii?Q?QkwCrwoGrZJ6Np5MS0L/kX9JIND5w4lubfiL4yWnjU+3tZ3e2rTU4rtVO1sB?=
 =?us-ascii?Q?+DuMal6vn9AnJicX0mHiVBT2aRzkW1zd8wEBAkHFdYLTerdCeGoqVw1+uU65?=
 =?us-ascii?Q?FFD1sL3hJPII1XuYDhoZqL6yMqiV0mKlMD/C6PxtKhHxavFmXA7wjBtGqlzT?=
 =?us-ascii?Q?qWiCc46EOr8F6q/iLphpxUvNhcOZa66x9iylrVRrr1iiW0DbJPURCZK57TJh?=
 =?us-ascii?Q?n9SWeYIoM5+LpYDPpxNkbavgUX+ZxcKSNErryaXg5AY1VNnJIBJvdNOyYjWp?=
 =?us-ascii?Q?eLbZShen+zyMvrpf3vGOfe9goYMkKL+Hc0U8Jqu6Y04JdAEQn1g+ZAvxvfOQ?=
 =?us-ascii?Q?XZkF5la8h3gyVSmqZ5NoYpWzR9hNkjDDPOKKQpnLM4Ijlrw/dp7fBZvIbytE?=
 =?us-ascii?Q?PZhjln21txmjaiNYTw+ekvN0ntudgXRwgnODbIfxddrrYDBUKx9upddiTTIT?=
 =?us-ascii?Q?HdVoF88ro5sYGg/REujCOv+BjPQEwo55mgwfi3quVBatTibC59Saf5FYjyIV?=
 =?us-ascii?Q?FskVlEl9I2c9VAJQfcTeFhR/frM3bnyDW1lvfYpKCR9u3eVPM5GwqYrw/5Sr?=
 =?us-ascii?Q?kW4ueyASsTJgb+dUMQv3LteIWoWaMVCIiTMDZhCzJR3VRd1HpL7dZHT4uEZp?=
 =?us-ascii?Q?s6sDBrmVbTfo/5dX6JPzoRJ7wINJcFuwlt+xK8HwrnOUcwhcR77wHHWM2vhE?=
 =?us-ascii?Q?EfFRv26l1fV97H5JJfIpy4z94CNSBxp8orV0I5c28FGW9J7nSO5I3SJzpbTX?=
 =?us-ascii?Q?xRawULJ6ObUhad1fvi4PFHM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f53dc9-2f9a-40ab-2962-08da017df8be
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:36:18.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0irSrzNFKaRgkoq+sPngQWrcZ+PHozo4c7mlqb27KI3+Xx52ST9d8Hb5NjuxV0nnJ94sfOzhlFX3JR6a/B6VxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333

This reverts commit f48f0143286db0d8dbded9542d9a2535533dd3b9.
---
 tools/testing/selftests/bpf/verifier/sock.c | 63 ---------------------
 1 file changed, 63 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/se=
lftests/bpf/verifier/sock.c
index 1f85588091ab..8c224eac93df 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -731,66 +731,3 @@
 	.result_unpriv =3D REJECT,
 	.errstr_unpriv =3D "unknown func",
 },
-{
-	"bpf_mptcp_sock(skops->sk): no !skops->sk check",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "type=3Dsock_or_null expected=3Dsock_common",
-},
-{
-	"bpf_mptcp_sock(skops->sk): no NULL check on ret",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "invalid mem access 'mptcp_sock_or_null'",
-},
-{
-	"bpf_mptcp_sock(skops->sk): msk->token",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D ACCEPT,
-},
-{
-	"bpf_mptcp_sock(skops->sk): msk->token cannot be modified",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ST_MEM(BPF_W, BPF_REG_0, offsetof(struct bpf_mptcp_sock, token), 0x2a=
),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "cannot write into mptcp_sock",
-},
--=20
2.34.1

