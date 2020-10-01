Content-Type: multipart/mixed; boundary="===============5594546758521614544=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: ADD_ADDRs with echo bit are
 smaller
Date: Fri, 02 Oct 2020 07:17:47 +0800
Message-ID: <CA+WQbwuxSTG8UNp+K8==d-0P17AV0CAFvZ-Lq3R-0pGL_rw-+g@mail.gmail.com>
In-Reply-To: bbbba48862ee0a14affdc5076de70df6e764bff4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6147

--===============5594546758521614544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Davide Caratti <dcaratti(a)redhat.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=881=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:29=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, 2020-10-01 at 16:58 +0200, Matthieu Baerts wrote:
> > The MPTCP ADD_ADDR suboption with echo-flag=3D1 has no HMAC, the size is
> > smaller than the one initially sent without echo-flag=3D1. We then need=
 to
> > use the  correct size not to send a packet with the wrong TCP option
> > lenght and containing garbage at the end.
> >
> > Fixes: 6a6c05a8b016 ("mptcp: send out ADD_ADDR with echo flag")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/95
> > Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>
> Reported-and-tested-by: Davide Caratti <dcaratti(a)redhat.com>

Acked-by: Geliang Tang <geliangtang(a)gmail.com>

> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============5594546758521614544==--
