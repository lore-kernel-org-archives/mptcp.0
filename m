Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D12D73A6
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178264; cv=pass; b=PCRhODxCODJ579gxNcV+roZuhzsGSjaARpQTiOiUm4giLOdePisSkSFHyGmsSJOjbokelDI8t1uBurQy/3AT8i2HUbGGhNFKOgWgvhzSndMbyRRqwjfVdZHHoRt3OZ1xPTm2ayeyJ+jEzcKRtqURg1yQnWCgZE5yagrweDaYSSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178264; c=relaxed/simple;
	bh=tcyoTvLyfq7be0zEpXcMVTj3MeE6gd8bdg8N21aFTgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCx3eW1BGzmOcAL0CqxFLSt+M3VgV8RagKzYydTWxPEFlBnyZbRxWHRRrCSbXds6N1IeKuInrY4pJL0zAm2DL6DQzQko3d3OSdgIn3n1CGvCLYwk5+ziP7jK98uhFQlg6M63lKltz+LxQUWcOjGrnJ+iCn7BB6meJayHcuvOpSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a772rK5D; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a772rK5D"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51306c9f2a8so10774081cf.1
        for <mptcp@lists.linux.dev>; Thu, 07 May 2026 11:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778178262; cv=none;
        d=google.com; s=arc-20240605;
        b=cB75XIrxEQV+GYn6k19JaaXaIagq+eHujqKPBf5qBSlUbsp6SStFHzkaLSNlmvOzVT
         eFF+G0C/Wwjvvv+gFvAS2tLP/9dkPAJXMCYkU2LAfQstIAu98XDXi6DTtqeQw/04VhLx
         ZX6fN+RAq/YQQn4kDHPNMIYF/l6/IrQSUQbajiCkcalCbgBlCGgGt8hkBkUCqZ4UU/k5
         gHY/EVaM7PMFrTBHk+86ybYPTxLDNgv+sGIzz66TX440aCz3sk8M8CQcwfe/dB61rhGZ
         QBmyPRmijwxSxq22Oy9SPIgauGnDiTZtpsWNF52S6DTJqJNMckycaB4/VHcS4xICv9Bi
         wtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAwfLiW0vxr1+5uikUuotTzmkp2AYIoia+WnOZtNZaQ=;
        fh=onEqDKNgRIzbE+4PEFOisFyjm58xGqA1xEtB0wKuYWs=;
        b=T7wdDXg7SNA1qumVp5VvIYcbCBR4itayKf9LzTNcO945x7US1yPjyRB3jI7hcSZ9Tr
         mTeCmioGQZRpKRh3j9CiuowHoKCPC0IJkhjUhS58ECVcQZmdzi7VPYaldvxf0eVSwOvw
         ol2Gx841bpdwtM4NOiguNBxJx1BpnxlmphtGO6cTx3yNR8Oj4DbS7VcvEb1pKSWtdErH
         2YmhK3lgIk/PlyU03yDsCF1ng86TvA8ogTGq5ZJVwtgN/piMB6e6Q6uA0dNJ5w21/dje
         V1oZTuLBb2lsIkKGnn4zNrwH4touaabxywb6BJptNtAk6iXzFXQT5iIyDhYSGxSwfOA0
         HDGA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778178262; x=1778783062; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAwfLiW0vxr1+5uikUuotTzmkp2AYIoia+WnOZtNZaQ=;
        b=a772rK5DeUQLNfpR6BgDdoUK7kRnSaJPosK0AD1i2FT7mtH1oTmha5YS4Uva+4TEi/
         IgqE38ogeFh8ZvOlLK5ZEZNgyGmS9O5VLwnI5ZF9WdkkY0LhQWHG0v9if8KfQAZV08ay
         EUdYjwznDJRjP+b9eFy0gIdag2WadbfX/Nt0Sr8qv4FKe3dJlBQcdg2IdurULTzskFWm
         fPGPzh27wQrJizUQOpebWTNS5m729f8TbfwOzTigTrg1Km/kpDsbG+XNGL0TOX3a6A7p
         UABnZA8n3n2OlCBqBw0ErVyove1zcNoxt5SlpD+/pgso0+sqrv7H9SlC4sxIxNzGrQLQ
         n0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178262; x=1778783062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAwfLiW0vxr1+5uikUuotTzmkp2AYIoia+WnOZtNZaQ=;
        b=DFdk8AMlor7rM3IgFqkiisjt0YM8gttI2QrXDa/YnFxjbpheIJq+rnBhvkVw2znmo7
         YHshfxSugXmxsK75oyF6KsD/r29CqYEegSxzPtF/7P2j6+9Fbbw0O7004rMWw3hPndvb
         vlK0gamq+XCb0YUBxWKit4toUiE2FUPtLqfxcr4zCs9g/m1I6aVEpqmo8u43CnO3QpX4
         eqv+Jiy6y+pih3EQVvUsL+azuNzhJ/2zEACPXhqqmnmqv7bQiA4hccwLJYjzAgxP2FpL
         Sw0WDqmj4BemNVCxzpryeBqWw8xthq2eD+wjb5drW6SKZ9Srytd9KXP5yp4p4TZemNzG
         EqUA==
X-Forwarded-Encrypted: i=1; AFNElJ+fjcstoM0XKI137/xDcFIslmrphG+0ntJjUbgPwt0fzNGoQF8oBCagWYpi9BUVlDYbdYTBCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBfBdRiw5UD85ZFiFi47sIWSppku4MK3Gpg7B+UAQHUb8wzjGP
	pwaRYRKPOGppdov/pIijU+m62fnMR5gj9sx1VB52bLg6rfHr/nSA07C/HO6n5g609oYq9ZVFUCp
	G7vsg62MfzIfWKoim/cGXr8McVR1d4I8=
X-Gm-Gg: AeBDievxrzpoA7S2fGye1n3ngcePpZWna9m22Ossp9MZ7wc+tW7XPwpCqKioFPfJz0t
	fIJTy16aNeIIiTrgC2ZZZzJu8L6NgGJF5ZkJc8IQWtuNIGXMGjToFfQzvQx0MiL9hJdxg1vq8vG
	ygh4h4fAgwME6yVDL56xXOC05pqhxGzVteCbgWoDarOHofhIrsEStMo0D+pyWuaI7aKxp2YVxIe
	WOmtUotFGhLRHKcKKoimOdqx1h3TgZWTTIjrAtBSRFcN0dKX3CV/wUT42vHcqyea25q2ZT8bHnw
	/CD5Vp4+DtbBIa0+jMk=
X-Received: by 2002:a05:622a:8c7:b0:50e:5fe2:83a9 with SMTP id
 d75a77b69052e-51461bf0515mr132024011cf.5.1778178261397; Thu, 07 May 2026
 11:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1776149210.git.caoruide123@gmail.com> <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org> <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
 <05a19f8d-360e-41d1-bc8a-0b4caab3d354@gmail.com> <027acbe6-ccef-4c4d-8b85-927044326150@kernel.org>
In-Reply-To: <027acbe6-ccef-4c4d-8b85-927044326150@kernel.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Thu, 7 May 2026 11:23:45 -0700
X-Gm-Features: AVHnY4KL6Fk32UJVkC2wlJ6gu9pwIbIP22C6FAIjmsvohtzOfzBrpziSR8vKLX8
Message-ID: <CAPuPA7K8Dqsoy7W4ow+c=gpPEKEbEiLErym2mxCyY6bJFO9G-A@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning reqsk
To: Matthieu Baerts <matttbe@kernel.org>
Cc: caoruide123@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, mptcp@lists.linux.dev, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, enjou1224z@gmail.com, 
	bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 1:07=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Yuan, Ren, Ruide,
>
> (-netdev list)
>
> On 19/04/2026 11:51, Yuan Tan wrote:
> >
> > On 4/16/2026 11:48 AM, Kuniyuki Iwashima wrote:
> >> On Thu, Apr 16, 2026 at 10:45=E2=80=AFAM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> >>> Hi Ren,
> >>>
> >>> On 15/04/2026 11:31, Ren Wei wrote:
> >>>> From: Ruide Cao <caoruide123@gmail.com>
> >>>>
> >>>> TCP request migration clones pending request sockets with
> >>>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
> >>>> subflow_req->msk, but the cloned request does not take a new referen=
ce.
> >>>>
> >>>> Both the original and the cloned request can later drop the same msk=
 in
> >>>> subflow_req_destructor(), and a migrated request may keep a dangling=
 msk
> >>>> pointer after the original owner has already been released.
> >>>>
> >>>> Add a request_sock clone callback and let MPTCP grab a reference for=
 cloned
> >>>> subflow requests that carry an msk. This keeps ownership balanced ac=
ross
> >>>> both successful migrations and failed clone/insert paths without cha=
nging
> >>>> other protocols.
> >>> Thank you for this patch!
> >>>
> >>> Indeed, it looks like this path has not been covered by the MPTCP tes=
t
> >>> suite so far.
> >>>
> >>> By chance, do you have any simpler reproducer using packetdrill? (the
> >>> MPTCP fork)
> >>>
> >>>   https://github.com/multipath-tcp/packetdrill
> >>>
> >>> Also, I see Sashiko is pointing to a potential issue with MP_CAPABLE =
and
> >>> the token, also only visible with net.ipv4.tcp_migrate_req=3D1:
> >>>
> >>> https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c94=
30.1776149210.git.caoruide123%40gmail.com
> >>>
> >>> Are you also looking at that?
> >>>
> >>>> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retr=
ansmitting SYN+ACKs.")
> >>>> Cc: stable@kernel.org
> >>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >>>> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> >>>> Tested-by: Ren Wei <enjou1224z@gmail.com>
> >>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >>>> ---
> >>>>  include/net/request_sock.h      |  2 ++
> >>>>  net/ipv4/inet_connection_sock.c |  3 +++
> >>>>  net/mptcp/subflow.c             | 13 +++++++++++++
> >>>>  3 files changed, 18 insertions(+)
> >>>>
> >>>> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> >>>> index 5a9c826a7092..560e464c400f 100644
> >>>> --- a/include/net/request_sock.h
> >>>> +++ b/include/net/request_sock.h
> >>>> @@ -36,6 +36,8 @@ struct request_sock_ops {
> >>>>                                     struct sk_buff *skb,
> >>>>                                     enum sk_rst_reason reason);
> >>>>       void            (*destructor)(struct request_sock *req);
> >>>> +     void            (*init_clone)(const struct request_sock *req,
> >>>> +                                   struct request_sock *new_req);
> >>> @TCP/INET maintainers: are you OK with this new function pointer?
> >>>
> >>> Currently, MPTCP is the only user, and "req" is not used, see below.
> >>>
> >>>>  };
> >>>>
> >>>>  struct saved_syn {
> >>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connect=
ion_sock.c
> >>>> index e961936b6be7..140a9e96ad58 100644
> >>>> --- a/net/ipv4/inet_connection_sock.c
> >>>> +++ b/net/ipv4/inet_connection_sock.c
> >>>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(str=
uct request_sock *req,
> >>>>       if (sk->sk_protocol =3D=3D IPPROTO_TCP && tcp_rsk(nreq)->tfo_l=
istener)
> >>>>               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nre=
q);
> >>> (Maybe TCP with fastopen could be this other user to call
> >>> rcu_assign_pointer()? (net-next material))
> >>>
> >>>> +     if (req->rsk_ops->init_clone)
> >>>> +             req->rsk_ops->init_clone(req, nreq);
> >> I think a simple direct call is better.
> >>
> >> #ifdef CONFIG_MPTCP
> >>     if (tcp_rsk(req)->is_mptcp)
> >>         mptcp_reqsk_clone(nreq);
> >> #endif
> >>
> >  Thank you very much for your suggestion. We will use this approach in
> > the next version of the patch. Would you like us to add your
> > Suggested-by tag?
> For a question of organisation, do you still plan to send a v2
> addressing the review comments?
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Sorry for the delay. Please forgive us that we are all working on the
patches part-time :)

Ruide will send v2 this weekend.
