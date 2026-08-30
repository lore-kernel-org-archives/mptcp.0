Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C07282F3F
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121024; cv=none; b=bxpX38zqUYJISSA+KrRQ5Ioa5Ak73Q1bdbJVsG24uyUkU+zudomuyVo1cmWQ73PZ02wq9lihq5BpYaPUv+8GqrxyeH5l07NFtUO1P+fGVKlopuhDyIITt7rk4cgmsdWhpMR4/l5ItOi7dmsJRQk8cRjE49yK0JDoEcsVetRK1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121024; c=relaxed/simple;
	bh=izBMh7eVZhkWs1WnjxZ/AvcCI4mp9b+oIlFEmuKE7Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZ/sAKBzhi05z7/vmiYySjTaXkI/omzRJMWSNKuytGD1PVNXCXIDOnf1TM8QEM+TLYF/bsHSY7rg0ASCG0R+PdLxlImVKmdGmJDKere1JBg8o9IeRnOOKjbyMonGKk7xxrZgsUadBQ09TFhFy3Nct0xt8xVukjs1/a7q/O75vmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEVMfXmq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEVMfXmq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b8687630fso19008775e9.3
        for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121021; x=1788725821; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRVinZDK/Gxcrvk2NhV4IrbRKPZZNwFZwWSNmf32j2I=;
        b=hEVMfXmqVYW4jqRuZHAdQEMUFkwXVORIz3JYanhe03hIoE/Lneuh5c2eIdsYtiRsiG
         nXcwRZS5/czPg+E2sL4l8INz6b4ofZRnn38IPzbuPWJlC6JS1l4DWtRP/XJ1CYyN8DDV
         gP2ogTasPYD5T2/Mlf7LQdZqpxkH+EDmXr7ePgLAwaloTADpwTc2rST4mfrDVMBSvSi+
         o4QJUdGC0LSUe2WuyBFKDVxrI1elOuoqOyak4K6uFxpfmbZeApWKfXrR/RXQ5ntUG4gz
         OTYV1td77Dobsqvgi85XNtC65RCW7hQ1erh/kOSOmOLq4hMvaSqx2oXoyAUr/zD9yWxF
         v5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121021; x=1788725821;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRVinZDK/Gxcrvk2NhV4IrbRKPZZNwFZwWSNmf32j2I=;
        b=HoPVLw/NC61PN0y18gtDb6dCKkX7qmksRoXYc6TUkPmCSVuJT22ubhFAqOO5deyM91
         Qf1cdjVcfRB5wuZltuF0LmVNvyoVc2xnwJuw6zzAAJeukmSC27wST/mccra12v3L5ecU
         5MgH59BZg7aoMLQBEu1uF4AQ9T6D5UNLN5dE/mEzveneyTBt92u/GdXQfTXnDWOzWY88
         vT175pkfcyIUThtmePxcjS+QY2+QG0ejFdqbDMRle2TTM1+ZUcLZX3zW3yK8ElCwRW+b
         r7T+MKTOCdO8/r0Z5JhYMcIT6W1QAUE2a9jY7giq/3ULU/HNbYRzl4Vrv+T/8U1NP6mS
         auhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDJ+FUM3UgzwvJaUr51F3rzSPAPBVMyPY0eUskUUFk6QxwJCWlqutlTDXswIScv6dKnSOhuQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n0cTsr8Z2VvBNmIc0fwP8knua8MAjpZsFCfxR988416hq4oY6S
	dIKgTib6MWtAEetHo05g7d1ZdzQ9BrvwA8HlVR+C3/aj/kVD9qMw8REB
X-Gm-Gg: AR+sD13NbYmqb9m+oIwixP+j4D6zgJnS7qJYwFriAIn1fc9GvvdPWL8Ime9ltxPzLk+
	TGm/9IMy9O2errIzPbxcMd2d+lRqgX8Fkyo6NPGx1uPMsgzo5qQWCsWmyk+e3uZ7DG+pJ40Fv6g
	Is3CP3jK/N5zrhGWcPF3ezYnpF/drRvWIuu70QMqsEDUQK6+2DCHMkUQ54No5PoSLJqr7WILRHZ
	K5T8jW2rkiVH/Zu4E1fnulJu8C3xIaq3cLrbFnCnSh5MkZXitrTTeomuc4kQ5YUt8fOY4ZRMonw
	Wj3jeuLH/jrXqxUVyMVT6+m/lDeUEuefRY5yWP1vhe5uovbV6i2bEZScc9dD/QUO59QIg1FqJxy
	0rG3NAw3r5LTuL7wCLo81VbdQo//J22Tuecd9vluxGLUcVzSUw3Ow90iJ1C4ddG1/lhAumgjis2
	dxRNbgXeGz9xC4M1B61e9KOPSaOyr9WvcYKUDnAKY3lfIJG7g3NKXKXRtA1tu9mvC1DxeZVo6rI
	r9wtUS38rhId0fmcnWpUOQxiw==
X-Received: by 2002:a05:600c:4ecb:b0:499:d95a:44d with SMTP id 5b1f17b1804b1-49b91bd885fmr303712975e9.0.1788121020425;
        Sun, 30 Aug 2026 13:17:00 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c44feb966sm205868655e9.6.2026.08.30.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:00 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 0/6] landlock: Support MPTCP bind and connect restrictions
Date: Sun, 30 Aug 2026 22:16:44 +0200
Message-ID: <20260830201650.67050-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch set makes it possible to restrict MPTCP bind(2) and
connect(2) operations by port, adding the access rights
LANDLOCK_ACCESS_NET_BIND_MPTCP and LANDLOCK_ACCESS_NET_CONNECT_MPTCP.

Motivation
==========

With MPTCP operations being unrestrictable, some aspects of Landlock's
existing TCP restrictions were not useful.  Notably, bind(2) and
listen(2) on MPTCP sockets was possible, sidestepping a bind(2)
restriction that might exist for plain TCP sockets.  This patch set
fixes that gap by restricting bind(2) and connect(2) operations in the
same way as for TCP.

As listening on MPTCP sockets is backwards compatible with plain TCP,
it has gained more support and has become the default in common
networking libraries such as Go's net.Listen() function since Go 1.24
[1].

Historical background
=====================

In the initial implementation, Landlock's TCP bind(2) and connect(2)
access rights worked on IP stream ports independent of their protocol
as specified in socket(2).  This was corrected in Landlock erratum 1
in commit 854277e2cc8c ("landlock: Fix non-TCP sockets restriction")
[2] [3], but also meant that MPTCP sockets were now not restrictable with
Landlock any more, even though MPTCP operates on the same TCP ports as
plain TCP.

That MPTCP should often be treated the same as plain TCP was also
pointed out in [4] and [5].

Implementation notes
====================

* The tests are an extension of the existing exhaustive TCP/UDP
  selftest coverage.
* MPTCP subflows are separate connections with their own port numbers.
  As it is the Linux kernel which negotiates these ports with the
  remote system, the ports used in subflows are not subject to this
  Landlock restriction.
* MPTCP Fast Open is treated the same as for TCP.

Apart from these, MPTCP support is a relatively straightforward
implementation, mirroring the TCP logic in most places.

Alternatives considered
=======================

Making MPTCP sockets subject to "plain TCP" Landlock access rights is
technically feasible, but would undo erratum 1 [3], which could be
confusing to users and might introduce potential incompatibilities
with existing programs.

Open questions
==============

I am on the edge about the helper functions that I added to the
selftests; maybe would be better to flatten these decisions out into
the fixture data for improved clarity and to not run the risk of
reimplementing the same code that we want to test.


Let me know what you think!
–Günther


[1] https://go.dev/doc/go1.24#netpkgnet
[2] commit 854277e2cc8c ("landlock: Fix non-TCP sockets restriction")
    https://lore.kernel.org/r/20250205093651.1424339-2-ivanov.mikhail1@huawei-partners.com
[3] Landlock erratum 1, security/landlock/errata/abi-4.h
[4] https://lore.kernel.org/all/49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org/
[5] https://lore.kernel.org/all/1d1d58b3-2516-4fc8-9f9a-b10604bbe05b@kernel.org/


Günther Noack (6):
  samples/landlock: Implement best-effort fallback for network rules.
  selftests/landlock: Generalize net test helpers for multiple socket
    types
  landlock: Add MPTCP bind and connect access rights
  selftests/landlock: Add MPTCP network access tests
  samples/landlock: Support MPTCP access rights
  landlock: Document MPTCP access rights

 Documentation/userspace-api/landlock.rst     |  27 +-
 include/linux/landlock.h                     |   5 +-
 include/uapi/linux/landlock.h                |  24 ++
 samples/landlock/sandboxer.c                 |  72 +++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/net.c                      |  68 ++--
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 341 ++++++++++++++-----
 9 files changed, 425 insertions(+), 118 deletions(-)

-- 
2.55.0

