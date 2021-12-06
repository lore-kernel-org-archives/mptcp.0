Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4F68
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 04:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638763202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM4Tb6ArJ4yUhL+IfExlB8RdpZjBjX66J0s+ipjUfis=;
	b=dphf1ICYeHVyUid2B7zdLNe+GqeUj+FvyMv3UTTC/ZvUosT+Va02SBvwRu8c23zpn0gSRd
	k0GTxXQUSGx4JwU3ljkai0wZ6QerCRzRvDOelDUxicBL1L4tfqSHcheN6Ff5/MSNYGG3jq
	EtnSxnImbJtHGQcGngndZP0B1rBTWIQ=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-49wz-4M6OiupbhIydwhYuQ-1; Mon, 06 Dec 2021 05:00:02 +0100
X-MC-Unique: 49wz-4M6OiupbhIydwhYuQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRK6+J2wVze6E7JAN9tnUC6/sY7JOgep953V+bRY4gDjqC3wBrCSsh3UznW4qXWCEuf/8mSENc/gT+eu/r4elNOWr5sSBeolzfmvZbS65WkErMpGpvgy9lqxRvH4QcpQRpe5NnkQ+xRyTUr8YZsz+7laV9BtVZu9Y4f9dpb5KecfOAIpChH6tXNlW1U1AenfPD8wWQ7j0SOoTOfAzBlBNhdSCVRFx8A9q3GlwmSZ85RIPKlEJDAW0UuM591oJ1VjV/bC6NyhMAuxaZYvJWHOdydac/LBJkaDG97GJgsow7wJzjEmxKYjUQNtnjZ1gTg9xPUbisVWWWcmEifusYNzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSkuVeDIS/S9av1F6du8A+T5WUELUsy6V5cKBIiSyMc=;
 b=R+8Cp0z13Ma/tiXVRnm4rCBJUI7fgNUv/1xygx6vSqg5Pp8+C127I6Du3icE7hEf2yarG/Tch69HNLmFQV1BpCMqZ1rECJX4zVAUa3DxZg7emQxpQZ2r3P+qTGpjZL/1S3YJ9lAGSTJ3a8fgflGSfzD7dpW0290VlgxUftXrODrANYUxIP5pnYqHzDQcd8Bq66eym7NRdFWu2VjUwmpwGDFFX3++HGuUVgmgwAUcD8ALf9lIVXiJ1Prm9lVV0ei4UDy1FrtU7Y0Iy/crSg0zyrbREGF/lQfEOSl+NJOqTbV9RtZc/NhxAr2aNJ3zmILJK93/560GWqXFhebrsikCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3065.eurprd04.prod.outlook.com (2603:10a6:7:1d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 04:00:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 04:00:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 2/2] mptcp: print out reset infos of MP_RST
Date: Mon,  6 Dec 2021 11:59:35 +0800
Message-ID: <296e7a31661fbb2783dfa994b49160ab07f66c82.1638762825.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638762825.git.geliang.tang@suse.com>
References: <cover.1638762825.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK0PR01CA0067.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 04:00:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bad88f-6c1f-4ed5-19a4-08d9b86ce079
X-MS-TrafficTypeDiagnostic: HE1PR04MB3065:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3065B9324AEC759393C12032F86D9@HE1PR04MB3065.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OtsYFWbNHRebGoSI4YEgvBIqYaAG8r8CjJJsgPj7tWHY9XzHJEF0z6eD682NrILOsw5xHEeR8QnM80wsIBBFEAi3Tx2s/WItHYJfHgAIw09eQDSqWuIRGe6y1T7OibL5Mhz39ypeE3O/iIyDiwbyQNTtg++vzNSGQHs/V3Oxr01/Qo0O5YRHe9Q626cSt5tnZzQRcH8femEPQUWqPLDfLla2/mpbm5Ld8k/3qW3NXiNQBFL76SEaIOdJLF9EipBQvFsExAcl65zGkqhEC1mzYWidoLGnbA3/IF/XbUBu4uIPRLdteh4k8O6+bNsRBnwM+GqF8rk64o0AVcQHH4twrUMEfLxhLcNX4gXVhUgW23qId/vLZsbIAORCPxG80kSeYRBtkpBtI5Vp3mTghapGVN8tsBIO4xIOc29X0w2hkXmMv/ufiD3toOJPWtvXlE7hWVn8F1utGxBzi/T0JRzgwqxPkNMnogI18KZT8J8UWOAOihBwEoloorc7RjzZdaLSZ5bP9X7D7URtwN6oE3LnOQCXUBFqR0/ie0mOEpS7FAbIqHsyPKOC2vXo1vLTV+zDIANRIn5TZQVFp52noKOVXrHGyeEr5hhRq9g7uUoBISJMAdTSbUYN+8QN6xGW3D/VmNdI3HAF3GNXAYUlbSf92A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(4326008)(2906002)(6486002)(6496006)(8936002)(38100700002)(86362001)(36756003)(956004)(2616005)(6666004)(508600001)(5660300002)(66556008)(26005)(6916009)(55236004)(8676002)(4744005)(66946007)(66476007)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/USYVPAHZbxMcCBbrIqlNtyQjemw2Fr1ffIhACh5W325erI2sv9/KsXk2rr3?=
 =?us-ascii?Q?i6Ndkqc2rL8GxAqjywW5JOA3RPlTi+IdT2yWc0eEoV9fgg7rzJv9qB8Y6Ezj?=
 =?us-ascii?Q?+vWgquToz4bxQ68w+4wH4BvS8PzvZU1hO23tYCZVuUiAJGfra2BOq2mVA/rt?=
 =?us-ascii?Q?vBXUe4R7sT5gQydC7Aj7pMxVogPzkvMuclEpwEIFGYa3bRC6NabexuWHeJut?=
 =?us-ascii?Q?KWPKQ0McTf2D77j/IEJSf2AmQGQlFCdC5HkBqZ1I/TLSfuFqah8eC4cOU3hW?=
 =?us-ascii?Q?sK2L7KAeloxuS80J0c4d1ffB22YRfAHlkR58m2Zl32Ak9yDmycC8KJZM2KBn?=
 =?us-ascii?Q?BpyVw3Pg/iukDLOwg/5Kp9F0lmPwdWh9hHG1hJnhXzX4DYIVp+mjSn9fcL2q?=
 =?us-ascii?Q?byAU6zbkh3XnM65c48zW87etcFiCK0NUiNAG/qvkjHIIzuet60Qs9vtGjipv?=
 =?us-ascii?Q?VXP05SQ3g4GnmDkjBCXgjzB3H4QNKMJtDqoJsNoiaIq6DjWvcWpTI/9aiILI?=
 =?us-ascii?Q?/pPbgPGclbt6KzfHOVH87g4Dhe3A/z//uT0Uqy1yvzkZLmp7sszDQcyRfsrl?=
 =?us-ascii?Q?4PRocj+iSK0ns/0an6gw0W+n31BgwH3DhRvhDFxx9TighJoFOwAqe5olb9Xt?=
 =?us-ascii?Q?YCEqmM8z/ymozwKV1x2DrkaPvup3qNnoeU0RqXYGOSHhCC//RZfQKPyjRpwJ?=
 =?us-ascii?Q?nMkZCWDXL4uLG4J/aufuC2cYVqTP6Q/ruhoGxD8VZcHCv36javrZnAWTkuBW?=
 =?us-ascii?Q?jbhLJPvXM86fd5z3QLmYdSFAGsjQ7OkOUWYgFKrXtObZXChgCP4Pezkg8dPo?=
 =?us-ascii?Q?WDYGDSVaJtKfWlgmepbpVi8CZ1QE/ZB8pm/Ewt4q0DGOFB2XMrOdhrZjROG6?=
 =?us-ascii?Q?jzW6+1W6a2x6MTFY0zkpX0ckzgEfh9lACMRxIHzaJx1BugJ7nLfzqY3kJIfl?=
 =?us-ascii?Q?FKv4A9/LJKj27fo9OlN+NP/hyk6Ig90lzG7Ws1TyAoj5n3/uSLX2f7Nph589?=
 =?us-ascii?Q?VDdRqxP3JiKuNuBGm70Txy6Kzr64NapggMDpFCt97MmE0WzHoMDyEDjBMmov?=
 =?us-ascii?Q?9g9mSDeFVFBsg/tvlhIPo+I+MmoQh8EKMOmcDzlVH4ZckSFtHfBu/J40+T4U?=
 =?us-ascii?Q?xj19f7KGyL1Js/w7gF/ckVFI8RLQ4f9NFaqXYX5NuNSr1s6tEU238hqxsb/O?=
 =?us-ascii?Q?CnhtekiTvKoY8AHb2OgWdumgapjtCsKb+XQRZvWOyWD6HSBQNsOYpQFezApP?=
 =?us-ascii?Q?IEvFIqkyBhrf9hcpawDrd1lR433lRLRBfvjMnVx1Wyj8WE+WSh0I/6JPf5AI?=
 =?us-ascii?Q?d02qN7P6lfMiM1fxGouvFZpvDBDfq9QB+H3TW4RdqBzHIo2djixJ0PUej8YP?=
 =?us-ascii?Q?n+Ug4d7IMK7uL3F4mXZNmNlvaBqr8wD4gZ7YWRcm2R83xSaz0muMifPYLUBS?=
 =?us-ascii?Q?JxYIGlvshZykgMXO8VJmZ2qrrXmQuXsgW5IjSfHvWiy8y3RL8EFM1XtqTgUz?=
 =?us-ascii?Q?82nqobCqx1J6pcskXzraU43liPGoUH4agN2/8kUphV1uUjxNTT4XvMe+YHjf?=
 =?us-ascii?Q?n8XfGDl3dku5AD0vGWeSxkEljVxQPXYKg+ANnxAvplAJReHPkeS364i0Hxb0?=
 =?us-ascii?Q?uPVBtR04F5VNyDVEbI6J048=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bad88f-6c1f-4ed5-19a4-08d9b86ce079
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 04:00:01.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27GknQVY3Y//3NZEbQsP3uJOdt+YjGbRxt363+0x6qbCqVmDmTpSxeJ5STJEp6yjKpZdOVPoZ/h7s6XhcSbNRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3065

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c5c0dd983ad6..7c101524b48c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		flags =3D *ptr++;
 		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason =3D *ptr;
+		pr_debug("MP_RST: transient=3D%u reason=3D%u",
+			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
=20
 	case MPTCPOPT_MP_FAIL:
--=20
2.31.1

