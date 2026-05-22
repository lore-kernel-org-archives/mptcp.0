Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B93B993A
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441177; cv=none; b=YGQ4gYQURPKPw32lM49VtHVYWbIFsS14pBXxzua25Y+jIo6tDaTY6lUppKoAJxLY/1pJ5L4LVKNGU2V0AgjEPocqbuIMLLLyFAbx+W4f4FPWCa1Vb1OVkW31iCk2pILG9rOYJI/A42e5gLXQNM1FEphfebmBSBm5yGT6FHzDUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441177; c=relaxed/simple;
	bh=cUogXGoEOeTcwaR5yLlPhfnDFkCWGhd/UGBvbPRmz54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxx+Zh8tkFA7TEcfTkbFu9UzAzh1MCIwhVDhOjKcEyj6gFczGPB3UNMBAg5YSy0kWFLRfcwqsXkOL8o/8hFr30zOJ3JYW6rSegNu1U1/OB/iPf+nh7OA9WUq6k9/AZNzePQAgTmyvTGTFU07hDecXRFrNU4YKOKrBmtYa2RV9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XWt2MDlZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XWt2MDlZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779441174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pY7/pbkeayWxlhePh7sAMil/JXfWTnQZpvhICht6ZoU=;
	b=XWt2MDlZp+QmUHSN7JRIM1cVzb3msl/XXyXWtKBl8MEACqOdeNOLcz/oeywuzDmE4GB0sQ
	JdcUP7ne92GAM6eKGoWe6X/3n4LdSQNQJquztxveTNljJithW+WOodLTxt0IbaPzhkmdVx
	QMtWo/uqRPKdgx3MBY8L0Nxc5I17ahA=
From: Gang Yan <gang.yan@linux.dev>
Date: Fri, 22 May 2026 17:12:33 +0800
Subject: [PATCH mptcp-next v5 3/6] mptcp: use sockopt_ns_capable in
 congestion control
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-sockopt_lock-v5-3-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
In-Reply-To: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, pabeni@redhat.com
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

When a BPF program calls bpf_setsockopt(), it may run in softirq
context where ns_capable() is not appropriate as there is no valid
credential context.  Use sockopt_ns_capable() instead, which skips
the capability check when invoked from a BPF program.

Additionally, the load parameter of tcp_set_congestion_control() is
changed from 'true' to '!has_current_bpf_ctx()' to match what TCP
does: when called from BPF context, use tcp_ca_find() instead of
tcp_ca_find_autoload() to avoid module loading in atomic context.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index e69d243bde36..3a5cd3023e59 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,7 +598,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 
 	name[ret] = 0;
 
-	cap_net_admin = ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
+	cap_net_admin = sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 
 	ret = 0;
 	sockopt_lock_sock(sk);
@@ -608,7 +608,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 		int err;
 
 		lock_sock(ssk);
-		err = tcp_set_congestion_control(ssk, name, true, cap_net_admin);
+		err = tcp_set_congestion_control(ssk, name, !has_current_bpf_ctx(), cap_net_admin);
 		if (err < 0 && ret == 0)
 			ret = err;
 		subflow->setsockopt_seq = msk->setsockopt_seq;

-- 
2.43.0

