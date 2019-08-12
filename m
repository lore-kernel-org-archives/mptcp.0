Content-Type: multipart/mixed; boundary="===============1840481749963491099=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 10/10] mptcp: Implement path manager interface
 commands
Date: Mon, 12 Aug 2019 21:36:33 +0200
Message-ID: <8f8e981a-637a-0292-c560-22cb1685cfde@tessares.net>
In-Reply-To: 20190807224434.2829-11-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1625

--===============1840481749963491099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/08/2019 00:44, Peter Krystad wrote:
> Use the addr_signal flag to indicate to the subflow layer
> that a local address may be announced, and call subflow_connect()
> to initiate a secondary subflow.

Thank you for the patch and the reviews!

Added at the end of the series:
- 9ad3c22dcab0: "new commit" in
t/mptcp-Implement-path-manager-interface-commands
- f7d9e8ce4717..2038a22e9690: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1840481749963491099==--
