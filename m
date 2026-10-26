Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996624;
	b=dUeAmfmOqj5Zh5uNDHW3IqRqIcpyO2WjXTfA6piBrh01GZCyeOsY8VJOeN3Iapvy95BN
	 NWF6Zopi8gWeegz/K10zmeJosyRBykJ7jyM/SXQVV8pWXvo40fLojLp3tWKFCalQ36Kmt
	 9DyzDuhSlbEPzVWWyVg396xFBhB5xFr++erHixAziAF7vndMUOtxk/tHo7LstHSrCU2xw
	 XvAAlgnXZZv+3N5ynEZyjaVtBJcAf77gr0pCW1vjn9l3q+VSUBDo/xM7k9ZYWgbCunBcV
	 QMjhyqkPxtEcbll5jEV0n6Pj7yCYLQTjbzqrlup/4eOGma+Esmc3pUD9DIoGI7f3ixg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
	b=AIaa/ZZYcnZ2MgKc12cWPfrzkpFrYPL88IkWpNvgofNx9GH1zs0kl0WTtllhYPN4mYOi
	 lywHodFw+u9v2dLfN0WnbHcjwik6kS2TponzJuaIqUtn74pt8vgXuTzRSCggFY/iSSBX6
	 NcvFpKpg7YUB2fkUXLtLjdgH7/xDgR0RRpIa7BEmZebu5W3gedjoU2ewo4JiEAOk53fAM
	 BYq0oaE+LOSPvPWTrfZAwM7yymZZzernkbE/zXNMjc08rLufobRJeS0YPK93nutPGViFF
	 Plva6T3TXzN2ivTQj+IXvXSTasc37HkR3tu2WEVLiqcMcpHQN5SUIX+4PqByO6DNc1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oPkvesGn;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED5606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 06:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50ED5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oPkvesGn
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so4012514eec.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792996623; x=1793601423; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
        b=oPkvesGnt46FwDE2OYNUFms1VfrjfJp2tfA7yj3tCW6mDI9TV4ldxliOwC9T5GvDce
         Zj1CW5jWrhMOR8M5yDRKspaHuocWI/GHuR184XYa+j7IGPmkzs8/MIw2gqhM/HxNsd8d
         APSnMb3Gub4N0E1VnhG8XZYAHHWpadRCckj7rM/RkowU9bjI47QurygmHEgxvYrdks0g
         t9WFOgJwZhB6+cSNiy7ZxdoZ4AIzv0mQIUAnntOjMIQOSrjq4YxC76gbJjW9UcDjnDny
         GSOZ+6fSOFckzWttc/ht+znjiTeUreg0a4mqA1gETpI4jXTJ6uAFDX8oHFFfUv2SK1sf
         HhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792996623; x=1793601423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XwlldahLZl6u6KBDX9l7n8vOmnvTZvhZdUFA/a8ErDA=;
        b=KthnxgqCmm347+WUyLqgGFvzbs3vXlrug/tj2rPWucYZ4tbcD0uLr3O6lmgbT9KKf6
         xNQuiH1IEg31f08gXotwzWpHh+muThPJ3NGA9Ql1zxeONkBGXdNeDO7X8wYoqOmztk5E
         eXMW6qu4WGWLnYeLepzGwckq7LsGEw6I1EVKUs6uuvCtRRpZ2BiKHoCzuLPP+lmIGPQ8
         VcdVJfkaENQlyyL0Nv1L2fMrnzAv6UmVwweiSOe9QlGKEZ4jvALmVFQ4UbY9F4x7P+rG
         bhaMHZHSw4slaGT3W+aVbb1Y3eUxKb3Jm91lumAPasOsoLtIMpayxu25v7BncvFWXXVL
         Us7A==
X-Gm-Message-State: AFq9FYLpMN7rdq07Nj2YxOCBTIGyMckk2dVy8dWVAeb/PiCI79jzkYyg
	1MIUrBEtN97Z+gmUD0IZ8wqSu9vXCwgf4wo05e+l4pVei6aE7HZwV4wHXnsVqw==
X-Gm-Gg: AYBFou3avSe5e0XnEcd7XZHPv0VPAlH5qiDXF+Bly/u4CXOGspr/VCuLFFKIYmQ2Xgr
	Hf7MR6Sgno4ReVZb0uOlan86ExqeH3RPAlSmeF4Ff3x5qAIWHSNhSVw4GwEtrRv6yNmhcvNSWiE
	VTCzKyzswRvyxdfuAsa7uHZxRqmzlgf2bX8TGxMS6/QQFv1wYoqhVgLymni5HMgfAa8fPTBIs4r
	jCV0+lkdGrHvi272ZwhrVREkXGNy4rTxQ1Rclu5VXpqJqes2uZP18zPk8VB3l0SVaxTCuzZnpcG
	FGbNgfF6OJg6y3r67yK/F4AQN5ZLEYQ2szTO0vMl4DZuFB0KhOqN4O9pb3HGjcUxoyIiwJtjtmO
	xFvwrR7bGNzoApTNIDha2Pjjw03Ri1a/hsUjfagw+NlW+e0o8OkJzEdrHsP8lglBnGZ9gENS/As
	CEN4OG0ECLkTWwAiA9EojIeXIgScIXtNa7We1RXtP07ffy0kEOwamzVXDIwCEQolzrK0ndmmsn/
	U5L0Q0hthIHLi8vq6rraWCNpt6i9bdggVetAejxtqFEB0lRr5PTNhhTvgd3fNLUEq2Dy/DmkxyY
	giJWt87/T+eD8TD3upaCnE9XUXPlpohXseSvBpHwvxlNxfhTd1zvEt8IQ4rniamBsRMdUm8bt0x
	1vkDKSAY7eOdF07IIwn2VvVPV
X-Received: by 2002:a05:7300:c00f:20b0:358:5bc0:4f08 with SMTP id 5a478bee46e88-369e84d7f7bmr9692985eec.37.1792996623075;
        Sun, 25 Oct 2026 23:37:03 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm21191609eec.8.2026.10.25.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:37:02 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v10 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Mon, 26 Oct 2026 06:36:52 +0000
Message-Id: <20261026063657.2955783-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
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

mptcp_connect treats any write() error as fatal. But write() can fail
with EAGAIN even after poll() said the socket was writable: the MPTCP
send buffer shrinks when a subflow is closed.

The tool then exits and the transfer fails on both sides. Instead, go
back to poll() and wait for more space. If a poll timeout is set, still
fail after as many retries, 1ms apart: poll() does not check every
cause of EAGAIN.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v6:
     - the comment says the limit only applies with a poll timeout (netdev
       Sashiko)
    v5:
     - no change
    v4:
     - count the EAGAIN retries, not ms (Sashiko)
     - no limit when there is no poll timeout, -t 0 (Sashiko)
    v3:
     - do not wait forever on EAGAIN (Sashiko)
     - wrap lines over 80 columns
    v2:
     - Fixes tag

 .../selftests/net/mptcp/mptcp_connect.c        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..49017d00ab69 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -638,6 +638,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		.events = POLLIN | POLLOUT,
 	};
 	unsigned int total_wlen = 0, total_rlen = 0;
+	int eagain_cnt = 0;
 
 	set_nonblock(peerfd, true);
 
@@ -711,6 +712,22 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
+					/* POLLOUT does not guarantee that
+					 * the next write will not block:
+					 * the MPTCP send buffer can shrink
+					 * in between, e.g. when a subflow
+					 * is closed. Wait for more space,
+					 * but not forever if a poll timeout
+					 * is set: poll() does not check
+					 * every cause of EAGAIN.
+					 */
+					if (errno == EAGAIN &&
+					    (poll_timeout < 0 ||
+					     ++eagain_cnt <= poll_timeout)) {
+						usleep(1000);
+						continue;
+					}
+
 					/* expected reset, continue to read */
 					if (cfg_rcv_trunc &&
 					    (errno == ECONNRESET ||
@@ -723,6 +740,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					return 111;
 				}
 
+				eagain_cnt = 0;
 				winfo->off += bw;
 				winfo->len -= bw;
 				total_wlen += bw;
-- 
2.25.1

