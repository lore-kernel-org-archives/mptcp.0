Content-Type: multipart/mixed; boundary="===============0043482928992559033=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v7 02/11] sock: Make sk_protocol a 16-bit
 value
Date: Thu, 09 Jan 2020 18:43:40 -0800
Message-ID: <20200109.184340.89665512479537332.davem@davemloft.net>
In-Reply-To: 20200109212528.GF795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3340

--===============0043482928992559033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>
Date: Thu, 9 Jan 2020 22:25:28 +0100

> If you think such a size increase is ok I could give that solution a shot
> and see what other problems with 8bit sk_protocol might remain.
> =

> Mat reported /sys/kernel/debug/tracing/trace lists mptcp sockets as
> IPPROTO_TCP in the '8 bit sk_protocol' case, but if thats the only issue
> this might have a smaller/acceptable "avoidance fix".

Ok I'll apply the current series as-is with the 16-bit sk_protocol.  Let's
see how this goes in practice.

Thanks for explaining.
--===============0043482928992559033==--
