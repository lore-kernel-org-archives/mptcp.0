Content-Type: multipart/mixed; boundary="===============3962545060049506919=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/3] mptcp: move MPTCP option bits to internal
 header
Date: Fri, 21 Jun 2019 11:43:24 +0200
Message-ID: <d165915e-7ec7-ace6-e08d-cccb197917d8@tessares.net>
In-Reply-To: alpine.OSX.2.21.1906200946330.44348@kdmease-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1438

--===============3962545060049506919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 20/06/2019 18:47, Mat Martineau wrote:
> =

> On Thu, 20 Jun 2019, Matthieu Baerts wrote:
> =

>> All these OPTION_MPTCP_* are only used in files from net/mptcp.
>>
>> There are 3 commits to ease the squash.
>>
>> Matthieu Baerts (3):
>> =C2=A0mptcp: move MPTCP option bits to internal header
>> =C2=A0mptcp: move MPTCP option bits to internal header
>> =C2=A0mptcp: move MPTCP option bits to internal header
>>
>> include/net/mptcp.h=C2=A0 | 11 -----------
>> net/mptcp/protocol.h | 12 ++++++++++++
>> 2 files changed, 12 insertions(+), 11 deletions(-)
>> --=C2=A0
>> 2.20.1
>>
> =

> I'm fine with moving all of these.

Thank you for your review!

- 72e69070c069: "squashed" 1st patch in "mptcp: Handle MPTCP TCP options"
- da16677a71a3: conflict in t/mptcp-Add-MPTCP-to-skb-extensions
- 8c2710489adb: conflict in
t/mptcp-Make-connection_list-a-real-list-of-subflows
- c5ab047d1760: conflict in t/mptcp-Add-ADD_ADDR-handling
- 6f0546582f94 + d589ed1f7d35: "squashed" 2nd patch in "mptcp: Add
ADD_ADDR handling"
- 90e85b0d709c: conflict in
t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 9395816292b8: "squashed" 3rd patch in "mptcp: Add handling of incoming
MP_JOIN requests"
- eefaf0b9e6f7..2c024529510e: result

Compilation is still OK.

Cheers,
Matt

> Thanks,
> =

> -- =

> Mat Martineau
> Intel

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3962545060049506919==--
