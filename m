Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAF349CD3
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919944; cv=pass; b=MGDagyRbaYpqgUNPyBKryx7sPEMQuxZt5Qi6ziWvSTpSlyDEvTCBAUs+sgjjaHYCiC3Ynt2lh5cTcK6djjSQWeS0/upFssWfivEMKTmnFtiBMQFUXw8fPa4V7ZbJ1FGCHyMeLQgmPTnSV5j6F7yDNUiddR01/kAn9bHJUVh3fyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919944; c=relaxed/simple;
	bh=j6DXQFZPqoJxKT6AqBIKO6CcGnuuFezI7MlEPU5EqfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdMpBclVQLva7zX9R6WWy+JgTw4ZRONLj1Jh/pVX3R2c8ao7gE+RRnw+QedFcQSIfwyz5XU8aBs83hoVL4kmcE8lhb84n9VrhTuxrMv7Ow8kjeRn8J5aXb8vA+P+TXyvYfeERPTlPxMcWMDD/dOKO+v74PS2W3v+Jmb3izmc2e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNxuiD74; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNxuiD74"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52b4e988c77so3909521cf.3
        for <mptcp@lists.linux.dev>; Wed, 05 Aug 2026 01:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785919941; cv=none;
        d=google.com; s=arc-20260327;
        b=KvmPwU9k8U2i/a/DT4tYuz8b1UX1hZiVcx999NQjf137hNpDukCeLpp4tGl/0LdNjw
         1GzFJe8hRtks65BISG+REAg/P8a0Ckt8fdfxIvPepQViXJjpTOnZNXoaehfgst2vuEMc
         0ppAd9ld+BZpDS8kfGYWaEmGLIjAzlGwEe51xHPtGS5foP3/2lIQovKXXq1ltfLQOFyM
         ywS+z0EMZB3g43Dlqx00oqFLzHGUEzWloTVr+FM8phoTwxClM6gR9Ua+lf4utOjQkTNh
         dX5KoUggThGSUiZbXNq9nxJA+sKBffcSer7cefaPVVN7gaKKofmiTB316LDrss8kcE4+
         BdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        fh=3koLGs7Lbsm+2oOVupTCnbTdZoDNbTzM5qAbhQivJrY=;
        b=soGyn4GCVoSC1Eqic2UIIwOW8Z/S2mJdYuUZKj8Cou99v5OKv6Q1rlbpaNvpXUP40L
         S396JklU5KfK6WZ5s2Wthv5KPMgrR9vDPH+hxIrBfySGIiPRSRJ6IJ11hSXUmqjh4bx6
         ysizWU4/k8qVRVRqKCl4vj4rB2iFKZS0/zllOCXAU994BMl7udZyRwz8sl42hM5rMUCc
         gn3FvTIbkGJ06rwa/CGKtCtNx8lSDBsOdzwvKSDcJjLXR91FdL9Wf5hIUwuTyE0lL6sx
         wUHEy2sNf3B7rfGvJIyI60ypzJQ95NIO/UclX/tPGPN5380sTftsL3olDe49jq/VLhIz
         kqOw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785919941; x=1786524741; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        b=bNxuiD74iAnZlxmKBUW0RTag16tYkFt9DMQZbTb8ngxsaBehqh9i1eulmoR0lPT21w
         Nk2HYit5RFs8XJZFvE6GPkJBzUNmQ1JkfLXjvSQ3bg6PeJ9oT9dt5mAbUui/S+imhHep
         zKwulh78B+CAePmFydsux3LsvMPQbT8BSFYFmJNydgenZzWts9IWixxhCOTIGNBrCIbA
         Iyv946kucaDwHo9Aj0kA3N6cOlLj5ELzetzqcgG4izSJOcWgo6a62g4ToO7Qa3dYgxY0
         71kq28Tb24G8WpadwDFVD78oCPdJ1tQTGt+eTYWlOtvEm3rQX5mPsEf3Yzvdts40xT11
         1RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919941; x=1786524741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        b=N/H9LZdTvznDsuRje65J8NTOikZ0tjt3rNdWqPjw0nltDrLxKaim8Ra/fxl60dscBO
         oiDwP5lTP2w/hiaB1RwQTXAHWKltz4IAhAh/yHNjp66I9IahcEMlmS7UGzpMoydCx1AS
         ceJbHBoC9fdmJytPL1ObAagF3f/0aa4trwcwUJcHg86Dkdq6b5mzgavdCLRcZsoZRPhs
         MIdN6Nq172N2rXirYb6DpmsHd5bBpPi4YX/+gxJ7lGQBHF9T0txPdJ0HKcENXjwfC1y8
         aGqe8RKFYRy9lShqwaKuvfBh20p4bpKvTze5+8g6G2BlFs8t8jOCxDzM1EDltu6vmhKi
         h2Rg==
X-Forwarded-Encrypted: i=1; AHgh+RroKZAoDDqywAyZRDv27G7n5CJF1ITTC0LKuaaVwaF7gBvnXGWE3zSSUWk91pFT42w7jOW/Tw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+rJOmYgpXDh9WmHnT/F2lBAMx8gpFoa56+JONZZdODlEnleoc
	U+jJP9GOv/OrdodiQafeRz2YSiQVdYBgVLyFx7ZwOAj/t9k4biJZdD/QRDUTpCDyY4ZkVBSR98p
	HEVwWFfQ690Egjyd64OzFJZyovxZ3GfU=
X-Gm-Gg: AR+sD13TRyEYk6H9HxBOXQoqQNuUKBpB6TfXn/nsDqevq2poxmFpeEcsp8Z9nXpqecF
	7S+tn+1IWlv7bHbZ30z7Oq9j6VOSkh9V3jySAxjuCNviLtqoh4KLZIoNdCcLoD8MxsdKdOoip6c
	UZhr45Wgu0xArxfSA2AZH61aL3VgauuGE4/jql5AfFks9rbRXOngB9txh5OIL3UTWzlKWL1qS5J
	Ifk/FgKiNcypDtACkHccU4dKI8IX2DZtn7v4FuGyCYlliEtnyOq/P6nY92pSBv/Dh+HNFqZMA2T
	CH85uOtNsWzri7VxOqCl3Tod4aD859eTZv7HCKlrC+k93LeUaaHKL8etcVA/KF7oA0Gjq0klMAx
	in+o=
X-Received: by 2002:a05:622a:1e12:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52ce5ff11acmr52330181cf.17.1785919941452; Wed, 05 Aug 2026
 01:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804095051.715355-1-david.lee@trailofbits.com> <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
In-Reply-To: <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Wed, 5 Aug 2026 01:52:10 -0700
X-Gm-Features: AUfX_mx8a4ogrmDGIJBdqb1hUA7WGigHW93m5FaPqnH_UvGOCPhqWGAgYlL8EvI
Message-ID: <CAPuPA7KZhv39w=nCG71WBLOcPRrrpb=CvDdVcnCRbfu+z9ZELg@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: hold msk reference when cloning request sockets
To: Matthieu Baerts <matttbe@kernel.org>, Kyle Zeng <kylebot@openai.com>, 
	David Lee <david.lee@trailofbits.com>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, geliang@kernel.org, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ren Wei <n05ec@lzu.edu.cn>, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com, 
	Vega <vega@nebusec.ai>, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:00=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi David, Kyle,
>
> (+cc Vega's people)
>
> On 04/08/2026 11:50, David Lee wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > An MP_JOIN request owns the reference stored in subflow_req->msk.
> > inet_reqsk_clone() byte-copies that pointer when migrating a request,
> > but does not acquire a reference for the clone.  The original and clone=
d
> > request destructors can consequently drop the same reference, leaving
> > one request with a dangling msk pointer.
> >
> > Let cloned MPTCP requests take their own msk reference.  The source
> > request still owns its reference while it is being cloned, so sock_hold=
()
> > is safe.  The clone's normal destructor balances the new reference on
> > both successful and failed migration paths.
> >
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
>
> Thank you for this patch. It looks like it is similar to this one sent a
> few months ago, but where changes have been requested:
>
>   https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.177840=
4619.git.caoruide123@gmail.com
>
> Do you mind checking what they did, and explaining the different approach=
, please?
>
> It seems there are two issues the Vega's team tried to solve: one with
> MP_JOIN requests (what you are trying to fix here) and with MP_CAPABLE.
> For me, it is fine to split that in two patches. I also don't mind who
> is writing the final patch(es), as long as credits are given. If you,
> David/Kyle, are doing that, it might be OK to add a:
>
>   Reported-by: Vega <vega@nebusec.ai>
>   Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53=
f.1778404619.git.caoruide123@gmail.com
>
> @Vega's team: OK with that? Or are you actively working on a v3?

We seem to have lost track of this patch, and we sincerely apologize.

Our patch addresses two issues: one involving MP_JOIN requests and the
other involving MP_CAPABLE.

I reviewed Kyle and David=E2=80=99s fix for the MP_JOIN issue, and it looks
reasonable to me.

Ruide and I also do not have a preference regarding whose patch is accepted=
.

If David/Kyle' patch is accepted, please add:

Reported-by: Vega <vega@nebusec.ai>
Reported-by: Ruide Cao <caoruide123@gmail.com>
Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.17=
78404619.git.caoruide123@gmail.com

Btw, Kyle and David, would you be open to collaborating with us on
Linux kernel patches? Over the past few months, our team has fixed
more than 100 high-severity vulnerabilities in the kernel. We=E2=80=99ve
learned a great deal from maintainers=E2=80=99 feedback and have built up
extensive experience. We=E2=80=99d love to help improve kernel security whi=
le
minimizing the burden on maintainers as much as possible.

>
> One last thing: it looks like your patch is conflicting with this one:
>
>   https://lore.kernel.org/netdev/20260803061739.134737-1-jiayuan.chen@lin=
ux.dev/
>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Co-developed-by: David Lee <david.lee@trailofbits.com>
> > Signed-off-by: David Lee <david.lee@trailofbits.com>
> > ---
> > Bug found and triaged by OpenAI Security Research and
> > validated by Trail of Bits.
> >
> > Trail of Bits has a reproducer for this bug that triggers a
> > KASAN use-after-free and can share if needed.
>
> I think it would be good to include the (decoded) KASAN warning in the
> commit message. Regarding the reproducer, if it is with packetdrill, I
> think it is always useful to share it. For others, don't hesitate to
> share it to the same people: it can help better understanding the issue.
> Maybe remove the mailing list when doing that if it is security related?
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
