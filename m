Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284884A11
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500856; cv=none; b=OmvT0D0e94YhP1N3EZ14fXF+L5Yr2Zn/rYiAjnqG4UqTGP0dyWyXAvLAtgP/2wTkRoq1td51fCVhg7TA4qb7hVYhssP100qmPRMv680AbYaT7KdRL1BbXerSCEaSpf+VVamaIAOnoLmMxJh4HzOqrQ+B/9DQ+8tWYgfdN16SdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500856; c=relaxed/simple;
	bh=O2EkeLSia+dmZis9TbKSGzYt0dzGrwVcHEVMcA7m0j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3KZX5YKz5LoObp++Ypj7iQyYZjjIHxdsYtr7sgj0M/3WR1upd3PGKtirrYpKutPbicwA1tjxhSDOBzrVYJrelsRi+Zte5sB1G4Znjl5XzuXuxzzwNmAw+2bBS25zC+NrnzEL+LQuW+b7VeABl0JXOvwVyGsMSvrcFd24Kpfl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DtoC4sJS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DtoC4sJS"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f4cf36c00so2819773e87.1
        for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756500852; x=1757105652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwJq7H//9mhoJqxp25Bag85O/wC8SbMpE8f4yoH82F0=;
        b=DtoC4sJSTojkFpj+7HqW5NEZkqlfFfZiD3T3mydGZYlJwhi6gJus6gY9G1eItm5cGW
         31WpRszWTNPYY8BVixF7OG75+LmNJiJuhMiXP9jFBYU/wz39k5f3Wg81evzCuP2IyKLt
         hVsfKPHoU51ddi8AfumvKLtnGf/B/jwq7vVp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500852; x=1757105652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwJq7H//9mhoJqxp25Bag85O/wC8SbMpE8f4yoH82F0=;
        b=lBqnoeVSqhsm/5zibpA2MnN6WUoorlWWCZcjPe5cNNTd04G/kMJ0DIgoGj0/3j58TP
         NMBczfhGBK3baKX0TZo+2Ndwywlmoy7ap0PWnQupUg4gxjPY2jYYP35YaACrBwD1KvMU
         vF3MN78/3lqLGcHR8Ltk89OkKtDMwONZ5myea5hxnZ57vv4IkfMvjWm4WGy9eHTiMpux
         jrkl11/vT5Us2TOn8QsOaIz3lmpRdMtixjbqEvTmhEPIfPGyOD4DTBXisVMsKHVD08pv
         HCBoDTTV7QdM1kLplQdE8Bij2GA3dZ5H42LDpL3FtUfaAMHJjwVxQJTPQaENWXgO5fz5
         7Wfw==
X-Gm-Message-State: AOJu0YxStjBlRrU8q2bluKU1DdCCksxqM/cIFOyg0CChB5gCZwr5XcBW
	0GDefgp3db2+Dmni82J6lX1gQG6R0/WEd2eXvv4z4OoJ1VOiZY1/+d+pKC6eo0IF4xodJBvO5xz
	pS2fZ7/09Xmsl5YY3TJhUg08s4OfREAZShX6ugqjm8g==
X-Gm-Gg: ASbGnct8IX8BfAkpFHN6g6wgNx0vKLgRZRjiBh0kVhEEh4Xt9NEG75ca1qiA2AQC5Ah
	aRdE6VNnkUI46Y6FgWdkyow2/oVQJUvGlt7jBzAEEu2WyJX9CwB1l06668KzzbtJtGGc21PP3OS
	oM6hPg+IkD29rX1TypUd4VgS88P8sYb/dB3G4D2mmlgthP3KeP17Rp7i+rT2gNg/SAmSxe/8MWb
	1xa6xKh9u5AEimOxBYwLLGISOi7EOj5GKNtJUB9mzCcFSp903ja937YjVJU1fI=
X-Google-Smtp-Source: AGHT+IEWQYHHt4UBA96/VWM7JYU+9goSoUa1mrzFbe0K1l3Ye5IplxsT45UWr0wDXl4UuMnh8kpL3qCrYd3dzao2GKA=
X-Received: by 2002:a05:6512:3ba2:b0:55f:7050:954a with SMTP id
 2adb3069b0e04-55f70509760mr13068e87.55.1756500852146; Fri, 29 Aug 2025
 13:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org> <20250829-mptcp-pm-user-c-flag-v1-2-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-2-78b25dda7708@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Fri, 29 Aug 2025 13:54:01 -0700
X-Gm-Features: Ac12FXxigH5V1fcBtsB39z2IWAmjXbF6_hSqWM7DBoOo5e9N-iRwm-gsowLAiqA
Message-ID: <CADg4-L_yzQo7Xs3aVL=sBY2M6OwZ=XDHCTdaS3KyiZa0hOct0g@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 2/7] mptcp: pm: userspace: respect deny_join_id0 attr
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:33=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> During the connection establishment, a peer can tell the other that it
> cannot establish new subflows to the initial IP address and port by
> setting the 'C' flag [1]. The RFC8684 is strict about that:
>
>   (...) therefore the receiver MUST NOT try to open any additional
>   subflows toward this address and port.
>
> It is then important not to let the userspace PM establishing such
> subflows, and return an error (ECONNREFUSED) if it tries to do so.
>
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow esta=
blishment")
> Link: https://datatracker.ietf.org/doc/html/rfc8684\#section-3.1-20.6 [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_userspace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 1911fe1799fa38a53381247a830a9a0daf1c4492..9968dc9a8b45112114953f668=
48ea22c971136d6 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -391,6 +391,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *=
skb, struct genl_info *info)
>         if (err < 0)
>                 goto create_err;
>
> +       if (READ_ONCE(msk->pm.remote_deny_join_id0) && addr_r.id =3D=3D 0=
) {

If userspace wants to, it could still work around that by still using
the initial subflow's IP-address and just use a non-zero address-ID.

Is that really a concern ? Sure, the IETF-draft says "MUST NOT", and
so, shouldn't we leave it up to the userspace PM to make that decision
?


Christoph

> +               GENL_SET_ERR_MSG(info, "deny join id0");
> +               err =3D -ECONNREFUSED;
> +               goto create_err;
> +       }
> +
>         if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
>                 GENL_SET_ERR_MSG(info, "families mismatch");
>                 err =3D -EINVAL;
>
> --
> 2.50.1
>
>
