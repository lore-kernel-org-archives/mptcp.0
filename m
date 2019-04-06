Content-Type: multipart/mixed; boundary="===============5830491693866564534=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH 3/4] mptcp: move tpext data_len initialization
 at option creation time
Date: Fri, 05 Apr 2019 17:00:55 -0700
Message-ID: <alpine.OSX.2.21.1904051518550.58453@aakhemka-mobl1.amr.corp.intel.com>
In-Reply-To: aa9f17441e53a1b1a44225f19533945fdf0784db.1554473233.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1052

--===============5830491693866564534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 5 Apr 2019, Paolo Abeni wrote:

> So that we can cope easily with skb coalescing
>

Paolo -

It's not necessarily the case that one skb corresponds to one MPTCP =

mapping (represented by the data_seq, subflow_seq, and data_len fields of =

mpext). If a large chunk of data is available for the MPTCP-level socket =

to send on a subflow, it might create one large mapping (covering up to =

64k of the sequence space) that would cover a number of skbs. This =

approach can reduce MPTCP's TCP option header overhead.

It seems like the next patch tries to maintain the skb boundaries by =

setting 'eor', aligning the skb with the intended MPTCP mapping. The =

MPTCP-level socket needs to know where one mapping ends in order to set up =

the next mapping, so I'm not sure we gain a lot by deferring the =

mpext->data_len assignment until the header is written. Since skbs getting =

coalesced would all be in the tcp write queue, couldn't the =

mptcp_sendmsg_frag code update mpext->data_len on the coalesced skb before =

calling tcp_push()?


Mat


> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c  | 2 ++
> net/mptcp/protocol.c | 1 -
> 2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1b6ac68c15ba..25a77e6dd5de 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -335,6 +335,8 @@ void mptcp_write_option_header(__be32 *ptr, struct sk=
_buff *skb,
> 	}
>
> 	mpext =3D mptcp_get_ext(skb);
> +	if (mpext)
> +		mpext->data_len =3D skb->len - tcp_hdrlen(skb);
>
> 	if ((OPTION_MPTCP_DSS_MAP | OPTION_MPTCP_DSS_ACK) &
> 	    opts->suboptions) {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index db7dcc687918..2fbfe3e30630 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -104,7 +104,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
> 		memset(mpext, 0, sizeof(*mpext));
> 		mpext->data_seq =3D msk->write_seq;
> 		mpext->subflow_seq =3D subflow_ctx(ssk)->rel_write_seq;
> -		mpext->data_len =3D ret;
> 		mpext->checksum =3D 0xbeef;
> 		mpext->use_map =3D 1;
> 		mpext->dsn64 =3D 1;
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============5830491693866564534==--
