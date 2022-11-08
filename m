Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20044.outbound.protection.outlook.com [40.107.2.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F46ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nut8J3U/xESNrCZl+90qglrfyMWap7vkIJs15qSyFA6qWBjesiWfiVHaZ5U67gRlLhKX+jPs7KXO43wKFmlkqPQ44uGxAtZOWRT88JgavFUy9tfoxoP/nmNGUYzmSEyQCED2jD12qO0MQo0GGBgwOMjOZ1tJt3b5Jc+uQj2JElh7LFrC2s/G1y9Mm5X0WQkVxbeWhqS0DaLgcHQ9q5Ue+ZIFZka3q+yMkmUIVizuVpl4tBBW42Yi+LXdiTrCOgNf7LomvOLuo3orIrkVmkMeTEx5Ow/4POj8sEiqm+/hrY3DQpnP5haI1G48JiKXT3ZLudFd3idWCr6hHpolmmFH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=OPrcEJvatEKQkzII80+dag/Sfp1nVq0NJrLQEaOgTmudMEw6mYjxG7W2cacTQs9CB0goElHm8OSOpEendRnXwUM8V+NXUYC7/yKYLtENotcPQuPlLsBujK0xKXtUwJNEnSh3/OPkRT7MvI/Ey8hN2aRL8NWz2/4k3ejJHQOJHfCC3vyimcUrsxKn1qi56b6q+SZI4/KjZzHgLtdBsKyx9zhYXszqi/QzFAhPgw6kyvsUZGhnLSibEPbOEdV3ybGFQ95XI3MQNazn1+EaxozkQqcMaPZkm8qDvhentGDcgzkJRAKxEVCF2tjS352UuTnNZ/KBIolBv6bq9JOhpCSM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=q4l0ssTFaxTgeoBY9QeFgQ8syZSdkRdSbK8rGpRol/PvE2GkjjsezXAI0VtImrdDlgWC9ZOib5U2x1P8e3G0NZ2gbsi3E2F2Nwf2ObLYfXq7grRYNZ+Y2ByHpydt03Ff5gFWMX0j49d3huPJ7CNcQ3rBIawuhGLUgW9pk3k7okR7y0OFotGlDWMUSklsCiqX6JkGtEgt635pDhbfV3ZQBr1bsE+T70PxB4SL3HGawSqB8c/0CoxFkDeTI6n+ZvSB2jdNCyk9Ef8IJ5EsMwiXCYKUupiIs7KIURIDjAYPhcAvv3khy8n8fzImISxRTSXoC/y0/FDpFZU1Z2fTXWxI8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 08/15] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Tue,  8 Nov 2022 17:08:30 +0800
Message-Id: <7e9c264eac108083c72ba1a1fb155544b3bbb239.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: f95468b8-0f84-49e4-ee9f-08dac168f189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8TOoCyCSaALQsjOBz+zh7HQJA1f97c457NRja8uyPhdz3Tk7QxXHT1Sc4yJ/C38sAjI9YuMcTN6xEPQysPzL4C7qJj6rLKaFMUEreifI8sy9lJR9F2RhBCr+QWMLs/REjr3OsKU2yOu1CJUK4t18SZ6SaiGeTkC8psLtDJo5npct1dCO2vWlWhXw/HL3dCBuVkQvf+3S5X2Z66tryfKIREo9HJSHDXv/aMQbIO5mJeCazNbEOeeunxub9Z11BCfpjDMUwMrnoDFKoPSXS7mN1BaEIj3tsg3ZFOOMOkqcbIyG05BHJB7A+98RFYqTiLmxrqwl/PWgZFMRwnjdhp6U3ITGeswhaUZ4kPXMT5SNBR/DIuaUTH8laTgb9rZSWEoOc9LjGZXzmIXJIhiN86D/tQ54trO7BuqatgVCWcScwRN91NW23vzfZhjV5PqSBuvQx1aQbneppVPxLPGgapFu5P+lOAVtu2koEcrFSG31y7pngj5I/EfKOsO+2DrDORIKIo9RBL3IHUZg2LuuGeoH8aPBPWbZZF3W893RqQAnVdpSDaJry3h5XjBkyxUUcTRtOES+Msdo2EIIimAsh5z/zvvkXxxKCEF+hqcz91IyyoX1Zkw72NG5nUz8iNmZdTJxrZw/VOpF9ICRqyBpqPEc6ZQpKfe0miVG6v2Rzgv9+ermMK66moSqO3fAj0auT4Ix54n5sMZ6GBRVBp4Kq7Djq4mKtt0VLUSJw8pNOJhrBkRdI0iUjqmXLqLk8B5Ub2Wl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(6506007)(316002)(6512007)(36756003)(83380400001)(8936002)(2616005)(186003)(5660300002)(2906002)(26005)(41300700001)(44832011)(66556008)(66476007)(4326008)(66946007)(8676002)(107886003)(478600001)(6916009)(86362001)(38100700002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPQ/Vc8Nd0m2Yyf34X+cLAzVxvvK8GDsIO7qZt1AFDIreTbGAaExjmqj358w?=
 =?us-ascii?Q?epzsd45drPCTKXzwfNKoq4C+1+R7PAk4vjECnO7+BVX6o56VHfe/WKJ+KbMH?=
 =?us-ascii?Q?kwuT2PFMSsoOnn1D8Q1btQQ/I2c6yasXyTgmLzr0MCrEJAXzdEoZednElMrm?=
 =?us-ascii?Q?wRRZ1YhORxg3l/Hss/K2VKSQ4y2fdbeZUDvIpHsjN8W5UwqCOJah+al9sIEb?=
 =?us-ascii?Q?jAfPkyasn1aS/wVgaKJrMsIcpoQFFv5b2qh+aZoqpyaA6Qojqg6QNZJRwfoC?=
 =?us-ascii?Q?mFvX0M6U/iPnYIvw0EeUMFzNEIU+ed8HX+xt2HbOWLD458LMuSYbIAm+UjXV?=
 =?us-ascii?Q?dYu7JGAONbCnXWCIYjGLHrMYe/Bk1EgS3FrTiosj6LDrT55m14SDNQw4kQrx?=
 =?us-ascii?Q?WymQJITXCEzPz+6HCT33MHaSMpvQaGckmYVr8ZgMVktyXjJtHN2EBlJYzWMT?=
 =?us-ascii?Q?6BRbN0nsIq44VzxTF3pMRYNL7noKz4V7ttaCpKCz9tC+Pw3nV7gZVojcwfOY?=
 =?us-ascii?Q?qtswXzdLTSetAuaBvzMgf40xOpQUPdLg5bKIZ9XI+ji24ZS3wuWmd/x9STAs?=
 =?us-ascii?Q?7UG+GpBkK5WqqtpiPja7GqQTyASMQ+A8LRwoKuRPNKIWzLMTFjkpWl9m7OpX?=
 =?us-ascii?Q?ENFSDkBfngndzR31bsQgfZbkhpfIqiVCcUi7RSelvKTt2Z88sE/PVnBCBzND?=
 =?us-ascii?Q?Pa9WzAsZS+AgsrvFXRuQaOPpLcRG2kXn90jL4c1LHAvjkcrKfeF52UeCeKhD?=
 =?us-ascii?Q?saBBY4sxPFayMaVQYRdudIfJ6+GUGMB2WX+eFeJ/yyhpJ1FxDwHwEchAr5gI?=
 =?us-ascii?Q?weuz2d1ycrUrc7UirRXiqtJG8KOtDzV6vuKrz1p9KlHit3NMVcQiBceAE6ZX?=
 =?us-ascii?Q?nr/M7VpNvpAkNE7Wd6aT7fTlgFrEV8J8h6I44cMdmO6jMvLfz+v64VFiuDAN?=
 =?us-ascii?Q?ZEGyubRIglZQYUAuW7V3Now47N6Yd/34CdvGa74LV2AT32VmT46hiAxbOHiF?=
 =?us-ascii?Q?VlR5g2T86HoK7kJANDVaiFyuZN50pO7Rg8rune17CZ9Yucu8CJVJ4B661Usd?=
 =?us-ascii?Q?xUIsQEX4T06LvFgtZSPWNjQkt4a/E3KRA0q3q3nitdOPx2aSCbuXA1HhTEaW?=
 =?us-ascii?Q?aBn6TAJDwjBhOlVRcrqQ/k5L3TvZfKAiKQrfN+O01L2a7pUYWgYRZwuQaFub?=
 =?us-ascii?Q?Mf7W6f/QgFEKwUyODA6k6Y5OHJ8Lc4m5g0tRmjzxl8r0dYF4TWsZEgEXnKaq?=
 =?us-ascii?Q?EWNciHURh19ShQycHfaEa5K9Ap+33g7xt0bzXu8nVpcAHaLEgtM8FYJx973J?=
 =?us-ascii?Q?6rRzsRJuvYeSzI9jLv65kGy6SlIBAFQbJsIyX+YcX05DA+a3Fyn/4v6OdDKv?=
 =?us-ascii?Q?wLiUE7zNr8a+iRnoFbH7WzUcHod74100toRumN3BiPPuNmVdSaCNUdUltTFd?=
 =?us-ascii?Q?Yy7KYQkHF2KZpgS5N2kCr3qSINlSAvl9arKFhlzPn0KoYLYbOQhMsVGWWf+u?=
 =?us-ascii?Q?Euo6ADy3P2lylHftZ9G3cOaa8UD3ctwxmRCKTjqqfLlHYpac7IUAkz3koxCm?=
 =?us-ascii?Q?S7eMoeuiWWSe6NEhWkfjyaiGFa+v2tbR38/pOsiM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95468b8-0f84-49e4-ee9f-08dac168f189
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:30.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECEEAjv2jXKTWNJNxZo8GWrzWNLw/w2wE2Y+UHp43BUEQ70Pymqz7mqEIezP1cbCQ+9xin/xa2+mG5qHq1lemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 949e053e980c..b2724426676e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -32,12 +38,14 @@ void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
+	.data_init	= (void *)bpf_bkup_data_init,
 	.get_subflow	= (void *)bpf_bkup_get_subflow,
 	.name		= "bpf_bkup",
 };
-- 
2.35.3

