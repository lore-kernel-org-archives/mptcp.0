Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60A14F9D
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bglBkVMGgUT4TFQBXCAGWc2/dvIKEcv5XsDAV9pGTBgQQUL3AIq1f/gW3tEWX/crAvl3w6x/i0rkdsdQ/IaW0SrQu+FFpbujH9gOmsYsCZsBANo4skNV2jMQejlJJas7YIne3w6xCZQQDEMbZym8BXRJzhwmY7gUBqL+5vhsGFUMxGV40R3CcdnSvaFD/hlgGJ7/vKHUO+RT/97qPkfuYzZIPuB83Ld0eJ5N/VMsRDna3wg62Dk94Alf48qLDT2QRHUYZnuZbXou8sp+RFuud6ePzAXrI8+xPNgiDlfO66nw4os3+9qo+eeZPzbCNMrMTaqjEaecpoegHmQ/cc3SYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3LhVzAXVItqcHvRMWS7cioLOoY2bvxnqtf8l7JNQiA=;
 b=UNOAvYpHniK9m+fmnvoZgmAIm6zKK0yXEDvrB3rXy0t86StMH1Jlw9sjEjXOoWiVH/fKt8qGN8GivukfqPdFQpmNSaIw9hRHgxsIXydemIwxvgJ4fz9RgYI0FDc0we+NzfxxbYSY37NuVq6zz1/BO7Xe91v93DwtKX3xFy/Y3faM3AN3K624+cw70Rn5HIH3FajbPdOMdfkrs8ZBB0qJyKmQu7OuOghSc+ESOQLkYDApT+8n6BCl8Cc32Da8TlxHmtyHfdg5L/SN6OIeVH0D3lNh3CrcGce5aPAt5NLg+1W7+msZMUqpPv/Nq5J77XcSUXQeZ43AYBrni/wDe1px1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3LhVzAXVItqcHvRMWS7cioLOoY2bvxnqtf8l7JNQiA=;
 b=mwadXlIsP9drTVGOU5i/7IBuJx21c5b+aaoB7SzZWtvaGaj6bBx/gEW87mlcgBLVGXEuhLBs+4s07ErQe2GUOyT/YpphxmMECNnzmyp93k9B7cvYSFutSxkqy3S/eu+Be56V74EnUm92nq0njuig7BRVdikEX1YjfAJBsTQPqsXo5vrxysICVDVcJISJPRfhCxliXjrB1TJDcRfAk4QqLnoOoE3NWl6OHlda3C4Zi8hfio5Rp9bsmGbP5qZQgYf78PlATd3Po6csOd2WqaLj2lHmaYub6+ZqcC+Z49UiLpVVyhsDkcwQx8izMvA3jp4CEwdSfwxvGOGucEBUXw61rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 07:58:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:58:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/5] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Fri, 18 Aug 2023 15:58:31 +0800
Message-Id: <aa413037855a07aa9463fdaef9006fb2f4c6a5ad.1692344463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692344463.git.geliang.tang@suse.com>
References: <cover.1692344463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4ee0d6-246e-4ef9-8d48-08db9fc0ed19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pSKPxsPvdkmC2VSIdE5lbbiiHSyb8o15EEHGK2JEfDoVPsafR6iTz6QYDMhB+gTghzmWGnC4ihcSHbIt1Nhy0kMg1ga5Cj5ROUCFtb8YYjAT6j8zyh/uAD13XiGVmhVsTkTV3/Clr1DB6lRhF/alcXjpC4Ny/04OCRpLNE72khTq3OHAmz8AXxrl+Qfx+81af3JJVCekRPb/By8MwzSSziFYqdrvolq4yutB26k620sWrMBT1cV318UVzlijy/J3bxeDBk+99yUxZ5g0g2g3x3pMXq/j7GyUUuEuEaOi6yeRSVjHCjMU+wGgMWFeRKaw1ziwB9MdK9NZBNzB0QdrlL+cTtQmOoVYuh8Hn/pYY1iVzxA8mxz/87aYAJeIVm66vWlY4PhqDbE6fbMOY79PNWwW9tvFwYvsK8kZ4yzmH8gaEIikpIL9puzc8Ceoe7Xl4TQc3JR7wlo61BYq2dmzVZUA5+967dDMI/+POg03jI9m95p/cE7DBwuU/7S68EanVRtbCKCirQSiYnMkM2WhSPRxj5zQMSWGifCN+zdsichPYVuGStDhcbvUsO2cLLi1GGjQXOMK3T4LNMvfASpXcGeZuJqGjOZMriRv8BPWv30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(4744005)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3dwMq/g92EKWLEe8He0/7Q0yl+Y7usXEe+IWPUqKRNFkdwMDMk+0c8AnlTiQ?=
 =?us-ascii?Q?Qcwc+N4MgeazJ5dozRjkkr3vt439Wm0K37OJ/kt+/4WpuXO71n6Yw3fFVx9J?=
 =?us-ascii?Q?wGJFWyPoeIrr7TJG5dHT2VIqJJfEsVBNNlHVoQ80aY6Jg5pk9EDRdjEGuYWm?=
 =?us-ascii?Q?KG2oh5Cojgkil+xaSBha4/u6fsE5Ov9srQOpWFch3TvqnbwFYiuCXaBLBAY4?=
 =?us-ascii?Q?pIBmf9+ApYRts42uUiPm6ExnJk4GQkkbfHcHvraEcxp+gAmhpjMiWAjTCUdr?=
 =?us-ascii?Q?zdiYQvh5U63TidQ8+WL0WOJ4CKpT4Z9WjcmhQ+Z2iEbN+YceKtYjdlyR1TXJ?=
 =?us-ascii?Q?wU+H5t1WPEQ5q33mb4r6AjKiL91vEvnNPEdgNR2l+FutqzrxkrTufIKAS5Fh?=
 =?us-ascii?Q?DkzfzxflWLpwLBceIVmlC8ib/VVTOhkHVt+y6pwI/hJMIKQ9+a+dKialeppz?=
 =?us-ascii?Q?Ijm3SjyqPxdQlSk4DL2633aYRspLX1EUckg0n9HJq2yGp+J79npQ62my6NE/?=
 =?us-ascii?Q?VH81aO67daMZtJNG6CrRYA33QJB/899Gfsldywc2IIzww54TxOs940xg61cQ?=
 =?us-ascii?Q?cQMsYupxplDbEW86Oqdwgi/6Vcx1MoUJjKoO/DuDSMtnoHtKCmOKzPVr+tz6?=
 =?us-ascii?Q?RW1439C7md1Meswzl3jSwUkE8S6lCoNZxCq6i5Y8JWi0PvS4Wse6Y4Z2ePQ8?=
 =?us-ascii?Q?MT8i3AAcOMaLx+nPBGzcyCMMhvRWq+l3nT140PcRFaQzxpHmNIf+9lgBln4z?=
 =?us-ascii?Q?aWpM2aIK1PcgSdB7PMhQk4J57dMNzsVxT+Hjm8sJwx1rhdfoFHBstG9YCblS?=
 =?us-ascii?Q?rNeRbIUsPmZvdam3yDyhatvRbySbog5WqTDTfvJTk9902yOqkjhOwE64COtf?=
 =?us-ascii?Q?Ahr0TUrh+bTK4VITPh9GEquQH5EPsuOYhsGDCYlHSAHOzmrL2jzfs+gdaDxX?=
 =?us-ascii?Q?N4PVLsEA0zfT6GPUsVFjKwlzcebZT8s4F73iB47pAy84KrIqCZ96qj1FNA8W?=
 =?us-ascii?Q?MB0LQAf/P9ywB0E3JNy+wv/ZvhbO3Bv79geZG6g9BeVONhssVrUOmG2AfRIr?=
 =?us-ascii?Q?t1FoRyogOUJN970DCA7PRli5kKlGD9h2lcCAutOUwu+qi76fEQqq/aLIcCqW?=
 =?us-ascii?Q?v7ctT2WEnejPrm5xC5G8U1HUOoQgPMLExbWndYtV+M81+KmBkAf1Nh1lL0r7?=
 =?us-ascii?Q?G+4dymKsHWt6raRbkNywA8tw2qrFj5+NWpXpCH53agCiyh3wEFsimxV2Bjmv?=
 =?us-ascii?Q?xsB1Fno1VBgIrzBxhwywV+PfY18TdKp3zw3BNoOAGyTzFAuD2k1oBaDv+mwW?=
 =?us-ascii?Q?Xq/vmBPWd+5gzU1esdRmu62AgeeoepsoA7AlhdCwZ0C+nsGHslSuzKRHtyp7?=
 =?us-ascii?Q?5TUpfIpHKShLsEOn72OgKnhDBO45TX6E2CIXcCiFVEl1sKjs1Xer98cU7Stt?=
 =?us-ascii?Q?7xToA3uO1//UgONUh/dASfoHhm30tXNscHK6zssvn2w2+cuc3m97nzjQobDc?=
 =?us-ascii?Q?VI+K++vqXTYmYDLKytSR1cGAQpAM/zQwr6DGR5ZqBGExSaUN0YsArucd9Akf?=
 =?us-ascii?Q?8/1xoE7TRQrx+ZxRtKWHXbMoW5IWIT9Ygtt4XBK68Q2HSaHEZFMktbQiBDTd?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ee0d6-246e-4ef9-8d48-08db9fc0ed19
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:58:36.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXKRbuGdALCYNM6qqtRLEpcBUrhyDQaGq/oOXrDJwhATzqlBPAzmbYPG4RMiWp2tkSpj+UIuV73zA/93q7YlLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

Alloc and init sk_storage in data_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 2962067568e7..b6a8a051741d 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -69,6 +69,8 @@ static __always_inline bool sk_stream_memory_free(const struct sock *sk)
 SEC("struct_ops/mptcp_sched_burst_init")
 void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
 {
+	bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
+			   BPF_LOCAL_STORAGE_GET_F_CREATE);
 }
 
 SEC("struct_ops/mptcp_sched_burst_release")
-- 
2.35.3

