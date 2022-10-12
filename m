Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2C17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieKmCL23ItcV4iOHNZogS81WbI4+/7Y4jCm40WMndp1tTReHvaBseHfXx9nxTXdqM9ShMp4Ulc/bcDgTKZXfcmdS8Q8mxCedOLvoRRRAbQJAlBww+UuMDhahbTsW5lslOkOsoZHOj3zR61e+MadEIVLKXJxUd2kJLn0KK/5k8HrgJ9EGwH77yqdsQRzVNm1JDrBY9ei/Am3xtPZV8pWiH2Vl5Z44vvfnU/g0Reqsm4R0Shw4Zad3HrL3IKS0zdOB6a3UUxHYJbRcAwCTF7a51d3lJdPril4RIzp2DCPGHnsxLhfVSVg0I00EKatiZ1hJeXiQ+7hNDp9/mwxRZgeZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J1ugRQjnFj/22ve/ERiELUmvDgRKvH/YGYu/AKffDQ=;
 b=ZkaA045QNZ/9Q90L5EWYavd94o6GPtNTNqtcIImpqMMidvdeRdB7BAO5rEZEX6ep9nlfKkPPUQnHpgcRJif6pWH4B7M3iOQ4PcXLDHBU6DsG2O47CCyPQbcvGC3ao9Aomlm57fOQOVmeZ8XYcVcYF2xlUxI+F7UDEK3kcQ3mEYuU2sQsgPnAqD0fNgX+VhQeh5C7BCmgo+Xhr4kxbmQnyod7sOoCa4cDsvlbJZ/eJ/lr7gEGF+xZjA8BtijAkEkF/E8fTNi8XIVzWdjKMCv+dhbETWjN0Vp7CAAZBSH30vETfSEg4wT+y6OXh1MBcdsQAVIx90PEghcrkg9l5scz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J1ugRQjnFj/22ve/ERiELUmvDgRKvH/YGYu/AKffDQ=;
 b=Zq9ciOgXK434n1oAadatoqGPixSwgEAHWx4+YOojO9BuQCpAW8BCCIqVESmmcbR6tA/FdwLEwpJ0chujCqn6lkuNMMGOri2N1gl9EXNyFRBpnfsXcND5hh55KyDT/39H2RK34Iek9pi8mGRPH9H1jUZ/8vEE17KU4vr/4q04q69qw4MIImKkpv6jyKcfPeFCBrOz1Wu1zvzNZNX7MlaSr5zQbYjb0Ei31RQ6s23WrWZJSUwBwC2SefWVcbZCeL1LGQ178a5eyNNvR8dlsJ02WGKE0bwdk9Z8YEW8jsIuIxQMtGwvEpbYF2s8mYnQAsg6et4j8eMm3oCOKsAFm4kowg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 04/12] mptcp: drop last_snd of struct mptcp_sock
Date: Wed, 12 Oct 2022 12:39:59 +0800
Message-Id: <8c7a2402131bc217a36bb2643ec55ec6025e93a3.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: b6895687-2e92-415a-e264-08daac0beaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u3L/qdfvaWjD7/ZadS9iFlLbkrCntBmepg1R2oTRNmYCA9DtSFzKZGFXWwRfyo3djWHn9ObbzOvG7R1rYUGW+IN5IDNV893SnSBcJD9LmL0YgDfnJSqc4UOHFqTFf3V5BqAX5lVgmQvGme/7aAX4eraDf6Y/iNZDBDHyzH0QNXQjp/F1UAiuPb0/3A28IaeGfrXb94De1izsBV1OVIiI4aMPuyN4CSkNceasIfWoK004Bz2S9Aqnvp9yeHesyshURVfpyPeoz3pxRootph5ptC2FxR/JwcFa1JgqD+6JCaLoGyEhPLc6lzaXm8H5hktOHaB5KRi+ZhLr2G2c7cmb2T4CLtRecxuh3OpmZpPNQt7J19cXps0GEKMAzMQLcZaj+zNtfCgXv+Uh0eVkFR6geWRGyZ55WdTVc7RmGht232lRHvp5/SgkaP3fKqdCqn/FUbdCfSDqWkDCJk4Y5KzR9hjsetRA3PSdwtRIFEHO3G7LB6hS0gK4UdQHNSxKzB4Qqk/K/ob5SWY5gMcTTlt/rSH/ouMdv9318CwasqVxwVqQ/v2YDM5pVnxal/zuY9WE5tUrkDoooEPY2bmM9vYyYbsNw6KUrFv4UKj1z4DYkgDzw5cMZo9TUnCgIRYDMr0ChzNm9lsBQP+AM4tblnHRAKD69SzHX6XIbfFnGMB6UZMZ9vYyx4s5wjlHSJLCqms1B69l9YQ1jfCz/l+JqthT8u/BMZhQL9Ww9Ew+ZVku/oiBoaUln/GXJCbj+V5kS6JW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9F94zPoA+N8fKJp61OMMQ2pznOs3KVa5H4Och8dHDPuqKiun3WcM8o0DRNH/?=
 =?us-ascii?Q?IoWvJdDPJi07pn4LUpp5Rowg5814Wyi1QdPm/KOEMJaSHyogsJPlg0Yj04vN?=
 =?us-ascii?Q?N/KVJcR+xA5Vn6M1azwV8x5Q/nfu/D2zNtWvXp+KulPUthK1i0Mg6i3ov8CG?=
 =?us-ascii?Q?HeYAsJMa8iGTAWOntmsUW+0ZlAkqXtI1ONziWtzuhxJHxomWsyiAqTaMoy4W?=
 =?us-ascii?Q?ixb11nR/6cyNPVffz9E8oVp4VRmsQZAv1coDDDhxEBwWnl06htAz48wGCNc+?=
 =?us-ascii?Q?p+6XkLLSlYaJrxn31P4Bdmxg065E0WWyVvzO47KVujJ4dBIE4vGhhVKx0RNu?=
 =?us-ascii?Q?FOgmYdFpbBlM5pEHNEWyPVkU5XwKle5sqRsgxNJDrj5F/Z6IfUA61SGFAtPF?=
 =?us-ascii?Q?h3QXefHDcuYJCKNwShBvn0foOtpeoNvf8t1v3QjurYzGQU4Q8Fg60yvMx1mX?=
 =?us-ascii?Q?Y7LDyuiQI32aia1Zbb9HBgL8MFASkoJUnaK3ZGg0yKodV5z47PtIAHSct7fn?=
 =?us-ascii?Q?qs9E74Gg7jxhyamuVXRAVK8ZNBbB+nLVW4uCzUxC9AFh2aZX8HYdiIOHfTJz?=
 =?us-ascii?Q?VjpOQz29Hyj9x+0HXhI5XCwRhQNobmL5IMOAI9yYIUBBPQ3VJuaI8m4snVEb?=
 =?us-ascii?Q?/SGBHuofosWeM8xlGAQt0M5R1Jq29ej8FK68XViUtK4tiBiKw8f1UIcckq70?=
 =?us-ascii?Q?CdweOTfAGwNixAHzIZEtHlS1IFW/hpYHRPizN9/ILkWhxa0otQQiB8rK7N5M?=
 =?us-ascii?Q?zoZB6gDq7ppXhD/nXuxXJ7/Iok+OkVVLlhAxhQCP2w13vsi9dV9QtMAqItYI?=
 =?us-ascii?Q?LHToAQKS/7qhyW5u7qKwAmwPS+KASareK2/kYduNnE+d+q/pxmUyxnpE5px8?=
 =?us-ascii?Q?BsaJKmIl1HK5go7yYar0PmU6CY1PfiGoQkqufPNLv4euxd128bfJjHIx5IWM?=
 =?us-ascii?Q?pgUAoS4l3kl1VBBMlrWZeTkAecvYWxbMWR2AaDzQFpnbvaGEv3+B9eW3Fzl5?=
 =?us-ascii?Q?V2aRfs5TYPdoJvYLxqlhjpgQl+xCk8jX++2ZRhjsKKG4mXnjXYFTtciYtHCi?=
 =?us-ascii?Q?CY5m6myo+x0fkAKzfzrnL/GFcNJjVMWV0zi6poJRhfZ/6vfo9GtWGWPXT83O?=
 =?us-ascii?Q?32i8tdGYMVwCEz3UCjcg9o8+elL6l8b5Nv0CtRB8TnB6fj6TosFy/iFgafis?=
 =?us-ascii?Q?GJYIuGTOPZ7lCXsDNL70vuUrWVoZx28O33kqg4iVBzJkIrlzvqIj0zv+awzi?=
 =?us-ascii?Q?R3ItosT1kAPSTmH93/zJ+AYx16QpMaBXCA/J7cy6BPmn0dorLLQYQkdDDyIa?=
 =?us-ascii?Q?TXnHCfmU8Cv61JWFxUSH69EltBC4hHJF19vglBN/bjjUJtq2BRldzUj39zT0?=
 =?us-ascii?Q?D7DnD+2tPHPLKMw1Dl3ES/KWQZJsGsY37Kog4qJL6OE2WfqB7SXm/7IwPz2c?=
 =?us-ascii?Q?ArY4JsjMmQ65yPfavatwmelGAZSj6SctAF9vJ8T6hHA1UaR30H2pbV1c9voB?=
 =?us-ascii?Q?XqyR6LWFz9yPS6/LKKO814m2ddO7Jh/m6LQIDSaX0KEhueUwqiJLsSsl3YYM?=
 =?us-ascii?Q?y/2OaaP6oVGgPwU1l0oM/jPHIhFHb2V7QjpDX9CAqgBMMOvMYKDPRUDi3xwK?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6895687-2e92-415a-e264-08daac0beaad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:41.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dUBZeMSqbQWgZN2jKU6tkPbUhX+T4AvFQZbZMGGxGYqoQW4GTmYFQe07L9Kw1UPL3/ZO2GtQPbpWzmhBDS9wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

msk->last_snd is no longer used anymore, drop it as well as the macro
MPTCP_RESET_SCHEDULER.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  9 +--------
 net/mptcp/pm_netlink.c |  3 ---
 net/mptcp/protocol.c   | 11 +----------
 net/mptcp/protocol.h   |  2 --
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45e2a48397b9..cdeb7280ac76 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9813ed0fde9b..1f2da4aedcb4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 52ac57fd8c27..7d5f89799c9a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1469,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	msk->snd_burst = burst;
 	return ssk;
 }
@@ -2346,9 +2343,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		msk->first = NULL;
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2981,7 +2975,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
@@ -3242,8 +3235,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d44c97bb41db..68a2b22a47eb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -258,7 +257,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

