Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148E1FE471
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087979; cv=none; b=f50+AWO8XQUBguJDzMaw+R+v1yQW2RnwQJ7b2qZd/1IMEGo3I/p3+USAT4k4rBnKuHluObKPz0/8Ju9bRwloPAtrvIEvWCuXXLc3NlbhSKjn1r0JTBWveafOvvMjkjZkmU8KPazPzpkwWyT0LXDf0AWACBBZOTabjVuxbLbfcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087979; c=relaxed/simple;
	bh=HipJrqHq24SCCyVfi6a1v0iUFY+Inc2jmVllzWiZahg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDnjQJ9iWehXoh5oVAP9EI6NyILHNUkcfV6egpHPWzJrp/5/adXSFomJYvILFK+u2VHmAiW4iky7ul2IcclWOJ1rBAVLlaGfL74SMgG2f+RgnVE1wtGzXy9SNkyBw8Kw3lXTTW6EJkHG3f20L5KccdDxOfSIXnCFcjae42eLjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htnKMh9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htnKMh9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01C1C4CEEB;
	Tue,  4 Mar 2025 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741087978;
	bh=HipJrqHq24SCCyVfi6a1v0iUFY+Inc2jmVllzWiZahg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=htnKMh9/MgU7EE016/kPVz7dF1q6ebARh2O0+cKaYjWb37FCoKs3lXt950nQOND1q
	 yr8d228+t4B/jV1LzKVB5N8xfAqGx3k6PmD4b3itO9m19MGBzKyI/SHp7Kb9gGenNX
	 Es+RNi/HHj7ubac6BEarv4Zwn2P6TZn1fdfnidypVgUGQtl7r2fiPNbzZTza29OfY5
	 5vdFslB9B2POl3ll+lMVxd2k2Y1tGajpEb3LDdDkXex5D82mrpmMUJ1/WjxjveGzXh
	 fW0pQDJ5iGN2mVWCOxs62JGTR+6LGlwdfS0j/rhM7PQh9YRbzZ2FDdw6YhrfIuPVuK
	 Bl2tnRSFGFHZw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 04 Mar 2025 12:32:50 +0100
Subject: [PATCH mptcp-net 1/2] mptcp: sockopt: fix getting IPV6_V6ONLY
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-mptcp-sockopt-missing-get-v1-1-6d306d0384be@kernel.org>
References: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
In-Reply-To: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HipJrqHq24SCCyVfi6a1v0iUFY+Inc2jmVllzWiZahg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnxuTo0t5V+GaL9h27uKsExBWbQKWaZyOf0bWp5
 lYv2egfV8yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8bk6AAKCRD2t4JPQmmg
 c7RjEADtoMowI4uuohr3PjinR8PCugIwP5SeC6hAUzkf/VL2t7sVffn6oyoDz/ecIBEVLYDmI4Q
 zkHCmHlO23BQ4CgJs+w06LbyNi5QKcktklSu4VT0paTJlbVXfTJ5eZ7x48s6Rf+s2CaritOU68R
 aCCpx8kDmvrZFYtiW9965DU0XxAPLXwIwd8ynZnQ0z5tfES1g2dxVbjHMrqdXVxPBH+TYbVjNHH
 Uen13BiwD2Fh6iLZJNQ/bPpIL37vBZ+DHkjtjTp0btfVoZjADN1u4SgTKhBKL+wIiyb7cwCPPi7
 OYB2jlN9fbZp5sqnzsyBLlB/ApeNqpiCPU4wQdtbQppSwyYQsTDJ9f35ROLcQaYCwDG1zc9SIpi
 gnr7AfuUiaCfrAwk4WxkGCy676lGbX08s/cYSJiOjzho3XG+JcLqlI9CSbUDVMDkm0BOde1/9Ix
 StMcuuseMJGFghNQOeXPFt74qdnB715yMM57f13tsqmeVcnd8ECSMaL3FXL3a7nct7t7VMBvIUv
 4sJ03D53USH93+wNvBtpIfO2JZZqrDFGgV2X/gA97BOeTWZbqhhO+lN/QP/V0AEiipCjMlkn0Wo
 XMkDWSkiZSx3KBCA172c1pG1RbH3Dr+woiHP4XARXbQVKPN6nvOY4gyFJB6zSL8OaOYgK/yuCTm
 xCvPgNawQAdHfMw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When adding a socket option support in MPTCP, both the get and set parts
are supposed to be implemented.

IPV6_V6ONLY support for the setsockopt part has been added a while ago,
but it looks like the get part got forgotten. It should have been
present as a way to verify a setting has been set as expected, and not
to act differently from TCP or any other socket types.

Not supporting this getsockopt(IPV6_V6ONLY) blocks some apps which want
to check the default value, before doing extra actions. On Linux, the
default value is 0, but this can be changed with the net.ipv6.bindv6only
sysctl knob. On Windows, it is set to 1 by default. So supporting the
get part, like for all other socket options, is important.

Everything was in place to expose it, just the last step was missing.
Only new code is added to cover this specific getsockopt(), that seems
safe.

Fixes: c9b95a135987 ("mptcp: support IPV6_V6ONLY setsockopt")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/550
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 505445a9598fafa1cde6d8f4a1a8635c3e778051..4b99eb796855e4578d14df90f9d1cc3f1cd5b8c7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1430,6 +1430,20 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (void *)msk;
+
+	switch (optname) {
+	case IPV6_V6ONLY:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    sk->sk_ipv6only);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 				      char __user *optval, int __user *optlen)
 {
@@ -1469,6 +1483,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_IP)
 		return mptcp_getsockopt_v4(msk, optname, optval, option);
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	if (level == SOL_MPTCP)

-- 
2.47.1

