Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131F3224
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:49 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id bq9so13217293wrb.4
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=SJaJNNWvXr+uUW+7FUU0Qt2mEuzYS6yLzpvutRM90+8=;
        b=bsff2HIzkMqrJTSioYGXpqTHtUJWtNn1U3M1AAUop3iFLyULHmOOX0EQ0HfOhGhtXV
         z7otAnQwTKiRseReAb+Cw/kPlOs5WnfhW+9c9WDoQRG/BPdD8iad5fTtirYnLosknmLr
         ovm8ahYNT8s1W9joRrZltuQBZUhy/cLbMp2ZzOcIaxbo4hPBoo1b6rr+ouTmQwRtsuqz
         qsbrGPqz9lVnJJMfpSJrShS31PA8JBtqsUBuFCviXuAAhFWzpYvBkQQh7GptU+UByXEq
         O04tV1MBeLkV3fkKi+MjA7FJcB8usdLoFQbuzALrZfLwZ/bFlQJ8ZG7zCwG+E1m0QdXJ
         4MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=SJaJNNWvXr+uUW+7FUU0Qt2mEuzYS6yLzpvutRM90+8=;
        b=MH3d4F4wnu/UG+FNwoa6bPM4crk8lcJrYSz1Uv1fXxQRXwQKF7s/mr3EdIWcEEfkPh
         6+sMCa5xjU393U950tAsO4e/jVoOSczd4xX1DOiFsxfyPz6c86U7Z0i8Xq+TVp8r1kOD
         Y5MDmIwUKUlBKRl1jXs++pQoSgPnnm3/RHGUgJFJqqa1nvuaLydJbOdpXJ+YtQrMt8R6
         KqmcSuD8phn0Y4tjhPo5TfVyu2iMir/8ZzWYsN2nw6JK25ZD3fdhCzwLrWTbgY21jndW
         XqmvIZ6+py8CpxxxS69xiCKGEsIyVyBcsrPLOyuxItarlNV5zvrN7D5IQx6BvSDA9kvJ
         w/3w==
X-Gm-Message-State: ACgBeo3mhOdc/XlNLGg6YO/scu7kZ8O/T8QwzGwG2ABgYVWBWwtPNCPf
	21J27ljDVkn8LtqWp1fYfrNYinSgfrvo/gGh68PumcPzZp7DWTinVX+HZtcj7AYDE+2Fl9GwQKk
	Bm/cHCQ9ouJyYqkXnQKyXkg==
X-Google-Smtp-Source: AA6agR4Hrt5j+fMY0VpSl4r39k5YDrtP7F01X7y4yzP0bkY9GtCeGWBRg+wKGhR/VB/ny6YbTs3cig==
X-Received: by 2002:a05:6000:1867:b0:21f:f2cf:74a8 with SMTP id d7-20020a056000186700b0021ff2cf74a8mr5200108wri.344.1662644328101;
        Thu, 08 Sep 2022 06:38:48 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:47 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 04/10] mptcp: poll allow write call before actual connect
Date: Thu,  8 Sep 2022 15:38:23 +0200
Message-Id: <20220908133829.3410092-5-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

If fastopen is used, poll must allow a first write that will trigger
the SYN+data

Similar to what is done in tcp_poll().

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad81824bdbfe..c249ce632c5f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3676,10 +3676,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk;
 	struct mptcp_sock *msk;
+	struct socket *ssock;
 	__poll_t mask = 0;
 	int state;
 
 	msk = mptcp_sk(sk);
+	ssock = __mptcp_nmpc_socket(msk);
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
@@ -3694,6 +3696,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
 		mask |= mptcp_check_writeable(msk);
+	} else if (ssock && state == TCP_SYN_SENT && inet_sk(ssock->sk)->defer_connect) {
+		/* cf tcp_poll() note about TFO */
+		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
 		mask |= EPOLLHUP;
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


