Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D928173333
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969971; cv=none; b=Tetg5Mej/8D/2BhdjYabxLv9wBtXbkFWMS2kWO3FFuLqb0xCJovJFxpPT5MoWk8hRyf1eEUowv2LdcubQYKQq+nOgZ0ZBEw3eOmzBYEcem77f5bezbBZPUqwdytpBvoyte4i6vcGQRrhm76OBK0m9LtM5EeBuDaC/GTRTWeoaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969971; c=relaxed/simple;
	bh=6BcNCVZi5VEoz9Dllnt92YFkM9GvvqXSuSrVQZ7zPIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0uoiVL5USw3N/Ufr/SlDMFgwtDG4SFW/DFCEge9+36Yf7ev4OLMpWYAUMj2qi2GQTebnY+Ip1TOeKf+Bv9qrDQ7BrmyIv0q1NMzA7AcNyEFmchJ7EhcUfAqpTwQGMSmzN+qqYYWydp28TCSNqn1kdzWLfmy6XcBu0h25bUdXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UabpbXce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UabpbXce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E3C2BBFC;
	Fri, 21 Jun 2024 11:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718969970;
	bh=6BcNCVZi5VEoz9Dllnt92YFkM9GvvqXSuSrVQZ7zPIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UabpbXce4kchtXUkHsilgJDlZ6Vbh+b83kuVBzzkTdR8PyEcQl81L5Tljz3YUC4cO
	 hBgC59MfFftOdF3p0TJ3E0hPr2NxZDlnbGPljZwcXndj8QCGZE8Nl/9GKk+CSHD/+l
	 3CI4HNretI2QqfBCIQJwvgGRzGOteFH+9h3yit9Tlpcs7jnzQ33/RYS5T+qLOGGkMT
	 7skS9RTnhkphBbPrEY6/LFbd1XgaS9nw9/pPx/hE5Fkf+K79stL483/eB2tATQ+uI/
	 9CiVijYOJzvLOh4/YScgqvwsCmLnVgNfn212HabOz3sk8yR9FZOBP/fbFFC5vZh3Bx
	 Fh9ChsNt7Akwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Jun 2024 13:39:10 +0200
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: join: test both signal &
 subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-mptcp-pm-avail-v1-4-b692d5eb89b5@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
In-Reply-To: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6BcNCVZi5VEoz9Dllnt92YFkM9GvvqXSuSrVQZ7zPIQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmdWZsAEhzTVK4+iFmrC/8Zze/NgpbZCEDXsJDw
 1xY8n+1d2SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnVmbAAKCRD2t4JPQmmg
 c1cSEADTFmnJjE5ksXJ0k4RFV5Jv2WDvyu4VZvZazYX65q7UdO/EK2ptsVHuG+Ag+srGsCYndSN
 aue0T0pAvhw50imXTWOv77YAoGGEDY3XJtlMWGf+4858hpallpeztwasTsvlwmRyL700Qo36hvt
 5AtvGVII/pZ0lDSiGnh6bCI+17wv1JjJ7KbvkBX5ZKu458ZJaTQ01ZTnjSvRzCPIkZeeGmngnFA
 pUzYmrgX8EV1sbbEj/wOHZ/YHur/Tq6W3mmO4zv4E7Qnu6/9EcdY4gjXeH8WmAd9PNMYwa++jUb
 vx5zpWf8KRSgRUyCnNDrerAfBODpuYq9qZgFQEsBB/LJHAUo4S6kgklLk0TqKr4b/0XLa+eb3C6
 aVISAWLAx2eXFmZRyKJDlVmwQ0l8TPMCGmo/e4RF5NU4lG7RdliWfNjxwCjIdoiXbSi4SDQ1K6Z
 2BFqkUfAgwZW5qNYDXEyeoeP0dI75g4ss8QdfwchLPs7Po5PnSLNWYxYpMzA24vsxbxsRwYMyYL
 SZG7WC+Q4Vfve3u5o2LBwKZlPR995xzjzv+gfQNXIYhR48i9Oax7zgyBMewFlCuPtc/NP+Rjkqx
 Pckdb8cfa8GE+unKUTgSrwdtSB3AEQgTpE0h1+NBeWIabNzIT/UHSlMSuAqR4mszu5+MbpKVwCG
 8i3m8XLimHpBPuw==
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
ACK: check that no RST have been sent by the client and server.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5f5e498bbb75..b8c0b69db527 100755
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
2.43.0

