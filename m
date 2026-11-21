Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254165;
	b=4dnyTmnHii59WdnlXnFdWk/oMEqXxl/rnGb+8//UcDJlRKGiqFn8UnSukBJdvHYNLCkZ
	 VyK4nwqnCXLPQfopFOcsu9EmzjoM6qwrYQsUECHRGqiBCQQO8aMaZi17Y7Qs+Yr5c9Z0K
	 boAEsOlUp+80rNFB+cG6Vi3TOP8nrA8bO0ZwWz4uDiH9/AfaCZcZycEmu4xY/CqfmK18d
	 ulxZewgJONpA5BXBkyYUpLY4+IaWwsO+maUV9buxfJhr/CvM1mUhXO+Mc3rbu6svD+U/R
	 tEDksc4ZksXdhpW80kYE+pwp1l/ThKeeUU61JcErl+DJbroPlPvVhBHBjUz4nsYWAZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254165;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YSq3s8h7EiepX7v1VY5tEQRVYyBZTAFvwoDMFzE3poA=;
	b=T2E+Gk3NgBvN4KOB1BJFNB2qT/0wYYVNUr4yynimNu8H9HH2zKh8qcli5x2TqHVz0zoD
	 TGvS4tXLqfYQ3Rez3+9VOXh6YGW5KwWmmHFyg6vys6OocnOvbjbSoXgwUP/uQLPRbkghi
	 FeFhejiTAA5LqlV99wb/02cyN5vrFrG0Iit1JEhXXp3rX2HwrkY2zr5IvNr870JYuaBvp
	 qugSOGCrIFDRTcCRXCeMulFue11rSO4z87R/Wk40ubq0dqrGwakurU63iTDOOj+a6Ipb9
	 FhHJGccwR+EAOpE50Ng6frEtfshr1HoL5B+wN/Lv3Z1ysCBVy8u/VQ4QiJuUtxOsSEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+C2peoN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C07606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+C2peoN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957CF1F000C4;
	Sat, 21 Nov 2026 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254165;
	bh=YSq3s8h7EiepX7v1VY5tEQRVYyBZTAFvwoDMFzE3poA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J+C2peoN8ksVIQKKMDonyAMhGAGfnT52l6+gK2qu3cvl8fOqPWP1mlKaA+lHjSXJB
	 E7AXyV3tfmcn+PhBPpRix+YYm/FhMCvXWHV0dQqNcbGYhWetgFJkrUVk8xY54flVCa
	 /Ed39FWnBPxaJdPbJGkTXCqQPLeRozn01/dEMVRvhOT3kDDvm7EmSb0LVF/abmALgI
	 resqceGqbVQ+jK8sxHQVFChBb5TFoz8Y5rRzsyDd86+Og2blxGK6Bo+RoccR7KVukx
	 Fd+fECBX/Zqi4F/V+V5uWS42qtZNntYZMGvF22S3TvboO88fWG1mNGbh17QtF2FEBN
	 Nb9b8xtlQxs1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:28 +0100
Subject: [PATCH mptcp-net v2 30/62] mptcp: don't inherit fastopening from a
 listener
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-30-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QfSSZ5fKPsAQRncm4BhP1Z0B2qhi/hLcWwvImWqqi/A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0+NmezHkSWjNEkp/ytq9VGVp8pvzu/oaT1XwVh6pr
 H5fL7imo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKzkxgZFpZcWX3lmVD6gzO/
 u/o+Wan8nR/J8UzSUKpvrVto+MPEc4wMJxMfJRedPDLJjjXZr6L59Ef27I2/MlZwPvnsV3Mxp/Q
 LJwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A new msk is a copy of its listener, made without the listener's lock:
if the application calls sendmsg() with MSG_FASTOPEN on the listener at
the same time, the new msk can inherit msk->fastopening, only set during
tcp_sendmsg_fastopen(). mptcp_disconnect() then fails on this socket:
connect(AF_UNSPEC) returns EBUSY.

Clear this flag when creating a new msk.

This issue has been found by an AI code review agent, while reviewing
"mptcp: keep listening after MSG_FASTOPEN errors": before this other
fix, these new sockets were mostly reset with the listener. It has been
confirmed with a Packetdrill test, and a debug delay added in
mptcp_sendmsg_fastopen(), during which the handshake completes. Without
this patch, connect(AF_UNSPEC) on the accepted socket failed:

  runtime error in connect call: Expected result 0 but got -1 with errno 16 (Device or resource busy)

Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6f4e418d712c..9202b14c030e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3977,6 +3977,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
+	msk->fastopening = 0;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);

-- 
2.55.0

