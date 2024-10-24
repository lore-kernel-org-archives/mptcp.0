Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2A1CD3F
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738344; cv=none; b=LdcOYqKgCwLKrMcnXX8VM5t4wuxe0XZPRdbHMRnxn9D0oPtRJD5/nz3E+9CZraO1wvJLwSNqD0EY4+oCHUA6M9hOXWoc1Os5enaILE5BOJ1L2q/TIQrrYN4g6rNNSTAFbHMGSkhzCIrjS9gcgyra1spaCQlFatKzv4k5ICZicL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738344; c=relaxed/simple;
	bh=NbnOHO+BntEtJFgdsQz2dac8wIePPluLxW1MSut+Vpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE9ZWyHqqVDcOaM7Y/VdrihrvqfZU/ev74DJEwJ0sxRt2DLK71LaZas7Yk05cKNLOmvo5rfkuoCJNl5ylZ0R+R9Tpnu9VvIP69uei6lFWmB2Xe4adWydoD5tb0G9nHPwOs5r96RS9sddNuCMKWNpiJb1k1door3d4Q8NIk22Axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgzWDJaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgzWDJaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C11C4CEC6;
	Thu, 24 Oct 2024 02:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729738344;
	bh=NbnOHO+BntEtJFgdsQz2dac8wIePPluLxW1MSut+Vpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgzWDJaGM6qJ5HmJY0YaQALYJtsw850wf0pDU9X4nDH6ByZH4M1c5nBBi4/PpeBUG
	 urtJDjD+4T818/cVocS57r7DfM6AM4u03sa3BJD8rNE4co1hU4P0oiljJUav2BTS3N
	 2IgsbrDHmDHHICr2lcrk/0Mya+FVP7jbRVxNGNqc4k6STIwL9c76k4b1qE/lXRJ5hY
	 ksIKcq8Y34MZG33ufBAcjY3UTNzdkpcve4fIPIJSs2EPMCLBb4o3HrtblD+GgHEyBF
	 YseSX8jtJCsKkBkxo8BRJ5p7AvyoKaqUaNbmoyHQFebpa90AZAJXE8RtPQAwPZPQOn
	 6D6LX/Wk6G6Pw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: check sk_stream_memory_free in loop"
Date: Thu, 24 Oct 2024 10:52:14 +0800
Message-ID: <74210f1b5f7eaf02829aec82d995f23589657e6c.1729738008.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729738008.git.tanggeliang@kylinos.cn>
References: <cover.1729738008.git.tanggeliang@kylinos.cn>
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

