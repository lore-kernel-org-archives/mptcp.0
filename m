Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93EA20EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv4maKpvBiGkwEI0drCGGuPw8tRskEYnOGFjC6Z+eyU=;
	b=XRC2j8VcaAC5/Wxpjt3R3R4tVKiL+eCwffdlDOdsaLhpXaE5QzpBFqBnqJqdmW5Wa+ph4+
	KRZ+/PU8S008w4XLkqAStAxp6aoKhj4dVkcgDaHDxIIXH7b9mi7xXmS28PAYud7nmGesMV
	PgOMk+cmTAjlQtqpin1cfBq4TOfgsWY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-xm2s90y-NOiob72H5oLiXw-2; Thu, 07 Apr 2022 06:10:12 +0200
X-MC-Unique: xm2s90y-NOiob72H5oLiXw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Rb5Lz0tD9c457ZO2HIWxad0eX8mUxvZFCuq1woU45MPBxH/F1YaWpJLqPRLwky6XiAN0cRD1dS+0LNmxEe+h57w58UcsQMk8Co63rrmH26mvbTN1bOkVs0aHPwOuJGLymo6xX5pFbC1k6FgTtYjIzVo+jpNuzYxqh3K7W8onqoMzP/cVQR3jnTu+YctNAZAp0YurjWQP6rLzYgJUkN90t84eHQOujNDvp2SCh3PRMtWoN8C5d/+74kVLOy+ggTQWk73jnpqL1RcBs6EMYqP3um1QrCK7wpRqTc/iaX7G8dvnfzGzkeOmeIH2+r7WvvOpj3M+zlsaHS6QRyCdYIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spYRxwGHXopx/KtRq3wZfJeYnCGHaTmVXF+xmZwfZ/Q=;
 b=VRTTq+fWItc1xPz0F38Ne59rMtYatSUWxtg9q62wBXvXyGbAukh0RyK7QoPUQkRylGmQ4l38bPI5PZ7cULylB62+1Z5z1Wu419o80NtD3uqC1IZujJ0jGSqYkmZC16X/m6fHQkqf0Hxd5IeAC3VG7Ff83NEYtbklgAUbR+x6VUPt6drmTSP5uexeJdz+ATYZjoTrM6Ru5RmqA99YjAxLuqBWY3TFkBbMFcovVTJKCu78B1K0I2tt5VL5sK+lawKOmWE2aolabDflOiW2x489M+c4/pQcr6PhM/92yDtTKePa7DQ4FQzIJU5B8UlKG2UHA+WVTAh1Hq+hg0mXAupjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:10:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:10:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/4] mptcp: add last_snd write access
Date: Thu,  7 Apr 2022 12:10:08 +0800
Message-ID: <0a862e37de917adce45cb8897e09e01f53b19a58.1649304364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649304364.git.geliang.tang@suse.com>
References: <cover.1649304364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f8b2c8a-dbc4-42b2-3b83-08da184c8231
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3354D42451F661AB43218AF3F8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eimdgQJirWaT2yr4HW53YEOwHZohFpYIWTDr2HE1D74gaRAwI53dyiu2ygCxUnwQzJU0x6SXOXlEHr7anqg2QXDi0GObLC695X/TfGtTnL20T+45HDOfBxY8d6TAt4kLkKH8IOpVIcVuKGA7t7LTtXUOIEzV5dOCjikp6yClesw1E3Y06qk948t4NDoZrx6r2Au/gp32QLAiRLX5dSk23ZDbqaxZ6HetLuT1YVybfEeKCvkxUJnZMIzL8vgC+oNDae5flxRA8EQQleKYwcAGukWxYy7xme3RkJlBpuZo94XAXQ/V5BPIsNdRRqGgV1J4PS8OCBlBq39GGypEq+Oz9uHvUV1D+rIf7KhzNT/xxQW2Ra2d7PHx4f413Q0kwk94xlg/DSjEGTQxnrPJiB1KduwUiqM8KcNtmJF7u4lcfoRHjym60w90D5Rbp1MqVVZuwFSUzJU0TDhOlWvjbbT+jE1VZluyDdgjKAJALj4cKuwwOss2OTLAuCb9XdQiP43ITg0I2/kXi+5GR8nojXCKo+sBvWTaSxXVlU/NKheixM25rR6z398cRagkzc+LH5WpP4M0z46nCFdddfIsvROid1fW81gPR8k75093yQRSZTKU+LZt7u+BOwJr/x2e/6ng0hH+AX4nn72TqOmkvL0rf7sdXN0dShctSK2lbN3ERc9n3GA6L1LrUAcDCuc+Hqe3Y2o11rNJiGDyjG7JooR8RQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6916009)(107886003)(186003)(66946007)(8676002)(66476007)(83380400001)(2616005)(6666004)(6506007)(86362001)(316002)(4326008)(66556008)(26005)(38100700002)(2906002)(5660300002)(508600001)(8936002)(6486002)(36756003)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+0SjBOjE77wlUWW2Iu/3ZiaT/rGPNKXEabV5sdcoN/hLCKgjzKAH5GzsoWvk?=
 =?us-ascii?Q?rqLTLZ7gDg8u0bOtVyiHzPiYq1Gx5P/BbMewppWLE2aOKe/Ig3l9z5QaVUbt?=
 =?us-ascii?Q?bv6cYHDS7vOeKAYGN7oDjmjE15j0LywpeAJr+ijkTxmpJ29v2hGa/op+mZef?=
 =?us-ascii?Q?YQfyIgg84IVJAct8WDxIlR2pgxdpEtj7Nj891oDdd3vkHk9rJOf0fLv4NzIl?=
 =?us-ascii?Q?T3X13bGsimm9GBPFKW75n13h+J22fuLWe9Un3cvg8jH6Adb9ku0jboDG8mM5?=
 =?us-ascii?Q?FI/m5r16/6U3uYz1DDJUKe86Wex6Zo5GL0HALQwwJkgdMJYYBjTeGHGTZsUB?=
 =?us-ascii?Q?UM43LN1gdsGBJnjC0Rpj7M9TrxN8QvBld3BcfA8FYkNWQzhdmnytvsTe75LH?=
 =?us-ascii?Q?SkSz50VVrF65nP5C+CHr8+z2XRHH5XRW6s3LRCpfrRKo0x3LcAL0ON0n18M8?=
 =?us-ascii?Q?Jy5iBj44+BSJa3w0cdy34HJQNshgcPuSt4txXmIcYoh7gPKNI0gj4DLcJBWU?=
 =?us-ascii?Q?lchB1lg1ppDl3kRcDtGntWZ1WSRIVwzo9/Adj/nfBS1gxn9tExTd4SjM1Rni?=
 =?us-ascii?Q?cMZm8SBf7fmeb0G/13Qa0A5LDjrY0sNxH5WGzG2OBKyON6COjXFZXl0nZY3a?=
 =?us-ascii?Q?t4ZaqeMYE39CVXZ4l/ELtiXL4eTK7KCep2WLSlloTc5JFl4HqLev5inYrU4Z?=
 =?us-ascii?Q?o325zgvZ36gsoLBSPpIRlUVt8a/p3brGBt1X9rHNKaGjLY+9xlql6P6MvA+O?=
 =?us-ascii?Q?BtCUZrMfD6rGUx2ir2El/2prelcqM4PwBqr3EVUe9mB5OfrysLUg5ifFjsX/?=
 =?us-ascii?Q?lsCZKEObkjqmuJIy334IHH3SuumQ6J5YBW37n7fQ+DK8DV3e4739IpydMLmX?=
 =?us-ascii?Q?310RgiIJ2VUGyYz4095LjNSTm8a6S2mlj2BZ9IZ2Xve3snn4GdL3KGvjhFOX?=
 =?us-ascii?Q?2FPx3dqZ2MZIs8KWALd0KBvjSYC26U/mhnoiQwVl2kETHDjYS79Ey5hKJnw8?=
 =?us-ascii?Q?aS4zSKjWz+H6o1FodKeTJt6EADwzbLs06miHGq6tcmlsPXWETWxpnsatFKqp?=
 =?us-ascii?Q?0CCMkl2VJBZiqzxvMiVoE68+hBQtQ0nEy4lXreBT2AIS3NsRv2xUy3nuvk6j?=
 =?us-ascii?Q?xJN5753gmD54tD6vYxl0MzXWE0M+fRnif3f4rFNJLVD0EQdJZzYj6EebuU8A?=
 =?us-ascii?Q?0XjDPhe8XV/mI32+2hmYJVdQd9/R7OV1ogq1R7BLeoSKJZjTzoeXeez/u0Hr?=
 =?us-ascii?Q?g4nKmpvMMMGEMsQ4YLVV3UTUlae+NFBr2MEjV4/Za2AVEfhqCnD5JjAYzR2b?=
 =?us-ascii?Q?WQoECIhptaFogRMaVDDkqash9mfPkaCAdV+YdA/zX27v3Eshqh6ylceO7tm4?=
 =?us-ascii?Q?+rW4OuIwUpRXBLnEuG3o16q9iHeMmyBRKEudrmEq2remJT6d3DFcC5jqdejV?=
 =?us-ascii?Q?JMflbY6L4/XfDZLQLCKag4nweVafMikW6iX/xiSwB7Ug4fwjElr6PADDgbNb?=
 =?us-ascii?Q?Bha6+SeyBV+D5merzCV/4D73cm/AWXP205Pzq3pkyQk0rEYbGlqRiPrev8VN?=
 =?us-ascii?Q?t1QxZgWe0ponr6UFnjB5TunEOR4YbydCHHWP9w1aRbxv9+aPGOORUpVvTT2V?=
 =?us-ascii?Q?1jsbJwRI6FvohEe7/YPsZbsQWReZ1qpo64thxRHq2guSHmVuDNgFc7jw4b5r?=
 =?us-ascii?Q?ahoEjONY6vqsv2On4Kpq6w1nKJkrTcRTWpbXNYCNBrmVNNbJkMifOHPsL1MA?=
 =?us-ascii?Q?spvHEbwSlokaee5Gw+EJKPYOYD74ou4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8b2c8a-dbc4-42b2-3b83-08da184c8231
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:10:11.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpcp5iNXE+KTQ3tIyu60Km556K3rio/XwX4H7SnMdtp5Blgrgcxr/SlY3MuPkdxCNv7te+scd2ZTN3SWVXjjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

This patch exports the member last_snd of struct mptcp_sock in
bpf_mptcp_helpers.h, and adds BPF write access to it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                                 | 16 ++++++++++++++++
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e849fc3fb6c5..bd3c50b07ab2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -40,6 +40,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_v=
erifier_log *log,
 {
 	const struct btf_type *state;
 	u32 type_id;
+	size_t end;
=20
 	if (atype =3D=3D BPF_READ)
 		return btf_struct_access(log, btf, t, off, size, atype,
@@ -55,6 +56,21 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_=
verifier_log *log,
 		return -EACCES;
 	}
=20
+	switch (off) {
+	case offsetof(struct mptcp_sock, last_snd):
+		end =3D offsetofend(struct mptcp_sock, last_snd);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_sock at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %lu",
+			off, size, end);
+		return -EACCES;
+	}
+
 	return NOT_INIT;
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 5135eb6710e8..990ccd2b6e96 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -9,6 +9,7 @@
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
--=20
2.34.1

