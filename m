Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AA68
	for <mptcp@lists.linux.dev>; Wed,  1 Dec 2021 18:39:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="234029172"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="234029172"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 10:34:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="512156086"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.209.83.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 10:34:47 -0800
Date: Wed, 1 Dec 2021 10:34:42 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: implement fastclose xmit
 path"
In-Reply-To: <bc4304c9-12f3-3961-de6a-7549034eb932@tessares.net>
Message-ID: <6cdf99-1cbd-baca-4dc1-2d7149f9a9d9@linux.intel.com>
References: <e7427851-a812-05b7-6441-cb9e6f61e65c@tessares.net> <20211130165527.1506827-1-matthieu.baerts@tessares.net> <05864fd724521fcde2e7e40b95a825f5e21a3e2c.camel@redhat.com> <bc4304c9-12f3-3961-de6a-7549034eb932@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 1 Dec 2021, Matthieu Baerts wrote:

> Hi Paolo, Geliang,
>
> On 01/12/2021 11:40, Paolo Abeni wrote:
>> On Tue, 2021-11-30 at 17:55 +0100, Matthieu Baerts wrote:
>>> This is linked to Geliang's patch with the same title.
>>>
>>> If I understand the RFC properly, we can use MP_RST with an MP_FASTCLOSE
>>> and an MP_FAIL (or none of them) but we cannot use MP_FASTCLOSE and
>>> MP_FAIL together.
>>>
>>> This patch implements this logic in both mptcp_established_options() and
>>> mptcp_write_options(). Before this patch, the first function was not
>>> allowing any of these 3 options to be used at the same time while the
>>> second one was allowing MP_FAIL to be used with either MP_FASTCLOSE or
>>> MP_RST.
>>>
>>> Small note: I tried to keep Paolo's idea of reducing conditions for
>>> "normal" options by moving MP_RST at the end and allow to jump there
>>> from MP_FAIL and MP_FASTCLOSE but I'm not sure it makes it easy to read
>>> and really improves perfs. We can also move MP_RST check at the
>>> beginning.
>>>
>>> @Geliang: feel free to re-use this patch if it looks OK to you.
>>>
>>> PS: I didn't try this patch, just quickly wrote it to better explain
>>> what I had in mind.
>>>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Geliang Tang <geliang.tang@suse.com>
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> ---
>>>
>>> Notes:
>>>     to be squashed in "mptcp: implement fastclose xmit path"
>>>
>>>  net/mptcp/options.c | 62 +++++++++++++++++++++++++++------------------
>>>  1 file changed, 37 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 8a1020e4285c..07091971a51a 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -829,11 +829,17 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>>
>>>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
>>>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
>>> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
>>> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>>> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
>>>  			*size += opt_size;
>>>  			remaining -= opt_size;
>>>  		}
>>> +
>>> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
>>> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
>>> +			*size += opt_size;
>>> +			remaining -= opt_size;
>>> +		}
>>> +
>>>  		return true;
>>>  	}
>>>
>>> @@ -1257,21 +1263,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
>>>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>>  			 struct mptcp_out_options *opts)
>>>  {
>>> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
>>> -		const struct sock *ssk = (const struct sock *)tp;
>>> -		struct mptcp_subflow_context *subflow;
>>> -
>>> -		subflow = mptcp_subflow_ctx(ssk);
>>> -		subflow->send_mp_fail = 0;
>>> -
>>> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
>>> -				      TCPOLEN_MPTCP_FAIL,
>>> -				      0, 0);
>>> -		put_unaligned_be64(opts->fail_seq, ptr);
>>> -		ptr += 2;
>>> -	}
>>> -
>>> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
>>> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
>>>  	 * see mptcp_established_options*()
>>>  	 */
>>>  	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
>>> @@ -1458,19 +1450,39 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>>  				ptr += 1;
>>>  			}
>>>  		}
>>> -	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
>>> -		/* RST is mutually exclusive with everything else */
>>> -		*ptr++ = mptcp_option(MPTCPOPT_RST,
>>> -				      TCPOLEN_MPTCP_RST,
>>> -				      opts->reset_transient,
>>> -				      opts->reset_reason);
>>> -		return;
>>>  	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
>>> -		/* FASTCLOSE is mutually exclusive with everything else */
>>> +		/* FASTCLOSE is mutually exclusive with others except RST */
>>>  		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
>>>  				      TCPOLEN_MPTCP_FASTCLOSE,
>>>  				      0, 0);
>>>  		put_unaligned_be64(opts->rcvr_key, ptr);
>>> +
>>> +		if (OPTION_MPTCP_RST & opts->suboptions)
>>> +			goto mp_rst;
>>> +		return;
>>> +	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
>>> +		/* MP_FAIL is mutually exclusive with others except RST */
>>> +		const struct sock *ssk = (const struct sock *)tp;
>>> +		struct mptcp_subflow_context *subflow;
>>> +
>>> +		subflow = mptcp_subflow_ctx(ssk);
>>> +		subflow->send_mp_fail = 0;
>>> +
>>> +		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
>>> +				      TCPOLEN_MPTCP_FAIL,
>>> +				      0, 0);
>>> +		put_unaligned_be64(opts->fail_seq, ptr);
>>> +		ptr += 2;
>>> +
>>> +		if (OPTION_MPTCP_RST & opts->suboptions)
>>> +			goto mp_rst;
>>> +		return
>>
>> As the CI spotted, missing ';' here.
>
> Yes sorry, I quickly did it before having to go.
>
>> Otherwise LGTM!
>
> Thank you for the review!
>
> @Geliang: do you prefer to use this diff -- without the missing ';' --
> in a new version or do you prefer if I apply it with the fix directly?
>

Matthieu -

Since you were handling Geliang's revisions of this series while I was 
away, I assume you are not waiting to hear from me, but anyway: these 
changes (plus ';') combined with Geliang's v3 all look good to me too.

--
Mat Martineau
Intel
