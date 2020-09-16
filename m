Content-Type: multipart/mixed; boundary="===============0074580253664000163=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/2] Squash-to: "mptcp:
 remove addr and subflow in PM netlink v9"
Date: Wed, 16 Sep 2020 15:17:07 +0200
Message-ID: <f8233821-9715-8266-f52d-efacf0c09635@tessares.net>
In-Reply-To: CA+WQbwv=gPBHpB-2QQtxV7qA=QWU_2Pg_c9anj02Vq8SiLHAKA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5900

--===============0074580253664000163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 16/09/2020 04:37, Geliang Tang wrote:
> Hi Matt, Paolo,
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=
=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:26=E5=86=99=E9=
=81=93=EF=BC=9A
>>
>> Hi Geliang, Paolo,
>>
>> On 15/09/2020 15:04, Paolo Abeni wrote:
>>> On Tue, 2020-09-15 at 19:59 +0800, Geliang Tang wrote:
>>>> v3:
>>>>    - use "goto next" in mptcp_nl_remove_subflow_and_signal_addr
>>>>    - update mptcp_destroy_common
>>>>
>>>> v2:
>>>>    - add mptcp_pm_remove_anno_addr and update logic in
>>>>    mptcp_nl_remove_subflow_and_signal_addr
>>>>    - call mptcp_pm_free_anno_list in mptcp_destroy and mptcp_sock_dest=
ruct
>>>>    - add mptcp_destroy_common helper
>>>>
>>>> Geliang Tang (2):
>>>>     Squash-to: "mptcp: remove addr and subflow in PM netlink"
>>>>     mptcp: add mptcp_destroy_common helper
>>>>
>>>>    net/mptcp/pm.c         |  1 +
>>>>    net/mptcp/pm_netlink.c | 91 +++++++++++++++++++++++++++++++++++++++=
---
>>>>    net/mptcp/protocol.c   | 10 ++++-
>>>>    net/mptcp/protocol.h   |  3 ++
>>>>    net/mptcp/subflow.c    |  3 +-
>>>>    5 files changed, 98 insertions(+), 10 deletions(-)
>>>>
>>>
>>> Both patches LGTM, thanks!
>>
>> Thank you for the patches and the review!
>>
>> Just to be sure, can I squash the two of them in the same "mptcp: remove
>> addr and subflow in PM netlink" commit? (+ update the commit message as
>> written in 1/2 patch)
> =

> Please only squash 1/2 patch to "mptcp: remove addr and subflow in PM net=
link"
> commit. And apply patch 2/2 (mptcp: add mptcp_destroy_common helper) as a
> new commit.

Thank you for the clarification.

- 96141df51494: "squashed" patch 1/2 in "mptcp: remove addr and subflow =

in PM netlink"
- 4c292fe817d5..79a312a49fee: result

The second patch has been added before your two commits modifying the =

selftests.
- 6d043d6c3dc2: mptcp: add mptcp_destroy_common helper
- c3f59bbd90df..653f02bb3161: result

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0074580253664000163==--
