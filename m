Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967872
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 06:10:40 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id n11so17775097plf.4
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LULJsID9PecbYDfZx0nYuTWKAdOkSNedTZuaOVdHZMo=;
        b=YTBQ8fae/IejIKECly3UQ1wqyLIjjFdeMZgqQRA0YKom/MJnhP9YJc2gW2GnbiYdDd
         ii26s8XY4D1FrW2jTjevLNVQvxLqiJPt2ahAcb0sugdOShmIoEsSZFovZ5BaW3Eq1iHS
         rWWwC44m0lnroW7oQ9xsJylhkjraXTUkLKOv1qfWXcpMNHK4NVTL1HH8GHtmTAbxaUox
         9OjVGUiBhztjUMdUQJlFO7w4i8qMV8KtAg0Xo2D5k6q9K+7AZSI8fD5ieyjemITAqxmI
         94sDLa64eZGCGA6fpdHt5jeNiTnzN3ovZ5CVCWIBYqvXiHPOyhSRk2lGpmum6akUnJSW
         bgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LULJsID9PecbYDfZx0nYuTWKAdOkSNedTZuaOVdHZMo=;
        b=VH+l5nbS+v9VJeSKTNWRtey4OiX55t8oLjuxp6/rJlqYkI0u7qQdOqeVaueRbPUTgt
         XRC8AdOB76ExfUTms/ch+4qPZ2RKDaaaXKpaBTFh6GXWra0hOYRWA8tid1fXLvQKXHc9
         px2zNtw0CGHHotpCRj8ER+hh6KCHvi6U9I3/zEf9f9w79XH4gYWtlfYXit26M2DZMC7g
         Y9zEEjUec+P6tqvUYQ2GHLU3eSgKYLjHXBBc38QY2TmvkqQ7rFwHoomW6OkIosmpcSs1
         3OpnmCuoXvchiuKMm4KEP1KtAxVDl1ZPZPMwXdhFaxsKyyK1W7ppB3gm5Njv91NmIJ6D
         AhFg==
X-Gm-Message-State: AOAM532sCgoIQ7gWnSVufew4hkIm9VlNlyN6neyWmZ7tu6x7LnLZsYkt
	bCRR9sN0PPwv4Czugbh3Dzn9IAoas3N+mXitK3A=
X-Google-Smtp-Source: ABdhPJx/McXUnkpDLeMnIHrPdtM+50iZ8wCL/R6ecMsC8+ShKpVQ2nBg9tdB11VSTsQCOnTKuuek6XkK2Vf4p4eQR3o=
X-Received: by 2002:a17:90a:1950:: with SMTP id 16mr4150039pjh.126.1634796640445;
 Wed, 20 Oct 2021 23:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1634531093.git.geliang.tang@suse.com> <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com> <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <609c4413-b7a2-bb19-5ebc-9b5ff5d8376b@linux.intel.com>
In-Reply-To: <609c4413-b7a2-bb19-5ebc-9b5ff5d8376b@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 21 Oct 2021 14:10:29 +0800
Message-ID: <CA+WQbwuxFiVWWSxKhRdx4U8+b4B=n5BWNmfyYSQadkHN6gqvdw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Davide Caratti <dcaratti@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B410=
=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:44=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 18 Oct 2021, Geliang Tang wrote:
>
> > Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=
=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:50=E5=86=99=
=E9=81=93=EF=BC=9A
> >>
> >> On Mon, 18 Oct 2021, Geliang Tang wrote:
> >>
> >>> ./mptcp_join.sh -Cf
> >>
> >> When I tried running this as './mptcp_join.sh -Cfc', I'm not seeing
> >> fallback in the packet trace (no data level len =3D=3D 0, and the pack=
ets all
> >> have DSS headers until disconnect). Is the test working on your system=
?
> >
> > Hi Mat,
> >
> > This test can't trigger the checksum failure every time, so you need
> > to run it again.
> >
>
> I ran it four or five times yesterday, with no failures. When I tried
> again today, it triggered the checksum failure the first time :)
>
> >
> > My pcap file (mp_join-01-ns1-0-U5nzEu.pcap) is attached.
> >
>
> Thanks for sharing the pcap. When I capture failures on my system, I'm
> seeing slightly different results. The MP_FAIL is only sent in one
> direction, and there is only one infinite mapping sent (in reply to the
> MP_FAIL), but the connection still acts like fallback has happened. I
> uploaded that pcap to the infinite mapping github issue:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/216#issuecomment-9=
47172574
>
> I noticed in your pcap that the infinite mapping is only sent in one
> direction, but MP_FAIL is sent by both sides.
>
> Section 3.7 of the RFC (after Figure 16) says the MP_FAIL must be sent
> both directions, and I think that also implies the infinite mapping shoul=
d
> be sent in both directions. So, should make sure that the last mapping
> sent by both peers is an infinite mapping. And if other people have
> differing interpretations of the RFC (especially the "infinite mapping in
> both directions" part that is not completely spelled out), please discuss=
!

I just sent a squash-to patch to fix this.

Thanks,
-Geliang

>
>
> --
> Mat Martineau
> Intel
