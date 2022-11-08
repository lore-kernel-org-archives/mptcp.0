Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130072.outbound.protection.outlook.com [40.107.13.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4AA323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBnePrHXTQeJTxUr5l7tHEd9IMlLDKxSCj62Ex8U1oOgDjAr1S+gJNsU2p48wvNR8TUw4DffeIQgEbvrxVAohdh7zl6Gk4AdP97kri/YhCptvciwsvMi1tWeiex7Ysc/PG8JS/nU7y3zU6odei/chKC2Rzxym+gI6XtZnEh57VEMPbAOVT5XP4DeAL/q5H43IVd4mVWaP99bpEENjrqvmkmBoJNYGlkYC/Z33dT/0oDDXQe53sEnWRpDoy6ewKFircRdQx+y2nkcqy/w/pzqVJA79CvKF5tX1/SuljzPeEGE8f/6zpO3oz8jm924Ia3/db7ECVrNDa9/EfzwEVBTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=DBDt+mPISXC2mp8bG2aMrBX7cKP0+BR3Qn7cLjkK55DwSg6CEpXFXcTIg4Kymd9OUlhoyWnv5zyg8pdBjNGjdzkmE7dpuLeBOk1KLjWqUWX6iWkY40MRSKU/NaNb0Ec9iN9ivC44E62IIDsRqm0L/lEps0GhLT95kfalLJ7hfKWh3XMuG/D7+TFQoSCRs+1xZUimPCGm9Il18lku3BJMt6B1U5MxaCHZ2rCNGJ+VD4d3mXkPSKR0lbf0sPFCONjVhbJZ9nzqJNqmiJWY8gVg8zdVCmDqY51FO+zwIQ1C9tmvIepqOwp1RBsg2TmwLJhofT8uJL4NzjtjeBPLVojS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=ZLP7+lGhEZ0YXK0G3xciXQiCpiN7OERZp327ZqlHvcLBeRa2GRaA+V8RqyrwVVLUzBOLNnrPsRjzRYAWdE7kE+7rRM7hBK/iCmKKQa0YZrVAHwyo4l+h6EtwqXJGl0D1zfI38osawyHIoPftapmlaXyiXWXe8r4YFdZ93C1gLIJiUeRbgfWOsHNDq9/vxJD+V+TGU8iJYxrb0aRpulAIrLeR21AH/cpojZ6zJiQzFKytj/ieDZ3oHBKyhzJX9klmAq8UovVdStp4kYBckKI2Uk2Lq4nlTZyUJx4cOjbugfQZxxC6wN1N3CDefdw2soUKmycmk/QBZXMj5f21S5Wkww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7948.eurprd04.prod.outlook.com (2603:10a6:10:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 06:46:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:46:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 09/15] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue,  8 Nov 2022 14:45:08 +0800
Message-Id: <33a6664ea5fb5b048b2059b22bbfcf87161b9256.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f037e13-c88d-4be1-4f97-08dac154e5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WNjo5VTxRflywySV6dm7hVt7RCRbza+wJtYms7aDPQyDp5FZcAHyKp1ShCg6eeeOLPmZU59Wnu9zIroMBKl6Ps0lwMjqsjPaymqujMLnJDNH6tgiqnNDVKo07sJ1vKQdn6cuhWHEJKmbZsyZNRGzHPJP+mciIsfYYVqdtcq6M5sbLFGgKClr5iLdjpJCQeVze1BMsPZLLk2ZIZO138xG5SPv0Xmu2MVDzi5KRlo861Lf+hB95sTpMNahUTPcTp+NUxvld41tkx0zqjz/Uk605Um0hMiI+WwXTzrdHkmoyF3gOFP3+p9BENx9T2pGy1fPPCrLVXbwMypHjTpCtSyu7L3YbPTnvWv3zMb7TR03tgR8T1a/kJSn+sRi3/rDyguEZd0zoVnljpRc42di5XDOl74fKpAMeT6sbOwxx7iCj7HqmALOPMeyMkeovkT8v5u+eJw2W15mpHzcmAy8KwEZSWLm9GbW/YmFEbr713u7BARuX9OFw96v86FH5t/KhXJ/YN0gFslogZJsei0MZ6D8Pr3KqZUXs7XZACwqV9JhVK0XtKgLeLE0pXYCGhO9oNBp/MdAwhQCW5ubIHfv0UsBZu4D2Yh80dI94hF0wFHclbOIYaVUkmU888yxyY0ejvSmEjtGRYdjaFzpY1+KFcCXFGF7Q8eEsdduFtjRTEl3YySlD5XoODXjdwJ+tYQ8JxFraktnY0Ljjd8y1iAlwk2aFTTLQ8EvT6fNTUL7h0X8Nm/g3JMH4TXCJYXgsoM6Nlol
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(186003)(107886003)(6512007)(6506007)(2616005)(83380400001)(44832011)(26005)(2906002)(316002)(478600001)(6916009)(8676002)(4326008)(6486002)(8936002)(41300700001)(5660300002)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?essUXJK3L08uhpx5ctpHiz8uVjVJgbSEL9QHKjeOfchzX+ohe5Zd0nV9bCil?=
 =?us-ascii?Q?G8BJZLImmIqlgUlLRBYqMJ1o9vouFFyXvkMXa7ZTdTd4zC8Oe3TgXJojRc0L?=
 =?us-ascii?Q?Kov+2wN9vtVEZjY6DgHeYEZ+MhCdh73fYU2HY0yNt69HO1kRzXscD28776FV?=
 =?us-ascii?Q?RrJDLIhE+pGZICNLu0ufb7L7QxSm+qf8SzEv2E/XutuuTqYByoPYnZuaQxtW?=
 =?us-ascii?Q?GKkTclvo5dUO/EJAUJoE9nclYevmp18Ybevxp/WF0f4wrXkGv1EdF1yTWVSF?=
 =?us-ascii?Q?OXf/zHoXk0BT6yUNwOBlesptBfg+4x5KWRmtmc0jA/doFQbPkExwwihgzbfe?=
 =?us-ascii?Q?Uzv6x8VRxJPJyXwmzxO/b21vINUeQZ+lcO6AiEIPnXASNoXr6n/Kt99jIuYd?=
 =?us-ascii?Q?3+95d0PGTNV2Pn9aGY9Lfj6M4rZxvteD/p+WnEL//1Sqy4gLhsNUSv3RYQep?=
 =?us-ascii?Q?D7ouL59c/xY41tPPadwfxjwwh45PxqRoPct9Vvi9JDv1t7k+KtGkE/s5rNSF?=
 =?us-ascii?Q?P3X6qSdXNpstMsD278Yrdv075e6yZaIzBhQ9tHpjaVRGf93B82tY7Is7lK8C?=
 =?us-ascii?Q?FztzBIVQOn9pXuoqbgev7zuaRj+PBQ3Mu15EMpxDm/c7E4085b7Q3gdVxrBF?=
 =?us-ascii?Q?W21VDrmhzQ652mCa1viN3AO00LgEYfY8QKvomS3f0ptRrGBzQIkRCBguklT4?=
 =?us-ascii?Q?2Ur4veOt5NPTOppjmDoSrwfzguiZU3YWNH4nIVDPvk0cTCan9cOx8MQPFWqA?=
 =?us-ascii?Q?MNJwCyp4NWuK2y0vmlocsiQS2N3Vy+40nzgbtvthijg47Prg5EeypZg9Wjid?=
 =?us-ascii?Q?jdgpG3fl6waRiXA3mResVp1VQU5gkPiF6k5uOoVN9qRDhpr8dgn71Pn83RFC?=
 =?us-ascii?Q?i/ls2pV8OutfNFVCXwcouSJJmYhILSsjWiWeGAYEhJmOtoWetpFcfV5+bxQJ?=
 =?us-ascii?Q?bFSfcR25XVwbVejwy7sAdsHNOsk/ZZMqDclBLNGr/lBGYoFzjG+08a4kyV0B?=
 =?us-ascii?Q?w/XGCsKRtX2CP/3t32hv7XFfT3d6tzq2uyaWl7+ycFAMQtfm9aeMS8oi/Nfc?=
 =?us-ascii?Q?XNy5tFTOh9I1wrjm5B0iWSGaE1EAJK4x2efx6eJOVBkGIK8MPj+ZWO6I4yXR?=
 =?us-ascii?Q?YuhaWmcTAzEczMEc3a8XCylEqTrraJskseS4UxuC/cflUS4YXwm8hhsaf36B?=
 =?us-ascii?Q?2FfcAtZ4otR2mkL+iP3/QZG0pBBl/sjfM+dYxqDhvlpsIsUtixxuIsLYJQtN?=
 =?us-ascii?Q?C+MPSf1jkouE4XUw6y6M6TQv3V22uJ0DEBnCEHso0oRwSGFmCyFFzGwDWLgI?=
 =?us-ascii?Q?Pv/EFHoFfa3ablCTEseI1TQeHAB1Tt0oP/tSLsrUuhUjpTlFeDcLyweQNjv/?=
 =?us-ascii?Q?rB1sHWuKrTLb5M0oDS2NASKSqrsGu/xDqbk1TdLBLKsJh7ZyaYbSSltQ+UHl?=
 =?us-ascii?Q?vIrTATqlP2NmzCyhvHgRpkh7nOVbkFgGvwGA8AymGMKi0IMVjEARUS6zA+od?=
 =?us-ascii?Q?taiHZSTqPFg3rIHHFGJlTh0iCOEJadA+S9+/ZIMSib2QCkD+jG8eU4t0aIz9?=
 =?us-ascii?Q?7vNlVMjuXuLCqDuMeMN2cTpUO9epFyX8ahBMjFz5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f037e13-c88d-4be1-4f97-08dac154e5a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:46:00.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyZA1XYaV1aK/0boLRMzc5dMMO2a7OLc/PoshZfcf/l+KBsa1h3PJRDk/m769wvl80fUsJpSBrVJSOJs901/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7948

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..e101428e5906 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -35,12 +41,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

