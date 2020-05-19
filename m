Content-Type: multipart/mixed; boundary="===============3441840503389783441=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use rightmost 64 bits in
 ADD_ADDR HMAC
Date: Tue, 19 May 2020 17:11:09 +0200
Message-ID: <7dd1f4ae-c6dd-c1f9-375c-d644cf7e8b22@tessares.net>
In-Reply-To: 20200519003050.GW45434@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4418

--===============3441840503389783441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Todd,

On 19/05/2020 02:30, Christoph Paasch wrote:
> On 18/05/20 - 15:29:16, Todd Malsbary wrote:
>> This changes the HMAC used in the ADD_ADDR option from the leftmost 64
>> bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.
>>
>> Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
> =

> Nice find!

Yes, good catch!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

I guess we should send that to -net branch, ideally before the release =

of v5.7, not to introduce incompatibilities between versions. What do =

you think?

 > I found this while adding support to packetdrill for the ADD_ADDR v1
 > option.  The computation I used for the HMAC in the pending
 > packetdrill work gave a different result than what was being computed
 > by the kernel.

Good to hear you are looking at adding ADD_ADDRv1 support to packetdrill! :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3441840503389783441==--
