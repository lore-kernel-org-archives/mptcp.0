Content-Type: multipart/mixed; boundary="===============2322015303994257599=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix bogus sendmsg() return code under
 pressure
Date: Mon, 03 Aug 2020 18:15:12 -0700
Message-ID: <20200803.181512.1195418774947073734.davem@davemloft.net>
In-Reply-To: 365d4a854cbfabbd93be7b0331e4c5d3eb1334b8.1596472748.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5453

--===============2322015303994257599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Mon,  3 Aug 2020 18:40:39 +0200

> In case of memory pressure, mptcp_sendmsg() may call
> sk_stream_wait_memory() after succesfully xmitting some
> bytes. If the latter fails we currently return to the
> user-space the error code, ignoring the succeful xmit.
> =

> Address the issue always checking for the xmitted bytes
> before mptcp_sendmsg() completes.
> =

> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied and queued up for v5.7+ -stable, thank you.
--===============2322015303994257599==--
