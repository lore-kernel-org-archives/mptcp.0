Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA22F21
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 11:07:33 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 130so1258960pfu.8
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sOx9vLy2QE28bKyN2t1/1xkztHyRHzHdVNOvKble7A=;
        b=GTAaAJupekkcODiDo0rGjELdVqMl04L+fmXo6NN90Q/Ito8mPzAGtecDXm/pmid3zR
         68oOJ8CJUzGdAk4WkG2NTQcIIqFUX8SplIQvAW2wV9f946QdInuieVYbKvkDpSaM8Sbm
         NpkOwPFNb4glW5BwEQKNwztpvkefYYGUUunTrkCdNtVJiAx+6hb/ZYopAuwXvQgzEs0x
         g0YjqRDfhtmWEvRgHhokGb8oPAWxwGgL5OoLCgBWkDXvSoA/RfdT6qpJgWbgJCUH5x11
         KRfGq68s+iaiUEJcgf3tlqexqIR4gIdo2flv3SxCgkNVAoKqXi1ae9WEVnNyvnlnkUwf
         aAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sOx9vLy2QE28bKyN2t1/1xkztHyRHzHdVNOvKble7A=;
        b=q8vRP3W0mAgsln+U3M0ObPdUmUg5Yl2FOhNDWwtUYUNGmuAi5ZEK+M3C14ZU2NzeSe
         HWY3IW4vYjJhJASXlP3q0jGxubbhpsBWCsr2jk7+3/WjveYnFOH53H8NOKVSAJmzO5Kf
         +dM1mjN2fy3Z04QkF3UVM/rzJyu6Faa9dGvWCUNAHEpgx9y+h46w39gPHPr57n+ITRxw
         52LDVpl62yyIVyyCvNNnRfVq0jn3uzStqw6tnjFy4TLqlCVsIhdLXanCJzD9NlsXmP5Z
         f0qjCfpiAZKSQ2fvZC3gozE91pEOgvFy3ao3n/8/JOUINtVQZc59GdXeHJs4YC0sRfYi
         f9VA==
X-Gm-Message-State: ACrzQf3OdUP78UAl14f+SqVq+05gHkn5V5n1xTxu3aPc4miZ+SdVSQH3
	6dhs4WTZTJdzFLyjlNjRGf8=
X-Google-Smtp-Source: AMsMyM66qZdlV5TRCe6/GnulbcyVg4M2g1Hdw8WYkAs2gkpvDJ/ProLWH+iJLXlUUEXOm2Ldr0VBMg==
X-Received: by 2002:a05:6a00:1884:b0:56c:636a:d554 with SMTP id x4-20020a056a00188400b0056c636ad554mr29787934pfh.18.1667473653336;
        Thu, 03 Nov 2022 04:07:33 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id w14-20020a627b0e000000b0056bd4ec964csm450555pfc.194.2022.11.03.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:07:32 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v6 1/4] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Thu,  3 Nov 2022 19:06:46 +0800
Message-Id: <20221103110649.299284-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103110649.299284-1-imagedong@tencent.com>
References: <20221103110649.299284-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

'sock->sk' is used frequently in mptcp_listen(). Therefore, we can
introduce the 'sk' and replace 'sock->sk' with it.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddeb8b36a677..151d22c91b7e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3653,12 +3653,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	struct sock *sk = sock->sk;
 	struct socket *ssock;
 	int err;
 
 	pr_debug("msk=%p", msk);
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock) {
 		err = -EINVAL;
@@ -3666,16 +3667,16 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	}
 
 	mptcp_token_destroy(msk);
-	inet_sk_state_store(sock->sk, TCP_LISTEN);
-	sock_set_flag(sock->sk, SOCK_RCU_FREE);
+	inet_sk_state_store(sk, TCP_LISTEN);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	err = ssock->ops->listen(ssock, backlog);
-	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 	if (!err)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		mptcp_copy_inaddrs(sk, ssock->sk);
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 
-- 
2.37.2

