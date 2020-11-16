Content-Type: multipart/mixed; boundary="===============5183401151380117996=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: create listening
 socket for new port
Date: Mon, 16 Nov 2020 15:55:14 -0800
Message-ID: <eb235288-c45a-878f-333-de72e59dc4bd@linux.intel.com>
In-Reply-To: 2ad1f083006c5489798b19f233badac10b4cf914.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6759

--===============5183401151380117996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 16 Nov 2020, Paolo Abeni wrote:

> On Mon, 2020-11-16 at 12:30 +0800, Geliang Tang wrote:
>> This patch created the listening socket from the kernel side, binded the
>> new port to the listening socket, then listened.
>>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>> ---
>> mptcp_subflow_create_socket will fail here since the sk->sk_socket is
>> null. I simply dropped this null checking which was been added by Paolo
>> in the commit "adf7341064982 (mptcp: be careful on subflow creation)".
>> ---
>>  net/mptcp/pm_netlink.c |  3 +++
>>  net/mptcp/protocol.h   |  1 +
>>  net/mptcp/subflow.c    | 55 +++++++++++++++++++++++++++++++++++-------
>>  3 files changed, 50 insertions(+), 9 deletions(-)
>>

...

>
> When we hit the !sk->sk_socket scenario, ownership for the newly
> created socket will be uncorrect.
>
> Possibly a more important point: does the above ensure proper isolation
> between processes and sockets ?
>
> If I follow the code correctly, once that additional listening socket
> is created, any join request landing there will be able to attach to
> any msk - even outside the current netns with the current token infra.
>

Does the per-msk port number checking in patch 9/13 (ADD_ADDR ports v4 =

series) address part of this?

https://patchwork.ozlabs.org/project/mptcp/patch/c32afb7d145744ba936bf37097=
c4120bd51c6c1a.1604984546.git.geliangtang(a)gmail.com/

> I'm wondering if we could instead create a single listening socket per
> netns - when the first msk socket is created. That should avoid bind
> and fallback issues. Ownership should probably set explicitly to root,
> and the isolation issue will be still there.
>

Paolo's idea for a single listening socket per netns sounds good to me.

--
Mat Martineau
Intel
--===============5183401151380117996==--
