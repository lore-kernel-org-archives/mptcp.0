Content-Type: multipart/mixed; boundary="===============7988572845384258833=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: stray code chunks in current export branch
Date: Thu, 31 Oct 2019 18:26:13 +0100
Message-ID: <8668305d-e56e-60e4-abc7-1127a8b74059@tessares.net>
In-Reply-To: 259f95245ea4bb1edcf6f2da46611d63839c74c3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2383

--===============7988572845384258833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 31/10/2019 17:55, Paolo Abeni wrote:
> Hi,
> =

> as per last mtg discussion, patch "mptcp: Write MPTCP DSS headers to
> outgoing data packets", includes:
> =

> @@ -208,6 +303,14 @@ static struct sock *mptcp_accept(struct sock *sk, in=
t flags, int *err,
>   =

>                  mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
>                  msk->subflow =3D NULL;
> +
> +               mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
> +               msk->write_seq =3D subflow->idsn + 1;
> +               ack_seq++;
> +               msk->ack_seq =3D ack_seq;
> +               msk->remote_key =3D subflow->remote_key;
> +               msk->ack_seq++;
> =

> 'remote_key' is set a few lines above, and the 2nd ack_seq increment is
> wrong, we just incr it once.

Good catch!

> The 2 bottom lines are deleted by "mptcp: Implement MPTCP receive
> path". We should avoid inserting them at all. @Matt, can you do that
> with git surgery, or do you prefer a patch?

Thank you for this email!

I just did the fix:

- a40c05d7dc64: squashed in "mptcp: Write MPTCP DSS headers to outgoing =

data packets"
- 0530ee00fb46: conflict in t/mptcp-Implement-MPTCP-receive-path
- 3a4c8696fb26..0a282f50587a: no diff

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7988572845384258833==--
