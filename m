Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254170;
	b=rIBeTrPOirqQtc16TmD0K1BB3DIR7Gv0J91ZcAubafitd3kTJaNvp7e5Fx2rtMsOux2Z
	 OKrqZIo+9mSL34V0CtN/voIrmJNiFLmJokSGjxCIIPosMQqng/IECGeD5wtcFL9m/QkZ5
	 +ZLO5g2FTPpWQ/3EkpaGnaLhxgglqSlZYT/q82WZAcRlDjcXVufH8zxiFZ98HujkK4gih
	 qd1P8e2y5r0XiQZBXS/hNse3hjg5W8GXUuyL5n6gfnL/2fRAI1+x2zuP6j1TbYbl/sN2+
	 MAaNahZr9fo/iVT5OSR5npA9VeCgChH+VCHfPuWYzo1EmhxXwhzPtuSRDIXD1OOGALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254170;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CBbmcC3SquL/sUh0/0abO4UmG3Cbv//EVoTMLeRnei4=;
	b=LB32NziSiNVS4p6Tnw8SnUQO4ELR8ZqWn7V/m5EoozRbF2fAGrUQmFPTlXl2jYe1DkGZ
	 iXJNJoUKEbT/5f+yQ/z/YeYvorbeJC6tnSCdkO6TeIXEhhAlg9fpihcbtNpUSO3yzUfVs
	 OfvaSdJFANLLv/abNJSAXnuKyJloWTq2jXvF3SY4mYjZZ2aHxuAzS+y8w/dtOwRg0nEqp
	 a8ALrlRwgBKrfZZwt6shaAtXmqnnHAMPOOa2WN1Eb3FhiFAfc9FiQemIQ+17j3wYPve7y
	 PCEsKzejthK9Ohn3i1hwmIgtvf7bNpLWBv9pZ0srynhB8QumD4JsvNrZZN8epVjJgVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNqK26TI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B6606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNqK26TI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A39C1F000C0;
	Sat, 21 Nov 2026 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254170;
	bh=CBbmcC3SquL/sUh0/0abO4UmG3Cbv//EVoTMLeRnei4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mNqK26TI3hQVXeB3oUOWRlcoXSt1DV6ZI3PCnqjK3VYK10tqIMOVohOdYcazD0Oge
	 7VUMoAILBTNNkJ4WH6GJfMJ73vRtIdoVOAShJ1s/KOmpfufmNss/IJ8SpQIVDM2IcU
	 o1ALz0kf0A6cTSKwFKeGmVcbrOpNPGU6d0uwkT9p8I2K2p2qmrObBetR9UTNCbT/y9
	 UB0jUm9y2I0wxkLq9tfJa3dcMR6FA0MEya/bSDcbDotnlalSlCaVFaM2GyOq/gUu9R
	 KKFE2/IcCo4zO9CaFWdF5w6BZO264pwZ8ewSoHKdHxfiCwYAheva5kBPEzZr/pZF5g
	 1+h8AJaXhIKzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:34 +0100
Subject: [PATCH mptcp-net v2 36/62] mptcp: pm: kernel: count endpoint
 listeners as sockets in use
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-36-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kyuwon Cho <kyuwoncho18@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OPRvotvx8HNkyVDGOs6cqb6T0ZZWlYYOMAuy5o5R+7w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ05MvKrcd6dLM3mGlyCaa1Fq042rd58lTmyWe5Qbf3
 qZUqMHZUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBGXIwz/TE3ZXh0LurFmlSFT
 eLJkv0PXkVcyX7hNOiztLSPldE+dYGRYlfoy9aPyg1O7NjfKdC6+9je105rvkM2tefbMoS7ahww
 ZAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The listener that the in-kernel path manager creates for a "signal"
endpoint with a port is not counted in the "sockets" column of the MPTCP
or MPTCPv6 row of /proc/net/protocols, but it is uncounted when it is
closed. Each removal of such an endpoint then hides one MPTCP socket of
the same family from this column, for the lifetime of the netns.

mptcp_check_listen_stop() decrements this counter for any MPTCP socket
closed in TCP_LISTEN state, and mptcp_listen() increments it when
listen() succeeds. But mptcp_pm_nl_create_listen_socket() sets its MPTCP
socket in TCP_LISTEN state without incrementing it. This socket is
closed when the endpoint is deleted or flushed, when adding the endpoint
fails after the creation of the listener, e.g. because its ID is already
used, and when the netns is dismantled.

Nothing depends on this counter, it is only displayed. But it is wrong
once such an endpoint has been added: its listener is not counted while
"ss -Ml" lists it, and after its removal, the total is one below the
number of MPTCP sockets of the same family in use, a negative total
being displayed as 0 by sock_prot_inuse_get().

The counter was introduced by commit c558246ee73e ("mptcp: add
statistics for mptcp socket in use"), when only the subflow of this
socket was in TCP_LISTEN state. Commit 57fc0f1ceaa4 ("mptcp: ensure
listener is unhashed before updating the sk status") then set this
socket in TCP_LISTEN state too, without counting it.

The fix used here is to increment the counter when __inet_listen_sk()
succeeds, as mptcp_listen() does. If it fails, the subflow is back in
TCP_CLOSE: move this socket back to this state too, also as
mptcp_listen() does. It was left in TCP_LISTEN, which triggered a
warning when it was released, e.g. after a socket in TCP repair mode
had been bound to the same address and port in between, as reported by
Sashiko:

  WARNING: net/mptcp/protocol.c:3542 at mptcp_check_listen_stop.part.0+0x4f/0xb0, CPU#0: ip/2816
  Call Trace:
   __mptcp_close+0x2bf/0x310
   mptcp_close+0x23/0x80
   inet_release+0x43/0x80
   sock_release+0x24/0x70
   mptcp_pm_nl_add_addr_doit+0x266/0x3b0

This issue has been found by an AI code review agent, while reviewing
the code of the commit "mptcp: pm: don't let listeners pin their netns",
and confirmed with a new Packetdrill test, and with a shell script
adding and flushing such an endpoint 3 times in a new netns, then
creating 3 MPTCP listeners. Without this patch:

  kernel_listener_inuse.pkt:15: error executing `test $(awk '/^MPTCP/ { n += $3 } END { print n }' /proc/net/protocols) -eq 2` command: non-zero status 1

  inuse: endpoint 1 present: 0 (expected 1)
  [...]
  inuse: 3 user listeners: 0 (expected 3)

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
Closes: https://lore.kernel.org/mptcp/179502042942.2742790.17887994424282536144@gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: count the listener once listen() succeeded, and restore TCP_CLOSE
    otherwise, to avoid a warning (Sashiko, then reported by Kyuwon Cho)
---
 net/mptcp/pm_kernel.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 2680d4672d58..73261685ae4c 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -915,7 +915,14 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (!err)
 		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
 	release_sock(ssk);
-	return err;
+	if (err) {
+		/* the subflow is back in TCP_CLOSE: like in mptcp_listen() */
+		inet_sk_state_store(newsk, TCP_CLOSE);
+		return err;
+	}
+
+	sock_prot_inuse_add(sock_net(newsk), newsk->sk_prot, 1);
+	return 0;
 }
 
 static int mptcp_pm_kernel_get_local_id(struct mptcp_sock *msk,

-- 
2.55.0

