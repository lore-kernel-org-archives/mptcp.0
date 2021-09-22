Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EB3FC7
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 03:50:58 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id me1so1071864pjb.4
        for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vgs54cWwBJXwIebazowEyEZdCzRM9o6K1jCaFpSF2tw=;
        b=h1EyC/JQSg5Gtvkrpdxmo8ZsCjlPzAr6kDT+37k54Om4+iyzfg2QV5YUr7Xu8Gd1x9
         4/vhDGU/l6tT20PvDmXcj/PXjbN4YzPGeTf8OZ5HRqjNMLvcZ0yWkVSw4AKvdBY3pkJP
         TXt4jZZF4+Dt/+cY8pOIk8FF4cOWVzTYkGAYi6BvIC7ahWkapfCzqG7aZ1Hd75RYMBrA
         bcyzdb39rFKn1KPLX4bCMpGaT6aKWMc0wdrwrOTs2VW0AXSdhraacIMtuFtlVlTKnLFf
         +ZR4q4ICNuptaQ4379hl1ikdRluwa3gChYVv0WTwwXVBKf2xCRuoFM9+Xg6DHFrsJrGp
         oRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vgs54cWwBJXwIebazowEyEZdCzRM9o6K1jCaFpSF2tw=;
        b=i+3G1FC7B01Ue+K5OVBnhN6NHILhhSaID3L3WuB1cmUwTGua3p7Fumgr3oBR7oeHk7
         TH7jBAsSPnebGgLdODMWeYa+casV6yt1b+ByB6GvzgMMlqpGmIdQJiP+CLkNm5Q68soi
         M3IiAN1l23KSEYXaKYr8Xz+/0f6jm0/dIXdp4OOyZ/X+bX892+dGTufYqLKJ/0IZmkZI
         WCMQQw/4GRXBSA/LlWVDaJ7tSxRGcCrgHc+ncyihz7V/fa0MByzRlPsnkdjzfMG9tN6y
         nNdnt8V5HJaJuW6L79/ETIgUQGPWxg2zuUaCz9Tq2ZcgyvtERhWIzMaJRrgCWiU0k14Q
         dGbA==
X-Gm-Message-State: AOAM533B92EdjdTvvIM/6JU1zkzpgF1yL7E+cUBakckZ9zo01SXxOfm+
	+2V4kv9hgvDBe1jidN3JZqIvyGj3T1PfpRwcT4g=
X-Google-Smtp-Source: ABdhPJyNTuTHcUf4QLowT6B5UoDqjUR5PN5WvOJjXAZI0a9Wcdk80rprb/Ijh2M11dSAmqxA8nFEZScM0dXZQ8MVDdE=
X-Received: by 2002:a17:90b:1bd1:: with SMTP id oa17mr9016520pjb.82.1632282657849;
 Tue, 21 Sep 2021 20:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1631188109.git.geliangtang@xiaomi.com> <5afb788b507a63f31f390c512fb5eedb464dd01e.1631188109.git.geliangtang@xiaomi.com>
 <3a1f4fdab51c7b451fe05a76f181853237774500.camel@redhat.com>
In-Reply-To: <3a1f4fdab51c7b451fe05a76f181853237774500.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 22 Sep 2021 11:50:46 +0800
Message-ID: <CA+WQbwshbrEcHUfMCH3XGeS+2sV7MRn2Rrt9t7exy8gg=0R0zw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 9/9] DO-NOT-MERGE: mptcp: mp_fail test
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > ./mptcp_join.sh -Cf
> >
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
>
> I'm wondering if we could use the u32 target to replace all the TCP
> options with u32 if find a DSS (tcp header len =3D=3D 38, IIRC) and the D=
SS
> len is not zero (checking 2 bytes at a fixed offset).

Please give me more help about how to use the u32 target to replace the TCP
options.

Thanks,
-Geliang

>
> That will corrupt che tcp csum, but IIRC the csum is not really checked
> over veth with default nic config.
>
> /P
>
