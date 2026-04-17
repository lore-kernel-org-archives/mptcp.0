Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775B1F30BB
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391115; cv=pass; b=dMwGifB70xv/Dy4FtUMqlz1k4RLdtO9xnt47TXb3BNKJjDluxXzkYzOiaERnZyC6MtJJBHN23EvZEa3IcU/FMc4JZ6zIETIBH3WhsJOAFbCkryNdkVa8F/BWm8FphwoheC/NKGuMioygdmb0QcbrK37zsUJYOAykxjzRUCr8G4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391115; c=relaxed/simple;
	bh=5XZg4lF8dt68vaCTN/Ad4qe3TP1/cSd8GLGcwL6ceYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkUdXiDgo+y+gq8mXkJKNRhe4UgXLoFGEwSywUmGnGPaq0mgMEsEyWuhUZVXZ8eiB4r45BTKoVj/c73C4YF6LWNz7P5v9829SZ1F0lFtjqJROvSuMJ+Ghb+RXipHvsrn3csrjzbXakUzz313xHhxpbjAOjLQfjEsClJnjpkWUcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pulxhLCw; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pulxhLCw"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c726ef332so234116c88.1
        for <mptcp@lists.linux.dev>; Thu, 16 Apr 2026 18:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776391113; cv=none;
        d=google.com; s=arc-20240605;
        b=IwikNInBql+7YEpcKHtDXaY9avu+6fMWDaceFjJB0ynxwsi9dzIH80z0ZRDwB7FpjW
         vWgGxn/wW0cNOXz5EuwFM4PML4tJQNeqXWinR5VQjsr3o5F5uUJXuOi4VQ6TMdxOYmTq
         FICW56Cg3S7s3kedYMpT/Vh9jpN7lBp5TTviDXmeSHXgSuKDtfCPCaQZKapkaO+lduHy
         bPdQIVbvNgAkKIFfcy9Ik4XXdbOPKUjoISq89ZL5q+uhAj9xYP6V5rY3GKf8K87ul8xz
         XlBrVWRng5G6c1Fzw6VSrOAgyW+MBerNWtIXeFzHWrrVoiPsYZzoL3DFj+7Ik0O4hOly
         X5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNY/LLTr6TIgoWo2qCLWE3FAOMBrGLPg8li787GxQcw=;
        fh=0tx+MzbBdC5qbPZ068dJu3FyfWPHqdvlHCeAG3q0s5w=;
        b=beowvDMOe/Sb1ZXF4s2qxHQpu54vCkTBxqQ8zs4eojMHYLpJi9AS2ZzIyletGQQqmH
         wMUqifw6kA3Q5fVdqmXj+Odn0Dei9Q133dcKWiQwUKy4UiQHJWxW9LkeLpLALazSSuAv
         kzFQjcLsehbhSgrVvnb8r8w+qmifRgyWEINoV1Vz3/M20AnW/Na/ZGDCNok7H4Z43frb
         R4n37AOpKBTfQDByarcpQrrokRi3cmlP2pMVfBRO+3Xokh5vgpY//6IFKNpkbea1IPO8
         HF34/gJNbc2xKl9iMZhQqpAy4hGNGz7vjay4NVXz5ueAQLbGIwUztx/4zl/MEBmr/oG/
         mSAA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776391113; x=1776995913; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNY/LLTr6TIgoWo2qCLWE3FAOMBrGLPg8li787GxQcw=;
        b=pulxhLCwVudQP9YmxYMOZL7952QFJzjRW+4f+MoMW+OMe5v9QklahRI8ykuSfUXLpY
         prLStkdlzMYpcCUHHNbWLnSbVOzzQtIttZ5Rb1itH8jNPTBS7wyp0ANDBj+wYub9Rj69
         M7KPGMlRDDXQOPbPDnixzuqbvAtVnXCI5Jq18RWOesbSLnqPV7aVf6E6UYiFruYAIxny
         k2mJ2mdSF0C7L7NkRdQtULWH97vNLFX6RNkO2WqsDA+cREtPPpBfrByFr0OneInh3MbX
         PtoVVSFne+ZFV00ks168TTxInzNepg9TRXKoJC+CG1q9iMfjd9zW3vHG6va84Tlpsdr4
         rpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391113; x=1776995913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNY/LLTr6TIgoWo2qCLWE3FAOMBrGLPg8li787GxQcw=;
        b=U52y44VAqwId/Oqm6hWDNWDO/+3pzkamKldETBFBXO3oEBAuycyY6gN+0+pIChs22V
         NX4QeIbF3AcaMEb7fx10HWSqciYkymoUsXvZvzIL2LfT+TLo97XO8Q8q4xOzuwjGzTlm
         ioGLUNInPtkuqYaQXtknd5aywDuS88MhtTiQdRocssIobMUfaWVO4VSLxFsKDvolJ8xm
         LS6ZQmpnb5WYtpFTxYnzWbbODXyC79FP6hzrMia//Cw0gA2QN7Kb8tIBl49mtzFLpr2M
         VP81INKkxMsURdvjDmYXf/uVXKF6iCbyx92Bz6MhOqxD/8fbg6Vo9sIf6cpaSx9yGeuG
         ZOSQ==
X-Forwarded-Encrypted: i=1; AFNElJ818Qhxa+C7HKx6oV9ON4DhJHR14WzzhsEyaRfppT8bq9h/abUEOw/vmGcwKZFFGb8ruq8g1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yztw4fn93FNSjNV/oPt/o82YjghWrpgGTjNUnXN0ZyWRe/Ts81J
	sDCJz+aoB5FxcyTQnAWUd8lNISbOTHbXHK+WcWjWH6/yWpi1+4imf/DMLhDU4q5sByZp7kOhv9s
	KQXvLh2tkBTRmjgIZimVXV+9WdG+t3P0eoQ4gqvOD
X-Gm-Gg: AeBDievGCZDuwTMA1SWaMEF412rS5w3ro5fIF5iPi/02GcGYQGIpLqb+O09GmNflJdJ
	B0Vr8bMw36+Gr+RdlQhN+vA87CtiubfKmE4OKY+sUycCtFdAUZO349bOHTpzWMbn0mWqv5VVIE6
	aYqZyL8jY6SAehyJnA0Pfn3E+OFiBOFZngduNWJjzHCbZBOorQUD+7jlA24mmd4bUqDpt/qgexY
	bsO/70rL9mFOW5E3BW6s8Hpx+hW1Zn6ZHKJlPQJWq21opTnHlNbBMgXyaTBTZ/vXaM8+SqjutCJ
	droSVUdhZTgvaaWkgpfd6E6mnR/aLWAd3YZSnvmN3vGo6CsIxtY996yavzDwxVebDTlvvxzjhHo
	5LE+7pLt9NkcfD52GwCrB9ObRVi3cECxNx5r1S7VeOf8IBcb2fYhkaP89gMUyB4cSR9htZqtu
X-Received: by 2002:a05:7022:6988:b0:128:ceac:6da6 with SMTP id
 a92af1059eb24-12c73fad1e2mr303679c88.30.1776391112480; Thu, 16 Apr 2026
 18:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1776149210.git.caoruide123@gmail.com> <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org> <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
 <cb1c7e8e-2d64-4a2d-9862-e5c4f544144e@kernel.org>
In-Reply-To: <cb1c7e8e-2d64-4a2d-9862-e5c4f544144e@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Apr 2026 18:58:21 -0700
X-Gm-Features: AQROBzAYgFWJ3xRcd4Gv0g-veHcRvkUl3VrGsUNeeEHwRZTHTLJJFvD_eCjW47A
Message-ID: <CAAVpQUAe=-F00FrLKDanO_aR7EavbfjpsDsyd==4BDqM5_6rQg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning reqsk
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ncardwell@google.com, dsahern@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, daniel@iogearbox.net, kafai@fb.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 2:18=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> Thank you for your reply!
>
> 16 Apr 2026 20:48:58 Kuniyuki Iwashima <kuniyu@google.com>:
>
> > On Thu, Apr 16, 2026 at 10:45=E2=80=AFAM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >>
> >> Hi Ren,
> >>
> >> On 15/04/2026 11:31, Ren Wei wrote:
> >>> From: Ruide Cao <caoruide123@gmail.com>
> >>>
> >>> TCP request migration clones pending request sockets with
> >>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
> >>> subflow_req->msk, but the cloned request does not take a new referenc=
e.
> >>>
> >>> Both the original and the cloned request can later drop the same msk =
in
> >>> subflow_req_destructor(), and a migrated request may keep a dangling =
msk
> >>> pointer after the original owner has already been released.
> >>>
> >>> Add a request_sock clone callback and let MPTCP grab a reference for =
cloned
> >>> subflow requests that carry an msk. This keeps ownership balanced acr=
oss
> >>> both successful migrations and failed clone/insert paths without chan=
ging
> >>> other protocols.
>
> (...)
>
> >>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connecti=
on_sock.c
> >>> index e961936b6be7..140a9e96ad58 100644
> >>> --- a/net/ipv4/inet_connection_sock.c
> >>> +++ b/net/ipv4/inet_connection_sock.c
> >>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(stru=
ct request_sock *req,
> >>>       if (sk->sk_protocol =3D=3D IPPROTO_TCP && tcp_rsk(nreq)->tfo_li=
stener)
> >>>               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq=
);
> >>
> >> (Maybe TCP with fastopen could be this other user to call
> >> rcu_assign_pointer()? (net-next material))
> >>
> >>> +     if (req->rsk_ops->init_clone)
> >>> +             req->rsk_ops->init_clone(req, nreq);
> >
> > I think a simple direct call is better.
> >
> > #ifdef CONFIG_MPTCP
> >     if (tcp_rsk(req)->is_mptcp)
> >         mptcp_reqsk_clone(nreq);
> > #endif
>
> Fine by me!
>
> I guess it is needed to check the protocol, similar to what is fine with
> TFO above:
>
>   if (sk->sk_protocol =3D=3D IPPROTO_TCP) {

I don't remember why I added this check for TFO,
but I think this is not needed.  The migration feature was
not supported by DCCP and it's already removed anyway.
I'll remove the check once net-next opens.


>       if TFO
>           ...
>       if MPTCP (+ifdef)
>           ...
>   }
>
> Cheers,
> Matt
