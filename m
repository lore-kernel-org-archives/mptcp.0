Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841132;
	b=XbpuayRCK6zKsNEdNDDxLo82LOMZd1oV/G0MX2txKbTobSr+7TrhkxrsVVSvXNSVzy1y
	 4VpWbFx+Uq/6m52G56gXeIEXk1Mxl4AMHMYeX7btIS+Uf9qkRl1fcfyFTh6CDPmq7wM5Z
	 buo/AIU4G2xcCWgfgG0RorFMWr/DkzRSGSNgL+3p92WHjAkX/BM+ohTQPa9mMjW6Ybmhr
	 2o/EfIHCbfDDAyMNQnmOhv11/iEUQeDcU61zRdy2pcmRSrNnqeBFfNyuAvPhwr7ljTlxr
	 Axlj+A1Vfoq6FF/u8RwczIWLGEXhfWITo0uz3vZERqQxfkeI+9Kye2DQp2yjXwlalIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841132;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	b=AvTABdCZATOaPuUHFucQHakZQOpBGP9mGo7589LRWpfT3vEz/rmZWSvxMgpBOLkriYhz
	 kbACtK/daBDX+dNVlkrbiHkaOGHm6HxMgz9SDvsRyl08rqNRLBdv5diUsFGkvMhbunjyV
	 DLyZm1px3pCFj43NqxZ4BkzbFIssPeYcCyBumj3T2K9TcFULjoOIw7h4Zxj6jHLHBJsrD
	 ge2QmVmzxt40lB6S93ukC9bTfjzngxZCHKEyO/0VJ4atCy6GJwcCcngOoFELSZUNEWtT/
	 ildrhQd9WAsUpRgtY2a2NjhWTetzrKdGT6O7P+fAyDMKKCvv0C1FE2+xRxKkFgGe/iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=oKD99tRm;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB24606A8AD
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB24606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=oKD99tRm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794841122; bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oKD99tRmaocPRgms3zuSGwdUQ7QrIgVnpefNP/WXZxTXcODHFR6qjdqRXEAxF2eD4
	 PfreKNa6bX2LyeoG6K0hRbmbOoTS/3at00MjgWGqus2hnqnxmVF54kN3O88h2UGMhT
	 LT37JCQ0J36tzI05LeMdb4DNiJRxvYimUIUD/erM=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:2979:aa1c:9ec4:8698])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E9E14C42; Mon, 16 Nov 2026 22:58:30 +0800
X-QQ-mid: xmsmtpt1794841118tximf9ax6
Message-ID: <tencent_4D4F1D48EA5FFFE96265141754F656C42608@qq.com>
X-QQ-XMAILINFO: NcCJkzr9kEID32ZflU5nxvDc+Cv6Nt6JIR5Ao6sFZJw1KBS0E+mKs+4zcL8jZE
	 Xe2dy4odEQFTWg2yAi3eBD979ar/0wBksUlzVJToXySn8zNlXMeCEpw0SFzZiTKPBcqv9HzumMcc
	 pXbhgv1er+WQYyTON5B+qCIZH93Nt1eIzllvYtav1XPa1oLilbD/jLUu0a1W+irNuMi6H9wKLU/c
	 5dmXspnWOgW2tWNsTr4TOLFJ1l7dTap/c3WBfa2S+hDIfMsHimWJnqm5TFGufmNQHhm9dVOgs1+9
	 WWn4yI6NLPr5m4qG1pG9WUZUtMYarUeLrm+CKCbi4wxDFBJs+vqESRHZ7hvpu/FJggUyzOQzIHHQ
	 WPNrrRlo6cmOWHRYiKWbfoFHu9VDEHNN4D4ybxz7zXdIMTZloXgowhu0BIYhtNy0+UqTpyZwpoK/
	 8Lny1ZZ0oj5ny5zpoJVoNMMRYNA6HjfFOwrWgiiWsBDv/W6H9Ppyxg7Q8QBPAfNo2ZsT1szi19aD
	 RJhx0bhfFyqw11MoC+iCOhONGcJxT/V4EandbFC/dqyi8YGHJQrie7SdqFjunMnaHore7hgvo8vn
	 HRbvYYNIlC0vrt7OWD2crtYqVCsmP5svnMkF9PlU3SOzH0sio1QJGWzC8U0I/6K7SWAIChfwuAjo
	 Gf4DT0Qob8wuhE69IKKEOYKyMSlUCeFBbs4VjpDfVZg91HLqskozMdHFi75yXZ9T/rQU6EwPCiHf
	 HCNLQoompOn6nNFf8FsWKM8LPstr1svXzG4F0KosCybIoVWtSb3294CM5S2wzq0FTwTeTQQw87kf
	 9JPLhipjDJsfE1GVNMRkeCShocPDP0xyXI6HvP0x7OtFiK+f7USyBfCor/zjiqOd6oTwIzlnFxTz
	 Dh5KbTBuyxtse3hyizV1cdI5EmcZq6MMvgBhww92R8CLt6nnSExgU2/DAC0PyrMCzyrJ5vwHHm0j
	 2hmJfLuZRdmnFaU26ljCCJecQ1YEzwctCeXEMh6FFjShmzq8S8h9DCRs23V/lCyC9LfNU3qsOevp
	 Jq2gcfq/dDjtjJC+sNGkpt8S1WUeqdhS7g3eBaEkLeRt4HUru3TanPdcI9nIszJ5OHJa/TJpNoCW
	 U4jSV+Id6BP/CMu42ISjw81JK/u/s7DPZkFe516q2eYNlVTYEeYfSsOnd4CV/6jzCfBRVmlQDTxF
	 JkTk2gTAmbni1+v4MbH7bPiXOx6nNIVmaYNr4=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v5 3/3] net: mptcp: verify the token slot in mptcp_token_iter_next()
Date: Mon, 16 Nov 2026 22:58:29 +0800
X-OQ-MSGID: <20261116145829.96849-4-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116145829.96849-1-2122295973@qq.com>
References: <20261116145829.96849-1-2122295973@qq.com>
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

mptcp_token_iter_next() takes a reference on a socket found on the chain
of the slot it is walking and then re-checks only net_eq().  A socket
that was freed and whose memory has been reused by a new msk in the same
network namespace passes that check while it is still zeroed, and the
callers - mptcp_diag and the userspace path manager - then use mptcp_pm
state that has not been initialised yet.

The token of a socket on a chain always hashes to the slot being walked,
and token 0 is never assigned, so re-read the token after the acquisition
and drop the socket unless it is non-zero and still maps to this slot.

Fixes: 96d890daad05 ("mptcp: add msk interations helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8a603fc8dc05..48470d6e751d 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -355,6 +355,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 	struct mptcp_sock *ret = NULL;
 	struct hlist_nulls_node *pos;
 	int slot, num = 0;
+	u32 token;
 
 	for (slot = *s_slot; slot <= token_mask; *s_num = 0, slot++) {
 		struct token_bucket *bucket = &token_hash[slot];
@@ -377,7 +378,9 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 				continue;
 
-			if (!net_eq(sock_net(sk), net)) {
+			token = READ_ONCE(mptcp_sk(sk)->token);
+			if (!token || (token & token_mask) != slot ||
+			    !net_eq(sock_net(sk), net)) {
 				sock_put(sk);
 				continue;
 			}
-- 
2.47.3

