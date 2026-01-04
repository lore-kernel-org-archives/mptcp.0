Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDF2D5A16
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767504603; cv=none; b=Sn0wp0p7+0QyQynZsXCsv5QLsK5+seflv6uPXWGnMeOtLUv11d0dlkDVamznG3dHGZleGiGe1X8eNejWvh59USwTkmGZeRN/XHifv2Vynbc6aezmL9Ok7+UtpfB4z4nlHy7r1/mAh3YD+CofUqEzB1icAmkjDlUU5a0qGlU4kuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767504603; c=relaxed/simple;
	bh=5e+wGjokdw9lf/RAoaGCcvmbjc2NWW1OltWOGet5qj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soajv+9g95JhiaNq1hryAnjwr7OrhHb5Vf0ygdLgZOzrjlQoDFWkxDHaf52o0ddBdZhQaSC41ihMfGdQW0JZycHJE+00Fg5w3jknrDSZEdVcvxhUKUaIEZAdZ3zhhJJJHgHeMgEc3W32TCjBX1oi/zpAKgXCIcqwjGWAJgEjlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuuozCSu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuuozCSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AC2C4CEF7;
	Sun,  4 Jan 2026 05:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767504601;
	bh=5e+wGjokdw9lf/RAoaGCcvmbjc2NWW1OltWOGet5qj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QuuozCSunSk+i9+ZidHEZTjbDkiBOx9JmH/jUrzMjTwGlaTxWAs0C5vQ9M0AMF9/h
	 h3DH1cilJuHs9fa3/MeVLZhHkgkIhtxju0TJLQXTvbe9wlTvfj8wyKe05x89lOdDUW
	 Jg0R/i1p8ovKPs2CcpAdo6paDcp7/ymB9wCDtOdMJRViYpk8Yzohq1XQSIZcX9uHT/
	 5b6YjxXSK98R54TitGbtsqjDrvJbG3zGuwevAdNjMm4FLPL78Lf6ZHvK2co4kOIvUv
	 zFEe9omlpUCiIIOM24cr34H2gskh8LSasEvR0wEDyycxo7c4Z5/TlBOCh++1W8M9Te
	 R8nW+ZBpGuSSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] selftests/bpf: Update sockmap tests for MPTCP
Date: Sun,  4 Jan 2026 13:29:44 +0800
Message-ID: <b8602c68bc9d73122e16cc312e82cd3cc9ec08a6.1767504329.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767504329.git.tanggeliang@kylinos.cn>
References: <cover.1767504329.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update sockmap tests to reflect new MPTCP support. MPTCP sockets are now
allowed in sockmap, so test expectations are adjusted accordingly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..217ecc59c8a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -570,13 +570,13 @@ static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
 	server_fd = accept(listen_fd, NULL, 0);
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &server_fd, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
+	if (!ASSERT_EQ(err, 0, "server should be allowed"))
 		goto end;
 
 	/* MPTCP client should also be disallowed */
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &client_fd1, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
+	if (!ASSERT_EQ(err, -EEXIST, "client should be allowed"))
 		goto end;
 end:
 	if (client_fd1 >= 0)
-- 
2.51.0

