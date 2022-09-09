Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E644622
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 05:49:56 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso542107pjm.5
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zObJjur29NGVC1x/vbzekAZIqJVc4Pubf1mrnRS0spo=;
        b=a88YNdPUwydWs+QVIEXU4XO9InrBtdO+7sDNYUboAtMWm8HbnnlKrsdQsbe/RtIC9x
         D6CVjeg+PBEZ8G3iU2iQ3ekeeVlQruHbUe1JrsMLcGXk1w1yeT829coOGFyFcQs+hQ5K
         QMMPaxxYzblNl5GTjbj22cNzswSUEO1f5IfOjZsilFEX4yjciWGWC2DLWNRnX/Q5ZyDD
         wpnDdEGC+aiGhKawhKzPc/Jl0veb39CQaQUIaZrSmVcFA4WIXMu6/ptuP54PsnOoAzRr
         3V9Qbv7Z2Ml/cBNJ9m1SAvms0NYSiHqAR+8l31qnbMPejdq73V3LFwXH5zWxh6mC29/b
         4zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zObJjur29NGVC1x/vbzekAZIqJVc4Pubf1mrnRS0spo=;
        b=6q0kuyoN0M+1YsZtiDdgisEzmSHYMjIq2i8igNumFN95XfMxXsZ48ILC9kCgpI+ioj
         7si+jNcSrQ385Zj9R0naxqTepcDjqgPMUkS93qf85WVudA03SMi5loYvR0AgiX/3CFE4
         NYN6HZDGU9wnjFZc1XYcO8xaRFf3iEKew6ndE/ZaAE3k0PihfURjExILT5m9BeEVQrlF
         5Rt/TTzvvlCf6UJTGzMQqEoAmEwwn0MNPQcsPVxNbo5oBpzMb0/2TugGaHckgtuJ3+4T
         /r2I8Y+O+9U6sh80UYMTNs1oco9gj7W5nsavNUw120bpXKANLsz12/uN9OcM2pP+dm1s
         XXrA==
X-Gm-Message-State: ACgBeo36+rekq5xW6Ra4U6ObDPe19AVwWhcKrvB4ycYibYOSuU1uLJwB
	rVMCMYaEIuVeOeEHn1ZgYjtQT8evees=
X-Google-Smtp-Source: AA6agR5QPmz1R0LIrwshm+NjsKE1paI7KrRh3WeuPpl5BJpM+y+grY4BsYnGIAL6OGUg17wa2IxUdQ==
X-Received: by 2002:a17:90a:d50b:b0:200:76c6:9cef with SMTP id t11-20020a17090ad50b00b0020076c69cefmr8103145pju.232.1662702596478;
        Thu, 08 Sep 2022 22:49:56 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b0016cf3f124e1sm492646plh.234.2022.09.08.22.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:49:56 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>,
	Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH net v4 1/3] net: mptcp: factor out __mptcp_close() without socket lock
Date: Fri,  9 Sep 2022 13:49:30 +0800
Message-Id: <20220909054932.246221-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220909054932.246221-1-imagedong@tencent.com>
References: <20220909054932.246221-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

Factor out __mptcp_close() from mptcp_close(). The caller of
__mptcp_close() should hold the socket lock, and cancel mptcp work when
__mptcp_close() return true.

This function will be used in the next commit.

Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.c | 19 ++++++++++++++-----
 net/mptcp/protocol.h |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d398f3810662..1cfb4f1ff4e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2796,13 +2796,12 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
-static void mptcp_close(struct sock *sk, long timeout)
+bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool do_cancel_work = false;
 
-	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
@@ -2833,7 +2832,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	}
 	sock_orphan(sk);
 
-	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
@@ -2844,10 +2842,21 @@ static void mptcp_close(struct sock *sk, long timeout)
 	} else {
 		mptcp_reset_timeout(msk, 0);
 	}
+
+	return do_cancel_work;
+}
+
+static void mptcp_close(struct sock *sk, long timeout)
+{
+	bool cancel_work;
+
+	sock_hold(sk);
+	lock_sock(sk);
+
+	cancel_work = __mptcp_close(sk, timeout);
 	release_sock(sk);
-	if (do_cancel_work)
+	if (cancel_work)
 		mptcp_cancel_work(sk);
-
 	sock_put(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 132d50833df1..8f123d450c76 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -612,6 +612,7 @@ void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
+bool __mptcp_close(struct sock *sk, long timeout);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.37.2

