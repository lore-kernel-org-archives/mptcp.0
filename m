Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261B1CA96;
	Tue, 26 Mar 2024 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416424; cv=none; b=LrrrA5rdU3iJRY5Dna1Z13vL2qxxGgDvYo6hsQkr/qegTV3WNw3wmd3iMKgLgcHcqqHatL+7gZJZLO4oPD4O/OKMv6fo20aE0ZcN9aoTL+w82U/0rW7AyYyUjw9Ty3w0uCe1UWadjnU/0cp4sqW59gwmL9NDQzGiatOTAWiLfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416424; c=relaxed/simple;
	bh=izUc53sEMJj4a0WY4I7PI+L0RUZvK7hybHEQTs3tgN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sl90JYRQLDb13zIGhR5AgcfDEAFdKkyx//sJoCy/5A0zHs8LIIxA4XooW897Hnc3FiMxPvG6gyqN8ox8YrdBPRRRb0Qt1WNUOL1070PTxdzCd0n2oxQXbxToIIXEFaJnCeW5acjVRBBhuFjCsdP4Ofm3TGwn/Em97Pe3eGQmvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWjN2KAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWjN2KAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED2CC433C7;
	Tue, 26 Mar 2024 01:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711416423;
	bh=izUc53sEMJj4a0WY4I7PI+L0RUZvK7hybHEQTs3tgN4=;
	h=From:To:Cc:Subject:Date:From;
	b=bWjN2KAqyZuVAyHlRV3shiV+zVd5OBlrAK32X8W3sqqsjZxRTca0RYh/58imTQSYv
	 TWvmpxeoYeqTHJ/Lcxk9fFUdl4Rnvt8dEKruNw+wJyYgM25qMLYWNbMiO7vhyXs6Nd
	 +gn29CL9lbHb0hGxT8RZsr8DNrnvh7+fOTpZg2b8g+S9f5x2pMZVj/sOqJxHnyxrpD
	 2dHw/1ydyWDhwMLXmpQPRx+gQVCQ4QLBFEBaOgG44Fn8pVpjx2GSqqo1EFaklt26hx
	 yjYrxbGI60J2j1yDE52kmN766FBFeZGLbjgEo1HVnLbEOJ05CKc/+E7WRmJr0lYBr9
	 EIv4vC6MolNEw==
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
Subject: [PATCH bpf-next v3 0/2] Use start_server and connect_fd_to_fd
Date: Tue, 26 Mar 2024 09:26:51 +0800
Message-Id: <cover.1711415671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - split v2 as two patches as Daniel suggested.
 - The patch "selftests/bpf: Use start_server in bpf_tcp_ca" is merged
   by Daniel (thanks), but I forgot to drop 'settimeo(lfd, 0)' in it, so
   I send a squash-to patch to fix this.

Geliang Tang (2):
  Squash to "selftests/bpf: Use start_server in bpf_tcp_ca"
  selftests/bpf: Use connect_fd_to_fd in bpf_tcp_ca

 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

-- 
2.40.1

