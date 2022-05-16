Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA9A52
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 05:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652680257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vchjx4DhsIARecLe6LsnEDCM8klUZHFsMkBEt+Jfmj0=;
	b=bxxBQJJt3y1jNMYMIiBSKBJAyJcLd+0MxxctLaL76h/UM7hxJ8Wqx6UWc3nU5j8MWy07dj
	nQKVAkqdR9UqOu5NoedxFCiaFZSIYs8sivni330vcgFeuAgXfXa9L21rR9O+xMnqhEy2aL
	HjBy7g/M4Hz9LklFb+wZ6+Ykiwvtg3g=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-uIga4nBzM0aGa8RquYdwzQ-1; Mon, 16 May 2022 07:50:56 +0200
X-MC-Unique: uIga4nBzM0aGa8RquYdwzQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey3AZJE7bjR+PAMjZGjPh+hbys+AkJBekkxkdkDF3rP5gYSsWo92sWHyleqYggAYSuOl6JG0p5uFFruhDCDv6KjMvv9wwJYIag2lIR9aNzSyCS6lNUpMHjHSULRsIxsAPPL1sTlJOlXr5AfFIanGX5x6F2p0kcjlG7IttSFluyZRygK4mS+QCvD6a3PehzSkkymRyGJM4DoiYCOG0BPiLvixPUeBmCSdhPYnzPburgxGoy+G7IGXxC0xtRNh9J8j01U+adq3Z1xbxdLQ7iSC8eK66Rvsi99jEX2a0mBRctCByyPIC01cE6WTnGPkKVlgclQ6c/15aWP4O2jNmO8gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAvVZB5C9Al5mrYrEcs6V7QO2/ye92rGq7rthnPXEOc=;
 b=CyPyd6Nldr0sRVuFQdiuZN4BtKqDNj/zeOD5ueZEhWckCZS5n8ZDqcOeFQSH3wwut5BBltMLzLRwgQihaV39Z4vF98qrutOHCZZqK8NI0h035rDi+tskP2ugimAArNXgbqMO6m2rEp4muqcJINulDbLZSv3ruDzADItbAdxdTe9Pzs4udr9Uir9VlVecWBtsxmkRUal63yL8AC6UwuIB/S/E3uXnTfykYcBqQvV/iDVwaUZaiXiansQC3DXhFN4/hCEHLn+52IRHQGiVS+HHk67uTTn3506qKXLyQs1kt31Y7MsmTogjG7dOpRpNtFtaMDu6cVCe8lcCJNwabmsT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8208.eurprd04.prod.outlook.com (2603:10a6:102:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 05:50:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 05:50:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: test bpf_skc_to_mptcp_sock"
Date: Mon, 16 May 2022 13:50:56 +0800
Message-ID: <f625826dad272f44039bf6f8e35fe18196d5ee08.1652680232.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b9c8a5-26d5-4b46-4b54-08da37000ac4
X-MS-TrafficTypeDiagnostic: PAXPR04MB8208:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB820814DD6D019CFF23C324B8F8CF9@PAXPR04MB8208.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fTxhrjtvhlTyBmzfvXumNDc7TnT0vXQobDYPb8pdS/ZWIwh3jsRlGJ7hg/VVqbLlu2+KLDcdV3mQTy7qGzCE+oObSrbf0uHfYdkODycjALq6cP2tbDqeQ8z3HXZ5St7MQ6yfy6nrcdA7NMqfGrmuvK8oNAHX8BVLUpOxQajVPOd7vEnWTCiFOyUw0pFPve77PMjXukCCGEVMEogYJkh7etnuWID3RvgPMZhkUuupzYxLOLRhu2VptFXFIDQdiqUcCzuH+wByy5bcaKNwAmmm+/gpQyoMp+eQsc/vlxVh+SELMFP9MppNlVxTYUY4PtzfnLQPC4+Pz77mKFiTOaOtoK8x5FuZzBiGF6KRt7G7TecmpxOgZ6TudZCBcKsrZowweWNnxX51n4OqXSPLii7ixs/ctVTuOp95jhGakpuIfOMlk2DjH/S4B7HlaJkkUHpto2vSNxsujKK+pA14LZHkqsko7nXA2SdDRhB0MYAT9yO2VGRkVn3x7RtjTLKHjmAvptDmtUpbacpSM92l9U3Kd22b0bTNWNdmjOFpdx+50Wo7OL3yE5aklZTXrbhECNthBH/f0V+TNjCV6rxvlRY6MKSZ3emeFmCX+JVuBIL/LPmWWzROGVCYaucOHTqgqe+1+9md2n/Xgvc6lYkkOtBpaV1qmSgrODu4vO8mwjngnGgmpGIoI4RB/tYiJBiMJqVSRcAGUXXB4UVlESQ7ZoxE0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(6916009)(186003)(6506007)(83380400001)(26005)(6486002)(508600001)(8936002)(107886003)(66946007)(44832011)(66556008)(316002)(36756003)(2616005)(5660300002)(66476007)(4744005)(4326008)(8676002)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9klvJggYCEGTsIbUt56k9TjtSKtu5kfjqKfOAFGwZ2yBjugIDGA67/c+vRdq?=
 =?us-ascii?Q?sljfpGmUkJcKJ92diX6Mv3LQZkIeSP5xdurwj9PcdLksWcBedTZrFPbDEdNh?=
 =?us-ascii?Q?vJFMKx8ztVeMMsIVqF+hZXsuwYLkyOdzsaTB3o19QvrXIb/oZoFkAtSJDSji?=
 =?us-ascii?Q?DS0zIHTiHqbDbfISoNN+ylF8MSkMtRgRSn+4FUSiVRqBe2I5uWdKDotyYGMm?=
 =?us-ascii?Q?cgtH9ZiUAgHo8N259+X6jCPPhavvjWwbRiZOHjPbZ2cQWQ1AySXaBCcUcBbz?=
 =?us-ascii?Q?7WXor9VY4AECRWzQCIG5Zhe48+5S/wmYigG2h+ON61Uvti76v1bE/1Uo70R5?=
 =?us-ascii?Q?9vJVbflLlf1lRBecEkUIS3RR00cpRE8ZTzSQD4JY1wNnk/zpOZjs3v6bAPJr?=
 =?us-ascii?Q?PciP1jzgTlcq1B46wEN/GA90x8Y8CA5HqcL3MlCiQrFKs83mUjPmDfvQAaTJ?=
 =?us-ascii?Q?F/Yp3M4Hm4wyggwpuaNcUHNSdi3tonb4qa4x1Iu6sjOlt/9bTYhOywY2b3Gv?=
 =?us-ascii?Q?1zbBsRRuuzNuxh9clPrkVaY62VWGnx1e+ainOC1aXdUnxdPbgd2ALkm5FBhE?=
 =?us-ascii?Q?8WrlU13Q9WO9LemCGsSswgDhT5Ptx3HYz6x5wIA9tH6rJURhZJNCVd+YdsMw?=
 =?us-ascii?Q?wErnkoflgtSIY2qU/SCCUnQEVu0vHgCrhnJKFb+m8BVs/gDlqMzXWBdRTExj?=
 =?us-ascii?Q?6oQm0LVERPx3ZmX6OOb0NckZxQQKdPnPPsvzDgVGxcpO/0do+QrQFX9HRs3w?=
 =?us-ascii?Q?VmujURZYrDFiT95KHAwyb8pCya625Z7qebs7gQvZsrV0azb8Dd5dtNGWwVMR?=
 =?us-ascii?Q?EAl7p6SU7H4qUIT+//T8OU/abC5fvFfISuVbo6Y/JwlhF29dUZg6UcUzXrVc?=
 =?us-ascii?Q?pGQINiBlDrmPY/1/qBEjyL77EnrZxyRa9bzv7gxd/R5Mz560p6Jukq5FmkqB?=
 =?us-ascii?Q?9GOLif3WDgSLQ2wAGKWLUat43RYlfUcNNCE6i0NhyskhWt2vLhyC5WpCd4NL?=
 =?us-ascii?Q?NhSpP0VLxfe+MYjYLNfwGAYHpZjdvKWXC7uycY16Q4tuGmu/wYHVGJIVIwm2?=
 =?us-ascii?Q?reNVeJexsz4uLDoU3MD/gT099wn73UgmQbQ0rU3GrXH3LRWGPi9UZpemtzLe?=
 =?us-ascii?Q?wH8RkffagT++ofgYQLZA1w90e60lk5Z+wFJDASX4R/Kby0m4JTvnZzP1U735?=
 =?us-ascii?Q?+d1wfENEzrXsdEO/21P+eZgLsrBYpKmFrV10XmgdWupyrl9OE2kTfqHCUXU0?=
 =?us-ascii?Q?Ngm9sgCQ8DSsZIH6Q9bwtUtGWLayh9whXdXB8vDNlRPsTJ/V8Zn5GDKZ/rxc?=
 =?us-ascii?Q?Vs5k63v6zezBBi306hmq3tfr+KXdp4KHcLUDNh5eV2ooOqmxLzu/nkD/nnQ/?=
 =?us-ascii?Q?YeAUFLirr3p2c0zVHfqFFUcVqqD8o/Wa/9l+JyUvMlh2WxHrB28rU+/NqGNV?=
 =?us-ascii?Q?B4EMgV2Ofi/6eSKUSosfTTJg2Xl84LFy6je2zceNfgdiy6D3v6B8PPVJMQom?=
 =?us-ascii?Q?kMzjdkYRcaGyFabHbmn9NRkPFxnEa9guTcxCKe4J7PcHEOX7ozQZtYq8AHAN?=
 =?us-ascii?Q?rTQXLZsgyoBYMBiTt4xV+SJq4llTFujt+dLhIDBQ3elYFnWSKSXq/llksMwk?=
 =?us-ascii?Q?flKJfjjfDqJf8x6JPGEjkmk/i4mV9EqxWZYhqAvmiPu0mCDHG9hqD9Tgkq9c?=
 =?us-ascii?Q?DwTrgawysb+GeSnAacaqzhhYjk4kIKfTPvM7DORAlWqz+rY2/7Z9pk62f30a?=
 =?us-ascii?Q?toNGGFWKNOUFtgJ5Bj4cmL1F7QI2roY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b9c8a5-26d5-4b46-4b54-08da37000ac4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 05:50:54.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A71QQwqZMezuqFon9BNjBcTS47fC6O/Dp4A8e7H3Vl9oJL8AVW7B/G8d6AdLbq8ZrqVJryH7GYz8Fwe9BCI3BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8208

Fix mptcp bpf tests failures on export/20220514T172044.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 25e1c8e6f905..ab135edf3ae3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -48,7 +48,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 		return 1;
=20
 	is_mptcp =3D bpf_core_field_exists(tsk->is_mptcp) ? tsk->is_mptcp : 0;
-	if (is_mptcp) {
+	if (!is_mptcp) {
 		storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
 					     BPF_SK_STORAGE_GET_F_CREATE);
 		if (!storage)
--=20
2.34.1

