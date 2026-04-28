Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741C24501D
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403756; cv=pass; b=dIqFuSMbtLDSyZVG6G4l3xVncBCLhN60498MLgzxD4hu616iwcAjGH6Fas/PbyFQo3g+iHTdD8IxW5ouXxBn2pjpRwLeksiiouTKBvLyFre2WNyE9j7QhKJnkozSv5yU11Op3waum0YuL988+QXnGgHVLqRO8q+k+D3Ce0Xg+os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403756; c=relaxed/simple;
	bh=TBRuca9JTg26505BMPOIV4RnsHVwXtbzPMHzwgnoCWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=memWM5YpiWhrQz8J15iUcwBGmJI5qcGbrhWJeuezMTv5Fbxl5eE0jbTP6bJwRPUYyQ/wg0ikB5z/XBn9DKGFf0Ml/CzEhBV55Yfj7vQuBq1Ly+2QKrJQwpg+gXqy87afbiBq6iX4+UyBEhKfJ4Iy+3Sy85sn789fIhaQYie/2x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNvQUwwE; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNvQUwwE"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479ef2b7979so5597493b6e.3
        for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 12:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777403754; cv=none;
        d=google.com; s=arc-20240605;
        b=cglJJyYjCGeVa0PIPZigo8dCAp0JzGWRRx1Nul3pMkRg/LeyGAXWQjrKHEn86aqj91
         SmKtKGIvFPO2bDnxwABPI4K1/Gdq77GTzacunH1e24EYiS2rYX8L9tR5J5iuxGk8IRrG
         yXYc79c0Z7FdCxhNWNvhl7Glj0kCl/pkJfFA/D6SYjL/yFVgIrDreVKepY4ZyMatGHY2
         hIyV1xdAAbHeN8oP4qY7T0zyRtWNC9JXI4Zmci6Q2Mx0R/JkoIJgPFxF+JBhTI5r4Xqd
         g5XovWxOlDIHCdaKyPySKE8KesRcnsoQNye4qhTx01evUbzE90Dq33iJkT4T2dt19xyU
         smaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TBRuca9JTg26505BMPOIV4RnsHVwXtbzPMHzwgnoCWg=;
        fh=3aq4rqqYDLX9E62ziLedLvZbHxOPygxBCZEI/Am5Y0o=;
        b=VBegWriddRasRAjxelbIPjc2pQ/RML9DDz2OrU99ai6nkEGEikiHHpODS6bxshwKvf
         eIdVCoOGjL5Tr47rxA8ZjM7IYn8v/emOJ1/lynps8BjyohW6+56kG+qKKQ69fZPVxfI6
         0w3BbSJcJSicOcJ6wKDeFBQAHiY9qfiNkxEJuLxxKGbdX6gePsx5brr4GUR+Q0KpaESO
         1lsfz6wZRCQquOfYbaMCM1A7CfA8zvpmTXFFwkXz7zdPJlF8pFl+zklol27Z3kn9F9li
         4mSLaSSohq8BKRUobk/563j6Fr9u3WUPi8FRp5FKKhDRvqcd7k7dT1mEYlcFtz3K0KIM
         rgGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777403754; x=1778008554; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TBRuca9JTg26505BMPOIV4RnsHVwXtbzPMHzwgnoCWg=;
        b=hNvQUwwEciOh+Iip2SVMNNx/VaXStggMNNjhFgVDRQiWJoy8SgJ7VChFEVCV1pMiq7
         R05nLvxSXU+lwvkTc+WXMcoqfBy4ab0nAeuYDTMwBV6oLkitQ14Q5K5Dno6DatHJIMWt
         1+whVPSTiCJ+ohCLL9EH8Ls9u6W7Icazu+v/TyMpZAiZnYofqQZqtzlCREJe4M/i6p9F
         lHk51+wPG750UUiW97y05HvZvmTgIOeZUFItpr5FE00PWoU00CD8Xqp23K0tYzhisPOw
         wDyp02Va35GQSku+H9XRMViTlT8dvHy88iLeWBshwYhpfYLwuFhedxeNgZSvumhnbM/6
         wkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777403754; x=1778008554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBRuca9JTg26505BMPOIV4RnsHVwXtbzPMHzwgnoCWg=;
        b=mRzYjcg+9aEZU6/VwQEc2fwGKC1fo95tdd/wTomqj60m1/6Huh68Io2xBP0hjWOBlq
         6THI4g3McTKJ4/7wRr2hKi4kDjZ2fFy5ZOCE8tQdiPwWMMVg4A2jh13+LtBYyNx6N0sM
         s5kwo4A1uQula+tyUxT6EVdx8TFIzjvfI+/7Doo9ZEX+pz0pLMLvP7dPYfp5BNHWxVD6
         E8cpLxRLuHJ5So530uoiLm/gGEtEehbl0r0ipM0ev8SLZSBqiIH3xyufHm81jHOnW+pj
         ya6qyGxC12yBKVNQoE3C/Z5QAKpE8rZ3Q5ywR86wjNBNBEOuzDPkt70/CXWTOR41ftum
         +MYA==
X-Gm-Message-State: AOJu0YxcG2aS06ujjzOcM++CsZOa5ySXFDPhXhwZgx4Doi2qd6qDTQtw
	Ht5u2Ahcv5L9Cf9fNp1St3GjJZj4pAskJJoPdeBR1C7en67+DAg2g1k+IpCZJsm2jCIrmDs2a0j
	TlGs80Qfoi83xuuD8NwxJvXiCkPiIR8M=
X-Gm-Gg: AeBDiesLED3/mGFzx5/ei96VkmKtjkGtMwymJKtk/TdEO913VPXL6iAMmdSY2nSkB1r
	Zc7wxKVW/6kj1P93Xh8WIbRjHuCSFh87pdWsoFWIXiHgP9bYkg0gJXvKHxp1F0o8UVNsyNuXnvW
	muQadAI7xuwFVtrnn/jK52KMYP69K2goRthOQ07V1XW7T4XILVPRVVA5IKHSQzj+QvtywlTiTkV
	HRpwRMqamC5ZBeTFUoqf7X7uLdzoX6mBGUG+MpFzg3sUUbhxxLgUHl++QdscZdLbX7iGWLA7FQs
	V6ojOWLXkxmH34v2ntR1cIKDk4R1QcEMzyrT7VjKQC58RVud
X-Received: by 2002:a05:6820:2112:b0:694:9e11:dd46 with SMTP id
 006d021491bc7-696684dfc4emr464291eaf.48.1777403753973; Tue, 28 Apr 2026
 12:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421223338.52743-1-devnexen@gmail.com> <cover.1777324037.git.devnexen@gmail.com>
 <43f69e5e-b0a5-4bc5-8e6b-8f41ef4cf55a@kernel.org> <59eccce4-cbc6-48b9-9243-9b9b5a5ca066@kernel.org>
In-Reply-To: <59eccce4-cbc6-48b9-9243-9b9b5a5ca066@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 28 Apr 2026 20:15:42 +0100
X-Gm-Features: AVHnY4Ic_sDSAdOTi20huh3i7yXiHYSAY4q9vwDlD209X8NdKKsv2ELhDJaIyD8
Message-ID: <CA+XhMqwnDRJJGiT2B-rqKSGKicS08m8q84uuSSUP60GJjfZXXQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

On Tue, 28 Apr 2026 at 19:56, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> On 28/04/2026 20:48, Matthieu Baerts wrote:
> > Hi David,
> >
> > Thank you for the new version.
> >
> > On 27/04/2026 23:10, David Carlier wrote:
> >> MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
> >> parent socket does not currently provide usable MSG_ERRQUEUE handling.
> >>
> >> This series wires the MPTCP socket up to the IPv4/IPv6 error queue
> >> paths. It propagates RECVERR-related sockopts to existing and future
> >> subflows, makes poll() report pending errqueue activity through the
> >> parent socket, and lets recvmsg(MSG_ERRQUEUE) on the MPTCP socket
> >> consume queued errors with the parent socket ABI.
> >>
> >> A new prerequisite patch factors the per-flag inet_flags propagation
> >> in sync_socket_options() into a single masked word copy, so further
> >> inet_flags propagated by MPTCP can be added by extending the mask
> >> rather than touching the call site.
> >>
> >> Patch 2 then leverages the existing mptcp_setsockopt_all_sf() helper
> >> for the setsockopt path and extends MPTCP_INET_FLAGS_MASK with the
> >> four RECVERR bits, dropping the family-specific helpers from v3.
> >>
> >> Based-on: <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
> >
> > I didn't review it, but I notice that the CI cannot apply your series,
> > because it looks like it is not based on the one you mentioned here.
> >
> > Can you either remove this line, or rebase your series on top of this
> > other patch?
> >
> > Also, please don't send your series as a reply to a previous posting,
> > please use a new thread. That's what is usually done, clearer, plus some
> > tools don't support replies.
>
> Note: I just manually resolved the conflicts and sent the series to the
> CI, not to have to resend a series just to retrigger the CI.

appreciated. Cheers.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
