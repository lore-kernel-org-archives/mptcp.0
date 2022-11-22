Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200BEA8
	for <mptcp@lists.linux.dev>; Tue, 22 Nov 2022 03:51:23 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id y203so13205640pfb.4
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 19:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0ydhPJoXSyhpeuxe/hVgjBauVZHn6Z/85xIJA53WwM=;
        b=p/GQ2d3IOWkvExxDHSDyko5DE6DfV+SulXDJHZOukRW08jwP2pSxRJDUe5cWlmz1ud
         19daSZ67BmCcppkKdjIZIiGoxAvDgudElUXwPlp66pupKb/xM+plzENrDet5M8YsL9eP
         eMrjaRio8Aq4iz9cdD8LZAXp41QCdiEfIOuz5BaOjbClt5lYToQ6JbW+SWKtE8cIxjrQ
         XDpsIvJ56orxVlJ/pZOMd9JEnk+SX3dExWC67q5wSU9NAq38YsXGCSxTHzps/7xVV5a0
         kym2M+bBgdIx3iBk6ZDNBvABn9ZLKxWQRiRjtql7IrjVO2VzJ9tIzUYunPURi6AV55+N
         zShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0ydhPJoXSyhpeuxe/hVgjBauVZHn6Z/85xIJA53WwM=;
        b=BuBe0NDvBe+0gApPGbopG7mkK29SOJO+fkHjr0obzBBE7R1/IGKBieQYREjNIG9pnl
         5aoYN4rNSlYflYavGstJiiMfx5ZcKo3XLKem/h6ceBM8J6rrOFHDiMc/xgWqd/lqZBGK
         Hk1AiCj7aiSDIq/VRUMdHJ/Z1iK9adVxzdtp1d7kZQTOp35xjipcfwygv2wu7pIyekwI
         j5EcsAFCpTm03whzmhJx3A94C7WP+Z1at3EjTR2NLNfRKRBP4rV8YgzngJ1tBI34FSj2
         5UYI7xtxzP0e/bxhBIgKowWtYGhY7BXuyuxqGMIUJgNm8UWm+BpJfYmQKkEvm90e1Xe4
         UmCg==
X-Gm-Message-State: ANoB5pkgC7g+Vf1Pi1Bi9PKChS+EtbvhSN3qLA/0UNuAaDOCtPxcrxIZ
	8bsAMFthc+O8GuwRoOrkhuE=
X-Google-Smtp-Source: AA0mqf6xl2boawgUchA5waH0TOaXNGBIoFS821TvakAkK4PExRepErIiKVWoAQ698HCrINJ8fzfexg==
X-Received: by 2002:a05:6a00:24c1:b0:56e:a001:8cb0 with SMTP id d1-20020a056a0024c100b0056ea0018cb0mr3577341pfv.60.1669089082774;
        Mon, 21 Nov 2022 19:51:22 -0800 (PST)
Received: from localhost.localdomain ([162.14.78.182])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001869d71228bsm10707220plg.170.2022.11.21.19.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:51:21 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v7 1/4] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Tue, 22 Nov 2022 11:49:20 +0800
Message-Id: <20221122034923.804955-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122034923.804955-1-imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
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
index a4fd971a7aa4..f9bcc724d9e2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3655,12 +3655,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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
@@ -3668,16 +3669,16 @@ static int mptcp_listen(struct socket *sock, int backlog)
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

