Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA84545DB2
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988436; cv=none; b=ZvAvllTZk6hH7l9aUK8T3VAUWFBKkOD/hQXM/pUKJoXvV9inZzJp7FJQr7NP9+AkjXEBGxU5d7lEgIWJ9ICwTZ/KVKDgprZW6Ll9YpiV2nY25wRBl/YN+jnSLIRLHS9amea+Xk0uyb4TK37LClUCzG1OA2fWrEQglQa40IqkNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988436; c=relaxed/simple;
	bh=Cp/sjpGrgi/Po5aGPpuq3uz48gQ+2Gqj/aXUp+uF6HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tf6D3uqR1IXaCjBdhu59IHK/P3TzL2PDJK3jgOOp4yp1W2U1bYba7nZVBY4g2mUQsRylkFYWpp/WYycndBp/IepZ2wf+B9948UHTXvf3RZZhe4yr1wfgJPO71Lh6mPyGm0UHfWyB4/Sxz3hfKgtkTLkq/Gkusvkl+SbCDcVwwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYNr7ilr; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYNr7ilr"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35943f55c06so944866eec.0
        for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988434; x=1792593234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXarZL15yK+bnxfJ8c2bYENt4tIIhVKPSsu0eyAjAm4=;
        b=OYNr7ilr/4dclFvipeunG6YI5eJSB6Lx2LEYlvJZNPjZYNL2/NKObqLD+Qry3tSBYO
         B4JtjSspKbpiDvXwxWh9zuP2CmDhTkbbSuomwWuMhpg3aQgszBLIMCxhmOXMz6kpiMY8
         Oz/t8Nj+QUMAVfxnltRviEz3hAOPOo92typCobO8sjOFbkYNlFQDk/J+s0zu24iyfUxb
         PnAbtpaw3qmq6zJAu39HMMclNhgN9aeXFuxDjmohUb5MX47m6ks19/HgpZVX2pWdcg4H
         0unrbqsSt2nd5Zs7jraTURcVh634XxQiltf+eDgFCZSKE2ZR5m3laf5kZ/LjHQQ0pxzC
         MUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988434; x=1792593234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXarZL15yK+bnxfJ8c2bYENt4tIIhVKPSsu0eyAjAm4=;
        b=WQ+rIL6Iim2fdZEV2WZJBVxavkCeAP7lDmLirydndaKG3B25PFD17T/LbGga0XBj85
         0jXrblmUx1mYHWtxZa4D9Q72rmygKCcc1mnbjEfql0uRUW/QD8mlporl5Wqu+IzAC0jv
         Kcqt8WLAT9H9Q5EbGcCRPL23IUZpqEBFAUzBqJbRtaoV36UViOrgQBnG7NyzpAVqWsQv
         9kN24u5EabCNPVLY4GYmQmXz6E3AWDqYg9i+CJjiZpHQL1m/WtUonZ04E37hUAPI4TX/
         B9t7fn5ZsiU7N1P5tdxrOnomHb2w0rXRsDfO68rLl9EnMYjOJCR81kTKBv9g8hC3SH/x
         4uqg==
X-Gm-Message-State: AFq9FYLcXoehjjX0PYW57jwZFMJLBI9yWGL5qVmvsAHA/GjCknC6qwIY
	/JvL0DD0KNuEEROt4XHDva+Oy1zn00kMk92rcO1HCqzSTQCHvzWWj+mpAG6VUg==
X-Gm-Gg: AYBFou3UNe5LlzvDvppcKOnhCn2SmfDrIRtlJKfCv+mFerLeMYD1NACMySsaoneXD9B
	mXxN6wSs5iadK1QuB7sFNG8KParxBMmOn7Tw91LN5Xv6oizWEPejn9wvwGEYVgYvDdZy50iFsZ1
	gp3lQhlzRTjifJB0zwb7ay+/aS1YTEpm106tAIyiJ6MkXAFdSLURYJGSfs4syyGljTbB9FEi7uo
	e3vTgkb63kaortEAXP2mic/7uQnbgK6CR7wgPODCtWFCSkHDchBskU8LTb1auxqP1S5SYytaXaD
	l/tQrA/wo2S31Z/P0QTwLNr39wbAcKVH5doDK1G1NvDviSOex7XhqUORFQxUcetlHnh4BY2VyoJ
	cHuMpbAzj73ehko1Op9WnS6xyMwZPfT6gm7/doTYAL5XOsfNxU89LiiTQ+xDYlF2yQGyf+2xVH/
	K4t8yg3wzzAxBU0IeKDOGKylUvWMwy/XBsEccwiX2Xo1BeA01bhFq31wFzQkq71ntB+sGCCdR81
	CilrpNdTJCH6LRHqSVsyu7dwuwTcL6zq/1S9E5V9lYAgOaNx5dW0XR6NBRe9Q3MTWM0RYvMg8C1
	kyoBLlgvuV+DtntZvoRIHsXSiAJrEYq2nZ/TRwXtdc0=
X-Received: by 2002:a05:7301:180e:b0:359:3991:ce1a with SMTP id 5a478bee46e88-3593991d263mr13742844eec.16.1791988433353;
        Wed, 14 Oct 2026 07:33:53 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm54997609eec.2.2026.10.14.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:33:52 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next v3 0/3] mptcp: pm: kernel: retry subflows closed after an error
Date: Wed, 14 Oct 2026 14:33:46 +0000
Message-Id: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subflow closed after an error is never re-created, even once the path
is back (#440).

When TCP closes a subflow we created because of an error, the PM opens
a new one to the same addresses, and if it fails, the same socket is
used for the next try. A new sysctl, net.mptcp.subflow_retries, sets the
max tries.

Open question: an ICMP unreachable aborts the SYN right away, so the
tries can be used up in a few RTTs. Adding a delay would need a timer
again. Is that acceptable, or is there a better way?

Changes in v3 (Sashiko and CI reviews):
 - no retry after MP_RST without the T flag, local abort or EBADMSG
 - no retry on a removed endpoint or address
 - count the tries from scratch only after a minute of uptime
 - use only request_bkup for the backup flag
 - reused socket: SUB_CLOSED event, MIB counter and BPF pre_connect
 - lock_sock_nested() when reconnecting
 - patch 1: don't wait forever on EAGAIN
 - patch 3: check the subflow address, create the files before the
   background job, bigger file for slow debug kernels
 - wrap lines over 80 columns

Changes in v2:
 - use the subflow sockets, no list or timer
 - sysctl is now the max number of tries
 - code moved to pm_kernel.c
 - Fixes tag on patch 1
 - one selftest with netfilter
 - Assisted-by on all patches

v2: https://lore.kernel.org/mptcp/20261013025653.523755-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (3):
  selftests: mptcp: connect: retry write() on EAGAIN
  mptcp: pm: kernel: retry subflows closed after an error
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/networking/mptcp-sysctl.rst     |  18 +++
 net/mptcp/ctrl.c                              |  13 ++
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/pm.c                                |   8 +
 net/mptcp/pm_kernel.c                         | 145 ++++++++++++++++++
 net/mptcp/protocol.c                          |   9 ++
 net/mptcp/protocol.h                          |  24 +++
 net/mptcp/subflow.c                           |  63 ++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  16 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 106 +++++++++++++
 11 files changed, 404 insertions(+)

-- 
2.25.1

