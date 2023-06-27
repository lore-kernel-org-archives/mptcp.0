Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF47FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG1A/1mCumCaWnuFskNukIQ3t/FlKgm/HDeESHDpaArxWNC5d5Q1d3w1+Li0gczKEfZfUEmGPu/GkbwWXB7EYlUtE5oMwnojFPbH/upA6QK4ilfSE69Ap8H+dHEo6UNc6Uxnx7rj7w/IGyVvZ5tpoFydw7oI0oQUfov3+f8a5D1SbIECxW38z88gbEZf4fVR5WDAaeatVMsd2J8NNpJGuALJ3Z3+AMGuUxpLlLW5KO1wqhd9cTm8r7u8cZIj1tL3ZzjLyuN3YqKVBC4sFZq8pFgBWmwYiTQJUwjifkSEg8oXPejMlzP+2GXWLqOITSO74rGszKyDBTceYvq96xmw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeApqQnToOXcd/HPMxQTIZreDZRn6iB/x5WGYHzeERg=;
 b=cZjiycOYLgg3ST9k1ieYCrD+LX5u3DXtAGE//ZRvC5slv8I5C9M7NC24qqPyJxfvY/AaK/5A3Y7pLvUXS87CBotesn4dlSbclG0rIYpO0BHeU3COtUOyj376fh0m/DHWYlIWZ4hpCCqiZ11xVcBWqJXgXhC5H84oOC/mIpgGKDa6z3IuM8eBzwFILJOMdZXRyxGLWr+e737dsXEVxN0RdGu14vwSxHm/QCLSPabnf8jV/UH/CHIg0vmh6PR4L63GYgoxVIXySnPVm6w83oMDu7RsyQ/DpcQvPVEhh6TXsxFC0PcT07k/kQmvpbTpUpfXBsYb8zFLG2qj5z2Vk6ZXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeApqQnToOXcd/HPMxQTIZreDZRn6iB/x5WGYHzeERg=;
 b=3iBcHekN/ARrj2jwaNjSxX6T2jnqv3gWlEJjXR0gjoIakKBkAtqPLQryS4eJzq58+oiXwDH7e9BF9Za1x/lDB0/5Ik4612kWFTJEZY+Xz5T8aCkQ6nsJq9hmZ29/j4tqtFyo5Wvu+LQPJDMqWG04SbjMCfi4LMCP2fa7fx0yKM+cn7K6cbIfYyFF5L2T1bTNQ6xNseLrHMkYYF9MQI2+hkKvqlwFEMh97Nry4EXMXMgJVLounewNKwPqQK3YhlRVzJINSAQu4vnJvEt3aCLlaYqFmSgbRwbWA4/eBtov0Hk75SySKKhitmhKkDq26wLeLRC6h2+3JEU/h8bxSFaLCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 01/11] Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
Date: Tue, 27 Jun 2023 09:06:44 +0800
Message-Id: <3b024e4191dfbe2508090eb15dc7966a0827d890.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcc9450-d59b-4c0d-8e7d-08db76aad290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zbQkf+wBzbi1x3xrhHa1uaBifPdiyMWYstTZY07VUllMjdOVKBKHq16qC16l7IkRGner41i1nuCzELOlmpWhC627MgDIC0QCtZ0XYKuwZi7sDtym9b+qserFpan5fBhOvWhQ/USkrP2+aRgT+sEjigcKbkeQbcNa0O0aaA+98wYBy31UY65ikaC+Ty0VQ0fFL2uev3ujXR1LzpLPSK9GJTKCn/v0S23UKy3aWHK8J3lbV+Qx1UxDLNh9SdNi+v5SYcmcbLBNhI0Qfx7n5bY1kn1XaMEC57TYmPOEmnP3As8uRght0kzqNnp3r0MUjoNO558VmZI2gev0KQF2tsYf4t/VbpB6AxZcRUscrs6wn6p0RPW/ceFiwPo6d7INw5yB86Dr+595PZTKLgmlJL9Y5S6WT/LuREeIlQkjlvi/mWtyePe6bNQeGz63ZoFRLIXkq+C4SYscLHFcj/uFhWGx2ExoG42tWP/FN6+zlzROj4EpA3Y+9NxsjOYI7fM5BKcdWRWr9AywbqluA9UgQRLeLxbS+Fqioa42xEKzNDU+qBGL1z//6CkcgHhYpWBHDxpk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzpeFN929iZ/QxAp2EQz/6dLPUwGoPtuIZVy7jspuLMCMAtXQ8eCdWCCcE3z?=
 =?us-ascii?Q?yQR0G9BsQq4+p5JF8wOebrYA6WnW3yKpfM0qe1279nxQZPELB3ZVBfpRSQMG?=
 =?us-ascii?Q?nwd3TQHQW4Z/OvOmMEI6m9brXTp0RooGlNbmQ9+NSTxEgnHrMxSqrc7NOFK0?=
 =?us-ascii?Q?QRbc/mSBBIbYzLI1B8BPz6kjwtEu9fGZ20+4uzsIvQpA+SWKI8q1CsNFFA9O?=
 =?us-ascii?Q?QwXcu898Dz896yjQzPJOq2R9nM6OOHqHJuoMxH1lUpOx2LYfO7VSnJAjbxbN?=
 =?us-ascii?Q?M3JLevzrzmeHx0M0+UwYRIPECNBWPceEjDEk0JN32tZcSkHJ5N3l5uNeikUE?=
 =?us-ascii?Q?1ujF5HtZStmKlAp5IESOCHliUybg4CemctH+hQhoxB8cPHSbllItfx550ufu?=
 =?us-ascii?Q?9E9N92l5y+IoJupKuWfqLfe1ERjjSkF6Gi8l8AJRQpPFLJ+BdwL/upR2tTNY?=
 =?us-ascii?Q?daBdJghO4YnbKMp3fpjZXWKa46WS7XkOdj9mL+tqfx5NqhTYk3QC0/qXHJg+?=
 =?us-ascii?Q?0M7W1fuPskG+/6Po4tlk83FRkUTbTPMduXsVJ3mY3CYm76SCwV8XWLTjWsUw?=
 =?us-ascii?Q?ltw3NjvxrfAlv9AQRR33RNFEV/tfcfueHo2AUtm1CbXg9Pg7BljO2k4QqylV?=
 =?us-ascii?Q?B6Wt92XILVfiscQiLXOz8iAly0f4nlFjMBokqGwKT+i2LOp5mSJHNQ6/uYd3?=
 =?us-ascii?Q?B2T4uEwyKmayVXUkA2JLemHokY1RqgrWnhYWZMgIBEABJumNOhUdz0hz6VX4?=
 =?us-ascii?Q?j6o5yguSaECeMOHoSP2uhJVhRn/gpuW7iZMF9w1xHI2pqN1cBOZU91w/l150?=
 =?us-ascii?Q?IpLQE9PEPUWaDkohpYQVfgJ7kb45khXiHFEzBgGwQezbu/1S72ViuSh68fn9?=
 =?us-ascii?Q?+FBC4R/ZBwIbPU+ulztO2SEzsLsBipTYrb+bYaZGpzbTY+bmNogKDSN+FP1z?=
 =?us-ascii?Q?laRXeyBUSS46/dRgWexOjNSCVuz9vZpTzLeQjTf/IZav533S+PBqTykPdzNn?=
 =?us-ascii?Q?8er7ds8feXsikbPAkhwrN1yXv1LhM+CKgVvHd+GaU3d9b9wmXTsN3XRAEL9L?=
 =?us-ascii?Q?3BKK2+adjWSWHgw3J8ocBQfIb5owSVBD73TP7pGeRmEGZTNTfBPfIsQ99pDX?=
 =?us-ascii?Q?QcdvFck6eoyLl/ImsFEmgcv46skq4xVtqgdYy9/Ux5+iFsjcbu6pqdK6SD0Y?=
 =?us-ascii?Q?HelVMaFEyaHzCV2FLzS/GDu1rF0qmDJ/v4G4O7D94hBJ19/P1/xRb8mMtDSl?=
 =?us-ascii?Q?1e4l13LzBAyRgpEuAb9yAI1fPobSMMmeE9siI+9Ll3JHIh64paWTXLtorfy8?=
 =?us-ascii?Q?NgH9jeBCqhVVhuaZC9cGnbV4GPf5gTMNe3KIQRS2CT78DVAecL128hBnywPJ?=
 =?us-ascii?Q?0HNeE50ID3Iayw3KdLAoerUeBGXb+ox6P6d7/PyeBLLGbglwZlJIVsxjwabb?=
 =?us-ascii?Q?6MX7pLydOiJZYZwLAS5kqhec19/udiH6qhHizzjAXye5Vi3ekHrwsOxc+IW5?=
 =?us-ascii?Q?V8Vt/3It5JdEoRWG876z4QB9PwM1WDUjLVcAxwZBYVm/RqbhR/HfU1in6PWT?=
 =?us-ascii?Q?U8thkxILW7+58qQaqqNne65koSymDOnOn9EYv2Mc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcc9450-d59b-4c0d-8e7d-08db76aad290
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:05.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoHQBK2fNqu2bso1o4KZpyZoSvUeUAKC2wWcqqXtRnzA9EDz0vfFXeDubKZEvC63IcNo2sSfL3HrsX3qlj41og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Drop all last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 9 ---------
 net/mptcp/protocol.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aad21e0bf536..3ae0b94d25c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1573,7 +1573,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
 			}
 		}
 	}
@@ -1614,7 +1613,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
 			continue;
 		}
 
@@ -1627,7 +1625,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2410,9 +2407,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2592,8 +2586,6 @@ static void __mptcp_retrans(struct sock *sk)
 			}
 
 			release_sock(ssk);
-
-			msk->last_snd = ssk;
 		}
 	}
 
@@ -3104,7 +3096,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e9ca30189731..8c9b2a03dc94 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,7 +268,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

