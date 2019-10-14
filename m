Content-Type: multipart/mixed; boundary="===============1466852032177821668=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] mptcp: Implement basic path manager
Date: Mon, 14 Oct 2019 17:21:08 +0200
Message-ID: <1e2994c4-9fa8-0367-2336-577780c8fae5@tessares.net>
In-Reply-To: 20190917183750.2693-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2111

--===============1466852032177821668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 17/09/2019 20:37, Peter Krystad wrote:
> Two features: 1) After an incoming connection is fully established
> announce a second local address and 2) When an outgoing connection
> is fully established, and an ADD_ADDR option has been received,
> initiate a secondary subflow to that address.
> =

> The second local address may be configured through the
> net.mptcp.pm.announce_addr sysctl variable. If configured
> then for listeners this address will be announced with the
> ADD_ADDR option, and for clients the local socket will be bound
> to this address (or INADDR_ANY if not specified).

Just to sure: is the goal still not to upstream this patch? Just for our =

tests?

(If we want to upstream it, I would propose a few modifications, e.g. =

call the file pm_basic.c, add "pm_" in the name of the exported =

functions, etc.)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1466852032177821668==--
