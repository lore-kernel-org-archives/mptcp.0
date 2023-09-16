Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820901107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0RP4qUqe3/TOM8E9lNQzuSMgYfWlU7t2pKpqMB5YUemNERSILAJy7/smBVHjl+dZeRCjq2956zrX5RPVmowNTkb5qPYG2MVQBhd8ts7Lp1QVIyNQ3Pe6PIEPBX9N98w0pcgshKU4lOxlyFEW+wZKveT1AUe9HDhNaX+4zCFF3o4/YyUPIDzkoNUNgeWxXu1aKkmcLpoPyVT41LILwaKkpEkaAEeRaV6Lz97RSIE8iUqh2bo2JMGZWoKtHDFbpWIGO1Jn/WaM4xlvrekQ+jag8iboSdtCpILpTTQ/Fh8OEdbha8k627uOV1KomCQ1YJWnrTScdJYw/EU99LiIVZnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxJoP65w/SR8UJ8c/cl5Nvzh7Nzpvhdk7YlZORSm580=;
 b=LX1kjjVBLuNHqtwtd8fgH0W880htGNpYpPMrhB3UM4trK2mpg4T7048+jBo1J3Bs8tlb//OezvyrPYTtMXagmNDkjXgW+G/EcVOWr0L0cfsMoQkqr6ZauxJe9j7QmkUWfLJCPcrENQK8dAodCqB9aVlK9MFN3SGg2tQsr7MoiNUR0Su90NdFCl8vvDPoHqoWZ1XOypKv060E5CROH4dO5iwfXWynw2VkUUxum9IV6jBvwH55Kz6E2sxcvDCLCalgOThi4HSw0lbCXtskfZlAW/+zGSufWOmbgcPYFvgJ0zjISEMb5FQaIYCg9j8R9yJZ8FaPy57qpXB4KOIzXmMEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxJoP65w/SR8UJ8c/cl5Nvzh7Nzpvhdk7YlZORSm580=;
 b=O+rhZU1HXTgUc8Bos5RsZzhjvz7Gq3tnoi44KVSqLTPvVZz0thfqchqg1I44+FCVIJd+q4F5Twd3HZ3nx6/8h8Ck0IxMzDKrSSDkrdhqVVphD+OHFjOMKJmUwVVkpeBYons3pSROXozSXCRh3PEVFW51QZiy74R55U4M4hc4qmgUJZO9UA88x/CEALIvie/V66A/PxCfvPgmfDYrN1aRylP4l4Dqke2ENdshbaJ3nW9hSkUaDgND7iBvw/AASYc/YdGTDkqLWBHfxR9VXcDiyRp9PqpjImDf5yAyqTghMmCC0EI92w2iLnL2Vgs/pQcIeTvnvUw2+QIygzkIEYD6lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:38:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:38:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/7] mptcp: use mptcp_wnd_end helper
Date: Sat, 16 Sep 2023 19:38:37 +0800
Message-Id: <9a9bc35139dcb51c7dd8c8c32ffdfa44cf722b6f.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694864093.git.geliang.tang@suse.com>
References: <cover.1694864093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c8763c-f546-4395-60e4-08dbb6a96d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Du+FtIeaaapJ/+CleOQW3UlLKS090EEGd1C+itP/06NnqepVdlQyt4MNbmXw+/7GHbsTw25ilAkad9xIUs+xnlClkq+rwbBD8Q5rW0DGj+OfDC6JH62I/JFjB9P+oMGQGPjJu90xZNJNy+YcLIkakOWs9Gx6y5wpGgBUKCZUv69WhQ0NZX6I17joJzP2MaKvLMen4P5ZNQ6xgeuZ7+KAMCj9J+B9iKSbQly/U14ZuH4I0JxVFcPEn5zCgR3q+mMSLW391F3rk9MY6SbfWV+AXHwP5Q+ga46f69piUTj/Wub8Oz2eQy39Jg4/vwCsTLS+VPfqXDLrSSGaPrZaE1XMJtroNiFmCvoEoHDSFM7TH4H+Ha/ZLgygCeLC/kJT22mfh4ywc89LCyc6I5TUORlknXutiF4pEn3a5XyxHEZa/Hujc9GG/dfYkY7nonjiEGG02P2XXXsG0XlLWIIsV3GSwKkUnaXocoEjrBiOClIeK8q5+Sz3TkLBhE7gW2u1hKSPozVDOA1s55gnXEwD7yjcGp3dgxsvAASaRLjqtekUjhGvtHdclRMyNfM2zZQyrdkgY1LBUlFuZSBt+KAUYYv5pYsEn0e54FD2u2SVSl6YEGs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(6666004)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(4744005)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+deS60xc7FL3R2RXgrk9Mo2EUNNngUvR0x16xaiWyNx7GXIto977QpP9Oi1?=
 =?us-ascii?Q?7QtB7Cjy+T8vuXauQz7ENSSyCju3rxBE2DB1FeqQrudoZ944XTN6TXjVmbvn?=
 =?us-ascii?Q?G30kD0j07bE0Cy0lW170M8Qra1rTLu8cmpXA1cIgrpTsPUPSuPaszWB6P7XN?=
 =?us-ascii?Q?hy8lxtcEQvTkfNXM/OxQaihVcRgCzcCwjdt3RARK2OKaY3bPGQTNeahcT3vP?=
 =?us-ascii?Q?83ZZd609Wk7JS2OceR63gGMh9gNDULlqN1ZT+yCOIhhX2wbUziRT0SWAZCso?=
 =?us-ascii?Q?PYO22Di4cgHEzppOpU+/QlDe6n4Nx8oLT8aVKp+xa3+PgiPKQmaPmZZl/m25?=
 =?us-ascii?Q?tX1fGRxsrGYC3XWvVD5IXKekbPhtzvqJglstjM0jXdrjYBQiInD49d1hHhw5?=
 =?us-ascii?Q?PT+FKx8Jf3xMVwfxQ7Sl/fbIvBJy3WiyMcDQQUQSnkvxCGMgusc5jlEXXT3P?=
 =?us-ascii?Q?Ur3g0oFoZ2WqNZ+6j8H5SE+PNloIvL8c2rQw31v0CAjgtQ2tEbioibP74iXf?=
 =?us-ascii?Q?r5enVvnL/zd962UrsXC132dK1Uz7n9KdNOo0DXr/nS+9hWe/+5QQ7++yhxm0?=
 =?us-ascii?Q?xV2q1OWcBJa+Jks4nqqAk9P2/mBx+0kDEWVslbbmsLDdiJY5m8ZEYJHk9ixD?=
 =?us-ascii?Q?Al6OMEPJCj3k7PmOOXVwyYegetPZ27s0poqZuZSeAVi4CBsxoBDQyYUDUo6d?=
 =?us-ascii?Q?iz0fq2/Gv07jjuaraMEjB4SFFqoZFO+bezMX482uyaf5zOiuIy4kfOvPpKb2?=
 =?us-ascii?Q?qFgFgzzjLDQ+1eQ88HA2LNU//C3LY2RCNdk+qIAhJDWGEBOm28UeJcBS4Eco?=
 =?us-ascii?Q?WQ9pvzbEbPyYlhMiChXSsy7/Ni2jDPiwFHgNrq0gyUXnI6serd6CrOHtqHof?=
 =?us-ascii?Q?FDAgoc/CzIhM/QedUpiuaLfTUnm3SHn1QoP8mzmjLie/tHj+gUtF4A92RJxm?=
 =?us-ascii?Q?dzbI2KvPacC4tU0xFoEagO6k4DSEClrDe8JK6T4WBjki/wYT91kft1qeNQ47?=
 =?us-ascii?Q?bDZ2cuF1Ir8D2FUxNFF92zcJqCzMNm1IS2q9mVc+Oivlh6V/e8KeO6def53C?=
 =?us-ascii?Q?JYwNY9hN3s29qvMO5HhUPyBzml4fD54XojvQdGAdFjfaQMF8Rw1mKvcZDesg?=
 =?us-ascii?Q?m5abhw2Nf05CGrcQyJvxDd8mez2VhBvjYc8HmekT7Q+kCKI9vDY6SaUYu9mG?=
 =?us-ascii?Q?XKJCrUL4lnS1JP1wSODQlHXkmy5680QiDs8LgCfndutWcE2Yry6wRTpyiG1q?=
 =?us-ascii?Q?D59a1RtiM3Dz1iz7ktTNzLyP7agMLxZi9Sa+ptgeJ2NVKuHwvLA4xMNXzuRt?=
 =?us-ascii?Q?gYEcYE42QS4+2fzCnEz+O7ukvud8fFIzQmz0lPxEXrSYJ92G2BH8mkpNlCOA?=
 =?us-ascii?Q?bvWMcuxQB8UBgmj6dczq+DV1UFblByqMzxJqNAMEVtKjRK+Ij8Lly2WchI7c?=
 =?us-ascii?Q?/ZUOX2nE5/GfY+cTWtXcaEby0y4fH/zKaaAs7yFx4cvxpuWnuVGAdTqsQdFk?=
 =?us-ascii?Q?3nPf0ahP72BHt6sjmMq/V1giOxPWJj0eI7WIqgYl3eqDAMHSLuKm7rhvQFoY?=
 =?us-ascii?Q?J1hWireb9ytjV/cpoVFt7PQCKbLrCD3vHSU96fPH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c8763c-f546-4395-60e4-08dbb6a96d91
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:38:20.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zru/9WMdAg7CMCmd6603LxgCTzUKXjmD85SHde5ot2zEotUySLn+8Z/vLvSYib7wa4UM9Gs0l4eTpkHRAaR0wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Use mptcp_wnd_end() helper defined in net/mptcp/protocol.c, instead of
open-coding it in ack_update_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd15ec73073e..f40381557788 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1059,7 +1059,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		msk->wnd_end = new_wnd_end;
 
 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
-	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
+	if (after64(mptcp_wnd_end(msk), READ_ONCE(msk->snd_nxt)))
 		__mptcp_check_push(sk, ssk);
 
 	if (after64(new_snd_una, old_snd_una)) {
-- 
2.35.3

