Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D87AD30
	for <mptcp@lists.linux.dev>; Thu, 24 Aug 2023 07:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlO1Gr5o+oGccc9CqPotYUq86wbHm4wmxsNbKG8/8Kz89p4rzY7CFjwv1zwG5zZ8LHH28Ij5PVE+UgR+V6JQz2NNG4S042aHETh+KlOxY5hHuU2iaY0Cn72JBQYTwlv2+9dqHctf53U2AEnjIxoOYXMcQ+rM7q/01g2U3l8i3gUKS1I8KPXV4xHakmKtfIzKABlHvos3p0RdB5bHqAVBFx32gyrrlwRCL5RLcpYZAVPK5nNE408nLMYIbFi9SNhWVLAoUM69VqratMhLl2FuR9YoY7yQp6EXe1olU+kJNn6LjoSeDg0y0KBDoBiyTqodtTQaldVep9oaTbfs+MD3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65b69FTUtOCpGcBaI29cPjyjNR/BFNd4Dj46L8wtjfQ=;
 b=MvRQi4Lqd2exJqaWdm0QHqujF51JDd9ZTt6P323vO/Kbho7/WD8IhAGj7CL5CDyFIUBNumBvqZdsaUMaOwg4sfnC0WBKXQG4Mo+jjtsTx+SufRFjiO51UhznF3mR6BWQQqajFvGFUqXhFg09TMtnPkEV/FaLXFC2Dh0E3tuE1btgRSIgMl3Xb/16A8jxDcS3iAAN9v5Bix750dxroV7VHs5xCK3XlkQ1bG+YP3OtHad7SybmRPo8j/WCi7GJfeEk1FpWxiNBzaSt6NxCYrPRpaClTdIAI1Jzbg/bZtFkPwOBzqh1rwabhnHWhq04aevGOA+zVuZjRHdT2peeKOeFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65b69FTUtOCpGcBaI29cPjyjNR/BFNd4Dj46L8wtjfQ=;
 b=2C4T9VU45LFWSnQV69hpqfXeOFkfqi8eD+1xa9oaHp1Ov+Cs4994mGskU/CeB8lRGiJsI9Qh9vN+XW5vytcsybenu9AJ0ZyaD3gC7nD+e9xF8xQXqSFXHlKt0RQF5kCUnSvP8pyHq1XcwJ2Oo8FLM4cZU2k6fqYZEPySQj6cLTK4I1ZUrcflha/e7Bwj8AZvrdKdHmTRh/jpcvuZrI5to0h2nkXEt9L+k39GSolHH/YFp7X+vJ19Zz0luP8ujp3eoTLr/hf154sqwp0e2siiFhIdvlEv/eB/EDk3TrfNTdw8WiLh6gdH6BJGuZuIIEDcEzpjUxTNLCWKVJET3JZQJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB8190.eurprd04.prod.outlook.com (2603:10a6:102:1bf::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 07:58:33 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 07:58:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add bpf_burst set/get params"
Date: Thu, 24 Aug 2023 15:58:59 +0800
Message-Id: <31a37c83652b8829317dd36fb2a5e4c8f0f65b0c.1692863931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAXPR04MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a4d1ab-3054-4683-15b6-08dba477e9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rvOfJAE1xHsijEg5umrIw8Nk4n6fI6om1zXpn5LTqaZlPSU6VlLsT9gJQi4P/BzKkPH/QaUQTDHLlDtL3BVUiMT/Mn5omJKPehMOfOuTwtPlAcicDmMBfZa1Dg3yP5NmvV/6nWqJEXrhgmyzkRHDOcKVVceYAKqwUOLkDidWyY/5Y2LTV0LeKOdzvlUrwSdLsPpRhLAx5jdGWKntgqXh8MbB0IzT7V/iKs1ol286632TN6PaNjMJcUfvLibtHBDN94qdrr+2vfLX743Kea/FcryK6WChZkTfShCqyVn4iCZdkU8zUnS70Kb9DOvgiSVgxHS/CBuRVpoUwTbaG6qn0+P22iE3LQJdVItTBjOuONEs5Ly4yxtfvQ8vO1AIIGLUF6mx81QGJYDwISlerVhJjdaHIuluHPO0YmfNwwSu5G5cbNv2T1gSI419vcZxd6D1j01s3DaphMdiqA1sb1wh3OkFTG6G8UYbiWoiFoUI/mw1T1KbbQpij80aRLl6Plq9E/xaor1xK2rXJX4Lg2MhD0Amj0UWD5pYwKJ6kZ3oxyCMfQXG3abb014/b5eeGxrJm+ZsRn9EgIbdwCdeg307aKv3vBqOFyjgvbvnh/VGvAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199024)(1800799009)(186009)(966005)(6666004)(478600001)(6486002)(83380400001)(38100700002)(41300700001)(2906002)(26005)(8936002)(6506007)(6512007)(2616005)(4326008)(36756003)(66556008)(66476007)(5660300002)(316002)(54906003)(44832011)(86362001)(66946007)(6916009)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hxvn5wnwvKz2WYmCcaV7kx4oW3jrsuyuIVX/RvtJvmadI1vatdRxGUkCqRoR?=
 =?us-ascii?Q?JaOsInZGVeIuUL8Drsew7/OwD4DV3HTw0/JpQmYoqZdxbVXkDFoD8WBScdf9?=
 =?us-ascii?Q?9AhmoPERKI/YqNdZ9L7z24gy+UXV+OVYg6OqaTP71gAijy/Pxyg3dwez8ryU?=
 =?us-ascii?Q?QExOogtrypfwXIjCK8XxpD+w5U2w9QmCTSSKvqqF/ssiQD69Vyd2LA1St137?=
 =?us-ascii?Q?3Z+bFy2dNg6xI9LlcnwKxP7o9Nt8nd0mh47TMHHEUI52+M9zFPhIRCF2S/Yz?=
 =?us-ascii?Q?/XC3nQSQ/j9mK460GBcVZ6ovNi6dG6eGQG1nzpf+CXVyy8Py/kyx1M5rMThZ?=
 =?us-ascii?Q?wZhrD0MLpmQuxHHEHaJilkoVHk4nIYLecQoXhBIBBw3Rq4xMCACkrsichTpY?=
 =?us-ascii?Q?tLpRGMHtIHSOFfVVkXFYTa+WgQhPqTlREtN8zcQm3l2LM8kSbB1Qefxe//H4?=
 =?us-ascii?Q?cSXcRxvT5037ePvm66F42bxEhhwWn7l+WfDrP8GyuOVncCKLH/eIZDV/BkNn?=
 =?us-ascii?Q?5uaIR2kRs0Cd5NTPsqsUtiCGpbGd7raksb33VNM9RU09acnZReVkt46ibaWU?=
 =?us-ascii?Q?R1NrIdchc+wyjf9Wf1aqZuz4gVfixyEnrJe3gH8ejkSZlj92saIl7JgMSWzt?=
 =?us-ascii?Q?kGw/OB0ZPAOiVNVW/8/l6kfOgFZ8XEy5n2boZVWf3LEe86UwxnvqOF6uf7U6?=
 =?us-ascii?Q?OWo4kSL/2uBhuIJySju2gzX58ukw9Qj29nKW54LcuYQ/qh3mtx+SR0tMCw78?=
 =?us-ascii?Q?zFNWfObwxh+JRSnI42tD5hW2l6QR5TbI3X2aFgI0tOYXEO50EE68HF6a6abo?=
 =?us-ascii?Q?Jyi9sT1CQt6rN3GcHgMS5duXY3dp1XONFYVPJ/VYI1IN7+uSEUqGJHw3GtMZ?=
 =?us-ascii?Q?1hzwUSIyEMuFi+fmMoj3f1YC2kDzEFQzFzr/rMEZtrpGKKlh8O4hxWNXSU7+?=
 =?us-ascii?Q?AT7/IbpgwQuQq8UEEpOr3CjDvluFisvrnBd3s4nLQ9SaE0XDQk9qHkVsZpBY?=
 =?us-ascii?Q?ZjyApN0wJitsAcgwJ30P3v4wKre9TigkG2fAW3U2VcfGf2RltKegYf+JgL6v?=
 =?us-ascii?Q?sDUzOBBmiqqMfESZ1bUmNrlWFV5vXCmV0wow5H5qvZ8AjHHzvHBYlrqC4lVf?=
 =?us-ascii?Q?tlwQJjSRPu052Pal2wlnc7GO/G8otPQSewB1C9bU2Gj3zdTJCBPd2NKUN42f?=
 =?us-ascii?Q?s3oQO4w952s5FLWIJikt5wayiteMnxPDHtn7fWVxA02Ndqn09pIAZf76LxFo?=
 =?us-ascii?Q?9tJWcFX5EwUtjouqDxX7lGfGcystBYUNAKQ35Bv60MJ6MbXA9tYcHnZrFpvn?=
 =?us-ascii?Q?oob7Kiaq0BricqYBlMbhsVXRQsRhoran7mvlUUHSiF0nFe5C6Wjho4o1FsWl?=
 =?us-ascii?Q?dAFUK2ECIWVZmiT1azKT62daErArozpQHw8FnCBymUJFhC3KzARw6ejqff5l?=
 =?us-ascii?Q?PIPpGRYgESJpz0Q0tQ8FdkQbg9LEXALB7VRbc1P1bk3L6vw0+Mt/faqFkZsS?=
 =?us-ascii?Q?/uuJeh6tOefI//0GDssGj0xY4MNPo1q6/CZQi5f0JyntheIA2iL6MOlT+l8R?=
 =?us-ascii?Q?0GX0JKSNw0+TduA6xnpM63HutVFQ6ydB/u47RD7h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a4d1ab-3054-4683-15b6-08dba477e9c9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 07:58:33.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLJd25kUrYfKx0I9vtm1fU+imKlAeRwb8r4wjKRqSTWh43OgjfHxK7Vy7Mqds8qeRrQmaABo6aJNRcIEde/N5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8190

Fix errors reported by kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308240536.xHdtOcPf-lkp@intel.com/
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/bpf_sk_storage.h | 2 +-
 net/mptcp/sched.c            | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 805142d59d02..4251c8158b9d 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -60,7 +60,7 @@ static inline int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 {
 	return 0;
 }
-struct bpf_local_storage_data *
+static inline struct bpf_local_storage_data *
 bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 {
 	return NULL;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 067df28899a6..23a9e4f2fe5c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -208,6 +208,7 @@ int mptcp_sched_get_params(struct mptcp_sock *msk)
 	if (msk->sched == &mptcp_sched_default)
 		return msk->snd_burst;
 
+#ifdef CONFIG_BPF_SYSCALL
 	if (sk->sk_bpf_storage && sk->sk_bpf_storage->smap &&
 	    !strcmp(sk->sk_bpf_storage->smap->map.name, "mptcp_burst_map")) {
 		struct bpf_local_storage_data *sdata;
@@ -223,6 +224,7 @@ int mptcp_sched_get_params(struct mptcp_sock *msk)
 				return ptr->snd_burst;
 		}
 	}
+#endif
 
 	return 0;
 }
@@ -236,6 +238,7 @@ int mptcp_sched_set_params(struct mptcp_sock *msk, int burst)
 		return 0;
 	}
 
+#ifdef CONFIG_BPF_SYSCALL
 	if (sk->sk_bpf_storage && sk->sk_bpf_storage->smap &&
 	    !strcmp(sk->sk_bpf_storage->smap->map.name, "mptcp_burst_map")) {
 		struct bpf_local_storage_data *sdata;
@@ -253,6 +256,7 @@ int mptcp_sched_set_params(struct mptcp_sock *msk, int burst)
 			}
 		}
 	}
+#endif
 
 	return 0;
 }
-- 
2.35.3

