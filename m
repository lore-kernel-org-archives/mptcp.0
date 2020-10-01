Content-Type: multipart/mixed; boundary="===============5938879646386029440=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: ADD_ADDRs with echo bit are
 smaller
Date: Thu, 01 Oct 2020 17:28:57 +0200
Message-ID: <bbbba48862ee0a14affdc5076de70df6e764bff4.camel@redhat.com>
In-Reply-To: 20201001145833.4039133-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6142

--===============5938879646386029440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-01 at 16:58 +0200, Matthieu Baerts wrote:
> The MPTCP ADD_ADDR suboption with echo-flag=3D1 has no HMAC, the size is
> smaller than the one initially sent without echo-flag=3D1. We then need to
> use the  correct size not to send a packet with the wrong TCP option
> lenght and containing garbage at the end.
> =

> Fixes: 6a6c05a8b016 ("mptcp: send out ADD_ADDR with echo flag")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/95
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Reported-and-tested-by: Davide Caratti <dcaratti(a)redhat.com>

--===============5938879646386029440==--
