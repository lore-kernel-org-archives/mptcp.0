Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B33D0916;
	Wed, 27 May 2026 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883924; cv=none; b=hS0++RUQBMnRit2TiMhgXew9Qu6AXA7gWiOP/NziQA7P+KoVlkysh+aw8L1iDq0ECM5i4dHMrtPTE0ohn9bgTaXBOE1MIMI5IdzO0OsaDQSzkUeSiFiriaD8TIqpD8CK3y2a5QPaYbNnWVV3YA9I5YaJRl8pzH6vOT+lqxLOFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883924; c=relaxed/simple;
	bh=vsTntsTjWJE4HuMZwz55v9CiJmNGj8blvpyMNjyg0ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxJzOLqD7hcVOnpxGZz4qDwvnKlCncwLV6REJc/U4+cQ4fP/wosISCgEYfs3s115Osz4cXXh7/JZYqd1hYc80rOzN57vDThcRQoWBO1/sR4m8VId77f9i5oZLmxo2UooZKmgsoN6NUAV2Se44Fm//1K+gt/wbYCp62MQlkEmMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOWBMXYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOWBMXYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8409E1F000E9;
	Wed, 27 May 2026 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883923;
	bh=AYVtaiqiIIDwyxFkeevLwHzRNA/ebS1U0PQqYPct23I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TOWBMXYrcfMHoaIgNw61uoZ1po+MFhmKiHArv6erxu0yNh0YHx96XscYwfB5MuVzv
	 bK8x0jYbbt733kh1X6IyukqviaMYlDSOQx7tftJYTjYm8Ut3057BifPkPZzVsvPxqE
	 sRv4FUfhTpfMlEMqh0a7SwJlCoMKRy96Epph3nErX/ocjOiXrrlbDm/EhrSk+hhUuv
	 DsmW7h9WWXphDd24LPmvBmGuyZPWn5ynYY4jG7uBIyhO4unMs+30DRyxl57h9fAM3x
	 L+CkKDr7hP3LLykcubazRVJCC7SDkWJwnomO5eDoG5Ae6Gcn1EoATSLW/9hqVtM1pX
	 HTCh6zysfJWTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 27 May 2026 22:11:36 +1000
Subject: [PATCH net 3/3] selftests: mptcp: sockopt: set EXIT trap earlier
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-net-mptcp-sft-bufferbloat-exit-v1-3-9afc4e742090@kernel.org>
References: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
In-Reply-To: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MK44442Y4GoOT8uW9O86ZnxBnXXBd/Ke3NWWnIJImtc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqFt99E/qu5U1ifj1gprAjbginxvFREUDz3f3hK
 78XyL3AhOqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahbffQAKCRD2t4JPQmmg
 czKtEADEFBgMs6FTGTPNpqwoO7jrUilBjcXIcShBesy30XjmfeZb+CbXr523TguNfXPiwfn2tr1
 nxrnUzWvV6PRCu4Ck0yOuJqYuTjo5YJjVXT1zelud76GTyhWXTigyxzCR/+MGczrP58Zm69os1v
 Cur4zl/JHoicVTwsKFO5mCobRilG5V9YV65guS2+bWH9NSNzM4THeCUicTB2so1ygkuHB5IxJ5h
 TWfUpGuN175V3rtNO25NBzmz6eYxKRrbaLetLfzUWEXZCF/r6jNqez8cfPCKR8O0T5MirWrDnvW
 MsoQarIil5HoxeC/FQe3rFn+8U756wccGDevkNmMuaskFX8T41KrLZkDP2jlNahM3frB8CrV3Wo
 srblLyu+nWpYQvvc1Kt5vS0ZhMTx8Ua47q74WpcWcsgPeWZ6bqAlJWip2nPTFf0lCFGRL8gXwTD
 +XUiT6iz207wSP48w/s2BRkzjn3bD2t2s4TL4j8wUyZ9kx6/rB+ZYU/6UNdzUgru8HDstlV66iA
 grmeggt4etcOaQHbe3lGzWs7gGIBGjiEO3HNisYkNt5pBdOPRHz2lO5U+tgxm8WxPTMlBEY9b0A
 dMFt6ccG8TUsfujXegmfWhcGkeJptr+hy9jLUgujqI/NMytUwJ6Pi0yiuhq6qd9uWSybwn4wqdZ
 E+tgo2CiTqypcFQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Set the EXIT trap for cleanup immediately after creating temporary file
variables, before init and make_file, to ensure cleanup runs on any
failure or interruption during the early setup phase.

Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ab8bce06b262..e850a87429b6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -355,10 +355,10 @@ sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
 cout=$(mktemp)
+trap cleanup EXIT
 init
 make_file "$cin" "client" 1
 make_file "$sin" "server" 1
-trap cleanup EXIT
 mptcp_lib_subtests_last_ts_reset
 
 run_tests $ns1 $ns2 10.0.1.1

-- 
2.53.0

