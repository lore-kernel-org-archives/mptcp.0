Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438DD1E4BE
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055439; cv=none; b=GPGjr+AZTAWaogF8HLsW71rdz9QrogNXDVVTBn7kDwAZYDB7sL4Ok/XHxYn38uvr8IMRsvbF17E2/M3fBn2VpTCUoRu+qzthFh0l5xoavdCdFp9nyr6EnYJO49espxZ75a6vo4Mj10+IPmKJVKx2s0tnQYHzUR/wNqtdaQLN8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055439; c=relaxed/simple;
	bh=RkexuyUwDPzvOhvjEIHE26q9eZX4X/O3H2GLIME3Quk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJ5XaZeeb5rk6UqUWWPIG//TznUHaHeyHySQIWr4HYBtp4FaREil7+UUmTTho8+tsGIhVq7h/uhbtukaxAHLJP/DuFFi+oRXuKfD/4z3DWCPbUs9BQQLXS6XBa3ORPh5LM+UyjKhOFggQukqUiti/EoR7rXZb2JGnAhiGnsIeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw/peGxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw/peGxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50AA1F00A3A;
	Sun, 26 Jul 2026 08:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785055437;
	bh=ZRvmQJTbiwMa/r7arSf176lVugsTHe3twDxh9Dla7Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gw/peGxUvdyuSycjCTRnNc7KbULCGMqtnADc7FP0PsusnjeuFXgu7+NbTZCOfMmgk
	 EdyTRrejcFI/Gisx2j9X8MphDMUtRE3IoD5o0uHivk53r3ZkicfIGHwwjmZ0thlBfH
	 4IH9YzUpTy77SEsuVDhMlZd/4aitXzouN1eoifFg+jwR/F+M8DQZP0zFLOs5HTen57
	 wcNXEx8tD5iM0ALPbQ25svp+Myc70i7v00PlttgS4b3CTlNVNmFrwGhcX7wAjf62LN
	 OoLFGVneyOlhA/S0QEyzspJVPZhem/d5ViaoosJkovu+m18XaXVQ0YQzVuVsseDVLi
	 Xq70jmSPVZMLQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/5] mptcp: inherit sk_reuse/sk_reuseport on subflow creation
Date: Sun, 26 Jul 2026 16:43:41 +0800
Message-ID: <650252e8ecf53c9d05aa808f95d7fa0fcf812c14.1785054808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054808.git.tanggeliang@kylinos.cn>
References: <cover.1785054808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Propagate sk_reuse and sk_reuseport from the MPTCP master socket to
newly-created subflows in sync_socket_options(), mirroring how sk_reuse
and sk_reuseport are already handled for the subflow.

Without this, a subflow started after the master toggled SO_REUSEADDR
or SO_REUSEPORT would not inherit the setting, leading to inconsistent
reuse semantics between msk and ssk.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..dc1ef52c2200 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1601,6 +1601,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
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

