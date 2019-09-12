Content-Type: multipart/mixed; boundary="===============0320044399580508042=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] mptcp: allow dumping subflow context to
 userspace
Date: Thu, 12 Sep 2019 19:34:29 +0200
Message-ID: <2f5b76fd-cf9f-777d-45ab-4439fbd66a95@tessares.net>
In-Reply-To: c2abb5d4494fb687eb394f7e5b90c35ee01060e2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1831

--===============0320044399580508042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

Thank you for sharing this patch and thank you for looking at that!

On 12/09/2019 18:57, Davide Caratti wrote:
> On Thu, 2019-09-12 at 18:50 +0200, Davide Caratti wrote:
>> add ulp-specific diagnostic functions, so that subflow information can be
>> dumped to userspace programs like 'ss'.
> =

> for the record: iproute2 support is also on the way, but also in this case
> the first step will be in ktls. This patch exposes token, local/remote
> keys, and some of the bitfield members. What do you think it's reasonable
> exposing to users of 'ss -i' ?

That looks good to start! I guess later we can expose more info like the
number of subflows, if there was a fallback to TCP (or maybe non
relevant?), the version of MPTCP and other info we store in the MPTCP
socket structure, etc.

Also, do you think it is possible to restrict the informations that are
shared depending on the capabilities of the requester?

A bit like what happened on the out-of-tree implementation with this
famous (for us) commit:

	https://github.com/multipath-tcp/mptcp/commit/e993b775d8abda23

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0320044399580508042==--
