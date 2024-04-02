Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71230762C9;
	Tue,  2 Apr 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055030; cv=none; b=ILyvyhAqdiM3znNsuOwe0sZiCggoW+I/tuiebTOU1J2OW/IhegL49iRgObJho02R8EuzhOO9deqZyS6RUHk4ekAgH9SWMMJ6U6ONlKN4HpODF4CTQfYFbS4LGcciCVwAanXdHxyPGprS/vx795rx3DGHANKHVNVIU9P1AtLTzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055030; c=relaxed/simple;
	bh=02nrjVljzboVxR9KQLk2jgoIU7w3ABlR4N+MigLd69s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIntyjAY1+XwnG+lLPomEEIDnDUVW1+9Ii9fm7CghYiVjjubHcjZNCJZZMhZfQBW5Jxcr+B6vQjebU2Slo2JQZpaUV9iUIOA9K6AZXNm/i+dHQ7QAGqD5RmDfjepq1gaxExZmnvP3s6GSlXSej/XgaP1JF0cS5Hl1kN0LfUUb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6G0Epv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6G0Epv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADACC433F1;
	Tue,  2 Apr 2024 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712055030;
	bh=02nrjVljzboVxR9KQLk2jgoIU7w3ABlR4N+MigLd69s=;
	h=From:To:Cc:Subject:Date:From;
	b=g6G0Epv6JN9DYfAyqXj4yRvATiQkeMwGGur9e5KBta39yEx99EuoFIZNgPJdZmbWQ
	 cTlH7kX2lluI60rA9CIWQsu2Fs/CUgZHy1dAvyZrTA59pxyZ8XSuaL9RxvL7AIav3J
	 LREwiOjFtQA3exWJ6rEM4Dsk8msxv4L+UANRewZ6wdIIcRzTTyiB6ZAU8IVRl4tcbk
	 4Ws8VNFpUJnAsGBaIAgmbF4w0ucLHYXFmNdwqVkIEFkhhFsVe3agl8Oz54fFOB0Yjc
	 CpOSyfr0athDHuSDq2JeGhkYQSxZV11sIPzUDU4bTuRgBAp9MgPLuYTrkDU//sC/ZF
	 a8kVAGxWaffhA==
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
	mptcp@lists.linux.dev,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Add pid limit for mptcpify prog
Date: Tue,  2 Apr 2024 18:50:21 +0800
Message-Id: <8987e2938e15e8ec390b85b5dcbee704751359dc.1712054986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to prevent mptcpify prog from affecting the running results
of other BPF tests, a pid limit was added to restrict it from only
modifying its own program.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 ++
 tools/testing/selftests/bpf/progs/mptcpify.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index bff13ecec64c..17f352154994 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -266,6 +266,8 @@ static int run_mptcpify(int cgroup_fd)
 	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
 		return libbpf_get_error(mptcpify_skel);
 
+	mptcpify_skel->bss->pid = getpid();
+
 	err = mptcpify__attach(mptcpify_skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
index 53301ae8a8f7..cbdc730c3a47 100644
--- a/tools/testing/selftests/bpf/progs/mptcpify.c
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -6,10 +6,14 @@
 #include "bpf_tracing_net.h"
 
 char _license[] SEC("license") = "GPL";
+int pid;
 
 SEC("fmod_ret/update_socket_protocol")
 int BPF_PROG(mptcpify, int family, int type, int protocol)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return protocol;
+
 	if ((family == AF_INET || family == AF_INET6) &&
 	    type == SOCK_STREAM &&
 	    (!protocol || protocol == IPPROTO_TCP)) {
-- 
2.40.1

