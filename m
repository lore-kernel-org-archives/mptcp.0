Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772641CAB5;
	Tue, 26 Mar 2024 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416434; cv=none; b=cyM8S+PkpGE9ZBtLfkiFwNOCj0BS4drwTGe/9cTuD4BlMhe600MXzSBUzr8Dbb/dlQIAceUxuXQGADHXgYxIe4vae0oFy2cbtYmVIMII2izBtunlQ/xtHXNLEy468iM+GRvI03PFxPjsovxZS5vVXsOnZFqX0ZQyMD22gCqcVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416434; c=relaxed/simple;
	bh=18Zkt7T2hCAIqpvhlhF4CEGnn3A8qSQkf0zooCIBfCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0yWma9AzJEfQkkb+dhfL5M91xsyoXnU47tjwJKKfM6WzEZncXwphOX6s9HNz5n488PLUbB+J/MiUrBOhFQCIIYUaF9ud3alCuVj6AW7/zRuQ7M68fEuLgHiObVfHH0TdvVKYiesFE8RReLDw892EIcDTzRIYpHJx4aUG4QRhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANHc9Opp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANHc9Opp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1524DC433F1;
	Tue, 26 Mar 2024 01:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711416434;
	bh=18Zkt7T2hCAIqpvhlhF4CEGnn3A8qSQkf0zooCIBfCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANHc9OppQ2eynGRdJ8/GhuMfJ5ZcZHuT/c/btgTIEbyrci6oE5s1uf8BELbwNpV/k
	 0jkZQc00Xu9Hsh6v4wTXWDZx2C81YxwaqrAoONMVKFy6CGx3wbemcXSHQ2XBBONkXr
	 iJWWf8nxK76vReOEv2mDJmUJ+mUe1HSpvzVPsnIu4rq1YD9dYAzlya4+EE3G8egj2g
	 f7rQy1s7/yqiEobRtGOVLSUIx6zGfbTmPj8mEwFrmQB51YhX5B/TMq0Hwg/mr9m+E1
	 1jJkVf14JSIWM/MnQUnvr+2kCTTkbNlf5qF2lGm++Un69h2puPUzCA1zlhFvoQ/THz
	 jxrL/1LB6LVdg==
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Use connect_fd_to_fd in bpf_tcp_ca
Date: Tue, 26 Mar 2024 09:26:53 +0800
Message-Id: <a024545b739d0046d15e6d5eab9e3aa7e21d6e18.1711415671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711415671.git.tanggeliang@kylinos.cn>
References: <cover.1711415671.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To simplify the code, use BPF selftests helper connect_fd_to_fd() in
bpf_tcp_ca.c instead of open-coding it. This helper is defined in
network_helpers.c, and exported in network_helpers.h, which is already
included in bpf_tcp_ca.c.

settimeo(fd, 0) is invoked in connect_fd_to_fd() already, drop the
duplicate one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index f44abb990804..3da3030c9365 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -78,11 +78,9 @@ static void *server(void *arg)
 
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
-	struct sockaddr_in6 sa6 = {};
 	ssize_t nr_recv = 0, bytes = 0;
 	int lfd = -1, fd = -1;
 	pthread_t srv_thread;
-	socklen_t addrlen = sizeof(sa6);
 	void *thread_ret;
 	char batch[1500];
 	int err;
@@ -99,12 +97,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		return;
 	}
 
-	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
-	    settimeo(fd, 0))
-		goto done;
-
-	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
-	if (!ASSERT_NEQ(err, -1, "getsockname"))
+	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca))
 		goto done;
 
 	if (sk_stg_map) {
@@ -115,7 +108,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	}
 
 	/* connect to server */
-	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
+	err = connect_fd_to_fd(fd, lfd, 0);
 	if (!ASSERT_NEQ(err, -1, "connect"))
 		goto done;
 
-- 
2.40.1

