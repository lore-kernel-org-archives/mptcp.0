Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35599228C9D
	for <mptcp@lists.linux.dev>; Sat, 13 Dec 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765607996; cv=none; b=JXJNPmgqlXfP5XMSUN6vYF1lVDCuTqRoAmCZRVEfaqXB7IG8N9u1sQb78xkXz23NeEUPg8sDnkNyE6STdJpO3ZoETXo5wKPnq2jkbejtErI26aDl5qsPbCpE4QdlQ9syMseFnYuLsTeldurwCn2oXtH2MlulmDEMDZ9EEWiaVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765607996; c=relaxed/simple;
	bh=qCx2qkiRbRvHweLZRMEVpltAbRE5pa6MWRPEC/BkY6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUIUVByWaOlQClYjtZYt9M4I9Wq/DaUWBFIw/tfp+8US8qmuR9fvVkulfSNdEtpxIPS3HkDjXSpPkVOQqqJquCrGhVkDN5JPTuJy/4Qe0O15QGBgu43HXrf6K6kBwX3UQN696v2MTO9JgNS1dAcruG/NeBJFZk866r1+rs74lKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqYCarnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqYCarnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A982FC4CEF7;
	Sat, 13 Dec 2025 06:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765607995;
	bh=qCx2qkiRbRvHweLZRMEVpltAbRE5pa6MWRPEC/BkY6E=;
	h=From:To:Cc:Subject:Date:From;
	b=bqYCarnROECdHd6CxuSJapMuTtQ/17PXMNFdaPkWULXCKCoqKYYS7fo8ezBuJgpmS
	 fCVU/HKP5sdYy1/94GbqqjXP/nmlB8bccrtRZiQl7Zr/Xh+gmu4K+9wNZbS5CSspqs
	 stwtaVs1RYdS4nwMcqWmbWig6goybHNAoS9pr590I8BVlvFLlKbc7aFzbIbnGVN8fl
	 zpNrH1EgERxvIu9mTOYZ41hGwmW1GYGmZfycc8grGd34yHRD/HIjWg4AOb/zz3a6h/
	 nC+98d+BqAquDsXCEQZbXKO04zO1NAEccUfEUbSj3vUgQN5R+Lhmodjdh24Bi9Srse
	 q7w3HTRxpCGBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] add tcp_recv_should_stop helper
Date: Sat, 13 Dec 2025 14:39:47 +0800
Message-ID: <cover.1765607485.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

While developing MPTCP splice_read, Paolo suggested adding a new helper,
tcp_recv_should_stop, to reduce code duplication. This patchset implements
it for use in both MPTCP and TLS.

Based on an earlier version and following Mat's feedback, the sock_error()
check has been moved out of tcp_recv_should_stop(). Also use this helper in
TLS and TCP-BPF.

Geliang Tang (3):
  tcp: add recv_should_stop helper
  mptcp: use recv_should_stop helper
  tls: use recv_should_stop helper

 include/net/tcp.h    | 23 ++++++++++++++++++
 net/ipv4/tcp.c       | 58 +++++++++-----------------------------------
 net/ipv4/tcp_bpf.c   | 22 ++++-------------
 net/mptcp/protocol.c | 52 +++++++++------------------------------
 net/tls/tls_sw.c     | 18 +++++---------
 5 files changed, 56 insertions(+), 117 deletions(-)

-- 
2.51.0

