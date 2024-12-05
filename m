Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D0193064
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385295; cv=none; b=FVS84BaQ95mPzZEwmJJGvD1SgHaD8PSFXyURILLejfNLLTK5svUl0UJ9pfr1+irvq62Us2bRltsZ4yYyv/IUjoQiLVcGqFKsbqeh4OHiIzyi1pSRVFe3sep5wXk24nnNlDAFeFcpTxzG6bBNHsrbvPfPTwyIp3n2QpYTFC88FvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385295; c=relaxed/simple;
	bh=vx5+qBh850FNYmcGamqyfPmnZAHBfCD8QuI0kcDQPpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I01sMfZuJv0ZJZifWdZ1LLVriRrtmOUslzwFB0ZKcG6Lu+MdaEbvvngifZEBZ+ZZLhuqTF4cjYxY5Sva2Q/jI7wA2MWsOf6r0WFwbiarb7+MswbPY64BKXQF3IOcXBfb/NjQJr1p0Ymngedkaumgg/783Wkv6yMA/L4uGZwmo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpXeyYfn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpXeyYfn"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa55da18f89so85487266b.0
        for <mptcp@lists.linux.dev>; Wed, 04 Dec 2024 23:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733385292; x=1733990092; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoveC5NiFJebUr6H/XvuyS4HCl5gaDQMYyE2e5JSYo=;
        b=YpXeyYfnP85e/ascwc/C6lVSJuhsQpHI4NJoeB44EWB9niDDng5oihsXeeSHzXKFTe
         cyi/zLunrT0MJiciLD9K9cSD5kd9/t1xQAQ7bRpXDVDCmQ1iUiN5+v8Vv59zygGusEiM
         vPXycjVFwHSabGP2y21zvqVn6EbRoo7uRi5XJaj+jopnDqqE7yVQFx5UgxIVC9eoO/Nq
         omIao2eQW1Hu9Ik1Ll0ccGfW9toOAe0GXMdjL4+GjTgznj4zLsHdO7m++7RX3qAJ+266
         8DL9C6hRY0TCQqz+I8y//BWsbFBhMHEuDPO3KjrDxc/f8mXjmc91X2R5Fizb4AZRJIxz
         648A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733385292; x=1733990092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPoveC5NiFJebUr6H/XvuyS4HCl5gaDQMYyE2e5JSYo=;
        b=Vcm7E+7PjemdLKlG6R95beeP5iIGloKdCXNFu7d0NuGGWSeOnI+ZYrigTtUYYSRBl+
         f72dISYyz/nhzyIA7zr/gVbuB7VrGsnFxbhPxod4N56rovS5yBdGqFNY0kOUj4+99su/
         MJLs8yReW6OJlETFf/lSfSj0ma8Jtw586gfGGRNSWVIkE3eBJvaALVpHhk20znKEJcrR
         bZ3N7D/LusLUYKvQbKB5AXvRQ5ZuHb9sEeUN2rwnJm7T5lSKQ8znf3jOmD+zTYCC+9fa
         QYGs29ba0KK5IdG7IklEXIuJHRabwwbLLwAQB1Dz9WiLpXrzvjJ0bEeznbr4C5vmUPPR
         Q/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6nPiEIHyQKKj+5+PGBfXLkpzrmDY7HQbiVfDbXG+D/JQwhoQ/sodkgiRLExatGkG8gxi2iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYjzdZ3srZO5zMT9CIGbMBwhHZZhTpeTPAaKOyzToMnmastC0l
	is3vbtuvN4sp74bSnnF1JX9Er/uukAuT40IaAgib/WNpIzz8sEGBC00OKOb7SwHmDgJmtwDYJvL
	Pc/AyqLmF+mMIHU1ysYnHJVCMYqN4EzVaNuth
X-Gm-Gg: ASbGncsvGjr0UIC4tK/N/SKg4+uc0eGbkQ3ifX8DAJfbN+4YoqUKx4pjg0W0+EStNJ/
	ZRROOkOYvoooS5dpYmIkPMBmMWHjmFx8=
X-Google-Smtp-Source: AGHT+IEkMEJuQYoavObqjfF1Dm1ARxtTM3In+7tdetfMxymzqpHnS3ICi4gVSe4yccpc3ySQA05ZVBU8SNk46yxZksY=
X-Received: by 2002:a17:906:23f1:b0:aa5:639d:7cdb with SMTP id
 a640c23a62f3a-aa5f7d4ec79mr647034466b.22.1733385291482; Wed, 04 Dec 2024
 23:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204085801.11563-1-moyuanhao3676@163.com> <80b6603d-ed52-43b7-a434-0253e5de784a@kernel.org>
 <dcdeaf17-c3ce-4677-a0c0-c391d8bd951f@163.com>
In-Reply-To: <dcdeaf17-c3ce-4677-a0c0-c391d8bd951f@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Dec 2024 08:54:40 +0100
Message-ID: <CANn89iLjhnxkOY7p3zQsyupGowjMt0beWE3=WHTVC2NSM_-2hw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Check space before adding MPTCP options
To: Mo Yuanhao <moyuanhao3676@163.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:31=E2=80=AFAM Mo Yuanhao <moyuanhao3676@163.com> w=
rote:
>
> =E5=9C=A8 2024/12/4 19:01, Matthieu Baerts =E5=86=99=E9=81=93:
> > Hi MoYuanhao,
> >
> > +Cc MPTCP mailing list.
> >
> > (Please cc the MPTCP list next time)
> >
> > On 04/12/2024 09:58, MoYuanhao wrote:
> >> Ensure enough space before adding MPTCP options in tcp_syn_options()
> >> Added a check to verify sufficient remaining space
> >> before inserting MPTCP options in SYN packets.
> >> This prevents issues when space is insufficient.
> >
> > Thank you for this patch. I'm surprised we all missed this check, but
> > yes it is missing.
> >
> > As mentioned by Eric in his previous email, please add a 'Fixes' tag.
> > For bug-fixes, you should also Cc stable and target 'net', not 'net-nex=
t':
> >
> > Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing
> > connections")
> > Cc: stable@vger.kernel.org
> >
> >
> > Regarding the code, it looks OK to me, as we did exactly that with
> > mptcp_synack_options(). In mptcp_established_options(), we pass
> > 'remaining' because many MPTCP options can be set, but not here. So I
> > guess that's fine to keep the code like that, especially for the 'net' =
tree.
> >
> >
> > Also, and linked to Eric's email, did you have an issue with that, or i=
s
> > it to prevent issues in the future?
> >
> >
> > One last thing, please don=E2=80=99t repost your patches within one 24h=
 period, see:
> >
> >    https://docs.kernel.org/process/maintainer-netdev.html
> >
> >
> > Because the code is OK to me, and the same patch has already been sent
> > twice to the netdev ML within a few hours, I'm going to apply this patc=
h
> > in our MPTCP tree with the suggested modifications. Later on, we will
> > send it for inclusion in the net tree.
> >
> > pw-bot: awaiting-upstream
> >
> > (Not sure this pw-bot instruction will work as no net/mptcp/* files hav=
e
> > been modified)
> >
> > Cheers,
> > Matt
> Hi Matt,
>
> Thank you for your feedback!
>
> I have made the suggested updates to the patch (version 2):
>
> I=E2=80=99ve added the Fixes tag and Cc'd the stable@vger.kernel.org list=
.
> The target branch has been adjusted to net as per your suggestion.
> I will make sure to Cc the MPTCP list in future submissions.
>
> Regarding your question, this patch was created to prevent potential
> issues related to insufficient space for MPTCP options in the future. I
> didn't encounter a specific issue, but it seemed like a necessary
> safeguard to ensure robustness when handling SYN packets with MPTCP optio=
ns.
>
> Additionally, I have made further optimizations to the patch, which are
> included in the attached version. I believe it would be more elegant to
> introduce a new function, mptcp_set_option(), similar to
> mptcp_set_option_cond(), to handle MPTCP options.
>
> This is my first time replying to a message in a Linux mailing list, so
> if there are any formatting issues or mistakes, please point them out
> and I will make sure to correct them in future submissions.
>
> Thanks again for your review and suggestions. Looking forward to seeing
> the patch applied to the MPTCP tree and later inclusion in the net tree.

We usually do not refactor for a patch targeting a net tree.

Also, please do not add attachments, we need the patch inline as you did in=
 v1.

As you can see, v2 is not avail in
https://patchwork.kernel.org/project/netdevbpf/list/

Documentation/process/submitting-patches.rst

No MIME, no links, no compression, no attachments.  Just plain text
-------------------------------------------------------------------

Linus and other kernel developers need to be able to read and comment
on the changes you are submitting.  It is important for a kernel
developer to be able to "quote" your changes, using standard e-mail
tools, so that they may comment on specific portions of your code.

For this reason, all patches should be submitted by e-mail "inline". The
easiest way to do this is with ``git send-email``, which is strongly
recommended.  An interactive tutorial for ``git send-email`` is available a=
t
https://git-send-email.io.

If you choose not to use ``git send-email``:

.. warning::

  Be wary of your editor's word-wrap corrupting your patch,
  if you choose to cut-n-paste your patch.

Do not attach the patch as a MIME attachment, compressed or not.
Many popular e-mail applications will not always transmit a MIME
attachment as plain text, making it impossible to comment on your
code.  A MIME attachment also takes Linus a bit more time to process,
decreasing the likelihood of your MIME-attached change being accepted.
