Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEA7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBaLjOVvThFjabFk2sdnd+ePVea14AIdGsUZCb8Cul7jk07wBAkTkWH3200JrfWImw+4XHdvfsXXOGEtOjnCBw7dKK1+J9oqkhwERnWibPXxFgFTpCr3onScyZFJNzlu9bW/zwga/pK3EvERpwJGdKZaxdMDMvA2IupuHohhJt0GVPEv8QY932cc2fqN1Gv2jJ64N3VAAu3WgJMixZftsg7Bb/uDDIbjyxcTF3qyilo0VdunBGFpkK2EpqthewoGOgvLmp6v1pZROuuCbN+6k1NdYy6neUPdv1HyH5629sXMbe+lRhNCqgRIWwB6HriIee6mG27jUZ0Zi0dQaBmLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oR3hVQ2Ir1jc7W4bhU48PfKmagBRrHPJgP8GTmNkZUY=;
 b=IbeqDLoHnW6K4hwr7SqNiOVtuNDUkqYy5OpaBJEdgVuRkSO4wNPWHgbfpIbjXJnSE4eXo5KKKVWf12vAUXgArPO9+fFGx+rf42M5fwI5Bz/6PZ7OX6x45VGdv6YN25sXqH7nWv2qEl/zKlcR13FzHlJPm4RGidnVqW7Clsuo1bGvO1Yy5VBRfl2hvqMZeZOhwPNNy2wzpIEyesWUo7fouP+98lRDovrCIaYn56DsOQcTR4oHgsBBc+2GNW3E/P6+ye8uSZTi2i95grS2FmpGPSsVW6m7RB7aXLniWw5AMY8vcVkjJHDyrwDzupmJ9GaoDenTaChlVnKCyXViylt+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR3hVQ2Ir1jc7W4bhU48PfKmagBRrHPJgP8GTmNkZUY=;
 b=axV2tfP5bwaWRlsR6u+zDEWD9iRlwrB+JaFUafILeqLAATc3WkRNdJmBxxQUrH5adEkW3Q/avBFVSEtm7o2PhacDCldATsynPG7app9DjciY0ZdGjUeqPjNqIpsl7oOiRtXGbKTGtorP+lCTKjsQBvA3EyaZXKSVd/VpZp69G6/97S0+5g9dAAVjVIystQVJA4UU9luBsvmTXUwCMedqsEvOzk2dTAhKaAfEPGvGS4fQ1Tjt+csXjY132eDVx/2A5sfhL3NzD05sB63tH/HEwni4dXdVi+T7QJEOAdfOhayFn9SmyeD9MoyxRm9OsL7bjGKgDR50es7K1EKqEtvLJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:43:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:43:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 4/7] mptcp: delay updating first_pending
Date: Wed, 16 Nov 2022 19:43:05 +0800
Message-Id: <e36ffece0b351b71a05bff97f3e3ca1fff661ae4.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f782f73-e2f1-4d54-f973-08dac7c7c5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CXYIQGUugWXjdTV54h+nCOEzBiS/1xn+e66iKxF143zm83+jUO1K+PWg0Bw5Qxv0Cf0FHhPirnqlHAc2bm/698M77yDO3FeUCCmVkV+EoVBXL/uGeOClAzWVt6gjxl/IaW9B7GJJ5hVxsN4RBsJrL42/s1TiHhlkEvJ3xgaXpc4H7sV1Pq4elSiXB3KUtHui163X7TfFJswDHG0C0pt0KKXryapAAqWZ0vhRVIml1ueKPejiAzJVA6+r+hVmsxKkCLaYDKvFerqrKdt3neo8mJIjCrc7618jOa/LlkB0UT7dIgpI6aa8L7fsE4cWT8KXGyqjjQ6NPxi3h62O4xhVaNv8JQJhqlyOyZHd/eO6wxydZ84CiIFtQy81V2yLdwcAGdeblBdEKuccbxQuep0iUp+LZsE5jNNVkYe/0HwdaQ+obY9CLbQRWwplgLKcWj06EGUcBep2VFh1TwqRWY+3PsVvips87hDe9aKMhAzoC+WfzIlyzONiEgnizb++J0oiVqnoB4FXbg1eqfKq6DYufLMpwvmdlFM6/DqQZIwb2nqyVWn5XDSLryDznXsMetH+pBiwsNY8zvqIj4bjtg5mQ44rLUa0g8dcVVo7I+7a+KEOv37ncE27suSFejeYtzwTIgo877gzSsScuVoaTLP4NRI1ME+XQifNRD5ejjrOHcqoCQrg4ycu45GX0fmMROHVvggnLOpPc/hZE6auJIYIFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(86362001)(83380400001)(38100700002)(478600001)(6486002)(6506007)(66556008)(107886003)(6666004)(8676002)(41300700001)(66946007)(4326008)(5660300002)(66476007)(316002)(6916009)(2616005)(186003)(6512007)(26005)(44832011)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1H0VFCEhuU8vTEIc6k+jgrJnoHhHKhkVFfEERpKICeogs78rhTj5v5yIuZ+l?=
 =?us-ascii?Q?ADuFgLm05TDBEFFMOAxuHaTsXZdjMpI2fW3KSDzWAFdotWriVRMWF/6r+5oC?=
 =?us-ascii?Q?aNl32jRpSZuE8GWfCtpyixhz5lbrKATXOoC+tvVOQB0KMnNE4tESWpZdeD6j?=
 =?us-ascii?Q?a5V37IHn/SnLnWo02E8u449JMWajfu34E+lc62ihUnEeMBA0QKK4ZeRMmnwL?=
 =?us-ascii?Q?6tsJPOrBy/s8NsLQM2e3JeF3zRT2MROwuJ+Oc2ZhKkSM7rntr+fybSWT8AwC?=
 =?us-ascii?Q?qiPUnt+8Wq6bGkxkv4AI3qOW0tfQhVBUxB9P3KUQeYzEpT81QdnPYuuMiFjS?=
 =?us-ascii?Q?WwWTYBbgDfkIXCi5zdULNvE3TD+5YWrgs6a00KEeqyzXaRvGo0VdSKJYWfaM?=
 =?us-ascii?Q?C5di3WgTSawkEGxF7NHoHD4RMZZd29G2so2lPLqTueUIRar2NI08CYvz7hnz?=
 =?us-ascii?Q?YCoQZhzPCZmOEvbarSMtq3MBOu1W1C8EvU+oi7nW/3B1KnTQZXtGgCnLrGQ0?=
 =?us-ascii?Q?W8CX3wfhP4I365SmfxwKRLCZriiDS/qrVx62yjAzKxzGBAQD9HW7LD/eKpRb?=
 =?us-ascii?Q?uiJJ9WUR5ouqzQQVQ6p2WaaiCXjjyxgYCv71lXdAYe4psFefuf5xego0iRog?=
 =?us-ascii?Q?v4T3ByOfiUrPyQVCYhKU+O1PHjqseKzhO4/2UN+Tw8F00hYQeL/npzY/9vf9?=
 =?us-ascii?Q?8lSRP3vVF0YU2s8Y06D8FtkLHmDW5ZuP1IvSZUEW+NMK/Ferq5NP5aIoUi/h?=
 =?us-ascii?Q?QiPFeccsTXqao2NencTkmKSLAgt4t9Yqn9r0JsXiawfTwLS+xGsLCRcm6rE/?=
 =?us-ascii?Q?4sKd4l/Gam4ad9+MwOgJSJxjtg+ncEj7Pcl59K4aqXhvauEQm4Z5YCJiRuSS?=
 =?us-ascii?Q?q6CrRQjWh5AZMyva5XHobi6GALngezCqFGhxKO/Piwbg5f/vCv5BjTo1rZV8?=
 =?us-ascii?Q?3+dWFG8XhOehqBsIUrILIDmDk5BC4mX9MgZ/4CasKU/XEORLhxAvIETY+k9C?=
 =?us-ascii?Q?YKjlXx47F65De+wJAU18DmnMCdm8Gjl5n+WNWiubOkjGdj7/czh5taECxH95?=
 =?us-ascii?Q?E6r/+vdmmW6oYVi7kdo251cNd4weELHyq3hfcIMpxXUCt5WRfe/zxhRuw7Um?=
 =?us-ascii?Q?jXCpBO1D8pMLis1fuX615+7snNfcp+avMpZx1bmWWZf/OWsKN8m8HH4bnnxs?=
 =?us-ascii?Q?9/mM2Ryez/Lt3hqAL9d5c/IDcsyR1cHHcozTpdSreLJcWEZuKSSJjiObFItF?=
 =?us-ascii?Q?qkdj5lZVXJHhtNGaDF4VE4klQ8MEHfsFiD/6MCSzapM/4zhm9hHbev0wxeIl?=
 =?us-ascii?Q?FDE+nYjmAH9nzCnOKLnYnvpZCOyi7dsLScdgbyJG9z5GU996vuk0lrhKjLIR?=
 =?us-ascii?Q?ySofymgkoq2Wh8Wmwupxopx7Ig0kIqUbMdN1cfc/1fk5x3UiWukCdkt7Sav7?=
 =?us-ascii?Q?EcI9oPnKoRZC2dCToXE3CJUVJDf9bXIPdbiFy8G15XNQmqK7G+91jbDm3r9l?=
 =?us-ascii?Q?7Euacj3UcaNqtNzGq/yEKE7A05LKgE7wF56VqJWr1g0lKt48SfixnOYycBVh?=
 =?us-ascii?Q?ZAMulKDM6pkYTuZU+o1VH7gjre8YKMwylrXqjF1PiDb4ceam+0kmzdVtFHAp?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f782f73-e2f1-4d54-f973-08dac7c7c5ac
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:43:25.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXnq7sBqmYQSHLECZlXLY51BhFlRzmS6gfu56uM2WpoXAYRrol+eM6JbzfV7JJgg+VZ0w4lO/uzudqH0E/Qy/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data is sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h | 13 ++++++++++---
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b8265badbe29..4c249d1b9ec6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1112,6 +1112,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last_frag;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1502,6 +1503,19 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (info->last_frag)
+		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
+}
+
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	mptcp_update_first_pending(sk, info);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1515,7 +1529,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
+	info->last_frag = NULL;
+
+	dfrag = mptcp_send_head(sk);
+	if (!dfrag)
+		goto out;
+
+	do {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
@@ -1534,7 +1554,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		info->last_frag = dfrag;
+		dfrag = mptcp_next_frag(sk, dfrag);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1543,7 +1564,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1587,6 +1608,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret != -EAGAIN ||
 					    inet_sk_state_load(ssk) == TCP_FIN_WAIT1 ||
 					    inet_sk_state_load(ssk) == TCP_FIN_WAIT2 ||
@@ -1599,6 +1621,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
@@ -1632,10 +1655,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 		if (first) {
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
-			if (ret <= 0)
+			if (ret <= 0) {
+				mptcp_update_first_pending(sk, &info);
 				break;
+			}
 			copied += ret;
 			msk->last_snd = ssk;
+			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1656,6 +1682,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					err = 1;
 					continue;
 				}
@@ -1664,6 +1691,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8536035a71d0..cdce0c092c3c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -358,16 +358,23 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return READ_ONCE(msk->first_pending);
 }
 
-static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
+static inline struct mptcp_data_frag *mptcp_next_frag(const struct sock *sk,
+						      struct mptcp_data_frag *cur)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_data_frag *cur;
 
-	cur = msk->first_pending;
+	if (!cur)
+		return NULL;
+
 	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_send_next(const struct sock *sk)
+{
+	return mptcp_next_frag(sk, mptcp_send_head(sk));
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

