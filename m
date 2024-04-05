Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4C179AE
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284783; cv=none; b=cVanRzIClxj47EgqWqwrJVYRcXIohO42EdhcPniRPj+UddvC3ekzfe4xTqfyESjWxnIN8tbXJn90/jcmhFKXw7nKR9BtNj/JZ5TQeBKF2YmsEsrR1TQCFkmE4AZ2AgM+ceXZC3dy8I2GBEdG5DzoqYw7D99W0nd5AvC4yeVHzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284783; c=relaxed/simple;
	bh=5QX6fzxn2CQXNmMlj/YURw9BuA5tNw+GgrYcPN6BxY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4qh/BeI//l6rFjo4/QH2dABv0YJ5qWZGn80Z+nDiz4POjuO148nYcLQr/WJVlCPfjzp3ppuOiu5noq4ZyMc1wIx9r8Iu8Szf2Kx85hZ05sz3fGA5/8d9hmcvVzOXSmOUJ7GEFJdKpft1w+xdeFF/JcLbPdDxFQu33DzfJsPHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk/lqoEw; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk/lqoEw"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a47cecb98bso1029515eaf.0
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712284780; x=1712889580; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+WUgxwoWhE9CA4LyTM2EhUBxr1t+2JsbiUmutcJLZ0=;
        b=Uk/lqoEwRMjR9w4xLfvHbGtW7kbiz4jW8iK/to8B7m9Qjdnu1p91RAqejXLdxlbe/0
         ABpWFwZ/i8xFsFWWsxZjM4ySyZuecJ9hbRNy+0grrEKkg13OaQOR+51HsU8bH1dfkQ7c
         HsJt3gsxbW55Sa3jt0I5XPB/FWMhPPqK29hpvftGqEesaRr8G7a274xzOAL5Lu0HPJUU
         Xr0E4EXMr/3ACQdvJSoayg25d2LVA5dHkz8dzNCw2NMNucCAmpEDnMFmAaQSPLfCZNis
         oDDgZ9EFIHLHelY1Gw0Al9s9+Z0Hv344nI7mkUOwekid9N0LKRwjbH0J4JwaGm8cnnad
         s+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284780; x=1712889580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+WUgxwoWhE9CA4LyTM2EhUBxr1t+2JsbiUmutcJLZ0=;
        b=ogeOHWfnpTefPeTl8681hgEFBjZ9DXz1S50lHGahDE9ya0sSwsg9/TC0r9YjsVRhcO
         dD4SxTyDzx/IPkN6TEc6sW/3/MBs+Us2B4DA/hGQI9Z7+zbJUCNEkw2Doe/hV116jkFq
         xmCgEIDcMq0JcdPvyx0+TMj3sLcCHz5vJrBU72QrXsr+yWa5x7cKrDhDsmPZ/oP+yVX3
         OGIB+Ws+EIrJUG8p4iYCVz9dEx7Yz0ny9S3jv6lqMPErFcwgJm0pH8x7omA13WSjBZcU
         HZOs9mp3BbWZkxkGVrB0aJ97RRQCqFyAY1WWk6CrfOcTIHgRRr+uE/y9ywMzoO1RjFLO
         s8OA==
X-Gm-Message-State: AOJu0Yyosx1L5ETLEHu/Ktj9nzHliGVLAFRMaQTietQEpQcY7mJSmtog
	NjHz0bBLwfgpDJA6ZWPcEYxVdMQHAfZXM8a01HR3FjZXI9tc1+lA
X-Google-Smtp-Source: AGHT+IE9uCOy08j21++u8sWENz6qjmz3wlGDjgbgkrmZJDVgWfDvR0rwMbf1iyPQZSZQ+wmX25CVPA==
X-Received: by 2002:a05:6359:a214:b0:183:612d:4499 with SMTP id ko20-20020a056359a21400b00183612d4499mr340167rwc.31.1712284780471;
        Thu, 04 Apr 2024 19:39:40 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id g27-20020a63565b000000b005d8b89bbf20sm366494pgm.63.2024.04.04.19.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:39:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] mptcp: add reset reason options in some places
Date: Fri,  5 Apr 2024 10:39:14 +0800
Message-Id: <20240405023914.54872-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240405023914.54872-1-kerneljasonxing@gmail.com>
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The reason codes are handled in two ways nowadays (quoting Mat Martineau):
1. Sending in the MPTCP option on RST packets when there is no subflow
context available (these use subflow_add_reset_reason() and directly call
a TCP-level send_reset function)
2. The "normal" way via subflow->reset_reason. This will propagate to both
the outgoing reset packet and to a local path manager process via netlink
in mptcp_event_sub_closed()

RFC 8684 defines the skb reset reason behaviour which is not required
even though in some places:

    A host sends a TCP RST in order to close a subflow or reject
    an attempt to open a subflow (MP_JOIN). In order to let the
    receiving host know why a subflow is being closed or rejected,
    the TCP RST packet MAY include the MP_TCPRST option (Figure 15).
    The host MAY use this information to decide, for example, whether
    it tries to re-establish the subflow immediately, later, or never.

Since the commit dc87efdb1a5cd ("mptcp: add mptcp reset option support")
introduced this feature about three years ago, we can fully use it.
There remains some places where we could insert reason into skb as
we can see in this patch.

Many thanks to Mat for help:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..49f746d91884 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -301,8 +301,13 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+		if (mpext)
+			subflow_add_reset_reason(skb, mpext->reset_reason);
 		tcp_request_sock_ops.send_reset(sk, skb);
+	}
 	return NULL;
 }
 
@@ -368,8 +373,13 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+		if (mpext)
+			subflow_add_reset_reason(skb, mpext->reset_reason);
 		tcp6_request_sock_ops.send_reset(sk, skb);
+	}
 	return NULL;
 }
 #endif
@@ -873,13 +883,18 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
+					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 					goto dispose_child;
 				}
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
 
-			if (!mptcp_finish_join(child))
+			if (!mptcp_finish_join(child)) {
+				struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(child);
+
+				subflow_add_reset_reason(skb, subflow->reset_reason);
 				goto dispose_child;
+			}
 
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req = true;
-- 
2.37.3

