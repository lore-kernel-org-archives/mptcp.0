Content-Type: multipart/mixed; boundary="===============1985107740543906745=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/5] mptcp: Make MPTCP IPv6 support depend on
 CONFIG_IPV6=y
Date: Wed, 13 Nov 2019 18:49:08 +0100
Message-ID: <d1962731-ff7f-6f05-ac86-6de5daca6715@tessares.net>
In-Reply-To: 3982a9f8e5fc16bd94b1a956513ff5106a5930ae.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2514

--===============1985107740543906745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 06/11/2019 09:24, Paolo Abeni wrote:
> On Tue, 2019-11-05 at 11:05 -0800, Peter Krystad wrote:
>> Do not allow MPTCP IPv6 support if IPv6 is included as a module.
>>
>> squashto: Add MPTCP socket stubs
>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> =

> Series LGTM, thanks for the detailed squashing guidance!

Thank you for the series and the reviews!

- 33ed5b5b51bf: "squashed" patch 1/5 in "mptcp: Add MPTCP socket stubs"
- 9e9c548823d0: "squashed" patch 2/5 in "mptcp: Add handling of outgoing =

MP_JOIN requests"
- 34ccdbb3a9aa: "squashed" patch 3/5 in "mptcp: Add path manager interface"
- 85084e907807: "squashed" patch 4/5 in "mptcp: Add ADD_ADDR handling"
- e4a3b46641e1: "squashed" patch 5/5 in "mptcp: Implement basic path =

manager"
- e225da73a467..f3e04ebb0c5a: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1985107740543906745==--
