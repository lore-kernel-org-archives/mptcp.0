Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6952125DC
	for <mptcp@lists.linux.dev>; Sat, 25 May 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716642139; cv=none; b=jcM/zmjww2JDmN9DSw2Kwsg0/4+SNk9EuFDDDQIWWp+6fe8/3G/Ff/mQvbvfyf76o0MMIgmjFPT5sz+97l1ii8Iws1EdCZEuHgP+CtaI//4mLeMNHqlQ9lfFqngMerRUPkjmrTXvstOpG37kzT2Gq6j9rzu21IOaEv2mfhFUA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716642139; c=relaxed/simple;
	bh=cpJhF0tfkdsbMA3a9h27E9ZvdIgKuVwPsv3RdLP16vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjY/GTOjsGFsLSKeotuVxUbUGEgqe3hm0jrFGtT3abFxHazVPNEsScpe8OJ4S7wpsE2B7usPc6aD9AQhj+lax4I+tn2CM9gRKtB1fHsBukuYs8xa4A3AqHl6cH0vgxuat+Ee8f+UUlLdOra6qlv9QcC5yatDAMqOWZZ8BW711lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK2V/zlD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK2V/zlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4D7C3277B;
	Sat, 25 May 2024 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716642139;
	bh=cpJhF0tfkdsbMA3a9h27E9ZvdIgKuVwPsv3RdLP16vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YK2V/zlDIMrw+670JqCyijRc+fGV7X3yCNU3peU9xOcjXmnR6oHZdG6YlmjDxuCfg
	 C2Lrl/gyaXVDXC2XoFgYRrKFjEHdahHbHEzC+q1z+5PvTVqf6Lh4ZSPxbDMEBQ/E9a
	 HBpk6aRoLIdzUBjwdJbenKdj0i83QrMmajLIsloSs4IK3RRZkZaMOJjtJ/glaAv1tR
	 KanZBksXNu6STePL7MNGGZd125Zljrj/6Xu2UJ5APvnOMFycfRkDnl3RlKE76gjtuj
	 lqgsyOP5USH5pY0vBBFt0RThI6l03mfxB3sWwmzEYOUAWvBJjK9LPJt52wphjcpJPT
	 h677MA2UEYaMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: diag: add ns name empty check in cleanup
Date: Sat, 25 May 2024 21:01:24 +0800
Message-ID: <eb0532a18d2d520268dc2ba0f1e414b25aaafb04.1716641976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716641976.git.tanggeliang@kylinos.cn>
References: <cover.1716641976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_lib_ns_init may fail sometimes, then ns isn't setup correctly. In
that case, cleanup is invoked, and ns is used in cleanup. So an "Invalid
netns name ''" error occurs.

For example, these errors occur when invalid name is set to setup_ns:

    Failed to setup namespace 'ns_temp': invalid name
    Invalid netns name ""

The patch adds an ns name empty check before using it in cleanup.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 776d43a6922d..7ee43c35e0e9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -31,6 +31,7 @@ flush_pids()
 #shellcheck disable=SC2317
 cleanup()
 {
+	[ -n "${ns}" ] &&
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
 	mptcp_lib_ns_exit "${ns}"
-- 
2.43.0

