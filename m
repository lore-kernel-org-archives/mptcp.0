Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91A1A4F26
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517244; cv=none; b=UdT9a0KYAj7u5i6gu15109SHR3zfGrYWsaPV+KfbjBjJY8+ZLN8TK/Z7DcA/7kf7zdzv3mdR6gDLNXFawTOcDu8vZHu+RJz/8/tHFNpJB/h2jH1E5bE8UE+IwZNhWjEFxIQNhq3V1CnS68T2QPzLlNXlsOaqU63gMOF9JRpkXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517244; c=relaxed/simple;
	bh=hQBOQYfqv02aDuIO/J4gtMfooXHtnExsP2RQuxLJ1mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jl60fnNJk4RrA7OF9cfuaqeJ+RMzHfxhfvi2mplW3qfLMHgdKsLHvUXCk/YjaRP1LZNY4fm+3rjIQO/eYSyMnvyFQ0+T8x3vOkC5r5j98WxNC31bHVi+dV8bO2U9PVBi1rR3QJEzQpfGs6+U1yFCIER9f22I3/ft4+g0euiIT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ5jgf9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ5jgf9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15FAC4AF09;
	Thu,  1 Aug 2024 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517243;
	bh=hQBOQYfqv02aDuIO/J4gtMfooXHtnExsP2RQuxLJ1mA=;
	h=From:To:Cc:Subject:Date:From;
	b=GZ5jgf9OGT4EwEjQLRiGsU6mQgo0kZEBXnj3vN/QqQVCI9ZtuJxvkfeGCt04BFDsR
	 +94CCK/H2+AHbtTDFy4vd3T3OLh6FVjsF4IgbU0iv3ZDWr1xkJoQw+r4KJ/VVvD8Mq
	 FIXzXF2zBM0Odp0O3YcrQrEOaKuoEXjRkpj0WDETvz5UXHMcbyVGjk6Ow+DgxWGyTa
	 omsZXDSQpX2YodykxTbxLXb3cfJmOM4W7C22+fxttJlhaDd9x9qEX/Rymk2lEYQrY3
	 2BKsMKOC9/pB3ON9LlNDxq77tr1RUAZw77dppf5iSKEmxkZfp2aQQMoF3ketVaiaX6
	 +Fpmc9uE59AHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] skip test if ip mptcp not support
Date: Thu,  1 Aug 2024 21:00:35 +0800
Message-ID: <cover.1722517019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - printf a log as Matt suggested.
 - two more squash-to patches for BPF sched tests.

'ip mptcp' not supported, skip this test.

Geliang Tang (3):
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"

 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.43.0

