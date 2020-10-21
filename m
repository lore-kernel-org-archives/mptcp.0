Content-Type: multipart/mixed; boundary="===============8039423973721096547=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 0/2] init ahmac and port of
 mptcp_options_received
Date: Wed, 21 Oct 2020 10:37:33 +0800
Message-ID: <CA+WQbwuHpxpSLK1Y4bTArNm1QxMQ28WQiFT+gyJoN_Neid3sow@mail.gmail.com>
In-Reply-To: 20201020163923.6feef9ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6374

--===============8039423973721096547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Jakub Kicinski <kuba(a)kernel.org> =E4=BA=8E2020=E5=B9=B410=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 19 Oct 2020 18:23:14 +0800 Geliang Tang wrote:
> > This patchset deals with initializations of mptcp_options_received's two
> > fields, ahmac and port.
>
> Applied, but two extra comments:
>  - please make sure the commit messages are in imperative form
>    e.g. "Initialize x..." rather than "This patches initializes x.."
>  - I dropped the Fixes tag from patch 2, and only queued patch 1 for
>    stable - patch 2 is a minor clean up, right?

Yes, that's right. Thanks for applying and updating the patches.

-Geliang

>
> Thanks!
--===============8039423973721096547==--
