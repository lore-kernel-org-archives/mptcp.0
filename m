Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191533DA5DA
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874916; cv=none; b=q8NDb5U+1pIgAONB2mmMX7ea8Gq+VxptGiW2e6B5fe1HR1Ydv95mx/On+JIoLGxWp63x8jpmBa5oTlHV9kvV8wQTYDM/EkfVrlQ+uSX8rEXo76BvuiEUDJJVWstTJFAQCx5FmtIS0N3Ii2ry5GtzMeu+u4nHa0GTPU36nVmDTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874916; c=relaxed/simple;
	bh=h27YVKK/TYuusXE6taFKqIAn5VyxSn/kotJtG8PpEoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpZBk9eICs9fhqSkOPfB5Vzfl7ua2wJXspusGsASfoAMEqgMmXQce4m+7iL5DVUXh46czd/JN3sZOGSR7A2vmgbj/JK6ltqnbnLCj3WwO9to3JCtSeoOeP2A5MjT/7yoH1MfanKTFG5wg5X4Hi+2V07tdR4ya1VAxOiHFygFyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSS//GVK; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSS//GVK"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66e4027b6cfso278436d50.3
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 16:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874913; x=1788479713; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCfWHkIpmLvJEZNt0kO4ZWyCArHHxMdSOeCJ5Kkvn7k=;
        b=KSS//GVK5ZRYfHmkZ9PYrokjWh6W5N9/lC/HV55xzdB4x5Tg4a6EO0HUsBuubwYRid
         u4vl/z586OEekhbPPzVcmscSaE/XgFDjalqAohPTs7csIpwNmjCUtCocAPJ0DcRIdGwP
         Xh7EYOga0mRYx2sMicabIphAWUrqVGZQCBCw7+4n8ashYMaV7InMddC9MFwEZ8HR7CR/
         Du0amqhzTH/jSEEUhCBAFOBWup5WLaaEy/ZTZWFb19eU6quR63+na1MmKQ1vFSvreScN
         AED5QbEetqG/mxXoqW1p/TpEfLdXcBxTPCKm4IuJMrAukc2grMtOzzwwzfmUPVFV5m/M
         LYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874913; x=1788479713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCfWHkIpmLvJEZNt0kO4ZWyCArHHxMdSOeCJ5Kkvn7k=;
        b=TnHVaxsEV8jA+I12CWIjwEN4JJeioscBLdC0Kj6jycN+a9sZ/ZWeXSJsWTxMalyQt1
         GmymjRGo902tb3CrhG44qmSIWVpPLTKxDIdUBoAqnhZD/4/fl+EdI0nxZU+dt6F1pGQx
         OfXqE2mMsrwV4v10y5MgLl6o9wxiW3sHPveVBWbvHdvPw2Mcbcj6/2fDKCyOveixIt+6
         nUidaSkBC6W6SLsZMrNcwd1xRRTLKpmbJ/r8REhueQzMSdWP3og/yw4TtZWUYf5MZXAn
         EYt+5exd1BQA37numc5OtLbXNuJKWjCQkwT9fDIdgLaMbNhafKZviIg1r40mhhTepw88
         RxQA==
X-Forwarded-Encrypted: i=1; AHgh+RoEbPYpppl+ovrSJ2cOC3/JZal4s3OEoBw/eiDif5WpjErd2g33l8It20cZheh+RkUAIIYwsA==@lists.linux.dev
X-Gm-Message-State: AFuF++kPWOAvAIqI1UCDurjoEoBpnWneFnANCXoLE3iRcpxTGbW0rdTy
	EPFn35z5UVzOMxqvUeVeCk4RNtoDBNih8W580wrPSxdhbytOrJuObTUU
X-Gm-Gg: AR+sD13FEX58RKq28AuZ2D7dI3ZaK6Em9MMPXri+hL7T1b+bBWIR4//lFDPy9Re/2xp
	KpwwAn+aMhU79tMj4uH3Mk4uk3O/3yhhTqPzjnbuD+it8OC61iEJiA/oFS48vYJW+adFR5ea8zZ
	VK3gS/NCiRYA7szF0cmSzxbg13SlnDc0sboMN7BOJRfuTGlqq8DyhoES3INqvEREOHcouYFzXd0
	gLAJ/OeylpnDntITJeHo7T0JhbFt516mNVua/kF4UP+/DddTWFCo2o6+Q3c+nzVmsM7aZdjehzP
	5GFi+9Cn05Z/ykyu++kzXqoZl0NRVaHvTebE0ze54Xd+JiC/Gq/Qbhq0RdFnbLMjeCFVUZEhCkN
	3SRd2nI9PNNWMlOZKKQNJcymXch0TcKup/Y5KsK9N0Zdd4iB6u45JtDm6dYtNvJlMzetxeg1Cxh
	HBG0zVDT8okYN6pGpdGep+wTre4IaHWUYD1oJwxoQlJqoa0nKJVetb0zl7iaBeXLKDI5M=
X-Received: by 2002:a05:690e:428b:10b0:66c:d353:948a with SMTP id 956f58d0204a3-66e4c7645d8mr742101d50.39.1787874913018;
        Thu, 27 Aug 2026 16:55:13 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:12 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v3 0/2] tcp: fix use-after-free in do_tcp_getsockopt()
Date: Thu, 27 Aug 2026 19:55:09 -0400
Message-ID: <cover.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() has two lockless reads of icsk_ca_ops. Since BPF
struct_ops congestion control made icsk_ca_ops point to dynamically
allocated memory, a concurrent setsockopt(TCP_CONGESTION) can replace
the pointer and free the old object while either reader is using it.

Patch 1 fixes the TCP_CONGESTION path by copying ca_ops->name to a
stack buffer while holding rcu_read_lock(). It also uses READ_ONCE()
for the lockless load and annotates the relevant icsk_ca_ops stores
with WRITE_ONCE().

Patch 2 fixes the TCP_CC_INFO path by keeping the READ_ONCE() load,
ca_ops->get_info lookup, and call inside an RCU read-side critical
section.

Changes since v2 [1]:
- Fix the TCP_CONGESTION build failure by loading icsk_ca_ops inline.
- Drop the unrelated WRITE_ONCE() conversion in mptcp_ca_reset().
- Add READ_ONCE() to dctcp_get_info()'s icsk_ca_ops comparison.

Changes in v2 [2]:
- Add READ_ONCE() to both lockless icsk_ca_ops loads.
- Add WRITE_ONCE() to all six explicit icsk_ca_ops stores.
- Include the data-race annotations in the UAF series as requested
  by Eric Dumazet [3].

[1] https://lore.kernel.org/all/20260826171344.4133-1-blbllhy@gmail.com/
[2] https://lore.kernel.org/all/20260821182449.79785-1-blbllhy@gmail.com/
[3] https://lore.kernel.org/all/CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com/

Cen Zhang (Microsoft Security FORGE Labs) (2):
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

 net/ipv4/tcp.c           | 18 ++++++++++++++----
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  4 ++--
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 5 files changed, 20 insertions(+), 10 deletions(-)


base-commit: a3dee9bb902ee4357fa02e49b415d7724ee0140a
-- 
2.43.0
