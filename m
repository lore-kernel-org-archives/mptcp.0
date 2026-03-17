Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFD3A0E93
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740707; cv=none; b=nNe8c2fK3bUWonlQ5nY3IdksQM+lXmUROblcVjhuBXHOARAkAkmFLnKF+teKi4nfxrU0C/fpta80HbfC9RjVE7auf5r7rvB79FB4Mn9TdVnHVqzFTJFM+MzjkEvLbzOQJ/LBI67yq5D9jgWDdf0JxWLIyv6H7+iGK3xTFfBuREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740707; c=relaxed/simple;
	bh=CYgVF5zY5Rvbg9CPg01AyrtZqoiA5aW2cHJoIC++TkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaQtqcep26Vj+V8UP959Qc159yUaKgrm0DMT5OZemqv48sEsVSVZROINDVszTf2cmhW5jPVCviYTSA8PKrbyRS0jCK3nMkfPfSD67QUpSjtX49smMkRoGNbO4HZkPbn3rCtjwdjrHJNQEWiPpo+Ma0NLnPvpmeDt8OPTLqfcG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8ju/BTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8ju/BTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24BAC19425;
	Tue, 17 Mar 2026 09:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740706;
	bh=CYgVF5zY5Rvbg9CPg01AyrtZqoiA5aW2cHJoIC++TkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8ju/BTW2A7MKi8CAJ6KanehdurXO3Y1i3a4/ZYi2361NA6g4ONebOMKwFCfBs/ZM
	 8q0X0+eQOwP+2ZKrMvyOcZASOCpaEH/wp7hAC/HQ2SU46mw6PJrvkIjqLdNTF7jq3k
	 dDoYBmi/yuQmSOOMtcvr8IRSJ7cfoyxQKVq9hBySAXjHY9zfhHI7FGAZVz9VlB+o5L
	 2zCzqPmiRcM187Gjs0EskfB77dBmGxDLqtChLS3GWJ8FWnBWOFD0JhKO0qXHS3JYGb
	 GrelT+i9UwBztZc9eOLP4Vt6Dffg72SLnI1FrAghuje8M9kYka6dAYp8XYbdlmeouO
	 jt6mnh7fybmqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RESEND mptcp-next v2 1/2] mptcp: check desc->count in read_sock
Date: Tue, 17 Mar 2026 17:44:54 +0800
Message-ID: <b404cbca4b0d30f82c56f65b38e1c2038bd7e5fe.1773740635.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773740635.git.tanggeliang@kylinos.cn>
References: <cover.1773740635.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

In __tcp_read_sock(), it checks whether desc->count equals 0 within the
loop and breaks the loop if true. This check should also be synchronized
to __mptcp_read_sock().

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5676b37f8f4..dc9fdd664871 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4384,6 +4384,8 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		}
 
 		mptcp_eat_recv_skb(sk, skb);
+		if (!desc->count)
+			break;
 	}
 
 	if (noack)
-- 
2.53.0

