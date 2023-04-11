Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407979473
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 20:42:26 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so3128474wmb.3
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681245744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwF0PomNECDDUOOp20oDb80C76i370h3UDr06DP9I3E=;
        b=AhJ4Nl72uzaN1JjDbbVWk7/9sNqAzcKUEt3q79fGQ6jXFsIWOdFWieqkn0youXhbQi
         qN3KDiVxOjtnT03q5V1ivqaWktKCH4QhA16mDYtg12tJCj3hz3YQsbcpPX/jWFIT7d5j
         Dd81/6HKW8Bw/qBYgZBW31Jv/eEEc2G1q7d7LF7p8H86X8MhDjB1NFV0mdp17Kp3QFCH
         +CGk2Yfez55f09f1EaXEYHEdgkUYJxOyKdAS88BUtpaMZ5KjJ9CoWEaPHxK15DdNCx51
         gZXKrq9YuEQJFgkp3R7tIhnfn7y5ZtHXTqXybBt2LAdCTVCfuAdINX4JKc+lvGjyqtti
         veww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681245744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwF0PomNECDDUOOp20oDb80C76i370h3UDr06DP9I3E=;
        b=wJNY1JLWkhjXzsLVNFYFfdt+dSv05LvQEelLi/JCB23/eTKVreFrzRzom59oca3YVd
         zGmbZf0ERaf/81rD8QL415KHWKP7QQm13bU11QQpwIEyByoDz7rHDsqZORw50GqHsqV0
         qy4jvWMWYBisl/i45lwNpDVr3gRqtQxgCD63Tbu4J+bvu1RyXIB+L9CMikubtopEBjkY
         X21BhjaOGVQ6S1x3HrqylDMqIz67XTZFa2d3+InJZzJ0igzspaXyFV6p6tWH+E49vFtJ
         tgiCRlNv3lSt0WGE0/m6MqHOY+aak5Hj7QdFkuIduLaqw9FV/wwMz+/ZKBsnzNcr2+y/
         W0ZQ==
X-Gm-Message-State: AAQBX9dmJBDXzFvAuZ251BziT/NPvmxLWdOaL26wP2QR1pRjDE0OZLe9
	0pTFIZ4xiI+YVEtchA6XbFyewA==
X-Google-Smtp-Source: AKy350Zls2SHdHmNAC2DbLyuiYu/jh89wReNkdMz3I0heC14eNk/G9iiRPMuMSIwzsGcuAg5Ph5APA==
X-Received: by 2002:a7b:ce11:0:b0:3da:1f6a:7b36 with SMTP id m17-20020a7bce11000000b003da1f6a7b36mr10876922wmc.0.1681245744378;
        Tue, 11 Apr 2023 13:42:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f0824e8c92sm86887wmc.7.2023.04.11.13.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:42:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 11 Apr 2023 22:42:09 +0200
Subject: [PATCH net 1/4] mptcp: use mptcp_schedule_work instead of
 open-coding it
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-upstream-net-20230411-mptcp-fixes-v1-1-ca540f3ef986@tessares.net>
References: <20230411-upstream-net-20230411-mptcp-fixes-v1-0-ca540f3ef986@tessares.net>
In-Reply-To: <20230411-upstream-net-20230411-mptcp-fixes-v1-0-ca540f3ef986@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=nbBO24auZXUWf308UdJEaew2MvvQb/ZCL4hcsSnZZco=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkNcYtUcj7Q6j4WeO0kFmzxIFRoXZWHxD6M2oLB
 BWnzpr5r2OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDXGLQAKCRD2t4JPQmmg
 c+xXEADiejdeMpap2B6k+q3lrU8trhAf2j0xGXgLdkVwGw61AzzT7bfu3PiekvRxxODFuSInxVh
 RbX7JzVzzNvc4FDm4Ry/tBoLuKA6vIeOG1ATl3WShoP6SaQbtRiKxkfE3tkeC6xGWGioxtTtBzf
 j9sLuFTCjJlnAP2mwta+XBiZPCk6NPTK5q6BlqxLGo/C2ejI2+DT2oMNvJDUxudNYZy45Lo5UKf
 Dab41taPjznxNYS955adjfwlvjHVXRfNBYd/bHSDHCOVB1hGzGfjjSnuR1Jy93lNnr0djnE05iT
 lNzUYqahz8JGujV480GapHd4eiRcKEw+9b4nIEr+VgHa16hyyoOGs8czHyqex8HTNC/NC5KbnZK
 VfR8K1iZa7DFKlbsOFwzvwh4sztHFPFj0ZFCrt/qWaiwhEQV0w8WhpnW1abaqy7aTIvePanaVcf
 MuGaqa+KFTU+AHUWySD+KZFwJYmGp0j3KhvGOcQbI386NNm5alCT7mbMbRkv3gPT1AisER/nVgq
 UbDIyIsWjmV92skkC6P9zTiuI3jGuQiAVzFyzwPAr7PmGtAtkIH1omSWtFc6JYoklDTg25anefL
 25/pMtBa0epgjyUBU/uGx4ivtiDme9pRj1zgyAYHGSsWA0m7e39+pkYUjyMdC7UQPe+KFdudK2x
 ZAOTVtGRyl6mesg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Beyond reducing code duplication this also avoids scheduling
the mptcp_worker on a closed socket on some edge scenarios.

The addressed issue is actually older than the blamed commit
below, but this fix needs it as a pre-requisite.

Fixes: ba8f48f7a4d7 ("mptcp: introduce mptcp_schedule_work")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c |  5 ++---
 net/mptcp/subflow.c | 18 ++++++------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b30cea2fbf3f..355f798d575a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1192,9 +1192,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
 		if (mp_opt.data_fin && mp_opt.data_len == 1 &&
-		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64) &&
-		    schedule_work(&msk->work))
-			sock_hold(subflow->conn);
+		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
+			mptcp_schedule_work((struct sock *)msk);
 
 		return true;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a0041360ee9d..d34588850545 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -408,9 +408,8 @@ void mptcp_subflow_reset(struct sock *ssk)
 
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
-	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
-	    schedule_work(&mptcp_sk(sk)->work))
-		return; /* worker will put sk for us */
+	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
+		mptcp_schedule_work(sk);
 
 	sock_put(sk);
 }
@@ -1118,8 +1117,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				skb_ext_del(skb, SKB_EXT_MPTCP);
 				return MAPPING_OK;
 			} else {
-				if (updated && schedule_work(&msk->work))
-					sock_hold((struct sock *)msk);
+				if (updated)
+					mptcp_schedule_work((struct sock *)msk);
 
 				return MAPPING_DATA_FIN;
 			}
@@ -1222,17 +1221,12 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 /* sched mptcp worker to remove the subflow if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
-	struct sock *sk = (struct sock *)msk;
-
 	if (likely(ssk->sk_state != TCP_CLOSE))
 		return;
 
 	if (skb_queue_empty(&ssk->sk_receive_queue) &&
-	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags)) {
-		sock_hold(sk);
-		if (!schedule_work(&msk->work))
-			sock_put(sk);
-	}
+	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		mptcp_schedule_work((struct sock *)msk);
 }
 
 static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)

-- 
2.39.2

