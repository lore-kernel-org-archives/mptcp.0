Content-Type: multipart/mixed; boundary="===============3350237622702963088=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Correctly handle port field in ADD_ADDR option
Date: Fri, 20 Mar 2020 23:03:03 +0100
Message-ID: <831f7800-df27-7d19-1f46-e4c6aff71d5d@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2003201216340.19124@mcgray1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4036

--===============3350237622702963088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat,

On 20/03/2020 20:17, Mat Martineau wrote:
> =

> On Fri, 20 Mar 2020, Peter Krystad wrote:
> =

>> Existing code allows ADD_ADDR option lengths that include the port field,
>> so we should correctly parse options with those lengths.
>>
>>
>> Peter Krystad (2):
>> =C2=A0mptcp: Parse optional port field of ADD_ADDR
>> =C2=A0mptcp: Include ADD_ADDR port value for path manager
>>
>> include/linux/tcp.h |=C2=A0 1 +
>> net/mptcp/options.c | 11 +++++++++++
>> 2 files changed, 12 insertions(+)
>>
> =

> Both patches look good to me - and they apply cleanly to the current =

> export branch.

Thank you for the patches and the reviews!

- 6b71141d6040: "squashed" patch 1/2 in "mptcp: Add ADD_ADDR handling"
- 49bd5a76f678..212bed34defa: result

- 3dc91a03e4e8: "squashed" patch 2/2 in "mptcp: Add path manager interface"
- 212bed34defa..19b9d67eec8a: result

Tests + export are in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3350237622702963088==--
