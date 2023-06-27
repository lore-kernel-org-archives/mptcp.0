Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341EE7FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkUviqdr+slvKIRsSMyLyMIkZApj+JORUxHAowoxEjRnUIf0MyQm9MmdvX/zHef0A6pXd3p8hAFFBXILm/bOvfgPzPWiEHWtT5ZWInBk9AbWiUToikXuV0oG/nnfj3wX7HT8MH3ufpXoO6dUcznoffffWxQCRIoI0dsJbHrTYpQBNksItPtoddUCdj56iMEoHSiESuO57dh7iFYBuf88lgXvhPnekkousNYrlXgSlPoikq4uFf1VQJKO/ZOwQVkDe04ASzqGBhy5Z79NmNWsOChFPUtlGW6Fp6P/xdJANfwyH/YLZh1etJCMDd1RulGl3ltG38NYuI4EQfIR9w7Zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGiO23idH7WqjqFNG43TvUxEhjYK9d0fVxColXMTePw=;
 b=aLlIkglALpLAPVEAIxwsuafpEHw9p5I3KZaih8njoeqXh47+iQmbG+sRIpL6YC5dTCaDN2gdgbtEHtBWuRrrk4Moe9kICU0lETSV0O7IzOhfZ24+9/RpdYJXmhWuRmic8bwX95+P6A0NT2t4EqE7E7MiE6UdmB1f6knP6ksPY0twoiJUKYKpATjRnkd5DdugRhVtiNpN9QcH5AeUDvNvaAvQByWma3itRkaqciBu44X/vAcJzO29bk3BFWafA7koc7Ty+RTCNi5Ew4I5QGLv56UFkaDbzY0rdbTpUhd7sjBS9SHtrRROCOrSBxg9/B8/Bxt3gtCRJZlvOdOzzoCVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGiO23idH7WqjqFNG43TvUxEhjYK9d0fVxColXMTePw=;
 b=FTAgfHwtDlFWMpXSBoQ5ffxLVF8lFkOECWs0iCKcqxx3PNi/kJDHgDXCp4JemI30aPpC1RmzNMzsxQGckM69evVZbHHgc7xggs77gaXQ3sJV7YMlG5rkzsJ+Jx8wRGvZFbNuzSDD/60Be2PSqzhCIS47xNcKEsWn3lAVCNVAizleLnNbJin41npZ1+digpXgdu0Co/ZaCTN7wtndeHeU/nMiokF3oTRlW3YZKkRzyuDEifFt19elhCSEoHRL2cVrunDtueRSuqOHmWlpFNq7bSMuTBf7sIe6XKdLafKkRb9cNI7gFJpcOY0JpIB6TAt8FXI0RAkgI00bLNHvFLvVrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:08:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:08:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 09/11] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Tue, 27 Jun 2023 09:06:52 +0800
Message-Id: <cc0be99ac1665c8a6df7641746a53dfeecc24a28.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d12967-ea0c-4209-0d1c-08db76aaf4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ni2QQbAIhAE5y/08JHwQdLNMB8/ZeNpjfCmfzIEcMxX5+897PcW2np40UeUjchP1SluiFmllTdZwBUTZpl2BuUONZke2/PKzLHFlnDcEDDrfiFTixVJopLC9rpEbcrRO4ytx08ltNFZy+PxPqjCpTbVK+quEeoXivNp3blJENTewnBVi/pDz7Ep00sdcyXWnWEUTgHvgJoNkDsFp4UgA/sD1X+Y7GUrH3aCTmJ8+tmxVCwU9LVRz3O/QK9yNA6CnfM1nMsFE2VZDPzw6eWfiKcJrK3Y3cNBHsKyNBIgWr1CFTPBxC0gqLwB6haPJ+LNK3j8LCuu6XinHuL37CSQ5MSxMxHT4TxEbJAu+JaJnOe0AwhX0ioe2C0V0h5SoX7XoMCeeypA4kSk70Ls6eiMVC+OsNYDnQIyeWShswup3syH+WB3kdSLxVatZK1XV8trhST/e1FeRivSBxk/u1SWoe/GpFmxWMxQyIE72XdU+rNmxVJny0HZ7J4xUvMgJsobLCi4n1ftfu7V+a0rcY853Nu4nTBsP7oj8Gfc0WvKrxqPSEnkUyQb7+ZBmBEJZgk1Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrUYoNBLDk3EHyHrA8U4nxoBqOTTs6V4uSdIRhVq6SAaAzD23X+RU2rIgjnA?=
 =?us-ascii?Q?tV/3kUXM29u9nZ7GEtjJimKEPvnmNDJOKshm+tZatLd6W0XlBO+D59X4AV1v?=
 =?us-ascii?Q?KQvvNv94M7ivwU6A8BrXrdaP7vPX+QUCo+YoZ80jLkTERQrHC3sonyI+YlPO?=
 =?us-ascii?Q?0qSYhl96/f+LmkxutqWNwkrxcQrSOZ//xbxiDh2DrnEXY1N60QLtPQhhRizW?=
 =?us-ascii?Q?zxQRneoZQ1Nqeu/S2MYf8xsmKyQnsU2u1g2+EF64WMuo6Oc/jUIAVMS3ee38?=
 =?us-ascii?Q?SD9gHDNedOW1dwNHd4xdAnO9e+YIRjCtZT6wiI0uGkFhGgvo3zKxCO5JE+rm?=
 =?us-ascii?Q?pmeZPIxxmqsczZvl6RY/4Z6ytnT8YR9JRaix1Ldnj6uwMbnYtULzkV9ZDKY9?=
 =?us-ascii?Q?ZFhTzV+rxri6fbkpVrxsexFc52Rs/xBI0x6izjYmgGOhQ0xibsRkD+5jwa8L?=
 =?us-ascii?Q?7XRLzVF2sJJHOJFEKK7Pio2C75FOOXSOPYQFuf3LVwzt5lC3mkLXitqMzLiB?=
 =?us-ascii?Q?u7EBTfG/bi8G9gYj3hGNnSoPOfYfbK8Cy3J/2EgtOYkLi3JG5WbFoUtbtVrO?=
 =?us-ascii?Q?jJFaJS9qNNcE9vxwmj89RAZsvSrgLgSpwfLuT4ww1W+aezE5daFDMc0CBied?=
 =?us-ascii?Q?fVe4mDLbw1S4veFmDDLuDhO2NbY4vUiQR3avAMmPzLrAtM1Jy3HI2/HMmlS4?=
 =?us-ascii?Q?/zHiQYNLYhEx78vQuM0NL6SG71C2vk2RP9AJr3qpsrNXJrv9X8TXRn8gIt1y?=
 =?us-ascii?Q?FUDzSYgopPcnweGvMikWyaQ1HaPFT4LAAdw3pVPwh28hoX4QBKdrm8clJYrF?=
 =?us-ascii?Q?p+nfoLJhFkLK5I6CrY9XzmaSnSB8fH66QnGJUN3jVYE8ZZVKCYza6AmMa5o0?=
 =?us-ascii?Q?HxFe3mnhBsbNMjSyylGoUbjK4IZ2bPDUxrbA/uUoXDVP07KDFfiDq89LjcmU?=
 =?us-ascii?Q?CGm7rzFdK/UoNrQj7TLSSvJo7JCnzr7Ne1EFVQeu6Gy4KqYD74eeUa849QQI?=
 =?us-ascii?Q?53bdfRRfHm4jR150z/r8gTGjtdMjhP8M5puozpqtuyKpVpqCAhp5NEs0oO7G?=
 =?us-ascii?Q?TUCS+h7ydFESa2n6AZIPg7KrU+dbwThSIQqx9f/IR8N4nCFOlvhH7TAsaQJz?=
 =?us-ascii?Q?Kixv7Do+hip4bv1v7t79Spk5xCMQMtpFraOypNLcGP7dJ0bFJ/8Nnpiod8RG?=
 =?us-ascii?Q?wFoc9uJOJh6+G4D5Wo+xyKIZ+8VLTachKK+ZxRJ2Z+0b/9rZuvacN9hOjp+Q?=
 =?us-ascii?Q?K7feQjdxlWSszNZ5jfr3U8ugyFbeQZy65+Bh/qVO72KBXKzEgEOBsIveatia?=
 =?us-ascii?Q?92YEO7Md1dorPyVymybAP7CKr8/2LPAPeF/Cs9eetLFx7IF0EXxgMc9RZcEI?=
 =?us-ascii?Q?UTIQ3nCHqC9Vy22yJu7PMFT8Rnsxiq7CeywaZovK7HyEICIqf9XjdyIw+sAh?=
 =?us-ascii?Q?Gq116asAD9j7vkfmHYSSLoPYx6A1hUwFsZowwH27Z0BJ6Z8ekNBdlxAZkG11?=
 =?us-ascii?Q?V74eI9ysP6ADgJcjah9WZ4DfxmfZn/7A4smLkHai/l7wTWfocLMF47glvIcd?=
 =?us-ascii?Q?3ZnZu7yp2khY0hCNsBUG0Nz+KMs+BY7tBnZ0ZeT3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d12967-ea0c-4209-0d1c-08db76aaf4d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:08:02.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzZ64iLXMUPA1qM+WFDmmR/4NJc31oEOm7gvrmYNR2f2E5ismKrwLCN9mBeGsf6z9VXqot/DREHwCRUQoUU3pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index b2724426676e..e5ba97390e17 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -7,37 +7,40 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("struct_ops/mptcp_sched_bkup_init")
-void BPF_PROG(mptcp_sched_bkup_init, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_bkup_init, struct mptcp_sock *msk)
 {
 }
 
 SEC("struct_ops/mptcp_sched_bkup_release")
-void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_bkup_release, struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
-int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
-		   struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
 			nr = i;
 			break;
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
 	return 0;
 }
 
-- 
2.35.3

