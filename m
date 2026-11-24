Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557686;
	b=SJTvTNuCUgb0IjuQ4rZQYbEUjC5a0vkU95QPnSGYGO6qWyhoC7M1LK6jTuwMbsX+Jdqf
	 AnB9t+8IDZbkqFSaz1lU4bee/sMemWQ/c9qOzl2qjccfZSPccWgu+9CW8xKLimern31lG
	 ao0XtahJSN4o9gtwPR2XCNmNmRAKhVKFSlOg9isolv0stPA6Ai960V1PVamqgUfbWcbM3
	 UFqIo8m8PG7peWppkUbvmh0RAHdl7FtWj7vOKhpYtCBouSkzMCgt1KegRMjgisLJ6kvpq
	 P+2vUQtIn9guCPp7ijoLH87SHXlUNedBMfE/WB/4B2+MiUm7Pd/BW/Z7Jt+d1wxDcvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557686;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CBbmcC3SquL/sUh0/0abO4UmG3Cbv//EVoTMLeRnei4=;
	b=PatqXcdRnJq5ENTdnPuK6DZ5B6CPNTi5+LXAtWG5w82wokIjZq/+f92ZezzmUev0a6oZ
	 cq0e/OymAK9offz1E0IdROijlSB7w9F0ICkSNinbBPvhmGZydFw4R48Lr5LJCq3jFeNpw
	 zt1Xk3/hW3QllQNkahYRU6cvWn4chaV3HK1wYo3nhKyFFwYMVeE12oMl2REmlnybvSt/4
	 DTU+knUFPQchM5hAs/eue7K2G51Scq3eKn3Zmen/Y36g4LsARAyBZ5X/JIMEl/KSrRyO9
	 JZsAO/JQZ9/HJie1MDMs7u6qmDctB5fn7mfTXmTfF261ABJrwpKHlq7L1bxQCPUVIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfMYa7Xk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAEE606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfMYa7Xk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83111F000C4;
	Tue, 24 Nov 2026 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557685;
	bh=CBbmcC3SquL/sUh0/0abO4UmG3Cbv//EVoTMLeRnei4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YfMYa7XkG3WPtH31c/p8U3jRi6hli6ga7S+6FRUvDcjpSHOufdD2viwotNTPdFR3R
	 7NwjjnWwjxak8cYSUQAzYFG8DYoGRII83iGVZgo/6/KPHF8lkdDWUuQX4GY1AeVI3P
	 YvyVQyHAK9T4zNw/KDUGJVnjiYNf9QhOFwYFy36z0OdKQYrSQkSGzWsdfHsa56pfiW
	 tyFA25oEGolMD2WlholoxiHgVBDzbJSrV0P5xr6wXpuiS2saSiJXcxwYztqWUhwfQm
	 SFd6LHhsXX9nd4USLlF3zjHpPQzTqTilP0O2p7Xj9WjZZZOKIsfhWLICq+yVTlfBwH
	 r9d9rblvQd4zQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:40 +0100
Subject: [PATCH mptcp-net v3 23/50] mptcp: pm: kernel: count endpoint
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-23-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kyuwon Cho <kyuwoncho18@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OPRvotvx8HNkyVDGOs6cqb6T0ZZWlYYOMAuy5o5R+7w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOFnzt0j3WLI9n60dPYH1uk7os1c1EWf73lTtmGfH/
 W7J6x0XO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyvZ3hf9wzg4z65uViS81y
 X5UHnJ5SeMbJOVb0g/zhiS2H3rJIuDAyfF8+Wdn5t5GdeZjQVcVjrnJfQ8wWB771vZLawhUxV6a
 YDQA=
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

