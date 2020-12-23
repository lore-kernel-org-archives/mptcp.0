Content-Type: multipart/mixed; boundary="===============2355961243291603873=="
MIME-Version: 1.0
From: Paul Moore <paul at paul-moore.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] linux: handle MPTCP consistently with TCP
Date: Wed, 23 Dec 2020 09:53:47 -0500
Message-ID: <CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com>
In-Reply-To: fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7245

--===============2355961243291603873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2020 at 6:55 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> The MPTCP protocol uses a specific protocol value, even if
> it's an extension to TCP. Additionally, MPTCP sockets
> could 'fall-back' to TCP at run-time, depending on peer MPTCP
> support and available resources.
>
> As a consequence of the specific protocol number, selinux
> applies the raw_socket class to MPTCP sockets.
>
> Existing TCP application converted to MPTCP - or forced to
> use MPTCP socket with user-space hacks - will need an
> updated policy to run successfully.
>
> This change lets selinux attach the TCP socket class to
> MPTCP sockets, too, so that no policy changes are needed in
> the above scenario.
>
> Note that the MPTCP is setting, propagating and updating the
> security context on all the subflows and related request
> socket.
>
> Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGByD2=
zxfF7fadyPP1kb-WeWH_YCyq9X-sRg(a)mail.gmail.com/T/#t
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Based on our discussion in the previous thread, the patch below seems
fine, although it needs to wait until after the merge window closes.

Paolo, it sounded like there was at least one other small MPTCP fix
needed, likely in the stack itself and not the LSM/SELinux code, has
that patch been submitted already?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6fa593006802..451bded67d9c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umod=
e_t mode)
>
>  static inline int default_protocol_stream(int protocol)
>  {
> -       return (protocol =3D=3D IPPROTO_IP || protocol =3D=3D IPPROTO_TCP=
);
> +       return (protocol =3D=3D IPPROTO_IP || protocol =3D=3D IPPROTO_TCP=
 ||
> +               protocol =3D=3D IPPROTO_MPTCP);
>  }
>
>  static inline int default_protocol_dgram(int protocol)
> --
> 2.26.2

-- =

paul moore
www.paul-moore.com
--===============2355961243291603873==--
