Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78552890D
	for <mptcp@lists.linux.dev>; Thu, 24 Aug 2023 13:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUV8ifaC3OJHL0WvWpVTDq54rWuX+d2lN4AN8l8L8bsa291Cmk5cnYChXA3QPkMJWRqK47tqAAz9JQzv1yKAw5vHEAjiIXO/ocCDOHrGdESCCsOktJumHphiUeZVNh/IckTsU8BpNjr9DG3DsPqC21qm1aEqdWxklZn1B0sO59/fEdyIgA/hGbwG30l8SsGvWVOnWDLF55m2Qh9wkomzjThUH2ZulN6e6O7vDdTi6DgU6oNDA9/PaLgzRIFZ1DgHnsCrjkOAujq0QNSzr5CfcSpHBKN2AuMUJkwzpaz/dNXhGkAM3DaeqTCe6BukOEibBLpVVCTdpjHONKecgi+2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qM3JD+7FAGrcC3sI/j3IXK8/OnqM/j3tzBFJJQrRalM=;
 b=DLz/Tzkv1g/pdkiEf5NZrjuD0CjfTeDeY60ouHJPRwL1jsYpV/AmJTnJ4aAXqR15hut1qASW5xX4CbBczJCpjrGX92YM2F60P2C7WLon1H/XZiGby9xUBFMtc9aV8BCjZxxJau5aklIUIZCm1o11Q7I4uLukh/Gy9MWxl0wAmatCVoZ7fx4llX0PXrm+sPKg2KE7yuSZ41OuN/8upH7cfE8kgLKRW9SroK0sNIq0NvyTYsMbF4tAnC8jyXjdKU93/sAjzo6c5WiKz2dozHA3gxGX+4v5viyy3IRZh5DukHSMBuHGK8Ogfaq6dZxfdePlJR3L4vSVcptivI43tSgcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qM3JD+7FAGrcC3sI/j3IXK8/OnqM/j3tzBFJJQrRalM=;
 b=JtHVisCWTOYaevRIk9PNo85AaUP60O7xhTxUcWcnIjMKFVKdKGQfLj5pPkE2odZNvCPw2kG58uWvTUb04SiFchCLkvC1prm8btC9nbxvmMaEQnUn+IRifPkLtVv/WkVKBlYNBk307D4yeNJFveV7t0YT9ppTymK+hLtoe3QYloBSl/NHJ8oYau7D8EXr+59HynWqkp93LBKM310rSY/TsJVtAw+LzDBSJww1sJWZu/zftn0aaQuWJbg/fWnunsSixne49cb9WqDZrT3+5MPuXVO06YAdZ2RzONa0587FYayTmT5sWJuLZ7Bt1NzVcbdXumB8Mja1BoNxHx58j7WfTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB9707.eurprd04.prod.outlook.com (2603:10a6:102:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:59:31 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:59:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next v2] Squash to "mptcp: add bpf_burst set/get params"
Date: Thu, 24 Aug 2023 21:59:55 +0800
Message-Id: <ea7a8cdb1b7f606503998bd156e2732815c2d528.1692885554.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAXPR04MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: b176aaf7-d567-4ef1-27e0-08dba4aa5696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qKr69EaP8PPZMd45wMs+Ruvh1WyFv4pWj7Iqr95XQNBzgFUzKs6tx3lEB8tDva/nGpT2M0116IgWF3e9+XbkSY9HmS5YCdmwfR3WbMC1rh/xbIyn7RVHVn3rmfibzAiWRtNyjyufqc5lfdQKDRKaP7cLAL+uDcG7GbvbBf8nKm90SQb94deBNAct95qxeuGipQpyHd8iuLkzdcq3kn5nIt/CMCUoyc+eLk1BkfEYcjefCzBRdTouqzvJ7pihtfX/YxkCAqxBbbZt9fQDLNNmkZe+kyRxW7LdqL9KJ1RDX0FZgII6hpmBwd42ESJurxZqpAniYXoRKvZca16d9jOeaAkbbY4yzuT4YD3od12o14XllrS8cgY+l5PShYPOWfWWjuKEvUkRvHKJyL2G10ofAE2XrdMw0CDNZVLVDqyP9bv4cslrWczvac4SpMjzm5vW7bnnWUE7v7XWZhKRdMyfU3nm4yA6Ycd4BthNtgKyVP06tHpsXBMaFwBekl/lqe7r+B48A4tIBItbmUMzZmICbefsgKDVNVetbJbjxAti9IMYk8q/gdjGE/5iGe/OKBjB3d2EyEAz6XKrAhCA0aHF6kiMPcfRi1GIKDew8YDDTFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(26005)(83380400001)(6512007)(2616005)(41300700001)(66556008)(66476007)(54906003)(2906002)(6916009)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6506007)(6666004)(6486002)(966005)(66946007)(86362001)(38100700002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KtWxlmpn9d+gTVyTv4Essxh8tsrgaJxMNVw4+bl2NuR2s7XmEVTVyzyR+szE?=
 =?us-ascii?Q?3RdAPwRoQGTgigz7FGfvpTy/O65SnfZaRdWjb1ke4s4eyrJSbLswXQoNs6Sq?=
 =?us-ascii?Q?12VIOdJOsfTw9vcc+lmwmfkCBQ0xVleFcRsjctRD3nwqnDMpLuJQB4Nj6YeF?=
 =?us-ascii?Q?P9YoRXVYeGC8DzCW5mcj+YCKu/3HAn+e0yeAAMnWfldI5UK5MZ75UKyQ5mm3?=
 =?us-ascii?Q?2qKCY7/nX/7mf6D8oLuWoP3rrpKZu0GwFcXS84iEJJfLlIfTZrugciTjwaxZ?=
 =?us-ascii?Q?Oa9UvjJHZsylK7QbYszDbO4ilJsnGchPp1Dz5UIdzsCMWvVRDEiMpDExMI7R?=
 =?us-ascii?Q?5EUZcK9yVvC3qj+uyUY1y/g7qGllYIPrhGHAMzW5TuvplN1X1/Fkuw7Agqo0?=
 =?us-ascii?Q?6YC/WyPZhhaOMXznvqWOv1xaESRgPOZOOcp23xbJk/8qWFYZv71d5NdOvYwn?=
 =?us-ascii?Q?FucF7AAEawvJ8Amz8mKOjjIlChWg9MRY1i+UFbT3hCmdg4mnIDFLz40Ep7ZP?=
 =?us-ascii?Q?HUolSPMHRGmYnGBam65sbnGBfuA1Wc611yXxClCF4XH7j3wjAi+UOE7iZXsx?=
 =?us-ascii?Q?IPYKBeaPc1Deaq7gi+m/zjlV+5GB8TlFlCVdFPEw6LvjyAFXuiuKJbfVx1GO?=
 =?us-ascii?Q?FA0EjGflYzEA8rbTiNirgBoNxqpABB4Q08DibFxrxNYYSdi/Y4LRtu49oOTZ?=
 =?us-ascii?Q?cBUjXn+mQ4EyZzgyZ4aRii0MZydunnPRZjQopekvTmFJAj6rWYDUfxasSmSe?=
 =?us-ascii?Q?1NokkLxeAAS/D+MIUv2oGnVZB9b9HmpG3ns+xiTbxgdqDN5wanJjF6QL9S94?=
 =?us-ascii?Q?2iLGmX5nyqSA8KpGB5b2WsWvWnWWkf9NSJhjtQZLYFkrC3M/27WmPAWUNcz+?=
 =?us-ascii?Q?D4M0JrH2aPDbFdo0FBVM+zv4LhafafW1W6GugMmIAi2PNjmpX/+o/A5EvoKB?=
 =?us-ascii?Q?G5p4sKYAN35u2dXIjn1azsoRzVnKmfmFjuOBxoYtJl6JC4d6GA40swXLGGjb?=
 =?us-ascii?Q?j1weJ137ZbPefPPiSCs9NnnDjqtqEZY8XctATP4nCsluMiXoHW1C+MsDKL8X?=
 =?us-ascii?Q?Xq7AZUiPJU46lpC2KCGS21umqhA9Ik/Mc+oHTDrE1GjOrDlRn/1JUVUBlhxS?=
 =?us-ascii?Q?EJjQAQgIqFr0NR8i6K8qQgyfxjip7VKW+ogALHzeHl+DdeEHkU4z84/X0QkD?=
 =?us-ascii?Q?wjX746OeBjVqlm/93bkvEnBwTW3ZKQWzLLrUn7VqbxRfFdDVUeGnHIgdf2K5?=
 =?us-ascii?Q?HzD3dr6tMJq7g46pMFNYIA0MnfLPD5XwCfJUxtE6DXLQ04K0/nukfpZPc5oU?=
 =?us-ascii?Q?OgCbv9wqaXFK2pywk12BZP9fMte7Pee3wWbHW8QXKhcIpcNocyn/r7geKHQm?=
 =?us-ascii?Q?6pZAI9qn/fyLCSfq2qssZimtMH5+jb9Ub2uVf14N4jIhGLCqhsv+qJw3UpkJ?=
 =?us-ascii?Q?yTuNTNPPenVueHYhkI7hNfm+G7IagRnx+ziA8NqV5J4mg7pwzN1hR6gfQWMO?=
 =?us-ascii?Q?v+zWQC3GeyfY+GPxil9RIs3QsFBYmIgvkDolpWDzEkwmm1Cw2EpUbCy7kX/Q?=
 =?us-ascii?Q?znx9RLS0VLczFyoReXwOe+xt4vXGlDNGy6L7b5FM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b176aaf7-d567-4ef1-27e0-08dba4aa5696
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:59:30.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZXpS8Xq1aq8nxVBlmhAbmMyOQ1N8jtq2855zEmVzkMlMVG1LXI8SvluOemoejxmJyIk8+oB7b5dMcP8Gy8lkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9707

Fix errors reported by kernel test robot.

v2:
 - move "struct sock *sk = (struct sock *)msk;" into "#ifdef CONFIG_BPF_SYSCALL" too.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308240536.xHdtOcPf-lkp@intel.com/
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/bpf_sk_storage.h |  2 +-
 net/mptcp/sched.c            | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

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
index 067df28899a6..54345f753b1a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -203,11 +203,12 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 
 int mptcp_sched_get_params(struct mptcp_sock *msk)
 {
-	struct sock *sk = (struct sock *)msk;
-
 	if (msk->sched == &mptcp_sched_default)
 		return msk->snd_burst;
 
+#ifdef CONFIG_BPF_SYSCALL
+	struct sock *sk = (struct sock *)msk;
+
 	if (sk->sk_bpf_storage && sk->sk_bpf_storage->smap &&
 	    !strcmp(sk->sk_bpf_storage->smap->map.name, "mptcp_burst_map")) {
 		struct bpf_local_storage_data *sdata;
@@ -223,19 +224,21 @@ int mptcp_sched_get_params(struct mptcp_sock *msk)
 				return ptr->snd_burst;
 		}
 	}
+#endif
 
 	return 0;
 }
 
 int mptcp_sched_set_params(struct mptcp_sock *msk, int burst)
 {
-	struct sock *sk = (struct sock *)msk;
-
 	if (msk->sched == &mptcp_sched_default) {
 		msk->snd_burst = burst;
 		return 0;
 	}
 
+#ifdef CONFIG_BPF_SYSCALL
+	struct sock *sk = (struct sock *)msk;
+
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

