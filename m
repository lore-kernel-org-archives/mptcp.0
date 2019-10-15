Content-Type: multipart/mixed; boundary="===============1039971696921448333=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: allow compilation on older systems
Date: Tue, 15 Oct 2019 09:37:08 +0200
Message-ID: <21331b88ba184186b74133fa6d31b5ed8fc1eb95.camel@redhat.com>
In-Reply-To: 20191014211734.29681-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2133

--===============1039971696921448333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-14 at 23:17 +0200, Florian Westphal wrote:
> #ifndef IPPROTO_MPTCP
>  #define IPPROTO_MPTCP 262
>  #endif
> +#ifndef TCP_ULP
> +#define TCP_ULP 31
> +#endif
 =


good morning Florian!

AFAIU this is no more needed after =


"selftests: test setsockopt(..., TCP_ULP, "mptcp", ...)"

that had this hunk:

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -18,7 +18,8 @@
 =

 #include <netdb.h>
 #include <netinet/in.h>
-#include <netinet/tcp.h>
+
+#include <linux/tcp.h>

^^ this ensures that TCP_ULP is defined, if the 'kernel-headers' package
is newer than 4.13.

netinet/tcp.h is provided by glibc-headers (you find a quite old uapi
here), while linux/tcp.h is provided by kernel-headers (you find a newer
version of the uapi, but maybe not the one that defines TCP_ULP).
And if I well remember, the rules in lib.mk should allow installing the
current kernel headers in ${top_srcdir}/usr/include, as per:

commit b2d35fa5fc80c27e868e393dcab4c94a0d71737f
Author: Anders Roxell <anders.roxell(a)linaro.org>
Date:   Tue Sep 4 12:47:21 2018 +0200

    selftests: add headers_install to lib.mk


maybe we can use this to avoid this "#include foo.h -> #ifndef foo ->
#define foo -> #endif" pattern?

any feedback appreciated, thanks
-- =

davide


--===============1039971696921448333==--
