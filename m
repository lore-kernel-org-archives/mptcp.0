Content-Type: multipart/mixed; boundary="===============3610455003390113789=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: use
 WRITE_ONCE/READ_ONCE for the pernet *_max"
Date: Tue, 02 Feb 2021 17:02:01 +0100
Message-ID: <60c71a60-8cc3-f69d-1154-5323d3e3aa97@tessares.net>
In-Reply-To: 13ed1e0-4d0-ced2-199d-a86394a78c1b@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7592

--===============3610455003390113789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 01/02/2021 23:21, Mat Martineau wrote:
> On Sun, 31 Jan 2021, Geliang Tang wrote:
> =

>> As Jakub suggested, drop all the READ_ONCEs in the original patch.

Thank you for the patch and the review!

>> And the commit message needs to be updated too:
>>
>> -
>>
>> Subject: mptcp: use WRITE_ONCE for the pernet *_max
>>
>> This patch uses WRITE_ONCE() for all the pernet add_addr_signal_max,
>> add_addr_accept_max, local_addr_max and subflows_max fields in struct
>> pm_nl_pernet to avoid concurrency issues.
>>
>> -
>>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>> ---
>> net/mptcp/pm_netlink.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
> =

> Yes, Jakub was correct to point out that READ_ONCE() isn't needed when =

> all of the writes are done with the lock held.
> =

> I'll go ahead and apply this locally and resubmit v2 now. Matthieu, I =

> guess you should apply as well so the topgit tree updates correctly when =

> the patches are applied on net-next.

Done:

- 04e13b990f05: "squashed" in "mptcp: use WRITE_ONCE/READ_ONCE for the =

pernet *_max"
- e82ca37a5376: tg:msg: reflect modif from prev commit
- Results: 4c0c22889ac1..b7b5f6b202bf

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3610455003390113789==--
