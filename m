Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58B36C
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 07:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648624093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LHAyAHAJkH76yvTnR18nRuidt/Oe7HahIMDtHaNioUs=;
	b=JHECU/LsT4+ww4dhO1Zez0+zcs7BQtgMAjkjHtkND3lnTnl2anquKcHm0czdGrY+6hxmB1
	u/w41WfWIcznHIECaYwEGOt32Qz8vqT7kZyRimKGC7H5DXuVB/RtHiSBcIddxgpYoXXhuz
	8yh5RzY17Bo05iybx/LFlwQt5bpZ5uI=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-g2Q6quEtMjinbfesW5ChiA-1; Wed, 30 Mar 2022 09:08:12 +0200
X-MC-Unique: g2Q6quEtMjinbfesW5ChiA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFhfm8Ca4pYNP58UkjDx6G96grw+CFOHw9sAQRXOMOZJ2f5ANblKAB9poxa55H2zyD5JQ59w76+ayS/TfPzbj2htX7KsMCWYJY4pNYV4N6xbqcEC8C01nIeERep5fmsFq07kqJgJv90+zczDK6HNVXWs4/WrXtxGfF92ERsCQth5sqIt4p6L8HlSV/tP1H4fB/mirrRCax0AxpSjDL47GmUZ9yB+hCGo7CL7Exa1XAiuNrUxIKmBGy6fKl5gVl68XSBgnI066NZPFUZ3D/roI072bM77GMNCnQ2PbHKuPBkVtGuomhnN2NLZyjFC2ZjsWiIWsGRVTgRp5lN7+5ZcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOs9z5I63+1CPOVLRGbgcqOsL+EfK9DzVAhHOE+96HE=;
 b=ll9WpgxizyfXGQNNIG99/YGM5hVhUvtEB9Qv5j2hdEu/i6Ok5cj0Hx1OUvqHMD6ObZ+4URlLPNiSn8qk6vaTksBK28Xp+/bA+YhnXMSV0G0kGaEwOAGv7jsv/cLLtjeTtLPQyUTjP8AUZHgMaIcUIzoNyDNZneVjR653mAuFc9YiD2GlXNzEYek54x/ne+byEo7hnv1cqnXawU7cAVNGw7NDCZEzYS1IDfwNM1ikyGR7b7xDGjmLlSuzDcapZPRnnBJyT5ANuJy8ODtHA7EzzuYnedKQhG7U3Iq+PpHS1HmZsevFVEF9OepEvbMEYOGc+9RbruOda6X6hvwDtHbcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4488.eurprd04.prod.outlook.com (2603:10a6:20b:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Wed, 30 Mar
 2022 07:08:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 07:08:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto"
Date: Wed, 30 Mar 2022 15:08:11 +0800
Message-ID: <ffd704984e4e76741161d35ef127fde082d0add1.1648624018.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fad96b1a-efe7-4b9e-1cb9-08da121c0c26
X-MS-TrafficTypeDiagnostic: AM6PR04MB4488:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB44886F6CC52A9C6EBF7CA984F81F9@AM6PR04MB4488.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Op8zfR4oTEmbREqfUTYvlF7TnOnOILC2AHZYAyvPHI8B6S4IOFwKRuShszsLDn0rcAxI+PemXiRYjCOwHfEiTRDhBk5ZtPqdcwMdWi57yLfuIIVcP+2OglcGXRSLvKdurYbGrZ3B1pkJNw8EldxSUXRlT0Hdhy6Bs1jz2BFU0HSMIUWRhdgdoNIXbn0tr1jX7Xd0HbZ32w5sUFYU6f073NvAGHJWAtS7sAOQWoU3k+6TMfoeEJTiouKRZ0iHXUJb0jNJzAUdxE3HAnMdLRd6S9/fp346v/zXaHGXWUETUGNy9TyAbsKVDL3Gf5k7Ur7nSbjQV8J6g9sHnxqK2IO9kQpV4RMxJNLOrieg4ysw4sWFve/37BGmzwH18IDH3PLpEgx1578uE9m8Tg5tMPZszdDVdq/1N/Q99pjhT2taKREKnTirUTZ9bghqjIwLUY3/jNbHi1gdHSqbvLURoV5rcwYRdJ0GafyhAJ6yJuZYa3jYdxqXaOF17Yw34oB2J1d9JtNsiQJQwUKlNuSv85Ez9HBSBZtB5sxOyLExMUW47qR0BCAfpIe5iJyR+la46lMhgwoGQX7jzHhioFOIIXAB1amTCasXrvbux5U6tMtisY8qM+lPy2jWvm6u2IOoJvthG22BEuQ9ScwTnsjya0sTRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66556008)(44832011)(86362001)(66946007)(8936002)(36756003)(66476007)(5660300002)(508600001)(6486002)(8676002)(4326008)(83380400001)(6512007)(6506007)(54906003)(186003)(6916009)(2906002)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZjbtR2OEf5VwkmfDcxMEVf8k+9FHNUIvqn+eI4Vufi7JGJzQDrgECr42So8T?=
 =?us-ascii?Q?foo3p/+Nk4K7w7Tdn96DjcpYAxwKJv/XngXRNTRi0Di6enn6EyIyNldvueWj?=
 =?us-ascii?Q?aS5KUyJ+8BlA4EcvpQG+wT6qWAUFvlNT5nzy3e2dSV5qPug/nyvCzmVtNICG?=
 =?us-ascii?Q?8cR9lOY+Xdn9W1ETH4Ay7oinn28P7f/NZoOEWdPlrvemjYI4WqIwW3ebaxwg?=
 =?us-ascii?Q?RM/YLeLkE0s6+HAKlobgU50DBSWNHoObwOQwhOTl/ikeLRgt+wKU8uuXciw9?=
 =?us-ascii?Q?fe6H/pWjn1PacVYhlHQQ4/MNV8UOMAFv3Puk5v/vKnZGxvTZwmAz/plyrrCq?=
 =?us-ascii?Q?Ggv74Di2Q5IUgxrRjKTnrCTqegOckw1TlIP+EM+HsyvE+ReaRQSw4JkYrlpO?=
 =?us-ascii?Q?0WMy38zZC4t0sMa6VxEVG0WxtO4oypqatc9fITkAfurPw5xGdc93x10JJEP+?=
 =?us-ascii?Q?BEgerL92E4RJtkd4tUAdSIexgIxwbhxDrP5W1i5A8BV3TOHBZFZmqw8yhuKQ?=
 =?us-ascii?Q?1vXhUdxMb3R1kwacCE/h0RfFd3tr59nNxovaXO8XCHxo3DkUfckucskjEqxE?=
 =?us-ascii?Q?dMQR0BaC278p/A+6Z7stJkkjkRsBEJ19GhOORiCwh3pnu+gcU0LtpnasiN/t?=
 =?us-ascii?Q?v6eG6ahBJ3bkeZC0qrQyiJlbxXqGEEVsicwy2ALJpZc+lbVPNyKpMxKIzBMX?=
 =?us-ascii?Q?9RfBOj5wiODzOgxgqyU2lhi8b2P1g35GCEzuQN/c7KIo6mW7V9PY0Wql4ko0?=
 =?us-ascii?Q?WJQsN8Pt0hny/tzwPj9aUiL5pFwtlIl4L+16WuhotCiMpHvuCCaePKrNah+a?=
 =?us-ascii?Q?YcBqNlkD0h3NG5t51OsTHbZir2RN92X4op0QDSc6nXQQX0s6/VCgBr7zYlXn?=
 =?us-ascii?Q?yYZlhwJ93/RlGQWlbORqP4qHle+vhFdv69JLbVtC8oFX4fLOMbrSgHW71GYG?=
 =?us-ascii?Q?aaukAzjkk58nLaX9iVkGMnX5Xo7ZrUUm5AS//MwRmsLEGvW/gI6itZ0Ldn8z?=
 =?us-ascii?Q?fAx1gTqj/5/JzHc06/Wy35jbgJ/NeOLBlqYxWBwImJwggvqpEL9nT9fkFC17?=
 =?us-ascii?Q?Zn1XJiVH3YypCMR/ithU9MyM6C2nhIdMnS/lT2f9zue1wp0VKrFvA+jI7wQc?=
 =?us-ascii?Q?aciDC6UR2Ka9TKNu7Ir2rI/JIKn96drKaEDxCd4sUX7q8kC8NDSzp+v18w21?=
 =?us-ascii?Q?SJGMHUTpqSOKngUVNRqfJhegcxxBYBZOfSkQMbWfCshk9odYrsiYuFlvzQYi?=
 =?us-ascii?Q?yPgh7S+h2gbt2pw6h/o78U0vVLsHKJ5x/6hnacuWRXmpRiw3MyfooHzWNyiK?=
 =?us-ascii?Q?VCX/4cOIWvmm3wOsyl5cNgEvNOoBjD3LwDGX6e3ImNycv3RfMNDnuCmk3ss1?=
 =?us-ascii?Q?GdtQV5WD3VIdeotO0RoZ/2Xp70QQS2nrp+Q6jPkw7CzUxoQ0ONBY9L4Sfs+U?=
 =?us-ascii?Q?BdnTjkblG9msg6E28xQeBrHhK7riDCyv5+masGuV6avxtewjBHtlsZmzBDGq?=
 =?us-ascii?Q?88Q9rfim+RtZMC750tIYiK1UByuV96EEL5N123CR4MBllqydjK/g1N0lfpKI?=
 =?us-ascii?Q?33DqmS0b9Zm11xSK2OSlJy4la44AtQT9qA6r000ByYe8knRLzGacdFSEbd7J?=
 =?us-ascii?Q?nSJi2GHAcu8IJJtKQMLfVo0G5d1GP1PXSvcZuarHvkcVWQMDUbShetUM0TyH?=
 =?us-ascii?Q?rE4IP3mwl8bCui5A0SqKPbOLK8fLuKY4GJD5pUlZY3YJT1wKscZwdqnjW6MY?=
 =?us-ascii?Q?NrvYtz8ejkSGVFbQgp9s01TU2cYAOQRTbv1m4RlUWoCLcETY5VFkwDl1jQOJ?=
X-MS-Exchange-AntiSpam-MessageData-1: AHGZYiJ5Ff0jXpKQT5Hxt+iS3Bi9l7e7Pv0=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad96b1a-efe7-4b9e-1cb9-08da121c0c26
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 07:08:10.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0618YpZCE9DyMkRo4OgzL2BMFnWJhXaCOgU4HpX0NmLAn6QTcCBPE3lqWACE2WCT3P8seB0A0sgAEGSo+iymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4488

Fix the build breaks reported by kernel test robot:

[mptcp:export 32/40] ld.lld: error: undefined symbol: bpf_mptcp_sock_from_s=
ubflow
[mptcp:export 32/40] filter.c:undefined reference to `bpf_mptcp_sock_from_s=
ubflow'

- add defined(CONFIG_BPF_JIT) too.
- move bpf_mptcp_sock_from_subflow from bpf.h to mptcp.h.

base-commit: export/20220329T195411

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h | 9 ---------
 include/net/mptcp.h | 6 ++++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 117ae3f9451e..bdb5298735ce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2372,15 +2372,6 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
um bpf_access_type type,
 }
 #endif /* CONFIG_INET */
=20
-#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
-struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
-#else
-static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk)
-{
-	return NULL;
-}
-#endif /* defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL) */
-
 enum bpf_text_poke_type {
 	BPF_MOD_CALL,
 	BPF_MOD_JUMP,
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b1afd6f5cc4..877077b53200 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -284,4 +284,10 @@ static inline int mptcpv6_init(void) { return 0; }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
=20
+#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF=
_SYSCALL)
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
+#else
+static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *=
sk) { return NULL; }
+#endif
+
 #endif /* __NET_MPTCP_H */
--=20
2.34.1

