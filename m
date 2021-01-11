Content-Type: multipart/mixed; boundary="===============2243653085751028396=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 1/9] mptcp: create the
 listening socket for new port
Date: Mon, 11 Jan 2021 15:47:37 -0800
Message-ID: <b9ea178a-d973-38b2-56bf-7fdb27c7478d@linux.intel.com>
In-Reply-To: CA+WQbwvmAxA9sf-tsnMifb1CTrQrz7HVD_KAMbft1Rn2rS+tbA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7316

--===============2243653085751028396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Jan 2021, Geliang Tang wrote:

> Hi Mat,
>
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=
=B41=E6=9C=889=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=886:56=E5=86=99=
=E9=81=93=EF=BC=9A
>>
>> On Tue, 5 Jan 2021, Geliang Tang wrote:
>>
>>> This patch created a listening socket when an address with a port-number
>>> is added by PM netlink. Then binded the new port to the socket, and
>>> listened for the connection.
>>>
>>> When the address is removed or the addresses are flushed by PM netlink,
>>> release the listening socket.
>>>
>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 96 +++++++++++++++++++++++++++++++++++++++++-
>>> net/mptcp/protocol.c   |  2 +-
>>> net/mptcp/protocol.h   |  4 ++
>>> net/mptcp/subflow.c    |  6 +--
>>> 4 files changed, 102 insertions(+), 6 deletions(-)

...

>>>
>>> @@ -972,6 +1032,38 @@ static int mptcp_nl_remove_subflow_and_signal_add=
r(struct net *net,
>>>       return 0;
>>> }
>>>
>>> +struct addr_entry_release_work {
>>> +     struct rcu_work rwork;
>>> +     struct mptcp_pm_addr_entry *entry;
>>> +};
>>> +
>>> +static void mptcp_pm_release_addr_entry(struct work_struct *work)
>>> +{
>>> +     struct addr_entry_release_work *w;
>>> +     struct mptcp_pm_addr_entry *entry;
>>> +
>>> +     w =3D container_of(to_rcu_work(work), struct addr_entry_release_w=
ork, rwork);
>>> +     entry =3D w->entry;
>>> +     if (entry) {
>>> +             if (entry->lsk)
>>> +                     sock_release(entry->lsk);
>>> +             kfree(entry);
>>> +     }
>>> +     kfree(w);
>>> +}
>>> +
>>> +static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
>>> +{
>>> +     struct addr_entry_release_work *w;
>>> +
>>> +     w =3D kmalloc(sizeof(*w), GFP_ATOMIC);
>>> +     if (w) {
>>> +             INIT_RCU_WORK((struct rcu_work *)w, mptcp_pm_release_addr=
_entry);
>>> +             w->entry =3D entry;
>>> +             queue_rcu_work(system_wq, (struct rcu_work *)w);
>>
>> Rather than casting the second arg, please use &w->rwork
>>
>
> May I send a squash-to patch to fix this?
>

Hi Geliang -

Since I'm asking for a rebased version of this series anyway (to get rid =

of all the 'git am' conflicts in the pending patch sets), please include =

this change in v10.

Thanks,

--
Mat Martineau
Intel

--===============2243653085751028396==--
