Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36756752
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897119; cv=none; b=QkkRX4INic0CaKnCsQkVMNOhinfIcmascHMHUvTGcRWiDnyZttAYiHi/Ph+c3gsS+/0lmPlf3vvJcpZqwyLRSOoH93T9LUjZdCe5DE0J1AW9TfMkisJccg0Yg7UmIiMNpbw3iuf5IE9otoG+LV78ornuTHxm2LxBS0NshqZOgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897119; c=relaxed/simple;
	bh=Luvsy+WOnkG5qwVTfDfExXvIyB7rY3PNoN5HeFz1GrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCq+OpDJ1UM17rr7aItJtNeVCkOsENX8hM7JS480VE0zv3HFh4hhkl8G9J4Th+rGjH1/uLPxhGWrWxy4LaMVYt0Uu3BzNmHxbJfnqX0lpSY4yUQMGo1w279xIXMLkWHwh46POdaAkx9envVBGN76a6CwuFDtYuTt5SZ+rUEa7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0lWF0qI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0lWF0qI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dca160163dso6014305ad.3
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897117; x=1710501917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXvQs0Wk+UfdeZ/dr1xV6h7P5P/4xSbgdWXCtbE0DXA=;
        b=U0lWF0qIuMfX3+Enyx9ziMTxytn7J1yRIqH/0gq+OcfsBKPTe7vW+eR95QpoB+MG1i
         kx6IdamCZjVlOYfY6GwCrdhkyuqPlDUGSnm1vPCWA0OVqoQU+2zFzdgSsBrGGflEavfv
         +84jwkDi4cvBGUsBY9fdi0n42oqV0AIuVVMmpW7h2xcHKlSgpZIcNyW+w3OqSMlD/w0y
         eUp93VWiUfhSSJVoVB+qc95NyO9/sBhMV8gFM6kXYXUe+Cflc1J2R3zSvFdO0clpZsGt
         1119zlWFT6uCEUiaJ3EPPDy9VGFpFO4JBpNNOn1GFfcY9ezs51z0k7FnIe8Wll/kZeF1
         zbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897117; x=1710501917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXvQs0Wk+UfdeZ/dr1xV6h7P5P/4xSbgdWXCtbE0DXA=;
        b=o92HqNbUpQZTqSfdIXEvazhvmqcCKFfJX/U1GWFKP+kaP5NscKiPIPztTaFcEnwDp4
         hB0+YVRBr4K/o3VofjtaFXzkHSxxcvudEKIAzqDWHTUmHeZL2EFQ6ecdnjIdvSwlhUyX
         IHVjIGIUersQct/1jLWGrJ6Ei3xgCXQOVk9+ru9ozP2fhgw6WEBi9DU8LgPhsKDnu6ok
         lzU7KHJQ+mWO5KMxXiii4AZThfk+xT/mLNFFpPB/QyIp/uyodv7VcBAKWHb8fl21DFOb
         STT8uDVU8xD2mvyUHi42E6lwh7MEzzQ2rnEUEIG3AD1USlBfKjrsq5+cqhVQv45gCz2T
         d7/A==
X-Gm-Message-State: AOJu0Yx0YsFxItNnb6MidlcJhdvtpVRhLXVNmM4QgOLADiKyqhtYRqW5
	/NCMgQUC3JVQ50i5XsHY2qb8wE7PXPsAuGOu4llXW1d+9uAL3siD
X-Google-Smtp-Source: AGHT+IFFQ/0l4f/zaDEvYCTncyZ1WnhaATXM7WfOwj8dMyzIDUDLSi8bXOQb1X+6McLld5Oh6BOAEA==
X-Received: by 2002:a17:902:ce09:b0:1dd:6e47:862e with SMTP id k9-20020a170902ce0900b001dd6e47862emr614753plg.63.1709897117518;
        Fri, 08 Mar 2024 03:25:17 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001db608b54a9sm16049806plh.23.2024.03.08.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:17 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] tcp: annotate a data-race around sysctl_tcp_wmem[0]
Date: Fri,  8 Mar 2024 19:25:04 +0800
Message-Id: <20240308112504.29099-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240308112504.29099-1-kerneljasonxing@gmail.com>
References: <20240308112504.29099-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When reading wmem[0], it could be changed concurrently without
READ_ONCE() protection. So add one annotation here.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c5b83875411a..e3904c006e63 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -975,7 +975,7 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
 	 * Use whatever is left in sk->sk_forward_alloc and tcp_wmem[0]
 	 * to guarantee some progress.
 	 */
-	left = sock_net(sk)->ipv4.sysctl_tcp_wmem[0] - sk->sk_wmem_queued;
+	left = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) - sk->sk_wmem_queued;
 	if (left > 0)
 		sk_forced_mem_schedule(sk, min(left, copy));
 	return min(copy, sk->sk_forward_alloc);
-- 
2.37.3

