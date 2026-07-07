Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318843786F
	for <mptcp@lists.linux.dev>; Tue,  7 Jul 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444667; cv=none; b=oGqxJILFdlnze70opnDpj5317I5EzColj3eeXH9XpRah8D0l6wWs3tXjswgiKnyHZlbiShda5twJKXG0uXSPypZMJE4dLvss//Sdi7M1iAdprs7vj7pVsujzjwnkZdqdZXJPypcSwO3dIuzhzy/VR/3BCoTpeYR0vAgebzFA5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444667; c=relaxed/simple;
	bh=nu6ZSgb2jRk2Ndie2s2jUBHTDDESXJco+T6QJqejMAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXaIWVhhsUy388SYsjbu+Hp3kyk6n13MKGDKfMkEX41slsctlQlUiL5rT2aDAqJEAV7zMMBxxqsJJhNO/Mi7XZarxQmmmPctG4Hb7EXBkroxht1aVLtCMe0iTNl6FqtgNK/44zcEvux//vNzZtdhuUZ+4+Ja96JCfMG3xSSUJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkiHYXnA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkiHYXnA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e51d3d83cso228036285a.2
        for <mptcp@lists.linux.dev>; Tue, 07 Jul 2026 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783444665; x=1784049465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUCStv+mG3q24BIMvpoJICyGa6vMwC+AFAbHW03keOc=;
        b=qkiHYXnAJpMjmUw4s7R95BMSemiesKaf6GKW+/VsX9MRvt0svavMkcZo2GONjlM7xX
         wb+5eHmVRfbKHktZMu1M0Bg/qouLWVDJn9BVADc8xSNc+kf5wcJrSc5oWOUrzLVSKizD
         F1KW64qJMVZKZN5PWqsg7Tv008JwNGrv4AS0mWycaI0i3IIdTxj5I2ZhtsZcvC43pSTp
         eATQeb5k5p5GgQ6SxqPSToZ9viJMyZr2i2+fmOEmW9Sd2qNvACc+5WmveaALLj/0P7tJ
         jflI0FVxKB4uFcv4KDWFa/ddv5/n3GobCNDK2W1kVcvkaZq5Eb9IrspST+pUEKM7bznW
         q6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783444665; x=1784049465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oUCStv+mG3q24BIMvpoJICyGa6vMwC+AFAbHW03keOc=;
        b=lUHk5HOJmhfn5Pado9n/fLC06rTyCwx4CJsYOx28YhQ3FUg4r3MUPwx5dYfmqJ86rv
         DAlIJ+QQsWkcUEFnmZHggxFbsOIc0y/cBKhr1iyyqIiVzbtvAhySL5mu/6Tmu4WAO3le
         Z/VHS7ejo3mArxW1m0IkPV6vA1t6HuN7sgfsI9d01CXJpd4IUHwTQAgijHkVB4pM3XYD
         93ArLUIPtlmTAVDQdj/eI0tM3iEG9x0VWomI7jOboVFUhI2JL5t03P0SWMdYp1FmYQ9n
         EVgAZSH33RAxSk/D1fXl1/OTDCM6uUa34ar6mPHWImo6X8tmCa5NMmShhb8BxKKasXKc
         jEtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdiCWr1k4vJ6JWpTgmQwqX1wm11yWbB+wNjkVGNKFruIIMr2tsrW1VDPPE6KJPU7DD/cpr4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1Xf1WAbjd9bA+QW9K9UFqpk+uHxNbeHJ8VmWtgHZyUw9zt1ae
	rnbJgDXKhIOPPrjb0WX5BSGnRxjb9lIEML4pqZp9a5x3sh7l2M6emE9O
X-Gm-Gg: AfdE7cncJKNMPM2/qxgHhT5w0lSppUa3Bu9uOgGPRVElBrJtWpEqdt8rPD6tEMd4zKh
	0xIvObroALGWGWSq2SYhhkFhfg1+SKg7ikXgAkL8yJczeUGqikZxrNp/GQiust6VhbHJ8GVuoy9
	0SaMpY5TKI8U6uHEpH4EUTPkTkVh0gIEmfSWvdCzR2xV2JncKNvZdzYeaqnWjfD7az6nheisThV
	/bFStz9wSwC+SIwSCZtIGl6xrNY7OUL43jSjcA6m3jHyIRAO8SWaOWyuLOfd6WZQWfR8dPRFw0B
	ItH/VWT73vz2z4M0WIsGj0ayVrnDh2w13KmsPe9lt1IA5gUZnkQaw/Y/+Gx8btWV+xu2V7t7U2h
	PKjdkC4h45PFwPKlJh4h9tOOBiWDvs9ygviSdSWN1Z+4ng6Y1vxvUBP6QjHUKHFj3u9vlTEW4Tk
	rt+KCPAQzQxXTjiqJLCLP025w2nFOHi+rHKNWbloA5zOqePLUtOTRrw0NJQrZzhGcoas4O71OwZ
	nwmq7+UuBM7tG6jWz3je+FAnxN+LxUx
X-Received: by 2002:a05:620a:4102:b0:92e:8a88:ab27 with SMTP id af79cd13be357-92ebb528e65mr702327185a.14.1783444665081;
        Tue, 07 Jul 2026 10:17:45 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccde4fsm1220363385a.39.2026.07.07.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:17:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
Date: Tue,  7 Jul 2026 13:17:30 -0400
Message-ID: <20260707171730.2679013-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
References: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

mptcp_get_options() clears only the status group of struct
mptcp_options_received; data_seq, subflow_seq and data_len are filled in
by mptcp_parse_option() exclusively inside the DSS mapping block, which
runs only when the DSS M (mapping present) bit is set.

A peer can send a DSS option with the DATA_FIN flag set but the mapping
bit clear. The parser then records mp_opt->data_fin while leaving
data_len and data_seq uninitialized. For a zero-length segment
mptcp_incoming_options() evaluates

	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))

which reads the uninitialized data_len and data_seq; KMSAN reports an
uninit-value in mptcp_incoming_options(). The stale data_seq can also be
fed into the receive-side DATA_FIN sequence tracking.

Record the DATA_FIN flag only when the DSS option carries a mapping, so
data_fin is never set without data_seq and data_len also being present.
data_fin is part of the status group that mptcp_get_options() clears up
front, so on the no-map path it stays zero and the zero-length DATA_FIN
branch is simply skipped. A DATA_FIN is always transmitted together with
a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
data_len), so legitimate DATA_FIN handling is unaffected.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: adopt Paolo Abeni's suggested approach - do not set mp_opt->data_fin
    at all unless a mapping is present, rather than gating the consumer in
    mptcp_incoming_options() (v1). data_fin then defaults to the value
    mptcp_get_options() already clears it to (0) on the no-map path, so
    the uninitialized data_len/data_seq are never read.

 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dff3fd5d3b559..6d003b24b969f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -157,7 +157,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr++;

 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
@@ -178,6 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}

 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
--
2.53.0
