Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0D44C665
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514594; cv=pass; b=PWxeEui6COZ1pPseUDh4kqatu68/T7P8uB2YiJq61Sx7mD2RvKpQj8Mmxm+v8D0bdwaStx3aM2oXeigiDRuDGfdRgv5fkndOZEnuYsCKVH7Xl/vHZgnpA1LqPPfnCnF1O+fr3GnzblELdc5efS68iH1UabiwHs/zkBeBHNO0PjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514594; c=relaxed/simple;
	bh=p64fzSUlfym1iQyNdY45ANhgP8w9MUHklALvtWS2kbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iy18gnDG1zk2sYzpaoFagvRZZ2VRmRQTODzr+jo4jGOoV9sgJKA6YZSa2BrgR0bUjEbm0XLo+l6/YZmmXhFabhbeFxAYnrICVk4qivp51lBeeQK7/7Ve97CxDVXmHQcRGdN5HmGiASWmdn67sE5BS12cxULw1KmDkvARdCR/8HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=o5bZJQ5D; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="o5bZJQ5D"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so696739a12.2
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 02:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514592; cv=none;
        d=google.com; s=arc-20260327;
        b=KhKcAGuYoYIXIdSfDgpWEkYDbzVUJCyGXTEGC4bdj3UMXx1MEGTyBxwoPicwY1HIZJ
         O0jLBmJH4r1eOdJ3Qjs9PerFylPvDDEfijW2ETarMH3G/rjfiuJg0IKhKDDywJeZfhvs
         nH40ZuikPCgCk4SdTPyAGz6rMGzdDSo5cIbpPbf3FH0ffKsryMAClalaRivEya3RaET0
         LlNtxc2sPVDQuT2Ote60wgSJ6NfZ8lcKxastLTGdLilZWZm2SSQb+1Dku6TaA7kOATJN
         bOWNcyeK91BgsEt/GBDaY9og47QaQouJqaqkKl+gGucP/3heMjIKEPhwdUiPmQ80mH4D
         BNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLFw34p5JVbfZtkd6Sw161TPVYuYb1zUP76oeIZ+TNc=;
        fh=CB5UpkY+O88awVVzOZ6u9gwGodJr4E7oL8gDALqWdIs=;
        b=c+ltdXXSsFHpL3PV8yXd7z7EDqkAzje5joyyiNZAV48yrfa5fy+zqNFuIQ1hL2WW89
         IhXnm2SuQn5wmiHNu8+Hb1qpLJO6y5+EYTT9ojTSK/tMUkKwpdNXPDalI4BUykVsn2iP
         zlligm+F/hBddpKtnKdKOVmDC8v/h4YtyiZABA1grKFDHrYahtq7BgGVwMwBdZJx4ul1
         zbU4st3seA+C4f+OldrK2F2rIsTvv2R+iLVZ4LuW53ghw3xBwrNV8MVwg0t0b575BbYe
         kNdt54NOQcvU2u20Lb9h/gY4pUudHGrPNlrvw5sa1gn9HXfL0f4pZsl0gbZj4z4mMd+P
         1XBg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788514592; x=1789119392; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLFw34p5JVbfZtkd6Sw161TPVYuYb1zUP76oeIZ+TNc=;
        b=o5bZJQ5DDl9bJt17BqGa1a8QYOQAX78fidOJdQQ+o+IY/mwCQuTRGkczFqlewsk8vq
         PmJkd4e51H1SO69Ru2u78uiMEQ+hh+rEcfkCLGXVaUOhw3nZU5OOrZCf5xLFGAlmPh+J
         NpPzrd8sl3qa5tz+1IjMlwSgUolDWCvvotdsW5O/BxTm6IGtFL04+Ub1G++QVkeS/psX
         Y73g3Moe77P4Q4g/DGzTTRiR3hWEcw84UST0wyBqIYYE/2af5ONIl6U2NrRKHV8Q8WWe
         8iDQRmgPCZa7tZbwSNa5eMw4hVMXPd34VLlpjhwsQrWad/c2fKqwa2XCN8H1sr5fVeBT
         adeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514592; x=1789119392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLFw34p5JVbfZtkd6Sw161TPVYuYb1zUP76oeIZ+TNc=;
        b=X42FtLTCh8JhU6cEzaWhoDifuekO6hihk/2guzgcPdXZCyjKeoOsHe2HM4LRUeRXPT
         JNhi4X4MhP2LS6nB7Dot5P0rYtGuBj6m1WotzLv069EDtbgzGLl/QIdlNdnuJaVsYBUr
         bEX9au7Bml056OexhING09LQSx3yzseOis0iSfP3iqAAFlS1TxyhTFKBgznHqnokTj/E
         uUte4XKOosEYT3jBjBAwz3/HKglTQrN/sTO7ffNzCJ2k/ce0T8wALeLLf4KueEsXk+wa
         VPugooWYFohdduyOqvoiYYa7sZfhpPsAz4YEB6WCam+FIky2biIh6JPOmi6fpOrHLXLA
         Yztw==
X-Gm-Message-State: AFuF++l7to3jnEgUP2ZkN7Pg4+gnmvRv7v6Eqi7rTI8dXwxVmTRGk8BG
	GWe1u1HPUVmywhYKV9VkcF2zvv2vOV5JVFsiU+zQZv47xSGsKCFNJT/ueN4YNt98ftRAfiQPIeo
	1MjDjLVBrSRzDJp+vMdcfgqzvwJqc0urrEUFVsN8NTkpcalGRD8E57YuVBvs=
X-Gm-Gg: AYBFou09gQnuw/eaMUJxrbFLQR2izFCf23TiqfstFIW6JLuCiyhC1P+JRcJnFaEoecj
	xiK+oMKSISxHWrVEmv0xdFpX9VKZxVOlehxpC9JRVojsLc+XHVTE1GizIhelio0Zu3ktlqIoofI
	PunxuFlsk96ynTYDhoe60YAnw9tN+Ae5u2VxjcrX/1nx7xqPqSgUqU5tjCnSWDMdShxLRFyX1ui
	GLVZ2T+CJAizbSWAdT1DpYMO9Lg0PXplHY/YqTefP/QrqJPyCXpoQXnDLvzybInguP+xkjBTifL
	bmfAlTAWXl1nHvuXAOzzBfNTAgq8uaOCWGUVrFOWZeRC
X-Received: by 2002:a05:6a20:1441:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3da39cffff0mr7836205637.3.1788514591664; Fri, 04 Sep 2026
 02:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788202924.git.caoruide123@gmail.com> <93dafd2c918b42d635b03e7d3d83f6f2cff49697.1788202924.git.caoruide123@gmail.com>
 <20260902103402.9C9AE1F000E9@smtp.kernel.org>
In-Reply-To: <20260902103402.9C9AE1F000E9@smtp.kernel.org>
From: Wei Ren <weir@nebusec.ai>
Date: Fri, 4 Sep 2026 17:36:18 +0800
X-Gm-Features: AcwNN1UEJHE5kxwtQIpvfaZR87xRhOqCc4ys3tc5g9vbMyYcRxOzksYYxTo17aA
Message-ID: <CADfOeh7YKUaZY8UVxtrw_YsASmuxJ3JuSq3nk_X702fAidW01Q@mail.gmail.com>
Subject: Re: [PATCH net v5 2/2] mptcp: fix MP_CAPABLE token migration when
 cloning reqsk
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=97=A5=E5=91=
=A8=E4=B8=89 18:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Ignoring the return value of mptcp_init_sched() in mptcp_sk_=
clone_init() causes a module refcount underflow.
> --
>
> commit 18a63fbca98d3e69ad5d14656be7de91ee0af91e
> Author: Ruide Cao <caoruide123@gmail.com>
>
> mptcp: fix MP_CAPABLE token migration when cloning reqsk
>
> The patch fixes MP_CAPABLE token migration during TCP request migration b=
y
> moving token request ownership from the original request to the clone
> under the token bucket lock. It also safely destroys the provisional MPTC=
P
> socket if a passive MP_CAPABLE socket cannot claim the token.
>
> Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e=
8c9430.1776149210.git.caoruide123%40gmail.com
>
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index e1f08f71cdb16..30067f2a7ca8f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
>
> [ ... ]
>
> > @@ -3764,6 +3777,14 @@ struct sock *mptcp_sk_clone_init(const struct so=
ck *sk,
> >       mptcp_rcv_space_init(msk, ssk);
> >       msk->rcvq_space.time =3D mptcp_stamp();
> >
> > +     if (!mptcp_token_accept(subflow_req, msk)) {
> > +             list_del_init(&subflow->node);
> > +             WRITE_ONCE(msk->first, NULL);
> > +             sock_put(ssk);
> > +             mptcp_sk_clone_destroy(nsk);
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but could this error path expo=
se a
> module refcount underflow?
>
> Earlier in mptcp_sk_clone_init(), the code calls mptcp_init_sched() witho=
ut
> checking its return value:
>
>         msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
>         mptcp_init_sched(msk, mptcp_sk(sk)->sched);
>
> Because sk_clone_lock() byte-copies the parent's msk->sched pointer, if t=
he
> BPF scheduler module is concurrently unloading, bpf_try_module_get() can =
fail
> and return -EBUSY. This leaves a stale pointer in msk->sched.
>
> When mptcp_sk_clone_destroy() is called here, it triggers
> mptcp_release_sched(). Will this cause a use-after-free and refcount
> underflow by unconditionally calling sched->release() and
> bpf_module_put() on that stale scheduler pointer?
>
> > +             return NULL;
> > +     }
> > +
> >       if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
> >               __mptcp_subflow_fully_established(msk, subflow, mp_opt);
> >       bh_unlock_sock(nsk);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788202924.=
git.caoruide123@gmail.com?part=3D2

  Thanks for checking.  I don't think this failure is reachable in the
  current tree.

  CONFIG_MPTCP is bool, and the only registered scheduler is the static
  mptcp_sched_default.  There is no BPF struct_ops implementation for
  mptcp_sched_ops, and mptcp_register_scheduler() is not exported.

  mptcp_sched_default.owner is THIS_MODULE, which is NULL for built-in
  MPTCP.  Therefore bpf_try_module_get() reduces to try_module_get(NULL)
  and cannot fail.  The default scheduler has no release callback, and
  bpf_module_put() reduces to module_put(NULL).

  Consequently mptcp_init_sched() cannot return -EBUSY on this path, and
  mptcp_sk_clone_destroy() cannot release an unacquired scheduler
  reference.  The unchecked return would need to be revisited if
  unloadable or BPF MPTCP schedulers are added in the future, but I don't
  think this series needs a change.
