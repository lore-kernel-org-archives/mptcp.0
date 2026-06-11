Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366435675A
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209339; cv=pass; b=VIkIFXyhco4Qzl9S7Cxr26iy0dNjKj8D8CApokwfWxETdYnhM7rvgwoydj6mIuDoadsl0VxlDqxFj7XcyINUO/HGpKUPmU3PE4uERBfYZgUfFZMUbTfeKcEAbA24qDQvFHpdiIZp2NKLqzL55m79C0N0WaY3ilQXBY7DsP12Zm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209339; c=relaxed/simple;
	bh=zCrMsrTixrqND3VBChgTMQBuDDR6SIJkYaFnU0QbEAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3GFO+TBKnoUxUygtsa3EggNlAUpmbVfwJRThpygw8vU6jJCL0TNrcSP7o2g7TllFmQHBMWsVjV6rQviBNwJX8AvGjRbBLurFOfY6euulVpgAejP/oMRM4okpq41y6PrqeY9t2/UqIEvKlhPcEgWzINpSBIDeJ7n+TcOGNk26fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqFiHK7T; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqFiHK7T"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6deacafa8so893638a34.0
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 13:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781209337; cv=none;
        d=google.com; s=arc-20240605;
        b=JdaK8WriMbi1xsLFN3Je4UIs+Ts/GKESJeWht9o0Sb0DeT4ytkDnIc809F6tjIjvRz
         qqzf+HKMJyqUrEetYyiYyc0mTvsAR0C5UxHrgp4qPKdktCNs3QvH8XOBSuelClkQlHFs
         cJzvTkWbdQblUDt5v8V0UMiwzanBcj8iUeSbSF0XVSqIrcsBKGeljDbImXOxZCVJvA4Z
         tLeU7i+A3fpUZ8BrFSLv/olwuW2RaByAbbqgwATAmXfNoIFMmm3xDA8JLjRrQdV3DusE
         SkT71lEsh3tDPHT/UP+U6kZHi9pYzpXlK6IwmQHHvP0rUagPebH8yhBcULGDkd7RqBBt
         bd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LR9YVhm/y7UwOaN1njgcgonOyt7uAb3/AL0v7Fq2xzk=;
        fh=mNe8Cc+s+tjSdDSmhUasC2c5XSFgoh7a1VdCA0QO2RU=;
        b=DbrLCS1ohaXqDrcN6RtdWZGJIUzZaKvz7zzichxzI5wUraTu60t7oqHtXUm+R0a57+
         UitM7G5feL4p94MndNklOfbaVKD6Tg7/IrIlgL+WVNlq7C+6rOyy98JK2amnfVAmXPyg
         /DMdb5aLGZYkZkIGJIPqZMb7g8iuoTOhnIjZBW5jHOYtJ308dxCuZxgGawsqOUxKaj+7
         +nG32xuZLM7TNIaQLiFiyvE07TcNIchE3ti4WO5D2bz05nSb5z4GEKL46aAk+8pYXaRr
         sus/78BAf/x3mZYXFGLL5bhWMPZnp2T7BZhcLJoRop4rDvmCXyqWcW7UPLD5bzvQD8vP
         ZFkQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209337; x=1781814137; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR9YVhm/y7UwOaN1njgcgonOyt7uAb3/AL0v7Fq2xzk=;
        b=QqFiHK7TSKcsE0JC8sXd1N9ZsN9xwEmcvxFzrodwrrXzKaQ0jHmMFRxD59AvzrH/IA
         6SZd2M7vhkmYqHqLJxBMzSeZdTiplUd9hoe4vUEd1xl4zYg3VI39+MIi62698ymXrwzj
         o7FYJYhi55OFTS6nokBrkuAbK1ck+HgiWY20fP+JAiy27wEBNqCe1l+3Uz05PFKhhQNa
         Y2/d1zWbf5ms5Rd1KksSCjTmh5p8iV+dRBFgd5zJqRkQVu8cxTHfeWwVy6qHqDczRv8d
         O/uMhjNDkWml1gICDvdxHDkqNO2Cil7vX6ot3LEkY/LK0k4RYzjDeVRW4JzsORx2zB3B
         VV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209337; x=1781814137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LR9YVhm/y7UwOaN1njgcgonOyt7uAb3/AL0v7Fq2xzk=;
        b=LVruBBIG8DBsf3w6ZOXRYkbacfRWTdzUVFviZUSnMa2pB84Qey5+EJso0ysY5VuKCv
         laxYJ4LvZd/k3IAMdrjzovvVkvAwtDlNcx7bvj7XenZrW7yGF+obnEaeMEfNz1XBlskT
         hMwSk2zL0xaUMVGML669zINIKVSLNwVnyH40HHDcAPpIch5twPbVBpmXZb4xpaSyQ7ey
         r3jkT9fuwYR46jtoRPMp3m5oM/3Wv+E6uPy+7OPboAYbaNSEkt1zhb57bmSED29dZ7Ro
         vIjr/13jLBYoeKAVAKWG1v8ek7IQnPG/pvR+ySB5lv52ygNAHIHCJ2Y7Ymdjzntn4TDO
         I6pw==
X-Gm-Message-State: AOJu0YwPCmVLIP1rsMp8i3cyTVe5bfLngBLtPrXA75C1m1xp9Fu2mpHE
	eKMnfywT0BZh89bPaeTcP1U3TnB5dywx9NXmqwtYMGADY1M12FzAlEIxyNnP53VuSDki1gQTibe
	5Bmex0X+yIVckgbn6ZDre9rxlTdoZH0OAMELjvT8=
X-Gm-Gg: Acq92OFSA4mLae8fYIk0PMxkj4Df30UkM30DGTrLZE/TFfvA0GSfll7Hk/q4sN1fkpt
	26ABsEIaxULFI0Li1cqHpq3elKH6uFKc1yaIdosl6cOSoVdwItH/ptasKrR0ub5mCG+UfeNAyFE
	OgdB3iUH4sNnB2nRPQElFR4fUrhQOIqiU+oyBzdem3B+o0VrRX7c7yGiYGhpaJbPH9ft7hq5FOg
	bGTeZgu/5OlDbEo0WONkXIDPRjH2gqCtn896DuaspnvMNkKP+vg3vsIvZDdI7Z+dWMkmNQ11mP0
	Wck58CXPwMV6LDOToO7aYQhiQAW3ZzpGXNsXJA==
X-Received: by 2002:a05:6820:4b05:b0:69d:ecb9:4a2 with SMTP id
 006d021491bc7-69edb016375mr79778eaf.4.1781209336622; Thu, 11 Jun 2026
 13:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260531145955.322337-1-devnexen@gmail.com>
In-Reply-To: <20260531145955.322337-1-devnexen@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 11 Jun 2026 21:22:03 +0100
X-Gm-Features: AVVi8CcDJ8EOE2Rdhn2uk8wiXI2YVUWx-VCC2xABwrKVuSPql0QDyPh4g7S3NG4
Message-ID: <CA+XhMqzaF09MgEgEvPrE=eKv6kT_WcW_bCQSPSpuAA50KmgS5w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v11 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

The lone Medium (patch 2) is self-resolving =E2=80=94 sashiko itself notes
it's fixed by patch 3 within the same series:

  =E2=96=8E Propagating IP_RECVERR to subflows queues ICMP errors into
sk_error_queue, but MPTCP recvmsg() doesn't implement MSG_ERRQUEUE=E2=80=A6
Note: This regression is fixed later
  =E2=96=8E in the patch series by ("mptcp: support MSG_ERRQUEUE on the par=
ent
socket"), which splices and drains the subflow error queues.


So I think it is ok ?

Cheers.

On Sun, 31 May 2026 at 15:59, David Carlier <devnexen@gmail.com> wrote:
>
> This series lets MPTCP applications use poll(EPOLLERR) and
> recvmsg(MSG_ERRQUEUE) on the parent socket to drain TX timestamps,
> MSG_ZEROCOPY completion notifications and SO_EE_ORIGIN_LOCAL events
> through the standard inet ABI, the same way they would on a plain TCP
> socket. ICMP-derived errors stay on the subflow queue: the legacy
> RECVERR ABI cannot convey their per-subflow peer identity, and they
> are intended for a future MPTCP_RECERR channel.
>
> Patch 1 factors the existing inet_flags subflow-propagation hard-coded
> list into a mask, so subsequent patches can extend it without churn.
>
> Patch 2 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
> propagate to the subflows. The parent stores the bit so MPTCP-aware
> helpers can branch on it.
>
> Patch 3 splices subflow err-skbs onto the parent's sk_error_queue at
> error-report time. All forwarded events go through sock_queue_err_skb(),
> which re-homes skb->sk onto the parent and charges sk_rmem_alloc, so the
> parent's error queue stays bounded by sk_rcvbuf and is dropped under rmem
> pressure, matching tcp's tx-timestamp path and ip_icmp_error() /
> ipv6_icmp_error(). MPTCP never originates MSG_ZEROCOPY or OPT_ID
> tx-timestamp completions -- its data path copies into msk-owned pages and
> bypasses tcp_sendmsg_locked() -- so no subflow-relative ee_data sequence
> is ever forwarded. mptcp_recvmsg(MSG_ERRQUEUE) forwards directly to
> inet_recv_error(), and mptcp_poll() advertises EPOLLERR purely on the
> parent's sk_err / sk_error_queue, matching tcp_poll().
>
> Patch 4 is a selftest covering the propagation path.
>
> Changes in v11 (addresses sashiko v10 review,
> https://sashiko.dev/#/patchset/20260529174524.260199-1-devnexen@gmail.com=
):
>  - patch 3/4: route MSG_ZEROCOPY completions through sock_queue_err_skb()
>    like every other forwarded event, rather than orphaning them and
>    queueing to the parent by hand. The hand-rolled path ran the subflow
>    destructor (refunding its memory charge) but never charged the parent,
>    so completions could pile up unbounded on the parent err queue and
>    exhaust memory (OOM). The "never drop or we leak pinned pages" premise
>    was also wrong: __msg_zerocopy_callback() calls
>    mm_unaccount_pinned_pages() before queueing, so a dropped notification
>    loses only the notification, not the pages. (sashiko v10, High)
>  - no functional change for the ee_data concern: MPTCP originates neither
>    MSG_ZEROCOPY nor OPT_ID tx-timestamp completions, so no subflow-relati=
ve
>    sequence is ever spliced to the parent. (sashiko v10, High)
>  - patch 2/4: initialise val in mptcp_setsockopt_recverr() to silence a
>    latent -Wmaybe-uninitialized on the switch without a default case.
>
> v10: https://lore.kernel.org/mptcp/20260529174524.260199-1-devnexen@gmail=
.com/
> v9: https://lore.kernel.org/mptcp/20260528055459.55133-1-devnexen@gmail.c=
om/
>
> David Carlier (4):
>   mptcp: sockopt: factor inet_flags propagation into a mask
>   mptcp: propagate RECVERR sockopts to subflows
>   mptcp: support MSG_ERRQUEUE on the parent socket
>   selftests: mptcp: cover IP_RECVERR sockopt propagation
>
>  net/mptcp/protocol.c                          |  63 ++++++--
>  net/mptcp/sockopt.c                           | 153 +++++++++++++++---
>  .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
>  3 files changed, 237 insertions(+), 34 deletions(-)
>
>
> base-commit: e05cbdb611ff815528cdf90e29a96663b9af48c6
> --
> 2.53.0
>
