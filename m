Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308481;
	b=J0iJaLhCnjf5Dy93tGm9ZTrWuZX7duwDvLHdz5fqgkE1ScCJTs7IitdyBOl7d+YHe6WB
	 hMzPzi3Y3mMGa7kd5pHcDC75kLi38gx47Gvi9yU2okUkB/gAu4x+lcMgpmHHVf1zYnwL4
	 MlruyK61M2OUrLEL7WKRbX3mg3y+CV3wiDViMJH+9TQyzZmNFDJqlEAhTnOKQBLl/Jx9a
	 UApFf1VWY+If35RN9Zb8XngniNW//cpDdNDTRmGIHy5xlZFcceEpJwL0L4t3mAgzJ261C
	 a1PacFC3Shr8sW2ZPylipzOZ4bdGiKoyH1PTLi0uXigdlLwwAcPMat8FnkezOu3mSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HF5VRbzVxDMOL5K8HBJA0/UewfgfyDXbK1YBCmAF4so=;
	b=wyX8BSBoRJFtilFvQeSY0Zp/uCGmRHiQMs7azr3aDbBO/64G2mhkcpXcm+5V9i28k89U
	 bFdhJ/JyvEEfk6LVNJO0pkT3pQArzSEbCCZpHAIf3fZBndGYsd8ghs/rr5u9VcY3ZWL+7
	 gwzYxRpnvXAgq8GaJM7V2j4/M9mbwzC0vt2/BArnS9Y1XZz2uusWvmujWekrApY7FwUa2
	 Iq7B+FFuScL3/ZKPdesGVtsW5aiZwb9BEF3Gy03Q6oGOYZsD7mlauuYIzX3EIsmVrrHpR
	 uPJo2CGKQAhRB5bCtJrwZU/sdE0TQQA8T8ggWYJ1cavSGckxfroIExQDqeLhwBwfOIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RooObO6m;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B971606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B971606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RooObO6m
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3869f03af6aso903430eec.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308480; x=1795913280; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HF5VRbzVxDMOL5K8HBJA0/UewfgfyDXbK1YBCmAF4so=;
        b=RooObO6mH3KBuAeuseur2PnZ7uf0AbtapPuG1+MshDMd4o9WOiriTBpymtXoQuNax8
         D7PU2Q3qyCBaeFbwmlKCmZwImAs3XjFwjIqUoih/93lrpwuqfwsvM1FZ0ei1qrmnr7as
         rBJEpt2Yv0LdliO2pWAlPC8Rv7pm6J7d7tYHNtIyeWeuUZy0iVRenRmOGxX78lupFNw4
         Rh39nS2tn2W8vXG/NB5V2T2UjMwFAxFU+d3jp55wFHryMbYzbZYkYpUWTw1oaoNEsvZw
         NQ70R8ua9bGh0mTU5RvzNbxydk0ejEq7kgatobw35HtrQo82ju35UJY9+2oXLTBg1qfJ
         hymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308480; x=1795913280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HF5VRbzVxDMOL5K8HBJA0/UewfgfyDXbK1YBCmAF4so=;
        b=Vlogg4KSZw7lrSeTqMn8vwmZUdWQ6BqhwCRPzA5SmV/n755LlW4KiemGjUbKUbfmZr
         9JpT8ImPpoBGN6j2zjqGPXASr2hgcV1MZI5tMVRPOkjJRLT2G6Y7LpNQByiNyk/E64UA
         MUbOYQC/wEotkfUqKdwyNeNUdFJjZf0g15R9J2ueKehzk13nUZP031WacCuwqmiO8gEj
         mFFXMmgEoap/80313u0Vb8OgeXAjYvCl4mmMCqpdwbqOrFs47vbUpPpyvQKPN3ZKgD7R
         MsmvAVs97ogbubFORtgKdimk4DLOLcS9/VI0OB32WoEI2oDxGfrR4hw7Eomu6YjJvdm3
         ERmw==
X-Gm-Message-State: APuU4Z/TzzTQab4B9w+YkBZ2Lbb0zKK6H7gUaXGWK/tQWxxB85Wa4Job
	isOAAlCIF1cL/R3kZqaJZeA0CFk6ueYZ2W++NKRLnDzFqYjjecS5mNJe6j6xoA==
X-Gm-Gg: AZFdTZeI9EkAw0g1ijFzLCSeu4RtgWuSOQK5lAyq6U5rqiHyzz313AE0me8WXBMCiUh
	JX/t9W3RhecP6czpiWNK9pYUCunj8x4RLyd/SYTqw55PMghq5P634HeLOzsRZt4phNuqm0WZe7I
	XQVeTM4vb7o0f+DhiK8Aetmf0NP488043JGmVCryT9NOnT7u/xR5vehAli76fezbYbnPuuIteSD
	W5uHc4qr13fOa13W4pmTy+ZUuttNbmviQVoBY5mdQivJ4oXMaStx267yf8rYF4LASjzVbFCiNop
	CMjkeTfnTttIQhMeXmDZ1qBTLQUTqyGjsRL8CgvK/B//lK8kdEa0PKfameNA0QDrd2CjVTeqtm5
	X3cey6IvbqJX4YsqA3GTkQNOhFxuVJVDEhLsYgDG8TCoNS4xPCOrlloeD6Pg/H2+Mm2TCoG3dTC
	BhkjsCAhnuZED6rrDBPqsaCme/NzfyA3ke+9mrHxoGuEnYOs82L0WaZSuibRzQqCm2hW+qwoYRc
	7fzdTq4qYQjtLbT6htueHDniooWzMj2dbVS6AIANnb6W94I7x5tdhQ3cWdBuo0CKbofL9yfGUdH
	fns0T/vBmPQBdRhNCkwxq7Y/ENxXX2KeYMLuBbZFOaTcPIALfBe4/XHDUekdhFeOQ+T9KpkvUX1
	Secg80VlTj/zgkQjRF971ugqHySFp7v/zLg8i0L+LTqFwXOTHPcrAsbHdLu/+pYc/pjnyBJpPcw
	==
X-Received: by 2002:a05:7300:7b26:b0:36c:dd3b:a3e4 with SMTP id 5a478bee46e88-3856f25f8f2mr8754011eec.3.1795308479190;
        Sat, 21 Nov 2026 16:47:59 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:47:58 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 0/7] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Sun, 22 Nov 2026 00:47:47 +0000
Message-Id: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

A subflow closed after an error is never re-created, even once the path
is back (#440).

When TCP gives up on an established subflow we created, after a
retransmission or keepalive timeout, the in-kernel PM now creates a new
one to the same addresses, while another subflow can still send data.
Its SYN retries space out the attempts. Their number is set by a new
limit, subflow-retries, like TCP_SYNCNT: the maximum, 127, by default,
about 4 hours, and 0 disables it.

Patch 1 fixes a selftest tool issue seen with the new test. Patch 2
checks the existing limits with the netlink policy. Patches 3 and 4 add
the new limit, patch 5 the retry, patches 6 and 7 the selftests.

I used an LLM to help write and review the code, the tests and the
commit messages of this series. I checked and tested every change
myself.

Limit: as documented, the new subflow is a single connection attempt, so
an ICMP error received during the outage ends it at its first SYN. The
retry then mostly helps when the path drops the packets silently. Such
errors could be handled as soft ones for these SYNs later, if useful.
The peer must also have room for the new subflow: if it only receives
data, it can still count the old one, and with its subflows limit
reached, it rejects the new one, which is not retried.

Known issue: in about 1 run in 20, more often on debug kernels, the
first new test fails. Once the path is back, the re-created subflow
joins, but the server resets it right away with an MP_RST, after
DSSNotMatching, and the PAWS counters are high on both sides. It looks
like an existing issue on the receive path, triggered by the two-way
transfer with losses rather than by the retry itself, but I have not
found the cause yet: it does not show up with tcpdump or tracepoints
running. I did not see it in the 9 runs of the new tests on v16, but
that is too few to say it is gone. Any hint is welcome.

Changes in v16: in patch 6, "pm_netlink.sh -i" also checks the
subflow-retries limit when ip supports it, with the iproute2 patches
[1], and then expects it in the "ip mptcp limits" output, so it no
longer fails with them; with an older ip or kernel, these checks are
skipped as before. The shared mptcp_lib_pm_nl_set_limits() helper now
takes the new limit as an optional value, instead of a helper only in
pm_netlink.sh. And the patches are rebased on the current export branch.

[1] https://lore.kernel.org/mptcp/20261120155749.2126268-1-anilkaushikwireless@gmail.com/

Changes in v15: new patch 2, so all the limits are checked with the
netlink policy, as Matthieu asked on v7, which I had missed; and the
first two new tests only lower tcp_retries2 while a path is blocked,
and the first one restores it on errors (netdev Sashiko); no export for
the new getter; and the doc says a peer that only receives data can
reject the new subflow.

Changes in v14, after the netdev Sashiko review of v13: the slot of a
closed additional subflow is kept for the new one, so a join from the
peer cannot take it in between; the join counters are checked before the
transfer is killed, since that can send MP_RST, counted with -C; if the
new subflow cannot be created, the PM tries the next endpoints, with a
new test; and the commit message and mptcp.rst wording is fixed. The
netlink spec patch still only adds the attribute, which the next patch
uses, as asked on v4.

Changes in v13, after the sashiko.dev and netdev Sashiko reviews of v12:
all the re-created subflows not fully established are closed again when
no other subflow can send data, not only the ones still connecting,
since one waiting for the 4th ACK could keep the connection open
forever; to fix the race reported on v11 instead, __mptcp_close_ssk()
checks fully_established again under the ssk lock, and keeps a subflow
that got fully established in between, so the change cleaning the msk
backlog without MPTCP_CF_PUSH is gone; the commit message and the doc
say that a re-created subflow keeps its place in the subflows limit, so
an endpoint not used yet is only tried if the limit allows one more
subflow; and the tests wait for the netlink events before stopping the
listener, plus small test and wording fixes. If trying an endpoint not
used yet first is preferred, I can change it.

Changes in v12, after the netdev Sashiko review of v11: when no other
subflow can send data, only the re-created subflows still connecting are
closed, a joined one is fully established soon; a subflow in CLOSE_WAIT
no longer keeps them open either; the doc says the initial subflow is
not re-created if the peer does not accept joins to its initial address;
small test fixes; and the patches are rebased on the current export
branch.

Changes in v11, after the Sashiko review of v10: a subflow is only
re-created while another subflow can send data, so the close timeout
works as before, and all the code re-arming or stopping it is gone; the
re-created subflows not established yet are closed from the worker, or
when the MPTCP socket is shut down or closed, never while iterating on
the subflows; the path-back test is gone, and the third test checks the
only subflow is not re-created.

Changes in v10, after the Sashiko review of v9: when the close timeout
expires, the connection is kept if a re-created subflow connected in the
meantime, since an active join does not stop the timer; the re-created
subflows still connecting are closed once the msk is no longer
established and no other subflow is left; a new test lets the path come
back before the close timeout; and the patches are rebased on the
current export branch, without the Assisted-by tag, removed upstream.

Changes in v9, after the Sashiko reviews of v8 and more checks: every
timeout is retried, whatever ICMP error TCP reports for it, and only
resets, local aborts and MPTCP protocol errors are excluded; if no other
subflow can send data, the close timeout still applies, the new subflow
no longer keeps the connection open for all its SYN retries; the
re-created subflows closed with the msk have their data in the msk
backlog cleaned, since they can get established in between; the doc says
this is a single connection attempt, ended by an ICMP error, and that 0
disables it; the close test blocks both paths, and its server reads all
the data first; the tests read the counters before blocking a path; and
a new test checks the close timeout with only one subflow.

Changes in v8, after the Sashiko reviews of v7 and Matthieu's comments:
the default number of SYN retries is the maximum, 127; the re-created
subflows still connecting are closed before the write shutdown
disconnects them; the doc is more precise; and a separate test closes
the connection while a subflow is being re-created.

Changes in v7, after the netdev Sashiko reviews of v5 and v6, and
Abdul's tests: only a path error, a retransmission or keepalive
timeout, makes the PM re-create a subflow, not a reset, so a peer
cannot make it loop; the flags are bools under the msk socket lock;
mptcp.rst documents tcp_retries2 and the keepalive needed by a subflow
that only receives data; and small fixes in the tests.

Changes in v6, after the Sashiko reviews (netdev Sashiko on v4, which
also applied to v5, and sashiko.dev on v5): only subflows that were
established are re-created, so the PM still moves on to the next
endpoints as before; removed remote addresses and the local ID 0 are
handled too; the policy checks the maximum value, so the parse_limit()
patch is gone; and the test uses the net/lib.sh helpers. Details in
each patch.

v15: https://lore.kernel.org/mptcp/20261103085244.23064-1-anilkaushikwireless@gmail.com/
v14: https://lore.kernel.org/mptcp/20261101072051.3853492-1-anilkaushikwireless@gmail.com/
v13: https://lore.kernel.org/mptcp/20261030050727.3534304-1-anilkaushikwireless@gmail.com/
v12: https://lore.kernel.org/mptcp/20261028054143.3222998-1-anilkaushikwireless@gmail.com/
v11: https://lore.kernel.org/mptcp/20261026125345.3019372-1-anilkaushikwireless@gmail.com/
v10: https://lore.kernel.org/mptcp/20261026063657.2955783-1-anilkaushikwireless@gmail.com/
v9: https://lore.kernel.org/mptcp/20261025134909.2794368-1-anilkaushikwireless@gmail.com/
v8: https://lore.kernel.org/mptcp/20261022151130.2285198-1-anilkaushikwireless@gmail.com/
v7: https://lore.kernel.org/mptcp/20261020031711.1896660-1-anilkaushikwireless@gmail.com/
v6: https://lore.kernel.org/mptcp/20261018041748.1655711-1-anilkaushikwireless@gmail.com/
v5: https://lore.kernel.org/mptcp/20261016160926.1155262-1-anilkaushikwireless@gmail.com/
v4: https://lore.kernel.org/mptcp/20261016055010.980819-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/mptcp/20261014143349.768138-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/mptcp/20261013025653.523755-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (7):
  selftests: mptcp: connect: retry write() on EAGAIN
  mptcp: pm: in-kernel: check the limits with the netlink policy
  netlink: specs: mptcp: add the subflow-retries attribute
  mptcp: pm: in-kernel: add the subflow-retries limit
  mptcp: pm: in-kernel: retry subflows closed after an error
  selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/netlink/specs/mptcp_pm.yaml     |  17 +
 Documentation/networking/mptcp.rst            |  26 ++
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  18 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  50 +++
 net/mptcp/pm_kernel.c                         | 218 +++++++--
 net/mptcp/protocol.c                          |  77 +++-
 net/mptcp/protocol.h                          |  52 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 420 +++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |   8 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  59 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 16 files changed, 941 insertions(+), 65 deletions(-)


base-commit: 85e5bb627afc7749558bb522d64e1163b87f0913
-- 
2.25.1

