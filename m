Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B9171AD
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284777; cv=none; b=gZeR5kuIIJ+5tV4bawi6oEGSaoTHUCxC1pyaOATf+seXNgJastzuDSLq/z+b9dGRWmqSsNJPXZlzmzfMWRmmWEzvF/eg61hX3K+qzLLW2Oo2q3fmXbPKN31PdIFCnb1GcQa7/5X1SarWONU3a8M4sfEPem2e+YpoBDM/0G3dAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284777; c=relaxed/simple;
	bh=tTgPHWnpK1ARuYaqryAdkko9C7B0FiHVoFSbYKVwDg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxmTwehAVzplwzb5WjtX+mEh7KO1yCgwtsFghjpWHfizyx52mqcHHt2hFeohyVe8sg0VuFNlF90TVHSoO+YS8cv2ZDcN7eVCUDKQ5TeSGCLpFkYak9ug1xuz3QjhxdjSrQzISXzSF706CmoqqpAuQI5Ie7rWm1UDtYli7rfouLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWbXDzyg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWbXDzyg"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6b22af648so2140967b3a.0
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712284775; x=1712889575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLePXVeMPfpQzwXoy7NOU9eXP6dijn/e0uzvyqDninM=;
        b=OWbXDzyg4RHdNOf9WHoRKPu9WFvItlfmdHwoh+X7r8CJaCc/gzpEIulQHDJnjrAOkD
         cOQ1MSU7lvOzIj3tqh+5emZjP7UzJNJ/+0IjkFe2EbauOSl2K0H+2cwtZf5DoGSE0L6T
         yW1jS3nvHyyGgt5ebdNKChvQJHLzyCD8EAtjqv5x1r1h2VoSQQr5EgAfWBnwOg9+VBTo
         Ru8zEQWkgnrF5F1ol1W4o4bD7eaoc7hUG+ed6VPhc6rIyuCdq+JPRw9YLzVeNNLrdpVh
         AREpxKxHGKPuaUh4DT2iO8TUd0myJwyM2m1JVszyYcVqA4QvfiRhHi/Zx4hu2gXYIqS0
         Wy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284775; x=1712889575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLePXVeMPfpQzwXoy7NOU9eXP6dijn/e0uzvyqDninM=;
        b=iQEFPp4NTPcC+AGE46Es2m5aUX3P1uKA45Siwf5LSPBqedn/0YLpRXrgpmdARLmR+c
         EKLQyPbagLrd9s3q9jv1nRHuFJQPICvpSSTYEZOY8pxNHTwKwDO1sjg9JH+GY5z08fVO
         WiXxlPGIqP/oDbOEEzmMUfPXOp/ONGJ2C8hXpq99D/AnBVUTEvbkv50Hh2o8YgnNR4nL
         rsLNolh8QPj7BRqeWtM4P2xm8hlSdCh1fAkmj3XomUzcrXBsipbXKfJ8iewRe5IVP7W7
         y3i8n67Tt5D1NrzfxMdnlf/ajs60LGMrlbeszh6xIzdVkWi/FMJ5QocCBZLU77J5XBPh
         hwaw==
X-Gm-Message-State: AOJu0YySwG5bs6yIiEQbdpfu9LiTAi5xNXreX90VETz94Xh2IbUpmgOq
	mHzghew3vIlWnNhxr1XZlvGwakUifv4ycwjlApoZgwqJT3TfdEuhzT38hiqiVuo=
X-Google-Smtp-Source: AGHT+IFgg+Or3iPiTfJ7Gpg6zUuzHOLtW8b/EWVJmICdCHYpjFDA+eeksmR2Rov5q5XFktbksHTv1Q==
X-Received: by 2002:a05:6a20:549b:b0:1a5:6c2c:2db9 with SMTP id i27-20020a056a20549b00b001a56c2c2db9mr1676278pzk.3.1712284775505;
        Thu, 04 Apr 2024 19:39:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id g27-20020a63565b000000b005d8b89bbf20sm366494pgm.63.2024.04.04.19.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:39:34 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
Date: Fri,  5 Apr 2024 10:39:13 +0800
Message-Id: <20240405023914.54872-2-kerneljasonxing@gmail.com>
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

Before this, what mptcp_reset_option() checks is totally the same as
mptcp_get_ext() does, so we could skip it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/mptcp.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index fb996124b3d5..42d13ee26619 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -215,10 +215,7 @@ __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 {
-	if (skb_ext_exist(skb, SKB_EXT_MPTCP))
-		return mptcp_get_reset_option(skb);
-
-	return htonl(0u);
+	return mptcp_get_reset_option(skb);
 }
 #else
 
-- 
2.37.3

