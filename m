Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140074.outbound.protection.outlook.com [40.107.14.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D87B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo/SA0Zjdgz8R0x168v2TB9EjvA+KltCx+nsil5a69wZsaH2PNPcA8El8jfFOs9i7T8a+AKUFNn0E/v5bxzP3NHILddwOBStV12y57ic0Ybqzwm/IEl74AfL8AT65ndAIi/4iZDOQRJf2IvqW/6ZJvV2R0KRaVF9EEpReS/AM9719Y9UlygxFp35u5k6ZGBxnyg63K+2nBTmOpXS+n5fjxiL7Nfcfj2WpArpFVZ4dZIO4Su5p85xV1XtV0+0bptkAB3p/mrjMdOwaUuoMikIqDztWSugbayDdbsI5IUa+JwtPESJRMxPJTLIjWKjArcbn3O+s6m61BihjxH7/cJc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=MDR6bxh0zwImeqIGs28NNI5M3XCLVjfCBHJPDKyI6XhijFv5LMLO54PMMn5loN08M21Z2OZ3YKJ8/aKmfoYAKMGvi9oXXXrqoE5b6zfHVPunCbTKFwt2r+Zc1bL6zu0tmY3sceZKzJcTt0xpsKzK4OOmTVluLwOBusYlOyfrS6YpUuH4Ra3a10t1zgprE07vMoxFHVRsqI4ZnVp1AZRVG30QU0u60eAAzQJDk4EGd0QpBbVA24qkYfcNc3OshUsRrUqDLWGBdO7TZXWcVJ/4w7FhbKpEWy+JGyaf+7ovt6ZlqfrNA6SrINXQzQOpyKibIxufNEZRJoMKQOwBHcUDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=TADm3+Y7XuFrNh1wJEWf3gzqT0ZYwHE2QrvETWZlQ3/r8d6j3/KLFZhcDxrRxnrP7Z1oA1xBzQXvmmxd9ayckEgi1e2e10H6n7jfB7gr3/sqeZQMQu7B0oXozQwr9hrzBdnvXwJXgt2V9ghQW2P/HpQDUOvhDb70J6BZqD8c9Ghg1ym9Z+tBBFOk3Tnwme282ApEhIENLwwuI8Bgym/VUqB/y1rGr10Vl/rJRjdwRZIU1iUpAUEsvatqkpT9aNCqvmSSGexpLNggIFXZs8HsdNfZgdYNTyDiiX8yzRi00QNuySf+9nowo9qdO/lTZSNarDmW56LWvZb66zZpvo5aAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:05:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:05:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 05/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Wed, 26 Oct 2022 16:04:14 +0800
Message-Id: <97843ba1507c34b5622b0bccaed0649be7f3891d.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: d59641c9-a5da-4a5e-3d63-08dab728db04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bEzd7FlX30WNQBUnsEsVugtyE0XaTLRMzP4HLj3liuGDFNz4sJ7aWQbLWAnJ/mMh9wb71AJ2J0Q7PXh8xJnIWe1hKuxMSenFh3kv/sot6p+Fi/M24GPgO1sBOu0zsSKM0236p8ZsRjyszbBjPdLfzfUv/e1ffaIAHdr9OhWGl7F/kOqhzbkxlzhRgxZurMSh0Pituf07Damr24Ha8I25Ra2U5qHI5f5Wl7RD1KBkUply++FJjFxU5u5xNZkyo0yFR9DGTmiXEzlaYm1kqR/Sii+Uh1aTXPD44LiMGWv4uM3zqjLw70fdbGpTkgCTWMdK6KN7hXGK3DTbH1rqBHPPoLW7Ln0fXvnWXni8DvXcwOvJKkh54bwlY5EcbNORfgYkbqHzkASuBkIJ/4/A6vaekKhz6SXsff4zr1D41ZRODiA4u7sD1UCZtNPGwzsgh2q4WiUoGUbeMdgRHUTnPFDytmwgblxmoWogttoB2S2YHgTqQ7YUYK1zFqd3MIPe58SpfGVd6w8UkR7sQ0wDJ2bDIXOywky9ICQzHW5D86U8jDAjln8uOPmevPCvKuQRHUjDsQ0gdyKY/wNnAzp1FBj5TeEQWa15VKtK7nrED9A8O3d+kU50CL4XHKRUu+KigaP167LAi2kxwm2PE7j49RNmaypjZm+Zf5so/XRL4+8oGYl8+BS6TsdwyG4PMGO7nRu+hDNj6Sntu9rX+T7w8kjkfbwWBlqd0z0/r3xpHkYPeN39V3TggA0bmwuDdkd8QEdd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(6666004)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZHtzyAeX8brASpfx5e46VZiLBtHIBEYAAhG5xSmTqt1h/fgKqDh/y9A4nd9?=
 =?us-ascii?Q?Om19ELGUYcH7uEbkKdxCIib429E9+bKoo+h35yg+JDDd4iO+7sM6M8UqrBU3?=
 =?us-ascii?Q?kQNCrxTyOx+eClNu/mjj+5HTD6YcUdqlw9ih4ZO8v7IeC+H4IkGX31u2r5GC?=
 =?us-ascii?Q?albDTnVbXfNhng15r6JrQK0on6IoorL/wQNqV3FRJ8E1fj0suNGibaZUwh35?=
 =?us-ascii?Q?/T0UW6RLc/tT+0GiQttMAxBwAhIFMu7SMYlMTUCjS93O7sedGHr+2ACwrgvp?=
 =?us-ascii?Q?BeS8yeU8RR9ymN1If5Tv/n2TscqoHzVBDH3051luKk8O7/ce01eYuFnPCRee?=
 =?us-ascii?Q?fgfXhOP1PU2Z+vijxH/wt+vM61ITasc2WdwDL9LJfgIfNMbJjEmSObXjn0Lg?=
 =?us-ascii?Q?RibgcdxIlXTzSmuNf+X5NssTUktvL5Pf75hE6WlNFlw2BHCzs24+CxAW72ws?=
 =?us-ascii?Q?JEmPphSXGv6H5h4KgHoJaWhINtML9x+Z2lns2JcTYdFhQgMnujaKiSLz/8gJ?=
 =?us-ascii?Q?dfU1NuAINIldyP0rXCDnxtO+rgCgQLoSdu5+WVTybVtkxPSWWXh/z+WxnFyk?=
 =?us-ascii?Q?HF0Buk0+JvhdIeBREbF8R8YHD4U4E/KUdq21l8flADMPm/9xik2IktIBJ/L0?=
 =?us-ascii?Q?9haGxjPCHxxXf4R4cVmfKpYf+S0JeKhkHblOkNMab235k7a21MP8O8/O5h+m?=
 =?us-ascii?Q?iPbUPeNhe53+tBsKb3k05UIZGchz6X/Miie9ESzuqDQPO/Xwc+MTqSLtoctP?=
 =?us-ascii?Q?JxSG8ODJmCq1uYXQ7c1CshzV490zenkBU7Z1CPCJK0UoOsYS79VEtJRO87ex?=
 =?us-ascii?Q?BfPtPMYtJ81aVwvzGrC+X/uMz0O06NX1Lsg97XMfHUzk7eH0LpBJZ83qroQG?=
 =?us-ascii?Q?UAjB/aCoBII2DfJp1VXupq2M4K1K1EKuFvud+mnXs+IU1P5ZCSJzYOGnWPXS?=
 =?us-ascii?Q?MynIRzcRc/eWbLhw6MM10ZhfwgKeVf+wmVbKXyWwdB6Ut0CPVY60eYKilWYW?=
 =?us-ascii?Q?WOer7IjbfkosSZGtdD95UFGRGw745uKpFX88M3VJCx0czv2PsO/cBtDrr0tU?=
 =?us-ascii?Q?jc0mHUkjF5QmOxymiRCZlg9q4lKqIioKHkNJAgllPMEKHWgF3kbL26p5n43F?=
 =?us-ascii?Q?YZ5KgkxgTo1tLIJSKJTGDO6aTKrHUmVnZzq96piTwQXyvMvdvMNR9WxsOPJF?=
 =?us-ascii?Q?OSC87Y++LZYeNfozbVppMHMWrfsAlqffVGyX0uYazjV7TfhnwjKBSVURSkfH?=
 =?us-ascii?Q?2KlX1S40gAIT5xVCmhYWszEDypPpcvKTHNbB81tBW+93Pt/KU/ogMkFlf/4N?=
 =?us-ascii?Q?oxjdJ+sycuysqzFxo3esU3Z5fWWEbviv77xogvjeYIhbRATv2W1B2Zk24Nv2?=
 =?us-ascii?Q?6sbJ2XeS4WLz5hdqKzL+aDhjed6pibxPF+sxkNk3PUXkyWhyqDp8gcEMJ61O?=
 =?us-ascii?Q?TYpj4s4XpkazIbN5yfGdQ8gs7b3p+Gx9RRUw/KxdMZmDs4674L70MLsafvcc?=
 =?us-ascii?Q?HT//4aaiYQmPgcKOdx07QX5DGY6wxSEusQ1I36VbLn8oZteGa51vR0GIaCo4?=
 =?us-ascii?Q?hoM038uVNaKRpXYm++a0WtqgOBn9ETFzmY4RgppO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59641c9-a5da-4a5e-3d63-08dab728db04
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:05:32.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sjAGs5wFDPAJD1ithSgKANCttLpRJ5KbdCB3YJ5sbc4yjFnsWTqIt1u5BdULlaTpsRHt4ywXtJ9HRqltahu2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..72c618037386 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -249,8 +249,10 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
 
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -265,5 +267,7 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

