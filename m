Content-Type: multipart/mixed; boundary="===============0078450746918858956=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: interpret \n as a new
 line
Date: Tue, 06 Oct 2020 18:17:37 +0200
Message-ID: <3f08a0d2-0761-1a31-5909-6c6d84e543e4@tessares.net>
In-Reply-To: 20201006145636.3863539-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6228

--===============0078450746918858956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 06/10/2020 16:56, Matthieu Baerts wrote:
> In case of errors, this message was printed:
> =

>    (...)
>    balanced bwidth with unbalanced delay       5233 max 5005  [ fail ]
>    client exit code 0, server 0
>    \nnetns ns3-0-EwnkPH socket stat for 10003:
>    (...)
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

Thank you for the review (on netdev).

I just added this patch in our Git tree.

- 8ddf02404ace: selftests: mptcp: interpret \n as a new line
- Results: 9984fc6a69ca..4d2f295912ab

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0078450746918858956==--
