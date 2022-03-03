Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3D36B
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 00:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646268289; x=1677804289;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5jLuvL6oCcbWpMzrGJtKJhCbQxZHEQECh0nmoPSgHA4=;
  b=hKIpLb/mYtPnC/GkQ0ufleJKj2TPrXyGqPvQrLzvPkqKbkewFxWQ8+hI
   d4fdyeXHg4/03mo7uGBCxTDzMzigM0yUMkPT1iESTFCGKrbaDvtxQxCiA
   2Vm96czpXT/WKphguHRyLExYS+tqQfO+IvrKsQPQqgNvMo6AdksFdl/RS
   Gr1+7akyF1Ck+nMLtSvhcBf1Wv7wB734VDbgpEP58Ry8Kabb2fExqEHE5
   foGleAPgbfV18bfMZ23eOyjIILxWOCGR+D97Di0Jbb0cJgADwit677DMc
   UMHw/2PktauQ9jWtwjIcsT5iIkC3EQnnaTOcSR+bAm9cxVByQ5GjInVjO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="240957782"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="240957782"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:44:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="576301356"
Received: from ashetty-mobl1.amr.corp.intel.com ([10.209.74.124])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:44:48 -0800
Date: Wed, 2 Mar 2022 16:44:48 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, fw@strlen.de
Subject: Re: [RFC PATCH mptcp-next 4/4] tcp: Add TCP hooks for detecting
 MP_JOIN on a regular TCP listener
In-Reply-To: <f7224fe7-5db-d6ef-6665-13ecba2aed1@linux.intel.com>
Message-ID: <3423147d-efd8-5e77-e92-20348ab16ec5@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>  <20220224232226.259304-5-mathew.j.martineau@linux.intel.com> <f1b2e28b245f5da89de6e045a73e5baa327282bb.camel@redhat.com> <f7224fe7-5db-d6ef-6665-13ecba2aed1@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 2 Mar 2022, Mat Martineau wrote:

> On Fri, 25 Feb 2022, Paolo Abeni wrote:
>
>> On Thu, 2022-02-24 at 15:22 -0800, Mat Martineau wrote:
>>> MPTCP uses a TCP SYN packet with the MP_JOIN option to add subflows to
>>> an existing MPTCP connection. This uses token lookup to match the
>>> incoming SYN with the appropriate MPTCP socket instead of the port
>>> number (in accordance with RFC 8684), and it is possible for a TCP
>>> listener to be present at the port that the MPTCP peer is trying to
>>> connect to. If the TCP listener ignores the MP_JOIN option and sends a
>>> normal TCP SYN-ACK without a MP_JOIN option header, the peer will be
>>> forced to send a RST.
>>> 
>>> Given that a peer sending MP_JOIN is guaranteed to reject a regular TCP
>>> SYN-ACK, it's better to attempt a MPTCP token lookup and either let
>>> MPTCP continue the handshake or immediately reject the connection
>>> attempt.
>>> 
>>> The only new conditional in the TCP SYN handling hot path is a check of
>>> the saw_mp_join bit. If that is set, tcp_check_req() returns early and
>>> tcp_v4_rcv() or tcp_v6_rcv() call the MPTCP join handler in an error
>>> path.
>>> 
>>> If MPTCP is not configured, all the code added in this commit should be
>>> optimized away.
>>> 
>>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>> ---
>>>  net/ipv4/tcp_ipv4.c      | 7 +++++++
>>>  net/ipv4/tcp_minisocks.c | 8 +++++++-
>>>  net/ipv6/tcp_ipv6.c      | 7 +++++++
>>>  3 files changed, 21 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>>> index 73e5726af8d0..124ad393e6fb 100644
>>> --- a/net/ipv4/tcp_ipv4.c
>>> +++ b/net/ipv4/tcp_ipv4.c
>>> @@ -2082,6 +2082,13 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>>  				tcp_v4_restore_cb(skb);
>>>  				sock_put(sk);
>>>  				goto lookup;
>>> +			} else if (req_status == TCP_REQ_MP_JOIN) {
>>> +				struct sock *msk = mptcp_handle_join4(skb);
>>> +
>>> +				if (msk) {
>>> +					sk = msk;
>>> +					goto process;
>>> +				}
>> 
>> If I read correctly, this will handle MPJ 3rd ack packets, we will need
>> a similar chunk for incoming MPJ syn in tcp_rcv_state_process(), and
>> likely something additional for syncookies.
>> 
>
> I think you're correct here and below. In trying to put a quick RFC 
> together, I was thinking about what happens on this code path when 
> trying to get the TCP listener to reject, but skipped over the use of 
> this code by the MPTCP subflow listener. Handling both cases does make 
> this approach more intrusive to the TCP code.
>

...on second thought, maybe not much more intrusive?

>>>  			}
>>>  			goto discard_and_relse;
>>>  		}
>>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>>> index 3d989f8676a5..4fdca31b33bb 100644
>>> --- a/net/ipv4/tcp_minisocks.c
>>> +++ b/net/ipv4/tcp_minisocks.c
>>> @@ -572,10 +572,16 @@ struct sock *tcp_check_req(struct sock *sk, struct 
>>> sk_buff *skb,
>>>  	bool own_req;
>>>
>>>  	tmp_opt.saw_tstamp = 0;
>>> +	tmp_opt.saw_mp_join = 0;
>>>  	if (th->doff > (sizeof(struct tcphdr)>>2)) {
>>>  		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
>>> 
>>> -		if (tmp_opt.saw_tstamp) {
>>> +		if (unlikely(tmp_opt.saw_mp_join) &&

Make sure this only triggers on a regular TCP listener:

+		    !sk_is_mptcp(sk) &&

>>> +		    mptcp_is_enabled(sock_net(sk))) {
>>> +			*req_status = TCP_REQ_MP_JOIN;

Then the TCP_REQ_MP_JOIN status is only ever encountered on a plain TCP 
listener where the MP_JOIN header is present. This was my original intent 
but the above conditional was buggy.

>> 
>> If I read correctly, this skips all the state and sequence number check
>> we have on plain TCP 3rd ack. I think we want to preserve them.
>

For plain TCP 3rd ack, there's no MP_JOIN option and tcp_check_req() 
behavior is unchanged.

For a MP_JOIN SYN being processed by a plain TCP listener, this returns 
early, then the token lookup is attempted as if there had been no TCP 
listener to begin with. If there's a token match then the MPTCP listener 
will do all the checks like it did before.

--
Mat Martineau
Intel
