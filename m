Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254169;
	b=Q2u3IDVFg4NSHgSpTqEsvEdhxw29NxKp6HCI+Q9VKBl4fIHatM+KD2qcampYjg4lGDJU
	 +SEbMrsUcYRRa2jh5AuDHbK9191RtbPd6gUryD61yWfocy9+iILRdYGhJq8PluHdUO5de
	 iQCe2IdMexHXhnx4Lb+JpKnrxIFJRHUr/UlY9gvnu/acckbAk7ITHQ6CnynX1cQAr2tmN
	 R9311yiM4CD3UxkHXbD4+8uqPtsKOrPGRmBO42bKx+x1pGvbYNsL2HUISHEX3TgVPswjr
	 QWfC4kG+pm6yiM0YaWH0f9yeR+yUd0NCOTrrNmugwH2/q9ASdFL30sagT7MBGIwVIPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254169;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YzMafzGQVdLPcNdAXZXrUpb4Pu65JxH1ySuzu/OVBLE=;
	b=fQ1KUzE+/GDWTocxRgpMIDQRV2IVPYouFGwg7bzHVu3FXQs07hfi1DcpQ3RKbpTQWQCw
	 BhS8EIhf1q45L3aUKhDd6OrWZv19FTk/lPX2m44w8AKwgnLieosVXn1WYW/ZRX2wTClim
	 aHGnQ1EtTAQlpAVI3u1ZqQysp2UrrCxgqCJL3vcNoBcety+AjwW2KqCh3ywlyBsmpJvp4
	 eY2Tr0N93KkmicjNK0bvBrXwM6on320GshVYp0U7KefDFJXAwejFL1qSD4KNQ1crfqzbK
	 oBBih8HPlVi+VB7xRNCP+LXuWjYDzRIkBUaFNCZCP3llKO6F1T6Bbb/4bjb8Gb1evlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHgsnHUj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1548606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHgsnHUj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232771F000C0;
	Sat, 21 Nov 2026 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254169;
	bh=YzMafzGQVdLPcNdAXZXrUpb4Pu65JxH1ySuzu/OVBLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dHgsnHUjeP00ODJ3EP60jLO66ZY4CBAZRFTirIDPFD7PCX0M253H2Z1BBx3bNd31S
	 cnUQCLS6qyC2mYqy+ecGugdhnVtgSe7oPIaJmWh0VpRICas8QyG2oj0p5+o86Ae2EV
	 4Aljm6wk/08TF+0Mgg/vE08vsiHQgJIYrmrwdxK4MvzudYsTU6dbdo06MW/ejAHYuh
	 FbiOIhskMFMRhFwjV+iPxROZ825S8aaaPIiV8PHG6XzBKRknV+RP+y3N5AyXnFXquY
	 43gddzw6dszMQYOXl6H/mYOvtU0JNJDYZGZdkTZH1ST3DhB8kiePBQbx/Vfp02rrSP
	 qtKVw5nq3IlIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:33 +0100
Subject: [PATCH mptcp-net v2 35/62] mptcp: initialize drop_req in
 subflow_init_req()
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-35-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2851; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oUA2Th1+YJiYsmBX1cCAbNltaqVXmh1ex6O+73pvrFc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ05PqTSQ0pqU3S+zPkpTZI7ki2KRIREP+SarEGj5hO
 6lHyzZ0lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATKT8B8P/9Fw257dbqrIfBx0x
 WPfCeL1WiWirJqPsobPcL67OF014xvDPKG5h9uopa+oeC635sHX2LbUbxZ1Hdwq/bby+d/Gx2wU
 7GQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

With CONFIG_MPTCP and SO_REUSEPORT migration, which
net.ipv4.tcp_migrate_req=1 or a BPF program enables, TCP sockets can
leak until reboot, and each keeps its network namespace alive.

tcp_check_req() keeps a child off the accept queue if drop_req is true
in a request socket that an MPTCP listener created. drop_req has one
writer, subflow_syn_recv_sock(), which tcp_check_req() calls before that
test only for an MPTCP listener. But if SO_REUSEPORT migration moves the
request socket to a plain TCP listener, the test reads what the
allocation left in drop_req, and nothing drops the last reference of a
child that stays off the accept queue.

The fix used here is to set drop_req to false in subflow_init_req(),
which runs when the request socket of an MPTCP listener is set up.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
run as an unprivileged user in a user namespace, with
net.ipv4.tcp_migrate_req=1: an MPTCP listener and a TCP one sharing a
port with SO_REUSEPORT, the MPTCP one being closed while handshakes
complete. Without this patch, the children were leaked, with their
network namespace, without any message from the kernel:

  repro: step 3 to 6: 32 SYNs, 16 went to A. A closed, 16 third ACKs. accept() on B returned 0
  [...]
  repro: RESULT: 16 children never reached an accept queue
  repro: one RST for each connection. TCP: inuse 0 orphan 0 tw 0 alloc 16 mem 0
  === exit code 0. The process and its namespaces are gone
  === after:  TCP sockets allocated, all namespaces: 16 [...]

With UBSAN, the original version of this patch also reported:

  UBSAN: invalid-load in [...]/include/net/mptcp.h:144:47
  load of value 14 is not a valid value for type '_Bool'
   tcp_check_req.cold+0xb6/0x189
   tcp_v4_rcv+0x11f4/0x4230

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 62a6dc18005b..a216d88d35ee 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -151,6 +151,9 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 	subflow_req->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
+
+	/* read by tcp_check_req() even after migration to a TCP listener */
+	tcp_rsk(req)->drop_req = false;
 }
 
 static bool subflow_use_different_sport(struct mptcp_sock *msk, const struct sock *sk)

-- 
2.55.0

