Content-Type: multipart/mixed; boundary="===============5158115195590909361=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: exercise GSO,
 retransmission and reorder code path
Date: Tue, 21 May 2019 16:45:47 +0200
Message-ID: <19f6daab-98e1-a4d3-e849-b51511d0960a@tessares.net>
In-Reply-To: fda85f6ee549c41798923ae498d5efca09286752.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1212

--===============5158115195590909361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21/05/2019 15:55, Paolo Abeni wrote:
> On Tue, 2019-05-21 at 15:28 +0200, Matthieu Baerts wrote:
>> On 21/05/2019 12:51, Florian Westphal wrote:
>>> Thats another option, but I don't have a preference, your change is fine
>>> as-is.
>>
>> Paolo, do you want to change something or can I apply this patch?
> =

> If nobody opposes, I think it can go in as-is, thanks!

Great! If someone opposes, we can easily revert/modify later!

Just "squashed" into commit 40e8869bdd0f ("mptcp: selftests:
 switch to netns+veth based tests")

- squash: 2707b30453da
- signed-off: b23efa13d890
- no conflict: /
- export commit: fb5407ead32f

Cheers,
Matt

> =

> Paolo
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5158115195590909361==--
