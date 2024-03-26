Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7054D9FE;
	Tue, 26 Mar 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447432; cv=none; b=TENEgo8p7f9rmOelVC1oxZqEBgGpAgFPsPT0atcKh53McXc8+zCjYXu8apWzclJszrHJHFxwztARf74HTZtyZ5mMFhkuuxgdViMtX2zl1tbuxt8KaNoS+1GEiemJvFPV2ldgu/YQ9CK63UMSaONztN6FVRJd6YXERc6B8uHSLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447432; c=relaxed/simple;
	bh=+fIE42jXnRsZLRuxQE/WMzSbKFFwXPegR9bLSmdyi7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hiwx2AcfF11jvJPv3vX0uWUOkoZFAUn4rhl3ccwlQdJVPFBUA/nASLrzkkMbwOJe5WMofd/yLu8x6a/bO0oYdBjxD3llYfgY1hYnyq7GJZxEgFPyVDmZ9DzHz8mQ8Pc3NQxTM28XTgNaM764Itd9BF46CoHYAg3IIKy6UbY+pIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/VGSv81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/VGSv81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52251C43394;
	Tue, 26 Mar 2024 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711447432;
	bh=+fIE42jXnRsZLRuxQE/WMzSbKFFwXPegR9bLSmdyi7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/VGSv81NbNV5P5MOLrEh9SDyxuvBb38+DeUWKsm0muQSoPl7CWzPoamE/hItH2KA
	 e4XIMlbVYWNg4WgALPcenBVpQ/7x2WMgkcc2QnHonIehGEUg1Ave/vbho+Ocrb8mKh
	 SPiWkEZT5+O7Y67jkT45Hsxv8m8yGEYTiLduZEyYNqZEQieWAEl/IMbglBleDn0nO0
	 RikS+6w1FjOm3xybi2FfaD7kqYp2GR3Y86/9np+fsMztHDXfulyTC9vBk4Xuew4Inj
	 a9S1QFOJw5MQHQD5XjcQHwYGJ4MH4wKYJ1/NiP5/4zGZqcs14J+8LfEjlbNPKrY1wk
	 cGU24xiCt9fIA==
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
Subject: [PATCH bpf-next v4 1/2] selftests/bpf: Use connect_fd_to_fd in bpf_tcp_ca
Date: Tue, 26 Mar 2024 18:03:38 +0800
Message-Id: <e105d1f225c643bee838409378dd90fd9aabb6dc.1711447102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711447102.git.tanggeliang@kylinos.cn>
References: <cover.1711447102.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 94cb22b01482..5aa3ccdc1351 100644
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
@@ -103,10 +101,6 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	    settimeo(lfd, 0) || settimeo(fd, 0))
 		goto done;
 
-	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
-	if (!ASSERT_NEQ(err, -1, "getsockname"))
-		goto done;
-
 	if (sk_stg_map) {
 		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
 					  &expected_stg, BPF_NOEXIST);
@@ -115,7 +109,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	}
 
 	/* connect to server */
-	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
+	err = connect_fd_to_fd(fd, lfd, 0);
 	if (!ASSERT_NEQ(err, -1, "connect"))
 		goto done;
 
-- 
2.40.1

