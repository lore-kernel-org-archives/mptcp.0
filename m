Content-Type: multipart/mixed; boundary="===============4543557240563942814=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [bug report] mptcp: retransmit ADD_ADDR when timeout
Date: Mon, 09 Nov 2020 18:27:08 +0800
Message-ID: <CA+WQbwvTTt_R_Z7Kq8bWQ2EBY+b5kq=yfmh7qhi5Y4dYcT+Cxw@mail.gmail.com>
In-Reply-To: 20201109093325.GA2451633@mwanda
X-Status: 
X-Keywords:                  
X-UID: 6592

--===============4543557240563942814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thanks for reporting this warning.

I have just sent out a patch named "mptcp: fix static checker warnings
in mptcp_pm_add_timer" to you.

Could you please test it for me? Since I don't have the Smatch tool you
mentioned.

Thanks very much.

-Geliang

Dan Carpenter <dan.carpenter(a)oracle.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=
=889=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:33=E5=86=99=E9=81=93=EF=
=BC=9A


>
> Hello Geliang Tang,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 00cfd77b9063: "mptcp: retransmit ADD_ADDR when timeout"
> from Sep 24, 2020, leads to the following Smatch complaint:
>
>     net/mptcp/pm_netlink.c:213 mptcp_pm_add_timer()
>     warn: variable dereferenced before check 'msk' (see line 208)
>
> net/mptcp/pm_netlink.c
>    207          struct mptcp_sock *msk =3D entry->sock;
>    208          struct sock *sk =3D (struct sock *)msk;
>    209          struct net *net =3D sock_net(sk);
>                                            ^^
> "msk" dereferenced here.
>
>    210
>    211          pr_debug("msk=3D%p", msk);
>    212
>    213          if (!msk)
>                     ^^^^
> Too late.
>
>    214                  return;
>    215
>
> regards,
> dan carpenter
--===============4543557240563942814==--
