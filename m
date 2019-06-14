Content-Type: multipart/mixed; boundary="===============8693798221841285249=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Change IPPROTO_MPTCP
Date: Fri, 14 Jun 2019 14:46:37 +0200
Message-ID: <66927244-eb25-b56a-742c-ea7535e1aa9e@tessares.net>
In-Reply-To: 20190612171643.21861-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1372

--===============8693798221841285249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 12/06/2019 19:16, Mat Martineau wrote:
> Instead of using 99 for IPPROTO_MPTCP (which IANA defines as "any
> private encryption scheme"), use 262 (0x100 | IPPROTO_TCP). The MPTCP
> self tests continue to run successfully with these changes.
> =

> Earlier in development we used 262 for IPPROTO_SUBFLOW as it would get
> truncated to 0x06 (IPPROTO_TCP) in the IP header. Now that
> IPPROTO_SUBFLOW has been removed in favor of using ULP, 262 is freed up
> for MPTCP.
> =

> Note that this does change the value of IPPROTO_MAX, and in reviewing
> the occurrences of that around the kernel most uses look fine.
> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c has one instance of IPPROTO_MAX
> where its meaning is not immediately obvious.
> =

> Mat Martineau (2):
>   squash-to: Define IPPROTO_MPTCP
>   squash-to: add basic kselftest program

Thank you for the patch.

- b2727bb697b3: "squash" of the first patch in "tcp: Define IPPROTO_MPTCP"
- signed-off was already there
- e993d4b99859: "squash" of the second patch in "mptcp: add basic
kselftest program"
- no conflict
- d44c2b144d8a..532214a3e83e: result

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8693798221841285249==--
