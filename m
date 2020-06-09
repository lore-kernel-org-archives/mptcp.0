Content-Type: multipart/mixed; boundary="===============0445563974695634530=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/3] Squash-to: "mptcp: refactor token
 container."
Date: Tue, 09 Jun 2020 12:09:56 +0200
Message-ID: <42c65b684c04040c5f9c5a5993a92dcc0642bdeb.camel@redhat.com>
In-Reply-To: 3937b1a365f3f679c4f09887ba372d310af52f48.1591652866.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4623

--===============0445563974695634530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-08 at 23:51 +0200, Paolo Abeni wrote:
> Move token creation into stream_connect(). This clean
> the code a bit reducing the test in critical path and
> plug a race: at shutdown time, subflow_rebuild_header()
> can be called after the msk token is removed, leaving
> a refecen to the to-be destroyed socket into the
> token container with later UaF.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

hello Paolo,

this patch fixes the kasan UAF and the GPF crash I saw yesterday on my
test environments. See below:

> ---
>  net/mptcp/protocol.c |  6 +++++-
>  net/mptcp/subflow.c  | 10 ++--------
>  2 files changed, 7 insertions(+), 9 deletions(-)

[...]
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fcb9ca9a9dce..2d30fafa1aed 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
[...]
> @@ -251,7 +245,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
>  		subflow->remote_nonce =3D mp_opt.nonce;
>  		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
>  			 subflow->thmac, subflow->remote_nonce);
> -	} else if (subflow->request_mptcp) {
> +	} else {
>  		tp->is_mptcp =3D 0;
>  	}

the above hunk does not apply because the lower context is different (it
has been changed wityh the fallback rework). I reworked it like this:

------------------------ >8 ------------------------
@@ -252,7 +246,7 @@ static void subflow_finish_connect(struct sock *sk,
const struct sk_buff *skb)
                subflow->remote_nonce =3D mp_opt.nonce;
                pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", s=
ubflow,
                         subflow->thmac, subflow->remote_nonce);
-       } else if (subflow->request_mptcp) {
+       } else {
                mptcp_do_fallback(sk);
                pr_fallback(mptcp_sk(subflow->conn));
                MPTCP_INC_STATS(sock_net(sk),
------------------------ >8 ------------------------

During tests, I saw a sporadic packetdrill failure (one occurrence) here:

/root/packetdrill/gtests/net/mptcp/mp_capable/v1_connect_tcpfallback_flagB.=
pkt

and here:

/root/packetdrill/gtests/net/mptcp/mp_capable/v1_bind_tcpfallback_wrongver.=
pkt

but I'm unsure if this is really a problem related to this patch. I'm
quite sure that it's something recent, because tests in the 'mp_capable'
subfolder have been passing wothout problems since a long time.

-- =

davide



--===============0445563974695634530==--
