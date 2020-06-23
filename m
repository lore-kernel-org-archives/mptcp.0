Content-Type: multipart/mixed; boundary="===============4869995547815946880=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: drop sndr_key in mptcp_syn_options
Date: Mon, 22 Jun 2020 21:07:24 -0700
Message-ID: <20200622.210724.1974696285872270248.davem@davemloft.net>
In-Reply-To: 60f8315d6ae7b62d175c573f75cee50f14ce988b.1592826171.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4773

--===============4869995547815946880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>
Date: Mon, 22 Jun 2020 19:45:58 +0800

> In RFC 8684, we don't need to send sndr_key in SYN package anymore, so dr=
op
> it.
> =

> Fixes: cc7972ea1932 ("mptcp: parse and emit MP_CAPABLE option according t=
o v1 spec")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Applied and queued up for v5.6+ -stable, thanks.
--===============4869995547815946880==--
