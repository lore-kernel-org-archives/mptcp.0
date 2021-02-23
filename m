Content-Type: multipart/mixed; boundary="===============2193736160751160411=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix memory accounting on
 allocation error
Date: Tue, 23 Feb 2021 08:30:45 +0100
Message-ID: <bf698fbc-55a5-2f6a-fad6-cf2f714b0169@tessares.net>
In-Reply-To: f3643a261e8467e56de23145f48b28fb641f5686.1613760037.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7914

--===============2193736160751160411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat, Christoph,

On 19/02/2021 19:42, Paolo Abeni wrote:
> In case of memory pressure the MPTCP xmit path keeps
> at most a single skb in the tx cache, eventually freeing
> additional ones.
> =

> The associated counter for forward memory is not update
> accordingly, and that causes the following splat:

Thank you for the patch, validation and review!

With a bit of delay, sorry for that, it is now in our tree with Mat's =

RvB tag:

- 8c45b9293d02: mptcp: fix memory accounting on allocation error
- Results: f6e0fb5d6125..b5622a37311b

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2193736160751160411==--
