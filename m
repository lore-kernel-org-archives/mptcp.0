Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99F3382E8
	for <mptcp@lists.linux.dev>; Thu, 12 Mar 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280154; cv=pass; b=YT2QtAD0yDn7wmFImTIU8GaeiqW/4h57fP/YyakLbzFP8b702mQZcLKl+y+GfyUUmHSjjK5IGRBdZnqL2OGWXx7UxqiuCcxPdhizja3GPpCgNYUGInrowt1gdv1uFgsByZyUF7mzvnNOfLoL7C75St6HnxqYEDdT9D5rIqnQlfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280154; c=relaxed/simple;
	bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qR/rZtSIQscelnnm7ULh2B2gSvNohI1LCuWcV6Zu+Ws2pouhWYe3hdLw3heUydDxNrVecPWUttH6fAuRop1g0NoXGOjnnu/C264TdJUGA4FXvbvvW6K76xuiA1Ew6CB3wJyriaNogfkanTPq9w9bq/oFeMoaN58smTt4mTrWp3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2C+BHtYI; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2C+BHtYI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a747448dso4275211cf.0
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 18:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773280152; cv=none;
        d=google.com; s=arc-20240605;
        b=LyTFS0SJ1WCZLJ5ia6UM4UBuFHu6JWOouKNnYaNRsquUALofprncWY7PQbZPyoIKxX
         r6WAKZPPqhSmSYKG0MZPhTAYP46XlEXfdQHhSPUtatdUD7q1PI9ykT8ga5B/zL+7N2/p
         oDCObkK6Glg+B/Q+zQp5cZqHWyT3dkdJCcQHkaOzAVDyDbBFzy17Wf0u9+/O62S1W1wN
         zC1gJLqZOF80nDcU4Uz/yVW7NZulMPcHehDEVHUycPG8FSwDlqzPxCVDDN+r3dyb77eL
         SsNWP1bH9AfjrZsoGLuQuz9IbNArTWl1uxZZyVjNBO3vq6Ck+AHxQtX+9p5ssvw0ld10
         wQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        fh=pwmbn5jjDZ6WZ98Zhk3qgCZbWyaZ07PHX0kFwh8vCmw=;
        b=locGm2MKLDaZ1ovLEH5tOqHA6CwcsniX9jQZFUaxjvRTdRoNGZQNdVguOYY9i6XCXX
         /oJTldFZSIDKFDID92zIpudcvGXhTnwLQtkwKLA/iM56aI5GTI8ddTtIVURIRsZ5VRFM
         C4qy69vEj4OOEfMl72Q0OoReO4pP3mYcHN0NdOqvRQWgHwfFzbMAKIEK8L+dqmQUetyv
         GcAc6ypBa4/HAO4YBMLJQ/1qGYCM12CskjoobQePcYlQ+NpXpQchzx1y1VoKTYzjptVi
         jtf2wa+Eb2pXW2ygBMU+tJg3dyidaciq5REgyiFyBvH9WnORsaAHrRuG40RbmIZ902+M
         /v+A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773280152; x=1773884952; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=2C+BHtYIYZJLGqxPJMgi/aNT0uTY8GJky1US/duNS12nrrd1qc85J7wSHqqjdy/3al
         d2HGYWaoHYmKABNSPIT2sm6+LrXYurzsW4GkR3DzexGuFUuqK8oEs2sD53NHHMb14QuR
         RoiMsArxdrsV6+wD+tbSHPmrsLZDFMCY6oTxtz9iYZE6rVvnp8IELgL9QkqsIntUPBq9
         piyuE3O8xHZrQQnnIZalpx/oMTi/0mqvJ8s891mwOT6wFEioylxcLeAdkezcfPNWwgbm
         Gw00VRl6n0xOKeZl8T2QAAo5MvXCiU9Q6GTkC04tu7pMvfp3l/B+YmyzMGIJ6g6YmErv
         9atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773280152; x=1773884952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=V7T49U2DjIiWaAkZxgIzQhRbB+aNmWr8WHY98RyEHsjGQRIGkBo+p750Tgtg/ij8XL
         FnncSYf3lW/MVtYqh5b5mucgmbS3mxoRW+2MWKD7CmzHUsh6x2SFiMaq7HCLiOes2xvX
         93QADqKDR83pIa2TldExwsLa6CC+NFAzKSwsfUXOvP2aMYr+NrRiY7CILTWlr2QLC3Gc
         jRvVDV7bdFrM/nb46wfaKCSCE1lP19nPTu3RSgBhFpB+eHIIjkQ2sMETTbuheFLGCYtZ
         ShLWGhBvMIQzlxNhynXmCd1kbCeHKv5W4jpXv2h5PDShKb6b+s+OqmbcOutAhkjl7nVs
         p+/A==
X-Forwarded-Encrypted: i=1; AJvYcCXe+vipNYQS4Jb77vAnTtGS2sS0c//SR4+d44iSipQC+T5J/pzDuzujVTRt02EO559EtCra7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXYd1qDKrG6YDrG/QUesqUJOo4etAm9Iw1XKycx8QN9LjNLpJ6
	8nLJOA9B2S3mFI3DwfUj+Hgb1ltZnTtNVnI3ZptYja8XGW4GSJqelVYS2Ea1PepP4Aah1o4/PEd
	bF4LfkmWsnHedWxnKzUSKpmda5rNGlujuCRH6xqSX
X-Gm-Gg: ATEYQzwKOq3h7EM4WGUlt+el7frFWxkuzI4h77hCtIbsnjPwlkjhhBORhLvSdjHSNIN
	0XyTHqA7Kq4aAfHBAaFqXT3BC/P7aQDOK9TP1Apr4XOLTIEyxVQBNcALp8h9EydqI20DTjw2EgO
	Uq4Gx1V+7WRZt9kN+E/ivLQgYppxYiig3a4qXIpJLMevn81AOWM5mSpbPd8ENNXBhNLJQpwYeVH
	CQbZIlpyrpy270rI9jZVmSMC4TxpddHrqDsrdFqzksdrJPf1oBc/xQceWQfLrRc1/xPATP+2FPV
	2k2TzHk=
X-Received: by 2002:a05:622a:245:b0:509:16ba:d537 with SMTP id
 d75a77b69052e-50939fc6311mr62588591cf.19.1773280152190; Wed, 11 Mar 2026
 18:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260311075600.948413-1-atwellwea@gmail.com> <CANn89i+dojcg=TDh6E1++g_TM7qdcpnyu47n2Q9DRW_w73TjzA@mail.gmail.com>
 <20260311174154.5fadb207@kernel.org>
In-Reply-To: <20260311174154.5fadb207@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 02:49:01 +0100
X-Gm-Features: AaiRm52zaoXRZHJbWhVYmknx0ZhJd77Ysbeej4LqlWfvsr4aOTCUEXNpCukM3UU
Message-ID: <CANn89i+8LBnbwGE+4qfXv3uKrwLXog1hXqabSK57dCABJ6Nx0w@mail.gmail.com>
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across
 receive-memory decisions
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wesley Atwell <atwellwea@gmail.com>, Simon Baatz <gmbnomis@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, kuniyu@google.com, horms@kernel.org, 
	geliang@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com, linux-doc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Mar 2026 09:34:32 +0100 Eric Dumazet wrote:
> > Your series will heavily conflict with Simon's one
> >
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1063486&s=
tate=3D%2A&archive=3Dboth
> >
> > I suggest you rebase/retest/resend after we merge it.
>
> Would it make sense to extend netdevsim and packetdrill to be able to
> exercise scaling ratio a little more? Having it optionally clone the
> skb and truesize +=3D X would be trivial. IDK how many bugs this would
> let us catch tho :(

Yes, I think we mentioned this at some point.
packetdrill uses tun device.
Adding a TUN ioctl() to control how many additional bytes are added to
skb->truesize after tun allocates an skb is doable.
