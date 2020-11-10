Content-Type: multipart/mixed; boundary="===============6337751650604278512=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][RFC PATCH mptcp-next 4/6] mptcp: send out MP_PRIO
 before RM_ADDR
Date: Tue, 10 Nov 2020 15:24:10 -0800
Message-ID: <d07fb60-224-235a-cced-219d2bf420a7@linux.intel.com>
In-Reply-To: CA+WQbwtAUa6X138Rs7M4vV464FiP4e82EQ9Z--AG0csaRpV-gQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6651

--===============6337751650604278512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2020, Geliang Tang wrote:

> Hi Mat,
>
> Thanks for your suggestions. It's very helpful.
>
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=
=B411=E6=9C=8810=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:07=E5=86=
=99=E9=81=93=EF=BC=9A
>>
>> On Thu, 5 Nov 2020, Geliang Tang wrote:
>>
>>> Before sending the RM_ADDR suboption, we also send the MP_PRIO suboption
>>> to change the related subflow's priority as backup. So here invoke
>>> mptcp_pm_mp_prio_send_ack from mptcp_pm_remove_anno_addr to send the
>>> MP_PRIO suboption and check whether the subflow's backup value is chang=
ed.
>>>
>>
>> Geliang,
>>
>> I also think this patch is not needed. The part of RFC 8684 that mentions
>> using the backup flag before a close is assuming a much longer period of
>> time between the ACK that changes priority and the REMOVE_ADDR. It will =
be
>> up to the path manager to coordinate the timing on that.
>>
>
> If we drop this patch, when should we trigger the MP_PRIO sending? In whi=
ch
> case does mptcp_pm_mp_prio_send_ack need to be called?
>
> Should we use the PM netlink to trigger it? Use the MPTCP_PM_ADDR_FLAG_BA=
CKUP
> flag or something?

Yes, I think netlink is the way to trigger it. Maybe =

mptcp_nl_cmd_add_addr() could check for and modify an existing entry to =

change the 'backup' setting?


Mat


>>
>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index a243017c4892..f80ebd4f6a29 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -491,6 +491,7 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock=
 *msk)
>>>               if (msk->pm.rm_id !=3D subflow->remote_id)
>>>                       continue;
>>>
>>> +             WARN_ON_ONCE(!subflow->backup);
>>>               spin_unlock_bh(&msk->pm.lock);
>>>               mptcp_subflow_shutdown(sk, ssk, how);
>>>               __mptcp_close_ssk(sk, ssk, subflow);
>>> @@ -830,6 +831,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_=
sock *msk,
>>>       ret =3D remove_anno_list_by_saddr(msk, addr);
>>>       if (ret || force) {
>>>               spin_lock_bh(&msk->pm.lock);
>>> +             mptcp_pm_mp_prio_send_ack(msk, addr, 1);
>>>               mptcp_pm_remove_addr(msk, addr->id);
>>>               spin_unlock_bh(&msk->pm.lock);
>>>       }
>>> --
>>> 2.26.2

--
Mat Martineau
Intel

--===============6337751650604278512==--
