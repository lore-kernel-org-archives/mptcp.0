Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8934A08
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997221; cv=none; b=DtnEygwPxclzGLe+9+NdFYhfEpgzfxosNGvtbfo5Wh5Jz6pe9QJl7cKP+pepIWVFQoSGo7rBzgEf3np3VGM4/QYO5ypcyYHNCjsEwXaSJwLeh1ISHLBWAKBFOkqRU4OieDbiIr06Mdi3WX4+R9xKcl7pAfEdP3kJ3zM12gX8VFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997221; c=relaxed/simple;
	bh=V9U8JdYBuAENa7dPeEa3fBLaft+F3rz8fQrkjeJFwY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyO2/wb4yRHcMeEGe/bWQtxSc0xHGEQXcn9Lf7c+AQWg/ClmQrnZLcgDHqJiO5dsd0IbDtHXoLLxba1wrA07dwWJ7GXGldwFfrPcBomZscFTrjMnPUtMv8r5xEJB/DGt2jqPoiAScMNlGx8+Q0xSdIfAWXv1PaCRuNGcN6qg0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTPGW923; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTPGW923"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3024C433F1;
	Thu, 15 Feb 2024 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997220;
	bh=V9U8JdYBuAENa7dPeEa3fBLaft+F3rz8fQrkjeJFwY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dTPGW923SyWclM7OdOEBOZFMxc5avFUOWFWEKJqyapi3SvT9j9UpJzfwIqPaO/ozY
	 s37nF8tu41dAx3sXoz+j38T0YQeySoI5Z/dgtyreimXisp1pzFFnD+zIiIaBrzmauR
	 W5f4HeTYhNa0e8PHJ85fxMkeSbSmJar66wiBepuecMWFAyeZsxrZ9LAxhk5kXqtg9I
	 0mHZDEvIsaNQ7lF/e/G/P6eOvGZ2nE0wulsuFYs+f58HmZTjTOAflHhNtzulGRiZFV
	 xNxDlPxvqyTtRw+KujOLtcPOwsEHrnY8dWEIWQWhYF0hpenbmEa3G34aaiUmxg9Zeg
	 Ex/+bwifjBIGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 12:40:03 +0100
Subject: [PATCH mptcp-next v4 2/3] mptcp: check the protocol in tcp_sk()
 with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-mptcp-check-protocol-v4-2-16e932665e21@kernel.org>
References: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
In-Reply-To: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V9U8JdYBuAENa7dPeEa3fBLaft+F3rz8fQrkjeJFwY0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzfge7sANFnV17/WO8Y/k3xc3xSDFxC3//jFR7
 tp3lgOKc02JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc34HgAKCRD2t4JPQmmg
 cy49EACd3mQBJH6XVttA7IOkBGv7bJaovBGPnZigYVF0pe9VFaHMbdOBKvVMQjh3koKv7sP4WV7
 n5o+IFZiv+SUwZA0qxGX6kVc4kGrBD9S/gGWzIZFjogLmQEZmFD1fK09UuhsGdMwihoNamVplSK
 QHy9PLT9KTbX0Sh4II1Euett+ZMV1I3HO4qKhR3D3ZdkSyLwF8zzxRweQyIwpxUKvX9ys1IVG0o
 XT/4fAOGTbROzZlJ5gzN4t1zaro+2KG9FeL0Jjwzw+lIOqKFmv2PfnNDGvCLhUwFsJz/rbMBvhI
 2tADvgeDfqqauUwEDPhzTItMOU+xz7WP88j6LO0fhXs1k8Fr7LZjx0QpfLQNnH+U+OQ6DQ3/1lA
 AjUjlb20HgaHOGxo0FhGcB9PL1m+Y7sKSV1E58rw1eFUddDjgUyt7qA5KpJtlmuwsVQMy5lTpmI
 ATBqOpm10+f11wYc1EPLCGvpqaGyOhoW4RVbuT8rSeKarQWnLr3ehLh6VafyEBTRzWA7dZayhqw
 CeFJW7dsPHKSc/oCJKUG4Y1EAfZIIZSu75juXxlGogmh6ZZLo5GN/Ev+Fb/x6LWW+xBHbyHDDpQ
 9u5WIcnjuZw4nF6MNHO5xNzCF+YQ47vztCqYNQRqFcat+NvAl0XsVPUb8+zuqgwRab9du4k0bT+
 TOc/0u+BZOxyUVA==
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
  - v4:
    - avoid reusing 'ptr' to fix checkpatch warning (Mat)
    - remove extra parenthesis in WARN_ON, no longer needed
---
 net/mptcp/protocol.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 486fff865803..32cf98bd2961 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -348,6 +348,16 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 }
 
+#ifdef CONFIG_DEBUG_NET
+/* MPTCP-specific: we might (indirectly) call this helper with the wrong sk */
+#undef tcp_sk
+#define tcp_sk(ptr) ({								\
+	typeof(ptr) _ptr = (ptr);						\
+	WARN_ON(_ptr->sk_protocol != IPPROTO_TCP);				\
+	container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
+})
+#endif
+
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
 
 /* the msk socket don't use the backlog, also account for the bulk

-- 
2.43.0

