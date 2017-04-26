Content-Type: multipart/mixed; boundary="===============5247281491691724752=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Register handlers for extra TCP options
Date: Wed, 26 Apr 2017 12:54:05 -0700
Message-ID: <918883b9-18f0-c29a-0d20-00592cd27631@oracle.com>
In-Reply-To: alpine.OSX.2.21.1704241552400.39098@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 10

--===============5247281491691724752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Good work see my comments inline..


On 04/24/2017 04:06 PM, Mat Martineau wrote:
>
> On Thu, 20 Apr 2017, Mat Martineau wrote:
>
>> Allow additional TCP options to be handled by registered hook
>> functions.
>>
>> Option parsing will call the provided 'parse' function when a TCP option
>> number is not recognized by the normal option parsing code.
>>
>> The 'prepare' and 'prepare_req' functions determine the required space
>> for registered options and store associated data. There are two variants
>> because options must be generated for connections that are associated
>> with either tcp_sock or request_sock structures.
If I understand correctly the only difference should be the options =

chosen. Why not handle this as is done today, syn and established options ?
>> A static key and RCU synchronization are used to minimize the
>> performance impact of these extensible TCP features.
>>
>> Before this is posted upstream, I plan to split the patch in two parts
>> (at least), since making tcp_out_options public should be separate. The
>> extra parameter for tcp_parse_options may also warrant its own
>> patch. I'd also like to discuss where to store information for the
>> options that are parsed or generated using these hooks, since the
>> tcp_options_received and tcp_out_options structs don't have places to
>> store extra information yet.
>>
>> I've confirmed that this code builds, but haven't tested yet.
>>
>> This commit is also available at
>> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
>> branch: mptcp
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>
> ...
>
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 04843ae77b9e..e0d0504f005a 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -3279,6 +3287,132 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
>>
>> #endif
>>
>> +/* Linear search, few entries are expected. The RCU read lock must
>> + * be held before calling.
>> + */
>> +static struct tcp_extra_option_ops =

>> *tcp_extra_options_find_kind(unsigned char kind)
>> +{
>> +    struct tcp_extra_option_ops *entry;
>> +
>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +        if (entry->option_kind =3D=3D kind)
>> +            return entry;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +void tcp_extra_options_parse(int opcode, int opsize, const unsigned =

>> char *opptr,
>> +                 const struct sk_buff *skb,
>> +                 struct tcp_options_received *opt_rx,
>> +                 struct tcp_sock *tp)
>> +{
>> +    struct tcp_extra_option_ops *entry;
>> +
>> +    rcu_read_lock();
>> +    entry =3D tcp_extra_options_find_kind(opcode);
>> +    if (entry && entry->parse)
>> +        entry->parse(opsize, opptr, skb, opt_rx, tp);

There does not seems to be a return value, what happens if the parsing =

fails or the processing requires resetting the connection. For example =

in MPTCP if checksum required is present but is not configured, the =

current code returns an error and the connection is reset.
We should provide provision to call a default function for an option =

that does not match, so it can at least be documented and the user may =

set an option to reset the connection.

>> +    rcu_read_unlock();
>> +}
>> +
>> +unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
>> +                       unsigned int remaining,
>> +                       struct tcp_out_options *opts,
>> +                       struct tcp_sock *tp)
>> +{
>> +    struct tcp_extra_option_ops *entry;
>> +    unsigned int used =3D 0;
>> +
>> +    rcu_read_lock();
>
> I think I'll change this to have the caller handle =

> rcu_read_lock/unlock, so the registered option list stays the same =

> between the paired calls to tcp_extra_options_prepare{,_req}() and =

> tcp_extra_options_write(). I'll double-check that nothing blocks or =

> sleeps between those calls.
>
>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +        if (unlikely(!entry->prepare))
>> +            continue;
>> +
>> +        used +=3D entry->prepare(skb, flags, remaining - used, opts, tp=
);
>> +    }
>> +    rcu_read_unlock();
Should there be a check to stop calling when no space is left ?
This also raises the question of priority, which seems to be based on =

the place in the list. What happens if there is no space left ? Do you =

add MPTCP's DSS  option or SACK or MD5 ?
>> +
>> +    return used;
>> +}
>> +
>> +unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 =

>> flags,
>> +                       unsigned int remaining,
>> +                       struct tcp_out_options *opts,
>> +                       struct request_sock *req)
>> +{
>> +    struct tcp_extra_option_ops *entry;
>> +    unsigned int used =3D 0;
>> +
>> +    rcu_read_lock();
>
> Same applies to this read lock and tcp_extra_options_write below.
>
>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +        if (unlikely(!entry->prepare_req))
>> +            continue;
>> +
>> +        used +=3D entry->prepare_req(skb, flags, remaining - used, opts,
>> +                       req);
>> +    }
>> +    rcu_read_unlock();
Again need to check for space, missing out on adding an option due to =

lack of space is less of an issue here.

>> +
>> +    return used;
>> +}
>> +
>> +void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
>> +                 struct tcp_sock *tp)
>> +{
>> +    struct tcp_extra_option_ops *entry;
>> +
>> +    rcu_read_lock();
>> +    list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +        if (unlikely(!entry->write))
>> +            continue;
>> +
>> +        entry->write(ptr, opts, tp);
I think you need a check here to call only options that are in opts ?
We should also pass in skb, In case tcp header is needed to generate =

option values.
>> +    }
>> +    rcu_read_unlock();
>> +}
>

This is a great framework for handling options, my concern is that the =

options processing is intertwined with TCP code. Unless we can implement =

that separately there will not be much benefit. Just search for =

CONFIG_TCP_MD5SIG, MPTCP related code is also sprinkled all over tcp =

code. Before we go down this path should we evaluate if that can be =

achieved ?

I have found a way to make MPTCP work without using tcp_skb_cb, I will =

post the patch after I clean up the code. However my approach is very =

specific to MPTCP. If we went with this framework, we would need a =

generic way to pass the options. I have ideas on how to do that but that =

would require a lot of changes to the tcp/skb code.

Rao.

> -- =

> Mat Martineau
> Intel OTC
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============5247281491691724752==--
