Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60B2459DD
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985255; cv=none; b=bFQRAVRZWhkguMVCWoY0VVrtL5MihxzSbpuIM+YQ11WvjJqEEJSWX//DQnEJekVqfuctYlX+M3W8vazfzqAX01duH1szort7YvXDjPM3vBpAHLWGVbAb/IakEcd/BrVCWc8tmxjETgXW6K0a/R5ExtUiuzsp4JDlw+lhmjt0QqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985255; c=relaxed/simple;
	bh=MnUUPbvgRWLBW3H0TRwqFdI7VpHcbuKPYoATHp8Eozg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6ThS8DmtPBNRBktXJ0ryZG+pu+eFdM53gjmlf2oezrPQMY4VWzligAW/Y0gRWvFnLHdpchv/exhwXUfBmHaQdDGZA1ttgHyvbaSl2moB3Hj/Im3zuUTc1mKkDVlCPAaYAd9JLtkN7/K3wNaRBydSALRjO612+oSLv7p1gVIrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPciFFHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPciFFHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E31F00A3A;
	Sat, 25 Jul 2026 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985253;
	bh=RE1Cqk2Ezk8fjSzTnDbDcIxnX2r/UFAV/PuAyWcUx5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPciFFHa20wr5Cqpu8UOID1YKiHqDAfr6E+iB0Hjl5rMfeu8Kk3recyw5kczB00qy
	 jR8PFuhSNEZSYRTZ2L2RxWKqhNDep+EAD8NqsDdsMkIGsb9E9jGzKD0QqjWak7+5D2
	 rNJ1pZAq6L1rdXWk7QCWUEjKlDR6cC/55upa+feDcMoHUMiX5I5olfCjLzZQiJsyKY
	 D1FKg2mLaRs8+UGfoQRCYBftUQ7HbIJlakA3kjVJ37jNaRx9JDGUDcyXmM/iLeomkH
	 swPzJErbSePVIknOxTKr+ak+ZT2HPmm38WLOlHL6C0CVAyJi3j8XE7AwXsrkgbHaB0
	 22PAsmcRTJM5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/6] mptcp: inherit sk_reuse on subflow creation
Date: Sat, 25 Jul 2026 21:13:40 +0800
Message-ID: <de70ce4930f7757820cddf40e87cc9dbc4d514ef.1784985085.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784985085.git.tanggeliang@kylinos.cn>
References: <cover.1784985085.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Propagate sk_reuse from the MPTCP master socket to newly-created
subflows in sync_socket_options(), mirroring how sk_reuseport and
sk_reuse are already handled for the subflow.

Without this, a subflow started after the master toggled SO_REUSEADDR
would not inherit the setting, leading to inconsistent reuse
semantics between msk and ssk.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1b2487a5ae2f..594ce3b4b707 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1603,6 +1603,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

