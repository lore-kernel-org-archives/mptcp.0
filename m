Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB8364A4
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114352; cv=none; b=tRiMRbxfZv7qaVAUPeHSDC0gSeZtYGBMyLQ1i0hW2QFalv+v8ek1sgS8LrzSVbUL5q72mM98yxZbuG0D37YoVePYSazldEWpvwPdbTaLwkyoW2xx4dImbDT4R/gpsyMqe4snr5zIIE3k8KL4FMFfaZf+Lsxf9qIbf48e58YZn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114352; c=relaxed/simple;
	bh=XL/zdbpGu4NMh5JJHYG15GedpnQ/+spfeAqNO3yxkkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlayUtqKAMjdiwvmffYJnUJU7blMFbiiG3Os4r1JblB7y3PCRYdDHVJCG07eQ5b3jjb5p4dSOgfkX7VlZKORtIHcF0dr9X32VOHYAzZSfX9G2FFuoXiGK5H4omuX6eKP0thg8rMKJIBbhgS99ekP2mAXhnAE/iJpKAXeTB48kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lne5pZ+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lne5pZ+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E49C433F1;
	Wed, 28 Feb 2024 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709114351;
	bh=XL/zdbpGu4NMh5JJHYG15GedpnQ/+spfeAqNO3yxkkc=;
	h=From:To:Cc:Subject:Date:From;
	b=lne5pZ+Y24jlwKYnp3C3xkFzDMNkOVgIys/uiDJZ+KjsNrpanAlBXMd2zuLSmTlVQ
	 PdSAywZP57jcJJh67Xmi1ICuSIXAkVpSqJAwIjot3kkjqOE1rXvCHakaci6uPYsIz7
	 A6vThIoiIZBGGal8MRrkBK97TMSqq9ctvHH/n3AoTiWV1JaaRMb7YPEeJ+ycLp+bKT
	 1BJXdCVp7CpGJPYYDjXTCLKWrtM/fB0OMZ261xwKyQmGv42eWI+Jc/ObPBxzDtsBsg
	 9iPIrAfESbqhaFkoeKIrcxKcLKgmULYiBJOa1/+LUsIWijpM6X3MdDud5TkpWLS+Qq
	 Oq0nMIXt+aG1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp 6.1.y] mptcp: continue marking the first subflow as UNCONNECTED
Date: Wed, 28 Feb 2024 10:58:58 +0100
Message-ID: <20240228095858.4117568-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=matttbe@kernel.org; h=from:subject; bh=XL/zdbpGu4NMh5JJHYG15GedpnQ/+spfeAqNO3yxkkc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3wPicO9eQ1t6D2dvbDYq7IjoM3QLRjK/NXOL7 MFSLR/KoCKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd8D4gAKCRD2t4JPQmmg c5BgEADdeuIiIAN6UGeK2R/o7yB9fC6jHybcmiPBtKuH+OQcDvZJHfYTgvj38CvYLgGBnyxC5pa vt/eJvA4Zve15P7DZSTTiYp3Hb2+u9efEpoaoVRYLellNJ6Fqxn+RJJtMpwGQAqa/afysmrJd3i uP/pyakoP0pHERimG11slOqUlhDIX+FyT1y0rsQPSnj2FVt/Q4s5odljEd5FGIiRcFhQHuZhGIa cTruiw3UcfPDegSlX/PUAdl7tqTdDoS/4Z4UdWDlougNX7IoPCh8IbUFyz1bWNzXaL5YDcGEPjd ieRQk63P+fwqCOelYw8r8YxC0SEWUv57MoZlgjzFVpxMx89h6kjn0O2E9gxozJ1o22fOItZAt9x Iv/tV7HVcGHhIZQiGXv1EjI+ARt2Pivvz9Jn0/yIFJ8+dri9dbQKBIX3ViYMcWRn/sACY24cjGz 33J9PXZId/xJOzDv/bLS13XlPxIhMaoxvn0KJff4G+S5Qxh2/M+Dby+LrpzikMCKc8Vat3Nz81w w7oNuLq8YWThyA6Vc2zNxedCG/24ZaDrmCK1tXG2ieiaTbxA1IDerfyeNgUSW4eczjrjGMh7mp7 5GDstFb98KLpmm6nbcBqXY9IV0/Lb9rTW9u96lZ2n+VsNxbJuUZL08ekLVPaRpWUY6r77vrz97x 7qpGVEGuWTf9zIw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

After the 'Fixes' commit mentioned below, which is a partial backport,
the MPTCP worker was no longer marking the first subflow as "UNCONNECTED"
when the socket was transitioning to TCP_CLOSE state.

As a result, in v6.1, it was no longer possible to reconnect to the just
disconnected socket. Continue to do that like before, only for the first
subflow.

A few refactoring have been done around the 'msk->subflow' in later
versions, and it looks like this is not needed to do that there, but
still needed in v6.1. Without that, the 'disconnect' tests from the
mptcp_connect.sh selftest fail: they repeat the transfer 3 times by
reconnecting to the server each time.

Fixes: 7857e35ef10e ("mptcp: get rid of msk->subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - This is specific to the 6.1 version having the partial backport.
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cdabb00648bd..125825db642c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2440,6 +2440,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		if (msk->subflow && ssk == msk->subflow->sk)
+			msk->subflow->state = SS_UNCONNECTED;
 		release_sock(ssk);
 
 		goto out;
-- 
2.43.0

