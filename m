Content-Type: multipart/mixed; boundary="===============0559983033507080771=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 4/6] mptcp: allocate TX skbs in msk
 context
Date: Mon, 30 Nov 2020 15:44:13 -0800
Message-ID: <1d213fb6-34a4-668e-e972-47e11f7061b@linux.intel.com>
In-Reply-To: 2c4eacb182281d8e65cf4cf521e05141e6b011c8.1606413118.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6995

--===============0559983033507080771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2020, Paolo Abeni wrote:

> Move the TX skbs allocation in mptcp_sendmsg() scope,
> and tentatively pre-allocate a skbs number proportional
> to the sendmsg() length.
>
> Use the ssk tx skb cache to prevent the subflow allocation.
>
> This allows removing the msk skb extension cache and will
> make possible the later patches.
>
> Acked-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 248 ++++++++++++++++++++++++++++++++++++-------
> net/mptcp/protocol.h |   4 +-
> 2 files changed, 210 insertions(+), 42 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0559983033507080771==--
