Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A93398E
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268655; cv=none; b=OgXLLSXeURlN58dOtgAJQdYh52OPhjyP8BXxOHRsq7kPvOx1EmKmdZQP7PyY0DN4rAw7MKrAQ/Q7Ovi1ZdvrUOMS8XRPXoJKqtZpfG8FaMJ4VTw/zGzl4amd9Nh6ax98TCqgwyCD610sJJfuucMUF1F8TH5G/654qA9LHKxuP8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268655; c=relaxed/simple;
	bh=qr2KDiGNOKDo25wAnh6k8E0UvGHjTRgmthFXxzi1AN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GggWvfUgMqG1G32OohtQfe/j1F638mgJ2dzzV7sbPx/Z2WtoM/YqS/6QVmZBf14P2exT/3/n8OgCZIj4Mso4V5jZxQnsk93tX0Vss+qm60bHnS9VOXbVlxk8gkQiBw6jTWi1yQVjMIYRr6wq1ysRkvMyAMzHYXyktMaXCAvcUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzDa4+2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzDa4+2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A65C4CEE4;
	Wed, 30 Oct 2024 06:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268655;
	bh=qr2KDiGNOKDo25wAnh6k8E0UvGHjTRgmthFXxzi1AN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZzDa4+2eW+6lwA5z2tkB8umZQVPciNOB8f4riVaR8SNHM8ACmgjoanhxv1vQ65ovu
	 epay7o9TaUwqa+e/3weHyafouI0Z2WWKcParSTRr6hraSjnJkwTlHFQAqmDHsHxy6E
	 f7+yGGD8U8Wfvlb6iRYqcMBnRNRm457DHc7lafzy6kKHWE8sTV09pldZR2q4WLAyqy
	 SJElZZsuoYdAxx+C4mteSXmHrTFQ7UGTshBTM4y6Dxnv1N5dHfLtE5M8CXedRY25kP
	 inSyog6pA1ybfpr3e7ie0qVezv1hYbDamqUfEcB/CU58eJ3I2VZqWzSimaE50Ku6Tn
	 WkU/bM7wPMrUg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 01/13] mptcp: check sk_stream_memory_free in loop
Date: Wed, 30 Oct 2024 14:10:25 +0800
Message-ID: <85e54452f647a887cdc1643629d06e017c3eef54.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to make it easier to implement similar logic to the burst
scheduler in BPF program, the sk_stream_memory_free() check is moved
forward into mptcp_for_each_subflow loop.

Assignment like "ssk = send_info[SSK_MODE_ACTIVE].ssk" is not allowed
in BPF, so bpf_core_cast() is used to cast it. But a casted pointer can't
pass to a kfunc (sk_stream_memory_free). To solve this, In BPF burst
scheduler sk_stream_memory_free check is moved forward to the position
before "send_info[backup].ssk = ssk;" in bpf_for_each() loop.

To keep mptcp_subflow_get_send() and BPF burst scheduler code consistent,
this patch also synchronizes the change in BPF burst scheduler into
mptcp_subflow_get_send().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21bc3586c33e..2ae9b8012dcd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1460,6 +1460,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
+			if (!sk_stream_memory_free(ssk))
+				continue;
 			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
 		}
@@ -1482,7 +1484,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * to check that subflow has a non empty cwin.
 	 */
 	ssk = send_info[SSK_MODE_ACTIVE].ssk;
-	if (!ssk || !sk_stream_memory_free(ssk))
+	if (!ssk)
 		return NULL;
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
-- 
2.45.2

