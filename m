Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31026EAF6;
	Tue, 26 Mar 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447428; cv=none; b=HyG4RT/Z9AdRth1ZYOtF3JgRxoc3N8pTSd1XWr7ztB8dH08HiEl0O4NqTRed5Tu5SS8R6D4h5llRfg1kGNx5e5Vr5FVtnmwV2XUxpCfnb9wnCFBhNlerx0f+Xt4kzCCIESLBCb4h/2xPBAjvB5WJC3Z4LIopG9fVRXOPFcuG7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447428; c=relaxed/simple;
	bh=IDMse0cT7YjYFIOnFFN9uh5CktAo+b0xnAUwzKjEoDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxJ8jXGJTXiwSNOyPCzg5tuYptuUGwesc4V7WsUR8/oD1apjc+7u7kiDrbJizbidLJzY2nUuwK+G1Ao2irLDpHPNjZxevr4h1aLOXtMfMnVMeeiPEX+BZ5PEtf3Xb1hWjpvoTCQk971qfwljfqd5q1w9TLy8YnNmHXD+s9VlKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U90WIQ6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U90WIQ6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24B9C433F1;
	Tue, 26 Mar 2024 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711447427;
	bh=IDMse0cT7YjYFIOnFFN9uh5CktAo+b0xnAUwzKjEoDw=;
	h=From:To:Cc:Subject:Date:From;
	b=U90WIQ6SLIkmc8dDLb0GpKIKBhE5ya2cuau2V4KPYdzd53rfLX9dMxfZK37iRm9d3
	 B9NoRNqGbQmN2pTKfYwp7XYV/9Kppa3hrfRy09tm6RYDw8dbTZHgEhSVb4YSoAUM4G
	 o4sO9SwhyQNDNShCV7JyjEnAA2ss16n5oa5DvdJmd8zpLruvm54eXPmeM7uQZrsUz5
	 KbrRmqyA8P29ELtjIcTTkqIQ4XgMnS7HmX75xuSBI6m2GE3Q1IDzEYyitv7HAraNBU
	 gYOO2CM/k9cB+e1G7kKfbd7FAycdFpGCuw3v1XakYYFdSIjjQO81oXgvH7YzDbMGrO
	 ANNBz1LnalsCg==
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
Subject: [PATCH bpf-next v4 0/2] Use start_server and connect_fd_to_fd
Date: Tue, 26 Mar 2024 18:03:37 +0800
Message-Id: <cover.1711447102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - Matt reminded me that I shouldn't send a square-to patch to BPF (thanks),
   so I update them into two patches in v4.

v3:
 - split v2 as two patches as Daniel suggested.
 - The patch "selftests/bpf: Use start_server in bpf_tcp_ca" is merged
   by Daniel (thanks), but I forgot to drop 'settimeo(lfd, 0)' in it, so
   I send a squash-to patch to fix this.

Geliang Tang (2):
  selftests/bpf: Use connect_fd_to_fd in bpf_tcp_ca
  selftests/bpf: Drop settimeo in do_test

 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

-- 
2.40.1

