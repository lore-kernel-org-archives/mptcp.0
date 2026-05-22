Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4E34B410
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441179; cv=none; b=Bbhqw5u5UyYLDH0OOWNSMjvHGRp7vZPCMnGyYQ9CRlF0/j3HRwt2J5s7J+EOObFOawms7LGNWd8oSClGapmoZ+UiWi9q0Y0xRwXWgMzDyioDe4hYkU5rENbseCDlsq52yRuXhd0SxVIy43y5ZzNPSTQtgCbgUh0UKOVh0SZjKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441179; c=relaxed/simple;
	bh=b+GkrD/fE3PGw1UslW8/3v+ndC81wrvLrIlPWqcHdBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xrhx8npyux84BDnz+dOXahrX0f8oax82hoFFwmDi19Ye9kCMMj7SU0tiGgC48HeOUVJMXW9JF0S2mSGEFnQcZNmUoqagDTV7tBoRCQFpswWF5iJJye8VtWsbWGJP2yLndbOnuobp4bdApLHKNbtl2e1Y948uDwsonOalKz5692I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WN+1BexZ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WN+1BexZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779441176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgeqPp3TSnsvJJ/vieW3dq7Z1PGrkpWsJyAYupzn6p4=;
	b=WN+1BexZp7wdCQt8d7/TYdGxmnaSW27s5OJMMLA3MXmCoZtXDn3S2EFig9Oqj33TMsoDkS
	0Wjwgh0ictFcxAwMIy43gdUOpbqqTgU/9K0z0n7QGeiiyJlNocZIWAH3cue+PzWMycvO8t
	/+cApo1xYrGCi+q44V6qLyjF2RZs/BU=
From: Gang Yan <gang.yan@linux.dev>
Date: Fri, 22 May 2026 17:12:35 +0800
Subject: [PATCH mptcp-next v5 5/6] DO-NOT-MERGE: mptcp: allow set some
 sockopt in BPF context
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-sockopt_lock-v5-5-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
In-Reply-To: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, pabeni@redhat.com
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

When a cgroup/setsockopt BPF program calls bpf_setsockopt() on an
MPTCP socket, __bpf_setsockopt() currently handles the option through
sol_socket_sockopt()/sol_tcp_sockopt()/sol_ip_sockopt() directly,
bypassing the MPTCP setsockopt handler entirely. This means options
are applied to the msk only, without being propagated to first ssk.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80a3b702a2d4..bfcfc8901b48 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5591,6 +5591,12 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 {
 	if (!sk_fullsock(sk))
 		return -EINVAL;
+	if (sk->sk_protocol == IPPROTO_MPTCP) {
+		struct socket *sock = sk->sk_socket;
+
+		return sock->ops->setsockopt(sock, level, optname,
+					     KERNEL_SOCKPTR(optval), optlen);
+	}
 
 	if (level == SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);

-- 
2.43.0

