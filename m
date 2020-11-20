Content-Type: multipart/mixed; boundary="===============0114351843744016450=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] squashto: mptcp: protect the rx path with
 the msk socket spinlock
Date: Fri, 20 Nov 2020 18:14:55 +0100
Message-ID: <e16e61c5-4c1c-5910-d263-b06ba92942a0@tessares.net>
In-Reply-To: 20201119234714.8519-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6881

--===============0114351843744016450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 20/11/2020 00:47, Florian Westphal wrote:
> Looks like the arguments are inverted.  Intention seems to move
> the msk rx queue to the sk one so it can be purged from the destroy
> function.

Thank you for the patch and the review!

- 86cb91bc831d: "squashed" (with conflicts) in "mptcp: protect the rx =

path with the msk socket spinlock"
- 35d1c3be69d3: "Signed-off-by" + "Co-developed-by"
- 6e9853431195: conflict in t/mptcp-use-mptcp-release_cb-for-delayed-tasks
- Results: 580a33433a07..b86f4581b5c3

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0114351843744016450==--
