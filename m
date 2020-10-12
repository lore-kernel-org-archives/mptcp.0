Content-Type: multipart/mixed; boundary="===============4492466719952149920=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/2] mptcp: mp join fallback fixes.
Date: Mon, 12 Oct 2020 14:58:42 +0200
Message-ID: <d39326ca-df41-e9a6-278d-46dfa0b23ec4@tessares.net>
In-Reply-To: 0c80e4568977c87fe9041bf9ed682a519516b739.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6288

--===============4492466719952149920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 08/10/2020 22:38, Paolo Abeni wrote:
> On Thu, 2020-10-08 at 22:34 +0200, Paolo Abeni wrote:
>> This solves issues/91 for me at least. Targeting upstream -net.
>> As such, patches based on the "bottom" of current export branch,
>> so that should apply cleanly on current -net.
>>
>> Note that rebasing on top of patch 2 "mptcp: refactor shutdown and close=
",
>> we must change the value of the macro MPTCP_WORKER_RUNNING (5 -> 6)
>>
>> The problem fixed by patch 2/2 already exist in the curren export/net
>> branches - is quite rare, but is more visible after patch 1/2.
>>
>> This iteration addresses the comment from Mat on patch 2/2
>>
>> Paolo Abeni (2):
>>    mptcp: fix fallback for MP_JOIN subflows
>>    mptcp: subflows garbage collection
>>
>>   net/mptcp/options.c  | 32 +++++++++++++++++++++++++-------
>>   net/mptcp/protocol.c | 18 ++++++++++++++++++
>>   net/mptcp/protocol.h |  2 ++
>>   net/mptcp/subflow.c  | 16 ++++++++++++++--
>>   4 files changed, 59 insertions(+), 9 deletions(-)
> =

> whoops, I did not edit the subj, this is a v2 of:
> =

> https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/RVEZWTSU=
WCZZ2CIM3G23ODLNA4PPKGCP/

FYI, I just applied at the bottom of the "export" branch the version you =

sent upstream:

- db2de27c5906: mptcp: fix fallback for MP_JOIN subflows
   - Note: I had to fix a simple conflict in protocol.h

- 7a314484c7f7: mptcp: subflows garbage collection

- 0b5ccff33117: conflict in t/mptcp-refactor-shutdown-and-close

- Results: 91d38a7ab17e..354a916e9e76

Tests + export are going to be started soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4492466719952149920==--
