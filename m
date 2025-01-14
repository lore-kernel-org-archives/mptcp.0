Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5171C1F0C
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876277; cv=none; b=QLYmEORpPN849S/JSJ6vJQqGxfxeYudkQou7xtPlAYU+JAGobshnNfAXMYHhm/T75dk9H0IQP163bf/MqeHxQaP04sT0555zzaQxICL3rxWo9Tvu8DzTbaKebCNVUWWlfGK2fvQMnFS76OpgEudFU+AMJHnqQ8DInqzhAFgBgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876277; c=relaxed/simple;
	bh=Em9k5uZjvJ5p2xnj3pQfXEVSs5SlJfKXpNgQMl4lmAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m05M3/KQNZ+t0vjKRfexxy1T6yneXUfomNzrlC5IaC69TRDCV71x6+Hu7SVIVw1j/tbmKgBTEBJnu7MxGL1bT3594A1KGJyR9d2i7nNa0e3MbA48AKIMYO2BMox7+fxAZe+lPHcxJB9Zl+pfuqWYt6Wc8LgmDqEd15r/kCQy58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhVh4lKB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhVh4lKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27853C4CEDD;
	Tue, 14 Jan 2025 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736876276;
	bh=Em9k5uZjvJ5p2xnj3pQfXEVSs5SlJfKXpNgQMl4lmAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PhVh4lKBgJdKCqpbgZdEk9w6yr0TRjVbq2H2P35yPa4aQ5/EqYeYTczk8AnJ81dqc
	 j1pNZhKAt9g7ZQH/tk14htzIpv02Ehk3NidUYMIJ6BUun6RtK8GfzLP87KOEGx0yXg
	 L6U3WWYdNd43w+WlDHKOrYj9WWWSEbPnwAl5rT9GO5HEDdKWtJ01eX6TqZWaKGSSht
	 EZ698hqa8l0xIDSYN89gGuNzJ/pQBsxJTvyZM12E0VsAslIcxrYk6YYYEO6HVySEgA
	 tWriQRqKIeK483ztvx3/aqGT+KEqHD39B4Mrlasg3LLQXxIBhwL9X8Kki2uZwakULC
	 gNNqqPo2eRVxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 18:37:49 +0100
Subject: [PATCH mptcp-next 3/3] mptcp: blackhole only if 1st SYN retrans
 w/o MPC is accepted
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-mpc-no-blackhole-v1-3-994bd2a357fb@kernel.org>
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
In-Reply-To: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Em9k5uZjvJ5p2xnj3pQfXEVSs5SlJfKXpNgQMl4lmAM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqDwV33WjQ2+avVUA4xioRTQ+sSoJWrasv++0
 a/IWYdsj2GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4ag8AAKCRD2t4JPQmmg
 cyCgEADkd138zjxOOoCnnwSNzqV1A8TuggKZ3qcm8BAx5i6pVtbV9OGtqCsUpUJElKaTCHhjiTA
 jO2d/PnmeKoJGUjH54LeJNFsqF84wjJ3mlb6dhIy6TqEa+u1fxRro7wtpTrV2zQNNoKiTAhuuLF
 Dlb8zDAQ08qhUBm/dggBfrhQot7bO+mFJpF75xNy8szavX7ZItC1Qjtpn+EV4hKU4eDvJ9NafP8
 j3N0kSYdeHxDFXm8/TIT716Dt7lGIaU6E5iTd796JD9CaMpW+y6bbernPlzL2A8oInY3JhCPmQ1
 RzKITIhj0biCen9+Kphv3lllmREId2dQiYcajDw3VBw0SFMB/7AVkry5/vZ24SDCmV9beL8R/2T
 LPELwTT5l0MwEipKBJABXNsNqlxGJMXI9c1fDqhDQ9KN8BUR8HaZdg6ZwoNP5jQCG8KXH6acSMY
 BPZbgdRXtrn8FI9+ZTfO/vv3ihp88uEcTK5f/G0CDilsBSIVh1/fMGnCejzXUgCO2aZxabz9Via
 RqS+dp/lxb2Yl9njVmWRzwX2JWHdjcfomVvKPQgw75sGABgsrG/iD7G/GvZJC22vGSfBDfjSO/J
 wAb9Gh7z+WIQ43TEp+ZVjFKC7gqnKhXUxOYxFggrQ42k4MdmUGN1h5YjN0tJ7+4GQGcddnlf7O6
 bu4vDluIgATKloA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The Fixes commit mentioned this:

> An MPTCP firewall blackhole can be detected if the following SYN
> retransmission after a fallback to "plain" TCP is accepted.

But in fact, this blackhole was detected if any following SYN
retransmissions after a fallback to TCP was accepted.

That's because 'mptcp_subflow_early_fallback()' will set 'request_mptcp'
to 0, and 'mpc_drop' will never be reset to 0 after.

This is an issue, because some not so unusual situations might cause the
kernel to detect a false-positive blackhole, e.g. a client trying to
connect to a server while the network is not ready yet, causing a few
SYN retransmissions, before reaching the end server.

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 3999e0ba2c35b50c36ce32277e0b8bfb24197946..2dd81e6c26bdb5220abed68e26d70d2dc3ab14fb 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -418,9 +418,9 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 			MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
 			subflow->mpc_drop = 1;
 			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
-		} else {
-			subflow->mpc_drop = 0;
 		}
+	} else if (ssk->sk_state == TCP_SYN_SENT) {
+		subflow->mpc_drop = 0;
 	}
 }
 

-- 
2.47.1

