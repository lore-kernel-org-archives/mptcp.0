Content-Type: multipart/mixed; boundary="===============8570122947665439629=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:netlink: fix compilation warning
Date: Tue, 24 Mar 2020 10:09:21 +0100
Message-ID: <e9b91ed5-d08a-9130-d1a9-a40ea380aa71@tessares.net>
In-Reply-To: 95069d1311f82c97a64f4c8714ce87931060a164.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4054

--===============8570122947665439629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 24/03/2020 09:49, Paolo Abeni wrote:
> Hi,
> =

> On Mon, 2020-03-23 at 13:04 -0700, Mat Martineau wrote:
>> On Mon, 23 Mar 2020, Matthieu Baerts wrote:
>>
>>>   net/mptcp/pm_netlink.c: In function =E2=80=98mptcp_pm_nl_add_addr_rec=
eived=E2=80=99:
>>>   net/mptcp/pm_netlink.c:238:23: warning: variable =E2=80=98pernet=E2=
=80=99 set but not used [-Wunused-but-set-variable]
>>>     238 |  struct pm_nl_pernet *pernet;
>>>         |                       ^~~~~~
>>>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>> ---
>>>
>>> Notes:
>>>     to be squashed in "mptcp: add netlink-based PM"
>>>
>>> net/mptcp/pm_netlink.c | 3 ---
>>> 1 file changed, 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 4bab1b32f932..743c3c58f826 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -235,9 +235,6 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_soc=
k *msk)
>>> 	struct sock *sk =3D (struct sock *)msk;
>>> 	struct mptcp_addr_info remote;
>>> 	struct mptcp_addr_info local;
>>> -	struct pm_nl_pernet *pernet;
>>> -
>>> -	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>>>
>>> 	pr_debug("accepted %d:%d remote family %d",
>>> 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
>>
>> I think this is ok to drop for now. Looks like it's left over from copied
>> code, but we should double-check with Paolo tomorrow in case it was
>> intended to check the pernet limits.
> =

> This is a left-over from previous iteration. The funny thing is that I
> don't get the warning locally:
> =

> $ touch net/mptcp/pm_netlink.c;  make C=3D2  net/mptcp/pm_netlink.o
>    CHECK   scripts/mod/empty.c
>    CALL    scripts/checksyscalls.sh
>    CALL    scripts/atomic/check-atomics.sh
>    DESCEND  objtool
>    CHECK   net/mptcp/pm_netlink.c
>    CC      net/mptcp/pm_netlink.o
> # no other output ?!?
> =

> despite there is actually no usage of 'pernet' ?!? gcc 9.2.1 here.
> =

> I hope there are no other left-over!

I checked by manually doing:

   $ make W=3D1 -j$(nproc)  ## lot of warnings are produced...
   $ rm net/mptcp/*.[oa]
   $ make W=3D1 -j$(nproc)

See the content of Makefile for the explanation why it is disabled:
https://elixir.bootlin.com/linux/latest/source/Makefile#L753

I am looking at automatize this check. It seems OK with:

   for i in net/mptcp/*.o; do
       touch ${i:0:-1}c
       KCFLAGS=3D"-Werror" make W=3D1 $i
   done

W=3D23 produces too many warnings due to code we don't control.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8570122947665439629==--
