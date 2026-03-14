Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029138E137
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519308; cv=none; b=Hwgun+GiC4hPN7cLLh9LXqEKUe/GWTn9l2yvXiqUmcf257cE2BAPs8OLCTMwJaILWbZbywSVjrBPz5AvZJCMo0Y4GsWGM/+bAJZNYFOnJFsrBD6bI2AvtOJgdxYmBG1lu7YdJwqq39Lwwnp9M3aOnxdhQgcXEO27RZkAwaw6DVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519308; c=relaxed/simple;
	bh=cj/seZubwP7nLqBoz8ofrtucQHhr4mn40yQgMXMr40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7wfl1tFYmMXP00I29MsD3eW2ew0S2pHmCFzDC+wNaxgL9HJIJUwlt3BGNcHyEP3C+1sm4yY1upLEOWrJXOHzj0fiJL9vNDYJEdvWMc/ArubiXq1DaiK+CONIeJpImmHv2BOUStFITsbhFZjsd4ffb9MaP+r8o371ymfhzGwLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKcJUgY0; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKcJUgY0"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40429b1d8baso1292806fac.0
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519304; x=1774124104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib/vlu986mcpuvwIbmamafwqas870ti4JrE+4bqQJAA=;
        b=gKcJUgY0ebP3agWtOrRO6koIuMrXqSVunYRAa3SByZwIF0UBbcKcjExd2hQK+ksdTR
         I+cD4Fs7gXB4IC15SCC+UbxBjBOTjeNL7iI0Hw/hDciWqE/huyukHzrPTXuDcOzcToce
         Zt6QXIITcOEd5NrFa6pJjaAQ7I15Ok9FUDpVahNDIG3exeVGyuElOCNcus1aOcVHSDvN
         E+sQQSlNYOUiOvke2Xziki/W21SaxcEZl6KBWfoigWr96sK4iGOHNodiDrDpVMR/xCDp
         zXf+jPKv42VquccSTrvYPuCCh3REU5lMBeM1EkTHKbCXq8/hOwro5ue/ydh6q8D2dVyv
         yttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519304; x=1774124104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ib/vlu986mcpuvwIbmamafwqas870ti4JrE+4bqQJAA=;
        b=ci2riulVuEr4TqYEGJcNZs5RbdCOnx1fcmVLoQlfMPosGHR6fNuw7+L92PeTUA9LBO
         ylWydx/TdZ2zz4P8i7G91mhYYnyshyVH//BO1b7ecPpELDkEvAe6Ru8bgfnypg2g2QNy
         kxiDUflRBKBVccxzp+EB+HLTsWFSAHE/x5B9CXRZuCZvGCHcBVjnvH/xXUr0BCfSNcap
         p8nYt/gtTTOR+fPyC8RYhEXyVcWgWhB04JNnMK8Vy6+E9SHorWttfX6ezkFFGxHYoA77
         MIxzmT7/+v+zU2t6wJSdnAUr8GR/+938WBxQ3bUALK3+hZl6nkcXS188B/O1AvVEWYiG
         FfIg==
X-Forwarded-Encrypted: i=1; AJvYcCUlgOnMRCipZ/9+0AbxkDjHrAZd8DfCrC1e2kvbspdWS7kiPDj7B8SLkSqztOhSQvDTE/hgWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk5Mfc2l50tvSBowOoPQftM/m/f81+AJhonRDptSiC+oSn/uEk
	0kp13Zo4gKKH54LHHGKpq2OOWEGR9Co+AP/7EqZzpU7LstqkJtC/FaHm
X-Gm-Gg: ATEYQzxo4ATXMB2aA93ERlZaz2n/ZqzDq2Su4fSgs2YyR1aG3ZsqIoheyv8lwtRJbpE
	LnhZIKdHm+5a4ES8g3wh2iE9Xq39ZonOZfZh0LEit+dMm+0X8dlF0CK7AzWAi9Ii3Rw3y7aZRtt
	NQPwOI1lItWV0eL00NK2VL0PzF9USe97xzoSnWmXGmN1EZRh1/eN3Zi1KkkPKf4DwMizgd+UL0q
	vxW3vuVO3gXOfO77ViRNNmUOXgRj8ZEB2DVgzobN1o6DKSnYGWo6H3XC1SqR7uJ/aPu3GuXTvfv
	WmlSa/51IMxs9jvQjc7AqEjdiENijoeu0AvaODkaM7g56SCd1vnLo3cy002HQl4PUB8pRXMDx5N
	u6EmiG5zOjz8ZRH6nE8MVX/2zEMO7alsJ/nuiTtMCWvXKFA1NVP7Tv6VxJTLXYzw/EuOj4kxB4f
	TK5YZGYDfsX6Qh8YM4sWDFN5M7fj3+iU1QsRbVPLP9ji0QbtVRXGw8ZK5xytn4/Rcf0l/TNGJhS
	Q2/odzQ8xOpXAVVP569kTIIIuG51oeHNG7On9aK
X-Received: by 2002:a05:6871:c949:b0:404:168:3ba1 with SMTP id 586e51a60fabf-417b91d86f7mr5008979fac.18.1773519304503;
        Sat, 14 Mar 2026 13:15:04 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:15:04 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 14/14] netdevsim: release pinned PSP ext on drop paths
Date: Sat, 14 Mar 2026 14:13:48 -0600
Message-ID: <20260314201348.1786972-15-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

nsim_do_psp() can leave an extra extension reference pinned until
nsim_psp_handle_ext() reattaches it to a forwarded skb.

Route the drop paths through a common helper and release that extra
reference when __dev_forward_skb() fails and when start_xmit() drops the
skb before it reaches the peer RX path.

This is separate from the peer RX truesize test hook itself.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 22238df79b6a..c22513c523d6 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -187,6 +187,15 @@ static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
 	return NET_RX_SUCCESS;
 }
 
+/* nsim_do_psp() pins an extra extension ref until nsim_psp_handle_ext()
+ * reattaches it to a forwarded skb.
+ */
+static void nsim_psp_ext_put(struct skb_ext *psp_ext)
+{
+	if (psp_ext)
+		__skb_ext_put(psp_ext);
+}
+
 static int nsim_forward_skb(struct net_device *tx_dev,
 			    struct net_device *rx_dev,
 			    struct sk_buff *skb,
@@ -196,8 +205,10 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	int ret;
 
 	ret = __dev_forward_skb(rx_dev, skb);
-	if (ret)
+	if (ret) {
+		nsim_psp_ext_put(psp_ext);
 		return ret;
+	}
 
 	nsim_psp_handle_ext(skb, psp_ext);
 
@@ -278,11 +289,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * the synthetic cost; sender-side skb accounting stays put.
 		 */
 		nskb = skb_clone(skb, GFP_ATOMIC);
-		if (!nskb) {
-			if (psp_ext)
-				__skb_ext_put(psp_ext);
+		if (!nskb)
 			goto out_drop_free;
-		}
 
 		consume_skb(skb);
 		skb = nskb;
@@ -303,6 +311,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 out_drop_any:
 	dr = SKB_DROP_REASON_NOT_SPECIFIED;
 out_drop_free:
+	nsim_psp_ext_put(psp_ext);
 	kfree_skb_reason(skb, dr);
 out_drop_cnt:
 	rcu_read_unlock();
-- 
2.43.0

