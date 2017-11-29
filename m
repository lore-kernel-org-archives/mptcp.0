Content-Type: multipart/mixed; boundary="===============9049501889959473828=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 14/25] tcp_extra_options: Check static branch
 before _parse
Date: Wed, 29 Nov 2017 14:24:27 -0800
Message-ID: <alpine.OSX.2.21.1711291406300.22612@skpadalx-mobl.amr.corp.intel.com>
In-Reply-To: 20171129211608.GX94116@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 224

--===============9049501889959473828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 29 Nov 2017, Christoph Paasch wrote:

> On 29/11/17 - 12:50:24, Christoph Paasch wrote:
>> On 29/11/17 - 12:19:32, Mat Martineau wrote:
>>> On Wed, 29 Nov 2017, Christoph Paasch wrote:
>>>
>>>> On 28/11/17 - 17:58:52, Mat Martineau wrote:
>>>>>
>>>>> On Tue, 28 Nov 2017, Mat Martineau wrote:
>>>>>
>>>>>>
>>>>>> On Mon, 27 Nov 2017, Christoph Paasch wrote:
>>>>>>
>>>>>>> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
>>>>>>> ---
>>>>>>> net/ipv4/tcp_input.c | 8 +++++---
>>>>>>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>>>>> index 4e84f299c96f..7acc1f46641c 100644
>>>>>>> --- a/net/ipv4/tcp_input.c
>>>>>>> +++ b/net/ipv4/tcp_input.c
>>>>>>> @@ -3799,9 +3799,11 @@ void tcp_parse_options(const struct net *net,
>>>>>>> 				break;
>>>>>>>
>>>>>>> 			default:
>>>>>>> -				tcp_extra_options_parse(opcode, opsize, ptr,
>>>>>>> -							skb, opt_rx,
>>>>>>> -							tcp_to_sk(tp));
>>>>>>> +				if (static_branch_unlikely(&tcp_extra_options_enabled))
>>>>>>
>>>>>> Since this case in the switch statement is only executed for
>>>>>> unrecognized options, I had skipped the static branch in the initial
>>>>>> implementation. It is more consistent to use the static branch, and
>>>>>> there isn't much use in making the function call just to try to iter=
ate
>>>>>> over an empty list.
>>>>>>
>>>>>>> +					tcp_extra_options_parse(opcode, opsize,
>>>>>>> +								ptr, skb,
>>>>>>> +								opt_rx,
>>>>>>> + tcp_to_sk(tp));
>>>>>>> 				break;
>>>>>>>
>>>>>>> 			}
>>>>>>> --
>>>>>>> 2.15.0
>>>>>>>
>>>>>>>
>>>>>
>>>>> I sent my reply and then realized I had one more point to make. We mi=
ght
>>>>> need to take another look at the use of static branching by the extra
>>>>> options framework. It's one thing to inc/dec tcp_extra_options_enable=
d when
>>>>> modules are added or removed, but we don't want to be rapidly changing
>>>>> static branches as MPTCP sockets come and go. Does tcp_extra_options_=
enabled
>>>>> still make sense for per-socket extra_option lists?
>>>>
>>>> You think that the test for whether or not the tcp_option_list is emtp=
y is
>>>> sufficient?
>>>
>>> It might be if we wrap it in a "unlikely()".
>>>
>>>>
>>>> I don't know about the cost of static_branch_inc/dec. Is it that bad?
>>>>
>>>
>>> Yeah, it's that bad. The kernel is patching machine code every time the=
 key
>>> is enabled or disabled (rewriting no-ops with jump instructions and
>>> vice-versa).
>>>
>>> """
>>>  * Since this relies on modifying code, the branch modifying functions
>>>  * must be considered absolute slow paths (machine wide synchronization=
 etc.).
>>> """
>>>
>>> http://elixir.free-electrons.com/linux/v4.15-rc1/source/include/linux/j=
ump_label.h#L56
>>>
>>> Not just a slow path, but an *absolute* slow path!
>>>
>>> static_key_deferred and static_key_slow_dec_deferred() are available in
>>> jump_label_ratelimit.h, which is one way to keep it from thrashing too =
much.
>>> This rate-limited static key is only used in one file
>>> (arch/x86/kvm/lapic.c). That subsystem limits jump label patching to on=
ce
>>> per second.
>>
>> I see.
>>
>>>
>>>>
>>>> One thing is that having the static branches allows for sure to avoid =
any
>>>> cost in the hot data-path. Which is definitely something netdev will w=
ant.
>>>>
>>>>
>>>> If we pay a cost for MPTCP, I think it's fine IMO. (at least in a firs=
t step ;))
>>>
>>> It would be more straightforward if only MPTCP was paying the cost, but=
 in
>>> this case the hit is systemwide if any extra TCP options are in use. The
>>> combination of a rate-limiting static_key and checking the option list
>>> before the call could be fast enough.
>>
>> If we have rate-limited static keys, do we still need to check the
>> option-list before the call?

You'd still want the fast path on concurrent regular TCP sockets to be =

minimally affected, even when other "extra option" sockets exist. I'm not =

sure if the maintainers would consider it a requirement, but this code is =

so highly optimized that I'm assuming they would be interested in cutting =

out the extra CPU cycles.

>>
>> Also, what if we rather inc/dec the static key more rarely. E.g., not for
>> every new connection but rather for the very first one and then dec agai=
n at
>> the very last one.
>>
>> I'm trying to cook a patch...
>
> This is what I have in mind:
>
>
> -----
> commit ba22182b0b3100539e545313e0eb12a9c466c1fe
> Author: Christoph Paasch <cpaasch(a)apple.com>
> Date:   Wed Nov 29 13:11:44 2017 -0800
>
>    tcp_extra_options: Reduce static_branch_inc/dec through a refcnt
>
>    Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6db92bbbf3e2..344a0d859b37 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2008,6 +2008,7 @@ struct tcp_extra_option_ops {
> 	struct tcp_extra_option_store *(*move)(struct tcp_extra_option_store *fr=
om);
> 	void (*destroy)(struct tcp_extra_option_store *store);
> 	struct module		*owner;
> +	atomic_t		*refcnt;
> };
>
> /* Every extra-option in a TCP-socket gets stored in a _store structure w=
hich
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 2dcb12c330eb..3067e7b5ad00 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3570,7 +3570,8 @@ int tcp_register_extra_option(struct tcp_extra_opti=
on_store *store,
> 	list_add_tail(&store->list, add_before);
> 	pr_debug("Option kind %u registered\n", store->ops->option_kind);
>
> -	static_branch_inc(&tcp_extra_options_enabled);
> +	if (atomic_inc_return(store->ops->refcnt) =3D=3D 1)
> +		static_branch_inc(&tcp_extra_options_enabled);
>
> 	return ret;
> }
> @@ -3602,7 +3603,8 @@ void tcp_extra_options_copy(struct sock *listener,
>
> 		list_add_tail(&new->list, to);
>
> -		static_branch_inc(&tcp_extra_options_enabled);
> +		if (atomic_inc_return(new->ops->refcnt) =3D=3D 1)
> +			static_branch_inc(&tcp_extra_options_enabled);
> 	}
> }
>
> @@ -3632,11 +3634,16 @@ void tcp_extra_options_destroy(struct sock *sk)
>
> 	list_for_each_entry_safe(entry, tmp, lhead, list) {
> 		struct module *owner =3D entry->ops->owner;
> +		bool dec_static =3D false;
> 		list_del(&entry->list);
>
> +		if (atomic_dec_return(entry->ops->refcnt) =3D=3D 0)
> +			dec_static =3D true;
> +
> 		entry->ops->destroy(entry);
>
> -		static_branch_dec(&tcp_extra_options_enabled);
> +		if (dec_static)
> +			static_branch_dec(&tcp_extra_options_enabled);
>
> 		module_put(owner);
> 	}
>

static_branch_{inc,dec} are already reference counts - I didn't explain =

the performance hit clearly. They aren't always expensive.

The problem is when the static key goes from 0->1 and 1->0. As long as =

there's at least one extended option socket active on the system, the =

expensive instruction rewrites won't happen. If you had a process rapidly =

open and close a socket that enabled/disabled the static key, the system =

would be drastically impacted. A server with one or more long-lived =

listening MPTCP sockets would not be affected because the static branch =

reference count for extended options would always be at least 1.

--
Mat Martineau
Intel OTC

--===============9049501889959473828==--
