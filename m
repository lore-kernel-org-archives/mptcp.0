Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7819F13F
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914009; cv=none; b=Ao+3Zt5V1uMGYuVZpJwa/iO/NgfiOVeVhi9UrAQndeENAE/EuOPGTK96B0I+OgQxaJ7MDlsygULI7cmYCkIJeRHrAQ6pLRi4mJfQ+54Zek+7fT0waLeih979E7p9jRe9FXfV/Ld5itFbWme6Gi6wnEJYKuPGs5HqUdqWoHHy6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914009; c=relaxed/simple;
	bh=Q9yI4R6hoVg2XeN1eirXmMeVAmcn7R8TGagvjKs2n64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7+YGxymQc2ihB/Ng8rqUQJK48r3yBclGSOFr9dLBa9TTJd1p8Puz7FLJTLDaX/skkqeFbFUmWOpEeelrdOfuoFJMGDgGa2teRJUQTDy2EnGB1S+S5w4aC+w5gz7bMM7aFkL9da591tVp7RMk6RSXLaydt4p5BCWQgIHIUpRk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=PUsOZ76C; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="PUsOZ76C"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b88369530so17060e87.0
        for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753914005; x=1754518805; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIeoinAIdYwGqdZwOERA4SesvzxtQ6LazQ/L7OpdWtQ=;
        b=PUsOZ76C+fQA1zdEo9lLhJEF4rsoT7fCGtbfrC/OgrB4DhWokBlRX09eocDCrMGRJx
         IxXEe+GGPhemmPC3KQnjA8tuxK/4W78dES52zhSN+6+VhdxlFkhFNa92FJaRWeXnHwYZ
         HuUuiNKHnKYatLoyb8TE7DOwkCFlSFhJMkC1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914005; x=1754518805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIeoinAIdYwGqdZwOERA4SesvzxtQ6LazQ/L7OpdWtQ=;
        b=Bv4RqRkgxpzhzqq7eypOuP+NhMfjjXtNSb5iUbxYcNoLurw26Neaoou3OMx3zYs7tU
         FVwW+a//P3QlarsIdl/m+77j1RgCnCNL4PtVPL32xIC27OYTY8/6PrRPFkgpC35gNBdw
         Fvqg6xueMSF7trktF5nBlZlIM+zZYGxnME9rrcXIh/nRB5uVqO6KqsWQjX+uHy1PY3fo
         /X+TQH0yVWE5Tbu/xqhGWEncucfA6qxXDV4yZ27EhZCVz31ekbwVldSBEFiO0VT9RD8K
         Llo77Ifg2G/HWbiNPkKnXp/2Y5gzz7v+p6GZ1WxpaJvmWW91bl/v1Tbit5CgLUab5BaP
         Epvw==
X-Gm-Message-State: AOJu0YyB7rS/LRYo3g1rGx9YoX+zDwcFij0fIy5xPb1r9XqgehSUSWn4
	UsWZCURtFI2/1wJpUK9JVFNpY7gNKOs/FO2NLgH9kSfSxmORVjWtVYpy6xedO4P4G9lP10bahkB
	D/ErT1GBEM2IP/SEleEUFMPy6w7HdT0zAEhNORVf6Jg==
X-Gm-Gg: ASbGncuhs+hF1qcWSZPl/YoDVacuWFAYn1AKkfVAGJvBzr8CHyzSJivoKAnd5D0gNjr
	QkwqX+WZ1IhPJVeHdx11l5D7WQbOEvtnl61ntFq2NMFzrrz9Mg9YZNID9ueCUtPsVgxgf+lFYEV
	6rDsQ2fQgHoQbU4AZG6P0ozaWRN/X3wwXKfnsbrb65/mOCxyoM3WcWm8NpQ1Hrx61Op7zIDb+9Q
	MARSp4/
X-Google-Smtp-Source: AGHT+IHo0xuDrCYGvJPoHwExJlExzLpRl4uEs3LL59ULzPenV+nQNoYxr5NAtN2PGdzl4RJu+6feXSUs45wTLQLO5eM=
X-Received: by 2002:a05:6512:3e11:b0:55a:90b:7a37 with SMTP id
 2adb3069b0e04-55b7c08e2b5mr1632051e87.50.1753914005257; Wed, 30 Jul 2025
 15:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1753859907.git.tanggeliang@kylinos.cn> <7f2aaa80eef99f64ff6d7a48ce0a6bf06d1cacab.1753859907.git.tanggeliang@kylinos.cn>
In-Reply-To: <7f2aaa80eef99f64ff6d7a48ce0a6bf06d1cacab.1753859907.git.tanggeliang@kylinos.cn>
From: Christoph Paasch <cpaasch@openai.com>
Date: Wed, 30 Jul 2025 15:19:54 -0700
X-Gm-Features: Ac12FXy3rqKuCLKAzW3S7gUd7UIrMs41CgchvByLpbu-DcRdEm6ZX_8KPh3n06g
Message-ID: <CADg4-L9m2=4d56kEpy48YYAaEhAe66m6fuG8qN_MdGi9W_GURg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: setsockopt support for TCP_MD5SIG
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Wed, Jul 30, 2025 at 12:22=E2=80=AFAM Geliang Tang <geliang@kernel.org> =
wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
> The implementation:
> - Allows setting these options (getsockopt remains unsupported)
> - Applies them only to the first subflow
> - Maintains MD5 compatibility limitations with MPTCP
>
> Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP too.

Is there even enough option-space to have co-existence of MPTCP with
TCP_MD5 ? I don't think so, right ?

The only way they can co-exist is if a bunch of other options are
disabled. And in that case, do we really want to use non-MD5 on
subsequent subflows ? I doubt that, because the goal of TCP-MD5 is to
"improve" security.

So, shouldn't we rather disable MPTCP always when an app sets TCP_MD5SIG ?


Christoph

>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index b264185b810d..5b3e54f7d803 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -567,10 +567,12 @@ static bool mptcp_supported_sockopt(int level, int =
optname)
>                 case TCP_FASTOPEN_CONNECT:
>                 case TCP_FASTOPEN_KEY:
>                 case TCP_FASTOPEN_NO_COOKIE:
> +               case TCP_MD5SIG:
> +               case TCP_MD5SIG_EXT:
>                         return true;
>                 }
>
> -               /* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is n=
ot compatible with MPTCP */
> +               /* MD5 is not compatible with MPTCP */
>
>                 /* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAI=
R_OPTIONS,
>                  * TCP_REPAIR_WINDOW are not supported, better avoid this=
 mess
> @@ -834,6 +836,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock=
 *msk, int optname,
>         case TCP_FASTOPEN_CONNECT:
>         case TCP_FASTOPEN_KEY:
>         case TCP_FASTOPEN_NO_COOKIE:
> +       case TCP_MD5SIG:
> +       case TCP_MD5SIG_EXT:
>                 return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optna=
me,
>                                                       optval, optlen);
>         }
> --
> 2.48.1
>
>
