Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65E3890E7
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519298; cv=none; b=P+n+WIhzTjU2a9Tcz0WvbHFtQi5Ak4s+BD30V1HgNZ+uwRtq+rTPwskV4lVyio8LP1mX+6R2ezEXnQHyaGOHYwUt1JCZjF4bIERsPENtY9xRyaEvlelGN242nDOpZnuorj5VKWHCZ0GsV+JKKms54M0/J0afD0hSauLKuTpQUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519298; c=relaxed/simple;
	bh=dcj1s6Dgcrw3Y7tNOEUlJFcSNNEIPs4iabts40+JwIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htLw03m2OIKjPDTYlAqflLb3lsBdZbKzUr+eCk2cdQxBz80x70d9E1kPlRo0FvkSsoajJS6Qi/Ez5oNpEEMxDUoKQ/v7XlLJpz13WzMaQnMiWersJrypRA7lFDeKWT8UtH5wtYS+Inr54LaIYcHyIKoK73Zf1Kt7ThtlWhZmJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCC2gmuV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCC2gmuV"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2247356fac.1
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519295; x=1774124095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpvhfo9p2XSrc/tbQHeJ0/cabcWcjahm5y6siccjbzs=;
        b=gCC2gmuV9GA5iIfMNa4eEMBfKvBUx8QHPm0tHQoFsP1XkEEtYW0mNm2KrIQp5j3AwG
         V21/84BEdt3LBNSW5bzv9ZziMWW3ixyiYXAN3enq7a5sZPodSBbLW6yYcslVFPK/7Yem
         O4fKZ1yF4uJ34cYYY4Qw0+ylLrVOLxQraRGc5DCbC4LveWB4oX/yO2cBUOjdytY4HueT
         hpMZ9teLArrgdOQLw5Xf8kGXeCVg97yziFZqrH7rnu0IqNKtHZHcm8FqIq9sb08AYai/
         WazhQk6Oflyj+blexHciVGYX/mYmx1u5XfgoKZy2Kp5m88D+obh/IGiaTQdR90OZdLHF
         z4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519295; x=1774124095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpvhfo9p2XSrc/tbQHeJ0/cabcWcjahm5y6siccjbzs=;
        b=oeVy+AQJKodgQY+r4Sty5WOxGOq1dkE43Mm5NhaEgS1tFT8ZCGji4MbXJg0f9uPviH
         kIrGtUSvgQpUtLOHwKCqvtpFc8kPqWwJng3RJDZyDHebUWbyVquSF+1Kx9Fgaqal9z+d
         gF64Yy9wmrYL66DH2l2aHgQdTDKD5f4OwZTGf7y3IdHzbNpd1zqxr9TFTcmIxEqsZMnb
         DDj0W8rIzlLH9HbbhczDSDxLdYazLvMqxfTK7qx+0gWr+pi0FiVpIjAg69n+Rvl9bn6g
         j0QVA4/khqJcqYt+y1oYf4ZFYpMTzFHZIfiHR6PMs/VBDAPJ1+BIPmKin0n2A0ekGfy1
         +8fA==
X-Forwarded-Encrypted: i=1; AJvYcCURWZE13+HErfWQlc5G4fitr+TLn+aIeJil9xpWXPXoPNKxNvuKknNohTZJo1vI2HNJPT9LOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5YPSHD3qHL1fbl3cnDPv/6NZbeKFErghPMPJLIfuwHgVbwmGA
	Y4rXphUJkC6zIT0fGFmcvl1YaSekPJr2baZ9aoj8760HFt03AZhDVa02
X-Gm-Gg: ATEYQzwT87Xy9im36phhaZBM066m45WCKJt/LwvY3paqmZI+K6lqveaTiOUjqStlPS1
	Psnt2LQZ/XyOcWASDSMJtSIOaTiZcM01aoB3cLI7bp+qIiirDtFdg9Zrg664zuZrKM443bSU2iB
	uGJ0xI1Ti07upqGq2pdjJ8NFmnrvvjSQ8mYs1lJFU0MCpq2B+7leFTSaD8V/2tauRLC7Cl7Kzxr
	oie9GbIQpfxgjfiVQBSWPlMMnEWdhuEVmP/K196MC1KY0Bk/D0J47pAhuUkIHpRwgz7mSevc+/L
	ArE8TDCxW3rs0LRQCiwN/BUac0ONgR5ObfJDyc8gOJNSsuMpwpj3fY7Kw7O2rhoz/iXbKpssAYw
	3rjvLN+/4cF2+W5DCkZMH64LmzzzocnhCozv3PabZNBb6Hqnl8Gj5G5f9KhbEAdqSsOlgIWfmd9
	lV2i1tE9sXwulohGTHU9dgoRRsCysY7WJGyB4PJ5Ox+AOJevUanOnBWuLtPY5MIao2zg6oFSm9O
	aZ7PjQWuMAoXaM9/8o3Tycf8fPmkOhWCHHp8bw+
X-Received: by 2002:a05:6870:a796:b0:3e8:8b6f:9d85 with SMTP id 586e51a60fabf-417b937d46cmr4417226fac.29.1773519295129;
        Sat, 14 Mar 2026 13:14:55 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:54 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 09/14] mptcp: refresh TCP receive-window snapshots on subflows
Date: Sat, 14 Mar 2026 14:13:43 -0600
Message-ID: <20260314201348.1786972-10-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

When MPTCP resynchronizes the per-subflow TCP shadow window from the
mptcp-level receive state, refresh the live rwnd snapshot and the
remembered maximum-window snapshot along with it.

That keeps subflow TCP bookkeeping aligned with the sender-visible
window state tracked in the core TCP patches.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/mptcp/options.c  | 14 +++++++++-----
 net/mptcp/protocol.h | 14 +++++++++++---
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..64cd637484a4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1073,9 +1073,12 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 		return;
 
 	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
-	 * resync.
+	 * resync. Keep the TCP shadow window in its advertised u32 domain
+	 * and refresh the advertise-time scaling snapshot while doing so.
 	 */
-	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	tcp_set_rcv_wnd(tp, min_t(u64, (u64)tp->rcv_wnd +
+				  (mptcp_rcv_wnd - subflow->rcv_wnd_sent),
+				  U32_MAX));
 	tcp_update_max_rcv_wnd_seq(tp);
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
@@ -1335,12 +1338,13 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
 		/* The msk-level rcv wnd is after the tcp level one,
-		 * sync the latter.
+		 * sync the latter and refresh its advertise-time scaling
+		 * snapshot.
 		 */
 		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
-		new_win = min_t(u64, win, U32_MAX);
-		tp->rcv_wnd = new_win;
+		tcp_set_rcv_wnd(tp, min_t(u64, win, U32_MAX));
+		new_win = tp->rcv_wnd;
 		tcp_update_max_rcv_wnd_seq(tp);
 
 		/* Make sure we do not exceed the maximum possible
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..4ea95c9c0c7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,11 +408,19 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
 }
 
+/* MPTCP exposes window space from the mptcp-level receive queue, so it tracks
+ * a separate backlog counter from the subflow backlog embedded in struct sock.
+ */
+static inline int mptcp_rwnd_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) -
+	       READ_ONCE(mptcp_sk(sk)->backlog_len) -
+	       tcp_rmem_used(sk);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
-				    sk_rmem_alloc_get(sk));
+	return mptcp_win_from_space(sk, mptcp_rwnd_avail(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.43.0

