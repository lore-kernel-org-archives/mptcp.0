Content-Type: multipart/mixed; boundary="===============4901083920075423496=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 6/6] mptcp: close poll() races
Date: Mon, 29 Jun 2020 16:31:21 -0700
Message-ID: <alpine.OSX.2.23.453.2006291631060.11066@jlbliss-mobl.amr.corp.intel.com>
In-Reply-To: 0c0e9026c97b90d92047b3771dc248e5d873ac6a.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4859

--===============4901083920075423496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2020, Davide Caratti wrote:

> From: Paolo Abeni <pabeni(a)redhat.com>
>
> mptcp_poll always return POLLOUT for unblocking
> connect(), ensure that the socket is a suitable
> state.
> The MPTCP_DATA_READY bit is never cleared on accept:
> ensure we don't leave mptcp_accept() with an empty
> accept queue and such bit set.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/protocol.c | 25 ++++++++++++++++++++-----
> 1 file changed, 20 insertions(+), 5 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============4901083920075423496==--
