Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB513B780
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807525; cv=none; b=hAQAcCaSPs2YB14IHS/QU26bwEGIRnDVnJN6cXJIUCWbsC9p4a1iG+xhi3dSQB2q53/93iU3rsrmhYqQSvnC6oA3+vavu9xg0KA6dBE8m/C8lAa9YoU5wRnzExF77IP0HhoaeyNuhcjQoxCvXCZgufcbmGeDaRz4y5iWtaZZ7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807525; c=relaxed/simple;
	bh=5sF13AQ0XQYTT9ojTSNuw2FASfABGqn7HXvokl2i96o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdtI/5eWGfA4sjQQRZvM64E7p+O+3b0Tfj3BPXTIrklSt2Cysd/CtmjLASS2UFuY4GFfYEsavKqdyz8RDZ7jeMFR0bNNJOlq04RdtTTwLwAhesLghzdDZMT1Au4cXbWXSTocpWjiBua7CdZOum/RTtCj3qSsfHOG+lVcT/r8RBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGSf6lII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGSf6lII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63045C4AF08;
	Mon, 27 May 2024 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807525;
	bh=5sF13AQ0XQYTT9ojTSNuw2FASfABGqn7HXvokl2i96o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RGSf6lIIGryuqOLOQg5O/5/bG3pJiSaDg/WQyJxoUHdZhKhlLmlWlL+YcMUrCAOrv
	 5ReWlJVFd+OWQhYABXbjyU0iaCJlpBo7LtDYu+lGOrWZgiYNf5OflT+B2wmc6pwwxO
	 F0kyjXp65RYYj3GZSmxbb7h+k8FZln2UiW4QW8oIRLRrI0mk6Uxo/Tues1K0aJYADx
	 vexf7ajeUEAgC0JFwvDTaRrPP+zG73ggclBkZOHow4DkuzN+PpHO597OgqaB4c03oL
	 gE1Um4/jB8EjqdAc93riQ6O9mBHSv3pE1jUdibgG5bjxg4dLS3kvDMEKGNsQCOpBT0
	 GLVhJFwbUeHOw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:28 +0200
Subject: [PATCH mptcp-next v6 1/9] selftests: net: lib: set 'i' as local
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-1-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5sF13AQ0XQYTT9ojTSNuw2FASfABGqn7HXvokl2i96o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdhapsnEiXho2pd1VqlLhcwq37iLKJrZ8p0v
 Ax+gvyqzIGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYQAKCRD2t4JPQmmg
 c9TeD/4xgAiqbmpS3STvrW+V3qOCufGhdYX7dvd2dpIdEdl86gvbMl8FJHZZP0NmrFWaBvLJl3A
 mwbArYZm3NC46jtlwof9iy6yQ1csR1KvsaIGQdDigPzi9CCLHF6gwW1ozjGm/CI1c/ZmNOAtc3s
 o1QeJyrJCwjJt8h7ZLWdSB+gCguM4TRQwwARwNhKt3eR4b5AzA3iICuXnQwy3RzYodlraMqbRIL
 nbAKj4JRzCi91GHDyrD7mBHcLY/QYCs7jDj7GPlGEe0pb2nXfTQiH8iecbr48TlVyxOQAU6qIKw
 AcuXFlXpvPVkke7FotUKzYkaLjkPV9XmtM7XfkuUuCODvDtP88AOL8UQXdkyyElXmjzJvCq599I
 XcLzAHhTZJOakXGlLsR4FlE1lFYzyyK+9s9MBfKK6xAjYLSLhUX2pkmM/RXWsfks94MFC1SCZfB
 d2MvceztYQpyFuNOEVYu0Xcu0Cev5wo9rWvSU9GXTLulOHZZrwSmZGJLagnkW08whWKcB3K7A18
 xicyi5TwyG/+echg8h11j2zQ8VxOn73753pmYnThei0UcShLgpEwoyDtV+zcTjTTe76DCt8hp0Q
 Ru9dYGA/RjBR1A8ZLal9m40hQkKHlHuEFGpr8OGdXQwwU+dB2hJtIK8x+7EhOd88ha5+SBNvKGT
 IoDiUwc3CBLMNiA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without this, the 'i' variable declared before could be overridden by
accident, e.g.

  for i in "${@}"; do
      __ksft_status_merge "${i}"  ## 'i' has been modified
      foo "${i}"                  ## using 'i' with an unexpected value
  done

After a quick look, it looks like 'i' is currently not used after having
been modified in __ksft_status_merge(), but still, better be safe than
sorry. I saw this while modifying the same file, not because I suspected
an issue somewhere.

Fixes: 596c8819cb78 ("selftests: forwarding: Have RET track kselftest framework constants")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index edc030e81a46..be80f7b1f9d7 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -27,6 +27,7 @@ __ksft_status_merge()
 	local -A weights
 	local weight=0
 
+	local i
 	for i in "$@"; do
 		weights[$i]=$((weight++))
 	done

-- 
2.43.0

