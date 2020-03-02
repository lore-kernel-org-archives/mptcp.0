Content-Type: multipart/mixed; boundary="===============0862322313353382786=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: disable two unstable mptcp_join tests
Date: Mon, 02 Mar 2020 17:11:08 +0100
Message-ID: <81b4a085-0e1d-4481-68c5-f8aedc0292f7@tessares.net>
In-Reply-To: b2cf7a3358172f0a7b9aae6223dfb9d48950438c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3845

--===============0862322313353382786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 02/03/2020 17:07, Paolo Abeni wrote:
> On Mon, 2020-03-02 at 17:03 +0100, Matthieu Baerts wrote:
>> They are currently unstable. Paolo is looking at them.
>>
>> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
>> Fixes: a17132c420b0 (selftests: add test-cases for MPTCP MP_JOIN)
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> =

> Well, they are actually stable: they fail with 100% accuracy ;)

Indeed, I just updated the commit message with s/unstable/failing to =

clarify this :)

- 118f5a4e2a1b: "squashed" in "selftests: add test-cases for MPTCP MP_JOIN"
- no signed-off-by added, that's temporary
- ee3a464ce517..b48bbfeadf3b: result

Tests + export will be launched soon.

> Looking to re-enable them ASAP, but will take time (we need correct and
> accurate fourth ack handling/3rd ack retransmission)

Thank you for looking at this complex part!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0862322313353382786==--
