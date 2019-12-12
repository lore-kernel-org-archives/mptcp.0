Content-Type: multipart/mixed; boundary="===============5416017399748864027=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: do not orphan the ssk before tcp_close()
Date: Fri, 13 Dec 2019 00:10:46 +0100
Message-ID: <c313911a-23ce-cb27-ec30-820d0ff74dbf@tessares.net>
In-Reply-To: 7a04a30700ceefe9dfb77646d203e9b2c6e4de23.1576173332.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2903

--===============5416017399748864027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 12/12/2019 18:57, Paolo Abeni wrote:
> This close the following race
> =

> CPU 0				CPU 1
> sock_orphan()
> 	// SOCK_DEAD
> 				tcp_done()
> 					inet_csk_destroy_sock()
> 						sock_put()
> =

> tcp_close()
> 	// UAF
> =

> Note that we can't acquire an additional ref to the
> sock before sock_orphan() and releasing it after close,
> such ref will be consumed by inet_csk_destroy_sock when
> the race is triggered.
> =

> Squash-to: "mptcp: Handle MP_CAPABLE options for outgoing connections"

Good catch! Thank you for the patch, the review and the suggestion!

- 5d1ef098aee9: "squashed" in "mptcp: Handle MP_CAPABLE options for =

outgoing connections"
- 3549fa17fbd3..1cb1c55ccee7: result

I am going to run tests now.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5416017399748864027==--
