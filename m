Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006297;
	b=KiDbkqelvLhngxFQp5lDNTgoKGuBdV3W8TY48kCfl78zMhy+ywxRi0wJtFRj/sWgaiDJ
	 Ife0sJwLvkUYZtD2AO/L1m2wkpcUABQ11looEORmlAifmL0V0btZAFhvyLf+lKK6kJCcO
	 lK1ntcIv4Zhzd4NPUIECeUq2QfZ/dkTBu3da9ue1K1l9U4r6LH6iS7C7SRCJn/StIjOD9
	 rC5kQHu0jsKQVU4yJPTaVhH5ymEuWC73rgMtuOe1Ae+r5AHh4O2BMcEyJIRIuhnfGF5sW
	 WrDfeT7unFagG5VAXaU+SuE8Gmgb/Mpwu7pFtf8Y3VQlgYMF1l43hei4K4CJny/nuxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006297;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gEG1LchJUYxB00ZriwlkYxRrrJAQDC7vzdIFJhfY1CM=;
	b=ENBysajuD1kAGQRRJlX8molIZb5hva7Diqyg7mRMfHGNh1JI0WHl/yhj+DjlJUlaLX00
	 xaoKuKk61RERgTtbSAgJcUTdr9eYouatVb2l0jbLyNm82yNeozrs7cx0//lzAIgJmhWco
	 MZFYWnvanZQ1fsDkxg4wnr3Z3pn1Q0W5hn7zU47HIk3h7RO9adx9uCU5xE+jlQGElKJBS
	 DZJYiscElxLCTA+sWAMmnVJN7Kl4PH0v4aCbXJMNJXAAu7tQP86/cMyFkzjmZLBDwsB0m
	 c2xrijmYw6yCGtu/pqXaz1gGZPovJfvWqOJx8r7mZmn8DvQfIOqR4gk/gqIA+eqQIdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="pXj/PJgm";
	arc=none smtp.remote-ip=95.215.58.26
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B9606A32A
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 12:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8B9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pXj/PJgm
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Yygq9mcJfKxqI8xXeG8WYqVlDUJnZZM9AFiq2bI6S5g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795006294; v=1; x=1795611094;
 b=pXj/PJgmCAjAqqg6rtZXrljx2AsfARXdFumguOXE02OrZr6gerXsd4T2E/R5tL+XKWPc3zxp
 LsHUezXlFy4vjuN0m0l3vNX+iwqqPqej26IFNOfshPx2dmYhhrOin4e8Ow7EQlHwYt4yxVs3Tsm
 9LrXXg08ynnlnE+hrcAKzLd4=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c61f9ec1859cff73;
	Wed, 18 Nov 2026 12:51:34 +0000
X-Mizu-Trace-ID: c61f9ec1859cff73
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	stable@vger.kernel.org,
	pabeni@redhat.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y v1 1/1] mptcp: fix UAF of child socket on listener close
Date: Wed, 18 Nov 2026 20:50:31 +0800
Message-ID: <20261118125032.200934-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118125032.200934-1-jiayuan.chen@linux.dev>
References: <20261118125032.200934-1-jiayuan.chen@linux.dev>
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

mptcp_close() orphans the listener subflow before inet_csk_listen_stop()
runs on it. A child created in that window inherits SOCK_DEAD, so a
following RST frees it while it is still in the accept queue:

close(listen_fd):                            3-way handshake & rst (plain TCP client)

mptcp_close
  // mark ssk as SOCK_DEAD
  sock_orphan(ssk);
  __mptcp_destroy_sock
    // ssk in conn_list is listen sk
    __mptcp_close_ssk
                                             // in 3-way handshake
                                             tcp_v4_syn_recv_sock
                                               // inherit SOCK_DEAD state from listen ssk
                                               inet_csk_clone_lock
                                             // process RST
                                             tcp_reset
                                               tcp_done
                                               // sk is SOCK_DEAD
                                               inet_csk_destroy_sock
                                                   sock_put(sk); // freed
      __tcp_close(ssk, 0)
        // free child
        inet_csk_listen_stop()
            process child        <==== process freed sk

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 59 PID: 404175 at lib/refcount.c:25 refcount_warn_saturate+0x12e/0x150
RIP: 0010:refcount_warn_saturate+0x12e/0x150
Call Trace:
 <TASK>
 inet_csk_listen_stop+0x3e1/0x530
 __tcp_close+0x3bc/0x440
 __mptcp_close_ssk+0xb9/0x210
 __mptcp_destroy_sock+0x11c/0x280
 mptcp_close+0x25d/0x3b0
 inet_release+0x44/0x90
 __sock_release+0x42/0xb0
 __fput+0x98/0x270
 ____fput+0xe/0x20
 task_work_run+0x6d/0xb0
 do_exit+0x1e7/0x3c0
 do_group_exit+0x3b/0xb0
 get_signal+0x17a/0x940
 arch_do_signal_or_restart+0xba/0x130
 exit_to_user_mode_loop+0xae/0x160
 exit_to_user_mode_prepare+0xad/0xc0
 irqentry_exit_to_user_mode+0x9/0x20
 irqentry_exit+0x21/0x40
 exc_page_fault+0x93/0x190
 asm_exc_page_fault+0x27/0x30

Unhash the listener subflow and drain its accept queue before it is
orphaned. No new child can be queued after the unhash, and the ones
already queued are not SOCK_DEAD.

Upstream fixed this in commit 57fc0f1ceaa4 ("mptcp: ensure listener is
unhashed before updating the sk status"), which does not fit 5.15.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/protocol.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f18dcb8d..f1122038d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2834,6 +2834,16 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
+		struct sock *ssk = mptcp_sk(sk)->first;
+
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			if (ssk->sk_state == TCP_LISTEN) {
+				tcp_set_state(ssk, TCP_CLOSE);
+				inet_csk_listen_stop(ssk);
+			}
+			release_sock(ssk);
+		}
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
-- 
2.43.0

