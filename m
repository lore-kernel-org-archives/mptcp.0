Content-Type: multipart/mixed; boundary="===============1090659407273471116=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: fix "fn parameter not described"
 warnings
Date: Tue, 24 Mar 2020 18:16:27 +0100
Message-ID: <17613bfe3e3e6eb6d274b1ccd3dc0e520b0ee24b.camel@redhat.com>
In-Reply-To: 20200324165709.2024557-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4059

--===============1090659407273471116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-24 at 17:57 +0100, Matthieu Baerts wrote:
> When checking for extra warnings using 'make W=3D1' [1], I saw this:
> =

>   $ make W=3D1 net/mptcp/token.o
>   net/mptcp/token.c:53: warning: Function parameter or member 'req' not d=
escribed in 'mptcp_token_new_request'
>   net/mptcp/token.c:98: warning: Function parameter or member 'sk' not de=
scribed in 'mptcp_token_new_connect'
>   net/mptcp/token.c:133: warning: Function parameter or member 'conn' not=
 described in 'mptcp_token_new_accept'
>   net/mptcp/token.c:153: warning: Function parameter or member 'token' no=
t described in 'mptcp_token_get_sock'
>   net/mptcp/token.c:178: warning: Function parameter or member 'token' no=
t described in 'mptcp_token_destroy_request'
>   net/mptcp/token.c:191: warning: Function parameter or member 'token' no=
t described in 'mptcp_token_destroy'
> =

> This doesn't stop the build if KCFLAGS=3D'-Werror' is used but better to =
fix them.
> =

> One of these warnings has been introduced in commits from the 'export' br=
anch
> but the rest is from two already published commits.
> =

> [1] https://github.com/multipath-tcp/mptcp_net-next/commit/2069cff66f186b=
0d4edf23af5ca02977d8806dc1
> =

> Matthieu Baerts (3):
>   mptcp: fix "fn parameter not described" warning
>   mptcp: fix "fn parameter not described" warnings
>   mptcp: fix "fn parameter not described" warning
> =

>  net/mptcp/token.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> =

LGTM, thanks!

/P

--===============1090659407273471116==--
