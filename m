Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47925392C39
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419242; cv=none; b=hfQLRE7XPX/+qabs4r0Nyc+PbEwVnVU2f4R0WuywtxtBXHGNcYIGagq6Dp4JE08nsppaMviPWov/+ybkG1p/mAWA25xqA8OaeGTzC9TMobYLGrsUZ/SqV0jukzQsMVA4FmjKQx/gqORkTYpvmrQDPzBLFOCU4VP05tJFnI3L7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419242; c=relaxed/simple;
	bh=A66lK2xgR6dgfhgpP3WmxHBoNqb2x57ZYFpl0mrYpDs=;
	h=Content-Type:References:To:Cc:Date:In-Reply-To:From:Message-Id:
	 Subject:Mime-Version; b=J6o/eFyp/qtM7AYVitRMabh5ubcm/1yVKxg5clavfyAMDhAxEkb9iL8S96jojxn5bmdIphmVn3QRZ7bl6vUk1s8bF419lC/xmkVeMtnxBmi6jKrsUb3nEIm6KIr0WBYAPS0D0dYNxOLmWgHhnHrGUxy4Ai2nqDg8ePfA3HrO9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=bCYV5bVb; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="bCYV5bVb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788419234; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2QefUN6DKjkvMaj8sGNZPNqaHqeihTj8Tk74loUgYs8=;
 b=bCYV5bVbvtChYjw+quUYde9aVA4D3ExGS+h4bxh+0xhgI8wjUosP5VK+tPwu7Z6eL9gTCa
 HSDDfIYJ72KQ8s00hJaJTnhMbpA3I165i0rxlH2zS93Qdn7DgIhcI3lhDsyMJAwRtYZqV6
 lsxDJxbopuPa9aN7X03RiEXrzQ2SpTOmjkQuZoVQcA3pWhbRMYNKh1/yt5pvwYGRCkGWHW
 fAllngcQs9F+W8mrM7mqREOEmcrzSLvgO5UYtHF5TXMivh7W5sAsg/H9ivWtjnxNXVc0QV
 2V7xu465EToE8YuzctTIWYGdwFsd9iLzI/conTOhSJZunmo2WTHKbbrZuZEWjw==
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Thu, 03 Sep 2026 15:07:12 +0800
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=UTF-8
References: 
X-Mailer: git-send-email 2.34.1
To: "Matthieu Baerts" <matttbe@kernel.org>, 
	"Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: "Mat Martineau" <martineau@kernel.org>, <netdev@vger.kernel.org>, 
	<mptcp@lists.linux.dev>
Date: Thu,  3 Sep 2026 15:06:49 +0800
X-Lms-Return-Path: <lba+26a991ca0+5cfeaa+lists.linux.dev+yilinzhang@moonshot.ai>
In-Reply-To: <c4d4d8c-34af-4ea8-ace8-e10e547d6744@kernel.org>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Message-Id: <20260903070649.3965366-1-yilinzhang@moonshot.ai>
Subject: Re: [PATCH] tcp: fastopen: check rsk_drop_req() in tcp_fastopen_create_child()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Here is a packetdrill reproducer for the MPTCP subflow/TFO issue.

It first obtains a TFO cookie and the server key during an MP_CAPABLE
handshake, then sends an MP_JOIN SYN from a new source port with the
corresponding token and cookie. The final ACK is intentionally omitted.

With the fix, the request remains in the SYN queue: the MPTCP reset is
followed by a normal SYN/ACK that echoes the cookie, and the second
accept() returns EAGAIN. Without the fix, tcp_fastopen_create_child()
ignores drop_req=true after subflow_syn_recv_sock() destroys the cloned
child. The TFO path queues that child instead; the SYN/ACK omits the
cookie, and closing the listener reports a refcount/use-after-free
warning.

-- >8 -- gtests/net/mptcp/fastopen/server-tfo-mpjoin-syn_v4.pkt -- >8 --

// Regression test: an MP_JOIN SYN with a valid TFO cookie must not queue
// a destroyed child.
--tolerance_usecs=100000
`../common/defaults.sh`

// MPTCP listener with server-side Fast Open enabled.
+0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
+0.0  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0.0  setsockopt(3, SOL_TCP, TCP_FASTOPEN, [2], 4) = 0
+0.0  fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+0.0  fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+0.0  bind(3, ..., ...) = 0
+0.0  listen(3, 1) = 0

// Obtain a TFO cookie and learn the server key.
+0.1  <  S   0:0(0)         win 65535  <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, FO,            nop, nop, mpcapable v1 flags[flag_h] nokey>
+0.0  >  S.  0:0(0)  ack 1             <mss 1460, nop, nop, sackOK,           nop, wscale 8, FO TFO_COOKIE, nop, nop, mpcapable v1 flags[flag_h] key[skey]>
+0.2  <  .   1:1(0)  ack 1     win 450  <                                                                              mpcapable v1 flags[flag_h] key[ckey=2, skey]>
+0.0  accept(3, ..., ...) = 4

// Use a new source port with the same address; the cookie remains valid.
+0.1  <  192.0.2.1:15000 > 192.168.0.1:8080  S  0:0(0)  win 65535  <mss 1460, sackOK, nop, wscale 8, FO TFO_COOKIE, nop, nop, mp_join_syn address_id=1 token=sha256_32(skey), nop, nop>
// The fatal MPTCP fallback destroys the cloned child and resets the flow.
+0.0  >  192.168.0.1:8080 > 192.0.2.1:15000  R.  0:0(0)  ack 1  <mp_reset 1>
// Normal SYN processing sends a SYN/ACK and echoes the TFO cookie.
+0.0  >  192.168.0.1:8080 > 192.0.2.1:15000  S.  0:0(0)  ack 1  <mss 1460, nop, nop, sackOK, nop, wscale 8, FO TFO_COOKIE, nop, nop, mp_join_syn_ack address_id=0 sender_hmac=auto>

// Without the final ACK, the request must remain in the SYN queue.
+0.2  accept(3, ..., ...) = -1 EAGAIN (Resource temporarily unavailable)

-- >8 --

For the MPTCP packetdrill fork, save this as
`gtests/net/mptcp/fastopen/server-tfo-mpjoin-syn_v4.pkt` and run it with
that fork's packetdrill binary.

Tested on Linux 7.3.0-rc1 (defconfig + MPTCP + KASAN, QEMU guest): the
unpatched kernel sends a SYN/ACK without the TFO cookie and reports
`refcount_t: underflow; use-after-free` when the listener closes; the
fixed kernel passes, with the second `accept()` returning EAGAIN.
