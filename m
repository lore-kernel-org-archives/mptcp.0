Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F53ECBE8
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063665; cv=none; b=hgsswGqNsr6i6tS3yQs9YAji8Povg6SdIZ5XRcJeixsw47vux98YhvWp3tPG9CU2IEOfksm4B++itlx5If6m9q5OTGmEtqdVwx58Y3SNNCkE157lBt2yMFCFJkjW+psi1vuFpzS8oMkzW8PIM4MGV2TbVcm63XQa5HGeU1ptzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063665; c=relaxed/simple;
	bh=VfGH5jkceJ0FWPDjuYU+YNBPXiH61sxu9bUwgfW05Ic=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UUxfzb+EFpAFLz13I9yWxia/xREcYQDdFQ1Rbmk6HUFZ/G7XXZObsb+r3KywbL7+PhejPW1pLqrLk6Wf/kNR3/r7A1p4GF5M7OelsuSBRJIMvgwCKf1DBVOVgbeHbKbJvILdMvrVUf6eDPjOb9Ai6eP/fhoQUUF/g9PWEDQvtxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YWvXh1Qb; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YWvXh1Qb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778063661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p8h9Urj4eeEpGS5gKIpvgQGlbvLFhtas4fT9pScXojk=;
	b=YWvXh1Qb3tPtwY6njxFH9Bkx1Rz2r9k63lfdEya1wIW9E1sAV2BFUDCp1I+iFer7CHe2Aj
	TBvEEv19n0+ikcmLzC7WIzSZdqM9dI6dXcmZdowhNtYVkMNhm8fudDSXYW6/ZPrzbI3BKT
	YhzFfwL6nZFUITKMkcGE9ofA915zWYE=
From: Gang Yan <gang.yan@linux.dev>
Subject: [PATCH mptcp-net v3 0/2] mptcp: convert to sockopt_lock_sock
Date: Wed, 06 May 2026 18:33:53 +0800
Message-Id: <20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABEZ+2kC/x2MQQqAIBAAvxJ7ThArrb4SEaFbLZWKSgTR35NOw
 xxmHogYCCP0xQMBL4rkbJaqLEBvs12RkckOggvJGy5ZdHp3Pk1HJtO1bCtlpOmMgpz4gAvd/26
 A0yftmcUE4/t+FVcrnWkAAAA=
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

This small series makes the MPTCP sockopt codepaths consistent with
TCP and the core socket layer by using the BPF-aware
sockopt_lock_sock()/sockopt_release_sock() helpers introduced in
commit 24426654ed3a ("bpf: net: Avoid sk_setsockopt() taking sk lock
when called from bpf").

Patch 1 switches all lock_sock()/release_sock()/lock_sock_fast() calls
in MPTCP sockopt handlers to use the BPF-aware wrappers, avoiding the
risk of sleeping in atomic context when lock_sock_fast() is used.

Patch 2 switches ns_capable() to sockopt_ns_capable() in the
congestion control setsockopt path, properly handling the case where
BPF programs invoke setsockopt from softirq context.

Both patches are fixes that should have been part of the original
BPF sockopt series.

Changelog:
v3:
  - Remove the special symbols in v2.
  - Use sockopt_ns_capable to replace ns_capable.

v2:
  Link: https://patchwork.kernel.org/project/mptcp/patch/20260422091927.77770-3-gang.yan@linux.dev/

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Gang Yan (2):
      mptcp: use sockopt_lock(release)_sock in sockopt
      mptcp: use sockopt_ns_capable() in setsockopt congestion control

 net/mptcp/sockopt.c | 123 ++++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 62 deletions(-)
---
base-commit: aa15c271d79edde595fb6f4eedb52fbc16325a83
change-id: 20260506-sockopt_lock-c46837d6d9d7

Best regards,
-- 
Gang Yan <yangang@kylinos.cn>

