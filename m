Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CE81724
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441173; cv=none; b=Yc+dP+VINhhKgonRRYbCe9LXCPwoFV5CLgLx8yAaNyTXUqqzI9+ZCfbcndXHImRG5wT6FaW7T9HBy1mogxJlNQuPqDfqRj7LZPVAbTXoYglXB+2fdIfvp42c1oc5vYaxEw/1O5ZKh00UVPsxUbDEEWs9lxk3XzzO7ea3EApNuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441173; c=relaxed/simple;
	bh=2/bBWZd22be/hHLvTQ/Sd5yhT9WHoNvvbJjx7ymCoSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cdFogG7ikRbgIIUf5/BB/CA2DWyC2n5HyogiNB4Dia67jsSigzUgeqYbpHxsy8+oLllmR7wx9/PnGlpq4vswKfIL1JoHZp1VxkrTdsFqEyPh4qzcIu7W+UctJX87yLHu+W1RL3cYr/YAwi/IQEcNI7jp2XRWUzbcfRxBSus8M4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NU1uGbzx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NU1uGbzx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779441169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L/LlwfEo28aHWojgfdX/jeB3RfUmb7+SrqpPJniODTE=;
	b=NU1uGbzxrxerdijVBPQkDSJHRwF9QF/lSKFxlsf6HpI58xTzCUpdEiVM+AVNreXr2vilyu
	Kie0Ko1T5qj3hG+hGY2cJBxh7iEIfkh2BNSmmgCV2lDJestaT2edX+DFpU3Xov8NPJWiid
	46wkw3kdpL0joN7bcKH/D0XTIUfEO9Y=
From: Gang Yan <gang.yan@linux.dev>
Subject: [PATCH mptcp-next v5 0/6] mptcp: convert to sockopt_lock_sock
Date: Fri, 22 May 2026 17:12:30 +0800
Message-Id: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4dEGoC/22NQQ7CIBBFr9LMWgwtFKwr72GMqUAtaQUChLRpe
 ncJKzWuJj//vzcbBOW1CnCuNvAq6aCtyaE9VCDG3jwV0jJnaHDDcIsZClZM1sX7nC8SlJ0Il0x
 2kkNGnFeDXoruCi8XhUNGLRFuuRt1iNav5VMiZfFfmgjCCLOHpDUXTDJymdZZGxuOwhRTop909
 0PTTBMykL4WVPIef9H7vr8B9kfP6vMAAAA=
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, pabeni@redhat.com
X-Migadu-Flow: FLOW_OUT

Hi Maintainers,

This patch series fixes locking issues in the sockopt path and adds
support for setting MPTCP sockopts in BPF context.

Patch 1 can avoid accidentally introducing sleeping operations inside
the lock_sock_fast() critical section like b5c52908d5("mptcp: fix
scheduling with atomic in timestamp sockopt") does.

Although patches 4 and 5 are marked DO-NOT-MERGE, I think they are
ready for upstream submission, reviews are welcome.

Thanks
Gang

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Changelog:
v5:
  - Split patch 1 into two patches, one is to replace lock_sock_fast
    with lock_sock to avoid 'sleeping in atomic context' issue in
    regular path, and another one is using 'sockopt_lock_sock' for
    mptcp socket like TCP does.
  - Patch 3 prevents the sleeping issue from requiring ssks' lock
    in BPF context, It will return -EOPNOTSUPP when application/BPF
    programs trip on this.
  - Patch 4 and 5 are temporary patches used to verify the validity
    of the above functions.
v4:
  - As sashiko said, when processing BPF setsockopt requests, the
    msk is already locked, but we need to use lock_sock() to
    protect ssk. If we use sockopt_lock_sock(ssk), it will return
    without acquiring the lock.
  - In 'mptcp_setsockopt_sol_tcp_congestion', the load of
    'tcp_set_congestion_control' is changed from 'true' to
    '!has_current_bpf_ctx()' like tcp does. This determines whether
    tcp_ca_find() or tcp_ca_find_autoload() is called. I agree we
    should keep consistent with the TCP implementation. 
  Link: https://patch.msgid.link/20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn

v3:
  - Remove the special symbols in v2.
  - Use sockopt_ns_capable to replace ns_capable.
  Link: https://lore.kernel.org/r/20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn

v2:
  Link: https://patchwork.kernel.org/project/mptcp/patch/20260422091927.77770-3-gang.yan@linux.dev/

---
Gang Yan (6):
      mptcp: replace lock_sock_fast with lock_sock in sockopt
      mptcp: use sockopt_lock/release_sock in sockopt
      mptcp: use sockopt_ns_capable in congestion control
      mptcp: reject sockopt requiring ssks' lock in BPF context
      DO-NOT-MERGE: mptcp: allow set some sockopt in BPF context
      DO-NOT-MERGE: selftest: bpf: set mptcp sockopt in BPF context

 net/core/filter.c                                  |   6 +
 net/mptcp/sockopt.c                                | 133 ++++++++++++---------
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |  64 ++++++++++
 .../testing/selftests/bpf/progs/mptcp_setsockopt.c |  71 +++++++++++
 4 files changed, 220 insertions(+), 54 deletions(-)
---
base-commit: aa15c271d79edde595fb6f4eedb52fbc16325a83
change-id: 20260506-sockopt_lock-c46837d6d9d7

Best regards,
-- 
Gang Yan <yangang@kylinos.cn>

