Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254155;
	b=iGiCUW0lXlMeNW9+d7rHwBEAcVvaaNl3BLnK+V+LYO062NvTFKHqk4EsuPM56V8euSOn
	 w/DFUtM2YonS7RgfKvepN49o72nxmkNpQXx3j8wHpW22KBhrkXUjvs0l316G1g+s2TLeD
	 5/9gJuzvHOJq4PgbwkfTYfhF68YOozFvkU1aYVWeFx3YxqIW+7QtztEMzCrNQ1X0637Qm
	 uVxATINaUebm8igRntRRctMOX7SAiHW/SI0zyPLFFR2RuN76oswP+Gyb4J01GBaS6jmSS
	 vCMrog0fYBXjsU1KnpIdLTOtunx3Ib+rj584EIZzF6z3sLR7pTiCRIMKNkVOpN4TJqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254155;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dtUNF7R/JZvAJATR0vh3jjl5HRWPOWIAHa7/Y+xlL+I=;
	b=j4cffRsJtnkwcovhS8RAkRDcoV+91NoPe2oq4qrfhEJMEEmQdboNTn4jiUwBKzWxg9vI
	 AM2UXL6+/o4/75AvgWgHEoPAglskKBIbZx8tVBt31Ut7+CElrsk1tT3MBkbx5Npv7DanJ
	 AxPayZHMcYBby2c9bpngQuWk6d0RKlma/OwvK5xBk2OkCOWhTjluLQ36e11CdHQZ4JHDf
	 14Zq/90Iy/N32CIu7GJr3o8GkyI4C9EjIY60KhWBxxHg55IwVAlvNbtI4h2zDuYQ3TaRs
	 3YVkklLONN0SYtKD1EUlfWAyg6NI6tnFOUXT6NEJKBjzSdpV1ylEXDzOLCjnmSZo8Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OypNrYrH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03C606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OypNrYrH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65E41F000C4;
	Sat, 21 Nov 2026 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254155;
	bh=dtUNF7R/JZvAJATR0vh3jjl5HRWPOWIAHa7/Y+xlL+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OypNrYrHczZVrmfjkKJYJchn8Qp8ulfU95VJrnPRku48Fd0KrkiKRV7ZBAkKMpqCs
	 3VC4i9UrUxP2J60yTdbXM8Z2b2AwguR9Rns6GPPOEmzlHYS6pjIbOaVi1U8VcvcPE5
	 U+ei+IUXUBAkTciyhyNFCMJgLd2Z7u4aFeoSzB6SVQYhfYv5zLr4H1ze8FVagiSoSy
	 G1dM5K5oxM1Otygte7626Wl/LiuOGHjhipSqV6PvKvI61eENK7nh0bD59/tREE4nn5
	 rWqAKk1nKc+8opIlrp3BRrf4fFPEPg3ittJzvZdvZbvwOv1y5AChhYiTW9Xp61AKWC
	 1DurvjuPnZP0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:16 +0100
Subject: [PATCH mptcp-net v2 18/62] mptcp: wake up blocked senders when no
 sf left
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-18-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3bqr5cktdwQRnklbcG7PaFogLt5S2kbO83/lAGFS9As=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ08OqE6bNqJi99uXqsKrQyKZZYt2NLx6cOqvKrpfZO
 DsndEZ8RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwER2ljH8j6lcynTmQUxlrMOz
 heejquY3zNSZ+8hiR/hinblCfeufsDH8d2K/I/Z/+WLjmAjOBt8rC/+dfGnfx8R2P3HNqyKhg3/
 YuQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an MPTCP socket moves to TCP_CLOSE because its last subflow is
closed, after the close timeout or not, sk_shutdown was not updated, and
no error was set in most cases. A thread blocked in send() was then
never woken up for good.

Set SEND_SHUTDOWN in these cases: no more data can be sent. The blocked
send() then returns EPIPE, as a send() called after the close timeout
already does. Reporting another error first, e.g. ETIMEDOUT as TCP does
after a timeout, would change the behaviour seen by the applications:
this is left for net-next.

This was reported on GitHub, with a reproducer: the only subflow dies by
RTO, and send() was never woken up, while it returned ETIMEDOUT after a
few seconds with TCP. With this patch, send() returns EPIPE after the
subflow timeout (like TCP) and the close timeout (by default at 60
seconds). This is also validated with new Packetdrill tests, with the
close timeout, and with a reset received in CLOSE_WAIT. Without this
patch, send() stayed blocked in both cases:

  close_timeout_blocked_send.pkt:24: runtime error: exiting while a blocking system call is in progress
  close_wait_reset_blocked_send.pkt:25: runtime error: exiting while a blocking system call is in progress

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/648
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for issue #648 reported on GitHub
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 201e77772bdd..b0f8a3d2e8b7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2813,6 +2813,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		} else if (sk->sk_state != TCP_ESTABLISHED ||
 			   msk->in_accept_queue) {
 			mptcp_set_state(sk, TCP_CLOSE);
+			WRITE_ONCE(sk->sk_shutdown,
+				   sk->sk_shutdown | SEND_SHUTDOWN);
 			mptcp_close_wake_up(sk);
 		} else {
 			mptcp_start_tout_timer(sk);
@@ -3306,6 +3308,7 @@ static void mptcp_worker(struct work_struct *work)
 		mptcp_do_fastclose(sk);
 		mptcp_for_each_subflow_safe(msk, subflow, tmp)
 			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
 		mptcp_close_wake_up(sk);
 	}
 

-- 
2.55.0

