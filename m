Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7433C3C
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 12:19:42 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id t14so20142389wrx.8
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 05:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=sEdKo/amd96dudg5/yt7fXWidiXwoZIvb354Ws11Dh4=;
        b=Tb8ntJxJKh4CyWug4kiRGXaLHe8wxZkdZoKoXvtf5JxYGzi2SAYUbVrrx5bvdGkYS1
         SaUWrbJsBEOCon7tDh6TgWZPA8IFE5YjnHC2XU7yyXHrKVJndAE0MTZ9xC4SWHy5XiNW
         EpRci4tSsh4/8yE9HDp2NzTE5GX6QUjDMuDSBEpHZWnJVEvgtlC1KUoTgugfjHxbBaXO
         IdMrSDfgTp0bkypher/slboicTdGnob3r0MTiI7Ndy9oOEkZlll1y2I2cOotxup+r71q
         r0Sz3HwzCvWOSjrz379xJKGY8MD+6GhqpElWS6/+F7ntKPDrUnLzJYXNLI27H4eSi4d3
         h92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=sEdKo/amd96dudg5/yt7fXWidiXwoZIvb354Ws11Dh4=;
        b=iB9Kwd79DO4zvTY1Mw9unUV6SZtxQr6NWtTNb7yAwoGFO1TaGY6TBrHyz9exBT3Bzu
         CpDzqoxJMqwkraYBUEQk6g/Zv599R7ZYvyU7w2ql9n8t4YqEi5XSmxnwsghr4zCVoU0E
         NQz9HEEdSaBv3fbEIm3r6JkMko7ifbdRAYqJyg1ZR9WOrAcTvbH/RpnhVJSv5neKy1UI
         R/y3zfZGsEPDO9B/AFCptZNSuR6Xg3zyCvm/AE9nXYLOwqfpDKFFW8d4b+6Xq7jr+sWe
         xNGgseGv744vHL7d0gCJrXoy3IeByWLa0o7zUMADRt+pR1jfVVdJ8UC+XF1p+zeI7RGf
         oFBg==
X-Gm-Message-State: ACrzQf0pqTvPOzxT8uuv/TYZWEk9+4ROkG0tPn9sO1cxVy5YoDUaHX4f
	/KfkhT+XQxHUtKfYf/64fv4iMkdf9w9aT8Jv6ygMHgcTZHf0cxXbbgkkM/8r3WxqA/af60QBRWu
	Lzk4/gMcv+hagYsHFWK8=
X-Google-Smtp-Source: AMsMyM6jQhAv6oWGoX3ZUUJ+y++y4CxrGVSsfZJCvJMtooos/rFgxd7nUpUsO8J86al8i7Tor/OgXQ==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr5089177wrb.581.1663935580316;
        Fri, 23 Sep 2022 05:19:40 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bj1-20020a0560001e0100b0022b0214cfa6sm8939309wrb.45.2022.09.23.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 05:19:40 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v3 3/4] mptcp: handle defer connect in mptcp_sendmsg
Date: Fri, 23 Sep 2022 14:19:12 +0200
Message-Id: <20220923121913.2135229-4-benjamin.hesmans@tessares.net>
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

From: Dmytro Shytyi <dmytro@shytyi.net>

When TCP_FASTOPEN_CONNECT has been set on the socket before a connect,
the defer flag is set and must be handled when sendmsg is called.

This is similar to what is done in tcp_sendmsg_locked().

Signed-of-by: Dmytro Shytyi <dmytro@shytyi.net>
Co-developed-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---

Notes:
    v1:
    - error case use latest patch from Paolo (propagate fastclose error)
    - I believe the use __mptcp_nmpc_socket(msk); is correct here (instead of
      msk->first but would be nice is someone can confirm
    - add unlikely for the TFO check
    - propagate the ssk state to the msk (Paolo)
    
    v2:
    - Question from v1's notes answered by Paolo.

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


