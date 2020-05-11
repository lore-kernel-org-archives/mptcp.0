Content-Type: multipart/mixed; boundary="===============4238367198979392046=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC net] mptcp: Initialize map_seq upon subflow
 establishment
Date: Mon, 11 May 2020 10:30:51 +0200
Message-ID: <f1ee39d4cb0ce1390fd3e6047c216cd96cfde89b.camel@redhat.com>
In-Reply-To: 20200509233905.72131-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 4358

--===============4238367198979392046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-05-09 at 16:39 -0700, Christoph Paasch wrote:
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
> index e1f23016ed3f..86ed1e55a59b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1635,6 +1635,8 @@ bool mptcp_finish_join(struct sock *sk)
>  			list_add_tail(&subflow->node, &msk->join_list);
>  		spin_unlock_bh(&msk->join_list_lock);
>  	}
> +
> +	subflow->map_seq =3D msk->ack_seq;
>  	return ret;
>  }
>  =


The patch LGTM, thanks! =


Perhaps we can move the assignment under the 'if (ret) {' conditional,
just for clarity?

May I guess the above is the root cause for the retransmissions we get
while interopertating with mptcp.org? Is that all, or there are still
retransmissions?

Thanks

Paolo

--===============4238367198979392046==--
