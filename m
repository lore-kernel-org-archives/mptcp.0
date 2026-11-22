Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795389672;
	b=fW5J+tGTbx3hlYN77bPkBEsrNVbCWGQws3eYsGB/LaekmUWu9TfC+briTgGl2enZDw22
	 a2x3IHyNm3rkj729qK7i+5025YjqR8cJjzfi+Mpq6uLA8eMvyWWMOR590pka/wsBUtYex
	 xp0Fsofy+NCuvatL1c24Sm/HBQO3I1YZADYZzfBRtKTaTtAMcQ0mVuoO78i11XdiLHj1Y
	 JWAVwD2liJyPGMe3rZuQKtILR4tGCdVcyw6qCRKdvnUFNL+vSgjDXPQIOVKJgd4WChdSq
	 vIUW6FvAAqh5SWttGlkWDtd/jrZ3HBtJRRApyOKkh34POZ2JRLmJay50yrq1yqWYUOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795389672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=TTW4RGUBOIoiovq6C38P7O0ojxYjuzO+Jk/cZ+Q8iu8=;
	b=R3Rf/aV5m4O9EtPw0Rr4zQex576I238AaNUvoYn9A0SReoo5ANscSZaMOdA/P1QppLAD
	 WSvw4V+f6ItH8cdZ+dNYK34GT2Htn+7DdUyn/9peUls9o7wgldhV0rlEORIF4qD5+lLCX
	 wnnCumpCpNui9ch9NEF2AFYEnUNvc1XuZZZrHq6wRwGZfonpXyKRQNUdgrKWZ8oKiPdad
	 sO42VH1g58T4tU5lvggnqPcfJnQSWDX+87rDZXbyE4PniEQZ9q6I/8GIhV2VeYo3Uxg07
	 TwWbbPirXMArkOeAtQc43KONFoxw4yfqwi19kBQd0Q3o03SB+Cw3F3uagkMJvulB7JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/y7RuYD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD3606A31A
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 23:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03BD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/y7RuYD
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ba1e6068c3so152817a12.3
        for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 15:21:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795389670; cv=none;
        d=google.com; s=arc-20260327;
        b=B9qmHXRYr6ooATURROvCcOJOapbtYV/uXHtBEnllTVeEm5CyjHLqKq/lWnNFOblDva
         9LvkURAdgzo+9+xdqLCdm9PIruQHh8EYZenvdQIJWfeLKPdoJz1B2O6N0Wgyvmi4ZtBQ
         8Vyg5izwdRJM6OxvcIedcHp4d3QbbT6dY5d21VaiLkSqLpN2vZBlcS1yzAFS5DZ1crkk
         PPt8XCMj+H8gtp3Qio3XSuKq6yhbuuyiP3UoEtqVES/3SpvssA5nQ8R42bvn1MhLE1Ve
         G1d2AKxRdd8Hy5w3g03N7ve/kAhPRnAb1Bg/C0aB7KGEmh6/9+YzjVqRqsOlHWPyXmIB
         6+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=TTW4RGUBOIoiovq6C38P7O0ojxYjuzO+Jk/cZ+Q8iu8=;
        fh=5eXKLRljkh3JQK3w0eRxcHmxBes7ZYwBKpnfSOMYgcM=;
        b=WenR7pqAb6ww7vBlHq5iy0iozaDLDWIdmS3C1ylN7I4NU7LcUR2NC+pyJBlFvNxnMH
         XDISBH5vRtTFSfBTaWGV/okWwlpXYO73UMfnvZEIsJo1ySyaNJ6ke4gHcMaDVhPhq/Ce
         9HcsUT6Nb3DDcUp+Q0dtRvEeMziHRDluktmG5dDZLOCpj/v27iPlLAVeee2PUtmp8u2f
         q7COEnijp33GZBJ/1emEWIr+fDm/akdqPFSgIXqPnL+10nIQ8qsZCrxvQZNap0IXKmUs
         KWrsTsyjCW2Ed/pNkp0e6VzMMFpUivs/jW3O3Z5ZsYYSOFMBHAchn4cwxMumt/h43kTC
         oa2A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795389670; x=1795994470; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TTW4RGUBOIoiovq6C38P7O0ojxYjuzO+Jk/cZ+Q8iu8=;
        b=g/y7RuYDmdkalLxyP/XATwx7+/5JVecGc3t0628BYXGMOMEhAfOvzts0OSXC0z13tn
         17Vp2sXKvcA7tWOQ0FuYYLlHMA0fyjFNxiqnDzks+cDlLH0Pf9GTvJGSeFb46qYQy7sr
         1cWTnq/JTw4Pjg+BoUKj32sB/thWI8DxJQwFpfS0gfT5ydMVo0RhvJ8p3rLrPxvE3ctE
         J+SArcaPZOpCGu1m5suAD4f7qrotWqe0fc6uggPSzSpDO/FAyjmqHor+VBkrVZLrogYc
         YjRREKoO/sY3bOZ4r79jdOEPl84SVFbCiUcYeCf03zvzR9KNKfiiaYeYbbw5oKrl/XKn
         dw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795389670; x=1795994470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TTW4RGUBOIoiovq6C38P7O0ojxYjuzO+Jk/cZ+Q8iu8=;
        b=dqHmkP6cRU9CxCsLMMRgeNUmiltl34j+JiI0FSvJNItbtokddHqizIxRBXaIAzF4Mk
         X5RaQOAkRnLIO4l+x35pTxPRUBADITcbbCPJpmUQNqlRteBcre2pVtSR7/ML8xUbCyUd
         q6JHpJsbuWiSvtFzmkfWRZ/W0/PBKKKCkLplanQFgVv3NSiski8t2CyfeUY1D5mfpQBP
         cO19AUDQvXaF8SsnsyOeXg4IAeCEpqUXC39KenVO24p2BlkNlhd+qDRrCq7YMJMpIYsa
         eQV2C2nL0yNn/+ePTEIkEME86ANpWZx3K5HuXmy5b9KJ2oAGgpPj7oQyVcCnOe2g/xyM
         0QLg==
X-Gm-Message-State: APuU4Z9gXg9Pm+gPQnM3YIPqWGbcNbiTO3qN3zDNm3i90YQyPNVZFlTc
	CpKtBllFAL0AYnknStGoutEYvgsA3vCMmv39qv4QcAgiwytbcBPwRm4g6Hay0YRAzpn6YmAeBJd
	lcGm1MyF2AATpe3f0cc85tizZ08UYe7VIt9tT
X-Gm-Gg: AZFdTZf375MCHx5fKCVU1SKGr2aIbu3UWd3WXILpjskIBpKlzABs3vHIQyu2z0SlzxP
	u93GNHesfrBtIy62ysiR+QCSQ0PIYtCGqMqLiI9AaiaqUH8fDk3ord4tdp7pUlSSr/t1XtMjFSo
	h0+7uSPxbpAAs2VbjFPLaDk78uO8xWGHukW8gzY4Lc++SFhW6CLUeVD5f7xupQxx1YYby3BIS89
	1ZKAMwRCXYr2wZJFpj0zf7cCswCNA+Hk3x9WFfah859UJFZUz/8U8jUYPTBtSR8cXFnV/23u0BZ
	0ImEwvzHuLFEPXdfgAnb8p0+lsLRkQAr8a/Xa3XRELYNuJ7J1WVdPerZTiOeGa5FMh9Ur9Bt5cT
	BjrnjO2KiuJmk1jj5zZ63T81HZYS/tX1wws4G9aqrxRDg4CTx1RcAPtv0YnTnoCVS+U8oxssYiH
	PKt9B1OylL9OjJM7DBiRG1UIBBcd471yf8vCh5SYsZw5ZSBglRwfI/vNkX9U02H7bPowGeKg==
X-Received: by 2002:a17:906:6042:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c513a5f04b2mr765814666b.3.1795389669778; Sun, 22 Nov 2026
 15:21:09 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Johan ter Mors <johan.termors@gmail.com>
Date: Mon, 23 Nov 2026 00:20:58 +0100
X-Gm-Features: Aa3M54q9i-eUfb68ANYI-0WXkcVo8MmJAw0JheY6aeJJhPoOK0SSWItMbYvqNQg
Message-ID: <CAPM+r-LfRteAFEuWu9am=K_S3cqP9iJFxiSnZK337_qwuC3HmA@mail.gmail.com>
Subject: =?UTF-8?Q?mptcp=3A_ADD=5FADDR_echoed_but_never_joined_after_the_fi?=
	=?UTF-8?Q?rst_announce_round_in_a_single=2Dnamespace_setup_on_6=2E12_=E2=80=94_c?=
	=?UTF-8?Q?ounters=2C_timing_sweep=2C_CVE=2Dcorpus_reconciliation_and_a_pm=2Ec_?=
	=?UTF-8?Q?pointer?=
To: mptcp@lists.linux.dev
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi MPTCP team,

While investigating late-announce subflow behaviour with kernel-PM
netlink configuration on UML, we hit one behaviour difference we
cannot explain from the code, plus a few things we confirmed healthy.
Everything below is measured twice: packet-level (AF_PACKET sniffer
counting MPTCP subtypes) and via the MPTcpExt counters in
/proc/net/netstat, on self-built kernels of v6.12 and v7.3.5 (same
probe, same config).

The question: on 6.12, in a single-namespace setup, every ADD_ADDR
round after the first is echoed but never followed by a join =E2=80=94 not
even a socket-creation attempt. On 7.3.5 every round joins.

Sequence (single namespace, kernel PM, limits 4, endpoint id=3D8
127.0.0.3 SIGNAL, listener bound to 0.0.0.0:50560, 30 live loopback
MPTCP connections per round; each later round does pm_flush() + re-ADD
id=3D8 and creates 30 fresh connections before announcing):

Round 1 (first announce after boot), both 6.12 and 7.3.5:

MPJoinSynRx=3D30 MPJoinSynAckRx=3D30 MPJoinAckRx=3D30 -> all 30 conns join
AddAddr=3D46 EchoAdd=3D46
Rounds 2-5 with 1 s, 3 s, 10 s and 30 s wait between rounds, 6.12:

EchoAdd: 46 -> 152 -> 317 -> 543 -> 709 (echo tracks AddAddr:
the announce IS received
and echoed every round)
MPJoinSynTx / MPJoinSynRx / MPJoinAckRx: frozen at 30
MPJoinSynTxCreatSkErr: frozen at 16 (mptcp_subflow_create_socket
is never even called)
same after 30 s of idle: not a timeout, a stuck state.
Same rounds on 7.3.5: MPJoinAckRx 30 -> 60 -> 90 -> 120 -> 150 (every
round joins, CreatSkErr grows with the round =E2=80=94 the same dual-attemp=
t
pattern as round 1).

Two further data points that narrow it down:

A round-1 announce with ZERO live connections (endpoint registered, no
msk exists yet) also poisons 6.12: after creating connections and
announcing again, the same echo-yes/join-no signature appears. On
7.3.5 everything works. So "the first announce that was actually
received" is not the boundary; the state gets stuck regardless.
pm_flush() + re-ADD between rounds does NOT reset it on 6.12. (Also a
small aside: re-ADD of the same id without an intervening DEL/flush
returns -EBUSY on both releases =E2=80=94 we used flush+re-ADD for every
round.)
The counter signature (echo present, join work never scheduled, no
CreatSkErr/BindErr/ConnectErr) points at the echo-only branch in
mptcp_pm_add_addr_received() (pm.c): for addr->id > 0 with
!READ_ONCE(pm->accept_addr) the code just echoes and acks without
scheduling MPTCP_PM_ADD_ADDR_RECEIVED. But a freshly created msk
starts with accept_addr=3Dtrue and zero counters, and accept_addr is
only cleared in mptcp_pm_nl_add_addr_received() after sf_created when
a limit is hit (pm_netlink.c) =E2=80=94 so from the source we cannot see wh=
ich
state, in this topology only, pins 6.12 on the echo-only path from
round 2 onward while 7.3.5 does not. The two-namespace topology
(server announces to a client netns) does NOT show it on 6.12 either:
a re-ADD after DEL there re-establishes all subflows within ~90 ms.
The trigger seems to be the single-namespace "self-announce"
configuration, where both PM roles live in one netns =E2=80=94 e.g. local
proxy-style setups.

Follow-up on the state we report: we tried to reconcile it with the
2026 CVE corpus before bothering you further. We backported the
semantics of CVE-2026-46137/46158/46170 (ADD_ADDR-rtx timer
locking/refcounts), CVE-2026-97566 (ID0 anno_list cleanup) and
CVE-2026-99603 (SOCK_RCU_FREE on kernel-PM listeners) into our 6.12
test kernel and re-ran the probe sequence: round 1 still completes
joins, round 2 is still echo-only =E2=80=94 unchanged. The signature is als=
o
identical on IPv6 (announcing an fd00:: endpoint) and with
tcp_syncookies=3D2 forcing every MP_JOIN through the syncookie restore
path. A fresh listener (close + rebind between rounds) does not clear
it either. The one discriminator we found: with a short (~1 s)
announce-to-close dwell the echo->join path fires on every round (even
while the genl announce itself returns -EBUSY), while with a ~15 s
dwell it freezes permanently from round 2 onwards. So the
echo->accept->join-work path appears to latch a per-namespace "already
handled" state that only decays with time, independent of all the PM
fixes we could backport. Does that ring a bell? We're happy to run
anything specific.

Background on why we're careful with claims here: the same
request-socket lifecycle area produced CVE-2026-98432 (IPv4 handshake
IP-options UAF, fixed in 6.12.113 et al.), where Anthropic reported a
working remote-root exploit against an MPTCP listener and AWS
confirmed it =E2=80=94 while CloudLinux could not reproduce that claim. Our
own finding sits next to CVE-2026-99288 ("NoisyTCP", unhashed-socket
established lookup ABA, fixed in 6.12.117/6.18.63/7.3.4): Kim's own
FAQ answers the RCE question with "Not yet. and basically, no.", no
exploit is public, and no exploitation has been reported =E2=80=94 so we cl=
aim
nothing beyond what we measured. What we did add: a differential
stress harness that drives the UP-reachable preconditions (SYN/child
churn on fixed 4-tuples with abortive closes, 40 established
same-dport-chain connections doing lookup pressure, backlog-2
listeners, 25 s storm, ~45k churn events) on KASAN kernels on both
sides of the 99288 fix (6.12.0 vs 7.3.5): zero splats on either,
matching KernelCare's single-RX-queue analysis =E2=80=94 our UML lab is UP,=
 so
the two-CPU race cannot fire there. We note two lab facts that may
matter to testers: our UML builds lack CONFIG_SYN_COOKIES (the sysctl
is absent), so the cookie-socket path of the published PoC could not
be exercised from UML without a rebuild, and /proc/net MIB access is
the reliable observation channel.

Since then we closed two more legs of the 99288 investigation, and
both seem useful context for triage. (1) What we tried, reported
honestly as bounded negatives: we rebuilt on a 2-vCPU x86 qemu guest
with CONFIG_SYN_COOKIES and built a raw-packet harness (IP_HDRINCL
segments + AF_PACKET cookie sniffer, storm workers pinned per vCPU so
cookie churn runs on one CPU while lookup pressure runs on the other).
Trial t1: 14,068 SYN, 5,330 cookie SYN-ACKs, 42,640 crafted
cookie-ACKs, 294,160 established lookups; trial t2: 44,032 crafted
cookie-ACKs, 600,760 lookups. MIB deltas confirm the cookie path was
genuinely active (SyncookiesSent +29.9k, SyncookiesRecv +2.2k across
both trials), yet both trials ended clean =E2=80=94 no splat, no deref. One
open measurement question stays registered, not hand-waved: the
majority of the crafted ACKs fail cookie validation (SyncookiesFailed
+86.6k), and we have not yet isolated whether the child-present path
or the time-bucket behaviour dominates that. Our loopback guest has a
single receive queue, so the published PoC's fragment-spread technique
cannot be exercised here =E2=80=94 consistent with KernelCare's
single-RX-queue analysis. (2) The consequence, demonstrated as a
labeled simulation: on an otherwise healthy guest (10 TCP connections,
30/30 ping-pong roundtrips) we injected the equivalent NULL-deref via
the in-kernel crash-injection path (LKDTM, crashtype EXCEPTION, write
to address 0 =E2=80=94 the same failure mode as the 0x12 deref in tcp_v4_rc=
v):
"BUG: kernel NULL pointer dereference", "Oops: 0002 [#1] SMP", "Kernel
panic - not syncing", host gone, all connections dead, no recovery
without reboot. That is the A:H reading of the official CVSS 3.1 7.5
(AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) demonstrated behaviourally =E2=80=94 =
it
is explicitly not the race itself firing.

Scope notes from the same session, in case they help downstream
triage: Android GKI lines 5.15/6.1/6.6 carry no fix (fixed kernels are
6.12.117/6.18.63/7.3.4), so the crash class applies there at kernel
level; the GKI 6.12 line is fixed upstream, with merge level per
Google release. On the BSD side the specific ABA mechanism is
Linux-only (BSD/XNU manage request-socket lifetime differently), but
our adjacent FreeBSD work found a related availability weakness in the
same class: FreeBSD 14 deliberately shares one global budget between
challenge-ACKs and closed-port RSTs (tcp_subr.c
tcp_challenge_ack_check -> badport_bandlim(BANDLIM_TCP_RST), per the
in-source comment), which we measured live as a 44% drop in RST
delivery under challenge load (knee ~130 pps, hard plateau 121-132
rps, reconfirmed on a fresh 14.4 CI-VM; FreeBSD 12/13 and XNU,
per-connection 10/s, unaffected). We are preparing that as a separate
FreeBSD-side report.

Confirmed healthy in the same MPTCP scenarios (counter-verified, both
releases): joins complete normally after a late announce once the
listener serves the announced address (MPJoinAckRx=3D30/30, round 1);
establishment-time joins (endpoint present before connect,
SIGNAL|SUBFLOW) are 30/30 in the same namespace on 6.12 even after the
block appears, so the join machinery itself is healthy; REMOVE_ADDR
under 50 live subflows tears down gracefully with FIN (no RST) within
~90 ms and re-ADD re-establishes within ~90 ms; endpoint churn under
open joins returns EINVAL (not EBUSY) for in-use ids and works for
inactive ones; 100 announce/join/DELETE churn cycles show zero drift
with TIME_WAIT plateauing (~800) rather than accumulating;
KASAN-instrumented runs of the same scenarios report nothing.

We may well be misreading something in our own setup =E2=80=94 the probe is
small and self-contained (static C, netlink + AF_PACKET + getsockopt
only), and we are happy to send it or re-run anything specific,
including against net-next. If it helps, the decisive counters are
EchoAdd vs MPJoinSynTx/MPJoinSynTxCreatSkErr in MPTcpExt
(/proc/net/netstat); a printk or ftrace on the pm.c echo-only branch
under this sequence should settle it quickly.

Defensive-scope note: this is a defensive-security evaluation of the
TCP stack in an authorized lab; all traffic is between our own
namespaces and guests on loopback. No exploit is claimed or provided;
a longer evidence report (per-claim artifact hashes and manifests) is
available on request.

Thanks for your time.

Kind regards,
Johan ter Mors
Security Engineer
