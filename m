Content-Type: multipart/mixed; boundary="===============6128295848408841669=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: interpret \n as a new
 line
Date: Thu, 17 Sep 2020 16:26:35 -0700
Message-ID: <20200917.162635.1949227267966227941.davem@davemloft.net>
In-Reply-To: 20200916131352.3072764-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5922

--===============6128295848408841669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Wed, 16 Sep 2020 15:13:51 +0200

> In case of errors, this message was printed:
> =

>   (...)
>   # read: Resource temporarily unavailable
>   #  client exit code 0, server 3
>   # \nnetns ns1-0-BJlt5D socket stat for 10003:
>   (...)
> =

> Obviously, the idea was to add a new line before the socket stat and not
> print "\nnetns".
> =

> Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
> Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied.
--===============6128295848408841669==--
