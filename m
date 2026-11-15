Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758283;
	b=Ss02YJKTEVLeorQkglDwSaxC2KDlPHwcyffO9x4UlpHw4zopD6zP9DfpU1oRFbep97mp
	 wWMOtCTq5A541WQbOAF5TBzzcieqnbXhgx685GjfI05FhRWsJu619uQbcl/xDWsoOypwC
	 e7h8qLI0lEmCUjQd8uHfPjsOmHLnr2uDiCKpDjBm3i56gjH56X0BIaJlnPNhEwLGBmEYA
	 8I7n0YyOvmj0n69xPZibxm+2Jji3n5mSzejd+ge7W7Ne8a80AmEe5WHMmb3b+I7fP1zJx
	 q10AubtyTPL1PEiXlolDb07B7LrZJhxDKWPUKlQXrrBMpOhubGnAslbp+HQkNCrM5Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758283;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3VoQXyEijSo/xuq/fhROFbh3/2Km0UUjaAcWVlWjklI=;
	b=Yrrguoo8pCPUtSMNZB4IAWhups3Q/wskxiJV+N7Lm2Q6VMt1cpRteVD+3FmopBKYYrmD
	 d9AkvLGUxbndcmsiLQa8RlsCMQ7zCzcDJ1Zy8ZjwJMbxE2U4hLd80niVd+VW0rcv1yWu8
	 5YOFOEqXEKCGpT1f5Oos0yyCyg4lIlCcEwXBpp7i8SJ6XsjXe1h2NX67zEfEZIWqpg23W
	 cZtPL/nSrkKt8waE+PfQdxlGHu6K8P2mUg6hRSwemdioLoxs8JTseJ/3rV2b+Ph2droBo
	 oHY63End6PVOtC4y1ndUsC5UglSrHnk5m7rn8b8al4bCDg/19MtzQJL1mcg2/ZN0aYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=x2awkUB8;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC13606A89A
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 15:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC13606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=x2awkUB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794758278; bh=3VoQXyEijSo/xuq/fhROFbh3/2Km0UUjaAcWVlWjklI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x2awkUB8zMfSNamXiWbSQENAaZlBFHL5wgYtJaiiKNr3FcYlLK4LGMCepMUc+oV6C
	 s8XVOyG1ytDj+4Fy4SuUCv7yLh6+GHUbgrkhyqnf7Q6MZDxM61s8tEkEtIdpwE9oGA
	 u66D0gPsdTw8lc1xhzeO0JLz1l8AbhB6/pLVvrS0=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:103b:e9c7:571:634c])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E701F634; Sun, 15 Nov 2026 23:57:48 +0800
X-QQ-mid: xmsmtpt1794758274t4qgfv96n
Message-ID: <tencent_43D317CA682E96EDDF89E59E669052BF7E09@qq.com>
X-QQ-XMAILINFO: OaiqBpjOzzhTTX4XaQmmBBSTpLHDXSLzRyPpqhzbW62kdEbbQBG+D5j3s3Cvwe
	 I9QmSLsWnw94M3Nnje+HhVCs6ZJe5eHGLXTlthPLa3GW0cH5s2W/jE4WKQzfBdvbwHZ2L/ZaORbg
	 7Ebr6IWUCrEQ/yZpgoYm6VEDw2hYrMQxXClRozOpIAnuYXRsTizv/Qcuc2Eaezw8EE16eqQz9Pc/
	 3FY0LMe73pdwIUqyIEPSK+V98dXHlLtL88xwfolDjk5OmcLIt726eKAQ49P24l7v9U4n0GID9xoX
	 Igy0bRrF6lkaBsGDt1X69cgcuzXoiUNlf58eZoN0NnUJfYy1qM+2JMpkjbTTfG/Ggpqi63Wf88oE
	 WIGPIYmeGxxnvVoGfclgd2ES/CAKCESn9PMLU5tkV/rJcfw3yiSlE0px8ud/WNuZwSh8TtTgW+Qw
	 4Er7VC4P3qIHMB2RuMRCMLf4td1NVgqEljmuwxdDnp7ycFUcDOU2nD6rJ+br1pjiCw6+B3aHZ9YY
	 LF4V63TsINfbEHBcLyYDKtXj5p+PiqdUdVAFBuUM+L66Wb0S1602kWiflY7Fc5gkHVCWEqYV6p4B
	 2SQQB+Vxw1nJnmfIXc02eSEj0xEk8yxzMc6makdiXl8LoIlSRpTvMTjrKfdrkWzTMeIsJn9GSRlZ
	 Tn3H7f+8QKPZ2acnq/rBVJsSt11LZPFd7ZbNUlekaAxUYyjFVogLL3KvPD83l6N8imjghWR60e7E
	 IJADc9OEikPz/4gVEp+VKBEb9JRbZkDtxpkbZYNnhJMsJ8oweYtU4RhvksajiQ8FJyyNIWo4y/qS
	 9wiwP91I3drPr8FPTIPstUP7CJ9w0z7fyajO3yChF68k9kYqa3CIPvb0Ffu1/UxsQc1XW0iH82GN
	 C/yOtshhcAmdsrWWhx4bjpVx2ORmRinVglqF+RfYs8Orl6UYdg69cW2CLkufQLcubhWKBgp/l4dg
	 fPjG0TXMnW9n4uFAlhYDkcypomVXUyhfqdaDWuEy+8DRbvd088zeQFxh9jOSYTw2O3NgB3JCEXBq
	 8ym0G8GdYZFOWnXIjpRYEVgA8r4+JJ85AbYNFYIXzFjSEQcBD5CQ3ugn0ZR67CDUzBaCfRVzY4ZK
	 3YSVJ2TICghW70k2v+nw+PPN3Z47SFNX+9SseDLFXb2ovJ6WM2dSabW2c7LXL3tGKI6flNq6e4TG
	 t7Ap1k/566WO1tMA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [PATCH net v4 2/3] net: mptcp: reject token 0 in mptcp_token_get_sock()
Date: Sun, 15 Nov 2026 23:57:46 +0800
X-OQ-MSGID: <20261115155747.178858-3-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115155747.178858-1-2122295973@qq.com>
References: <20261115155747.178858-1-2122295973@qq.com>
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

Token 0 is never assigned to a connection: __token_bucket_busy() treats
it as busy.  It is, however, the value mptcp_token_destroy() stores into a
socket that is being torn down, and the value a freshly allocated msk
holds until it is hashed.

Both validations in mptcp_token_get_sock() compare the socket's token
with the requested one, so for a request for token 0 they cannot tell a
match apart from a socket whose token has just been cleared.  With
SLAB_TYPESAFE_BY_RCU the same is true for a socket whose memory has
already been reused by a new msk that has not been hashed yet.

The token comes from the wire: mptcp_parse_option() copies the MP_JOIN
SYN token without validating it.  A lookup for token 0 can therefore
return a dying or half-initialised msk, which subflow_token_join_request()
then hands to mptcp_pm_get_local_id() and, when the subflow uses a
different source port, to mptcp_pm_announced_has_ssk(), which walks
msk->pm.anno_list.  That list is only initialised later, from
mptcp_pm_data_init().

Reject token 0 before walking the chain.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 3429b43a9f7c..8a603fc8dc05 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -299,6 +299,10 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 	struct mptcp_sock *msk;
 	struct sock *sk;
 
+	/* Token 0 is never assigned, but is what a torn down socket holds. */
+	if (!token)
+		return NULL;
+
 	rcu_read_lock();
 	bucket = token_bucket(token);
 
-- 
2.47.3

