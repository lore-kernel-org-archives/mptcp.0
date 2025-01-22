Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1463212B2B
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547804; cv=none; b=IBKZRRRjQL41j7mWfTRbPdCluGU+nrZ/Uta/i4e6/yeHEVIOw2umhTbAsj7M4kEpxAiny/iMCRgDNlOeDZKNMMP5KE47rj8KYk+0G0t66THueEOciO6qUdl+UZTim3owxeCKKUEVM+Y30PR3ekffMzTplobgP9uHjN3ZphTI5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547804; c=relaxed/simple;
	bh=Em9k5uZjvJ5p2xnj3pQfXEVSs5SlJfKXpNgQMl4lmAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkrY5sep5zojLkGWzLKvn1vxEUZbV2uTGz8L6SrQyAufkYefMyh+x5iSonSXTsh9KcC1bSit0txrA/aTyH9xc4AHAVmKB3ZI3XirPQblRKgfpPkZ4k0hhpt3DJ2gFDjmpfue5jaPDJaw4ql7vvALaXimFYk06NpIL5qBfNl9ZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1NwQaSs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1NwQaSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA96C4CEE2;
	Wed, 22 Jan 2025 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737547804;
	bh=Em9k5uZjvJ5p2xnj3pQfXEVSs5SlJfKXpNgQMl4lmAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U1NwQaSsypuNSpBALYbAkcTI6aFed8LJh1oLvdsG6qulvJzoSJpVApcTstLlNNbnY
	 AL9EzvcqYoNK1yXvBPo5+G3JYbiEo16BtxJ/6FWB2HKaitYnBevoYGTdlqqBNGlGfw
	 8NWiZcKV7tmIM+ZwXrL5GveSkvxwpCeVC6ayfNQAHUdPQPl0dQuHA3EEZPuRLNSc9A
	 KuUQDOVtlVFl8ejyxPL2XBRUpvHL4iURDPFllYaf9xCd5EFwrK6MY8Gw31Ru4kTCHi
	 mRX/CZF3i2xdpnV0IGfvTrM5BemGA8eIqsGI4+E7NHiRz5cQKsI+dXF1YChsL5kvyN
	 OG0Nh5r4nTLCg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jan 2025 13:09:48 +0100
Subject: [PATCH mptcp-net v2 1/2] mptcp: blackhole only if 1st SYN retrans
 w/o MPC is accepted
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-mpc-no-blackhole-v2-1-13e6670d512f@kernel.org>
References: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
In-Reply-To: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Em9k5uZjvJ5p2xnj3pQfXEVSs5SlJfKXpNgQMl4lmAM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkOAaVzaTxKLsq3ggsYBLAiyKecRBYgzdgnSvW
 Y9BS2hWCP6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5DgGgAKCRD2t4JPQmmg
 cwtCEADp0sN/V73bO92rhlru4D41RDlJnrLROoERkFKZvUElRWHfEvi1qC68Judl8b+Bk5K0+d8
 2n7dSUXXAL5KpsdaR2jA/rgjUTfqAF5SG7Cq/UlyEyxhLKupnTXZTNRZbgJcJelxa2pbHgi4EI7
 NYsxEoQr4/ByKpsExwJhHg9weIxAywI52GLuhJXAQ6kZPBLmJoG7FA9pT++u3EP7R5+742ee8/N
 qR1yS4/lJ7Y0Mtabrs9FOXAu6DJ+0fI09VHa9vapY18JxNTXQ6CjhF13puhSoJ73/hVbYJNrEEO
 kOvnIQJNHcnXSqFjobHfIcwr1nAnKfBKMD/03jGRWios7eva070g/lYcOSWuqJMnJPQ0Zv/SAWs
 aJGZoVgBbXedO2ysiepGh2M3MjpCAA37Z+ji/mLjDFmVISjV0SAyriZN8csj+SRbRJ0NM36Tcrm
 BQaKVPLQjvalxqDt9XBLo4Rcp2hHLjPPY3jet+Wq7vmWCDIr92cENTODWQTZfevSa0LxrtAULdg
 62mFv9hqha2QSN3UHt5eLAP7mhBYkZ72t6ahLIPvqxma6/JG3Mii/cyGQZoqjnuKZ26Z0IsH6om
 lnc1gy5oDWX9LfqUUbKbflhbMYNXguYpvHwn4mjPel9HoPzhlynDukp/TZbcdGYVBmI5de4xxHG
 AInBScnDFZ0WDDQ==
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

