Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6B20F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJmrarI51b0MU+NggQ2vco6fSWeH2B5xZbC/tstrtAFGPeCstgf+H8OxdwcLXM/Gm5X8XQJlDpaAWkLHVrGV1HAogf1qxlsyAxufhG2C5bdkaZ7Cca3Shn15CVWhlYtWZ66XeSEfYsQNfr+ttHT1elFCsLXGKSWAQjV4+0A8y2hwoUIXNBgR6hFYQ+E9QLkkd9GOq8sOoOOUB1A1UOC5EeOS/USeUW8p7qK82JrgB3Io6BYbiReCIFy1RhsrLEwT2VQlOyMZmQu6s3pTh+xQtfCDnLySOxdMXyMJkOfzOfsfwXMSAhl7nlMq+2fZRO0WIBU3lX/1izQUSHGtMGWGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=RlCbpSUTwevlETwaSTrl8S04rVMQnIEsqQHeh9/jn+2XKjhmDffaABOhCeXu7hJ83oKqVmQzAqqqpdhKXDUdWfdDsDPAX0CfqmeL3Ri7hVnUI+dOrIgXXr8R3ZJbZu77fdGG77e58eKYinnayeSEUscV5HF+BbfYCfuX6ey9Jcio2u5nMVuXr52/yb0AQI4zy8CXqoCT8vfQONhrIMbxZHH6TVZoxWRh6PeZGP8ce1vpui4QHAj5TC0nutPIBiG28XfmOgr7eaT61paSsG3J06bG4xEixctF/Kv4JORba/8CNTxAegSDyFKB1PrpPxMStYQEdCYtSYSMw9/sq6bkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=nIrN9Ii2LuP2OKpFIQgOkri31RoncAah718qCZUVu8RGsw3TVgihahXHF+em8rYKuOVoPE9xuDzeHUARUgq5q+yYQzHzUM43MiFaTv05ONce9fz66hYVYMLaoQuK99KyzEodxYc5uoTRAxCQgOzYC2Sk7bKE4YkkyCN9deHx+3SEFMr3snHfIeQUAt8qKhBaHEKyI0u+GKFcyysMxLty961SZjhg2oX0IMvq8w9J//X+rJzrUX+tDoXgyD+jP3F6xt6vmx1praKK8Evyskj0V8ZAMf1m7QvFq6wWicsm5B/pL2RcIP8Mjhsf6Pv9q74es4vqqckgvAS/ynmx5sBVtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:34:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:34:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 12/15] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Fri, 14 Oct 2022 21:32:19 +0800
Message-Id: <834aee3abe542d820195195cfb9e981e0cb85426.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0038.apcprd06.prod.outlook.com
 (2603:1096:404:2e::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c0c774-57bf-481b-ac76-08daade8d8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nk1/1HCPlz5dG2lQ5N3YZbZOOTtdvIqiM70MTK+wJ/C+FShHgUh2W40SR3HcLmx5PnobJEDFOdJ3oekjsRhDTwFXNOJxykBlxbdRdhB3dqFcMRnz0eOUB1jDqzQ4HZFz8ZhoGDtqxkOKReRBemZlpBPsctX8qwkJnZIp0ZjZer3Qr6IE7SZ9Wq7ziq3i1rH4cKVmlh+X2AmytwYQvsN+674nSuzMF2LILgkiMf1YDMzZI30+fPF8RyPQ+ZuVL3nBucZ6FVGH+nVFY1AJJZbW+1j8c/5AjLLmSuQdzYjKQNNOmb7XZWJBEJZ6E6plODUTe1W6p98yMaaKhxLKbT76DiCK+BdLVXs0TPM4W/oJGnskHmg7LEzia1icOS2ecg1lgS/dsAOJjny2vucE7Lx/+fP9RuKV9qxdhNA7Atb15uPM3eur+K2Py0C85OBwxu1MldwCvcSSZgnbnEk2Cx3coB1guWk8qrCKVXIcF4Aq90/wGEgty8/AnBOnfYJLX5XRizPvdrar/gWvbSdX12zYpKy1mAj4AkVikmSW3HtqZI8RaglH3PlE/uiHA5388YGVS6G11XDxYGt1K8IWIJNtDCc6lR7YXvXRtR6FHsAn/1Ei1qEsT1g8gc5Gk/pwMGY1ZDuZrzkvqHwuBlY7ziPrCl9FfkczYoTWk6Y+U/dVjj61Ndi023wuFboLfPx7PbXHiiOeJTDseA91pmpJmVWiUXSbojOTFx1gfWfcpf4UKg3+NGriE4ManO4AuDhwoVdm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6486002)(36756003)(2906002)(6916009)(316002)(6666004)(38100700002)(41300700001)(6506007)(186003)(8936002)(107886003)(26005)(5660300002)(2616005)(478600001)(44832011)(6512007)(66476007)(66556008)(4744005)(66946007)(8676002)(86362001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JmoLtMO5y3g0b5bSurjE/NfEbAtpTGB2SzHhVo8J+Rt/+9+GJtqtAUqTHd0D?=
 =?us-ascii?Q?WsFS6GY9Br7y72+jyhO9vKhR6gHR9gMMol7Dun8jZAIKxbL7+H2E69vzYQ30?=
 =?us-ascii?Q?maOKCaxrdcgbWXwogLbDXxcxsRyWI/6Uhblz3rfCKL4WxSZ5+blv8WZqBPQ6?=
 =?us-ascii?Q?wXSeypXCsmAGYo3wZmK99CgzfCCR/EwPaN5Mwf8xlMchYtFKMWquQ46zBSok?=
 =?us-ascii?Q?aQikrG8yJpsIsS5bNxG56NRUHNCcnLEK9QGkLvDpLhoE/HUhxUow28MKxhyE?=
 =?us-ascii?Q?3K0NVwa1qzbtq9fz7ai8lJ7aXkvjxmutFmlu7QcXq8a4svWYt2LFHradQPxX?=
 =?us-ascii?Q?Zj+lW1xJJL9lo2Gw4boUkEr5OcXtjG3OdbXtmSPEehaJYaxSffqjVP9tcXeM?=
 =?us-ascii?Q?iWmd9m1IJsLYPnyx226xkN0uBb6z6e98oNAcdpuYP05fnF7fNbYttYktCaBZ?=
 =?us-ascii?Q?4iZGbEqXheuQ+T9h4pKw11c1yUvfaqMsW5ATMat5P+PVbw0eKis0f5fwrody?=
 =?us-ascii?Q?oM7p/IPKuO1CR7hkX8l464+5rTk2L0EHeySx5nfVw4wMwCH2weV8BVvYSYQz?=
 =?us-ascii?Q?/I1ILv2KtsiOzAmir2G53iLhZ5FztXEA5KcrqSI9FYNH157/F82hepvXzX9y?=
 =?us-ascii?Q?3U4tTajNWbmUgEEAbIyySH3HGrQRkPF3qBaAC2TfxqzFMKO/IvfDaZks1p+k?=
 =?us-ascii?Q?s7FENuIp7keZzKn3fdSPVHrQqRcBG3sr+07m0xJuXm0aFBwNG+aOwgy5gOqK?=
 =?us-ascii?Q?SkKMyJIRdMjJU3NDxFYzy+D2z+2KD6SAqJbBwhMqYCv2qAD0wiGagoAZBi/c?=
 =?us-ascii?Q?jwaUMV+I0NPN2eT159fZuNp+DZju/0Gl7ixppyCYGAMgyS2LDJ4Ubwvv02Hh?=
 =?us-ascii?Q?QgrxkBI7Gm7DtB3i4QYP4llPH/B0cJsC7TY91kaOKliSbizuf1nCPBBnRMXC?=
 =?us-ascii?Q?nKC0hu37Es17iFqxj+I4yCWH+L5hjinA1U+rDskF8nKXK8XDWljfiu5vfm8O?=
 =?us-ascii?Q?x1wyNYj6BMAlKnogYBBVSmI2qVeWQ5v1npJ01bVxUsvCzuVZtmejTqMqWBLk?=
 =?us-ascii?Q?qcEIodlRE2Cs7UhzOeJFJRZZWl+sZccfgpUrJXVpxdkn3D/R51cdBE7elVvr?=
 =?us-ascii?Q?6nMbJlc1K5scfXJBQRsQgUBqt/FMWAUulProv83y8jrykkzZz/MU7B215xZw?=
 =?us-ascii?Q?JqLdZHFGXwmay9JMEY5JodAn2B6DHAr911Yi383Io8J9EOfwrqryTGEpLtcc?=
 =?us-ascii?Q?1DgdLfS5AEveueh8xX/CbYgzAx7k13/TgXqg1GvBcMo8ISuIfPtv4lvXEYL8?=
 =?us-ascii?Q?AAREWECrr6jV/j+ryR1KwRVUPe59X0miQbWLNUVzJ2+W6APWlRbbZKCiy8Dt?=
 =?us-ascii?Q?DJmmD4ITlyNq5cuZ1q/F5AkR4IU38XlMLFtiSSzqHG0s6csidsvbECxMZEvQ?=
 =?us-ascii?Q?r4q9kYG8kRq/T7jI8kzr5BUQIlalw8zZxnAYpnQCbkHB6T/iNNP1eC3jGn+D?=
 =?us-ascii?Q?Tjx0rMGkpsNKVAgFsdiOfSc529rl+2PmiAawz+MX0pnhj9JH/MKJtPizLId/?=
 =?us-ascii?Q?ZyBAUqHIOBoFX8ZDyYq99NpCP/rEJiZAPwrAQN8q5Bm2uGPvYoF3PdqMxVPM?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c0c774-57bf-481b-ac76-08daade8d8e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:34:41.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sig7jxUbn33I1jXF338g+XeR1Ya5sVtbos2EBCIzGOu61Zh+PqEo2VGuLMISqbBVPve5bVYe/XgeoNdUJPAi4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

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

