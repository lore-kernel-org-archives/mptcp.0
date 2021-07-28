Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660AB70
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 11:13:10 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so9460845pjb.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQTyZZcmBkEx/und5K5PXANSSxTP+FqyoRDE+0I7BDw=;
        b=lByy07MOynsOQ0t6xZc3b1ufM6Bas0QFR/8IKng6MjKmaJ7C6yKgxDMetjC5195s1z
         yMGpnAhNz3sTeaNralNMUKdH+HYUtXV+9H3DyoTuZj4r3hELcRRJBwoPE4AZvotWsAxH
         7tZoFy67/9oLS78JNWBWd6ET0KtXbm9QURDi1ytTJbUbk5dODe7S9GO5mxHTU5aKauwI
         blbVU2S8CTABw3CvGIBHoMtLiyOs2+7WRVJ1LDueIwP0C1FvBd117Ml5lcvfIFbN3/5o
         GzbHbSjLeBBpz6NdBtTIc2vlHG5jpXaUKp+6MUY9sN8Hg2MdVzviTxPyo10Cd31OxDSJ
         cwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQTyZZcmBkEx/und5K5PXANSSxTP+FqyoRDE+0I7BDw=;
        b=MFfYpXMQkm+NpP0fEABDfA/+lmhODFtNJq92Kc2RPhLUM7tOwUY/3BchHmbPSVO9AG
         JprHk1trMw+78K3cKs7LierVhVn0nFEInlu6NEF2rrG/jVBFLUrZWkQdEJHiqAzmwrEK
         DBCHyuKhveDz3x74/kRtxd5SC6PPSphb3GKDuidRpGxPKDkyvqLjlACac8O4NQX91m7J
         6cYHIwZXNqjj/rIptXXI01r7N2ldTQCLEkWwn5N696NBw1uqjn3gDLH/MxwOqGLZQIGH
         AmHncvsy14VcbGzOtQwmyER5Y13lpQZkeXtFkXnGSQKhL16rvc+PgxzrEtXCNX5Y0znC
         Oi3w==
X-Gm-Message-State: AOAM533WWKNp+x/xQ+1qSa9sQ39ggubCBJJWi6RUo0hXowGKGD/O0Hrx
	iu3snKy0NedXa0ONUoHNU0zt7Rt85nM=
X-Google-Smtp-Source: ABdhPJx0RCboxsh7xFDTpRkBHO/xOIaIU/+OZT9aUTyh1Um6l9rZCcP8kdvky0cRkOYV2AOMldxJPg==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr9226277pjh.40.1627470789823;
        Wed, 28 Jul 2021 04:13:09 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm5761002pjv.34.2021.07.28.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 04:13:09 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: MP_FAIL suboption sending"
Date: Wed, 28 Jul 2021 19:13:05 +0800
Message-Id: <04121bcd7e28251f4a3e1b17774b8ef5402f2431.1627470720.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Drop the use_ack check, and add a likely tag.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/options.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2b15063c8009..6db24cf72ac0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -788,7 +788,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	if (!subflow->send_mp_fail)
+	if (likely(!subflow->send_mp_fail))
 		return false;
 
 	if (remaining < TCPOLEN_MPTCP_FAIL)
@@ -835,12 +835,10 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		ret = true;
 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
 		ret = true;
-		if (opts->ext_copy.use_ack) {
-			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
-				*size += opt_size;
-				remaining -= opt_size;
-				return true;
-			}
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+			return true;
 		}
 	}
 
-- 
2.31.1

