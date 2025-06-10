Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056092D8DA4;
	Tue, 10 Jun 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560407; cv=none; b=q0o2PAwEigip0vxHv1hvhlDI3jx3dHBvfBxvdFHiJKZoTLnRdqaWlmPwYxxIVfYNQ3cMbF+ezLDFex2b3LLZHdDuwPn/e3vE88XwT1vjisWE1GEtK5Ra6ALmGnb0wqD8BwPcKVwiec8tj3yQ/jF2vCLT4WlsFox2MHRNmWUPtF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560407; c=relaxed/simple;
	bh=IlPcq3mFEXCcNLGdbaA7USQGMuvLdkvGnpYHgSkEQWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC20qTSqIDvXZqWXOdfccLDBK40G1qaPb/9ftZpTcZsLTaNPdf0YmwDCQAgYPZjb92u5wjF0JW4gWmzgk1lwHdyWD8DMGHxPCNyxCUy656wFOBrHJPnkUaq7yhR+OhN+xv7bo/uwhsLM5B3/mBTqiyGgXxYODKetMfB+K+DCWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnmEiSE6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnmEiSE6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2103744f8f.0;
        Tue, 10 Jun 2025 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560404; x=1750165204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMxgXQ0jevyDJ/ND5HyBUsgL+Iy2YrdC73ZOx6fVgQc=;
        b=JnmEiSE6T3W3D8ggf71UA2KyoxWrQ8ewok4enwHVKpNdbG64gUUC9Xs4Oq+JPMa2Ja
         KVQCMDlfmheKmr4u7ZhdFBWdfVktbrVI59Aga7Wo5jdAyuXwqAAxCagpbyEReWfRrZ62
         K4a61EBIjOkaBePRrb4fjGWUtExcrUSUcgEu9xJHXu9fj4nMkbWPOSqvJWrCtmcOd9IZ
         K2ClHOxXc0Tr+Bcbv4z8aFBnB3E/cg2ShI3ztXCYV7766jVe/8yhCgEdHZV/AnpKq/tk
         Ws/mbzPQpF5Tvg/4g5cdanHxRdS1Nz5+vD4KqIzI5lC6CbJ04ftI6Yxa4d+WO31bvuAB
         XYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560404; x=1750165204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMxgXQ0jevyDJ/ND5HyBUsgL+Iy2YrdC73ZOx6fVgQc=;
        b=T1MwilqtPFLj3ZyhE6kPHzNhTXrMZg/2IizVBEh6ysh4IoHH0ABNci/yEr/0BgOjEO
         zjLfJhBIXquji+klu2yNPWqTo+51a8q5gFx3Vy+KxbwFInzj9oKGXEAkOF2d2M8Vzf12
         JBLnVBEqJ3NKadyFNa7cc3++mL9zAvMZsChtVWpDTUD9+PIoFbNaRPuUlXOqXzA9K4IG
         87WV/bscvqXYi2Lcli9WBHpFqV0j+JGejoTMw8quDyXXqcWIC6cNTbYQe0kLhqxuqgFl
         gXwOIpeoJOx4rwIuCGZCWABsSzNJUTBd9xUuX9m56H7i7ioSCYVnCVtoakeIIz3UsdRz
         nTYA==
X-Forwarded-Encrypted: i=1; AJvYcCWKCBMSPGPRiumekoVyHTZkL5EZuEWb1YjpbhwfxPN+6Af/KdcFW5hfPLEZ1xq1lPHZWBo6+DyeN86brxe4nUC4Y0PktQ==@lists.linux.dev, AJvYcCXB/erisg3adh45KZsxJ9rU5Dd3lHu7VbVRYj5aPPU+Wb/HaEoGI0WBw5gUuc+BoJYSW5UJ2pw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzGtnkbNDNtSQszXTBdZma6UBBTDSqe59lLGftSzKJgr/ots49T
	b3XZf/2003LiJ3T9NqKBi709Cqd/mT+PPTHJvIyaxIz2eusO2adacBmh
X-Gm-Gg: ASbGnctQCqDXaduFBebP56QEkv9d7OoudCf4nef+UKYsdOwZMWRHAsBWskkwXrI/nvL
	4JpqXWqPN69YjksxtpZ2LBgWsznIYwu9A5M29i4wJ/b8410xjwSdirErbWSpCDJY3W2uySSx0XK
	y+2SaH9pvrCwMBoBLaPlrQeI3dd5dtFLbqW117wHK0JgCJ4GP2YUO/Pz/FAYabRxQKMg/JvRQ+a
	waQi0fdqnse30JPLphdottG7S4Yq7/h/y8G2ioRc4Zqk2BdrOdGzAg4KbM3xfyd5ERY1ZIfLPI4
	4gmWznx81RPGiU+5uyFBVjIJqyAR8fU38oegH7dcmGwR/0g3FMcTr944aC7DwfkJFshbcHJee8y
	RqUkEu/YwNeXP4V4=
X-Google-Smtp-Source: AGHT+IE/fK31Vav6E/nuroESCGrP8TVj+xyjNp3FjK6+XBphGx5l6s08v9+9QjO+BXEI9E7lHxx6ig==
X-Received: by 2002:a5d:588a:0:b0:3a4:fb33:85ce with SMTP id ffacd0b85a97d-3a5522caa5amr2342209f8f.46.1749560404186;
        Tue, 10 Jun 2025 06:00:04 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:00:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 7/7] netlink: specs: fix a couple of yamllint warnings
Date: Tue, 10 Jun 2025 13:59:44 +0100
Message-ID: <20250610125944.85265-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the remaining yamllint warnings in the netlink specs:

    [warning] comment not indented like content (comments-indentation)
    [error] too many spaces after colon (colons)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/devlink.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bf54eb2b639c..ad56093d6ead 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1139,7 +1139,7 @@ attribute-sets:
       -
         name: param-type
 
-      # TODO: fill in the attribute param-value-list
+        # TODO: fill in the attribute param-value-list
 
   -
     name: dl-region-snapshots
@@ -1266,7 +1266,7 @@ operations:
           attributes: &dev-id-attrs
             - bus-name
             - dev-name
-        reply:  &get-reply
+        reply: &get-reply
           value: 3
           attributes:
             - bus-name
-- 
2.49.0

