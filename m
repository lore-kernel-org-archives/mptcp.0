Content-Type: multipart/mixed; boundary="===============6474059228632278637=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 16:03:14 +0200
Message-ID: <b90ae5e6-9858-eccd-ef45-eb59250ae8a1@tessares.net>
In-Reply-To: 7ceabb97898fbcd06d6d746be96e29ffb2944613.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6221

--===============6474059228632278637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Paolo,

On 06/10/2020 15:07, Paolo Abeni wrote:
> On Tue, 2020-10-06 at 14:22 +0200, Davide Caratti wrote:
>> using packetdrill it's possible to observe the same MPTCP DSN being acked
>> by different subflows with DACK4 and DACK8. This is in contrast with what
>> specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64-bi=
t wide
>> DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix 'use_64bit_ack'
>> variable to make it a property of MPTCP sockets, not TCP subflows.
>>
>> Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> =

> LGTM, thanks Davide!

Thank you for the patch and the review!

@Davide: be careful that this patch doesn't apply as is on -net (or =

net-next). I had a small conflict when applying it on top of net-next, =

not at the end of the "export" branch?

- 79519fc3f520: net: mptcp: make DACK4/DACK8 usage consistent among all =

subflows
- be078f4e24b5: conflict in t/mptcp-refactor-shutdown-and-close
- Results: b74dfa0c4018..9984fc6a69ca

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6474059228632278637==--
