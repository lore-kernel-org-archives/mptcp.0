Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693073;
	b=fIcKkOHcjiB43pR9NPFp2Cl1UQsmpY/NpksT2SUBktjYJmprUR0vDlHaloHkgKyTI8CD
	 LAdcOoirfUpoS8lNM6uXJyDMpc4jzYouq3S1LuBNXIn6Ano4i4tJp3whSTt9GGuvyKwDn
	 K8GH8bmzTIShLpxnZRelGtPHE0wUUKsEabZTywI1dsV0gTVO9wABkJGBkv4lH6rVjzzwx
	 GkAUTTQi2GdApOw75/QZwyFQ6q3iQDonqvMK5nCT6GywaKtguHPr2frJdvl+4S9hVSm9S
	 7iJyx/4v11TAqBlOAWoESuDGRJj6vXuvAwK7Aeys3/DoDnT/p7r48P9kEiYums03N8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693073;
	h=Received:DKIM-Signature:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID;
	bh=ESE5C0i8J9UtpPkDUVoRquvfOcWKncLg5Vsd6vV7s8w=;
	b=joVjeOBb8mybwgHIAHbn8jGYPS/yobVu3nYyRymkKNke0AUFEEq8vSUTzNrE20HhCLif
	 7mtUqh72EvUWXD6NM/9BFgewbb4nkbZA2b3AfBvjbc0/R6bgrU9+2Ar/W5aCFcwM0etMB
	 eqMf9mmVdsUrvJeS9aQJnKPzd5Ifg9ZSCSGEeAchYnDcVCV7f3W2hGEWxx44qPcEZ7W6I
	 qIoW2un0QDmS2JsJ0GMI6hi+gwkBMDCDJjKEcasVGTPUvJn1i+iQUpnX5bykrum5E77dM
	 53l/8LQjOTxPJjY2RiBkf+7O7xWrzrFi90br45fDzsI14Aq5oPl1IRGQDcDnPTBhxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ADIiPBj/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57480606A33C;
	Tue,  3 Nov 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADIiPBj/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2187D1F00919;
	Tue,  3 Nov 2026 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693073;
	bh=ESE5C0i8J9UtpPkDUVoRquvfOcWKncLg5Vsd6vV7s8w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ADIiPBj/BpFNGQIO4kEgM79Ej94EnBV1zCmPowIQo9cl97zrL0OLkzbgMS9/4jHtF
	 Xb9JVQE22EwMnOCJoraZkZ31Dvp+WW6GPzIYSdyUSOfcsU2SfA4ba5unyDWfwT0nVJ
	 OJoiv4rOVXjT/JRBtHxSgE/6InQkJ8+1m3YWqfAHEcJjLeL4oAxQb84Bx/cSQ/MA9/
	 mWkQ0qRZ72vGCc0p+D/vSz3JmScgdonTB/O2dMp0NYihVI4mhthidRKIs7R5JRbmAQ
	 y1DV/hq4/bNzEVBOrarbDT7T2uP7BY1+g88NqmQCFpcsdqABwl3VoPjEUemsyG5kqf
	 3hyLI3WUEQULg==
Date: Tue, 3 Nov 2026 09:04:25 +0100
From: Matthieu Baerts <matttbe@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
	mptcp@lists.linux.dev, netdev@vger.kernel.org
Message-ID: <abc8a000-caa8-4dd4-9d18-925d1ceda683@kernel.org>
In-Reply-To: <aumNbD0vtdtLgWN9@v4bel>
References: <aoWBrkNwebJe-koh@v4bel> <bf25121c-72cf-40a7-bbaf-5db85aee7f59@kernel.org> <aobtmznTdBks0frM@v4bel> <994ecd4f-eaf9-4d2f-95a3-611083207d6c@kernel.org> <aumNbD0vtdtLgWN9@v4bel>
Subject: Re: [PATCH net] mptcp: fix use-after-free of the subflow context on
 the delegated list
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <abc8a000-caa8-4dd4-9d18-925d1ceda683@kernel.org>

Hi Hyunwoo,

Thank you for your reply.

03 Nov 2026 08:29:55 Hyunwoo Kim <imv4bel@gmail.com>:

> On Tue, Sep 08, 2026 at 07:46:19PM +0200, Matthieu Baerts wrote:
>> Hi Hyunwoo,
>>
>> On 20/08/2026 14:05, Hyunwoo Kim wrote:
>>> On Wed, Aug 19, 2026 at 12:22:18PM +0200, Matthieu Baerts wrote:
>>>> Hi Hyunwoo,
>>>>
>>>> On 19/08/2026 12:13, Hyunwoo Kim wrote:
>>>>> mptcp_subflow_delegate() links the subflow context into a per-CPU nap=
i
>>>>> list and takes a reference on the subflow socket. The context is a
>>>>> separate allocation, reached through icsk_ulp_data, and the list hold=
s
>>>>> no reference to it.
>>>>>
>>>>> inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
>>>>> outstanding references. That path ends in tcp_cleanup_ulp(), which ca=
lls
>>>>> subflow_ulp_release(). subflow_ulp_release() frees the context with
>>>>> kfree_rcu() but does not remove it from the list. Once the grace peri=
od
>>>>> elapses and the context is actually freed, the next mptcp_napi_poll()
>>>>> dequeues that entry and mptcp_subflow_delegated_next() writes to the
>>>>> freed context with list_del_init(). That is the use-after-free.
>>>>>
>>>>> The freeing path cannot dequeue the entry itself: the list is per-CPU
>>>>> and only the CPU that queued the subflow may touch it, as
>>>>> tcp_release_cb_override() already notes.
>>>>>
>>>>> Delay the free instead. Add MPTCP_DELEGATE_DEAD.
>>>>> mptcp_subflow_free_ctx() sets it and frees the context only if the
>>>>> subflow is not scheduled, while mptcp_napi_poll() frees it if the dea=
d
>>>>> bit is set when it clears the scheduled bit. Either
>>>>> mptcp_subflow_free_ctx() gets there first, sees the scheduled bit and
>>>>> leaves the free to mptcp_napi_poll(), or mptcp_napi_poll() gets there
>>>>> first, does not see the dead bit and mptcp_subflow_free_ctx() does th=
e
>>>>> free.
>>>>>
>>>>> Also skip mptcp_subflow_process_delegated() once the dead bit is set.
>>>>> subflow_ulp_release() has already dropped the msk reference by then, =
so
>>>>> the pending actions must not run.
>>>>>
>>>>> Finally, move delegated_status out of struct_group(reset).
>>>>> mptcp_subflow_ctx_reset() clears that group on disconnect, and cleari=
ng
>>>>> the scheduled bit while the entry is still queued would let
>>>>> mptcp_subflow_free_ctx() free a context the napi list still points to=
.
>>>>> delegated_node is already outside the group.
>>>> Thank you for looking at this. Do you have more context about how the
>>>> bug was discovered? Do you have a reproducer and/or a KASAN calltrace =
or
>>>> similar?
>>>>
>>>> Having this would help the reviewers.
>>>
>>> Sorry for the late reply. The poc was extremely unstable, so I wanted
>>> to improve its reproduction rate a bit before sending it.
>>
>> No delay at all when compared to my reply, sorry!
>>> Attached are the poc, the KASAN log, and the mdelay diff used for
>>> reproduction.
>>
>> By chance, do you have a decoded stack trace? e.g. using the following
>> script with the vmlinux and modules used to generate the KASAN trace:
>>
>> =C2=A0 ./scripts/decode_stacktrace.sh
>>
>> Note that we are still looking at a possible simpler fix, but no luck so
>> far. In any cases, we will take this patch in our tree first, then send
>> it to netdev.
>
> Ah.. I had missed this mail.
>
> It seems this issue has not been resolved in netdev yet. May I ask how
> you plan to handle it?

We didn't find a less "intrusive" way to fix that, and it went down the TOD=
O list, sorry.
Do you mind rebasing it, and send a new version including the
decoded trace (without the timestamps), please?

Cheers,
Matt
