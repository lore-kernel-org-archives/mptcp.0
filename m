Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A83C3F54
	for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362416; cv=none; b=sHbBWQd92dfkGOhe1fdlUOBUSbEwKEUrdDQMOjcZeLqGv+Lf0k7d8R/Ts0MI3R4heDSRfPoDMMKxJZEAogUaTRhZoDuExWZipbI9ZwvbC9oGUjwZ0Ws6tjEjHKfMOIMoB4KxFj0rYRVSN2/QZLoBPeiuxu28RXlJUop2nPefrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362416; c=relaxed/simple;
	bh=FqSKut/NeF+jbTcveYFebP/x9+OUciEE4qfDOf5tz1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgJuJUvdXCBTWRvxUUYYkFmcSSZ+Ho1s32l5Of+jGWsBPstjOoV9chWLGukVPkl+lvqBNP8It0CsJgQvGsPp8J/c32ffErjbq44zrhoPpMgGXJb33lcu+Nq671lqh29/nxciHDH11nTpZUQ7vXW/coF5tJRNG97jUaSxUYZP7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er74j11m; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er74j11m"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb662575d3so852479a12.0
        for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786362414; x=1786967214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5csJ5l5RsA5RzZR3PB83eVZukyO/ayF8j669uOpiolA=;
        b=er74j11mIxiNkEovEtN4NMQv6H9EvDsiDbJNAGsiQV9mNLp0UrpU+f81GcpXlAveZB
         g2ou8YYwuTQEdi/tQYazvARa+xQ6mZ6eE9b7BvUhGtM8cOrX7kw1pn24y+xpaIiwg6B/
         gO9UAM9KzFX5TCC3y1+Bowu8uwquGTMn5WL+IzExJsMrKd+pAmi+Fqkztik+TL87PLTd
         9GvRwueU0R/YJB2SkDEtaH8E3IVDxJIKEcmnbPw5SJT2f6U4Btqa+jD62Y8dyOsSj5At
         VWbwM8aMSgsLF3VUbFdGMS1YIZRIubYzJYZlwzfs+H/C5AWjn/Ko2mtP00eSq7alJMNI
         6uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786362414; x=1786967214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5csJ5l5RsA5RzZR3PB83eVZukyO/ayF8j669uOpiolA=;
        b=mDR0+8qBMKOzOeWYtW5AEkvbnGJPe0UVUWucKoGs1ivQVonf9QZTkvTU7RI+ws7Oq6
         sinoDojgaCKz6yK+a7i0jMP+Ru12HCMgmND6Y3PvaR8UisvwPugWwwJ/1Tn5re6fQvH0
         hYrbBmoAm/oyvy2mwSKj6KKxVbGF9KSxDawtohfy+YiwQJGB6SJGkCgj5g2ozyaDMJ/L
         5mcKp+iMIkGWHUZzz6iIZnPlO2RyQ4w1gnVl3Hh37HR0AM5vWhbMppU0pG4JvRzT9LLO
         xgcsO40Mm9OtJr4ky/XcGapryigln9aX7jWhmof+Y5q//CMHQoF+Rru9ufxozrx2CnUu
         sSSg==
X-Forwarded-Encrypted: i=1; AHgh+Rq//aeogGH1s8Cs5wNaOXsFI4oDooyJOAQJejkGer3l3JIniLLPWzEgQj5wjyrNtZgK3spQEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0JBcburBjkZyg74mI4CttYfP4u8vIiRuKu/5WyX+3jb59jSG3
	VGpwA2FyRsSEfVSWSXIF+PBLNs1zOVty06cUdCWzbPCIxn6J43MZFhLp
X-Gm-Gg: AR+sD11HGSoQwJoHfaNrTD77fLEzugMfmWHfbxXhe9OwK5epsnLm8TWphr1h7N5SrJ3
	vc1QWkJmwCvAdXvyg6kEWvjyXGpImgJmtKTSyn6+nMBqLKWN/OdU+JaV5zZEL4XGa9yinU+3Z0P
	09QE/qUIvxqAvSdK+k0vJ3tyTsNmCvxUaiJR0P0GCe8+kWlRKcfpNXiHtspliALeqHDu/EvrrDJ
	1ioKV3sB207BsV1sw5NO8Mwd6dw5tIxmwqL6Y9SSYA5ZUOMGY6yBhYoDmMJQlUX0DYy9nw0DTgP
	V4Ml1tWSCtYBAAREh9KWRz50APr2QNT9Mj5/XAOlBXMPt82jDTMp9gLHSKytiGG75DZbUf/hKtA
	izxCDmlZv/CzdxVDWuGgGcpliC/CeyaSOJ5O74EP8HGx5NqtGzdnciMud3U41/aoN3x4c8Tp9iC
	cAmJev6CYX140i6hPEsSUyb2C+q8SqA+wSbhnlxoW3pa4r0AL98pKo+AeHGmFpL4JeOcAkouW4z
	7YmGA==
X-Received: by 2002:a05:6a21:3117:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3cbadc97c22mr37147925637.28.1786362413580;
        Mon, 10 Aug 2026 04:46:53 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f38b7d9sm3793305a12.32.2026.08.10.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:46:53 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	mptcp@lists.linux.dev
Cc: Fourie Zhang <fouriezhang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] mptcp: reject a DSS option that follows an incompatible suboption
Date: Mon, 10 Aug 2026 19:46:10 +0800
Message-ID: <20260810114616.2709245-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All file:line references below are against v7.2-rc4 (ac5b0e5651b1). The
KMSAN trace was captured on 7.2.0-rc6-kmsan72rc6 (075b74841bd0), where the
same lines apply.

mptcp_parse_option() writes the DSS status flags before it validates the
option length. For MPTCPOPT_DSS it assigns dsn64, use_map, ack64 and
use_ack at net/mptcp/options.c:160-163, computes expected_opsize at
:165-180, and only then rejects a bad length with a plain break at
:190-192. That break leaves use_map set.

OPTION_MPTCP_DSS is a separate, sticky bit set at :194, and the mapping
fields data_seq, subflow_seq and data_len are written only inside the
use_map branch at :207-220, i.e. after the length check.

mptcp_get_options() clears only the four-byte status group
("*(u32 *)&mp_opt->status = 0", :370). data_seq, subflow_seq and data_len
are declared ahead of struct_group(status, ...) in struct
mptcp_options_received (net/mptcp/protocol.h:145-177), so they are left
uninitialised, and the caller declares "struct mptcp_options_received
mp_opt;" on the stack (:1137).

So a single segment carrying two DSS options -- first a well-formed
ACK32-only DSS, which sets OPTION_MPTCP_DSS but no mapping, then a
truncated DSS whose flags claim a mapping, which sets use_map and then
fails the length check -- ends parsing with OPTION_MPTCP_DSS set and
use_map == 1 while the mapping fields were never written.
mptcp_incoming_options() passes the OPTION_MPTCP_DSS test at :1210 and
copies them into the skb extension at :1253-1258; get_mapping_status()
then branches on the uninitialised data_len:

  BUG: KMSAN: uninit-value in mptcp_subflow_data_available+0x2428/0x4c70
   get_mapping_status (net/mptcp/subflow.c:1152)
   subflow_check_data_avail (net/mptcp/subflow.c:1369)
   mptcp_subflow_data_available (net/mptcp/subflow.c:1466)
   subflow_data_ready
   tcp_data_queue
   tcp_rcv_established
   tcp_v4_do_rcv

  Uninit was stored to memory at:
   mptcp_incoming_options (net/mptcp/options.c:1258)
   tcp_data_queue
   tcp_rcv_established
   tcp_v4_do_rcv

  Local variable mp_opt created at:
   mptcp_incoming_options (net/mptcp/options.c:1137)

  CPU: 0 UID: 1000 PID: 137 Comm: poc 7.2.0-rc6-kmsan72rc6 #1

Reject a DSS option when an incompatible suboption is already present. The
test runs before any DSS flag is read, so a malformed duplicate can no
longer mutate state retained from an earlier valid option. ADD_ADDR,
RM_ADDR, MP_PRIO and MP_FAIL stay permitted alongside DSS: once
mptcp_established_options_dss() has run, those are the only options
mptcp_established_options() can still add (:843-878).

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A KMSAN reproducer for this issue is available if requested.

 net/mptcp/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c664023d37ba..7ec18fa1bef6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -153,6 +153,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_DSS:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO |
+					    OPTION_MPTCP_FAIL)) != 0)
+			break;
+
 		pr_debug("DSS\n");
 		ptr++;
 
-- 
2.43.7

