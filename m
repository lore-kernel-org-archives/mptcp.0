Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54934F275
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309671; cv=none; b=VlD9frCUxXdOkVowdRjmxSZapcTInN+TvK33iyetv9LVdBEv8UL+eofPOlDkV9r/gV+0fCNnCAuK1nH5cCy7h+IdmdpxxICwhRH6XbeVWtxghE0B8wBkjzngIOY4kDagr3dWBAcaeJcgd0CgX83n4lNk9ssf6f2i6oxmB0KmJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309671; c=relaxed/simple;
	bh=DFOnTgjRG4hnwzX7JwVkka8lNyJkSZG2+a9U1M6mcHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUCXyjFZwCKcC7pyMD279kVJE2kpdeQShUqsgWrlbQvoot4AKEVR6bisc7J9oJV0LFOy1RygnYvn8/1K3VIrK5LMJOOcTyjdHc/E04p7b/dzK5CEUpzOHOioIr71f8E6Ce6GQo0aOtGQ8cQ1JGQrbWKeI46bXDF5FQDTaOcKgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NalTDRfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NalTDRfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A4EC2BCB4;
	Mon, 27 Apr 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777309671;
	bh=DFOnTgjRG4hnwzX7JwVkka8lNyJkSZG2+a9U1M6mcHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NalTDRfiZ/DCEzxrVw4oZxVTZ+WkFlV7szFOrrHU7/3NBMiAJSCJ645uMQY1BzADI
	 X5BzHQfmCndcJbNrSHQ+h5XNXErUqoD2fwNCLEqQ0gSQ1tauGXr0NFribHqVcd5gY0
	 +8nnMGzauo3P0msEU+1SOHBiu4sDL8+BS924flBC6yI61gn5S+Q2mYrLVd7qth7nBu
	 AIt9ft4MRTFlJVYcYni7NQoKkvZGAaWuZtg55092hlPteGa/9LgZU08rUNuKoYBGy2
	 KLGV1HbDmYOtIM4Msnz1ojtvAthNuNeHdI6XozKh0UauJP5GU7l5NjxqPL1+hK/cv2
	 wGGveRRC9DICQ==
Message-ID: <b9d69160-1a93-4788-a3b4-47b366645fde@kernel.org>
Date: Mon, 27 Apr 2026 19:07:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: propagate RECVERR sockopts to
 subflows
Content-Language: fr
To: David CARLIER <devnexen@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
References: <20260421223338.52743-1-devnexen@gmail.com>
 <20260421223338.52743-2-devnexen@gmail.com>
 <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
 <CA+XhMqw5z0NbsXH0MRL=T7ZmRv_OT9Reke6Uo6Yq6kFQJL=2yA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+XhMqw5z0NbsXH0MRL=T7ZmRv_OT9Reke6Uo6Yq6kFQJL=2yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 22/04/2026 23:51, David CARLIER wrote:
> On 4/22/26 10:05 AM, Paolo Abeni wrote:
>   > You should drop this line, only a single SoB tag is needed.
> 
>   Ack.

(I don't know why there is an indentation in your replies, but I guess
most email readers will not interpret this properly, even lore [1]:
check your messages vs. the other ones)

https://lore.kernel.org/mptcp/CA+XhMqw4xRGdJbtX02++9eS8u_bWOzbPimM1Mk_dDNed5SX94w@mail.gmail.com/T/#mf03244a0e5af6ca0fdd80dfb1bff9f2f2d769e0b

https://docs.kernel.org/process/email-clients.html

>   >> +          ret = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
>   >
>   > The above looks a bit overcomplicated?!? It looks like you could
>   > leverage mptcp_setsockopt_all_sf() [...]
> 
>   Will do, rebased on Matt's sockopt_seq_inc() fix.

FYI, I sent my patch there:

https://lore.kernel.org/mptcp/20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org/

I don't think you need to rebase your series on it, except if not having
this patch breaks some tests. If that's the case, feel free to add this
line in the cover-letter:

Based-on:
<20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>

See this for more details:

  https://github.com/multipath-tcp/mptcp_net-next/wiki/CI

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

