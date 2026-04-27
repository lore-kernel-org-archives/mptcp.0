Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EB3A1D14
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324214; cv=none; b=C/Jyf0BcaWLiRWHSeFT1+P9eKnBXaoa/dLcg641o/q0czhTjj8Z7wy1fpKeAAwqGawcHGpoaxu2xUACa8KJvHbB/uFxNLnHYu6knXUK3HXr/t8LgAUvXyl8ZpCISvXjNCx6I2kgI9qFUVlEL+LyH9iD8yBxzIkl33Bk+dz2v51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324214; c=relaxed/simple;
	bh=oNjQ4qUVtOCWQvRoeC8pUaK+Xz2GNvYaWSVymqA94nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlFyyOH141kSn4YoxLDzwRXG5/QSsyZzyltIU+BNdjol1Z7NVwRVW68IH/qtY07Tr4pgviWDu3i0DKVvoWnn1xF226U4FyXg1CY/BlGyPlqpG/n5rOaY3A09sI7CZFevDLBO/49LuH1Bql4QXdBaKhqQ9pUqued0jHWpvfFtkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUADv3HZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUADv3HZ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso108515955e9.1
        for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324211; x=1777929011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYaPKI8P43LDgJBZTH9YEBk6mFA/pQnbjm/DstSq7Cg=;
        b=JUADv3HZzR7Yo6sCts6mCg2XhWt4SRoLfFFodSGnET8iVkpr4+k96zxh+bqDY5EWm7
         yOgFBVzg/TBnYKj9IY2cy0tMrBse3PjdX69VTJQF5qACvo6icaVVw9BAF60ueqxlXDnJ
         4vD7TRbYI4R8Yg9eDczSenxWliybzV3mEz+HtbE1OALVEOg0HeE8sttB0N+xc78vWLxc
         kyenPl6QlFQL4woppzMw+1QvUypnh4Hts3+ZHGWjuTl1Q+7RterUa2s9WEz7rj7T3QDZ
         pgN2DWoDnNziDt7987XR+gwW17FfX81rpYK3Rd2Az6ro0PViK5WgtA7TcplW2mLWVKdU
         04Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324211; x=1777929011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYaPKI8P43LDgJBZTH9YEBk6mFA/pQnbjm/DstSq7Cg=;
        b=tFqBwwq/vQFn+jscpiAuc3DlMAGp60XluHM9c3kNTnfFDqm6qmBlbRyXd9SfxngzQS
         2lRtTzjodzNYTteL+OAlHOuO3WxvjDYcAiKl3Z33vADCaX8phzr9kuNva6UTTjPl8ACt
         vT5/rTSYFIRVOEUkWhVBL33oQkNruUd5GCrQu1qKaj+BMgG41Er+eJtwCx14JFZV8A01
         tDQHXHeBlNwIHxYZMSiNY+V1TpnEX0ADwYesywmQYP4uN5eWERJrECLRTtc8sDPfcBaz
         2t5Q/6+tx6nBJz43Grv5+Atuhz6+jL8iUy9ttDBZRw6OGXad6eM/Lmu8HGCCCJhu9A9S
         c3cg==
X-Gm-Message-State: AOJu0Yz8Rmc0D0dPMlvvmxAdG7vp8NByikQ+O53Ykgptu5xGbVM7FS/S
	ESfbREye1uCTz6tXpTeRTT+TK3xEZl+cE8SJzNwp21PSK19bdIBerYxhs9CQRRFZ
X-Gm-Gg: AeBDiesJ/E+HQBapEPDz+cwEX6YlUkvs85tLCKGdgA8CJ7WoleDTme2at5WDF0JeWeM
	VOFJlk72lDPFNhlwiQnhdZubyu76pBp7Az6n7aDKrf83hITPXNVaZFf/CHPK4LiP5ulqwL6P8OY
	IT6WcqkE3w/KegLPd2ZBp2mKUqJYfcYSokLzx4nObyOc7bYa6IZ4BxqVXDebH31mAQetCANHkT/
	kBPiqSt21zvUA7mD2H2h3tspJ1mC45mPX4NCb+VJfd0qKkY/n6DUktUaZ5LlsjKwBCmQePwJuUN
	Ny1pNf3J6vzM2VorUsDe2oC9c69MStqbTvE5MxrLzFtOtztSvSKI9cgYZkWh//Lm7xpuLQFiCEE
	SbT8+B8cKKglQooumdwLPqhRv4d8nt8mxw59QGrh/p5BaOIsiS1U/rn4DVbHf+I4D/sBiHgWOt8
	3laOrdq8vCdM33AAHPs/m3Tsp316o4SP1D6M5IcVi1RwoRhJHGDEvSnZ/N2G6F6y/0/g9j6/Pck
	BOoOc92NpwiulrZyJgIjA==
X-Received: by 2002:a05:6000:1449:b0:43c:f257:c706 with SMTP id ffacd0b85a97d-44657c07315mr515272f8f.23.1777324210648;
        Mon, 27 Apr 2026 14:10:10 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d5ee9ecsm1107145f8f.16.2026.04.27.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:10:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v4 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Mon, 27 Apr 2026 22:10:03 +0100
Message-ID: <ebbe083d1820ed64f8d5d055c6f585887b522d6e.1777324037.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777324037.git.devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com> <cover.1777324037.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the per-flag inet_assign_bit() calls in sync_socket_options()
with a masked word-level copy of inet_sk()->inet_flags. Introduce
MPTCP_INET_FLAGS_MASK so further flags propagated by MPTCP can be
added by extending the mask rather than touching the call site.

No functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0efe40be2fde..41c9dc9cf95e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -16,6 +16,10 @@
 
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
+#define MPTCP_INET_FLAGS_MASK \
+	(BIT(INET_FLAGS_TRANSPARENT) | \
+	 BIT(INET_FLAGS_FREEBIND) | \
+	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -1536,6 +1540,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long flags;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1582,9 +1587,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
-	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
-	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	flags = inet_sk(ssk)->inet_flags;
+	flags &= ~MPTCP_INET_FLAGS_MASK;
+	flags |= inet_sk(sk)->inet_flags & MPTCP_INET_FLAGS_MASK;
+	WRITE_ONCE(inet_sk(ssk)->inet_flags, flags);
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 }
 
-- 
2.53.0

