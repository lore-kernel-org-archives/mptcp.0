Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97272
	for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 01:43:28 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 200so16166919pga.1
        for <mptcp@lists.linux.dev>; Mon, 15 Nov 2021 17:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8uXFJj5REg1QUQSDVjzJUhi00EzEHOAI99BvgXuKGCI=;
        b=caRM+Vs/iGaijrPl8bx4ZN5yBJ5G4a1a/3P0JLdmoEbLzIcXfwisbC1IIh3ntN1vWW
         noBhvrskiQxJ3/Jn+CGmM7PANGaGlfVENq9I8NUCp8CEsR0wkO2HU5bXMQUzMVoJX9vO
         Qp7uftM3izwzSOfzfxxHXNczKLjqK89K86xByxhMcvteADxItePt4ZFrf/CXF69PLZpZ
         MHQsiMYUSdHbL5DmtKRtYCeaG0DzKhaO4nDP2Z3tBr3fg5bQofAuZIEZfaNEYVojWsPJ
         G/p5rqqMUKd0+U7MgY5qehU+ZLQQ4BmEPWFIPgQtaM251GEBLXsq8WuKVuIO2Pcgg18B
         B/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8uXFJj5REg1QUQSDVjzJUhi00EzEHOAI99BvgXuKGCI=;
        b=8AuRuRYS5I8s6zXKKsy8ui1Ef43aTLZQOVE37HClcPGPSgJ7jRER2uOXUu+oahz81a
         O8jT+e5BhuV/jK9RW6jm/uFLQATdBVgzIVNYvjHfEQYvHlZSSDBo2YapYEXV1CBrESg/
         kUvP5kXV+pTqAboX5lWrJ75DMsGcxl8tf8fG+6UJaH6ngtoO7KLaByba153/jvMjheV8
         1kehk58AmJjDfOCf8B3tojRzw+1nlKJ96wKu0dx++mtlgPahgyl5qQQvbm8MUbVlYDWM
         QxFftNAXgmc7JOBWcw/duMvq14acIQ7BfH9AsqHGrhKydG83iHWilg2bkLz1Ik7b0rSH
         WvWw==
X-Gm-Message-State: AOAM531ElCS6OGEuMSpCQ3axnIpEDnM0X+Alr+MXJiHBxvW2Eqq2uBtb
	M64d/yfqtwvmUMGDwxafgAq9B688r4Z84Mv9fiD6B8QlBxY=
X-Google-Smtp-Source: ABdhPJydY7ozs27OS2C5u52X4AEdAIWjrMCr3qzH/Ucz+euqC/nf3lmi/Z2aJCQUnCHVptB/4g5J7Fu9MEZXxH8Gtdk=
X-Received: by 2002:a63:6b08:: with SMTP id g8mr2367974pgc.253.1637027008441;
 Mon, 15 Nov 2021 17:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+WQbws3N2+9tODvHPxtz0MUebBD7YsUW=D+dQO+pFkhgfJkTQ@mail.gmail.com>
 <CAKuKrBnbswz2est=KenbCb3npfyCNcfOm=3ELDSZf5cxNoN7AA@mail.gmail.com>
In-Reply-To: <CAKuKrBnbswz2est=KenbCb3npfyCNcfOm=3ELDSZf5cxNoN7AA@mail.gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 16 Nov 2021 09:43:39 +0800
Message-ID: <CA+WQbws118ErxCL34ZtWVGFdLUjq3V+OF4wLTXke4h=ewTYnKw@mail.gmail.com>
Subject: Re: MPTCP on "openEuler Summit 2021"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B411=E6=
=9C=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:13=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang,
>
> On Mon, 15 Nov 2021 at 10:40, Geliang Tang <geliangtang@gmail.com> wrote:
> > I finally had a talk about MPTCP and our upstream community at another
> > conference named "openEuler Summit 2021" (openEuler is a China Linux
> > distribution) in Beijing last Wednesday (2021-11-10). About 40 people
> > came. And the talk was broadcast live on the Internet at the same
> > time. Here I attached some pictures about this talk.
>
> That's really cool, thank you for sharing this and the pictures!
> Do not hesitate to share that with others ;-)
>
> Did you have interesting questions from the audience?
>
> If you have a link to watch the recording of the talk, we can add it
> on our wiki page if you want to.
> https://github.com/multipath-tcp/mptcp_net-next/wiki#talks-and-articles

Here's the link:

https://live.issmart.com.cn/Live/issmart_live/#/pc?eventId=3D5482&liveId=3D=
0a15532b&lang=3Dcn&utm_source=3Dlive

There are 8 topics in it, all in Chinese, and my talk (Introduction to
MPTCP) was the first one, about 20 minutes.

Please add it on our wiki page for me.

Thanks,
-Geliang

>
> Cheers,
> Matt
> --
> Tessares SA | Hybrid Access Solutions
> Belgium
