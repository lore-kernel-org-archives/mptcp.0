Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2606418A46
	for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223532; cv=pass; b=OY2ZTfrXUg5TPXIpGmB4Xuq4Qbi+eVnubDHXOFhaxCfFSTcfxttGd7FKYsDEfCeLQb8IrcQ9JEyf48Ku+GoJ9JHsjGBiLLziqMR/JeA8guD/bZvUrsaffrDhe3f9UYDUMmDFPANk11D4ZH7uXE/BLM5bKlYqV02NzILZPeRtMSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223532; c=relaxed/simple;
	bh=P2lCZ64G1tHsyCUN9IGEtfoznMOL0waPTppEGNX4G6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryHKdcLdFi0/iLhpaDSs3wacP2YQO9L4kiBL9FQhOYVwh5nBy/h6u0zd+IsPT/mbQJAyBOrz871GDJhX8TJlGqKWP+9z9N2TcscMUmqqFqXJYuBaD7NLvqjnJEeHB7+OBv83thG42lf50FEwXdBokL4RYxSp78KECyAiDtV7x3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=b0echz2l; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="b0echz2l"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso15380295ad.3
        for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 03:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787223523; cv=none;
        d=google.com; s=arc-20260327;
        b=XMUYiZ9xDCsQt38bi50kBm3Dh7gKjj2tS3GUCbSOT8/R5H3Gy2f8mEEEp/jUYQrCIS
         co3ZbePi6y5UFjR5DKqLJhxSeWNCEUvD98IYS5PphCFpFIZvVoRazyUBeqgr0QOgXdV5
         9ks/Xq+jqF6uP/XEY1criM2ymRdx6ACvLkf88E+w35CNe7H/fkGpP2Xt8Fu+vce60OTX
         vIZI5by2GLjPOLviDUD5fdsnUVxkywM/YEp8b8h20zd3O8k4xtbYfB53VX+0paPSCO1R
         xtvd2n6kaVw5CX71CVhxzCQDrFkBPmXv401A7pqHperoyQD+y8mMYkqARJVbnj6Awaau
         4v0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cw0p0Zs17OGqL0CpVaUylVnGrKO85tM788BbVvkohK0=;
        fh=CB5UpkY+O88awVVzOZ6u9gwGodJr4E7oL8gDALqWdIs=;
        b=PbOX+Ef5lfj/SlcMtsS36u22jiBEJ6kXN0xabm/zJlgFLTqc0Jxni/jEEZOnTuSRp5
         m8oDOfZRAV0VDK0srUtBIEPV70YtFtrHIWJ0TBPdPL6wt40Ectc0Qw2uavza0jCExtej
         kwi9+iesxb6SnhbhcBWC6NYPody8rsthQQiUv6IQUdawJWhVts4rKXdHnPLQEWa4dcMZ
         bNIsrl3Da08DzGM5YujYb6TzVwkfckGd0dFI+jZQM2pZ5lQHZDqAijARDfnCfgDnLMlm
         8w7voM1Q7qfwlYERZ99r/YBEBua+dlEkujapNh7H9BQhYzMdlGIo7gHW7fbn+EGjGDEc
         ZGMg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787223523; x=1787828323; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cw0p0Zs17OGqL0CpVaUylVnGrKO85tM788BbVvkohK0=;
        b=b0echz2lLVH4TW9txjCi+FUzheZOOcTe0eUvAW2+cVBXU+hAZZNHwjxpPWagu04s3Q
         krj8nbA9ekKTvjk5pv5GdHJtdKMUif+aqloTZNZ0vNvXJw5FukNYO4zBNjVmOFtewqdA
         gzJsG5OUS70kex2z/K2Wkg0RCLocZP8YJoT4M+d+Ba39Xq8QvNTzS/QNLsj7IyYkksri
         IefLapBs0WB8qaWS2p/syWMXGXgptxTpQiEAJKCobbDYvbJVawvNl+bR/k2p0JL/E3Kz
         AXLaRVXiNa/krI6qyfaU5gh4Psiq/tOYgneZnF9NtkL340VA8wutDW+AUhhR7KBUfP+O
         5tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787223523; x=1787828323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cw0p0Zs17OGqL0CpVaUylVnGrKO85tM788BbVvkohK0=;
        b=e9GxMWRy/3W7JzX3KMujsQqmtN3t0gKFXLJsdeeU2sK5MDV7ATW3PqPNozXYBVTmSD
         iFEWBj8osXgWwdzZ2pfvAdE6lGa+tTLW4AJQ21MDtvxG06YvR76z/wx8Roov9Cvsbx+f
         oPWEvqMu9qEdINZGySFwgqpL76SO9wbddZUweA3ojNLwck4jpIikS1QwdM+ppJnampn6
         Z8A0ixJooyZ87vbURPBh5h6YZpFIPp1cuAgh27MY+q8uCGwe//OQT23mERg4OuPA6Dxw
         MB+vwIlpaaxEJZr6xd7xGScapmyMsCLiBzwXC36JdXnfZSex56o7mae+Rs2JXDMd/TQ3
         E97g==
X-Gm-Message-State: AFuF++nyLFEVYTC8kdUWiNiBCoD7BkIAkRSoY2tgjaAL02IEMHyJhGf8
	FRptm8neX2cEM7CSRIIOyYvpO2JLGJOWVAox/lqjIX8Y9fHZzOdaZmFqOWML7Uqh2Ovx4BArXCF
	d3JHel2C+dwtSId+Bn2opzL8sMKQtdn/Ws+okkd2WkjE=
X-Gm-Gg: AR+sD10B2dcgTgRrZ3PZhF7CiM6tpamaTM+MNGjG1IwyEEd6vdZSnEP8ggW/hml+Fis
	ZBH9bIzuD1Ty0dO/k+tdiSdZMPu7yfwxKnvOx+sYbmKoinusTmojOSn8xUTPliBt8E4A3Xl8Lp9
	28HFVSasamBLOz8RCvq1BJUwJJ5FuCs5BbUo8/MZn89vyi+Fl9J7uEWveasg3QQ6+MOnBdOQoj1
	aUXy379oN/ZTDb1fuRh5JKTve/ZVcGJQqdSOAPl4A6qTBDujaFF7+swMKhL1/YaYz22h1y4FoZs
	T4nmu71VkXMaheHsSZOdqbrajERLQTQdoOoRv13EWXla
X-Received: by 2002:a17:902:f706:b0:2ca:1b97:70c5 with SMTP id
 d9443c01a7336-2d5fd5e5d4fmr224168925ad.4.1787223522392; Thu, 20 Aug 2026
 03:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1786497414.git.yuantan098@gmail.com> <e3aeafa4dc2afb7ea36143eae163635eee23395c.1786497414.git.yuantan098@gmail.com>
 <20260813065630.908AC1F000E9@smtp.kernel.org>
In-Reply-To: <20260813065630.908AC1F000E9@smtp.kernel.org>
From: Wei Ren <weir@nebusec.ai>
Date: Thu, 20 Aug 2026 18:58:50 +0800
X-Gm-Features: AcwNN1WYyW-8z_95osKXmxJZNbMRNkNVWcxZ23BokIsMPC8k01UieylBReKqe-Q
Message-ID: <CADfOeh6F-PngQB-F4dYds2CpqBCTfJHpBYLD+0ZhcWNiBtPOeA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 06:56:30AM +0000, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but does this clone helper also need to
> handle the migration of token_node for MP_CAPABLE requests?

That is what patch 2/2 of this series does:

  https://lore.kernel.org/all/6abadc83940143e099fa3b54ec6dea2fb95da090.1786=
497414.git.yuantan098@gmail.com/

It extends this helper with mptcp_token_move_request(), which re-hashes
the token node onto the clone with hlist_nulls_replace_init_rcu() under
the token bucket lock, so the clone becomes the single token-table owner
and the original is left unhashed.  mptcp_token_accept() and
mptcp_token_destroy_request() re-check ownership under the same lock.

The same question was raised on v3, and v4 was restructured to answer it.
Reviewing 1/2 in isolation makes it read as an unfixed issue.

Two details of the analysis are inaccurate, for the archive:

> ... leading to hash list corruption and a reliable kernel warning

There is no list corruption.  Nothing in the bucket chain points at the
clone's copied token_node, so __token_lookup_req() can never return it,
and both list mutations are gated on "pos =3D=3D subflow_req".  The stale
node is never passed to hlist_nulls_del_init_rcu().  The splat is the
only observable effect: the panic_on_warn DoS holds, the corruption does
not.

> permanently lose the MP_CAPABLE token from the hash table, breaking
> subsequent MP_JOIN requests for that connection.

The msk insertion sits outside the WARN_ON_ONCE() guard:

if (!WARN_ON_ONCE(pos !=3D req))
hlist_nulls_del_init_rcu(&req->token_node);
__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);

so the msk still enters msk_chain, mptcp_token_get_sock() keeps finding
it, and MP_JOIN for that connection keeps working.  What does drift is
bucket->chain_len: a net -1 per migrated connection that completes the
handshake.  It is a signed int, so it goes negative and
__token_bucket_busy()'s TOKEN_MAX_CHAIN_LEN cap stops limiting that
bucket.  Patch 2/2 fixes that as well.

Thanks,
Ruide


<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=8813=E6=97=A5=E5=91=
=A8=E5=9B=9B 14:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] TCP request migration clones MPTCP request sockets without updat=
ing or re-hashing the `token_node` list pointers for MP_CAPABLE requests, l=
eading to hash list corruption and a reliable kernel warning (`WARN_ON_ONCE=
`) that can cause a Denial of Service.
> --
>
> --- Patch [1]: [PATCH net v4 1/2] mptcp: hold MP_JOIN msk ref when clonin=
g reqsk ---
> commit 2b2ebcd4a3ea728b0d1c8d74d1e09d5e75f65848
> Author: Ruide Cao <caoruide123@gmail.com>
>
> mptcp: hold MP_JOIN msk ref when cloning reqsk
>
> TCP request migration clones pending request sockets with
> inet_reqsk_clone(). For MPTCP MP_JOIN requests this byte-copies
> subflow_req->msk, but the clone does not take its own reference.
>
> Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@tra=
ilofbits.com/
>
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index e1f20ff8fdb42..8f8e1229766d4 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_so=
ck *req)
> >       mptcp_token_destroy_request(req);
> >  }
> >
> > +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> > +                            struct request_sock *new_req)
> > +{
> > +     struct mptcp_subflow_request_sock *subflow_req;
> > +
> > +     subflow_req =3D mptcp_subflow_rsk(new_req);
> > +
> > +     if (subflow_req->msk)
> > +             sock_hold((struct sock *)subflow_req->msk);
> > +}
>
> [Severity: High]
> This is a pre-existing issue, but does this clone helper also need to
> handle the migration of token_node for MP_CAPABLE requests?
>
> When inet_reqsk_clone() performs a byte-copy of the request socket, it
> copies the token_node list pointers (pprev and next) as-is:
>
> net/ipv4/inet_connection_sock.c:inet_reqsk_clone() {
>     ...
>         unsafe_memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end=
,
>                       req->rsk_ops->obj_size - offsetof(struct sock, sk_d=
ontcopy_end),
>                       /* alloc is larger than struct, see above */);
>     ...
> }
>
> Because the list pointers are copied without re-hashing or updating them,
> the original request is destroyed and removes itself from the token hash
> table, leaving the clone with a stale pprev pointer.
>
> When the cloned request is eventually destroyed,
> mptcp_token_destroy_request() checks hlist_nulls_unhashed(), which return=
s
> false due to the stale pointer. It then fails to find the token in the
> bucket, which triggers a WARN_ON_ONCE:
>
> net/mptcp/token.c:mptcp_token_destroy_request() {
>     ...
>         pos =3D __token_lookup_req(bucket, subflow_req->token);
>         if (!WARN_ON_ONCE(pos !=3D subflow_req)) {
>                 hlist_nulls_del_init_rcu(&pos->token_node);
>                 bucket->chain_len--;
>         }
>     ...
> }
>
> This could cause a kernel panic on systems with panic_on_warn enabled, an=
d
> permanently lose the MP_CAPABLE token from the hash table, breaking
> subsequent MP_JOIN requests for that connection.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786497414.=
git.yuantan098@gmail.com?part=3D1
