Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B461620
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 01:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHRUEk3Ht+3HtgDMvFz81C8hWKeptqXxQGvldKqlBwevVE1+IePhjzXbU1NOIUmvTU5Nts594KXbeM0eqFfgL9+Rh2024Jim4uELJ5hAjb0BduNzB3ZzXl8OvgOm17yQ+6vPUzgUTGZCXYlIzpVUd8P/oBmIZEC3vw9YruCHuxcXhKG+gLX5MYXo8yWvpgIsxUKZowdOrIV0CkhBNMa5+0aMp/sLt52ZzVP43EGT0PATME89Qne+9xTAKFFtHY54SSRMMtuJaIfAKnPI6quqf+wgeYHLiEh73UFZgFIyyN04cUtbT8WOMmzMSswo+7qWzAuJC9wcGOjTX2e+v1HXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vIFpBGPvtLGGIwrE43pMNnpOFRRg86yVpFMfNELrUU=;
 b=JRC70F0j/BR6EtQk0GdfF1izbenX93RNGxJn9MAPer0uX2PWKn+YlP+3A+RDiUOdyvVvQPAHK6OwC0qAyAcJHBnVU6lUj2E6/4JS7+bhdqOMFp/a1sua8EAPSBXVvEAHucEWQ30leMHH6SRNy9SYvhnmr4CgPuluKa4oMSAFaNVglP/2SSJxAVLNVwHPNgYwh799cMbF1sDqlf05zM2s8KaDaubOT7JuljhbZBWpIdbmd/gqGZYtpUdJVo3N4QB+1kQ/gip+DsvNJe9wjiexepZuC9O8xHrf2skseN/Ka2lJNt7ANhmo7Xn++PHEouSBV5Ghk4c/dLebgNks7x1Y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vIFpBGPvtLGGIwrE43pMNnpOFRRg86yVpFMfNELrUU=;
 b=BffhTmuNYTQUZJ1Qt6kwwdQXvrgtTcPe6gKetzhlI/Vzunh/UwtwZV0xvzx6wDfmceaTu3z2IyJ1w/JTjvSj+T3s5FYCY9UE8622jKgfF2exucMjsuFdtT+q7vkD92+8PSZIbcyTC1t9O5T0K66neT8JEj6nOEdwgJOGwOHDI4nK/WwQR5OyDerJZzdxkcXMkMhK6c2vpVxEZiqCHhhcUAFZ2QIyKi6QkVfKMLPD5XOdHdC+FPyxIe2QFJCIH0RRul0gPk24ISawPP2atWXPf1IsBhULLXUdAAxYQNl+jZE1yG005xgZg1Oa6h2fNxgI6Fymj4CN2+tHZn3HTo/bGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 01:36:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 01:36:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to 'Squash to "selftests/bpf: Add bpf_rrscheduler" v11'
Date: Tue,  4 Jul 2023 09:36:03 +0800
Message-Id: <0b57bf87dc30e15782ba1fe2e925a7ce6ef0fc90.1688434547.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd855ec-825d-4be6-4a87-08db7c2f06f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	utm+kT1uWXIEN77AlA912INTcEksgR+5bJyJpZNDk0T74kRB4+E0DMA3q1RETSi2BewYonv3ohtzrHd5LTc6N1CsXECBeYuhfivKHf9JffVKnb3bqal8yc9KeJKQFVt9nJb5K+e5SumcuaoYvMKzXRoEqGlHSguzcG26GakDtHfsDCvIiwk5I3A4kqHKwv/lRa6nGs2Qf1BJgfHLyahQ0y7vWR4+VR2P1nDdjhZHh02W/aMrMDZnS5kDpj/PRpGdr3oGvTbeSrTHrI/WQDggSlXI8YEMNZoUGQ8cLpYPbAaMWmMKGXnptBp29Gdc5YRvxl01T510mmbvr1jEedwaJkLKnFumx4KiOgtoyhRNnz/gsHUwRybaxSSTWW1YTlyR1GJ6qPs6SzbDPshzEqBgbfESlkuauoG5FBqRtE5jkcLfDnaIgNdzBnZrHoet8YVKAsyMo8T0u1N0GbEoTElCzee1u0TOPDCTw333TPM84unHt6oMCCSQvEzTeLXU/3/kr+sMK626HGXb/A6oWugRAeRi2+lCD/K7uxlTH/o6Z129sVIRbAQWBhDvilcqKONM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6506007)(6512007)(6486002)(316002)(6916009)(66476007)(4326008)(66946007)(66556008)(107886003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuF8E5FDDLJOP38LwaRLQJqYEg8nxKMW+UCVnLS/VRhuqyAW3bwQ164HV6hP?=
 =?us-ascii?Q?PBtTZ6asHN3k+nVMc9oE3U51bMpevYHapqgnrBbICv8VMU9IJXRCfuPWP5We?=
 =?us-ascii?Q?vrYOw8VHNUfdYqYKkYmGJtePMkowjrOVhkF5GG/i3U7nZYU8HHNNdVsienop?=
 =?us-ascii?Q?+z3ZsmEPAVNzxgzDMLZXX86Zo1BUZxysqDP1SBSHn8pw4vb6B1oBzI+Chp1k?=
 =?us-ascii?Q?z6erBV/58X++lSQM4+MgFgxBHDUo7Qk4jIMJExrQMIbGVwE0kpmMX4+m8N2V?=
 =?us-ascii?Q?5IYYvDPB+a68Pg9r414XL5shxycxCdJ5Ma0X1ulysPDLkAXPg/4blv7Qq2Tk?=
 =?us-ascii?Q?liX+Ngo4lcc83/YiWZtF635NlTF5dlyvnk+R3ITwR1uzK58Fw9GBAkVm3Rlv?=
 =?us-ascii?Q?2UrRe2fOOFlvBeMI0BJ2ciee7c5rwkyVZN5kHrBEmAIZgQbfiBzUoilQRfNY?=
 =?us-ascii?Q?/yX8wwYEomMxmOyEl3IaC6L3jCQevlgJSQAgeEl8YCc8ceq41j+Fftzu0A2e?=
 =?us-ascii?Q?j70/+NXCX+FMKxS9UUC3iQnW0F7vyxd6ou1DefiJt4QLnkCeCzPmfpULY98X?=
 =?us-ascii?Q?f7WhE3yNNbfbFpUjz4qrtCNsaBZimBSrRCbN35rUC9wsGPttp6TSgDH+i0Dz?=
 =?us-ascii?Q?/aeEFVmnQoUdg8dCahkcQl74/xnDt1QkFT3ebiOQXLDzSFR+fLB5qWr03i3/?=
 =?us-ascii?Q?SqeJs55n+PWEcYwwcC2dT8R1NgE1ltOwH6fPRP3nCjkCJBrGnVVQCid+OXT2?=
 =?us-ascii?Q?0LYgNpMcPxrq2LCbTxUngYkxEJwyci7AmFKrkZ4UJvLLOO/F7jZ7nS09QBz1?=
 =?us-ascii?Q?v4HzIpeB919RYSxyj8vigheV8xuUl3ZSgf+HOiiQwRglrQjBS+TE05PzzF/4?=
 =?us-ascii?Q?4Y+Tnb6/5dfYYc5WB6Njf/lb/bXJkVsxlJIuhgwPffAueGfVMFpBozbjZYZU?=
 =?us-ascii?Q?n5TD+aC1ylFNzso6YYw0h4N++mfpnMqcnT3bXWKTRCJZ2llrgzhkvQbr1X9d?=
 =?us-ascii?Q?7o9Ul7g0nqugI7wg8qP1KjXOX8wccfwAWQ1jip7RbcHZMH+g0RbbecHx48nI?=
 =?us-ascii?Q?WgX8XjrCfRLHl71Y1nb6Jhj0+n4wJJINbtV2iU0IA1rKK41JPaBOtBAetFx0?=
 =?us-ascii?Q?J6OaWxCqCFsHJrP+rji5sULaE9ojTmeOoYbKFjrz2/CAbDdF03rZxVYJEbxw?=
 =?us-ascii?Q?da5LbNyD4Ch+vgR9zBExgQPDTGP3jGekL57xHlPFtWhaCBloanfJi7ITtWNZ?=
 =?us-ascii?Q?t1y8kWORLEhXWpZqn2Hb/9NQG/ixXRTIpODH2SZfUT+6t/r8d6oV+q/0mgx4?=
 =?us-ascii?Q?ncYOAiTNu7XzPl69/7UqMJup3fyOPnunYZuemLEZQYtO6JIFaC2Sc1l0lDRj?=
 =?us-ascii?Q?ePGQzbl/pOaks0LOAAMcB1fVLQX4QWPz3hAwTh19vAvttkvsLc3zioWacnHS?=
 =?us-ascii?Q?/3Me8MDWOLfn4yNoZoELMUqTHRiqZNo7dZFQ62A8PDGHk9zkTHxvFT6nrkmb?=
 =?us-ascii?Q?FhmDYYQDoxPWrj42qfuyCLp7QSgqG0QNUnqsLxcvyrLoZa7ZwQGhNNc5NFtR?=
 =?us-ascii?Q?Q7tlrMdvf0tZvMlK4/rZ0Tp1XXHNhKipXIGzxghT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd855ec-825d-4be6-4a87-08db7c2f06f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 01:36:02.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AvleODKYLtdc884R30nE8uA84qY42k8uDZskbkF7TU9AvOAGtz0nkRvH9r0myBT2P9TrR0ePtcOaeL8AgyMKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

Change last_snd as a local variable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 21144e96ba56..8d9442996e0f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -9,7 +9,6 @@ char _license[] SEC("license") = "GPL";
 struct mptcp_rr_storage {
 	struct sock *last_snd;
 };
-struct sock *last_snd;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
@@ -40,8 +39,16 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_rr_storage *ptr;
+	struct sock *last_snd = NULL;
 	int nr = 0;
 
+	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return -1;
+
+	last_snd = ptr->last_snd;
+
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		subflow = mptcp_subflow_ctx_by_pos(data, i);
 		if (!last_snd || !subflow)
@@ -60,11 +67,7 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	if (!subflow)
 		return -1;
 	mptcp_subflow_set_scheduled(subflow, true);
-	last_snd = mptcp_subflow_tcp_sock(subflow);
-	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
-				 BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (ptr)
-		ptr->last_snd = last_snd;
+	ptr->last_snd = mptcp_subflow_tcp_sock(subflow);
 	return 0;
 }
 
-- 
2.35.3

