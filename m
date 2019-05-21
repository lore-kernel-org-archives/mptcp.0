Content-Type: multipart/mixed; boundary="===============9054405061767618005=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [GIT] Sync with net-next: conflict
Date: Tue, 21 May 2019 16:03:02 +0200
Message-ID: <f22b9f0c6f2ab53325570a0b2427279c7d04929b.camel@redhat.com>
In-Reply-To: e0fff648-e14c-f815-9a02-4bb37687a6e1@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1207

--===============9054405061767618005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2019-05-21 at 14:26 +0200, Matthieu Baerts wrote:
> diff --cc include/net/sock.h
> index fd982f976925,0680fa988497..000000000000
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@@ -1473,8 -1473,7 +1473,12 @@@ static inline void sk_wmem_free_skb(str
>         sock_set_flag(sk, SOCK_QUEUE_SHRUNK);
>         sk->sk_wmem_queued -=3D skb->truesize;
>         sk_mem_uncharge(sk, skb->truesize);
> ++<<<<<<< t/tcp-clean-ext-on-tx-recycle
>  +      if (!sk->sk_tx_sb_cache) {
>  +              skb_ext_clear(skb);
> ++=3D=3D=3D=3D=3D=3D=3D
> +       if (!sk->sk_tx_skb_cache && !skb_cloned(skb)) {
> ++>>>>>>> top-bases/t/tcp-clean-ext-on-tx-recycle
>                 skb_zcopy_clear(skb, true);
>                 sk->sk_tx_skb_cache =3D skb;
>                 return;
> =

> =

> The commit 8b2e02e94442 (tcp: clean ext on tx recycle) from Paolo was
> conflicting with a new one from upstream:  (tcp: do not
> recycle cloned skbs) from Eric Dumazet.
> =

> I simply added the new condition (&& !skb_cloned(skb)). I hope it is
> alright: a73376082e4c6e3c9a48fd887f759ab1e4118477

The conflict resolution LGTM, thanks!

Not sure if the following actually makes any sense, if the merge commit
could be squashed into "tcp: clean ext on tx recycle" that would
simplify/cleanup the git history.

Cheers,

Paolo


--===============9054405061767618005==--
