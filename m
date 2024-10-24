Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D13399F
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765372; cv=none; b=aqZSl5YeRb+nc/y1A4qbBsRvAuGL4ZGenLmdRhXz+k+fd+76enn4kUA/5m16kM7ZmUUgmZhYETk3YbU+2oz8rf4QP5IPjsvzX68UKKVcTi8zty/bYrz2EEMyQjXxf2Km6YFbfhXj1NAncnE9feRGlRTC2BMZgweROTJEg7QKVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765372; c=relaxed/simple;
	bh=w6pzZgUEQKDHCrJ5SZzqhNjOmGuJ5Vq13ySobUnLoqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC1ZCkz6MWO7thdIT4KSaqptucK/TSnaoenz1OFgfvDyIhwtJTsvUCMJW0obxm5IR7YSGfLwRSTGi+FqRdqwi4kJe2tGzZ+4HfuEKb4kZvCMIDkL+k6oLKWTcC1LKeccYvvsuUqIMmVV8rRplGBKbYb5bns/BUw6WeoQpwrCxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZZ+HzuI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZZ+HzuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9D3C4CEC7;
	Thu, 24 Oct 2024 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765372;
	bh=w6pzZgUEQKDHCrJ5SZzqhNjOmGuJ5Vq13ySobUnLoqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZZ+HzuIUugPmHiRQLlIo7lUrH/VjikOLP81y3mc1uK4mPQfo7W/0eQrVmvmQteKX
	 Z7O6cCYk5TqSSICJB0U1ptJYxgXuJO6+pbUftDvlG6fjYfwhOCcDZxfimztLP9yy3i
	 9SQtO9dLWd9aWAZm+35t9sEZOzlp6s+xgWIim7UFnPQfCoeB//4INo7B76LXSCNAwZ
	 z2ETu8nNhmT0/iJiOLBL3EMJFDNJu/Iuu61I04UaLYpLe/6ZEEL5HzEzSF22ggtrFt
	 UD9iJ7H3bzCJuM1tJJXKAF3T9LIVfVa9xOX1CxvcSiluYS5UxKamkptxu6/dE/q2I0
	 d21MtXgHse0Jw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu, 24 Oct 2024 18:22:04 +0800
Message-ID: <f7cc83a335efc23ca65b825062c804914c9227db.1729765157.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729765157.git.tanggeliang@kylinos.cn>
References: <cover.1729765157.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move sk_stream_memory_free check before "send_info[backup].subflow
= subflow".

Use mptcp_stream_memory_free instead of using tcp_stream_memory_free.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 6242430d0330..1157921d2f0b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -23,7 +23,7 @@ struct bpf_subflow_send_info {
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
-extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
+extern bool bpf_mptcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
@@ -49,7 +49,7 @@ static __always_inline bool __sk_stream_memory_free(const struct sock *sk, int w
 	if (sk->sk_wmem_queued >= sk->sk_sndbuf)
 		return false;
 
-	return tcp_stream_memory_free(sk, wake);
+	return bpf_mptcp_stream_memory_free(sk, wake);
 }
 
 static __always_inline bool sk_stream_memory_free(const struct sock *sk)
@@ -87,8 +87,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk)
 		bool backup = subflow->backup || subflow->request_bkup;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
-		if (!mptcp_subflow_active(subflow) ||
-		    !sk_stream_memory_free(ssk))
+		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		nr_active += !backup;
@@ -103,6 +102,8 @@ static int bpf_burst_get_send(struct mptcp_sock *msk)
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
+			if (!sk_stream_memory_free(ssk))
+				continue;
 			send_info[backup].subflow = subflow;
 			send_info[backup].linger_time = linger_time;
 		}
-- 
2.45.2

