Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28777367B96
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022404; cv=none; b=SXy8BmHSSHdV2zt5HqrIRz917JTLUq1Ngh+p2FYQe9XmIsRdQYn4m3MPv4aO4FZokaSHu/6CRJF8S65UuGJyCPOcwJZOrLuQsmdT6ZgBV6ky64My2324JMMY+X0vkzSZWsOhg1uoLqXwycAJ9jeYNrBG/muMWKmPq1fG77mGViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022404; c=relaxed/simple;
	bh=m3yB78Ujzsnz5zEaK38emrH4qTHPFHFuXvsrfxlo2GM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S+RFzikXRlalHxgE393LqOYwkukzW4TRlRrIXJLTETIDHJo0hOgJwV6XrXJg2EK7K4RFOy/9BQbXxah68Ier2/1hnRpsJHo+mOV2p4vfKM3PkA7wpftcxEixK0kEQmZ7NAQlrPjDPDqAQlXxTjLi9mJk+lrfdBp1xAkGvGDAViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1+ZKoNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1+ZKoNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9191F000E9;
	Fri, 29 May 2026 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780022402;
	bh=m3yB78Ujzsnz5zEaK38emrH4qTHPFHFuXvsrfxlo2GM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=D1+ZKoNsMQ7i/b4KzpnNS3vE5CJzcWzxm+PglxdiDWHXmrBHBsOngzCcckaa5ncJP
	 Zo8CAf2gduqkRsHNeYXBCkzkzwT+NEeFQ+NWijwW83ifPpzmEHSRuRkJVWg2EgpYfr
	 22gkeRQ5rbwx1EFK65LchJCFkBlhNEvtki6lDxcutJT+YJyjbt2gNQqIap3n2kQhlf
	 ZDvlWITlAZvx67ViaCXlDa3FYFNcqMFrnIKLoYqeRrwylB4yUGvjc440UfjXZ3dghL
	 5WfNUGJgG4+hzM4q4ZXSDL3OOVFFO126AQSE7YiMcczya7fhWIOrf28AVvozdpPw8y
	 EoL1r82oAxb4w==
Date: Thu, 28 May 2026 19:40:01 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v3 16/16] mptcp: pm: avoid confusing check_id
 in del_timer
In-Reply-To: <71cd48e3-2727-4dd8-8a2d-28617a03c851@kernel.org>
Message-ID: <c5737d3a-fcdb-5a7f-f975-8e355f0bd6e1@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org> <20260520-mptcp-add-addr6-port-ts-v3-16-bffa658a7678@kernel.org> <71cd48e3-2727-4dd8-8a2d-28617a03c851@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 May 2026, Matthieu Baerts wrote:

> Hello,
>
> On 20/05/2026 07:25, Matthieu Baerts (NGI0) wrote:
>> We an always check the ID in mptcp_pm_announced_del_timer: this check is
>> needed when an echo is received, but in other cases, the caller will use
>> an entry that was previously added in the list, so they have to match
>> too, otherwise that's not correct.
>>
>> After having removed this extra check, the variable is only used to know
>> what to do with the list and the timer. Use del_list instead of
>> check_id: clearer that the action will remove the entry from the list.
>
> I think it is probably better to drop this patch. Taking the opposite of
> a parameter can introduce issues during possible future backport, plus
> it is now a static function, so its use should be restricted.
>

Yeah, I agree: better to drop this one.

- Mat

