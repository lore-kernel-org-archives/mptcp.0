Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DF548EC;
	Tue, 26 Mar 2024 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447437; cv=none; b=RxlkfM05zaNo+x+Q40PkFi/SC7l/ORPnDS1L3DxNVneQPK4AzhRUK3H11Wfk4L5BSGNSqXiVNyootDpzmKwRS7VBE6RgyE6uj6RFCA42DddRY7CavlkYSv5ufdrf0mOdc0nKgmf6jKd0eNnqs1ejjxZQSIGEyzp29LB0Zmgb3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447437; c=relaxed/simple;
	bh=iUIdoQJmd/JeS6FVWvYqhhiJJX4bqojbuzrdGV9yjoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiqCO+OV7Ojb66Npabz8NCeUd7hdOOPUBTRK8qF1JA26k+Edup1x2SJW9klHBZeXvlZwp7GOu6/hghP8qrCI7+fMs1TAq3wQFWSa8FtJ5TLpRqqH7rS7vJ5yqdoJwtyDIoWB0WTY/w84FqElM6+QI7jTkoUyIa1qgpzW2/5dRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCk0hjc/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCk0hjc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE142C433F1;
	Tue, 26 Mar 2024 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711447436;
	bh=iUIdoQJmd/JeS6FVWvYqhhiJJX4bqojbuzrdGV9yjoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCk0hjc/AyHs/wuOx9T1Z+5cuWFAMAIaWMsoieBpSg1WJUB8uXkjf82uoUQE04mAY
	 jcngSyo2TmmnbzEVQCRwRrDyNRg0F7cqb2FP2ueh8fALMg5JBIbZkrBXkjwsrZoRYN
	 vtK2dprWk6/PNxYWMl4BI9t8J7uZYH71z5Tt2a+VTw0PH42EO4PKqyoAmxUBTkNHQa
	 gVRJjczjO96ws0wouHymfNOnp43xuNENgIkaymbbN06ZNHVgnCwwPAtkD5XUKh9KqW
	 UxMv3a91FugH1m8OXfOaqjJmZQNNdTg6O6ge5ta9A0culaU3yTRs0e04hzG9310K+g
	 xJ5Fe1n8/Sgmw==
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Drop settimeo in do_test
Date: Tue, 26 Mar 2024 18:03:39 +0800
Message-Id: <dbc3613bee3b1c78f95ac9ff468bf47c92f106ea.1711447102.git.tanggeliang@kylinos.cn>
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

settimeo is invoked in start_server() and in connect_fd_to_fd() already,
no need to invoke settimeo(lfd, 0) and settimeo(fd, 0) in do_test()
anymore. This patch drops them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 5aa3ccdc1351..3da3030c9365 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -97,8 +97,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		return;
 	}
 
-	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
-	    settimeo(lfd, 0) || settimeo(fd, 0))
+	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca))
 		goto done;
 
 	if (sk_stg_map) {
-- 
2.40.1

