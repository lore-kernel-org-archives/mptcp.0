Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8CC2F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKRFSBqXIXqBc0vcTs2TU2vX2GTuP6eynTfEoywRh1Rpg3ozK1ayXkVQ6P6KcXi0Vq4r75UUW13vxt6M3FeizO0G3Vy14DWN0F2QMlVrC+aqaDX80zvPP3A2gsB6vSVInm2m9BExJdGkMB/nBgOfC2vm7fvV9Vy8I1f8fgJitYT3UG84mWL0i1GS+j9hewx6rQQmuh2ot0Fks/qkeSaOMsjUuoZ4aIdSuYnFDI/WGDO7bf0zDeHr6UPUCHd4dt0SZeVaNO/2vcRSVSXxXl2mNjCibzDdKmK8htKDEFcmYaKVxuDRPSX2k4cCg11+Psv+tP5krO+fpt+JJRGRrf5fKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iszZLFfbkflw+3GUV/kZdKhKPStHpkJpqhTc5iCuoc=;
 b=k48/eHZtq0DbOhJ2DLYlOkXOhgiTQZeUknN3TCzb864QbjlrPj87yubh7pamciX0okB9b0xDS/x/UWwEPplJyiSnrSJUZ8luiMLt8UCApQXDdcFCQcpGI2nr7KVCuwzTlwq1FEdCe6k7Qqx2mijV//QIT5uhqz5zyead179rqqegN3BVHLkMvmTMO2TAl+JsVw7KvJfd8ITID10qllKLtv/mKP0ytzqTAGwSRdRUgmiZOAw8qxVcWaUSnnkCxLufV8TohvduTZnMbqpgmYheFBbsegEywIClJyVSHb7S3Cstbqm+eVNB+2nOyOKyx3CLOrubORyMgAowjwaCKeQLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iszZLFfbkflw+3GUV/kZdKhKPStHpkJpqhTc5iCuoc=;
 b=HQIX450VsocIRJnWlLqrH1ANQFrvSa1uhdLgBVe+bFYneLZo9/rvVLEEE5S0mEdyUFtpuCvxtPXwa7aPHBcMsd2lEMGhaF6k7ywXYgSRAHPwKsbMSj9nDDwqE5miZ1SY7LGu1jj9E5hYfeCUOtnY9yeO+A8Yk9fTfg+1VeiJe3xFcHPrQkvxolFA/7mVAb4f8NmOcArH8qHMjLdmFHV1DCEbDGhdiDWQ52U4kOIL7iutHGo/bX3KUgsCIjxUi2qNh48Ow+O6/zrwAGmQoYbZve00hDTLQmXBCrZt6HKJDyKu7c15cBVBs1YPCremT7csyOC2cAJxMgPHAAbV0dOJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:36:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:36:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 5/7] mptcp: delay updating already_sent
Date: Wed, 19 Oct 2022 21:36:03 +0800
Message-Id: <cfadd8bffc2b673bb40f4348f3949e8d0d193ae9.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666185947.git.geliang.tang@suse.com>
References: <cover.1666185947.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7b3ef5-50ac-4d8c-7067-08dab1d6fea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QEYXgV6VmWbgJEQnVQ4DUQg7g/kviahyQh4cboIvnhHtFWFQL4ktD/ZEximV7Zd2Kh0vVgaVhC1H1NQFmc9q7VJcGmuWY0TMrg+Hxd7qeN5K/Vf7bgPzleQxnQPT+R7KQ3rYvu9DCN85oco42/XVE9uFkgdRvj+vtx8IupVsSN9VGTJ6p90ljvC9e8rqV36yn6R64NFf+iJwxIXJ3qPxP0wG3dsYGJIyJUkHKTNOggY8yM99Wat9LrAa20nVLXFK4r4k+nk268Pee21vb6vIBR2GhIVY3txBQuiOj00HYQf+sltqUToclJj0d6GzxLMLICH5nMLYFXlf6lh7A3ow1Fo8aCZv2tzYMYI0KvenWvYPHqfOs7NHyhTtcfd2syN/yXWkA4nufnv2JYGXMhwV3vlzjdT+wLfmbbw2gco4+l1SY3tsgpE2rensJo6PD9CoqUrct4ypiJA0TGebmIUmGdScJ8wdjoNEAMp8JaGYnzADgzz9T9x8L37pNbVpXDQO5FPxeZf0YGOmboLJfl4DsMCBm5A/9xDnGEQ7s+hEMKyK+G+3Yw+z9hhNkhRNgYGHKlBxpEPlMdqvHMGpINX+ZYE8tziASpQhHr6RyKQP/R/C1ToL/lh1PFyvEEkbGvpRy9kjUVRjTxVZvnwmOYkKw73vu4RLrB2vnt+uTcZcDPqG28sxeHaY1dJgyVb8gpy5JNchT4XWPfZWdP4ikhSBDxHo28rlNdyLtcw2ENmn/KFU7MXhAyl9xAJSeBX4wwl2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(36756003)(86362001)(38100700002)(6666004)(107886003)(66556008)(316002)(6916009)(5660300002)(44832011)(8936002)(186003)(66476007)(2906002)(6506007)(2616005)(478600001)(66946007)(6512007)(26005)(41300700001)(6486002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ah1T1h83iHg/gMwElOafjDPzj7KY6snPKQjMRy5/iVb8dZFe+RXkKH8xuwh1?=
 =?us-ascii?Q?1uhunRz7JhfeORwAaZCZevGRrF4U1tJi5vQQG13/xmXFlPP4Saw3ppO5GLar?=
 =?us-ascii?Q?70pdYTljkbN/7kABimBgI3GfjO5+CBw7Ue1UnAS0JtwRx2blkJjb3SJfilre?=
 =?us-ascii?Q?eDl6l/Lh3SUVlCKof8dAkMZxzBJG8wwUcYAul69Om/SFNF9NW99yFlnzMo0J?=
 =?us-ascii?Q?4DBCA03ZLtL5+qLUr5EDqKpmMGNtrYwrsiHFXsiKlTFi7qUlqiXHOuTk2beD?=
 =?us-ascii?Q?gWcJ2qHxroQbzwOsN6t/AlTN3Ike1nf80vG0ICgovkjZnK+zafPqy9CZjw7p?=
 =?us-ascii?Q?5zgCn8aKYirzGifw/aC3s2PtBFsc7kX6WLPHRanip/SLQnQMAw8gg03e0ZUd?=
 =?us-ascii?Q?4qErNa7iYwtnyglAnsiyHpkJZi+bN5CXAidu3MjwgKofzv7hANCy9ANJUNtt?=
 =?us-ascii?Q?GFOjQsCsjw0cl1JstoV/koaFWEUQGrfuOOOkX368KmS5F2saRYX0IXjNv/bW?=
 =?us-ascii?Q?fvpn+C9ZL7pvNLcZziH2eNvpNrwIX07MPcF8NtdbSay8r7FvykMmWqrmEasb?=
 =?us-ascii?Q?NSJPZqdMNfMw2KPbnenzQyMWfnZoBIkZlHzA+iylG9XCDArrK0ECG6hrV/CY?=
 =?us-ascii?Q?xyQudJLgQ+BjSDesu3kJNkaYcpUcZuECivj9q3ir2ojMEKbaoUeNCcKY4JwQ?=
 =?us-ascii?Q?UxOdFa6fqpu1Q0Riw7O6GRZPIIVCqX+4gCF510e/cera56Gvrp5lHDykbJJi?=
 =?us-ascii?Q?1Prir5djyIjn5q4cHH2Pet241SFa0jRYSBF0JM0LJ00syz5fjOWkc567exSn?=
 =?us-ascii?Q?BA5tsh1FSZw5uw0cjgWqFkKqa//8sM/yg3lIKmsqpisfoy6Sqr2LFwjmM4kt?=
 =?us-ascii?Q?vJ6+ziOgCphhCvyE33uKWD5qj7jPuIQpxifzAMopHG+SRVZ+Idn13K07lxty?=
 =?us-ascii?Q?VxiGCmNQAbqm8CFEaiap5yFSXoonByLVEcJY73A/CAwk+rYlTIYvay8pJz3B?=
 =?us-ascii?Q?f8jCDZuLaz62rnShLJ7xtD9SJqmgZd5w28/bnkNNT37tA3zPtaIyzNC0Wink?=
 =?us-ascii?Q?XFhoZFP0LHMB8il0sQbW2IxK1vq4WwZH0h6599oS/JfeOJi0nQFT6Y8LE0ha?=
 =?us-ascii?Q?497Gw5VTfmQQ3NS2+BUrztsfKSwOPAO5nRhRvWrEMQKQ/bzPAxSF5TyUrDik?=
 =?us-ascii?Q?CV2yyuck8ap/vdJTZ1RtS4DtTPdb/X5Yo1roeSua2mhRAnOi0kpmjr1bYVcZ?=
 =?us-ascii?Q?HCA0UQljVSVmGls36VpR0KzrjsZsAnZMsCguGwpSY5un90+CZ2tdfNCbGZ9a?=
 =?us-ascii?Q?eI35AYsK3HkT39E3o8ZUfXjGWHwU9b9GNl1k+gJNIUdOAg56dV3iVKE81iB7?=
 =?us-ascii?Q?cFDKhZIhlluu8hocYetBf8KwAtpZRp6H8DdyVu9kHCXrkBNsS/ALWNvTSbAa?=
 =?us-ascii?Q?xG8jER+coTXpC5M5+yFfHgqXnr1LMWzib2VZyVJLKlRSPVtvM4gsloGd/pfa?=
 =?us-ascii?Q?nx5bGHTIuZwJUeJmgVOAkGxPfYrrT09b6JkjqGydpTOEpriySG33GpTGduXY?=
 =?us-ascii?Q?jDr2//5UKD2SoTWDY6EMWV0Btc28Z6Fg0U5hdUNVvMGY7UgriUOi4/22gdAw?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7b3ef5-50ac-4d8c-7067-08dab1d6fea0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:36:58.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miJ2Nj1YAssaxn7y7mqKuFuSOk0l3uWT5dQJJY8uBqLVvCr5ERPrUf8/laF5qWQrHfNz8Z5abRZcM0zJiC/qiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

This patch adds a new member info_sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrag until
all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 34 +++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 +
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1fef2b0c968..8ae8be76a09e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1108,6 +1108,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
+	dfrag->sent = 0;
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 
@@ -1243,8 +1244,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
-	if (WARN_ON_ONCE(info->sent > info->limit ||
-			 info->limit > dfrag->data_len))
+	if (info->sent > info->limit ||
+	    info->limit > dfrag->data_len)
 		return 0;
 
 	if (unlikely(!__tcp_can_send(ssk)))
@@ -1496,11 +1497,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 {
 	u64 snd_nxt_new = dfrag->data_seq;
 
-	dfrag->already_sent += sent;
+	dfrag->sent += sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
+	snd_nxt_new += dfrag->sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
@@ -1523,6 +1524,23 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
 }
 
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
+			dfrag->sent = 0;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
+	mptcp_update_first_pending(sk, info);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1546,6 +1564,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		dfrag->sent = info->sent;
 		while (len > 0) {
 			int ret = 0;
 
@@ -1556,6 +1575,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			}
 
 			info->sent += ret;
+			info->limit -= ret;
 			copied += ret;
 			len -= ret;
 
@@ -1619,7 +1639,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
-		mptcp_update_first_pending(sk, &info);
+		mptcp_update_dfrags(sk, &info);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1658,7 +1678,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 					goto again;
 				break;
 			}
-			mptcp_update_first_pending(sk, &info);
+			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1686,7 +1706,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
-		mptcp_update_first_pending(sk, &info);
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 118fe5a2745c..f60520bfdb7d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -242,6 +242,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u16 overhead;
+	u16 sent;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.35.3

