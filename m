Content-Type: multipart/mixed; boundary="===============0448534201699176079=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: interpret \n as a new
 line
Date: Tue, 06 Oct 2020 18:12:45 +0200
Message-ID: <c750c3256bec4ceab91a95f2725e4bc026f4b5dc.camel@redhat.com>
In-Reply-To: 20201006160631.3987766-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6227

--===============0448534201699176079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-10-06 at 18:06 +0200, Matthieu Baerts wrote:
> In case of errors, this message was printed:
> =

>   (...)
>   balanced bwidth with unbalanced delay       5233 max 5005  [ fail ]
>   client exit code 0, server 0
>   \nnetns ns3-0-EwnkPH socket stat for 10003:
>   (...)
> =

> Obviously, the idea was to add a new line before the socket stat and not
> print "\nnetns".
> =

> The commit 8b974778f998 ("selftests: mptcp: interpret \n as a new line")
> is very similar to this one. But the modification in simult_flows.sh was
> missed because this commit above was done in parallel to one here below.
> =

> Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============0448534201699176079==--
