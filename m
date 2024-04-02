Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC721A0A;
	Tue,  2 Apr 2024 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039925; cv=none; b=KfFq+aMhehJfT8SvBCpuTQ7xCJDuv+9WOGXZC5VHMRZV5zEZaUCho1ogh3Zmzme7diUkj6bFOKK0axkvr/qeqHpUA2TtWDWCyoNsQwuaLebcxJYWlos7i9wZppxXyXeg9JJIlhqW3HAD9b8Fc+xSfdW3hvfKd+NrlTlL+WzGveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039925; c=relaxed/simple;
	bh=mV7wL6w4YmzEymnT+rKsmuopZIr/3LipLLaV23/hVYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N5ytFuN50BI3W48tmPetmuEA8wvdoymXGHRDzhiDOG7P3coxtJw0n+wVr2rCU9PetZ+U0ioltAGsMy4+3gLPiYp85dKWGM/nnvtl3xjsIM/TXMU60nGtoxDDazrHqpx5T2kQ4RHrR+ZI36VqhmCu6LMaCqMriwkAmpbnh/EagNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8zwduaN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8zwduaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423A8C433C7;
	Tue,  2 Apr 2024 06:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712039924;
	bh=mV7wL6w4YmzEymnT+rKsmuopZIr/3LipLLaV23/hVYE=;
	h=From:To:Cc:Subject:Date:From;
	b=Z8zwduaNl5GhgmclwVeIvHsgN3/nHhLYuwKjUGrxKEb/qWyYiThMj6J6vBpT6la5c
	 Tzi9v4hJ9NeO8P3flLv51sPcE2MLipeuHY7liXpjGO8N9fuQEWwPBO1+Mdh4lZa5YP
	 +gt/A1M+QbZ7Nmw7DDJylhU8UG7YTYyvoGLJY5SeGvuRaMrios7wMy/GKaMG7YPJJY
	 4/SEkSh6Al6Q9OC1alTrKUF0uLgfKQbKXOB8J9RypLQntNoIyRq19opCkqcAfJ+o77
	 W97pL73Qm1EZhppGvTZ53ui7WHnM6lP1JRMnHjg01W+1KCK6KoTLC6MMQfxNlOfPxE
	 E+UX6pNqy0s+g==
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
Subject: [PATCH bpf-next 0/3] export send_byte and send_recv_data
Date: Tue,  2 Apr 2024 14:38:26 +0800
Message-Id: <cover.1712039441.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Export two helpers used by MPTCP BPF selftests.

Geliang Tang (3):
  selftests/bpf: Export send_byte helper
  selftests/bpf: Add struct send_recv_arg
  selftests/bpf: Export send_recv_data helper

 tools/testing/selftests/bpf/network_helpers.c | 95 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 71 +-------------
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  7 --
 .../selftests/bpf/prog_tests/sk_lookup.c      | 13 ---
 .../selftests/bpf/prog_tests/tcp_rtt.c        |  7 --
 6 files changed, 98 insertions(+), 97 deletions(-)

-- 
2.40.1

