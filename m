Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBB1CA96;
	Tue, 26 Mar 2024 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416429; cv=none; b=DlyiCtDxR/FkhjHpa4eFq2urkf22OXK3hrZFWAs0FXbkcVHLJ4ozXmXs+blrsqnA9Xf6y3tNNICtZB3xrn2+X04eIfEiWA09WmE97FEawIx9YRF+k4MFe0HOKuSf+7ocfqkOriGisf8ZRRvsFH+gs2HIjfJoUpFXZ26AUQPZ9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416429; c=relaxed/simple;
	bh=DtAEuz7DlUmdHV4GApnjMFRpP2OGvcT9EdC0I/cfJhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmOoqq2r34jsl640xMh/M3FTdO1Ms2HrJb5T3zRfZXvqISOyBMDnKq/SXcZNwtn/t/cyugUxRUCBYpQwJoDqDKxnIPkt0a9Oah32Ex/KAJ4J1YQ1psJqre25x5KcFKRcj7b5ySFrjvVIm1THZpShJoTg24tI5LC09VlKgenI9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ior7uqZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ior7uqZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6928C43390;
	Tue, 26 Mar 2024 01:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711416428;
	bh=DtAEuz7DlUmdHV4GApnjMFRpP2OGvcT9EdC0I/cfJhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ior7uqZy0QE+7DgLTEUpWMFD/kLPJ6AkP1C6OdqvDGf1727n9NvFh1hjKsTot1U1D
	 vndlOu3y9+IMO0eacJBJ0874CrRXCwFnRAOjDWZ4BR8Lmov1JEhzN6NB03VdifUY+l
	 lbw+Wxg9lGyXRu4aPGl58oSYXN6KIT1YfgJ/Eq6LbWbUXSQiWd6dBSYVR+wWQYS3lv
	 4Tv9hjEJleXcQD1bCEI1struqJbQmQeLAy7yQz9mS48MCT4EXhh3zYmgl2fDvDiQHL
	 rQ49GtBh/uTQc0aT93Xee7XUnVvrFrC0pyGc26OCBJ82iClxNjtgpSAvZnWVppROSp
	 EB83L05WC42TA==
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
Subject: [PATCH bpf-next v3 1/2] Squash to "selftests/bpf: Use start_server in bpf_tcp_ca"
Date: Tue, 26 Mar 2024 09:26:52 +0800
Message-Id: <83239db116b07cfea62ce3a63604c5523b0f9670.1711415671.git.tanggeliang@kylinos.cn>
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

Please add these lines into commit log:

'''
settimeo(lfd, 0) is invoked in start_server() already, drop the
duplicate one.
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 94cb22b01482..f44abb990804 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -100,7 +100,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	}
 
 	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
-	    settimeo(lfd, 0) || settimeo(fd, 0))
+	    settimeo(fd, 0))
 		goto done;
 
 	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
-- 
2.40.1

