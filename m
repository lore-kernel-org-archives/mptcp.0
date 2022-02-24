Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF97A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645716039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ntAr9x6O4CQSD/NflQAV23tph1GKduK3ZgUvOLraRTQ=;
	b=SrOxkS+nX55DcPAOLBVnEKyM9XR8n93zR0ekDk92OPM9j9vE79QhD491Wh8IQxtmzJinsS
	WvOyGAy1eLVAnaEpkZkrP44il1cGpxj7qseiU5vsghfAGM/ZUT73dHFKvYPMT1kZdJoKVI
	kX++jBnSI4TYmIyNwx2+3CCQq+FGHfA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27--nqNVQA5Pym_xHYTUwZq-g-1; Thu, 24 Feb 2022 16:20:38 +0100
X-MC-Unique: -nqNVQA5Pym_xHYTUwZq-g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6+nP3YggvuU5P4BoZ0UWhXNruPY6uzk+j8h9k8sAFYOfjF5e2+Eyi2pndBYOISWMxXYdppbnu2iL/rh+4JkDnCNOhsQB0HxTHXpYjZHyCPAczNq55FHaftmknXNnTkVkO0Mpwj74LceeQf6nQkZIhTugFHMiHMRTfIMQUhfMsXVUqyRBzxrL7tzLraD3suO+tTjDkDHSfevU7xWrPdCPAx5cWFI3fOKASySxwYgkI8QHy3aAnvIJWQ/7gv7u1kRQpSz/hOTOvguhDVZFobaiUbve0hx9inFT20qCdC++DH8JiMWGRGmjfR0LHjQfg57CB3Ph3rJcREtUnVkiEFWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXHXDDyDZAQf8rkN/MRHw/JmgkY3rs7dXwE2f01xm1M=;
 b=B6LVvBoRbAhdMpJp+C9DVrCEKkm+A7C7DITobTpVDjCRW49nd4Fg4X7q9cyRuejgten7zGyHaDCjvWrO6Y0rWa5BiVe28tlIpL3wlsDtWAhC0E/eTPPfEiIDB+lQKtPSqHQ1dNmLMr8LXjZ8I8OyWfzCDhdMtVB/wF7kVHoYzkyX1JnpjoXijDfBxFFDWz842WEa+07bXuAebQ3PMzeJFx9+yIdG9T9zpJ5RFRFHp2loSCFABSV1wIbCb//5rIst2dedYDLUMi2xL3KYDPqh2LePyiNRYKfGb8O5hLhThePOERL+WSFoIUoU6QcSsXZruNctbF7qvCcVZ+k5P6Fp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5755.eurprd04.prod.outlook.com (2603:10a6:10:ac::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 15:20:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 24 Feb 2022
 15:20:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: bpf: exercise bpf_mptcp_sock()
Date: Thu, 24 Feb 2022 23:21:04 +0800
Message-ID: <4561ea0907db7c1db98a7c6d90f831ee337da5c5.1645716043.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34cea3f7-b072-4027-c310-08d9f7a93429
X-MS-TrafficTypeDiagnostic: DB8PR04MB5755:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB5755E6C998A4316BC53D819EF83D9@DB8PR04MB5755.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O1VGP112pp/6fBPQRMZsUQxw+P+XQhjnwz3IsdL97gws/IJAM3hLwWUSsv6FYmXyDawtUn7eZah7NYUCAxzlhlOiIqK2DBo0bYjAVMuNvNtJOMaYMA7zK+P60aBGLlLQfMKBrJ03E/0d/WghJKt8tGtn9+JRU3GRh9P5xwDgZRmk4PUmdexhug/t2mwXgq8HLcDOZrq4aCyKjm1OgYE8scnUs+IrU/ZjXV6N6iLUM0D40XX9AP+LJYomEA5eIcacvvO9KHRMrDPLyFfrIDvDa6tH4f+vgfrGcwThLYK9POPR96aBT1DvTAFN/Mr9+n0TwfyZa+f6Fj/NtMAZrbgANQP97cYFkf5xZ4jYQo9aW7Ge4Qe2E0vsayoRAjnv0Ceh6ZEhbe+qRPa6hJ32ldfm/LpOn19Zu8BFx5y5T2HfUjaZprV/IcYENtdggQEQfGH0KxKFE8DNtLC16Y0SaSTqxlhN5eFCsl/28LgkjaSN6V61LrwjBuqxADm8lT5Zm63f8Ufm9DqCuiJ5CBbIrMRoncHM9u2tUoKnchI7CLPYv/I4zaUunoqA+cpw5PEWfsLAv+p4tqe7zGh2PSw28wxRwuvYnU45WeakX3s9nueZOrNa87QqQ7i17T+0GwqrkaH2tzI0Asph6lh+LLs18nj8sdWzI0lHSXc1pZONkH1jYO4QO4NrR+765AwqE3Pm1Z5IIWFEGXUNppS7l3cfheXtKg42HsAy0qZABDpc5xli7dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(2906002)(86362001)(6486002)(6666004)(316002)(107886003)(966005)(6916009)(508600001)(66476007)(6512007)(6506007)(38100700002)(5660300002)(83380400001)(8936002)(8676002)(44832011)(4326008)(66946007)(36756003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+LZoLUqHY2a0rBJX+AG6iG104DnmLj7D3WDFGHDrMGLS4dub14+pIh7mk9+G?=
 =?us-ascii?Q?OILd8d+mmND+464FwDv6UbKlWT6ffT0O/7EHMdMtWLtE7t6iJIbpKBW4vwBr?=
 =?us-ascii?Q?mdY/kFW1IHcYxcCpbzftC7wLgoLjUL06JtxPehDdMI6wjs1In48CAZIeNGoO?=
 =?us-ascii?Q?FrEl8LXAodBE6RbklnOKOjxh68g8/bFid6DYmOvZylIo7YN9dFKJdKt6/b5K?=
 =?us-ascii?Q?f6ZQyQzrHCkQaiwA/L42ufA+BPFPHR9+3LJUw3SNPPKPIIPN1ywq1L+lZocb?=
 =?us-ascii?Q?304Pbxy7tJlbJZ8kPdYKENUyO6kvnwPjmbbkyf2Kq4NApcDVjKVwkU3/LrVC?=
 =?us-ascii?Q?eYr+bWRd1MRPI+qpjXBNDRaRXqDr6QMsdcdW5F7XwMYZiRCE0hWPdYDO1EmB?=
 =?us-ascii?Q?UrmgLT92iBPWwVev+P5q/OtFozGgLphgZsSmuztuyouvKxCUenGaVBSxxHcm?=
 =?us-ascii?Q?bKySzRhIBFFQHusqqJ4bq+51GZoRb8wxj5AKuCal0ljUyWS/CSnGqtPfzo8M?=
 =?us-ascii?Q?uy5D3qXUTOQN+HD4duF/aM4wh5cYNtjPREVoyWtkhDNxTkQk1DscNdUxBwK1?=
 =?us-ascii?Q?IL0OjHRiU0OrWzssOxY6NFU/d1x1Yr4a9+Q5iLLxHMmmWHLWSc3XtauF6+Vd?=
 =?us-ascii?Q?TbWMixCIJqBTwqGfTHmGXbWyWZ8/fiAnBdJKw8HPBldHmTSum187eR5i369S?=
 =?us-ascii?Q?5F4OPI4TTaYkA+DsqqIKCKjuD7ZTqawK3BGaM7vQAZ7Kdnmtq0Xl2UXwYxhC?=
 =?us-ascii?Q?UwCdYwQFZP/xjkI6IxtTFvOJMO8k3RqZoM3TruqMYzOM3eFTpmbMZuVbOrS5?=
 =?us-ascii?Q?y47f+NjAa1G5rZarK0EwDJyAsNlEl955WcbOQc88T26b/Mzxi4D434zyc28Z?=
 =?us-ascii?Q?1YaTy/vrSvgChjm7BxVXtCbEbse7gBQpbsU7LUn0ePuG8FLUh0Fbp4reAXXc?=
 =?us-ascii?Q?y2k2M8vdqA2mKNb0bsuf/zDqKFdKrSzWNw1mP+IHxfZRDqzTkljhoUh8j9Ro?=
 =?us-ascii?Q?pgR1JQQNqLmBOVETkyKOgNhYTPL2wciUadwkOOgT6JoxhFCl6o0yQDyBVdB7?=
 =?us-ascii?Q?q/o5Z8/5JiwAyIef2dxhE3uybeqiiOE+t2AyoGoux0IejgLE7gNhJaxfLS+k?=
 =?us-ascii?Q?qOnrFTGXRJNWn+ECYBDoI3eqnI+OjW7Io/DapXvnuLnsFlT28Lm9ITrLndwD?=
 =?us-ascii?Q?9S/A/bevSFOPdaCDYQJqzMojW46YCal+n5FjU2HT7UqnutVekz2NjrwmjNvh?=
 =?us-ascii?Q?lD5S5ulyd26WdD5xas92/RKpEpmMOQQF4Qn9COyQi6EBLMiaugMUDGGNXckI?=
 =?us-ascii?Q?iGFa6b3ibKCalWpszQBU3xLg4Tx49RYbWx95+Px5ohX6cGXq/PHCBj4OUsOi?=
 =?us-ascii?Q?atrtmTCbb7PP9Ik99AfDD4JMBGbq9d+8Af6EiznFhoR5PEy7pRk7BniyoUBY?=
 =?us-ascii?Q?W95ukA8Xock7MgJrLfPRw9u1PTJIJEK9V/YJcj+nZGASQB7oOEpsOzULwemY?=
 =?us-ascii?Q?xD/kLzu8bXOyunheuG3HVA8PQS8dT6X+bII0aGqNpMFgFM5mdT8RjdXLLxmM?=
 =?us-ascii?Q?bfExMhGouUXZw5oorAgtwL1lTmPXpaW/8x/XjLJy92wxPROULqb0ReXYzxme?=
 =?us-ascii?Q?nofVcE/qUYkvOKzX700ZntfwkvrWcJ+yAeyfiPv+bShEDDfLBmquz9wBhvfx?=
 =?us-ascii?Q?oMcvSuEb1740q23kZABMDNfSFKs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cea3f7-b072-4027-c310-08d9f7a93429
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:20:35.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiAqShYi9iUBF38JquzI9tW5QFm7II1PhZ+HLBY9UMPfvBGIFuzGhWRKMUJy/imvM63ioGUft5hZn7ZOXyyr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5755

This patch extended the MPTCP test base, to exercise bpf_mptcp_sock() from
C test as Alexei suggested in [1].

[1]
https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp=
.thefacebook.com/

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c |  1 +
 tools/testing/selftests/bpf/progs/mptcp.c      | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..eba1b6d12a8c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index be5ee8dac2b3..ea614e02c8e1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -8,6 +8,7 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	__u32 token;
 };
=20
 struct {
@@ -20,6 +21,7 @@ struct {
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
+	char fmt[] =3D "invoked=3D%u is_mptcp=3D%u token=3D%u\n";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
 	int op =3D (int)ctx->op;
@@ -43,6 +45,20 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->token =3D 0;
+
+	if (tcp_sk->is_mptcp) {
+		struct bpf_mptcp_sock *msk;
+
+		msk =3D bpf_mptcp_sock(sk);
+		if (!msk)
+			return 1;
+
+		storage->token =3D msk->token;
+	}
+
+	bpf_trace_printk(fmt, sizeof(fmt),
+			 storage->invoked, storage->is_mptcp, storage->token);
=20
 	return 1;
 }
--=20
2.34.1

