Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599683;
	b=FKn9uLnfCw1r5Y9qlA1OMyw31xso4eU+ueUtb/KHg8IBg48jq0moJcXfBplX6K/WcY4T
	 dHZzFVyJRHUUgdJBxQO0tO5REMino4LQilAIyEhoNOOmj65Q1RTdOc03J3pOg3kgstO23
	 ETr7z9I9XHI5DWglUBNkLOYG2nm3OfY2wjo6PDh8OhC8q5HcDeoz98ouiBYeG4nabA0MZ
	 YBc9G/77w5mApjzmumW+D3sBLyKCFEWQMuwAtyMAXWwcUnyjlqENgBGwsW9s0vsNoTKLa
	 QMIezxuhVyDgYTNfzW/oeMPeHFhNmrd55lHaAds7aj/15OSbrHQSBD3LzljLRLSd+1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599683;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=C4X5HzONSCfdWXGQSkyVhX4JvV2WJ4zr2jsyiMJCi4o=;
	b=PG+jPd2CZRrop51DHqWUWA7e+3t/JcayrvoLEISoV/6/Ns63vxqk3oBeWsNdimxy/msH
	 +4xBKXOYiRxu2Hk88DJ+nFuZgQM/jM98rSzK1O3p0CqpXbtyDwN0UJi3vqfhVISsoKrLB
	 tzc+V6yOeLKXExc2yyVkQ5Fb8y4Vgfvzhl/bUuhuTimcKPLU8OwNk/zgcqKxil741RbXu
	 DMI92dhX6kLhzaYzfZy39Q82ue7svpf2ceQAto0jKztXPNBruFOH80BN+mxWES/d+l4QA
	 jynOqI2Qz8qlatmsKH/qzV+eFkc8gT8nwjR1jzuxLy3BuV7dNiWnIqJ3d0W4/CJA1QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYiZBAS7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA5606A89A
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYiZBAS7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45F61F000C5;
	Fri, 13 Nov 2026 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599682;
	bh=C4X5HzONSCfdWXGQSkyVhX4JvV2WJ4zr2jsyiMJCi4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nYiZBAS7VDTaUQ3t8HBjB8kPDJRJnpYHRLjlrI8SG0DqBP+BboHAN9pnrWtWF6/zv
	 H+ot9A2mLfCdhZo9bEYU/XQtru3v3+cKR5+Vyi0cnYwLKfEuPto5EeDwUMh1ORYeQb
	 N46QJSFb9S13SVT58rE1g4Uk/MRqd0E+iC4HZIBljztYYHwVkA4EU7KrevAonPwxT3
	 9FELbESOy8ZZHyJf6HMMZa9hZQWMtgAwqx6VzmanzSyQuKilt8T2VIfH1bvPyRpcTz
	 PEKSoEofStqC33SNagy2TBZd7T7LAd+CZCtyi9p1CHmjU21D/5aKMS8V8txmOs3+mb
	 ZgrMbffK19rJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:55 +0100
Subject: [PATCH mptcp-net 17/34] mptcp: pm: kernel: count endpoint
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-17-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3061; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BoI5JMs8XNYoBRMkau/c8cUjriZTyOx+60jgUoDQygQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z931jFdzX5Actv66QJ/En8O5MfybDr3e+0/8bvWsf
 j+lxcdOdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExESJ+RYSa34J1ZBSeb3ioH
 /uwoYqsRS2hcUHKEw/1m4+rpanJa/IwM3Qslb5uK5W2L83r4OiQt2SR11lTFid3PTUuyzvz4cDC
 CEQA=
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

The fix used here is to increment the counter when this socket is set
in TCP_LISTEN state, even if __inet_listen_sk() fails then: unlike in
mptcp_listen(), the socket stays in this state, so the counter is
decremented when it is released.

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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index cd882eb6af54..4955c928ea32 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -906,6 +906,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 * old status is known (TCP_CLOSE).
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
+	sock_prot_inuse_add(sock_net(newsk), newsk->sk_prot, 1);
 	sock_set_flag(newsk, SOCK_RCU_FREE);
 	lock_sock(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);

-- 
2.55.0

