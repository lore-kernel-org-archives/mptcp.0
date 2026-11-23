Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397241;
	b=3rGjw0QZye1IxQ5f6yhpKOV3P8cIXXDjL64qHiLtEiciDte9WcgmFH2wv0MRyxPRF4/W
	 8fKkFSlvTWS+WJLmpTWXTw63B4GUvic3p/jADwzgYRt0W8EJXaXQ6NxLP9pJl4k66jzLZ
	 EwqwvYiSywzNKHqFGHBbHhhvM53T/MwszFwUNTA7v5PjuTv7Toj12ibw5LY97yBhZ4rwr
	 ytc/ReZaYC0MtboCyahJMrkjRjF0agPZlFXPLxV7z56lw7TbZECiYHr/mbftqYYb1nkWB
	 sRx5DCSBeRiuycek5/Vs71U6bVoHw3HCA8dMIqMTbHRlR3U2so9OCoilENSfN9s+4MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397241;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xzgdi6tixpENAajuTDo2lKhr0psohkrbZKpP6EdA4a8=;
	b=sbaCR9QzcX0XxEhhrM0tNBMY/w25ehPXKwLd2kC9p36euYBAfcg1A/d9+mwNsd33xpA6
	 KpA4D0gK8CerPZBjJ6wHFSEeggTX6F1Mxc2jXihYbhw8sILx2tOkce/Lzy2ZaLq3ru5/W
	 qYkfsJerSV69vqgbb3SiJppcJVoqfGpLjt0/DG+KzNpcn8MB7HbRvrkHquQxHEYMgCNL6
	 0oLAzdh5mZv6XXSi577mWewmSqTD751EgiAWcSwv/Y9VlFJDJiZtuQrkmjdYOF9U3P2pj
	 wQyJ3OnDd361N43MJPudCjmvcKumGpLPD97mfhW3FIPtgL/bLqNuNCy52BvrWb4GtvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M0iSSjR/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C56606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0iSSjR/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31841F000CA
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397240;
	bh=Xzgdi6tixpENAajuTDo2lKhr0psohkrbZKpP6EdA4a8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=M0iSSjR/uFb+PAGlqjWvKH7V6NBX5Qqw7QxBTI3eP9Gvq/CPEQ52TVodcRXBkqAa1
	 sJIK1KIzF1KgpATSTYhQvXVN5LK/aoGwMvSQ+/xNHYmzhxHscaOhFIWZOxl4Y//c6r
	 LzNE2LsIVYMKAmy4qa6Wvre8SMb/2HMLLizHZU/yYY2ORyqWp4V98vXxgji01ckqml
	 yCjeSaxsacaH2ZV5whdEVhxqFFQSlvH9sFOwlUWysP+dlJrXUgk8vrDWXnnvlGadPI
	 ItkWSrk/qR6YAUUm86Aiuh5zqhkZXnLQhAxkU6u22ma6rGOb7bf5dWqH1ooZnlbErX
	 hAQ1j+o7NsG5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 1/4] mptcp: handle ack_seq advancing past rcv_data_fin_seq
Date: Mon, 23 Nov 2026 09:27:11 +0800
Message-ID: <84d2d4f05df024cd45c1936a3d53ea1d2797ae2a.1795396910.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795396910.git.tanggeliang@kylinos.cn>
References: <cover.1795396910.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Change mptcp_pending_data_fin() to check if ack_seq >= rcv_data_fin_seq
instead of ack_seq == rcv_data_fin_seq. This handles the case where
out-of-order segments in the OFO queue advance ack_seq past
rcv_data_fin_seq before mptcp_pending_data_fin() runs.

With the strict equality check, if ack_seq advances past rcv_data_fin_seq
due to OFO processing, the DATA_FIN would never be processed. In
ESTABLISHED state, this causes read() to never return EOF since
RCV_SHUTDOWN is not set. In FIN_WAIT1 or TCP_FIN_WAIT2, the connection
hangs until the close timer expires.

The new check using !before64(ack_seq, rcv_data_fin_seq) ensures DATA_FIN
is processed even when ack_seq has moved past it.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be23768b6d05..5ade9c25d0fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -569,7 +569,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
 		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 
-		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
+		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
 
-- 
2.55.0

