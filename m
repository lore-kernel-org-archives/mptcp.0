Content-Type: multipart/mixed; boundary="===============8621840953131721271=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH kbuild] mptcp: update_una() can be static
Date: Thu, 10 Oct 2019 15:10:19 +0200
Message-ID: <7f78838c-d8e2-b3d4-fce3-f971b0ddeed4@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910091105480.48251@crpeter1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2082

--===============8621840953131721271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 09/10/2019 20:06, Mat Martineau wrote:
> =

> =

> Fixes: e0c0e8d7b6cd ("mptcp: update per unacked sequence on pkt reception=
")
> Signed-off-by: kbuild test robot <lkp(a)intel.com>
> ---
> =

> Forwarding additional kbuild suggestions that were not sent to everyone.

Thank you for forwarding this.

> =C2=A0options.c |=C2=A0=C2=A0=C2=A0 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index be05d99e6bfa5..ef53f5ddb7325 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -550,7 +550,7 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool
> use_64bit)
> =C2=A0=C2=A0=C2=A0=C2=A0 return cur_ack;
> =C2=A0}
> =

> -void update_una(struct mptcp_sock *msk, struct mptcp_options_received
> *mp_opt)
> +static void update_una(struct mptcp_sock *msk, struct

I moved the second parameter to the second line not to use more than 80
chars.

> mptcp_options_received *mp_opt)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 u64 new_snd_una, snd_una, old_snd_una =3D atomic=
64_read(&msk->snd_una);

Note that it seems that one line was missing to be able to apply it with
'git am' or patch :)

- eab083ba60a5: "squashed" in "mptcp: update per unacked sequence on pkt
reception"
- 43529028ecfd..2533ea90238b: result for the 3 patches

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8621840953131721271==--
