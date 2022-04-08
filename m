Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE142564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgXg3vVnhLMPBszWHvmtMEVAZ/zoCfKNiCVdsEiKF5M=;
	b=LqO5bAuJ0mJ1j3BIaN3pHb4gXbtVOuG1iw2Y6V1X/uoZNBsYjNIb/G1DuSvjIpy2ZQZxHC
	+iu+0fua6Mml+W7I0X8VmZnPpV4SIK83Ey4+Dgypub/fu9rnVe+St1gAKgT4XINw4TZRzQ
	Bwo7cguDx8LQaKVWjF4KMxn7D3QD/0M=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-Gt15iZ19P2iPtSimsMtqVg-1; Fri, 08 Apr 2022 17:42:53 +0200
X-MC-Unique: Gt15iZ19P2iPtSimsMtqVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy78SMIY+JppYU4kkrZHu+UY6L0SanGHxyKO6NBgZrkLXzV9KCoQP9BoBZcz9S0UNRcp0LEWQNkOsltbXcRl/c60UmiuEvyfoUzjR0bpejo18dEcCiH46V47oyLvTAGcLVEgq8vM53epb6jBlig+8x5qitTPWucgrUYdNWHLwuTBRuDOffNdyYcguS99WvPEmTmTyCe3X3oomnBLY/TpuGXw3swzgfl7roQIqZpM9wbO/zW7EALdfuVESnhX4jRsAsTFDHsLperI7Sk8B1yF2mNe2m1cSSyb8LSDxxGMGAaeCVVgrkshw70sP9j2Q5HgXwWtVKHxLTPO9u7UvFKzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXzdaEnG0SKTDSALrktJl0PzBD4XzXODO8fD/vWWNxE=;
 b=CW5ddjuiEmMi2sl6gBBOUjeex7XEvSOBh95Qr8Qi+U/DKhzcWsBICACERr8zyhtSUdbMwmQBsshFesSxKih//weyrRMqeUWlf8sq6ezAP5JzFFwamEMZBu/4Ry1TZxU58pPWK4CnY6RPNBlxJVlsjbdxxDpUnQTWhCifacI0cgMFTkvXo6gFMmMh74sMSOQVU2RdE/jQ4qdU2qpE47Vwh5BHVz3Yhj6g8DdxUU+SqkDWtxdZgMZ/rnPeyYDW4yNbxaa9Epcs7SmNHY9Wtd61IDGVHj4JzbvnVmwv1ftUuah5UhZ8PuoordcN6dNyQEvgB8W/bXCcF1Q7jb/UwAFNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB3957.eurprd04.prod.outlook.com (2603:10a6:209:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 8 Apr
 2022 15:42:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:42:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/4] mptcp: add bpf get_subflows helper
Date: Fri,  8 Apr 2022 23:42:33 +0800
Message-ID: <016936c2bcc0fad9dbdb2d1372d027d99e78215a.1649432434.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432434.git.geliang.tang@suse.com>
References: <cover.1649432434.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:404:a::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd6bc05-6e6d-49da-4286-08da19766bf2
X-MS-TrafficTypeDiagnostic: AM6PR04MB3957:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB39570286951F88E43B43489EF8E99@AM6PR04MB3957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H9cyFCsbi8ri64LP0r4boIRIOASBn0GCY5AFt16BNMGRA//0x76H6Zd3ldZ3p81JZ72bB1/liK0tSxySQawQdLnyV55GyEg4wiXNSUWu9yjpIjZ5YpkBYK0YQAsjTe1niMZqBSlaGGWxrEI+nA+rcSFG3XoIx5f2d68IJx5xvxZ7VpgWXYMJy5Wr5ytWD0DRr2/wJLXM9Tcpn6lrkwbT55W3VvCNs0wyYYFlPcwMU94Qb6TPIvZeHQ4UyTYe0mfNM9CeiCA6w/r0HONZbxm96kBWcJHHobwJ/m8//VLBebVl0yVyRWurhIEUsPlBBg802A7XOhH7RFc1Xa2Hnpi8KSUKC6O56GbvZCByClm7ZMn8JdscktWMZAh9QI8BxA90nIv7mfhMrOKsotBKZ3yyVRgPkcnKUo/eRQlJrRsCVLRK2QQjKzMJNmis6H1W4pjposyC6i6eUdtm6roKKW04ICHkbsPm+bLuflmE5OBD3FU1li7R7hV9uBN6ye2vPRin9CbGg24wUA5HJIIKPXEEv6M2bBNtmwXmyd6BYVPLLhQLg+unkhiRtmAxr8eBdfeBh4RFV9bYW8w4lzxzH+OIbQDLwG2rr7sGaDZBydcdioViIqcg3/dJxvKwcyOyeCBmnsgykWCMMZP78LJe1BqqsxH5U7OzB8ed1akrkxA2LH+ZMAbuDeNr7oOOpCHHChAQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(36756003)(26005)(6512007)(66946007)(316002)(8676002)(4326008)(83380400001)(186003)(6666004)(2616005)(5660300002)(6506007)(44832011)(508600001)(66476007)(2906002)(86362001)(107886003)(66556008)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Opai3cNbDKPZZ1CtYGlaRXNWsJgDY7kQfGVEim8uwM3ilwjdAXPLs28Ja7c7?=
 =?us-ascii?Q?AebrnnxiJkb7F9gRFty1mMAYQqcigYnvD0z9BR5iIDCTlpefTMWs4edyTJRc?=
 =?us-ascii?Q?Aj+Tvd5XN66gOK/Tka4TT6x/2MrbfNC1KNdlZO1I3iT5V1SUU6QyKs6IZUq2?=
 =?us-ascii?Q?NGlrCEHsAygf66L3v2nllGEPYAH504sXAnWUTGHAj4e1AxrmirYOhMEiNJWw?=
 =?us-ascii?Q?zjoqQqxfRBptWRshZccAZH4VMf/36suQZtr1+wNfHcarkbro3LzFi1RdVuda?=
 =?us-ascii?Q?+KMfz5DfTFqOn0OYuvsnrQIvNT0bEqralD48ti/OScKgudXxKTv+NVoW1skw?=
 =?us-ascii?Q?iyF5yD1OumHk75Ms3PNc6TBcCB7fe+S3XHUnf+1BRvqAkMOl2asw5n9cl3fq?=
 =?us-ascii?Q?k3H5vN2XZM02h0ehLfpshkpWV50ePohcIkAYHXRcopi+KI7RfZ3ddrknMWFl?=
 =?us-ascii?Q?v7zS7y4Ry06kMHyH6onORAgKRkUC8gdeQ9R2LWNBhLTH9yvbeypAf0MAyJGY?=
 =?us-ascii?Q?ot/m5q7TP8m718sDZJAaMJOv7reZ1+DynlZv6nfYXSI4gpTInidLDkyuJUlP?=
 =?us-ascii?Q?Cb/rhc4tOq9xL+a3Xde2YzO1zSBE/s7AeI4pjCs+2G9RXezuFVrCqXE/wgII?=
 =?us-ascii?Q?7Dd7JkxKL8uJTQBSNnz1XOD6Qw9HfEKSvVLALUm+8mgX+Im4IiKPrqli3+0f?=
 =?us-ascii?Q?35JKmN59xkpLMFy6g0JLdNlq+v4yG8QhyTybhPtUT/yG4Pm6C8G3wrj+raLI?=
 =?us-ascii?Q?/EI24+jCnvpdZFRftGcHi51sjnETLDonKqQ+1s9cCiiOOP9hNyWpwFG14hvB?=
 =?us-ascii?Q?ZpUL3SRiYy454+xsn9cUkhtEJW5bcJ/b53/FFLyw83I0r7M2K1K9pB89ms14?=
 =?us-ascii?Q?ME4G6UFB8DaCDwro9w66otXnOIhd3ZyRrM9Uhuqs0I/pKaiU9RNfQukUlFy9?=
 =?us-ascii?Q?qK4QneuN4b23X+Zgg7AK5EtxXs4q3SBKLs9V6HahwXfMdYMF8u9alcb5elf7?=
 =?us-ascii?Q?RvBlsWXCri0rdj8xnzrFVifIhpExfPTfED49U05zkltWOuIFiYF8DwMLRfEt?=
 =?us-ascii?Q?duXMitm8U6r+ZQd2VtE3U8HTrbyTkTmtnyGn1FBchTMl4r3q8YhOKY98VmUf?=
 =?us-ascii?Q?sC2hFJjGL/B68dEFx9welNOb8HlMStgZy1FFgmmhI3NhAeWK0oLFyxRbN6pg?=
 =?us-ascii?Q?TDP8PliAHZWWRluRH8nlLctSXH20RKnl4FIl+XU3kBWQjCfhWjMUBmRQ16f9?=
 =?us-ascii?Q?8AiW/pD1LPKCjBAk/6kQ1EhwUrkPbvl+DPre+v5EgLDHAn1T3GG1teyY6qwW?=
 =?us-ascii?Q?PeIwKTomzTuCC2z9ji1MCt7G0Ky54Zcn0js731+frcOApRDe/DzLFbbdqOvB?=
 =?us-ascii?Q?wXEE8X3Rgnla/DJTJxdm44tOUuTYFsG4SGF4mfb2JZ4gxVmh3gKfRbBmAB2J?=
 =?us-ascii?Q?y/7CQ6Dc5+JFK9Gj3ZvlYJtbsL2fLEBnsmU0Rl91RLTBTlHoFFejpU++bARQ?=
 =?us-ascii?Q?FT90brzkR4dUaxqFtqpP3YpnvkhakfzkOHwLCpPcIV96yJi0EANwVJF5AjAL?=
 =?us-ascii?Q?rERe3oQxP+CUBQS9IyIVhRfq0X2WrreVfMWBdo4N5hcA6/BMoblvZia8zMlZ?=
 =?us-ascii?Q?CHQVq9Ks4U5kGohcc3xiJCVhiZ/X6CIQd77I5KfrUYTSE+RsULXLH82T9SXk?=
 =?us-ascii?Q?B0cyoW6qAenTFJt4lRO74qXZSmazDryu4ZynQG+nKodtSIkzDtkUvSDO9d7u?=
 =?us-ascii?Q?YlgSpkrVzjbgGOMv9bQvrffK7gvgspE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd6bc05-6e6d-49da-4286-08da19766bf2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:42:43.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LR8dXgyrmTPeLA7FMUo3cYcpo6chsn8GjEObIGc1AX+rvK+7mK9vi8XhwzRV6bQ87BONcl36ZQvK/bynvxXkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3957

This patch implements a new helper bpf_mptcp_get_subflows() to get all the
subflows of the given mptcp_sock, it returns the number of suflows. Add
a new member subflows in struct mptcp_sock as a pointers array of all the
subflows.

Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 28 ++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index bd3c50b07ab2..7f8782dbfa6d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -157,6 +157,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.name		=3D "mptcp_sched_ops",
 };
=20
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, bpf_mptcp_get_subflows)
+BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set =3D {
+	.owner		=3D THIS_MODULE,
+	.check_set	=3D &bpf_mptcp_sched_kfunc_ids,
+};
+
+static int __init bpf_mptcp_sched_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_mptcp_sched_kfunc_set);
+}
+late_initcall(bpf_mptcp_sched_kfunc_init);
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
@@ -165,3 +181,15 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct =
sock *sk)
 	return NULL;
 }
 EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
+
+u8 bpf_mptcp_get_subflows(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	u8 nr =3D 0;
+
+	mptcp_for_each_subflow(msk, subflow)
+		msk->subflows[nr++] =3D subflow;
+
+	return nr;
+}
+EXPORT_SYMBOL(bpf_mptcp_get_subflows);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a58c5c84e72b..7c5bb8fb9e77 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -238,6 +238,8 @@ struct mptcp_data_frag {
 	struct page *page;
 };
=20
+#define MPTCP_SUBFLOWS_MAX	8
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -298,6 +300,7 @@ struct mptcp_sock {
=20
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
 };
=20
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
--=20
2.34.1

