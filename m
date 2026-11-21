Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254168;
	b=YuDMrSwii216iFgCRNkNIkMuDG7GMDNmhS3oSzPguUirjEObYqc8QKyANEV17lkMgBfj
	 KwypqbkMpaJOuxx4j+sxYnCADfzdu2pfOthrx79qECdd7L6Dw5zvE1zVNlikLj+gFlRz2
	 xA939fzMk4FVoBERTjZx3GFSlLg8WQM/gUFY1Nie/Z6D57O65u8wDMSmxdJ+1HFAbjtY2
	 zWqqDw/V4lUaMwiE21+m/uXrUqRnX2pOVeAwbHSbYwobAGGC3UN98mF5tWDRL2PlFYi31
	 +s7FlGbp4MpO7uWm9NrA9aArVjmzIpSEZKAHNwu68DHW1brS1ZZ+/j4CzQY00VfQw2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254168;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DKiOJLmt91Al6Fs+halFYbdfB7gKkP2q/ZnjT8wthyw=;
	b=va3dRbSPyLpgUjWgsUsttwQX+qDePt8BCWPWFKPZfU8CLgCl8dGjha3FoOzOYU9pskMu
	 HsqO6YAnjMEPjRK0G9rSpTKJTXsJcFi2Q70NzszH9nMEKzMkHMn6Pn1nSeI15+0gV6pbl
	 BM2rzi3USgoRtS1gNdR7X/PaTCyRSyVXRzpkhxE82SOR33GkysxJs+uEvd7rme+9q1H7o
	 sK1EW3QC4HHkWUR5qt7ZvVxhUQyJXKNx/oqE6zpcIsASrAXlm186HRuLki3pPRWWgR9rx
	 Itn/z9Y020Z0bcYSB5wghB6diWWDu4k4WPk0zjm3ylwlSx0Bl5lQeVb+6yE89jH/sXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLO6BaEg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9552606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLO6BaEg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D71F000C4;
	Sat, 21 Nov 2026 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254168;
	bh=DKiOJLmt91Al6Fs+halFYbdfB7gKkP2q/ZnjT8wthyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GLO6BaEgoV5O3B5Zucad2KyRqAj/oD4mBiussTPl/rr7+WbBIGxx+nHxAKO3hpMKH
	 CDceL+D1sxjhiVDxzhaxGUriZCVuYhknaGCT3MXxCQrgE8h793DVOW6GcgJnrVFRSL
	 zCXNChL/cG03dvy7MtI8/cIkipApfUFQ4/TGRFu+HZ7wdeL2xEamXGMM1xj2PvrhON
	 ZlbT34fSAYQWVb8bJ0BVXd3uuUlnfx9m/iobTsZGA0J0wXjbvLo0P9RW1A0mPI0FT/
	 0ivMrcrpw1S4z/Mkls/TOIZfZmbv55Z0r/7q/1f989TKlXnHO3pb/B/+Px2YP0lq+M
	 YAJx0pJnZyvCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:32 +0100
Subject: [PATCH mptcp-net v2 34/62] mptcp: close a subflow reset for a bad
 mapping
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-34-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vDSonjHJLvEYRw0B6TXnfiH/4XWAJbqSWPE+t3ePBJM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0xPllVgmtgfMf738t+Jqm8MRkYdvbsjySJT6tbhly
 cvfPLdPdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyk7iLDP72od3/UotLz/Rmf
 rFyhzt2geNejnvfM3ljJ7QEZN3qSnjMyvFtnPfvaXPaSki8hGpqTuXZqT7BwVi7MfshuemfJuQf
 OPAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

An MPTCP socket can stay in the ESTABLISHED state after MPTCP has reset
its only subflow because of data with no valid mapping, and recv() and
send() then block with no error.

If data arrives with no valid mapping and a fallback to TCP is not
possible, subflow_check_data_avail() resets the subflow: it moves the
TCP socket to TCP_CLOSE with tcp_set_state() and sends a RST. The MPTCP
worker then has to close the subflow in __mptcp_close_subflow(), and
closing the last subflow starts a timer that moves the MPTCP socket to
TCP_CLOSE. But the worker only calls that function if the bit
MPTCP_WORK_CLOSE_SUBFLOW is set, and this reset neither sets the bit nor
schedules the worker.

The fix used here is to call subflow_sched_work_if_closed() after the
reset, which sets the bit and schedules the worker. This also covers
the reset done after a bad checksum, when MP_FAIL cannot be used.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
and with a new Packetdrill test: data without DSS while the fallback is
not possible, here because of out-of-order data at the MPTCP level.
Without this patch, the subflow was reset, but the MPTCP socket stayed
established, with no subflow: read() returned EAGAIN and send() timed
out, for good:

  dss_drop_ooo_reset_server.pkt:30: runtime error in read call: Expected errno 107 (Transport endpoint is not connected) but got 11 (Resource temporarily unavailable)

Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Add a Fixes tag. Moved before "mptcp: continue the last mapping after
  a fallback", which makes this reset path reachable in more cases.
  Commit message: how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: commit msg: the reset after a bad checksum too (Sashiko)
---
 net/mptcp/subflow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8163731a9366..62a6dc18005b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1502,8 +1502,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		}
 
 		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
-			/* fatal protocol error, close the socket.
-			 * subflow_error_report() will introduce the appropriate barriers
+			/* fatal protocol error, reset the subflow and let the
+			 * worker close it
 			 */
 			subflow->reset_transient = 0;
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
@@ -1518,6 +1518,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				sk_eat_skb(ssk, skb);
 			mptcp_send_active_reset_reason(ssk);
 			WRITE_ONCE(subflow->data_avail, false);
+			subflow_sched_work_if_closed(msk, ssk);
 			return false;
 		}
 	}

-- 
2.55.0

