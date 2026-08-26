Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6F3FCB3D
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764466; cv=none; b=RDIMf8yq5To4mIyoKZPj3BRywzdbLwC9l0i/5zNpuLp66ayTs8bet76UkNFaBVqPfR4t7/VMnznMkMToodZfQbqpc8xHxN8O/cVpGpIWBLAKLgPXXqilq/JV3LXQno8cpyON4Z3HV5EYAEOq8s1n5YO5oCchuXftBT4lcum0mFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764466; c=relaxed/simple;
	bh=8bKsD9oWj33NgkNdGu55Mu1gP/LaW13d70gMWYrT2RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHbInEj2PvDw8m3fVTEFCqQmTEBQ6+avJnl2PnOnAPOCl9HQiiiKD3un9iPsXlnPsfX+iq8Ei4NmADEban+0CycedLn6RjXkeP8YcqY/deEZ6BJ2NAyWEUetveOWpeVYZEYwpe4b799NGDvOJvnoozJ+kCUhWWJzXoW/X3kjQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9FljS3n; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9FljS3n"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81f64e8dfbcso19616937b3.2
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764453; x=1788369253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clawZ9fzGlkquq5rpQ6tbQ3zyBYp/FjuWXWqf1icnXM=;
        b=X9FljS3n9BPLcprm6l8idxnb9gEjP6fbQRRg60BqarUHHePbaQy+e0ZmXdqn2XOfBG
         VkRzX/wMbKoCDU5tkSpyjbJYHFeYE1CkBviwf8UUCnCjnJSZ9GbkH2vsJQ2z+3K+URr1
         f0TaycnH5tPqxBArCjTEggXb/WBIZTmJiUl9AvJpkMeDzuSQg4pRuaBL+uRK11MhhxZ2
         wljTe3Tf8DQCQCvcYl3cbtrAc0f/IRFLwhlaD2/08qKyl3dAgOd9FfUuN/s9qyNspSJd
         9tnhw9ZQBUNREtpNP4vNNEsGkE1CYwCUOZ7RAge4pT1PxukYECQnHE8vLbejTFnQ/xtE
         JuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764453; x=1788369253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=clawZ9fzGlkquq5rpQ6tbQ3zyBYp/FjuWXWqf1icnXM=;
        b=UWK/zlFr01xFNRTG/nXZrezigpqWTep772F3htVO35brI0trGOvYyMG+nwfaHEJg6e
         lJ/ibdk++j8iEsD3m8VEGg//HI2Dyndrp2lEy8I6O2ut6SqfP1jLVhEvsoI2WW+mZNoh
         ZvycAcWp5FlaUyBnR6vzwtpant+Vz99OzJVr84kf37CZtLfdaLqsXc64Ou9sNXS7fQR0
         DacB8NFJ3lkxyTN/xtCt+ud6IPA01dj6EIhXLYmCCdAlCt+nXUn150TQhLL2PJ5cYVlT
         gXLG0xCOvBYA0P6ZEVNO9L1R0aKUnQjol/4QBvTYpWkjx5wPMkoGDiYPRups7/5CnWaD
         srhg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2Xb+ECkr2ITKF5VYFVZJNayH721u+YKIEL9EfpaG4xP6Ay8T3O/Udfikk5n1ZGAD9LEumbQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nWILMOhwTPSVwMLBVpfH6H0qJ2pmJhcQ2V9FBWuP4KYUe1akeR
	Ui3FInaNDExekLcURf65gQVmhRStjgm5DEmF5JMg9u2Z7hiRMQnJkKEr
X-Gm-Gg: AR+sD12zIj37xFH/03LwzWVJ1s0+Qq95j+cV3Vg4YOhzaUlAKmq4fv8+1Fa5tkxSf3N
	bqEMMEyMMkTWOyo9cbwdeA4S7P3wyiV5DUYxrhlDLYMAqc4zHJoDFbdu1O0se9//1EgIKovfS9O
	9z2J8hhS0nnGkcoFkSfL19Xa9AVmemwLWuzeiis5CB9vWHXf4tAhJgeY0GvtFKQgxCN0hRkSOQs
	pNOMaLFOA/S8EilOdxua4ez3gTi7gYxwoPabyJ1tznYpaYd/qvlVbgxHIPrBCQL5pHhVOsVma9f
	zd64abZKvPSl/jsywPFHN3UTMjctZagWV5dM+A2t9n19ePQ1jXjrW+KbLWGjvygkpSwcFO0POyA
	RbszMPh/eAi4KOMvse7BW8cMXGeh7HqpcjmpEy6To+N/9OmvLEqEP6d4J70p8zh7/x20wJJ4lI0
	IijqWuRKQnvtAkd5sRY8yqBKWeFXngNq/PMpS7ftPOQyPhrFFa9JaECTx5x4M0EN8vzpU=
X-Received: by 2002:a05:690c:6d83:b0:81f:2479:16da with SMTP id 00721157ae682-8573e062ff7mr37338717b3.16.1787764452549;
        Wed, 26 Aug 2026 10:14:12 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d620433sm19313287b3.42.2026.08.26.10.14.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:14:12 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Wed, 26 Aug 2026 13:13:44 -0400
Message-ID: <20260826171344.4133-3-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826171344.4133-1-blbllhy@gmail.com>
References: <20260826171344.4133-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
get_info function pointer without rcu_read_lock(). With BPF struct_ops
congestion control, ca_ops can point to dynamically allocated memory
that is freed concurrently, resulting in a use-after-free when the
kernel dereferences or calls through the stale pointer.

  BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
  Read of size 8 at addr ffff888013701258 by task exploit/149
   do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by wrapping the ca_ops load and get_info call within
rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
the icsk_ca_ops pointer.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Link: https://lore.kernel.org/all/20260821182449.79785-3-blbllhy@gmail.com/ (v1)
Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
---
 net/ipv4/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4918f48ba76d..c45776d3ed90 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4562,9 +4562,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		ca_ops = icsk->icsk_ca_ops;
+		rcu_read_lock();
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-- 
2.55.0
