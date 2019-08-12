Content-Type: multipart/mixed; boundary="===============6035250325495309478=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 08/10] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Mon, 12 Aug 2019 21:36:19 +0200
Message-ID: <c3f0d83a-aa56-7ca3-b975-d79d262de47d@tessares.net>
In-Reply-To: 20190807224434.2829-9-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1623

--===============6035250325495309478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/08/2019 00:44, Peter Krystad wrote:
> Subflow creation may be initiated by the path manager when
> the primary connection is fully established and a remote
> address has been received via ADD_ADDR.
> =

> Create an in-kernel sock and use kernel_connect() to
> initiate connection. When a valid SYN-ACK is received the
> new sock is added to the tail of the mptcp sock conn_list
> where it will not interfere with data flow on the original
> connection.
> =

> Data flow and connection failover not addressed by this commit.

Thank you for the patch and the reviews!

Added at the end of the series:
- 31bf10533d43: "new commit" in
t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 417bdddfeedd..f7d9e8ce4717: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6035250325495309478==--
