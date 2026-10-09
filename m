Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C0489FDB
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541883; cv=none; b=VJ8QqT6vgISJatWT98wxUehVrsKnOpUUfAEJ1VhAhpSSaMKCn4XVEX3M5tGdcHAlAIGYRfKaqjUYfs/KfJT2XD7dnnaE4g44j6dLB3/IFZOdwZRdX5LhcNWEA0osp9pmR9d1UeWvhcH00SPAsRbXTzXqeUye+63wwC7+Pv8f39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541883; c=relaxed/simple;
	bh=4kdVFUlJjxmdXUPXroyblEhfv+quBbk53lbIML8I/fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPBS5KuansjI87UqgFJlCuZ06ofA5KQDJHN5utqQnoaCr9NBwnjagXodQC/OX3lJ7vK4vYO11QwHMahCbdj7TgO5N5v8LSl4abRURwThu6UcpvU+L9QoygkIMdBNYpcDrXzBZeDGrzP2cUa9u78SPvaqtdZPmlA+7jfviJrASqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ8+Uvw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ8+Uvw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F341F000FF;
	Fri,  9 Oct 2026 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541881;
	bh=mwetpzuzSsvrQRbzijrBRvvXcANc4QJsCanRrIGiooA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZJ8+Uvw1x7cADQ7rGeLjh50Vs2WwWSm+62gBlyaaC8QlLtq2Nn57e1WUG2amFFnAN
	 f4lWqyj9SCQhCzn8LTzvr1DlFu6fj5tytnDOI4Z+vFpk98+xOJnDXOmxZ8UrINw9Tu
	 rhNvAMFjEPVSJk4WIVRQvQTMY6PY5vJdYnOq9vdKePZiOJngbQ1mwHS7emAnUMdJGJ
	 xbVzgbbi+yOegBrzx6QyCQMhbyAqiSnAOjP4zcF/jITrL0jZs/Jh9cc/ubEF+k6MBj
	 ZrWAGksy0JPn9Vq2gvJAGFD/HtnvOM5j8Sn/bl3c6pp6/aQlUi5EfHsmfYRL5iKCYI
	 /X+PHIheaw1WA==
Message-ID: <98ff7eb0-a0d2-46ff-b689-4708a0cd7fe8@kernel.org>
Date: Fri, 9 Oct 2026 12:31:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/2] mptcp: options: avoid printing uninit data
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
 <d4f8a020-8cce-d760-4625-adafb26d9ede@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d4f8a020-8cce-d760-4625-adafb26d9ede@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 09/09/2026 17:51, Mat Martineau wrote:
> On Tue, 8 Sep 2026, Matthieu Baerts (NGI0) wrote:
> 
>> When parsing the MPTCP suboptions, some pr_debug() might read and print
>> uninit values.
>>
>> That's mostly harmless, but that's also confusing. Fixing that also
>> avoids some tools to complain about accessing unint data.
>>
>> So read these fields only if they have been set.

(...)
> Thanks Matthieu, series LGTM:
Thank you for the review! I'm lagging so much I even slow at applying my
own patches :)

New patches for t/upstream-net and t/upstream:
- e83426516ebe: mptcp: options: mpc: avoid printing uninit data
- 55dcf92c5ff9: mptcp: options: dss: avoid printing uninit csum
- Results: 7e92f912c44e..77cb3db4e666 (export-net)
- Results: 45035345367c..fbeaa40c1480 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/984504faff7251d01755ff9d5077c95929788472/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/c320b1b2220752a879c853142d2ce128985a6012/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

