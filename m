Content-Type: multipart/mixed; boundary="===============3498662570137738587=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/2] Squash-to: "mptcp:
 remove addr and subflow in PM netlink v9"
Date: Wed, 16 Sep 2020 18:10:49 +0200
Message-ID: <70dc9458-d070-bf97-1c5e-70350d3408cc@tessares.net>
In-Reply-To: f8233821-9715-8266-f52d-efacf0c09635@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5903

--===============3498662570137738587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 16/09/2020 15:17, Matthieu Baerts wrote:
> Hi Geliang,
> =

> On 16/09/2020 04:37, Geliang Tang wrote:
>> Hi Matt, Paolo,
>>
>> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=
=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A =

>> =E5=8D=884:26=E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> Hi Geliang, Paolo,
>>>
>>> On 15/09/2020 15:04, Paolo Abeni wrote:
>>>> On Tue, 2020-09-15 at 19:59 +0800, Geliang Tang wrote:
>>>>> v3:
>>>>> =C2=A0=C2=A0 - use "goto next" in mptcp_nl_remove_subflow_and_signal_=
addr
>>>>> =C2=A0=C2=A0 - update mptcp_destroy_common
>>>>>
>>>>> v2:
>>>>> =C2=A0=C2=A0 - add mptcp_pm_remove_anno_addr and update logic in
>>>>> =C2=A0=C2=A0 mptcp_nl_remove_subflow_and_signal_addr
>>>>> =C2=A0=C2=A0 - call mptcp_pm_free_anno_list in mptcp_destroy and =

>>>>> mptcp_sock_destruct
>>>>> =C2=A0=C2=A0 - add mptcp_destroy_common helper
>>>>>
>>>>> Geliang Tang (2):
>>>>> =C2=A0=C2=A0=C2=A0 Squash-to: "mptcp: remove addr and subflow in PM n=
etlink"
>>>>> =C2=A0=C2=A0=C2=A0 mptcp: add mptcp_destroy_common helper
>>>>>
>>>>> =C2=A0=C2=A0 net/mptcp/pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +
>>>>> =C2=A0=C2=A0 net/mptcp/pm_netlink.c | 91 =

>>>>> +++++++++++++++++++++++++++++++++++++++---
>>>>> =C2=A0=C2=A0 net/mptcp/protocol.c=C2=A0=C2=A0 | 10 ++++-
>>>>> =C2=A0=C2=A0 net/mptcp/protocol.h=C2=A0=C2=A0 |=C2=A0 3 ++
>>>>> =C2=A0=C2=A0 net/mptcp/subflow.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>>>>> =C2=A0=C2=A0 5 files changed, 98 insertions(+), 10 deletions(-)
>>>>>
>>>>
>>>> Both patches LGTM, thanks!
>>>
>>> Thank you for the patches and the review!
>>>
>>> Just to be sure, can I squash the two of them in the same "mptcp: remove
>>> addr and subflow in PM netlink" commit? (+ update the commit message as
>>> written in 1/2 patch)
>>
>> Please only squash 1/2 patch to "mptcp: remove addr and subflow in PM =

>> netlink"
>> commit. And apply patch 2/2 (mptcp: add mptcp_destroy_common helper) as a
>> new commit.
> =

> Thank you for the clarification.
> =

> - 96141df51494: "squashed" patch 1/2 in "mptcp: remove addr and subflow =

> in PM netlink"
> - 4c292fe817d5..79a312a49fee: result
> =

> The second patch has been added before your two commits modifying the =

> selftests.
> - 6d043d6c3dc2: mptcp: add mptcp_destroy_common helper
> - c3f59bbd90df..653f02bb3161: result
> =

> Tests + export are in progress.

It looks like these two patches are causing a crash:

   https://github.com/multipath-tcp/mptcp_net-next/issues/90

Sadly I always see that when I have to leave, I didn't investigate more =

so far nor removing the two patches.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3498662570137738587==--
