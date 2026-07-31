Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6F2D060D;
	Fri, 31 Jul 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507886; cv=none; b=l8hQ22BxFyKBJH0W1BmR3BTp5q2uCEgB1/B7qi1OLDZRmRMdiKsgVJ6i8nuSZGm4fFJay2N5jP84edj/ROMkLHOOMlDxJ8P5SGh/D0UHe/oYbZ5IrlATda2GpbzPzPYE4BN9ISR/8qQuW4dEGbBSOioTQO3yjkiD7awS8j2UVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507886; c=relaxed/simple;
	bh=pPuAPZBOTad69egfVrBpUtU+lJoZGsJ5U6c0dOWoR4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EeeAgkBTX4cWOvUTHEFIiuKwEIhnLI1pVpox/uS3enbtMd7YFChONi9GgjEWtzJPD7/ylAHmu8SdXHxrRqUErgZTlS/C1jVKAU0y761TyhRXJmNZEQPpwO0nPxN9XBBJfk1Thms3tXZTXHv1eqxqhG9/86BhZ7JYGO6eoJFhT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzFnvpa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzFnvpa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61751F000E9;
	Fri, 31 Jul 2026 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507884;
	bh=l1FFNgewqmo5lJDRgOb+ULKjpIIQmRuZwzOlDJQI7YQ=;
	h=From:Subject:Date:To:Cc;
	b=hzFnvpa3jAcJ/mQ3cgMCplJ2RXgZjdyHbeDR+AGQgHyz8WvDosGeyfA6DLjf9+x02
	 9TQG0XhX/ZCpzHqlgWNfWdlMKqNc1RcjhiT74G6hEAnecP9Y6IYnWbVc7eSy1EAtCp
	 esAmwoDxLj2r9KQCwW+Gq+vFnUWT1/8ccp4iOqJpS6E6uBClmovoh+m7ihhK55dlNh
	 bEzvmljI7TL5BAHfxBQEg044BaY1NrF1ixy4zpbdaKooY/F6ItDKEfJ4RD7I5B38HB
	 zahS36f2IfF+A27fF/c63G14udeFsE50erjAm1uomcVxSikHOSE6tGHv+WMTlrQgXu
	 32k98TT00S92g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/5] mptcp: out-of-order queue pruning
Date: Fri, 31 Jul 2026 16:24:16 +0200
Message-Id: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ7CIBCEX8Xs2TUUKRpPvofpoYW1xR9AoE1N0
 3eX1nj3MIfJ7Hw7E0QKhiKcNhMEGkw0zmbDtxtQXW1bQqOzB864ZAcu0FLKGhM+fVIenXMv9KG
 3xrYojqWUumC60QwywQe6mnGlX+BXhOqbxL65kUoLfLntTEwuvNchQ7E2/vo5FMiw1FpoUnJfl
 +J8p2DpsXOhhWqe5w+lECPL4wAAAA==
X-Change-ID: 20260724-net-next-mptcp-oooq-pruning-48566d10dbd0
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pPuAPZBOTad69egfVrBpUtU+lJoZGsJ5U6c0dOWoR4w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyNqhU7E6XjlUt5fp8n/PGKpGSsI8vhE64Trmfa7Jnm
 T37LPknHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPpWM7IsCDfd+nd5dYLHiwp
 PJSW6f05vZ3/j2Vs5EyFq8uvhHjJhjMyPL9dcPTbE9VEfcfW3ik9IZVnJ9rfLd1+JPq10IqD68P
 CGQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Under memory pressure, a pruning of the MPTCP-level OoO queue might be
required as last resort, to avoid too long recoveries, or even stalls.
Geliang and Gang managed to reproduce this behaviour, and Paolo
improved the situation thanks to the following patches:

- Patches 1-2: improve the MPTCP-level retransmission schema to make
  recoveries from memory pressure/after MPTCP-level drop significantly
  faster.

- Patches 3-4: make the admission check way stricter for incoming
  packets exceeding the memory limits, with some exceptions for fallback
  sockets.

- Patch 5: implement OoO queue pruning for MPTCP.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Address comments from Clashiko.
- Patch 3: typo, comment, bump TCP MIB counter.
- Patch 5: uniform MIB counter name.
- Rebased.
- Link to v1: https://patch.msgid.link/20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org

---
Paolo Abeni (5):
      mptcp: move the retrans loop to a separate helper
      mptcp: let the retrans scheduler do its job
      mptcp: explicitly drop over memory limits
      mptcp: enforce hard limit on backlog flushing
      mptcp: implemented OoO queue pruning

 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  32 ++++++-
 net/mptcp/protocol.c | 251 +++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 219 insertions(+), 70 deletions(-)
---
base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
change-id: 20260724-net-next-mptcp-oooq-pruning-48566d10dbd0

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

