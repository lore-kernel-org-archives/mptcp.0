Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122415B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5d0FLqMutMpFI7/vESuqLwxQldK/SVmMtj+9v2VTSI=;
	b=NeqWNds4Gxr8ojMLn1MAjcWwLpV+qxcUf+C7eR94ABwXhYZGaZ+JPJajsOYyV7aaD5YJqm
	z9pfIGaYzRj2ohfA0DZLWMI59Kr2ORqKSPilLd7Hqww1OPw24yc5+GNNI+JADZ4O68Bcoq
	J0JJujgzPFh/FTLNs+KihkCs+9F8cKc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-yA-wzU3uM2KjlYmrvFqdlA-1; Wed, 11 May 2022 05:39:32 +0200
X-MC-Unique: yA-wzU3uM2KjlYmrvFqdlA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxJJ8kKZgGHEgAAv8CkqhiVYKM56O+LX/OkFi9ejvSf6VuG0ocywZNDL9HGtkQ9iBNOOFDTNFdadCytL1e4hDSz/TKcqdDuv05CtrZSOPw4L69g1rIZUEPUPxQM6jPak+ZMn/mI8r7Z6hfasCgQm2iGApbdoYV/EvA9qjS6gqJb93B5XNfqGZqgywgmRkrJQie//Inq6nyWoHlfW+LE7aImsOvec36vWgTZOOA+harN1rah17ZFbAURdQi5RflTu6GOev9ZNoPouvRNDfS7kUPOLDjyY8yhI83OJIojHTGO1A+FQmDPCE6ob9j5PHWzVNjtYiu+B2Hj3NHeJzDDwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8sJOoISg62R8pYWZ48eyTyTtIV4KhH5l5TWybcrjFY=;
 b=LOlHOycyeTke/GLYQXy9jZgL0T25MhMeKEWKf2xWU11l5wsPxjuHcYgz3QNLAzhvzS8o9qi9/xhsM6njEhZiQnNsHRVWZj1nk95TUpTpYpz77VvCbMKp7b/lZ2EDmP+iqROTOGu9ToxfRBvt2r4/qcafjnUnbkVLxcGLqWyAyedmjyxhYHggw7uf2d7K8Z4VuS8gYyhAHek52Qum5C0CaJmTRiPSNZdd7TP4XCgc/xw5Kqgw0uOub4zq3q9RNcB5bWFPVgJVQP0DmD/+V5YgCIeFOlDZ/zwWmsc7cneCUCaP+nsEvdT+PqguIaTGZktCmJrojS1FOEMuj+8FOkGzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:39:31 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:39:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 01/15] bpf: expose is_mptcp flag to bpf_tcp_sock
Date: Wed, 11 May 2022 11:39:02 +0800
Message-ID: <5a78577aee37847267b1f4d458de008604a17bda.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4230b3b3-53ab-4186-78d5-08da32ffdba6
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156BC8AFDF76184FEBBDA88F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ut26f0UVzz+ZED7NOxTbpWsGNt0TewEIQ5npbKfto/51C6MXYYdFS3h4CmqP6cv3IV17t+GfJQPoqUGrSRuOAXRi7ZCtrp2CS4SGbO31HHwBt7QjdxHfaPOKp/FJHqonWCDSlCiDNB7S7oG5Vvps4hLg6hqy8fes2kczhXti7wKRkJyw8G4/sTiETGM4V5W37AsTWMzDDk45GlOGgtVI2gcz33olXPz39YwXnGfq/dQT+k22/rzFOVpFSMe5EnWWjIehQu78fnpr5zh5pbewOJGdLclV70tjdVGflF1ftlsKcpFTTO2Y0vXyYjFeViq/3o6o2ymUz2Yxk21d8J4M6du0jmVnGF+lNCwcvWC3M+buBq2fqMipKg+EyvPmagvDa+nIBSuOThVh6JLRDW4DUjPF1aONMzmbq4lmaTPD1EwweK7rIZsCtR8N6MAV5uSyuFD2D5tHXQWxVP/y4JG6deZNCKk5r+IPErigIx48KfoFq9mWX1UMreHpX0112NzZQjL5IMCyQXvDA3b7ic4X9Mh3X3otdPgYQMpMB7Oo1ZqL+4eHEiRbEym7gBW/ggBkYFVedkiyJez/TUV20mZcB+TLESbHze94q/rI0lKFxcKdkv4WoA4ZKEc+Xi4fuOEeRoWOKtFwrsRQCyh/a2FF0OfEC7WtcWLcUvEpqGn+sihfYCjTqpz3sKJCVoJ5T/W0C+cBal0MwCqCwjoKezrha4p+e+EaKfdyZ0CLvpTSdSD9aiSvXeiP59nnSV5tN+wGIn99b5+Hk8pEi0PtQAluQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2YyxkWNHilywl1OoShAnSZ+cc6qkCuZWPrR8ctAvlTLXoM513wWaA7jdrK3I?=
 =?us-ascii?Q?9i+oW2s6sYKrWTVVerUzJkEgrLQXfg+5LWvRt3Rs743ED7nXEf4ZB7b9mK7L?=
 =?us-ascii?Q?A54j6pKhQcWwM4mAe4cPuhyP7a0bZEVFf2PvdJeIZO1rzyLKz8w3ckloaLey?=
 =?us-ascii?Q?YNkpaVxKkKjYzyEjj1/LBN3DVFUrUz9qGi5HP7kh81BiDBriPE7IgMK3NGsv?=
 =?us-ascii?Q?zwaGYoKx211SlppxPthIvBE0TKxg3RsCxqJws2A61QaFMQm2hOytIBzpOpbT?=
 =?us-ascii?Q?QgFyM7/FuL0EGVkN9avSHakk1MAJIb9hiQc/MkNc6qHg1u96SeDawDcpnVaB?=
 =?us-ascii?Q?XARXZpwZmZnN2w0s9UMoIifOi4OhILWXKEezmHrGYs5/up+9pav9HRPm5bVe?=
 =?us-ascii?Q?VLZSu5qWTzK9e4UEixT9+VtsrF6GD5mpANzay8Ac5/YCnQN1ExBHikrJ7mwm?=
 =?us-ascii?Q?BFHwJRPla5xEBZGLr0A3G/KKR1g59Qb1UqqoGiBr96B3ZGLU3oMapPphEzcV?=
 =?us-ascii?Q?4PKsPQUy/5dWi4yrLmTLu8huDoL/wSwCV1uIdJvPGDtINmevEmtdP/IGvE0C?=
 =?us-ascii?Q?o8gsoJhSkBVzJRyqnoi7GOzw9pWiHFRxWcNSnx9QQ8OiYAGyZ9C/qi56SMU2?=
 =?us-ascii?Q?L/pUVxx0AJNhZZu5dx1MgXHK2PndyatKj2rz9V4brAa76+osxcpCDpengGvK?=
 =?us-ascii?Q?fT6erh7x8nw2+NjlqowvDfuwX579a0Q5XY9KiV2115UWAWzrkEqN0AE5f3IS?=
 =?us-ascii?Q?1Z3lHhSZklTZW8p74UfB9fqbrygWZ12b0YLpVu1f5KpRIF0B+5fTdbuAmQ+S?=
 =?us-ascii?Q?zJA7SYbCICWwi7ayF/fX7kkkgZDMk+U4yazDzfTLartYb4HXk9OGJKK+epeV?=
 =?us-ascii?Q?5/Ndpi764j+kP25/sX67PT771qYlZC54qTmRU76vgeRlq6eOoYMYmt75ddcx?=
 =?us-ascii?Q?+xqxg6m2XaQu1EodFReQqi1gbLTPXZhwmYPoF1dP/s8E01nLOtzCGATPELwr?=
 =?us-ascii?Q?SI77tt84/j5AbkZP/8DdVNaknMH2MwlBLhOmBvRWOZeUfkfxuxixcy8ppUNk?=
 =?us-ascii?Q?aW1pX3fOX7aJAeha3W1WSbFO4ghnPglxrExYnQGPIODkUaiJH8lxGE5FQoro?=
 =?us-ascii?Q?FQDY7X/x7E4VhiltMn+r8yaenDmgGvpmJe+4mZ/2Jp4l1UrCRfZgO09YABBe?=
 =?us-ascii?Q?ph73L0F9r9YH8r4bxPYMhYitLcA3h4d1fmdCNwuu1dXpgbJvjr1xBTz7p5Wd?=
 =?us-ascii?Q?wXsZRlzR2nIJQNVWzOHkPXPFlbGPeP5bEGI69uK5/2hYmhHjVhpWGVYcSIj+?=
 =?us-ascii?Q?6AZ6uR18clMba3KBd3ciSauXTDUjZq64r219pa/5CcTaPch0CQ73W7gYPYLk?=
 =?us-ascii?Q?3ECIxbGPhTbCC/hbwfaq9QhCkhqIUlifpzc/MTdHaDBGbfYOgCyWQ7RA9FlL?=
 =?us-ascii?Q?hXj60epTU6ucW+DaqZNm1HY4ho2kbGwx15VjYSZV7Z5FfoPiWqssEzfRn+56?=
 =?us-ascii?Q?pQHngZ2HnUC5LOj5R0xQLbXNNqc26qiawtrY0+X4oyF9TrwzXFjgmGhMKWvc?=
 =?us-ascii?Q?0pl3QXSkYxydVgZ9GtOf0s3mVtLQvR5qDc1TmS//79/QaGsHiSVJ2ff490xL?=
 =?us-ascii?Q?GAqmqfwa6vlh++m/x+ZwitE+psEVM5grp+B7h8xt3HIsQR623DuS+cPMIdZs?=
 =?us-ascii?Q?P1Olpe0H4D2aKPqf3t3DnQTJNATbAEX6qDwEdP/LAOwvtlah1/ORQveORVRu?=
 =?us-ascii?Q?XR/CWC0TbHmGSc8vH+Z8A/wD21ljZCw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4230b3b3-53ab-4186-78d5-08da32ffdba6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:39:31.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TjGO0nSvWei+/Iuo+21zXadH7WKmuRyAg9yUTaCuYidxNngusWutIcZGjnEzzoW+AiC+Z0qKnpdQavSyDSfIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

From: Nicolas Rybowski <nicolas.rybowski@tessares.net>

is_mptcp is a field from struct tcp_sock used to indicate that the
current tcp_sock is part of the MPTCP protocol.

In this protocol, a first socket (mptcp_sock) is created with
sk_protocol set to IPPROTO_MPTCP (=3D262) for control purpose but it
isn't directly on the wire. This is the role of the subflow (kernel)
sockets which are classical tcp_sock with sk_protocol set to
IPPROTO_TCP. The only way to differentiate such sockets from plain TCP
sockets is the is_mptcp field from tcp_sock.

Such an exposure in BPF is thus required to be able to differentiate
plain TCP sockets from MPTCP subflow sockets in BPF_PROG_TYPE_SOCK_OPS
programs.

The choice has been made to silently pass the case when CONFIG_MPTCP is
unset by defaulting is_mptcp to 0 in order to make BPF independent of
the MPTCP configuration. Another solution is to make the verifier fail
in 'bpf_tcp_sock_is_valid_ctx_access' but this will add an additional
'#ifdef CONFIG_MPTCP' in the BPF code and a same injected BPF program
will not run if MPTCP is not set.

An example use-case is provided in
https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples

Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 include/uapi/linux/bpf.h       | 1 +
 net/core/filter.c              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 444fe6f1cf35..7043f3641534 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5706,6 +5706,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
=20
 struct bpf_sock_tuple {
diff --git a/net/core/filter.c b/net/core/filter.c
index b741b9f7e6a9..b474e5bd1458 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6754,7 +6754,7 @@ bool bpf_tcp_sock_is_valid_access(int off, int size, =
enum bpf_access_type type,
 				  struct bpf_insn_access_aux *info)
 {
 	if (off < 0 || off >=3D offsetofend(struct bpf_tcp_sock,
-					  icsk_retransmits))
+					  is_mptcp))
 		return false;
=20
 	if (off % size !=3D 0)
@@ -6888,6 +6888,13 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_=
type type,
 	case offsetof(struct bpf_tcp_sock, icsk_retransmits):
 		BPF_INET_SOCK_GET_COMMON(icsk_retransmits);
 		break;
+	case offsetof(struct bpf_tcp_sock, is_mptcp):
+#ifdef CONFIG_MPTCP
+		BPF_TCP_SOCK_GET_COMMON(is_mptcp);
+#else
+		*insn++ =3D BPF_MOV32_IMM(si->dst_reg, 0);
+#endif
+		break;
 	}
=20
 	return insn - insn_buf;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index 444fe6f1cf35..7043f3641534 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5706,6 +5706,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
=20
 struct bpf_sock_tuple {
--=20
2.34.1

