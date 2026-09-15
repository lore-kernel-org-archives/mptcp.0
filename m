Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9F3B71BF;
	Tue, 15 Sep 2026 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471193; cv=none; b=N1lU122C2GuLrbmkY0bD35nfEkCAhDQz1d/YJrKO+FIF0apk0WnsqVPlLYDvAmDF2cWAmWZrt+MLnTwWEjhXwLi//v2gK4SdhWsJIUqtw+3cL7o0TD33FBglOtxRQYrVyv3rdTMY2jBSbkNvXfULiUeBj5Kif2a3862MImm/Ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471193; c=relaxed/simple;
	bh=zfWoJcnWo9VwngZWVRrPUa4bt30KAuYkCacL3IxKOS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Foyl/AIWSzzWUPneOsjAwsEgKVuXEQPtvtRDJzzIjCmhJgWxA53zRiE7bhtt+oF4jC382TkrautdnzmoI7zaxdAG3IiU9zORwJFkY+TheUQZnTR4bbINnif5NSLOu5NnThUFClVR6Im1zXpMcMIzYoPg0prYiplO3AsU/Tsbl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4/gLsVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4/gLsVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC341F000FF;
	Tue, 15 Sep 2026 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471191;
	bh=4mqeKlaygKAXwLw/uVmB1M7xI93uBRn8QQDuvpK3S5M=;
	h=From:To:Cc:Subject:Date;
	b=U4/gLsVe/cwnkuA+NoJmZqi0buGJN9Sw9aQvh4WY8IRyJfTsS9fq6SYwIE5xPTPns
	 L8PONjJwd0nzRKdmVo+TzuE1Uy2QqgfFQu5L5qnTX7cU8eTpLzCnWfSgBpuRThpcuc
	 1fvAE8trLtYre1wvZ4qn9Ym9R09ADQtRoP8US1YKfBCZwv74DycJ/FVq28s3Wf8/+k
	 Sg2uSmta3Ype/VnSxyzr4hwH8KhcQSquiN/OctX/35+NajHRl0oK3o9ZD0gYmgl+ld
	 ru6++4z1bc1MDEeciNL+WOJxJVy3uhmVYB7wCL8QMBzoE+GqdWGHbqUCrHqfLFYjTr
	 lI6/HxuzMyqWQ==
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
Subject: [PATCH v2 0/2] Drop redundant tcp_rate_check_app_limited calls
Date: Tue, 15 Sep 2026 19:19:30 +0800
Message-ID: <cover.1789469930.git.tanggeliang@kylinos.cn>
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
can drop this redundant call.

v2:
 - drop the "Fixes" tags and update the prefixes and commit logs as Jiayuan
   suggested.

v1:
 - https://patchwork.kernel.org/project/netdevbpf/cover/cover.1789368148.git.tanggeliang@kylinos.cn/

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

