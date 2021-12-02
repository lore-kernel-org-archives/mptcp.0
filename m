Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798629CA
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 04:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638419174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzvhBQ5das5/bURvz76ZuQaBYn/Wi/GcDzMQHm6VZEw=;
	b=MGtGh02+ttDO9OCG7NSThfqWpgfRz1sxNnwt+vaROo/vumA7lWxI4wkF2pen8ojgHHut2b
	IudxMl6+ttLG8K7jKigXM+kYmvGHFdTMoRCGri79B22YlC7/gQezvgP43kY8ZRNcMvdzft
	drjBKh0/mBpyNf/52jfdVmP2mWqLHs8=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-L-QeQ_gpPLSO8Z-oHBbmTQ-1; Thu, 02 Dec 2021 05:26:13 +0100
X-MC-Unique: L-QeQ_gpPLSO8Z-oHBbmTQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/4+wIClt+M9JJjIyLYpsOTZInQ1K8ERKBos8FJSgTjEqn9GX7piBaaL9KFxpoSuaWMA4u/r5LlYu+LOGjrvUQNp4h4fnljWu+84V1hcc7Me+OJJkoLmiWIAEzKty3468w03GcFIITsDGHhfc/hI3+XYj4J1kS143+DRFO/L3v755XjeCh0gvglmUHL2h3LcRsx8oFhY6FwZWdsvgi5hv8dkF1ry/ERGwzrAkSMbujw0jSmvw1WdAKA2OBJ9DpgTRjGvekZyi2mtzK833KWxwAKlQixFPfPAP466tuifJKk+HJ8G8G7n2x001+KRQUsR5cKLjxQViTtUt3rC84zdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOaylXriL2vWUuiWdlRYT6f4mXOMw799eThKn6h1Sjw=;
 b=YvWNfTaTxzcMoU4KiO3VTYtQmeBtQbuPVtlfsE0sb+MFqFEZJ7vDrmTSHwzQ/+m6eexyMAaaStJOCn4S5c+aqdQGmcJmJYkrZDJM4A8I82boSCTW4LUtPHJi9hWWBMKivdj12VDY2PEX663B8i9Upx4k4ytyxTmAFXw7VMWR0HuwqmKVnKEHxt99hhPE0AYx1OdXHYkP7jyJa3mi9TTqlSDBYddjOvbUMKFQXq+rcJgjDeo5T4B8zj0zvE7FX+YUtjK9rMuDPuPW8Hxi1iCQ/P+wUalbeDRFfrF1/CoXIvSFbLbZJkMhfOZBZWV4up6u4y6SPKOLmvfPjrOzwDTpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3403.eurprd04.prod.outlook.com (2603:10a6:7:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 04:26:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 04:26:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/2] Squash to "mptcp: implement fastclose xmit path"
Date: Thu,  2 Dec 2021 12:25:48 +0800
Message-ID: <4ff5bdca4887d54bb60f3cf491357f5b832c314c.1638418477.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638418477.git.geliang.tang@suse.com>
References: <cover.1638418477.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Thu, 2 Dec 2021 04:26:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c7d5302-fa81-4c6c-fa17-08d9b54bdea7
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3403:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34033DCEB162C152B1501900F8699@HE1PR0402MB3403.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1G2P2TVAfuyQCfGPi3lywQ9SGGpBeAh7TYbyBiciFVC0xRBpbaHsAtacFFdJTv+aoRcU+oAE7OIPjG/i+1x3C8vB8DGcc1Os2EKJGtAxp/0Dfn7nywGbfzufzomqhdw6TGVjpjEXtlJ7SzyUY3Y6c6uwFcmQImwHPzDsVwSoerRdwuFED5Sjd2av+hcRDZjwQSudVQg6vxUEf6L4oKVk/j7gABKRHfs8eAdsKGJ0R7RK0eSmtBuMinjJvkybVLF9+cvgBxyhIlDm6hHfGvV23FdcxMA1rIU++BCFldrYhOClEYq86whgWBO9XyxqaT74hie+82bURJ7lPaMCwbD468jcA0VuxT71AVeBbA4chBNHOB+Hb+1JjpbIWbUj/g1Ic+vbxjFSHpglp+bYbt3k1Z7yvQpE3Sqhsp8evH6+8KjP3kT3hlI2mQwuO/8fYDtQbB+bIYPlcT9hz8VjOJfjFwAreq5Db9XwLcOjlHy8WWvOv8IRyflLUQZq7v5M9JT2dyuWHabuFD/jrqushSEnlg9gp3lQlFoEkEGxjw6WQyuLLtCtRc/kpb+iBv23B5mFJ4+jPZUMfE5FIAsmt8mxksAYcd3wEQWisO8WJucE4vs5F8R12GGrhKgy3kMHbtMJFWltwMkhMmPiOHt7RQah2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(83380400001)(6496006)(6916009)(38100700002)(86362001)(26005)(8936002)(36756003)(8676002)(6666004)(4326008)(66556008)(55236004)(2906002)(186003)(6486002)(5660300002)(107886003)(66946007)(44832011)(54906003)(508600001)(66476007)(2616005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PJGBoeKV7RL3DFn6E0Ej+uKDzbLEUaMuV7tw2rDTQvCXQ8qCJouYRzoYZP9V?=
 =?us-ascii?Q?hTJ8OloCG1KGnxMYFPulXFGDlhQw8AR4j3FgT/euciqUWop1V0KzQ54qZygs?=
 =?us-ascii?Q?iKRvIx/YCC2s9jfdAJo5FfAvD5gDt284RY+fr7OImy6C6LqN7T9yakCbYdHt?=
 =?us-ascii?Q?41TdkZMy64hNq2PLqitqn3kcJ54/6GZEiDgB+A2vnydQt3vszLYNhPAT2DrN?=
 =?us-ascii?Q?RPEImX+urdxYHxsuZkohg/LVxOryDPoFliDd1fuJ86i9jaWZJWsNNTf5Drd+?=
 =?us-ascii?Q?qo+UpqiTJsYBneUbdDGkh9fHvu7TTQGGup/vr38yP7MiRpWYJ3viDhI/KwEB?=
 =?us-ascii?Q?gT1GQ3B4+yFowk4KndfBic5RSZ5suEoFuUBZsA1QIPWWi6zaoa4SBuTVv0iA?=
 =?us-ascii?Q?fT9GHZAfe1xK5QMoxxjzJkklLbil8WZsYYW10rkxKLOypZ/XiHZ9GPhiO7JF?=
 =?us-ascii?Q?ovo7TvGf33wT/u3xlGmVnq2/7htjxkyfb7v5pDeDziHyMasYRbzEBxhc6haW?=
 =?us-ascii?Q?t/Szspr6caCnG85C4xNdHb8YqytWwXlAGNQlOxHiJ+5lmFbVeUMtkjQrObat?=
 =?us-ascii?Q?SnXPLSylW6QJuUH/mAGJvc8XOpq7inAuPJGIy9mENLSBZE4/SBRj5RnRbyQZ?=
 =?us-ascii?Q?3ECvO0UnYczuH53JRfPFnKlECDXweRemxR07acOoTn2+BD3Oc2fvs3+lK9rJ?=
 =?us-ascii?Q?sb/2JLQxH2BrbHkgyZVkrGzMAmn4q90M2jmRSNbN2SzPjEtvW1TdJ/yRyCCo?=
 =?us-ascii?Q?wbSyQxunZL+MX4rsGHAbQDsBCWetqtVhkby83MatuP2po5A5IdxrOX0EYimb?=
 =?us-ascii?Q?vbIl4XGi4U66ehmVDsylD2UySQuJoX8VErYgthcEDUUXMfRuvpXb4ATuQYov?=
 =?us-ascii?Q?QSlcC5pGQYZfEFSNfZM26IQs8ZbxQETBp2bnbdgcAUNZUJChiXztkCKe22Xi?=
 =?us-ascii?Q?crnJVSA+RW9wg3KGOV5iKYScTK1EDAx0NdaMlgaroX4Q/qsG70M+TQuysnP7?=
 =?us-ascii?Q?ry9SJHltvM9uLwm6HIa5yJ1FYSa9X35i4v71Qrcmnh1AQbWdryitOgTAfTz8?=
 =?us-ascii?Q?XHVmInWXt0bXBCX5RLnUkCp/havrTMltQF/yvZXQHkmIGki+4T1K6N1HUy9a?=
 =?us-ascii?Q?MjgixfmvXEbOGdf1KLAaXcT3NFSEMLQ3158Rtm4w+IidDoUkexICxvR4GqjS?=
 =?us-ascii?Q?Jh3QiYOnuZdAIDBRF/vN8niFLtfQ4+HDx4UKwwGpe1wg+lI0Tbtn6Iw8YcMQ?=
 =?us-ascii?Q?h24OSCOxTBu3gtqxCuoUCaIlIo9RBCvOuTZ1CVk96yy6tgVIIMvJeuMfq8kj?=
 =?us-ascii?Q?ioD4Z5KtkY6SFJQUbEHN00garqtw7kxQZpGOKGfoNGIzlY67keQqo/A7O04a?=
 =?us-ascii?Q?39a3SwmNUNdol0m6vTApzfp8dzJGfxaGGblY/8vYlkTx4jAJpLBT3M2qZTAD?=
 =?us-ascii?Q?8xMbLnHdQRJnShI2sddw9w3X4dUs7Z71mA+zvlSkyuX9tLAGjsVrYPfSy6D7?=
 =?us-ascii?Q?3hzGTTCn0EeSAgOF8sIXcP2QaouLhjdruhErFog7RjBsOjhy7YbRYfWiIX4P?=
 =?us-ascii?Q?OqCkPfNXlqvHdPiKQkzOecTdeyt/CngnvQtt2BU2CGCRgQvgxMMVYhtl3o0Y?=
 =?us-ascii?Q?fcTycKx+yvyhfdsbc6yA1h4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7d5302-fa81-4c6c-fa17-08d9b54bdea7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 04:26:11.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JycgcOR8nDXYZ0dXkHwkmBpdTKGLnypoXHh6Gy19Q0ohXQJDB99K7kVzjbVWFi8Ssnby2PRsIDoM0WGVjvTZeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3403

From: Matthieu Baerts <matthieu.baerts@tessares.net>

This is linked to Geliang's patch with the same title.

If I understand the RFC properly, we can use MP_RST with an MP_FASTCLOSE
and an MP_FAIL (or none of them) but we cannot use MP_FASTCLOSE and
MP_FAIL together.

This patch implements this logic in both mptcp_established_options() and
mptcp_write_options(). Before this patch, the first function was not
allowing any of these 3 options to be used at the same time while the
second one was allowing MP_FAIL to be used with either MP_FASTCLOSE or
MP_RST.

Small note: I tried to keep Paolo's idea of reducing conditions for
"normal" options by moving MP_RST at the end and allow to jump there
from MP_FAIL and MP_FASTCLOSE but I'm not sure it makes it easy to read
and really improves perfs. We can also move MP_RST check at the
beginning.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>
Tested-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 60 ++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..078187456467 100644
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
@@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *m=
pext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		const struct sock *ssk =3D (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
-
-		subflow =3D mptcp_subflow_ctx(ssk);
-		subflow->send_mp_fail =3D 0;
-
-		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
-				      TCPOLEN_MPTCP_FAIL,
-				      0, 0);
-		put_unaligned_be64(opts->fail_seq, ptr);
-		ptr +=3D 2;
-	}
-
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
+	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
 	 * see mptcp_established_options*()
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
@@ -1458,19 +1448,39 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
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
 		put_unaligned_be64(opts->rcvr_key, ptr);
+
+		if (OPTION_MPTCP_RST & opts->suboptions)
+			goto mp_rst;
+		return;
+	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
+		/* MP_FAIL is mutually exclusive with others except RST */
+		const struct sock *ssk =3D (const struct sock *)tp;
+		struct mptcp_subflow_context *subflow;
+
+		subflow =3D mptcp_subflow_ctx(ssk);
+		subflow->send_mp_fail =3D 0;
+
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(opts->fail_seq, ptr);
+		ptr +=3D 2;
+
+		if (OPTION_MPTCP_RST & opts->suboptions)
+			goto mp_rst;
+		return;
+	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
+mp_rst:
+		*ptr++ =3D mptcp_option(MPTCPOPT_RST,
+				      TCPOLEN_MPTCP_RST,
+				      opts->reset_transient,
+				      opts->reset_reason);
 		return;
 	}
=20
--=20
2.31.1

