Content-Type: multipart/mixed; boundary="===============1469479524087249881=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 01/13] selftest: add mmap-write support
Date: Wed, 20 Nov 2019 21:39:35 +0100
Message-ID: <20191120203935.GG20235@breakpoint.cc>
In-Reply-To: 1bee3b71-df45-26ce-2afb-3d862d4f40d4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2634

--===============1469479524087249881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools=
/testing/selftests/net/mptcp/mptcp_connect.sh
> > index b5367fe2c6ea..478bc47c3d60 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -3,7 +3,7 @@
> >   time_start=3D$(date +%s)
> > -optstring=3D"d:e:l:r:h6c"
> > +optstring=3D"b:d:e:l:r:h6c:m:"
> =

> Just a small detail but the capture (-c) option doesn't any argument. I
> guess we should also apply this:

> -optstring=3D"b:d:e:l:r:h4c:m:"
> +optstring=3D"b:d:e:l:r:h4cm:"
>  ret=3D0
>  sin=3D""
>  sout=3D""

Oh, absolutely.

Can you also apply this fixlet that Mat pointed out?

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -391,7 +391,7 @@ static int do_recvfile(int infd, int outfd)
        ssize_t r;
 =

        do {
-               char buf[16536];
+               char buf[16384];

Thanks!
--===============1469479524087249881==--
