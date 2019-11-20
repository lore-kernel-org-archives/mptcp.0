Content-Type: multipart/mixed; boundary="===============7703203574178680720=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 01/13] selftest: add mmap-write support
Date: Wed, 20 Nov 2019 21:05:20 +0100
Message-ID: <1bee3b71-df45-26ce-2afb-3d862d4f40d4@tessares.net>
In-Reply-To: 20191118214538.21931-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2630

--===============7703203574178680720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 18/11/2019 22:45, Florian Westphal wrote:
> No changes on default options.  New option -b allows to set a lower
> send buffer size.
> =

> New option "-m mmap" allows to use a mode where the sender transmits the
> entire file in very large chunks (using mmap + write) instead of the
> default poll+read/write.
> =

> This is mainly useful to make sure we cope with large writes.
> I also added sendfile() support (as its easy), but it won't work yet
> for mptcp sockets.

Thank you for the patch!

[...]

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index b5367fe2c6ea..478bc47c3d60 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -3,7 +3,7 @@
>   =

>   time_start=3D$(date +%s)
>   =

> -optstring=3D"d:e:l:r:h6c"
> +optstring=3D"b:d:e:l:r:h6c:m:"

Just a small detail but the capture (-c) option doesn't any argument. I =

guess we should also apply this:

=3D=3D=3D=3D
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh =

b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 1f840c87be5d..61b9e2a9c891 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -3,7 +3,7 @@

  time_start=3D$(date +%s)

-optstring=3D"b:d:e:l:r:h4c:m:"
+optstring=3D"b:d:e:l:r:h4cm:"
  ret=3D0
  sin=3D""
  sout=3D""
=3D=3D=3D=3D

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7703203574178680720==--
