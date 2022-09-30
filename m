Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988344A03
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 14:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuHOB9EPd2ZTTiZ3oR0F/u7L3Iv7EeZc1h9HJuFZpbJrLah4VZYFll4mWzrmbSW0DZXONHo1aPxGCaDuX9dfGkPowo3hzFW4ZfcnLJOXwvPZSIGtX8vQlx4T8d+d//YNF8CB1+P1Z+dOVH1lII5YiG9QvsOaFSNMB4bYBpmx7hoqG2JTTCHAK+9GcFH37ehJd3z61Wom7kVRFu8bLqCDUzwzdA86JFxk6T+6di/2cwNxdNCnwpnTOFprfnDZV0RQyjwT4AXCeniD3afO8VOFklNDb9R3N9KryiUBEetQshuklxXo11RMRrxXraZc9hp9+DTi4VuU50lJsa/P3sXXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVs3sD/AHaNmqUyrcrI7fZYoE/UnxSGB2qVqoth1cD0=;
 b=ScocKGJJNUQHG+2j6NMmK2qy3l0HGk01RPnyGT0Rw3xqxkCldk64gj+VMRNGko+IvBlwwC6QjMzPZtcCBb2B3vCIaA1Yv81Pqbt/g3KvbQJpKjtPEFM+3iCAxM5BpDv+ZOFegVfOcuWS23LhHSOov8m24hp8GEmWJqMhk5pd9+T1tNmImPz/mheTiVLud28OVbBHwvmjIIuUqIfpFOPe0Cq9NYS3R8/ecBGtSGhyZgGis+Y3YjNpN3i3G+6jXeSKh5YoKUqkpyt6uZL/u5yL1bU8jutxfW/5VSsBQtDd3BD2euXVMzG+Tf/SG/aWKnD3iG+wuLzQVUVwBHNI3l/UFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVs3sD/AHaNmqUyrcrI7fZYoE/UnxSGB2qVqoth1cD0=;
 b=0CpiEIRAkFgoNzScN1LPBqp2GtuGD6A16vdH089Dq1Z2urLJ9hEuoh9PAxZUgmLXrdHXzO+EdMtF5O2VBuPaqlEtTVz7SBdpKyTwkARtf2h6VAiU7ntG/EF+hSBq1qfOg7Vsu2/6fOWzVREeC5gZzscA7J0eS3Z311Tykp3yCO0X8BZpDn2fsCDzSoZq752oHSFV9XTsKMcOeEC7VpOXrd6dkKxhDlmDjJ0rzgDUQuM16f0EfLN64fabWiBxqOjauYU58tHjxsT1yqh/NMDwaQzNNESsFCNHS4TajAE0V7O192OzZF3dQgj1iAwB3JBqmQHeCw0JJSdlEGpEn1MNkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 14:17:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 14:17:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/5] mptcp: add do_push_pending helper
Date: Fri, 30 Sep 2022 22:17:33 +0800
Message-Id: <a84f238e5720103744e23fb8bdbc29f1d888cf6f.1664547250.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664547250.git.geliang.tang@suse.com>
References: <cover.1664547250.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e4b691-5834-48f1-a2fc-08daa2ee79ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ygW4EEXR6+ESYiqaj3e2nWHmCgbErdBbc70xt38p2Pogrr0Xe02PzeMFIsFkapA41nl6mwxDySW0BRy85/xwtUwF9EV7n25NASwptoqWUy+IIC2jjyo9aWbBiqecmSDBGNvYdUmN7fcsSPGGbfGh6ZUtx2AL+RKRNd4zoKp6Q6bys4jfyn8zTHBV3HbN5E++I3HTospzKL9mrSK7yR2c4xBDjXFN25qezu/i5vTcVz5K81xCC2i5SwG1OPDjks4udWTrhP5vF9GSoPw5Vby0XE1wOCia+ymrMyzeqIwRLw8gIqb4UNqpCmFladV9FP2wOC2TRCVYBj8XgzwirzzoiKtCLkMXPLT9SVZdWXvd3wkz7JkM07QJrwQVWyzJ9sbn2F+JIW2oA6Z1+Mo0/KQyPoMyHdS5zSNxikVCAuK+aaTq0ZEfovy5QoAx0nebl0b7fL1r212fDfYer0PIl66WhnoHN1Z5XpkdjN+5qQila4RqCD7Wq4mdwBUFG0p9EQNdkvxekX4VYmMM5wjSeDdVcTGX7+zQiBtqApO00j1Dn7feTgA1ZMQN0vN4fDNZvHB0lH5GH5Gf0x9k05IIP4onlw7ibgckiXrluGNXXwjUX3NHGbeHutK6MNBHBTBlUjCF5KrgSHKTdfBCHWKVCbN8BD2jItH2ObyzseS9dvaeimN3SMzgUhEkjT9tPALGELFocFnSMmWBlCremNcixZfKigIGLGypA8pjflUlWb4kdHxSMsiYXltD4zhpkzMRWmHF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(478600001)(6486002)(66556008)(4326008)(186003)(2616005)(316002)(66946007)(8676002)(5660300002)(2906002)(26005)(6916009)(6506007)(6512007)(6666004)(107886003)(36756003)(8936002)(83380400001)(44832011)(41300700001)(66476007)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzzct3LYPpRcmv6L0ckHbiPptNQmqLn6USmXFldFGo7DFst4eMGrkAxLRlXK?=
 =?us-ascii?Q?l46ywCCiqO8f7/r0K3bK2NUMhaD3ePnYjLjR/vk3vpf6STXMHKCt/83aZMWI?=
 =?us-ascii?Q?Wm7YPHLtWsOYqBl6Ji50DeOngXtxsGczC5JM+wPGAB3gQuhGBWBXbXARujBH?=
 =?us-ascii?Q?4URQCTR6mD2KlyKv0+cw6+mGC9pETO4sbtz/wh/8DoJpb9sKYy3X3COHnsmU?=
 =?us-ascii?Q?l+VziJ2ier2IeoZ5rlEv5dzo/8CBvjqT1CJhIr0jyMUAlbQCIQInaXFFzYgu?=
 =?us-ascii?Q?eQK7bgAWtQDeCGOrSttqublS0YAluzUIhJJsWqRkoOgUcsvEETXhF9E2amK5?=
 =?us-ascii?Q?CphCOZDTgwJ9jRp4RdOF3i9X9EtglMtfNOxJisH5fwdC03557pI31IyNCXlf?=
 =?us-ascii?Q?prXfijXeaIj4UiasIxjUSO2c2q9kAEwodwAOQ/Q7dbgB9LPaEvgT1w+MxxB1?=
 =?us-ascii?Q?hkrrVitIkvDdciePvRFHJzzqxrA44Hlib803WvnMkKpDGuMTw3wQjXZ7KM/n?=
 =?us-ascii?Q?JX+F9do9Ty1hXQtQlG9TtQe9GQprLLoAwK0SVltfLubApo3Wd8RA4lnC8Yla?=
 =?us-ascii?Q?LeFEk0zG851uUnuBnb9TsEsh6DZ7MXqDp2knrdXSxHSdKMbIXKmU+IHsHtEp?=
 =?us-ascii?Q?58OD2sCLpuW72QpKccL7/fwxlxq+ef1Wj5PLZ1hnvMnZHyPKsDp+hVgLYOa7?=
 =?us-ascii?Q?8reoSwBpvVzwbhF7WbJmu4iKtaXoXxEKcXxwiIVuLKX5gBjVkUoeOceXCjxw?=
 =?us-ascii?Q?XQEukPQomNFh4mcdegGTkHZiFug1lUgAHO2EwiojTL+qXj+WmmL/UYUGkQUT?=
 =?us-ascii?Q?bnO2IxAmnRZiX3upBBh4Cegal9aZzSY5qcgu4eyyfebcegtnQoynNwSqR0Mv?=
 =?us-ascii?Q?rVZJSM5fL4bizwkZVNL7iqGReuJV2OekEMou+BNKxFNMQ2xZt/9IkUlGsl3Z?=
 =?us-ascii?Q?bCtX1ktdRcgfgl72jvkeMzUbVDXoS+n4rWiFW16OCSYYjiShwD7kdBQmgRjF?=
 =?us-ascii?Q?O1rBiT8JPulK7nTix1IoH2PlWz1StujdW/fEqeNBatP2SJqvRoUWNYlu2+sY?=
 =?us-ascii?Q?xzUMy7nwjRknl95mChwAWi5xD3JeDkvc8Y24/6hxewqVbXWIWuMZSBpnFuND?=
 =?us-ascii?Q?oStHgsT4aESF1Mw85yRgarUk4eBCFXe233pl1H4n0wsWCHjqObEwYy55CwXM?=
 =?us-ascii?Q?o4WCDg7v6kCEd7A1SFVL0Z3x4M3N9ebGLolNX4kMYDzJOW4tGPHr/hIodNvz?=
 =?us-ascii?Q?8adlcmEOU5+3g4+bO1kN6qpTYo1ghwQ1r5gnz4uxC1bjee2eg5MKBc25o3CD?=
 =?us-ascii?Q?8U8m2/xObTSf/dLoFAsQoZhp8BK5VZaeZUOutGQOrcPt7p5PnHvVzQK8c9Ov?=
 =?us-ascii?Q?+JTYbk9ZGcxlUBcCfANTLngbUPgji8Ny4Z3Oe8dYrFNAuC0tC9Jg4fL75gjX?=
 =?us-ascii?Q?mUZB7EZ3DT7x1Hm4XR/D9s5qvgE8HSKrD8GSbXmSoViKKNMaLZNfMIB/QV4s?=
 =?us-ascii?Q?AkpkreWOU8ky8ZGkH3Gdxk0sq6xZnikfEkscJSoGUnSbEZcYw8iUut/ZRoIz?=
 =?us-ascii?Q?/r1rdLKQZdS9xD5y1a8e3XbhBO65nASlmxzseBYS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e4b691-5834-48f1-a2fc-08daa2ee79ad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 14:17:15.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9adR8JMVpz8IEGPO2MakFFl9FCmhaa2XWWd44X+62ArmRS+BwzLAxbQQQ0mvXCihWI0J0kaPBTLB4HLUWvOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882

This patch moves the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__do_push_pending(). And simplify __mptcp_push_pending() by invoking
this helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 92 +++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99a9ec70c7e9..dc5e03a616b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1480,12 +1480,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1517,6 +1511,53 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
+static int __do_push_pending(struct sock *sk, struct sock *ssk,
+			     struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_data_frag *dfrag;
+	int len, copied = 0;
+
+	while ((dfrag = mptcp_send_head(sk))) {
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
+		len = dfrag->data_len - dfrag->already_sent;
+		while (len > 0) {
+			int ret = 0;
+
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					continue;
+				goto out;
+			}
+
+			info->sent += ret;
+			copied += ret;
+			len -= ret;
+
+			mptcp_update_post_push(msk, dfrag, ret);
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst > 0 &&
+		    sk_stream_memory_free(ssk) &&
+		    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			mptcp_set_timeout(sk);
+		} else {
+			break;
+		}
+	}
+
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+	}
+
+	return copied;
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1524,49 +1565,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
-	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
-	int len;
 
 	while (mptcp_send_head(sk) && (ssk = mptcp_sched_get_send(msk))) {
 		lock_sock(ssk);
-
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0) {
-					if (ret == -EAGAIN)
-						continue;
-					mptcp_push_release(ssk, &info);
-					goto out;
-				}
-
-				do_check_data_fin = true;
-				info.sent += ret;
-				len -= ret;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst > 0 &&
-			    sk_stream_memory_free(ssk) &&
-			    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				mptcp_set_timeout(sk);
-			} else {
-				break;
-			}
-		}
-
-		mptcp_push_release(ssk, &info);
+		do_check_data_fin = __do_push_pending(sk, ssk, &info);
+		release_sock(ssk);
 	}
 
-out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-- 
2.35.3

