Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178A86AC5
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715357; cv=none; b=bRF8w9BHHN1fcx+nZsg5fzeA+lEuYShsg32jr5MdQ81p9JZGEjF0sQR86oklJFKut03Vdd17TiwZtzBgJtz8BwCbWi2KJWjU7RZVbmI6JjUY3fZMX0JkdFE7OgPj45SNDmVx2QCjacW6RqVYibf1nDwElhbC5GAXCNSgDMknvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715357; c=relaxed/simple;
	bh=jO3nEk/mlPbUpANvlwS02TdVsHCXvCZH7qgFx4ceosY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s864dIY5gLFbBm4yt+yDHxNi80UOonKByOGySrYueHNaPccJ++iakVRZCC5T5zJcyu3X36WxoeeI77lQGrhtuUWcTm+IwWTuYv3Vpq4mtTeyjt1sT1QoXUW/OOxqzt2mNiDF9QGDnom9QrHGh/uwGsSPo/V/AmHATAoTM5Nk5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHhe+BNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHhe+BNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1BEC43390;
	Wed, 31 Jan 2024 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715356;
	bh=jO3nEk/mlPbUpANvlwS02TdVsHCXvCZH7qgFx4ceosY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eHhe+BNREhvQkW2G0wYIUFYrgfA2HpGUW9nwinLI+ZwNIX2WPfae2aINlb/WshikO
	 QscEAamygFdvharhuabwJvCihPHr3nh/iLnyjJ0+F2UsCuJqeDb55G4uoiMttOmmcX
	 9lmjt84cPGvSXOvUbT7SOqvQcWRJ634VWb3fxwsCbPlPVC+oKEsL8Iztkin+qOvFD5
	 MfHkPQZHanhKvuzc1+yvQF+268yK2Qws7DBVwZLisKLjR9cdR6RZ/TYxA3OGn1qp+n
	 UocLwJ2vs0eXNQqXq76k8Z1Xqgh1/m9Ppm9HUKup+3eFVTOv/HRQQwiXRIUX37v3K2
	 xsCkkyyRMqjJg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 16:35:51 +0100
Subject: [PATCH mptcp-next 2/3] tcp: check the protocol with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-mptcp-check-protocol-v1-2-a06067f0bd08@kernel.org>
References: <20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org>
In-Reply-To: <20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jO3nEk/mlPbUpANvlwS02TdVsHCXvCZH7qgFx4ceosY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlumjZsgcSgNv1iz9oUDgQkUNaxbJtLURRmrm3K
 KuBYE6lJbiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbpo2QAKCRD2t4JPQmmg
 c/pHD/479Jfcm2MyQWgIysoehLQ3bgvxGPmq/yLFIL2mUfz4H7rNUeK+Cix9N6f+f72LgZTp+Cz
 vIXen6E9xzED2lqN9vPp3WQzMuyZQ45asu+TuZiS1XwqEVH/9H6naEOrq1k3ZzZooscGnv1zogo
 +d2aBbmKNgrLJxok389IAJDDkQvk6ZFWzaF/+BcKz0oSwAA1IeDISmhzttOhIlCSGDLNb29qpCm
 mIZiFy+wmqyyvjc4djnKW0ODU/f74IVpt2m03uHzMAN2ooB+YjMnzYgVDmk+RPmJK/p+4wvJtt2
 o3eoBL0YFvPGkD3KXVi3rjIgUPDT8pbELBymquHEm/B7JAdFDzuBUdCC506IA0DSv8VYcQm5R5d
 hZyGLTorKlPdy6+LIGJ2ExAjfBXVYpwVLMNhAMBzF881GdNvr4voYjU4V4v9+oQZQsssxx+XGE/
 Mh0OxYP44kC02u6MApN+Uf2KXEICMmXPx0nvN0/kNwrScR0dE1SjyVuLBpVjP8/NJbe9NZyd8YM
 /NdfBuFNb1zYcYWLSIKBpmR4X+LpEOTay5o+7WAjGePI6uW+IBIdUxglgnI7EFEqyF4vpc6hF9i
 CJkLT+hGFQylL2LbEy0PgzZlCB3IbHmtmjNyV4hS0kMZRypHmkzhYZx45pifcg61Vmk9Q08RAL2
 7/g9SyESdEdlrug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when tcp_sk() is used with
a non tcp_sock structure.

This kind of mistake already happened a few times with MPTCP, when
wrongly using TCP-specific helpers with mptcp_sock pointers. On the
other hand, there are many 'tcp_xxx()' helpers that are taking a 'struct
sock' as arguments, and some of them are only looking at fields from
'struct sock', and nothing from 'struct tcp_sock'. It is then tempting
to use them with a 'struct mptcp_sock'.

So a new simple check is done when CONFIG_DEBUG_NET is enabled. tcp_sk()
is then used as an inlined function, like before commit e9d9da91548b
("tcp: preserve const qualifier in tcp_sk()").

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/linux/tcp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 89b290d8c8dc..11413d0e3c1c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -525,7 +525,16 @@ enum tsq_flags {
 	TCPF_ACK_DEFERRED		= BIT(TCP_ACK_DEFERRED),
 };
 
+#ifdef CONFIG_DEBUG_NET
+static inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	WARN_ON(sk->sk_protocol != IPPROTO_TCP);
+
+	return (struct tcp_sock *)sk;
+}
+#else
 #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk)
+#endif
 
 /* Variant of tcp_sk() upgrading a const sock to a read/write tcp socket.
  * Used in context of (lockless) tcp listeners.

-- 
2.43.0

