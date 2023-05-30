Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769C134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldWLbhy4ggvixxTh2e9jwgPCLN3mx7tx2Bu518rC/15E8IG7Il2YrBfX/wUBA7vZApHvJvqFfxzncUsZxdsFArpdo6/OA37uCmrRtGo+scRkO0wZLBlZpaemn6c9Fz6JoVgWjaIk0YddPsowrkR2IiVBRIr1044SMBRZKsVsGgigAPv7OXteNcENd15+K040oY5E7DgYuXb4ZzGwFcUALFrjaiT1+Awqa/vhe++CBv5bqmTeBAMBBVz23p3d0QXlA4RT5aT4uW1bMMLWM/DmW/yoElPp4HnG83uSRffr/wHFkAHjswL1244vxc07OLwEocHNUvyDF2GGifAJVfa/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsyIBUfohl6UmExIXwILMxZE/VQci31GxF7/sOspquA=;
 b=HtS5bx7NkuvNM2nrWVnhf1Pk5fDdXovBV6+/nDxsSl/0CYpjtQMVkQTYASkQ4Yir5MLCrJ/pWRRunu/xRaEGVCHVwnOAs3mjxZPy35m+Uq/9UQV7/T1tbxOXxTmEUFhvbWmDbzF7m6/a7uJU64stf8tEYrODcEX17zX+RL2TlMDmrrrEHYNaMLcSjI8uithNoZ9npAasrXF+B+7BYre2hjFwqpgUmArK1GjtZnPW0IyHqAX9S/lIabWSyCEfqR7Kv67DhxnX/1WiKEWuj/nagYur0pPv9W4aBIAhJkeWDQ6vxTsDqNYQnf8JeVmowJ6gTwDf3TmnvADI2qUcdgDnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsyIBUfohl6UmExIXwILMxZE/VQci31GxF7/sOspquA=;
 b=gXXhspPLfid5mWzrx9YmEVW5hZzH31Rl1mjgjF9dx0wkBkBmqqJroy6n11aKhj5c2gc2Kb2K13K70kMWPdMB1TCt+2WAjUuBgwOJ53rBSDZxem6g+Z03lOuV5vihQoGWw/uJEks+xPr4FpjOuPIKdL8Q0JhxBwcULA9ehFDuHS2HY9awpbBgJZNrDaKwtJaGLohULaBwFwS35AlSEUZ+0aMgVQnyREmEc2DRVxfugE6klWbgQnnA28t9KVFhhUXMz/6z/oNfRIanViFsyt9IAnmSZILX+hyO+14S8TkheZkLNgonifVNmU65tnttZkAnsyPVg58Vlb1dXavBbxnARg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:19:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:19:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 10/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue, 30 May 2023 21:17:30 +0800
Message-Id: <d1970e4df2db74374e6d099d71693088dac65080.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7e18cc-b509-48e6-4a2f-08db61107740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AND90RUTMuapitNWj6bfECK2Wtrw41D7aOPNzMZCxSGfEiH0EG9qoa6HeaSuL5D/2zHtdyGX18KQDmMDujG1hsTTm2nL06Q33fvIfNx6SheUwqF80gmR54MG2mnqrbcRzBVthA8rYzuLU0N9xtm39OaMN8OsohyjgE1D+NyCKhEhvFn+p+4xUS8i/gvJDvWplJ2v1rZ2sXT4F5GmgHzMRdY7WHaonv1mqKtbY9ye2v4cgjKP7mSv6AWXwaa1Ql/beBO//05bnyMhVIx3H5SEtUZOz6vDqqcF+c3tq6FEIfLlYITvowOGyo7VTu9XITPVk0blcK/Cw4A9rCbmK+ueUx1j1tBIsj7OIdvcjR1WstOpjcArjAvrY9rQryqJf+1f/fx2PA2vBqd2B61wfCbQzvhr2Kb1V62lv+MBazn1cii823vTsX27x87wlUBNl6Gpwoek1YcUp2roDw1AkPXAhRGhWEhndcLBla+3u6BTzcD53R3dMzSkj+MoqBvO4xSx5gt7reBvs9bNr8c6Jcb5D9tA20JG/Hph7JcGV1X+uqty8/+Ou2gHABBe/Vf3gZY4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(83380400001)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/zddZYKCjOfeedMSXiKQQhxbxdXziIMlLtrCpuIrSPJ4EaMpMCiyG1FGvUn?=
 =?us-ascii?Q?bFZ2mrF5eDmEXi87tND8WhKX09DHYv8y81fL903DHGq1ICXAADK48UZEN9JS?=
 =?us-ascii?Q?JOtmwq/S7JHOnOv6MI3rS3zelvfWvsKS+8cWwi5TGSA4kCGOqWZ8i7GyaHgk?=
 =?us-ascii?Q?gc9LgZkRjzImRp1n/TQPPIxucCZOUn+m1ZVSg5KMHmdrF7PqJUuXtQbAJz1p?=
 =?us-ascii?Q?R9vSEVGO/b5J1TG6/QBwzSN3RIvP9TZoGmO/oFqR9Qlx9VALEDWSGER7x5FU?=
 =?us-ascii?Q?/CJmZpFOgb5t5xpp2ayvNwfqht++PnfzQiWl7IORLJ7v7Z/S+QeuKe1dGYJS?=
 =?us-ascii?Q?qUJwmJcCpuHTajvXv08cmd4qTidsdtiBwVHtUswqBayd2SD9FmN9bNdwbezj?=
 =?us-ascii?Q?4kxfibwJq4ggsqfyFn3HG5XY0DUYxad1o1ecm4K7Ui0/zM2A5m6JQ4u8FgTG?=
 =?us-ascii?Q?rfm039xCEudu5O+21g0nuciYvLLaYTeovNFkCXZELQAjAbQI5hLjp8lMYfxG?=
 =?us-ascii?Q?VY6x57wVCBopuU2L1UMh88jmRSyc5mDqo/P9+IIHygKNR/3LjKvmuqbgER8t?=
 =?us-ascii?Q?7ABh7YyV6l5IGSqmlxQPYgbU1rPlF1hagGB1I7B2E1zyqD9GTqDtZHXjxLCl?=
 =?us-ascii?Q?m4UeQnRa5hXjZC0NNmd3OGOUc261nlS9pys9UL7NoAvOy9lwEuSFH7VUcUTK?=
 =?us-ascii?Q?24MsaPpa5plnG5/UDT+JsVjtA2C/8S4/CROPlVie9v5IZQba6CkG5i5dSkn5?=
 =?us-ascii?Q?adBhNutJp+cqaEBn+tAsljzI1UZHfqQ/ZYXzT2bgSkbVZ5dABSfoTs4imNsk?=
 =?us-ascii?Q?7dqHt+AmuUwWogRGN0N28gG0fdhhtAkZqL6DjKPmxhwP138TQyrCmbBd7B0v?=
 =?us-ascii?Q?MvyHjkj6z9jxHtkDReHQj/loSB6S39eo7vwLMjls4RkjpSKQ4OQk9w08RHnT?=
 =?us-ascii?Q?dFf6unD5KCoyhCrXnh1CKagJ0CPEf4TAecrhMKLDK0X39d9ZF5hBMVg/0SUG?=
 =?us-ascii?Q?Ku8xAfAecWkopM/ol0qGDMgosDG/XoY/T0s9g22SAMVaqrL0a21FWga50772?=
 =?us-ascii?Q?K3VJr42kC8e/gAcywrZTj6twzTc0ZuBh3ZsHu3QPkoNsGZQizteCXeCWQjqQ?=
 =?us-ascii?Q?zM89/RxhaAhqAP+WeZHy4nj5a0b/DZl3butG9zaNVVB9hEh3iDZ9a8Bx/01/?=
 =?us-ascii?Q?Vikpt5a1ntKiXrZw97WPKpvhefrDxLlcZ3AojomCfFx7faOBd33bveFqdmvc?=
 =?us-ascii?Q?XoXqANo28Gg/z503AMDGJTn5HEwIK0qeuYVsAVQaPaLQWnO9rX9rDhl5zene?=
 =?us-ascii?Q?UIxyZ8KIu7/93RDDqPtlC4o0RkdzZQIxl+xDO71HKTm2kLwNXHlE+sINmxcZ?=
 =?us-ascii?Q?YRGojYTXe0Uec84nlKy7KV35lm+mHhKgkAaI5DX1yzppxv6HCltqLzy4kiAc?=
 =?us-ascii?Q?/fhAYJrGDAJS/XAmDfIngGyvJ2A+mq/a8TkNlqfRT6o9r6lKa9kG7L744SVO?=
 =?us-ascii?Q?DwC4rD767DBzzNAgkfDkWbheLIAmsSATPhpESyyxr0XEQP2wuC9rAsxBjYvc?=
 =?us-ascii?Q?HU7txyGduII3q/6wDHFLhf7p2NG0ZYCF17cuaZNP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7e18cc-b509-48e6-4a2f-08db61107740
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:19:15.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2iPe+PD0/K0RapTixm8VK0pGOD6Ogv5qCkpg9U3RfZTp7Zm25NV2YTAWmZI6F7ZDe7CYBkhWw5UAZHa13AM1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

Add more struct accesses.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..f2ce9acc2628 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,9 @@
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
 extern struct btf *btf_vmlinux;
-static const struct btf_type *mptcp_sched_type __read_mostly;
-static u32 mptcp_sched_id;
+static const struct btf_type *mptcp_context_type __read_mostly;
+static const struct btf_type *mptcp_data_type __read_mostly;
+static u32 mptcp_context_id, mptcp_data_id;
 
 static u32 optional_sched_ops[] = {
 	offsetof(struct mptcp_sched_ops, init),
@@ -41,8 +42,8 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != mptcp_sched_type) {
-		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
+	if (t != mptcp_context_type && t != mptcp_data_type) {
+		bpf_log(log, "only access to subflow_context or sched_data is supported\n");
 		return -EACCES;
 	}
 
@@ -50,14 +51,21 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+		break;
+	case offsetof(struct mptcp_sched_data, snd_burst):
+		end = offsetofend(struct mptcp_sched_data, snd_burst);
+		break;
 	default:
-		bpf_log(log, "no write support to mptcp_subflow_context at off %d\n", off);
+		bpf_log(log, "no write support to %s at off %d\n",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off);
 		return -EACCES;
 	}
 
 	if (off + size > end) {
-		bpf_log(log, "access beyond mptcp_subflow_context at off %u size %u ended at %zu",
-			off, size, end);
+		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
+			t == mptcp_context_type ? "subflow_context" : "sched_data", off, size, end);
 		return -EACCES;
 	}
 
@@ -141,8 +149,15 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
-	mptcp_sched_id = type_id;
-	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
+	mptcp_context_id = type_id;
+	mptcp_context_type = btf_type_by_id(btf, mptcp_context_id);
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_data_id = type_id;
+	mptcp_data_type = btf_type_by_id(btf, mptcp_data_id);
 
 	return 0;
 }
-- 
2.35.3

