Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBD3E0C7A
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874919; cv=none; b=VKta0vNDURFcZUjQYi3+7xVWzO1eDK8hkEExoTHd7yRwtVKQDsIdzaBqFKRxQg5gZBlGC3/aLteuVAjxkJCPeZA1wO8S12htE2Gj8iRi5TsUgbRBoIBZCR1A+YnveuGLv8uhgiYbbHYo+NIBoca1fjzE4pY6qZa67RB1HKg5Af8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874919; c=relaxed/simple;
	bh=povcfs+zEFwhtdLtyHZfkA0h8OxsjY5Ocq80rUw6ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnq1pAWXlS8fizuuDZzjVklHU94AAgFdxzcTw5YCUtlJifAj1QuKeOEyrl3hhnOFilQtPY8Lekmeypjp2JdGE7i64cFN7kSm6VZmkIjvkmEn9YjZcFrfMUH32PNanZjmdtlw4KnObkb01/T8MJKiA3etbdCp/HFoe4dDzY4+aY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmSM3h08; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmSM3h08"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836c4474028so6086357b3.0
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874916; x=1788479716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibdqZhM5Iy57YHQTMa8QJ1pQX4PIL/iVkp9X2oZ/1hc=;
        b=GmSM3h087ssm2H0Fuh9n1ehfWsryT8JY3iQVNh5TJeCmiOaq00qkYmrN9BQTGecXRQ
         QOLt0PJ6/4IHo6F/oX2E9wIBWwSDsgHt3n3UXQK7AnHKkHj+nljY9xCAUJ+0cEKCTmQ+
         V3UV/F/Wp5vABTfR5VnHJSG1N3eeyl+KUMpVfIUk+Mkxj8elurppC7th7e8C4xHJjn5Z
         quhdgquN1UpdXmIfXg/xfk2qJDcJ3fTMtcw8DXMoU1gcqlRltHgvpk1VIVQbB8YkB3Kq
         rViztyR59/CNKuLBW+baTkv4IMu3aYZcdBPSQnzYnL1s79D9oya3ffkTih1nM+vbbN6e
         q0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874916; x=1788479716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ibdqZhM5Iy57YHQTMa8QJ1pQX4PIL/iVkp9X2oZ/1hc=;
        b=Rgt9cxgdk0RLA3sBReYCFSiK7AvNikabCYeTAkUE9OW2oYOddl4uRhoFg1hK1wBdv9
         rjRLjLuGcPcfTIZ4+wE43bC5t2OYIBKWWPgfEWeVJR7xrJqFwkmEXlFhXn/rCvU8IWvc
         v6YM8v2Jqj2Lyp7fhaHhRZEtPvlKLikkMDYre2SgY6IILSWRSag3MYvMkJExwBm85ID8
         xYpZcPtSNB/+c1zOm2XpmkEK3ZXieUrFWpwcmo7L+IEjq/gpSEeEjdSKg6xnXvAeWKZR
         KFQjXmtpkkoyjo53jVX5mkBI/yHtPTTlmEAxgpyowyXsCJ3jaUPwz78YGXleE/MkKITw
         s8Lw==
X-Forwarded-Encrypted: i=1; AHgh+RqoQJK5stTuH0UTSG6RToYzRmt4sIIcHD9tZfUO2LDkRuIKkTWJh6wkvIznu/DXWR5QjNxWkw==@lists.linux.dev
X-Gm-Message-State: AFuF++n/s9rsXTQlakwPf9+KU4gDxjZrHsmnbPwB8w1jImHQL7S0BPk0
	Ttiu1qHAwjxuJt/YEIUqxhtiKcjRHCT09BQkqi99+RnM/hiEni7Q8pPH
X-Gm-Gg: AR+sD11c8vSNhNUyuznuDhZpwz2cABVelZTdNy6bVyBYbvUtVIB5sgiB4HRImU4sy58
	eY5SqRGD0WVla/fTXwBSVqV7mRWomMd28YlzKf8AKhKncqeKXYALuIGXLL/akidb/Q1V+ME/o6g
	VEjV0Sg/9/cd1Uk8ur7/EeFA+xvO6tOtPt6o476XKPoYY7pHPhBEcehaQTg3ezeICa9tpVTy8ZV
	Uq3gsgXYmAA82OS/6Soe6sJRNdh2xd300PAdWfJhm1vdA9PL+kFgkp64atwx9LqcVvdoc43C6cj
	h+Xf3BBsdLtbZNFbR9EWj4UfEb8SSBbcN85G+DaCZ/X3YJFqe16rjitPBr4VpjkT1MjqRgTBrz2
	gg4abvrlzRvJ2y7Mfcl6+LmAgzJveVywjrok271M4KNgVkho7X9thip39lPVW+4b2OUhVrTENC6
	4yx7X3KKTdfkEOQ0o8STPD6scqTjj+1UpqSCKSOCTBmjBcMA40JeGO2/zUBvk+uQIzruk=
X-Received: by 2002:a53:acdb:0:20b0:66c:f55f:cd9b with SMTP id 956f58d0204a3-66e4c75015cmr700353d50.46.1787874915812;
        Thu, 27 Aug 2026 16:55:15 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:15 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Thu, 27 Aug 2026 19:55:11 -0400
Message-ID: <65fd3816ed5d541d9edd4bf4fcf97104a2cf907a.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787870710.git.blbllhy@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Link: https://lore.kernel.org/all/20260821182449.79785-3-blbllhy@gmail.com/ (v1)
Link: https://lore.kernel.org/all/20260826171344.4133-3-blbllhy@gmail.com/ (v2)
Changes in v3:
- Annotate dctcp_get_info()'s icsk_ca_ops comparison with READ_ONCE().
Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
---
 net/ipv4/tcp.c       | 4 +++-
 net/ipv4/tcp_dctcp.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 55ca74f60..71d4c5e6b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4561,9 +4561,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 99f68c299..5b457f68a 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -228,7 +228,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	if (ext & (1 << (INET_DIAG_DCTCPINFO - 1)) ||
 	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
 		memset(&info->dctcp, 0, sizeof(info->dctcp));
-		if (inet_csk(sk)->icsk_ca_ops != &dctcp_reno) {
+		if (READ_ONCE(inet_csk(sk)->icsk_ca_ops) != &dctcp_reno) {
 			info->dctcp.dctcp_enabled = 1;
 			info->dctcp.dctcp_ce_state = (u16) ca->ce_state;
 			info->dctcp.dctcp_alpha = ca->dctcp_alpha;
-- 
2.43.0
