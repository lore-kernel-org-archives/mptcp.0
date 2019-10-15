Content-Type: multipart/mixed; boundary="===============3927086218108589000=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: allow compilation on older systems
Date: Tue, 15 Oct 2019 12:26:45 +0200
Message-ID: <20191015102645.GP25052@breakpoint.cc>
In-Reply-To: 21331b88ba184186b74133fa6d31b5ed8fc1eb95.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2134

--===============3927086218108589000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Davide Caratti <dcaratti(a)redhat.com> wrote:
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -18,7 +18,8 @@
>  =

>  #include <netdb.h>
>  #include <netinet/in.h>
> -#include <netinet/tcp.h>
> +
> +#include <linux/tcp.h>
> =

> ^^ this ensures that TCP_ULP is defined, if the 'kernel-headers' package
> is newer than 4.13.

ii  linux-libc-dev:amd64            4.9.168-1+deb9u5               amd64
Linux support headers for userspace development

I don't care though, I can carry this patch in my private branch.
--===============3927086218108589000==--
