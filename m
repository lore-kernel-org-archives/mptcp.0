Content-Type: multipart/mixed; boundary="===============3516593530785377684=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: deal better with out-of-sequence
 mapping
Date: Fri, 18 Oct 2019 08:37:51 +0200
Message-ID: <092d31fd-6c33-c53c-34ff-6edb303aab26@tessares.net>
In-Reply-To: 5cbb90dd96596787c70d1c09008954ebbabd5e5d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2233

--===============3516593530785377684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/10/2019 16:03, Paolo Abeni wrote:
> Hi,
> =

> On Thu, 2019-10-17 at 15:22 +0200, Matthieu Baerts wrote:
>> On 17/10/2019 11:00, Paolo Abeni wrote:
> =

> [...]
>>> +static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
>>> +{
>>> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>>> +	unsigned skb_consumed;
>>> +
>>> +	skb_consumed =3D tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
>>> +	if (WARN_ON_ONCE(skb_consumed >=3D skb->len))
>>> +		return true;
>>> +
>>> +	return skb->len - skb_consumed <=3D subflow->map_data_len -
>>> +					  mptcp_subflow_get_map_offset(subflow);
>>
>> Do we need to do something special here and/or above to deal with
>> wraparounds?
>>
>> By only looking at this chunk of code, it looks like skb_consumed can
>> have a huge value if one of the two seq numbers have done a wraparound.
> =

> Differences are ok even in case of wrap-around. AFAIK, we could have
> problem only if skb_consumed would be signed and the distance between
> 'copied_seq' and 'seq' would grow above 1<<31. So basically we can't ;)
> =

> 'seq' can be greated than 'copied_seq' just in case of some bug
> elsewhere (in TCP and/or in our calls to tcp_read_sock()), and we
> should get a warn on the next line, if so.

Thank you for this explanation!

>> Then we might have a warning.
>> Same below with map_data_len and the offset, no?
> =

> mptcp_subflow_get_map_offset() can be greater of map_data_len only if
> we hit a bug somewhere else. Other places using that algebra currently
> don't warn, so I did not add an explicit check here. I would avoid
> that, to avoid adding more warns in subflow.c and protocol.c

Sounds good to me! Thank you for this note!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3516593530785377684==--
