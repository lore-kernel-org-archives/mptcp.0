Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BD19A
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="iPL5fnIc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFj00YQRtblRsQBEO1XNhzXgByI4KaqVahJZzetMR+ZYXKqNso1I+lKAZfyrrcS6G8b8PfcO87TdZ2vEeQ0RMaA0+uWrfzFrtXs0cJ3nk4g3lOPmHPp6cQSkNN6UzkCjsfk/wHlRdHGcWG/t15AiqTnEvEjQnghHsjQxeD4XORwf0mzXLEzcOewcc7baN1PKZCLRIItEFs6RYRI5+d0piZqHJP5OpbRNudAEZDJsmg+HwgPPhKcPLHd0P7HGXpAPKwmi9BOJrCqX42Di/kuQyBG5NgVpGEEOlpNRojic/AVPgvsUBQC8OggR9fY63EDQ+9VpuTTtLHGoObcBZfNwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swNqzRmRhtSA56A63LL7Rx3QeYb+HtEs+UP5N1gK6n0=;
 b=AWYrFQfEzDLro6FbT/WsmuhentkSspf1d86PMCaBGXv3m4wz0LruV7bsVlJ2cOg87fuBvc4vFW1neB3StaaDCUc+eEBOcKyl3cJol56urv7G3NHzp10VyukyXISK6PK/lJvg2dNKKhQwU9C+qsx21RqmdOkZMovh5usk8qEtMw6p/JLPSegRcjKHpdhgtZZNNCHsImRCFl8jv+4yhrI9e9WH5Kdf/pVhXnEzQ4tnLk8sfyfVdV+PgEo5OfjWcoRJO3VBahfs1gjw3CRMs0NsEnlUmhplDjIblQ3frGazyTuACzG2qawR3HxC7gAJyZStcwp6d1k1fSVgPkNz3iohhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swNqzRmRhtSA56A63LL7Rx3QeYb+HtEs+UP5N1gK6n0=;
 b=iPL5fnIclNOkXiGkrbLreD4JdW37IpByBFzz8Bnsaa7Ze45jHG3gnYwCVKh2QIatgAAr7/k5JA8I87UjGLjRZCfDjYT52GeWrYn374mBT4vQFTNsFnEPAIPQwAMtcvG+TGl8wtXDb+Mb/pFQhy3N8b0n3rUa57QLRn1FUYBvK3xsVLXyAti3URPbYNpGFlKzudga7KW54VBxmm9ZgH2y8gtjTAhjGBu2XiQaA3Pxv9xfpkoDjDYXszZ3tutPZTnHfTYzYtwwHJPMgFEw8nSbG7UZGXoSFoha5ZHWN7BYHm2DLVtIuOItWcOL24rUOplvuJoWz6d47TJpI0Es5+skyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 05/12] mptcp: rename free_local_addr_list with prefix
Date: Sat,  4 Nov 2023 08:26:16 +0800
Message-Id: <26d81412b213e636c8cd5972c7ea62f6f53789e7.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ea9701-9d7f-4476-03a5-08dbdccccb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y8rrC8/RO/KZf4UI/HL0+LoMHHtyYHvxrLpPxaYigh+fNH1/wzjvFksWCdAPF2GJajlSO7hbF4yxleZaOqMV+aQSzdpVL92m02PcxE0qMItzFhbyD7noe6ehL+GmNh5LQhdUBo3lLw0QeqdC5zJZe9aFh5yoTTDsrLXAjyQI23hFEEGsMwIughOfnnhMHkjHsDjAD3LNwE+f9dUdyGuZUNKhG1bPj8R9DBBwkXCuK4Ta1VXc/ktQeULQ50OQGsmy1l6QWVlmytmdvtebq7EjLqtKXbm3LII7OLGPqzSaIlx9IN+Qekj2cFJ2YL6azzmU/Nhro9SV0lReb4pxL6rKEJO0RE7jm28R7J2yX9S6AujHLUxuyZnuG5dc0ktcAS6AXxIFbIb0n894HOosslJFCDA130+/P3fBt+ta10QgNIc7vPpSxdGL8gfqyEjkjusUOuolv0Wbmo4f2xkgiSh3uSrWSx+MwQtewsoQdfOvc1Rs9waCqsQFPQrN9z6n9XowCtoclU1k4RVfhwP7e2UshElXrL5+z2QYYBZ5teUP3l9JXRtwpmov/l10LOiBTqVB999+SwnRojy911ypeurtNaANKOyE0c3qHXXdyc/1XNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AG6+kXiFdz1uIndvT9xcZWq0w3WCedSVOwp6G9t3LB/rSNJ1rkd5ufYpp3NZ?=
 =?us-ascii?Q?FRTtLLpkNSqDIvr/5TcT/yNNFrI1Av7STy2/+3+8LEhaegRvbZL/fiB4w8qM?=
 =?us-ascii?Q?V06BChZRl9B2tLLUR6NXj5YTtJpRFgB2oxeteDyIZsEvaDu1jTEwo5tTad2R?=
 =?us-ascii?Q?F9TCFPjMf2MhNKxVNXXQ9UIU6U+Q4DaytRfa1ydmXqwkVBo1hE6OVvLUSVYw?=
 =?us-ascii?Q?cjhsdSYuvhx3ctYYqWtMVyEMjzZo0HnzRJNvkg5yIxylpZvNm2fmqMCoxtqv?=
 =?us-ascii?Q?JA6XALpN1uhyz6nXcK63pvIaP2VzGFavPgUY3HmGu//xav9xjNB7TNXscMO0?=
 =?us-ascii?Q?ojKA8V5gvDq71OKo9k9iyOCFy+z+WkUuJTZOUbcJ1fmu1nNNFPP9XgH31+Jv?=
 =?us-ascii?Q?MO75Sa0V6R9cckKikyoIKPznkehZMI9FzPyiLJS4CU/BSjLuZ8KIespKeJFw?=
 =?us-ascii?Q?frR4Ghy8nk0/F76K9v0yZv70A/ixbietHTmgRcNVhMCCnNiAdSqeTmDTxPGf?=
 =?us-ascii?Q?cVsNdEKs5+YdcB320zoEmoKKtLYjO8s0Jn1QtRvJxz2MwOXRwy+9xoRn5KaU?=
 =?us-ascii?Q?pK8271LynCO+ype08hNqbwKGidT6xXYrbVHTO8qGw7/j8X8Cin9LSXmYKpji?=
 =?us-ascii?Q?HH0rHAWnfSEhkg2YYZuFMPj50CgMdsh0rVR4qzAhQbrHxIOZQz9pcKIgAPXO?=
 =?us-ascii?Q?dZxF1T+wQo51CShycyrK8NFuVXvKfx+2tacA5lcqIMJiFyBtQRqJiUZmxIj/?=
 =?us-ascii?Q?7GSUtICeJAc3FQ+KcmDoI6+xVm3jiYbP0T1FLtw6bZTDQZIeOxRpQlX3ZoGc?=
 =?us-ascii?Q?09IWB5Pqx3GANIMK5HmA8dHgz+BDGIvYjmX6ttyDrqt9GsJgArNzbzzLR7yP?=
 =?us-ascii?Q?jGrNiiHACcBnbTaRy3RN6nn1UeJyWDEHnLHYdCaKwyH0cei/S9m4+JC0lM1a?=
 =?us-ascii?Q?zXlmPn7ad5JmfhR9rS72OyQF6B0ImPhATEVfzkFz3Ck8dyehqmwQ0PpQ+HBB?=
 =?us-ascii?Q?LJfxdc5JR7LDyseuMvG2MletTWZDGgGbop/7k8R1DB0kG1huQyCm/UWNen9M?=
 =?us-ascii?Q?ZGk6uHpxqw4PdaJl1tPw9T3w4tZpX1qjRPwlrmdfoX5d30OBUXHMBrR99VAJ?=
 =?us-ascii?Q?8EizNe+gNKf6vbT5k42LFKPxTkATrCsamWyQf1iwHpnZDryMjUqGDpIHzFPM?=
 =?us-ascii?Q?aAC/A4O4kjGngJasF4h4mcC1i05qjse+58+myEdP+L3toP2E6sOdmsNLlJc3?=
 =?us-ascii?Q?rysh4DnyrkB5pcrIHPQsRkf7hhW5BH9D/y00gzy3L06m/mS1KaDZreoQDffh?=
 =?us-ascii?Q?GJ1zlhFc2mLtnLy/kI/qFRNxhAV9HlUCb3lO3xZPOpfOImb+ATHmyXDZAznJ?=
 =?us-ascii?Q?8Rq64oj5YAI1is/UhNM3GOhKcL/SlKxHXLFJNRUBnJ1Qdn+Zg2rmmWFw/9LM?=
 =?us-ascii?Q?at/8o75ek4FqkwkZy79twWNkrLDAppLbt+Kv6sB23NNkrlwdOq8Ib3bsMCxu?=
 =?us-ascii?Q?EJl4UuCGaqbeo5W96Nb84RxpUvXU8udSBKWm4vMwz2X/+q4ckwqX6oGQ92Do?=
 =?us-ascii?Q?RuwLdzF4yYK6EtJggBFuI97ZvTum6jQjsRTpi/Hg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ea9701-9d7f-4476-03a5-08dbdccccb11
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:14.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIs/+8Bw+WDCACav0NrwSOMgWQ3nyYorEZ8HCAg1xYvAyICKPmVx3XRbfuZdTn3rXvjqp22NlHoNsFNXQcxLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch renames mptcp_free_local_addr_list() with the userspace pm
prefix as mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b7fa9481e3b3..86f3809c0b28 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0ad507ac6bc7..3bbccb53eb29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3317,7 +3317,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cf72a57e6c54..2d9e8a78625c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -943,7 +943,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

