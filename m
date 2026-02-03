Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FBB665
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090479; cv=none; b=czljhZTYy+vFQTDAXQ48ccZ+3tKIH2fGt2CPHkx774N2Buc7ugrxkMd3AbydEj1sHXQ7FU29VsNHM5MQz7XXjTve5w2UmppDCDLPPpJ+3+GPxbzMTjNa7q/jA4neTMAybL3wH88ETTKKmNBOLsV3UI2ibvcb0fHAq7mfykYxiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090479; c=relaxed/simple;
	bh=vov6tkqC87cnSOm8by38/8go1MTToOlVyH1VKguG0gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JS6zrozWaqSTpSZwZCKBAFNnn0zPoX12zTZZ/GSKwrxMPk0pDt8rJpNG/3M8K/bNM6RkFMrn+Jrhc2Ic/OOiX7RouU1wGZHqLvGXvAkEUoorLw9s85e4/ZZ1xH3s1QaLt9GwUfvsbaKs5DXqbo5k4N88BqOUcK3y/gqIJDeYHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abA1YyLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abA1YyLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2862FC2BC87;
	Tue,  3 Feb 2026 03:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770090479;
	bh=vov6tkqC87cnSOm8by38/8go1MTToOlVyH1VKguG0gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abA1YyLmrlwkmyttZd77Pu165vZ9lVF8AqrFZZyyowNbQLsRl22hA9uo00JlFzRmi
	 XzosE9Dk0zCSCOBzcVZPAWRPkfl5TKj10LSK0UH6xwdL30JgnMFDSSWwShouWXDvkS
	 oPnAQyl9yLD7AJmACdvXP5XQxcV8wkY0H6GOg2+sUKSaORMqrUqUlJzmWxKhTruy4C
	 NYRzoJiAtYuX3TknXW5swdNE9gVFPZptcMwQ4khXk7DZaxXrC0XBpvv0XzNQ/zB4l4
	 PXWaNzDBpqMv2X8kWskuuLS+yR9cCwIXuZzqsQbWCz6rT6erGl+Y5NRIZswEIys3Zo
	 rlMgTkt9YocOw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v2 1/2] mptcp: check desc->count in read_sock
Date: Tue,  3 Feb 2026 11:47:44 +0800
Message-ID: <ff0fef09d4b3416b585c7aff4c59762bc609bf32.1770089761.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770089761.git.tanggeliang@kylinos.cn>
References: <cover.1770089761.git.tanggeliang@kylinos.cn>
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
index c88882062c40..fd9a574d1dda 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4382,6 +4382,8 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		}
 
 		mptcp_eat_recv_skb(sk, skb);
+		if (!desc->count)
+			break;
 	}
 
 	if (noack)
-- 
2.52.0

