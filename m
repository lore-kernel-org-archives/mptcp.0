Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557683;
	b=DeXvieGWg1PUaCfNkO9H1OLOu1GbosNUU6xWsJ3diRYGdV84mQ5SKwcJGgffTuPPvAuG
	 t+awNVSp+xrmYopL9g6ttOdMSes0/r31ceaakmxWortC/G+d+7/cgf4JH65mXAnZYEuEO
	 qlZD44apvLdfF7TrXmN4aUhl+rRPHCvdK1ECTWCw4QnxLlp7hpWa70l60ujFvGqeI2rUo
	 nKKg0+cQr0d8aDlM2mNFKagGrH4vVs8g32hlhk/JUASVyV1WsQN8cvOvrcRDiU+1EsS+q
	 YTqpF1Jz6z2JJcDC+9eqsxaNoTgAvw4NvfIq9toO09qMXIKRzW85qPyzRgdtFhPaUSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557683;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vQCImdFitGpbWIKf0MA1uvRp2nUKPsjiELXLQrrfI2g=;
	b=EyVVarnpD6HC4z01jrRGRvLMCr8BNwnZ0UjV+a82n4eSxHgtQ0UP4XpjgHhuywJLfGPM
	 5yOvgzserMdNtF8c6KFv42TSB2zmCvMs+mdNrvzvXG1O8WxysafZqZ4Kl4MQ9ZEW98rX4
	 wHbpGPPk2WNuYs8fa0J6NV7BQq0DwfXL35wb2E6q78chrNEoopqVT4GTlWSE3gAwHDC2J
	 g61Ub/diX79A6NZF88hpQBnb/mf3Dm8H7kOx64XmxCtlU2xqmJ/VP/q9Fa9hF0mOeDH/J
	 syYa57rfqvPje8ecDIDJkUCqnLzIPhOqhmuRu2T1vpftNYy0yAdIeYqjNExmB6NPaEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYkBDToP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59B606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYkBDToP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6345F1F000C6;
	Tue, 24 Nov 2026 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557683;
	bh=vQCImdFitGpbWIKf0MA1uvRp2nUKPsjiELXLQrrfI2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JYkBDToPbKfKLoT5D/11WtXUNwWWmm/NGFIoMZ1Kou8sINQ0Bm3HPDB8rjDZAPIYF
	 hdtCRXVPFonYx4gcLhMZaf/oqszj7ciz67YbYM6MyCwo4TlHlazKR94qs7Ar1G73hc
	 RcISS5khXTv16t/tCQH+A6qj/oSF2dedkjj7nyrcQnFWIvHg8454yNSA/7cPTVdiUo
	 2qCbSqiAJxnI7Ks62mCDYFBxSM6zC2u9JSLWxjo2AXK3i42caDh1fC64Ao53t6R/xn
	 ttByNOA4CK2WVXG1lz8PnyNyfXxUncc4hkfVrlIiE6IR3DZxXLcB5VI8CwftQx9pPT
	 bPV2SAAIu2F+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:38 +0100
Subject: [PATCH mptcp-net v3 21/50] mptcp: drop non-MP_JOIN cookie ACKs on
 PM listeners
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-21-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sjK3TzczKwFnRy3Th9jpJkZdKQpZKzSTaIOKeS++4FQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOJndK2a6uLdMX3DD4oFJhrC8klVe1ZaG6tywtVtnM
 FW8dxXsKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMgiV0aGCRG79mQt/3h5oyRT
 4arWa3/OXO+2LizjE3J/Hff5Nsv8qQz/k+6Jv39kGHo4MOB/Rmiozmn1C87+9f8W5S/Xf2jJruf
 JDgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

With SYN cookies enabled, a port-based MPTCP signal endpoint can stop
accepting new subflows until it is deleted.

Nobody calls accept() on the listener that the in-kernel path manager
opens for such an endpoint, so it must create only MP_JOIN subflows,
which never enter the accept queue. The listener is marked pm_listener,
and since commit 3d041393ea8c ("mptcp: prevent MPC handshake on
port-based signal endpoints") subflow_check_req() refuses a SYN with no
MP_JOIN option on it. But a SYN cookie does not record the MPTCP option
of the SYN, so mptcp_subflow_init_cookie_req() picks the kind of child
from the options of the ACK, without looking at pm_listener:

    ACK with a valid cookie and no MP_JOIN option
      creates a plain TCP child, or an MPTCP one if it has MP_CAPABLE
        which stays on the accept queue until the endpoint is deleted
          once the queue is full, the listener drops MP_JOIN SYNs too

These children also hold a reference on the netns: since commit "mptcp:
pm: don't let listeners pin their netns", they are what keeps it alive
for ever once its last process is gone, unless somebody deletes the
endpoint, as noted by Clashiko on that commit.

The fix used here is to refuse an ACK with no MP_JOIN option on such a
listener in mptcp_subflow_init_cookie_req(), so that the request sock is
freed and the ACK is dropped.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
a client sent 1025 ACKs with valid SYN cookies and no MP_JOIN to the
listener of such an endpoint. Without this patch, its accept queue
stayed full, and another client could not create its additional subflow,
even 130 seconds later:

  TCP: request_sock_subflow_v4: Possible SYN flooding on port 10.9.0.2:6666. Sending cookies.
  [...]
  C2         4.007  [130 s after C1 has gone] RESULT: subflows established 1, in SYN_SENT 1, the service works
  --- V, after that try of C2
      listener 10.9.0.2:6666 Recv-Q 1025 Send-Q 1024

With the same reproducer, adapted to delete the namespace of the
listener after a few of these ACKs, this namespace was not freed:

  srv: listener of the endpoint: Recv-Q 4
  srv: deleted, then NOT taken down after 60 s

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment, the details are in the commit message. Commit
  message: how the issue was found, its symptoms, and the netns pinned
  by the queued children. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: commit msg: the netns pinned by the queued children (Clashiko)
---
 net/mptcp/subflow.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 67a749643ad7..91698d154c40 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -315,6 +315,11 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
+
+	/* PM listeners only take MP_JOIN, like in subflow_check_req() */
+	if (unlikely(listener->pm_listener) && !opt_mp_join)
+		return subflow_reset_req_endp(req, skb);
+
 	if (opt_mp_capable && listener->request_mptcp) {
 		if (mp_opt.sndr_key == 0)
 			return -EINVAL;

-- 
2.55.0

