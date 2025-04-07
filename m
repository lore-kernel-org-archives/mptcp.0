Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFF2288D2
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015907; cv=none; b=YfpUPg28Nit7yJS+2Wnh527quCQVaQGuxprbQQJV2TC8WqegUhmmIlRUn4KmrufwLdYu4wWojYocvBXp7Egtd6uDXK3qblz9UEYfM633wGNEVa5tfvhxvRtOUqd8q/0G7+0P8M2P+1ex9NlXMKowtOTNL9jfhomCQI23RcxvZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015907; c=relaxed/simple;
	bh=JzUuLgQjqzsuDFsOmyFLNHi+3ZA2NXJNSaqGAaMZIJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2hPR71YWR/zEMrjwA0it/73IzCOFPeFdTHVRN6P5uZIXDfbtOFQIy4qyVZbssAiqsFtY1URCNvPkgazkUrw9rQ9EfDJFDEsY+Dgcwo/UYPnN3ghtbgylQMtKDGEF8msTI2nrUh8BFw8JwmNoZH65Po24jsZgcgoW9E3DIbG29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YnP5rIzU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YnP5rIzU"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af241f0a4beso3303453a12.2
        for <mptcp@lists.linux.dev>; Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744015904; x=1744620704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uyJxUSjwirFDuWmm3Ov2pKSAd0ErZhNjYPXSZRPwMg=;
        b=YnP5rIzUBdXA5YAhdRqM40qEe3asPAJLGgEIqRz5wcnatE5X0Tx46r4cNgj+uDL9EH
         p/Yqo5n0BPAwsCkCb5rc6reUUBpP0x3qtr5zkrSBYtm6WdE3ctRXsJohpNwTjijdZmDQ
         2+tjra3fsdCyDMAhKifqppUphN/RAbtOviF3ja7FY31HICl7jgzXLxvS8+83TbB9+hgg
         O/nY79tpfQJz4xWiPCIQnxEb/MMGAXXlbzkhdNAK05vH8odPyQMq2cNTo28Lyyss1zBo
         ggWERB5yOJPKsw+qMT1ENKOwMmwnwsaqbYO0+KBdczL7/KSMok3nOsyQ+pfyFLqYtBvz
         k85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015904; x=1744620704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uyJxUSjwirFDuWmm3Ov2pKSAd0ErZhNjYPXSZRPwMg=;
        b=OkbTQNabBDiGV1qUc9L8vGITxPSNJUzQPMgPkDE3Z/GP1ZAyr2MLMIbBOzEbIhXBsR
         PUcXdO8hcjgNTPG/CfTBZKB9RevHsYlE3Dzzznjc9WjvraHlAcWjC0dy7Mi5BzZ7rDoi
         XLcWZT2zG9F5GAa+GyPFleSSGzvmr79IzOtui3ZxyKBrJglNZaPXKUYQCbC+RsNd8Yav
         XQ4jtUHLdL+i4hDuKGH34jJyv5tPkZ9+lX7PC/dqnviOZT33luaMPG8YUZDGGUNbiRAq
         9e+O6wgTGvjfhf6necXuDVu5SmE1r0UCcBGYlonbJblIo0Vh+XhvAwoDpeWl8rFK0om7
         ae/g==
X-Forwarded-Encrypted: i=1; AJvYcCX/X7BRJwDbc6qx9F4msE6nKfqg/molIfqf+eB3JPQmELOcDe/wOb2BJtdbcllcouOa1ANkEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfN+qSXLP/0NKMrggeEuRQSZ+vAbm4sS9zYrw1JL+RvLS1tFO9
	a8cHqiebjnNv1utsm0y3VMyqqkYoooKTkGTiJNpjW4HP/XiT01i84CvqTSc9nlI=
X-Gm-Gg: ASbGncufQYIsDGkhO24aXG8dxUYAFic/h8va3FYa5lv2czEVx6xwwG220I4soLLxvCv
	L3mYDxd1r65sebZpV81lNu9IyhAuFTQYAQkPKCb3WudeMRjhLBdD33tILrseqO+5kzEHKKk7i85
	0XveHIFqwX8PrABVosBZKnuIk4mPNSYhL2E2JEX1GtQdkmYLv2SzLeIHEu9vlysAcwbFPbgHIrs
	eItIhT8rNQ2vxC2NFppiGl2yNJCQiWCykc12F8HiNo+ou0/+gdrFsq+T+zjjLFRSCSFbxl6IJje
	JvsG8SC2KcL026JlxW0pJrRcZYVZ8bpUjPtVV9yuV8uHAzg/3A1co9MJKnJ0Zdu+X90=
X-Google-Smtp-Source: AGHT+IGW7/HQcOSrWsFxMUBwQZEFvu6hcIo8WL0C16qqewIUDvPZ3V176EqIWn668YLPeuSi7WpN/A==
X-Received: by 2002:a17:902:f64d:b0:220:f87d:9d5b with SMTP id d9443c01a7336-22a8a867cfdmr200793525ad.24.1744015904387;
        Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
Received: from always-zbook.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787727eesm75759455ad.224.2025.04.07.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	viktor.soderqvist@est.tech,
	zhenwei pi <pizhenwei@bytedance.com>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH] selftests: mptcp: add comment for getaddrinfo
Date: Mon,  7 Apr 2025 16:51:22 +0800
Message-ID: <20250407085122.1203489-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_connect.c is a startup tutorial of MPTCP programming, however
there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
getaddrinfo MPTCP support.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c83a8b47bbdf..6b9031273964 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
 	}
 }
 
+/* There is a lack of MPTCP support from glibc, these code leads error:
+ *	struct addrinfo hints = {
+ *		.ai_protocol = IPPROTO_MPTCP,
+ *		...
+ *	};
+ *	err = getaddrinfo(node, service, &hints, res);
+ *	...
+ * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create socket.
+ *
+ * glibc starts to support MPTCP since v2.42.
+ * Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
+ */
 static void xgetaddrinfo(const char *node, const char *service,
 			 const struct addrinfo *hints,
 			 struct addrinfo **res)
-- 
2.34.1

