Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1E433B1
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997223; cv=none; b=X7y2htkaQrBVhUj3TKPM04Qsxj8rZOkYOFCs4H++7Ylh/4RD9dytSKqr5JqTBTA9BmKnuvl04hckRjOIZ1qeLj8crnrfML0JVDQODRGdn3fi39QUxHlSmhiW86si82vAOYxDH7YN+nu5wECFIusCkKXtgT8aY8eP3ZHtprZFOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997223; c=relaxed/simple;
	bh=yn3HDvwvTHvw/SrDF028FlsUMAUFy1J3KeYXRRH+gkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwDohMZ7dsiRqlfszxTIoGDVCcXXtm+fqxm4w3mjhfdJ9AiKpENs3+PISGU2wVOqo5vFqGFrsZcvs6KVQchYfnxn28Ts8+V7UdQZ78x0opCW1jPAQdD3jq0i31KeRW6u24e2BDWfsfxSj+qz3CJ5Jm2K2jNuodPZxw9BlQuG4UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX7G+KlX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX7G+KlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449F7C43390;
	Thu, 15 Feb 2024 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997222;
	bh=yn3HDvwvTHvw/SrDF028FlsUMAUFy1J3KeYXRRH+gkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dX7G+KlXQZA/hr7bkU2N9d7WauuuYEuhMAbk6r9sNvQyvpRYlXQmfeLYK1LKht8UH
	 EkFZ5Anj9ckRYSCRsQin4DhVB/lopcvTYNMUo+u3hQqyMjuT7RdPWMxNtSCH+63fxN
	 sV2lQQKhbLWreSn3ACWlGCjo8tcvyq74pXK8CSoAbEMvZ8NRNSQN6YTF0OZjV1KdRi
	 8/5G+e54oD995OYOAE3Uo0soZsAAbVADYmrjGNGwWrMtbKyfDvFttZ/QETMCRL9pBz
	 0G/LA0GpkBJhtNZ98mo9JamFz4DSySgeHAmuHVNHlqdRNAoLHgQFcxQt+MLGU9P5Ig
	 ogEDjRifnfZVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 12:40:04 +0100
Subject: [PATCH mptcp-next v4 3/3] mptcp: check the protocol in mptcp_sk()
 with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
References: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
In-Reply-To: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yn3HDvwvTHvw/SrDF028FlsUMAUFy1J3KeYXRRH+gkc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzfgegJeJn1g2jr79HtrcYJVxYgoFFbQMJcfhO
 OwTT5fSZUuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc34HgAKCRD2t4JPQmmg
 cyvPEACaBTsNhBoosy5nFvIucifZ9Gl5zV1JYaIMDSnM5OQpL4vpg/IpPcYPaIzwdtQmE/BTzSw
 W0gxvk849vhyEaMIJRKHbCUZ0QPEkrAuzSCXocSWZ2yWNDlQrD+rENLHrrMHOfLYh5ykLsBZNED
 Pk5sDMadtKKqXm4ZmEvkZ9lhtDH4FzO8jc4DgprYl8cBH+sA1PdIPCh9FDKOPEmwiO+ifeSpVSf
 4K5CKDocjuhRqnSwnFK9YFDenSiJK/AsucBx6fMh0y6Eo11wezq8h5IM0oEqIUzVBfRYpZpH+4l
 wSQ2Omn/oeW8HpwTYLmHWyW73DzzwGuVkohEX2V+NiNyH0VxwosL74UIuCZdln7xYarWA+moT0B
 d0mLv9cJj++ec4zMjgdRlFC+AAZkYCZ2Mo11mNGDYYXWW6VpccUO3wcgwP9rcnpVpfxVvARE3I8
 gnfi71QqgJLKMghDMwFQDWOzNs7icvKDuQkECAKEgahD3d02k2vp0X61cVg3FuVYL4pWC5vAH/i
 S+llN84t1wKnQx9epXbKW+OEXz4QqsWjO37VeVe7VyyszCr1DmzKhGEWrfyeoNgcJju6jqa4zQs
 /16HUFaaPoM7O6YF5zH/ynkFVZMoljkDBTQhxzAeNb/p0nf7QKa361NK6kCXjkAp8IK1+6Q7iKd
 xZGsQ7MCYoZ+KaQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when mptcp_sk() is used
with a non mptcp_sock structure.

This is similar to the parent commit, where it is easy to use mptcp_sk()
with a TCP sock, e.g. with a subflow sk.

So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
kernel devs when a non-MPTCP socket is being used as an MPTCP one.
'mptcp_sk()' macro is then defined differently: with an extra WARN to
complain when an unexpected socket is being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v2:
    - Use a macro instead of an inlined function (Paolo)
  - v3:
    - add parenthesis around 'ptr' (checkpatch)
    - there is still this check from checkpatch but I guess that's fine:
      Macro argument reuse 'ptr' - possible side-effects?
  - v4:
    - avoid reusing 'ptr' to fix checkpatch warning (Mat)
    - remove extra parenthesis in WARN_ON, no longer needed
---
 net/mptcp/protocol.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 32cf98bd2961..459859b107ba 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -356,9 +356,15 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	WARN_ON(_ptr->sk_protocol != IPPROTO_TCP);				\
 	container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
 })
-#endif
+#define mptcp_sk(ptr) ({						\
+	typeof(ptr) _ptr = (ptr);					\
+	WARN_ON(_ptr->sk_protocol != IPPROTO_MPTCP);			\
+	container_of_const(_ptr, struct mptcp_sock, sk.icsk_inet.sk);	\
+})
 
+#else /* !CONFIG_DEBUG_NET */
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
+#endif
 
 /* the msk socket don't use the backlog, also account for the bulk
  * free memory

-- 
2.43.0

