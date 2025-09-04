Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0C2E8B86
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985902; cv=none; b=QwUX3rxTZAnfAtcZWOvXS1b+YPSbEh9RpwrW2gxoLMX8S1xXslM3SuOvdDshmkuYaOyOA1tRyCh+J/Arqih+9L+aZnGupiYsQt6wy/dSY8l49jOWF+5y5yaddtbkfFNYA+73GxWoNtovnXGYDk+oIIsxI4mYhaQ/YHT2NeNucII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985902; c=relaxed/simple;
	bh=ArtvU1t7K7AJUEhR3CP/UahXLbgwR5qQaKZcIKI0RjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fl4Lz4lqjpT+zhLF3FB+CHdEUpmMi6+jArZs/9LEg0zI3LNDfKML6Rd/uMohJuOQdyyBFGRA87RLmZdEGl/gfGrNdEOHEpkfNZYNURQmLjMiE5U1anafYGg5nwQbmK5H4Y15LC6VpoDrca1sZUbfkqyWTsPnFoa2NDcDbZnTq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2+GsidJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2+GsidJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDF1C4CEF0;
	Thu,  4 Sep 2025 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985901;
	bh=ArtvU1t7K7AJUEhR3CP/UahXLbgwR5qQaKZcIKI0RjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k2+GsidJa51P76AkqXcxkT0Eo2gFPqf+9VHYc3/SnpFCBw2efhDzYw6s3g2E43hYG
	 o7LJ3+hRjhVVeAIB7z3m06uBBrK9ZF+MRK4W4XaCaOfTIsPC/P3W0Qt+a4NdsGonNE
	 fafR0hxrnR6HjfVr3lRqn6PzQvs6NqTbSpCSk+cZD7Xv2gUmfVN6U9Db2O7htr+YtQ
	 QmXWHtt4M13fCc5FcDVu3dtRIfYNok+ChDg8PhCJbB7ANwif/iggsHL4sfcrG4YXpj
	 TDsSAM0wCWCy0zGJ6uiLQSZThKr1HHP94kHTUSvO+HekcDvbsCOmDMRaCBgQPH+75h
	 eI/NBXBCb+mIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 04 Sep 2025 13:38:05 +0200
Subject: [PATCH mptcp-next v2 1/3] Squash to "selftests: mptcp: remove
 add_addr_timeout settings"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-1-a019e6678628@kernel.org>
References: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
In-Reply-To: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ArtvU1t7K7AJUEhR3CP/UahXLbgwR5qQaKZcIKI0RjA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2Vmls+C9evXlKytWpc07Y9pkd9Frtc01w4T12LZUPT
 wWztr3O7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI3KuMDPsnT/JJCL+4dqHh
 Yn1Zb7cXx1pvrZxq774+7+eK55/nPG9jZPhz/zfTtNv/96S3CNy5++UY84p91ROm/pz01V3j/8n
 aIhleAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This reverts the patch: when add_addr_timeout is set to 1, chk_add_nr()
and chk_add_tx_nr() are more tolerant with retransmissions, see commit
6ef84b1517e0 ("selftests: mptcp: more robust signal race test").

But the main reason is that this revert breaks the selftests running on
old kernels.

It is then important to keep this. Plus it still acts as a maximum, just
in case everything is very slow, we still have retransmissions in time,
especially with the new exponential backoff.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a97b568104bc284f050b2f0e09fe3fdd3341c5cb..2f046167a0b6cc6fb5531a033d8d95c9ea399cf9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -358,6 +358,8 @@ reset_with_add_addr_timeout()
 		tables="${ip6tables}"
 	fi
 
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+
 	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
 			-m tcp --tcp-option 30 \
 			-m bpf --bytecode \
@@ -2303,6 +2305,7 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 
 		# the peer could possibly miss some addr notification, allow retransmission
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 

-- 
2.51.0

