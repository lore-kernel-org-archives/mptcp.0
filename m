Content-Type: multipart/mixed; boundary="===============2916544537744639576=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix ADD_ADDR HMAC in case port is
 specified
Date: Sat, 13 Mar 2021 09:17:05 +0800
Message-ID: <CA+WQbwvH+7-7wdfRmY=u1YuSkCsGAfjrP_vEKbKYL+QhsL5CLg@mail.gmail.com>
In-Reply-To: e982a3ff-26b0-d899-fd35-403d3eb5cf4@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8143

--===============2916544537744639576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=888:35=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Fri, 12 Mar 2021, Davide Caratti wrote:
>
> > Currently, Linux computes the HMAC contained in ADD_ADDR sub-option usi=
ng
> > the Address Id and the IP Address, and hardcodes a destination port equ=
al
> > to zero. This is not ok for ADD_ADDR with port: ensure to account for t=
he
> > endpoint port when computing the HMAC, in compliance with RFC8684 =C2=
=A73.4.1.
> >
> > Fixes: 22fb85ffaefb ("mptcp: add port support for ADD_ADDR suboption wr=
iting")
> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > ---
> > net/mptcp/options.c | 24 ++++++++++++++----------
> > 1 file changed, 14 insertions(+), 10 deletions(-)
> >
>
> Hi Davide -
>
> Thanks for catching this. Fix looks good to me.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Acked-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

>
> --
> Mat Martineau
> Intel
--===============2916544537744639576==--
