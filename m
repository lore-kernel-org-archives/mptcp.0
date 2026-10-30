Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360569;
	b=MMzerp+jasAPV34/pnbcdMoWJnVJiF15eGTE+a89215NfN22V6khFgi7lXaYHiy/mLrT
	 YYTrgnUMZ7iLg0ynhLEZtiuQAp3FgkOGPIBd7qbsNj/SEs5jZaMx1tKPiGp+ramWBqvR8
	 f5XG2Dcvq8b3L0EVYRDNCcEAGiOyYv1Sj0AmAU9Mqin2eh/OszkgVIpDrD8dCghIERJH9
	 CZt6D4l7UkIkMVnF6S/6zv/Np4kTdQrpt2o+Y9TsyEas9H5ah3u/w6TIN10z2dmK0T9iS
	 ODK8HPq8UU5uu/ccOHIlRB9wg21x/1lTVGd8ozzD5Ou75xhz4Je7h9Xw9YG2jZ+84zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360569;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KWtletzfNUB1pYmx01WPsayHIKi2DPTSyiDJEKx/2RI=;
	b=sRcRBG2u88b5tq0hcXXTZqYy3u18sBOb8fLV+DZh7tVfxJGygrNnbTUU6Qz5x360thuC
	 tYwchf0yYLtDJv9dUf50jY6PsoaH0sXVO/CdoD9y+V4sEGiEDeue5/FfZxGe/pJAMjOiO
	 8FuAVmiG4rglnMjyBGFYr8HJbrJa+hmCv7QFD39K/jzw1dI8Aw8z/cegqQgvf+meaeUrV
	 XngGKXN8Cp16I2frtAmoGi6gtgqE7T4+ZyfEAcWr6LVRefvqFOiChVUX4rzk5RznparZF
	 oZ42QXqU1qgBTLhj5Y2H9OCK4Tc+mFS/m9O4kQjM9uL5R6fya6bKVd7st8B4z8Dnn8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3KoVcpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5E606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3KoVcpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F162B1F000C1;
	Fri, 30 Oct 2026 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360569;
	bh=KWtletzfNUB1pYmx01WPsayHIKi2DPTSyiDJEKx/2RI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q3KoVcpyyb2ZOo4OmR/weR6xWUGjTUhiMZf99ipOegTPjevw1TiSagxnsLNcqdCKb
	 F3Smi9Ei3MKaXB0cDUE8dCM1xh1NF1FeV4aeAcHrJllLDS+e59WzWLzZ/IXChUn6WW
	 tv24BjfELmrPV8AjDWT7fDY/46MRM+CUjzK7slRplkzRiYfoQAGOniYIy/vtI+O5SZ
	 jKbJUIQRy4comckkQDGihZ39buoM4RpsdkYYlEIm03cfH3SVcKq74NT4HLq7vsVGj1
	 GFBjl4ac33V9qgtKAHzcO5hByV+EMdYG5O5PP5DEOvbLNGwKfH1FFmEBJPED/Sb7I0
	 jeNXEAE2P2KVQ==
Message-ID: <241cf22f-fe1b-4afc-a2d0-97a5b3329b51@kernel.org>
Date: Fri, 30 Oct 2026 12:42:45 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: reject MP_JOIN earlier
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 Chenguang Zhao <chenguang.zhao@linux.dev>, Gang Yan <gang.yan@linux.dev>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
 <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
 <7ef983a66bc3303f33a95db8fe112024175a45f9.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7ef983a66bc3303f33a95db8fe112024175a45f9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review.

On 30/10/2026 05:43, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2026-10-30 at 00:21 +0100, Matthieu Baerts (NGI0) wrote:
>> When a SYN + MP_JOIN is received, it is good to check directly if the
>> MP_JOIN is allowed, then checking that later at the establishment of
>> the
>> new subflow.
>>
>> This avoids situations where the 3WHS is done, then the joined
>> subflow
>> is rejected.
>>
>> This changes the behaviour, and the new behaviour is tracked with the
>> MPJoinDisallowed MIB counter.
>>
>> Note that in the selftests, we need to support older kernels not
>> following this new behaviour. For that, we can check if the new
>> counter
>> is present: if it is, the join rejected counter should be used
>> instead,
>> and we should see more SYN+ACK. One exception for the SYN cookies
>> case
>> were the reject was already done early but MPJoinRejected was used
>> instead.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2:
>>  - Explain that mptcp_can_accept_new_subflow() is racy, but OK.
>> (Paolo)
>>  - support older kernels with the previous behaviour.
>>  - no more special case for syncookie, switch to new counter.
>>  - s/MPJoinDisallow/MPJoinDisallowed/ (+ ed). (Sashiko)
>> ---
>>  net/mptcp/mib.c                                 |  1 +
>>  net/mptcp/mib.h                                 |  1 +
>>  net/mptcp/subflow.c                             | 31 +++++++++-----
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 55
>> +++++++++++++++++++------
>>  4 files changed, 64 insertions(+), 24 deletions(-)
>>
>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>> index 608cb568897c..b1710082bbca 100644
>> --- a/net/mptcp/mib.c
>> +++ b/net/mptcp/mib.c
>> @@ -34,6 +34,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>  	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
>>  	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
>>  	SNMP_MIB_ITEM("MPJoinNotEstablished",
>> MPTCP_MIB_MPJOINNOTESTABLISHED),
>> +	SNMP_MIB_ITEM("MPJoinDisallowed",
>> MPTCP_MIB_MPJOINDISALLOWED),
>>  	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
>>  	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr",
>> MPTCP_MIB_JOINSYNTXCREATSKERR),
>>  	SNMP_MIB_ITEM("MPJoinSynTxBindErr",
>> MPTCP_MIB_JOINSYNTXBINDERR),
>> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
>> index 1ebdb55e9534..e97ee2d952a7 100644
>> --- a/net/mptcp/mib.h
>> +++ b/net/mptcp/mib.h
>> @@ -29,6 +29,7 @@ enum linux_mptcp_mib_field {
>>  	MPTCP_MIB_MPJOINACKNOCTX,	/* MP_RST: no subflow
>> context on ACK */
>>  	MPTCP_MIB_JOINREJECTED,		/* The PM rejected
>> the JOIN request */
>>  	MPTCP_MIB_MPJOINNOTESTABLISHED,	/* MP_RST: JOIN on
>> not-fully-established msk */
>> +	MPTCP_MIB_MPJOINDISALLOWED,	/* RST JOIN early if
>> disallowed: fallback/PM */
>>  	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN
>> */
>>  	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a
>> socket when sending a SYN + MP_JOIN */
>>  	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the
>> address when sending a SYN + MP_JOIN */
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 78e886b20258..f9785e20e209 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -117,7 +117,8 @@ static void subflow_req_create_thmac(struct
>> mptcp_subflow_request_sock *subflow_
>>  	subflow_req->thmac = get_unaligned_be64(hmac);
>>  }
>>  
>> -static struct mptcp_sock *subflow_token_join_request(struct
>> request_sock *req)
>> +static struct mptcp_sock *subflow_token_join_request(struct
>> request_sock *req,
>> +						     u8 *reason)
> 
> We modified subflow_token_join_request() in this patch, but then
> removed it in the next one, which seemed a little odd to me. I suggest

I did that because it is not clear to me if this patch *might* need to
be backported to fix some issues. I don't think we should, but just in
case, I left the refactoring (patch 3/5) after this one.

> not removing this function - just changing its prototype would be
> enough. For example:
> 
> static int subflow_token_join_request(struct request_sock *req,
>                                       struct sk_buff *skb)
> 
>>  {
>>  	struct mptcp_subflow_request_sock *subflow_req =
>> mptcp_subflow_rsk(req);
>>  	struct mptcp_sock *msk;
>> @@ -126,12 +127,25 @@ static struct mptcp_sock
>> *subflow_token_join_request(struct request_sock *req)
>>  	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)),
>> subflow_req->token);
> 
> We can set mptcp_token_get_sock() to "subflow_req->msk" instead of
> "msk":
> 
> subflow_req->msk = mptcp_token_get_sock(sock_net(req_to_sk(req)),
> 	                                subflow_req->token);
> 
>>  	if (!msk) {
> 
> Then we can use subflow_req->msk to replace msk:
> 
> 	if (!subflow_req->msk) {
> 
>>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
>> +		*reason = MPTCP_RST_EMPTCP;
> 
> Set the skb reset_reason directly:
> 
> 		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
> 
> This requires declaring subflow_add_reset_reason at the beginning of
> the file.
> 
>> +		return NULL;
> 
> No longer return "struct mptcp_sock *"; return an error code instead:
> 
> 		return -EPERM;
>> +	}
>> +
>> +	/* Stop it early if the subflow cannot be accepted.
>> +	 * This check is inherently racy, the consistency safeguard
>> is given by
>> +	 * the fallback check at finish_join time.
>> +	 */
>> +	if (!mptcp_can_accept_new_subflow(msk)) {
>> +		SUBFLOW_REQ_INC_STATS(req,
>> MPTCP_MIB_MPJOINDISALLOWED);
>> +		*reason = MPTCP_RST_EPROHIBIT;
>> +		sock_put((struct sock *)msk);
> 
> sock_put is no longer needed here, because the msk reference is now
> owned by subflow_req (set immediately) and will be released by the
> destructor.
> 
>>  		return NULL;
>>  	}
>>  
>>  	local_id = mptcp_pm_get_local_id(msk, (struct sock_common
>> *)req);
>>  	if (local_id < 0) {
>>  		SUBFLOW_REQ_INC_STATS(req,
>> MPTCP_MIB_MPJOINNOIDFOUND);
>> +		*reason = MPTCP_RST_EMPTCP;
>>  		sock_put((struct sock *)msk);
>>  		return NULL;
>>  	}
>> @@ -252,17 +266,19 @@ static int subflow_check_req(struct
>> request_sock *req,
>>  			SUBFLOW_REQ_INC_STATS(req,
>> MPTCP_MIB_TOKENFALLBACKINIT);
>>  
>>  	} else if (opt_mp_join && listener->request_mptcp) {
>> +		u8 reason;
>> +
>>  		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
>>  		subflow_req->mp_join = 1;
>>  		subflow_req->backup = mp_opt.backup;
>>  		subflow_req->remote_id = mp_opt.join_id;
>>  		subflow_req->token = mp_opt.token;
>>  		subflow_req->remote_nonce = mp_opt.nonce;
>> -		subflow_req->msk = subflow_token_join_request(req);
>> +		subflow_req->msk = subflow_token_join_request(req,
>> &reason);
>>  
>>  		/* Can't fall back to TCP in this case. */
>>  		if (!subflow_req->msk) {
>> -			subflow_add_reset_reason(skb,
>> MPTCP_RST_EMPTCP);
>> +			subflow_add_reset_reason(skb, reason);
>>  			return -EPERM;
>>  		}
> 
> Then use subflow_token_join_request this way:
> 
> 	if (subflow_token_join_request(req, skb))
> 		return -EPERM;
> 
> This way, in the next patch we only need to extract the two functions
> subflow_check_req_mp_join() and subflow_check_req_mp_capable(), and
> subflow_token_join_request() continues to be used in
> subflow_check_req_mp_join().
> 
> WDYT? Attached is a squash-to patch with my changes.

I think I would prefer keeping the refactoring (patch 3/5) and move it
before this one (2/5), no?

I don't think that's a good idea to assign various fields of subflow_req
in subflow_token_join_request(). That's why I removed this function.

>> @@ -280,15 +296,8 @@ static int subflow_check_req(struct request_sock
>> *req,
>>  
>>  		subflow_req_create_thmac(subflow_req);
>>  
>> -		if (unlikely(req->syncookie)) {
>> -			if
>> (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
>> -				SUBFLOW_REQ_INC_STATS(req,
>> MPTCP_MIB_JOINREJECTED);
>> -				subflow_add_reset_reason(skb,
>> MPTCP_RST_EPROHIBIT);
>> -				return -EPERM;
>> -			}
>> -
>> +		if (unlikely(req->syncookie))
>>  			subflow_init_req_cookie_join_save(subflow_re
>> q, skb);
>> -		}
>>  
>>  		pr_debug("token=%u, remote_nonce=%u msk=%p\n",
>> subflow_req->token,
>>  			 subflow_req->remote_nonce, subflow_req-
>>> msk);
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index c3ccce96b45b..308fad861afc 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> 
> Also, could the selftests part be put into a separate patch?

I don't know: here, we are changing the behaviour, so without it, the
selftests are broken. Because this patch 2/5 is quite big, I can split
it, but then I need to clearly state that the kernel code changes the
behaviour and a modification of the selftests is required. Hopefully we
will not need to backport this patch 2/5, so the split is OK.

> Thanks,
> -Geliang
> 
>> @@ -78,6 +78,7 @@ unset join_ack_no_mpjoin
>>  unset join_ack_no_ctx
>>  unset join_not_established
>>  unset join_no_id_found
>> +unset join_disallowed
>>  
>>  unset rst_md5sig
>>  unset rst_dss
>> @@ -1595,6 +1596,7 @@ chk_join_nr()
>>  	local ack_no_ctx=${join_ack_no_ctx:-0}
>>  	local not_established=${join_not_established:-0}
>>  	local no_id_found=${join_no_id_found:-0}
>> +	local disallowed=${join_disallowed:-0}
>>  	local rc=${KSFT_PASS}
>>  	local count
>>  	local with_cookie
>> @@ -1617,10 +1619,21 @@ chk_join_nr()
>>  	if [ -z "$count" ]; then
>>  		rc=${KSFT_SKIP}
>>  	elif [ "$count" != "$syn_ack_nr" ]; then
>> +		# support old kernels without
>> MPTcpExtMPJoinDisallowed counter:
>> +		# => connections are rejected later on
>> (MPTcpExtMPJoinRejected)
>> +		if [ "${disallowed}" -gt 0 ] &&
>> +		   ! mptcp_lib_get_counter ${ns1}
>> "MPTcpExtMPJoinDisallowed" >/dev/null; then
>> +			syn_rej=$((syn_rej + disallowed))
>> +			syn_ack_nr=$((syn_ack_nr + disallowed))
>> +		fi
>> +
>>  		# simult connections exceeding the limit with cookie
>> enabled could go up to
>>  		# synack validation as the conn limit can be
>> enforced reliably only after
>>  		# the subflow creation
>> -		if [ "$with_cookie" != 2 ] || [ "$count" -le
>> "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
>> +		if [ "$count" != "$syn_ack_nr" ] && {
>> +		     [ "$with_cookie" != 2 ] ||
>> +		     [ "$count" -le "$syn_ack_nr" ] ||
>> +		     [ "$count" -gt "$syn_nr" ]; }; then
>>  			rc=${KSFT_FAIL}
>>  			print_check "synack rx"
>>  			fail_test "got $count JOIN[s] synack rx
>> expected $syn_ack_nr"
>> @@ -1658,9 +1671,18 @@ chk_join_nr()
>>  	if [ -z "$count" ]; then
>>  		: # ignore skip
>>  	elif [ "$count" != "$syn_rej" ]; then
>> -		rc=${KSFT_FAIL}
>> -		print_check "syn rejected"
>> -		fail_test "got $count JOIN[s] syn rejected expected
>> $syn_rej"
>> +		# support old kernels without
>> MPTcpExtMPJoinDisallowed counter:
>> +		# => with syncookies, the MPJoinRejected was
>> incremented instead
>> +		if [ "$with_cookie" = 2 ] && [ "${disallowed}" -gt 0
>> ] &&
>> +		   ! mptcp_lib_get_counter ${ns1}
>> "MPTcpExtMPJoinDisallowed" >/dev/null; then
>> +			syn_rej=$((syn_rej + disallowed))
>> +		fi
>> +
>> +		if [ "$count" != "$syn_rej" ]; then
>> +			rc=${KSFT_FAIL}
>> +			print_check "syn rejected"
>> +			fail_test "got $count JOIN[s] syn rejected
>> expected $syn_rej"
>> +		fi
>>  	fi
>>  
>>  	# Per-event MPTCP_RST_EMPTCP JOIN counters; default 0, gated
>> on
>> @@ -1701,6 +1723,13 @@ chk_join_nr()
>>  		fail_test "got $count JOIN[s] no id found expected
>> $no_id_found"
>>  	fi
>>  
>> +	count=$(mptcp_lib_get_counter ${ns1}
>> "MPTcpExtMPJoinDisallowed")
>> +	if [ -n "$count" ] && [ "$count" != "$disallowed" ]; then
>> +		rc=${KSFT_FAIL}
>> +		print_check "join disallowed"
>> +		fail_test "got $count JOIN[s] disallowed expected
>> $disallowed"
>> +	fi
>> +
>>  	print_results "join Rx" ${rc}
>>  
>>  	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
>> @@ -2180,8 +2209,8 @@ subflows_tests()
>>  		pm_nl_set_limits $ns2 0 1
>>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>>  		run_tests $ns1 $ns2 10.0.1.1
>> -		join_syn_rej=1 \
>> -			chk_join_nr 1 1 0
>> +		join_disallowed=1 \
>> +			chk_join_nr 1 0 0
>>  	fi
>>  
>>  	# subflow
>> @@ -2210,8 +2239,8 @@ subflows_tests()
>>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>>  		run_tests $ns1 $ns2 10.0.1.1
>> -		join_syn_rej=1 \
>> -			chk_join_nr 2 2 1
>> +		join_disallowed=1 \
>> +			chk_join_nr 2 1 1
>>  	fi
>>  
>>  	# single subflow, dev
>> @@ -3546,7 +3575,7 @@ syncookies_tests()
>>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>>  		run_tests $ns1 $ns2 10.0.1.1
>> -		join_syn_rej=1 \
>> +		join_disallowed=1 \
>>  			chk_join_nr 2 1 1
>>  	fi
>>  
>> @@ -4092,8 +4121,8 @@ userspace_tests()
>>  		pm_nl_set_limits $ns2 1 1
>>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>>  		run_tests $ns1 $ns2 10.0.1.1
>> -		join_syn_rej=1 \
>> -			chk_join_nr 1 1 0
>> +		join_disallowed=1 \
>> +			chk_join_nr 1 0 0
>>  	fi
>>  
>>  	# userspace pm type does not send join
>> @@ -4116,8 +4145,8 @@ userspace_tests()
>>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>>  		sflags=backup speed=slow \
>>  			run_tests $ns1 $ns2 10.0.1.1
>> -		join_syn_rej=1 \
>> -			chk_join_nr 1 1 0
>> +		join_disallowed=1 \
>> +			chk_join_nr 1 0 0
>>  		chk_prio_nr 0 0 0 0
>>  	fi
>>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

