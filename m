Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCB42189E
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262911; cv=none; b=K4oGNy5At3/w/9HCw8TJZxylAU20GZIWTMZ8Yh0dWM54gDaXuigcO2cE8vA2fC3mknqojJcR8mvTqoaxUVV1IwE+5aoWx9fWLx86YZXT+/CTv+En7EqgDmt6ywfkcx6m0N9x44MDKxY5Tv3ijrnxH+KMCNWLtGSvNB+355tvAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262911; c=relaxed/simple;
	bh=VYcmXdByBKvDg9K5rNS7iOEkOgkYFmXKRr9tSZVepZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/5zttChReVDkSZt+TTk0Hnior2SsVp6AJlnsE+acTi5aJO1mePi2SjNIy2LGMy+6hqxTa6gN3aIlQMQQ/jrrrfjfyuRi14dFfn+9LhVmCNXuQ2y8GKX0icjqRy46dRLd6bkkGRzpAYLf73zLvlIbk1B5EGX6mzT9C+GToDJsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co0NcfzM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co0NcfzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD44C2BCC9;
	Fri,  8 May 2026 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262910;
	bh=VYcmXdByBKvDg9K5rNS7iOEkOgkYFmXKRr9tSZVepZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Co0NcfzM1u4ChufZg27pJrj1dcmM/rjz6W6GgC1GZUWXVDmS9u4hIontw6G/cqJd3
	 +2sWpblwwwb9avafzsE4AJmzVKDKrqUbT0ofJStCoJbcg4XYr1XNo8LXzpG7GK+Prr
	 aKRbODUIPL09WvtQFvA0bkaagSnsaLU1zwKlcofXNQk6Zb2dKlqdpBgg3vChSedN8/
	 TewcduZH/mg5sNd+jmb+3dFJzIx0DG4iI2jMjnG3m/G/A80g983SDX9YaqWiF+XfbB
	 fQuKox8kkdbeaTdQ3iwCVZuHg5vUE08YDaCf4E7yU6VqcYo8Oq8UkdsDLoqdZsRFjV
	 3bnttxon6h14g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 19:54:57 +0200
Subject: [PATCH mptcp-net 3/3] selftests: mptcp: simult_flows: disable
 'flaky' mark
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mptcp-sft-sflows-bufferbloat-v1-3-e9b0d25d9789@kernel.org>
References: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
In-Reply-To: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VYcmXdByBKvDg9K5rNS7iOEkOgkYFmXKRr9tSZVepZs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KVeX7sqNUPZL4rzX0vW1S7NYN4TP70JC3VWv3znNf
 W3HFC52lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATGR2DCPDUsMzgmwHd5+Mz7tl
 vPZwS+Jjlm3ZWXxciglsDV/CXQ0zGRnmzqiIuTn33E7PxR+2bl2/aXmq+sw/FU8fV3t/tt2bo67
 HBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks to recent commits removing high bufferbloat in this case, the
"unbalanced bwidth" subtest has a more stable transfer.

Thanks to that, it looks like the test is no longer flaky (hopefully).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: for -next.
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 7b9aabe10170..acb2f3983881 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -307,7 +307,7 @@ run_test 10 10 0 0  20 20 "balanced bwidth"
 run_test 10 10 1 25 20 50 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0  30 20 "unbalanced bwidth"
+run_test 10 3 0 0  30 20 "unbalanced bwidth"
 run_test 10 3 1 25 40 30 "unbalanced bwidth with unbalanced delay"
 run_test 10 3 25 1 50 30 "unbalanced bwidth with opposed, unbalanced delay"
 

-- 
2.53.0

