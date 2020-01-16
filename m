Content-Type: multipart/mixed; boundary="===============8127312338626805478=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1] mptcp: handle ipv4-mapped ipv6 address.
Date: Thu, 16 Jan 2020 07:54:36 -0800
Message-ID: <alpine.OSX.2.21.2001160744150.45790@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: 5acd242e52ebe981e06148190ef43b8213207fe1.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3375

--===============8127312338626805478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 16 Jan 2020, Paolo Abeni wrote:

> On Wed, 2020-01-15 at 19:00 -0800, Mat Martineau wrote:
>> On Wed, 15 Jan 2020, Paolo Abeni wrote:
>>
>>> The TCP code unconditionally overwrite in a few places 'icsk->icsk_af_o=
ps',
>>> which lead to the wrong oops being called for ipv4-mapped ipv6 address.
>>> e.g. Kasan notice a invalid slub access running packetdrill ipv4-mapped
>>> tests.
>>>
>>> This patch try to address the issue building ipv4-mapped  mptcp icsk ops
>>> and using it when appropriate:
>>> - on connect() for ipv4 mapped address (and ev. failure)
>>> - on syn_recv_sock() - passive socket creation
>>>
>>> Additionally subflow_v6_conn_request() should call into subflow_v4_conn=
_request()
>>> for ipv4 packets, otherwise we always fallback on passive socket bound =
to
>>> ipv4 mapped addresses.
>>>
>>> Note: this still touches af_ops twice. If we do differently, alike:
>>>
>>> 	if (sk_is_mptcp(newsk))
>>> 		mptcp_handle_ipv6_mapped(sk, true);
>>> 	else
>>> 		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
>>>
>>> we need either:
>>> - additionally handle the #ifnef CONFIG_MPTCP_IPV6 case in
>>> as mptcp_handle_ipv6_mapped(), as we risk to skip 'icsk_af_ops'
>>> initialization otherwise.
>>> - wrap the above mptcp_handle_ipv6_mapped() call under
>>> a preprocessor's conditional (CONFIG_MPTCP_IPV6).
>>
>> I was thinking something like:
>>
>> static struct inet_connection_sock_af_ops *get_mapped_af_ops(sk)
>> {
>>  	if (likely(!sk_is_mptcp(sk)))
>>  		return &ipv6_mapped;
>>  	else
>>  		return mptcp_handle_ipv6_mapped(sk);
>> }
>>
>> (with mptcp_handle_ipv6_mapped() modified to return the relevant pointer
>> rather than assign to icsk_af_ops, and handling
>> different CONFIG_MPTCP_IPV6 settings)
>
>
> Uhm... I don't like much 'mptcp_handle_ipv6_mapped()' being a sort of
> 'getter' that also modify the status (it changes subflow af_ops).

That's fine - I wasn't sure I explained the idea well in response to the =

RFC version of the patch, so I wanted to clarify.

>
> Additionally mptcp_handle_ipv6_mapped() must handle the
>
> #ifndef CONFIG_MPTCP_IPV6
>
> conditional. Likely it should never be called if !CONFIG_MPTCP_IPV6,
> but the overall code will be not so nice IMHO:
>
> static struct inet_connection_sock_af_ops *mptcp_handle_ipv6_mapped(sk)
> {
> #ifdef CONFIG_MPTCP_IPV6
> 	// ... set subflow af_ops
> 	return subflow_v6m_af_ops;
> #else
> 	// ????
> 	WARN_ON_ONCE(1);
> 	return 0; // caller will crash
> 	// or
> 	// return &subflow_v6_af_ops // caller will crash too
> 	// or
> 	// return &subflow_v4_af_ops // ditto
> 	// or
> 	// return &ipv6_mapped; // needs additional 'export'

This is where I thought having a helper function within tcp_ipv6.c would =

be helpful for returning &ipv6_mapped.

> 	// or
> 	// BUG_ON(1); // perhaps this ??? still not nice IMHO
> #endif
> }
>
> WDYT?

I don't think the 'getter' approach is required - the maintainers might =

not even consider it a problem.

Should still do something about the extra mptcp_handle_ipv6_mapped() =

parameter though.

--
Mat Martineau
Intel
--===============8127312338626805478==--
