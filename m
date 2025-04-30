Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A41E32D7
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992194; cv=none; b=nNRuLEaX1RgvjELWqPTmgXy0g4xaCntdceO1wOusqPWTcpoe3KuqXTwLv0RqVxgMdv2ThIKmZnfBi2TCPwK3v8sE7vwqmY8HhvY9UkHx4eREr8y9VffOweJ8kxFoWqw2jG60n+0eUUcXVp+E3L5YwVr9zenOtTbTATEJsQ3g/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992194; c=relaxed/simple;
	bh=R89UzM8Nl2S0Dk+t/6mqljP1CoB32z2e10z66oqIp7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AC/ArvHMvZuLQL2girRdEcu3a9CPQRQkjc3D29KbbbvZXENsslaonyYciv55x8bqfDmkCyG1lHJPlJxUYNZwxxpLb5+zhYyqHRRAYsV7vvQaUjyWeHELWLuUqPLoW6I0KIo0Jp6WqAfateZbxgO3AsTiQiWLOUFM6iZfdkD4GmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwOPK8Qh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwOPK8Qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003F0C4CEEA;
	Wed, 30 Apr 2025 05:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745992193;
	bh=R89UzM8Nl2S0Dk+t/6mqljP1CoB32z2e10z66oqIp7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwOPK8Qh+aYW+cuhN0mw5ml3VFoJJ3TiPzddrrgmU6nzthaQcPx1s1Jt7RmfsU9mP
	 DJ6diVvfUxy+K1/ejo+Ul2FfUXB0xY0uKu6nqfkKk0zvniqa4T6J5rc3HULJhcG62k
	 V+fe5SmzP9X1wQx47X6dZgsTvu0ygaikw8Z6BM5ZcpKvzHgnFlwQ+QHD8CR3kO0f4Z
	 tZzIAN9PimCjifqxztk0Pp6YQZQpCgL54uqFOj+ZP5l3dxV4RYsj9z4zRrfid3Amit
	 cbD0O1heEQhbqtI6+uAKKG4C7YiOBEAwuMm2fKi4FFxD7/AEY7y4BKHD1wCDa5EamS
	 ua4eNmSH1ykoQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 1/2] tcp: add tcp_sock_set_maxseg
Date: Wed, 30 Apr 2025 13:49:44 +0800
Message-ID: <65512e0b126b894d029cad693f8d6b44f70ec311.1745991978.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745991978.git.geliang@kernel.org>
References: <cover.1745991978.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a helper tcp_sock_set_maxseg() to directly set the TCP_MAXSEG sockopt
from kernel space.

This new helper will be used in the following patch.

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a8af71623ba7..41206c3f289f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -624,6 +624,7 @@ void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
+int tcp_sock_set_maxseg(struct sock *sk, int val);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e1bbb070e734..e1f00faed760 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3726,6 +3726,19 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	return 0;
 }
 
+int tcp_sock_set_maxseg(struct sock *sk, int val)
+{
+	/* Values greater than interface MTU won't take effect. However
+	 * at the point when this call is done we typically don't yet
+	 * know which interface is going to be used
+	 */
+	if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW))
+		return -EINVAL;
+
+	tcp_sk(sk)->rx_opt.user_mss = val;
+	return 0;
+}
+
 /*
  *	Socket option code for TCP.
  */
@@ -3858,15 +3871,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case TCP_MAXSEG:
-		/* Values greater than interface MTU won't take effect. However
-		 * at the point when this call is done we typically don't yet
-		 * know which interface is going to be used
-		 */
-		if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW)) {
-			err = -EINVAL;
-			break;
-		}
-		tp->rx_opt.user_mss = val;
+		tcp_sock_set_maxseg(sk, val);
 		break;
 
 	case TCP_NODELAY:
-- 
2.43.0

