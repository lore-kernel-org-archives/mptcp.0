Content-Type: multipart/mixed; boundary="===============0286987226387780051=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix data_fin handing in RX path
Date: Wed, 22 Apr 2020 19:46:47 -0700
Message-ID: <20200422.194647.2015117902662502050.davem@davemloft.net>
In-Reply-To: 97c9e399060f81ed71ebfd446d9cf89bbb534142.1587572315.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4232

--===============0286987226387780051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 22 Apr 2020 18:24:56 +0200

> The data fin flag is set only via a DSS option, but
> mptcp_incoming_options() copies it unconditionally from the
> provided RX options.
> =

> Since we do not clear all the mptcp sock RX options in a
> socket free/alloc cycle, we can end-up with a stray data_fin
> value while parsing e.g. MPC packets.
> =

> That would lead to mapping data corruption and will trigger
> a few WARN_ON() in the RX path.
> =

> Instead of adding a costly memset(), fetch the data_fin flag
> only for DSS packets - when we always explicitly initialize
> such bit at option parsing time.
> =

> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied and queued up for v5.6 -stable, thanks.
--===============0286987226387780051==--
