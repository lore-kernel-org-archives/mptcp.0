Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66A46424;
	Thu, 28 Mar 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621432; cv=none; b=dV2APEhbd8MGsz2gnJCnnwrP0Py4rr6EeuqRgvIYGm0kbYj9pxgujMIepYiT//vENVOAPdRSxVRBBiKpc0I67t2dcV3EwdC8vyY2qm9wdAgKQDrbK2/iWwF+rUOGQb0eU7FhtLIJiQIA5sAn+192zQQsfeLHn1Zw3ZI0y31xi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621432; c=relaxed/simple;
	bh=8h83ua/XVqBd3Xbxhziaf6x/NJNF6bLbLjqOv8fpvRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUEABdinkswwqEfMZVVIrLxJBjbVmtIyYw7uXSIDQRI7nK4Q8XOhE1MjbM/Hmb/ouG8pcQg3yBrgLHWNEUUoA1wMweVaqy15lqaJ8M9IMvs7Y7LWEYZPk2lPH+uU4Dffxd7LWvzTZsmgouaSmwSbAQjfNfJ+gvBMxV2s0EBLhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN+xriCi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN+xriCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AE9C433F1;
	Thu, 28 Mar 2024 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711621431;
	bh=8h83ua/XVqBd3Xbxhziaf6x/NJNF6bLbLjqOv8fpvRo=;
	h=From:To:Cc:Subject:Date:From;
	b=eN+xriCiq330eZCokt3Stia6+lGFQUtik7oKdn+iFEfs2pcEOEfHG/dVommFqovJA
	 u1V3FbG8l+WxT+s/GaZBmQIxoD8QHPTiBx6ReMRSrgzpg+rippTGodB6tiLs3rW3zT
	 /TOOykH3q9uiTMtplqpVKPVixJh/Y/mRIoypbYKwraC/u/NQfWsMY50x2mi1NImNXO
	 PESQ9sLlJjUHGNxoIESzYI+OL+aC5xdV9Gf83FjI2mXms6F6HZx1fVjtABgEFLEiba
	 QNCCKjnEh6nulFt0ZC95u98QCU3zB6lMTsi1ZQin2jbcS2MomEhdQ8TyVvHB8cCHyl
	 L4bi9sWk8Qc7w==
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
Subject: [PATCH bpf-next] selftests/bpf: Handle EAGAIN in bpf_tcp_ca
Date: Thu, 28 Mar 2024 18:23:44 +0800
Message-Id: <78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_tcp_ca tests may emit EAGAIN sometimes. In that case, tests fail with
"bytes != total_bytes" errors. Sending should continue, not break when
errno is EAGAIN. This patch can make bpf_tcp_ca tests stable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 077b107130f6..fbc219c2d53b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -56,7 +56,7 @@ static void *server(void *arg)
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_sent = send(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
+		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))
 			continue;
 		if (nr_sent == -1) {
 			err = -errno;
@@ -131,7 +131,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_recv = recv(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_recv == -1 && errno == EINTR)
+		if (nr_recv == -1 && (errno == EINTR || errno == EAGAIN))
 			continue;
 		if (nr_recv == -1)
 			break;
-- 
2.40.1

