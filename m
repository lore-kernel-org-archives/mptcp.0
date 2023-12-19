Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96318628
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4frGbSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE23C433C8;
	Tue, 19 Dec 2023 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702989501;
	bh=kH+0GVVuvb/Kbsy6vz2Yn1VYDFGZgd9ihb/vgjhAxp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N4frGbSrxSeaiEHe0Si6sL3w8RA+iSnSntuqAFTFm3FEXAuqDfUrvydbrjTDJmfDA
	 XwHOE1YKH0f8dLvYZFRb8uVtTk1SPVlM52uIK0R8TLJFCf4Ggu5Io5UFu59Go/FL9R
	 m3wJrfO6kXRimTwy+z1KvbTMsPz7oLAB+Q82nQ2KOTWVCStOpVI2u7fxwatAgdTsIN
	 C8eVKpcJBr96tmOB5pYHPZNP1zHa77Xnrg9VM4Qb4naIzxwn4pOv98RRhr2RlgVG9s
	 joIFGtrHCXM8PziWE+S69hVNIq+2ypkQxJA3oZE8fWr3eC1WfaFZFiRIlAQKyAtA14
	 1pihln6Spi6mw==
Message-ID: <8d75b638-9d21-4ca9-af28-5f2c7caa0632@kernel.org>
Date: Tue, 19 Dec 2023 13:38:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/5] mptcp: move inet_sk_state_store under lock
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
References: <cover.1702889134.git.geliang.tang@linux.dev>
 <84b7f01dcee92c4c1ae00523baa5f98f0cb64671.1702889134.git.geliang.tang@linux.dev>
 <4c1e2e407e2b6721b4ca0aad73746c8ea13f2753.camel@redhat.com>
 <2a3ded63-0abe-4f9e-a4d2-8d9342b25467@kernel.org>
 <ce5132c6a8e90c44835e0ed05ffe4e093dcd703a.camel@redhat.com>
 <d2663469f30b05f4b38d250dd50678148cb55f44.camel@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d2663469f30b05f4b38d250dd50678148cb55f44.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo

On 19/12/2023 09:05, Paolo Abeni wrote:
> On Tue, 2023-12-19 at 08:57 +0100, Paolo Abeni wrote:
>> On Mon, 2023-12-18 at 18:29 +0100, Matthieu Baerts wrote:
>>> That's what I had in mind, but I was not sure if there would be an issue
>>> in case of error (and I didn't check), etc.
>>>
>>> But if there is no issue, best to move it there indeed!
>>
>> If __mptcp_nmpc_sk() errors out - or any other check in
>> mptcp_pm_nl_create_listen_socket() - the newsk will be released just
>> after by __mptcp_pm_release_addr_entry() so there should be any issues.
> 
> ... except that such release will call mptcp_close() on the mptcp
> socket. If the error happens in inet_bind_sk() or inet6_bind_sk(), the
> msk state will be TCP_LISTEN, the first subflow will be already created
> - by __mptcp_nmpc_sk() - and the latter socket status will be
> TCP_CLOSE, causing a warn in mptcp_close() ->
> mptcp_check_listen_stop().
> 
> I *think* it's would be better special-case this status change here
> using keep using inet_sk_state_store()

Thank you for having checked, it was feeling suspicious :)

I agree, we should then keep inet_sk_state_store() for the moment. Then,
I suggest updating the comment, from:

  avoid replacing inet_sk_state_store with mptcp_set_state here, as the
  old status is known to be TCP_CLOSE, hence will not affect the count.

to:

  We don't use mptcp_set_state() here because it needs to be called
  under the msk socket lock. For the moment, that will not bring
  anything more than only calling inet_sk_state_store(), because the old
  status is known (TCP_CLOSE).

(or something similar)

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
