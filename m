Content-Type: multipart/mixed; boundary="===============6279012809747986206=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fix state update on accept()
Date: Fri, 10 May 2019 13:02:25 +0200
Message-ID: <58e12b5a-7fcc-b157-e615-41a2f1d36cd0@tessares.net>
In-Reply-To: bd845eebe7d58a27e8ff603d4aa4e1c9bbd9b9fe.1557420146.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1141

--===============6279012809747986206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 09/05/2019 18:43, Paolo Abeni wrote:
> We must update the newly created socket status, not the listener
> socket.
> =

> Fixes: cc0d09002896 ("mptcp: Implement MPTCP receive path")

Good catch, thank you for the fix!

Just added in the repo!

- fix: de8f56a9b08849ca7a1b86782de0dab9b1c959fd
- sign-off added: 54cae76d4cfcc093bacc82830bb7c04a5c5a08ef
- no conflicts

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6279012809747986206==--
