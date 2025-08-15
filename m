Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10752BE7C3
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289059; cv=none; b=kODHvClwQgp8FdISmBycQ5LyWpd/cKtWqnGqiAzOPNTO+3JwgrvqKNaMfIWYKPl2nJRdetOVzhgtJERX0hvakiBC+7jZ4Rc4U4eWkHFpXf5vKvNerv0DDPepi01eNyXADIBfzok86LeC5LicAYkRM6IUQU3R7yrIwW6RaUIEw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289059; c=relaxed/simple;
	bh=XyVZJFZzKfSSIkf/pvmLmwKjraQN8W4KgjzemH/XGU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mAP7clID2TTFIvR+6gnJt1qO+Mg2Nba3ZPBcuEjrUBlX8Fny1mEh3d7zhuZ04cW+X/fmj6X/+//xeco3dzDYCC4utdjxHVshX8CA5xIP0mK1VixOBxxgy8ChYy+nwGUUymu80xrja1xXFJR+JcQno7LeboB9HmSxmvtXveerem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pyrfnc/D; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pyrfnc/D"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2ebafe0aso2011597b3a.3
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289057; x=1755893857; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=Pyrfnc/D0QnV9MJsug58VwYNAHfcDTs0pougPFGz62vNWWFdoSkkkCdkNOjS3/MMol
         tEc4m3KE45zC0H5+PvDZB6emHiBs0RQWNXOheKWARC1osBkro5DWdnfqm8aite+j9qMY
         X3XgBDI4EsTJveLwEvv78rX8h2QsfD7bu/SHAQT69xXD5wVIHnXTymGAhBd8Z1IezMuO
         FKt2fY4CJagfKOS06/0IcMh7eUvfHmVUw9fpFJ4z0NNOrdU9qGX5iDLigQzkBAaEn/+j
         c3w9pjxo0CJHBFueahuYG+Mtyqh4/zI8ooJR5Q5tUqIJyoIIPDBBxWoHFcG57H87f9Iw
         /KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289057; x=1755893857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=xALTeD2vmE7Da0UjVzjtYB2lTwbWkqFLfJdesbpYm9g0/2us5q8MPQrazPVj2rbZtl
         je+YvaBxZL9rc5r0268OXQ/MwYHAes26LdIMNa7gpQZXjiErXlB8KDV9V2BzyFsldBYM
         5fxS5/5DxQ6zZtGpNZL6GzZiklfGdwlwc7miLvET0ss7J2nrcZtk0BrdHG2bh1pDN9Zg
         wCscZRvqkzFtxZbmLjD2Zx7kiCd+sCrC85njVkKPJIk1gr5cHgnXutC5jfUL+7Go2RIs
         W5/+q6n1brboDT9mOAjVD3XCCETeYk7t4qyHpex5/5qkc34dJKJloB3F0fRgdLf3c05L
         AD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq/2i9w37xf4V3tK7Zb2fBxXxl9kFryT73hkExqv9YVq80e1q/BlrXWtcQ00nd4dbK1Z7F3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjyQgFT+AD8YE/V2vQ1sA8uaT/s5B63FvS/dKLqLvta0OEGUjD
	XS2H78RH1ReA2/89z9z1maDyzl1qUxGjFTEdxYeI5MAi4F5jIrQwz5Z+Wi1xV0lHJBglKHx1hPB
	AZ9qVww==
X-Google-Smtp-Source: AGHT+IEr+/ZjFkXy8umwdjDxM5J/aKMeoAE5dmVL5UloiD+KmJwNlOPL6BEq/ZXuKgz5B8/N8YhDKs6emow=
X-Received: from pfnv9.prod.google.com ([2002:aa7:8509:0:b0:76b:8c3c:6179])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1893:b0:76b:e805:30e4
 with SMTP id d2e1a72fcca58-76e44838e26mr5098018b3a.24.1755289056973; Fri, 15
 Aug 2025 13:17:36 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:10 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-3-kuniyu@google.com>
Subject: [PATCH v5 net-next 02/10] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b15d7fab5c4b..a1787a1344ac 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -788,9 +788,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
 	 * as it can always coalesce them
 	 */
 	return (data_avail >= sk->sk_rcvlowat) ||
-	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
-	       READ_ONCE(tcp_memory_pressure);
+		tcp_under_memory_pressure(sk);
 }
 
 int mptcp_set_rcvlowat(struct sock *sk, int val);
-- 
2.51.0.rc1.163.g2494970778-goog

