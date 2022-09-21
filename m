Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFF4C6D
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 15:26:21 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id n10so10409883wrw.12
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=G3FI+a0WxAwNMcUnh0b427qJ8UdMTqO31XG/ICJRL4s=;
        b=had5XNA/x00YhZHcvEL77ogIUXrns8lC4EN07371GJV2iRcNh8EW/jGN3ziArtDhWH
         au7LRaxkk+V/u7yRXpnSoFxFkaW1Rt3kAeDvQ23lOoV/9mliNjsWFqzUPU3kMJgPcHyY
         inTkynPx1dmb0sKAvRXsqnDN30b1/BctAo8PioL2ESbwK7ABnxfkbu5mVesz4DwLdFGb
         kUCQjwZZ9hXEkQ59e8hd6PZ8niIRqGZtbiPlD2xJtkRQodGC2Zdty/otvwSkxSIVbPXg
         s3fGhE2phYHPXOPZlskWK9ZyDXUVu/VINBg4rA8jSd7u4wBIbax+0Dn3mXAIR0ZOLwug
         pQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=G3FI+a0WxAwNMcUnh0b427qJ8UdMTqO31XG/ICJRL4s=;
        b=hI9gUOIY8383clZwXCUzgn7XAZCRyUE/kR/OrFeM8mxgo3QRXlQgIaon1w6KC5MNYl
         h1iDs4gZQDalqh4N+lL4wjOzCd+kCUdpD0xxXy6oI1ynaR3ov3VA2wp0TtGa1WLo+Sth
         /kP2kEk87U+ph2fbp3gBW+xeY7poRkUQrRCAm9+WQAELrNrEw8ffD3JcNDjAc0lctRAD
         54LLZBe0MECyf9ANAbkathCChQ3Z3ZuPrwhxIzeTDBLMGwE4b1OGnW9/zaDGxEvk/sBl
         y7Cns7OZ9RAAPlCt2S62O3Tnn0fxpt6X4oAB6oMkCIzhHd6BNPyXA8JMXCjBJ0+BFhfm
         v0Pw==
X-Gm-Message-State: ACrzQf09eEq8ikkPIgLiKsA7aW/SC1UtjjFM7pRWwMCBOfkBHAOu3zEQ
	B4vAw1PanJTSfCospVbS8Gw+YLPsp2KrhVjgp2+KPjh45FuFh/qdJ9h81r5kNIhapnZCadf9EnO
	n4VyLJJmK4vegwzzmNvM=
X-Google-Smtp-Source: AMsMyM4W0qdNxTObOvgUWxUtICd3MLAorUy8SyViSjru4ojcVy0Lx0hEFEma2DsiNHT+eZ5ly0w+IQ==
X-Received: by 2002:adf:db44:0:b0:22a:56eb:927f with SMTP id f4-20020adfdb44000000b0022a56eb927fmr17932488wrj.627.1663773979756;
        Wed, 21 Sep 2022 08:26:19 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003b4935f04a4sm3994435wmq.5.2022.09.21.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:26:19 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v1 2/5] tcp: export tcp_sendmsg_fastopen
Date: Wed, 21 Sep 2022 17:25:36 +0200
Message-Id: <20220921152539.1851441-3-benjamin.hesmans@tessares.net>
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

It will be used to support TCP FastOpen with MPTCP in the following
commit.

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 include/net/tcp.h | 2 ++
 net/ipv4/tcp.c    | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 27e8d378c70a..4f71cc15ff8e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -327,6 +327,8 @@ void tcp_remove_empty_skb(struct sock *sk);
 int tcp_v4_tw_remember_stamp(struct inet_timewait_sock *tw);
 int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
+int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
+			 size_t size, struct ubuf_info *uarg);
 int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5702ca9b952d..5237a3f08c94 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1162,9 +1162,8 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
 	}
 }
 
-static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
-				int *copied, size_t size,
-				struct ubuf_info *uarg)
+int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
+			 size_t size, struct ubuf_info *uarg)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_sock *inet = inet_sk(sk);
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


