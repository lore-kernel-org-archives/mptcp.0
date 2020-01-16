Content-Type: multipart/mixed; boundary="===============1361302452221866637=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Handle subflow join failures
Date: Thu, 16 Jan 2020 17:43:41 +0100
Message-ID: <17efebcc-626c-33b6-67a2-c7cb4876e3a9@tessares.net>
In-Reply-To: a9a3e3518641f1ddc9721438a4fa117ccb911e34.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3378

--===============1361302452221866637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 15/01/2020 09:41, Paolo Abeni wrote:
> On Tue, 2020-01-14 at 14:57 +0100, Florian Westphal wrote:
>> squashto: mptcp: Add handling of outgoing MP_JOIN requests
>>
>> When the join request fails we should send a reset and also
>> close the socket, we can't do anything useful with such a
>> connection.

[...]

> LGTM! It's nice to remove that old todo ;)
Thank you for the patch and the review!

- cc94bbe4718f: "squashed" in "mptcp: Add handling of outgoing MP_JOIN =

requests"
- 704e4fa8a50c..4fe8bda1127e: result

Tests + export will be launched soon!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1361302452221866637==--
