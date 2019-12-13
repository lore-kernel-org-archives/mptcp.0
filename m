Content-Type: multipart/mixed; boundary="===============2149458433299895543=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: "tcp: Define IPPROTO_MPTCP"
Date: Fri, 13 Dec 2019 17:08:17 +0100
Message-ID: <21edfe97b84a943b68a1ce2da0f214402caae372.camel@redhat.com>
In-Reply-To: fd9848c19b14b56061bdf660e55b9f3ddb443736.1576252967.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2952

--===============2149458433299895543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 17:06 +0100, Davide Caratti wrote:
> checkpatch fixes
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  include/uapi/linux/in.h       | 2 +-
>  tools/include/uapi/linux/in.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index 44df6dc1ff1d..1521073b6348 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -76,7 +76,7 @@ enum {
>  #define IPPROTO_MPLS		IPPROTO_MPLS
>    IPPROTO_RAW =3D 255,		/* Raw IP packets			*/
>  #define IPPROTO_RAW		IPPROTO_RAW
> -  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection 		*/
> +  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection		*/
>  #define IPPROTO_MPTCP		IPPROTO_MPTCP
>    IPPROTO_MAX
>  };
> diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
> index 44df6dc1ff1d..1521073b6348 100644
> --- a/tools/include/uapi/linux/in.h
> +++ b/tools/include/uapi/linux/in.h
> @@ -76,7 +76,7 @@ enum {
>  #define IPPROTO_MPLS		IPPROTO_MPLS
>    IPPROTO_RAW =3D 255,		/* Raw IP packets			*/
>  #define IPPROTO_RAW		IPPROTO_RAW
> -  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection 		*/
> +  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection		*/
>  #define IPPROTO_MPTCP		IPPROTO_MPTCP
>    IPPROTO_MAX
>  };

Since is not ovious without hexdifd, this replaces \s\t with \t just
after 'Multipath TCP connection'

ACK.

--===============2149458433299895543==--
