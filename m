Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599692;
	b=2bwvIzUVoifO9Si/BYGpZAk/WJEZcmpma/B1cmRFaJX8iy2uSPY56Wi+2+5lyqn1SLV+
	 legCF3eFEeOBq6fvOnOOYo97p45rQZC4oyRbOPl4szdBj/VK9BgLCiF4iYLeEH1mVJsO4
	 dtvgZD/WyzDnHArvRSCYYLefjeyYCrOVU2/O5pgo4kcq0o6xwJbaNuZkuZqp81beh+LMa
	 SZZkJjNX/12CqKiRFvmEBxjI60Q0g7jz26fVgdzFOyVMJ20Rcz9ngtFGSTsNzPrrp4m5F
	 Oi88RC+BuLtJ2gOR+uoW6vtsVXxjmTBylN2QQu+ly9NfSkiXaRIsaZvsBq4diWoH9RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599692;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=J2fN1dTbxw9ZFbXlLl+ZVj0v3rMcXWmbDkGIedCb7DI=;
	b=RpusPKc88jVqMTGumownHC/IVHuPhITAuD3CQ4YKWeRhAQR7BgdIXi34scVn6XApdBPk
	 dz+PNoNnCJf5bHyq9Xn3xxFGeV0Z+a8rheSpJJlzE7OeHicTTGlAy3+rlMDwVL+ZvmAqu
	 Ki+kAQWvnle6OoICDHewAo1qF8pNpT+RpgDxatLiqdbG8Lqh2pWfhCjbHIdX2/cqMGe2b
	 wbWjOKTXLvuHCH0m3EVu1zDAjvNU1ogDWOdz6kUcLf/mwYhvpoRaavLYTP95xpU74Tyc6
	 zW/gbVtaKqXgWugKyUqtKWAtXgMcvV3FnLqLNG/JcYHBqpsEZd3sGyxBKxVdmKxrGQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUe0ihDA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A62606A8A3
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUe0ihDA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B661F000CA;
	Fri, 13 Nov 2026 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599692;
	bh=J2fN1dTbxw9ZFbXlLl+ZVj0v3rMcXWmbDkGIedCb7DI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OUe0ihDAxdevb8mIC2IDB7mGXdIIufPCBcAiSb0W0+aaMPstO9ogqJSp0wSjT622w
	 qNHc1mb8MqEOvwzOTMVzLU8MRUAPNLJh9ttTDyigb0WXdEu05ofn5RfBvdRaoDulAm
	 FPqmk8jAKzhTLFvOI1bMO+5WCZc46z/uvlGwJZOQ3hk2ip9wG62GkDFSpH23xSWyoT
	 iUIalkq7JJ6n01XwCETW5Sac4uV1HEEbJCNf6g6IoOHx1/lCHWN7pm00jO2ZFPmIIE
	 z7Em7I1b+z54Lu3TIa7Dt8co6IT9gV/+9YNS7E2wwsb1qNaBrszfv3SXvdhzHAZ9Wd
	 BE+3ntT32ofAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:03 +0100
Subject: [PATCH mptcp-net 25/34] mptcp: push queued data on passive TFO
 subflows falling back to TCP
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-25-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tolMyCn3ZfsUpNCvJ7fbbbjbTidaykJPTNVmxGkQvXQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3Z7/XgmW53vIL40fLkDEuNfZ9zzB0FL/IL/f+70
 SfoTq5QRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESy+xj+GWwO4nly2UdU//JC
 lcM77Wzcdi/0vWr54CRfYYbsO0FZFUaGhp1nrp9Xnvl6+2LXjHJ+vWtcD3fUxXvL+dfqPiieMes
 BFwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP Fast Open (TFO), the data written by an MPTCP server before the
third ACK is not sent when this ACK arrives without MPTCP options, but
only when another event triggers a push, e.g. new data from the peer.

The previous commit pushes this data when the third ACK, with the
MP_CAPABLE option, makes a passive TFO subflow fully established. If
this ACK has no MPTCP options, e.g. because a middlebox removed them,
check_fully_established() falls back to TCP, and returns before this
push. The fallback case of mptcp_incoming_options(), which pushes the
pending data, is only reached with the next packets.

The fix used here is to push the pending data after this fallback too,
for the passive TFO subflows only, as in the previous commit.

This issue has been found by an AI code review agent (Clashiko), while
reviewing an earlier version of the previous commit. It has been
reproduced with a new Packetdrill test, where the MPTCP options are
removed from the third ACK. Without this patch, and before the earlier
commit "mptcp: arm the rtx timer if a push leaves data behind", this
data was not sent:

  server-tfo-fallback-write-before-3rd-ack.pkt:26: error handling packet: Timed out waiting for packet

Since this earlier commit, this data is sent, but only when the MPTCP
retransmission timer fires, here after one second, as the test increases
its interval:

  server-tfo-fallback-write-before-3rd-ack.pkt:26: error handling packet: timing error: expected outbound packet at 0.235869 sec but happened at 1.144189 sec; tolerance 0.100000 sec

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3477a7ec5a05..c56ca5e4df14 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1035,6 +1035,11 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 			goto reset;
 		}
+		if (tcp_sk(ssk)->syn_fastopen_child) {
+			mptcp_data_lock(sk);
+			__mptcp_check_push(sk, ssk);
+			mptcp_data_unlock(sk);
+		}
 		return false;
 	}
 

-- 
2.55.0

