Content-Type: multipart/mixed; boundary="===============5051817533354577316=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: Initialize map_seq upon subflow
 establishment
Date: Mon, 11 May 2020 19:35:21 +0200
Message-ID: <6b0594845f7787b9bc82c845321e23b6bc3bca38.camel@redhat.com>
In-Reply-To: 20200511162442.78382-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 4371

--===============5051817533354577316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-11 at 09:24 -0700, Christoph Paasch wrote:
> When the other MPTCP-peer uses 32-bit data-sequence numbers, we rely on
> map_seq to indicate how to expand to a 64-bit data-sequence number in
> expand_seq() when receiving data.
> =

> For new subflows, this field is not initialized, thus results in an
> "invalid" mapping being discarded.
> =

> Fix this by initializing map_seq upon subflow establishment time.
> =

> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>  net/mptcp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e1f23016ed3f..32ea8d35489a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1629,6 +1629,8 @@ bool mptcp_finish_join(struct sock *sk)
>  =

>  	ret =3D mptcp_pm_allow_new_subflow(msk);
>  	if (ret) {
> +		subflow->map_seq =3D msk->ack_seq;
> +
>  		/* active connections are already on conn_list */
>  		spin_lock_bh(&msk->join_list_lock);
>  		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))

Reviewed-by: Paolo Abeni <pabeni(a)redhat.com>

--===============5051817533354577316==--
