Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF927F
	for <mptcp@lists.linux.dev>; Tue,  7 Jun 2022 00:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654561772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i9HKxmsFEe8bKulwu9oSFTGpck5IZxmqkiP4j2vsAsg=;
	b=gm7G7h+uJsIjyO3CG+MqiU6Xc6cvRhOkygyHRZtLXC6OsZ/s/jRHK261M4pyvcpeDWQbrb
	uoluzV0BBXVCOw0ceWWw7FZBYZA9x+ciVsFw12nCyPziCqNjX0JQkn5Qw5hKp7ORARTzfI
	UwYEUijSrslQie6M3x6FwXwAM+CL5H8=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2051.outbound.protection.outlook.com [104.47.6.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-kthp7nUDOQ6VyFMypx2xqQ-1; Tue, 07 Jun 2022 02:29:31 +0200
X-MC-Unique: kthp7nUDOQ6VyFMypx2xqQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HF5XHF9s079iZwVTa4sqm4bxFQQ2boffw549CG/8RKhv2znYnMu5BFbNEduyhG0Qx6vqZqAXev7ytxaMFsyy2ri6ePZpC2Hdg2SfhCNE9Cr2Hx/36H26mXcFJp57Kwy5S/K4dsX28J1glWIYfsZnJmpiS5YojYaWev8yZLfjQuRigVghsCmx5VxIGmkyDad6WwszErX3RvJ/b1ccvBQf8wjwSx/VJg12fklrSWQ175Pm2/Wqzajda5tsK8TnX3kGnq7lr88msiarvVaokqHNm0LwInmXjw53EjnZ7lCep7dIr+zDH10eV8cgD2XNY8gQsc1/RWTmsLVZufdwlc5JuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+Izz49kKBhDEKC5sjgY/A3GE3HqkjUfAIMf7EcYj30=;
 b=Va02NCLwQ+RRgNZciZaFZCgv5V9jNGQ0qDPuU/66fBWNLgOTWthjHDJfgndyk10NCgV0DbgmNrk7nJNH5DC+bh/AqG17mjteVxJBD11snupTiF9jF1l9M8XustfqgwzscJoUV6IIhlGrCrDIUgBTCGCvQwmLUJRGOL79Va0BskIv3p6nTxh9VVKGQ50H98wjH1t6v4Owyy2daB/G+LXsgFdNQgmxBkvW/vlP3+AW2Y0B3qG0A/hbu1TZc+k/8Vd60uL/wfKTQ8BrtPxuAxdHvGa6anpVafxEK3BZpUTry1lxyFLQvIcfs1VRSFccUbVXJF9eurMXCvl28/uRhMYHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+Izz49kKBhDEKC5sjgY/A3GE3HqkjUfAIMf7EcYj30=;
 b=DyvJJx86cNkLOpsOz4fqCGw7BkST90iQtp5C06EPc6dIffRsghBMwNRHcvNSPcUgwOvGYdmX0Ru+hUvIT9VTvjrjgg1yPy+ybX2KWyz286xkia74XdrdR3KDw6YR/IeRuBc+sd53V6fsAm4K8HfdAjkltfIaN4DwVgMi0VujBUpPaFZdwInoTco693t0CXaDJiupmyqz1dAGrdTOHTTrBUYtRPYUIHgiKHoyt2oDgNDS6aX79LJZazAaYstaVljH3ZT4Cd1rBG/Fpr/1Q/YDDNN+FSHdpARIhI/CooyWbqr04Gb6hu5rrLlA6ajcT4RX47mFC57zOUsmZuygP6cjvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB4571.eurprd04.prod.outlook.com (2603:10a6:5:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 00:29:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 00:29:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: redundant subflows retrans support" v5
Date: Tue,  7 Jun 2022 08:29:17 +0800
Message-ID: <bf701cb47c25ea01cabffb67f83ff82a3ddb933a.1654561738.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb0e6727-59e8-49df-4847-08da481cc8a8
X-MS-TrafficTypeDiagnostic: DB7PR04MB4571:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB45713DDC5CB222383398D7F7F8A59@DB7PR04MB4571.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rID6YdsH399FBjT9PI5Fo4nWLWyU53vOPme9/MATmwro9OOTQAtD66IHJCq48hhCK82d18uSwcFzgCeLAzNKMFm6o049w/Zhc+jFHg9bISQ5Su8h3Vjz78+V31te9pV+DTjc9kwh2RYNRGkcIyWrfu+KGjASt5M2XY9swPTiCzxR2xZfikJjJr1K72SlnxQpZ/WBLEspPzWictBtAj82XsvP3PzefGT3CITqPP0D50ftVTHI8etCMI8mOE+JesBcSj02kUs6EDvMGp/m8f6efLHLofsZbNRYQ2rQ5oeE+lkYCImw8jl4jNIZKWC+6vCjbZMuPM4hTKwID+eazsXgK4liGhmGLsVGCkSvEgztdvm7Tvf1DNdIzkwtxMEloFYa+aP5BjpXgDmtuytIW/GqoWTij2NdxTukLL0ippA59W3d6UGjGI/PLuPsoFijNPXvjkzNw0LMO8m9gBqCO+lKmqToKGWZWb1/XcnC2XGQZK4HDo8JCm60ygotm5XtyM9w0wRC8wYGPCoNt8J9HvezKPggjmbskyZqJ42ffoAbNj1AVsVxAm0ujyO0ppoU+TExWnaTkRL0YT1ONCu1X2lbtk589ulcy92IJTfbBlxdFxy3xL24BzDXsfAnb74iQaJDsCRIA+OUG0OcsVp7badGzM27ruuCI49sCCsp0W1MDbIxA7uoTApq9BhlURDgljlH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(36756003)(2616005)(6916009)(38100700002)(66556008)(6666004)(66946007)(26005)(6506007)(5660300002)(86362001)(8676002)(4326008)(316002)(8936002)(44832011)(107886003)(186003)(6512007)(508600001)(45080400002)(83380400001)(6486002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H06wyRtnk2qmMwKqiPffGlFCcMXRhySpYGC2vKf1Jrsw6dMgKqKeNs8W9XxI?=
 =?us-ascii?Q?txK7dICcTyZua+Pn/BX+xKpTJYPAVj3vNO5TSCNOmW+2tlQ/FgfXAOHo9pSD?=
 =?us-ascii?Q?5Juq0gNZ+WZCYZb9bCPrBfWWvPAnWmDnMQnWyV9iqKytdWiBwB95gNhEk20q?=
 =?us-ascii?Q?Jh4ZeqF2LauJII8Ixkq4o3WziV5jrwPf7uprQfPp6m5FgiCyspeSlFlSza3c?=
 =?us-ascii?Q?HB2GSDeQY/LDMWtQPSVXMURr2mlynS7BWZxfU6gUfwLNajq/ptllerLKXujg?=
 =?us-ascii?Q?MGtGu9FVyavzFssHOCPSRVl0wLUtHIzaluAdWRNr7Ax2TfjRkuQtzK7ckW15?=
 =?us-ascii?Q?L0fG2OuKN3CZdeWpY+O76T6oOpItR48TIN75ObpekHH/nGUM0Ggd1GHqz5L2?=
 =?us-ascii?Q?FovEytdrtBhKMIWj21yD8cCKv9SFDTcocxbZUaSNq22IhvaDxZaWIn5ilBLs?=
 =?us-ascii?Q?5G98dtcOuE0yiHMxHwXjJnlWrdc5tqvYET0zEpHbt/ciUjZBuQTHRJqXxdKz?=
 =?us-ascii?Q?ESuCfZWcsAAisRI432XHYUgZmEWvatOk7zi3rOWvy0uusyr2FALmtMFf/ORw?=
 =?us-ascii?Q?0zbkZaxXWGxlOVNU1NfGxQ0zYyc6V/IAZL7vq+vI3WpyR6TJjS1GlTK0b30C?=
 =?us-ascii?Q?EYhoC7IQaX8wsWX5aEd/IzeZWBJNcFd43TfQmEZ8QdhThCkOyEWmcOVHreKM?=
 =?us-ascii?Q?JfSrIXAn4kbOExNdxsPn07rHi++z/IQVqzhStYUTHZbseE68w08Lu8y46xsz?=
 =?us-ascii?Q?aJWVUyvl7sbPSwXvS4J/pyMGghOmYNBSaaHRsZ4cw9eqllC2B8Tm3YoaHXeZ?=
 =?us-ascii?Q?2vFiXv5asp0+Ltn9qBiYFT7rrCYBgtmqFhau101B0ofhVov6j9ZfkMGeqXe0?=
 =?us-ascii?Q?T4j0fUzU4SnMOlPMFtkQg7Ss5QbbyfyrBqblfS1CR8CXMHWi07Yz/sivb+1a?=
 =?us-ascii?Q?V0TFxJuWvy7YEwFzXrVwFY4bAZ1c8x0n4wdIaUFSGHKIaBmTEo5OJ0Bix7HO?=
 =?us-ascii?Q?frL+EGy1wHAIEBTGvtT3egpaF/NGKestawYS1JCBgxoyA8Y0ZJN7jzn8TIJX?=
 =?us-ascii?Q?d2uF2Qbl+8GVee1LK73+pd0jLtWhxeH0w1Xp/9pLcF1dtk/q4M0kP4NCpEz9?=
 =?us-ascii?Q?x7hbMes7r3+Kzl3jMgXCUfS5YOLpYBUUuWNchVRsBZA4R3Vnjdu7A/aZGhLD?=
 =?us-ascii?Q?zhq8qGdF6RNXbzc9x9d7sr+pExRtovKQQLsLThrObe/ur4zfzGIslVM6/NiL?=
 =?us-ascii?Q?z9BECRbmt6XumfGN96EqmMYcLJYP+TeOWn1Lyc73NMK5dmsDE+KAhU0JcPeO?=
 =?us-ascii?Q?RmI7S3Q8+MzyPMrBnFErzlecbL7JuA5tJL2t7ltVMUg6h0l16jURwHFZ6YCF?=
 =?us-ascii?Q?TuF6kv6X8r+x6+rLXxG/gaOe1Z6/ATcEPJ71jYzdtPLKgv68NjxtDqBpUfPf?=
 =?us-ascii?Q?Y0Jv5WzGLhbh3+53fmvejEyI2gTmC1tef4qCtGCIQFQT9UyYDwZnpg5Z2ND3?=
 =?us-ascii?Q?ecT7P0oKIpTVRV+ljzQFSlEXElGfiHZGHeE3qBYoJodbSVJkgYwS32Cz5+ea?=
 =?us-ascii?Q?3svxzdwqi82YOQUP836yoP2kqh/zogS1Vx/pJOAUuahX6/hR3UEKE/86bks9?=
 =?us-ascii?Q?BI1UGf0n9wh6SSrP7KXE2H0Q72KNjymXySOt90JKQff6UIPV+UAex1j7Nw1o?=
 =?us-ascii?Q?SF1fAxNrliLHucsVTmutKjmzK7ZNuas+9KJJatqJFORRaxivqCnJwf/GZ5Hw?=
 =?us-ascii?Q?kW7GfkmeGYaw495QosL+hbKRwdssoZI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0e6727-59e8-49df-4847-08da481cc8a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 00:29:29.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evo+9mSM1a1bxg2tS446rvhUkUAC4jmD8AFqR+GLH24pPkDUZInM1Qt/O1eyNAsxLGLvDM3VYGDXWKahrKdxVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4571

Fix a soft lockup in __mptcp_retrans in my test:

[  458.339707] watchdog: BUG: soft lockup - CPU#5 stuck for 26s! [kworker/5=
:2:23428]
[  458.339717] Modules linked in: bpf_testmod(OE) mptcp_diag tcp_diag inet_=
diag sch_netem act_csum act_pedit cls_fw sch_ingress xt_mark xt_statistic x=
t_length btusb btrtl btbcm nf_tables btintel bluetooth ecdh_generic ecc ipt=
able_nat      bpfilter iwlmvm i2c_designware_platform i2c_designware_core i=
wlwifi x86_pkg_temp_thermal intel_lpss_pci thinkpad_acpi intel_lpss mfd_cor=
e ledtrig_audio battery platform_profile intel_pmc_core intel_hid usbkbd us=
bmouse nvme hid_multi     touch nvme_core i2c_hid_acpi i2c_hid pinctrl_cann=
onlake hid_generic usbhid sg dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_=
alua efivarfs [last unloaded: bpf_testmod]
[  458.339748] CPU: 5 PID: 23428 Comm: kworker/5:2 Tainted: G        W  OE =
    5.18.0-mptcp+ #76
[  458.339750] Hardware name: LENOVO 20UASA0901/20UASA0901, BIOS N2WET27W (=
1.17 ) 03/29/2021
[  458.339751] Workqueue: events mptcp_worker
[  458.339757] RIP: 0010:__mptcp_retrans+0x126/0x3a0
[  458.339759] Code: 44 24 30 4c 8d ab 50 06 00 00 48 c7 44 24 08 00 00 00 =
00 48 89 04 24 4c 8b bb 50 06 00 00 4d 39 ef 0f 84 5d 02 00 00 45 31 e4 <41=
> 0f b6 47 61 84 c0 0f 84 b4 00 00 00 49 8b af b0 00 00 00 48 85
[  458.339761] RSP: 0000:ffffae5c41e33de8 EFLAGS: 00000283
[  458.339762] RAX: 0000000000000000 RBX: ffffa006e4294b00 RCX: 00000000000=
00001
[  458.339764] RDX: 00002e53124044c8 RSI: 0000000000000000 RDI: ffffa006262=
a2400
[  458.339765] RBP: ffffa005c38f71c0 R08: ffffa005c38f7320 R09: 00000000000=
00001
[  458.339766] R10: ffffae5c41e33be0 R11: ffffa006e4294b00 R12: 00000000000=
00000
[  458.339767] R13: ffffa006e4295150 R14: ffffa006560a0000 R15: ffffa006e41=
a5100
[  458.339768] FS:  0000000000000000(0000) GS:ffffa0092d740000(0000) knlGS:=
0000000000000000
[  458.339769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  458.339770] CR2: 00007f9a909ea000 CR3: 000000014d210003 CR4: 00000000003=
706e0
[  458.339771] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  458.339772] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  458.339773] Call Trace:
[  458.339776]  <TASK>
[  458.339779]  mptcp_worker+0x233/0x390
[  458.339782]  process_one_work+0x21f/0x430
[  458.339785]  ? process_one_work+0x430/0x430
[  458.339786]  worker_thread+0x2a/0x3b0
[  458.339788]  ? process_one_work+0x430/0x430
[  458.339789]  kthread+0xe6/0x110
[  458.339792]  ? kthread_complete_and_exit+0x20/0x20
[  458.339794]  ret_from_fork+0x1f/0x30
[  458.339798]  </TASK>

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f39318f5a21e..d0621730692f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2450,12 +2450,9 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_data_frag *dfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
-	int err;
=20
 	mptcp_clean_una_wakeup(sk);
=20
-	/* first check ssk: need to kick "stale" logic */
-	err =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2474,14 +2471,15 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
=20
-	if (err)
-		goto reset_timer;
-
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent =3D 0;
 	info.limit =3D READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->al=
ready_sent;
 	while (info.sent < info.limit) {
-		int ret =3D 0, max =3D 0;
+		int ret =3D 0, max =3D 0, err;
+
+		err =3D mptcp_sched_get_retrans(msk);
+		if (err)
+			goto reset_timer;
=20
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
--=20
2.34.1

