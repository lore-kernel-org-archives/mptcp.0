Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34786D22
	for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 17:26:23 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id n12so27586724edx.8
        for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGMn9Hh+2GJB6wJ1q/J1b/b3eTB5jIgwF2hEqv9MFfw=;
        b=lY8Fi2Uiff1qtxNL20Ke/rnmn31W5F/sVQqx36dEOaDgmpYZ1ScPjQuKUnT1cktDUe
         +lK5raPomzkluMPlEGVe5tYgr8PPJqMRiDtAIVkHSgKGSKB7Z9T16L7uai4uod7CveRP
         3qJ33sj5OnDnuE1daqMxOfCCn/+DyP3j4sPki/Hsp+xflzkCF0/Xtp3C2lsMDCaw+M8G
         NvqBGJZbLJ5D2i1U8tQTJsqsR0eFTawZZQvH5NHft1oYXACb95mqh4hN2srhCn/e1eV3
         WxO9WctXIOhbp70MiExymtujNQBzJGjy2sB5s4ajIwVYx9Yn0dGMr3xeJGiHyAAfIMH+
         mIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGMn9Hh+2GJB6wJ1q/J1b/b3eTB5jIgwF2hEqv9MFfw=;
        b=UfmW+04fujFZTr796QwUuFno0OCGzfREEtkjT7Mk0jU3pMLBx6WFDO9+BxJsLaJqVY
         OJb1BNfomPhMJ29yTWWdYbMskNdh5ykEYjw/APYweo9lw/tgYUaMKTGpuhtRWHRh535Y
         V1+7QolC21nvQaOZQ+Bw+zZx2VZ6z5mD8EL7ozL0413YtxY0WKHy4Hy7oyWTaF92Xzo/
         sRxdHK6fKpv0yMjRu/N3rr5kkyysFdCcmyGWmWy4OowhZTFIv3vrUqIOyUxO3+Kq4jqN
         nMqiNYS8x3XZw8oo3hTE8JqkdtOTzzsldHNKgyiFu03F/l+6lLuya/0JVcg1C9XCEHFj
         8l7w==
X-Gm-Message-State: AOAM530pZ78fT4l8eSPKduLPVH1KBLJCn8ysnx18zqN1MzGkap99ZW68
	B+kRxhzaORrAaHLecAXpNEVwhw0L3y8YcoVsRj4=
X-Google-Smtp-Source: ABdhPJxCgVECGKwHB+SI/q5TyjczVQE183oA6bc0p4FgZllYf/XKEt44WTljz4n+bePYo+GKgE76qw==
X-Received: by 2002:a05:6402:4412:: with SMTP id y18mr22007625eda.364.1629134781985;
        Mon, 16 Aug 2021 10:26:21 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y2sm3912981ejd.111.2021.08.16.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:26:21 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v2 2/2] mptcp: full fully established support after ADD_ADDR
Date: Mon, 16 Aug 2021 19:25:48 +0200
Message-Id: <20210816172548.2339984-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
References: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If directly after an MP_CAPABLE 3WHS, the client receives an ADD_ADDR
with HMAC from the server, it is enough to switch to a "fully
established" mode because it has received more MPTCP options.

It was then OK to enable the "fully_established" flag on the MPTCP
socket.

But that is not enough. On one hand, the path-manager has be notified
the state has changed. On the other hand, the "fully_established" flag
on the subflow socket should be turned on as well not to re-send the
MP_CAPABLE 3rd ACK content with the next ACK.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    - v2: reword the commit message not to mention "valid" content (Mat)

 net/mptcp/options.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a83550de54db..bec3ed82e253 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -945,20 +945,16 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return subflow->mp_capable;
 	}
 
-	if (mp_opt->dss && mp_opt->use_ack) {
+	if ((mp_opt->dss && mp_opt->use_ack) ||
+	    (mp_opt->add_addr && !mp_opt->echo)) {
 		/* subflows are fully established as soon as we get any
-		 * additional ack.
+		 * additional ack, including ADD_ADDR.
 		 */
 		subflow->fully_established = 1;
 		WRITE_ONCE(msk->fully_established, true);
 		goto fully_established;
 	}
 
-	if (mp_opt->add_addr && !mp_opt->echo) {
-		WRITE_ONCE(msk->fully_established, true);
-		return true;
-	}
-
 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP. Fallback scenarios requires a reset for
 	 * MP_JOIN subflows.
-- 
2.32.0

