Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA852517BDA
	for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110788; cv=pass; b=ugwe9d6WjkjXRdSGfUvcxjbBp3fQ4VWfqW9OMnpcGJJPgTH+DA6RSkoJFvD8deo5fxyYGOQU33Z7/Dg+cCVVhnUIQf0l8fp8iknpt88/EOY8qWpNanXdG4gqP8cWzIJwes6WiXXWjVDvTZPOehP7tf0o4qj+XJBvqVQ32QOH89E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110788; c=relaxed/simple;
	bh=wIRXXuVsUSpgf3xCZFrSJzI8xByKVKMD+dC+JD/lknA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZkb3iSByct5iELTNkTUW0iWLFbslBsP2efLPIl0XYKkdceQOwS0uyMuGj5NyxDuQh3tXT+v8/WLXypNbxRlhAbizcJUJdSPLqhemhRL+rEDfBB7D8Vbue+DU+x4M7CWyoZ/pMR1vAOFwUWkUmiNfcWV5yxk4gTk6Hp6ttc/SCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9Chaaxj; arc=pass smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9Chaaxj"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d06a12d360so154268eaf.2
        for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 13:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790110774; cv=none;
        d=google.com; s=arc-20260327;
        b=B7Gum9ELL4Q3m38YQ3ssVPnQgWPEXQ1s8u/a96p5M8gDccmfSSIp804MTAP1OqSMt1
         08xsRakmMrJdP6Xx2Zrs5gTZZaUh5HU9M2LN+P045DG0sjb795OF2pLZlLCWwl6XbAnM
         FqOHbSr9DoeQvmlB3qtvmysyIWjMJJNhd+YHydO4S/N1ppFVPIlL4Ls9oS11SU9pW8if
         bOmAXJy4jSdSR6aIh2arglIJYPLSr1F9i9bRSCpEtT128rOZF6Dpn/mmXV586VG5ez2r
         4mrvKs16Z4+Qq73Q9psCky/vAfvvw7/9YdClQ7zk2qr9wmiHX1HGU4AsXAa74FSyIMaI
         gmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=btBRPiBOdcnMWIsPdftA9/JWuQ65VWOKgdruB6cHU6E=;
        fh=7SCMrqQac4gFSXYVUdpIP38ezbuuWY3QTj9GGr2x+FY=;
        b=RmhAfK1La89aOkI+BHwtuk7GnwNHU6yWf25CdIdkJTlfonKanVeXeuvn5Qdr47piLM
         FtjJ9MXND5i7xwCG6jC68d3dWfFRTY1KhZ/T0t9WM5Z/y6FwraqeuQW6oJdC5goQWaXK
         ZmVls5vJkifrvzteHgy58xwD81+sPbDL9pNP1l3TG99dHNjhroNpJnOtwgZscjzr5pFZ
         2tP82bdwvRuN0RsNKJJX6rNrk3RKqCmQSGcstV8JD/hlagVGrXRHBLy3NoAnC9VWG702
         G0akGAA6kksXZz2m8wK7k4G8+tJqnamad31EFq8J1606sWqdDTEd6FC1btFdwawustLW
         svcQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790110774; x=1790715574; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=btBRPiBOdcnMWIsPdftA9/JWuQ65VWOKgdruB6cHU6E=;
        b=P9Chaaxj4mf3CpzhRHoxsS8vORWuW5eQ1icmYn+k2L+kKKl/i8Jk2nVWUafLJaQdOV
         NurBKCcyZvvokNNbU2h2IRbcixuYh33QN4UdqMZ/7qs8HuU5DQnRyniCaC+tLN27xLR0
         Jzo0Xn7Hrprg9Toc2pU9uSz9Ueto9uI6QYxddS3Pjdpj5DaAouN9kbhmha4SqcRTi9c3
         FaXgJZdV2yOLgmd1UU4Wvr8bHgoZuFMKQf8zee8spivb502QEpMs+ar2EQ6Hc/7U7ZPL
         SCGzpHseYC+QP/uU3CcSD1CIfWKyMYNVGbqUzPVTBLSyhrFYP5YnldArhhw7uwpKPiiZ
         0Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790110774; x=1790715574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btBRPiBOdcnMWIsPdftA9/JWuQ65VWOKgdruB6cHU6E=;
        b=pBYbn5+0lg4GYI2shsqu+cvcRK00LLoVup4IV+G2TX0WTtTS4Gi3icA4OcUHOTNR0l
         u8SxFhiY/hmUL/d8/Ha5WVNheWOOXKkbQ91WR9D1UTuhUER2f0CPGw+HfruTdQ7eWSp0
         O+gJs+DNONKCTQJacX2u9VkobVGiikdNM+3lnPz+CHne8Ui26Uo0eyNi3T6ER6NRsNwn
         ntN9DYc+Cqeyf4FShzEUA7KkE6n7iH+6PJSUGN7TjKNgIDW3aWZXubtwWaSvJqNSW6rq
         afkVfbP8y8UiZFB9xl52ec5oJaa8/aXWVHdh2Y7yAogFezumqp/rbxfjmJb+Ib5HxrLm
         cuqQ==
X-Forwarded-Encrypted: i=1; AKwUvByuI4W3RlfO0a5CD8eWWV8mAWt1vc4r8Z31CAj35zb4afe9kITG4S2tXggfxNLK72b/MJXhyg==@lists.linux.dev
X-Gm-Message-State: AFuF++mSsLthRJMGdHplD461ZJWXqlgNTA2sEqXblicgOI6jYh2N+/gu
	KuIsAOG8MUsjYf0vaeiv/64MH17jwTX5G/LZTkYqwyB8r4cpLrp8ZMpFUxPHaZ9uEfCiDbVUMO/
	qGrVkJiURtOt39DtNL5YBv2X3tKzjDSw=
X-Gm-Gg: AYBFou12Pgb6GljPyG4DHBImrApNjcF4uJPKSk7rsRtlT5QzI3MkP2mIDJjuV2KfhTo
	J/dKuPa8nZz3XkP3Hwu76J/kTG93LMC+0EhE7NW8M46V7yC+gdueTvzHMKBY00/jYcLhs80ZEQr
	KyFsO7YABTDkVgLdAXmeEs5UhyO2/o10XjqSmJEMqTzXqgNdvyY3zF96Wa6aGjId+YY1rEOEuKe
	bL/JNMb0ay3BzC5Q9JkyTNf0FblH+KXDhK28tWs+7jPl7RB5KYBYhUjbhFgLslWtU3KEIhNUFJS
	5cLnpA3nbaT7eraJdOfEb0LBjvanyTbx9SOV0IQovzCvhobocpz9HIMdY2tVyAE6hoBWOiBUsWM
	3Hk3GgftvKw==
X-Received: by 2002:a4a:e911:0:b0:6b4:5cfd:f381 with SMTP id
 006d021491bc7-6d2d0836a4cmr577159eaf.25.1790110774153; Tue, 22 Sep 2026
 13:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260918-net-next-mptcp-msg_errqueue-v1-1-dd77e1738248@kernel.org>
 <179001595171.2160803.3670624686905872378@kernel.org> <d6cdbc83-86a6-4c2a-ad99-29cdb83566dd@redhat.com>
In-Reply-To: <d6cdbc83-86a6-4c2a-ad99-29cdb83566dd@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 22 Sep 2026 21:59:22 +0100
X-Gm-Features: AcwNN1VUII6uOcsfxfr-62vUKq7jiIrNoNXoOzhNQ-DW9bOGJNbIJXNMHXPivns
Message-ID: <CA+XhMqyGNBrd=Kt71gk2M+PC3bZxfPt7ujswBGe3pRAFiuz0PA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] mptcp: support MSG_ERRQUEUE on the parent socket
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sept 2026 at 14:30, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 9/21/26 20:39, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The new error-queue splice is dead code for MPTCP-native dat=
a:
> >    its only accepted input (SO_EE_ORIGIN_TIMESTAMPING skbs on a subflow=
=E2=80=A6
> > - [Medium] Forwarded TX timestamps expose per-subflow identifiers inste=
ad
> >    of parent-socket byte-stream identifiers, breaking the=E2=80=A6
> Sashiko comments look relevant to me. Basically this work makes sense
> if proper support for mptcp-level tx timestamping is enabled and the
> and sk_tskey is resolved at the msk level.
>
> I underlook at the above during reviews on the mptcp ML.
>
> IDK if someone is currently working on the missing work/bits.
>
> /P
>

Agreed, nothing arms tx timestamps on the msk today. Let's drop the
series for now.

I can look into it.

pw-bot: cr
