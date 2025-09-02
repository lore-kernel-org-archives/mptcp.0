Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3534DCDB
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839709; cv=none; b=clwL7BMSAHW6jU3tKVdjBLecPRZqG7WhgtqSwKLQgQB0WOu18bzeUHyNQV0Ao9mNaHPWJqBu78WmYSyFuq0ejAFMSqr6pWN7AGfdS9qmSqOePvgs6OhAzSLNOatYHxCdvPjdPzrWK+x8l/QJfjJGY3JY+IYBI6FqK10A8mjv8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839709; c=relaxed/simple;
	bh=ThIxjE5OYNtXDa4qRbMhj87Sh2pFHrO906nf6G+IexI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwN7bzxMP7gi0qJPclXrr5w/kl1JLVhkrlGj1gMivk8b80j6qXCwcN5St8uq75VmiVux7enhU/MEF2XtAtuuSD0EUyMn50S2Yp3gxPE1nsXNkYdjLwpqGVVHI8Fse/7k2IFfzul/QD5psSbx/Zct58J/+MFDCWy85WZvW0HoK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR5h9Tv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR5h9Tv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD5DC4CEF7;
	Tue,  2 Sep 2025 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839708;
	bh=ThIxjE5OYNtXDa4qRbMhj87Sh2pFHrO906nf6G+IexI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uR5h9Tv6aduuu1Scam6bSx+hEWsXVnFC+0P9g4uTnIoPIzQQI919yvK9YV3F5pdjh
	 hhOEpFPlbELm5/l/Xy/qoFUbtig+6FPW29lLv+FlkQrDX5NoNIKaY1xgN5Pp41fNrk
	 XSKlphsdAkmjeC736JQp4iZ59P72rYLHBhmVnMjsKcC9v0ed2310Tax4fyswGkrxBv
	 DD/S5Ql0U2/Ar+jp/0wxn+Wap57KSIIdAOcoCUPmhLyIaEoLxiuVCqb+yt+iFgyxgE
	 +xGygYMkayjHE60ONfrb4xc0eaVlAODYeCphFT7UHxbQPQl7JnVY2LZgqfOvGXMd/C
	 h/NdalsHPPgGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Sep 2025 21:01:38 +0200
Subject: [PATCH mptcp-next 1/3] Squash to "selftests: mptcp: remove
 add_addr_timeout settings"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-1-956a315d6a5a@kernel.org>
References: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
In-Reply-To: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ThIxjE5OYNtXDa4qRbMhj87Sh2pFHrO906nf6G+IexI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK220vUsDe/DdziwdESOSt9Xk7GN+Hq9dkC+hd7zzrUv
 td/qTeto5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJzrBn+x7nNNjgUJrzu4d23
 P3ezaXw9M6XMc1992LxrScp3d54NnMvwv9CKOeNEUN8psfuvb57hi7eUPHtsar9yku/Fjuv3P6s
 tYgMA
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

