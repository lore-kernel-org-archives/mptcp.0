Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D03AD512
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238815; cv=none; b=b6oNiUw3X7w+cdczXvriuaUlTl7VOYMkLW+K2Du9b8TVqYLyW1lokP7yq/nfYRtvCpubiMOToPE8RJP8M37MT1c3IUsUTDhpqjggAj///my16awb2PVTHiBS9iJ9Kx+Sah4EIEf9KooS+rJD5XFtl2HF3TjeD90UbNN4Ypjturs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238815; c=relaxed/simple;
	bh=hnRdmd3i4pMqRlq2KAW5JlOwu1gHDhXakz3I13cZSUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egqL9rEhEwY40x9aBwkAMYgRofcrnMDn4H7gKZaqGyIFtS2VzMnBFVcbxRGOX/RVv/gnnnRtoD2XGUZvVEzg0Ye3OKPOftnFT4D4bVA8b8H6EEorwJHXFffqT3IYggtsxR7AzbpVlrAzjf/N8nt0QvMwP5kN2Q0/vwT5kBuUQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzmIKVEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzmIKVEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE081F00A3A;
	Tue, 28 Jul 2026 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238814;
	bh=YV0JXnpiXszaXfnHGLGoqUaEj8Uho1EeAyo0R88VJLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzmIKVEafDkytWbbCKjcmD3S9WUsJr3jRkRlrR/1778Ihi6E6Z+/Mb1kRpkeeoNmP
	 CqckBQQuGP0lPkHNmg8lw5bivC3pbTQy0ECTQNC4g258hybCMHHYPL1b06pw9+l1Ip
	 juTKfo+NsJ1JEfO8OTxukeJo0J5QYKwMmVPro/zaueVJzTSFrm1PaX9rSNtZrJBtTF
	 loVJJH1yvg/sfyC9eiaKELKy2oRGogT9OWrKar6hCEbocLgmbnKtfF+Z8soXooU/LO
	 rpitqF+QJFkKeUnC4ywHo6P7ztiXyZdz/Yzh9L1K90ZrIjWqqszrbgvimlOrhAtb8w
	 lrXXqzbFKmZYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/9] mptcp: inherit sk_reuse/sk_reuseport on subflow creation
Date: Tue, 28 Jul 2026 19:39:34 +0800
Message-ID: <2fed2c35a415e9513bc79ecc3b050ade7e9c2b90.1785238723.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Propagate sk_reuse and sk_reuseport from the master socket to newly-created
subflows. Without this, subflows created after the master toggles
SO_REUSEADDR/SO_REUSEPORT would not inherit the setting.

Also bump setsockopt_seq in the SO_REUSEPORT/SO_REUSEADDR path so that
subflows created later (e.g. via MP_JOIN) trigger sync_socket_options()
instead of skipping it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..37e65923f544 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -326,6 +326,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 			else if (optname == SO_BINDTOIFINDEX)
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
+
+			sockopt_seq_inc(msk);
 		}
 		release_sock(sk);
 		return ret;
@@ -1601,6 +1603,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
+	ssk->sk_reuseport = sk->sk_reuseport;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

