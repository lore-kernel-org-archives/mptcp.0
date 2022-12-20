Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE977E
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 03:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7BmPX8HR2PTnXe1wepiVBtJ4/ex334EtunpnLjfW9M5S2nuTEz2B1Cm0ZVOZcJzT+dcmbNZskh5n+56TJcTTqf1oFvqdcHprV9f65Womvknp8Q/MXvOucUIsFsyX+wFLC+vj7wvhSzdDg+Pq9S90dczOE42lsg4/ln9jFfckIawj4qe8x3u30RRtzzqDB1jC5NdosMFW2ZmMA39JQ4F5TxPIwg4POh4I7r0U190AYsrPGT/c9hkBMBbJtZyYki1OwVspdrTarcPWGw9xCzi93+FeCwcyq4pPoDBTYEh3UdOC7gD3NuZwMXoc+MnM8cly7YCu7r0x+E2ztYDuEFdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBJXYAssbGJToveqbjmKm6pMVdpxOihmGLze1U1tynw=;
 b=PXd+YiRygdI6Q4N/wXyaeQhOrF3mS3QQfYUYSbKBUt/e+/+PfZZjHiYieTfG/+JCHbt7IwR+IC69S/7ccbEOQl5BPJ0MpLpxeHp6bO+n59Hu94OsnrASDBgwBlGiwbYtEVrQVQ1zPZI//cj3RZm4MZuZVSrQ6IRNxsb+v+j+4TjW2BcIrR9pfkWlqU18B0R8Z9mPZZbIOmJXIwHCcjaxrHXJAnMwxflNX96dDHaKuUyQApY3EAqhUU7pSy02cRvLm2wIkFhCEQM4TnZ7qkwe+CcY1vXanvDoJLebS5kQRxHnRR5/yqolI+OLUeiBJ9prIG8b66xNjg33L0BRNOr0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBJXYAssbGJToveqbjmKm6pMVdpxOihmGLze1U1tynw=;
 b=ERSC4Jv1cYyl6ZY78q9hc0hbytdKzByO+kiX64UmEylAjQ7071jYeRXqPavoABbjsyLNLiAotXQVKQSz8IvocdNNzpRu0CzpjINFBHRx4LDRq9pbO3xs436/A+6r5axSO3z+Q4+Ln6eqPu9IjzMJdr4gUgF1doTHK0VBasG6TfxWbLREAePVnspt6yNKotgLVCvI2EG6zyTVYl5xZY9/dOfAE0Dk3PwCqiYq1TCqKlom/CEunW6K18DuEweGI/n2O78UVOmYunsRP1wRKiuxJLTN34j4GxddOmdofVsoouimgo3+zdA1P9+48niftgm3EWAHGQ7qMvud0+fWRNFYrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7047.eurprd04.prod.outlook.com (2603:10a6:20b:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:46:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:46:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: use get_send wrapper, v25"
Date: Tue, 20 Dec 2022 11:46:49 +0800
Message-Id: <db6dc5629093dea02dd3b6c1088f8efdf78ea03a.1671507997.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d48738e-261d-486f-a8b9-08dae23ccb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PeldDCWyBNKps2u+v9P/skSHECQqpGsBreVgqfjlSSve/Q2uLvJxXyCW2lC615kmksspW44DS3oOFNnQ4ie7hi78O81CC8ufRC4k0ig9ugE5DEC6l4IMTkmX40FVYRZx9xPXnrkNtpJWYdnda/X72+AjOkVGr3gTWBH8x80Hv9k0XVrJqFJw/KvjwmKGzyc9PtRyUWThiI1IC3l5gKODj8cBSbkkZjcHp3kKxNwk6yV8dXYeml+shHdqiYABjyMhZq5BBAjFu187SZkymoeJQDaHgTv5lE1RCbrQlByKVxgXw/e5zbjlKY18XDnTAl9RuAAw8abnpoEjAEMYK4vD5HWyTV4VzyqFc+7cqsUSNGnL5vskjRqL7X3ayyu1MS7UGtjrHWbMnPAKzmT+Gp/TIr8dG4rW3SfOr4tV1we3ej0szNaEfzXmzuQTGHH0ZqT2Gg/uXNCS0g841CD1JfpOu6QwSvXyK+uXsobUy2NdahdV/Nc+krCE/RcPdPFLTw6m8p7m1Zzd7cu1ZI/fRPkpl7zm+Z5mYbxIinJPXVKstB3+yC4aVcgSLci8Dx3tdhm+0pr4lIb1ADCmgVIvi360Vupz3z0oF0Ww2Razkoc0FnMdY9aLgE8VYZq+dw7kYPgvQ4/U4ZdayeDuvtpjpRZM1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(44832011)(6916009)(38100700002)(478600001)(6486002)(2906002)(4744005)(316002)(36756003)(8936002)(5660300002)(66476007)(86362001)(66556008)(66946007)(8676002)(4326008)(83380400001)(41300700001)(26005)(2616005)(6506007)(186003)(6512007)(6666004)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4xnrh+LyabVoHmr0EmJk2FOls4PwM5ibqi42dq6sPoyo8ggWWrN3xBXm7VFK?=
 =?us-ascii?Q?Cen2tTtQg6qoWGQDznkN1FjRQ1SBOLSXClK8Tkd2CgPhIYmDuz5TqhvHuQ79?=
 =?us-ascii?Q?cxN3uHW2JrCXBPEktOy6fv4gEa3xanreyLO0JKqyDvPe0FXzyqKL4V1lx/ho?=
 =?us-ascii?Q?NLlC9FBeZDz8O34b3vPstrDJKMK45SYwIqAAacAF3BF0u+XEX/5G3Hp1AvDe?=
 =?us-ascii?Q?BQLRhfCYPUFvvdKG/39vCY7dTtHvhfSyCYD/+X7E8JhRfZuKs+U6v7Lwj0/A?=
 =?us-ascii?Q?WDJVWrSLzwXdhaJHxPauXJWmqvuivupvb3u4UtR+Ldl0J3Q2VGuwZ7SaswEM?=
 =?us-ascii?Q?Zy0019IZeDipiKPiU24RC30cjvZwkY5i8jGY2QmxKGdhS/A0yZLFemgoDE2D?=
 =?us-ascii?Q?FgN0KJqPY9PTn8DO6e4w5PVdiY3bAjYUTpI8weOT2lz2I0zSQCjArjttaYjU?=
 =?us-ascii?Q?Ab2ZoAS0jw+McdveMotlIG/aNcJdjLwP1hhzGqQUHNqugnud2quSSwB9+77y?=
 =?us-ascii?Q?eqYGPVaNXI6t4ggkoalGCjyRPW7TDb6WukabEaxynhf1fnWOiPOIk8aCCUuB?=
 =?us-ascii?Q?Itdiuvc+t6MpaQ4kYJGzFydy39979KznChxHxtKNBJZytfFHe2LNU3elPVcI?=
 =?us-ascii?Q?F+Jd/cV6LxxSg+/HKp23sExhoPvbpAx0mAijs96M7UZKK03+s64vBfNSvJ0D?=
 =?us-ascii?Q?JSqfuvoKb0+MfhuQgxeVbSzBFHubt0UYOh1nla43gHVadQJvcR+U/Zx84msW?=
 =?us-ascii?Q?33lskVhlrLrcsm4mUre4cEuxupiY8juTTx/3a8Ul3boO1igZCe0oiUQ8IMve?=
 =?us-ascii?Q?LRUKnOp/4foc6xMlLjRV5WltVWNLDJ0O9NlSOJkAHzzov+m3FuwuUOzmu0mL?=
 =?us-ascii?Q?PzJVoGW6NDXAytoAWvs9V1LOOGj6NG5PyO5VRagCyoImFMoLqQPWSt5FaOas?=
 =?us-ascii?Q?plTnwwehi181N5iHiY6DVZNCXAsmBkuJbZEImZ4/Y86Uwx/6xXvKrYF7gB6y?=
 =?us-ascii?Q?aEXAjHc6jse87M5bDPtXdTAF3m3kjVKJb4YfvQnH7eeEDQ1NFhb5qW1DMYC9?=
 =?us-ascii?Q?qlPpMI75oAgL+UowgQHxQ6Ybp5rkDtztvBJCO2/fCQtrSUcevPUjAOOPWQOB?=
 =?us-ascii?Q?dQhn1DKO6aXCudfR5/pQuxD6V6lVvAttpHdHMGl2d5SExgOQZDRn0VLY085l?=
 =?us-ascii?Q?KyLgfxOUi/UHfblnixEngj7Qxzp7/OPz6f5Dr2JsAriG8GDka7xrSmEkICQ1?=
 =?us-ascii?Q?NLxgO1D1CbWPLmK+2XWeNkfl4+1aiee0swSaICSsTXWhDIPsP28Ls+dwAdFQ?=
 =?us-ascii?Q?7SWwvQfxkgip5yvJT+NLW48ExffNuIqNQdSa6pw82uvaxud+rlCtshSye0VU?=
 =?us-ascii?Q?4Ovdhr322XzR3qwToCnuEOuOT795cn7EJyjcLaESPdoJLRDf0cwgVUatVPXc?=
 =?us-ascii?Q?GA8O73/ZaWhEt4v78RfuL33a9pUEBgNFsXnBcLNdXhjJy5uUogvpP65yYSYk?=
 =?us-ascii?Q?KGHeY/jGC6jfIa8KIJQ4817BRWPgdaOestgMTRdySjL566UKTjSIIgzLje2D?=
 =?us-ascii?Q?Jx3Moy5puVmyyJzUky4Noq6tHEeLFzhXPaEZvO8+Qbcw044OwlbfNEWaVjoO?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d48738e-261d-486f-a8b9-08dae23ccb21
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:46:36.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqxnMI7u5glA2rgNOyu48fagfTHroS55a4bFCPvqwrvztcW5Ni7y+jwbQVSw7iPanDp8Dc5QcJ4ZrRI2iPAvfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7047

Delete the assignment to msk->last_snd in __mptcp_subflow_push_pending().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4086f064ae16..43effa0df50a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1662,7 +1662,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				if (xmit_ssk != ssk) {
 					mptcp_subflow_delegate(subflow,
 							       MPTCP_DELEGATE_SEND);
-					msk->last_snd = xmit_ssk;
 					keep_pushing = false;
 				}
 			}
-- 
2.35.3

