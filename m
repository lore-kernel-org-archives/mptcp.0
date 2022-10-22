Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20049.outbound.protection.outlook.com [40.107.2.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF87C
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 07:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs+W/9ufziya4b5fvi8OnEHCHvTH0q39FyReEX8AF4+jOwpGf62W4uCg/TIbxhOgwetPz5ZPhT3ot6cVp6ShafSDAgVkmaIvviNH2xVfDA8QN70y0zhFTPrWgCDH0hIq+y4aPGSBPKhB1vsFQNV+pfHRExtQl/CjRIykWs7CzNZD72YFzZgWG7wlvDUgs+WD6WjoR1N76vtARYeTTVZ3gLjsJAHBOan/gPfb5IP4pbqpoWMRjykLyhaIVJRjTpQos5bbCp737AEV1h625skS+8toziv7La7MldpG61mRDd63CejW3O035+SvAjvEWXimOXR3U4bLoKjd8eCWlFpAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ0l1r9CvImeeJmOdxxQCsZlLSGC/a20+Yrdc+caaIg=;
 b=jhFbkr8fS8JoDqxozXY4vp8f0x2I7AqeGz6bEtOPPhVRCKZo/OWQNVsOBsjzkKAXvhxb/2FBMYjbFRn+nyef+zftFpP1oSj8B/ZkoaKhvInurbTkJ1Itwr3w6srkO8h31oLBe7IdSh+fsQVcfu/IVVo3xbz6n62ak9qhkYoE4An8u9KJCe4fzN6qdMa7lqPYOth6fL00KvaXIcFKn52GKVnOXHl5i+IaN4NfVqa41dA2vgCPy+WxNjPqFGL5obZhXBFyyC+FBRldDxDQR7SZz4fQq4b4evS8N2PVystTyzNW7MqizRUur3kn35PaNnk9s9DL6doGcN/O8EI1odwehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ0l1r9CvImeeJmOdxxQCsZlLSGC/a20+Yrdc+caaIg=;
 b=2AVlQW3Z31ZiQ8DsEbC1qf3oI2F3U4PqCDbcctRs+kulRjzxIBuxvxDscjqiyjl5t5LMpFGlX8OiIJZ/wJ8IK9oHvXKPrSlEyTONjiZWSNiV15vqPwxxhryflyavQjqKuAMf5bEBJXgq63cz7OYvewsxhTwMpQLgXAs4IAdeHmnYBR3mBqddT5q84jULL5GXiHDpGy6MgamKCqtdmP1GnL+N27oqAm3mTOvSwDx1SMUotuV38u2F/7tWCZfYklmhkvQfS+MtqdXzdJZ/HtXEmeoW3VefqjqXLF0k9wjUBuytjizCksr/+4QaS05v5Kbzgz44AnJjnHclPLbfPphzHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Sat, 22 Oct
 2022 07:54:19 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Sat, 22 Oct 2022
 07:54:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] mptcp: fix divide error in mptcp_subflow_get_send
Date: Sat, 22 Oct 2022 15:54:11 +0800
Message-Id: <20221022075412.471-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 789bf7cc-93c4-473e-51e2-08dab4029ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sQKNR15nYu+8X0A3/4A4QMAV/hE6iqWnjgLBI7ZUJUIu2JLjia7rXwEEl7VpBSfwgQkMzxZGuUUu1B/REG6IT/HwhHSobZ6sGgNtt38e4Jdof3EE5F8rphdH2yl1fuT+nYfhZngTuOkz3DAJW6BsERdcvhV9H/SL12nGaT6yosU3Q6bug6iYHewBAADjlC00vP4pAV+4uCAJwGTaU5saom9sdBS0U4hKa2+85v4uiKGF6PllNgFVEcgxfc1RPR8myE83N4cbT9oAnoa0rtEnDCi8apDHM1gWaQJq3VXeiw30WifzTitRXmN2z6UzbsOGOOUMkCXzpPDI9NDlBwhbhos2whfnmbaIDBstHLBhSzkTpkg8ei3Y6GpzdR4bt/Q/s7krnxGpmchJJmynInKDK/wq0lvgUdFn972k75fRAkR2Rqa2xhiWJWl27s7/QoozVUqePQ1MtNtn64kPhKYmvJ9Cr1TZjFHQgVakloUvbxNt0aFAK41GsdOYyVHYHn/gSNIHYcnrvuzmW2g8bzOLBP1JhrS3rE2tneMs+OLSFhuY1ec4EPnGJhwVexOY+Xa9WDMPoyDruSRay+4tnjLgyyXbkMxUFm4HyzOc9v1qK5fI9a5WxAc2H1i90KSytkPj+EYP+6Vc0Vxo+DcR4PdiqcKsVwfSP8JZEUfsZak1fjKQhR1EMAP5rZK5W9aVMOSGx3AJV1gf6i+v+bLtIvJTsHR5PFagcFxoozFme0qEWCaiYThy3zmAAZoO4zwn8qgNDGUtm9M4bDV/JS1XQp7DEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(6916009)(54906003)(316002)(6506007)(66476007)(36756003)(41300700001)(4326008)(66946007)(44832011)(6666004)(8936002)(5660300002)(38100700002)(2906002)(2616005)(186003)(1076003)(8676002)(66556008)(86362001)(83380400001)(26005)(478600001)(6512007)(966005)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D8luKDZhjAM3/ZhsyQQWX9wGI1tpa5TXVMptC1sIAkqn8PTuW+SuskyodFIL?=
 =?us-ascii?Q?3MLX72AmFz4+/O1Jsmqvuwvu6h1xjtUbRG/AcSe8xdBnAzRbKE3fy2VP37nG?=
 =?us-ascii?Q?IqLEkpnLCx1UW1BR0CM2m8ayQ+8OrftHogN55hSFa+TStSBvjcoazWSmpCfj?=
 =?us-ascii?Q?zou2Ehut/7w9gkBcobhfDogXpDMe+XH9tPXmDkvcgdWnfnaxmLAsltVTSrwU?=
 =?us-ascii?Q?KSoeVEYDZk5oStfRRUs5fAtRV75PnZqGNOHrwlyHLFtx6J5sonV//+vwjB1p?=
 =?us-ascii?Q?CCY5klZPgGbKfnLCZhQZgaSMyyesjwdQw1L0jQ567h42U8SbMEHG1rimTLO2?=
 =?us-ascii?Q?c8ik+8u0d6O1odMrY6bSmDyyzv8TWDfi3tUttqEPcVlw94CwlrhdSM33de/v?=
 =?us-ascii?Q?KDTg9lPRd7SwonqN2wgeb4Iosy4kuWPepoQbOHqDwXANP/js1B+wSOYBvpBt?=
 =?us-ascii?Q?um4Gr68X9IMZ495GsfSZM5NAHXET2zcfA9zCbnPDrhoRK4Fx6Kb8mR2KL/LE?=
 =?us-ascii?Q?3BZNeIvMgPMGGA4dC/UsGbF3Mx8FOI5Qt6UdK36e7pvrYFRMlGsrKRY1KRsI?=
 =?us-ascii?Q?I/+EKGBYMcZdnrYCCWaMmNIgItCJEJIviAjzQDw2fJgzH1P4qiDjDvSSMw6A?=
 =?us-ascii?Q?UrctUkhVgNtIP7hE1+FmQc4Y8uuDw3yrAESoTW5KQvoujnVABU19Yep3z7T2?=
 =?us-ascii?Q?XzUHITBHwEyd5un2n6QTWwwQpbYkdjJXsVmpHPLjApaHcxlvdvCqHpOhXaou?=
 =?us-ascii?Q?/F/Z0J7EeU83ZM3EaIytj6WFuDE3c8WzT/eQVn8CIGcoxEvkPQxOymg0SalT?=
 =?us-ascii?Q?62FyASBEMPHhwVg3Fw0OHuGbeQHEIlXnfywifpiM4+GBJMrS1l24ceD/3ZKU?=
 =?us-ascii?Q?uRkCn74NAES8fI8f4Ff6+m9epiZF0I510Om/ORPxZMzuQBLizny61itWo2Pc?=
 =?us-ascii?Q?ViZPbpz8U5EBDonyx1It1R9E/3D/B8fKQ2kJe+ehtDbCId8QrZUCwHeFoY/w?=
 =?us-ascii?Q?wprH7NWVRzhQfE0bsDuXza86i/9WhltDCkFDKJtTj/9VfWVW5tGHw0Zv8uhu?=
 =?us-ascii?Q?ttt4xMxUndh+63LOOk7I3dbj6yUVs2hRmvi/c9kJIT6/9ZMuGLJJSBQVvdoE?=
 =?us-ascii?Q?kHVqUAG2aOFcMyihrUbLwyn/x6pnIpcBVXWRtszjhNN/ujCVsIwCtdMzqV4x?=
 =?us-ascii?Q?kHJ/IepER7+6lnWPz3rDxm2Uj3/1D1TBod5yLs9HV2xHWG5TpFtDT7xuNg/x?=
 =?us-ascii?Q?/AVIVD7dQI+oncc4F4XvuNyDIX14UaCvnsSMIwFdeE0mfLaKQqQ/r+Xgdj8W?=
 =?us-ascii?Q?CerBuR8CStmhZGGFwPO0kmyQvss5P0c2GiD5gOoXZ2xb9ACeg3+jW7d0Jmlp?=
 =?us-ascii?Q?s6PIRGQAkzciC8SCp7zM76T9hDf8REt6fVPScPTg/QdDEhs36jqzyP3APHWZ?=
 =?us-ascii?Q?2NhuvSLVrotuoTtlr+Ah3SBMVtd4s0S+JSiC5B4dLGdFC6Ca0beVki4a3ZEA?=
 =?us-ascii?Q?PiQXFZWPuUZSyCMJNySmQD8JUwxeJoYXEpGrJmpJddSx6oo/He9aDXpWr4uQ?=
 =?us-ascii?Q?c1w3zyjHz7M04o1SJk8Ug92hW2fTX8Rr3hUg4WF0P7sANIC5ma1mBF4duzkL?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789bf7cc-93c4-473e-51e2-08dab4029ff0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 07:54:19.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcQU9/5TG555HK8HcPTXtDc7FbHcQP3WvlQnn6Z2hc78M1I+GFltE667eMwmfE6u1+f/RNHQSFoGqNoPvKWgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423

Fix this divide error:

----
divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 14336 Comm: syz-executor.6 Not tainted 6.1.0-rc1-00215-g47aa7f23f440 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:128 [inline]
RIP: 0010:mptcp_subflow_get_send+0xa87/0x1200 net/mptcp/protocol.c:1486
----

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/314
Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddeb8b36a677..3a07c0d197d4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1475,13 +1475,14 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
-	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
-	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
+	if (mptcp_wnd_end(msk) <= msk->snd_nxt) {
 		msk->last_snd = NULL;
 		return ssk;
 	}
 
+	burst = min_t(u32, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	wmem = READ_ONCE(ssk->sk_wmem_queued);
+
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
-- 
2.35.3

