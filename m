Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8296153
	for <mptcp@lists.linux.dev>; Wed,  2 Mar 2022 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646265483; x=1677801483;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J9BbiTM65LnN4afG3AeETSKGoirsKX2OeWo9C/FAtrM=;
  b=MBAUk86wNb2lW02d056HEUbPzKRXHL86/M3qjU2x6u04flQ0FXDDr4+c
   q2DbKaxHdGaw9Ah5QBzJU5jMSYrGV2gzdPGo2I2L5XbnKMp+50oY20/hV
   bYaAQn3bEuavXyeLvlUzGuRWeAIvuvDQtJ4LEPuOsYwnfjdZVbR54vYTR
   sZD0fzQ71Rtm2d4siv0VePvwfVmA9Z031Xl4r1Ub4tlZRfslSej2K5i3v
   k+L9E14l2rwqKDHrV9H1YCyQZ3yfz+AwnJrt3wWSe5JY45/SCZq/8bv28
   dJ1RcXY6VJ2kLiSG43iierkLbkFLgxqAUrly0RDMpea5hhmppU9GF7A+7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253463937"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253463937"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:57:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="808378820"
Received: from ashetty-mobl1.amr.corp.intel.com ([10.209.74.124])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:57:44 -0800
Date: Wed, 2 Mar 2022 15:57:44 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, fw@strlen.de
Subject: Re: [RFC PATCH mptcp-next 4/4] tcp: Add TCP hooks for detecting
 MP_JOIN on a regular TCP listener
In-Reply-To: <f1b2e28b245f5da89de6e045a73e5baa327282bb.camel@redhat.com>
Message-ID: <f7224fe7-5db-d6ef-6665-13ecba2aed1@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>  <20220224232226.259304-5-mathew.j.martineau@linux.intel.com> <f1b2e28b245f5da89de6e045a73e5baa327282bb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 25 Feb 2022, Paolo Abeni wrote:

> On Thu, 2022-02-24 at 15:22 -0800, Mat Martineau wrote:
>> MPTCP uses a TCP SYN packet with the MP_JOIN option to add subflows to
>> an existing MPTCP connection. This uses token lookup to match the
>> incoming SYN with the appropriate MPTCP socket instead of the port
>> number (in accordance with RFC 8684), and it is possible for a TCP
>> listener to be present at the port that the MPTCP peer is trying to
>> connect to. If the TCP listener ignores the MP_JOIN option and sends a
>> normal TCP SYN-ACK without a MP_JOIN option header, the peer will be
>> forced to send a RST.
>>
>> Given that a peer sending MP_JOIN is guaranteed to reject a regular TCP
>> SYN-ACK, it's better to attempt a MPTCP token lookup and either let
>> MPTCP continue the handshake or immediately reject the connection
>> attempt.
>>
>> The only new conditional in the TCP SYN handling hot path is a check of
>> the saw_mp_join bit. If that is set, tcp_check_req() returns early and
>> tcp_v4_rcv() or tcp_v6_rcv() call the MPTCP join handler in an error
>> path.
>>
>> If MPTCP is not configured, all the code added in this commit should be
>> optimized away.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> ---
>>  net/ipv4/tcp_ipv4.c      | 7 +++++++
>>  net/ipv4/tcp_minisocks.c | 8 +++++++-
>>  net/ipv6/tcp_ipv6.c      | 7 +++++++
>>  3 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 73e5726af8d0..124ad393e6fb 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -2082,6 +2082,13 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>  				tcp_v4_restore_cb(skb);
>>  				sock_put(sk);
>>  				goto lookup;
>> +			} else if (req_status == TCP_REQ_MP_JOIN) {
>> +				struct sock *msk = mptcp_handle_join4(skb);
>> +
>> +				if (msk) {
>> +					sk = msk;
>> +					goto process;
>> +				}
>
> If I read correctly, this will handle MPJ 3rd ack packets, we will need
> a similar chunk for incoming MPJ syn in tcp_rcv_state_process(), and
> likely something additional for syncookies.
>

I think you're correct here and below. In trying to put a quick RFC 
together, I was thinking about what happens on this code path when trying 
to get the TCP listener to reject, but skipped over the use of this code 
by the MPTCP subflow listener. Handling both cases does make this approach 
more intrusive to the TCP code.

>>  			}
>>  			goto discard_and_relse;
>>  		}
>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>> index 3d989f8676a5..4fdca31b33bb 100644
>> --- a/net/ipv4/tcp_minisocks.c
>> +++ b/net/ipv4/tcp_minisocks.c
>> @@ -572,10 +572,16 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>>  	bool own_req;
>>
>>  	tmp_opt.saw_tstamp = 0;
>> +	tmp_opt.saw_mp_join = 0;
>>  	if (th->doff > (sizeof(struct tcphdr)>>2)) {
>>  		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
>>
>> -		if (tmp_opt.saw_tstamp) {
>> +		if (unlikely(tmp_opt.saw_mp_join) &&
>> +		    mptcp_is_enabled(sock_net(sk))) {
>> +			*req_status = TCP_REQ_MP_JOIN;
>
> If I read correctly, this skips all the state and sequence number check
> we have on plain TCP 3rd ack. I think we want to preserve them.

--
Mat Martineau
Intel
