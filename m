Content-Type: multipart/mixed; boundary="===============2060656607994893214=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][RFC PATCH mptcp-next 1/6] mptcp: add the outgoing
 MP_PRIO support
Date: Thu, 19 Nov 2020 15:55:58 -0800
Message-ID: <941e4c9b-bf6f-095-c315-5bdcb7c459f3@linux.intel.com>
In-Reply-To: CA+WQbwuXnknvwvk3GQR_NOuEtPEwqyb612xLoPad79Q2N=-v2A@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6854

--===============2060656607994893214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2020, Geliang Tang wrote:

> Hi Mat,
>
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=
=B411=E6=9C=8810=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:48=E5=86=99=
=E9=81=93=EF=BC=9A
>>
>> On Thu, 5 Nov 2020, Geliang Tang wrote:
>>
>>> This patch added the outgoing MP_PRIO logic:
>>>
>>> In mptcp_pm_mp_prio_send_ack, find the related subflow and subsocket
>>> according to the input parameter address, then set subflow's send_mp_pr=
io
>>> flag to true, and save the input priority value to suflow's prio_bkup.
>>> Finally, send out a pure ACK on the related subsocket.
>>>
>>> In mptcp_established_options_mp_prio, check whether the subflow's
>>> send_mp_prio is set. If it is, this is the packet for send MP_PRIO. So
>>> save subflow->prio_bkup value to mptcp_out_options's prio_bkup, and
>>> change the option type to OPTION_MPTCP_PRIO.
>>>
>>> In mptcp_write_options, sent out the MP_PRIO suboption with
>>> mptcp_out_options's prio_bkup value.
>>>
>>
>> Hi Geliang,
>>
>> Thanks for working on this additional feature!
>>
>>
>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>> ---
>>> include/net/mptcp.h    |  1 +
>>> net/mptcp/options.c    | 36 ++++++++++++++++++++++++++++++++++++
>>> net/mptcp/pm_netlink.c | 30 ++++++++++++++++++++++++++++++
>>> net/mptcp/protocol.h   |  7 +++++++
>>> 4 files changed, 74 insertions(+)
>>>
>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>> index 5694370be3d4..f71259fb04cd 100644
>>> --- a/include/net/mptcp.h
>>> +++ b/include/net/mptcp.h
>>> @@ -51,6 +51,7 @@ struct mptcp_out_options {
>>>       u8 rm_id;
>>>       u8 join_id;
>>>       u8 backup;
>>> +     u8 prio_bkup;
>>
>> The existing 'backup' struct member can be used for this.
>>
>>>       u32 nonce;
>>>       u64 thmac;
>>>       u32 token;
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index f611fbcbd6d0..b74e6ab2d605 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -665,6 +665,30 @@ static bool mptcp_established_options_rm_addr(stru=
ct sock *sk,
>>>       return true;
>>> }
>>>
>>> +static bool mptcp_established_options_mp_prio(struct sock *sk,
>>> +                                           unsigned int *size,
>>> +                                           unsigned int remaining,
>>> +                                           struct mptcp_out_options *o=
pts)
>>> +{
>>> +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>>> +
>>> +     if (!subflow->send_mp_prio)
>>> +             return false;
>>> +
>>> +     if (remaining < TCPOLEN_MPTCP_PRIO)
>>> +             return false;
>>> +
>>> +     subflow->send_mp_prio =3D 0;
>>
>> tcp_established_options() is called by tcp_current_mss(), so clearing
>> send_mp_prio here will stop MP_PRIO from being sent sometimes.
>>
>
> Should we move this clearing to the end of this function? Or move it into
> mptcp_write_options? Please give me some hint for this.
>

Moving to mptcp_write_options() would be good.


Mat


>>> +
>>> +     *size =3D TCPOLEN_MPTCP_PRIO;
>>> +     opts->suboptions |=3D OPTION_MPTCP_PRIO;
>>> +     opts->prio_bkup =3D subflow->prio_bkup;
>>> +
>>> +     pr_debug("prio=3D%d", opts->prio_bkup);
>>> +
>>> +     return true;
>>> +}
>>> +
>>> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>>                              unsigned int *size, unsigned int remaining,
>>>                              struct mptcp_out_options *opts)
>>> @@ -707,6 +731,12 @@ bool mptcp_established_options(struct sock *sk, st=
ruct sk_buff *skb,
>>>               ret =3D true;
>>>       }
>>>
>>> +     if (mptcp_established_options_mp_prio(sk, &opt_size, remaining, o=
pts)) {
>>> +             *size +=3D opt_size;
>>> +             remaining -=3D opt_size;
>>> +             ret =3D true;
>>> +     }
>>> +
>>>       return ret;
>>> }
>>>
>>> @@ -1138,6 +1168,12 @@ void mptcp_write_options(__be32 *ptr, const stru=
ct tcp_sock *tp,
>>>                                     0, opts->rm_id);
>>>       }
>>>
>>> +     if (OPTION_MPTCP_PRIO & opts->suboptions) {
>>> +             *ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
>>> +                                   TCPOLEN_MPTCP_PRIO,
>>> +                                   opts->prio_bkup, TCPOPT_NOP);
>>> +     }
>>> +
>>>       if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
>>>               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
>>>                                     TCPOLEN_MPTCP_MPJ_SYN,
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 069447424ddb..a243017c4892 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -441,6 +441,36 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_so=
ck *msk)
>>>       }
>>> }
>>>
>>> +void mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
>>> +                            struct mptcp_addr_info *addr,
>>> +                            u8 prio_bkup)
>>> +{
>>> +     struct mptcp_subflow_context *subflow, *tmp;
>>> +
>>> +     if (list_empty(&msk->conn_list))
>>> +             return;
>>> +
>>> +     list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
>>> +             struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>>> +             struct mptcp_addr_info local;
>>> +
>>> +             local_address((struct sock_common *)ssk, &local);
>>> +             if (!addresses_equal(&local, addr, false))
>>> +                     continue;
>>> +
>>> +             subflow->send_mp_prio =3D 1;
>>> +             subflow->prio_bkup =3D prio_bkup;
>>> +             spin_unlock_bh(&msk->pm.lock);
>>> +             pr_debug("send ack for mp_prio");
>>> +             lock_sock(ssk);
>>> +             tcp_send_ack(ssk);
>>> +             release_sock(ssk);
>>> +             spin_lock_bh(&msk->pm.lock);
>>> +
>>> +             break;
>>> +     }
>>> +}
>>> +
>>> void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
>>> {
>>>       struct mptcp_subflow_context *subflow, *tmp;
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index b01c1fae9d8f..a8ed1de1cb05 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -23,6 +23,7 @@
>>> #define OPTION_MPTCP_ADD_ADDR BIT(6)
>>> #define OPTION_MPTCP_ADD_ADDR6        BIT(7)
>>> #define OPTION_MPTCP_RM_ADDR  BIT(8)
>>> +#define OPTION_MPTCP_PRIO    BIT(9)
>>>
>>> /* MPTCP option subtypes */
>>> #define MPTCPOPT_MP_CAPABLE   0
>>> @@ -59,6 +60,7 @@
>>> #define TCPOLEN_MPTCP_PORT_LEN                4
>>> #define TCPOLEN_MPTCP_ADD_ADDR_HMAC   8
>>> #define TCPOLEN_MPTCP_RM_ADDR_BASE    4
>>> +#define TCPOLEN_MPTCP_PRIO           4
>>>
>>> /* MPTCP MP_JOIN flags */
>>> #define MPTCPOPT_BACKUP               BIT(0)
>>> @@ -362,6 +364,7 @@ struct mptcp_subflow_context {
>>>               map_valid : 1,
>>>               mpc_map : 1,
>>>               backup : 1,
>>> +             send_mp_prio : 1,
>>>               rx_eof : 1,
>>>               can_ack : 1,        /* only after processing the remote a=
 key */
>>>               disposable : 1;     /* ctx can be free at ulp release tim=
e */
>>> @@ -373,6 +376,7 @@ struct mptcp_subflow_context {
>>>       u8      hmac[MPTCPOPT_HMAC_LEN];
>>>       u8      local_id;
>>>       u8      remote_id;
>>> +     u8      prio_bkup;
>>
>> The existing 'backup' bit in this struct is keeping track of the peer's
>> requested backup flag, which affects the choice for the local msk to send
>> on that subflow.
>>
>> The existing 'request_bkup' bit is tracking which priority (backup or
>> normal) we have requested from the peer. I think prio_bkup duplicates th=
is
>> bit.
>>
>>>
>>>       struct  sock *tcp_sock;     /* tcp sk backpointer */
>>>       struct  sock *conn;         /* parent mptcp_sock */
>>> @@ -515,6 +519,9 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *=
msk,
>>>                               const struct mptcp_addr_info *addr);
>>> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
>>> void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
>>> +void mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
>>> +                            struct mptcp_addr_info *addr,
>>> +                            u8 prio_bkup);
>>> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
>>> struct mptcp_pm_add_entry *
>>> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>>> --
>>> 2.26.2

--
Mat Martineau
Intel

--===============2060656607994893214==--
