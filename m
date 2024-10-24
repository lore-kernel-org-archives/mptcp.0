Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3C3399F
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765368; cv=none; b=DJzeS4KUdgwRbZcqTBVlE1sihQYbpwLltYYETIIumWsYgC7nlSKZ/jXeTNYKPcOjymF5fWMZRqv88FAxfH/oInTeds6FYAqsvu+yAqZRCuxo67phqxzmg2WBY3WzZ2nJWwAh0cqXHs2BvUlfZmiDCJ+CEehdLv/w9pdNbfL0q20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765368; c=relaxed/simple;
	bh=NbnOHO+BntEtJFgdsQz2dac8wIePPluLxW1MSut+Vpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvYWAPKdybbvdMUFztePJLAs99yVD4UZxWMdHcWhttmUYauIymW0D6rUU+9wMm78y6NNNTaX+C40VhKl0U59ubVtJptHo3mBO3GaashBBtwsC2uOrBhSI+pnmsmsV1c3REmBmNxz2/N0bDK4ZyY2bu3XvjkVz7QZNuahzMu3T/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgicaJBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgicaJBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27146C4CECC;
	Thu, 24 Oct 2024 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765368;
	bh=NbnOHO+BntEtJFgdsQz2dac8wIePPluLxW1MSut+Vpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgicaJBGnQ8qeyxAle7IkreGqW8src9zAXMgr/a7VQBEqyWkrYxKd5AmgeaRj5oLM
	 bu3EMY7P19wprJ+ZdIEkuhi4GIzUk4MyFSJyAKpEJB0f/NEfZAnuqhLGgvodBoAsv7
	 ljRAdqleBB5hB8fXq6fSxpzvHzJGWaenDqPHNsZFoEErWbMzBN5u2Jz5bdcM+1h3eV
	 rlZdK3lYLY9wDLiZtNerXHpsnVk2z206P0xG8WaYcPW9lR2JsT1Io7W3whjGtBMX1h
	 UTN3Av0JHzPQOwxPEeX+F2CQGYyiUK0ZR4tLkXP9eP2/JoUvPU5LE+Li0Tkw1RTNB/
	 +wbb8CWSW7DTQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] Squash to "mptcp: check sk_stream_memory_free in loop"
Date: Thu, 24 Oct 2024 18:22:02 +0800
Message-ID: <664f278b99385aa3d539d07e1a16ef2598a800de.1729765157.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729765157.git.tanggeliang@kylinos.cn>
References: <cover.1729765157.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix mptcp_join.sh (22) and packetdrill errors reported by CI.

Move sk_stream_memory_free check before "send_info[backup].ssk = ssk".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f36e63b84b88..2ae9b8012dcd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1444,8 +1444,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
-		if (!mptcp_subflow_active(subflow) ||
-		    !sk_stream_memory_free(ssk))
+		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
@@ -1461,6 +1460,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
+			if (!sk_stream_memory_free(ssk))
+				continue;
 			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
 		}
-- 
2.45.2

