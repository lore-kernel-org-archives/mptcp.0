Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F854C72
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 15:26:22 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id g3so10409630wrq.13
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=Cl0QWFGxCWG418mR28KAVV/a+LLCD7/GfroCYwhEdDU=;
        b=aqVTOtwf8Tx5IuTC7Wbud2V0GR6/YQGfamUvzwRCM1Vbq1OH1zHZhY+7nzPdXDrEUd
         GzaKfdQAkSGUf3ge9oV9nymIPFx9+pIYwlNH2c9sg9nHjQ2IGdFqWw9jJkCE/QwT1X02
         mNXFts99WT26wy/xjs6oTJUUKGpe4gyAo8RRgUaqRyHnojcGRQZ21nX/xHATJ7AxzXgL
         IB82wpNi0ngwwc8fAUKeuah3dCAZRyeIO3NL/q+CVQD7xwa3medWw9qMTEzq0k1o79PF
         V/4GuFBYTT7POcA1eKYCNk7Z1jhAbn4jw0J/4aTmLs3zEqLYnqpPSnMH/IljK68dk2C7
         lv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Cl0QWFGxCWG418mR28KAVV/a+LLCD7/GfroCYwhEdDU=;
        b=15jBgLFi8vW70HLBoY5v2rhl5InYeMsoAkfR9yS3npYR5qS7FB1OXJ6w9ZufUWqtF4
         bvr9fbCQdT7NMJDcsP/V4gKj7iOyKWL4QBE5wAn1BCB/jYt1z2+M6cehAxXLZL1bcikW
         q9C87AU2YlKGyzf0XBNdk8xnSD8xlSdQDhbHs0NnuWXQT+mSflBc+oidsnn3ev1TX7tC
         SUArMyyY4fXQ3zAwGE+3UolhoEZ9swgk75k0uJIBNGFnBzwHZ2U9bWZMDTXoAAYT0TXi
         YjJfCG9HHAowU48W4SJT97aQKnmY9LzeCAQ+/iWfL5mPfP4Fb1HKgvCe/lsmice9uPPW
         IXMg==
X-Gm-Message-State: ACrzQf1pfTjatvkOABHZ38Ur54a9YB6sSx9VxDtx8hqU9mgQW30biq1v
	0nieV2L/KShQyFlH8PPbXyubXP8rhjdY0ffImqeGzCuLqzoR9iV12zfZLXrOaLyqx4WGxteh3nN
	YebwhftNZB30Pqn6AiIM=
X-Google-Smtp-Source: AMsMyM7pG2NIncBQ6Gb4KvNcCplVDzjFHVHuosCZWHeTos9H6HHS9Jf0i1mIt4kKMXqDaALNv7QXKQ==
X-Received: by 2002:a05:6000:815:b0:22a:418e:f354 with SMTP id bt21-20020a056000081500b0022a418ef354mr17765274wrb.97.1663773980510;
        Wed, 21 Sep 2022 08:26:20 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003b4935f04a4sm3994435wmq.5.2022.09.21.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:26:20 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v1 3/5] mptcp: handle defer connect in mptcp_sendmsg
Date: Wed, 21 Sep 2022 17:25:37 +0200
Message-Id: <20220921152539.1851441-4-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
References: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

When TCP_FASTOPEN_CONNECT has been set on the socket before a connect,
the defer flag is set and must be handled when sendmsg is called.

This is similar to what is done in tcp_sendmsg_locked().

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---

Notes:
    v1:
    - error case use latest patch from Paolo (propagate fastclose error)
    - I believe the use __mptcp_nmpc_socket(msk); is correct here (instead of
      msk->first but would be nice is someone can confirm
    - add unlikely for the TFO check
    - propagate the ssk state to the msk (Paolo)

 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d4e197ec567..f5f20910cd83 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1668,6 +1668,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
+	struct socket *ssock;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1681,6 +1682,27 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
+	ssock = __mptcp_nmpc_socket(msk);
+	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
+		struct sock *ssk = ssock->sk;
+		int copied_syn = 0;
+
+		lock_sock(ssk);
+
+		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
+		copied += copied_syn;
+		if (ret == -EINPROGRESS && copied_syn > 0) {
+			/* reflect the new state on the MPTCP socket */
+			inet_sk_state_store(sk, inet_sk_state_load(ssk));
+			release_sock(ssk);
+			goto out;
+		} else if (ret) {
+			release_sock(ssk);
+			goto do_error;
+		}
+		release_sock(ssk);
+	}
+
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


