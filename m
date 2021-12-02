Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1FE68
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638430222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4MxoOC5Biz5Za6BV8UxCUnH3+FTWfdIbZ6m0rxDZZ4=;
	b=Zlf31Ab6PXVWLzbM2IEBYn4OhJ5yYffnjIorN7rWgE4isgCQ3kJ2WgHDVtq3wEI4PfQXpl
	/uUqf4jjAEvvaDUSkSzFoLui5nb0QmBBfDFX25IAvfq5mGQ7xLiJFlVlyTU6Tj1DKzHNJb
	lVRGRWtksmwxEOBKzJ5Nzqmdc72iZdg=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-QGEfQV2SOmuFuUbcWsKZcQ-1; Thu, 02 Dec 2021 08:30:21 +0100
X-MC-Unique: QGEfQV2SOmuFuUbcWsKZcQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okj9jCYRe5FLaQaMDSzxPNYHYTEKdmXGjnohgGjEdpYhn48KVmnhLTIJkWDIBhGMtZHq0BvX5ISyWldchwa8cHfDlpLazhUcgh3GCzM8hZhIuZZOlVbW6R2XjBtTJ+E9twYm96wZvIpJeo6X5qMBbYb7tJWmGzd1lBAerre7rAYdol6Sxbc5ZJkzUNzyzfAaVrWV+G6loPRXCM62wdtjsI2SqcbKABoGIGr4XmibBJa3LqZoC7x3bXGnKzCPxml5/iAMKSfRJYPe7nOHnbIs8BCH43EEzl0Uq0HbVPkYCa7O6gX0oE/oIHE1sVJinI6Jq0u7PhwalmYddBLQXLrk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRucKG0R3GAOFkbHiYzrvE+h/HItKmZTGQ7/YBzi4Hg=;
 b=hsf0dwx3vI18ssYdYXyubLYsNF7SalNv9yEeXhlcOYMgXjOlgZZur91Z+NqIgywVfFimIoiHB6bpP7K3yFrOlwPYefI9/kUZw7D+ZHVb9sohINj39B8qxQvBTnAERJtw7+5NM931mu/rQk6faOh3he8PYOS9gR+8+hOjgWiHK6VNpzxRh6iKAO5rXoHzFzW4bUOTRTGGPJ98397MCodEEJu0HKmqObSJivgqUNIwpqs/5RCuNUJPVTuf2FZc5v1BB3T1AavWbrzfBXJcL5D4YYyj6zSS6wO3KjmGm5VC9g8w+hODgaUWM0brFL44zLMF8yEVQDSebxacQBzPAflW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2698.eurprd04.prod.outlook.com (2603:10a6:3:dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 07:30:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 07:30:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 1/2] Squash to "mptcp: implement fastclose xmit path"
Date: Thu,  2 Dec 2021 15:29:59 +0800
Message-ID: <41e52e743ee397180dab0ad4a980e2b8d532bfe2.1638429740.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638429740.git.geliang.tang@suse.com>
References: <cover.1638429740.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by SG2PR02CA0009.apcprd02.prod.outlook.com (2603:1096:3:17::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 2 Dec 2021 07:30:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1396cc26-5ec7-4a05-b36a-08d9b565989b
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2698:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB26982D8198E0322D30E5664CF8699@HE1PR0402MB2698.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dgj6DdXm5WW8o6ixyn8IaxhNvPpLCMFd7zR+4s/QeDZpZHkPPYRIZTCPoQWE89RKn/C749AS5XVlwG3bTF99tBgH+AkqhvaIikKUmKJd3WyMOEUnAUHF66Oe6I1kRtYJJWI/VuvmTmpkNiuBoxuxAo/NBXHT6DiGhHkSzW7dk2q1s2wKfojwnr/cs/NMYDuguqxIlCbZ8pwPiEBf65xiSv/a3XmhKCuIS0hQVhbNprd2AzrVfbnz2yLerFyzpf3J3sKUWByIsOBkbHOGGs9bg2kyJ9Mred7cpJLuFpY5FpqS7I7OIzOCTUNXXw9CVF4v5FHj/TaWkP0btcUDysXgy+TLkUcXuTP/miSA2keL4QSJE7QLj3WAnAtrojD16h/6oJK/vnyA6VGeeFEG3flQvs2uDsIsUV/Zc28V38rUPhJ0UgsiZ54SZqXSKcfrLGJZvXh0o2nYuhnuiPJnTMbceiA/ao2wHsDr/wLinFc/cNgcTndxPuNbCnlTAXfFDBiFsGquT7tjVZ+SPXAbcoavxxGTlELiqruxdeNkWRBy9TRZt07TvyXgZdneofI0LsIhbC8v/Nf5/TuGW/H9qrsxhBE8ol/W0griXwGvJjcW+ZsUhoQmRV+HBKD4iqT5jFnIQ8X7ZKsU1LyITWx+j+UhWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(66476007)(44832011)(66556008)(6666004)(86362001)(54906003)(2906002)(316002)(66946007)(508600001)(5660300002)(36756003)(55236004)(6496006)(6916009)(186003)(8676002)(6486002)(83380400001)(26005)(38100700002)(2616005)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUa8lkW5kcv7ttydExu5M59L6Ow5OoWibx8FH3ael/wvQJRCQn3Yxm1EC+CS?=
 =?us-ascii?Q?Gygml7j/AkJ399M1AOnQoyaWbrammR678gKbXs7R4nq8dif0Uk1Fqpr8BVGY?=
 =?us-ascii?Q?qlLvZ4Wm7m3s0xeq/Vw/Uj3vrc/9iUNWOWyQC3PwXeUAIXChP3L7yfHF8cjB?=
 =?us-ascii?Q?VwmlHEQs8ntxVI3mGc9XWP0h+gAXU5CymRdMyzxK8poyGIVaxiX1pR8pzHb6?=
 =?us-ascii?Q?WTyvmQC2Gx3pLVB8+yRQkFoiPH44KA5K/ekwMuBgGBixavU0TYnXbyN+ym59?=
 =?us-ascii?Q?pORgxMmwxOin04at+i4EAycVqljExEh5wbiQoji3orxfSo+XuCMJkN7q2ee5?=
 =?us-ascii?Q?RtXeqFpfFY04reCdo6Kgic1OvNCyua+YIP4QmM2BZSXzAq3GKyMxMDX4Aibd?=
 =?us-ascii?Q?qlgPHuHvIjgGU+dnKEbNiSdAmir3tOZpd6OT3fh34ciuTUKTRfLuDS4e7V+1?=
 =?us-ascii?Q?3dhhi6x3cXen+qA5PfsOlJY2L1TxTPKW44KCwa2IqnjbaK2DNntGUwzKzTrZ?=
 =?us-ascii?Q?ZKXDYVS219ILlEvj1yux3fWmBTiP28im0u3JIA61+DYq6LMVQX2EdaD+5ozn?=
 =?us-ascii?Q?0w5sGN5Q915geGhiVSEMh1Vq8ivIeKVxKZ9nRCar+EpMTIddwAaeLiZOWYZ+?=
 =?us-ascii?Q?swwKDNZz897qNHDTaRAmuNcGp4IMmlF/qaVSTXx/0BbPFZefnDMhqoTQwOtl?=
 =?us-ascii?Q?0gu/Nl+3FCK8GgWdSzLIE6FbcumAVRecQZn9eOJPXJQ5m69D5l4FHd3A9U8K?=
 =?us-ascii?Q?YCsZgf0NgaEpm3Fe8sr1DKPi1w9neNnADjFCFJelg81Xuu26SOemt48LHbMR?=
 =?us-ascii?Q?UwF0HUhMUYkdRxN1uc6eJo6+irrtztrunqjQIcC/74J9UpUOVIVWYWqeLFaD?=
 =?us-ascii?Q?1LxzacMVWE3K9/Mk5maFCIsA3ZIywO+k0Z+RT/avXmWLpkpoBfysMDfg5uEG?=
 =?us-ascii?Q?dHw0a+CTsE0XsIdOeyjGhqfKXVOY5mZ58WmEhAuKq1gRFPsAIFVgsYnQXsq8?=
 =?us-ascii?Q?63PmWTte1blvETnwgtxkzLT2ilhsG42zFF/MBoNsgAkwZ/2+Ap6mjMAtPDUH?=
 =?us-ascii?Q?3+zY0PQLTl6PJ3a6Dz+/GvCR8MtWoqDKwzTIn8KcTMIX1dittbiRqzgEkJYq?=
 =?us-ascii?Q?ORZulR6l0WAfH06v2qEunh8XDX56YEuJHfJWFTxv/Y++vuVErU/IzF+rcVbV?=
 =?us-ascii?Q?IIL5Ol+Xxvl3/ouf1ANAOn494r2kZL4EnFB2Ae99SK8oi1NXLj7PWlp0TLHI?=
 =?us-ascii?Q?ZhnaIGW3njd2RurfRls0WZCVy4gc8dYbW9nTRVek7WItUZiP5X5jVbEQNzsZ?=
 =?us-ascii?Q?FdeiHvGnqHUyMAJePg7FJcmrsWiOSexECOk9X9n/zzilNk6wt15bekwZ9KuM?=
 =?us-ascii?Q?88WiuVbszRpOPBKEEDoks0L8tKY2QOQQe9CBrecfkVdReA/k/Db5l+gXMP2J?=
 =?us-ascii?Q?zgav2siX8TREO5Z754dWcWWlUGgXzyZub5KIpWJrw4lcaeJm+kbno5s3tz8h?=
 =?us-ascii?Q?2/LsKvFLyaFVNy/154jyaQo5zEzZp9nTOOeG5uT65LRIQs/XnWSbcryL5kkw?=
 =?us-ascii?Q?KDTsYCk8MCVj9S6mb9cnwwKqdJMu56f0wJyOPfXwQ1kWbn9uVFdVbuohJSmv?=
 =?us-ascii?Q?GTOHiQmgesNECZp0aqpce7w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1396cc26-5ec7-4a05-b36a-08d9b565989b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 07:30:20.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyqW/EmVNfCFzCi1KOKmvADFRi+j0Km5jyc3CpFQkvJYbKsauPNPr/scn5WbESAHdPdxzXp2KvjvXAuO+2v/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2698

MP_FAIL could be sent with MP_RST at the same time, fix this in
mptcp_established_options().

MP_RST could be sent with FASTCLOSE at the same time, fix this in
mptcp_write_options().

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..73242304ada5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct=
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
+		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
 		}
@@ -1257,6 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mp=
ext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
+	/* MP_FAIL is mutually exclusive with others except RST and DSS */
 	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
 		const struct sock *ssk =3D (const struct sock *)tp;
 		struct mptcp_subflow_context *subflow;
@@ -1271,7 +1276,16 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 		ptr +=3D 2;
 	}
=20
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
+	/* RST is mutually exclusive with others except MP_FAIL and FASTCLOSE */
+	if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_RST,
+				      TCPOLEN_MPTCP_RST,
+				      opts->reset_transient,
+				      opts->reset_reason);
+		return;
+	}
+
+	/* DSS, MPC, MPJ, ADD_ADDR and FASTCLOSE are mutually exclusive,
 	 * see mptcp_established_options*()
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
@@ -1458,15 +1472,8 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 				ptr +=3D 1;
 			}
 		}
-	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
-		/* RST is mutually exclusive with everything else */
-		*ptr++ =3D mptcp_option(MPTCPOPT_RST,
-				      TCPOLEN_MPTCP_RST,
-				      opts->reset_transient,
-				      opts->reset_reason);
-		return;
 	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
-		/* FASTCLOSE is mutually exclusive with everything else */
+		/* FASTCLOSE is mutually exclusive with others except RST */
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FASTCLOSE,
 				      TCPOLEN_MPTCP_FASTCLOSE,
 				      0, 0);
--=20
2.31.1

