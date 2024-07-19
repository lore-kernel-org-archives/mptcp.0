Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD483CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391882; cv=none; b=QP8+VeA6ztslfhFB8XYVonAwY1b0nOqLSq/qdgMgZW78dtzSzM6VctyNGsUavhrG36/rFTpnSscMpM3rPP2uaZGOMzcGwMRu87lfJlynaAN5WwHGBBanVF0p397sdYHtOyjocXzSCE8tMcntqp/qq3N+G2oMqYKx6PVG2gb2QEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391882; c=relaxed/simple;
	bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKp1Nu0V3XVi1u62OzVfXftblhgTpFLK2dnxr8EV9ZxoTeKGEOmKOnAVBiTNLkXhCQysr49waVp7Gh227DvGAe/OKubeOQxv7eiVzux8U3LSGwNRP8gD+XyO9DhQ1Pk9/rBn8ysskCRZkxOTY2UI0CfJfqPw8FNWuQDIUSw2kSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amtOf2N1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amtOf2N1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0AEC4AF0D;
	Fri, 19 Jul 2024 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391882;
	bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=amtOf2N1n4v3R0QFFiaUDI3Obr4AbrhTpTXyDZJZlu+rweawkYedBIv7bISDwEn24
	 IpfAOdwosfdAAy8YKTNmK4MbDw/ysYz+BklNaryZICuykINI7yPHV6uax0ts+ni0v7
	 PSzVvicifjU9IuknhqWfr+xTQ3ERj98huWWSm+oLZM/wQUZNvZEomwspEKqtXGalfl
	 IogVpTaOYA6qYZ731UVOT5+PYXSCq0bVuP2VHE32gf+tO27oYhZCFE821JwsBo+y6B
	 1NNwX/J3Wrg3sQ8WqwkHsKmaCRUcpLlLtkc0TQ32s1pwyyjglMN9bBMlQONUh0ncE4
	 O90r62APjhmMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:18 +0200
Subject: [PATCH mptcp-net v3 07/20] selftests: mptcp: join: test both
 signal & subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-7-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/BgpdpFyEDjBa6nz2BH7hCRFkr1rqOG+W+
 zH4M18SBTaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c5WMD/90aE5dS1f2CstS6t15NE4F3tKrzFWKqjWrK01PFOpyscqIoLY46kwNNfnCvkUCudGc6vp
 3Iupzbsk8CUffxGBKYHELdCQruD4rLUujQdwrnRyTR3WxMhLQB4G8vyzp3a65s+ISTNRimWic52
 gxCdyWyULT/HxKuLqa2jFpEBziB50sJqFjpxDWyox+YcZ1UE1DH22o6Jt41GeV73QPXc6Am/s0m
 fK1x3sd7DaPBWGi5Zw2D7Y4Pmi74+kQf+E3l/39tSRjK9PX3vL7S63gw8bnLVNJTiO0Vk9WZTft
 5B51CY0RKOkVSI+26hSRNrwx7V7FxO6dop9Kw22T5+y3xue5elIR39QqwEf42WtOfP/Bd3HEq2v
 NgdDlPFyZV/qqJHEamp4kzlgpBQcY2t5FbggJCLEevd8s7kZEKBbn36tXeX/CzpKdCyVdtOyjnR
 HWa3TIcyMmDJquZwQqmumxTN+3e9ymHgA6ZqcDcxxCypQcXOAGPTjA4o7gkKpQYEz64GoLe69LV
 ipWhqKwrtxTr1jclQN71eIRpBB/KhukhA1hQRVgvtJaUx0m/nbB3T+k7Q4Kipk8RM1JVFBxPDaq
 onwW8rMAwYDi8+Ql4MqKP7PzNH6/iAOlllFSE/tJ5v6GaTNg3ea3JmlJ1VTNVfCAhaNPScu/uLv
 v5Vpy7CCPGR6/Gg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It should be quite uncommon to set both the subflow and the signal
flags: the initiator of the connection is typically the one creating new
subflows, not the other peer, then no need to announce additional local
addresses, and use it to create subflows.

But some people might be confused about the flags, and set both "just to
be sure at least the right one is set". To verify the previous fix, and
avoid future regressions, this specific case is now validated: the
client announces a new address, and initiates a new subflow from the
same address.

While working on this, another bug has been noticed, where the client
reset the new subflow because an ADD_ADDR echo got received as the 3rd
ACK: this new test also explicitly checks that no RST have been sent by
the client and server.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55ccc4fdf18a..d25ac561e050 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1967,6 +1967,21 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 0 invert  # only initiated by ns2
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3

-- 
2.45.2

