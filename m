Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286464C
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 06:11:52 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id b15so907807pje.1
        for <mptcp@lists.linux.dev>; Wed, 05 Oct 2022 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dSafesNQgHD7ZwadbJT0090Fsu3V5WN0dWI0fRLQpP0=;
        b=RpUq4sEPrd+16c2DCXSiETgPhT/8oQBhs8ZNHuaDM8EPDXZjj+lQq5vQeLrHf2I7JC
         lNYiAIpfXs0A61Ag4mnV9zrt7r8cFkNn/E77b+8Q5wnXCXc/D1Mu74mbWEys539NTEfK
         SaxWFfIG9vZEUbF9vI4rLStI6zbvvercIN5Gen2UkWgHzrasMVz1PS9GXj2tbYcs6Y+Z
         V7NYdck/FAAHtmOYFmpnucvTMtqek0VOceMbGQ1fFXOPz+fG0P0vJwN0Rz9udHb1can2
         1B56Rs9UJLt5CgeHz1sKCLFuyMS6RpXjZ9THPIYJM9DFGdnzsAsyd0YUfghIRpDuiAvr
         Hd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dSafesNQgHD7ZwadbJT0090Fsu3V5WN0dWI0fRLQpP0=;
        b=s0xW/RcKmrrMpCao3DWHl/YnUIoTq/Sk2kbcZziJLO1gW0vCL4a3dSZZZL0acs4Ixl
         1Bmt+5lxRSg5PD+qlRTHS/Mfg3SEAg8W3SxvwydXYpTvd+shz4IJj86WpU3J9YQ1UG7Y
         sqG/j5Y/Uw/gG29g7HAaKnPhFi8PSiEM577euLLrnDYFpKQbo9zWgRVVmaUbmLUsUGPO
         IL7AgEx0Y47jSIbRayVpMF7sZcTLwcml8wujIiIFU4WxXsgUMnXAS0FJ6+E6KPuxZn2O
         Lk8eianTtbhDdaqERGRr4hMsi/4DRsroNJ5ZytMM2CbxHgcD0fj9SfNu8c2x/GpsE7eR
         ZKgQ==
X-Gm-Message-State: ACrzQf0jK7z4hckRcIzduMe8nMN/qwXXX1uuKICGZzVRnis32xqMQsWg
	k+DiC6GEOh7ZmBw9RtzY+hSfUF4J3jLw9A==
X-Google-Smtp-Source: AMsMyM5x1jvmtZ2JYYHxUvVVYAaDGroisNeDn1eEvRCAh+U76xracRyIo3S4EorDs/EAgtzXHb0BUw==
X-Received: by 2002:a17:902:ce8f:b0:176:d5af:a175 with SMTP id f15-20020a170902ce8f00b00176d5afa175mr3333085plg.123.1665036711814;
        Wed, 05 Oct 2022 23:11:51 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b0017bbd845c17sm11398046plb.158.2022.10.05.23.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:11:51 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v4 1/3] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Thu,  6 Oct 2022 14:11:20 +0800
Message-Id: <20221006061123.1474224-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006061123.1474224-1-imagedong@tencent.com>
References: <20221006061123.1474224-1-imagedong@tencent.com>
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
index 760404b15cd0..d817fdb2f6ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3577,12 +3577,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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
@@ -3590,16 +3591,16 @@ static int mptcp_listen(struct socket *sock, int backlog)
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

