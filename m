Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9070
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 11:44:45 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id a8so2526304pjk.4
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hrdcx63AR9EI+zy7arcmfHfdhuJJmUYoINb44RJdEsU=;
        b=ky1ZF0lqlcCTiWc2Dp2lmmzZVr/O4eZijSYcQ8EpLBxMOqWRCX/0MiANa4aTszvBCz
         QYX/W5PJEmUeZhWEIheUV9KMKWgB287G2WUlDVIiqItZgHiDMcjN2WwMhd2ODef/XNKb
         +5JcQXQnrexnk5KMeoH9fbGWka8g9dY62nvEDQZVROGVYah3RInlVMx7HeMFqSv6m7mH
         Cp2fcCbhSm20Z6AZXDeJEbPySDZiHldNgWdBGx3/11KPBg/JGtBodWHu5jfxsyJpQDqO
         o+rVX9ip9sq+uClKXq8wHFHtFwu2ccUmeKmwWhivDtQHX++1NWRPtUI1uD+/ln9xXL8S
         VKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hrdcx63AR9EI+zy7arcmfHfdhuJJmUYoINb44RJdEsU=;
        b=mqtxJtVSDE8WYtiAfAyLe0Qw7pV0jg/3a+9a6WOflPwYD0dJo5pDzXUHE35iBvVTyz
         HiURZYVys/QTiqxj+rGbPKHduL/GrWCHSgF2qKq3EpxkGssgwMQJHRtl0naEm/HUD0WO
         KmiD/ieyPpSXKVi9pfMy/SaDumbBqpJUbdG4eMzpTEREuPvFzmoMqJ4KL6H4hf3rV1Gt
         q/txce/jdTWOIS870r1qhUIuJpQ1/fiRgfh+s/uPMQtSzn8DX1mrwxLrWbfd/pTs5QIp
         idrIiWLdHFw4VP6P7EIzTWZ/ui6pQdvzrHj1FwqTUjZwEt6qfOwta6fALAp6HbcCQcHD
         P06A==
X-Gm-Message-State: AOAM530mFeqC2FVXOT0QAvBycxf5HY+gE5Z3QvjUJgE1IOvdmVaR7KMR
	Xh7hkHrHC/XF8wTCA2frF/4ugFJ0dHCEQM1gzqk=
X-Google-Smtp-Source: ABdhPJxBqks2iojWNLd0nu3Z50bjH0/MFNqvhVSXjOdZ6QJT1bbVFWvLwk5Ml6PvTPthalXCts/DNIvSfm242bbqap4=
X-Received: by 2002:a17:90a:5d8a:: with SMTP id t10mr9580317pji.6.1628077485062;
 Wed, 04 Aug 2021 04:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210804072556.664287-1-matthieu.baerts@tessares.net> <7655f9a1-df47-cfc8-3281-cd5fbd1e3c1b@tessares.net>
In-Reply-To: <7655f9a1-df47-cfc8-3281-cd5fbd1e3c1b@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 4 Aug 2021 19:44:33 +0800
Message-ID: <CA+WQbws-UiT5-ZFKBPiXBAATJGt1G2AmtU=F0=cpJQm=pkWUMQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add fullmesh testcases"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for fixing this.

Acked-and-tested-by: Geliang Tang <geliangtang@xiaomi.com>

-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:36=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hello,
>
> On 04/08/2021 09:25, Matthieu Baerts wrote:
> > To avoid using the >10 numbers for the fullmesh test cases and comments
> > around to make it a bit more clear this is a workaround, we can pass
> > 'fullmesh_X' where 'X' is the number of addresses we want to add with
> > the 'fullmesh' flag.
> >
> > If we detect that the parameter is starting with 'fullmesh_X', we add
> > the flag and set the corresponding variable to 'X'. Then we continue
> > like before.
> >
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> >
> > Notes:
> >     to be squashed in "selftests: mptcp: add fullmesh testcases"
>
> I forgot to mention that we also need to update the corresponding commit
> message to remove this line:
>
>   Reuse the above 10 address numbers for the fullmesh test.
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
