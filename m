Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297433914EB;
	Mon, 14 Sep 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370087; cv=none; b=iJZCYfwEEKKv4AHtO25Y+0UPLxeLP0OKhJs4YZInq8XzTVpk/ORJ2g3qP+gKyS29Z485cE0Pfb16h3CNQzWoXx3RX5Y+9ZUm3o7k9u8Mt3hSEPXynfeCjUVPCwhHTck8d2az3YWTMETrGDds/a1wnPeQCZN6YubJy3Ozv/sZmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370087; c=relaxed/simple;
	bh=vQF3IPEdA4rhc3ZsUTy/9ISrvxp4SuLp6s4/fZ47FpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKi2uiupYSxOHXKhNCtnKJg1rDKPwzKo8+6hYOmAQ/Pb26+Dr6y9YCoH3MZLCRbPzZ1CU/Rbwz9+04xHMVZBhVZzT+lcej9CaQv143xPZ5IPqmSzsYut9SIxdk4HagDSo9j/kSurGjVeuMmGLV4vpoXn70truTZFnnMbst/6NTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTCkpiw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTCkpiw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D871F000FF;
	Mon, 14 Sep 2026 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370085;
	bh=wg2A4tV2/nJFB3456M0wR44y82V/1lnTe1+6Q55Hiyo=;
	h=From:To:Cc:Subject:Date;
	b=GTCkpiw2zpC6sMlSlYWhaChV++U71qKkEf41KOk6+X1Ee7pJ4Vc+L2Bo2oQ0PKbj4
	 2RxPbwGCuWj/t1TJ2opo/XAuxmd7eSO14i15rY1HKlkAzaijqZV8J1rPBoJFux242J
	 GbIXe/eEWL2IdrujkPr2sMK9r8BWSu+kOoIp2TjFdTdP6ydiTNM+9K2qbkzZwyNuz7
	 cgE7myXtZHYsXbuGRBqR9xk8cPYs7HKFbeLDx3RZbERSrVkCwZSmma0HwP0gnsF+2M
	 0jLHwkpt1favDZQ34N7ZWOkyQwh/+11DqfBOK0Co0bFFmOKkCiEFwGenhe+DLDJ/SK
	 pJapwYy0OGiFw==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH 0/2] Drop redundant tcp_rate_check_app_limited calls
Date: Mon, 14 Sep 2026 15:14:21 +0800
Message-ID: <cover.1789368148.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

These two patches drop the redundant tcp_rate_check_app_limited() calls
before tcp_sendmsg_locked() in tcp_bpf_push() and tls_push_sg(), since
tcp_rate_check_app_limited() is already called inside tcp_sendmsg_locked().

Note:

The first patch was originally part of my ongoing "MPTCP sockmap support"
series [1] (patch 5). Matthieu suggested converting it to a fix and sending
it directly to netdev. Removing the redundant tcp_rate_check_app_limited()
call benefits my subsequent MPTCP work: in patch 3 of that series, I
implement an MPTCP-specific mptcp_rate_check_app_limited() function and
call it in mptcp_sendmsg_locked(). This allows me to reuse tcp_bpf_push()
by simply replacing tcp_sendmsg_locked() with

		sk->sk_socket->ops->sendmsg_locked(),

without carrying protocol-specific assumptions.

The second patch similarly benefits my ongoing "MPTCP KTLS support" work
[2]. In patch 9 of that series, I had defined a check_app_limited()
interface in struct tls_prot_ops, but this interface is unnecessary if we
can reuse the existing TLS infrastructure more cleanly.

[1]
MPTCP sockmap support
https://lore.kernel.org/mptcp/b5f9e8d7-b738-1df6-3b5e-1d54cbbc663c@gmail.com/T/#t

[2]
MPTCP KTLS support
https://lore.kernel.org/netdev/cover.1782123118.git.tanggeliang@kylinos.cn/

Geliang Tang (2):
  bpf: drop duplicate check_app_limited in tcp_bpf_push
  tls: drop duplicate check_app_limited in tls_push_sg

 net/ipv4/tcp_bpf.c | 1 -
 net/tls/tls_main.c | 2 --
 2 files changed, 3 deletions(-)

-- 
2.53.0

