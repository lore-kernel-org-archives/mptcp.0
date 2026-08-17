Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BA2E8DE3
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939048; cv=none; b=VgDjhLB1hxy2ei3nZUglXiTlQ37fpYsdzf9Om9IlyBPax/9sgOu68Omg9FWjiE+W2nkKJkpkZakNRNRCHuNgTIkrgOLRd5JOoQxGF7FJlnzrrO1LFuAijzJ9R1RnBuVSaCb0q7ubE+KUEmGXRtWcMkSxwg1k/4yhAXCQmIXpaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939048; c=relaxed/simple;
	bh=OoW1mOHrfQr3p6XnrxuF9rleL3z6nH6jNspTKo/LlBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrJgGTYoa8ozpa2E0dPsiLyZTRYEbb2aa0tR18XthWs7kdSWbHEVrbjUTtCtKhyGtFezi3ds7zgFosW/MG8wKPL3W0PDyGQTc3GDQi4ADaldiOFG2MI2G4zyNsU5F2TZInqqQtm2Fl388HgYEcxnrlHZo6ngbknobA6gyvyOD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcs/NcJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcs/NcJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BF61F00A3A;
	Mon, 17 Aug 2026 03:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939047;
	bh=68LYAzFqK7LWuCmZshunI/FHnd4fzYZzcErEL3W3Cxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcs/NcJZdIZv6d67Nwj0MPI+3YOn2YxCmRKRJ973I06mvWr5MbePce1nFdlXMNjsm
	 rdtCu+BIsMdrcAhHABQ9R/ONebNwhMrkk9k+KXOEOlYocVulh/pZXsYjtFTQMwKTHO
	 vNyXnJTTiawhOZmslFkcKgPaf7lIieCv2m+/jdn5bN8tkeufFAUKy+OYPNqHR5LOAN
	 WdAL8VZyjTFfZrgkTnOEhJdkIBUu7djCoeZ2Ozd2oYVJuPDoD4sYyG1HDvcDAFDRrQ
	 r/TZgVJZxzieFHleUSYCMHTvF5bohrwDbCQ2nDow97BqXfIKZlE+lCZovV95S95kIU
	 HtZaq7ZfpGIlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 4/6] mptcp: add TCP_SYNCNT setsockopt/getsockopt
Date: Mon, 17 Aug 2026 11:57:11 +0800
Message-ID: <30ec9ef5f850dfb4e34b9546a856592e65d97b3e.1786938892.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786938892.git.tanggeliang@kylinos.cn>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds TCP_SYNCNT support on the MPTCP socket.

The setsockopt() path stores the value in inet_csk(sk)->icsk_syn_retries
on the msk and all subflow sockets. The getsockopt() path reads the same
field back from the master socket.

A newly created subflow picks up the master socket's syn_retries through
sync_socket_options(), so the setting takes effect for outgoing SYNs
without further plumbing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d79139eb5b8a..50420d332b44 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -974,6 +974,13 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 &tcp_sock_set_maxseg,
 						 &msk->maxseg, val);
 		break;
+	case TCP_SYNCNT:
+		ret = tcp_sock_set_syncnt(sk, val);
+		if (ret == 0)
+			ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_SYNCNT,
+							 &tcp_sock_set_syncnt,
+							 &val, val);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1526,6 +1533,10 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_SYNCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    READ_ONCE(inet_csk(sk)->icsk_syn_retries) ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syn_retries));
 	}
 	return -EOPNOTSUPP;
 }
@@ -1646,6 +1657,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned long src;
 	bool keep_open;
+	int syncnt;
 	int b;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1709,6 +1721,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	ssk->sk_reuse = sk->sk_reuse;
 	ssk->sk_reuseport = sk->sk_reuseport;
+	syncnt = READ_ONCE(inet_csk(sk)->icsk_syn_retries);
+	if (syncnt > 0 && tcp_sock_set_syncnt(ssk, syncnt))
+		pr_warn("Failed to sync TCP_SYNCNT=%u to subflow\n", syncnt);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

