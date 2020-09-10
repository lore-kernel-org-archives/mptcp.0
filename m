Content-Type: multipart/mixed; boundary="===============2377188679745668555=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Thu, 10 Sep 2020 21:22:13 +0200
Message-ID: <c4ed5840-a2ff-8dc9-1298-76c94124d319@tessares.net>
In-Reply-To: CA+WQbwuwJZYybKPJqpC2dKLyAvdH8qHpeLsb0JmnyG7P9yNm2A@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5790

--===============2377188679745668555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 08/09/2020 08:56, Geliang Tang wrote:
> Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=881:07=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:40=E5=86=99=E9=81=93=EF=BC=
=9A
>>>
>>> v9:
>>>   - update patch 3/8, simply call mptcp_pm_nl_rm_subflow_received.
>>>   - update patch 5/8, use the reverse x-mas tree order.
>>>   - this patchset should be applied after the applying of my another
>>>     patchset, 'add ADD_ADDR echo flag support'.
>>>
>>> v8:
>>>   - drop anno_list in v7.
>>>     We don't need to add a new list, conn_list is enough for the signal
>>> address and local subflow.
>>>   - fix local_id and remote_id issues.
>>>     The RM_ADDR logic uses an address id to identify the removing
>>> address, so we must make sure the subflow's local_id and remote_id be
>>> set properly.
>>>   - fix mptcp_pm_nl_rm_addr_received logic issue
>>>   - update selftests
>>>
>>> v7:
>>>   - add RM_ADDR mib
>>>   - update RM_ADDR selftests test case
>>>
>>> v6:
>>>   - rename lookup_anno_list_by_saddr to remove_anno_list_by_saddr as
>>>     Paolo suggested.
>>>   - add msk socket lock when traverse msk->conn_list as Paolo suggested.
>>>   - Since the first three patches in v5 have been merged to export
>>>     branch, drop them from this patchset.
>>>   - add remove addr and subflow selftest test case.
>>>   - this patchset is against mptcp_net-next's export branch.
>>>
>>> v5:
>>>   - merge mptcp_nl_remove_subflow() and mptcp_nl_remove_addr()
>>>   - add cond_resched
>>>   - reduce the indentation level in mptcp_pm_nl_rm_addr_received
>>>
>>> v4:
>>>   - update mptcp_subflow_shutdown()'s args.
>>>   - add rm_id check to make sure we don't shutdown the first subflow.
>>>   - add conn_list empty check.
>>>   - move anno_list to mptcp_pm_data.
>>>   - add a new patch 'mptcp: add remove subflow support'.
>>>
>>> v3:
>>>   - fix memory leak and lock issue in v2.
>>>   - drop alist in v2.
>>>   - fix mptcp_subflow_shutdown's arguments.
>>>   - bzero remote in mptcp_pm_create_subflow_or_signal_addr.
>>>   - add more commit message.
>>>
>>> Geliang Tang (8):
>>>    1/8 mptcp: remove addr and subflow in PM netlink
>>>    2/8 mptcp: fix mptcp_pm_nl_rm_addr_received logic issue
>>>    3/8 mptcp: implement mptcp_pm_remove_subflow
>>>    4/8 mptcp: fix every subflow's local_id is zero
>>>    5/8 mptcp: fix subflow's remote_id is zero issue
>>>    6/8 mptcp: add RM_ADDR related mibs
>>>    7/8 selftests: mptcp: add remove cfg in mptcp_connect
>>>    8/8 selftests: mptcp: add remove addr and subflow test cases

Thank you for the patches and the reviews!

>>
>> Hi Paolo, Matt,
>>
>> I want to adjust some code in this patchset.
>>
>> I think patch 2/8 "mptcp: fix mptcp_pm_nl_rm_addr_received logic issue"
>> shouldn't be here, it's better to squash-to the original commit "mptcp: =
add
>> the incoming RM_ADDR support".
>>
>> So I have sent out a new patch named 'Squash-to: "mptcp: add the incoming
>> RM_ADDR support"' yesterday.
>>
>> And I want to commit patch 4/8 "mptcp: fix every subflow's local_id is z=
ero"
>> and 5/8 "mptcp: fix subflow's remote_id is zero issue" directly to -net =
as Paolo
>> suggested. Some code about subflow's remote_id fixing in the commit "mpt=
cp:
>> add the incoming RM_ADDR support" should be put together in patch 5/8.
>> So in the squash-to patch, I drop the original subflow's remote_id fixin=
g code.
>>
>> Please give me some suggestions about my squash-to patch.
>>
>> Thanks.
>> -Geliang
>>
> =

> Hi Matt, Paolo,
> =

> After this code adjusting, the valid patches in this "RM_ADDR
> support" patchset v9 are these 8 patches:
> =

>   Squash-to: "mptcp: add the incoming RM_ADDR support"

Applied, see my previous message on the ML for more details.

>   mptcp: remove addr and subflow in PM netlink

Applied here with Paolo's ACK.

>   Squash-to: "mptcp: remove addr and subflow in PM netlink v9"

Not applied, waiting for Paolo's ACK. He will do that when this series =

is applied and validated by the CI

>   mptcp: implement mptcp_pm_remove_subflow

Applied here but without Paolo's ACK, see below.

>   Squash-to: "mptcp: implement mptcp_pm_remove_subflow v9"

I had to apply this one, required by the next patch. Because it was not =

ACKed by anyone on the ML so far, I didn't add any ACK here. I can add =

one later if needed.

>   mptcp: add RM_ADDR related mibs

Applied here with Paolo's ACK.
Note that because I applied this series before the xmit one, I had to =

resolve two simple conflicts:

- 2c9aa6f86e74: conflict in t/mptcp-add-OoO-related-mibs

>   selftests: mptcp: add remove cfg in mptcp_connect
>   selftests: mptcp: add remove addr and subflow test cases

These 2 have been applied here with Paolo's ACK.

> These 3 patches should be removed from this patchset:
>   mptcp: fix mptcp_pm_nl_rm_addr_received logic issue
>   mptcp: fix every subflow's local_id is zero
>   mptcp: fix subflow's remote_id is zero issue

Note that I applied the patches you sent to netdev ML for -net. So a =

part of them are also in the export branch.

- 377cd31c5d51..95751f085d69: results

Tests + export are queued.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2377188679745668555==--
