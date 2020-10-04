Content-Type: multipart/mixed; boundary="===============8433506216157001736=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: ADD_ADDRs with echo bit are
 smaller
Date: Sat, 03 Oct 2020 17:36:48 -0700
Message-ID: <20201003.173648.767792137065746549.davem@davemloft.net>
In-Reply-To: 20201003153656.1224144-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6180

--===============8433506216157001736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Sat,  3 Oct 2020 17:36:56 +0200

> The MPTCP ADD_ADDR suboption with echo-flag=3D1 has no HMAC, the size is
> smaller than the one initially sent without echo-flag=3D1. We then need to
> use the correct size everywhere when we need this echo bit.
> =

> Before this patch, the wrong size was reserved but the correct amount of
> bytes were written (and read): the remaining bytes contained garbage.
> =

> Fixes: 6a6c05a8b016 ("mptcp: send out ADD_ADDR with echo flag")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/95
> Reported-and-tested-by: Davide Caratti <dcaratti(a)redhat.com>
> Acked-by: Geliang Tang <geliangtang(a)gmail.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied.
--===============8433506216157001736==--
