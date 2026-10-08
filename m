Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB22FD69E
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470400; cv=pass; b=hLjh8iFVg1Il9uF78W5XXbYevCaac109qryBh+DyHyNfgaD+yoTl4V0us1SMGMB3iNskKOShb64459l0nYqtmhUB19yWawbrgDxxr35kBaIVHXTtazNXtm0p5fgQ8k3z+fp6jBUZVhNp2BgD2VlhqSnhFfwZCDAN+LPV/Lckqjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470400; c=relaxed/simple;
	bh=tZBa6wkn/LY3vBCMZ72o78okiMNPKNohsRa4re2REs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTmt/JVXKAqCCnYwiBmKa34M1qpf7KoAXobN73pJe3351ZFOizLoQK4HDBatM2AsovbFrKfKV0o+gRHmL8EfH+m+Pgj5uixojH6UPvufo3ZhHgZjgY4+uDnS15iDRAlp4Bp63CF27ElkMOy5QA1roaeaVUi8yPGYRSIPiR8cYHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish; spf=pass smtp.mailfrom=ink.fish; dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b=k9uE32+0; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ink.fish
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b="k9uE32+0"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso4922587a12.2
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 07:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791470397; cv=none;
        d=google.com; s=arc-20260327;
        b=EYGX6gsHjmF2RYs4uyR/k3FaDEzdLi28XDnGcvF+iqydXbE6iPn5cpZts4q0MmbUkJ
         PONkUXKvKUoTLTgQzCaoqVbMoUJr8fuWhzBT0sVJdUZopZh82M5Sb1sQpVuQ5Ov5vJ3G
         WNDqgGB8MruQqHsfOOZ71UxaYww9urQq8mO842cHplU/n8i8tvq2ZBWWHdSjc7vRHmX+
         DnvgJEayctVAQmhRKZV3YOOHeG4Fjng/VVX9lnjEZMY/LLU4ezwanB87OFsQNkFy1YFu
         89Wg+ZABCk+th9Aa1lHJkanrEBGtxZxed/z8c/0S+V9zkXxK9/UZjtbCD2ffyJfODj7N
         gSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O2oHKKMhz/JwwkaBSlD/liG9+hmeACRG6m7hQzsSMtM=;
        fh=Ov9cDZi84CBzUmehYAs6c16A/3xKHI/jRorTU2PDDQ8=;
        b=PrsfDPebZ+OWnlAK79FeQk4vo9Ktu+R0+cr/7MsuQL/ByhIlxiR4hT9czKKkOQwfOH
         BdYMAsPOCmPvQPlRA0umD8dIPqkbfK6/aByvD717RDkIZKKvFAuhYGuhnIEsSVdRsbJh
         hVdtPE4mlFqtHgm7YYZbLds3Isi7YSHVpfq+DBnLyLz3mYkhucLyoQUFMU05S3t6DCYc
         BeNwucU1FGmHFQvn4UAtj1wVpCm5HJQCeIrvgWqvbunwp4GseutxWVYxdf1VkJ8/3u8j
         cT2LxNPmSlCrRrAhZwbZ//KC3PcBWqR5Et8b5q3rnk5/bWTH71+5baNlpL4BOB6nZgw1
         tanw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ink.fish; s=google; t=1791470397; x=1792075197; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O2oHKKMhz/JwwkaBSlD/liG9+hmeACRG6m7hQzsSMtM=;
        b=k9uE32+0NMqe1MhJn+njtC0b42+gK1MZrBwxJuQE6e+BuB6Lv8Aw0VPVn2PoS9RJvi
         peC897mQlYRyyzzz6kZcJyv3E5Td1+qen2X0gR38IgRPlwiJRQiPd0kXD2oQsBlcu/qj
         4HhLbXssjn7+fLsEzR71Un81m31Kjz6D0G0mwJycADy0o6cPwhGGVNHY9sH0nNT+oITH
         XEk4+uC8Bdr9YIZjCo4aiW+XINtrHy5j1+PTOL9jO2pGJf4f09HXxe4u5AHp/4YQAmz2
         P3NL5MjZ+RdC3Pap71VSaOaTLHns6PYjsMe2K4dUH2tynhD3YlXu/kpnnH6qmE9iRjJk
         iaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791470397; x=1792075197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2oHKKMhz/JwwkaBSlD/liG9+hmeACRG6m7hQzsSMtM=;
        b=nFPHPWyak24VFoHGyXVcGgARIbNJVkWQLcMWVGZ006pchPrJWhMYJjUB+DOFpFiBFM
         m2t1Z/vOXu+UPmC6e2N0AfkbcwlzTpIqcAdQ0g0kVnXY3lrIkaNKBsJUFiNCDTSBFQDT
         JiEiukA2ncwpx5VjiYIxqU790n2e+l3QsuMW6+zv5Mc/PTQJa7LkEtC4kJ25QnxaWCVv
         nPwo4FEeVk7fk2IScVnpbDQ784EgFngO+v3KfpHHIQborNtl2dGCBPO5QUUrck9X4XgH
         FHOO/ednHXifqyuur+W0nK9w115bQnSl1//Cwry+XISIai79L6Hvu11VjY4rvWQOx9vD
         SreQ==
X-Forwarded-Encrypted: i=1; AKwUvByQZ3FZysc1hwH14nGZNnwF5bVaHbEFAhCdhWtJRWl6q/Lcp3ulQCdDXfdNp2ofp2YYx5ijOA==@lists.linux.dev
X-Gm-Message-State: AFq9FYICGc18RHWVg+2gW8/XAd20Ft+GEXDhwH0n6i9MmydFhhUlviAc
	mphN5pLJFoi3tleGPrukFAFbGr+AXf5FussE4C8N1hQpd24P4pxF0hJNsoGOMIymXfDwwbqn2cA
	kRdyIARrTVqSaM5wc6P2BhR+Ogfq9d1W8YQw4QXNeEQ==
X-Gm-Gg: AYBFou1msgDOWqZD501dlCZc0CVtEMhMAeAlZ2B0AhqdV3Q6KcCQCgORsfHGcSGN7PG
	3UYcVmWdxactfUnBPazYNDU3Lg9VLyBsRXcOsEHRcT2lXCXX03PwJwkob8BufZtK956z9G/d0Zt
	SYmiHoBU3iWFbnN3Dl0tw6VdFP/njOx6UzXH7MwnxU8muRZQ5f2sVXQ0R2E2v5uOvocBsHE86cN
	892TYn4uqu0DSzgJTwzZYVO1Vxvaw6U/9WTdzqSPerzHHqB9aI807iH5vhelqWGSAElfKYnCrW+
	057qda+hIsE7xt8g7CvYM1AIav8TsbGagg8QXxoKX35qKvlP3+cAYmU6aYY2PbyVBjDN8CWD5hd
	4+D7OkYt/Md6hdYbLrAudTQvoNvGpHI51YiyeUk/BUfZHAzLV1bpXSJxw6HCU1PDlz8o6/uJSJg
	==
X-Received: by 2002:a05:6402:440a:b0:6ab:223:f7f1 with SMTP id
 4fb4d7f45d1cf-6aff391242emr5241369a12.17.1791470396699; Thu, 08 Oct 2026
 07:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
 <a6269e21-a506-4607-b39a-3b4d2e4cccf6@kernel.org> <PN0PR01MB9382C18780E137E3013A097CF4932@PN0PR01MB9382.INDPRD01.PROD.OUTLOOK.COM>
 <a1ed275c-d455-480c-b12c-d44eeedbed65@kernel.org>
In-Reply-To: <a1ed275c-d455-480c-b12c-d44eeedbed65@kernel.org>
From: Petar Sakic <petar.sakic@ink.fish>
Date: Thu, 8 Oct 2026 16:39:45 +0200
X-Gm-Features: AclHuK_va4cIEVs9Kbc3e0ryAk_3Lx9jOTbqgiTfnGk2an-nKpktc4bKUvw1Vao
Message-ID: <CAFPPu1hphgMCQWxUUENR=2+VfE++PG7eW-EeBd1cy8qyPHsDqA@mail.gmail.com>
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
To: Matthieu Baerts <matttbe@kernel.org>
Cc: T S Rameshkumar <Rameshkumar.t@phytecembedded.in>, MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

> @Petar: are you working with T S? Because if you suggested the patch, we
> should at least add a "Suggested-by" tag. Is it OK with the
> attributions?

No, I'm not working with T S. I don't know him; he picked up my report
from the list.

Suggested-by is fine with me, and so is T S carrying the patch. I'm not
a kernel developer, so I'm glad someone who can do the formal
submission and the packetdrill test is taking it on.

> (Next time, please send a formal patch to avoid any conflicts here ;))

Understood, will do.

For context: we hit this with xray Shadowsocks-2022 proxies over MPTCP.
The client puts the whole request in the first write, so small requests
ride the SYN, and replies from targets close to the server hang. We
reproduced it in network namespaces at ~120 ms RTT, and the single
options.c hunk fixed 30/30 requests on 6.12.111. Happy to run our
reproducer against v6 when it is posted.

Thanks,
Petar

On Thu, Oct 8, 2026 at 3:31=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> On 08/10/2026 15:06, T S Rameshkumar wrote:
> > Thank you for the detailed feedback and guidance on the workflow!
> > I apologize for sending revisions too quickly without giving enough tim=
e
> > for review and discussion. I will make sure to pace subsequent
> > submissions properly, base patches on top of the MPTCP "export" branch,
> > increment version tags (v2, v3, etc.), and include changelogs using b4.
>
> Thank you!
>
> Please keep the discussions on the ML (and reply in plain text, and no
> top-post [1]).
>
> [1] https://subspace.kernel.org/etiquette.html
>
> > Regarding your technical questions:
> >
> >  1.
> >     Clearing is_mptfo:
> >      1.
> >         You are completely right. An automated bot flagged a potential
> >         bitfield data race if is_mptfo were cleared concurrently.
> >         However, since check_fully_established() is only evaluated once
> >         upon receiving the MPC third-ACK, clearing is_mptfo is not
> >         needed at all. Since is_mptfo is only read after subflow
> >         creation, leaving it in the bitfield and uncleared (exactly as
> >         Petar drafted) is completely race-free and clean.
>
> Thanks!
>
> Please also send a regression test for this, ideally with Packetdrill:
>
>  https://lore.kernel.org/bfd64e10-7f1e-41f6-ad12-12f06c4d2880@kernel.org
>
> >  2.
> >     Attribution:
> >      1.
> >         I will definitely add "Suggested-by: Petar Sakic
> >         <petar.sakic@ink.fish>".
> >
> > I will wait for Petar's response and any further review comments before
> > submitting v2 on top of the export branch.
>
> Sounds good to be. But it will be a "v6" then.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
