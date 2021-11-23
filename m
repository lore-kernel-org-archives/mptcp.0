Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF32C83
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1637630634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llnC6qjC1/E3/wDbtoxQ8JMsHgB7P4KDuddQ+xRw6QQ=;
	b=dakaohAB2CuI5L+6Pm2zxlGR7UdMn76VNWBYhwnmYdr0PXEmViRXo4v50XFh4AaePNOr5O
	+cbEcyvo4+521f4njUukNv+yNd2duL+Pf91FMiB999hrZJmORrroK0tBpAEKBvt0HUiMMm
	IYxRbnc53bkOabB0CXbLvdsqTUTNC+M=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-wzEAoYIYPS-m4zm1V93YJg-2; Tue, 23 Nov 2021 02:23:53 +0100
X-MC-Unique: wzEAoYIYPS-m4zm1V93YJg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSTIonwT4D+3L4dmU0UQqrA/svkZfyI/LWKAmVxLUoPshgHIhIlXoYzsflLtLnCfSP+DblTADOIsPAeo4aYTJFo1jGhsMgNKoH4MarbvJbyAcs95Ogn7wlwlmo7Pg0P0cYnnKy/aUQbnrliBLI/y8MQbADjvvtpcyB6Klq5rmQENEtk7if+/CU/lMkwdUz0JIg1xWbdRAuDSZHDuHt+zp/mON8rbenlr81q578LSbPYPsxzxqkdjwdgtKJO9p3vH1lSVyhQsQqFzyuGyRhJaiuPhVc97Ip8EXIeb4TR4e03SZGK9ommQRX4pAcM4D1oLS+Sz/beB2GnPFfKq9qpm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALkkJGFk6IxC9QP6b1cw7LvU7OEAJVyCC8/FDrPXRAs=;
 b=llzPaqKLaK7oSIrtdwQhnGqcZVEjYBd8p2CpkiqAQp0Zg6YzQyV3bNlFqq0rFNnBT+hVZsAsK0tvR64nqtUjyIIM6x6WUF2/qZLd0z6oYYQKci5jLzXKzJF9YqojEq+gBl7O9r2K/Afh1DYxCXOTQLYgdp2schflP+fyKXCZNTh8TyULd4vs98UaoKIZUM31Ow4jtZT1uQGH1jhMjDo4j1FRJQusOO1wuPzRhDfVYHuBlcLgga0s+SccpqOkAA/UCL0SOWs5vc8KYXh9dYO6dmub8No4QB2p4bGlaUD38+esMHyiFG8RMcnnhkpLKgP+ZeHb8TfN3PvNc7cvV8KRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2571.eurprd04.prod.outlook.com (2603:10a6:3:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 01:23:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4d5a:e54e:9ad7:e79a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4d5a:e54e:9ad7:e79a%7]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 01:23:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] mptcp: send MP_FAIL with MP_RST
Date: Tue, 23 Nov 2021 09:23:52 +0800
Message-ID: <2ba9856233bd45ffe99f01566c2772b0dd12a501.1637630218.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1637630218.git.geliang.tang@suse.com>
References: <cover.1637630218.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:254f:fa90:ffd7:b378:8b95:8f44) by SG2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:3:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 01:23:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad57e01-3d39-4ebf-b37d-08d9ae1fe7cb
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2571:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2571071ABD3A0E6693508A9EF8609@HE1PR0401MB2571.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eqLTE9p7T98/IvQsTliRzvVpXdyYVqyDCApVGKfqmwPA6/i25FEoqSEADKkYsTaI0BpJn6dH8FsMykAmo/H4IMrvWj30In7I0pd2NJfxYqydZgt3dAOuag72iQuCcL58UwcGVMJkn4gbNwNCCynHWdR0uWmIPco2IRaHryvKXrb1Gf8lZl8KJrd6bHmcLXFHMqui//5GogO0RKrEySRtwpUCbToX5IPEGsnhgnxfe5kcSpC+y8lXy/9UR2DZdWmClROW/QpzU+3C0eOZbHKfMwOttyP57o+mQPoFRIMywiL/HLlTHTCb4lVi/ccowgvvM/tDV0e2QFHgHXVKAIXXiyy98PFn+54e9QCGB7weZlldgobObPywHse+STJGPAABIlRhzXxPJyUI5uR6ryV5II1rd7QuNo8/DOnezqvHqLKnw015Xl2w70yjj+r6XxuUsACo42CxnzbVuYJ3pshBjmD3DZo7Bo4EB/875YbqkO6GeBWt5RobUcjuMLTMC1RAvwB9cJjbpdF1sZh2hmBUYVKT3zd7O9mPi/qej3Or6PDhP6kJYBAg5/vRsh8cXWxiptUrBAxjfERQ/L6xVKwrBcIG9s97UbQ5os61Fx6TxLNoF59KCtLgJRgUqmA+1wUgu/IERfl9v1v7ZZziiR+r9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6666004)(316002)(186003)(83380400001)(66476007)(66556008)(5660300002)(6486002)(66946007)(8936002)(4326008)(44832011)(107886003)(2616005)(6496006)(2906002)(86362001)(8676002)(38100700002)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+6gwxphE9ncfBt+DnS1F8CKbVcMlCv2F18q/vv0Eut1fcHhB2QXceuQSIaE?=
 =?us-ascii?Q?70C3Yk5xzrVnDG0NHE1M9FBv2PGr2HpTsbw/eS5eHs5bGU4n35DGRLAUJfbK?=
 =?us-ascii?Q?XddSZLzpwz8prndunWZ+bIZNYl+5vz+K55+Dpxmxat/KIe9XepChOH3i32xz?=
 =?us-ascii?Q?og+ZkqY6YUr0MvHS5xNlUmEZjwwBv4hb7y96/AV6OVGpfKB1b580dK6GU2tW?=
 =?us-ascii?Q?riFT7Hkt/d2WZOFHxNK/t24D1XzcWFts0CMrsI+Q69Ahp6xKh01UUAMuGLr5?=
 =?us-ascii?Q?xOQmxAsbt0/zqyTuUZzG2OMBtSlscUBt92hSd+FVhuM8VAS3NZhVziXCY/03?=
 =?us-ascii?Q?tKdz2so5mmNgw8KfZ9rR2JP3M4R5mI2dsfT3WL1r90DZ8GxJSusaqqdL7cRA?=
 =?us-ascii?Q?RCNXn8CS9PJHLarGQw/JsU+usnrepiecgHqqwAt6EHN2H+JXxWbpYZs452Yz?=
 =?us-ascii?Q?Hf+HlI4OZf10hX10lfdTuHcE4znJ1W0OACTAhoaxggQqeKF6a1tkm/Wu465E?=
 =?us-ascii?Q?itYzvndEcwkMDiQQ+ymXfTUdUfO47qJmctK1W/xvqVfVXlk7xX2EnqF0w/2s?=
 =?us-ascii?Q?a0hUbj2aCy6bQT7CYelD6DLGwZx6zTnxrp1o7n1yKgx0d51vjkXeVmwvbsws?=
 =?us-ascii?Q?9Q+oai6STipnhWsTn+yiBwL4Yh8F3zBUOSH2B9WR2tacS6yx5vuhrl4u+fUW?=
 =?us-ascii?Q?EejN9iUgZwu9zGuKX/Si+76+0vydBUzBNhtEHpTFmNjTjav9d6w+eicsSTfv?=
 =?us-ascii?Q?m7uTFhl0gn/IZP8Pjo7+fq5wS+aYfOYfcWXR8V72YiuExzQZm5tjSD7n89Rq?=
 =?us-ascii?Q?chUAOaSBW3rZIE9dBCurDmtlr5h5JWNvjU1jqvkbwDgV0vgcvkQSO4drpdKH?=
 =?us-ascii?Q?h9iym8muERsENcPDu/WUUxY/G1fqmkH7Gbqy0+5gomNrdZ4PKBJMu/Y5GIyw?=
 =?us-ascii?Q?7zCXXBvUPV0GF51lBC4K2AI+gmguIW4f4ywCqq+GDcf0+3pWZtoyVAWduCOB?=
 =?us-ascii?Q?LNdDY9rDayQkGNBIzAMujgzcKihbP3w52nhha19RczAkL1xGVp5iPtcoLZXY?=
 =?us-ascii?Q?+B87OfPvcOYLgnjny3JR42rnIkUm2kLrzpDYac7kvK3K8O2qBYYprC+pBJhC?=
 =?us-ascii?Q?VOflofKrLmFQmX9XWhbYhMLx1Ioqfqbggmvkw2peMLaFKGqahdtCWaM5psWO?=
 =?us-ascii?Q?ZOX8HLFSyAmLSXQSl9Gxn0e0HDsjpNK5JNj86rKLqkOJ7BxlswRfRf/SQ/+C?=
 =?us-ascii?Q?+8vy5OnLO9hEjJP34eCLTShHVLemfi53bBY/lNZ962cagukHcC+BBwvHvjyT?=
 =?us-ascii?Q?zcGvtFrELTowlEt6MMVYqes1xjrymSYGeHcKgfJq6Ii2jg5eSgI3xv9biqd2?=
 =?us-ascii?Q?KLjsLH1t8yz/RqAqF0YIQV6BU4nUdPDT/1Ae8qW8P108UwCLc/u0wW8yL7Sa?=
 =?us-ascii?Q?rX80PUr1G+AkymUaO//Xj5f5Z5DFZ8kBJ+nrss4rVgXEhevAR2It9PK7f73z?=
 =?us-ascii?Q?Y1flwgKgPj4x3Gf5v41ASNfmNzd4U/0GeHUX2lsmPzT7OsA7szMnFc1MXPrS?=
 =?us-ascii?Q?oLlU2fvLj42477tMo8oTQZrzB5EbKFdQlA6zZkVJdVCZOWbVrCtWqk0VwLCZ?=
 =?us-ascii?Q?k9n4Y/kHbo8wdVKwLI0U6D+Q2x0PkltHN2Q70v63F8sGiKjfKWsDkmQ+A9s0?=
 =?us-ascii?Q?6zhiNAUEeYH+51PPbuau6fA8qE8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad57e01-3d39-4ebf-b37d-08d9ae1fe7cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 01:23:50.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl/0si6ZvTS1l9vKU/9yYND+0JUabM4LlKv3qd+V0gdMXnxZhWh3kIqcB1cPWxpxdvlERtbXoGKp5zImJeyfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2571

As described in RFC8684, 3.7 Fallback:

'''
Therefore, it is not possible to recover the subflow, and the affected
subflow must be immediately closed with a RST that includes an MP_FAIL
option (Figure 16), which defines the data sequence number at the start
of the segment (defined by the Data Sequence Mapping) that had the
checksum failure.
'''

MP_FAIL could be sent with MP_RST at the same time.

This patch fixed it.

Fixes: c3b546f7292ac ("mptcp: implement fastclose xmit path")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..dc998a14f4cb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -829,8 +829,11 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
=20
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) =
||
-		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
-		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
+		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size +=3D opt_size;
+			remaining -=3D opt_size;
+		}
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
 		}
--=20
2.26.2

