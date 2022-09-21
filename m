Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA94C63
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 15:26:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id r7so10504999wrm.2
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=eltcDqSR2JIjJjVY7p5nTjxc6ETlVySwp0BIGdSe/dg=;
        b=0m5rEFZZgvYdpOKCX8JfQpgX0KLWhSv8PzyMENIJ0jkq0ChciDuH73BxjHA5d45fE5
         A8oX04Pet/qwLZPsHwmhbShd6FQnJxwPwSxpGhyqVh1fg5+TZIlbfAbjObNUM98df067
         I4OkB2OABz0WGczNOb2B9t3BSaLuKnKkglzud8aKXL0MaWf807Gao/LKgGRUyzAzdXME
         1xlAwbQ1wkrLyV/WPbmsVdexCsaHJJ0WMIA4ung4zaDQ8JqwiZ3S3lwFanNH9TvhrrQz
         7jrfZr/VC0Cxcg5b7QDMHyg4KJcsNSVWYqigftBuwSAGl1nywCdkqHThL1M/2Q6PieLQ
         Wx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=eltcDqSR2JIjJjVY7p5nTjxc6ETlVySwp0BIGdSe/dg=;
        b=Dr4Ik823+t5v+UDuiheS9J8ZkW+99vKwQwOoz40c2GHbssdvNXEcqVYBGOSui4e9lv
         aiqaPp8Kwk+Q6/HivsWMAVMh6UfRpHBO84w3RF7FKpR4BIDtgp1HT+YFpAz64GxC9kI4
         3AaOMzIr4JYrShTCbDzCTMr1BtS2N4JJAiMB0fkNeZiIAeRBHYQQytBidzayrfiL6ISs
         uzwXRSLabPXAIYGHMXliFWPEp5sG1B1TkJS+MCSiDAfPbVF0fphTIA+f4lGfDlfdSM60
         Ovl+X745l2Qa3aDZ+vtzWemfIZzopqBe3KF6gbPjTgqnsVL5Tiy6y4xhSpMd8aujG2tD
         aahw==
X-Gm-Message-State: ACrzQf3n7J0ws8Wan+RISVrYc8GnDiDtS6gGSQyraE8MJ5IFaT76Y07v
	b3Xsqzk1zlR2RElTePomF/253w1PAK1FZIRfw0EfArd+UM4cPoOqCYNlea6zjQJjSDUbMTlRWP6
	4H2zhospkCEWriJ9WP4Y=
X-Google-Smtp-Source: AMsMyM6anTIy5FNlXpFKGP4xJcwmD1JbFK5IKFDa3wZpE64AUpUtrCXpYs5kzTM7xDY/k3i7ehJuvA==
X-Received: by 2002:a05:6000:1c18:b0:22b:13e3:19d3 with SMTP id ba24-20020a0560001c1800b0022b13e319d3mr5859513wrb.699.1663773981292;
        Wed, 21 Sep 2022 08:26:21 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003b4935f04a4sm3994435wmq.5.2022.09.21.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:26:21 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v1 4/5] mptcp: add MSG_FASTOPEN support
Date: Wed, 21 Sep 2022 17:25:38 +0200
Message-Id: <20220921152539.1851441-5-benjamin.hesmans@tessares.net>
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

From: Dmytro Shytyi <dmytro@shytyi.net>

Support for TFO when it's used via sendmsg() or sendto().

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---

Notes:
    Imported code from Dmytro's series

 net/mptcp/protocol.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f5f20910cd83..aa6e13949b23 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1673,17 +1673,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int ret = 0;
 	long timeo;
 
-	/* we don't support FASTOPEN yet */
-	if (msg->msg_flags & MSG_FASTOPEN)
-		return -EOPNOTSUPP;
-
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	lock_sock(sk);
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
+	if (unlikely(ssock && (msg->msg_flags & MSG_FASTOPEN ||
+			       inet_sk(ssock->sk)->defer_connect))) {
 		struct sock *ssk = ssock->sk;
 		int copied_syn = 0;
 
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


