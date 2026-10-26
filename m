Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026250;
	b=znFUVeIHuILBH7E4p6H5LLVvvxe7Pp29LRvvz5NS1x4amRShKfZlu4Fw3tFpwCYCBIyn
	 GMV1RyhfP7oL/OkV3J9f3XQZ6EWXPIRoYq5l+kdgyG77/k/UDTk/oKizCuQ/b9mFjIe6L
	 lO2/h99zjEc1EVH46q+4kSzG1pFqQGIcLeU0sybPy2PcFo/fD8yOWTip8zCI7neB84YCF
	 spMfbtuqdeObx6g31RQ7AWgPTr3Ape5XF2sdnVOFRDGcqkzp8HkDthpsX33ZjKF8aaOEB
	 gAfTbFIxaUFf7tC7CnVErb4GLt22UW3uo3JLQyPIBY53ZcvuMNOPIjxQV77BTS5fsPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026250;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Y8RSEfE0OC5eG2IInvUhBUL/bxPzP3bYQjg4gh+caaorFkpXEDiAjH3rVtGjeBowXOfs
	 mWI6gMceUomVaCbHgWzml0u4RzhEyEo0TPtD6Y1kohZjtbE9gHQEwAYwgLwmX3BBpuuvc
	 xT0mwfVclpNqcy6ZgQ4V4192kvyIwBtVBSwDHly+MJycwy5Th3VifSbqZm7oSI57BEtqQ
	 bi50+GEUWk3CuRAO+uDSqZsfNoIVldssWxpfDvexs0H7seKR3vJaTwvMePwc/zjFOxXSU
	 kt9y9URuPtIJAJvFTMM3blOZmHwks3zgyrLUkz5QqqTzqd2hpiSut/w/+PNOWb47yTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G55xFDQ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C5606A31A;
	Mon, 26 Oct 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G55xFDQ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8461F01825;
	Mon, 26 Oct 2026 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026250;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G55xFDQ8+3XEOJxX5Pd4gGgnDBtOpNGq1r8gczxWnRQi/P1pFGIzNAq1fo8uB2jx6
	 3pWPSxyHRWdXjNPC/G+jECek6U3jgp1f2tmOhUI+r8SNgFgSPiPRHywwKqKgaESdHQ
	 g+dIuSiv3K6vwex1cW68TQIw5rBsBep9RchxvqK8V97zpoB+ZxS262VAT1Jj3L6WMq
	 as9ntPW+Bx4Nt+vaUCzayPnZh3tEq+RQyX8ozQVDtlRPSBrWFeQ+bSF4+x8c7W3Gll
	 7hncbDfjkl+ztNoCUopAR44nGV2SyBbnpFqEj57RHQsNK/Tkagc4Imeo6VpibYOU8J
	 UxsHnXlkpO2eA==
From: netdev-bot+sinfo@kernel.org
To: Cen Zhang <zzzccc427@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: 
 Re: [PATCH net v2] mptcp: protect listener backlog reads in diagnostics
Date: Mon, 26 Oct 2026 14:50:48 +0000
Message-ID: <179302624885.3327.13045655090448587758@kernel.org>
In-Reply-To: 
 <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
References: 
 <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
