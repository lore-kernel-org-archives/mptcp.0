Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909B3859DD
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519293; cv=none; b=Sr4fMwS2xTCn9/MPNYJcvrYU2+vnWEp512MJWbm5cUNSQSeONB33KJuzcWmMBVAcn31sT+A7PfJWIZ3nVyxvtTFdpuWK/i5/F/9tOcbBfdkP0Rd6XeAHBvOxxkxDPdAZNJ9kBiMUAhsN28h5tLpTbIhnuCn6mroRGyqScJU6P3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519293; c=relaxed/simple;
	bh=X1zLIw1J0h9kTV3NoqokrWtcJn8B9ET3Wq/q4qH3Vzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhqMymXCvhw9FWO4378M3gjN2CCWXkqju7co19Wk8hM4S1vCwMwsER22Vm0n/iKva+bpfFenHE8VQ1E0Jkhso1XLHvDEU+Rn7yPg2QPMw/ZLMvFtpKE1x2plDyFQMIjHeC3yuAEBwa3xzgFZ/uy23y51z8o2lAFVLENfpmaaAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndkg3iKA; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndkg3iKA"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7653db148so2321281a34.2
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519291; x=1774124091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q07GcXVkZ6+WpFEBkbyw8fuqV93z6jZU74lSMjAcsUw=;
        b=Ndkg3iKAxtCPGQVCR0u4NfrIBz3/U19Xy+rqGmc1Unbz9Clj86KSw7tKsd6BM1ZZtf
         G6x80RMNUQUi9iTps7jMXcb7qCGbHsGQtZqiCfftiCoeggzYavhkFgE5DRel6/s3OpMp
         mGqLzLydNoYU4cUgkjny6do/l9j2eF7HaHROqvIQVx2DexTqJdAYY4lBKBcX3AkzOPdb
         dI2EaMJtK1LrUlk3RexJJkxCQSg0KVAcsZwLBwdVtZHLvfXlSt0Ivr8J9kYZglCPdkNk
         VdiwtKSAmNNFpapW1ulmeG5SbKMHvDmZK1MQ4yJSwcezEw7MIEuk4f31FIMkphrE7owd
         Q05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519291; x=1774124091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q07GcXVkZ6+WpFEBkbyw8fuqV93z6jZU74lSMjAcsUw=;
        b=HqrN3Jond2pUm/8/fLVsteCXLjhOK2NGmAMnAyBDExMclnYbU3GwU3KGmNoaNryRg9
         gk8b32NXWaPUKAjvIYAuk++1g/8XH/QhUqriaC2bgJyzp4smk00WheNomsDVaYfFk9i/
         0+lDJZpPZp84neqlx2tgdxXyeMiJUFlhUhEQ8A5WzJYRNSIcOIV0bbjUSA+8JIaT/gOu
         JEfqEv1XMNzCRV6Ro9UtgMGYlcgHWSC2hY8LRczQDsvYCIYEddzlGSAh6Uta5DnIGsmL
         MrUYYPdq4wr457FyvMAb5fai57/Uh1y4BjRd73IS2uaozQd9Lil0queAYs/TskE4enFK
         OTLA==
X-Forwarded-Encrypted: i=1; AJvYcCW6+cG7KxNsbLqTD6Ai6CKSLsBWv+Ng96e4zONQqoSdiYhxaxYtjwEyCHjVRKv3l4NMTZV2AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB5D8/3l/7O3Q+GjAb4oZgB1ZKUkcoYH3nceN/ytee4e3IFKON
	B/o/gVuDdGYBIM2ZpiOYV449DEcpuJcLBiqncRpangX/TlOGP+fogXlt
X-Gm-Gg: ATEYQzzG/qo74GaRvQNuaLoQjqEh8Kz6zCRgR3WIIABD6aMAXgI3bIpVrKKEQ9T3u+C
	KwNijvwdQgd0HYekVH/S/cKP/2dl2y1HPjTHhtlmoF69fZ5VdVj614XUxoWeizVcsVuWVCKYTG2
	RFeXmyOPb2gecAIb69L9o9k+tFUnZvpKINsWQSZVvaxs9RtW1iIGAc1erRUf/azuP6EoPJSZ1xJ
	kNddTyAYA6yfjL2uDY5C+1WJaD/A5SXvvwNvUDmXtRw6rhjAVDXNP11jX/RgOUEZlplv7UmWX61
	huYIypUmdFf1gKCiCm76zO9ZzwICfV9czEIprREUI3gR+5zAOQfq5Iyx1jxZfc4x+8TvA8AVPB3
	dpjkIKObK1XT4PKi11NYOaaT1K6W/R4DxnMvzizQq2cXrYnmevLjGv/oPcuf6xQO3gWy8DohzhF
	J//WsbqtKJXodUhrKIanEpFqcQOqvTzeqfbWKPkqJyrnQH71VOFxhTm8V6LpUL+Cweh6XnGZ8iV
	KcB98cLUprUJlfIb5dHnDjm/LxuwCUa+8ZrxeQcx9QHN9HJs0Y=
X-Received: by 2002:a05:6830:370d:b0:7d5:13eb:6010 with SMTP id 46e09a7af769-7d78259393bmr5062611a34.33.1773519290685;
        Sat, 14 Mar 2026 13:14:50 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:50 -0700 (PDT)
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
Subject: [PATCH net-next v2 06/14] tcp: regrow rcvbuf when scaling_ratio drops after advertisement
Date: Sat, 14 Mar 2026 14:13:40 -0600
Message-ID: <20260314201348.1786972-7-atwellwea@gmail.com>
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

When tcp_measure_rcv_mss() lowers scaling_ratio after a window was
already advertised, grow sk_rcvbuf so the remaining live sender-visible
window still has matching hard receive-memory backing.

This repairs the live advertised window only. Retracted-window rescue is
handled separately in a later patch.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_input.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 32256519a085..d76e4e4c0e57 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -221,6 +221,31 @@ static __cold void tcp_gro_dev_warn(const struct sock *sk, const struct sk_buff
 	rcu_read_unlock();
 }
 
+/* If scaling_ratio drops after we already advertised tp->rcv_wnd, grow
+ * sk_rcvbuf so the remaining live window still maps back to hard memory
+ * units under the old advertise-time basis.
+ */
+static void tcp_try_grow_advertised_window(struct sock *sk,
+					   const struct sk_buff *skb)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int needed;
+
+	/* Keep this repair aligned with tcp_rcvbuf_grow(): do not adjust
+	 * receive-buffer backing for not-yet-accepted or orphaned sockets.
+	 */
+	if (!tcp_rcvbuf_grow_allowed(sk))
+		return;
+
+	if (!tcp_receive_window(tp))
+		return;
+
+	if (!tcp_space_from_rcv_wnd(tp, tcp_receive_window(tp), &needed))
+		return;
+
+	tcp_try_grow_rcvbuf(sk, needed);
+}
+
 /* Adapt the MSS value used to make delayed ack decision to the
  * real world.
  */
@@ -251,6 +276,7 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 			if (old_ratio != tcp_sk(sk)->scaling_ratio) {
 				struct tcp_sock *tp = tcp_sk(sk);
 
+				tcp_try_grow_advertised_window(sk, skb);
 				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
 				tcp_set_window_clamp(sk, val);
 
-- 
2.43.0

