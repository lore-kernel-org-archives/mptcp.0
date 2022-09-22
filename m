Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2023C30
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 13:56:36 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id r7so15727587wrm.2
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=G3FI+a0WxAwNMcUnh0b427qJ8UdMTqO31XG/ICJRL4s=;
        b=QUBDchijDtz7Rz8NCfozASvmV56sQAEC2mRB209GDlUkNSupA4EeJsibs+C01zuzca
         IX4a7ceUEaqLMmNy7p1HmdahHKkV7pHHRk1wtXY+f0gkTRKaR986c/uh5sNQRuBStT9t
         jNL4SuIjOTGFvQqcwhKOiL404c3H4rlRGSw/Vfdo2Sx2B08sGijJyWT0JC+eHvaowGBj
         2lTCvT3+wDGORXIQtmFLfRnQW2aBpev/vDxh0iBv0OUyzZguy/y8si8r+NyvHB3oTQGu
         6sUT7AJwOb1PfDl5xtK1a2VUsTZdMChRbrpXTtImTM2AabPhUJjGvIqp+yG6yxiHhmPx
         6elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=G3FI+a0WxAwNMcUnh0b427qJ8UdMTqO31XG/ICJRL4s=;
        b=O4XTB4BKYdPWwGX5vjYLoBcFZ6d+4awYV05ZGhMIkURvavmJ7Knrt2a10q9EMFqFr5
         +oZZu83hu/HK+SfXNS6G3bvu41JcareHKAwrY0M9rUtcuwrsD/Ebl0PMbmK0sGcp3PtZ
         LNn7vjwOImJb51ru0WyDD5BDPYMHEYEswEfoddMRnFRlN+ev6PhmbCQ6GT/uvr2PzigI
         Xyo8lwK0VQAorrvJj09dLNLMuFuIa7uIL2/EidhP9RJrUdZ2Zx5k9jPeWXDWPL6uIWNc
         wAjQlHjApv4DJjsJwknsgopMng/IZpR1iCrY/hVNhb5UG97mDaBwQL7lMqjt+rALyTtF
         kCkA==
X-Gm-Message-State: ACrzQf35VDP9+Xg+rH1hWpU4UjrBv7z9u39k/hBO8hir+K//fU12XDwl
	7fxEImb+26R0yp9NlXErZ/svGlwqRkMNr2NgMzMeauLrVQsw5k7tTXv7CTh2CT1Dlv8KQrbzjPs
	/m2+y8EwV3xxav88JoSzjVA==
X-Google-Smtp-Source: AMsMyM7CU2F3/OZcD61mkb8iR5uCRVm1lvGRo3Wu9WTgI0uouskdYQo5kizSvw38O+2KBnCnnXzaRA==
X-Received: by 2002:a5d:6986:0:b0:228:60f9:b013 with SMTP id g6-20020a5d6986000000b0022860f9b013mr2082210wru.102.1663854994895;
        Thu, 22 Sep 2022 06:56:34 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b003a844885f88sm6577053wmq.22.2022.09.22.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:56:34 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v2 2/4] tcp: export tcp_sendmsg_fastopen
Date: Thu, 22 Sep 2022 15:56:25 +0200
Message-Id: <20220922135627.2019807-3-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
References: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
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


