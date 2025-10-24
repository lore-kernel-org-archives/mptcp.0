Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD43081CA
	for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301029; cv=none; b=GKFOFRyR/ywQapUMMuUmFhFLPLGMEWaJDJPdX9LZTaf/TSnDc1B3DZGDYVbXqmoRQtm/upU0kt6klHmZDJwah3SPAbKLozJxHynvjJ3f2VT8gzFxFZ11l/T5qPLtlYvA4pKDucuPrU4ZOAMBIJM+EkrKsOoIvXVWXpvcBqgeKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301029; c=relaxed/simple;
	bh=8HdAnWOjKycVQtnQ48xxq7QU0aPGRMGjwMXASjwal2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l/S0JqvBZ7S4CaanXXIi6u4lmgSmGSh8fWbVIuIEfxbeVPAO2ZgOnUXKDXFt1MikjVwSICLl29L4T4GnnyeLF83VCumecH9zxZa9uqixG6MRx5H580Cdb8Q0PO3kWybhycqcPurB1aZN4fODvmYoi2aX51AOVAJBd8mexW5YDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1OkbwQA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1OkbwQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A59C4CEF1;
	Fri, 24 Oct 2025 10:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301028;
	bh=8HdAnWOjKycVQtnQ48xxq7QU0aPGRMGjwMXASjwal2g=;
	h=From:Date:Subject:To:Cc:From;
	b=T1OkbwQAuvKZUwn2IXsGQc3PxlatUSnQJ6xdZUjE5fWLObkpwyjAzZUb0Z0LJJnMP
	 hz5duenClQD+CjGCDMtfvHHWbGRoaT0LXzZbsmpE4Q4N+srNnHMQkJg2dyw8g609Up
	 0Zd4HVm056+VBqfWN8F2Zw89+e1sg8jEK3ttATMKSW9UjHkSKdNlmGGzkgVdiuxZvQ
	 npHMYnMKQMiG/mcy0MrW2+mN0PEMc9WfwIKNItvhjeXS+4sCcqoaPtaGv1JlpOugd1
	 q4i+w2cN58sMWVUazNRywri54cFaY6PlDTKTe4VyBCaJWF8tOP6a6qWWr6E+DbhFSh
	 ihGCLNP4CB/5w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 Oct 2025 12:02:11 +0200
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: join: validate
 extra bind cases"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKJO+2gC/x2MQQqAIBAAvxJ7bsEkEfpKdDDdag+Z6BZB9Pek4
 8DMPFAoMxUYmgcyXVz4iBW6tgG/ubgScqgMWmnTKd1jWQQXvnHmGFB4p+MUtGR9b50JRjmoacp
 UnX87wp7EJ4x0C0zv+wFa0sUfcgAAAA==
X-Change-ID: 20251024-sft-fix-bind-timeout-7e7c47a5d50a
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8HdAnWOjKycVQtnQ48xxq7QU0aPGRMGjwMXASjwal2g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ+Bym/jnW7aqR+dca/CU+M841cshcxpkSu/MS1ZFuV4
 rI7P1tmdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkYi3DT8YHiesk/1VdN2W/
 KBOw45JMz+QP71nco5Of5gq7FestqWNkeMqwvvAhxw1Ds6Yz11yk3FdxPLj5csnXFGaRlPO3e30
 PsAAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

I was going to send the related commit upstream, but then I realised in
a slow environment (e.g. public CI), with a debug kernel, the default
10 seconds timeout can be too short:

  086 multiple bind to allow joins v4
        join Rx                             [ OK ]
        join Tx                             [ OK ]
  main_loop_s: timed out
        add addr rx                         [ OK ]
        add addr echo rx                    [ OK ]
  ./mptcp_join.sh: line 3305: kill: (2032) - No such process

This doesn't affect the results, because it happens after the test, when
checking the counters. Still, better to fix that by using an infinite
timeout: the process will be killed at the end.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 05faacefb719..e0cdb9c662aa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3293,7 +3293,7 @@ bind_tests()
 
 		# Launching another app listening on a different address
 		# Note: it could be a totally different app, e.g. nc, socat, ...
-		ip netns exec ${ns1} ./mptcp_connect -l -p "$(get_port)" \
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
 			-s MPTCP 10.0.2.1 &
 		extra_bind=$!
 
@@ -3315,7 +3315,7 @@ bind_tests()
 
 		# Launching another app listening on a different address
 		# Note: it could be a totally different app, e.g. nc, socat, ...
-		ip netns exec ${ns1} ./mptcp_connect -l -p "$(get_port)" \
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
 			-s MPTCP dead:beef:2::1 &
 		extra_bind=$!
 
@@ -3340,7 +3340,7 @@ bind_tests()
 
 		wait_ll_ready $ns1 # to be able to bind
 		wait_ll_ready $ns2 # also needed to bind on the client side
-		ip netns exec ${ns1} ./mptcp_connect -l -p "$(get_port)" \
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
 			-s MPTCP "${ns1ll2}%ns1eth2" &
 		extra_bind=$!
 
@@ -3371,7 +3371,7 @@ bind_tests()
 
 		wait_ll_ready $ns1 # to be able to bind
 		wait_ll_ready $ns2 # also needed to bind on the client side
-		ip netns exec ${ns1} ./mptcp_connect -l -p "$(get_port)" \
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
 			-s MPTCP "${ns1ll2}%ns1eth2" &
 		extra_bind=$!
 

---
base-commit: 6354d0b328258d1974cc7d32a82983b2bd3e5871
change-id: 20251024-sft-fix-bind-timeout-7e7c47a5d50a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

