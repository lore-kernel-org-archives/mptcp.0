Content-Type: multipart/mixed; boundary="===============4922694895115222726=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: do not wakeup listener for MPJ
 subflows
Date: Tue, 23 Feb 2021 08:30:42 +0100
Message-ID: <e73e0cdd-6ed8-0989-668b-0b4b2be49859@tessares.net>
In-Reply-To: 78c7489cd28150c0c8a1433d3dd1546559688c20.1613652328.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7913

--===============4922694895115222726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 18/02/2021 13:45, Paolo Abeni wrote:
> MPJ subflows are not exposed as fds to user spaces. As such,
> incoming MPJ subflows are removed from the accept queue by
> tcp_check_req()/tcp_get_cookie_sock().
> =

> Later tcp_child_process() invokes subflow_data_ready() on the
> parent socket regardless of the subflow kind, leading to poll
> wakeups even if the later accept will block.
> =

> Address the issue double checking the queue state before
> waking the user-space.
Thank you for the patch and the review!

With a bit of delay, sorry for that, it is now in our tree with Mat's =

RvB tag:

- ecfdb48000c7: mptcp: do not wakeup listener for MPJ subflows
- Results: 356eae3ba43b..f6e0fb5d6125

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4922694895115222726==--
