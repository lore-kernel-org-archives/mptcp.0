Content-Type: multipart/mixed; boundary="===============0550818715199707972=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH 0/3] Change sock->sk_protocol to a 16-bit value
Date: Fri, 28 Jun 2019 11:59:30 +0200
Message-ID: <14ea07f9-bcf4-b6d2-7d21-ede5356d0682@tessares.net>
In-Reply-To: 20190621235534.19690-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1452

--===============0550818715199707972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 22/06/2019 01:55, Mat Martineau wrote:
> While debugging socket state transitions in MPTCP sockets, I found that
> MPTCP sockets were listing IPPROTO_TCP as their protocol in
> /sys/kernel/debug/tracing/trace. sock->sk_protocol was only 8 bits wide,
> truncating the new value of IPPROTO_MPTCP (0x0106) to IPPROTO_TCP
> (0x06).
> =

> The networking code has varying integer widths for 'protocol' at
> different layers:
> =

>  * POSIX socket API: 32 bits
>  * sk_buff->protocol: 16 bits
>  * IP header (on the wire): 8 bits
> =

> MPTCP shows a use for protocol values outside those that fit in an IP
> header. The change to struct sock fills an 8-bit hole, so there is no
> change in the size of the structure.
> =

> Given that we are currently discussing the appropriate value for
> IPPROTO_MPTCP, I'm sending this as an RFC to inform those discussions. I
> had previously thought that the 16-bit value for IPPROTO_MPTCP was
> compatible with the existing code base.
> =

> Mat Martineau (3):
>   net: Make sock protocol value checks more specific
>   sock: Make sk_protocol a 16-bit value
>   net: Add IPPROTO_MPTCP to inet_sock_set_state tracepoint output

Thank you for the patches!

As discussed yesterday, we said it is OK to add them in our repo and
wait for feedback from maintainers later.

I added the 2 firsts ones just before "tcp: Define IPPROTO_MPTCP" and
"squashed" the last one in "tcp: Define IPPROTO_MPTCP", see
a4ed239bad09. The result is visible there: 7312e2219900..78d9680a7731

I hope it is what you had in mind, I can of course change that later if
needed.

Tests are still OK!

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0550818715199707972==--
