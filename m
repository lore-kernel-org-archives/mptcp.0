Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459123AE62
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985258; cv=none; b=FlFmiMHPbd8eyS21zp9Fq/o44eopsW+UPlGuEjtEpstj4jtls67k0Hy3b+dnQSPuTO0loHVSrB9KxarXxhdM1CaALyHJkd6/b86CDNGLjeIxVo5xCoMXxPe+kI+Km77ICY6MqTunN7bTVh2HvwB7Rmh58yMFnD0tih45oc3BEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985258; c=relaxed/simple;
	bh=NzgcNt7WrZxLxb3fl/I7ol8GF5gHfSsOHfIe+oSc4tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lu7HkaqkKBGMwj7KMdsTAhTXuG+L54xYMv/GryVdr7iSnRfmUcziCyxjjAoDOiEHNkDqh9zkoC3BsB3cMDzSTIPgScq3IE/JyNiebxWi1ourqcHogNSmoNP3PvsCihbg3vgFTXWZ6yP4nbiygz95tzTD6vdWWqdHG87XR9OkFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0PC+7NN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0PC+7NN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D324D1F00A3A;
	Sat, 25 Jul 2026 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985257;
	bh=iDUwgc3YWb0PTSj+Lt3liXAYK/Yjf3lkzFfN87TDiIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0PC+7NNOyyqi73a8E4/k0yEAPRhmwx/xHt7viLaTWLGYJbt08KoiIRRD36VvhvAJ
	 ysn+whDR309Tp7Vwvn5SVfRgT6sh1HUeipGxoaiNyOFpwSG6yZPPViIl2DDrcQkk2W
	 CIg7qhLTmqQF8RmROhzYQRppE4iRVeNejgOkTcEXlAktL3MP4gaZMdXM2Eedqxfpnk
	 JCrYzlsuvMObxqgOovMK3nRWYIS/Zm5QXwrAhqS8rx138HvRXBZ7WHvW6pwe8Uy5IS
	 BrRV18rcWEhkC8AgvqfWIFbUv98bP/Il6+V67dhba3C5X9xIy2grmardhXcOtkiqID
	 e9WcqtnWJGdTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/6] mptcp: add TCP_SYNCNT setsockopt/getsockopt
Date: Sat, 25 Jul 2026 21:13:42 +0800
Message-ID: <7b893aca2bfc58dfd9992ed3eb3de61ce7b20a9f.1784985085.git.tanggeliang@kylinos.cn>
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

Surface TCP_SYNCNT to userspace on the MPTCP master socket.

setsockopt(TCP_SYNCNT) validates the value via __mptcp_setsockopt_set_val()
and stores it in inet_csk(sk)->icsk_syn_retries on the msk. getsockopt()
reads the same field back.

A newly created subflow picks up the master socket's syn_retries through
sync_socket_options(), so the setting takes effect for outgoing SYNs
without further plumbing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index e40a5a23d1c9..50dcb53effe2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -897,6 +897,17 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
 					      optlen);
 		break;
+	case TCP_SYNCNT: {
+		int syncnt = inet_csk(sk)->icsk_syn_retries;
+
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_SYNCNT,
+						 &tcp_sock_set_syncnt,
+						 &syncnt,
+						 val);
+		if (ret == 0)
+			inet_csk(sk)->icsk_syn_retries = syncnt;
+		break;
+	}
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1449,6 +1460,9 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_SYNCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_csk(sk)->icsk_syn_retries);
 	}
 	return -EOPNOTSUPP;
 }
@@ -1603,6 +1617,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 
 	ssk->sk_reuse = sk->sk_reuse;
+	if (inet_csk(sk)->icsk_syn_retries > 0)
+		tcp_sock_set_syncnt(ssk, inet_csk(sk)->icsk_syn_retries);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

