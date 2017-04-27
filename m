Content-Type: multipart/mixed; boundary="===============2507368116479736864=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Register handlers for extra TCP options
Date: Wed, 26 Apr 2017 18:02:01 -0700
Message-ID: <alpine.OSX.2.21.1704261722550.73463@manojcha-mobl.amr.corp.intel.com>
In-Reply-To: 918883b9-18f0-c29a-0d20-00592cd27631@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 13

--===============2507368116479736864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 26 Apr 2017, Rao Shoaib wrote:

> Hi Matt,
>
> Good work see my comments inline..
>
>
> On 04/24/2017 04:06 PM, Mat Martineau wrote:
>> =

>> On Thu, 20 Apr 2017, Mat Martineau wrote:
>> =

>>> Allow additional TCP options to be handled by registered hook
>>> functions.
>>> =

>>> Option parsing will call the provided 'parse' function when a TCP option
>>> number is not recognized by the normal option parsing code.
>>> =

>>> The 'prepare' and 'prepare_req' functions determine the required space
>>> for registered options and store associated data. There are two variants
>>> because options must be generated for connections that are associated
>>> with either tcp_sock or request_sock structures.
> If I understand correctly the only difference should be the options chose=
n. =

> Why not handle this as is done today, syn and established options ?

Christoph had a good suggestion for getting rid of prepare_req (see that =

reply).

>>> A static key and RCU synchronization are used to minimize the
>>> performance impact of these extensible TCP features.
>>> =

>>> Before this is posted upstream, I plan to split the patch in two parts
>>> (at least), since making tcp_out_options public should be separate. The
>>> extra parameter for tcp_parse_options may also warrant its own
>>> patch. I'd also like to discuss where to store information for the
>>> options that are parsed or generated using these hooks, since the
>>> tcp_options_received and tcp_out_options structs don't have places to
>>> store extra information yet.
>>> =

>>> I've confirmed that this code builds, but haven't tested yet.
>>> =

>>> This commit is also available at
>>> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
>>> branch: mptcp
>>> =

>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>> ---
>> =

>> ...
>> =

>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index 04843ae77b9e..e0d0504f005a 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -3279,6 +3287,132 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
>>> =

>>> #endif
>>> =

>>> +/* Linear search, few entries are expected. The RCU read lock must
>>> + * be held before calling.
>>> + */
>>> +static struct tcp_extra_option_ops *tcp_extra_options_find_kind(unsign=
ed =

>>> char kind)
>>> +{
>>> +    struct tcp_extra_option_ops *entry;
>>> +
>>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>>> +        if (entry->option_kind =3D=3D kind)
>>> +            return entry;
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +void tcp_extra_options_parse(int opcode, int opsize, const unsigned ch=
ar =

>>> *opptr,
>>> +                 const struct sk_buff *skb,
>>> +                 struct tcp_options_received *opt_rx,
>>> +                 struct tcp_sock *tp)
>>> +{
>>> +    struct tcp_extra_option_ops *entry;
>>> +
>>> +    rcu_read_lock();
>>> +    entry =3D tcp_extra_options_find_kind(opcode);
>>> +    if (entry && entry->parse)
>>> +        entry->parse(opsize, opptr, skb, opt_rx, tp);
>
> There does not seems to be a return value, what happens if the parsing fa=
ils =

> or the processing requires resetting the connection. For example in MPTCP=
 if =

> checksum required is present but is not configured, the current code retu=
rns =

> an error and the connection is reset.

tcp_parse_options() doesn't have an error path, so I stayed with that =

approach. But maybe we need something a little different, if MPTCP can't =

handle the error on a different path (for example by putting something on =

a work queue to handle the connection reset).

> We should provide provision to call a default function for an option that =

> does not match, so it can at least be documented and the user may set an =

> option to reset the connection.

Unrecognized TCP options are currently ignored - is a wildcard option =

handler useful for MPTCP or TCP in general?

>
>>> +    rcu_read_unlock();
>>> +}
>>> +
>>> +unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
>>> +                       unsigned int remaining,
>>> +                       struct tcp_out_options *opts,
>>> +                       struct tcp_sock *tp)
>>> +{
>>> +    struct tcp_extra_option_ops *entry;
>>> +    unsigned int used =3D 0;
>>> +
>>> +    rcu_read_lock();
>> =

>> I think I'll change this to have the caller handle rcu_read_lock/unlock,=
 so =

>> the registered option list stays the same between the paired calls to =

>> tcp_extra_options_prepare{,_req}() and tcp_extra_options_write(). I'll =

>> double-check that nothing blocks or sleeps between those calls.
>> =

>>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>>> +        if (unlikely(!entry->prepare))
>>> +            continue;
>>> +
>>> +        used +=3D entry->prepare(skb, flags, remaining - used, opts, t=
p);
>>> +    }
>>> +    rcu_read_unlock();
> Should there be a check to stop calling when no space is left ?
> This also raises the question of priority, which seems to be based on the =

> place in the list. What happens if there is no space left ? Do you add =

> MPTCP's DSS  option or SACK or MD5 ?

I think it should keep calling even if there's no space - it might be =

useful to know a packet is going out with its option space used. The =

prepare() call will need to handle too little space anyway (even if it's =

more than 0).

Ordering is an open question. It would be a minor extension to maintain =

the list ordered by priority when each option is registered. There's a =

comment before tcp_options_write cautioning that option ordering can be =

sensitive, but we aren't changing the order of the "normal" TCP options. =

Still, I think I agree with you that changing the order of options based =

on who registered first is not great.

Regarding SACK specifically, I placed the prepare() call before SACK so =

that the registered options would consume space before SACK tried to use =

up the rest.

>>> +
>>> +    return used;
>>> +}
>>> +
>>> +unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 fla=
gs,
>>> +                       unsigned int remaining,
>>> +                       struct tcp_out_options *opts,
>>> +                       struct request_sock *req)
>>> +{
>>> +    struct tcp_extra_option_ops *entry;
>>> +    unsigned int used =3D 0;
>>> +
>>> +    rcu_read_lock();
>> =

>> Same applies to this read lock and tcp_extra_options_write below.
>> =

>>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>>> +        if (unlikely(!entry->prepare_req))
>>> +            continue;
>>> +
>>> +        used +=3D entry->prepare_req(skb, flags, remaining - used, opt=
s,
>>> +                       req);
>>> +    }
>>> +    rcu_read_unlock();
> Again need to check for space, missing out on adding an option due to lac=
k of =

> space is less of an issue here.
>
>>> +
>>> +    return used;
>>> +}
>>> +
>>> +void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
>>> +                 struct tcp_sock *tp)
>>> +{
>>> +    struct tcp_extra_option_ops *entry;
>>> +
>>> +    rcu_read_lock();
>>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>>> +        if (unlikely(!entry->write))
>>> +            continue;
>>> +
>>> +        entry->write(ptr, opts, tp);
> I think you need a check here to call only options that are in opts ?

This code doesn't know which opts are relevant - does it make a big =

difference if we check here and optionally call, or call and let that =

function quickly check to see if it needs to write? The list is expected =

to be short.

> We should also pass in skb, In case tcp header is needed to generate opti=
on =

> values.

I was trying to not add a parameter to tcp_options_write, but we can =

change this if needed. The prepare() call gets the skb pointer, so it =

could store necessary information (if we figure out where to put it).

>>> +    }
>>> +    rcu_read_unlock();
>>> +}
>> =

>
> This is a great framework for handling options, my concern is that the =

> options processing is intertwined with TCP code. Unless we can implement =
that =

> separately there will not be much benefit.

Are you suggesting a larger rewrite of TCP option handling overall? Or are =

you referring to the intertwined MPTCP option handling in the =

multipath-tcp.org kernel?

> Just search for CONFIG_TCP_MD5SIG, MPTCP related code is also sprinkled =

> all over tcp code. Before we go down this path should we evaluate if =

> that can be achieved ?

As Christoph mentioned, MD5SIG would be one way to validate that the =

framework provides a useful approach for multiple TCP features. There's =

still more work to do to see if MPTCP can fit within this framework, and I =

expect the approach to options to evolve as we learn more.

> I have found a way to make MPTCP work without using tcp_skb_cb, I will po=
st =

> the patch after I clean up the code. However my approach is very specific=
 to =

> MPTCP. If we went with this framework, we would need a generic way to pas=
s =

> the options. I have ideas on how to do that but that would require a lot =
of =

> changes to the tcp/skb code.

Great, thanks for the update! I look forward to seeing what you've got, =

maybe we can share some ideas about fitting it with the framework.

Regards,

--
Mat Martineau
Intel OTC

--===============2507368116479736864==--
