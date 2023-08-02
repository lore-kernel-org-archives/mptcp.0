Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BED53A6
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 08:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GszNpkJ01i/zx83R1BuIEc+LHyDvb82u/z/vs9D5prQcco8pxcWTtsbIxq/skZxHPFoYVRAi77GUGCikNu0keSKOuT0BD4ufDqg/4LO3lT3i5PqIj8gM6UEc+nqUNTr7xvw3fAbFVnbV7zxfQPFrGtvk5b6/N4ln2CSWaM488Pa9+U3Qelk+Hvn2/K2lPjQ43nuXn+DK712dyHythns7zcQh7/vCn05+gvhV+cN96AL3PFZGSFRBmC5V6+5N7BVbu80VZxj2t9AwO8W+xSsuhQMUKyoUXmKYDWurkZsCNn320rMoE8aLhKFX/x5Kr4Ji4T1Qz882RUQG6BjMkiAxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lmz5FvaYQwwdBSZOXksnQ+0OVKiMx3bnEAkXGdlro8o=;
 b=IiQ0ul04irfIp6IvQOmYtaRPQlIl3WGy/sUpIznLFQEo2jlJGaXqL5ztXkmMigCMNZVCn5wD+7wfKbnwNrtvK9Dl6gxeKqLOzHg3st4RXtIWeB3G2In7iEYGCc68vbsxqHY93CkV6mf9meXiC2E1x2xGrTiImeMidw+ENuzH4R8J7aSYJ6NG8d2hp4Pyth9v7GsxmvP2Km3imh/THnNVx9yzDH2lsdxyzbUf+yJckcOaJrl5VJ+RbvUDUfPXaO1gfV501qklpfA36wvcnlyKRuCLcMMjfJI7CdUXy9KpAwBDSmKgvWb/cJGCYDhIpm6at8WkGPdNc6DWRMzjbhSrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lmz5FvaYQwwdBSZOXksnQ+0OVKiMx3bnEAkXGdlro8o=;
 b=wS3ZbT7W3sMgEUjAn5u1a8VqHtmSizqPjLqhL+gMe3D1KM2B50HaQJoHk2iKdhLh5oG0VMF6aaF5oMQbGFNAa0BleZQRxwxJ4YqAopD3/ijMYmRPaBzp0oP8FoftY6r6TrlTMW4pdJLa/sG/bk/rECi1c6AaMNoJE5ELK7S/lsIKNB/6/HwakFwmP6AhIzNrN0uSqZvFdWR2FX+QikZS+n7sioMw9RKtrDLFXN6Jg0qz3BY/3cqmINbXSVaDHAmeJ8Dza/ajLX8kWSQojTheXPuUGJ04e8u31/4haW4YtsLCHAWdQQWnFLMdvewOFdk+Ui/nyORwmGIumd0QyC/sWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:06:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:06:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	sferlinr@redhat.com
Subject: [PATCH mptcp-next] bpf: Add accesses to bpf_skc_to_tcp_sock
Date: Wed,  2 Aug 2023 16:07:03 +0800
Message-Id: <322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: c3935411-de1a-402b-f87f-08db932f6f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OdH2XTrvcI/1v8oLmx0HYTvpRGEp1Lk8AGNiPRJzm2BwFgBOok8G5A1f3Yrzqal99bod6stxSU2KCqEh/2yHE7AY7My+19wV4wg7oYhrgTT4m4FSWi4W6z3XHLiHxHzhF5hjmtV/vejeUDZMWHGNpElho3d/3l87+8iZBxL98TgT9eSftIFkydtDRDg7EsvJnPqUl3Gw02wc2I3/3henydVt5lRePgeaIXTDfqMTogon55mobLt1GzF558oU3z9BFsp4bsPfVFxW2Cg6fDzscOsY3CPYFKf3ieH4SymAk7kigad67u8G0Hdq+R3WsjKp19nybNf3cWza5AsscuiYpbUVfVqbkesGnjUFCmfOVptIKyrou4KGqy8A+R7PefXpGh7MrR3bFUHM5S0OtpPdeLjYhjIMJOjWdCz58l3AKxYMVaKXKur28yUViIPqXqNqj5ZtA5u6VLOQ2UmsjJkii2RVv/kYAHbMJiuZPXleACKbwHbLmA0Te5i6oUX+qm3LQi42WetOcvB8FuFDH2VO+VVfYBz5PFXmA94cHuuYUUEwMXb4OZ3Y+Wid1L37MxyYCcy/PsoOupZ1MBE6+SznF/xdJCfuu/JZbzAwYSnndLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(44832011)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(6506007)(26005)(83380400001)(86362001)(36756003)(478600001)(6512007)(966005)(6666004)(6486002)(41300700001)(8936002)(8676002)(5660300002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZ7ryUW79skxDTIcJoFxcZfiXSHZU8uDzl2ipN58c1KqCeeG9DmvZUppNLs6?=
 =?us-ascii?Q?g4gGHACnZqgT1BZ/cGnf7Seg0kF9UPALdrNMw7+db7ff4DMrSKDzTg2b0aoo?=
 =?us-ascii?Q?CxYASgDgyf6kGqf8FybXgG4LIdbM5tY9pGt/No1nHzGQVs6dBLGEl5TW6FQs?=
 =?us-ascii?Q?Qxt2Y+lM/yS4gawwlICAo/jlKL3ckEeYSK9zbgAyXpR2EF3fjp/5Le/xvkLQ?=
 =?us-ascii?Q?clZkTRIIpyEocoNsnv39pQhupzpsKzbbm2rNFNErTQPHF2h1kHlY1Vi7eP2E?=
 =?us-ascii?Q?fS8KOEFvGPZHFgwpZTK5xshEH/njx4ehYA5Y2OdusWpFW8jzreLIyHyArmyj?=
 =?us-ascii?Q?VvSQDi2uR+gpmsIcCE6d2vWKMsxsee2iqLomkDg43SMlRV6RgOfyj4ouIAJq?=
 =?us-ascii?Q?lg4Rf+OBW34glp7kq/z+s1iwuknQduQqrlMA7qn+6MeZj5vTSQ+AN0u+C369?=
 =?us-ascii?Q?OGkdIJZiiXYzQGvkDQgSEK7L1pccAHyU35MNUfb4Z42GA0zfeEqqPZWf+RYa?=
 =?us-ascii?Q?HOaCRzZN+nLuJlhlaL3+hgpdkyw4eUeo1q1sZZYcUSsytFIu04FAlpO7ylmV?=
 =?us-ascii?Q?4Kcq//s+dNrY48Gu0yyKbT9pQRRvaSGtu1mraN8L+OUQdHSU5MBWc19P7Plv?=
 =?us-ascii?Q?yXvt6E49U25r86+GXCY5jn8QvtZa99Dp74sKC6I9AMw9crz//oZFVYfKF35S?=
 =?us-ascii?Q?1EFCgZsFo4sCDXhAyGpojBT7Cf5N+N3vuTQKFGgGCd8LICooEV4om5kZca0y?=
 =?us-ascii?Q?0E5EF0FKk1VfknL5HIkIIGRUmXGTfQYXeJ91+60GTkD88TwkTL5hdnVoOTN0?=
 =?us-ascii?Q?mRsvv6H7uqXa8BDBYJSrFXBAXPaAxs8OPHzn7mPqndWhKSQsLwF8ac8EDkKs?=
 =?us-ascii?Q?e+fVeOuxSO/3Pki1rQ4rzjxYr1T0YAldO7J7c328M9kr8cGJmqCjvR9jVbHx?=
 =?us-ascii?Q?P9x4cjL82IA6tWOaJWzxd94sXwI0zpcTjnNUvzIN4rckMbo+Neu0OOYBpx4o?=
 =?us-ascii?Q?EtI6MYjXuBur1IIOoy6likkaicit5eF1i9WuKIqB7ZEn7ZvvgMBIfBL0GvwG?=
 =?us-ascii?Q?mIJPon4/aAoY11ffIBeZz/RvDRHjsW0qgRlrDpke/UNjbEs9mfljtBbyAYuU?=
 =?us-ascii?Q?+G5c7i3kB3yjkzEHlkVv2NxNnjWEAql7AqQ+FKr2Gact/Z2NsklVbI6KQMOy?=
 =?us-ascii?Q?u1s3dYiElMaOZd56PZgLkQbgAI2jkAvi11f18nZpuxnRVMvf2Z1zC6xr9hkf?=
 =?us-ascii?Q?X18klyv5QcJXJeoEWlB/OBYkw/5W1nFXsX4LObdPEyYb5U4i0qApw513CEH+?=
 =?us-ascii?Q?DdwuZ/gPWhqe3U4lkjBcbcSTqzm7kTAtsZzYKXR2fYH/w31ccnnxpq5e0tbS?=
 =?us-ascii?Q?nt5naiekIDNiRNg19lPCArAIAsFLaDG4qdrxbpGWMn4sdVkVArmKsLtL1/Zm?=
 =?us-ascii?Q?sTYh7yvdMsrzHtMnoiNsRlsA2hI90lnZ6Qb2Bz24w8sEKtb6moAsFpj3Z3Jy?=
 =?us-ascii?Q?iiv2hWOMAzaoFLmrY99VD8izIpNdtCgRIAkjtLxsIZm4JzE1T+lSw1W5jfDz?=
 =?us-ascii?Q?vlEqIzEbX8FFQQ6AN6b5TmLjPWAyKlCFCZbUYBRh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3935411-de1a-402b-f87f-08db932f6f31
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:06:54.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEzkRfXEfNfh3NhJwxY5569Oby1pumB3GS+bEvu3ixHuJTnviJMpE53+1/1qTB2MQYc99Sl+nCjNHAeJvuL/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443

Squash to "bpf: Add bpf_mptcp_sched_ops" II

As is reported in #417 by sferlin, we can't access tcp_sock fields in
BPF schedulers.

I gave two suggestions in the comments of #417 to solve it:

1. Move the helpers which needs to access tcp_sock fields like
tcp_packets_in_flight() into the kernel space, call the helpers in BPF
context.
2. Add more helpers in the kernel space to access more tcp_sock fields,
call the helpers in BPF context.

Although these can solve this issue to some extent, but they aren't the
best solutions.

A better one is using bpf_skc_to_tcp_sock() to get the tcp_sock instead
of using tcp_sk():

    tp = bpf_skc_to_tcp_sock(sk);

Then we can access every fields of tp and keep sferlin's patch as is.

But this needs to add accesses to call bpf_skc_to_tcp_sock() in BPF
schedulers.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/417
Cc: sferlinr@redhat.com
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5c82cc35bfe0..f17a947635bf 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -30,6 +30,10 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_skc_to_tcp6_sock:
+		return &bpf_skc_to_tcp6_sock_proto;
+	case BPF_FUNC_skc_to_tcp_sock:
+		return &bpf_skc_to_tcp_sock_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
-- 
2.35.3

