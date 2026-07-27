Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3956363086
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119389; cv=none; b=XGLW+vBl8sSRPA3jN+FqKUYWYiIq6ha2GS2BDA20Cbw7gR7nUPJIQXv7UWwnZ8V/zVvr2neM3bGI/PzKQ27olvFJ0pmPQNiXKyY+8O3uu0fASyuXnPZl36fNUdCydCrw1/AaDl+4yMs6FaWPGnx+4OcUoGALgfQ4sHDjcTjW0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119389; c=relaxed/simple;
	bh=LIf7pYTQe5gFC3YD3BPwo7fV1ZFkjFvVMAq4MOw705k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaGqjSGJUp74UlQXA8j6NQtGGM1K0jcStXv4xfpT/jeU+INA/Ur8G0udDGzKc3mOx8DLoii4i5mRSciN44xSBPy3MSZ3eHWWy64qQW8/mOPWzZ9MpKGdBocU8UoBm4B2bpBk3QI8ReeYGTqSkvL+H8eAubELKCsjw1vNtdQDUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xerjUy4+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xerjUy4+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785119384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUoMrCeHxUNbHSWyrBWNgupQf2D4kFYpm6ax4sftE1k=;
	b=xerjUy4+lOKEy9QvkKom/FI1vUoFrhwttaKBFKu98QkYPMTeHAaX75g3aCWu/kvsbhkupm
	HbWH+twrJELXO0SeqSfg1zaYk9YOYdEDXIIQjR0unDDWbB/93ORya4XsGovNImOGHZPS12
	JFijltyuQt4+qJ3H5p2f2hSYXlCB+TQ=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/7] mptcp: take TCP_MAXSEG handling into __mptcp_setsockopt_set_val
Date: Mon, 27 Jul 2026 10:28:44 +0800
Message-ID: <20260727022849.20923-3-gang.yan@linux.dev>
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

mptcp_setsockopt_all_sf is only used in 'TCP_MAXSEG', and it can be
replaced with __mptcp_setsockopt_set_val.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/ipv4/tcp.c      | 1 +
 net/mptcp/sockopt.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b427f924608c..5915d0e62f43 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3830,6 +3830,7 @@ int tcp_sock_set_maxseg(struct sock *sk, int val)
 	WRITE_ONCE(tcp_sk(sk)->rx_opt.user_mss, val);
 	return 0;
 }
+EXPORT_SYMBOL(tcp_sock_set_maxseg);
 
 /*
  *	Socket option code for TCP.
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9c4faa0d82ef..a7d4135757e7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -889,9 +889,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 val);
 		break;
 	case TCP_MAXSEG:
-		msk->maxseg = val;
-		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
-					      optlen);
+		ret = __mptcp_setsockopt_set_val(msk, &tcp_sock_set_maxseg,
+						 &msk->maxseg, val);
 		break;
 	default:
 		ret = -ENOPROTOOPT;
-- 
2.43.0

