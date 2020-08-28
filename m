Content-Type: multipart/mixed; boundary="===============2226601210976059005=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: only wake parent if subflow is
 writable
Date: Fri, 28 Aug 2020 21:15:04 +0200
Message-ID: <ec89cc4d-e7c7-4bc4-b926-53c337284a7c@tessares.net>
In-Reply-To: 20200821132856.867-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5660

--===============2226601210976059005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 21/08/2020 15:28, Florian Westphal wrote:
> mptcp_connect.sh -d 10 -l 0 -r 0 -e "" -f $((100 * 1024 * 1024)) -m poll
> =

> will result in frequent write errors:
> ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP   write: Resource temporari=
ly unavailable
> =

> We promised write() would not block but then no subflow was ready
> to accept more data.
> =

> Changing the 'free' check to 'writeable' (which checks the available
> space is above min thresh) makes those errors go away.
> =

> Note that there are still poll timeouts:
> ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP   copyfd_io_poll: poll time=
d out (events: POLLIN 1, POLLOUT 0)
> copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
> =

> This appears unrelated, they also appear without this change.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Thank you for the patch and the review!

Applied at the end of the series.

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2226601210976059005==--
