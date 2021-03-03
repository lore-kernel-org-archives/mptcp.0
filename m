Content-Type: multipart/mixed; boundary="===============2389668776143978866=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 3/4] mptcp: remove id zero
 address
Date: Wed, 03 Mar 2021 11:28:53 +0100
Message-ID: <76cb1405-238d-63d4-e45d-16196bb114c8@tessares.net>
In-Reply-To: 556d8bab7ecf975121bdefeef6837536cbdf13e5.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7993

--===============2389668776143978866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Geliang,

On 03/03/2021 11:19, Paolo Abeni wrote:
> On Wed, 2021-03-03 at 15:49 +0800, Geliang Tang wrote:
>> This patch added a new function mptcp_nl_remove_id_zero_address to
>> remove the id 0 address.
>>
>> In this function, fill the remove list with the id 0, and pass it to
>> mptcp_pm_remove_addr and mptcp_pm_remove_subflow.
>>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>> ---
>>   net/mptcp/pm_netlink.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 419b643bd6fe..eeef36663679 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1171,6 +1171,33 @@ static void mptcp_pm_free_addr_entry(struct mptcp=
_pm_addr_entry *entry)
>>   	}
>>   }
>>   =

>> +static int mptcp_nl_remove_id_zero_address(struct net *net)
>> +{
>> +	struct mptcp_sock *msk;
>> +	long s_slot =3D 0, s_num =3D 0;
>> +	struct mptcp_rm_list list =3D { .nr =3D 0 };
>> +
>> +	list.ids[list.nr++] =3D 0;
>> +
>> +	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL=
) {
>> +		struct sock *sk =3D (struct sock *)msk;
>> +
>> +		if (list_empty(&msk->conn_list))
>> +			goto next;
>> +
>> +		lock_sock(sk);
>> +		mptcp_pm_remove_addr(msk, list);
>> +		mptcp_pm_remove_subflow(msk, list);
>> +		release_sock(sk);
>> +
>> +next:
>> +		sock_put(sk);
>> +		cond_resched();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info=
 *info)
>>   {
>>   	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
>> @@ -1183,6 +1210,9 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *s=
kb, struct genl_info *info)
>>   	if (ret < 0)
>>   		return ret;
>>   =

>> +	if (!addr.addr.id)
>> +		return mptcp_nl_remove_id_zero_address(sock_net(skb->sk));
> =

> I think this deserve a comment explaning why the generic addr removal
> code below is ineffective, something alike:
> =

> /* the zero id address is special: the first address used by the msk
>   * always get such id, so different subflows can have different
>   * zero id address. Additionally zero id is not accounted in id_bitmap.
>   * Let's use an 'mptcp_rm_list' instead of the common remove code.
>   */
> =

> [minus grammar/syntax errors on my side ;)]

Good idea! And while at it, it is maybe clearer with:

   if (addr.addr.id =3D=3D 0)

"!" is often confusing when used with numbers, i.e. something else than =

pointers and booleans. Especially "if (!ret) success();" :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2389668776143978866==--
