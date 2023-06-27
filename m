Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1287FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuA8o1F6MEIiH46pwX3Pfe6I4VrVRtYPHx8fiQNMsIWlB5JI9xvtgCmIxy7u141CXtFkmxB9zEPL95qY2uIPTYz+Cpjv17dOh3i3Got+V/M2vEaqk6r7BZppFPdp3a5Fl1mgDbKmD8dFMoZVukZR0c5ksTlKG8u6MpB+JKCTVI/ADyeEtpTMlHkb2IlGIjyPNYS52MGZEpG/+73vljAXkZJW4PGIzkwmzSBl4Ju3MERkTIXR9e/Bi5YAy9M8nHD0bAYVBLSzXA7x6JdzhbO74tYRD9q/qzNCI2/GNJTteEnjyGVaSh9vnb5TxnUk4RoqC9CrWgSvvey2xmQcAorsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2M21LhEVa+TV4kVcZDTDriCjy4o26GIos576DA30Mg=;
 b=H/T196LlzpvA4c6kOECU/3TlZjp4yeq83UUyBTDiYwacZ2DVHNt4Hc3Qr/KeXgu/6VPAOIVmRbudtgWj65bEuDcFzYZl3jRw5KYxPIIsm7bGVOynDlvDmyqStVt++U8lHggmxXoQOmft5YNe/glLggA+oeAbCMsNgTSYoW2ezYWWZd8ElwO7y4n7AhqxlZBGzZx70VRcBSn3WPL3UrM5LVEiM3MYL+xqZNxKqsOaBRZNnkRTaqtVkqzB+QhX8pPnqMSzhJEHkb8T8OH0SEDJ5Ivuz07JLRPainQnNJmDiAPvJeRtaRkbgI8v79CdO962hq/rV1F8NSynWxMngiUhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2M21LhEVa+TV4kVcZDTDriCjy4o26GIos576DA30Mg=;
 b=AceQmsCqa+iAQ+MaPrHg05z8M4xeZbgTL0CIQmPujDKBI0vM2M0bkry48OiCdFg14gnDMvOrMejlp9TtVwZbb6HVLbwvgLhryNTZk6LWNX0NSt3dXTAGwkQW7rYCdRiHSwED2R3VSIAQLLboIgDEZaJBN5IkeqWC7Cmja0aTVSAUOErHuZGcNf4Dc0kR3u4GiNmkft0sjD5//n6WvVYdS/svz99PkizIEAFCw96vImZHlrYIsd2KV6z2OkBwR9zwikUtrXF53Dg3PNdQp1vzo2MrXqvp0z+CAvGv1M3PJ8SUmnWK3mPTthtmnmq/I3zvNepumsRTodZ08GxmfsHxsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:08:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:08:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 10/11] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue, 27 Jun 2023 09:06:53 +0800
Message-Id: <664d3df8d7d05c3cf5d092b6fe5c8e418a44cb16.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 187baab2-456b-42bb-0cbc-08db76aafaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ISPPw8vfYx6D1IW9bEpSS86RzpQKlaGH+EASjAvO23figJ82kekxEYYFaLMtfHXIXVxbjoMET9OG7YAWEzC8wCj/dqnbeS7/Uh82pKTjBInO2CF6+1Wf05WpvVrDAx6VCyMx23MNYE2ljr+ufS03OpwdLpxvYr4BXKFVAMQ1HnipLAxjV1LRwbpO6nx3mHRoPeo3m9E+lY+euNI3Kp9xs/ncKIsIBCudu5CHxsSoAYoE3nyfCfVD/KMqUHz741+jtN25Y/4Un7UA2jF2AGZxQr7NSyQI4bblq6zhtFcRmqDZ6LMgc6Gq/lKuCaTL339+arQsDAQqGS1u0j/tIATLtxBf6jSx2HwnI3jetpKtMuTGw1c4FAU6R0/yIGXK8+BxvY3ez8PT/fzavbrbZuFBt/sAWK8y2J9Kf8kKJ8j8Ff+tVC2ctrGHJFVeFfF23730Tgq/GFL0XXPGTuCJ5m5y36Thw8+wnXmCZAd/RMeIBaw4JTcSeDETR9HnSc+Asu3neoVk2TRB1Fh5s/rET8xNj/P+esvGk7mkK+hYxjEE3D3rFPjwGAb2Mi8Xc6WuLBCt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wt1b47GNYuqOqAZ3D7OyXYfVZhF/Et2qclzBbneA9OE65eChP8lGn/xUKcQC?=
 =?us-ascii?Q?NAH+83W1o+NaR8e2VSbly4smlATnehHke/Bt/VEDFnqOCuoOKKhwn3GFdHYh?=
 =?us-ascii?Q?SWqGBHyyqWophjZIXKN+IcJDdqdmQPRaZfFQZuzGYWrD1H3/iNmhEWBeVAxf?=
 =?us-ascii?Q?2J2sbCDCV9yveEaEi7d5bFOz5q67lkN1dAFQ7mMBbGrttdB6LCxMz1Gr7mdh?=
 =?us-ascii?Q?UHiFxST7FLDshE25w0MaTFnBtX8YOW1XnE37MygxkfsW1aFFUDkc0N5SDoF6?=
 =?us-ascii?Q?Tri+PBQKADGIeS7BPYIxuH7lUGCr+3c6EgnDM+TyYr0X2BgEuhscCTcZb/pu?=
 =?us-ascii?Q?2dwHwoEwdyJodAJaAD0S9RebiKEuLp+5UUETK1nl75o9IACIX9vF/Lz3IOsi?=
 =?us-ascii?Q?y1AjVJWvJJUyUFM5FGKL5pF8+TfwTLXC8tgTVIGCQHKlDcAFxyqkLuA1nnv9?=
 =?us-ascii?Q?t6JNjtl75eS6ouv/Qx+vdj9qEuZd0LC+/b9LLVDblC0xv2nTkQUDoLo3IMDt?=
 =?us-ascii?Q?3UcGWmSSu4vMuZLfFprQ68a/8Xw23nWs/fbZu/Ixi5PeOEAyrk/9+wi1Sq9I?=
 =?us-ascii?Q?hCLrjUv6IG97j4llot+JiNZcJHWZ7WbU5AJ10OsqRTW6tkAm0bN6cxNioPnI?=
 =?us-ascii?Q?/lVGTH928klR6WBDgl2YrTRLE7XytoZd8yMQao/t3ifY1CiWn85b5Lh1JUvI?=
 =?us-ascii?Q?UdrYo6stwWO2qm89htAslxOaxROeigHqjpyFSnC6VMsxcFP2Ouees3qsFrPP?=
 =?us-ascii?Q?fOzbp4M8qqtLmRJaDyZndOk2IZCCfKrBY38Cyq4AbGM7HYiWTto1hm2oNxzo?=
 =?us-ascii?Q?ifhVIRkORBm5JdLW/zi6wCd+k49hJk0+ks2lubzJPfO+ZVYVXLdz3dmLt1Wf?=
 =?us-ascii?Q?HUyU7sN7iEkfdXRpGx/O6oTyH6zR4SB2PN4Nl2eH6bP3bznKqgnivnXPW/lI?=
 =?us-ascii?Q?c7vNgROpQiAEuX/mydjJQ77gb1s9Mxley/Zh48DMCWkyclw1p9PZbZ8YgYV8?=
 =?us-ascii?Q?UBP7wXzOWX77JEutWJ/XD5ZyJLVc2W0mUwo7wE3Wg+lLWeOheJ68JZT4mWqg?=
 =?us-ascii?Q?wdPdwzMLHx6KdX2SGRbXIe/nzYf72AHlRb/7JlmxS4Xd6M3ylxyheJl2MaEt?=
 =?us-ascii?Q?aLq6gRuKd8fhwAv4OVy/Z0Vkv+1GYwlMo0Q4PFUKV6iXwuWfLzXTY1JuSdms?=
 =?us-ascii?Q?wrVWLleyNXPzA5cSfdyWli1AFF7GN4EyzYrru1wCUoLlmczEouxa59TVPeJa?=
 =?us-ascii?Q?dhnMp/ono37EmHqeU9mG8E+j+cWAK3TpsAR+razdEEAkz7olsEldalXALPhg?=
 =?us-ascii?Q?GXxO7pv005OWqcBLB4lPYpoOlh8gQrKCEOyebVAyawQlD2cPMcWVT7x0/KNh?=
 =?us-ascii?Q?PR+7ktlqdFEe1OtgYp9dgfLTZJm5SjeEdiS7vnnLtiMubmBN/u2c1ZBg5dpv?=
 =?us-ascii?Q?APhIet1NrOB1mrp1kOt/aRdiA7zqZOJeMwevAsxaDf3OYaTfZqUScPlVd7r+?=
 =?us-ascii?Q?FHwSo8RXpwS5LMBjmICzUSLe2IYrc9Q4rZ9KEbzfE+X4/ZDoZ+8P8yEmN0Qe?=
 =?us-ascii?Q?JrfVY2p4UvsWn6+XKBoPAOiqNEYhWUqluAgQbw/f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187baab2-456b-42bb-0cbc-08db76aafaaa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:08:12.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R//0cLtzMVve+Eou2sbu0OxLbVtjzLT3z8HanX/z8CfqhWHr8THdVm/KlG4xcVxw+ADVCvbSSCCj9c7JHGDqAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Use sk_storage to store last_snd, instead of using msk->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 44 ++++++++++++++-----
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index b4b766c7a68f..945dd46c98c0 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -259,7 +259,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
@@ -271,5 +270,10 @@ extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
 extern struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
+static inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index e101428e5906..21144e96ba56 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -6,33 +6,49 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct mptcp_rr_storage {
+	struct sock *last_snd;
+};
+struct sock *last_snd;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mptcp_rr_storage);
+} mptcp_rr_map SEC(".maps");
+
 SEC("struct_ops/mptcp_sched_rr_init")
-void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
 {
 }
 
 SEC("struct_ops/mptcp_sched_rr_release")
-void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 {
+	bpf_sk_storage_delete(&mptcp_rr_map, msk);
 }
 
-void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
-int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
-		   struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_rr_storage *ptr;
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!last_snd || !subflow)
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
+			if (i + 1 == MPTCP_SUBFLOWS_MAX || !mptcp_subflow_ctx_by_pos(data, i + 1))
 				break;
 
 			nr = i + 1;
@@ -40,7 +56,15 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	subflow = mptcp_subflow_ctx_by_pos(data, nr);
+	if (!subflow)
+		return -1;
+	mptcp_subflow_set_scheduled(subflow, true);
+	last_snd = mptcp_subflow_tcp_sock(subflow);
+	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		ptr->last_snd = last_snd;
 	return 0;
 }
 
-- 
2.35.3

