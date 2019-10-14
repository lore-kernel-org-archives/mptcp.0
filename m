Content-Type: multipart/mixed; boundary="===============1350148165540100194=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] Interim Path Manager
Date: Mon, 14 Oct 2019 18:36:08 +0200
Message-ID: <7d7d6eae-f038-27d0-427e-571b0811e5f2@tessares.net>
In-Reply-To: fa075b41d8c5ddc20037031633dc3396989c4cbe.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2112

--===============1350148165540100194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 14/10/2019 13:29, Paolo Abeni wrote:
> Hi,
> =

> On Tue, 2019-09-17 at 11:37 -0700, Peter Krystad wrote:
>> Patchset includes the interim path manager plus sysctl setting of
>> the announce address and binding local address when creating subflows.
>> I also split the path manager into a seperate file.
>>
>> v2:
>>    rename to 'basic' path manager
>>    remove pm_init definition
>>      =

>> Peter Krystad (2):
>>    mptcp: Minor changes to path manager interface
>>    mptcp: Implement basic path manager
>>
>>   net/mptcp/Makefile   |   2 +-
>>   net/mptcp/basic.c    | 247 +++++++++++++++++++++++++++++++++++++++++++
>>   net/mptcp/pm.c       |  38 +++++--
>>   net/mptcp/protocol.c |   2 +-
>>   net/mptcp/protocol.h |  14 ++-
>>   5 files changed, 290 insertions(+), 13 deletions(-)
>>   create mode 100644 net/mptcp/basic.c
> =

> I'm sorry for lagging behind so much.
> =

> I'm ok with the patches in the current status - even if I fear some
> rebasing will be now need, perhaps good Matt can take that bourden, too
>   - since he called me 'lawyer' I feel less guilty asking that ;)

Yes my Lord!

Thank you for the patch and the plea (review?)!

- e3c637f02e45: "squashed" (including a rebase) the first part of the =

first patch in "mptcp: Add path manager interface"
- 232953cffb3b: "squashed" (including a rebase) the second part of the =

first patch in "mptcp: Implement path manager interface commands". Note =

I had a conflict: addr->s_addr is stored in network bytes order.
- 250376a152f7: added (including a rebase) the second patch at the end =

(should I move it somewhere else?)
- 5cfa9c11a52f: fix compilation errors (due to changes made since the =

patch has been sent here)

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1350148165540100194==--
