Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF023ED5B
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778309087; cv=none; b=feX1VsXK/aga0RAmXrDvbrWdqmj00vRFlOyFeVgeYOLFSyWbSOWI+n7ahfegm/wCrglzQ1a4RzL+kzt1Wg1oo05jnt8G6zhVdC8jvSVpgHxo2W5URTlkp/EvTt3fjtUplw0qmJuseV9w4EJeFWExvVBCfW4QcJlb/gpyc78lgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778309087; c=relaxed/simple;
	bh=f1IdNrF+AVoOoYG9eNkdaL4Yh/PVlBP2pf/GIlIdElU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MzhNuz67izZpLlndkjshomSYxPkZx+ZPZyUfYGR+FkCsy3Xk4h1zJcWkxi/1zAG3YttbkcH8QJPc+2lFTOENnbHmKdIhEeTLGe4wJ4RtkJdcppex/2hU0aEnHzUcx4fEXrfgb4JB7jCLhgaeHh9VZyQ53cAyck7dKCuawmdp90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q5Vupvnm; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q5Vupvnm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778309082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGTVRlQ+7gKI+p4sG81DqI/nDZFR126BfyeTW+HxU+I=;
	b=q5VupvnmQljO6OpVl0rZwGwBqIJJ9HRpFGg6n1r/9YNPrSCtHYjvAl5z0nyTUQiESoT0cg
	620M/9gl4y/V3i7Jcs/4SaJU+Lc06LYkDpWzzUtwK/KPiHALCBIYBWymJVr8CG7fwDpI9H
	if7ODFZRKRyDeNN8z33/yUplEYmgJSo=
From: Gang Yan <gang.yan@linux.dev>
Subject: [PATCH mptcp-net v4 0/2] mptcp: convert to sockopt_lock_sock
Date: Sat, 09 May 2026 14:44:21 +0800
Message-Id: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXX/mkC/22NTQ7CIBCFr9LMWgwWnKor72Eao4B20goECLFpu
 LuEtauXL+9vg2gCmQiXboNgMkVytoLcdaCmh30bRroy9LxHfuTIolOz8+m+VGVK4kkMGvVZD1A
 rPpgXfdvcDT4+Kc+sSTBWa6KYXFjbURYt8H8zC8YZx6eWh0GhRnGd14Wsi3tlYSyl/ACwLwcJt
 AAAAA==
X-Change-ID: 20260506-sockopt_lock-c46837d6d9d7
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

v3:
  - Remove the special symbols in v2.
  - Use sockopt_ns_capable to replace ns_capable.

v2:
  Link: https://patchwork.kernel.org/project/mptcp/patch/20260422091927.77770-3-gang.yan@linux.dev/

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn

---
Gang Yan (2):
      mptcp: use sockopt_lock(release)_sock in sockopt
      mptcp: use sockopt_ns_capable() in setsockopt congestion control

 net/mptcp/sockopt.c | 101 ++++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 51 deletions(-)
---
base-commit: aa15c271d79edde595fb6f4eedb52fbc16325a83
change-id: 20260506-sockopt_lock-c46837d6d9d7

Best regards,
--  
Gang Yan <yangang@kylinos.cn>

