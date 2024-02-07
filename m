Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA12E856
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307012; cv=none; b=J1hq9CcffDYuxJv/qG8dOm9OIxjML4exujd7sgIuh5E/yKqXarUCrqy7+XfQcdhCM4JU+JiXK+8WIxYiBX06gcXbfzn/fwnXQupVmkEKoDwZT3RmpX+SLEQ9u/QSBdByFxNvKsLFjBoLmQPoxF6XhIJxhbsp2ZKUR2vw3TK+KMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307012; c=relaxed/simple;
	bh=4V2mtFiKHeJuBAa3am4+ZUuAoftwJtuommAupSBVqZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tnoqtv3LWpMP+qLgMHhOQq14t5A1s59KKdvavU8mES2PPGr/6QffodHoUkJt8mzwYj6cZJqzyOsUDjHCRQEsfdN2ApHwGD5bWZi6F8dtXw6Fh0JPKtQL0f3VC306T/rtUdUcGUrfPVCLLXXY1/Lb8Utcx7oqaiKXCNFe4ewI9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTRdY1yv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTRdY1yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4ECC433C7;
	Wed,  7 Feb 2024 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707307012;
	bh=4V2mtFiKHeJuBAa3am4+ZUuAoftwJtuommAupSBVqZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QTRdY1yva1D78y3uudOVEIGTYqYqV8hy30dzS8sZCKJvvr6q1IWL9cUjukPO6HdtS
	 DmmCwXPe5HS0jymmIKKwSqqwkieVSDIYuNJ4TxmC+DBAN60TvF0uVsto8hKpRdJ0BO
	 qLyPnKw98qygGkxP1TYiO15EY4JgMwd6bZHhvg+hbd6vx0kQqF7ZP4mtEi4NMW2eC+
	 QrNpA9eEe031chC9ZKkkBp5qwz0G6G+ngy4fLmmm9jQDAWfoxw3n/Bu03oErARxSyB
	 X0YVbdzjCC65eyEp2LAy1OYGxtsmv+vgCJwyylVa07ZJQP+pCB1F5coRK4K3YsJetS
	 wGmnCxwef2Prg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 07 Feb 2024 12:56:24 +0100
Subject: [PATCH mptcp-next v3 2/3] mptcp: check the protocol in tcp_sk()
 with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-mptcp-check-protocol-v3-2-77c69c596f55@kernel.org>
References: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
In-Reply-To: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4V2mtFiKHeJuBAa3am4+ZUuAoftwJtuommAupSBVqZA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw3AATYqIB3tC+7eqtY2QOfEo9vCtJn4cfrikr
 ZAVWqLg6k2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcNwAAAKCRD2t4JPQmmg
 c6ZiEADmrA41S+EvdQpDHRp+WJBoX03BFRdGQtoez1z2/YGHWMD5+U0qcQxM9yG7gtqkDBb3vDN
 UZujeVeYvedpJy/mW0rrRqAv59A0dE7hRepIHK5nxX5AcX/++z/nEc8dTst4xgiNqJ6x5w4N8vq
 DEVJZi/3E8yuR7N0V8PMNUr4BG/eR0C8YANfQmwagMd8THZ8oBCM32YDKOrfy3bxUk/fEncePcZ
 VWoS45npLEtO1mfrm/JiXUioU0WmXID1v/dgf9gPY3+b16AitJb89w86ZwBHdWqg3pxCWtVT8YV
 i82csi0N6tCf01jbM0CbxVzWds+gm4YdHrMbwamljl0ceBZrx/Zu0vic0KpBLGVK1z3c8VR/Hed
 bI6483hYxWR60eyxOfXFWLJeYJaTjPQKGC1t+XRFOr65CLryYjkIsdJmwBemOGKI7wXYww8CVwW
 J/qZYYuGQ9BR+2XgeFaJP5IzJE2TnkO0UngnZ9FGxnASQEPbKtYamn7COg08YPQzZbL/uOv+Sv+
 3f5Cbuow5y9qKJU9UTF6jV/UVEUVj60GiyZ8q/XYgBWt9YABiNT1dWKItdjKY07K7yYUlK1GBkz
 TSAnVm+JWzqEXdEYwK3GBnPNdY0awOEEgaZpCz1LTWvAVe10vczyGa3cOvDkJaGNHM6mzh00X87
 yB0EjOsYnV3HZ4Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when tcp_sk() is used with
a non tcp_sock structure.

This kind of mistake already happened a few times with MPTCP: when
wrongly using TCP-specific helpers with mptcp_sock pointers. On the
other hand, there are many 'tcp_xxx()' helpers that are taking a 'struct
sock' pointer as arguments, and some of them are only looking at fields
from 'struct sock', and nothing from 'struct tcp_sock'. It is then
tempting to use them with a 'struct mptcp_sock'.

So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
kernel devs when a non-TCP socket is being used as a TCP one. 'tcp_sk()'
macro is then re-defined to add a WARN when an unexpected socket is
being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v2:
    - Move from include/linux/tcp.h to net/mptcp/protocol.h: specific
      to TCP (Paolo)
    - Use a macro instead of an inlined function (Paolo)
    - Adapt the commit message after the recent changes.
  - v3:
    - add parenthesis around 'ptr' (checkpatch)
    - there is still this check from checkpatch but I guess that's fine:
      Macro argument reuse 'ptr' - possible side-effects?
---
 net/mptcp/protocol.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eefd1397106d..6b62a7f35dd9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -348,6 +348,15 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 }
 
+#ifdef CONFIG_DEBUG_NET
+/* MPTCP-specific: we might (indirectly) call this helper with the wrong sk */
+#undef tcp_sk
+#define tcp_sk(ptr) ({								\
+	WARN_ON((ptr)->sk_protocol != IPPROTO_TCP);				\
+	container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
+})
+#endif
+
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
 
 /* the msk socket don't use the backlog, also account for the bulk

-- 
2.43.0

