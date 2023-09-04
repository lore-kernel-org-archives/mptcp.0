Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE87E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVxuGKL2lKBSK9tnWD93gXpyBbWWqDLKReDndIqtUk1n7Mp6MP2kuPUUow8ZVh+zjdraa3QT7pmVVgx+v/Q7ggOVRggNkfwXPnzSo45mNus9a/v9GScShamSVhWFyMzeOEvRgSihY8CaB7XZp5oK8mXwR7v94WNa9Kh72YPsol7lcu0hnUdAX6TqblVm5YiT3gtqwyTTmPbGq9MtVLWpxEFV91mE8tLWQtFnbz2Ds45ou/LfqVDW0mRN4zLg4EM66xmW3/BUYVSvkRxfvfxkdF6veY5mkJf+pa299QMhMHmWXBBWDHBCqKKCH+A/8f6irx6Oyv7694HjBOa5vW/yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYqa9HZci0x/XAgz2JQmqwe8ZjdquiDBw+rW+RQ7sRw=;
 b=exK2lJT0OUETa6oaIXha/sdAY1b9UnU8fIe0kUXTkrH6EsFyWnIDsy0GKGKMzehYECouUDInNN+KfKeKcGEFfLs1+slt7Hh30Iw3XEuCPWngLTX98oWipqb3qA2TTTg58AymYjYVavsqGU+fUo1xnkaXZT2Bo9Z1L4zhdUi7BNqkM5oU2os0BIoh4lVyoqu4NI+ez8KsZs5WUO9UVhnaF1WuspIjDMYSsyWIKqMnmFmTnPblWlpcBBQ4vLgPqDdg2ChAIhXO5HmN86sAlxOFxHcs4w+YoGvtF1Ulnp376sTxvsVMWaSQRSNffll3IIwcIKy7QlaK4lhIDEreAOBNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYqa9HZci0x/XAgz2JQmqwe8ZjdquiDBw+rW+RQ7sRw=;
 b=p0OKU9OcEvbTanFlNAymq9DnYn4Eb4w3w1d3V8EQSME0dLSDSGxVAp7Ig95BZI17kbm+t7FUoWDFYYoWvfCcKOjQU5NaIysOtHcQlcGgnW+lvZS/hgwvGU79UjMd9F+DDTRECpv8fYGM+D9KNJxOIkeKCIBvJekx2EFqlqRqGKLtJRzjFyrKEY2iksuo8RAGJ/tslXncv6IKURumI4rTuOIcQHeg6PLY5zo/eKHM3BgoAC8PdK+uofmwg97xL+/Ut8vNqRahJ5F7FFhNQQqL6A3a11/+7BEH0WK8B4EhQboQsvz4XrECdBNnZ1GZL48ahZC/xB3AWyyWQFHHmNowcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:39:57 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:39:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/9] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Mon,  4 Sep 2023 17:39:24 +0800
Message-Id: <48b540697e7f8f68d5eb69d383bb719cd8111211.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0288.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 575b6877-7381-4a0e-2165-08dbad2ae6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cDIDzDu4zpn/PNs2XkjtFsMYnjXb3u+hW6CyailCn2/qfoR3luzPbxzt/4/5uCO3kJycYZwYtm/D5TbDxntg1zusm4r4WCglMbeL9kkzyTu6y1tcCxJMJt4/ibRiiTh0MeY6g1fue3D9m0dewFfZapdYBiQOvwi4UM8oqNdr6r4rPlJcQMCvc0pbxfSyUXrXiqVedf86/QSV0L6m8S5eOfhFTdOXjP6Kigx5ypRlxbuTja1XvZexqL+rH3pxVn7M/4X2IB71eKBiBja+VUT9Yj2/SzaChhX1wVAGM51wsJXPco3rmoAkyCKh31AnJzoP8hQMcLmiRk527xpD+uLGIKE7Sd2WvsbptgKWJ9UFSvyVSIUKvDGorIvicxZUsiXhewSJf+Zw3IeO4+cxmQnB4LzXcapsl8WK+WbnwB4yT1Z0kbbD5c2QqICvJTKbc93vB2oBgKDamLXK2PFmJtUMuwx3oVkYOB33P937KUCDfpmxrW1dVqU1FtLtM4w1Yfona9wBM5qg/63rE7jMWxd3o0p6ugEcaWt2mSbSfseznYXFtSf3IQJZzRxreia9UG/6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(4744005)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZniP9gIu4y0n5o/KWxLjSZHV+sjxQAWnYlJcSFLOMOizeWH4EwDtIEQriFT5?=
 =?us-ascii?Q?fMFJ1mah6qz6PtAfYZCKACbT+s+fOOE1wUklBjYR3mtavYN7mgk+WwWA8nTy?=
 =?us-ascii?Q?kDl1EiqLbdOhsnMPrmMbKbY4G6GQAJ/Eg4bHpS1NezALr/ko8DtYTvtsUIs6?=
 =?us-ascii?Q?4SPHUPGYoNwJpxi86ID5vaakRZ7Lh7G31MZwBtFUeWZmDQxc3ti/iZGsnEf0?=
 =?us-ascii?Q?+BhTM9EewUvRt5jn4Lvkji9XIpwnKDKNmfOIW4dK7xuUI916B8vdRz4iEDAA?=
 =?us-ascii?Q?9cCXTiC6oLAcYqZLzwZJzeMOPT5V2dNvtijxs4xbwsvPryfL2JW9oLnNW/9N?=
 =?us-ascii?Q?PxCaX4TE+QVMvM3IWiySIw+7AFqvMQjDefxKdo6xJQvLm4c4XXRK8F91Spep?=
 =?us-ascii?Q?pbmoj+giTomzOaVPHQBGr7DjvauSjwZc4KYWYeNC8JwwW+i5rKMWIlb+NAay?=
 =?us-ascii?Q?Mlzp/1M6l+j4nFq0LrY7NvjAtiv+7JHziwGdcxrw845l00qZ0pnBKDAxbo/J?=
 =?us-ascii?Q?7zbW6HtMBlOZ1mG1NMG7rbLdr0Ru2vHCUZNfvxEzixjaZ8VqEwl9Pj5lIe7M?=
 =?us-ascii?Q?i5pdQqrxED/dzczaEAZ68yoaujI2/zBDG2m5eeFU7tQv8H6pn46DUBQPVtpP?=
 =?us-ascii?Q?OC2h1bt4JgcoY/F6eKCGTDgya+VRs/O+p7SWAQYFS4GUpbdj26+xpkjRQ8dI?=
 =?us-ascii?Q?ElbIL//Tk1C4ttUVFPLYJRippZjY/I0gJlHmX6DhJ+7vOtRbUQ/l+EQjwreX?=
 =?us-ascii?Q?OZ2hvkAjh/Rgt/YF0CGvcRyPcNN0dUowoPCPkKp3CY3MTi/+Vy8otPNRBG94?=
 =?us-ascii?Q?ruXAuK1FUjuzGql+G5LaVLm0Mm2lScbKcdzIRiaLFrKCeAykmVXqOwSry/71?=
 =?us-ascii?Q?M/0DV+BVEU12bpyY3PbbJPswvSJt6FRigOmkFVTN7sjvzw0NNo+ITkSccnWl?=
 =?us-ascii?Q?BoJ8PGx9TDIGc0q+POtAko+RaxzS0KmMtoNBuDs+Zl1gwFmxAjEuRfrHWP6b?=
 =?us-ascii?Q?xT7/O0nMhaqBBPaCC6fBQ8Tb1ZkJhUVYNS0Xf+ainUIHna4DDiL1ey9ctAqy?=
 =?us-ascii?Q?37pimQnobQ6Wz4Vm7jv8ErPM3LPcT/7/iRYO3NP3zIn1TgOrrvROHGfYqH3k?=
 =?us-ascii?Q?KE8uy5k3ehfqX4tNr6skeoyV46OoQr++qro3cFcxGNZ2fZmt3khRLGzFm1Ul?=
 =?us-ascii?Q?Ki8SllTaXgOWaIYfLn1DypEBhTmHWj3PRmLYsoljyUkn3fqsTC28h/2oHKsB?=
 =?us-ascii?Q?5rJsBmMderhh/kl9D9RIWoxUQ8X8NKfqxxWrEeZzd8uRE4gAqyflVvfZaB6A?=
 =?us-ascii?Q?gqMtB8DzB0hLUdV5T5GqfJAHSJZjDiUHhQDUkuXCTK1cgfYdYcRf3V/wv8JA?=
 =?us-ascii?Q?a8OYO3SOMbUBzuUJmBRWYAFdlqtQK1AS0p6irPNg3x5O0h7qYQxOQ2M1riNa?=
 =?us-ascii?Q?LxHFIxp0rkW1+eBwZlRz8a0GWoMr76mcpn5z3iNcFZxV3+Q+JeEtZcA6EHkF?=
 =?us-ascii?Q?gUwBbuBGtmzs9b09OA2dOBEjXLXgsotu2E6ABy5z4EmXclictNv1F0aPQnrq?=
 =?us-ascii?Q?BJWqVAvKv4I4mUtJc2e+cdSSwADrRsqe6nsLycNY2pDXlN6ZcShJVKvxs+xC?=
 =?us-ascii?Q?mCikA9/K2ntjqopgziUEvT4S8AaeFdaAFkfIiWnU3Win?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575b6877-7381-4a0e-2165-08dbad2ae6c5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:39:57.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XWt6N4avfv6SSvxwpL/F45bstcSnG8LerbQ9MS8XYZlOs2/QWWCwU8v1MlJ1ZrCNAfui0kxCzTJXY50/qCHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Update mptcp_sched_data_set_contexts and mptcp_subflow_ctx_by_pos.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index ae0eced5b91f..23a3e8e69e8f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -19,8 +19,7 @@ void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
 int BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	mptcp_sched_data_set_contexts(msk, data);
-	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, 0), true);
+	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
 	return 0;
 }
 
-- 
2.35.3

