Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559456;
	b=XQSAeSqJ4KzyuherE4Xyf4/nrnmM3wvRiraLaNRHY1kdk94Yqhd/TVDtc9RqMzuzL9/y
	 LB8OL2pWn6lSnq1m35I9VIJ3xqbfUJMkCKb2AqGyZ/u5caNQjSy62fqhgqqbhhWMCOSsq
	 lG6XuL+hJuLOmQRI6cOv08CF+5r1UEMZIfMmnPkH4nPZGyFEJoIQSyt4S8PNG7me9aZtO
	 3p1lnSZdg28yh4BHnxACNTmJOOjkVdQ/U7AMQBT3GFA3t5ZiJjKoRFFRAWfB3My7iUvqs
	 w7c0TlJJmiViYCG3em9BQJ0OLKiEiTP9OiDqHRsGp/5cvhmcXpbjJo4N4txonMaZJag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559456;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:In-Reply-To:
	 References:X-OQ-MSGID:MIME-Version:Content-Type;
	bh=W9eIkvDDECsB4Is+yRISbbRYeQyVZMf9actxMz8gkHY=;
	b=sqQ9vk/jxxlzCytLbQ8pbOxXh7xFhZPAGHo6WWxorlAqruerLU/Rl59L3I4rDvVzoqv9
	 K28mdMgtwuejszox3nbEVvQVUVztwfz9ltpQ6DYW7JX5H3NWpanJNY78aP+AqTTuODEot
	 R+4v4bHNSPbuMh7hpFFs6Wck4CFjDjSSkhfDwUtgxv1IWlyj9qWx1+BvmeZYkZ8we/FWQ
	 EdXBTRzPzrb1GSr4tl9xruWkauRJeDnwPOaW8cVeXvKhICcWFlNsFW9YX1au0ypDtHy03
	 QjP2hD05zYFV5i2jDD/oE/eCp9zEaACyShnJhnU3LU4qnCY6yO0gNRRUf/OGpB+gX6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Vkx+3NSj;
	arc=none smtp.remote-ip=203.205.221.239
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783E606A327
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 08:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6783E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Vkx+3NSj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794559452; bh=W9eIkvDDECsB4Is+yRISbbRYeQyVZMf9actxMz8gkHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vkx+3NSjIYF71P5RDKjn2szxRx7JC0zX1xDDdpGajc1pEl4FEaPNXrEAT55fqG3DS
	 be6U+Yl+gLpodk6YKcWKXsnDlz08vyi1ktbz6H4gEpVCUN8/aZx28dIbdDCUjZ/DlT
	 V38df1JhSOA1kDPVBLr1gGlh/kanty7zY/zwJxzk=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:e498:8f16:a485:ceef])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id B07180EA; Fri, 13 Nov 2026 16:44:07 +0800
X-QQ-mid: xmsmtpt1794559447tcgpuq1dl
Message-ID: <tencent_EBC4654F72487E5F85E9F6656A174BF68108@qq.com>
X-QQ-XMAILINFO: M2dBUVw0X9hn1bKgHYDXwrRIPkkqRVEbQ9sWMw56Qav/+7z9NO0ztD28lm+KFj
	 xN4Qo8nzVW3/9jksyUUgzNt77XTKUCcKzPaTt4Cv2ieAkxihQcqOUVQ4u1ra6MT1eWHimbMA/q1w
	 cuWgrpyuN18nv6ULvJ20ttY6dgETQGtTY/Hy1XB9ARI0S9LJRhvFp855mUzmQOyi4jOoI+ftrPkk
	 Qqopn0oVDHxrU1yfS0CWxLhlcWSXxEMm40gink2PiOjFW4NLflnJVaWMs8kD2p9FwUrrQdvgqw08
	 8NO4L/gS3+LyCS8Lhe3xPLPVdHSxmEV4KR4Kgk4vyAAg9noEuf1J3lWcM7FRzXB/3RGzM2qIdDk4
	 KCcVJ+SLzB71ymjUBrPxLdvsSj8Sjkx07lHrWFj4da4Yv+Ke/shfoEfhibIUJdxkyaKfIlGGQ/I7
	 tx6Kh/j39GfL0gfXNiqXbM67Stxu61eyE30dH27gQ0+T1OTc6dBUZn4Ofz42Qd5g05N0atxqGLmI
	 fntgEkydiczy/OPbDn87NGsESGp4GXspK7G82tFtP0kG2rj3EBZI6NPMXqbsS2d0NhNQn+phQqeW
	 LJpjg+82G9jGi/xYJn2gXpJ6ysS7N94cAtDnuhWLn8sETUr5yhQzdppHHnN82GGRSril6qlRFQTp
	 DC5Z2QsC+YlJw62/g8AlYIP8O/cOJmUyPulVqR5G2f9mEgZm4964lhuF8EFngZbO9EiGYL85laUS
	 gAzspE3Bx/WO3WgLIhGuMckuxLD/68UuvFZre4YWpiwz3d2e4bFOuM0MovsICNBczjc+4LAFNYyR
	 E47SjEeJsv6MXf0Jrr4h9dTtdu2Yyc6r55IxydFvlgfHoee/+4YzguIR7gNqTQmWtKM0voRCuPY0
	 D2wSPUugK+kTytfgv/A2M36tEtgb6vjh1PNntPNi5Umlb0T5JOp84sqboiIUkTBWwBBY/MmDoHvg
	 oWHosvkB31cHhehYqEICpzMn6c0zO+KDLf6ePlDdWMGWWF57oOafKj0ZJqAJSYEv+/3OrjNVVWMW
	 B/vr2x2OtEQ7ODPvz9yKtojARTNz6hwmNAvoZmQiRnpGZY0X2UHihHnFgMkVS8Vk60rHkAI1FNRN
	 g8gyXg+qulpSqLylFqIVLU0rEFW7VU593niOpk+j3LCWUi2QkqN21K6eZyzmuz6oG2gAsR
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 linux-kernel@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net 0/2] net: restore acquire ordering for two remaining
Date: Fri, 13 Nov 2026 16:44:06 +0800
In-Reply-To: <179448794830.196117.14284634941387773647@qq.com>
References: <179448794830.196117.14284634941387773647@qq.com>
X-OQ-MSGID: <179455944699.466184.11601062358584953491@qq.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1344242358540054460=="

--===============1344242358540054460==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the automated review.  Here is the missing information for the
series, plus the instruction-level evidence that was asked for.

How it was found: manual code inspection, not a runtime report.  While
looking at net/ lockless lookups right after 5b5d8f351dd9 landed, I
enumerated every refcount_inc_not_zero() call site in net/ (102 of them
today) and classified each one by whether the reference is taken only to
keep the object alive, or whether object state is re-validated after the
acquisition.  mptcp_token_get_sock() and mptcp_token_iter_next() are in
the second group: they re-read msk->token and sock_net(sk) after the
increment, and mptcp_token_destroy() unlinks the socket and then does
WRITE_ONCE(msk->token, 0), so the re-validation is the only thing that
rejects a socket whose token has already been cleared.
reuseport_migrate_sock() in 2/2 is the only other site with that shape
in net/.  The enumeration of the call sites was tool-assisted; the
classification and both changes were checked by hand against the
callers and against the teardown paths.

Instruction-level evidence (new): the two helpers do compile differently
on a weakly ordered CPU.  Built from this series' base (7.4.0-rc2) with
aarch64-linux-gnu-gcc 14.2 and arm64 defconfig, which enables
CONFIG_ARM64_USE_LSE_ATOMICS, net/core/sock_reuseport.o disassembles as:

  before 2/2 applied:
        fc4:  88a37c02        cas     w3, w2, [x0]     <!-- relaxed CAS -->
        fc8:  6b03003f        cmp     w1, w3
        fcc:  54000981        b.ne    ...

  with 2/2 applied:
        fd4:  88e17c43        casa    w1, w3, [x2]     <!-- acquire CAS -->
        fd8:  6b01001f        cmp     w0, w1

  i.e. CAS -> CASA.  For builds without LSE the same change turns the
  ldxr/stxr loop into ldaxr/stlxr, and refcount_set_release() turns the
  plain str into stlr.

On x86-64 both variants compile to the same "lock cmpxchg", so the
series is a no-op there, which is why the ordering violation is not
observable on the machine I tested on.

Reproduce:
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- net/core/sock_reuseport.o
  aarch64-linux-gnu-objdump -d net/core/sock_reuseport.o \
        --disassemble=reuseport_migrate_sock

Whether it was triggered: no.  This is a theoretical ordering gap, not
an observed crash.  I have no syzbot report, no KCSAN splat and no
runtime reproducer for the reordering itself; demonstrating that would
need a weakly ordered machine (the instruction sequences above are the
strongest evidence I can produce here).  So the series does not claim to
fix an observed bug.

Reachability of the path (for completeness): with
net.ipv4.tcp_migrate_req=1 and four SO_REUSEPORT listeners on loopback,
a 20 second churn run (4 connector threads, 2 threads closing and
re-adding listeners) moved TCPMigrateReqSuccess from 16426 to 17103 and
TCPMigrateReqFailure from 1858 to 1875 on 6.18.58.  On 7.4.0-rc2 the
same load drove 6,625 successful migrations across three 80 second runs
(KASAN kernel, no reports).  A minimal two-listener case (64 established
but unaccepted connections, then close one listener) moves the counter
by 27-29.  This is only a reachability check, not a demonstration of the
reordering.



What was verified: the re-validation exists and is the guard described
above; the teardown order is __sk_nulls_del_node_init_rcu() followed by
WRITE_ONCE(msk->token, 0) in mptcp_token_destroy(); both touched objects
compile cleanly (net/mptcp/token.o, net/core/sock_reuseport.o) on x86-64
and arm64; the change is a no-op on strongly ordered CPUs.  The argument
is the same one used in 5b5d8f351dd9 for the inet lookups: a successful
reference acquisition has to order the validation that follows it.

Happy to drop the series or fold it into a larger ordering series if
reviewers would rather wait for a KCSAN/arm64 runtime demonstration.

Hang Nan

--===============1344242358540054460==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="arm64-unpatched.txt"
MIME-Version: 1.0

ICAgICBmYWM6CWI5NDA4MjYxIAlsZHIJdzEsIFt4MTksICMxMjhdCiAgICAgZmIwOgk5MTAyMDI2
MCAJYWRkCXgwLCB4MTksICMweDgwCiAgICAgZmI0OgkzNDAwMDVhMSAJY2J6CXcxLCAxMDY4IDxy
ZXVzZXBvcnRfbWlncmF0ZV9zb2NrKzB4MTQ4PgogICAgIGZiODoJMTEwMDA0MjIgCWFkZAl3Miwg
dzEsICMweDEKICAgICBmYmM6CTE0MDAwMDEwIAliCWZmYyA8cmV1c2Vwb3J0X21pZ3JhdGVfc29j
aysweGRjPgogICAgIGZjMDoJMmEwMTAzZTMgCW1vdgl3MywgdzEKICAgICBmYzQ6CTg4YTM3YzAy
IAljYXMJdzMsIHcyLCBbeDBdCiAgICAgZmM4Ogk2YjAzMDAzZiAJY21wCXcxLCB3MwogICAgIGZj
YzoJNTQwMDA5ODEgCWIubmUJMTBmYyA8cmV1c2Vwb3J0X21pZ3JhdGVfc29jaysweDFkYz4gIC8v
IGIuYW55CiAgICAgZmQwOgkyYTAxMDA0MiAJb3JyCXcyLCB3MiwgdzEKICAgICBmZDQ6CTM3Zjgw
NTAyIAl0Ym56CXcyLCAjMzEsIDEwNzQgPHJldXNlcG9ydF9taWdyYXRlX3NvY2srMHgxNTQ+CiAg
ICAgZmQ4OglmOTQwMjNmOSAJbGRyCXgyNSwgW3NwLCAjNjRdCiAgICAgZmRjOgk5NDAwMDAwMCAJ
YmwJMCA8X19yY3VfcmVhZF91bmxvY2s+CiAgICAgZmUwOglhYTEzMDNlMCAJbW92CXgwLCB4MTkK
ICAgICBmZTQ6CWE5NDE1M2YzIAlsZHAJeDE5LCB4MjAsIFtzcCwgIzE2XQo=

--===============1344242358540054460==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="arm64-patched.txt"
MIME-Version: 1.0

ICAgICBmYWM6CWI5NDA4MjYwIAlsZHIJdzAsIFt4MTksICMxMjhdCiAgICAgZmIwOgk5MTAyMDI2
MiAJYWRkCXgyLCB4MTksICMweDgwCiAgICAgZmI0OgkxMmIwMDAwNCAJbW92CXc0LCAjMHg3ZmZm
ZmZmZiAgICAgICAgICAgIAkvLyAjMjE0NzQ4MzY0NwogICAgIGZiODoJNGIwMDAwODEgCXN1Ygl3
MSwgdzQsIHcwCiAgICAgZmJjOgkzNDAwMDVhMCAJY2J6CXcwLCAxMDcwIDxyZXVzZXBvcnRfbWln
cmF0ZV9zb2NrKzB4MTUwPgogICAgIGZjMDoJNzEwMDAwM2YgCWNtcAl3MSwgIzB4MAogICAgIGZj
NDoJNTQwMDA1NmQgCWIubGUJMTA3MCA8cmV1c2Vwb3J0X21pZ3JhdGVfc29jaysweDE1MD4KICAg
ICBmYzg6CTExMDAwNDAzIAlhZGQJdzMsIHcwLCAjMHgxCiAgICAgZmNjOgkxNDAwMDAwZSAJYgkx
MDA0IDxyZXVzZXBvcnRfbWlncmF0ZV9zb2NrKzB4ZTQ+CiAgICAgZmQwOgkyYTAwMDNlMSAJbW92
CXcxLCB3MAogICAgIGZkNDoJODhlMTdjNDMgCWNhc2EJdzEsIHczLCBbeDJdCiAgICAgZmQ4Ogk2
YjAxMDAxZiAJY21wCXcwLCB3MQogICAgIGZkYzoJNTQwMDA3ZTEgCWIubmUJMTBkOCA8cmV1c2Vw
b3J0X21pZ3JhdGVfc29jaysweDFiOD4gIC8vIGIuYW55CiAgICAgZmUwOglmOTQwMjNmOSAJbGRy
CXgyNSwgW3NwLCAjNjRdCiAgICAgZmU0Ogk5NDAwMDAwMCAJYmwJMCA8X19yY3VfcmVhZF91bmxv
Y2s+Cg==

--===============1344242358540054460==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="x86-unpatched.txt"
MIME-Version: 1.0

ICAgICA4NjU6CTg1IGQyICAgICAgICAgICAgICAgIAl0ZXN0ICAgJWVkeCwlZWR4CiAgICAgODY3
Ogk3NCAyYSAgICAgICAgICAgICAgICAJamUgICAgIDg5MyA8cmV1c2Vwb3J0X21pZ3JhdGVfc29j
aysweGMzPgogICAgIDg2OToJOGQgNGEgMDEgICAgICAgICAgICAgCWxlYSAgICAweDEoJXJkeCks
JWVjeAogICAgIDg2YzoJODkgZDAgICAgICAgICAgICAgICAgCW1vdiAgICAlZWR4LCVlYXgKICAg
ICA4NmU6CWYwIDBmIGIxIDBmICAgICAgICAgIAlsb2NrIGNtcHhjaGcgJWVjeCwoJXJkaSkKICAg
ICA4NzI6CTc1IDVmICAgICAgICAgICAgICAgIAlqbmUgICAgOGQzIDxyZXVzZXBvcnRfbWlncmF0
ZV9zb2NrKzB4MTAzPgogICAgIDg3NDoJMDkgY2EgICAgICAgICAgICAgICAgCW9yICAgICAlZWN4
LCVlZHgKICAgICA4NzY6CTc4IDVmICAgICAgICAgICAgICAgIAlqcyAgICAgOGQ3IDxyZXVzZXBv
cnRfbWlncmF0ZV9zb2NrKzB4MTA3Pgo=

--===============1344242358540054460==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="x86-patched.txt"
MIME-Version: 1.0

ICAgICA4NzA6CTI5IGMxICAgICAgICAgICAgICAgIAlzdWIgICAgJWVheCwlZWN4CiAgICAgODcy
Ogk4NSBjOSAgICAgICAgICAgICAgICAJdGVzdCAgICVlY3gsJWVjeAogICAgIDg3NDoJN2UgMjQg
ICAgICAgICAgICAgICAgCWpsZSAgICA4OWEgPHJldXNlcG9ydF9taWdyYXRlX3NvY2srMHhjYT4K
ICAgICA4NzY6CThkIDQ4IDAxICAgICAgICAgICAgIAlsZWEgICAgMHgxKCVyYXgpLCVlY3gKICAg
ICA4Nzk6CWYwIDBmIGIxIDBhICAgICAgICAgIAlsb2NrIGNtcHhjaGcgJWVjeCwoJXJkeCkKICAg
ICA4N2Q6CTc1IGViICAgICAgICAgICAgICAgIAlqbmUgICAgODZhIDxyZXVzZXBvcnRfbWlncmF0
ZV9zb2NrKzB4OWE+CiAgICAgODdmOgllOCAwMCAwMCAwMCAwMCAgICAgICAJY2FsbCAgIDg4NCA8
cmV1c2Vwb3J0X21pZ3JhdGVfc29jaysweGI0PgogICAgIDg4NDoJNDggODkgZDggICAgICAgICAg
ICAgCW1vdiAgICAlcmJ4LCVyYXgK

--===============1344242358540054460==--

