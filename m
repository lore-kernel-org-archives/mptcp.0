Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161310;
	b=Rm78OmOAcKb5Ra9ETZ1wFQ6I9vHGuG0mL071Bqwg7eJC3Cv6+OoGpyJ7ntNg5lrP92CS
	 eQJinlWq0p6C8FCd9kmbNCkSpMc+lz6jM7diM5HMJNLf92Lw8Tea/7EArPogK8ln7eY71
	 GnFlTjEa/m2MmZ40PFg8KdiK1etRc43ZkoRQhYMN/EDYA30NgZnAKS09R6vM5B0F0xPaN
	 O0vo0EdJsHqua8E0pLnSN65GsyXfUq6NooHM4XQxt7+oum7swuC+oSiFFPP5e3A4ZOmed
	 L/5SYBAl+Bv8rb+wj1RykIhAcBH5aHmI2aNKZRYbLl9+Vat1f8TcCZmlITPWTUA1nUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=++UQ42/+mh10cd5bdbFo3XyNe3E6KwnEO9Zqkc0vqdY=;
	b=KIz14rhSlHmy5wfKXVgUIFiWSRfYseqYxX4iLS5vx6e5f0H6SWBfvPHvqSqBRueJmN1N
	 yRx9V68v7w5Waix2oZgWQs4Q97e+LK0vqkKm4MXQgPMRc96hSPCFYaXSgpv8PIkmNAPzT
	 ltlZLyeji57uVlXOlPNjaxJqwvmbomsYD6ueVm+GXZTdFK2Dt+Zt0tlD8BnpTjNwkMqlG
	 SOpaOIbuOdt8TAh1hYrhaYtpDcHAC1xgEiaaSRPRouSEqjUDEztNbA6Q69DOK6+d+KYtb
	 Kag+70nLbF0NjZqvdR/3XuiCbp4zzpeOlP7docE4YILrM+CRM4FM20qURBZKBf61TMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0zbSgV7p;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CB606A325
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 07:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C5CB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0zbSgV7p
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f04b676219so1086745ad.0
        for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 23:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795161309; x=1795766109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=++UQ42/+mh10cd5bdbFo3XyNe3E6KwnEO9Zqkc0vqdY=;
        b=0zbSgV7p7ghErPwoA2OC7teIzfPSmDyFihyy4ewsyjib8IPODA3paXtwldlzIjQpxn
         WIu6EKqefg2FxlgTbv+/zWUY+GaYLzJQPgZ3P3QpdhTAwLzN3FlECQBVwyd6LgTATSfZ
         7trxgDvcN16pJ6yLIa+MWaomamIvSNZ8A+B6nP+9QgUMSCaK++Weo37+HQIhSu49AFNg
         RXF4lIh7iBr1M40GG1BsCyt/WO3Mzw2V5BglAxxFBLqQ9Vc6ddAtoFFxp2gE8O1HgaVP
         yzLeJyh2d1WuuuIVSxnM1LbYP8MbcQXqwCsteJhZmYfWY91CMmuArPxp/yQRnINAirV5
         hyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795161309; x=1795766109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++UQ42/+mh10cd5bdbFo3XyNe3E6KwnEO9Zqkc0vqdY=;
        b=TawakHro3uV8vUSnPcpeQi51dJWlMO+7jbU+XJFrG9ZJk0OkGjtNV0EoEobH/DKePp
         HiDaDnY+UJlS2pRtRW2QugCXw/MQApuVBW93nZErwU+OKm+84QIrbDaU8Tz6gdX/IRML
         2MIAtVcUxIu3q4nU5cpuHesOmWdb0Xzeif7UApEkM3x0t3u4Er8od8cNDoS8Y3hdQYB0
         wwKPsC4J2TvA9md/VoFS0iJuK4DNdQdejnAlInCQq3jsbianP3TQkhlthZTLTa/V9CB7
         a+A2h49UFOV7bBGmQTA28SHnDltHAp4Z49MPUsKieh5gHh6bZeYuItOO9JSvT3Edn9ov
         S5Uw==
X-Forwarded-Encrypted: i=1; AL+hErGtterp67DYP+jF7Uxf/YRot8bD3lcVp/gr63bDA0f/2E/YU5ol/S1ThORorxFKZDj2Q5aJyg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/tTAtfRq62DfM9oAth70p9XZgBbwvvBlo0GbALL5V+8QoTDHk+
	gbSwbG6huDtw5ojXiASl4357nzAXk0PPzF12KllBceBm6wyMXqU0IZZL
X-Gm-Gg: AZFdTZegXY8cMW0xcIOt+LYnM9WF6dirOM2Id/crNan/3hkUoeO2/sqasfAiF2MgjK3
	RCozpChYrd5N66ehhinrZlAGzy6dLiqkXhV7i0KjngtvfgV18uRnCDETbKhrFgSbIW6DDWdh0AD
	QWekFYfjSejbh9ewqz8uDR3JzR9w4ULfR1G+UyMsOpwsGQAlM+XUesz7DnTj5R9aVrzDHo+Kv6Z
	Xpz0E+0zfoRehAN3lE8ybBU7ibEdhcWCP8LPbbGdKQN5KuqUAcFWsg6r41NaByKaARzqGnKyVVi
	cxwYWEy/rUWkwojZlcgzkYTLXb7MPqBx0w3hSXQ3UksKBXskbt2Gma1NWFfEHjkjkphTY3WfOFR
	+WHkmTBR7AmQsM1cE79mZqGcO+YBwJaQnkkqXs9kLDX6nfhidklbk/BZ+bxUthU+/AVuxtGjFDc
	cO75IoqdsXufnrjC7rOEK42GwTzAUQQoOOyQXu/kGzs+4lXrYJBpsxAzZNheP2NOHhyek17qLQT
	rezrnLQGKpsSQYzRQtBHLeQ4LvKw3k9hbQDLqqbNTB1RpeDcmKTTVJnLFIPjCTPepxkds6h1PfN
	l6qJeylqO/fhISstIfcexXYQy9LF5VM4ZgSfP7p/52qg85M=
X-Received: by 2002:a17:903:2b0f:b0:2ef:d9b8:463 with SMTP id d9443c01a7336-2f03f186250mr24454025ad.35.1795161309252;
        Thu, 19 Nov 2026 23:55:09 -0800 (PST)
Received: from revrse.tailec2828.ts.net ([166.111.83.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2f03ee84871sm11010785ad.8.2026.11.19.23.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:55:08 -0800 (PST)
From: Lin Lei <llleigoing@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org
Subject: [PATCH net v2] mptcp: exclude MSG_PEEK from receive buffer autotuning
Date: Fri, 20 Nov 2026 07:54:59 +0000
Message-ID: <20261120075459.2862977-1-llleigoing@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__mptcp_recvmsg_mskq() passes bytes copied by MSG_PEEK to
mptcp_rcv_space_adjust(), although those bytes remain in the receive
queue. Repeated peeks count the same data as new application
consumption and can inflate the receive-memory budget. Subtracting the
unread queue at a measurement boundary cannot undo that repeated count.

The receive path originally skipped this adjustment for MSG_PEEK.
Commit 581302298524 ("mptcp: error out earlier on disconnect") moved
the adjustment calls without preserving that check.

Only adjust receive space for non-peeking reads. Keep the returned
byte count unchanged.

A loopback test leaves a fixed 32 KiB queue unread and peeks 4096 times.
Before this change, sk_rcvbuf grows to the configured 8 MiB limit.
Afterwards, both the budget and the queue remain unchanged, and a
subsequent consuming read returns the original data intact.

Fixes: 581302298524 ("mptcp: error out earlier on disconnect")
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Lin Lei <llleigoing@gmail.com>
---
Changes in v2:
- Send this fix separately from the other patches.
- Update the author and sign-off and add the Reviewed-by tags.

v1: https://lore.kernel.org/all/20261117052200.1507847-4-llleigoing@outlook.com/

 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b375da1f17fed..ca0ebcf11e02c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2216,7 +2216,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			break;
 	}
 
-	mptcp_rcv_space_adjust(msk, copied);
+	if (!(flags & MSG_PEEK))
+		mptcp_rcv_space_adjust(msk, copied);
 	return copied;
 }
 

base-commit: 4d67cf2fd2352f130c42494a933ba9158b925c65
-- 
2.43.0

