Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F13C35
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 12:19:43 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id n12so20154907wrx.9
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=4mTVb33SQX6GPn0CWDxmkK/0imHagQT+Jol7Om6Wbnw=;
        b=hsDsqFy1lu4aN5Hfj0Jc/hMWOFycdjRkU/r6yHKxmhPM2kLU5tZGuXC/McpEdVTq4z
         dm33P9Yce9Oyjg3SKhBI4iHtCGaL5Odty1NIJhk+fcfQ6RhgJORjV2312VM4ldvBsrbA
         8yeE8Rd6dmL5Rpzc8o185+PlzbNtlfQJBG3zWAEb4LImAoxLw2CxUHKNU5ueEPafmzwm
         Ar7oxXd4P/P57RoYDgAWIbSx0IzTANXRjYPJ1UzhOfCsVGpa2aL0Mj3FpF1KAo1Cegk1
         0Ze06qs0hX0ye5PH1TY0kaRQEPYFDpQ4GXcUxIEArRtsAPtXZxOgMtv/2kb3N48HN9dv
         5KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=4mTVb33SQX6GPn0CWDxmkK/0imHagQT+Jol7Om6Wbnw=;
        b=gZuLXdkUzqnsSeB2bnBrNf0v0qS/7MRTJHgaR0SFPUYRWlN0BM5zMBMvTin+uLs0mC
         ISMcLZGi7JhXpap3Ju0QwFC9QC01UOPjgSG++Dl40oziEnYldFiDxJhKUmElRhcb2cZ/
         Zkh574ym5JQF22I5G9R9VLqkpnStYZsCCrpVoJb8TS1Jmbfqaz7kgcWwCR7CjefIP5lP
         5vPjWFAuQmiAssh06oqdW/xJ95Xu8071zx/QVztyfS9ZD38tCWv8Iq680rsnLvomS2xg
         K52oXTqUe2/tyAnE2bhuZQT5nlLua0AYKJ0ytkpTawjLXBKRk8DTS6dq/I//WUsJb+HN
         EeAg==
X-Gm-Message-State: ACrzQf2QMio7MjKQbzC0Nkq6d/IhMQcBTCo174fwvOmVz3oC5Zo32pXF
	UlgqEGshjnfW9Y57N1XrH31ZEO6rG8K3cIY2eE/L2MohyWgjgIFEQEw1dpRaCcDnnzn5cK3JfQZ
	NYmgG2D8pn83fZA96iVc=
X-Google-Smtp-Source: AMsMyM47bau1UQFj/vikZPTRVITWLP1Hqn/+I0YQhUPqOglXClI1vDLyfzUayxDl0jfN96jC0U7GDA==
X-Received: by 2002:a05:6000:697:b0:22a:f737:b10f with SMTP id bo23-20020a056000069700b0022af737b10fmr4848718wrb.222.1663935581352;
        Fri, 23 Sep 2022 05:19:41 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bj1-20020a0560001e0100b0022b0214cfa6sm8939309wrb.45.2022.09.23.05.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 05:19:41 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v3 4/4] mptcp: poll allow write call before actual connect
Date: Fri, 23 Sep 2022 14:19:13 +0200
Message-Id: <20220923121913.2135229-5-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
References: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
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

Notes:
    v2:
    - Using __mptcp_nmpc_socket() without lock on msk socket was unsafe.  Instead
      copy the defer_connect from mptcp_stream_connect() and check this flags
      instead. (Paolo's review)

 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f5f20910cd83..0eeb8115c9d0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3616,6 +3616,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
+	inet_sk(sock->sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
 	sock->state = ssock->state;
 
 	/* on successful connect, the msk state will be moved to established by
@@ -3754,6 +3755,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
 		mask |= mptcp_check_writeable(msk);
+	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
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


