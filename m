Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD533D4E8;
	Fri, 24 Jul 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901757; cv=none; b=uFb12pEl9Teic+OVeOFWLByPW+w3GXXcWAx7IsZna/bznqC9ueRfHU78H5w0jYshJjC+UA89lwX08ZAAKCIps2R6+lR/NcjhcmcSzVm00X62KboN7S4i+q32CZiuMo+iP0hlRYq7tOnuWBPHQgt8oH5169/6Ox9DCpajD87Rfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901757; c=relaxed/simple;
	bh=8Xoo5J/kqs1bn2BjbuLUR1h6eE8WpaD5PafID4BztfM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pp7t4FyUGACfKBMKRqlut3G3+6Ot+cMsKsNmPVmIQPnQeiwtmy/w3IFYT/HST/nXFMMx6TG5hZHMb2I/QTwW2dv77HuIecFyYz/94jSuFxU+EHMLCHBEzZdJQ6qLiA+yqdPjCA5+Ij7MG5OifLex0XG0vlXlRugganHPeTEd37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHoFPVaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHoFPVaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1686E1F00A3A;
	Fri, 24 Jul 2026 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901756;
	bh=z8KlqnW4nrudOlZ8GvMDV483UPf/PVzWCDDUWxT+exk=;
	h=From:Subject:Date:To:Cc;
	b=nHoFPVaPOpASkwNLY9+fF0Scd70u8qwxAFHdCdPmKLOgR1VMJAWdrohfaFgGAviMG
	 KeoVunSwnLtC68Lt0dNa0ra3a49hHWJF+uxwqp2HZO0sffUVJJlGiSG12eAbRYAFUW
	 zVqE/muH3M6F3m6LJYkebxieQAtYK6Ec5z3KtNgP70qpyMo9PORiBO7Zcmz8FE4zz3
	 +b7PCTcaTlkNAX2xXsTEOxByLsDPX2EEQ5m4qOfR6zIXI6kuQZ/U/ehTmXh//DU7zh
	 bd7CaBVUhnnNDWnktirHjuyVP8KfJn0kt1olzof80gqLy9zZgvO/jjiMPIMxiZW2fy
	 c5/HtxxdyL03g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/5] mptcp: out-of-order queue pruning
Date: Fri, 24 Jul 2026 16:02:12 +0200
Message-Id: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMQQqDMBBFryKz7kAMNpZepXShyagjdJImsQji3
 ZtWXPzF4/PeBokiU4J7tUGkDyf2UqC+VGCnTkZCdoVBK21UqxsUymVrxlfINqD3/o0hLsIyYnO
 7GuNq5XqnoBRCpIHXf/0BpwjP40lLP5PNvzjs+xdN+zj+iQAAAA==
X-Change-ID: 20260724-net-next-mptcp-oooq-pruning-48566d10dbd0
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8Xoo5J/kqs1bn2BjbuLUR1h6eE8WpaD5PafID4BztfM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKSC0qX78u3SjW8bPnbqfnK3q87fjLPnPnlxe45392sX
 RL3moc+7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIjB5GhsfnWc0vVIUGzfT7
 0H6naNvKKqmDUY6by0SFpTfs3r17qhsjw7OFt3Zt3ftdy17y7TbOz8bS56ITNDgfBm5lnWj2+v7
 ecF4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Under memory pressure, a pruning of the MPTCP-level OoO queue might be
required as last resort, to avoid too long recoveries, or even stalls.
Geliang and Gang managed to reproduce this behaviour, and Paolo
improved the situation thanks to the following patches:

- Patches 1-2: improve the MPTCP-level retransmission schema to make
  recoveries from memory pressure/after MPTCP-level drop significantly
  faster.

- Patches 2-3: make the admission check way stricter for incoming
  packets exceeding the memory limits, with some exceptions for fallback
  sockets.

- Patch 5: implement OoO queue pruning for MPTCP.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (5):
      mptcp: move the retrans loop to a separate helper
      mptcp: let the retrans scheduler do its job
      mptcp: explicitly drop over memory limits
      mptcp: enforce hard limit on backlog flushing
      mptcp: implemented OoO queue pruning

 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  28 +++++-
 net/mptcp/protocol.c | 251 +++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 215 insertions(+), 70 deletions(-)
---
base-commit: 89d8006259b81dd25c962f6cc8d7ab268d6ea426
change-id: 20260724-net-next-mptcp-oooq-pruning-48566d10dbd0

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

