Content-Type: multipart/mixed; boundary="===============4230306579184905035=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/3] DATA_FIN fixes proposed for net tree
Date: Fri, 28 Feb 2020 08:17:53 -0800
Message-ID: <alpine.OSX.2.22.394.2002280808500.71801@mahansen-mobl.amr.corp.intel.com>
In-Reply-To: 1534ea6ec8bb7c2d07c5e2083e958e32b77f7bf2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3824

--===============4230306579184905035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 28 Feb 2020, Paolo Abeni wrote:

> On Thu, 2020-02-27 at 16:29 -0800, Mat Martineau wrote:
>> More changes are needed for multi-subflow DATA_FIN support, but these
>> fixes may be worth applying to the 5.6 tree for single subflow. Self
>> tests pass, and I checked the headers with DATA_FIN for both the
>> DATA_FIN-only DSS option and packet with a full mapping and DATA_FIN.
>>
>> I'll send to netdev following review on this list.
>>
>> RFC -> v1: Rebased on current net tree
>>
>> Mat Martineau (3):
>>   mptcp: Check connection state before attempting send
>>   mptcp: Use per-subflow storage for DATA_FIN sequence number
>>   mptcp: Only send DATA_FIN with final mapping
>>
>>  net/mptcp/options.c  | 16 ++++++++--------
>>  net/mptcp/protocol.c | 32 +++++++++++++++++++++++++++-----
>>  net/mptcp/protocol.h |  2 ++
>>  3 files changed, 37 insertions(+), 13 deletions(-)
>>
>>
>> base-commit: 3ee339eb28959629db33aaa2b8cde4c63c6289eb
>
> The patches look good ot me.
>
> On patch 2/3 we likely want to replace:
>
> 	mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1, 0, 0);
>
> with a FAST_CLOSE, but first we have to support/implement that:)
>
> My understanding is that there a pending quesiton on the git tree these
> patches should target. I think net-next is more suitable than -net, as
> this is somewhat relevant change of data_fin handling.

I can bring these patches back to the development branch if that's what =

works better. I do think of these as bug fixes, but for single subflow =

they are corner cases for sure - and there's also some chance of creating =

some merge conflicts with net-next or our branch if merged to -net, so =

net-next/mptcp_net-next is fine.

I'll rebase on the updated export branch and post again.

Thanks,

--
Mat Martineau
Intel
--===============4230306579184905035==--
