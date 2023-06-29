Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198913AC3
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 17:06:02 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so5379345e9.2
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688058360; x=1690650360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFRyAdSIxqUZQqfPJUWxAEQjiS/V1ekdNR3eKWn3VeM=;
        b=TF404rn32TCtAn1gwHxs+g9VpYC4Au5mj2P9ct4UJjlHIOn9zSydiJ44B02DQ76Ky3
         jrFm89C1PAmNZzgTPwu9wGdYODZUlcKpA8RBX+AAYFT09BsY8XBo5ECi2OpUfwDwd2ur
         aPrZfKAQznn8kAmRu6/++wy1lOOE2wCIfJLj3TlBQFlwt/xPaQJK+5RhmNBEecpA+fc+
         lq2trN75zlTzU+B65CnOJjKqkho34Q6SncnPsyQY2RWmZJolPItYMP7KrxstuI/btec1
         JgIWnP/0PZeLOULVhAWk/mGSTK1D+6NdTnwMXOs44v4HwACUSTpQng9ZrrsY9t3xIbP1
         psbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688058360; x=1690650360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFRyAdSIxqUZQqfPJUWxAEQjiS/V1ekdNR3eKWn3VeM=;
        b=Hx/AhfXaXMpq3CBP59i5BfsSIAl9S0ntZJtB2Os4zj8xgWvt4TqxCsPaJD1gGDCZ6d
         5PH5+7QdT5BQsziDSDLnQyBw0NveyDbV/IOD9epzjzDQj4cdlF91AbUbNPNSZSIfoDJ7
         SRbq+Nx+0s8qRf6WzDVKwh8wXSEWEYIa0auBpkq7oejcKUmNFzGacEKeJ5vDLVcimT7D
         7MIYdj6xAqeKCSskrFabgyADeBvYDahXu4423EPIxb7GsMBjjOe1R0pQoa19unQXufuG
         OwFr97GzjVr+7uIixf32VapZ79ZTVqxsznywPNTAgPve+lbD2wSWr1i+nfFjuQ/cynPh
         VCKA==
X-Gm-Message-State: AC+VfDxvfIiU0aN50WNkJ0zCBCYFuVuMObv97O556AAqc4dV+RUfpjq9
	/LxSOXxAMVUB7ODggflFvFRpbFdPhQ9j3s1dNJUkdgl2
X-Google-Smtp-Source: ACHHUZ4eFOw46RDQzssAz3LrpRZ4OUSdCbsFnzkBbjP8l92XUv6ZRbdQHffnXa6rvfNWXdPZNRglLg==
X-Received: by 2002:a1c:7c05:0:b0:3fb:3c78:5c23 with SMTP id x5-20020a1c7c05000000b003fb3c785c23mr9237378wmc.22.1688058360602;
        Thu, 29 Jun 2023 10:06:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id c25-20020a05600c4a1900b003fa9a00d74csm8973471wmp.3.2023.06.29.10.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 10:06:00 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net] selftests: mptcp: depend on SYN_COOKIES
Date: Thu, 29 Jun 2023 19:05:51 +0200
Message-Id: <20230629170551.3043312-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=YM7YHXhDFlJZhIk8zqWqQx/gGkKzEJHZfPgulw1sUgU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBknbnvhnP2BEdNTWl5DxsIGJR/wLFLMd7iTtCud
 XM5OGc5CmeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJ257wAKCRD2t4JPQmmg
 cxF9EADAmqL0fRrWAegVFv7E2p11BWsPPxhuNIdTR71kmem2cQMuv/GdngCvMgno0dA6luKO9k7
 65T16lYqeftEEkXW/J9nSHV/JgOa+B7CGyWY+PXNxU9RqhFuUUbZNYHb9vNV2NkxsTUKZ29TxJm
 Iu63JEVfF0iLVBoNL+Ydc4lVOAuOmolAJDkytitbhDQd1V486BJHexvVhutU4kMEMECf+bAKCaJ
 m9YPiAOYOF3CZ8Ws15phoVBavE2UEjnRTAzn8yJ+hGrIHs3aOJnM65UGq4Q/eFOOQr89Ht54Bw/
 LX5slnlcIaVNIfLdhKmC8tc7TXansEukZ0fxf35BIbdRX9dmmiWeRhDgbAraw7TLuF11kp8WR0M
 WFH7T/GQm5Il280DK2lB2Twpllu1KmEqqXdEVewqQh1NgUeJFuDmmDSygbVKXBk2Opz9MTIWEkE
 OD157w+K11C3WfnZm4jonKIkgXaiWw4V++uotlt5vnUYJpwvaHkO5qfLOI+zksMyLpCahLVWQeV
 m+Rz40cODTdhf0rf4llan50ziKIxJ9/dU+SnNm9LHEddo87rgPbH8uoqn7SgKZxDMTKPOxDVkMs
 qGJB/Fp0vfwGZU91uXHKnr76NwRUPguBpKJ5+mlRm/Cn3hsI9HKPNWoXf+CNKWncY5NhyBELHma HTB9fMNCfGVQrpA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

MPTCP selftests are using TCP SYN Cookies for quite a while now, since
v5.9.

Some CIs don't have this config option enabled and this is causing
issues in the tests:

  # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     (duration   167ms) sysctl: cannot stat /proc/sys/net/ipv4/tcp_syncookies: No such file or directory
  # [ OK ]./mptcp_connect.sh: line 554: [: -eq: unary operator expected

There is no impact in the results but the test is not doing what it is
supposed to do.

Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 6032f9b23c4c..e317c2e44dae 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -6,6 +6,7 @@ CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_VETH=y
 CONFIG_NET_SCH_NETEM=m
+CONFIG_SYN_COOKIES=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m

-- 
2.40.1

