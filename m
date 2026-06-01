Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B536F917
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315147; cv=pass; b=dxauyWSqyyzuli5tD3zJCSPAew0mzwq68gU3fuTc5Rloae7iC0HNG8utRxOAOSTw5Van51iTLrtYrhv8DEkLbFnLA51Yea2vGCIx/0A2s0rxtG1RJJ4p9PCYwKrTSeKe5GcIed6/HdkoHUWj+xmpVAgqdmUC9JxDVcr3eLYLRns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315147; c=relaxed/simple;
	bh=wR+S67EPrjjfjf/tpdqbDVySbQ+G5Ou1WXfIFODibPc=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CRUy59MFENNFj4EEqYwUw+XVLI+/pIaiIELpnpFSOOW2qGpuedxSe+8VwCJoUPVIIP44/Zp/dZGoD5vgJ/bpa7DeA3mmOixY4h7NlJ3i3DMBwUomVRzrg0l0XU1RFEBDuyjYbtOQFEZFbKrN8Jv6a9DMIBvqaIRDm6b54h3zo3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=kZONnGIL reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="kZONnGIL"
ARC-Seal: i=1; a=rsa-sha256; t=1780315141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JprHh/XbtI/V9wDgjxBFhtCR/uh8ss4/EzyIpx5tzK9SPVFlPbeJfEiuyr62PiSKfdYAePojuN3lqPC4eOzSzJVxo2ye3f8fygrf0RvpDwRTzHJr39o3VCSOTSAj5iAed9aoYxBPJPb3S3/kUSwTFkXuEHApstq+7njIQsFCo0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780315141; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XbEGA7L2p2e0/hlLGLw57TXWHo7CW4uVg3VQtQttL2E=; 
	b=At9krcv8OC2FjknT+ax+VJq6NquoUigtHVOiQnoX0GYR+4TQj3Ag3yeUuPbtwSBPxjihQK637Sf8tfUb9DppXzMiKOV6sH3tqGtqJsrwHAjVPu5+UpQUbcfY+l2eSSLoxWSM5EkVp5ELd/Hs48AkDa2FI4c5ohJorFSpqsdeXwE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780315141;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-Id:Message-Id:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Reply-To;
	bh=XbEGA7L2p2e0/hlLGLw57TXWHo7CW4uVg3VQtQttL2E=;
	b=kZONnGILKPFlOispVfwq2LI+I7R5PQH0wuLtZBMWG5aScwUzw6ioyyY0lmT744ST
	FqmMveNRZKTJXX7EhmPZccYmZMRfvPINCpCnv+iuFa6P1xkzwb2hVQmFJeB1g6y/Lc8
	5duYb+SWwfUU0i/khWiyE+H7Z5srE4Tlk9adurkc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 178031514033720.465095556046435; Mon, 1 Jun 2026 04:59:00 -0700 (PDT)
Date: Mon, 01 Jun 2026 17:29:00 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>, "syzbot+55c2a5c871441261ed14"
 <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
Message-Id: <19e830d30d7.701114c6187254.5018026155515510877@mpiricsoftware.com>
In-Reply-To: <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
 <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
 <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com> <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_380467_158738163.1780315140312"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.300.36

------=_Part_380467_158738163.1780315140312
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

> do you mind sharing what you have so far. Maybe someone else can help
> you to reproduce the issue.

Attached is the WIP packetdrill test (server side, based on the existing
add_addr/mp_join server tests, with an extra MP_JOIN subflow). I have not
been able to reproduce the WARN with it yet, so please treat it as a
work-in-progress rather than a finished test -- the status and the open
question are written at the top of the file.

The trigger is "ip mptcp endpoint delete id 0 <saddr>", which is the only
op that reaches mptcp_nl_remove_id_zero_address(). (flush is not usable: it
goes through mptcp_pm_flush_addrs_and_subflows(), which already calls
mptcp_pm_announced_remove(), so that path was never buggy.)

Where I am stuck is getting ADD_ADDR(id 0) announced in the first place.
The signal endpoint on the MPC address has its id bit cleared by
mptcp_mpc_endpoint_setup(), so it is not announced on connect. "delete id 0=
"
frees the bit again, but I could not confirm that the PM worker re-runs and
announces id 0 on an otherwise idle connection. Without that announcement n=
o
pending anno_list entry is created, so the second "delete id 0" has nothing
stale to leave behind and the WARN does not trigger.

So my question: what is the minimal way to get the id-0 address actually
announced via packetdrill? Does this need the MP_JOIN subflow and/or a data
exchange to wake the PM worker between the operations, or is there a simple=
r
approach I am missing?

> I will wait for this test before applying the v3.

Understood, I will keep working on it. One thing I wanted to ask directly:
is a deterministic packetdrill test a hard requirement for applying v3, or
could the fix go in on the reasoning + the syzbot report alone? The change
only makes the id-0 removal path symmetric with the non-zero id path (tear
down the pending ADD_ADDR and decrement add_addr_signaled), so it is fairly
contained and independent of whether I can script a reliable trigger.

(Note: the anno-list helpers were renamed in current export, so v3 no longe=
r
applies as-is; I can send a trivially rebased v4 that swaps
mptcp_remove_anno_list_by_saddr() for mptcp_pm_announced_remove() if useful=
.)


Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "martineau"<martineau@kernel.org>, "pab=
eni"<pabeni@redhat.com>, "shardul.b"<shardul.b@mpiricsoftware.com>, "janak"=
<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>, "shardulsb08"<=
shardulsb08@gmail.com>, "syzbot+55c2a5c871441261ed14"<syzbot+55c2a5c8714412=
61ed14@syzkaller.appspotmail.com>
Date: Sun, 31 May 2026 12:09:53 +0530
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing =
id 0 endpoint

 > Hi Kalpan,
 >=20
 > On 29/05/2026 17:18, Kalpan Jani wrote:
 > > Hi Matt,
 > >=20
 > >> Did it work with packetdrill?
 > >=20
 > > I worked on a packetdrill test based on add_addr4_server.pkt with the
 > > MP_JOIN extra subflow and the delete/re-add sequence. The environment
 > > is working (add_addr4_server.pkt passes cleanly), but I was not able
 > > to reliably trigger the WARN through packetdrill within the test
 > > timeframe.
 > >=20
 > > The difficulty is that the id 0 ADD_ADDR is only sent when the
 > > endpoint is re-added after the connection is established AND after
 > > mptcp_nl_remove_id_zero_address() has run to restore the
 > > id_avail_bitmap bit via __mark_subflow_endp_available(). Getting
 > > packetdrill to control this timing precisely =E2=80=94 while also keep=
ing
 > > conn_list non-empty so mptcp_nl_remove_id_zero_address() actually
 > > processes the msk =E2=80=94 proved tricky.
 >=20
 > I understand it might be tricky, but do you mind sharing what you have
 > so far. Maybe someone else can help you to reproduce the issue. Also, it
 > might be enough to have a test that can reproduce the WARN not 100% of
 > the time, as long as it is not 0. I will wait for this test before
 > applying the v3.
 >=20
 > At least having something exercising new paths: here, having the new
 > call to mptcp_remove_anno_list_by_saddr() returning true.
 >=20
 > > syzbot is reproducing the bug reliably on current upstream (3 crashes
 > > between 2026/05/19 and 2026/05/22 on kernels including cca95436be15).
 > > The syzbot reproducer is the most reliable pre-fix evidence available.
 >=20
 > Because syzbot didn't manage to generate a reproducer, we cannot really
 > rely on syzbot to say that the bug is fixed. 3 crashes out of how many
 > thousands/millions attempts? :)
 >=20
 > > I will continue working on the packetdrill test and send it as a
 > > follow-up once I have a clean before/after result. For v3 I have
 > > addressed your comment shortening request.
 >=20
 > Thanks!
 >=20
 > Do not forget to wait ~1 day between submissions, otherwise it is even
 > harder for reviewers and various tools to follow the modifications and
 > discussions.
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20

------=_Part_380467_158738163.1780315140312
Content-Type: application/octet-stream; 
	name=add_addr_id0_readd_server_WIP.pkt
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 139996079403120390
Content-Disposition: attachment; filename=add_addr_id0_readd_server_WIP.pkt

// SPDX-License-Identifier: GPL-2.0
//
// ============================ STATUS: WIP ============================
// Work-in-progress reproducer for issue #620. It does NOT reproduce the
// WARN yet; sharing it per the suggestion to post what I have so far so
// others can help close the gap. Please do not treat it as a passing test.
//
// What it is meant to do: drive the in-kernel PM into reselecting address
// ID 0 while a previously announced ADD_ADDR(id 0) is still pending (echo
// withheld), which on an unfixed kernel leaves a stale anno_list entry and
// trips WARN_ON_ONCE() in mptcp_pm_announced_alloc().
//
// Where I am stuck: I have not been able to confirm that ADD_ADDR(id 0) is
// actually announced in this setup. The signal endpoint on the MPC address
// has its id bit cleared by mptcp_mpc_endpoint_setup(), so it is not
// announced on connect; "delete id 0" frees the bit again, but I am not sure
// the PM worker re-runs to announce id 0 on an otherwise idle connection.
// Without that announcement no pending entry is created and the WARN cannot
// trigger. The "> ..." kernel-reply lines below are therefore my best guess
// and are NOT calibrated against captured output (in particular the DSS
// data-ack values are placeholders).
//
// Open question: what is the minimal way to get the id-0 address announced
// via packetdrill -- is the MP_JOIN subflow and/or an interleaved data
// segment required to wake the PM worker between the operations?
//
// Reminder for anyone trying it: the trigger must be "endpoint delete id 0",
// NOT "flush". Only the delete-id-0 op reaches mptcp_nl_remove_id_zero_address();
// flush goes through mptcp_pm_flush_addrs_and_subflows(), which already calls
// mptcp_pm_announced_remove() and so was never buggy.
// =====================================================================
//
// Roles: packetdrill is the peer (caddr*); the kernel under test is local
// (saddr0 == $OPT_LOCAL_IP) and runs the in-kernel PM as the server.

--tolerance_usecs=750000
`../common/defaults.sh`

+0    `../common/multi-ep.sh -e 0`
+0    `sysctl -q net.mptcp.add_addr_timeout=0`

+0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
+0.0  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0.0  fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+0.0  fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+0    bind(3, ..., ...) = 0
+0    listen(3, 1) = 0

// ---- MPC connection on saddr0 ----
+0.1  <  addr[caddr0] > addr[saddr0]  S   0:0(0)       win 65535  <mss 1460, sackOK, TS val 4074410674 ecr 0, nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
+0    >                               S.  0:0(0) ack 1            <mss 1460, sackOK, TS val 4074410674 ecr 4074410674, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
+0.2  <                                .  1:1(0) ack 1 win 256    <nop, nop, TS val 4074410674 ecr 4074410674, mpcapable v1 flags[flag_h] key[ckey=2, skey]>
+0    accept(3, ..., ...) = 4

+0.0  <  addr[caddr0] > addr[saddr0]  P.  1:3(2)  ack 1  win 256  <nop, nop, TS val 4074418292 ecr 4074410674, mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 2, nop, nop>
+0.0  >                               .   1:1(0)   ack 3           <nop, nop, TS val 4074418293 ecr 4074418292, dss dack8=3 dll=0 nocs>

// ---- Extra subflow via MP_JOIN (likely needed to wake the PM worker) ----
+0.1  <  addr[caddr1] > addr[saddr0]  S   0:0(0)       win 65535  <mss 1460, sackOK, TS val 448955294 ecr 0, nop, wscale 8, mp_join_syn address_id=1 token=sha256_32(skey)>
+0    >                               S.  0:0(0) ack 1            <mss 1460, sackOK, TS val 448955294 ecr 448955294, nop, wscale 8, mp_join_syn_ack address_id=0 sender_hmac=auto>
+0.1  <                                .  1:1(0) ack 1 win 256    <nop, nop, TS val 448955294 ecr 448955294, mp_join_ack sender_hmac=auto>
+0    >                                .  1:1(0) ack 1            <nop, nop, TS val 448955294 ecr 448955294, dss dack8=3 nocs>

// ---- Signal endpoint on the local (MPC / ID 0) address ----
// mpc_endpoint_id is set and its id bit cleared, so NO ADD_ADDR is sent yet.
+0.1  `ip mptcp endpoint add $OPT_LOCAL_IP id 1 signal`

// ---- First "delete id 0": intended to free id 0 so the PM announces it ----
+0.3  `ip mptcp endpoint delete id 0 $OPT_LOCAL_IP`
// UNCALIBRATED expected RM_ADDR(id 0) ride-along (DSS dack value is a guess):
+0    >                                .  1:1(0) ack 1            <nop, nop, TS val 448955294 ecr 448955294, dss dack8=3 nocs, remove_address address_id=[0]>
// UNCALIBRATED: ADD_ADDR(id 0) -- this is the step I could not confirm fires:
+0.1  >                                .  1:1(0) ack 1            <nop, nop, TS val 448955294 ecr 448955294, add_address address_id=0 addr[saddr0] hmac=auto>

// Withhold the echo so the ADD_ADDR(id 0) entry would stay pending.

// ---- Second "delete id 0": THIS is the path the patch fixes ----
//   * unfixed: leaves the stale entry -> later re-announce hits the WARN;
//   * fixed:   mptcp_pm_announced_remove() returns true, entry freed,
//              add_addr_signaled decremented.
+0.2  `ip mptcp endpoint delete id 0 $OPT_LOCAL_IP`
// UNCALIBRATED expected RM_ADDR(id 0):
+0    >                                .  1:1(0) ack 1            <nop, nop, TS val 448955294 ecr 448955294, dss dack8=3 nocs, remove_address address_id=[0]>

// A 2nd signal endpoint lifts the signal cap so the PM can reselect id 0;
// on an unfixed kernel the reselect should hit the stale entry -> WARN.
+0.2  `ip mptcp endpoint add 192.168.0.2 id 2 signal`

------=_Part_380467_158738163.1780315140312--

