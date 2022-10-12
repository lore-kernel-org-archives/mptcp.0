Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854A17CF
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 13:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo4o+d5jhLrvhYL6nohPwLGAEoY5eEExL0s6CvGcz9RjTfJDefUYhqEMzuoNDVy2Izp6aVvFB7Fj/rmTxxx0MtDhKKKTMvOgavcFCU9C6vqZgkEnsNtxStgDsCsQcYgFRAgZijAOeC+MOSyjJPk3E8hqENk3wfvhgi1leN/mefynJZ593oRZSNxT1HTwd/zw2QvQ9ZPohPMmrCcWwX4G43JIQY6Sr0T15zxp/JGUqZ+GilLBYfHyHb5d5JhuqELn7FAJPr+ZIWFQK43Adu5/VtPM56M5AmAXGT3g9sJVbjjWwDFh2sHpnnlHNG+10s6WAxys9M/RQ47OWO2dyP0/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hrSLA9uEJUJyoQDSSCfYlGhMorpX6T5FyjV2QO3Bes=;
 b=Vv36BAlXJZFQrL3oqPpsKLtwt1u99RB8g5V1O762lgpcvWDfnsaa2dqMGi7DbbqBzbV5haXEqxdj92sr/xKOuDBYffKuObVb9j0J1B0cZJDuoAB1UnwjpzFlOXE8cxqBhmI9xQPeufp5PBFNkPGSCbSWacHwYj0c5xojvfP8brcWvw6d53ALvwvhKuU4ps8emfNkt8uK9ag4E3UgqIilaIRwYKIbrw9be3xtTjmFyp1ZJWjq9KFTQxFsMoTJO0g1FVHTUKrWgJarMhZ0KiNkJ/gEAARRIQOksSqDXQQ8eRSnxEF2T2a1Tz1LarkaCUHOqocDGb3itzs9ZdC4umOV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hrSLA9uEJUJyoQDSSCfYlGhMorpX6T5FyjV2QO3Bes=;
 b=p/3kHt0o4SJ0bg9DKxMpqxn+n6ETSM3kXXHl9HxleRL880n9CoPzIXXTWwGCFZzBGpkZYT31AjO4kfcNF5n9Tg0fZGKID/UyZrKdpOS1PBeVje/OWCslb4Vtayaewbpbx4MbzrumneLqSk2em9ZWD5SYx7aLCrNNxTG0M+W1ek0hl0ksZSjc13Yas5gCvwgsdJIxoV+O0phSYesC9pLUxKyiyMFXWBocaVUiY9pilO5VsaOdiH9GYQwib/JoOttmlU4AViKZk1jj/fCBKhMWpsLQkcNI+2fFm5wRdoYB2GkxWrB1SuJl6MrEgCjOqeghseHRJnAqakARctygunkeiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 13:42:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 13:42:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add get_subflow wrappers" III
Date: Wed, 12 Oct 2022 21:42:04 +0800
Message-Id: <d25122dbd282e7efb55a6c515a298d263bf2f6f9.1665582114.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ac8c75-a213-4807-710b-08daac579d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	giY73523h+mCSrDRLnHqio3bkUXwARmCdFC70Blzf2k604v8qx+7pCXfwGL9hY4f9pEVfBre7X82wFnzoHAgM/Sm+UboFvUQemesZcxXuC2Kbiirb4ssMI9nOsQfBaXP8Q1KaLf4uel/zuupdo+K/rGtPedAr2gVu5IutStPrxY9zWr31tD0gmT5P9X+BxZGObD/KuTFwF80Sdj1FzJ1t6I9MUda8YWHYixOpVgtnfgEZl6AOVEo17gp6JWzlibn4cMa+wAu8uWUUk+wRUZ895gaptJtpOt+FUhQ1+uE/OR1JLq2slEgf8EwlNv3rnKi+xOIKtfoauKxLYzOIWLAo4ktoj5EVi01lp81d6cESf2iEji7ZO/zpjJUXTfdbTXwQsizB1HqLzjUj5tZp/ip78hNkZc7jXUJaUvlNtcMIpHOA21+Ma28WE0XlJn9XWSawbcrnfVj1w5i8i/uoWovakLWmiZO3yFNZuOnPAW66Q0A7fPquPsnmWX7nM5czpk3wolbjDhHN3+u2ADcVv+uLwxprG5ZpMK6tPAWe3Dt2Ni386yU9S9ZjSZx2q6BBQ1xYY8s635BCr+PwholJfsiOrgV0DohMgQwcffsSPvTZWfPsqCblXDfCucwKig0IRz30VZFN2FZt1qAxvGbfUEBPFtFGjUQUdF8/e5p50LIRVkxi/QLDUWKTKKI8slLoTZScc6oXmQhLsKGT9oBSTx7hZCLn2os+6O8VkrvK17sS7DYSyIvi0AriBht1aTyd0fI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(6666004)(316002)(36756003)(86362001)(478600001)(6486002)(8676002)(6916009)(38100700002)(26005)(8936002)(6506007)(6512007)(2616005)(83380400001)(66556008)(5660300002)(4326008)(45080400002)(44832011)(41300700001)(66476007)(107886003)(186003)(2906002)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8wPTYC2k+cARYa3AT0rg8s6xZkQGp7HFYV9FsCFvg82lAEtwyX3qeSoRpjuT?=
 =?us-ascii?Q?o4XWtPbQZ7bmKWT8P9MAxBg2anstJIeItb7ZwTN0/AAhCkc0amy0i3JoT3SN?=
 =?us-ascii?Q?aXrwfrkmVCpOIRruwHULbe+5MjCkxu6gpEYUQzw/UYHlzJu2a1PvIcA5nmdv?=
 =?us-ascii?Q?YaurirlzAAUyY1pRZM6dx07JjI/sIbUq22P1eHikhPfbpjop2UzlhcXyC5JC?=
 =?us-ascii?Q?jocImPXAmR6JdpHD66lBL1r5DUOZPUOo/+Dr6jzIY0z2qOETSsCw1/cZiB5C?=
 =?us-ascii?Q?qaVlHfbs7bec7x38n0o/z7s+qw1PpwU+Cc8jRu6A/0tlwcSz7HOFWFZ5Jdn4?=
 =?us-ascii?Q?8xIeJ1R6iT5JG3BLpJRSsB7ssQzO7tFEWhgSjtpQqWwNfDkr9cakAD5MjVx1?=
 =?us-ascii?Q?AAzjufxKPxoT4AvGYnf37Ipx4Bjq2AeCy+MeEVRPQafQqEQwijbOXzcOob+s?=
 =?us-ascii?Q?J5DSkDnfPP72vn5zSV26zyFYAOySoCTrRaCyAe2hMg8Y8xBBKkyHNaWFyVmf?=
 =?us-ascii?Q?2gvz84UE6SRfRTqKXyh13e79DHvoNGdddt1DUh953vlG+5D8pH/kExZ/4WCw?=
 =?us-ascii?Q?xGFaFeqg/XZHpjgPbcyWmPcaPocuJCNAZFyTByQQ6pACL45wInWaIha3E+WQ?=
 =?us-ascii?Q?x4T/UrZGdQWlx2+ZeoAKV/uF2Ply2m3EBX0+bL9exqaF1Qa5cY8nTpQfa4iR?=
 =?us-ascii?Q?GfZebtncx6GLW1Tkg2HLqpM2kRqotF7koXaLPSpVTwPAsSxilgrbQ4e5HwlE?=
 =?us-ascii?Q?ZX8d26gNaBaqdksHjo69PhJpCklRFOKIUuRfGpSwytehaot/Z1r0yMSyYcRl?=
 =?us-ascii?Q?QWhc+7FDGSb5xgHVFQkd1Vr6REQ55dYAZRdKlrmMzkZfaYs0bFzD11yRzOld?=
 =?us-ascii?Q?zvzsYLrVEoaQDSA/Zgz7naNQ8qxj4Rm3OdTNXDCwFyPAtY0NDt1JONBX+pth?=
 =?us-ascii?Q?x/7iiu7uom1VTN7xaYm/Devn89kOXS1XYd86VYRs0zEmlDKd20/bN0oTOLm3?=
 =?us-ascii?Q?m6sazZNHrzd1Eqcvfywt/0wt8jj8e6UurkPnDV+j1kmF0dfrQeUG/AyeMC6U?=
 =?us-ascii?Q?qGQwaMNLT+0cRC3JkW5JehEoiEVjxiwv63YH7ZRjOPd/XHohM8H0jDOJ3Dr7?=
 =?us-ascii?Q?veWWXhmDNJhw5u0FNvOQlaMgaFw09qtiIvwAKk9FABj7mkt7vxzwK6TEtJhP?=
 =?us-ascii?Q?mHggg3WSST8WR1wEmpf8ZrSAB/xmwI773KzytF71kSt2UMM2rcP+l8ujF8JV?=
 =?us-ascii?Q?ufJeR4iq7ds1gYeQUetrgVLqc0HLqWL0qkLbNw9oyy2JS1eRe4Rukt4F6PaG?=
 =?us-ascii?Q?gUZRo1U7CpbPH49nwrCJzQo0PwEOcu++hTgg0iWcfNxmKwoYRutR2MhZvter?=
 =?us-ascii?Q?52jnwdTrKdC1gq7+A9SIYisWzwtp3TlILHf3dRyq/3yXDE5Ngrz2+f7jHiHt?=
 =?us-ascii?Q?87dmSZy33cszepY7YW9m0xftfqbMx2vXol4LKxcj0ll/Eox5T9vqiRddI37I?=
 =?us-ascii?Q?bdPvOwQhwSZ7C3m77ELWmSnTsp9M1dE6AAAQ04cQhRr5CEjj+4kGIh9lU7Un?=
 =?us-ascii?Q?do0MQMELdinIFUHANrTO7siXhgwbWFoQCRnptMVw3nLzbZkuw4G42tDzCCoa?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ac8c75-a213-4807-710b-08daac579d24
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 13:42:32.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quxtMmxGRjmcn+1BvVqTOwJWpWGuN1pfiaNC8wIvLOipwQ3MxVLkffsaFhgQe6Wl7dPkjt+I7/JDLC0n91DrTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477

This patch is for "register default scheduler" v2. Fix the following error:

---------
<1>[  357.589992] BUG: kernel NULL pointer dereference, address: 0000000000000000
<1>[  357.590009] #PF: supervisor read access in kernel mode
<1>[  357.590020] #PF: error_code(0x0000) - not-present page
<6>[  357.590029] PGD 11aac7067 P4D 11aac7067 PUD 15c888067 PMD 0
<4>[  357.590051] Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[  357.590064] CPU: 0 PID: 9878 Comm: mptcp_connect Not tainted 6.0.0-mptcp+ #1343
<4>[  357.590078] Hardware name: LENOVO 20UASA0901/20UASA0901, BIOS N2WET27W (1.17 ) 03/29/2021
<4>[  357.590088] RIP: 0010:mptcp_sched_get_retrans+0x44/0x90
<4>[  357.590109] Code: 01 66 90 48 c7 c2 00 16 bc 9a 48 c7 c6 17 b9 01 9b 48 c7 c7 98 6d ab a2 e8 b9 4a 64 ff 48 8b 83 20 07 00 00 48 89 ee 48 89 df <48> 8b 00 ff d0 0f 1f 00 66 90 48 c7 c2 00 16 bc 9a 48 c7 c6 30 b9
<4>[  357.590122] RSP: 0018:ffff9fe18683bd28 EFLAGS: 00010282
<4>[  357.590135] RAX: 0000000000000000 RBX: ffff8fdc4567f800 RCX: 0000000000000001
<4>[  357.590145] RDX: 0000000000000000 RSI: ffff9fe18683bd60 RDI: ffff8fdc4567f800
<4>[  357.590154] RBP: ffff9fe18683bd60 R08: 0000000000000000 R09: c0000000ffefffff
<4>[  357.590164] R10: ffff9fe18683bd30 R11: ffff9fe18683bb18 R12: 0000000000000010
<4>[  357.590174] R13: ffff8fdc40271920 R14: ffff8fdcdb23d240 R15: ffff8fdc4567f800
<4>[  357.590183] FS:  00007fd57658d740(0000) GS:ffff8fdfad600000(0000) knlGS:0000000000000000
<4>[  357.590194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  357.590204] CR2: 0000000000000000 CR3: 0000000105e06003 CR4: 00000000003706f0
<4>[  357.590214] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[  357.590222] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
<4>[  357.590230] Call Trace:
<4>[  357.590240]  <TASK>
<4>[  357.590253]  __mptcp_retrans+0x9f/0x350
<4>[  357.590274]  ? __local_bh_enable_ip+0x37/0x80
<4>[  357.590288]  ? mptcp_pm_free_anno_list+0xa6/0x100
<4>[  357.590302]  mptcp_release_cb+0x174/0x270
<4>[  357.590319]  release_sock+0x40/0x90
<4>[  357.590332]  mptcp_close+0x29/0x70
<4>[  357.590345]  inet_release+0x3c/0x80
<4>[  357.590358]  __sock_release+0x3a/0xc0
<4>[  357.590370]  sock_close+0x11/0x20
<4>[  357.590379]  __fput+0x8f/0x250
<4>[  357.590389]  task_work_run+0x67/0xa0
<4>[  357.590402]  exit_to_user_mode_prepare+0x203/0x210
<4>[  357.590415]  syscall_exit_to_user_mode+0x17/0x40
<4>[  357.590423]  do_syscall_64+0x46/0x90
<4>[  357.590435]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[  357.590446] RIP: 0033:0x7fd575f07343
<4>[  357.590455] Code: f1 15 02 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3d f3 c3 0f 1f 00 53 89 fb 48 83 ec 10 e8 44
<4>[  357.590463] RSP: 002b:00007fff7da16f48 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
<4>[  357.590472] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fd575f07343
<4>[  357.590477] RDX: 0000000000000000 RSI: 00007fff7da14eb0 RDI: 0000000000000003
<4>[  357.590482] RBP: 00000000006072a0 R08: 00007fd5761e9044 R09: 00007fd5761e90a0
<4>[  357.590487] R10: 00007fd575e07468 R11: 0000000000000246 R12: 0000000000000000
<4>[  357.590493] R13: 00007fff7da16f90 R14: 0000000000000000 R15: 00007fff7da17e5d
<4>[  357.590501]  </TASK>
<4>[  357.590505] Modules linked in: uhid xt_bpf sch_netem ipt_REJECT btusb btrtl btbcm btintel bluetooth ecdh_generic ecc nf_tables iptable_nat bpfilter i2c_designware_platform iwlmvm i2c_designware_core iwlwifi x86_pkg_temp_thermal intel_lpss_pci intel_lpss mfd_core thinkpad_acpi ledtrig_audio platform_profile battery intel_pmc_core intel_hid hid_multitouch hid_generic usbhid nvme nvme_core i2c_hid_acpi i2c_hid pinctrl_cannonlake sg dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
<4>[  357.590589] CR2: 0000000000000000
<4>[  357.590596] ---[ end trace 0000000000000000 ]---
<4>[  361.714975] RIP: 0010:mptcp_sched_get_retrans+0x44/0x90
<4>[  361.714990] Code: 01 66 90 48 c7 c2 00 16 bc 9a 48 c7 c6 17 b9 01 9b 48 c7 c7 98 6d ab a2 e8 b9 4a 64 ff 48 8b 83 20 07 00 00 48 89 ee 48 89 df <48> 8b 00 ff d0 0f 1f 00 66 90 48 c7 c2 00 16 bc 9a 48 c7 c6 30 b9
<4>[  361.714992] RSP: 0018:ffff9fe18683bd28 EFLAGS: 00010282
<4>[  361.714995] RAX: 0000000000000000 RBX: ffff8fdc4567f800 RCX: 0000000000000001
<4>[  361.714996] RDX: 0000000000000000 RSI: ffff9fe18683bd60 RDI: ffff8fdc4567f800
<4>[  361.715013] RBP: ffff9fe18683bd60 R08: 0000000000000000 R09: c0000000ffefffff
<4>[  361.715015] R10: ffff9fe18683bd30 R11: ffff9fe18683bb18 R12: 0000000000000010
<4>[  361.715016] R13: ffff8fdc40271920 R14: ffff8fdcdb23d240 R15: ffff8fdc4567f800
<4>[  361.715017] FS:  00007fd57658d740(0000) GS:ffff8fdfad600000(0000) knlGS:0000000000000000
<4>[  361.715019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  361.715020] CR2: 0000000000000000 CR3: 0000000105e06003 CR4: 00000000003706f0
<4>[  361.715022] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[  361.715023] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
<6>[  361.812605] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link becomes ready
<6>[  361.820442] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
<6>[  361.828501] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link becomes ready
<6>[  361.837312] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link becomes ready
<7>[  361.842062] MPTCP: subflow=00000000c9892109
----------

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 99d7df8d9b58..1ff717e492d7 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -164,6 +164,8 @@ int mptcp_sched_get_send(struct mptcp_sock *msk,
 	}
 
 	data->reinject = false;
+	if (!msk->sched)
+		return -EINVAL;
 	msk->sched->data_init(msk, data);
 	return msk->sched->get_subflow(msk, data);
 }
@@ -178,6 +180,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk,
 		return -EINVAL;
 
 	data->reinject = true;
+	if (!msk->sched)
+		return -EINVAL;
 	msk->sched->data_init(msk, data);
 	return msk->sched->get_subflow(msk, data);
 }
-- 
2.35.3

