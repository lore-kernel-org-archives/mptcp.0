Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC95646C
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897116; cv=none; b=PzX7AsPhQy6TT64oc2XaPfJq2bUojsFycE+pQuMh6rUPnqSHz6mQwMcZBUfmG+9+AIRFVwJqR02yK9zZVIeNbi1Xz+rvfT8r4BNuFAG3JOS6z+RTi5yDTrmtvZlmv2Z4PU1Cwtzb9YhzajaZ/mnuEjf79qGd41+9mBqWW2KDHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897116; c=relaxed/simple;
	bh=XZ60jz/4L+dtCcaLrNLOEHxEb91G13YdPFdP6fZhVDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRyC6UjqdS+fQ5J088w5pd+mMGLw1Ft8Qd6s3uQ5s/MIOtuOY1l2f+B5Hv43O1ZfWOvXq7UHVzBQe0Vh3eju01of2MRvivgVC87I5RFhehBhnowEp1mm79xTpNKoTqZiVZAj7DV1mgkMxS2wh8ZMx3JKl9kDeNXak8KIUHakXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5CGtqjx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5CGtqjx"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc139ed11fso21348335ad.0
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 03:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897114; x=1710501914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOV6rkeK+dAF2umQi90xQLCfmYrig/9c5Ifw/L4zFXA=;
        b=D5CGtqjxTXHEyFkbODmwrJlmmnv0FYsM52wRpidF2YXfKNCBhBuL9C2/OSyjvyvCRs
         EdB95pcjnvV5sQmge/2bUQauJG+RIh6IvSi6Fm0xadzlM2OaXn1Oru9OJJHeGija73J/
         tBB7axFjpUWlLY8QybXXwu6L5D3ORobYJ5F8X9DsS9H2wMEyk0y7SXN9GNB/lwNapJbu
         nWFddsr1RfG+zMzdzM58LGIhPLcbcxCO+2NrAX+LyD2ZkHfmxT/k0S9/vPKOTk0LCIel
         BCsvj0wXnCGEK5ol69w6yS0UQuZOJA6h91Mu0FwBDVP6VUV18B0A2KWUSZqXTU8+KrVy
         OXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897114; x=1710501914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOV6rkeK+dAF2umQi90xQLCfmYrig/9c5Ifw/L4zFXA=;
        b=ivxi6q1RthlZjJiwRfmUlFjiuSqL60nT7WmZQneh/qcDt9koQadohTkx4PoFhtBcFl
         +qmuFDSlvvGLv6yqChH3Vh16gaYuDn40oTzpl0TZEstKsmNjctACE35H1KLwI9zYu4rj
         Mf7FtXP5VJ2ri2QmHJHyNG6mt0Ibo7lRGY9BtZzeh5+8hB9FkukaJoXdZZPXT5d3298F
         iiDsYISX3LQzJ1uwiou6X3dI0EvfS7Kc4wafVdsfYNziWw7EnSxKEtPEl8emXEtp/JwG
         lhjxhTwfIgyCsyLSAf2iOukpiT++b4yahF7OrEvZq5lLYWIWGrF+0b3YWx3gLs29SPfq
         MVfA==
X-Gm-Message-State: AOJu0YwQvmU4hsWvx3P0VHFbHgkBKBOK6extNbCUVY6GDhjYWbiZA1OC
	+mTQ+UEaw/b82iwONKfpWNd/6wzqvp8dkksLXsnZH1l9I+/UmhKZ
X-Google-Smtp-Source: AGHT+IG7sno4VUVtN1IfNefGmWd6UIeSez2uZObIv68bmv/gFoj2UfKeoZdWMoXWurBSXW4afI7lvw==
X-Received: by 2002:a17:902:fa90:b0:1dc:c161:bce6 with SMTP id lc16-20020a170902fa9000b001dcc161bce6mr4888621plb.15.1709897114213;
        Fri, 08 Mar 2024 03:25:14 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001db608b54a9sm16049806plh.23.2024.03.08.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:13 -0800 (PST)
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
Subject: [PATCH net-next 1/2] mptcp: annotate a data-race around sysctl_tcp_wmem[0]
Date: Fri,  8 Mar 2024 19:25:03 +0800
Message-Id: <20240308112504.29099-2-kerneljasonxing@gmail.com>
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

It's possible that writer and the reader can manipulate the same
sysctl knob concurrently. Using READ_ONCE() to prevent reading
an old value.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f16edef6026a..a10ebf3ee10a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -850,7 +850,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
 	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
 		return;
 
-	new_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
+	new_sndbuf = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]);
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		ssk_sndbuf =  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sndbuf);
 
-- 
2.37.3

