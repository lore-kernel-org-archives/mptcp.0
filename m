Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA773B05A7;
	Thu, 30 Jul 2026 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434624; cv=none; b=V3KwBfnvBIRlLOax0FUMn3SmYryVAEj6BQZ/PCKIQKqX3rCdnXtNgMo3ra0re4pdm9jc/ne85fbLleTtU/cHrFV64HndQRgyGvYm+Xn56T1mPqq7Ri4dOy5xi0O83F23vonTdUkGsOTTVqyYzQAXHqdVVxEtz0NtyUPaaX2pU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434624; c=relaxed/simple;
	bh=BNmwDpLhI7j42YzupuEGlX4vmb9ZkM0O366FxBgJh+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atmIDA8qCzK+eAjRD/zNaimx9ckNqGRCscaC0acEnas5CWXLtDwn3VqfA/sNI/Xz6q2YJy4G+xQ2AVbOvUnsH24E9qlbW1OIYxeZS3MEzzxGg9KmRPlAXyPNnTWzS8aOB5xTHqfbhD6mSkU6o6bUN5S3lUXKHAwy0ZVdnCmudm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2xdBBYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2xdBBYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5117F1F000E9;
	Thu, 30 Jul 2026 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785434623;
	bh=xcnMnS1SAFYRObzVF/sQ+C45aUfsURxcmGZxWYdiRWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q2xdBBYjvm+8sN+nDc25ltM1j1bRRgd/CGz84AarLcqQIBbpN+PApOrFIWztjPsLt
	 JEx3GSyOwq3NJsrPgnvnu3gle9sBZp3vk8GGrGREScfMePz21/ba08m5gZFhXV5npP
	 +1wSDJRt2+qD2FeYr6PeC7qZasQICxdDIHqGpkVYcV0s/LSKP4fFF76+Gp9WnLfEKW
	 0KTmesBpqR22kMOsGTrkJxRl9NZ9OMHludTt2nZObYhqc1lUDFe5AzvskyripYKlF2
	 7UVq6T6a4nHV5rHEW3OqS2z5r5KbuSdbEbbUPllgvDOpIzs+Y7agTNpuQQuh89jAyM
	 vwzmgwzSt9Jzg==
Message-ID: <d13300c5-596d-45a4-8686-9eba63125e3e@kernel.org>
Date: Thu, 30 Jul 2026 20:03:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 1/1] mptcp: fix request ownership when cloning
 reqsk
Content-Language: fr
To: Ren Wei <n05ec@lzu.edu.cn>, caoruide123@gmail.com
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, enjou1224z@gmail.com, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com>
 <be1b6f66-207a-4ed6-8188-72ec11f222a4@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <be1b6f66-207a-4ed6-8188-72ec11f222a4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ren, Ruide,

On 13/05/2026 11:37, Paolo Abeni wrote:
> On 5/10/26 4:14 PM, Ren Wei wrote:
>> From: Ruide Cao <caoruide123@gmail.com>
>>
>> TCP request migration clones pending request sockets with
>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
>> subflow_req->msk, but the cloned request does not take a new reference.
>>
>> Both the original and the cloned request can later drop the same msk in
>> subflow_req_destructor(), and a migrated request may keep a dangling msk
>> pointer after the original owner has already been released.
>>
>> MP_CAPABLE requests have a similar ownership issue for token_node. The
>> original request is hashed in the token table, and inet_reqsk_clone()
>> raw-copies the hlist pointers into the clone. The clone must not inherit
>> that hashed state on migration failure, and the token ownership must move
>> only after the new req has actually replaced the old one in the ehash.
>>
>> Fix both cases while keeping the change local to MPTCP and the TCP
>> migration path: grab a reference for cloned subflow requests that carry an
>> msk, clear any raw-copied token hash state from the clone, and move the
>> hashed token request ownership only after migration succeeds.

(...)

>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index e961936b6be7..578471bb8a2b 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c

(...)

>> @@ -1115,6 +1121,8 @@ static void reqsk_timer_handler(struct timer_list *t)
>>  			goto no_ownership;
>>  		}
>>  
>> +		if (rsk_is_mptcp(oreq))
>> +			mptcp_subflow_reqsk_migrated(oreq, nreq);
> 
> Sashiko says:
> 
> ---
> Can this sequence trigger a race condition with network RX processing?
> In reqsk_timer_handler(), nreq is inserted into the global ehash table
> via inet_ehash_insert() right before this block. The ehash lock is
> immediately dropped, making nreq globally visible to concurrent network
> RX softirq processing.
> However, the MPTCP token state is not migrated to nreq until the call to
> mptcp_subflow_reqsk_migrated(oreq, nreq).
> If a concurrent RX thread processes an incoming ACK for the connection
> in this narrow window, it could find nreq in the ehash table,
> successfully process it, and invoke mptcp_token_accept(nreq).
> Inside mptcp_token_accept(), __token_lookup_req() searches the token
> bucket and finds oreq, because the timer thread hasn't moved the token yet.
> The code then asserts ownership:
> mptcp_token_accept()
> 	pos = __token_lookup_req(bucket, req->token);
> 	if (!WARN_ON_ONCE(pos != req))
> 		hlist_nulls_del_init_rcu(&req->token_node);
> Since pos is oreq and req is nreq, would this fail the assertion and
> trigger a kernel warning?
> If the calls were reordered so that mptcp_subflow_reqsk_migrated()
> happens before inet_ehash_insert(), could that merely shift the race? If
> a concurrent ACK is already processing oreq, it might call
> mptcp_token_accept(oreq) after the token was moved to nreq, triggering
> the same warning, since the ehash table and the token bucket are
> protected by different locks and the updates are non-atomic.
> Could a remote attacker time ACKs to hit this window during a listener
> migration, potentially leading to a denial of service on systems
> configured to panic on warnings?
> ---
> 
> I _think_ the above race could/should be solved squashing
> mptcp_subflow_reqsk_migrated() into mptcp_subflow_reqsk_clone() and
> adjusting  mptcp_token_destroy_request() and mptcp_token_accept() to
> deal with already removed token, checking (again) for unhased token_node
> under the bucket lock.
> 
> The latter will require a little more work, returning a success status
> to the caller - mptcp_sk_clone_init() - and make the latter fail on
> mptcp_token_accept() failures.
> 
> The above would also make the fix more encapsulated into the mptcp code.

I was checking old patches tracked on our MPTCP Patchwork, and noticed
this one is marked as "Changes Requested". I don't think a v3 has been
posted: are you still working on a v3 addressing Paolo's comments? Or
did I miss the v3 because it had a different name?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

