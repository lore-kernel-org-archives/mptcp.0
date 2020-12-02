Content-Type: multipart/mixed; boundary="===============6114910006545637926=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Wed, 02 Dec 2020 12:17:57 +0100
Message-ID: <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
In-Reply-To: 3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7008

--===============6114910006545637926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-12-02 at 11:31 +0100, Paolo Abeni wrote:
> The MPTCP protocol uses a specific protocol value, even if
> it's an extension to TCP. Additionally, MPTCP sockets
> could 'fall-back' to TCP at run-time, depending on peer MPTCP
> support and available resources.
> =

> As a consequence of the specific protocol number, selinux
> applies the raw_socket class to MPTCP sockets.
> =

> Existing TCP application converted to MPTCP - or forced to
> use MPTCP socket with user-space hacks - will need an
> updated policy to run successfully.
> =

> This change lets selinux attach the TCP socket class to
> MPTCP sockets, too, so that no policy changes are needed in
> the above scenario.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  security/selinux/hooks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826fc3658..9a6b4bf1bc5b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umod=
e_t mode)
>  =

>  static inline int default_protocol_stream(int protocol)
>  {
> -	return (protocol =3D=3D IPPROTO_IP || protocol =3D=3D IPPROTO_TCP);
> +	return (protocol =3D=3D IPPROTO_IP || protocol =3D=3D IPPROTO_TCP ||
> +		protocol =3D=3D IPPROTO_MPTCP);
>  }
>  =

>  static inline int default_protocol_dgram(int protocol)
> @@ -1152,7 +1153,7 @@ static inline u16 socket_type_to_security_class(int=
 family, int type, int protoc
>  				return SECCLASS_TCP_SOCKET;
>  			else if (extsockclass && protocol =3D=3D IPPROTO_SCTP)
>  				return SECCLASS_SCTP_SOCKET;
> -			else
> +			elseextsockclass

Whoops, my bad! I don't know how this chunk slipped-in. I'll fix it in
the formal submission for inclusion, if there is agreement on this
change.

Thanks!

Paolo

--===============6114910006545637926==--
