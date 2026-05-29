Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F7224D6
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045594; cv=none; b=TZ6DL8+28NSkjfeDN+cjR2HUW2/uUeMD+3Q9XOQIBCEWXdqwnW3TvNyxERvYviu2NJ6Hh7+4vYI2ODAf5p5a8p7VYi5pn+VrtZb+SJZbNLUWqlAvng4xbbVrgbvPAXNxS8eXGvMn+O4gNx7TnPDRXNJXayv8m7DkeT2dujVUNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045594; c=relaxed/simple;
	bh=eDM6ahACxJmmKESA7Lo8JC2BUDL8SSaoCP3lxkfcULY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dd2G1BB2gUkHo/EkXSQcID2ReVdcKKxXY++3PhXggHVVOGHohDUQUEowtFUaHjCWlL3tWf/DWmH4xyBs7PE52iRBQ1pEKEYqSeuukbL/OrksC1ALVyzorAZetJ2+QBAIM6Y4mS2S7JrCL3U0ffozCipSM550d6BY63R3jNMM/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fb9AmmBW; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fb9AmmBW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780045589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JNyw6tH1cj0/zJxw0F05Tqw/i8jGJ19c9XWFRjJTgBE=;
	b=fb9AmmBWYtR6H0a/Y/V0q6pJAxqNdgnxaPWNs1VlOA34y/3/3B0091wttlUvea/93YnNgT
	G773GEebiKPSMPqfsBiD5zqTzdaPHihHFfw0YUgvd/6RI+aXx7Y5EcufDLw4M26C+y+GPp
	lCXYWyXeH5vmsNEPcexCAdKMviHIbYA=
From: Gang Yan <gang.yan@linux.dev>
Date: Fri, 29 May 2026 17:05:51 +0800
Subject: [PATCH mptcp-net v3] mptcp: check desc->count in read_sock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-read_sock_fix-v3-1-bb3fc3f44b22@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAO5WGWoC/x2MQQqAIBAAvxJ7ThDFsL4SEWZbLZGJSgTi35OOM
 zCTIWIgjDA0GQI+FOl2FWTbgD2M25HRWhkEFx1XomcBzTrH257zRi+TmzGqX7RQUkNtfMCq/98
 Il0/WM4cJplI+BQqSMmoAAAA=
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

__tcp_read_sock() checks desc->count after each skb is consumed and
breaks the loop when it reaches 0. The MPTCP variant lacks this check.

This is a functional bug, other subsystems also rely on this check:
TLS strparser sets desc->count to 0 once a full TLS record is assembled
and depends on this break to stop reading.

Add the same desc->count check to __mptcp_read_sock(), mirroring
__tcp_read_sock().

Fixes: 250d9766a984 ("mptcp: implement .read_sock")
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Hi Matt,

Apologies for the delay. I only just realized I’ve been overlooking
this thread all this time.

I’ve sent the new patch with commit message uploaded.

Thanks
Gang
---
Changelog:
v3:
  - only update the commit message, no function change.
v2:
 - Link: https://patchwork.kernel.org/project/mptcp/patch/b404cbca4b0d30f82c56f65b38e1c2038bd7e5fe.1773740635.git.tanggeliang@kylinos.cn/

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 29cb10c02ed8..1d652ded9467 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4476,6 +4476,8 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		}
 
 		mptcp_eat_recv_skb(sk, skb);
+		if (!desc->count)
+			break;
 	}
 
 	if (noack)

---
base-commit: 64a0f10e355310447acda9767d4fde746159172f
change-id: 20260529-read_sock_fix-3faa59b82538

Best regards,
-- 
Gang Yan <yangang@kylinos.cn>

