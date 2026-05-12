Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DA3839A9
	for <mptcp@lists.linux.dev>; Tue, 12 May 2026 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582018; cv=none; b=fkX5gQ2xCW36jfBNFJlRzJVzlBjsonTnyp294/qJAJU8SUy+1YqQcYMcU1cr0RUaOCDzcU7VCm3pgwwavVN0OXnIbnigUzb9PR2IoEQrd1kTWeSCNYGiuic2BqT6R0Iw+gMMzzXoB6l5Urtm6SggA1xBeX56Z0eG6R2FRLchTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582018; c=relaxed/simple;
	bh=WdmqctYFViM5fA2xpBJeCWnZLDGxh536eXC4IsqG8ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCGFLFyWxAsqzq0e0OMtVNQQ9/rA7//coOXdue+DdtcoU54f+YHHsytcjdluQgwlcw6y/1dZbws0/RSLvUBaemcnjEmeVxdxo0XZmuapXrYFwswriLKsJtPJW0Y0oM4/Q5AsZO2zs2X/sEhRAG5K8PwW7xLs5s5GPe+OHq/378A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7B58RtE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7B58RtE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so33777525ad.3
        for <mptcp@lists.linux.dev>; Tue, 12 May 2026 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582016; x=1779186816; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMgf9zagQv/RoLAP3xHM+yAO6BER45h0YVhQWXppqko=;
        b=V7B58RtE0uq+Ntoe78BFe1pxvuvr1xK3ir4vBIxOhFRo71CgHTJuNSPzZNkRgUcRq/
         zlwvK8PyRscgUaGc3wPpyP2A3TICV4QCXJ25Dd7qRBa29XG24pNF/hIP1kRqERFNdEly
         8X4vIZpykeu+VBl95Ox9Riy2ZUovOrJmVkw3IFj1XYKdIxOmfRa3ChhyG0FohD4Y4twQ
         BnlE6kquh7vm06CiK/5bRIrGDM4NzgRIutsod4Ze9iNLMnh2iPT5wE620yTsGA0QZrdr
         iNmotQXxAG83NDbLLV6VlZYXjazEflkU9bc6BDWra6dRMek8QdohPdAknYmLueJw47pc
         +BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582016; x=1779186816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMgf9zagQv/RoLAP3xHM+yAO6BER45h0YVhQWXppqko=;
        b=Ge5yUAJuC87xOTdGPfB6GitD1D0OvntMgLXB7Ev6ceEtJOqpqOB2qWs6fY8TmSqWqu
         rolmClFmWMQowbKWHaUiuwzZv82PQqhaQAATAHZA9d4rq/RGcEjeoCPJEUqx5Di/BKhH
         OSIrD5u3PDnMz97b7fCE7d6pdS/9MTSKVCk5m2KlgbA2+CyyMvU/m5PivvrxzEohsDqp
         0k5KQWgCtYQuPSTTkW1Ir9ZP5sWTsKwq/HLSFyQBgvL+xpslSVOKtW2ruoqA0w/YZSfE
         mwFTXi/FSLiZ+3BbMCHZyQIUc1hw740InOZKXFzbIAajGhTQIX1C3aeUtjYEIZtkNUwp
         Xf+Q==
X-Gm-Message-State: AOJu0Yw7xah7QEK7ZlQ2Zyu7adGeJpeX0BcjDTIdaZ/qyNBzYIHFpnEw
	A9nsQqpQ+61ErBbEPfXnup2mO67QtpPUc7j6hmcGfgcb4h/7RbmP+wCCwepCro8e
X-Gm-Gg: Acq92OHatj1Ji0/Tnl4sfbhpspQ69KDHBvbqXVKLA8NXRjMuH1B/g953Lc3ov/BTK9V
	WhKM76AohKZ+ao6ujBasKBv3iggNMg95Q31UutibaLrM23L+OtAjAlXAvx1W4lmWR80mAGB1ops
	mRfwdPMf4laPV52d+KCZRBBI2cbNKVWiCB/JpacOq5lKXfgNIISCgfnT5m2wb/8x+g/I25P3Uj8
	rvgj9jpR640/JgUgyPYi4t9pju1yRSYXARv0k3zyPzpjLmG5b77U6sgr3X0lmUK5HWEZjZyBbhp
	tm4lgP2PMg3nIndq6k33DMh5Ab+DpC2d+T2GL68oUQbpIHweigdBDePCvLkwbXGjh4P8sIBZpIr
	dncuoludj+EtY2FAC2gOzhvM1qvHAm+kdoaMa+Sc5RQD/LpBmco38f5ULHNKxz+6c7u47DBKlQD
	7yNJg6DTkcdzCCM+t5NfFlaA==
X-Received: by 2002:a17:903:9ce:b0:2ba:b5a3:1864 with SMTP id d9443c01a7336-2bab5a3210bmr268073555ad.20.1778582015772;
        Tue, 12 May 2026 03:33:35 -0700 (PDT)
Received: from localhost ([223.185.43.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm127240585ad.44.2026.05.12.03.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:33:35 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v3 0/2] mptcp: per-event MIB counters for MPTCP_RST_EMPTCP
Date: Tue, 12 May 2026 16:03:29 +0530
Message-Id: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP_RST_EMPTCP (reset reason 1) is currently used as a catch-all for
several distinct conditions across subflow setup, authentication, and
data-path validation.  This series adds per-event MIB counters at each
of those use sites and extends mptcp_join.sh's chk_rst_nr() to validate
them.

Patch 1 adds six new counters (MD5SigReset, MPJoinSynAckNoMPJoin,
MPJoinAckNoMPJoin, MPJoinAckNoCtx, DssReset, MPJoinNotEstablished) and
increments them in mib.c/mib.h, subflow.c and protocol.c.

Patch 2 extends chk_rst_nr() with named env-var expectations for each
new counter (silent on success, gated on availability) and adds one
test inside signal_address_tests that triggers MPJoinSynAckNoMPJoin
from within the existing ns1/ns2 setup.

v3 (this version):
  patch 1: move new SNMP_MIB_ITEM entries and enum values next to
           their semantic neighbors instead of appending them in a
           single block after MPRst*.  No functional change.
  patch 2: drop the third-netns approach for triggering
           MPJoinSynAckNoMPJoin.  ns1 now signals an address that
           is already bound on ns2 (10.0.2.2) with a TCP-only
           mptcp_connect listener on ns2; the client's MP_JOIN
           routes locally to that listener and the SYN/ACK arrives
           without MP_JOIN.  The test moves into
           signal_address_tests.  speed=slow dropped (not needed
           here), and the local-and-assign that tripped shellcheck
           SC2155 is gone with the old test.
v2: https://lore.kernel.org/all/20260509183335.969018-1-shardul.b@mpiricsoftware.com/
v1: https://lore.kernel.org/all/20260421095646.3741956-1-shardul.b@mpiricsoftware.com/

Shardul Bankar (2):
  mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
  selftests: mptcp: extend chk_rst_nr to validate per-event RST counters

 net/mptcp/mib.c                               |  6 ++
 net/mptcp/mib.h                               |  6 ++
 net/mptcp/protocol.c                          |  1 +
 net/mptcp/subflow.c                           |  9 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++++++++++++
 5 files changed, 94 insertions(+)


base-commit: 52f68f13d42a1c3752de7a776b6f873988f48401
-- 
2.34.1

