Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092197B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC58Bn/GavsTidyGivZm2aUobOd45+oKWcUM+ML48M5cx96m7dQxIrfK8l1tQcSqrOzBQpJyREFKEDaF0y+O/p/GbYXyaN5uNLKEUXxP96ppdR0Md/1P7t3nkKhApPmA1iubViw5pgiDiQ9GVZbyzf5nZ7kdfZCMPkHddMR82XdbZiuWtzCFqRG9+x3wQCO3GiPUoIjMNJOunb/Hs3unG2iaeLKniNr7KQKjjqpcp7X4RUrX6ng38JQUB0FIoEkZjRINUek8+WeV3OFW3kuqCLygEnk+JBGqzE6CJ8VSH35V4GQvQ6Zc4TmwAn7/LtHwsZYAGW36nmq0qMusGWqisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=FWV48/hFJSlXyJVBTO5TfVV4hsBzD+BQRzwl4fEVghB7dHzVdrjrV13vRqzDc9QHkeWi8Uxve0Fq5/iMjwMeXsmFXVewzhfK/JL8ouIn/+/KJNcUrU+3Meb0fPD5oTRKDGM4HebuU7pgNtXxqoggIKrEyUTX88WkeWRzNdvt+WQxDRP/3mRwRudKnS+/yATJJNR8fEI1eePWylRZsHFDtbcS/JwGZD50wGcQ46Ep2tVu6XMVJ+XGieQM0OmDDMfP8Tkg41EOfcNMibGJDY4h6hiqSCiopFBt1rt1mCpRrmrJrnNZyfihWygIxp4lW9nzcKJJ9iyWtc5aNQM8TWkPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=TdlHQ8rucxkI/k85n19dXYoxfnz18k0Oz1PXvZSa5apsgJ3JatsdJRHDeZlRAMpuOJKXWQE1iLH+YS6B9ShjuUP193vwx6HntCgLZz/HtUMHkbn6KsRdk3W94jQVcBpCe2VHbiEXVS9ydrNy7UvPvt4VDY2DgI8AU/0+dIClZZ4RfC0sDf2RvEtJiRN5oEMTfZrZUz3qwKR0vO4glSkdMAYFi+sCTrNRIO5U1ofN8H61/VhrpPhFa0g1KSJrB2/ynOBpx+SLnEdVV+Ds92ZvrDy2NY/Spdqyy8Apa6oPQ8GpcnBfLqKJ5v+Ft8+NFYpzALDD3TDATbO/aI3sfRF03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:05:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:05:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 06/15] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Wed, 26 Oct 2022 16:04:15 +0800
Message-Id: <b086f836937f791d22c5c81004c44edb2df4de2d.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 70161a65-2de7-4822-be4e-08dab728e15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OQJl04w0mAmp3r9zGyaDUPPK9YKQUIqvqM5JYjrB05YJjB6t9E+Ts7699tJxiBpkPHe3N/CTwvqVR5Nw2PX/Wk9s+bZqrDtamglfWSY1PvSDPBbXHrxE1aFGr01QsHO4rEF4/JQOc9ZWPGT+Bo6dXXcVCqH9WlqN6H+jU4JMyNnRTNYbdl3rh9fv9dtmPLM9eNmifaVr8LaOcgmr65C0mpe/SLFs+eTICc+K/PD3WtIfJI890RsPpc2b3Qevvg7g7fQkUE4OwMj15uP6KfIcaUaRJDXfdsFzRmzA+DBIufwb4tpi3E72RxOh0euvwrsoSNq7XU1U/VPfF8KNpSlLckbwuAZGmSWPluQC/Mha7P2Y9SaHUpdoRlbSa0NmuHzp7WjebEppbSrRZKHR175Fs24ZczhJYHoqGv4mNC6yn1gtH6mImMzEKb4Tk00aYuYoKWDdlh5/Uw519biZmESaIjJ9Bvh/AjyGAX7CYxWOWKjRqG1jwlNcwHid+gjqxZkbkzOCu7yfxFrtgBQkap4Szn8vOJLDniLmxwZJCzLMAaYdhLuzDLv4KAZE9mR+Sz9kZbZzscrUKy6ErVlf6yy+2GRRZr0jPpeaB4pNu41Im4R1klMaj/efxw/X5WVIH2mJK3UAdghoZUIXHPD/JD6kLzvsCnHT/Nk7q7aTJLlbiYWCpKHYsiH1JPlAHcvnj1V4IumEmXDhW8SyahyAuctM8ThGuvRJXYGvinP5PfofMYyMiwePObJ50IrMrJB37ytx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(4744005)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(6666004)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EoKCTDX9VcZYAx4Si7fzlVsFz4wdHxWDEbenR4zwTZbDty29/r/FkWng1hru?=
 =?us-ascii?Q?xXxfumcz7S9Azf9G0gnTY4gA2Alqogrd+I/ngeBYmr9KfaaNSROnxsuib4TA?=
 =?us-ascii?Q?xhHpmW142OF4WEkICW1JSJ2bkM/uFZj/Bf+AHNFVkRnsBuE2VSn4BfN5KxUz?=
 =?us-ascii?Q?HPSeSK3CZOielg4nWUphOdLFPcJn6gLOjAmv5XVd0Ya1J8qAi0x3QaZ2ukBz?=
 =?us-ascii?Q?HIcu3B2UHvIdMN6rkLI3iTnmQdkIMzPoP6ta6od62cxPFy0rXSIrEUc2xyd7?=
 =?us-ascii?Q?LBYFOk63ZUqRWHHlW1vu2hKQyDCkli1RWL42VbnCUAvtxAAtIOv7Yi1A6sYG?=
 =?us-ascii?Q?LSO8nc9/VoGBJ6FbEDsdz/4pVHUxGjwv5uFCb+qwWXGsG1aF7rl+8m15ODRs?=
 =?us-ascii?Q?MLmvb8ugxPHiCCWzv2tvtCxousyz4UzvstiVdw+dU2UnUr9kMVZNJBybBT56?=
 =?us-ascii?Q?Ghe8yc5wMK8mDb3v7Khh5Od85rhsgOMLXnO7SZiwnuDHZm0IpwUmZ6yJ7x4D?=
 =?us-ascii?Q?34naVGX+JUgLd/G4kqE21IUYcRsv2ST/vw03V7lGbG5AqViEXe5OGWoM+xX4?=
 =?us-ascii?Q?0UQd9mHZ6Ap3/a1QIG6Mvp/fp9DhGpbQge327bEnGHOkR+ZD5idcV13rz5Vg?=
 =?us-ascii?Q?yd2aUqteEeCKsnuOp/Dp9i5ABpGPny//knAZvcsBLFTH8M2Hs/DTTtHR417M?=
 =?us-ascii?Q?0TM9hlcsybL8UuSm95NRpxVcbSlnr8iQ/gQxEimRTvKcVM2CLnIJOCJ5w5hY?=
 =?us-ascii?Q?U1ZQNQUm4ZjR9WbHWNEvQX2VjYXBVLdtFAPaEjM20wZ9DwHFQfM9SfElZ8Pv?=
 =?us-ascii?Q?CvDHQir8Sb9cmQOu0sSI4sKsqXMEH6LzviejsX3KoIX/w0CjWQwHh3XWh1cq?=
 =?us-ascii?Q?zzTRXoCSGGbJCd396f0CMsjJvdvv4XYItSU8n0vnAWaYVfDQlV66qrhO99Wm?=
 =?us-ascii?Q?FdyeLcA9lialmb29R9RaSAZkB+xQmsLxQOxUXf/ZQV27Z2P0RJxLlZxEloSh?=
 =?us-ascii?Q?fCTwU3id9yXAX5WBdoGX23uydwSYAwzeqYYU5liV8+PoyTOysTfnbTP/zN/C?=
 =?us-ascii?Q?TlFduuyuGJqA1cfHMP/UU3jUwbKU5t94zezT//SFV+SavGWfAPSP2p7YjHk5?=
 =?us-ascii?Q?swkQvAJgQcurVmvaiBjRjBdVgdVyPKScBEoeRrh5XVkmymoJA1nMc8xeUytB?=
 =?us-ascii?Q?Z6EX6Kn6Vx3qruNJw/vNeoq0kVgJ+vkq61W7TEhcVxiYZZee+E7xqcMNJ6tj?=
 =?us-ascii?Q?LDL7Yl/Yap/3nOHykexc2TbP99VELe1s/DJhyFWLWMulIkGqCCoIBLQ2evc/?=
 =?us-ascii?Q?qIUtbTLrBUPY311AU/sbwCh1VjX8fIXcMiGRlXdxBJhnbS2zlEDBgVa2TBcK?=
 =?us-ascii?Q?dcpdONo3AUThGPywVJUA3G+Sb7gBy6cmB2/NgYl121JLdngFHxdjulrTmqrf?=
 =?us-ascii?Q?AnRyLSuIaPVbxsxaBxCsrkI/DVIkX/WLzYpAbJkanCbapB62pYxrz2Mvhms+?=
 =?us-ascii?Q?4f/Q/g497ygqNb+Vs/nH3FigQDThZgGnH1OG0Qqd9FwLJ4CLtgXAO/QXHsnu?=
 =?us-ascii?Q?r9r0RmPbXBIsZsYDFFXTTGtskchXL50JHy70pRwI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70161a65-2de7-4822-be4e-08dab728e15b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:05:43.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFwKbICGe8JfbIQVf+gRMouev7IwVpdARFApVaScR0G17t/TMPeRv7y6cXo88nfhg0AwpCDF8u1fDtPskX8GUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

Add mptcp_sched_data_set_contexts in kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0a768898990f..03decb05755f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -164,6 +164,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

