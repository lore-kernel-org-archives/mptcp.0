Content-Type: multipart/mixed; boundary="===============2682390911176271526=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Move subflow ipv6 code earlier in subflow.c
Date: Mon, 20 Jan 2020 17:04:37 +0100
Message-ID: <6b01cb15-604d-c4c1-922c-ea94cf5fad7a@tessares.net>
In-Reply-To: c4b67714d7dc21e184e02570c7ebd1468c470baf.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3429

--===============2682390911176271526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 19/01/2020 15:10, Paolo Abeni wrote:
> On Fri, 2020-01-17 at 16:58 -0800, Mat Martineau wrote:
>> This prevents some diff noise in "mptcp: Implement MPTCP receive path",
>> where the code is currently moved.
>>
>> squashto: "mptcp: Handle MP_CAPABLE options for outgoing connections"
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> =

> LGTM! yep, noise in later patch make the latter much less unreadable.
> =

> Thanks for addressing that!

Thank you for the patch and the review!

- 3d4edf2302a5: "squashed" in "mptcp: Handle MP_CAPABLE options for =

outgoing connections"
- b6685f0043f6: conflict in t/mptcp-Implement-MPTCP-receive-path
- d23bb6b15878..485d1d576dcd: result (empty, as expected, no?)

But now, t/mptcp-Implement-MPTCP-receive-path is indeed cleaner

Tests + export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2682390911176271526==--
