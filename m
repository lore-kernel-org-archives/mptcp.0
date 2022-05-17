Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE97F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652773412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3jORZefhjjcF3EOtOmzZpq48uUP9bot7SW8L0nelClw=;
	b=j6UYOc/YxZrZN4siuTM8dbFl6EvmKz80tzdGFimp8/GXWKhzzCQ/Uq/0HtiIqs72FsIyom
	MAsWNXyxxKk384HdbUwWbY7NGuGzHTV7/CVFSTc+Wv1i9QE+He1u4Fb1ePrLZTIiIxIKiM
	ZJuFXZbfLHhs09zSMoigIVX4Hi+xToE=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-NtnsFvu2PhGXN5D-SVxjKw-1; Tue, 17 May 2022 09:43:28 +0200
X-MC-Unique: NtnsFvu2PhGXN5D-SVxjKw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmw9syUwsLK5fg2lkpv6/7L2wzlbgzA96mZ6MiQRSJHCyY90Is8JAxmH01X3FOo0joMUeLEhdBAbGbghlXV81/r9A+9hU9NLsMiEP8NS6dzdxnD7AHbBi3DRhynS1c5E7VZYeUotUWR/FI19y8WOwMwQQ948G+uSiIGs09td0sTcnhFTUTAzr7tZZtmAJgWMIjqHdXC4450l4zzIzM3bs855fxLLdSnY0ygT3fAQDEPl7ihVurLgXcr7eJ2Cvi+OHbDQqA13U1Z3y6ws5FkxHo5Cl/5LH6VGCo0ecuYr0+YVMPBD+LA/dEwTr7YcyxK4d4Gi6E4nO3gs0vTmv4fA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su+gx4fOd0vvVHMNsG20wNt1AmJJxK6E1b+Isisde9M=;
 b=bDUF43lIC5TaXBTMvoChWGiaL84uWPy9k00xZ9TCypbDNUqLkZsm+90x0tUhnC1UAV1WIglm7K8JAdE+Pvyxr9QAQpFBPcOsRo3HwUKTOQPpQW2pha2mXrki9CHJ6S22zvM+IUfz0aAfAOTjV7YGp9xyM/LZbBNOG1sA5i3aEAzl8vJ9lGYlwRyGI15EyLw/jt0U3IGDywHyTGOn8hm5YVrWZoQNAKqxJZuoflMF83kq31jbhpIdzBESVp270VobwrFZ4MBD56F16lSU5ik+2twFY/OHENuBxOgr7vTgGwiFYnI409oAtYuek2GiDxT9yZL9jx/Q0PAdvRw47eeJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2732.eurprd04.prod.outlook.com (2603:10a6:3:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:43:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:43:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto"
Date: Tue, 17 May 2022 15:43:19 +0800
Message-ID: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7a34f9e-fbf1-4ad8-232c-08da37d8ed5b
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2732:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB27323CE9AF733C8C7EAFD500F8CE9@HE1PR0402MB2732.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6sOxW7B3FilKxI9hTut6oJ3s9eaxKAFSqMTN6OIhQoNe3vatSWzBXWYAdEwziiarr/cSsQkeqxdL9lClPVMY9qSqwqU2xyXcjEIvFstqUr2FoGVicEIXKURv2p+/+x8SBOd2jKIxyXNFmrKKBAC+4jZPE93HSXCxd/dKESJKS5MYx8SzPNzGc0NHMdFcy9E1V4tDrtU5o0FRfJdCe8S6L7wuGLDfUPtYG7VPs7OaZmwsvi46fK4NQh8ok5eFf21Lo65EE/73NNlFcLqSdtpg+bTGRNUDM581H8kFN0C4lTNYM+rIm9VwSw+2UqsJR52ZWL2sXuGxOYy5LgQ1GVM2WsyQX+eZ2ZEcTGFO/JpXYFQhRLRbIV3guKUF1G9UuQ6ABJdI160RuGKj/Qr14xKrwNVatMKZ5ZWzazPgZRVW4f0oS+ZZTtJRU3okFOei+9oZVKT+OhcPZEK5viSFO51VJC4+H/+AUKv/jhtUKLtxeBUXVViygi4mKCE90XlU9f3VZYdQSOAbv6idYcrBaZz8Xl/msBKhMR8d/qufPOg5VO/umZFTCWx8d3EUvQPqFN80AQjrmhVC8mdi4XhPhIoYzt74JHG7snZBrFxqULvAjAn6oj41wyd5oNkHIpvalkWH616lmA16t+GSh8yMHsoHNEzUSuhMsJQ6mZ7LkqSv8tlF+waBPx+HV6GHDIhzEU8P4+P7nOFbTz89q6NXKJwVaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(4326008)(2906002)(316002)(8676002)(44832011)(6666004)(36756003)(6486002)(4744005)(6506007)(186003)(26005)(5660300002)(38100700002)(8936002)(508600001)(6916009)(83380400001)(2616005)(86362001)(107886003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E1FjrFG49Nu8sUHYcxQGPDLhnOUCKgpA+xbqAmpjiHAclMtR6JnkRSgpUYML?=
 =?us-ascii?Q?r0kTGzf0vzgbgDU8jwqLrQHca5EImdLej8u7t0koa9YTE0HaedCdNkhUB0AX?=
 =?us-ascii?Q?GF8AeMeFsxvmrTCOgawP7jgUzSnndJzzA8Yw32a+5c/iXYLh9rLY3a+kRLoo?=
 =?us-ascii?Q?V9UTV0wOCtseFkmJPdpQ0YfCiXkDAMmAAODmdENqIPMlF0GylMI5m5D4G8od?=
 =?us-ascii?Q?uejM6Xg158hEyGdMeRbtBlhH5CsJCdYZk2Mc0n5vkSXPhJGS8hnbgGjJcKdm?=
 =?us-ascii?Q?o0ItDjjpD/J0Nm6/1CRCzFaROpmGaMYgytj51t25uPUSqOKX1QGrzSmGmTnH?=
 =?us-ascii?Q?z4+eiqW4cPIXhWiq1WvhertY5HZOuSI3lsm+fxU3ydQuiI9e3U8Ogx4gw5ix?=
 =?us-ascii?Q?w4NTAKnDxmebSFv86OJ5sf/5OfzJtpgyu0NQS9PZgy76rv4Nj6e+QsTDqk9m?=
 =?us-ascii?Q?cjjSnEFADxX/ov3gefCC3/ohJeXr5i2BEzRZBN6K0IKErKVLqaViyEu7erGH?=
 =?us-ascii?Q?MFU0ptemoG6wAP4Hg+8Qex3KnHfV8LgmrXsjizuVtxlLGfhzT9eTT9Ugwo9N?=
 =?us-ascii?Q?5ERxr20nyHXbwgECzVRqIkrxvYPPKBN3Lp5a4ybueoi6mlCYEXE6flX7joFK?=
 =?us-ascii?Q?stFCEwvso/PQQQ2iGcTDyuOF+aMwH7qtJItMh3FgL7Iv7bVtGBpsW9+Sqhse?=
 =?us-ascii?Q?Hz0zkuJp1GdS/95cHzSzOyHANOVX38sblK5j66XL1C7o8SmmeBQpLHt/8TNt?=
 =?us-ascii?Q?VukViNlnmtLs2re5d+S2x/qud0PknoaUv6ejV/R6xtQYXhjf61OMixxKO5mZ?=
 =?us-ascii?Q?RvniJZdHbTHHhmFXukdi+qpgvcLpOqyiSzXw23MtmV93KuZy8wm0z5/czPOf?=
 =?us-ascii?Q?pNLDSwzCPFJaDKojiHHQrHSPje4hF9Tm8wdSxS1b2M24ezQ4fXDW2SR4GuK1?=
 =?us-ascii?Q?u/XOiM2EOReInrObCxfx1Y2JTBleNuKfIRhtYhOLks2HdC3tX1e6z6/j1L6w?=
 =?us-ascii?Q?c3B5ofDsPG89n5pPUsc91bgcJSh4m2f3m7aD989XQuVGNh2kgYty3gbzMxqk?=
 =?us-ascii?Q?5Fyiqjye0a5lt67zAMUNQKcK2R580dqmLgQo400vEgmISolSmnqgkj25e5NJ?=
 =?us-ascii?Q?m/i+MIndVVtThrJUCXX9Gg0meIkfmf8FhDtaNbyeKuLTC7IDcAjVuHVjN8zu?=
 =?us-ascii?Q?77W3olMZ6vVoPgwtTlHO2i8HUmgqYlYXWmpf/iisiYi5dVjrSPutABP6faq6?=
 =?us-ascii?Q?/q6peq2+CS0sOiPI27w7nzWxkD/HtQ499EMvO7mk59f7PioZSzoMEUFoPBhO?=
 =?us-ascii?Q?kN4VuDHt5mg0J3bk7EvfLFhuthDfCXoZ1uECCw+dh7cGft0OnMdMBn/TBmaP?=
 =?us-ascii?Q?UMQzkodmTyFTU4E3quOSWo5XBbwjzV+YFX0smtmNF1lVxekwHoFzr2ZgkPzH?=
 =?us-ascii?Q?51gcrSqxafZFHULcWGr7FNF/1ZWU7cRLh+kMJcMSP402s58QZcATGRXkN4Mv?=
 =?us-ascii?Q?bHsiaM1GhW1Cqtyo2V5oKLVYCqP87CQW2ENpGkNhsOgwAFp2BmWyjU/gzAYd?=
 =?us-ascii?Q?xS8R2Q6bjLO4SWFda4EpK+adJZf7PlVRF/YjDxwuxK6siRhYrDAfKd5hfBcH?=
 =?us-ascii?Q?tYQzNb1nqaIg9/9fCxtoKDdAenC52cY3W0lp5Fi4xgXaMyv6HtjCiwwL2DT/?=
 =?us-ascii?Q?seJN6I6m18Ud4VQB2wtBIXYb5C6ZB9aXkCwBQRI6+OD9JOuUoejeU3cvGdFu?=
 =?us-ascii?Q?on3ImwagNgJjMQKR7FOyJBy7QfqNK6U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a34f9e-fbf1-4ad8-232c-08da37d8ed5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:43:26.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDpoVogV2NsRuKMyHIc1pqzNKV33+r9hLfH8xZptlHD8XvrDMt0rSzX37jfpk6rE5H+xATnS9zeJ6V4JvS7C9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2732

Drop EXPORT_SYMBOL. (Martin)

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 535602ba2582..5a0a84ad94af 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -19,4 +19,3 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct soc=
k *sk)
=20
 	return NULL;
 }
-EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
--=20
2.34.1

