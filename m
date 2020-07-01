Content-Type: multipart/mixed; boundary="===============8667926819927046173=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] selftests: mptcp: add option to
 specify size of file to transfer
Date: Wed, 01 Jul 2020 15:06:51 +0200
Message-ID: <1943d2bb-fc60-4614-07db-e56d7e3a824d@tessares.net>
In-Reply-To: 20200630192445.18333-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4883

--===============8667926819927046173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 30/06/2020 21:24, Florian Westphal wrote:
> The script generates two random files that are then sent via tcp and
> mptcp connections.
> =

> In order to compare throughput over consecutive runs add an option
> to provide the file size on the command line: "-f 128000".
> =

> Also add an option, -t, to enable tcp tests. This is useful to
> compare throughput of mptcp connections and tcp connections.
> =

> Example: run tests with a 4mb file size, 300ms delay 0.01% loss,
> default gso/tso/gro settings and with large write/blocking io:
> =

> mptcp_connect.sh -t -f $((4 * 1024 * 1024)) -d 300 -l 0.01%  -r 0 -e "" -=
m mmap
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Thank you for the patch! The new '-t' option was also very helpful when =

investigating the issue 6 on Github!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8667926819927046173==--
