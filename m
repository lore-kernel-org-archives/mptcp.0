Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FB2033A
	for <mptcp@lists.linux.dev>; Sat, 30 Aug 2025 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515518; cv=none; b=CTon4T5FYPlTWVyYRBp3ZeO8Moc32zXkxRlCODcq4wySNhLPRISKylpxpPMaS5Isegfx5yOqudjQfrcq6m3FI6qYqf/NuWEww/T9sykTreucXt5dO3OttUfjw5z/X9P1IC6qM6HyvRHlsviVGmpFsrjIMkIH+U2F5HpbzDOcQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515518; c=relaxed/simple;
	bh=7hY5EwM7fp1/WNjhsR0W9UF0vc09is6prLxgCXkYgTU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u3MtTX1VJvTfz6MNKx3qIhdSQOOVaN6Tp9p5VwUDBao0HqOj7T5JOrMDL45/WWpxHMfyn29k2LXUKAiskG4/lsetSB5bL/x4Twr2lQgkXVlpFUMt/0MVa/37ZmrxE9aAWIBOtyjnzrpaikcTFQxTJ8JSg8ImWUiblTnxJtR9o+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQDAe3PQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQDAe3PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62A0C4CEF0;
	Sat, 30 Aug 2025 00:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756515518;
	bh=7hY5EwM7fp1/WNjhsR0W9UF0vc09is6prLxgCXkYgTU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RQDAe3PQg/f5WpuPGElhmj91v8qyDdMioGl1qkKydoJUlzGOE4QPcM0VeLGf2WmK9
	 8UsBqfyva44E1TbPpTk0vbXKpgGLxuD4/JovU0Q5K/LbdlwmTmhJov0yUnyESxrG/w
	 bP7P+jFNNcjsOApdnpIZzA2AJrE6R92UuXFqvc0pXx0GcsgqZC40fpNlpVyg1vxqQ7
	 KD1VtCzIFCOcyypXhTPUOq3uUGw9hSMmv2Qy0u0yPQ3e1GCJ059jd/U+WjK6i8138p
	 oW+smBQ9azbFN1r7vWJyt+qHb2WKk/UNfX4kwcZKDggjlwt+smKAFjMima5pm/41nK
	 9HrJDNmbTa46w==
Date: Fri, 29 Aug 2025 17:58:37 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Christoph Paasch <cpaasch@openai.com>
cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 2/7] mptcp: pm: userspace: respect deny_join_id0
 attr
In-Reply-To: <CADg4-L_yzQo7Xs3aVL=sBY2M6OwZ=XDHCTdaS3KyiZa0hOct0g@mail.gmail.com>
Message-ID: <9de05bc0-fcf6-364f-b143-fb72cb8c4cae@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org> <20250829-mptcp-pm-user-c-flag-v1-2-78b25dda7708@kernel.org> <CADg4-L_yzQo7Xs3aVL=sBY2M6OwZ=XDHCTdaS3KyiZa0hOct0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-143989299-1756515517=:73212"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-143989299-1756515517=:73212
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 29 Aug 2025, Christoph Paasch wrote:

> On Fri, Aug 29, 2025 at 1:33 PM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> During the connection establishment, a peer can tell the other that it
>> cannot establish new subflows to the initial IP address and port by
>> setting the 'C' flag [1]. The RFC8684 is strict about that:
>>
>>   (...) therefore the receiver MUST NOT try to open any additional
>>   subflows toward this address and port.
>>
>> It is then important not to let the userspace PM establishing such
>> subflows, and return an error (ECONNREFUSED) if it tries to do so.
>>
>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
>> Link: https://datatracker.ietf.org/doc/html/rfc8684\#section-3.1-20.6 [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/pm_userspace.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index 1911fe1799fa38a53381247a830a9a0daf1c4492..9968dc9a8b45112114953f66848ea22c971136d6 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -391,6 +391,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>>         if (err < 0)
>>                 goto create_err;
>>
>> +       if (READ_ONCE(msk->pm.remote_deny_join_id0) && addr_r.id == 0) {
>
> If userspace wants to, it could still work around that by still using
> the initial subflow's IP-address and just use a non-zero address-ID.
>
> Is that really a concern ? Sure, the IETF-draft says "MUST NOT", and
> so, shouldn't we leave it up to the userspace PM to make that decision
> ?
>

I concur with Christoph on this one, I think the PM (userspace or kernel) 
is responsible for this aspect of the protocol so it doesn't need to be 
double-checked here.

- Mat

>
>> +               GENL_SET_ERR_MSG(info, "deny join id0");
>> +               err = -ECONNREFUSED;
>> +               goto create_err;
>> +       }
>> +
>>         if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
>>                 GENL_SET_ERR_MSG(info, "families mismatch");
>>                 err = -EINVAL;
>>
>> --
>> 2.50.1
>>
>>
>
>
--0-143989299-1756515517=:73212--
