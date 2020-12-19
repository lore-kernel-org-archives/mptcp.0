Content-Type: multipart/mixed; boundary="===============3227011062148399862=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 1/8] mptcp: create the
 listening socket for new port
Date: Fri, 18 Dec 2020 16:23:25 -0800
Message-ID: <9c113c7d-af66-789a-e43c-cea93930bb35@linux.intel.com>
In-Reply-To: CA+WQbwsLNeNi2yz_sW+9YYAKY2NPvRnRECmh2G3MaQKvWeEaUw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7224

--===============3227011062148399862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Dec 2020, Geliang Tang wrote:

> Hi Mat,
>
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=
=B412=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=888:14=E5=86=99=
=E9=81=93=EF=BC=9A
>>
>> On Sun, 13 Dec 2020, Geliang Tang wrote:
>>
>>> This patch created a listening socket when an address with a port-number
>>> is added by PM netlink. Then binded the new port to the socket, and
>>> listened for the connection.
>>>
>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 64 ++++++++++++++++++++++++++++++++++++++++++
>>> net/mptcp/protocol.c   |  2 +-
>>> net/mptcp/protocol.h   |  3 ++
>>> net/mptcp/subflow.c    |  4 +--
>>> 4 files changed, 70 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 9b1f6298bbdb..1548efb22a1b 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
>>>       struct list_head        list;
>>>       struct mptcp_addr_info  addr;
>>>       struct rcu_head         rcu;
>>> +     struct socket           *lsk;
>>> };
>>>
>>> struct mptcp_pm_add_entry {
>>> @@ -613,6 +614,53 @@ static int mptcp_pm_nl_append_new_local_addr(struc=
t pm_nl_pernet *pernet,
>>>       return ret;
>>> }
>>>
>>> +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>> +                                         struct mptcp_pm_addr_entry *e=
ntry)
>>> +{
>>> +     struct sockaddr_storage addr;
>>> +     struct mptcp_sock *msk;
>>> +     struct socket *ssock;
>>> +     int backlog =3D 1024;
>>> +     int err;
>>> +
>>> +     err =3D sock_create_kern(sock_net(sk), entry->addr.family,
>>> +                            SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     msk =3D mptcp_sk(entry->lsk->sk);
>>> +     if (!msk) {
>>> +             err =3D -EINVAL;
>>> +             goto out;
>>> +     }
>>> +
>>> +     ssock =3D __mptcp_nmpc_socket(msk);
>>> +     if (!ssock) {
>>> +             err =3D -EINVAL;
>>> +             goto out;
>>> +     }
>>> +
>>> +     mptcp_info2sockaddr(&entry->addr, &addr);
>>> +     err =3D kernel_bind(ssock, (struct sockaddr *)&addr,
>>> +                       sizeof(struct sockaddr_in));
>>> +     if (err) {
>>> +             pr_warn("kernel_bind error, err=3D%d", err);
>>> +             goto out;
>>> +     }
>>> +
>>> +     err =3D kernel_listen(ssock, backlog);
>>> +     if (err) {
>>> +             pr_warn("kernel_listen error, err=3D%d", err);
>>> +             goto out;
>>> +     }
>>> +
>>> +     return 0;
>>> +
>>> +out:
>>> +     sock_release(entry->lsk);
>>> +     return err;
>>> +}
>>> +
>>> int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common=
 *skc)
>>> {
>>>       struct mptcp_pm_addr_entry *entry;
>>> @@ -657,6 +705,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk=
, struct sock_common *skc)
>>>       entry->addr.ifindex =3D 0;
>>>       entry->addr.flags =3D 0;
>>>       entry->addr.id =3D 0;
>>> +     entry->addr.port =3D 0;
>>> +     entry->lsk =3D NULL;
>>>       ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
>>>       if (ret < 0)
>>>               kfree(entry);
>>> @@ -808,9 +858,19 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *s=
kb, struct genl_info *info)
>>>       }
>>>
>>>       *entry =3D addr;
>>> +     if (entry->addr.port) {
>>> +             ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entry);
>>> +             if (ret) {
>>> +                     GENL_SET_ERR_MSG(info, "create listen socket erro=
r");
>>> +                     kfree(entry);
>>> +                     return ret;
>>> +             }
>>> +     }
>>>       ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
>>>       if (ret < 0) {
>>>               GENL_SET_ERR_MSG(info, "too many addresses or duplicate o=
ne");
>>> +             if (entry->lsk)
>>> +                     sock_release(entry->lsk);
>>>               kfree(entry);
>>>               return ret;
>>>       }
>>> @@ -921,6 +981,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *sk=
b, struct genl_info *info)
>>>       spin_unlock_bh(&pernet->lock);
>>>
>>>       mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry=
->addr);
>>> +     if (entry->lsk)
>>> +             sock_release(entry->lsk);
>>>       kfree_rcu(entry, rcu);
>>
>> Releasing the socket here could be racy - since the list is rcu-protecte=
d,
>> the entry could still be accessed (which is why it's freed with
>> kfree_rcu()). Rather than calling kfree_rcu(), use a custom callback with
>> call_rcu() that will both release lsk and kfree the list entry.
>>
>
> It dosen't work. I fixed it like this:
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 5f80b886aecb..d6b937bffb43 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1010,6 +1010,16 @@ static int
> mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>     return 0;
> }
>
> +static void mptcp_pm_addr_entry_free(struct rcu_head *head)
> +{
> +    struct mptcp_pm_addr_entry *entry;
> +
> +    entry =3D container_of(head, struct mptcp_pm_addr_entry, rcu);
> +    if (entry->lsk)
> +        sock_release(entry->lsk);
> +    kfree(entry);
> +}
> +
> static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *i=
nfo)
> {
>     struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> @@ -1039,9 +1049,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff
> *skb, struct genl_info *info)
>     spin_unlock_bh(&pernet->lock);
>
>     mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->ad=
dr);
> -    if (entry->lsk)
> -        sock_release(entry->lsk);
> -    kfree_rcu(entry, rcu);
> +    call_rcu(&entry->rcu, mptcp_pm_addr_entry_free);
>
>     return ret;
> }
> @@ -1054,10 +1062,8 @@ static void __flush_addrs(struct net *net,
> struct list_head *list)
>         cur =3D list_entry(list->next,
>                  struct mptcp_pm_addr_entry, list);
>         mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
> -        if (cur->lsk)
> -            sock_release(cur->lsk);
>         list_del_rcu(&cur->list);
> -        kfree_rcu(cur, rcu);
> +        call_rcu(&cur->rcu, mptcp_pm_addr_entry_free);
>     }
> }
>
> --
> 2.29.2
>
> But I got this error:
>
> [  261.105979] MPTCP: sock_release 0000000058a9d993
> [  261.105985] BUG: sleeping function called from invalid context at
> net/core/sock.c:3048
> [  261.105987] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
> 0, name: swapper/2
> [  261.105990] 1 lock held by swapper/2/0:
> [  261.105992]  #0: ffffffffac5a68e0 (rcu_callback){....}-{0:0}, at:
> rcu_do_batch+0x216/0x900
> [  261.106009] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted
> 5.10.0-mptcp+ #429
> [  261.106011] Hardware name: TIMI Mi Laptop Pro 15/TM1905, BIOS
> XMACM500P0301 04/08/2020
> [  261.106013] Call Trace:
> [  261.106016]  <IRQ>
> [  261.106022]  dump_stack+0x8b/0xb0
> [  261.106028]  ___might_sleep.cold+0xb6/0xc6
> [  261.106033]  lock_sock_nested+0x28/0x90
> [  261.106040]  mptcp_close+0x20/0x2f0
> [  261.106043]  ? rcu_do_batch+0x216/0x900
> [  261.106048]  ? rcu_do_batch+0x216/0x900
> [  261.106052]  inet_release+0x42/0x80
> [  261.106058]  sock_release+0x20/0x70
> [  261.106063]  mptcp_pm_addr_entry_free+0x3b/0x60
> [  261.106067]  rcu_do_batch+0x289/0x900
> [  261.106078]  rcu_core+0x27d/0x450
> [  261.106085]  __do_softirq+0xd5/0x485
> [  261.106096]  asm_call_irq_on_stack+0xf/0x20
> [  261.106098]  </IRQ>
> [  261.106103]  do_softirq_own_stack+0x5b/0x70
> [  261.106106]  __irq_exit_rcu+0xda/0x120
> [  261.106110]  irq_exit_rcu+0xa/0x20
> [  261.106113]  sysvec_apic_timer_interrupt+0x4b/0xa0
> [  261.106118]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  261.106122] RIP: 0010:cpuidle_enter_state+0xfa/0x470
>

Oops, my mistake. Yeah, I can see how sock_release() is not able to run in =

a regular rcu handler.

Instead of call_rcu(), try queue_rcu_work(). That will run the handler in =

a context where it can sleep, after the rcu grace period.

Look at nfc_genl_rcv_nl_event() and nfc_urelease_event_work(), which use a =

dynamically allocated work struct. Use 'struct rcu_work' instead of =

'struct work_struct' and queue_rcu_work(system_wq, rwork) instead of =

schedule_work().


Mat


>
>>>
>>>       return ret;
>>> @@ -934,6 +996,8 @@ static void __flush_addrs(struct net *net, struct l=
ist_head *list)
>>>               cur =3D list_entry(list->next,
>>>                                struct mptcp_pm_addr_entry, list);
>>>               mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
>>> +             if (cur->lsk)
>>> +                     sock_release(cur->lsk);
>>>               list_del_rcu(&cur->list);
>>>               kfree_rcu(cur, rcu);
>>
>> Same issue as above with sock_release() and rcu.
>>
>>
>> Mat
>>
>>>       }
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 8ec9e4582d18..79e1b34ecb53 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -49,7 +49,7 @@ static void __mptcp_check_send_data_fin(struct sock *=
sk);
>>>  * completed yet or has failed, return the subflow socket.
>>>  * Otherwise return NULL.
>>>  */
>>> -static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
>>> +struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
>>> {
>>>       if (!msk->subflow || READ_ONCE(msk->can_ack))
>>>               return NULL;
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index d6400ad2d615..a2a031cca97a 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -473,11 +473,14 @@ void mptcp_subflow_shutdown(struct sock *sk, stru=
ct sock *ssk, int how);
>>> void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>>                      struct mptcp_subflow_context *subflow);
>>> void mptcp_subflow_reset(struct sock *ssk);
>>> +struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
>>>
>>> /* called with sk socket lock held */
>>> int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_in=
fo *loc,
>>>                           const struct mptcp_addr_info *remote);
>>> int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_so=
ck);
>>> +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
>>> +                      struct sockaddr_storage *addr);
>>>
>>> static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
>>>                                             struct mptcp_subflow_contex=
t *ctx)
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 73e66a406d99..c64a1c41a29b 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -1073,8 +1073,8 @@ void mptcpv6_handle_mapped(struct sock *sk, bool =
mapped)
>>> }
>>> #endif
>>>
>>> -static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
>>> -                             struct sockaddr_storage *addr)
>>> +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
>>> +                      struct sockaddr_storage *addr)
>>> {
>>>       memset(addr, 0, sizeof(*addr));
>>>       addr->ss_family =3D info->family;
>>> --
>>> 2.29.2

--
Mat Martineau
Intel

--===============3227011062148399862==--
