Content-Type: multipart/mixed; boundary="===============5781928653987037067=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 16/16] mptcp: retransmit ADD_ADDR
 when timeout
Date: Thu, 24 Sep 2020 17:26:56 -0700
Message-ID: <alpine.OSX.2.23.453.2009241726360.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: 8d5db133c22f03ed112b13fdc2a36ed4168295d8.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6040

--===============5781928653987037067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR echo
> is received. It added a timer with the announced address. When timeout
> occurs, ADD_ADDR will be retransmitted.
>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c    |   1 +
> net/mptcp/pm_netlink.c | 109 ++++++++++++++++++++++++++++++++++-------
> net/mptcp/protocol.h   |   3 ++
> 3 files changed, 96 insertions(+), 17 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============5781928653987037067==--
