Content-Type: multipart/mixed; boundary="===============0880229818910171146=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: more stable diag self-tests
Date: Fri, 07 Aug 2020 18:12:19 +0200
Message-ID: <692cf402-f7e2-1cbc-f38a-98934c88c3a3@tessares.net>
In-Reply-To: 1634f4575a4a2c8e7621941b633a0be50e65e195.1596815971.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5511

--===============0880229818910171146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 07/08/2020 17:59, Paolo Abeni wrote:
> During diag self-tests we introduce long wait in the mptcp test
> program to give the script enough time to access the sockets
> dump.
> =

> Such wait is introduced after shutting down one sockets end. Since
> commit 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machin=
e")
> if boths sides shutdown the socket is correctly tranistioned

(small typo: s/boths/both/ and s/tranistioned/transitioned/

> into CLOSED status.
> =

> As a side effect some sockets are not dumped via the diag interface,
> because the socket state (CLOSED) does not match the default filter, and
> this cause self-tests instability.
> =

> Address the issue moving the above mentioned wait before shutting
> down the socket.

I just did a quick test and it seems it fixes the issue on my VM, =

thanks! I guess it should fix the issue on my CI as well.

=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D
# selftests: net/mptcp: diag.sh =


# no msk on netns creation                          [  ok  ] =


# after MPC handshake                               [  ok  ] =


# ....chk remote_key                                [  ok  ] =


# ....chk no fallback                               [  ok  ] =


# check fallback                                    [  ok  ] =

 =

 =


# many msk socket present                           [  ok  ] =


ok 4 selftests: net/mptcp: diag.sh
=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D

> Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")

Your SoB is missing ;-)

Also do not hesitate to add:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/68

> ---
>   tools/testing/selftests/net/mptcp/mptcp_connect.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index cad6f73a5fd0..090620c3e10c 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -406,10 +406,11 @@ static int copyfd_io_poll(int infd, int peerfd, int=
 outfd)
>   =

>   				/* ... but we still receive.
>   				 * Close our write side, ev. give some time
> -				 * for address notification
> +				 * for address notification and/or checking
> +				 * the current status
>   				 */
> -				if (cfg_join)
> -					usleep(400000);
> +				if (cfg_wait)
> +					usleep(cfg_wait);

Would it be OK for the stability to keep a wait? I guess it would be =

hard to wait for an event (check counters, etc.) to happen.

(if it is possible, it can also be done in other patch, good to have a =

fix here :-) )

>   				shutdown(peerfd, SHUT_WR);
>   			} else {
>   				if (errno =3D=3D EINTR)
> @@ -427,7 +428,7 @@ static int copyfd_io_poll(int infd, int peerfd, int o=
utfd)
>   	}
>   =

>   	/* leave some time for late join/announce */
> -	if (cfg_wait)
> +	if (cfg_join)
>   		usleep(cfg_wait);

(same here)

Cheers,
Matt

>   =

>   	close(peerfd);
> =


-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0880229818910171146==--
