Content-Type: multipart/mixed; boundary="===============2160556163785898605=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/2] mptcp: Handle incoming 32-bit DATA_FIN
 values
Date: Tue, 29 Sep 2020 18:14:08 -0700
Message-ID: <20200929.181408.534589469741619213.davem@davemloft.net>
In-Reply-To: 20200929220820.278003-3-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6104

--===============2160556163785898605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Tue, 29 Sep 2020 15:08:20 -0700

> The peer may send a DATA_FIN mapping with either a 32-bit or 64-bit
> sequence number. When a 32-bit sequence number is received for the
> DATA_FIN, it must be expanded to 64 bits before comparing it to the
> last acked sequence number. This expansion was missing.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/93
> Fixes: 3721b9b64676 (mptcp: Track received DATA_FIN sequence number and a=
dd related helpers)
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

The commit header text in a Fixes: tag should be inside of double quotes
as well as parenthesis, like ("this")

I fixed this up while applying this series, but please get it correct
next time.
--===============2160556163785898605==--
