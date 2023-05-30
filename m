Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A31134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wnnnq0SarFmTmAKyswK+95WkYvE1eanI4fGEW10O3yOL3DMD1wE1RyP8aIHFrS/Jz6vkVDpwW76LOiiEgufzAggEI2ZV5GO5rgc2c8x7T/GuXFUHgaN20GJhFjuLR7GZ9BzltJEcR5sjVcbw7aEJGMTGNghVuZV1ixHR60WfEBfNHhgKFMskhNkn14E7veYIjjfh3ieySIzPJS826zZxEN4y7dgvALni52NfkjQMgc6mcteg/2/qzuzNlMH+dO1Deh4sEFGNs+YusP1auQGedBzyAmA5eVDFORNq1tVGE4tyJDId2fijUXmQ4PZLCOM4vIwjZTqQ1y8KMvuN2ZpR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6Dx3a2gs92b6lcUGYlYt0Ez3TVE1atpFG93VipnE9o=;
 b=NKFZ8w1BO9vE9c70yA/tI03SK3XjeVLGp2OD3p0fWG1x1QA53jjDZK8GvVnalt6FKng5kQVNoKGUkVFX+8zwTAAcMgQMJHYuU2C6o9COU1BVk7H9Hg+qEKerpoOzAJgDtxgc1GX5Ht0C+PwGAkzCxhUcnZY/4uQNCGyADK5Ms7Kwf7ls2KOD3LH/FQvzMTRtUypW2pKEIjO8WNmafMyHe/cUsCGQPrCbYuXS04K8QafifNMClpzm58LsFLwXig6LLtzjcA+YDA0TxOkct19DMsODg8axG5Wb4AeAQeAlMi/bfktfUdY6IdoRVb1iEk48zE+am4N9Ll0Y1w96D81wPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6Dx3a2gs92b6lcUGYlYt0Ez3TVE1atpFG93VipnE9o=;
 b=vThm3w+lxjDGhYC6IeLW73m0PNi/srd0IAriQPEVaMyD4cQ/RreFxZOGuyZmhPcewdsKn6ow3HTlrRAP9ksxUF7gLyWOkzcPTqe5GBzARXK27MtAFPdC3l3ktpJJ1s5EdgZ8e4rULjGjt2jJyhVVJTucx68+wejs7451/O5ddWNiA3nWmuuSEQ7cwiHWSz47ve67PuzHuyLinQCD/BuiqGOStIHZO/0nSCabvn6m3jgWF/Lpy6Iwbcs1weQWRV2uNmOH5OspRSkQ+eAjs6n7VU6qYYOYea4/09j+B5kwZ7JMzVRXaR2gqX+Vk6VII/xgAZVOBkplAOBaZ8CIO5horA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:19:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:19:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 09/15] mptcp: add three helpers for bpf_burst
Date: Tue, 30 May 2023 21:17:29 +0800
Message-Id: <97173d8d0c609a8b97c8820860da4b11ba4ed42f.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af7b05d-e512-49d3-6225-08db6110726d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kWzXWA+Md342f/xD4IomWkrJBS+PiFrgmyoaTRHr/DsQ6INChBvCpxq2/gVBTMHdERGj4FeDPLB5Np87O3MIPRop9XOmF4crOizz0hNNh2VJhuQtDrvXDtSkJzvLMVkgcp9jx/rJfTraGT7iB1xDHMm2xuRpodANjrfH3llo+sY36JKQyQVJtvEz2ZaqOqVP1uX61yQ+Y3mg7/QKunJPRD40MaTPiA3YO4exywWiFeGXjcTJb9qjD2+vl6zfg0blUh/kb0nw2caJVMe2dApxRJG5yFpxtT1yvw8+djYbghuY75GMIRoAxj7aPpPCpzNTIN2CCSs75N9NurIm63Y/wU3Wqdiit4aqzgi4o89y5Z+GdFA7ZmMROF+u7WjdIzfxyU0vUY92DI+W30gq387fkW7sTKzeEZpUhuW635D4Ehz/BFEh4EcnI2Z9ymAFnG7rumpiYEk+s5w42MTQbSpfba0d25QYTQebK8JEUCz1h33AxzYJbfAU6WW9Ue0G2y6Rj65qvwL47UVMnm70kw6Xm6wkWGSaERJ6XPgTTJvH+NCUlchAnoArL+UqM6OUVh5t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P62MW4uqPieV93xj9qIdMoj6GrSPzV0eBst8q4kwLbmS/63jc2jO8cXyF2cr?=
 =?us-ascii?Q?YOC6edRliR4GXwBFKvz1E1UTvfyhawJQB6/hI/1x22W/2LNsWDFfMXk0M39R?=
 =?us-ascii?Q?KW2hMnnYqqvgJPQJ0aASlLNBYwAG855VKE3OMuWT1zZpPlLxKPodAOkdjYEI?=
 =?us-ascii?Q?Lb9pdCBWPpStOMTbfI7PsSjfA49uzA5GAxzp0OtfvH2lWPQF3+0qAy2K/X7x?=
 =?us-ascii?Q?OAiAXUv0DnhPctPQCrdDpn0A+Oloogu2uRFQ14k566R8Xlqr6rfA3/J2hH4F?=
 =?us-ascii?Q?LdGy3hia6v0M6rMhqpmvmpKfvr0c3Oer+A3RMlH4BadujUDCXHqFkDsrHsoR?=
 =?us-ascii?Q?iWkEoOxqdCHPuq5Hr8luin8gh2t0L9PtHtWpQ1+kZ9zVWtUUqm10ODW2O0SC?=
 =?us-ascii?Q?GWppRkR2zJIJpInmaUTYK0KsoadMUNceScsiMkMwnQBUprH7MmO35/okZ/js?=
 =?us-ascii?Q?OuUAQ1s5/s+5ht35d/0MK4JucmhVpVvOSyBQ7VozujqhfD1lNkNvLWeXoCoB?=
 =?us-ascii?Q?SGcUWk7qRyW8O2CC6h7m2dvn3dVEdPNuAnILh70kFlBkAEELMnQReCbuFZE0?=
 =?us-ascii?Q?tqSFTSGda4Xaz/BYDKyD9BJPbbc1fuZ52qiia6RfpOnB2QSfcJoF/1O95zIP?=
 =?us-ascii?Q?2eGl9jkSZssQGTifKOmlhUIevO8CvUcOpyi6OaZHQUfwkC5QGKnR1aI43ck5?=
 =?us-ascii?Q?zejftpeCkFftUEK5/hWivtLmEpkXRJ4iaTHSEiijwIeWFY9GnplehonCrAKf?=
 =?us-ascii?Q?HqL60WdG51+r4wJmtxCQhXoIdz+5vg/3Y6/M7XpfnWPEubUVJocPIVKWg8Fw?=
 =?us-ascii?Q?UjQwK9NKPwLyS6fgaYe7PzQHG2flWZko8sQempcoh1BFJaS+8smhUF1HWj1q?=
 =?us-ascii?Q?vFH4c41Vsvyv3pYbpRFS9COwkNwjRUIVn+FKPToBWHFzP5bzKncYoS8jcuyH?=
 =?us-ascii?Q?pMfa74u/M1IrLwq9S3oo4WI1pTVAN7WzWG1hfho/NWZvPrO0Zoc2NOisx6KJ?=
 =?us-ascii?Q?JbunLtJzAgg4Tjub3JL+NF0RZ/PyplgnX/gbuI30MYarWLtu5Zai6znClSNI?=
 =?us-ascii?Q?jybrXA43Bxs/fkdReTsDSeZ5wM4apnXZfO5pMy/URtwUAY8SHFu/uhdnj6qS?=
 =?us-ascii?Q?FadNdEKUrEE0oH8fZR2OV3tqWCHcf+gWhjia4U3P7pzrrVDxWckBpI+UuJlr?=
 =?us-ascii?Q?pbRxUzQFW1TOp4NMDTNxr837Uru3UjHpmcPLmNtZhca1VpJ/odGVIlfJOdr5?=
 =?us-ascii?Q?+pRw+qR8NppD7a0IctxGkq22/Zpwp7laltkkEKbzGaBWsu/I6p0tUWYaDxHO?=
 =?us-ascii?Q?z0HXdOIAvL+UPZZd9ER+rWrhQfhZeImpXK8l77deDnQ21Tkb2lgGTk4tavSs?=
 =?us-ascii?Q?rc1z8/SoIhli82qiJNxxhoO0xKkeTfhqeBZXMQEal7FrJPgTzBaSL0rUxC7H?=
 =?us-ascii?Q?TXN5RpZ+7CzotLFVTX8vHtSeFONaT4p2xT4yTWnY06dXbrj5kY+WMI1Y6QiW?=
 =?us-ascii?Q?szm1x2FWoDZFyszkr98e2MUq6eO6LTxE7FfDSRzyf/UUpzlH4MLqySCD3L8g?=
 =?us-ascii?Q?SSGQi3FlURf/s9FcAioLw46ZyOZpkCvzd22ySzkr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af7b05d-e512-49d3-6225-08db6110726d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:19:07.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqPZM9i5hPRFInORvjMiq5GlUbtc4Ln4AePuxM2s66Sxdaml2uA6aiAK7Cl2rXriBzwAKdq9IfgbmxqwOs2Ccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

This patch adds three helpers needed to export into the BPF context for
bpf_burst scheduler: mptcp_get_linger_time(), mptcp_get_burst() and
mptcp_get_pacing_rate().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c8fd0915fa0b..8dbc9b9c3eb3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1415,6 +1415,26 @@ bool mptcp_stream_memory_free(struct mptcp_subflow_context *subflow)
 	return sk_stream_memory_free(ssk);
 }
 
+u64 mptcp_get_linger_time(struct sock *ssk, u32 pace)
+{
+	return div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
+}
+
+u32 mptcp_get_burst(const struct mptcp_sock *msk)
+{
+	return min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+}
+
+unsigned long mptcp_get_pacing_rate(struct mptcp_subflow_context *subflow, u32 burst)
+{
+	struct sock *ssk =  mptcp_subflow_tcp_sock(subflow);
+	u32 wmem = READ_ONCE(ssk->sk_wmem_queued);
+
+	return div_u64((u64)subflow->avg_pacing_rate * wmem +
+		       READ_ONCE(ssk->sk_pacing_rate) * burst,
+		       burst + wmem);
+}
+
 #define SSK_MODE_ACTIVE	0
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
-- 
2.35.3

