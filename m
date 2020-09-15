Content-Type: multipart/mixed; boundary="===============0087388931839963708=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/2] Squash-to: "mptcp:
 remove addr and subflow in PM netlink v9"
Date: Tue, 15 Sep 2020 22:26:37 +0200
Message-ID: <92808529-48b6-7680-a982-1eca0fb0710e@tessares.net>
In-Reply-To: 5817e524b9fc383bbc3a53915f58e71c40e87266.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5889

--===============0087388931839963708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 15/09/2020 15:04, Paolo Abeni wrote:
> On Tue, 2020-09-15 at 19:59 +0800, Geliang Tang wrote:
>> v3:
>>   - use "goto next" in mptcp_nl_remove_subflow_and_signal_addr
>>   - update mptcp_destroy_common
>>
>> v2:
>>   - add mptcp_pm_remove_anno_addr and update logic in
>>   mptcp_nl_remove_subflow_and_signal_addr
>>   - call mptcp_pm_free_anno_list in mptcp_destroy and mptcp_sock_destruct
>>   - add mptcp_destroy_common helper
>>
>> Geliang Tang (2):
>>    Squash-to: "mptcp: remove addr and subflow in PM netlink"
>>    mptcp: add mptcp_destroy_common helper
>>
>>   net/mptcp/pm.c         |  1 +
>>   net/mptcp/pm_netlink.c | 91 +++++++++++++++++++++++++++++++++++++++---
>>   net/mptcp/protocol.c   | 10 ++++-
>>   net/mptcp/protocol.h   |  3 ++
>>   net/mptcp/subflow.c    |  3 +-
>>   5 files changed, 98 insertions(+), 10 deletions(-)
>>
> =

> Both patches LGTM, thanks!

Thank you for the patches and the review!

Just to be sure, can I squash the two of them in the same "mptcp: remove =

addr and subflow in PM netlink" commit? (+ update the commit message as =

written in 1/2 patch)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0087388931839963708==--
