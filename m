Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B813C36
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 12:19:41 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id t7so20114674wrm.10
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=VWV4BzegnDOYqkcuzawhqLZQCNJYnsc6brVAmAUMKcs=;
        b=Gej20UWRieMQzeXkAc6S8PMedHJzjet/4jYhX5LAqThn9AcRmaX24yGpQKDeIzVXzY
         DAyHeasXuSr3YRikULhL1iOD8PUHyh1hicpHBSU67zhhLU4HiD3EDc/+O7aj9fzX9nYk
         Jhtp/rxS+n3qlxBCpvDFthdpyeB8s85lQWAUEBLycEn4e4TcDIgeLOcG37mcux/62BPa
         elx9JrzwHtwH8kBZc6ho3bYHZbZBohOxBIMLUV2DBGoTt+NJ9V2yBtEQII71xD7oyJic
         9psL9XIJi+3MPXf18aod1RgJkczWQR4071LS/lz44aLxga/kG4Pbdyr/CdDkr8S1CiQy
         kTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=VWV4BzegnDOYqkcuzawhqLZQCNJYnsc6brVAmAUMKcs=;
        b=VZQGJsGe7ynJAch6TJ+qlmt3jDptztAGqHAYEJrgOpLOzbM3oGHXSuFl3yvnl/XQEu
         48GGTriV2GoapLtTu3MS0EEtBv3rFXuliSg1rOnva2gzn5FNaA8hKzjmr7oMDgw7QibB
         /7qgPDFBHC8drxrz9+EtGIvRie8RGkpi/AbN0ucr+2nl+uhXkx7jzktqWrcst5NjuwJw
         BjcMAfJs290pB6+9ANpct/YImfuMQKorgCEeM9h9B31rPhAg/tPYrgvtAhDnqRX5pLKA
         kf7qTUcbQshG7E2ysuH+TJRllIqexe+QvMmQC5cU5aLdxZWDgYNPXKHQdK05wsAdRtxI
         HM0A==
X-Gm-Message-State: ACrzQf096uxqN4zBBwnBbnY2AUciecq3EEamHYYXMHYNTEaAeJK5BBRo
	LxXuwtdMUdgGkJ/oYLrhpXfIOW2Bq0DTVkTJHzuyKgL+ToU+JTAqU/Ty+RszwR6m5QENJQWTw1y
	EYwGsbuo8wAYmKRmnRJ4=
X-Google-Smtp-Source: AMsMyM6kqnKQ4I+Pzzj3Gcoi7fjvMWV/N4PH43KKra+6RGF/KsQC4FQFItct+6PHNFzN+NbeRMBHPQ==
X-Received: by 2002:a5d:4dcd:0:b0:228:d1e4:9cf1 with SMTP id f13-20020a5d4dcd000000b00228d1e49cf1mr4775164wru.182.1663935579512;
        Fri, 23 Sep 2022 05:19:39 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bj1-20020a0560001e0100b0022b0214cfa6sm8939309wrb.45.2022.09.23.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 05:19:39 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>,
	Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next v3 2/4] tcp: export tcp_sendmsg_fastopen
Date: Fri, 23 Sep 2022 14:19:11 +0200
Message-Id: <20220923121913.2135229-3-benjamin.hesmans@tessares.net>
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

It will be used to support TCP FastOpen with MPTCP in the following
commit.

Co-developed-by: Dmytro Shytyi <dmytro@shytyi.net>
Signed-of-by: Dmytro Shytyi <dmytro@shytyi.net>
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


