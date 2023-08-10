Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B31E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFj7YfnN4sB/p+FumIon16M0PMDmOerFLutJ+kbw34Mo19HVjoQgdDtfJNmAQInxVyJZ58nafRABdkPay2V2ztJIHBdPeTGQV2zeyg7oOGwa/r8KJJvbBqfWjjcwe7A/ZMIWk2E0OLGq86IH1vAyZ7pXmBBfjWI0bBnaGVXyR/0rbBd5+0slkQQwEM0e0fRgBnp3D2CTJHAeaYMjqPPcWfh0fHg2dGRbnRTZv9CCl+khuax3GIdOM6Nlcly4VyBb28o6r7p6QsFkOtcDUa42loJCok1Cr9PXjKz0aQrHhywXTCmeJQOsLbGZGa6h4eit2JHtlej91NFULRzf4CHMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3MN2AS7Iz3lXhXQ24vD4JN7C5X5U3uOJWIod6iY8V8=;
 b=HFwiU+9IraMdnMlvX6BiPkDj203PbBcN20aH49cFg8z61JKJ/gQg32btk/Us8y1p+/+1zFCB7rCroxwXBhSnXKg1B6RxkKIkRY92uPwdHL+eMcy02TdwjWX8+lJKNHWclX+E/Hr55gYiJoOtSiGqzYRpVUigcCN/Nomusx2/1mBI9PPj3PG/sSWKAIBdrQw4tjc0YLypM9s6d7p4GuISaT0nEOn+puFk1Lhu2IyyOd7v8GG7nlgQ6UlTubhhNbcRPXMB94QwUdzk6tJJTvjLXQa0NOruyiFOBJXuBFzjosO4JkHY6dunUTeYx/nh7bn4UTufjeRziHGBAafdzIZ4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3MN2AS7Iz3lXhXQ24vD4JN7C5X5U3uOJWIod6iY8V8=;
 b=iRQ2PAzsGJvuCwXjbcpNugmAOEAlJhLae9/fpeUH00weclFqdNENegZuALG6eGNZ1BB8djv06Gt9ARcZRekqDZtekNEdzQIsHo76a0ACXWQhPh27vaZ8OMIATvQI5EAOsgnAQI8BMuUqVNdrXcfSOV4FX8C6zv/5gqNqD+kMnV9s/n8/xO6uIPCEIIKLvSq9WRu5M3dm23ZmGt39kNbs5nTpFco658W6LuKEXvNEqIETDAdRN2e3P5R0MvK0fWVQAsq+p6vbap6k1EbMj5Zobu51Y3eeMkajf/7d68a5owT+Hw3onVpzeR5Xmfnvf91wmqlrcvyoYCzJnHZpOfNnMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:10:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 07/11] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Thu, 10 Aug 2023 22:09:59 +0800
Message-Id: <b1036aef166e8021e57160a5302024526646de09.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c72fe98-b755-4cc8-f4c8-08db99ab97d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G/in1lyJGE/m6O7u4aMBOobBICq8VbXh9AmjwmgeZ4dqZexelwGt8OmwU1OY2OwBgwOKaieqlmQ5E8MrA2FuI0LuoegT75WAUL0gnKfVvuATJzxe0ghh8IJIzVWieN7JCzq6nbJtuE7YaVJsHDUMlVyvjpJnHZ02FziS0Tb+Av+m2DbZFDo+UuEYwCcc8Xg0x8lhGNtCJtabI4UO8gCq8L5nwct1BhBnCyuIfGyk2l7UnKtWeVMbwp3KuMpouhF3q2sdKOEPqM41/zqZR40SHs6c6du1dXrUiAd8Np9iTtU/8MrK/Z3iGcQqfRTeYvSAzml2ezv92Tu/yQBEHuya8GoAXirJ+Gg0a2EgF7cWPYmK9/IrzMn0AdevGMO/sXiK1hFl6Mpw3c4/Mv8r3cvehlBmyZZUZgjJHCbYZE+t1v9v1PH08QwXb++qN+Y36nsVQTmGl4cQyOT/awbFAlu/HebN0z+UhIWR4Wm97nFG4/EFFItVA0O00g1lM1SQR4bXFl/9ZTrcl8BvOYr9gO3eq1oLLCvWtn5JnUwtptwFjQbF01LQAMoqdKiRMf24nrbWCNSHY0c8bCU4t2kjKs+0I+6LLMfhrUfi7QlwkY4vT6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(107886003)(6916009)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(4744005)(2906002)(41300700001)(316002)(44832011)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmSGrwv0VV6GENGTG7VBQVY1BoTPT/qqdQ8gvQ5scmR75ajLsd32+niAwUOV?=
 =?us-ascii?Q?faqZMwM7xo7zy2iU0TKAJxXdJT5wfIhk993Z44U6qBIxRiJxYE8T4j36hoVE?=
 =?us-ascii?Q?90F0CUBNuzQZWzuDlL2Nra/kbbec+MA8vFY3/QAUYmeOO6H6IIW4XrWw3km2?=
 =?us-ascii?Q?9vH59M6Dkl2ST9LJV96fNp+hcPI6a/krzmyf0t0UjPK0Bk/mC5opcpY+uGVL?=
 =?us-ascii?Q?u+nufuuhJN1T0rFjD+YI9HMdDr97ikw4WnuLbeBuG2+dOYhm0eKnSHDoiIf5?=
 =?us-ascii?Q?lJSFoIPI4aVcoO9yYWZzIoH+Gm1wTadbVk9eNjCny0lbfO45gqeSkVAAdYGv?=
 =?us-ascii?Q?3aoQz90NY9a31Hb4MKYsyY4I1pSvaVXK5TauxyO0eKVvQ/yWySnt7p2BAA0W?=
 =?us-ascii?Q?QmB53+YNUPTeniv3IEogrC/uphMIPqzgJQz2/4oduNRP7V41xj1TyRh6aWIZ?=
 =?us-ascii?Q?VtqfPPJlrsNeBnP3yFITGjKcEbR+7RNAPbvcKjJKlm+WJjFXctB2SiS8bW8V?=
 =?us-ascii?Q?ErMJD0C+KbtkKjsCX8iqubV0efDlEhQYkS4QJXtdaBhzL0Lu+o5r8PyWc1ye?=
 =?us-ascii?Q?QRAfvPGptO/JhbAifJ//GQ0I2PiFFJFOHkTDEQ3DUhK7fgHx/wuevyQaIokx?=
 =?us-ascii?Q?uAgCFRgVnXjINZff+Qrs8Np6f/kspT+EE268DXZ6Jfo01kqvGZ4DOPYboN7t?=
 =?us-ascii?Q?zmEzgK8ykx/EPB1SO72IANMbOOfdxJxo0ORph6t6PCLzKUPvTcPpOjrEfmyT?=
 =?us-ascii?Q?WJvSKOtk/gwa+SBQWuHHFksKUpD8acqEJ4pVUa8ure8hYocu77yZf7/IccXe?=
 =?us-ascii?Q?qPCA46s9CCDludG7bj439lK2qshWiLQL3iKAyvK8gzLqlfyBHdvBmrMMbn1X?=
 =?us-ascii?Q?siNgfdMbf4v+/GeuPebkvVdbNnDgbnjq0NpjimPuK+lQ5Zuo5VtrPKMOu0bT?=
 =?us-ascii?Q?xCnzvcGh2mbZvraiM3KSY22ezj+nsFKWyYfPvwpliWgABdW/0BH/gSw7kQJc?=
 =?us-ascii?Q?KdEQNMXU+yglaoXlQoms+WoZZfORBOllF9THcSJLmy1x/Ti+bolIgh4VkGVA?=
 =?us-ascii?Q?W7DHwsWWw6mphngeEt93SMJyYN+sJ5uiIHbZZPhYdkQ+iU14tcK4czvQ5TyW?=
 =?us-ascii?Q?x/dHCzrfloAL78P5yBXmyRQ5NMmTuyqmNvnx/eWcqI6Ljupd58RQKcI6WXR6?=
 =?us-ascii?Q?NLR10wPV50vthEtCUdp/rximFs2IKotl/iDAx7T8pnEWZVE0WKUgQFBQQ+n5?=
 =?us-ascii?Q?BNYpzslfjbdGWfwpf6FdEXtMBMenwuMm9Cvmgd4BucRncE0Q5ApkyGV/MO3v?=
 =?us-ascii?Q?F1G0VPjPiAP5gVFMwh2D56oFDxFcvAITv3BthUiGMdVrBzYm13aFoIvfEA36?=
 =?us-ascii?Q?4PMpUdCulfqjNHWMFsFMExftJhk6kBkD+rLXKf8NUc3l3Op7LzIAwNYfrhtX?=
 =?us-ascii?Q?+BuHMVLaygmmcIhCH+Zw/Kjz5w2UZSOrIMv5lRLHZalec2Kqid3KkZEXD4xr?=
 =?us-ascii?Q?i0dHj56vmF/xEu3dtoU4hxZf8S5EEhLbDDwX6xC5pHSwLNYIegEC8axJ9Vur?=
 =?us-ascii?Q?2cId2p7c3q+MbMt3BX3Jg7nsq4It0YCOp2FCs0Ey?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c72fe98-b755-4cc8-f4c8-08db99ab97d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:47.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+oqmO5Rzlet2c5JxvEHe99wdNfcU6A3eNYsHc6u5OhzgjZf1GyXRlUk2I1pvv9/bs6YOuJimi6ZqhWghUWF8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314

Return -1 when no subflow is selected.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 21493a3affdb..331c8e7e10be 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -40,8 +40,10 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 		}
 	}
 
-	if (nr != -1)
+	if (nr != -1) {
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
+		return -1;
+	}
 	return 0;
 }
 
-- 
2.35.3

