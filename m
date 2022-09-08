Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8C322A
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:48 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso1744679wmc.0
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=AlZcDGKD3h8w7SVOoMAnBwdJWd5RHVKmHHHEnH8yp/k=;
        b=Bvl6RAXsAu8Mq1ZJua5X9G++evk/VWchcl3Wu+5tMKhl7azXl2XM1hMEph1tHWDT5o
         XCGRmSSSUE1Zl2BkI9KYwNLDvweSccuH/fkm70iREAqQVViaueKfVUvs1LAdKhArHnAr
         2zXpfsKfhU3ioR6LySyppv91MBWeib9sT0waDDAuwJRT2RXdTnrnI4cIl8fKXF1qg02I
         DffsT/WCjZge8haBXL3dRLG//2i2qCmuawxCjtD/Sz8ymvncz3jgY8rqpjkT4WRrAG5o
         NXaMwLY7yci2AyCevp1HlC8ycrNGxEXh9ua1sPel72dwW+BjIABrTnX3DsYZBuSo614c
         xx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=AlZcDGKD3h8w7SVOoMAnBwdJWd5RHVKmHHHEnH8yp/k=;
        b=a46pAQZYvUHjjztnSaZSh6iFbmj/ThUhqTLGzJvS2LqIVLZ8Jbpmqq8fr1J03ZM2Kw
         fERIZ7TZSu50YSPhQqxb6I1C7TfcL3pYtRRsarHG/AxB2PiyfphniEHlBlVoluBFZt9/
         eYNjh7PpY7vkDQnkb2dGPTjkRoxWmY6VhA6oKH89x09pl2u3deLz0dppUhgFMpYOPEep
         FvvBGB40vl2yNPS9fmeR348DVZjFYYRPtzkE4H9jZBOpKoXXWxKTlqL9Epb4U3PYOn5o
         FOuWBW+2Q7UuApsfeWnjlhdo3pByK2cNXrJ6exjDB/9IXuEjouKLqygf1rJcQhFDvn3j
         R7GQ==
X-Gm-Message-State: ACgBeo2KBTNU67f9LXYtP7rp9vRk35cbcf7ZiszX+VfR+7AoG8AgxiaS
	h6PAmYeNFPG70uuzCTxJM0ilfDSD4fzhoNTfKIDyt6vEQxNKXvCGIpN7V0LS3a3F5il9km2J0qh
	76jj9Ge4BvsmLeEpeJ0ZI1Q==
X-Google-Smtp-Source: AA6agR4X59zYYroil7p01mBms+QYwyKdaDWgn2g19pLwIq8yTazTJmF0xkB5QA3I5ZiiJRoVVSujjA==
X-Received: by 2002:a05:600c:3d93:b0:3a5:eb9b:b495 with SMTP id bi19-20020a05600c3d9300b003a5eb9bb495mr2279123wmb.91.1662644326688;
        Thu, 08 Sep 2022 06:38:46 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:46 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 02/10] tcp: export tcp_sendmsg_fastopen
Date: Thu,  8 Sep 2022 15:38:21 +0200
Message-Id: <20220908133829.3410092-3-benjamin.hesmans@tessares.net>
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

It will be used to support TCP FastOpen with MPTCP in a following commit.

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 include/net/tcp.h | 2 ++
 net/ipv4/tcp.c    | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d10962b9f0d0..9a073b58dc4b 100644
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
index 44bc885bb2db..999db6b28008 100644
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


