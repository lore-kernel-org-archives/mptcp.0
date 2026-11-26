Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725845;
	b=MN7TBIe8DFugsFZuFmz+xZ4ujsxYGushL7ecm+9iFkYdm9lBqTO24ytyREfms0RhrKAE
	 9NOT5YDnbTqUhkCwXXTMkiXMB+gHQcb3gw8uOZ65m0DrilAOEYi0wgwo3fnYozEkjJKuN
	 ldHT0UnyctZAytFEtlqGKm6nOQN+YYUF12mzNZFttlzoeTvJTsj2fGNZ01qR7rVqodpqq
	 h6suhiDp4MYyQPow1fYY3TNXs2MOiNrYzSR8PDJeIuttMC5N6I8vpQkDECuEIUdmqtnY/
	 abQzZJZ7TkFWJ7eoVm/cnmYI2TJMAP07ZT9+rce36foQRD0LODF0s0ZVihv2MwVkmmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725845;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vNx/uCXWwDvPhIzcpK0XfJ8D3OdzmfMVM7s7BULmDFM=;
	b=JW0eKT7fklyHuWH9iTeE0ERdtFxY2MDpUR9uFsGbhXlIiP0mjnnUnEADXDuQfOK/f8I9
	 uFAlLUA8QAlFmVMFonnqpzP79jlOGYAC2kVGyYwUlLmDDxwqb1x9UsarJx0wqspTtQ8kf
	 d9CDcCVPe+PnHDlo0c6YpetwGV6K5NvReU0lr8W7Q+joup0qTc2cc2UNj8GX6Sx5wBt5r
	 C+8WTslDKimSj5yNDaQeSfrfgxN4M6ZCop/k+rk3ZCbe0Fm4vJXypdud8jbshL8zQ4cdn
	 awOtnfcK+hfYYX5kLunTzCv1lrHebTmj5toL6pQjmSI5FXoPdVeQBcElDWbLvrHRLNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yx1ziD3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2E606A6AE
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yx1ziD3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596011F00893;
	Thu, 26 Nov 2026 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725844;
	bh=vNx/uCXWwDvPhIzcpK0XfJ8D3OdzmfMVM7s7BULmDFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yx1ziD3F0DOKMzrO84F7rNw/kK0cxkiLHMaBY9EQnpW1WXmjpqFN4gZQyP6guOD8i
	 emHy+omENKR6yQGK9vhv5E3D6pIrh4E7uVVBKWyDLFCTM86wU7AM3Rw6ZFTguSp84S
	 2L1a7x0Is5XANyKVdavLKTT42+vwtHuXWo4HtperSnheSM9jr/okw+4fawIEH64gL1
	 bWh7gFNOYuWRZs/EzQ+fTOk1ktTiruYRuE9+JekxlVEdACGotI+HPFOp8B3O8o95gl
	 XaTGVGoMVQj4wpaKcmS+BVO0u4HgrukkufH7kHp7OTGvZoiJSpdsPidsxHTobA0NsW
	 T/mZnrKpbC9Qw==
Subject:
 Re: [PATCH mptcp-next v9 5/7] Documentation: msg_zerocopy: add MPTCP support
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 20:44:03 +0000
Message-ID: <179572584387.3133.12939272108333770181@kernel.org>
In-Reply-To: <f3aa500269ed8fd0a8c219cf245e93682370ca1c.1795591278.git.tanggeliang@kylinos.cn>
References: <f3aa500269ed8fd0a8c219cf245e93682370ca1c.1795591278.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit "Documentation: msg_zerocopy: add MPTCP support" adds
  MPTCP to the protocol list in the Intro of…

--

Documentation: msg_zerocopy: add MPTCP support

This commit adds MPTCP to the list of protocols that support
MSG_ZEROCOPY in the Intro section of
Documentation/networking/msg_zerocopy.rst.

> diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
> index 78fb70e748b77..0b91beb2f5bea 100644
> --- a/Documentation/networking/msg_zerocopy.rst
> +++ b/Documentation/networking/msg_zerocopy.rst
> @@ -7,8 +7,8 @@ Intro
>  =====
>  
>  The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> -The feature is currently implemented for TCP, UDP and VSOCK (with
> -virtio transport) sockets.
> +The feature is currently implemented for TCP, MPTCP, UDP and VSOCK
> +(with virtio transport) sockets.

[Severity: Low]
Should the protocol-specific sections later in msg_zerocopy.rst also
mention MPTCP? After this change they still only name TCP/UDP and VSOCK.

The Notification Parsing section says:

    The level and type fields in the control data are protocol family
    specific, IP_RECVERR or IPV6_RECVERR (for TCP or UDP socket).
    For VSOCK socket, cmsg_level will be SOL_VSOCK and cmsg_type will be
    VSOCK_RECVERR.

MPTCP error queue reads go through inet_recv_error():

net/mptcp/protocol.c:mptcp_recvmsg() {
    ...
	if (unlikely(flags & MSG_ERRQUEUE))
		return inet_recv_error(sk, msg, len);
    ...
}

So MPTCP sockets also get IP_RECVERR/IPV6_RECVERR. The text doesn't say
so.

The Implementation/Loopback section has the same gap:

    For TCP and UDP:
    Data sent to local sockets can be queued indefinitely if the receive
    process does not read its socket. ...

    For VSOCK:
    Data path sent to local sockets is the same as for non-local sockets.

MPTCP subflows are TCP, so the TCP deferred copy behaviour should
apply. The document doesn't say that MPTCP is covered there either.

Later patches in this series don't change msg_zerocopy.rst again.

Could these two sections be updated to include MPTCP alongside TCP?

>  
>  
>  Opportunity and Caveats

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795591278.git.tanggeliang%40kylinos.cn
