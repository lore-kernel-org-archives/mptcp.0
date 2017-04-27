Content-Type: multipart/mixed; boundary="===============9179589849222235585=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Register handlers for extra TCP options
Date: Wed, 26 Apr 2017 21:08:39 -0700
Message-ID: <d370ac9a-4221-ec1b-91be-ff6612f7748b@oracle.com>
In-Reply-To: alpine.OSX.2.21.1704261722550.73463@manojcha-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 15

--===============9179589849222235585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/26/2017 06:02 PM, Mat Martineau wrote:
>
> On Wed, 26 Apr 2017, Rao Shoaib wrote:
>
>> Hi Matt,
>>
>> Good work see my comments inline..
>>
>>
>> On 04/24/2017 04:06 PM, Mat Martineau wrote:
>>>
>>> On Thu, 20 Apr 2017, Mat Martineau wrote:
>>>
>>>> Allow additional TCP options to be handled by registered hook
>>>> functions.
>>>>
>>>> Option parsing will call the provided 'parse' function when a TCP =

>>>> option
>>>> number is not recognized by the normal option parsing code.
>>>>
>>>> The 'prepare' and 'prepare_req' functions determine the required space
>>>> for registered options and store associated data. There are two =

>>>> variants
>>>> because options must be generated for connections that are associated
>>>> with either tcp_sock or request_sock structures.
>> If I understand correctly the only difference should be the options =

>> chosen. Why not handle this as is done today, syn and established =

>> options ?
>
> Christoph had a good suggestion for getting rid of prepare_req (see =

> that reply).

Yeah. I should have read his email before replying as there was quite an =

overlap. I do have to say that looking at socket state when we are down =

at the transport level just seems strange, but I guess in Linux that is =

quite common.

Can you guys save me some the trouble of digging through the code and =

tell me what is the locking strategy for sockets and tcp structures.
>
>>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>>> index 04843ae77b9e..e0d0504f005a 100644
>>>> --- a/net/ipv4/tcp.c
>>>> +++ b/net/ipv4/tcp.c
>>>> @@ -3279,6 +3287,132 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
>>>>
>>>> #endif
>>>>
>>>> +/* Linear search, few entries are expected. The RCU read lock must
>>>> + * be held before calling.
>>>> + */
>>>> +static struct tcp_extra_option_ops =

>>>> *tcp_extra_options_find_kind(unsigned char kind)
>>>> +{
>>>> +    struct tcp_extra_option_ops *entry;
>>>> +
>>>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>>>> +        if (entry->option_kind =3D=3D kind)
>>>> +            return entry;
>>>> +    }
>>>> +
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +void tcp_extra_options_parse(int opcode, int opsize, const =

>>>> unsigned char *opptr,
>>>> +                 const struct sk_buff *skb,
>>>> +                 struct tcp_options_received *opt_rx,
>>>> +                 struct tcp_sock *tp)
>>>> +{
>>>> +    struct tcp_extra_option_ops *entry;
>>>> +
>>>> +    rcu_read_lock();
>>>> +    entry =3D tcp_extra_options_find_kind(opcode);
>>>> +    if (entry && entry->parse)
>>>> +        entry->parse(opsize, opptr, skb, opt_rx, tp);
>>
>> There does not seems to be a return value, what happens if the =

>> parsing fails or the processing requires resetting the connection. =

>> For example in MPTCP if checksum required is present but is not =

>> configured, the current code returns an error and the connection is =

>> reset.
>
> tcp_parse_options() doesn't have an error path, so I stayed with that =

> approach. But maybe we need something a little different, if MPTCP =

> can't handle the error on a different path (for example by putting =

> something on a work queue to handle the connection reset).
Take a look at tcp_validate_incoming() -- since MPTCP packets take the =

slow path.
>
>> We should provide provision to call a default function for an option =

>> that does not match, so it can at least be documented and the user =

>> may set an option to reset the connection.
>
> Unrecognized TCP options are currently ignored - is a wildcard option =

> handler useful for MPTCP or TCP in general?

That was just a suggestion to add something for observability.
>>>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>>>> +        if (unlikely(!entry->prepare))
>>>> +            continue;
>>>> +
>>>> +        used +=3D entry->prepare(skb, flags, remaining - used, opts, =

>>>> tp);
>>>> +    }
>>>> +    rcu_read_unlock();
>> Should there be a check to stop calling when no space is left ?
>> This also raises the question of priority, which seems to be based on =

>> the place in the list. What happens if there is no space left ? Do =

>> you add MPTCP's DSS  option or SACK or MD5 ?
>
> I think it should keep calling even if there's no space - it might be =

> useful to know a packet is going out with its option space used. The =

> prepare() call will need to handle too little space anyway (even if =

> it's more than 0).
OK.
>
> Ordering is an open question. It would be a minor extension to =

> maintain the list ordered by priority when each option is registered. =

> There's a comment before tcp_options_write cautioning that option =

> ordering can be sensitive, but we aren't changing the order of the =

> "normal" TCP options. Still, I think I agree with you that changing =

> the order of options based on who registered first is not great.
>
> Regarding SACK specifically, I placed the prepare() call before SACK =

> so that the registered options would consume space before SACK tried =

> to use up the rest.
Let me figure out how retransmission is being handled. I am worried =

about the case where sending SACK would be more beneficial than some =

other option.
> +
>>>> +    return used;
>>>> +}
>>>> +
>>>> +void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options =

>>>> *opts,
>>>> +                 struct tcp_sock *tp)
>>>> +{
>>>> +    struct tcp_extra_option_ops *entry;
>>>> +
>>>> +    rcu_read_lock();
>>>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>>>> +        if (unlikely(!entry->write))
>>>> +            continue;
>>>> +
>>>> +        entry->write(ptr, opts, tp);
>> I think you need a check here to call only options that are in opts ?
>
> This code doesn't know which opts are relevant - =

Actually it does. The options (KIND) to put in the packet have already =

been chosen.
> does it make a big difference if we check here and optionally call, or =

> call and let that function quickly check to see if it needs to write? =

> The list is expected to be short.
Someone will have to look through the opts list and make a decision. It =

would be better to do it here but if you have another idea than that is OK.
>
>> We should also pass in skb, In case tcp header is needed to generate =

>> option values.
>
> I was trying to not add a parameter to tcp_options_write, but we can =

> change this if needed. The prepare() call gets the skb pointer, so it =

> could store necessary information (if we figure out where to put it).
I am not sure if that is convenient because when prepare is called =

headers are not present. There is code in MPTCP that checks for say if =

the pakcet is a FIN etc.
>
>>>> +    }
>>>> +    rcu_read_unlock();
>>>> +}
>>>
>>
>> This is a great framework for handling options, my concern is that =

>> the options processing is intertwined with TCP code. Unless we can =

>> implement that separately there will not be much benefit.
>
> Are you suggesting a larger rewrite of TCP option handling overall? Or =

> are you referring to the intertwined MPTCP option handling in the =

> multipath-tcp.org kernel?
I was trying to point out that if we can not move MPTCP, MD5SIG code out =

of TCP into a separate module it will be difficult to sell this =

mechanism to netdev.
>
>> Just search for CONFIG_TCP_MD5SIG, MPTCP related code is also =

>> sprinkled all over tcp code. Before we go down this path should we =

>> evaluate if that can be achieved ?
>
> As Christoph mentioned, MD5SIG would be one way to validate that the =

> framework provides a useful approach for multiple TCP features. =

> There's still more work to do to see if MPTCP can fit within this =

> framework, and I expect the approach to options to evolve as we learn =

> more.
>
This is exactly what I meant to say above.

The design of the options handling framework is pretty good, the details =

will evolve. So continue on with the good work.

Good Luck,

Rao.



--===============9179589849222235585==--
