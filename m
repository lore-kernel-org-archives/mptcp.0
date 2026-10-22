Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675831;
	b=VV5RY4BtlwVM847Xk66DrZD4sgozpVIH2eVkCP7TBWtUm0eUMhpXVl42V8sAhRpiyFuV
	 4HmQ4NdbV0BxkhfEeRrSPTd2z1Q5WSrbKwLGkpKxBVOdyeIRTmUI+Df9m3n4WOHSpxk67
	 vNTFr6ofuDLfWQ8iDeN411ly6yhbBdMPyoRW3CsYjXz76WSysbM0rp4yD6zthApFd3qao
	 H2vRUadpSo7ziUKyDU//v3HQP0OoLNPy4a5fGNFwunx2MbqrcVRTSkOG5uoQIMtoaX1f8
	 hEc6+hC75mkklhS82aciutQEABJ+NLwEl3byi0bMA+oS0ctsZxBnzLJGHYJjl4lf7KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675831;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:Cc:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7nZ+PTvIIYY32MbOGiiGjY3A9u7uFw/+tvgMhQC7g20=;
	b=4SXZMbcR5c92mKIth/wWR40/HfvH7N4QF741kw3k2H/EPsJ1sVQ4+PClapK9wwWk7Ewn
	 jMyJ/2WX7z9Fx3qi2NMIbqDfAM8MntkeGurOId188kGQ8uy+MRn3ThJ+6gc5OhP111s2+
	 M3hAHrW+RFmRQXuFYVl+k3mHUPMyvstwF2XxHuwN0z6lbh1yJ976RpbR3aaNhB8ShekTY
	 1mUKqbeDi70Q26nejzBTwZ4TqJJxTxYBCiDLx5JSZfAFqLPyYGK3kuIJK75uFw+9NDiIG
	 u5jtFrHnN1wTsSjWkPWnyvjeFbKJ8C7y0aMxVum6fYWJPPF6GfYrhdCU53YmCT8QQfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmWkw7W7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA13606A323
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmWkw7W7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB411F000C2;
	Thu, 22 Oct 2026 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792675831;
	bh=7nZ+PTvIIYY32MbOGiiGjY3A9u7uFw/+tvgMhQC7g20=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=cmWkw7W7u+fHGMnFzJ7sb6AruZMIJ/Z87BtvRHe8zuw5zhc0+WgpdtCTwMHblmmir
	 qfuV90gJ+Xj6DirQk7zXXzCOeoRvUjvk5nu0TSVDcAHSFOPMZd7fIvgR9N1FfnZCNW
	 3ICcDHfTINUK8njR+Vod1X86uknfIUFljOyZNG2awS8pseMU6TsCHm2a6dS2zYrizF
	 6FlJdABssJi4RmzkWlg7QFwBF7YgjzZNRj86aHnuKXWJlpp21mciEy9I9KlZvWQVqF
	 yj/dn9KGBPyUPok9SOv3t7RDnspZCsx5I/Yqn3qR4RQRWbYjtkHoqTyfeGHFVdeJyJ
	 lFf6KuGSeXOtA==
Message-ID: <b6eed470-af86-4554-b89e-2edc702521e9@kernel.org>
Date: Thu, 22 Oct 2026 15:30:28 +0200
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
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
Content-Language: fr
To: Anil Kaushik <anilkaushikwireless@gmail.com>
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com>
 <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
 <CAG0Mgm_uj70o=R5HnEb0GkTy4FTQK6cy6GHWuO7y2FitzwnucA@mail.gmail.com>
 <7c7308c5-c150-41a1-9d84-9981acfb5962@kernel.org>
 <ffc98c40-09d5-4299-8128-72cc0ed6beae@kernel.org>
 <CAG0Mgm9ShHdApcKAUj_PgGdm_A+w--FKpSpJq=nTJ=DkRcuACA@mail.gmail.com>
 <4180b794-8877-4516-9400-afb0894e8f49@kernel.org>
 <CAG0Mgm85JF6bFs2Nwije+2cbFjC-DmUNLeanwSCqOXxU=c1piA@mail.gmail.com>
 <07243418-dc96-43c6-beb6-ff220234bdeb@kernel.org>
 <CAG0Mgm_iQmH2uuP8x8dd7M9qDZm7G_ySp=XzqxsHhuXaFC23Cg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: mptcp@lists.linux.dev
In-Reply-To: <CAG0Mgm_iQmH2uuP8x8dd7M9qDZm7G_ySp=XzqxsHhuXaFC23Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/10/2026 13:04, Anil Kaushik wrote:
> On Thu, Oct 22, 2026 at 3:58 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>> On 22/10/2026 11:24, Anil Kaushik wrote:
>>> On Thu, Oct 22, 2026 at 1:02 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>> On 21/10/2026 20:20, Anil Kaushik wrote:
>>>>> On Wed, Oct 21, 2026 at 11:18 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>>> On 16/10/2026 10:43, Matthieu Baerts wrote:
>>>>>>> On 16/10/2026 07:49, Anil Kaushik wrote:

(...)

>>>>>>>>> modify icsk_syn_retries instead [...] WDYT?
>>>>>>>>
>>>>>>>> Good idea, I will do that: one new subflow per failure, with its SYN
>>>>>>>> retries set from the new netlink limit, 0 = disabled. It also removes
>>>>>>>> the socket reuse, the retries counter and the 60s check.
>>>>>>>>
>>>>>>>> One point to think though, If ICMP unreachable stops the SYN at once.
>>>>>>>> I would not retry
>>>>>>>> again then. Is that OK?
>>>>>>>
>>>>>>> Good point. In your specific case, what do you observe?
>>>>>
>>>>> In my tests, the fiber outage is a silent drop: the SYNs just time
>>>>> out, and the subflow comes back once the path is up again.
>>>>
>>>> Interesting. Out of curiosity, how long are these outages typically?
>>>> Less than ~20 minutes I suppose?
>>>>
>>> It varies. Short ones are a few minutes, but when the fiber is cut, the
>>> repair can take several hours. So a longer default would help.
>>
>> When the "fiber is cut", do you still have an IP address or is the
>> connection still up?
>>
>> To me, if there is an issue in the network, we generally have two cases:
>> either we are closed to an end (client / server) and the host should be
>> disconnected from that network, or it is happening in the "middle" of
>> the network where BGP will reroute the traffic.
>> In case of disconnection, I would guess the IP is lost and the
>> corresponding MPTCP endpoint is removed. The userspace will try to
>> reconnect, then re-add the MPTCP endpoint, and the PM can restart the
>> subflows.
>>
>> But that doesn't seem to be the case on your side :)
>> Do you know why?
>>
> Yes. MPTCP runs on a gateway in front of the fiber and Starlink
> routers, connected to each of them over Ethernet. The fiber cut is
> between the fiber router and the ISP, so the gateway keeps its link and
> its IP address on that side, nothing removes the MPTCP endpoint, and
> the packets on that path are just dropped. There will be mix of
> deployments like this.
> 
> Any thoughts?

So when you have an issue between the fiber router and the ISP, the
fiber router keeps its connection up to the ISP, and no ICMP network
unreachable are sent?

In such setup, and if the fiber router gets a notification somehow in
case of issue, I would find it better to forward this notification to
the gateway to disable the MPTCP endpoint. An alternative is to have a
simple service monitoring the links, and removing/re-adding endpoints: a
simple "echo" service in TCP (or ICMP echo) with a server somewhere, one
per link. With that, you have more control and can eventually ack quicker.

Yet, the series you are suggesting here still makes sense because that
would help people, or in case of issues not detected by the network manager.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

