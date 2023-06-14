Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CD38E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8jlxT9gEbvKqRdaj+j5NV6Iz30uIF9d+BCRGdtX0EPyTLQmEuNWvEDW9OQa4lKuIdLDKwt41J6vPI6+Zd19oXoh8248457587QtafgwhCu7zkFA1dcFf4ntCXim2HcvQH5wOeW2W6oKmdhSoh4iglcEcspnb7jbvrCQh6Z918HRoU7bOX5Nq/X/XgQUs3ahewhcwgv/RVbNp0TKXMvZJs6WGpZDOetdztZ6JYCziuWHxiyXqMlqGj7pqvfLOHc9HzFlmCAlhlwFju3dv7D4Yue5XfCGBpFpU6YXHr14+W3Rx+Bn5TXo7B5NG3fTuZoh2iswnmMDU9VzVyvIUlTb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNH6HZT6vMlB+n5d4g54xa72ska2pRn+qTIVUaniwcY=;
 b=hjLp8ABEMRTofjJHeavZwCulv53I84swMPu15m3miIZPvUp37oaI6xsRAkBKbcCutwzPAGSHUfsQYwKK4ntvzpQRBdrt3GkLtRc8hykQnUiA1RGJCIwmHfOYjrXb90PmBtP8Q00CpwirrbzfbXYlNGP2nWeWt31crLnXKVz/MyxkhKdDoMziYJd0eMCcrlgozefCLokUhDX3y9sf5R54/mztnPe9KOcoD7u2QdsXDUZRVGQptCioo+2dYkRg3nUlHzw+fEsNFkyfB2CM9bfFfIx1CCV0ZHLBDR3M6raTtNwBFxcROAPe0vKhDGAzhD0UUU6e8313EUyY3TVISd6MjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNH6HZT6vMlB+n5d4g54xa72ska2pRn+qTIVUaniwcY=;
 b=yuuyYeno7GjnDyQL79//fcYwCfiWifgByhV7saJLsiRVsUwqFRB+Ku0XWHSDWyaE7KcC7I9bFosHgWE2TvynJEbx3CbutDigSuNPzjLvMUtOOhVYfXnp1KgqdtLnoQVQy+RhY8y+ccXx3u9Fz6Z6NZ0nxpAeS9/LgJwDn0oZnUlv2j53DDRDnaNkL56SBPd0cAvZz2BHM17NBMdyrEPUPc/qJfTLUnxgK45jRz0y/8h8ISjILc9Igce+KQdnIFtTiFPknPfbYrzatnsjMrnH6o75Tl1r+ydIeuR8pc62HKzQdciRDYeTbe0VfD4W5rtF5LqvQqsn8gOHHjwHZuqeOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:21:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:21:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 01/23] Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
Date: Wed, 14 Jun 2023 10:20:48 +0800
Message-Id: <9173cf366b5e9c0c276ee2c66654d5d30010c512.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c0b3fb-0ebe-4f01-eebc-08db6c7e1edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZcNSHUb4/TGLis7WsqkemP8zC1kn66iCo4Dx0lNtHnJ78lDJasnqNDLNRj+D/bcFs0/GowR1ni9r6Ekzd5eNS1Xy5fts+pcI5sHXWjr+eF3NO0Ix4zOnx05FKjgx4v9WaF2WjVTvhyuI5trbQtBQRbRFZsUNtGgn3aURUpXoyORqbfucCW4E8ya6/E/xGXUUZuBxY/gCTbzP3+jWpFyFdbezGn/VqXNsC2TlUit8SLJdgMeXGWLAumStQ9ZPD/k9sCwBbGHa5SZTNkUzz8uV4kzERb+eDqmMhamUgF2HaAM0Vz+pfWaO6jrC7H9DKNBUtd0cvH0sEGtjWRZiLg+CoO7AzVU0ualOMUXBQHgI1IdZ1CWX2j3uJWudxoPD83ECraE70xBcYV8i/lVgwsxO9VK66GbCmi2OGZjOxUsBcv6eVWlVnuucCr1u8YvwRUeXnwihxkz0egvtFfMnNBgOsadOsN/CqX7XamUM1ui0nrUwplyHIWMUY3AWJfuYNo1ZbKsT22b4FmZYsNn54FX2c6cIualao4X8CfPX4nFkpmuk+fmIdxhPQ50UmkO8uDmp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tWMWztMAKolMg6bHosfer9AUBb1nHd+WFBXhUZ3mGW5MtN/4L/WtWCn2jNQ?=
 =?us-ascii?Q?Cxdm4Q4iOZ4TdvHhl1kzFt6DFnCgVP0tpxkuL28ehj7HwQCxAvXLYejFHUlH?=
 =?us-ascii?Q?6AwzrcB/p7Ltx/ZDqHLMBTjLmD7UcsPD9kAHXrl8mQtqkhSrZE5HfREH5PcJ?=
 =?us-ascii?Q?Llnp8qfyXhsGgb+97h0AlL+Hq//YCYvp59Ky8PbDTAJ0zc/nYcmYbBHe6zLy?=
 =?us-ascii?Q?MZC1Rr+WpmeV3RsG/hXwaQfkZfdMqlwY0RY8Wnp3+0mEREcO9cXHuEELU3sB?=
 =?us-ascii?Q?JzZcQUDccuEvBFkN2wJ2CI+wt8nSTS9AWEGnjaXUMhBsCbXqW9YrYmuKxOq9?=
 =?us-ascii?Q?nPthNUcG4uaPB5xmLRlIV46l7lcE3jMvstgaQAaslw6vwVZJKG8ydYeJB0Kr?=
 =?us-ascii?Q?KLm6MjjolK5bN/kiW+eZo5PnyMh5QSr591k21MujxlvanM3ICygVYpIho7lr?=
 =?us-ascii?Q?jE4cQyh8u12H+lKyl7b62MpnNriFDzI/TVQ2tLBUGNK7b7T01JnqZZL7qq01?=
 =?us-ascii?Q?4vOFxU/kg1iCOpDEqHw7W/vB4Vgw/5/yuXaMBclWGqISfJjPYKJZttePtb3d?=
 =?us-ascii?Q?+eBgImHkzvN0L2fpqvbech9zoAz4+IezESfyLK+qj68MBNL7AnSzTzXlvxAL?=
 =?us-ascii?Q?4ugVQZrbrOIc7i/xHHqjWMK3nJ1+Hp/TPR6PQes0N1r18dF0qnNFMRS1jG3h?=
 =?us-ascii?Q?EVlDkIt+E8y7YLoBxDu6GgkUWQ/+5fcWZlrx8FIC57aq/uv6L/REV4I8EsiZ?=
 =?us-ascii?Q?0z+/42GW7lIwDRC7e52cDnYv1y/Sz0S0HR4LIrezpdKfeKzvyY2sSupovL9o?=
 =?us-ascii?Q?QEGrjYXlMoM4YivPvGM1RY9zohGeBfvOvDYKOQn11OWgMDhzh3ATRdCQZyEJ?=
 =?us-ascii?Q?knyE2eqFnzXhPQ/25s0BHvy8b26WnL79ng4CRUb8HOORNXq2XEMvISRQcW2J?=
 =?us-ascii?Q?mpXvY7fYEVeEGSl3dxsBHN1JI5VvOFsX7c7Uko0lAhZdc1FRpwbnEYnedVOo?=
 =?us-ascii?Q?13A0VzS43V2tldfyhIPFI4UjZ+YYti3Iw/Djqd0cIOYf4tmCwnWNL7CX7CjG?=
 =?us-ascii?Q?GYnz5ZrTkAvgNZkmOGnKjSt0ySjtNXyv0URuTzDbMa662m4aUEh7pabhobtC?=
 =?us-ascii?Q?5Q85WUhA7QJfunE2T0Wl4fcAfluRzx84Ru1l5cQ3NxSVFlXV3QYE6kQW1wMx?=
 =?us-ascii?Q?rQ1FCWYFP+UAhettE0F5nQYPNb3z0Yc4fs/0TZnGk6arvhDyGEVUmSSzGt7t?=
 =?us-ascii?Q?K9O5drHMJwn6sr+l9JcUPEfcd1t57Uj+G8ScwPkdLSmLCaRP4lI6VG23KKm2?=
 =?us-ascii?Q?vfGpUen56kd2ef98HwT/HatIcjLe4dF4A1/ivYOlf4Vc9L3+ZAlcWFLcv7U1?=
 =?us-ascii?Q?+smgpedYyH5+fop4JVeQbg4/cm+nXdplepVhoAFIxAaifHBOceWtzyvf7e3c?=
 =?us-ascii?Q?N31ITnI9M2it61m8vXQJyaT74PLyu/qIU3jLqRheeP5zcm1AjasLvsJHjQbY?=
 =?us-ascii?Q?zMOAenvWUQvpAeZ/3+kgx4QogLyeLUlmc2DeLDao+A5C/xcyn7jb1bjZFKaN?=
 =?us-ascii?Q?kUY91tPgqnmirRmruS4Jjco1U72AArH6KLpyPA35?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c0b3fb-0ebe-4f01-eebc-08db6c7e1edc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:21:54.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxDeX6xdPT6ztOMShTJeF+svYrgIV3DG8iSkj6hVK1gNjrxXogdGQfHwvP37xuVjLuaqFo9WWM9tFuPOZCYj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Drop all last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 9 ---------
 net/mptcp/protocol.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ffb6709cacd..64343c664455 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
 			}
 		}
 	}
@@ -1660,7 +1659,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
 			continue;
 		}
 
@@ -1673,7 +1671,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2466,9 +2463,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2648,8 +2642,6 @@ static void __mptcp_retrans(struct sock *sk)
 			}
 
 			release_sock(ssk);
-
-			msk->last_snd = ssk;
 		}
 	}
 
@@ -3157,7 +3149,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..35dd3683f735 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

