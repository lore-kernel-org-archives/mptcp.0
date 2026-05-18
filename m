Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D64382368
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124681; cv=none; b=SKTw9pvc5yk6Brvr/ptQx5go26xN6Pi3d5USeT+l7QbHD0RQ10zmT2lCrl2uW5fHJ5OX5PHFs/TQn95EooFzwnSokpvByVBd3iD4lTzPGHh8VDRsilQEFOuaEY/62vUDt+xqI32rdTmuGDjOpol4aH52jczRqKdz9E8unYBmf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124681; c=relaxed/simple;
	bh=zrHB6LKJpCBit2fHQLaBK4DJVcovR65v8TJqwl1VbMc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=T0U3KuXPZMhOEifqR+g2wi4ycpZcmzj8L93qYIfQEYXDZ6tlKslUhcxkRw7pbgVXGW+LWAwF63Nevb1XjWoxY0ZSjazJYFSv/uwazL9rELHhodQrOMoop8yO0bgtBo72d1oioyWqBZNepTg5BSTp55UkQxkpDmQC5mX28MHbXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJTLataG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJTLataG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE2C2BCB7;
	Mon, 18 May 2026 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779124681;
	bh=zrHB6LKJpCBit2fHQLaBK4DJVcovR65v8TJqwl1VbMc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bJTLataGZcyQkG0U3tWKd+e0BCANEtu4mPEUpkbSMuNjK4u32faU28JMeYRco60cJ
	 lyz03BVn1qI9EWVpLywQoq+Fzl7w2w+CC6zuKnZ8wZ2S+jQJ2IbBADxIRYvwrC+OyE
	 xFp4FkeZgJqrbsTA3QTc3iPXTZ6s3KbJUt5GowgzAD76bqzX3Lnet6rJ3ezHpTbKKJ
	 51JlUfQ3gGYo+KSSpTRFKL4IAIvqi3c1gumF0fRnjUl6KG3DnEqWvFzk75Y8ypuyAo
	 7yv32YUTCzWjLBag5jDKpk1B1g3MAPJqpPzxEvdEbz3JbDJXjQb0ieNinP3RdhKoAD
	 D5u/xHp39hKBA==
Date: Tue, 19 May 2026 03:17:53 +1000
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Message-ID: <e8eab089-38a9-4786-9052-b2d0a4d2aab4@kernel.org>
In-Reply-To: <9878b113-59e9-4100-92b8-fed412466097@redhat.com>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org> <20260518-mptcp-add-addr6-port-ts-v1-3-f1ca26977fcd@kernel.org> <9878b113-59e9-4100-92b8-fed412466097@redhat.com>
Subject: Re: [PATCH mptcp-next 03/12] mptcp: pm: drop TCP TS with ADD_ADDRv6
 + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e8eab089-38a9-4786-9052-b2d0a4d2aab4@kernel.org>

Hi Paolo,

Thank you for the review!

19 May 2026 01:19:36 Paolo Abeni <pabeni@redhat.com>:

> On 5/18/26 2:59 PM, Matthieu Baerts (NGI0) wrote:
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 47647a99e324..3dcc6880fd44 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -1182,11 +1182,15 @@ static unsigned int tcp_established_options(stru=
ct sock *sk, struct sk_buff *skb
>> =C2=A0=C2=A0=C2=A0 if (sk_is_mptcp(sk)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int remaining =3D MA=
X_TCP_OPTION_SPACE - size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int opt_size =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool drop_ts =3D opts->options & O=
PTION_TS;
>
> Minor nit: reverse christmas tree order above.

Oops, sorry, I forgot to reorder them after my quick PoC...

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_established_options=
(sk, skb, &optsize, remaining,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &opts->mptcp)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &drop_ts, &opts->mptcp)) {
>
> What about passing `opts` instead of both `drop_ts` and `opts->mptcp` ?

I didn't do that because "struct tcp_out_options" is defined only in
tcp_output.c. Do you think it would be worth it to export it?

> Also possibly move this hooking change in a separate patch to help
> reviewers?
>
>> @@ -825,15 +824,17 @@ static bool mptcp_established_options_mp_fail(stru=
ct sock *sk,
>>
>> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *size, unsigned int remai=
ning,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mptcp_out_options *opts)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool *drop_ts, struct mptcp_out_options *=
opts)
>> {
>> =C2=A0=C2=A0=C2=A0 struct mptcp_subflow_context *subflow =3D mptcp_subfl=
ow_ctx(sk);
>> =C2=A0=C2=A0=C2=A0 struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>> =C2=A0=C2=A0=C2=A0 unsigned int opt_size =3D 0;
>> =C2=A0=C2=A0=C2=A0 bool snd_data_fin;
>> =C2=A0=C2=A0=C2=A0 bool ret =3D false;
>> +=C2=A0=C2=A0 bool has_ts =3D *drop_ts;
>
> Minor nit: reverse christmas tree order above.

ACK

>> @@ -948,6 +949,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, const struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!*drop_other_suboptions)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
out_unlock;
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*drop_ts && mptcp_add_addr_v6_=
port_drop_ts(net)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* OK with=
out TCP Timestamp? */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *len -=3D =
TCPOLEN_TSTAMP_ALIGNED;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (remain=
ing >=3D *len)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto drop_ts;
>
> A label with the same name of a local variable is IMHO a little
> confusing,

Good point!

> possibly pass here `opt`=C2=A0 (tcp options ptr) instead of `drop_ts`

If we can (see above)

> Side note: possibly even the sysctl changes deserve their own patch.

Only its declaration in ctrl.c? (+Doc & export)
No objection from me, I can do that if you prefer.

Cheers,
Matt
