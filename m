Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83B231836
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791789; cv=pass; b=G1JOCMgRofUWKwnJhkgkFjBtYLJW9uhBPVuZxO/gZESe+MW3u9dmHpLDLxO5fXNFLwqBBNOty2wMlzNW7lzMWOPjH5kok3ucDMKh5AIG2V5i465DNO+5as8q0tLvPn37I7pwpPnhaYyYYz6XAKVkc4XxX3I/NicrS/gBX+cuVBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791789; c=relaxed/simple;
	bh=2CBZ1Rqc23Qaydu6GW+vtGWePFnNGnpAokO03IopENg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHIndnxHIrhVKQwZkh8sLwzcnkdyE5SEshqT8/bG1feeakXrrn+wp5VXrhvuM6d4hC5IjmG4xf1YXYRIPZCB9TCTEcwkjtY+s5DiOSyZjk+JVwHhWlXNGkXtFHQ2gEV/icqzdPm9DZk8o+ZpbCB5ae4fsBBworVABBHo4pJU9LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+KFolCU; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+KFolCU"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4645dde00a7so3996765b6e.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 10:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776791787; cv=none;
        d=google.com; s=arc-20240605;
        b=LHvxmotId5JmdN8ZV2GgkePNKPg5u9EWku1vvgIb0Tbuz5lThyg8is4jNDGVJWZoU5
         DSISy68E4gavE+zZsDoG7OSypgfaFYG7engrA5FVbpUtwyXoQcsLTqArCKG97gpTBq4r
         h8nisuZy0Ambpzw7ZTaxuNW2gQ7Q+jdqG/g8bOC5joahyRM4UTvdH/OuvKkB/kfKXi7W
         ITUckXhNGKt8R/I0LaQK2Lo9nnO9ugQma3oghg/Kcnp6n0e4taVXjN38s/KuKy8uBRru
         uckgFSSs0Qc1d/tmpkWXskkm8TPzFZ6foS8vW3UQeFEQY0tV3S+9bAtvoCwrBdE/+0r+
         27IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fzd73w16DcPSlyS3AsXsVnxBJzGmztdTG3B2VSdjWsU=;
        fh=pK07Gasv5lYnZ90eHyBCWVOQqaL1u0BUzDlvoYI4bdk=;
        b=ULCQ+VGmZzCN1LIGsFUB8ZCAKmXoXfEy38bZSk6eXIb6dVdcgMiY8dCY3HKe/tfR8M
         0d9kS0TYGe4A5fiPHvxpKauxn/gI6Bwg0Vsq40bI82YGLZvOomt7GLImk1Saz0q/VKCc
         oCapISf507OmaNf+zLLyso9kMK9uoSL37OFDKq3xIQPK6Qoa3ASen/et+tiogXcUsVfV
         MULIS04KkTRHo0nFkRQrdRRCQ+e1XaYKcHmIwOHwtMjNuC9l/hsps+CZ2W0erDeX6qyt
         PCbfW+251qRlk5RHW+NU7O18H+q8jvt9tYzuil+U4U+hkh68fJnrP/NusDf+LhG94e0p
         4RPw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791787; x=1777396587; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzd73w16DcPSlyS3AsXsVnxBJzGmztdTG3B2VSdjWsU=;
        b=R+KFolCU3OZ5pykXESjXNRUFf8M2NK+9cL2T8gWqmVJBG/ReFDw/PzlvUs16vXsCb0
         oNs7O6nG0N0YqedYSfInOv6VAvbTlB3Q6slnPqdNvBYZaaxgQpP9xDMwA1TjiD5FmOQQ
         +HQdg3wrcReHOEwFvRjvCgp5FDVWfqwcArEMva15h19HqXVId+8uA9ePXOQLPM9maOhh
         o7LGRRfL41UQlki91ObVHIto5I4JlpYxz2Mhd/IIDhxMwzsyFLHe1fCzztTF2PmV4Sti
         JxJpqq4kPU7nk/vhxUtZpNwgbd45BcplncLS3oRo10ltYWdioiuyrBLH+m7A8zJ1QV+p
         QxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791787; x=1777396587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzd73w16DcPSlyS3AsXsVnxBJzGmztdTG3B2VSdjWsU=;
        b=HHggLSOmB/SIJjISnIbEPH7SlTWVnm4sX+qMRvE9UUoTQ/GUVJ3wipErjKig7SN+6o
         X+kYZzZKzkaZu4t1M1DcYQp1+4SYg2RaTY6OidVolj4upQit6C1l9LfLgOXoJwKoAuZ2
         0CkwomM8pMIu3GR/Zx8gI6OyQvPfFYWpDNt+np8TBENnYjtoo15xBNgk+QPwbYKy8Bxx
         xMIWvo8NNWfTnUv8COIpcOoDR//uTzQAqrYlDurvaw4+MZNZzlMIbpf4E+8BYudgtNL8
         QZYtuIe6cV8HkQbcq6KPCXa4nkIpMSLpV/yJgJ+JeVTM+IIdbcxbIIQmxj5Y8CC9AnNA
         wW3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+aDP+KqX4pz+vSMIrmzXerymnmMZHnjvfx/QagoNfIYL1gkCq8iCGFJbhagcRih33NrRrItw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxC1gB0nZOLgYxYnRwP5dhofThdKdXe10qiD3CfNyTS02WsYPOB
	vcoVEZ5plgfAvIW0WlydvU5KFD2fPtN+uvqgeJs0Wuk3pl8Ag6OodKMP7HLM/xl6PJZPmbnI+GX
	S9AcXunTN6oX97TQ8g2MwQFdL/UpO0N0=
X-Gm-Gg: AeBDievVZmqs06YVo2Z48Q8XUnja3ixXAoVR4HnCyhtJF4mqo20BHjBwwsj6RMl9Eo/
	FntgZ78d01UVwDcuydR1ZIi//uMw348hHExmy9YNo7DP9akbU8haUNXzyREEFNRbgEUBbtu7Zvh
	16b6XgT9mw5QXLIeenDzBy8Z4rWHsmKIx4hJpPnWVRHiWNMawv7px1aZGwk412XNfPjoYZX3iSD
	0RgvcZwhKs2ovOjtCthckokcjMCAtPESuThoz+ZRsiBz2GtxDghsfdteT1O2YqRiiaXFunYywr3
	FtKNrrPNQhT+3QQ6e0/GLNuQFrQC6jwU9l6E9r43n3aEQeNStxhfnqqW02Q=
X-Received: by 2002:a05:6808:2f0c:b0:463:a42c:503a with SMTP id
 5614622812f47-4799bf4bd21mr8436947b6e.14.1776791787044; Tue, 21 Apr 2026
 10:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421152216.38127-1-devnexen@gmail.com> <e190409c-3dee-4de8-b1a0-7867213cb801@kernel.org>
In-Reply-To: <e190409c-3dee-4de8-b1a0-7867213cb801@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 21 Apr 2026 18:16:15 +0100
X-Gm-Features: AQROBzDqbD5N-Y5TdVq2TaKl4j8rp50eNk6JIIFOT2auU5qIfZqbTrQS8OuZX_k
Message-ID: <CA+XhMqxB7dw-wSiuBvJ6e-s2aoDA84MHeUGA3eHSZb4EHpzpfg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mptcp: add RECVERR and MSG_ERRQUEUE support
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, martineau@kernel.org, 
	geliang@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the head-up, cheers !

On Tue, 21 Apr 2026 at 17:07, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 21/04/2026 17:22, David Carlier wrote:
> > MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
> > parent socket does not currently provide usable MSG_ERRQUEUE handling.
> >
> > This series wires the MPTCP socket up to the IPv4/IPv6 error queue
> > paths. It propagates RECVERR-related sockopts to existing and future
> > subflows, makes poll() report pending errqueue activity through the
> > parent socket, and allows recvmsg(MSG_ERRQUEUE) on the MPTCP socket to
> > consume queued errors with the parent socket ABI.
> >
> > The series also handles mixed-family subflows by applying the matching
> > sockopt according to each subflow family, and avoids silently losing an
> > error skb if requeueing to the parent socket fails under rmem pressure.
> Thank you for this series!
>
> Even if I agree it would be good to have full MSG_ERRQUEUE support,
> net-next is currently closed, and only bug fixes are accepted, see:
>
>   https://docs.kernel.org/process/maintainer-netdev.html
>
> pw-bot: defer
>
> Instead, I suggest switching the discussions only to the MPTCP ML if
> that's OK. If the CI is happy, someone will try to review it over there,
> when time permits. If not, please send the new versions only to the
> MPTCP ML, with the 'PATCH mptcp-next' prefix, and ideally on top of the
> 'export' (or 'for-review') branch of our tree. For more details:
>
>   https://www.mptcp.dev/contributing.html#kernel-development
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
