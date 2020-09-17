Content-Type: multipart/mixed; boundary="===============2906458419428168470=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: interpret \n as a new
 line
Date: Thu, 17 Sep 2020 10:17:35 +0200
Message-ID: <1cb1ca491d7ea2fb8a928c14a56e3a2a5c5e7917.camel@redhat.com>
In-Reply-To: 20200916131352.3072764-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5908

--===============2906458419428168470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-16 at 15:13 +0200, Matthieu Baerts wrote:
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

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============2906458419428168470==--
