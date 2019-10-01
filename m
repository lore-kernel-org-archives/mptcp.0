Content-Type: multipart/mixed; boundary="===============2019344064509244495=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: prefix subflow routines with mptcp_
Date: Tue, 01 Oct 2019 10:16:21 +0200
Message-ID: <278aabfa-6ee3-995a-7bd4-5618fd6796f0@tessares.net>
In-Reply-To: 20190930214336.GC14819@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1970

--===============2019344064509244495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 30/09/2019 23:43, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Hello,
>>
>> As planned, I looked at prefixing with mptcp_ all exposed subflow_xxx()
>> routines (functions and structures).
> =

> [..]
> =

>> It is quite big but I only renamed functions and structures and
>> sometimes moved functions to keep the reversed Xmas tree.
> =

> Yes, can't be avoided.  Thanks for keeping xmas tree formatting.
> =

> Looks good to me, thank you for doing this.

Thank you for your quick review!

result: 08867957be0e..3d566a4b1ebc

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2019344064509244495==--
