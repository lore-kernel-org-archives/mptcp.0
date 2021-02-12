Content-Type: multipart/mixed; boundary="===============8148727658157320660=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] mptcp: reset last_snd on subflow close
Date: Fri, 12 Feb 2021 18:15:27 +0100
Message-ID: <e954086f-0f23-568d-1505-b2e4673e8a61@tessares.net>
In-Reply-To: 20210211234245.31961-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7773

--===============8148727658157320660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 12/02/2021 00:42, Florian Westphal wrote:
> Send logic caches last active subflow in the msk, so it needs to be
> cleared when the cached subflow is closed.

Thank you for the patch!

> Fixes: d5f49190def61c ("mptcp: allow picking different xmit subflows")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/155
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>   net/mptcp/protocol.c | 3 +++
>   1 file changed, 3 insertions(+)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d49e0efbdd50..fdd6b3cb0bf5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2145,6 +2145,9 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>   	release_sock(ssk);
>   =

>   	sock_put(ssk);
> +
> +	if (ssk =3D=3D msk->last_snd)
> +		msk->last_snd =3D NULL;

I see that this patch is for -net but it looks like "msk" is not defined =

in this function. Same in net-next in fact.

I also see that you declare "msk" in patch 2/2. I can move the =

declaration in patch 1/2 when applying it. (Not sure when we want to =

send it to netdev, I guess "soon", no?)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8148727658157320660==--
