Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01312BEB1;
	Mon, 25 Mar 2024 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331789; cv=none; b=Kn0rTCSahUDmKMAiFuwYa+yv+vDJBYX9ay32lrCTebc88yjSqYlqmQG+YtssDX/3/vEwlYFoxIxJyAFVTVgsZQj/fzRxUVSZEoFztpmoljYGTsTXMeFdSRQB47VM4mEemWZZWSPlJ96r/5uSZSwN/X4NncOSLXMnfIcYGqOvPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331789; c=relaxed/simple;
	bh=icyO38cGeBzkpbCKm3zrjf9h1V8WBVmcoCFYROVh7Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQtMRZJNq1sjWmSAnAT8KswnattNK3UnAyRHqG0qEwaiMgmIf1rzFH1eOCp/gHDkAAKinChw0cGxvazpEZZPhqCyAxGios+zGZtW5ms8QH3vClm5mu/MWPhbPKrgLb2m5sXbYqOHaaRfF6xyjls0K/hzkdYEwXgV4GAXksgUhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB0PdNmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB0PdNmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3644FC433F1;
	Mon, 25 Mar 2024 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331789;
	bh=icyO38cGeBzkpbCKm3zrjf9h1V8WBVmcoCFYROVh7Z8=;
	h=From:To:Cc:Subject:Date:From;
	b=mB0PdNmXxm90+sZtId6K7tTuWrqCOrBG8+Bgo8gn7bsncZWopNzJnlXYk+qf2KLm9
	 vq8XQ95FoEdtE25TT0OMmTnFy4pd57E7gPS178PL2OvEarNncyrutmfFSkXBliQRMU
	 YiMVXXFJoyimL8oChmFSZ6norzfEGDTZ3fDK/QFDyYBmwIhleorUbkfDCI2+y98tLt
	 hl2JfRlvvcaoY2QFncwkk6iBpqt5RJDKvaCSK1zfn6eN03Appn+zDoGoGnUMEMAUsi
	 PAPXlAkCQAYsvA80s9hZp3ZXc7qQc0FImz/f36JTeWuyQ7Bdq4PW7QZQrey9yQ3xxF
	 1a7YPM61udGKA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH] selftests/bpf: Use start_server in bpf_tcp_ca
Date: Mon, 25 Mar 2024 09:56:15 +0800
Message-Id: <9926a79118db27dd6d91c4854db011c599cabd0e.1711331517.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To simplify the code, use BPF selftests helper start_server() in
bpf_tcp_ca.c instead of open-coding it. This helper is defined in
network_helpers.c, and exported in network_helpers.h, which is already
included in bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index a88e6e07e4f5..94cb22b01482 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -89,7 +89,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 
 	WRITE_ONCE(stop, 0);
 
-	lfd = socket(AF_INET6, SOCK_STREAM, 0);
+	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
@@ -103,21 +103,10 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	    settimeo(lfd, 0) || settimeo(fd, 0))
 		goto done;
 
-	/* bind, listen and start server thread to accept */
-	sa6.sin6_family = AF_INET6;
-	sa6.sin6_addr = in6addr_loopback;
-	err = bind(lfd, (struct sockaddr *)&sa6, addrlen);
-	if (!ASSERT_NEQ(err, -1, "bind"))
-		goto done;
-
 	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
 	if (!ASSERT_NEQ(err, -1, "getsockname"))
 		goto done;
 
-	err = listen(lfd, 1);
-	if (!ASSERT_NEQ(err, -1, "listen"))
-		goto done;
-
 	if (sk_stg_map) {
 		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
 					  &expected_stg, BPF_NOEXIST);
-- 
2.40.1

