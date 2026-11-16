Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841119;
	b=gZ+MvGz0aATG8cXQIDOZp2ciR9/yBiCxMV5ibnV6NCSXVPCtbl8HpppPVxO6ReMx2FNd
	 UTZlHXwiGFP7XmXFoFemutuKH0Tpz6df4x1X5nlBofmQ2fH+xKFTxfsvPJeaHlFAA+0FV
	 +c1qCUCxsU9sjvQLlTbFpwnaBuibSLMF3BLN2p316hnFz6a7WhKUcQmbkIaBVaYVcXAt3
	 tf45IkcmPYN1CufF3uy98sVM0NE3GA6Z8RdgQvsE7zNVZGg63qjG0W7BIZt73cnmIeH9d
	 uN568C5a0Hb2vbs+9JN16tczHTHWz4+iFP+9a3SiUmAsCISiiKjdHkJSrtCkz6lvb2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841119;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SfHYqP/pPKPSLMNVoIqnPXnOAyAQwBTQuGj/nWRAdUU=;
	b=3YXyhQbbjXm1Zcb7E9tf4hqhdTbWAE6x2dKY8r5Qm/7hNnYWkeK6GhHqLRcQ0x741A1e
	 djDTNdgrtcy0Fhcd6ZWKUC0onbXJvE50ySjLxw6iPG2az6+x2h3/TREWz0RDqHnsle/Sl
	 aYZ86sg7nxhZd034etjj33r48kmnQVZFDdiC+tP2vkK+pNm+Ln7SkaNMNGS7D05vWo6vt
	 U1xozUowd19F5BfpW6HNZRyuJf8vSjEjZDJu6vYfVlwR1MZT4Qzfo7BlwagTj3JG5w/ZJ
	 eJkUVQQfPUcsgirTlbXHjwzWj9HQiGGDdAs1sGIDxY7ekBkAVwLFBsZe82/0Kyi0FmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=wvdw5KSd;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B1606A333
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 14:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A6B1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=wvdw5KSd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794841115; bh=SfHYqP/pPKPSLMNVoIqnPXnOAyAQwBTQuGj/nWRAdUU=;
	h=From:To:Cc:Subject:Date;
	b=wvdw5KSdMKWbhHzIdky1DEj9qS1Q5g9kHAQhisu0OefgG5ZzsN8qHxCC1glLFL49x
	 pzy8udqsFNk4SFN1gI46UFXpW/AruwbWLs5maZjS3mRu9EoKMaNpLEq1mZXRN9rkll
	 h9rJZJp6WtxpvrUsG9iEkY1Yu8vRSMqTuiPvfKWA=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:2979:aa1c:9ec4:8698])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E9E14C42; Mon, 16 Nov 2026 22:58:30 +0800
X-QQ-mid: xmsmtpt1794841110t8q3g5kej
Message-ID: <tencent_50E9A78F95855D54DA67136F3D8520017F0A@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+NsHQm9vJZQmptPt9GNOWxD7iXpUcoo6loT44SU0DGu20yE//hU
	 WFcWzvlaGkLBImrkL9KDoiHzZzP9Ht/I0qvvW2TRNhiuLm40REdTLSe0Cc7LlZKuHLcWOsFR2p3O
	 Ss28vXoJW4If57TbxRGFHiHK49ekTEFt057Vq88BOncxhtYP9k0hSd8r6DIP0l29BxkUS6ePlcg5
	 WnIYbRLn4fduWpn7ss7i0YQT3ArOP7i90rOp/o5Hh1d/3Fig9GV+j0dRtcHg8RJhRHXUYa7/HN7d
	 C0g1y+AyXYaipv/htE1vsX30e850cJX4ORFaxRP2IDUu7s/NZzJJwB6tx7t3nJoRBln2mzIEaWKj
	 CC43A8wrI0N0sL5vDkWvaXprAN9KVZxmaZlo4jjovu/YmOJ2tTwPBcX7vpbXHFX89bz/xM4I2Db/
	 Ss8/AU4KZ01Qtpdu2kwoxslBhuT0lL8MLZmtj3vC+f/cujJHH1Y4TwbWhcPN1NrVdxszGTr7S2S4
	 TqBK2FYddrfT2eELCza2osW8Aguv5msfOL/HVzUXxcd5gfyAhuaxSkvr+2bn+o4uIT0NpKKzEOaQ
	 z7G63qFSPuC1KN7X18Vj8igVgtMN/sOz1pLCpcYejCms2vEAaQV9pH0+sBmMO2mR541jXepM6AaN
	 7ZF0neDd5y+KRIzxl9+Kp5DrF4MU5kVAHWa7lpJX+gl+rCfzltrhL1q6UXRekySHuIUlTebc/mdN
	 odJoYTYYFCTvSqxa7fHggqlN4zTmtiIZXJmsHlLce65vPtU1/KL5UeX4cVAKU7cJ2S7nQoCJfYfN
	 Pd3dUVkelvTqVp4zMTBoTsOAovPHQRFaw76HQHgFxmDB0CoX6fCNNnmv8C+Qx1naZ6ElciorN71f
	 x3J1H6FyGWE8A/x/pYvaYeMWZbmNN23/ziN6ASg8laOU9M3L97zArkXIYwYR7L4tKOk8hhbftknb
	 1qvzbEsajlkueHPY2GO9LbI7RjZAfDnsbFxPPu/DIPHqOWHUM+M+YBrHMAIofRCtqeMfgDUv1Vbi
	 s/17i/PURSksKpLu586xGt/JvxS4V60kHuNLop8KEHH2kiGaqZyS6d10Hg6NtNBuxLEl5HP7W2z7
	 X7M0XjpM9harDlPHBIO0yfx/D4IQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v5 0/3] mptcp token hash ordering and token 0 lookups
Date: Mon, 16 Nov 2026 22:58:26 +0800
X-OQ-MSGID: <20261116145829.96849-1-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NanHang <2122295973@qq.com>

This series restores acquire ordering for the mptcp token lookup and fixes
two pre-existing defects in that hash table which ordering alone cannot
cover.

Patch 1 converts mptcp_token_get_sock() and mptcp_token_iter_next() to
refcount_inc_not_zero_acquire().  These sockets live in a
SLAB_TYPESAFE_BY_RCU slab, so the re-check of msk->token and sock_net()
after the increment only rejects a recycled socket if those loads are
ordered after the increment; without the acquire they can be satisfied
before it, against the previous owner's contents.

Patch 2 rejects token 0 in mptcp_token_get_sock().  Token 0 is never
assigned, but it is what mptcp_token_destroy() stores into a socket being
torn down, and what a freshly allocated msk holds until it is hashed.
For a lookup for token 0 both validations compare 0 with 0 and accept
such a socket; the token is copied from the wire by mptcp_parse_option(),
so a peer can ask for it.  The join path then uses the result, including
msk->pm.anno_list, which is initialised only later.

Patch 3 makes mptcp_token_iter_next() re-read the token after the
increment and drop the socket unless it is non-zero and still hashes to
the slot being walked, so a socket recycled in the same network namespace
is not handed to mptcp_diag or the userspace path manager before it is
initialised.

None of the three has a runtime trigger.  Patch 1 is argued at the
instruction level (on arm64 the CAS becomes CASA; on x86-64 both variants
compile to the same lock cmpxchg) and KCSAN cannot observe it, since it
does not model reordering of marked accesses.  Patches 2 and 3 are static
arguments; patch 2 now carries a KUnit case that fails without the guard,
which is as far as the state can be constructed without the race.

v1 -> v2:
 - Point the Fixes: tags at the commits that introduced each lockless
   lookup instead of at the refcount consolidation (sashiko review).

v2 -> v3:
 - Rewrite the rationale of the ordering patch: the acquire pairs with
   the SLAB_TYPESAFE_BY_RCU reuse window published by
   sock_init_data_uid(), not with mptcp_token_destroy() (sashiko review).
 - Add the token 0 and iterator patches, reported by the same review.

v3 -> v4:
 - Drop "net: core: take the reuseport migration reference with acquire
   ordering".  reuseport_migrate_sock() does not validate anything after
   the increment, and the listener state that could be raced is re-checked
   under queue->rskq_lock in inet_csk_reqsk_queue_add(), so the acquire
   orders nothing there (sashiko review).

v4 -> v5:
 - Add a KUnit case for the token 0 guard, as asked by netdev-bot+sinfo.


Hang Nan (3):
  net: mptcp: take token lookup references with acquire ordering
  net: mptcp: reject token 0 in mptcp_token_get_sock()
  net: mptcp: verify the token slot in mptcp_token_iter_next()

 net/mptcp/token.c      | 13 ++++++++---
 net/mptcp/token_test.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.47.3

